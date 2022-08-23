/*
 * Diablo2 Save Game Library - (c) 2008, 2009 Rink Springer
 */
#include <stdint.h>

#ifndef __ITEMNAMES_H__
#define __ITEMNAMES_H__

struct ITEMNAME {
	uint16_t	id;
	const char*	name;
};

struct ITEMSETNAME {
	uint16_t	setid;
	const char*	type;
	const char*	name;
};

extern struct ITEMNAME uniquenames[];
extern struct ITEMNAME setnames[];
extern struct ITEMSETNAME setitemnames[];

struct ITEMNAME* findUniqueName(uint16_t id);
struct ITEMNAME* findSetName(uint16_t id);
struct ITEMSETNAME* findSetItemName(uint16_t setid, uint8_t* type);

#endif /* __ITEMNAMES_H__ */
