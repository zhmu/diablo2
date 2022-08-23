/*
 * Diablo2 Save Game Library 1.0 - savegame.cc
 * (c) 2008 Rink Springer <mail@rink.nu>
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "bitstreamer.h"
#include "savegame.h"
#include "item.h"

void
Item::load()
{
	uint32_t i, a, b;

	clear();
	if (bs->readLE16() != 0x4d4a /* JM */)
		throw SavegameError(SG_ERR_CORRUPT);

	bs->skip(1);		/* XXX: quest item */
	bs->skip(3);		/* unknown */
	setIdentified(bs->read(1));
	bs->skip(3);		/* unknown */
	setDisabled(bs->read(1));	
	bs->skip(1);		/* unknown */
	bs->skip(1);		/* XXX: duplicate item */
	setSocketed(bs->read(1));
	bs->skip(1);		/* unknown */
	bs->skip(1);		/* new item */
	setIllegalEquipped(bs->read(1));
	bs->skip(1);		/* unknown */
	setEar(bs->read(1));
	setNewbie(bs->read(1));
	bs->skip(3);		/* unknown */
	setSimple(bs->read(1));
	setEthereal(bs->read(1));
	bs->skip(1);		/* unknown (always 1?) */
	setPersonalized(bs->read(1));
	bs->skip(1);		/* unknown */
	setHasRuneword(bs->read(1));
	bs->skip(5);		/* unknown */
	iversion = bs->read(8);	/* version */
	/*
	 * For some reason, items with item version legacy still seem to spawn
	 * in 1.09+, even with expansion-only charachters.
	 */
	if (iversion != ITEM_VERSION_LEGACY && iversion != ITEM_VERSION_CLASSIC && iversion != ITEM_VERSION_109 & iversion != ITEM_VERSION_110)
		throw SavegameError(SG_ERR_CORRUPT);

	bs->skip(2);		/* unknown */
	setLocation(bs->read(3));
	setBodyPosition(bs->read(4));
	setGridColumn(bs->read(4));
	setGridRow(bs->read(4));
	setStorageLocation(bs->read(3));

	if (ear) {
		bs->skip(3);	/* XXX: ear class */
		bs->skip(7);	/* XXX: ear level */
		bs->skip(18*7);	/* XXX: ear name */
	}
	for (i = 0; i < ITEM_TYPE_LEN; i++)
		type[i] = bs->read8();

	/* look up the item type */
	itemtype = findType((const char*)type);
	if (itemtype == NULL)
		throw SavegameError(SG_ERR_UNSUPP);

	if (!simple) {
		/* extended item data */
		setNumItemSockets(bs->read(3));
		setID(bs->read(32));
		setItemLevel(bs->read(7));
		setItemQuality(bs->read(4));

		/* ring/charm/amulet/jewel image */
		if (bs->read(1)) {
			setImage(bs->read(3));
		}
		if (bs->read(1)) {
			/* XXX: class info properties */
			bs->skip(11);
		}
		switch (itemquality) {
			  case ITEM_QUALITY_LOW: setLowQuality(bs->read(3));
						 break;
		       case ITEM_QUALITY_NORMAL: // tomes have 5 bits here which we can skip
						 if (itemtype->itype & ITEMTYPE_TOME) {
						 	bs->skip(5);	// unknown
						 }
						 break;
			 case ITEM_QUALITY_HIGH: bs->skip(3);	// unknown
						 break;
			case ITEM_QUALITY_MAGIC: setMagicPrefix(0, bs->read(11));
						 setMagicSuffix(0, bs->read(11));
						 setNumPrefixes(1);
						 setNumSuffixes(1);
						 break;
			  case ITEM_QUALITY_SET: setSetID(bs->read(12));
						 break;
			 case ITEM_QUALITY_RARE:
		      case ITEM_QUALITY_CRAFTED: setName(0, bs->read(8));
						 setName(1, bs->read(8));
						 a = b = 0;
						 for(i = 0; i < 3; i++) {
							if (bs->read(1))
								setMagicPrefix(a++, bs->read(11));
							if (bs->read(1))
								setMagicSuffix(b++, bs->read(11));
						 }
						 setNumPrefixes(a); setNumSuffixes(b);
						 break;
		       case ITEM_QUALITY_UNIQUE: setUniqueID(bs->read(12));
						 break;
					default: throw SavegameError(SG_ERR_CORRUPT);
		}

		if (hasruneword) {
			setRunewordID(bs->read(12));
			bs->skip(4);	// unknown (5?)
		}
		if (personalized) {
			i = 0;
			while (1) {
				pname[i] = bs->read(7);
				if (pname[i] == '\0')
					break;
				i++;
				if (i >= ITEM_MAX_PERSONALIZED_NAME)
					throw SavegameError(SG_ERR_CORRUPT);
			}
		}
	}
	/* XXX: gold? */
	if (bs->read(1)) {
		/* XXX: GUID */
		if (itemtype->itype & ITEMTYPE_MISC)
			bs->skip(3);
		else
			bs->skip(32*3);
	}
	if (simple) {
		// all done!
		bs->seekNextByte();
		return;
	}

	if (itemtype->itype & ITEMTYPE_ARMOR) {
		if (version >= 110) {
			setDefense(bs->read(11));
			setDurability(bs->read(8));
			if (durability)
				setCurrentDurability(bs->read(9));
		} else {
			setDefense(bs->read(10));
			setDurability(bs->read(8));
			if (durability)
				setCurrentDurability(bs->read(8));
		}
	} else if (itemtype->itype & ITEMTYPE_WEAPON) {
		setDurability(bs->read(8));
		if (durability)
			setCurrentDurability(bs->read((version >= 110) ? 9 : 8));
	}

	if (itemtype->itype & ITEMTYPE_STACKABLE || itemtype->itype & ITEMTYPE_TOME)
		setQuantity(bs->read(9));
	if (socketed)
		setNumSockets(bs->read(4));

	/*
	 * Sets have 5 bits here, each bit contains whether we have an extra property list.
	 */
	if (itemquality == ITEM_QUALITY_SET)
		a = bs->read(5);

	itemprops = handlePropertyList();

	if (itemquality == ITEM_QUALITY_SET) {
		for (i = 0; i < ITEM_MAX_SET_PROPS; i++) {
			if (a & (1 << i)) {
				setprops[i] = handlePropertyList();
			}
		}
	}

	// runeword data is here
	if (hasruneword)
		runewordprops = handlePropertyList();

	// items in the sockets appear immediately at the end of this item
	if (socketed && numitemsockets > 0) {
		Item* previtem = NULL;
		for (i = 0; i < numitemsockets; i++) {
			bs->seekNextByte();
			Item* si = new Item(bs, version);
			si->load();
			if (previtem == NULL)
				socketitems = si;
			else
				previtem->setNext(si);
			previtem = si;
		}
	}

	bs->seekNextByte();
}

