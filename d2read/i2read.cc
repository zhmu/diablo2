/*
 * Diablo 2 Save Game Reader 1.0 - i2read.cc (Item Reader)
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

SAVEGAME_ITEM* item;

/*
 * main(int argc, char** argv)
 *
 * This is the main procedure.
 *
 */
int
main(int argc, char** argv) {
    int len;
    char* tmp;
    FILE* f;
    struct SAVEGAME_ITEMDATA* idata;

    // got exactly one argument?
    if (argc != 2) {
	// no. complain
	printf ("usuage: i2read [file.itm]\n");
	return EXIT_FAILURE;
    }

    // load the item
    if ((f = fopen (argv[1], "rb")) == NULL) {
	// this failed. complain
	printf ("error: cannot open '%s'\n", argv[1]);
	return EXIT_FAILURE;
    }

    // figure out the length
    fseek (f, 0, SEEK_END); len = ftell (f); rewind (f);

    // get memory
    if ((tmp = (char*)malloc (len + 2)) == NULL) {
	// this failed. complain
	printf ("error: out of memory\n");
	return EXIT_FAILURE;
    }

    // load the data
    if (!fread (tmp, len, 1, f)) {
	// this failed. complain
	printf ("error: cannot read '%s'\n", argv[1]);
	return EXIT_FAILURE;
    }

    // use magic
    tmp[len] = 'J'; tmp[len + 1] = 'M';

    // close the file
    fclose (f);

    // initialize a save game
    item = new SAVEGAME_ITEM();
    idata = (struct SAVEGAME_ITEMDATA*)tmp;
    item->create (idata);

    // dump the item info
    printf ("- %s\n", item->get_name());

    // do we have more?
    if (item->get_info()) {
	printf ("%s", item->get_info());
    }

    // all done
    delete item;
    return EXIT_SUCCESS;
}
