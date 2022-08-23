/*
 * Diablo 2 Save Game Reader 1.0 - savegame.h (Savegame Reader Class)
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
#ifndef __SAVEGAME_H__
#define __SAVEGAME_H__

// SG_READBITS is a helper function
#define SG_READBITS(start,size) ((*(unsigned long*)&data[(start) / 8]) \
				>> ((start) & 7) & ((1 << size) - 1))
#define SG_WRITEBITS(s,n,v) *((unsigned long *) &data[(s) / 8])		\
	= (*((unsigned long *) &data[(s) / 8])				\
	   & ~(((1 << (n)) - 1) << ((s) & 7)))				\
	  | (((v) & ((1 << (n)) - 1)) << ((s) & 7))

// SAVEGAME_OK means victory, SAVEGAME_ERROR_xxx is an error
#define SAVEGAME_OK			0		// victory
#define SAVEGAME_ERROR_CANTOPEN		1		// cannot open file
#define SAVEGAME_ERROR_OUTOFMEMORY	2		// out of memory
#define SAVEGAME_ERROR_READERR		3		// read error
#define SAVEGAME_ERROR_WRONGVER		4		// wrong version
#define SAVEGAME_ERROR_NOSAVEGAME	5		// not a save game
#define SAVEGAME_ERROR_WRONGSIZE	6		// size mismatch
#define SAVEGAME_ERROR_CONTRA		7		// contradiction!
#define SAVEGAME_ERROR_CORRUPT		8		// corrupt
#define SAVEGAME_ERROR_INVCHECKSUM	9		// invalid checksum
#define SAVEGAME_ERROR_WRITERR		10		// write error

// SAVEGAME_CLASS_xxx are the character classes known
#define SAVEGAME_CLASS_AMAZON		0		// amazon
#define SAVEGAME_CLASS_SORCERESS	1		// sorceress
#define SAVEGAME_CLASS_NECROMANCER	2		// necromancer
#define SAVEGAME_CLASS_PALADIN		3		// paladin
#define SAVEGAME_CLASS_BARBARIAN	4		// barbarian
#define SAVEGAME_CLASS_DRUID		5		// druid
#define SAVEGAME_CLASS_ASSASSIN		6		// assassin

/* SAVEGAME_ITEMTYPE_xxx are the item types */
#define SAVEGAME_ITEMTYPE_UNKNOWN	0		// ?
#define SAVEGAME_ITEMTYPE_SIMPLE	1		// simple item
#define SAVEGAME_ITEMTYPE_GEM		2		// gem
#define SAVEGAME_ITEMTYPE_SKULL		3		// skull
#define SAVEGAME_ITEMTYPE_RUNE		4		// rune
#define SAVEGAME_ITEMTYPE_POTION	5		// potion
#define SAVEGAME_ITEMTYPE_STWEAPON	6		// stacked weapon
#define SAVEGAME_ITEMTYPE_STACK		7		// stack
#define SAVEGAME_ITEMTYPE_TOME		8		// tome
#define SAVEGAME_ITEMTYPE_WEAPON	9		// weapon
#define SAVEGAME_ITEMTYPE_ARMOR		10		// armor
#define SAVEGAME_ITEMTYPE_AMULET	11		// amulet
#define SAVEGAME_ITEMTYPE_RING		12		// ring
#define SAVEGAME_ITEMTYPE_JEWEL		13		// jewel
#define SAVEGAME_ITEMTYPE_CHARM		14		// charm

/* SAVEGAME_ITEMQUALITY_xxx are the item qualities */
#define SAVEGAME_ITEMQUALITY_LOW	1		// low quality
#define SAVEGAME_ITEMQUALITY_NORMAL	2		// normal quality
#define SAVEGAME_ITEMQUALITY_HIGH	3		// high quality
#define SAVEGAME_ITEMQUALITY_MAGIC	4		// magic item
#define SAVEGAME_ITEMQUALITY_SET	5		// set item
#define SAVEGAME_ITEMQUALITY_RARE	6		// rare item
#define SAVEGAME_ITEMQUALITY_UNIQUE	7		// unique item
#define SAVEGAME_ITEMQUALITY_CRAFTED	8		// crafted item