void
Item::clear()
{
	int i;

	Savegame::freeItemList(socketitems); socketitems = NULL;
	freeItemPropertyList(itemprops); itemprops = NULL;
	freeItemPropertyList(runewordprops); runewordprops = NULL;

	identified = disabled = socketed = badequip = ear = simple = ethereal = personalized = 0;
	hasruneword = iversion = location = bodypos = gridcol = gridrow = storedloc = newbie = 0;
	numsockets = itemlevel = itemquality = image = lowquality = 0;
	numitemsockets = durability = curdurability = quantity = 0;
	for (i = 0; i < ITEM_MAX_PREFIX; i++) magic_prefix[i] = 0;
	for (i = 0; i < ITEM_MAX_SUFFIX; i++) magic_suffix[i] = 0;
	setid = uniqueid = runewordid = defense = 0;
	memset(name, 0, sizeof(name));
	id = 0;
	memset(type, 0, sizeof(type));
	numprefixes = numsuffixes = 0;
	memset(pname, 0, sizeof(pname));
	itemtype = NULL;
	for (i = 0; i < ITEM_MAX_SET_PROPS; i++) {
		freeItemPropertyList(setprops[i]);
		setprops[i] = NULL;
	}
}

void
Item::dump()
{
	printf("type             : %s", getType());
	if (itemtype != NULL) 
		printf(" (%s)\n", itemtype->name);
	else
		printf(" (?)\n");
	printf("identified       : %u\n", getIdentified());
	printf("disabled         : %u\n", getDisabled());
	printf("socketed         : %u\n", getSocketed());
	printf("badly equipped   : %u\n", getIllegalEquipped());
	printf("ear              : %u\n", getEar());
	printf("newbie item      : %u\n", getNewbie());
	printf("simple           : %u\n", getSimple());
	printf("ethereal         : %u\n", getEthereal());
	printf("personalized     : %u\n", getPersonalized());
	printf("runeword         : %u\n", getHasRuneword());
	printf("item version     : %u\n", getItemVersion());
	printf("location         : %u\n", getLocation());
	printf("body position    : %u\n", getBodyPosition());
	printf("grid column      : %u\n", getGridColumn());
	printf("grid row         : %u\n", getGridRow());
	printf("storage location : %u\n", getStorageLocation());
	printf("number of sockets: %u\n", getNumSockets());
	printf("items in sockets : %u\n", getNumItemSockets());
	Item *it = getItemsInSockets();
	while (it != NULL) {
		printf("item in socket\n");
		it->dump();
		it = it->getNext();
	}
	if (simple)
		return;

	printf("item id          : 0x%x\n", getID());
	printf("item level       : %u\n", getItemLevel());
	printf("item quality     : %u\n", getItemQuality());
	switch (getItemQuality()) {
		  case ITEM_QUALITY_LOW:
			printf("item low quality : %u\n", getLowQuality());
			break;
		  case ITEM_QUALITY_SET:
			printf("item set id      : %u\n", getSetID());
			break;
		  case ITEM_QUALITY_UNIQUE:
			printf("unique item id   : %u\n", getUniqueID());
			break;
	}
	printf("durability       : %u/%u\n", getCurrentDurability(), getDurability());
	if (itemtype != NULL && itemtype->itype & ITEMTYPE_STACKABLE)
		printf("quantity         : %u\n", getQuantity());
	if (getHasRuneword())
		printf("runeword id      : %u\n", getRunewordID());
	ItemProperty* ip = itemprops;
	while (ip != NULL) {
		ip->dump();
		ip = ip->getNext();
	}
}

