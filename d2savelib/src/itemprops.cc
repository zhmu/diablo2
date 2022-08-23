#include <stdlib.h>
#include "item.h"

struct ITEMPROPERTY itemprops[] = {
	{ 0, "strength", ITEMVAL_STD, 7, 32, 8, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 1, "energy", ITEMVAL_STD, 7, 32, 7, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 2, "dexterity", ITEMVAL_STD, 7, 32, 7, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 3, "vitality", ITEMVAL_STD, 7, 32, 7, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 7, "maxhp", ITEMVAL_STD, 8, 32, 9, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 9, "maxmana", ITEMVAL_STD, 8, 32, 8, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 11, "maxstamina", ITEMVAL_STD, 8, 32, 8, 32, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 16, "item_armor_percent", ITEMVAL_STD, 9, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 17, "item_maxdamage_percent", ITEMVAL_STD, 9, 0, 9, 0, 18, FOLLOW_NONE }, 
	{ 18, "item_mindamage_percent", ITEMVAL_STD, 9, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 19, "tohit", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 20, "toblock", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 21, "mindamage", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 22, "maxdamage", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 23, "secondary_mindamage", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 24, "secondary_maxdamage", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 25, "damagepercent", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 26, "manarecovery", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 27, "manarecoverybonus", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 28, "staminarecoverybonus", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 31, "armorclass", ITEMVAL_STD, 10, 10, 11, 10, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 32, "armorclass_vs_missile", ITEMVAL_STD, 8, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 33, "armorclass_vs_hth", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 34, "normal_damage_reduction", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 35, "magic_damage_reduction", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 36, "damageresist", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 37, "magicresist", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 38, "maxmagicresist", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 39, "fireresist", ITEMVAL_STD, 8, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 40, "maxfireresist", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 41, "lightresist", ITEMVAL_STD, 8, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 42, "maxlightresist", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 43, "coldresist", ITEMVAL_STD, 8, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 44, "maxcoldresist", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 45, "poisonresist", ITEMVAL_STD, 8, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 46, "maxpoisonresist", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 48, "firemindam", ITEMVAL_STD, 8, 0, 8, 0, 49, FOLLOW_NONE }, 
	{ 49, "firemaxdam", ITEMVAL_STD, 8, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 50, "lightmindam", ITEMVAL_STD, 6, 0, 6, 0, 51, FOLLOW_NONE }, 
	{ 51, "lightmaxdam", ITEMVAL_STD, 9, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 52, "magicmindam", ITEMVAL_STD, 6, 0, 8, 0, 53, FOLLOW_NONE }, 
	{ 53, "magicmaxdam", ITEMVAL_STD, 7, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 54, "coldmindam", ITEMVAL_STD, 6, 0, 8, 0, 55, 56 }, 
	{ 55, "coldmaxdam", ITEMVAL_STD, 8, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 56, "coldlength", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 57, "poisonmindam", ITEMVAL_STD, 9, 0, 10, 0, 58, 59 }, 
	{ 58, "poisonmaxdam", ITEMVAL_STD, 9, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 59, "poisonlength", ITEMVAL_STD, 8, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 60, "lifedrainmindam", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 62, "manadrainmindam", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 67, "velocitypercent", ITEMVAL_STD, 7, 30, 7, 30, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 68, "attackrate", ITEMVAL_STD, 7, 30, 7, 30, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 71, "value", ITEMVAL_STD, 8, 100, 8, 100, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 72, "durability", ITEMVAL_STD, 8, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 73, "maxdurability", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 74, "hpregen", ITEMVAL_STD, 6, 30, 6, 30, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 75, "item_maxdurability_percent", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 76, "item_maxhp_percent", ITEMVAL_STD, 6, 10, 6, 10, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 77, "item_maxmana_percent", ITEMVAL_STD, 6, 10, 6, 10, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 78, "item_attackertakesdamage", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 79, "item_goldbonus", ITEMVAL_STD, 9, 100, 9, 100, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 80, "item_magicbonus", ITEMVAL_STD, 8, 100, 8, 100, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 81, "item_knockback", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 82, "item_timeduration", ITEMVAL_STD, 9, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 83, "item_addclassskills", ITEMVAL_STD, 3, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 84, "unsentparam1", ITEMVAL_STD, 3, 0, 3, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 85, "item_addexperience", ITEMVAL_STD, 3, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 86, "item_healafterkill", ITEMVAL_STD, 3, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 87, "item_reducedprices", ITEMVAL_STD, 3, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 88, "item_doubleherbduration", ITEMVAL_STD, 1, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 89, "item_lightradius", ITEMVAL_STD, 4, 4, 4, 4, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 90, "item_lightcolor", ITEMVAL_STD, 5, 0, 24, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 91, "item_req_percent", ITEMVAL_STD, 8, 100, 8, 100, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 92, "item_levelreq", ITEMVAL_STD, 6, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 93, "item_fasterattackrate", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 94, "item_levelreqpct", ITEMVAL_STD, 7, 20, 7, 64, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 95, "lastblockframe", ITEMVAL_STD, 6, 20, 6, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 96, "item_fastermovevelocity", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 97, "item_nonclassskill", ITEMVAL_STD, 7, 20, 15, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 98, "state", ITEMVAL_STD, 6, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 99, "item_fastergethitrate", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 100, "monster_playercount", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 101, "skill_poison_override_length", ITEMVAL_STD, 6, 20, 6, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 102, "item_fasterblockrate", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 103, "skill_bypass_undead", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 104, "skill_bypass_demons", ITEMVAL_STD, 6, 20, 6, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 105, "item_fastercastrate", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 106, "skill_bypass_beasts", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 107, "item_singleskill", ITEMVAL_STD, 14, 0, 12, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 108, "item_restinpeace", ITEMVAL_STD, 14, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 109, "curse_resistance", ITEMVAL_STD, 14, 0, 9, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 110, "item_poisonlengthresist", ITEMVAL_STD, 8, 20, 8, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 111, "item_normaldamage", ITEMVAL_STD, 7, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 112, "item_howl", ITEMVAL_STD, 7, -1, 7, -1, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 113, "item_stupidity", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 114, "item_damagetomana", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 115, "item_ignoretargetac", ITEMVAL_STD, 1, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 116, "item_fractionaltargetac", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 117, "item_preventheal", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 118, "item_halffreezeduration", ITEMVAL_STD, 1, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 119, "item_tohit_percent", ITEMVAL_STD, 9, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 120, "item_damagetargetac", ITEMVAL_STD, 7, 128, 7, 128, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 121, "item_demondamage_percent", ITEMVAL_STD, 9, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 122, "item_undeaddamage_percent", ITEMVAL_STD, 9, 20, 9, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 123, "item_demon_tohit", ITEMVAL_STD, 10, 128, 10, 128, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 124, "item_undead_tohit", ITEMVAL_STD, 10, 128, 10, 128, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 125, "item_throwable", ITEMVAL_STD, 1, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 126, "item_elemskill", ITEMVAL_STD, 4, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 127, "item_allskills", ITEMVAL_STD, 3, 0, 3, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 128, "item_attackertakeslightdamage", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 134, "item_freeze", ITEMVAL_STD, 5, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 135, "item_openwounds", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 136, "item_crushingblow", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 137, "item_kickdamage", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 138, "item_manaafterkill", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 139, "item_healafterdemonkill", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 140, "item_extrablood", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 141, "item_deadlystrike", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 142, "item_absorbfire_percent", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 143, "item_absorbfire", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 144, "item_absorblight_percent", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 145, "item_absorblight", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 146, "item_absorbmagic_percent", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 147, "item_absorbmagic", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 148, "item_absorbcold_percent", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 149, "item_absorbcold", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 150, "item_slow", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 151, "item_aura", ITEMVAL_STD, 7, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 152, "item_indesctructible", ITEMVAL_STD, 7, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 153, "item_cannotbefrozen", ITEMVAL_STD, 1, 0, 1, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 154, "item_staminadrainpct", ITEMVAL_STD, 7, 20, 7, 20, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 155, "item_reanimate", ITEMVAL_STD, 7, 0, 17, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 156, "item_pierce", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 157, "item_magicarrow", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 158, "item_explosivearrow", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 159, "item_throw_mindamage", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 160, "item_throw_maxdamage", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 179, "attack_vs_montype", ITEMVAL_STD, 3, 0, 19, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 180, "damage_vs_montype", ITEMVAL_STD, 3, 0, 19, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 181, "fade", ITEMVAL_STD, 14, 0, 3, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 182, "armor_override_percent", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 183, "unused183", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 184, "unused184", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 185, "unused185", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 186, "unused186", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 187, "unused187", ITEMVAL_STD, 14, 0, 14, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 188, "item_addskill_tab", ITEMVAL_STD, 10, 0, 19, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 189, "unused189", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 190, "unused190", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 191, "unused191", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 192, "unused192", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 193, "unused193", ITEMVAL_STD, 10, 0, 10, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 194, "item_numsockets", ITEMVAL_STD, 4, 0, 4, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 195, "item_skillonattack", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 196, "item_skillonkill", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 197, "item_skillondeath", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 198, "item_skillonhit", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 199, "item_skillonlevelup", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 200, "unused200", ITEMVAL_STD, 21, 0, 21, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 201, "item_skillongethit", ITEMVAL_STD, 21, 0, 23, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 202, "unused202", ITEMVAL_STD, 21, 0, 21, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 203, "unused203", ITEMVAL_STD, 21, 0, 21, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 204, "item_charged_skill", ITEMVAL_STD, 30, 0, 32, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 205, "unused204", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 206, "unused205", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 207, "unused206", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 208, "unused207", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 209, "unused208", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 210, "unused209", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 211, "unused210", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 212, "unused211", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 213, "unused212", ITEMVAL_STD, 30, 0, 30, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 214, "item_armor_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 215, "item_armorpercent_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 216, "item_hp_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 217, "item_mana_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 218, "item_maxdamage_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 219, "item_maxdamage_percent_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 220, "item_strength_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 221, "item_dexterity_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 222, "item_energy_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 223, "item_vitality_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 224, "item_tohit_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 225, "item_tohitpercent_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 226, "item_cold_damagemax_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 227, "item_fire_damagemax_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 228, "item_ltng_damagemax_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 229, "item_pois_damagemax_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 230, "item_resist_cold_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 231, "item_resist_fire_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 232, "item_resist_ltng_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 233, "item_resist_pois_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 234, "item_absorb_cold_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 235, "item_absorb_fire_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 236, "item_absorb_ltng_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 237, "item_absorb_pois_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 238, "item_thorns_perlevel", ITEMVAL_STD, 6, 0, 5, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 239, "item_find_gold_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 240, "item_find_magic_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 241, "item_regenstamina_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 242, "item_stamina_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 243, "item_damage_demon_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 244, "item_damage_undead_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 245, "item_tohit_demon_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 246, "item_tohit_undead_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 247, "item_crushingblow_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 248, "item_openwounds_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 249, "item_kick_damage_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 250, "item_deadlystrike_perlevel", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 252, "item_replenish_durability", ITEMVAL_STD, 5, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 253, "item_replenish_quantity", ITEMVAL_STD, 5, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 254, "item_extra_stack", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 268, "item_armor_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 269, "item_armorpercent_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 270, "item_hp_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 271, "item_mana_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 272, "item_maxdamage_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 273, "item_maxdamage_percent_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 274, "item_strength_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 275, "item_dexterity_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 276, "item_energy_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 277, "item_vitality_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 278, "item_tohit_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 279, "item_tohitpercent_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 280, "item_cold_damagemax_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 281, "item_fire_damagemax_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 282, "item_ltng_damagemax_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 283, "item_pois_damagemax_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 284, "item_resist_cold_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 285, "item_resist_fire_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 286, "item_resist_ltng_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 287, "item_resist_pois_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 288, "item_absorb_cold_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 289, "item_absorb_fire_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 290, "item_absorb_ltng_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 291, "item_absorb_pois_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 292, "item_find_gold_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 293, "item_find_magic_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 294, "item_regenstamina_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 295, "item_stamina_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 296, "item_damage_demon_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 297, "item_damage_undead_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 298, "item_tohit_demon_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 299, "item_tohit_undead_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 300, "item_crushingblow_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 301, "item_openwounds_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 302, "item_kick_damage_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 303, "item_deadlystrike_bytime", ITEMVAL_STD, 22, 0, 22, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 305, "item_pierce_cold", ITEMVAL_STD, 0, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 306, "item_pierce_fire", ITEMVAL_STD, 0, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 307, "item_pierce_ltng", ITEMVAL_STD, 0, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 308, "item_pierce_pois", ITEMVAL_STD, 0, 0, 8, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 324, "item_extra_charges", ITEMVAL_STD, 6, 0, 6, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 329, "passive_fire_mastery", ITEMVAL_STD, 8, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 330, "passive_ltng_mastery", ITEMVAL_STD, 8, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 331, "passive_cold_mastery", ITEMVAL_STD, 8, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 332, "passive_pois_mastery", ITEMVAL_STD, 8, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 333, "passive_fire_pierce", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 334, "passive_ltng_pierce", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 335, "passive_cold_pierce", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 336, "passive_pois_pierce", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 337, "passive_critical_strike", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 338, "passive_dodge", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 339, "passive_avoid", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 340, "passive_evade", ITEMVAL_STD, 7, 0, 7, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 341, "passive_warmth", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 342, "passive_mastery_melee_th", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 343, "passive_mastery_melee_dmg", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 344, "passive_mastery_melee_crit", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 345, "passive_mastery_throw_th", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 346, "passive_mastery_throw_dmg", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 347, "passive_mastery_throw_crit", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 348, "passive_weaponblock", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 349, "passive_summon_resist", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 356, "questitemdifficulty", ITEMVAL_STD, 0, 0, 2, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 357, "passive_mag_mastery", ITEMVAL_STD, 8, 0, 9, 50, FOLLOW_NONE, FOLLOW_NONE }, 
	{ 358, "passive_mag_pierce", ITEMVAL_STD, 8, 0, 8, 0, FOLLOW_NONE, FOLLOW_NONE }, 
	{ NULL, 0, 0, 0, FOLLOW_NONE, FOLLOW_NONE }
};