/*
 * Diablo2 Save Game Library 1.0 - savegame.cc
 * (c) 2008 Rink Springer <mail@rink.nu>
 *
 * File format described at
 * - http://www.ladderhall.com/ericjwin/html/udietooinfo/udietood2s.html
 * -  http://home.stx.rr.com/svr/formats/d2s.htm
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bitstreamer.h"
#include "item.h"
#include "savegame.h"

void
Savegame::load()
{
	uint32_t i, j, n;

	clear();
	bs->seek(0);

	// verify magic
	if (bs->readLE32() != 0xaa55aa55)
		throw SavegameError(SG_ERR_NOSG);

	// check savegame version
	version = 0;
	switch (bs->readLE32()) {
		case 0x5c: version = 109; break;
		case 0x60: version = 111; break;
		  default: throw SavegameError(SG_ERR_VERSION);
	}

	// verify length of savegame and checksum
	if (bs->readLE32() != bs->getDataLength())
		throw SavegameError(SG_ERR_CORRUPT);
	if (bs->readLE32() != getChecksum(bs))
		throw SavegameError(SG_ERR_CORRUPT);

	bs->skip(32);	// XXX: weapon set
	for (i = 0; i < 16; i++) {
		name[i] = bs->read8();
	}
	setCharachterType(bs->read8());
	setCharachterTitle(bs->read8());
	bs->skip(16);		// unknown (00 00)
	setCharachterClass(bs->read8());
	bs->skip(16);		// unknown (10 1e)
	level = bs->read8();
	bs->skip(32);		// unknown
	bs->skip(32);		// XXX: timestamp
	bs->skip(32);		// unknown (ff ff ff ff)
	bs->skip(32*16);	// XXX: skill keys
	bs->skip(32);		// XXX: left skill weapon set 1
	bs->skip(32);		// XXX: right skill weapon set 1
	bs->skip(32);		// XXX: left skill weapon set 2
	bs->skip(32);		// XXX: right skill weapon set 2
	bs->skip(8*16);		// XXX: charachter load graphics
	bs->skip(8*16);		// XXX: charachter load colors
	bs->skip(8);		// XXX: normal town
	bs->skip(8);		// XXX: nightmare town
	bs->skip(8);		// XXX: hell town
	bs->skip(32);		// XXX: map random seed
	bs->skip(16);		// unknown (00 00)
	setMercenaryDead(bs->read8());
	bs->skip(8);		// unknow
	setMercenary(bs->readLE32() != 0);	// control seed: non-zero => mercenary present
	setMercenaryName(bs->readLE16());
	setMercenaryType(bs->readLE16());
	setMercenaryExperience(bs->readLE32());
	bs->skip(8*0x90);	// unknown

	/* quest info must be here */
	if (bs->readLE32() != 0x216f6f57 /* Woo! */)
		throw SavegameError(SG_ERR_CORRUPT);
	n = bs->readLE32();	// number of acts
	bs->skip(16);		// XXX: size in bytes
	for (i = 0; i < n; i++) {
		/* 3 times: normal, nightmare, hell */
		for (j = 0; j < 3; j++) {
			bs->skip(16);	// XXX: act start info
			bs->skip(16*6);	// XXX: quest status
			bs->skip(16);	// XXX: act end flags
		}
	}

	if (bs->readLE16() != 0x5357 /* WS */)
		throw SavegameError(SG_ERR_CORRUPT);
	bs->skip(8*6);		// unknown
	bs->skip(32*3*6);	// XXX: waypoints

	/* npc state control */
	if (bs->readLE16() != 0x7701)
		throw SavegameError(SG_ERR_CORRUPT);
	bs->skip(16);		// XXX: size of struct
	bs->skip(32*2);		// XXX: normal
	bs->skip(32*2);		// XXX: nightmare
	bs->skip(32*2);		// XXX: hell
	bs->skip(32*2);		// XXX: normal1
	bs->skip(32*2);		// XXX: nightmare1
	bs->skip(32*2);		// XXX: hell1

	// charachter stats should be here
	if (bs->readLE16() != 0x6667 /* wf */)
		throw SavegameError(SG_ERR_CORRUPT);

	if (version >= 110) {
		/*
		 * 1.10+ stores charachter stats as a list of properties.
		 */
		while (1) {
			i = bs->read(9);
			if (i == SAVEGAME_STAT_END)
				break;
			switch(i) {
				case SAVEGAME_STAT_STRENGTH:
				     setStrength(bs->read(10));
				     break;
				case SAVEGAME_STAT_ENERGY:
				     setEnergy(bs->read(10));
				     break;
				case SAVEGAME_STAT_DEXTERITY:
				     setDexterity(bs->read(10));
				     break;
				case SAVEGAME_STAT_VITALITY:
				     setVitality(bs->read(10));
				     break;
				case SAVEGAME_STAT_STATPTS:
				     setStatpointsRemaining(bs->read(10));
				     break;
				case SAVEGAME_STAT_NEWSKILLS:
				     setSkillpointsRemaining(bs->read(8));
				     break;
				case SAVEGAME_STAT_HP:
				     setCurrentLife(bs->read(21));
				     break;
				case SAVEGAME_STAT_MAXHP:
				     setMaxLife(bs->read(21));
				     break;
				case SAVEGAME_STAT_MANA:
				     setCurrentMana(bs->read(21));
				     break;
				case SAVEGAME_STAT_MAXMANA:
				     setMaxMana(bs->read(21));
				     break;
				case SAVEGAME_STAT_STAMINA:
				     setCurrentStamina(bs->read(21));
				     break;
				case SAVEGAME_STAT_MAXSTAMINA:
				     setMaxStamina(bs->read(21));
				     break;
				case SAVEGAME_STAT_LEVEL:
				     /*
				      * We already know the level. So, if this does not match
				      * throw an error.
				      */
				     if (bs->read(7) != level)
				     	throw SavegameError(SG_ERR_CORRUPT);
				     break;
				case SAVEGAME_STAT_EXPERIENCE:
				     setExperience(bs->readLE32());
				     break;
				case SAVEGAME_STAT_GOLD:
				     setInventoryGold(bs->read(25));
				     break;
				case SAVEGAME_STAT_GOLDSTASH:
				     setStashGold(bs->read(25));
				     break;
				default:
				     throw SavegameError(SG_ERR_CORRUPT);
			}
		}
		bs->seekNextByte();
	} else {
		/* 1.09 */
		i = bs->readLE16();
		if (i & 0x0001) setStrength(bs->readLE32());
		if (i & 0x0002) setEnergy(bs->readLE32());
		if (i & 0x0004) setDexterity(bs->readLE32());
		if (i & 0x0008) setVitality(bs->readLE32());
		if (i & 0x0010) setStatpointsRemaining(bs->readLE32());
		if (i & 0x0020) setSkillpointsRemaining(bs->readLE32());
		if (i & 0x0040) setCurrentLife(bs->readLE32());
		if (i & 0x0080) setMaxLife(bs->readLE32());
		if (i & 0x0100) setCurrentMana(bs->readLE32());
		if (i & 0x0200) setMaxMana(bs->readLE32());
		if (i & 0x0400) setCurrentStamina(bs->readLE32());
		if (i & 0x0800) setMaxStamina(bs->readLE32());
		if (i & 0x1000)
			/* we already know the level - but we can check for contradictions */
			if (bs->readLE32() != level)
				throw SavegameError(SG_ERR_CORRUPT);
		if (i & 0x2000) setExperience(bs->readLE32());
		if (i & 0x4000) setInventoryGold(bs->readLE32());
		if (i & 0x8000) setStashGold(bs->readLE32());
	}

	// charachter skills should be here
	if (bs->readLE16() != 0x6669 /* if */)
		throw SavegameError(SG_ERR_CORRUPT);

	/* XXX: handle charachter skills */
	bs->skip(8*30);

	/* item data is here */
	if (bs->readLE16() != 0x4d4a /* JM */)
		throw SavegameError(SG_ERR_CORRUPT);
	n = bs->readLE16();	// number of items
	Item* previtem = NULL;
	for (i = 0; i < n; i++) {
		Item* it = new Item(bs, version);

		it->load();
		if (previtem == NULL)
			playeritems = it;
		else
			previtem->setNext(it);
		previtem = it;
	}

	/* corpse items are stored next */
	if (bs->readLE16() != 0x4d4a /* JM */)
		throw SavegameError(SG_ERR_CORRUPT);
	n = bs->readLE16();	// number of items
	previtem = NULL;
	for (i = 0; i < n; i++) {
		Item* it = new Item(bs, version);

		it->load();
		if (previtem == NULL)
			corpseitems = it;
		else
			previtem->setNext(it);
		previtem = it;
	}

	if (bs->readLE16() != 0x666a /* jf */)
		throw SavegameError(SG_ERR_CORRUPT);

	/* if we have a mercenary, item list will be here */
	if (havemerc) {
		if (bs->readLE16() != 0x4d4a /* JM */)
			throw SavegameError(SG_ERR_CORRUPT);

		n = bs->readLE16();	// number of items
		previtem = NULL;
		for (i = 0; i < n; i++) {
			Item* it = new Item(bs, version);

			it->load();
			if (previtem == NULL)
				mercitems = it;
			else
				previtem->setNext(it);
			previtem = it;
		}
	}

	if (bs->readLE16() != 0x666b /* kf */)
		throw SavegameError(SG_ERR_CORRUPT);
	if (bs->read8() != 0)
		throw SavegameError(SG_ERR_CORRUPT);

	/* all done - or are we? */
	if (!bs->isEOS())
		throw SavegameError(SG_ERR_CORRUPT);
}

