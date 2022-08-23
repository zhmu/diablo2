/*
 * Diablo2 Save Game Library 1.0 - stash.cc
 * (c) 2008 Rink Springer <mail@rink.nu>
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bitstreamer.h"
#include "item.h"
#include "stash.h"

void
Stash::load()
{
	uint32_t i;

	clear();
	bs->seek(0);

	// verify magic
	if (bs->read8() != 'D' ||
	    bs->read8() != '2' ||
	    bs->read8() != 'X')
		throw StashError(ST_ERR_NOSG);

	// number of items
	numitems = bs->readLE16();

	// check savegame version
	version = 0;
	switch (bs->readLE16()) {
		case 0x5c: version = 109; break;
		case 0x60: version = 111; break;
		  default: throw StashError(ST_ERR_VERSION);
	}

	// verify length of savegame and checksum
	if (bs->readLE32() != Savegame::getChecksum(bs, 7, 10))
		throw StashError(ST_ERR_CORRUPT);

	Item* previtem = NULL;
	for (i = 0; i < numitems; i++) {
		Item* it = new Item(bs, version);

		it->load();
		if (previtem == NULL)
			items = it;
		else
			previtem->setNext(it);
		previtem = it;
	}

	/* all done - or are we? */
	if (!bs->isEOS())
		throw StashError(ST_ERR_CORRUPT);
}

void
Stash::clear()
{
	Savegame::freeItemList(items); items = NULL;

	version = 0; numitems = 0;
}
