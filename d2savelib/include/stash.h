/*
 * Diablo2 Save Game Library - (c) 2008, 2009 Rink Springer
 */
#include <stdint.h>
#include "bitstreamer.h"

#ifndef __STASH_H__
#define __STASH_H__

enum StashErrorCode {
	ST_ERR_UNKNOWN = 0,
	ST_ERR_NOSG,
	ST_ERR_VERSION,
	ST_ERR_CORRUPT,
	ST_ERR_MEMORY
};

//! \brief Class used to handle stash errors
class StashError 
{
public:
	inline StashError(StashErrorCode value) { errcode = value; }
	inline StashErrorCode getErrorCode() { return errcode; }
	const char* getErrorMessage();

private:
	StashErrorCode errcode;
};

class Item;

//! \brief Interfaces Diablo2 stash files
class Stash {
	friend class Item;

public:
	inline Stash(BitStreamer* bs) {
		this->bs = bs;
		items = NULL;
	}
	inline ~Stash() {
		clear();
	}

	/*! \brief Loads stash data from the bitstreamer
	 *  \throws StashError on errors
	 */
	void load();

	//! \brief Resets all stash values
	void clear();

	inline int   getVersion() { return version; }
	inline Item* getItems() { return items; }

private:
	BitStreamer* bs;
	int version;

	uint32_t numitems;
	Item* items;
};

#endif /* __STASH_H__ */
