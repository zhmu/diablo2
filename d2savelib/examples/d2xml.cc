#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bitstreamer.h"
#include "item.h"
#include "itemnames.h"
#include "savegame.h"
#include "stash.h"

void printItemList(Item* list, int level);

#define INDENT() for(int idt = level; idt >= 0; idt--) { printf(" "); }

const char*
resolveItemQuality(int q)
{
	switch (q) {
		case ITEM_QUALITY_LOW:     return "low";
		case ITEM_QUALITY_NORMAL:  return "normal";
		case ITEM_QUALITY_HIGH:    return "high";
		case ITEM_QUALITY_MAGIC:   return "magic";
		case ITEM_QUALITY_SET:     return "set";
		case ITEM_QUALITY_RARE:    return "rare";
		case ITEM_QUALITY_UNIQUE:  return "unique";
		case ITEM_QUALITY_CRAFTED: return "crafted";
	}
	return "unknown";
}

void
printProperty(ItemProperty* ip, int level)
{
	INDENT(); printf("<property name=\"%s\" value=\"%u\"/>\n",
		ip->getItemProperty()->descr, ip->getValue());
}

void
printPropertyList(ItemProperty* list, int level)
{
	ItemProperty* ip = list;
	while (ip != NULL) {
		printProperty(ip, level + 1);
		ip = ip->getNext();
	}
}

void
printItem(Item* it, int level)
{
	struct ITEMTYPE* itemtype = it->getItemType();
	INDENT(); printf("<item version=\"%u\" id=\"0x%x\" ilevel=\"%u\">\n",
		it->getItemVersion(), it->getID(), it->getItemLevel());
	INDENT(); printf(" <type code=\"%s\">%s</type>\n", 
		it->getType(), (itemtype != NULL) ? itemtype->name : "???");
	if (it->getIdentified()) { INDENT(); printf(" <identified/>\n"); }
	if (it->getDisabled()) { INDENT(); printf(" <disabled/>\n"); }
	if (it->getSocketed()) {INDENT();  printf(" <socketed/>\n"); }
	if (it->getIllegalEquipped()) { INDENT();  printf(" <illegally-equipped/>\n"); }
	if (it->getEar()) {
		INDENT(); printf(" <ear>\n");
		INDENT(); printf(" </ear>\n");
	}
	if (it->getNewbie()) { INDENT(); printf (" <newbie/>\n"); }
	if (it->getSimple()) { INDENT(); printf (" <simple-item/>\n"); }
	if (it->getEthereal()) { INDENT(); printf (" <ethereal/>\n"); }
	if (it->getPersonalized()) {
		INDENT(); printf (" <personalized name=\%s\" />\n", it->getPersonalizedName());
	}
	if (it->getHasRuneword()) {
		INDENT(); printf (" <runeword id=\"%u\">\n", it->getRunewordID());
	}
	INDENT(); printf (" <location where=\"%u\">\n", it->getLocation());
	INDENT(); printf ("  <bodyposition>%u</bodyposition>\n", it->getBodyPosition());
	INDENT(); printf ("  <grid row=\"%u\" col=\"%u\" />\n",
		it->getGridRow(), it->getGridColumn());
	INDENT(); printf ("  <storage>%u</storage>\n", it->getStorageLocation());
	INDENT(); printf (" </location>\n");
	if (it->getNumSockets() > 0) {
		INDENT();  printf (" <sockets amount=\"%u\" used=\"%u\">\n", 
			it->getNumSockets(), it->getNumItemSockets());
		printItemList(it->getItemsInSockets(), level + 1);
		INDENT(); printf (" </sockets>\n");
	}
	INDENT(); printf(" <quality type=\"%s\">\n", resolveItemQuality(it->getItemQuality()));
	struct ITEMNAME* in;
	struct ITEMSETNAME* ii;
	switch (it->getItemQuality()) {
		  case ITEM_QUALITY_LOW:
			INDENT(); printf("  <lowquality>%u</lowquality>\n", it->getLowQuality());
			break;
		  case ITEM_QUALITY_SET:
			in = findSetName(it->getSetID());
			ii  = findSetItemName(it->getSetID(), it->getType());
			INDENT(); printf("  <set id=\"%u\" name=\"%s\" itemname=\"%s\" />\n",
				it->getSetID(), in != NULL ? in->name : "???", ii != NULL ? ii->name : "???");
			break;
		  case ITEM_QUALITY_UNIQUE:
			in = findUniqueName(it->getUniqueID());
			INDENT(); printf("  <unique id=\"%u\">%s</unique>\n", it->getUniqueID(), (in != NULL) ? in->name : "???");
			break;
	}
	INDENT(); printf(" </quality>\n");
	if (it->getDurability()) {
		INDENT(); printf(" <durability cur=\"%u\" max=\"%u\" />\n",
			it->getCurrentDurability(), it->getDurability());
	}
	if (itemtype != NULL && itemtype->itype & ITEMTYPE_STACKABLE) {
		INDENT(); printf(" <quantity>%u</quantity>\n", it->getQuantity());
	}
	if (it->getPropertyList() != NULL || it->getRunewordPropertyList() != NULL) {
		INDENT(); printf(" <properties>\n");
		printPropertyList(it->getPropertyList(), level + 1);
		if (it->getRunewordPropertyList() != NULL) {
			INDENT(); printf("  <!-- runeword properties -->\n");
			printPropertyList(it->getRunewordPropertyList(), level + 1);
		}
		INDENT(); printf(" </properties>\n");
	}
	for (int i = 0; i < ITEM_MAX_SET_PROPS; i++) {
		if (it->getSetitemPropertyList(i) == NULL)
			continue;
		INDENT(); printf(" <set-properties id=\"%u\">\n", i + 1);
		printPropertyList(it->getSetitemPropertyList(i), level + 1);
		INDENT(); printf(" </set-properties>\n");
	}
	INDENT(); printf("</item>\n");
}