/* SAVEGAME_ITEMDATA is an item in a save game */
struct SAVEGAME_ITEMDATA {
    char		magic[2];			// 'JM'
    unsigned short	unk:4;				// ?
    unsigned short	identified:1;			// indentified
    unsigned short	unk2:6;				// ?
    unsigned short	socketed:1;			// socketed
    unsigned short	unk3:1;				// ?
    unsigned short	newitem:1;			// new item bit
    unsigned short	unk4:3;				// ?
    unsigned short	newbie:1;			// newbie item
    unsigned short	unk5:3;				// ?
    unsigned short	simple:1;			// simple item
    unsigned short	ethereal:1;			// ethereal item
    unsigned short	unk6:1;				// ?
    unsigned short	personized:1;			// personized
    unsigned short	unk7:1;				// ?
    unsigned short	runeword:1;			// runeword
    unsigned short	unk8:15;			// ?
    unsigned short	loc:3;				// location
    unsigned short	equip:4;			// equipped location
    unsigned short	col:4;				// column
    unsigned short	row:3;				// row
    unsigned short	unk9:1;				// ?
    unsigned short	stloc:3;			// stored location
    unsigned short	type:8;				// item type
    unsigned short	subtype:8;			// subtype
    unsigned short	variant:8;			// variant
    unsigned short	unk10:8;			// ?
    unsigned short	numgems:3;			// number of gems
    // everything below is for EXTENDED items!
    unsigned long	uniqid:32;			// uniq id
    unsigned short	ilevel:7;			// item level
    unsigned short	iquality:4;			// item quality
} __attribute__ ((packed));

/* SAVEGAME_ITEMTYPE_DECL is an item declaration */
struct SAVEGAME_ITEMTYPE_DECL {
    unsigned char	type;				// type
    unsigned char	subtype;			// subtype
    unsigned char	variant;			// variant
    int			itemtype;			// type
    char*		name;				// name
};

/* SAVEGAME_SETITEM_DECL is a set item declaration */
struct SAVEGAME_SETITEM_DECL {
    int			setid;				// set id
    unsigned char	type;				// type
    unsigned char	subtype;			// subtype
    unsigned char	variant;			// variant
    char*		name;				// name
};

/*
 * SAVEGAME_ITEM is a Diablo2 item.
 */
class SAVEGAME_ITEM {
public:
	SAVEGAME_ITEM();

	void		set_next (SAVEGAME_ITEM*);
	SAVEGAME_ITEM*	get_next();
	int		get_type();

	char*		get_name();
	char*		get_info();

	unsigned int	get_defense();
	unsigned int	get_fire_resist();
	unsigned int	get_cold_resist();
	unsigned int	get_lightning_resist();
	unsigned int	get_poison_resist();

	void		create (SAVEGAME_ITEMDATA*);

private:
	SAVEGAME_ITEM*	next;
	int		type;

	char*		resolve_magic_prefix (int);
	char*		resolve_magic_suffix (int);
	char*		resolve_set_item (int);
	char*		resolve_set_item_name (int, SAVEGAME_ITEMDATA*);
	char*		resolve_unique_item (int);
	char*		resolve_runeword (int);
	char*		resolve_skill (int);
	char*		resolve_skill_set (int);
	char*		resolve_spell (int);
	int		resolve_prefix (char*, unsigned char*, int, char*, int);
	void		resolve_magic_data (char*, int, int, char*);

	unsigned int	defense;
	unsigned int	fire_resist;
	unsigned int	cold_resist;
	unsigned int	lightning_resist;
	unsigned int	poison_resist;

	unsigned int	ama_skill;
	unsigned int	pal_skill;
	unsigned int	necro_skill;
	unsigned int	sorc_skill;
	unsigned int	barb_skill;
	unsigned int	dru_skill;
	unsigned int	asa_skill;

	char*		name;
	char*		info;
};

/*
 * SAVEGAME is a Diablo 2 save game.
 */
class SAVEGAME {
public:
	SAVEGAME();
	~SAVEGAME();

	int		load (char*);
	int		save (char*);
	int		analyze ();

	unsigned char	getBE8 (int);
	unsigned char	getLE8 (int);
	unsigned short	getBE16 (int);
	unsigned short	getLE16 (int);
	unsigned long	getBE32 (int);
	unsigned long	getLE32 (int);

	char*		getName();
	int		getClass();
	int		getLevel();
	int		isHardcore();
	int		isExpansion();

	unsigned int	getStrength();
	unsigned int	getEnergy();
	unsigned int	getDexterity();
	unsigned int	getVitality();
	unsigned int	getStatRemaining();
	unsigned int	getSkillRemaining();
	unsigned int	getCurLife();
	unsigned int	getMaxLife();
	unsigned int	getCurMana();
	unsigned int	getMaxMana();
	unsigned int	getCurStamina();
	unsigned int	getMaxStamina();
	unsigned int	getGoldInv();
	unsigned int	getGoldStash();
	unsigned int	getExperience();

	unsigned int	calcChecksum();

	SAVEGAME_ITEM*	getItems();

private:
	unsigned int	savesize;
	char*		savebuf;

	int		strength;
	int		energy;
	int		dexterity;
	int		vitality;
	int		stat_rem;
	int		skill_rem;
	int		life_cur;
	int		life_max;
	int		mana_cur;
	int		mana_max;
	int		stam_cur;
	int		stam_max;
	int		exp;
	int		gold_inv;
	int		gold_stash;
	int		level;

	unsigned int	num_items;

	SAVEGAME_ITEM*	items;

	int		analyze_items (unsigned int*);
};

#endif
