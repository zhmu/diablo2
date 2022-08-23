/*
 * Diablo 2 Save Game Reader 1.0 - savegame.cc (Savegame Reader Class)
 * (c) 2002 Rink Springer
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRENTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "savegame.h"

/*
 * SAVEGAME::SAVEGAME()
 *
 * This is the savegame class constructor. It will reset all values to their
 * defaults.
 *
 */
SAVEGAME::SAVEGAME() {
    // nothing loaded, no memory allocated yet
    savesize = 0; savebuf = NULL; items = NULL;
}

/*
 * SAVEGAME::~SAVEGAME()
 *
 * This is the savegame class destructor. It will nicely deallocate any memory
 * used.
 *
 */
SAVEGAME::~SAVEGAME() {
    SAVEGAME_ITEM* i;

    // got memory?
    if (savebuf)
	// yes. free it
	free (savebuf);

    // kill all the items, too
    while (items) {
	i = items->get_next();
	delete items;
	items = i;
    }
}

/*
 * SAVEGAME::load (char* fname)
 *
 * This will load a save game from [fname]. It will return SAVEGAME_OK on
 * success or SAVEGAME_ERROR_xxx on failure.
 *
 */
int
SAVEGAME::load (char* fname) {
    FILE* f;

    // open the file
    if ((f = fopen (fname, "rb")) == NULL)
	// this failed. complain
	return SAVEGAME_ERROR_CANTOPEN;

    // figure out the file size
    fseek (f, 0, SEEK_END); savesize = ftell (f); rewind (f);

    // allocate memory
    if ((savebuf = (char*)malloc (savesize)) == NULL) {
	// this failed. complain
	fclose (f);
	return SAVEGAME_ERROR_OUTOFMEMORY;
    }

    // read the data
    if (!fread (savebuf, savesize, 1, f)) {
	// this failed. complain
	free (savebuf); savebuf = NULL;
	fclose (f);
	return SAVEGAME_ERROR_READERR;
    }

    // all done
    return SAVEGAME_OK;
}

/*
 * SAVEGAME::save (char* fname)
 *
 * This will save a save game from [fname]. It will return SAVEGAME_OK on
 * success or SAVEGAME_ERROR_xxx on failure.
 *
 */
int
SAVEGAME::save (char* fname) {
    FILE* f;
    unsigned int i;

    // open the file
    if ((f = fopen (fname, "wb")) == NULL)
	// this failed. complain
	return SAVEGAME_ERROR_CANTOPEN;

    // update the length
    savebuf[11] = (savesize >> 24); savebuf[10] = (savesize >>  16);
    savebuf[ 9] = (savesize >>  8); savebuf[ 8] = (savesize & 0xff);

    // update the checksum
    i = calcChecksum();
    savebuf[15] = (i >> 24); savebuf[14] = (i >>  16);
    savebuf[13] = (i >>  8); savebuf[12] = (i & 0xff);

    // just kick it in data
    if (!fwrite (savebuf, savesize, 1, f))
	// this failed. complain
	return SAVEGAME_ERROR_WRITERR;

    // all set
    fclose (f);
    return SAVEGAME_OK;
}

/*
 * SAVEGAME::get[B|L][8|16|32] (int offs)
 *
 * This will get a Big or Little Endian, 8, 16 or 32 bit value from [offs]
 * and return it.
 *
 */
unsigned char  SAVEGAME::getBE8  (int offs) { return savebuf[offs]; }
unsigned char  SAVEGAME::getLE8  (int offs) { return savebuf[offs]; }
unsigned short SAVEGAME::getBE16 (int offs) { return getBE8 (offs) << 8 | getBE8 (offs + 1); }
unsigned short SAVEGAME::getLE16 (int offs) { return getBE8 (offs) | (getBE8 (offs + 1) << 8); }
unsigned long  SAVEGAME::getBE32 (int offs) { return getBE16 (offs) << 16 | (getBE16 (offs + 2)); }
unsigned long  SAVEGAME::getLE32 (int offs) { return getLE16 (offs) | (getLE16 (offs + 2) << 16); }

