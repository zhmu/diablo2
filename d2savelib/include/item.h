/*
 * Diablo2 Save Game Library - (c) 2008, 2009 Rink Springer
 */
#include <stdint.h>
#include "bitstreamer.h"
#include "itemproperty.h"
#include "savegame.h"

#ifndef __ITEM_H__
#define __ITEM_H__

#define ITEM_TYPE_LEN		4
#define ITEM_MAX_PREFIX		3
#define ITEM_MAX_SUFFIX		3
#define ITEM_MAX_NAME		2
#define ITEM_MAX_PERSONALIZED_NAME	18
#define ITEM_MAX_SET_PROPS	5

#define ITEM_QUALITY_LOW	1
#define ITEM_QUALITY_NORMAL	2
#define ITEM_QUALITY_HIGH	3
#define ITEM_QUALITY_MAGIC	4
#define ITEM_QUALITY_SET	5
#define ITEM_QUALITY_RARE	6
#define ITEM_QUALITY_UNIQUE	7
#define ITEM_QUALITY_CRAFTED	8

#define ITEM_LQUALITY_CRUDE	0
#define ITEM_LQUALITY_CRACKED	1
#define ITEM_LQUALITY_DAMAGED	2
#define ITEM_LQUALITY_LOW	3

#define ITEMTYPE_ARMOR		0x01
#define ITEMTYPE_WEAPON		0x02
#define ITEMTYPE_TOME		0x04
#define ITEMTYPE_MISC		0x08
#define ITEMTYPE_STACKABLE	0x10

#define ITEMVAL_STD		0
#define FOLLOW_NONE		0x1ff

#define ITEM_VERSION_LEGACY	0
#define ITEM_VERSION_CLASSIC	1
#define ITEM_VERSION_109	100
#define ITEM_VERSION_110	101

struct ITEMTYPE {
	const char* name;
	const char* typecode;
	int   itype;
};

struct ITEMPROPERTY {
	uint16_t	id;
	const char*	descr;
	int		valtype;
	int		bits109;
	int		add109;
	int		bits110;
	int		add110;
	uint16_t	follow1;
	uint16_t	follow2;
};

// from itemtypes.cc
extern struct ITEMTYPE itemtypes[];

// from itemprop.cc
extern struct ITEMPROPERTY itemprops[];

//! \brief Interfaces Diablo2 items
class Item {
public:
	inline Item(BitStreamer* bs, int version) {
		int i;
		this->bs = bs; this->version = version;
		socketitems = NULL; itemprops = NULL; runewordprops = NULL; next = NULL;
		for (i = 0; i < ITEM_MAX_SET_PROPS; i++)
			setprops[i] = NULL;
		clear();
	}
	inline ~Item() {
		clear();
	}

	/*! \brief Loads item data from the bitstreamer
	 *  \throws SavegameError on errors
	 */
	void load();

	//! \brief Clears all item data
	void clear();

	inline Item*   getNext() { return next; }
	inline uint8_t getIdentified() { return identified; }
	inline uint8_t getDisabled() { return disabled; }
	inline uint8_t getSocketed() { return socketed; }
	inline uint8_t getIllegalEquipped() { return badequip; }
	inline uint8_t getEar() { return ear; }
	inline uint8_t getSimple() { return simple; }
	inline uint8_t getEthereal() { return ethereal; }
	inline uint8_t getPersonalized() { return personalized; }
	inline uint8_t getHasRuneword() { return hasruneword; }
	inline uint8_t getItemVersion() { return iversion; }
	inline uint8_t getLocation() { return location; }
	inline uint8_t getBodyPosition() { return bodypos; }
	inline uint8_t getGridColumn() { return gridcol; }
	inline uint8_t getGridRow() { return gridrow; }
	inline uint8_t getStorageLocation() { return storedloc; }
	inline uint8_t getNewbie() { return newbie; }
	inline uint8_t getNumSockets() { return numsockets; }
	inline uint8_t getNumItemSockets() { return numitemsockets; }
	inline uint8_t getItemLevel() { return itemlevel; }
	inline uint8_t getItemQuality() { return itemquality; }
	inline uint8_t getImage() { return image; }
	inline uint8_t getLowQuality() { return lowquality; }
	inline uint8_t getDurability() { return durability; }
	inline uint8_t getCurrentDurability() { return curdurability; }
	inline uint8_t getQuantity() { return quantity; }

	inline uint16_t getMagicPrefix(int i) {
		if (i < 0 || i >= ITEM_MAX_PREFIX)
			throw SavegameError(SG_ERR_ARG);
		return magic_prefix[i];
	}
	inline uint16_t getMagicSuffix(int i) {
		if (i < 0 || i >= ITEM_MAX_SUFFIX)
			throw SavegameError(SG_ERR_ARG);
		return magic_suffix[i];
	}
	inline uint16_t getName(int i) {
		if (i < 0 || i >= ITEM_MAX_NAME)
			throw SavegameError(SG_ERR_ARG);
		return name[i];
	}

	inline uint16_t getSetID() { return setid; }
	inline uint16_t getUniqueID() { return uniqueid; }
	inline uint16_t getRunewordID() { return runewordid; }
	inline uint16_t getDefense() { return defense; }