uint32_t
Savegame::getChecksum(BitStreamer* bs, off_t start, off_t end)
{
	off_t oldpos = bs->tell();
	uint32_t c;
	uint8_t v;
	size_t s;

	c = 0;
	bs->seek(0);
	for (s = 0; s < bs->getDataLength(); s++) {
		v = bs->read8();
		if (s >= start && s <= end)
			// Nullify anything at the checksum position
			v = 0;
		c = (c << 1) + v + (c & 0x80000000 ? 1 : 0);
	}
	bs->seek(oldpos);

	return c;
}

void
Savegame::clear()
{
	freeItemList(playeritems); playeritems = NULL;
	freeItemList(corpseitems); corpseitems = NULL;
	freeItemList(mercitems); mercitems = NULL;

	version = havemerc = 0;

	strength = energy = dexterity = vitality = stat_rem = skill_rem = 0;
	life_cur = life_max = mana_cur = mana_max = stamina_cur = stamina_max = 0;
	level = exp = gold_inv = gold_stash = 0;
	chartype = chartitle = charclass = mercdead = 0;
	mercname = merctype = 0;
	mercexp = 0;

	memset(name, 0, sizeof(name));
}

void
Savegame::freeItemList(Item* list)
{
	Item* it = list;
	while (it != NULL) {
		Item* next = it->getNext();
		delete it;
		it = next;
	}
}