/*
 * SAVEGAME::analyze_items(unsigned int* start)
 *
 * This will analyze items and keep record of them. It will return SAVEGAME_OK
 * on success or SAVEGAME_ERROR_xxx on failure. [start] will be set to the
 * destination offset and used as the source offset. It will try to detect the
 * number of items to add.
 *
 */
int
SAVEGAME::analyze_items(unsigned int* start) {
    SAVEGAME_ITEM* item = items;
    SAVEGAME_ITEM* prev_item;
    struct SAVEGAME_ITEMDATA* idata;
    int offs = *start;

    // handle all items
    while (1) {
	// end of the file?
	if (getBE16 (offs) == ('k' << 8) + 'f')
	    // yes. bye!
	    break;

	// is this an item?
	if (getBE16 (offs) != ('J' << 8) + 'M')
	    // no. complain
	    return SAVEGAME_ERROR_CORRUPT;

	// null data after this item?
	if (!getBE16 (offs + 2))
	    // yes. do we have a new section after this?
	    if (((getBE16 (offs + 4) == ('j' << 8) + 'f')) ||
	        ((getBE16 (offs + 4) == ('k' << 8) + 'f')))
		// yes. bail out
		break;

	// do we have an item structure immediate after this?
	if (getBE16 (offs + 4) == ('J' << 8) + 'M') {
	    // yes. do we have a count of zero?
	    printf ("save game count of %u at offset %u\n", getLE16 (offs + 6), offs + 6);
	    if (!getLE16 (offs + 6))
	 	// yes. bail out
		break;

	    // no. skip this 'pseudo'-item
	    offs += 4;
	}

	// grab the item
	idata = (struct SAVEGAME_ITEMDATA*)(savebuf + offs);

	// make a new item
	prev_item = item;
	item = new SAVEGAME_ITEM();
	if (items == NULL)
	    items = item;
	else
	    prev_item->set_next (item);

	// add the item
	item->create (idata);

	// scan for the next 'JM' or 'kf' thingy
	offs++;
	while ((getBE16 (offs) != ('J' << 8) + 'M') &&
	       (getBE16 (offs) != ('k' << 8) + 'f'))
	    offs++;
    }

    // return the correct new offset, skipping the final terminator
    *start = offs + 4;

    // all done
    return SAVEGAME_OK;
}

/*
 * SAVEGAME::analyze()
 *
 * This will analyze a saved game previously loaded. It will return SAVEGAME_OK
 * on success or SAVEGAME_ERROR_xxx on failure.
 *
 */
