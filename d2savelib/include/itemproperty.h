/*
 * Diablo2 Save Game Library - (c) 2008, 2009 Rink Springer
 */
#include <stdint.h>
#include "bitstreamer.h"
#include "savegame.h"

#ifndef __ITEMPROPERTY_H__
#define __ITEMPROPERTY_H__

#define ITEMPROP_TYPE_END	0x1ff

struct ITEMPROPERTY;

class ItemProperty {
public:
	inline ItemProperty(BitStreamer* bs, int version, uint16_t propid) {
		this->bs = bs;
		this->version = version;
		this->propid = propid;
		next = NULL;
		if (propid == ITEMPROP_TYPE_END)
			throw SavegameError(SG_ERR_ARG);
	}

	inline ItemProperty* getNext() { return next; }
	inline void setNext(ItemProperty* p) { next = p; }

	inline struct ITEMPROPERTY* getItemProperty() { return itemprop; }
	inline uint32_t getValue() { return value; }

	void load();
	void dump();

protected:
	static struct ITEMPROPERTY* findProperty(uint16_t id);

private:
	BitStreamer* bs;
	ItemProperty* next;
	int version;
	uint16_t propid;
	uint32_t value;
	struct ITEMPROPERTY* itemprop;
};

#endif /* __ITEMPROPERTY_H__ */