void
printItemList(Item* list, int level)
{
	Item* it = list;
	while (it != NULL) {
		printItem(it, level + 1);
		it = it->getNext();
	}
}

void
usage()
{
	printf("usage: d2xml file.d2s\n");
	printf("             file.d2x\n");
	printf("             file.d2i version\n");
	printf("\n");
	printf("version must be 109 for 1.09, 110 for 1.10, or 111 for 1.11+\n");
	exit(EXIT_FAILURE);
}

int
main(int argc, char** argv)
{
	BitStreamer bs;
	Savegame sg(&bs);
	Stash st(&bs);

	if (argc < 2)
		usage();
	try {
		bs.load(argv[1]);
		if (strcasestr(argv[1], ".d2x") != NULL) {
			st.load();
			printf("<stash version=\"%u\">\n", st.getVersion());
			printf(" <items>\n");
			printItemList(st.getItems(), 0);
			printf(" </items>\n");
			printf("</stash>\n");
		} else if (strcasestr(argv[1], ".d2i") != NULL) {
			if (argc != 3)
				usage();
			char* ptr;
			int version = strtol(argv[2], &ptr, 10);
			if (*ptr != '\0' || version < 109 || version > 111) {
				printf("invalid version number '%s'\n", argv[2]);
				exit(EXIT_FAILURE);
			}
			Item it(&bs, version);
			it.load();
			if (!bs.isEOS())
				throw SavegameError(SG_ERR_CORRUPT);
			printItem(&it, -1);
		} else {
			sg.load();

			printf("<savegame version=\"%u\">\n", sg.getVersion());
			printf(" <player>\n");
			printf("  <stats>\n");
			printf("   <name>%s</name>\n", sg.getName());
			printf("   <level>%u</level>\n", sg.getLevel());
			printf("   <experience>%u</experience>\n", sg.getExperience());
			printf("   <strength>%u</strength>\n", sg.getStrength());
			printf("   <energy>%u</energy>\n", sg.getEnergy());
			printf("   <dexterity>%u</dexterity>\n", sg.getDexterity());
			printf("   <vitality>%u</vitality>\n", sg.getVitality());
			if (sg.getStatpointsRemaining())
				printf("   <statpoints>%u</statpoints>\n", sg.getStatpointsRemaining()); 
			if (sg.getSkillpointsRemaining())
				printf("   <skillpoints>%u</skillpoints>\n", sg.getSkillpointsRemaining()); 
			printf("   <life cur=\"%.2f\" max=\"%.2f\" />\n",
				(float)sg.getCurrentLife() / 256.0f, (float)sg.getMaxLife() / 256.0f);
			printf("   <mana cur=\"%.2f\" max=\"%.2f\" />\n",
				(float)sg.getCurrentMana() / 256.0f, (float)sg.getMaxMana() / 256.0f);
			printf("   <stamina cur=\"%.2f\" max=\"%.2f\" />\n",
				(float)sg.getCurrentStamina() / 256.0f, (float)sg.getMaxStamina() / 256.0f);
			printf("   <gold inventory=\"%u\" stash=\"%u\" />\n",
				sg.getInventoryGold(), sg.getStashGold());
			printf("  </stats>\n");
			printf("  <items>\n");
			printItemList(sg.getPlayerItems(), 1);
			printf("  </items>\n");
			printf("  <corpse-items>\n");
			printItemList(sg.getCorpseItems(), 1);
			printf("  </corpse-items>\n");
			printf(" </player>\n");
			if (sg.getMercenary()) {
				printf(" <mercenary>\n");
				printf("  <name>%u</name>\n", sg.getMercenaryName());
				printf("  <type>%u</type>\n", sg.getMercenaryType());
				printf("  <experience>%u</experience>\n", sg.getMercenaryExperience());
				if (sg.getMercenaryDead()) printf("  <dead/>\n");
				printf("  <items>\n");
				printItemList(sg.getMercenaryItems(), 1);
				printf("  </items>\n");
				printf(" </mercenary>\n");
			}
			printf("</savegame>\n");
		}
		return 0;
	} catch (BitStreamError bse) {
		printf("bitstream.error=%u\n", bse.getErrorCode());
	} catch (SavegameError sge) {
		printf("savegame.error=%u\n", sge.getErrorCode());
	} catch (StashError ste) {
		printf("stash.error=%u\n", ste.getErrorCode());
	}
	return 1;
}
