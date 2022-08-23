/*
 * Diablo2 Save Game Library - (c) 2008, 2009 Rink Springer
 */
#include <stdint.h>
#include "bitstreamer.h"

#ifndef __SAVEGAME_H__
#define __SAVEGAME_H__

#define SG_MAX_NAME	16

enum SavegameErrorCode {
	SG_ERR_UNKNOWN = 0,
	SG_ERR_NOSG,
	SG_ERR_VERSION,
	SG_ERR_CORRUPT,
	SG_ERR_MEMORY,
	SG_ERR_ARG,
	SG_ERR_UNSUPP
};

#define SAVEGAME_STAT_END		0x1ff
#define SAVEGAME_STAT_STRENGTH		0
#define SAVEGAME_STAT_ENERGY		1
#define SAVEGAME_STAT_DEXTERITY		2
#define SAVEGAME_STAT_VITALITY		3
#define SAVEGAME_STAT_STATPTS		4
#define SAVEGAME_STAT_NEWSKILLS		5
#define SAVEGAME_STAT_HP		6
#define SAVEGAME_STAT_MAXHP		7
#define SAVEGAME_STAT_MANA		8
#define SAVEGAME_STAT_MAXMANA		9
#define SAVEGAME_STAT_STAMINA		10
#define SAVEGAME_STAT_MAXSTAMINA	11
#define SAVEGAME_STAT_LEVEL		12
#define SAVEGAME_STAT_EXPERIENCE	13
#define SAVEGAME_STAT_GOLD		14
#define SAVEGAME_STAT_GOLDSTASH		15

//! \brief Class used to handle bitstream errors
class SavegameError
{
public:
	inline SavegameError(SavegameErrorCode value) { errcode = value; }
	inline SavegameErrorCode getErrorCode() { return errcode; }
	const char* getErrorMessage();

private:
	SavegameErrorCode errcode;
};

class Item;
class Stash;

//! \brief Interfaces Diablo2 save games
class Savegame {
	friend class Item;
	friend class Stash;

public:
	inline Savegame(BitStreamer* bs) {
		this->bs = bs;
		playeritems = corpseitems = mercitems = NULL;
	}
	inline ~Savegame() {
		clear();
	}

	/*! \brief Loads save game data from the bitstreamer
	 *  \throws SavegameError on errors
	 */
	void load();

	//! \brief Resets all savegame values
	void clear();

	inline uint32_t getStrength() { return strength; }
	inline uint32_t getEnergy() { return energy; }
	inline uint32_t getDexterity() { return dexterity; }
	inline uint32_t getVitality() { return vitality; }
	inline uint32_t getStatpointsRemaining() { return stat_rem; }
	inline uint32_t getSkillpointsRemaining() { return skill_rem; }
	inline uint32_t getCurrentLife() { return life_cur; }
	inline uint32_t getMaxLife() { return life_max; }
	inline uint32_t getCurrentMana() { return mana_cur; }
	inline uint32_t getMaxMana() { return mana_max; }
	inline uint32_t getCurrentStamina() { return stamina_cur; }
	inline uint32_t getMaxStamina() { return stamina_max; }
	inline uint32_t getLevel() { return level; }
	inline uint32_t getExperience() { return exp; }
	inline uint32_t getInventoryGold() { return gold_inv; }
	inline uint32_t getStashGold() { return gold_stash; }

	inline uint8_t getCharachterType() { return chartype; }
	inline uint8_t getCharachterTitle() { return chartitle; }
	inline uint8_t getCharachterClass() { return charclass; }

	inline int      getVersion() { return version; }
	inline int      getMercenary() { return havemerc; }
	inline uint8_t  getMercenaryDead() { return mercdead; }
	inline uint16_t getMercenaryName() { return mercname; }
	inline uint16_t getMercenaryType() { return merctype; }
	inline uint32_t getMercenaryExperience() { return mercexp; }

	inline char* getName() { return name; }

	inline void setStrength(uint32_t v) { strength = v; }
	inline void setEnergy(uint32_t v) { energy = v; }
	inline void setDexterity(uint32_t v) { dexterity = v; }
	inline void setVitality(uint32_t v) { vitality = v; }
	inline void setStatpointsRemaining(uint32_t v) { stat_rem = v; }
	inline void setSkillpointsRemaining(uint32_t v) { skill_rem = v; }
	inline void setCurrentLife(uint32_t v) { life_cur = v; }
	inline void setMaxLife(uint32_t v) { life_max = v; }
	inline void setCurrentMana(uint32_t v) { mana_cur = v; }
	inline void setMaxMana(uint32_t v) { mana_max = v; }
	inline void setCurrentStamina(uint32_t v) { stamina_cur = v; }
	inline void setMaxStamina(uint32_t v) { stamina_max = v; }
	inline void setLevel(uint32_t v) { level = v; }
	inline void setExperience(uint32_t v) { exp = v; }
	inline void setInventoryGold(uint32_t v) { gold_inv = v; }
	inline void setStashGold(uint32_t v) { gold_stash = v; }

	inline void setCharachterType(uint8_t v) { chartype = v; }
	inline void setCharachterTitle(uint8_t v) { chartitle = v; }
	inline void setCharachterClass(uint8_t v) { charclass = v; }

	inline void setMercenary(int v) { havemerc = v; }
	inline void setMercenaryDead(uint8_t v) { mercdead = v; }
	inline void setMercenaryName(uint16_t v) { mercname = v; }
	inline void setMercenaryType(uint16_t v) { merctype = v; }
	inline void setMercenaryExperience(uint32_t v) { mercexp = v; }

	inline Item* getPlayerItems() { return playeritems; }
	inline Item* getCorpseItems() { return corpseitems; }
	inline Item* getMercenaryItems() { return mercitems; }

protected:
	/*! \brief Frees a linked list of item
	 *  \param List first entry of the list to free
	 */
	static void freeItemList(Item* list);

	/*! \brief Calculates the checksum of the save game
	 *  \param bs Bitstreamer object to calculate the checksum of
	 *  \param start Start byte of the current checksum
	 *  \param end End byte of the current checksum
	 *  \return The calculated checksum
	 *
	 *  The current position in the stream will be saved.
	 */
	static uint32_t getChecksum(BitStreamer* bs, off_t start = 12, off_t end = 15);

private:
	BitStreamer* bs;
	int version, havemerc;

	uint32_t strength, energy, dexterity, vitality;
	uint32_t stat_rem, skill_rem;
	uint32_t life_cur, life_max, mana_cur, mana_max, stamina_cur, stamina_max;
	uint32_t level, exp, gold_inv, gold_stash;

	uint8_t chartype, chartitle, charclass, mercdead;
	uint16_t mercname, merctype;
	uint32_t mercexp;

	Item* playeritems;
	Item* corpseitems;
	Item* mercitems;

	char name[SG_MAX_NAME + 1];
};

#endif /* __SAVEGAME_H__ */