int
SAVEGAME::analyze() {
    unsigned int   i;
    unsigned int   offs;

    // is this a Diablo 2 save game?
    if (getLE32 (0) != 0xAA55AA55)
	// nope. complain
	return SAVEGAME_ERROR_NOSAVEGAME;

    // get the save game version
    if (getLE32 (4) != 0x5C)
	// wrong version
	return SAVEGAME_ERROR_WRONGVER;

    #ifdef STRICT
    // check the file size
    printf ("[%u->%u]\n", getLE32 (8), savesize);
    if (getLE32 (8) != savesize)
	// wrong size
	return SAVEGAME_ERROR_WRONGSIZE;

    // verify the checksum
    if (getLE32 (12) != calcChecksum())
	// invalid checksum
	return SAVEGAME_ERROR_INVCHECKSUM;
    #endif

    // ensure the final NUL byte of the character name is there
    savebuf[35] = 0;

    // grab the presence field
    i = getLE16 (767);

    // reset all stats to zero
    strength = energy = dexterity = vitality = stat_rem = skill_rem = 0;
    life_cur = life_max = mana_cur = mana_max = stam_cur = stam_max = 0;

    // get all stats
    offs = 769;
    if (i & 0x0001) { strength   = getLE32 (offs); offs += 4; }
    if (i & 0x0002) { energy     = getLE32 (offs); offs += 4; }
    if (i & 0x0004) { dexterity  = getLE32 (offs); offs += 4; }
    if (i & 0x0008) { vitality   = getLE32 (offs); offs += 4; }
    if (i & 0x0010) { stat_rem   = getLE32 (offs); offs += 4; }
    if (i & 0x0020) { skill_rem  = getLE32 (offs); offs += 4; }
    if (i & 0x0040) { life_cur   = (getLE32 (offs) >> 8); offs += 4; };
    if (i & 0x0080) { life_max   = (getLE32 (offs) >> 8); offs += 4; }
    if (i & 0x0100) { mana_cur   = (getLE32 (offs) >> 8); offs += 4; }
    if (i & 0x0200) { mana_max   = (getLE32 (offs) >> 8); offs += 4; }
    if (i & 0x0400) { stam_cur   = (getLE32 (offs) >> 8); offs += 4; }
    if (i & 0x0800) { stam_max   = (getLE32 (offs) >> 8); offs += 4; }
    if (i & 0x1000) { level      = getLE32 (offs); offs += 4; }
    if (i & 0x2000) { exp        = getLE32 (offs); offs += 4; }
    if (i & 0x4000) { gold_inv   = getLE32 (offs); offs += 4; }
    if (i & 0x8000) { gold_stash = getLE32 (offs); offs += 4; }
	
    // correct level?
    if (level != getBE8 (43))
	// nope. complain
	return SAVEGAME_ERROR_CONTRA;

    // are we now at the character skills?
    if (getBE16 (offs) != ('i' << 8) + 'f')
	// no. complain
	return SAVEGAME_ERROR_CORRUPT;

    // skip over them for now
    offs += 32;

    // analyze the items
    i = analyze_items (&offs);
    if (i != SAVEGAME_OK)
	// this failed. complain
	return i;

    // are we hitting our mercenary data?
    if (getBE16 (offs) != (('j' << 8) + 'f'))
	// no. complain
	return SAVEGAME_ERROR_CORRUPT;

    // fetch the items for the mercenary (if any)
    offs += 2;
    i = analyze_items (&offs);
    if (i != SAVEGAME_OK)
	// this failed. complain
	return i;

    // all was ok
    return SAVEGAME_OK;
}

/*
 * SAVEGAME::calcChecksum()
 *
 * This will calculate the checksum of the save game and return it.
 *
 */
unsigned int
SAVEGAME::calcChecksum() {
    unsigned int i, c = 0;
    unsigned char v;

    // handle the entire file
    for (i = 0; i < savesize; i++) {
	if ((i != 12) && (i != 13) && (i != 14) && (i != 15))
	    v = savebuf[i];
	else
	    v = 0;
	c = (c << 1) + v + (c & 0x80000000 ? 1 : 0);
    }

    return c;
}

/*
 * SAVEGAME::get[X]()
 * SAVEGAME::is[X]()
 *
 * This will return the [X] field of the save game. Ensure the save game has
 * been successfully analyze()-ed before calling any of this!
 *
 */
char* SAVEGAME::getName() { return savebuf + 20; }
int   SAVEGAME::getClass() { return getBE8 (40); }
int   SAVEGAME::getLevel() { return level; }

unsigned int   SAVEGAME::getStrength() { return strength; }
unsigned int   SAVEGAME::getEnergy() { return energy; }
unsigned int   SAVEGAME::getDexterity() { return dexterity; }
unsigned int   SAVEGAME::getVitality() { return vitality; }
unsigned int   SAVEGAME::getStatRemaining() { return stat_rem; }
unsigned int   SAVEGAME::getSkillRemaining() { return skill_rem; }
unsigned int   SAVEGAME::getCurLife() { return life_cur; }
unsigned int   SAVEGAME::getMaxLife() { return life_max; }
unsigned int   SAVEGAME::getCurMana() { return mana_cur; }
unsigned int   SAVEGAME::getMaxMana() { return mana_max; }
unsigned int   SAVEGAME::getCurStamina() { return stam_cur; }
unsigned int   SAVEGAME::getMaxStamina() { return stam_max; }
unsigned int   SAVEGAME::getGoldInv() { return gold_inv; }
unsigned int   SAVEGAME::getGoldStash() { return gold_stash; }
unsigned int   SAVEGAME::getExperience() { return exp; }
SAVEGAME_ITEM* SAVEGAME::getItems() { return items; }

int   SAVEGAME::isHardcore() { return savebuf[36] & 4; }
int   SAVEGAME::isExpansion() { return savebuf[36] & 32; }
