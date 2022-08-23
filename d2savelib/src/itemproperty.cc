/*
 * Diablo2 Save Game Library 1.0 - itemproperty.cc
 * (c) 2008 Rink Springer <mail@rink.nu>
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bitstreamer.h"
#include "savegame.h"
#include "item.h"
#include "itemproperty.h"

void
ItemProperty::load()
{
	int bits;
	itemprop = findProperty(propid);
	if (itemprop == NULL)
		throw SavegameError(SG_ERR_UNSUPP);

	if (version == 109)
		bits = itemprop->bits109;
	else
		bits = itemprop->bits110;
	value = bs->read(bits);
}

void
ItemProperty::dump()
{
	printf("%u: %s = %u\n", propid, itemprop->descr, value);
}

struct ITEMPROPERTY*
ItemProperty::findProperty(uint16_t id)
{
	for (struct ITEMPROPERTY* ip = itemprops; ip->descr != NULL; ip++)
		if(ip->id == id)
			return ip;
	return NULL;
}
