/*
 * Diablo 2 Save Game Reader 1.0 - main.cc ("The Glue that Binds")
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
#include <stdio.h>
#include <stdlib.h>
#include "savegame.h"

SAVEGAME* sg;

/*
 * resolve_class (int i)
 *
 * This will resolve character class [i] into a text string.
 *
 */
char*
resolve_class (int i) {
    // figure out the class
    switch (i) {
	case SAVEGAME_CLASS_AMAZON: return "Amazon";
     case SAVEGAME_CLASS_SORCERESS: return "Sorceress";
   case SAVEGAME_CLASS_NECROMANCER: return "Necromancer";
       case SAVEGAME_CLASS_PALADIN: return "Paladin";
     case SAVEGAME_CLASS_BARBARIAN: return "Barbarian";
	 case SAVEGAME_CLASS_DRUID: return "Druid";
      case SAVEGAME_CLASS_ASSASSIN: return "Assassin";
    }

    // ?
    return "?";
}

/*
 * main(int argc, char** argv)
 *
 * This is the main procedure.
 *
 */
int
main(int argc, char** argv) {
    int i;
    SAVEGAME_ITEM* item;

    // got exactly one argument?
    if (argc != 2) {
	// no. complain
	printf ("usuage: d2read [file.d2s]\n");
	return EXIT_FAILURE;
    }

    // initialize a save game
    sg = new SAVEGAME();
    if ((i = sg->load (argv[1])) != SAVEGAME_OK) {
	// this failed. complain
	delete sg;
	printf ("unable to load '%s': %i\n", argv[1], i);
	return i;
    }

    // analyze the save game
    if ((i = sg->analyze ()) != SAVEGAME_OK) {
	// this failed. complain
	delete sg;
	printf ("unable to analyze savegame '%s': %i\n", argv[1], i);
	return i;
    }

    // dump the info
    printf ("Character name  : %s\n", sg->getName());
    printf ("Character type  : %s%s\n", (sg->isHardcore() ? "Hardcore " : ""), resolve_class (sg->getClass()));
    printf ("Character level : %u\n", sg->getLevel());
    printf ("Character exp   : %u\n", sg->getExperience());
    printf ("\n");
    printf ("Strength        : %u\n", sg->getStrength());
    printf ("Energy          : %u\n", sg->getEnergy());
    printf ("Dexterity       : %u\n", sg->getDexterity());
    printf ("Vitality        : %u\n", sg->getVitality());
    printf ("Stat Points Rem : %u\n", sg->getStatRemaining());
    printf ("Skill Points Rem: %u\n", sg->getSkillRemaining());
    printf ("\n");
    printf ("Life            : %u / %u\n", sg->getCurLife(), sg->getMaxLife());
    printf ("Mana            : %u / %u\n", sg->getCurMana(), sg->getMaxMana());
    printf ("Stamina         : %u / %u\n", sg->getCurStamina(), sg->getMaxStamina());
    printf ("\n");
    printf ("Gold (Inventory): %u\n", sg->getGoldInv());
    printf ("Gold (Stash)    : %u\n", sg->getGoldStash());
    printf ("\n");

    // list the items
    item = sg->getItems();
    while (item) {
	// print it
	printf ("- %s\n", item->get_name());

	// do we have more?
	if (item->get_info()) {
	    printf ("%s", item->get_info());
	}

	// next
	item = item->get_next();
    }

    // all done
    delete sg;
    return EXIT_SUCCESS;
}