struct ITEMTYPE*
Item::findType(const char* type)
{
	if (strlen(type) != 4)
		throw SavegameError(SG_ERR_ARG);
	for (struct ITEMTYPE* it = itemtypes; it->typecode != NULL; it++)
		if (!strncmp(it->typecode, type, 3))
			return it;
	return NULL;
}

ItemProperty*
Item::handlePropertyList()
{
	uint32_t propid;
	ItemProperty* firstitem = NULL;
	ItemProperty* previtem = NULL;

	while (1) {
		propid = bs->read(9);
		if (propid == ITEMPROP_TYPE_END)
			break;

		ItemProperty* prop = new ItemProperty(bs, version, propid);
		if (firstitem == NULL)
			firstitem = prop;
		else
			previtem->setNext(prop);
		prop->load();
		previtem = prop;

		/*
		 * Some items have follow up properties: this means that one property is followed
		 * by one or two implicit properties that do not have a property id.
		 */
		struct ITEMPROPERTY* ip = prop->getItemProperty();
		if (ip->follow1 != FOLLOW_NONE) {
			prop = new ItemProperty(bs, version, ip->follow1);
			previtem->setNext(prop);
			prop->load();
			previtem = prop;
		}
		if (ip->follow2 != FOLLOW_NONE) {
			prop = new ItemProperty(bs, version, ip->follow2);
			previtem->setNext(prop);
			prop->load();
			previtem = prop;
		}
	}
	return firstitem;
}

void
Item::freeItemPropertyList(ItemProperty* list)
{
	ItemProperty* ip = list;
	while (ip != NULL) {
		ItemProperty* next = ip->getNext();
		delete ip;
		ip = next;
	}
}