	inline uint32_t getID() { return id; }
	inline int getNumPrefixes() { return numprefixes; }
	inline int getNumSuffixes() { return numsuffixes; }

	inline uint8_t* getType() { return type; }
	inline uint8_t* getPersonalizedName() { return pname; }

	inline struct ITEMTYPE* getItemType() { return itemtype; }
	inline Item* getItemsInSockets() { return socketitems; }
	inline ItemProperty* getPropertyList() { return itemprops; }
	inline ItemProperty* getRunewordPropertyList() { return runewordprops; }
	inline ItemProperty* getSetitemPropertyList(int i) {
		if (i < 0 || i >= ITEM_MAX_SET_PROPS)
			throw SavegameError(SG_ERR_ARG);
		return setprops[i];
	}

	inline void setNext(Item* i) { next = i; }
	inline void setIdentified(uint8_t v) { identified = v; }
	inline void setDisabled(uint8_t v) { disabled = v; }
	inline void setSocketed(uint8_t v) { socketed = v; }
	inline void setIllegalEquipped(uint8_t v) { badequip = v; }
	inline void setEar(uint8_t v) { ear = v; }
	inline void setSimple(uint8_t v) { simple = v; }
	inline void setEthereal(uint8_t v) { ethereal = v; }
	inline void setPersonalized(uint8_t v) { personalized = v; }
	inline void setHasRuneword(uint8_t v) { hasruneword = v; }
	inline void setItemVersion(uint8_t v) { iversion = v; }
	inline void setLocation(uint8_t v) { location = v; }
	inline void setBodyPosition(uint8_t v) { bodypos = v; }
	inline void setGridColumn(uint8_t v) { gridcol = v; }
	inline void setGridRow(uint8_t v) { gridrow = v; }
	inline void setStorageLocation(uint8_t v) { storedloc = v; }
	inline void setNewbie(uint8_t v) { newbie = v; }
	inline void setNumSockets(uint8_t v) { numsockets = v; }
	inline void setNumItemSockets(uint8_t v) { numitemsockets = v; }
	inline void setItemLevel(uint8_t v) { itemlevel = v; }
	inline void setItemQuality(uint8_t v) { itemquality = v; }
	inline void setImage(uint8_t v) { image = v; }
	inline void setLowQuality(uint8_t v) { lowquality = v; }
	inline void setQuantity(uint8_t v) { quantity = v; }

	inline void setMagicPrefix(int i, uint16_t v) {
		if (i < 0 || i >= ITEM_MAX_PREFIX)
			throw SavegameError(SG_ERR_ARG);
		magic_prefix[i] = v;
	}
	inline void setMagicSuffix(int i, uint16_t v) {
		if (i < 0 || i >= ITEM_MAX_SUFFIX)
			throw SavegameError(SG_ERR_ARG);
		magic_suffix[i] = v;
	}
	inline void setSetID(uint16_t v) { setid = v; }
	inline void setUniqueID(uint16_t v) { uniqueid = v; }
	inline void setRunewordID(uint16_t v) { runewordid = v; }
	inline void setDefense(uint16_t v) { defense = v; }

	inline void setID(uint32_t v) { id = v; }

	inline void setNumPrefixes(int i) { numprefixes = i; }
	inline void setNumSuffixes(int i) { numsuffixes = i; }

	inline void setDurability(uint8_t v) { durability = v; }
	inline void setCurrentDurability(uint8_t v) { curdurability = v; }

	inline void setName(int i, uint16_t v) {
		if (i < 0 || i >= ITEM_MAX_NAME)
			throw SavegameError(SG_ERR_ARG);
		name[i] = v;
	}

	void dump();

protected:
	static struct ITEMTYPE* findType(const char* type);

	ItemProperty* handlePropertyList();

	/*! \brief Frees a linked item property list
	 *  \param list The list to free
	 */
	void freeItemPropertyList(ItemProperty* list);

private:
	BitStreamer* bs;
	int version;
	Item* socketitems;

	uint8_t identified, disabled, socketed, badequip, ear, simple, ethereal, personalized;
	uint8_t hasruneword, iversion, location, bodypos, gridcol, gridrow, storedloc, newbie;
	uint8_t numsockets, itemlevel, itemquality, image, lowquality;
	uint8_t numitemsockets, durability, curdurability, quantity;
	uint16_t magic_prefix[ITEM_MAX_PREFIX], magic_suffix[ITEM_MAX_SUFFIX];
	uint16_t setid, uniqueid, runewordid, defense;
	uint16_t name[ITEM_MAX_NAME];
	uint32_t id;
	uint8_t type[ITEM_TYPE_LEN + 1];
	int numprefixes, numsuffixes;
	uint8_t pname[ITEM_MAX_PERSONALIZED_NAME + 1];
	struct ITEMTYPE* itemtype;
	ItemProperty* itemprops;
	ItemProperty* runewordprops;
	ItemProperty* setprops[ITEM_MAX_SET_PROPS];

	Item* next;
};

#endif /* __ITEM_H__ */
