/*
 * Diablo 2 Save Game Reader 1.0 - item.cc (Savegame Item Reader Class)
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
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "savegame.h"

// savegame_rname[] are the rune names
const char* savegame_rname[] = {
	  NULL, "El", "Eld", "Tir", "Nef", "Eth", "Ith", "Tal", "Ral",
	  "Ort", "Thul", "Amn", "Sol", "Shael", "Dol", "Hel", "Io",
	  "Lum", "Ko", "Fal", "Lem", "Pul", "Um", "Mal", "Ist",
	  "Gul", "Vex", "Ohm", "Lo", "Sur", "Ber", "Jah", "Cham", "Zod"
	};

// savegame_lqname[] are the low quality names
const char* savegame_lqname[] = {
	 "Crude", "Cracked", "Damaged", "Low Quality"
	};

// savegame_itemsdecl[] are all items types we understand so far
struct SAVEGAME_ITEMTYPE_DECL savegame_itemsdec[] = {
	{  '2',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Double Axe" },
	{  '2',  'h',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Two-Handed Sword" },
	{  '6',  'c',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Elder Staff" },
	{  '6',  'l',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"Crusader Bow" },
	{  '6',  'l',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Hydra Bow" },
	{  '6',  'w',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Giant Tresher" },
	{  '7',  'a',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Suwayyah" },
	{  '7',  'b',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"Champion Sword" },
	{  '7',  'b',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Decapitator" },
	{  '7',  'd',  'g', SAVEGAME_ITEMTYPE_WEAPON,	"Bone Knife" },
	{  '7',  'f',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Colossus Sword" },
	{  '7',  'f',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Hydra Edge" },
	{  '7',  'g',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Champion Axe" },
	{  '7',  'g',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Colossus Blade" },
	{  '7',  'g',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Basher" },
	{  '7',  'q',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Scissors Suwayyah" },
	{  '7',  'l',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Cryptic Sword" },
	{  '7',  'l',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Feral Claws" },
	{  '7',  'm',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"Ogre Maul" },
	{  '7',  'm',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Reinforced Mace" },
	{  '7',  'm',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Devil Star" },
	{  '7',  'p',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"War Pike" },
	{  '7',  's',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Phaser Blade" },
	{  '7',  't',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Runic Talons" },
	{  '7',  'w',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Mythical Sword" },
	{  '7',  'w',  'h', SAVEGAME_ITEMTYPE_WEAPON,	"Legendary Mallet" },
	{  '7',  'w',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Caduceus" },
	{  '8',  'b', 0x73, SAVEGAME_ITEMTYPE_WEAPON,	"Gothic Staff" },
	{  '8',  'c', 0x62, SAVEGAME_ITEMTYPE_WEAPON,	"Double Bow" },
	{  '8',  'c',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Cedar Staff" },
	{  '8',  'h', 0x62, SAVEGAME_ITEMTYPE_WEAPON,	"Razor Bow" },
	{  '8',  'h', 0x78, SAVEGAME_ITEMTYPE_WEAPON,	"Ballista" },
	{  '8',  'l', 0x62, SAVEGAME_ITEMTYPE_WEAPON,	"Cedar Bow" },
	{  '8',  'l', 0x73, SAVEGAME_ITEMTYPE_WEAPON,	"Quarterstaff" },
	{  '8',  'l', 0x78, SAVEGAME_ITEMTYPE_WEAPON,	"Arbalest" },
	{  '8',  'l',  '8', SAVEGAME_ITEMTYPE_WEAPON,	"Large Siege Bow" },
	{  '8',  'l',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Gothic Bow" },
	{  '8',  'm',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Siege Crossbow" },
	{  '8',  'r',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Chu-Ko-Nu" },
	{  '8',  's',  '8', SAVEGAME_ITEMTYPE_WEAPON,	"Short Siege Bow" },
	{  '8',  's', 0x62, SAVEGAME_ITEMTYPE_WEAPON,	"Edge Bow" },
	{  '8',  's', 0x77, SAVEGAME_ITEMTYPE_WEAPON,	"Rune Bow" },
	{  '8',  's',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Jo Staff" },
	{  '8',  'w',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Rune Staff" },
	{  '9',  '2',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Twin Axe" },
	{  '9',  '2',  'h', SAVEGAME_ITEMTYPE_WEAPON,	"Espandon" },
	{  '9',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Cleaver" },
	{  '9',  'b',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"Lochaber Axe" },
	{  '9',  'b',  '9', SAVEGAME_ITEMTYPE_WEAPON,	"Gothic Sword" },
	{  '9',  'b',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Bearded Axe" },
	{  '9',  'b',  'l', SAVEGAME_ITEMTYPE_WEAPON,	"Stiletto" },
	{  '9',  'b',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"War Fork" },
	{  '9',  'b',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Battle Sword" },
	{  '9',  'b',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Tabar" },
	{  '9',  'b', 0x77, SAVEGAME_ITEMTYPE_WEAPON,	"Tomb Wand" },
	{  '9',  'c', 0x6c, SAVEGAME_ITEMTYPE_WEAPON,	"Cudgel" },
	{  '9',  'c', 0x72, SAVEGAME_ITEMTYPE_WEAPON,	"Dimensional Blade" },
	{  '9',  'c',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Dacian Falx" },
	{  '9',  'd', 0x69, SAVEGAME_ITEMTYPE_WEAPON,	"Rondel" },
	{  '9',  'd',  'g', SAVEGAME_ITEMTYPE_WEAPON,	"Poignard" },
	{  '9',  'f', 0x62, SAVEGAME_ITEMTYPE_WEAPON,	"Zweihander" },
	{  '9',  'f',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Tulwar" },
	{  '9',  'f',  'l', SAVEGAME_ITEMTYPE_WEAPON,	"Knout" },
	{  '9',  'g',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Gothic Axe" },
	{  '9',  'g', 0x64, SAVEGAME_ITEMTYPE_WEAPON,	"Executioner Sword" },
	{  '9',  'g', 0x69, SAVEGAME_ITEMTYPE_WEAPON,	"Ancient Axe" },
	{  '9',  'g', 0x6d, SAVEGAME_ITEMTYPE_WEAPON,	"Martel de Fer" },
	{  '9',  'g', 0x73, SAVEGAME_ITEMTYPE_WEAPON,	"Tusk Sword" },
	{  '9',  'g',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Grave Wand" },
	{  '9',  'h',  '9', SAVEGAME_ITEMTYPE_WEAPON,	"Bec-de-Corbin" },
	{  '9',  'h',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Hatchet" },
	{  '9',  'k',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"?9kr?" },	// ?
	{  '9',  'l', 0x61, SAVEGAME_ITEMTYPE_WEAPON,	"Military Axe" },
	{  '9',  'l', 0x73, SAVEGAME_ITEMTYPE_WEAPON,	"Rune Sword" },
	{  '9',  'm', 0x39, SAVEGAME_ITEMTYPE_WEAPON,	"War Club" },
	{  '9',  'm', 0x61, SAVEGAME_ITEMTYPE_WEAPON,	"Flanged Mace" },
	{  '9',  'm',  'p', SAVEGAME_ITEMTYPE_WEAPON,	"Crowbill" },
	{  '9',  'm',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Jagged Star" },
	{  '9',  'p',  '9', SAVEGAME_ITEMTYPE_WEAPON,	"Lance" },
	{  '9',  'p',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Partizan" },
	{  '9',  'q',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Holy Water Sprinkler" },
	{  '9',  's',  '8', SAVEGAME_ITEMTYPE_WEAPON,	"Battle Scythe" },
	{  '9',  's',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Shamshir" },
	{  '9',  's',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Rune Scepter" },
	{  '9',  's',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Cutlass" },
	{  '9',  's',  'p', SAVEGAME_ITEMTYPE_WEAPON,	"Barbed Club" },
	{  '9',  's',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"War Spear" },
	{  '9',  's',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Gladius" },
	{  '9',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Yari" },
	{  '9',  't',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Greater Talons" },
	{  '9', 0x74, 0x72, SAVEGAME_ITEMTYPE_WEAPON,	"Fuscina" },
	{  '9', 0x77, 0x63, SAVEGAME_ITEMTYPE_WEAPON,	"Grim Scythe" },
	{  '9',  'v',  'o', SAVEGAME_ITEMTYPE_WEAPON,	"Bill" },
	{  '9',  'w',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Naga" },
	{  '9',  'w',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Ancient Sword" },
	{  '9',  'w',  'h', SAVEGAME_ITEMTYPE_WEAPON,	"Battle Hammer" },
	{  '9',  'w',  'n', SAVEGAME_ITEMTYPE_WEAPON,	"Burnt Wand" },
	{  '9',  'w',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Divine Scepter" },
	{  '9',  'y',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Petrified Wand" },
	{  'a',  'a',  'r', SAVEGAME_ITEMTYPE_ARMOR,	"Ancient Armor" },
	{  'a',  'm',  '1', SAVEGAME_ITEMTYPE_WEAPON,	"Stag Bow" },
	{  'a',  'm',  '2', SAVEGAME_ITEMTYPE_WEAPON,	"Reflex Bow" },
	{  'a',  'm',  '4', SAVEGAME_ITEMTYPE_WEAPON,	"Maiden Pike" },
	{  'a',  'm',  '7', SAVEGAME_ITEMTYPE_WEAPON,	"Ceremonial Bow" },
	{  'a',  'm',  '9', SAVEGAME_ITEMTYPE_WEAPON,	"Ceremonial Pike" },
	{  'a',  'm',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Ceremonial Cavalin" },
	{  'a',  'm',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Grand Matron Bow" },
	{  'a',  'm',  'e', SAVEGAME_ITEMTYPE_WEAPON,	"Matriachal Pike" },
	{  'a', 0x6d, 0x75, SAVEGAME_ITEMTYPE_AMULET,	"Amulet" },
	{  'a', 0x71, 0x76, SAVEGAME_ITEMTYPE_STACK,	"Arrows" },
	{  'a', 0x78, 0x65, SAVEGAME_ITEMTYPE_WEAPON,	"Axe" },
	{  'a', 0x78, 0x66, SAVEGAME_ITEMTYPE_WEAPON,	"Hatchet Hands" },
	{  'a',  's',  's', SAVEGAME_ITEMTYPE_SIMPLE,	"Book of Skill" },
	{  'b',  'a',  '1', SAVEGAME_ITEMTYPE_ARMOR,	"Jawbone Cap" },
	{  'b',  'a',  '2', SAVEGAME_ITEMTYPE_ARMOR,	"Fanged Helm" },
	{  'b',  'a',  '3', SAVEGAME_ITEMTYPE_ARMOR,	"Horned Helm" },
	{  'b',  'a',  '4', SAVEGAME_ITEMTYPE_ARMOR,	"Assault Helm" },
	{  'b',  'a',  '5', SAVEGAME_ITEMTYPE_ARMOR,	"Avenger Guard" },
	{  'b',  'a',  '6', SAVEGAME_ITEMTYPE_ARMOR,	"Jawbone Visor" },
	{  'b',  'a',  '8', SAVEGAME_ITEMTYPE_ARMOR,	"Rage Mask" },
	{  'b',  'a',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Slayer Guard" },
	{  'b',  'a',  'e', SAVEGAME_ITEMTYPE_ARMOR,	"Conqueror Crown" },
	{  'b',  'a',  'f', SAVEGAME_ITEMTYPE_ARMOR,	"Guardian Crown" },
	{  'b',  'a',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Bardiche" },
	{  'b',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Broad Axe" },
	{  'b',  'h',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Bone Helm" },
	{  'b',  'k',  'd', SAVEGAME_ITEMTYPE_SIMPLE,	"Key to the Cairn Stones" },
	{  'b',  'k',  'f', SAVEGAME_ITEMTYPE_STWEAPON,	"Balanced Knife" },
	{  'b',  'k',  's', SAVEGAME_ITEMTYPE_SIMPLE,	"Scroll of Inifuss" },
	{  'b',  'm',  'f', SAVEGAME_ITEMTYPE_STWEAPON,	"Balanced Knife" },
	{  'b',  'l',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Blade" },
	{  'b',  'o',  'x', SAVEGAME_ITEMTYPE_SIMPLE,	"Horadric Cube" },
	{  'b',  'r',  'n', SAVEGAME_ITEMTYPE_WEAPON,	"Brandistock" },
	{  'b',  'r',  's', SAVEGAME_ITEMTYPE_ARMOR,	"Breast Plate" },
	{  'b',  's',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Broad Sword" },
	{  'b',  's',  'h', SAVEGAME_ITEMTYPE_ARMOR,	"Bone Shield" },
	{  'b',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Battle Staff" },
	{  'b',  's',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Bastard Sword" },
	{  'b',  't',  'l', SAVEGAME_ITEMTYPE_WEAPON,	"Blade Talons" },
	{  'b',  't',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Battle Axe" },
	{  'b',  'u',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Buckler" },
	{  'b',  'w',  'n', SAVEGAME_ITEMTYPE_WEAPON,	"Bone Wand" },
	{  'c',  'a',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Cap" },
	{  'c',  'b',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Composite Bow" },
	{  'c',  'e',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Cestus" },
	{  'c',  'h',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Chain Mail" },
	{  'c',  'i',  '0', SAVEGAME_ITEMTYPE_ARMOR,	"Circlet" },
	{  'c',  'i',  '1', SAVEGAME_ITEMTYPE_ARMOR,	"Coronet" },
	{  'c',  'i',  '2', SAVEGAME_ITEMTYPE_ARMOR,	"Tiara" },
	{  'c',  'i',  '3', SAVEGAME_ITEMTYPE_ARMOR,	"Diadem" },
	{  'c',  'l',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Club" },
	{  'c',  'l',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Claymore" },
	{  'c',  'l',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Claws" },
	{  'c',  'm',  '1', SAVEGAME_ITEMTYPE_CHARM,	"Small Charm" },
	{  'c',  'm',  '2', SAVEGAME_ITEMTYPE_CHARM,	"Large Charm" },
	{  'c',  'm',  '3', SAVEGAME_ITEMTYPE_CHARM,	"Grand Charm" },
	{  'c',  'q',  'v', SAVEGAME_ITEMTYPE_STACK,	"Bolts" },
	{  'c',  'r',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Crown" },
	{  'c',  'r',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Crystal Sword" },
	{  'c',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Gnarled Staff" },
	{  'd',  'g',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Dagger" },
	{  'd',  'i',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Dirk" },
	{  'd',  'r',  '1', SAVEGAME_ITEMTYPE_ARMOR,	"Wolf Head" },
	{  'd',  'r',  '2', SAVEGAME_ITEMTYPE_ARMOR,	"Hawk Helm" },
	{  'd',  'r',  '3', SAVEGAME_ITEMTYPE_ARMOR,	"Antlers" },
	{  'd',  'r',  '8', SAVEGAME_ITEMTYPE_ARMOR,	"Hunter's Guise" },
	{  'd',  'r',  'e', SAVEGAME_ITEMTYPE_ARMOR,	"Sky Spirit" },
	{  'f',  'h',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Full Helm" },
	{  'f',  'l',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Flail" },
	{  'f',  'l',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Flamberge" },
	{  'f',  'l',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Falchion" },
	{  'f',  'l',  'd', SAVEGAME_ITEMTYPE_ARMOR,	"Field Plate" },
	{  'f',  'u',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Full Plate Mail" },
	{  'g',  '3',  '3', SAVEGAME_ITEMTYPE_WEAPON,	"The Gidbinn" },
	{  'g',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Great Axe" },
	{  'g',  'h',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Great Helm" },
	{  'g',  'i',  's', SAVEGAME_ITEMTYPE_WEAPON,	"Giant Sword" },
	{  'g',  'i',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Giant Axe" },
	{  'g',  'l',  'v', SAVEGAME_ITEMTYPE_STWEAPON,	"Glaive" },
	{  'g',  'm',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Great Maul" },
	{  'g',  'p',  'l', SAVEGAME_ITEMTYPE_STWEAPON,	"Strangling Gas Potion" },
	{  'g',  'p',  'm', SAVEGAME_ITEMTYPE_STWEAPON,	"Choking Gas Potion" },
	{  'g',  'p',  's', SAVEGAME_ITEMTYPE_STWEAPON,	"Rancid Gas Potion" },
	{  'g',  's',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Grand Scepter" },
	{  'g',  's',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Great Sword" },
	{  'g',  't',  'h', SAVEGAME_ITEMTYPE_ARMOR,	"Gothic Plate" },
	{  'g',  't',  's', SAVEGAME_ITEMTYPE_ARMOR,	"Gothic Shield" },
	{  'g',  'w',  'n', SAVEGAME_ITEMTYPE_WEAPON,	"Grim Wand" },
	{  'g',  '#',  '#', SAVEGAME_ITEMTYPE_GEM,	"Gem" },
	{  'h',  'a',  'l', SAVEGAME_ITEMTYPE_WEAPON,	"Halberd" },
	{  'h',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Hand Axe" },
	{  'h',  'b',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Plated Belt" },
	{  'h',  'b',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Greaves" },
	{  'h',  'b',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Hunter's Bow" },
	{  'h',  'd',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Horadric Malus" },
	{  'h',  'f',  'h', SAVEGAME_ITEMTYPE_WEAPON,	"Hell Forge Hammer" },
	{  'h',  'g',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Gauntlets" },
	{  'h',  'l',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Hard Leather Armor" },
	{  'h',  'l',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Helm" },
	{  'h',  'p',  '1', SAVEGAME_ITEMTYPE_POTION,	"Minor Healing Potion" },
	{  'h',  'p',  '2', SAVEGAME_ITEMTYPE_POTION,	"Light Healing Potion" },
	{  'h',  'p',  '3', SAVEGAME_ITEMTYPE_POTION,	"Healing Potion" },
	{  'h',  'p',  '4', SAVEGAME_ITEMTYPE_POTION,	"Greater Healing Potion" },
	{  'h',  'p',  '5', SAVEGAME_ITEMTYPE_POTION,	"Super Healing Potion" },
	{  'h',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Horadric Staff" },
	{  'h',  'x',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Heavy Crossbow" },
	{  'i',  'b',  'k', SAVEGAME_ITEMTYPE_TOME,	"Tome of Identify" },
	{  'i',  's',  'c', SAVEGAME_ITEMTYPE_TOME,	"Scroll of Identify" },
	{  'j',  '3',  '4', SAVEGAME_ITEMTYPE_SIMPLE,	"Jade Figurine" },
	{  'j',  'a',  'v', SAVEGAME_ITEMTYPE_STWEAPON,	"Javelin" },
	{  'j',  'e',  'w', SAVEGAME_ITEMTYPE_JEWEL,	"Jewel" },
	{  'k',  'e',  'y', SAVEGAME_ITEMTYPE_STACK,	"Keys" },
	{  'k',  'i',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Kite Shield" },
	{  'k',  'r',  'i', SAVEGAME_ITEMTYPE_WEAPON,	"Kris" },
	{  'k',  't',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Katar" },
	{  'l',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Large Axe" },
	{  'l',  'b',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Large Battle Bow" },
	{  'l',  'b',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Sash" },
	{  'l',  'b',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Boots" },
	{  'l',  'b',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Long Bow" },
	{  'l',  'e',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Leather Armor" },
	{  'l',  'e',  'g', SAVEGAME_ITEMTYPE_WEAPON,	"Wirt's Leg" },
	{  'l',  'g',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Leather Gloves" },
	{  'l',  'r',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Large Shield" },
	{  'l',  's',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Long Sword" },
	{  'l',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Long Staff" },
	{  'l',  't',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Light Plate" },
	{  'l',  'w',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Long War Bow" },
	{  'l',  'x',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Light Crossbow" },
	{  'm',  'a',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Mace" },
	{  'm',  'a',  'u', SAVEGAME_ITEMTYPE_WEAPON,	"Maul" },
	{  'm',  'b',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Belt" },
	{  'm',  'b',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Chain Boots" },
	{  'm',  'g',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Chain Gloves" },
	{  'm',  'p',  '1', SAVEGAME_ITEMTYPE_POTION,	"Minor Mana Potion" },
	{  'm',  'p',  '2', SAVEGAME_ITEMTYPE_POTION,	"Light Mana Potion" },
	{  'm',  'p',  '3', SAVEGAME_ITEMTYPE_POTION,	"Mana Potion" },
	{  'm',  'p',  '4', SAVEGAME_ITEMTYPE_POTION,	"Greater Mana Potion" },
	{  'm',  'p',  '5', SAVEGAME_ITEMTYPE_POTION,	"Super Mana Potion" },
	{  'm',  'p',  'i', SAVEGAME_ITEMTYPE_WEAPON,	"Military Pick" },
	{  'm',  's',  'f', SAVEGAME_ITEMTYPE_WEAPON,	"Staff of Kings" },
	{  'm',  's',  'k', SAVEGAME_ITEMTYPE_ARMOR,	"Mask" },
	{  'm',  's',  's', SAVEGAME_ITEMTYPE_SIMPLE,	"Mephisto's Soulstone" },
	{  'm',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Morning Star" },
	{  'm',  'x',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Crossbow" },
	{  'n',  'e',  '1', SAVEGAME_ITEMTYPE_ARMOR,	"Preserved Head" },
	{  'n',  'e',  '2', SAVEGAME_ITEMTYPE_ARMOR,	"Zombie Head" },
	{  'n',  'e',  '3', SAVEGAME_ITEMTYPE_ARMOR,	"Unraveller Head" },
	{  'n',  'e',  '4', SAVEGAME_ITEMTYPE_ARMOR,	"Gargoyle Head" },
	{  'n',  'e',  '5', SAVEGAME_ITEMTYPE_ARMOR,	"Demon Head" },
	{  'n',  'e',  '6', SAVEGAME_ITEMTYPE_ARMOR,	"Minion Skull" },
	{  'n',  'e',  '7', SAVEGAME_ITEMTYPE_ARMOR,	"Hellspawn Skull" },
	{  'n',  'e',  '8', SAVEGAME_ITEMTYPE_ARMOR,	"Overseer Skull" },
	{  'n',  'e',  '9', SAVEGAME_ITEMTYPE_ARMOR,	"Cantor Trophy" },
	{  'n',  'e',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Heirophant Trophy" },
	{  'o',  'b',  '1', SAVEGAME_ITEMTYPE_WEAPON,	"Eagle Orb" },
	{  'o',  'b',  '2', SAVEGAME_ITEMTYPE_WEAPON,	"Sacred Globe" },
	{  'o',  'b',  '3', SAVEGAME_ITEMTYPE_WEAPON,	"Smoked Sphere" },
	{  'o',  'b',  '4', SAVEGAME_ITEMTYPE_WEAPON,	"Clasped Orb" },
	{  'o',  'b',  'a', SAVEGAME_ITEMTYPE_WEAPON,	"Swirling Crystal" },
	{  'o',  'p',  'l', SAVEGAME_ITEMTYPE_STWEAPON,	"Fulminating Potion" },
	{  'o',  'p',  'm', SAVEGAME_ITEMTYPE_STWEAPON,	"Exploding Potion" },
	{  'p',  'a',  '1', SAVEGAME_ITEMTYPE_ARMOR,	"Targe" },
	{  'p',  'a',  '2', SAVEGAME_ITEMTYPE_ARMOR,	"Rondache" },
	{  'p',  'a',  '3', SAVEGAME_ITEMTYPE_ARMOR,	"Heraldic Shield" },
	{  'p',  'a',  '4', SAVEGAME_ITEMTYPE_ARMOR,	"Aerin Shield" },
	{  'p',  'a',  '5', SAVEGAME_ITEMTYPE_ARMOR,	"Crown Shield" },
	{  'p',  'a',  '6', SAVEGAME_ITEMTYPE_ARMOR,	"Akaran Targe" },
	{  'p',  'a',  '7', SAVEGAME_ITEMTYPE_ARMOR,	"Akaran Rondache" },
	{  'p',  'a',  '8', SAVEGAME_ITEMTYPE_ARMOR,	"Protector Shield" },
	{  'p',  'a',  '9', SAVEGAME_ITEMTYPE_ARMOR,	"Gilded Shield" },
	{  'p',  'a',  'e', SAVEGAME_ITEMTYPE_ARMOR,	"Zakarum Shield" },
	{  'p',  'a',  'f', SAVEGAME_ITEMTYPE_ARMOR,	"Vortex Shield" },
	{  'p',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Poleaxe" },
	{  'p',  'i',  'k', SAVEGAME_ITEMTYPE_WEAPON,	"Pike" },
	{  'p',  'l',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Plate Mail" },
	{  'q',  'b',  'r', SAVEGAME_ITEMTYPE_SIMPLE,	"Khalim's Brain" },
	{  'q',  'e',  'y', SAVEGAME_ITEMTYPE_SIMPLE,	"Khalim's Eye" },
	{  'q',  'h',  'r', SAVEGAME_ITEMTYPE_SIMPLE,	"Khalim's Heart" },
	{  'q',  'u',  'i', SAVEGAME_ITEMTYPE_ARMOR,	"Quilted Armor" },
	{  'r',  '0',  '#', SAVEGAME_ITEMTYPE_RUNE,	"Rune" },
	{  'r',  '1',  '#', SAVEGAME_ITEMTYPE_RUNE,	"Rune" },
	{  'r',  '2',  '#', SAVEGAME_ITEMTYPE_RUNE,	"Rune" },
	{  'r',  '3',  '#', SAVEGAME_ITEMTYPE_RUNE,	"Rune" },
	{  'r',  'i',  'n', SAVEGAME_ITEMTYPE_RING,	"Ring" },
	{  'r',  'n',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Ring Mail" },
	{  'r',  'v',  'l', SAVEGAME_ITEMTYPE_POTION,	"Full Rejuvination Potion" },
	{  'r',  'v',  's', SAVEGAME_ITEMTYPE_POTION,	"Rejuvination Potion" },
	{  'r',  'x',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Repeating Crossbow" },
	{  's',  'b',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Short Battle Bow" },
	{  's',  'b',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Sabre" },
	{  's',  'b',  'w', SAVEGAME_ITEMTYPE_WEAPON,	"Short Bow" },
	{  's',  'c',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Scale Mail" },
	{  's',  'c',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"Scimitar" },
	{  's',  'c',  'p', SAVEGAME_ITEMTYPE_WEAPON,	"Scepter" },
	{  's',  'c',  'y', SAVEGAME_ITEMTYPE_WEAPON,	"Scythe" },
	{  's',  'k',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Skull Cap" },
	{  's',  'k',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Scissors Katar" },
	{  's',  'k',  '#', SAVEGAME_ITEMTYPE_SKULL,	"Skull" },
	{  's',  'm',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Small Shield" },
	{  's',  'p',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"Spiked Club" },
	{  's',  'p',  'k', SAVEGAME_ITEMTYPE_ARMOR,	"Spiked Shield" },
	{  's',  'p',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Splint Mail" },
	{  's',  'p',  'r', SAVEGAME_ITEMTYPE_WEAPON,	"Spear" },
	{  's',  'p',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Spetum" },
	{  's',  's',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Short Sword" },
	{  's',  's',  'p', SAVEGAME_ITEMTYPE_STWEAPON,	"Short Spear" },
	{  's',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"Short Staff" },
	{  's',  't',  'u', SAVEGAME_ITEMTYPE_ARMOR,	"Studded Leather" },
	{  's',  'w',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Short War Bow" },
	{  't',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"Throwing Axe" },
	{  't',  'b',  'k', SAVEGAME_ITEMTYPE_TOME,	"Tome of Town Portal" },
	{  't',  'b',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Heavy Belt" },
	{  't',  'b',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Light Plated Boots" },
	{  't',  'g',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Light Gauntlets" },
	{  't',  'k',  'f', SAVEGAME_ITEMTYPE_WEAPON,	"Throwing Knife" },
	{  't',  'o',  'w', SAVEGAME_ITEMTYPE_ARMOR,	"Tower Shield" },
	{  't',  'r',  'i', SAVEGAME_ITEMTYPE_WEAPON,	"Trident" },
	{  't',  's',  'c', SAVEGAME_ITEMTYPE_SIMPLE,	"Scroll of Town Portal" },
	{  't',  's',  'p', SAVEGAME_ITEMTYPE_SIMPLE,	"Throwing Spear" },
	{  'u',  'a',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Shako" },
	{  'u',  'a',  'r', SAVEGAME_ITEMTYPE_ARMOR,	"Sacred Armor" },
	{  'u',  'c',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Loricated Mail" },
	{  'u',  'h',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Colossus Belt" },
	{  'u',  'm',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Mithril Coil" },
	{  'u',  'u',  'i', SAVEGAME_ITEMTYPE_ARMOR,	"Dusk Shroud" },
	{  'u',  'p',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Balrog Skin" },
	{  'u',	 'h',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Ogre Gauntlets" },
	{  'u',	 'h',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Spired Helm" },
	{  'u',	 'h',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Boneweave" },
	{  'u',	 'h',  '9', SAVEGAME_ITEMTYPE_ARMOR,	"Bone Visage" },
	{  'u',	 'l',  'd', SAVEGAME_ITEMTYPE_ARMOR,	"Kraken Shell" },
	{  'u',	 'l',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Bramble Mitts" },
	{  'u',	 'l',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Hellforge Plate" },
	{  'u',	 'm',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Luna" },
	{  'u',	 'o',  'w', SAVEGAME_ITEMTYPE_ARMOR,	"Aegis" },
	{  'u',	 'r',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Corona" },
	{  'u',	 't',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Mirrored Boots" },
	{  'u',	 't',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Troll Belt" },
	{  'u',	 't',  'h', SAVEGAME_ITEMTYPE_ARMOR,	"Lacquered Plate" },
	{  'u',	 't',  's', SAVEGAME_ITEMTYPE_ARMOR,	"Ward" },
	{  'u',	 't',  'u', SAVEGAME_ITEMTYPE_ARMOR,	"Wire Fleece" },
	{  'u',	 'u',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Shadow Plate" },
	{  'u',	 'v',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Vampirefang Belt" },
	{  'v',  'b',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Light Belt" },
	{  'v',  'b',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Heavy Boots" },
	{  'v',  'g',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Heavy Gloves" },
	{  'v',  'i',  'p', SAVEGAME_ITEMTYPE_UNKNOWN,	"Amulet of the Vipermagi" },
	{  'v',  'o',  'u', SAVEGAME_ITEMTYPE_WEAPON,	"Voulge" },
	{  'v',  'p',  's', SAVEGAME_ITEMTYPE_POTION,	"Stamina Potion" },
	{  'w',  'a',  'x', SAVEGAME_ITEMTYPE_WEAPON,	"War Axe" },
	{  'w',  'm',  's', SAVEGAME_ITEMTYPE_POTION,	"Thawing Potion" },
	{  'w',  'h',  'm', SAVEGAME_ITEMTYPE_WEAPON,	"War Hammer" },
	{  'w',  'n',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"Wand" },
	{  'w',  'r',  'b', SAVEGAME_ITEMTYPE_WEAPON,	"Wrist Blade" },
	{  'w',  's',  'c', SAVEGAME_ITEMTYPE_WEAPON,	"War Scythe" },
	{  'w',  's',  'd', SAVEGAME_ITEMTYPE_WEAPON,	"War Sword" },
	{  'w',  's',  'p', SAVEGAME_ITEMTYPE_WEAPON,	"War Scepter" },
	{  'w',  's',  't', SAVEGAME_ITEMTYPE_WEAPON,	"War Staff" },
	{  'x',  'a',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"War Hat" },
	{  'x',  'a',  'r', SAVEGAME_ITEMTYPE_ARMOR,	"Ornate Plate" },
	{  'x',  'c',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Tigulated Mail" },
	{  'x',  'e',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Serpentskin Armor" },
	{  'x',  'h',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"War Boots" },
	{  'x',  'h',  '9', SAVEGAME_ITEMTYPE_ARMOR,	"Grim Helm" },
	{  'x',  'h',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"War Gauntlets" },
	{  'x',  'h',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Basinet" },
	{  'x',  'h',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Winged Helm" },
	{  'x',  'h',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Mesh Armor" },
	{  'x',  'i',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Dragon Shield" },
	{  'x',  'k',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Sallet" },
	{  'x',  'l',  'a', SAVEGAME_ITEMTYPE_ARMOR,	"Demonhide Armor" },
	{  'x',  'l',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Demonhide Boots" },
	{  'x',  'l',  'd', SAVEGAME_ITEMTYPE_ARMOR,	"Sharktooth Armor" },
	{  'x',  'l',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Demonhide Gloves" },
	{  'x',  'l',  'm', SAVEGAME_ITEMTYPE_ARMOR,	"Casque" },
	{  'x',  'l',  't', SAVEGAME_ITEMTYPE_ARMOR,	"Templar Coat" },
	{  'x',  'm',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Mesh Boots" },
	{  'x',  'm',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Round Shield" },
	{  'x',  'm',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Heavy Bracers" },
	{  'x',  'n',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Linked Mail" },
	{  'x',  'o',  'w', SAVEGAME_ITEMTYPE_ARMOR,	"Pavise" },
	{  'x',  'p',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Russet Armor" },
	{  'x',  'p',  'k', SAVEGAME_ITEMTYPE_ARMOR,	"Barbed Shield" },
	{  'x',  'r',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Scutum" },
	{  'x',  'r',  'n', SAVEGAME_ITEMTYPE_ARMOR,	"Grand Crown" },
	{  'x',  'r',  's', SAVEGAME_ITEMTYPE_ARMOR,	"Cuirass" },
	{  'x',  's',  'h', SAVEGAME_ITEMTYPE_ARMOR,	"Grim Shield" },
	{  'x',  's',  'k', SAVEGAME_ITEMTYPE_ARMOR,	"Death Mask" },
	{  'x',  't',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Battle Boots" },
	{  'x',  't',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Battle Gauntlets" },
	{  'x',  't',  'h', SAVEGAME_ITEMTYPE_ARMOR,	"Embossed Plate" },
	{  'x',  't',  'p', SAVEGAME_ITEMTYPE_ARMOR,	"Mage Plate" },
	{  'x',  't',  's', SAVEGAME_ITEMTYPE_ARMOR,	"Ancient Shield" },
	{  'x',  't',  'u', SAVEGAME_ITEMTYPE_ARMOR,	"Trellised Armor" },
	{  'x',  'u',  'c', SAVEGAME_ITEMTYPE_ARMOR,	"Defender" },
	{  'x',  'u',  'i', SAVEGAME_ITEMTYPE_ARMOR,	"Ghost Armor" },
	{  'x',  'u',  'l', SAVEGAME_ITEMTYPE_ARMOR,	"Chaos Armor" },
	{  'x',  'v',  'g', SAVEGAME_ITEMTYPE_ARMOR,	"Sharkskin Gloves" },
	{  'x',  'v',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Sharkskin Boots" },
	{  'x',  'y',  'z', SAVEGAME_ITEMTYPE_SIMPLE,	"Potion of Life" },
	{  'y',  'p',  's', SAVEGAME_ITEMTYPE_POTION,	"Antidote Potion" },
	{  'y',  'w',  'n', SAVEGAME_ITEMTYPE_WEAPON,	"Yew Wand" },
	{  'z',  'h',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"War Belt" },
	{  'z',  'l',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Demonhide Sash" },
	{  'z',  'm',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Mesh Belt" },
	{  'z',  'v',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Sharkskin Belt" },
	{  'z',  't',  'b', SAVEGAME_ITEMTYPE_ARMOR,	"Battle Belt" },
	{  '#',  '#',  '#', SAVEGAME_ITEMTYPE_UNKNOWN,	NULL }
    };

// savegame_setitemsdecl[] are all set items we know of so far
struct SAVEGAME_SETITEM_DECL savegame_setitemsdec[] = {
	// Civerb's Vestments
	{ 0x00,  'g',  's',  'c',  "Civerb's Cudgel" },
	{ 0x00,  'a',  'm',  'u',  "Civerb's Icon" },
	{ 0x00,  'l',  'r',  'g',  "Civerb's Ward" },
	// Hsarus' Defense
	{ 0x01,  'b',  'u',  'c',  "Hsarus' Iron Fist" },
	{ 0x01,  'm',  'b',  'l',  "Hsarus' Iron Stay" },
	{ 0x01,  'm',  'b',  't',  "Hsarus' Iron Heel" },
	// Cleglaw's Brace
	{ 0x02,  'l',  's',  'd',  "Cleglaw's Tooth" },
	{ 0x02,  'm',  'g',  'l',  "Cleglaw's Pincers" },
	{ 0x02,  's',  'm',  'l',  "Cleglaw's Claw" },
	// Iratha's Finery"
	{ 0x03,  'c',  'r',  'd',  "Iratha's Coil" },
	{ 0x03,  'a',  'm',  'u',  "Iratha's Collar" },
	{ 0x03,  't',  'b',  'l',  "Iratha's Cord" },
	{ 0x03,  't',  'g',  'l',  "Iratha's Cuff" },
	// Isenhart's Armory
	{ 0x04,  'b',  's',  'd',  "Isenhart's Lightbrand" },
	{ 0x04,  'f',  'h',  'l',  "Isenhart's Horns" },
	{ 0x04,  'b',  'r',  's',  "Isenhart's Case" },
	{ 0x04,  'g',  't',  's',  "Isenhart's Parry" },
	// Vidala's Rig
	{ 0x05,  'l',  'b',  'b',  "Vidala's Rig" },
	{ 0x05,  'l',  'e',  'a',  "Vidala's Ambush" },
	{ 0x05,  't',  'b',  't',  "Vidala's Fetlock" },
	{ 0x05,  'a',  'm',  'u',  "Vidala's Snare" },
	// Milabrega's Regalia
	{ 0x06,  'c',  'r',  'n',  "Milabrega's Diadem" },
	{ 0x06,  'a',  'a',  'r',  "Milabrega's Robe" },
	{ 0x06,  'k',  'i',  't',  "Milabrega's Orb" },
	{ 0x06,  'w',  's',  'p',  "Milabrega's Rod" },
	// Cathan's Traps
	{ 0x07,  'm',  's',  'k',  "Cathan's Visage" },
	{ 0x07,  'c',  'h',  'n',  "Cathan's Mesh" },
	{ 0x07,  'b',  's',  't',  "Cathan's Rule" },
	{ 0x07,  'a',  'm',  'u',  "Cathan's Sigil" },
	{ 0x07,  'r',  'i',  'n',  "Cathan's Seal" },
	// Tancred's Battlegear
	{ 0x08,  'b',  'h',  'm',  "Tancred's Skull" },
	{ 0x08,  'f',  'u',  'l',  "Tancred's Spine" },
	{ 0x08,  'l',  'b',  't',  "Tancred's Hobnails" },
	{ 0x08,  'm',  'p',  'i',  "Tancred's Crowbill" },
	{ 0x08,  'a',  'm',  'u',  "Tancred's Weird" },
	// Sigon's Complete Steel
	{ 0x09,  'g',  'h',  'm',  "Sigon's Visor" },
	{ 0x09,  'g',  't',  'h',  "Sigon's Shelter" },
	{ 0x09,  'h',  'b',  't',  "Sigon's Sabot" },
	{ 0x09,  't',  'o',  'w',  "Sigon's Shield" },
	{ 0x09,  'h',  'b',  'l',  "Sigon's Wrap" },
	{ 0x09,  'h',  'g',  'l',  "Sigon's Gage" },
	// Infernal Tools
	{ 0x0a,  'c',  'a',  'p',  "Infernal Cranium" },
	{ 0x0a,  't',  'b',  'l',  "Infernal Sign" },
	{ 0x0a,  'g',  'w',  'n',  "Infernal Torch" },
	// Beserker's Arsenal
	{ 0x0b,  'h',  'l',  'm',  "Beserker's Headgear" },
	{ 0x0b,  's',  'p',  'l',  "Beserker's Hauberk" },
	{ 0x0b,  '2',  'a',  'x',  "Beserker's Hatchet" },
	// Death's Disguise
	{ 0x0c,  'w',  's',  'd',  "Death's Touch" },
	{ 0x0c,  'l',  'g',  'l',  "Death's Hand" },
	{ 0x0c,  'l',  'b',  'l',  "Death's Guard" },
	// Angelic Raiment
	{ 0x0d,  'r',  'n',  'g',  "Angelic Mantle" },
	{ 0x0d,  's',  'b',  'r',  "Angelic Sickle" },
	{ 0x0d,  'r',  'i',  'n',  "Angelic Halo" },
	{ 0x0d,  'a',  'm',  'u',  "Angelic Wings" },
	// Arctic Gear
	{ 0x0e,  'q',  'u',  'i',  "Artic Furs" },
	{ 0x0e,  'v',  'b',  'l',  "Artic Binding" },
	{ 0x0e,  't',  'g',  'l',  "Artic Mitts" },
	{ 0x0e,  's',  'w',  'b',  "Artic Horn" },
	// Arcanna's Tricks
	{ 0x0f,  's',  'k',  'p',  "Arcanna's Head" },
	{ 0x0f,  'l',  't',  'p',  "Arcanna's Flesh" },
	{ 0x0f,  'w',  's',  't',  "Arcanna's Deathwand" },
	{ 0x0f,  'a',  'm',  'u',  "Arcanna's Sign" },
	// Natalya's Odium
	{ 0x10,  'x',  'h',  '9',  "Natalya's Totem" },
	{ 0x10,  '7',  'q',  'r',  "Natalya's Mark" },
	{ 0x10,  'u',  'c',  'l',  "Natalya's Shadow" },
	{ 0x10,  'x',  'm',  'b',  "Natalya's Soul" },
	// Aldur's Watchtower
	{ 0x11,  'd',  'r',  '8',  "Aldur's Stony Gaze" },
	{ 0x11,  'x',  't',  'b',  "Aldur's Advance" },
	{ 0x11,  'u',  'u',  'l',  "Aldur's Deception" },
	{ 0x11,  '9',  'm',  't',  "Aldur's Rhythm" },
	// Immortal King
	{ 0x12,  'b',  'a',  '5',  "Immortal King's Will" },
	{ 0x12,  '7',  'm',  '7',  "Immortal King's Stone Crusher" },
	{ 0x12,  'u',  'a',  'r',  "Immortal King's Soul Cage" },
	{ 0x12,  'z',  'h',  'b',  "Immortal King's Detail" },
	{ 0x12,  'x',  'h',  'g',  "Immortal King's Forge" },
	{ 0x12,  'x',  'h',  'b',  "Immortal King's War Boots" },
	// Tal Rasha's Wrappings
	{ 0x13,  'o',  'b',  'a',  "Tal Rasha's Lidless Eye" },
	{ 0x13,  'x',  's',  'k',  "Tal Rasha's Horadric Crest" },
	{ 0x13,  'u',  't',  'h',  "Tal Rasha's Guardianship" },
	{ 0x13,  'z',  'm',  'b',  "Tal Rasha's Fine-Spun Cloth" },
	{ 0x13,  'a',  'm',  'u',  "Tal Rasha's Adjudication" },
	// Griswold's Legacy
	{ 0x14,  'x',  'a',  'r',  "Griswold's Heart" },
	{ 0x14,  'u',  'r',  'n',  "Griswold's Valor" },
	{ 0x14,  '7',  'w',  's',  "Griswold's Redemption" },
	{ 0x14,  'p',  'a',  'f',  "Griswold's Honor" },
	// Trang-Oul's Avatar
	{ 0x15,  'u',  'h',  '9',  "Trang-Oul's Visage" },
	{ 0x15,  'x',  'u',  'l',  "Trang-Oul's Scales" },
	{ 0x15,  'n',  'e',  '9',  "Trang-Oul's Wing" },
	{ 0x15,  'u',  't',  'c',  "Trang-Oul's Girth" },
	{ 0x15,  'x',  'm',  'g',  "Trang-Oul's Claws" },
	// M'avina's Battle Hymn
	{ 0x16,  'c',  'i',  '3',  "M'avina's True Sight" },
	{ 0x16,  'a',  'm',  'c',  "M'avina's Caster" },
	{ 0x16,  'u',  'l',  'd',  "M'avina's Embrace" },
	{ 0x16,  'x',  't',  'g',  "M'avina's Icy Clutch" },
	{ 0x16,  'z',  'v',  'b',  "M'avina's Tenet" },
	// The Disciple
	{ 0x17,  'a',  'm',  'u',  "Telling of Beads" },
	{ 0x17,  'u',  'l',  'g',  "Laying of Hands" },
	{ 0x17,  'u',  'u',  'i',  "Dark Adherent" },
	{ 0x17,  'x',  'l',  'b',  "Rite of Passage" },
	{ 0x17,  'u',  'm',  'c',  "Mithril Coil" },
	// Heaven's Brethren
	{ 0x18,  'x',  'r',  's',  "Curass" },
	{ 0x18,  '7',  'm',  'a',  "Reinforced Mace" },
	{ 0x18,  'u',  't',  's',  "Dangoon's Teaching" },
	{ 0x18,  'u',  'h',  'm',  "Ondal's Almighty" },
	// Orphan's Call
	{ 0x19,  'x',  'h',  'm',  "Guillaume's Face" },
	{ 0x19,  'x',  'm',  'l',  "Whitstan's Guard" },
	{ 0x19,  'x',  'v',  'g',  "Magnus' Skin" },
	{ 0x19,  'z',  't',  'b',  "Wilhelm's Pride" },
	// Hwanin's Majesty
	{ 0x1a,  'x',  'r',  'n',  "Hwanin's Splendor" },
	{ 0x1a,  '9',  'v',  'o',  "Hwanin's Justice" },
	{ 0x1a,  'x',  'c',  'l',  "Hwanin's Refuge" },
	{ 0x1a,  'm',  'b',  'l',  "Hwanin's Blessing" },
	// Sazabi's Grand Tribute
	{ 0x1b,  'x',  'h',  'l',  "Sazabi's Mental Sheath" },
	{ 0x1b,  '7',  'l',  's',  "Sazabi's Cobalt Redeemer" },
	{ 0x1b,  'u',  'p',  'l',  "Sazabi's Ghost Liberator" },
	// Bul-Kathos' Children
	{ 0x1c,  '7',  'g',  'd',  "Bul-Kathos' Sacred Charge" },
	{ 0x1c,  '7',  'w',  'd',  "Bul-Kathos' Tribal Guardian" },
	// Cow King's Leathers
	{ 0x1d,  'x',  'a',  'p',  "Cow King's Horns" },
	{ 0x1d,  's',  't',  'u',  "Cow King's Hide" },
	{ 0x1d,  'v',  'b',  't',  "Cow King's Hooves" },
	// Naj's Ancient Vestige
	{ 0x1e,  'c',  'i',  '0',  "Naj's Circlet" },
	{ 0x1e,  'u',  'l',  't',  "Naj's Light Plate" },
	{ 0x1e,  '6',  'c',  's',  "Naj's Puzzler" },
	// Sander's Folly
	{ 0x1f,  'c',  'a',  'p',  "Sander's Paragon" },
	{ 0x1f,  'b',  'w',  'n',  "Sander's Superstition" },
	{ 0x1f,  'v',  'g',  'l',  "Sander's Taboo" },
	{ 0x1f,  'v',  'b',  't',  "Sander's Riprap" },
	// the end
	{    0,  '#',  '#',  '#',  NULL }
    };

// savegame_rarename[] are the names of the rare items
const char* const savegame_rarename[] = {
  "" /* unused */,
  /* Suffixes */
  "Bite",	"Scratch",	"Scalpel",	"Fang",
  "Gutter",	"Thirst",	"Razor",	"Scythe",
  "Edge",	"Saw",		"Splitter",	"Cleaver",
  "Sever",	"Sunder",	"Rend",		"Mangler",
  "Slayer",	"Reaver",	"Spawn",	"Gnash",
  "Star",	"Blow",		"Smasher",	"Bane",
  "Crusher",	"Breaker",	"Grinder",	"Crack",
  "Mallet",	"Knell",	"Lance",	"Spike",
  "Impaler",	"Skewer",	"Prod",		"Scourge",
  "Wand",	"Wrack",	"Barb",		"Needle",
  "Dart",	"Bolt",		"Quarrel",	"Fletch",
  "Flight",	"Nock",		"Horn",		"Stinger",
  "Quill",	"Goad",		"Branch",	"Spire",
  "Song",	"Call",		"Cry",		"Spell",
  "Chant",	"Weaver",	"Gnarl",	"Visage",
  "Crest",	"Circlet",	"Veil",		"Hood",
  "Mask",	"Brow",		"Casque",	"Visor",
  "Cowl",	"Hide",		"Pelt",		"Carapace",
  "Coat",	"Wrap",		"Suit",		"Cloak",
  "Shroud",	"Jack",		"Mantle",	"Guard",
  "Badge",	"Rock",		"Aegis",	"Ward",
  "Tower",	"Shield",	"Wing",		"Mark",
  "Emblem",	"Hand",		"Fist",		"Claw",
  "Clutches",	"Grip",		"Grasp",	"Hold",
  "Touch",	"Finger",	"Knuckle",	"Shank",
  "Spur",	"Tread",	"Stalker",	"Greave",
  "Blazer",	"Nails",	"Trample",	"Brogues",
  "Track",	"Slippers",	"Clasp",	"Buckle",
  "Harness",	"Lock",		"Fringe",	"Winding",
  "Chain",	"Strap",	"Lash",		"Cord",
  "Knot",	"Circle",	"Loop",		"Eye",
  "Turn",	"Spiral",	"Coil",		"Gyre",
  "Band",	"Whorl",	"Talisman",	"Heart",
  "Noose",	"Necklace",	"Collar",	"Beads",
  "Torc",	"Gorget",	"Scarab",	"Wood",
  "Brand",	"Bludgeon",	"Cudgel",	"Loom",
  "Harp",	"Master",	"Barri",	"Hew",
  "Crook",	"Mar",		"Shell",	"Stake",
  "Picket",	"Pale",		"Flange",
  /* Prefixes */
  "Beast",	"Eagle",	"Raven",	"Viper",
  "Ghoul",	"Skull",	"Blood",	"Dread",
  "Doom",	"Grim",		"Bone",		"Death",
  "Shadow",	"Storm",	"Rune",		"Plague",
  "Stone",	"Wraith",	"Spirit",	"Storm",
  "Demon",	"Cruel",	"Empyrian",	"Bramble",
  "Pain",	"Loath",	"Glyph",	"Imp",
  "Fiend",	"Hailstone",	"Gale",		"Dire",
  "Soul",	"Brimstone",	"Corpse",	"Carrion",
  "Armageddon",	"Havoc",	"Bitter",	"Entropy",
  "Chaos",	"Order",	"Rule",		"Warp",
  "Rift",	"Corruption",
  /* Unused */
  " 202", " 203", " 204", " 205", " 206", " 207", " 208", " 209",
  " 210", " 211", " 212", " 213", " 214", " 215", " 216", " 217",
  " 218", " 219", " 220", " 221", " 222", " 223", " 224", " 225",
  " 226", " 227", " 228", " 229", " 230", " 231", " 232", " 233",
  " 234", " 235", " 236", " 237", " 238", " 239", " 240", " 241",
  " 242", " 243", " 244", " 245", " 246", " 247", " 248", " 249",
  " 250", " 251", " 252", " 253", " 254", " 255",
};

struct sg_magical_modifiers_t {
  unsigned short id;		/* 9 bits */
  unsigned char data_len;	/* number of bits in the data field */
  unsigned char data2_len;	/* some magic properties have 2 data fields */
  short		bias;	    /* adjustment of stored value vs. screen value */
  short		bias2;
  const char *	name;		/* written name w/ value in printf format */
};

const struct sg_magical_modifiers_t sg_magical_modifiers[] = {
  { 0, 7, 0, 32, 0, "+%d to Strength" },
  { 1, 7, 0, 32, 0, "+%d to Energy" },
  { 2, 7, 0, 32, 0, "+%d to Dexterity" },
  { 3, 7, 0, 32, 0, "+%d to Vitality" },
  { 7, 8, 0, 32, 0, "+%d to Life" },
  { 9, 8, 0, 32, 0, "+%d to Mana" },
  { 11, 8, 0, 32, 0, "+%d to Maximum Stamina" },
  { 16, 9, 0, 0, 0, "+%d%% Enhanced Defense" },
  { 17, 9, 9, 0, 0, "+%d%% Enhanced Damage" },
  { 19, 10, 0, 0, 0, "+%d to Attack Rating" },
  { 20, 6, 0, 0, 0, "%d%% Increased Chance of Blocking" },
  { 21, 6, 0, 0, 0, "+%d to Minimum (one-handed?) Damage" },
  { 22, 7, 0, 0, 0, "+%d to Maximum (one-handed?) Damage" },
  { 23, 6, 0, 0, 0, "+%d to Minimum (two-handed?) Damage" },
  { 24, 7, 0, 0, 0, "+%d to Maximum (two-handed?) Damage" },
  { 27, 8, 0, 0, 0, "Regenerate Mana %d%%" },
  { 28, 8, 0, 0, 0, "Heal Stamina %d%%" },
  { 31, 10, 0, 10, 0, "+%d Defense" },
  { 32, 8, 0, 0, 0, "+%d Defense vs. Missile" },
  { 33, 8, 0, 0, 0, "+%d Defense vs. Melee" },
  { 34, 6, 0, 0, 0, "Damage Reduced by %d" },
  { 35, 6, 0, 0, 0, "Magic Damage Reduced by %d" },
  { 36, 8, 0, 0, 0, "Magic Damage Reduced by %d%%" },		// [RS] NEW!
  { 37, 8, 0, 0, 0, "Magic Resist %d%%" },
  { 39, 8, 0, 0, 0, "Fire Resist +%d%%" },
  { 40, 5, 0, 0, 0, "+%d%% to Maximum Fire Resist" },
  { 41, 8, 0, 0, 0, "Lightning Resist +%d%%" },
  { 42, 5, 0, 0, 0, "+%d%% to Maximum Lightning Resist" },
  { 43, 8, 0, 0, 0, "Cold Resist +%d%%" },
  { 44, 5, 0, 0, 0, "+%d%% to Maximum Cold Resist" },
  { 45, 8, 0, 0, 0, "Poison Resist +%d%%" },
  { 46, 5, 0, 0, 0, "+%d%% to Maximum Poison Resist" },
  { 48, 8, 8, 0, 0, "Adds %d-%d fire damage" },
  { 49, 8, 0, 0, 0, "+%d to Maximum Fire Damage" },		// [RS] NEW!
  { 50, 6, 9, 0, 0, "Adds %d-%d Lightning Damage" },
  { 54, 6, 16, 0, 0, "Adds %d-%d cold damage over %d seconds"  },
  { 57, 18, 8, 0, 0, "%d-%d poison damage over %d seconds" },
  { 60, 7, 0, 0, 0, "%d%% Life stolen per hit" },
  { 62, 7, 0, 0, 0, "%d%% Mana stolen per hit" },
  // [RS] Can't get the bottom values right
  // { 73, 8, 8, 0,  0, "Adds %d-%d Magic Damage" },		// [RS] NEW!
  { 74, 6, 0, 30, 0, "Replenish Life +%d" },
  { 75, 7, 0, 20, 0, "Increase Maximum Durability %d%%" },
  { 77, 6, 0, 10, 0, "Increase Maximum Mana %d%%" },
  { 78, 7, 0, 0, 0, "Attacker Takes Damage of %d" },
  { 79, 9, 0, 100, 0, "%d%% Extra Gold from Monsters" },
  { 80, 8, 0, 100, 0, "%d%% Better Chance of Getting Magic Items" },
  { 81, 7, 0, 0, 0, "Knockback" },
  { 83, 3, 0, 0, 0, "+%d to Amazon Skill Levels" },
  { 84, 3, 0, 0, 0, "+%d to Paladin Skill Levels" },
  { 85, 3, 0, 0, 0, "+%d to Necromancer Skill Levels" },
  { 86, 3, 0, 0, 0, "+%d to Sorceress Skill Levels" },
  { 87, 3, 0, 0, 0, "+%d to Barbarian Skill Levels" },
  { 89, 4, 0, 4, 0, "+%d to Light Radius" },
  { 91, 8, 0, 100, 0, "Requirements %+d%%" },
  { 93, 7, 0, 20, 0, "%d%% Increased Attack Speed" },
  { 96, 7, 0, 20, 0, "%d%% Faster Run/Walk" },
  { 99, 7, 0, 20, 0, "%d%% Faster Hit Recovery" },
  { 102, 7, 0, 20, 0, "%d%% Faster Block Rate" },
  { 105, 7, 0, 20, 0, "%d%% Faster Cast Rate" },
  { 107, 9, 5, 0, 0, "+%d to %s" },
  { 108, 9, 5, 0, 0, "+%d to %s" },
  { 109, 9, 5, 0, 0, "+%d to %s" },
  { 110, 8, 0, 20, 0, "Poison Length Reduced by %d%%" },
  /* The following needs additional math; percentage is actually value / 127 */
  { 112, 7, 0, 0, 0, "Hit Causes Monster to Flee %d%%" },
  { 113, 7, 0, 0, 0, "Hit Blinds Target +%d" },
  { 114, 6, 0, 0, 0, "%d%% Damage Taken Goes to Mana" },
  { 115, 1, 0, 0, 0, "Ignore Target Defense" },
  { 116, 7, 0, 0, 0, "%d%% Target Defense" },
  { 117, 7, 0, 0, 0, "Prevent Monster Heal" },
  { 118, 1, 0, 0, 0, "Half Freeze Duration" },
  { 119, 9, 0, 20, 0, "%d%% Bonus to Attack Rating" },
  { 120, 7, 0, 128, 0, "%d to Monster Defense per Hit" },
  /* These two are duplicates of 242/244, because I'm not sure I had
     them at the correct bit offset. */
  { 121, 9, 0, 20, 0, "+%d%% Damage to Demons" },
  { 122, 9, 0, 20, 0, "+%d%% Damage to Undead (unsure)" },
  { 123, 10, 0, 128, 0, "+%d to Attack Rating against Demons" },
  { 124, 10, 0, 128, 0, "+%d to Attack Rating against Undead" },
  { 126, 4, 0, 0, 0, "+%d to Fire Skills" },
  { 128, 5, 0, 0, 0, "Attacker Takes Lightning Damage of %d" },	// [RS] NEW
  { 134, 5, 0, 0, 0, "Freezes Target" },
  { 135, 7, 0, 0, 0, "%d%% Chance of Open Wounds" },
  { 136, 7, 0, 0, 0, "%d%% Chance of Crushing Blow" },
  { 138, 7, 0, 0, 0, "+%d to Mana After Each Kill" },
  { 139, 7, 0, 0, 0, "+%d to Life After Each Demon Kill" },
  { 141, 7, 0, 0, 0, "%d%% Deadly Strike" },
  // [RS] The length below is just a rough guess....
  { 142, 6, 0, 0, 0, "+%d Fire Absorb" },			// [RS] NEW
  // [RS] The length below is just a rough guess....
  { 145, 6, 0, 0, 0, "+%d Lightning Absorb" },			// [RS] NEW
  { 150, 7, 0, 0, 0, "Slows Target by %d%%" },
  { 153, 1, 0, 0, 0, "Cannot Be Frozen" },
  { 156, 7, 0, 0, 0, "Piercing Attack [%d]" },			// [RS] NEW
  { 157, 7, 0, 0, 0, "Fires Magic Arrows" },			// [RS] NEW
  { 159, 6, 0, 0, 0, "+%d to Minimum Damage" },
  { 160, 7, 0, 0, 0, "+%d to Maximum Damage" },
  { 179, 3, 0, 0, 0, "+%d to Druid Skill Levels" },
  { 180, 3, 0, 0, 0, "+%d to Assassin Skill Levels" },
  { 188, 5, 5, 0, 0, "+%d to %s" },
  { 195, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s on Attack" },
  { 196, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s on Attack" },
  { 198, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s on Striking" },
  { 199, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s on Striking" },
  { 201, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s when Struck" },
  { 202, 9, 5, 0, 0, "%d%% Chance to Cast Level %d %s when Struck" },
  { 204, 9, 5, 0, 0, "Level %d %s (%d/%d charges)" },
  { 205, 8, 5, 0, 0, "Level %d %s (%d/%d charges)" },
  { 214, 6, 0, 0, 0, "+%d/8 to Defense (Based on Character Level)" },
  { 216, 6, 0, 0, 0, "+%d/8 to Life (Based on Character Level)" },
  { 217, 6, 0, 0, 0, "+%d/8 to Mana (Based on Character Level)" },
  // BELOW: [RS] NEW
  { 218, 6, 0, 0, 0, "+%d/8 to Maximum Damage (Based on Character Level)" },
  { 224, 6, 0, 0, 0, "+%d/8 to Attack Rating (Based on Character Level)" },
  { 225, 6, 0, 0, 0, "%d/8%% Bonus to Attack Rating (Based on Character Level)" },
  { 252, 5, 0, 0, 0, "Repairs %d durability per 100 seconds" },
  { 253, 5, 0, 0, 0, "Replenishes quantity" },
  { 254, 8, 0, 0, 0, "Increased Stack Size (by %d)" },
  { 0x1ff, 0, 0, 0, 0, "END OF LIST" },
};

/*
 * SAVEGAME_ITEM::SAVEGAME_ITEM()
 *
 * This will initialize the item.
 *
 */
SAVEGAME_ITEM::SAVEGAME_ITEM() {
    // no next item, yet. no name or info either
    next = NULL; name = NULL; info = NULL;

    // no defense, no resistances
    defense = fire_resist = cold_resist = lightning_resist = poison_resist = 0;

    // no increased skills
    ama_skill = pal_skill = sorc_skill = necro_skill = barb_skill = 0;
    dru_skill = asa_skill = 0;
}

/*
 * SAVEGAME_ITEM::set_X(...)
 *
 * This will set the [X] field to [...].
 *
 */
void SAVEGAME_ITEM::set_next (SAVEGAME_ITEM* x) { next = x; }

/*
 * SAVEGAME_ITEM::get_X(...)
 *
 * This will return the [X] field.
 *
 */
SAVEGAME_ITEM* SAVEGAME_ITEM::get_next() { return next; }
int	       SAVEGAME_ITEM::get_type() { return type; }
char*	       SAVEGAME_ITEM::get_name() { return name; }
char*	       SAVEGAME_ITEM::get_info() { return info; }
unsigned int   SAVEGAME_ITEM::get_defense() { return defense; }
unsigned int   SAVEGAME_ITEM::get_fire_resist() { return fire_resist; }
unsigned int   SAVEGAME_ITEM::get_cold_resist() { return cold_resist; }
unsigned int   SAVEGAME_ITEM::get_lightning_resist() { return lightning_resist; }
unsigned int   SAVEGAME_ITEM::get_poison_resist() { return poison_resist; }

/*
 * SAVEGAME_ITEM::resolve_magic_prefix (int value)
 *
 * This will return a string with the meaning of prefix [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_magic_prefix (int value) {
    switch (value) {
    case 0x000: return "";
    case 0x08b: return "Blanched";
    case 0x08c: return "Eburin";
    case 0x08d: return "Bone";
    case 0x08e: return "Ivory";
    case 0x08f:
    case 0x090: return "Study";
    case 0x091: return "Strong";
    case 0x092: return "Glorious";
    case 0x094: return "Saintly";
    case 0x095: return "Holy";
    case 0x0a6: return "Scarlet";
    case 0x0b7: return "Carbuncle";
    case 0x0ba: return "Jagged";
    case 0x0bc: return "Vicious";
    case 0x0bd: return "Brutal";
    case 0x0be: return "Massive";
    case 0x0c0: return "Merciless";
    case 0x0c3: return "Cinnabar";
    case 0x0c4: return "Rusty";
    case 0x0c7: return "Vulpine";
    case 0x0c8: return "Dun";
    case 0x0c9: return "Tireless";
    case 0x0cc: return "Rugged";
    case 0x0cf:
    case 0x0d4:
    case 0x0d6: return "Rugged";
    case 0x0d8: return "Chestnut";
    case 0x0d9: return "Maroon";
    case 0x0db:
    case 0x0e3:
    case 0x0e4:
    case 0x0ee:
    case 0x298: return "Bronze";
    case 0x0ef: return "Iron";
    case 0x0f0: return "Steel";
    case 0x0f1: return "Silver";
    case 0x0f2: return "Gold";
    case 0x0f4: return "Meteoric";
    case 0x0f7: return "Nickel";
    case 0x0f8: return "Tin";
    case 0x0f9: return "Silver";
    case 0x0fa: return "Argent";
    case 0x101: return "Sharp";
    case 0x102: return "Fine";
    case 0x105: return "Knight's";
    case 0x107: return "King's";
    case 0x10a: return "Glimmering";
    case 0x10b: return "Glowing";
    case 0x10c: return "Bright";
    case 0x10e: return "Howling";
    case 0x115:
    case 0x117: return "Lucky";
    case 0x119: return "Felicitious";
    case 0x11a: return "Fortuitous";
    case 0x125:
    case 0x130: return "Lizard's";
    case 0x131: return "Snake's";
    case 0x132: return "Serpent's";
    case 0x135: return "Dragon's";
    case 0x137: return "Wyrm's";
    case 0x138: return "Great Wyrm's";
    case 0x139: return "Bahamut's";
    case 0x13a: return "Zircon";
    case 0x13b: return "Jacinth";
    case 0x13c: return "Turqoise";
    case 0x144: return "Rainbow";
    case 0x146:
    case 0x14b: return "Prismatic";
    case 0x14c: return "Chromatic";
    case 0x148: return "Shimmering";
    case 0x149: return "Rainbow";
    case 0x14a: // UNSURE!
    case 0x14f: return "Scintillating";
    case 0x15a:
    case 0x15e: return "Azure";
    case 0x15f:
    case 0x164: return "Lapis";
    case 0x165: return "Sapphire";
    case 0x161: return "Cobalt";
    case 0x176:
    case 0x0c6:
    case 0x171: return "Ruby";
    case 0x16f:
    case 0x172: return "Russet";
    case 0x174:
    case 0x175: return "Garnet";
    case 0x177: return "Garnet";
    case 0x185: return "Tangerine";
    case 0x186: return "Ocher";
    case 0x183:
    case 0x188: return "Coral";
    case 0x180:
    case 0x18a: return "Amber";
    case 0x18b: return "Camphor";
    case 0x29b:
    case 0x199: 
    case 0x19f: return "Beryl";
    case 0x196:
    case 0x19a: return "Viridian";
    case 0x19c: return "Jade";
    case 0x19e: return "Emerald";
    case 0x1a0: return "Jade";
    case 0x1a1: return "Triumphant";
    case 0x1a3: return "Aureolic";
    case 0x1a4: return "Mechanic's";
    case 0x1a6: return "Jeweler's";
    case 0x1a7: return "Lunar";
    case 0x1b4: return "Acrobatic";
    case 0x1b5: return "Gymnastic";
    case 0x1c4: return "Freezing";
    case 0x1cd: return "Noxious";
    case 0x1d1: return "Golemlord's";
    case 0x1ee: return "Caretaker's";
    case 0x1ef: return "Keeper's";
    case 0x1f4: return "Terrene";
    case 0x1fd: return "Psychic";
    case 0x21e: return "Shivering";
    case 0x22b: return "Septic";
    case 0x22c: return "Foul";
    case 0x22f: return "Pestilent";
    case 0x230: return "Maiden's";
    case 0x234: return "Monk's";
    case 0x23a:
    case 0x23c: return "Summoner's";
    case 0x240:
    case 0x23e: return "Angel's";
    case 0x241: return "Arch-Angel's";
    case 0x242: return "Slayer's";
    case 0x24c: return "Magekiller's";
    case 0x256: return "Hallowed";
    case 0x16e:
    case 0x259:
    case 0x299: return "Crimson";
    case 0x296: return "Tireless";
    case 0x297: return "Lizard's";
    case 0x29a: return "Tangerine";
    }

    // what's this?
    printf ("Unknown prefix: 0x%x\n", value);
    return "???";
}

/*
 * SAVEGAME_ITEM::resolve_magic_suffix (int value)
 *
 * This will return a string with the meaning of suffix [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_magic_suffix (int value) {
    switch (value) {
	    case 0: return "";
	case 0x073: return " of Health";
	case 0x074: return " of Protection";
	case 0x077: return " of Life Everlasting";
	case 0x079: return " of Absorption";
	case 0x07b: return " of Amicae";
	case 0x07c: return " of Warding";
	case 0x07d: return " of the Sentinel";
	case 0x07e: return " of Guarding";
	case 0x2de:
	case 0x0a1: return " of Thorns";
	case 0x0a2: return " of Spikes";
	case 0x0a7: return " of Alacrity";
	case 0x0a8: return " of Swiftness";
	case 0x0a9: return " of Quickness";
	case 0x0ab: return " of Fervor";
	case 0x0ac: return " of Blocking";
	case 0x0ad: return " of Deflecting";
	case 0x0ae: return " of the Apprentice";
	case 0x0b2: return " of the Glacier";
	case 0x0b5: return " of Frigidity";
	case 0x0b6: return " of Thawing";
	case 0x0b9: return " of Burning";
	case 0x0bc: return " of Passion";
	case 0x0bd:
	case 0x0c1:
	case 0x2d2: return " of Shock";
	case 0x150:
	case 0x0c2: return " of Ennui";
	case 0x0c3: return " of Craftsmanship";
	case 0x0c4: return " of Quality";
	case 0x0cc:
	case 0x0c5: return " of Maiming";
	case 0x0c7: return " of Gore";
	case 0x0dc: return " of Ire";
	case 0x0dd: return " of Wrath";
	case 0x0de: return " of Carnage";
	case 0x0df:
	case 0x0e4: return " of Worth";
	case 0x0e0:
	case 0x0e5: return " of Measure";
	case 0x0e8: return " of Joyfulness";
	case 0x0e9: return " of Bliss";
	case 0x0ea:
	case 0x2ae: return " of Blight";
	case 0x0eb: return " of Venom";
	case 0x0ef: return " of Envy";
	case 0x0f1: return " of Skill (0f1";
	case 0x0f0:
	case 0x0fb:
	case 0x100:
	case 0x2db:
	case 0x0f6: return " of Dexterity";
	case 0x0f3:
	case 0x0f9: return " of Precision";
	case 0x0f7:
	case 0x0fc: return " of Skill";
	case 0x0f8: return " of Accuracy";
	case 0x29e:
	case 0x105: return " of Daring";
	case 0x106: return " of Balance";
	case 0x107: return " of Equilibrium";
	case 0x108: return " of Stability";
	case 0x10c: return " of Truth";
	case 0x10d: 
	case 0x2e3:
	case 0x10e: return " of Regeneration";
	case 0x110: return " of Regrowth";
	case 0x111: return " of Regrowth";
	case 0x116: return " of Wealth";
	case 0x115:
	case 0x11c: return " of Greed";
	case 0x11d: return " of Avarice";
	case 0x11e: return " of Chance";
	case 0x120:
	case 0x122:
	case 0x11f: return " of Fortune";
	case 0x127: return " of Brilliance";
	case 0x124: return " of Prosperity";
	case 0x12b:
	case 0x130:
	case 0x2e4:
	case 0x125: return " of Energy";
	case 0x126: 
	case 0x131: return " of the Mind";
	case 0x132: return " of Brilliance";
	case 0x128: return " of Sorcery";
	case 0x129: return " of Wizardry";
	case 0x12a: return " of Enlightenment";
	case 0x12d: return " of Brilliance";
	case 0x135: return " of the Bear";
	case 0x136: return " of Light";
	case 0x137: return " of Radiance";
	case 0x138: return " of the Sun";
	case 0x139: return " of the Jackal";
	case 0x13c: return " of the Tiger";
	case 0x13d: return " of the Mammoth";
	case 0x13a:
	case 0x148: return " of the Fox";
	case 0x13f: return " of the Squid";
	case 0x140: return " of the Whale";
	case 0x141: return " of the Jackal";
	case 0x155:
	case 0x15b: return " of Life";
	case 0x15e: return " of Spirit";
	case 0x163:
	case 0x160: return " of the Leech";
	case 0x161: return " of the Locust";
	case 0x162: return " of the Lamprey";
	case 0x168: return " of the Wraith";
	case 0x16e: return " of Defiance";
	case 0x16f: return " of Amelioration";
	case 0x170: return " of Remedy";
	case 0x171: return " of Simplicity";
	case 0x172: return " of Ease";
	case 0x173: return " of Freedom";
	case 0x175: return " of Might";
	case 0x178: return " of the Titan";
	case 0x17d: return " of the Giant";
	case 0x174: 
	case 0x17a: 
	case 0x2dc:
	case 0x17f: return " of Strength";
	case 0x18b: return " of Haste";
	case 0x192: return " of Self-Repair";
	case 0x195: return " of Replenishing";
	case 0x197: return " of the Centaur";
	case 0x1a3: return " of Firebolts";
	case 0x1a5:
	case 0x1a6:
	case 0x1a7: return " of Charged Bolt";
	case 0x1ac: return " of Frost Shield";
	case 0x1f7: return " of Charged Bolt";
	case 0x1b2: return " of Nova Shield";
	case 0x230: return " of Weaken";
	case 0x296: return " of Amplify Damage";
	case 0x297: return " of the Icicle";
	case 0x29a: return " of Burning";
	case 0x29b: return " of Lightning";
	case 0x134:
	case 0x29f: return " of Knowledge";
	case 0x2a1:
	case 0x2a2: return " of Virility";
	case 0x2b2: return " of Blight";
	case 0x2b0:
	case 0x2ba: return " of Frost";
	case 0x2b6: return " of Frost";
	case 0x2b9: return " of Winter";
	case 0x2da: return " of Dexterity";
    }

    // what's this?
    printf ("Unknown suffix: 0x%x\n", value);
    return " of ???";
}

/*
 * SAVEGAME_ITEM::resolve_set_item (int value)
 *
 * This will return a string with the name of set item [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_set_item (int value) {
    // try to figure it out
    switch (value) {
	case 0x000: return "Civerb's Vestments";
	case 0x001: return "Hsarus' Defense";
	case 0x002: return "Cleglaw's Brace";
	case 0x003: return "Iratha's Finery";
	case 0x004: return "Isenhart's Armory"; 
	case 0x005: return "Vidala's Rig";
	case 0x006: return "Milabrega's Regalia";
	case 0x007: return "Cathan's Traps";
	case 0x008: return "Tancred's Battlegear";
	case 0x009: return "Sigon's Complete Steel";
	case 0x00a: return "Infernal Tools";
	case 0x00b: return "Beserker's Arsenal";
	case 0x00c: return "Death's Disguise";
	case 0x00d: return "Angelic Raiment";
	case 0x00e: return "Arctic Gear";
	case 0x00f: return "Arcanna's Tricks";
	case 0x010: return "Natalya's Odium";
	case 0x011: return "Aldur's Watchtower";
	case 0x012: return "Immortal King";
	case 0x013: return "Tal Rasha's Wrappings";
	case 0x014: return "Griswold's Legacy";
	case 0x015: return "Trang-Oul's Avatar";
	case 0x016: return "M'avina's Battle Hymn";
	case 0x017: return "The Disciple";
	case 0x018: return "Heaven's Brethren";
	case 0x019: return "Orphan's Call";
	case 0x01a: return "Hwanin's Majesty";
	case 0x01b: return "Sazabi's Grand Tribute";
	case 0x01c: return "Bul-Kathos' Children";
	case 0x01d: return "Cow King's Leathers";
	case 0x01e: return "Naj's Ancient Vestige";
	case 0x01f: return "Sander's Folly";
    }

    // what's this?
    printf ("unknown set 0x%x\n", value);
    return "[some set item]";
}

/*
 * SAVEGAME_ITEM::resolve_unique_item (int value)
 *
 * This will return a string with the name of unique item [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_unique_item (int value) {
    // try to figure it out
    switch (value) {
	case 0x000: return "The Gnasher"; 
	case 0x001: return "Deathspade";
	case 0x002: return "Bladebone";
	case 0x003: return "Skull Splitter";
	case 0x004: return "Rakescar";
	case 0x005: return "Axe of Fechmar";
	case 0x006: return "Goreshovel";
	case 0x007: return "Chieftain";
	case 0x008: return "Brainhew";
	case 0x009: return "The Humongous";
	case 0x00a: return "Torch of Iro";
	case 0x00b: return "Maelstrom";
	case 0x00c: return "Gravespine";
	case 0x00d: return "Ume's Lament";
	case 0x00e: return "Felloak";
	case 0x00f: return "Knell Striker";
	case 0x010: return "Rusthandle";
	case 0x011: return "Stormeye";
	case 0x012: return "Stoutnail";
	case 0x013: return "Crushflange";
	case 0x014: return "Bloodrise";
	case 0x015: return "The General's Tan Do Li Ga";
	case 0x016: return "Ironstone";
	case 0x017: return "Bonesnap";
	case 0x018: return "Steeldriver";
	case 0x019: return "Rixot's Keen";
	case 0x01a: return "Blood Crescent";
	case 0x01b: return "Skewer of Krinitz";
	case 0x01c: return "Gleamscythe";
	case 0x01d: return "Azurewrath";
	case 0x01e: return "Griswold's Edge";
	case 0x01f: return "Hellplague";
	case 0x020: return "Culwen's Point";
	case 0x021: return "Shadowfang";
	case 0x022: return "Soulflay";
	case 0x023: return "Kinemil's Awl";
	case 0x024: return "Blacktongue";
	case 0x025: return "Ripsaw";
	case 0x026: return "The Patriarch";
	case 0x027: return "Gull";
	case 0x028: return "The Diggler";
	case 0x029: return "The Jade Tan Do";
	case 0x02a: return "Spectral Shard";
	case 0x02b: return "The Dragon Chang";
	case 0x02c: return "Razortine";
	case 0x02d: return "Bloodthief";
	case 0x02e: return "Lance of Yaggai";
	case 0x02f: return "The Tannr Gorerod";
	case 0x030: return "Dimoak's Hew";
	case 0x031: return "Steelgoad";
	case 0x032: return "Soul Harvest";
	case 0x033: return "The Battlebranch";
	case 0x034: return "Woestave";
	case 0x035: return "The Grim Reaper";
	case 0x036: return "Bane Ash";
	case 0x037: return "Serpent Lord";
	case 0x038: return "Spire of Lazarus";
	case 0x039: return "The Salamander";
	case 0x03a: return "The Iron Jang Bong";
	case 0x03b: return "Pluckeye";
	case 0x03c: return "Witherstring";
	case 0x03d: return "Raven Claw";
	case 0x03e: return "Rogue's Bow";
	case 0x03f: return "Stormstrike";
	case 0x040: return "Wizendraw";
	case 0x041: return "Hellclap";
	case 0x042: return "Blastbark";
	case 0x043: return "Leadcrow";
	case 0x044: return "Ichorsting";
	case 0x045: return "Hellcast";
	case 0x046: return "Doomslinger";
	case 0x047: return "Biggin's Bonnet";
	case 0x048: return "Tarnhelm";
	case 0x049: return "Coif of Glory";
	case 0x04a: return "Duskdeep";
	case 0x04b: return "Wormskull";
	case 0x04c: return "Howltusk";
	case 0x04d: return "Undead Crown";
	case 0x04e: return "The Face of Horror";
	case 0x04f: return "Greyform";
	case 0x050: return "Blinkbat's Form";
	case 0x051: return "The Centurion";
	case 0x052: return "Twitchroe";
	case 0x053: return "Darkglow";
	case 0x054: return "Hawkmail";
	case 0x055: return "Sparking Mail";
	case 0x056: return "Venom Ward";
	case 0x057: return "Iceblink";
	case 0x058: return "Boneflesh";
	case 0x059: return "Rockfleece";
	case 0x05a: return "Rattlecage";
	case 0x05b: return "Goldskin";
	case 0x05c: return "Silks of the Victor";
	case 0x05d: return "Heavenly Garb";
	case 0x05e: return "Pelta Lunata";
	case 0x05f: return "Umbral Disk";
	case 0x060: return "Stormguild";
	case 0x061: return "Wall of the Eyeless";
	case 0x062: return "Swordback Hold";
	case 0x063: return "Steelclash";
	case 0x064: return "Bverrit Keep";
	case 0x065: return "The Ward";
	case 0x066: return "The Hand of Broc";
	case 0x067: return "Bloodfist";
	case 0x068: return "Chance Guards";
	case 0x069: return "Magefist";
	case 0x06a: return "Frostburn";
	case 0x06b: return "Hotspur";
	case 0x06c: return "Gorefoot";
	case 0x06d: return "Treads of Cthon";
	case 0x06e: return "Goblin Toe";
	case 0x06f: return "Tearhaunch";
	case 0x070: return "Lenymo";
	case 0x071: return "Snakecord";
	case 0x072: return "Nightsmoke";
	case 0x073: return "Goldwrap";
	case 0x074: return "Plated Belt";
	case 0x075: return "Nokozan Relic";
	case 0x076: return "The Eye of Etlich";
	case 0x077: return "The Mahim-Oak Curio";
	case 0x078: return "Nagelring";
	case 0x079: return "Manald Heal";
	case 0x07a: return "Stone of Jordan";
	case 0x07b: return "Amulet of the Viper";
	case 0x07d: return "Horadric Staff";
	case 0x07e: return "Hell Forge Hammer";
	case 0x081: return "Coldkill";
	case 0x082: return "Butcher's Pupil";
	case 0x083: return "Islestrike";
	case 0x084: return "Pompei's Wrath";
	case 0x085: return "Guardian Naga";
	case 0x086: return "Warlord's Trust";
	case 0x087: return "Spellsteel";
	case 0x088: return "Stormrider";
	case 0x089: return "Boneslayer Blade";
	case 0x08a: return "The Minotaur";
	case 0x08b: return "Suicide Branch";
	case 0x08c: return "Carin Shard";
	case 0x08d: return "Arm of King Leoric";
	case 0x08e: return "Blackhand Key";
	case 0x08f: return "Dark Clan Crusher";
	case 0x090: return "Zakarum's Hand";
	case 0x091: return "The Fetid Sprinkler";
	case 0x092: return "Hand of Blessed Light";
	case 0x093: return "Fleshrender";
	case 0x094: return "Sureshrill Frost";
	case 0x095: return "Moonfall";
	case 0x096: return "Baezil's Vortex";
	case 0x097: return "Earthshaker";
	case 0x098: return "Bloodtree Stump";
	case 0x099: return "The Gavel of Pain";
	case 0x09a: return "Bloodletter";
	case 0x09b: return "Coldsteel Eye";
	case 0x09c: return "Hexfire";
	case 0x09d: return "Blade of Ali Baba";
	case 0x09e: return "Ginther's Rift";
	case 0x09f: return "Headstriker";
	case 0x0a0: return "Plague Bearer";
	case 0x0a1: return "The Atlantean";
	case 0x0a2: return "Crinte Vomir";
	case 0x0a3: return "Bing Sz Wang";
	case 0x0a4: return "The Vile Husk";
	case 0x0a5: return "Cloudcrack";
	case 0x0a6: return "Todesfaelle Flamme";
	case 0x0a7: return "Sword Guard";
	case 0x0a8: return "Spineripper";
	case 0x0a9: return "Heart Carver";
	case 0x0aa: return "Blackbog's Sharp";
	case 0x0ab: return "Stormspike";
	case 0x0ac: return "The Impaler";
	case 0x0ad: return "Kelpie Snare";
	case 0x0ae: return "Soulfeast Tine";
	case 0x0af: return "Hone Sundan";
	case 0x0b0: return "Spire of Honor";
	case 0x0b1: return "The Meat Scraper";
	case 0x0b2: return "Blackleach Blade";
	case 0x0b3: return "Athena's Wrath";
	case 0x0b4: return "Pierre Tombale Couant";
	case 0x0b5: return "Husoldal Evo";
	case 0x0b6: return "Grim's Burning Death";
	case 0x0b7: return "Razorswitch";
	case 0x0b8: return "Ribcracker";
	case 0x0b9: return "Chromatic Ire";
	case 0x0ba: return "Warpspear";
	case 0x0bb: return "Skull Collector";
	case 0x0bc: return "Skystrike";
	case 0x0bd: return "Riphook";
	case 0x0be: return "Kuko Shakaku";
	case 0x0bf: return "Endlesshail";
	case 0x0c0: return "Witchwild String";
	case 0x0c1: return "Cliffkiller";
	case 0x0c2: return "Magewrath";
	case 0x0c3: return "Goldstrike Arch";
	case 0x0c4: return "Langer Briser";
	case 0x0c5: return "Pus Spitter";
	case 0x0c6: return "Buriza-Do Kyanon";
	case 0x0c7: return "Demon Machine";
	case 0x0c9: return "Peasant Crown";
	case 0x0ca: return "Rockstopper";
	case 0x0cb: return "Steelskull";
	case 0x0cc: return "Darksight Helm";
	case 0x0cd: return "Valkyrie Wing";
	case 0x0ce: return "Crown of Thieves";
	case 0x0cf: return "Blackhorn's Face";
	case 0x0d0: return "Vampire Gaze";
	case 0x0d1: return "The Spirit Shroud";
	case 0x0d2: return "Skin of the Vipermagi";
	case 0x0d3: return "Skin of the Flayed One";
	case 0x0d4: return "Iron Pelt";
	case 0x0d5: return "Spirit Forge";
	case 0x0d6: return "Crow Caw";
	case 0x0d7: return "Shaftstop";
	case 0x0d8: return "Duriel's Shell";
	case 0x0d9: return "Skullder's Ire";
	case 0x0da: return "Guardian Angel";
	case 0x0db: return "Toothrow";
	case 0x0dc: return "Atma's Wail";
	case 0x0dd: return "Black Hades";
	case 0x0de: return "Corpsemourn";
	case 0x0df: return "Que-Hegan's Wisdom";
	case 0x0e0: return "Visceratuant";
	case 0x0e1: return "Moser's Blessed Circle";
	case 0x0e2: return "Stormchaser";
	case 0x0e3: return "Tiamat's Rebuke";
	case 0x0e4: return "Gerke's Sanctuary";
	case 0x0e5: return "Radament's Sphere";
	case 0x0e6: return "Lidless Wall";
	case 0x0e7: return "Lance Guard";
	case 0x0e8: return "Venom Grip";
	case 0x0e9: return "Gravepalm";
	case 0x0ea: return "Ghoulhide";
	case 0x0eb: return "Lava Gout";
	case 0x0ec: return "Hellmouth";
	case 0x0ed: return "Infernostride";
	case 0x0ee: return "Waterwalk";
	case 0x0ef: return "Silkweave";
	case 0x0f0: return "War Traveller";
	case 0x0f1: return "Gore Rider";
	case 0x0f2: return "String of Ears";
	case 0x0f3: return "Razortail";
	case 0x0f4: return "Gloom's Trap";
	case 0x0f5: return "Snowclash";
	case 0x0f6: return "Thundergod's Vigor";
	case 0x0f8: return "Harlequin Crest";
	case 0x0f9: return "Veil of Steel";
	case 0x0fa: return "The Gladiator's Bane";
	case 0x0fb: return "Arkaine's Valor";
	case 0x0fc: return "Blackoak Shield";
	case 0x0fd: return "Stormshield";
	case 0x0fe: return "Hellslayer";
	case 0x0ff: return "Messerschmidt's Reaver";
	case 0x100: return "Baranar's Star";
	case 0x101: return "Schaeffer's Hammer";
	case 0x102: return "The Cranium";
	case 0x103: return "Lightsabre";
	case 0x104: return "Doombringer";
	case 0x105: return "The Grandfather";
	case 0x106: return "Wizardspike";
	case 0x107: return "Constricting Ring";
	case 0x109: return "Eaglehorn";
	case 0x10a: return "Windforce";
	case 0x10c: return "Bul-Kathos' Wedding Band";
	case 0x10d: return "The Cat's Eye";
	case 0x10f: return "Crescent Moon";
	case 0x108: return "Stormspire";
	case 0x110: return "Mara's Kaleidoscope";
	case 0x111: return "Atma's Scarab";
	case 0x112: return "Dwarf Star";
	case 0x113: return "Raven Frost";
	case 0x115: return "Saracen's Chance";
	case 0x117: return "Arreat's Face";
	case 0x118: return "Homunculus";
	case 0x119: return "Titan's Revenge";
	case 0x11a: return "Lycander's Aim";
	case 0x11b: return "Lycander's Flank";
	case 0x11c: return "The Oculus";
	case 0x11d: return "Herald of Zakarum";
	case 0x11e: return "Bartuc's Cut-Throat";
	case 0x179: return "Nosferatu's Coil";
    }

    // what's this?
    printf ("Unknown unique 0x%x\n", value);
    return "[some unique item]";
}

/*
 * SAVEGAME_ITEM::resolve_set_item_name (int setid, SAVEGAME_ITEMDATA* idata)
 *
 * This will return a string with the name of set item [idata] from set [setid].
 *
 */
char*
SAVEGAME_ITEM::resolve_set_item_name (int setid, SAVEGAME_ITEMDATA* idata) {
    struct SAVEGAME_SETITEM_DECL* setitem =  savegame_setitemsdec;

    // scan through them lal
    while (setitem->name) {
	// match?
	if ((idata->type == setitem->type) &&
	    (idata->subtype == setitem->subtype) &&
	    (idata->variant == setitem->variant) &&
	    (setid == setitem->setid))
	    // yes. return the name
	    return setitem->name;

	// next
	setitem++;
    }

    // no match.
    printf ("Name of set item '%c%c%c' from set '%s' unknown\n", idata->type, idata->subtype, idata->variant, resolve_set_item (setid));
    return "???";
}

/*
 * SAVEGAME_ITEM::resolve_runeword (int value)
 *
 * This will return a string with the name of runeword [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_runeword (int value) {
    switch (value) {
	case 0x01B: return "Ancient's Pledge";
	case 0x051: return "Black";
	case 0x056: return "Fury";
	case 0x05B: return "Holy Thunder";
	case 0x060: return "Honor";
	case 0x065: return "King's Grace";
	case 0x06A: return "Leaf";
	case 0x06F: return "Lionheart";
	case 0x074: return "Lore";
	case 0x079: return "Malice";
	case 0x07E: return "Melody";
	case 0x083: return "Memory";
	case 0x088: return "Nadir";
	case 0x08D: return "Radience";
	case 0x091: return "Rhyme";
	case 0x096: return "Silence";
	case 0x09B: return "Smoke";
	case 0x0A0: return "Stealth";
	case 0x0A5: return "Steel";
	case 0x0AA: return "Strength";
	case 0x0AF: return "Venom";
	case 0x0B4: return "Wealth";
	case 0x0B9: return "White";
	case 0x0BE: return "Zephyr";
    }

    // what's this?
    printf ("Unknown runeword 0x%x\n", value);
    return "unknown";
}

/*
 * SAVEGAME_ITEM::resolve_skill (int value)
 *
 * This will return the name of skill [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_skill (int value) {
    // what's this?
    printf ("Unknown skill 0x%x\n", value);
    return "unknown";
}

/*
 * SAVEGAME_ITEM::resolve_skill_set (int value)
 *
 * This will return a string with the name of skill set [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_skill_set (int value) {
    switch (value) {
	case 0x000: return "Bow and Crossbow Skills (Amazon only)";
	case 0x001: return "Passive and Magic Skills (Amazon only)";
	case 0x002: return "Javelin and Spear Skills (Amazon only)";
	case 0x005: return "Cold Skills (Sorceress only)";
	case 0x007: return "Poison and Bone Skills (Necromancer only)";
	case 0x008: return "Summoning Skills (Necromancer only)";
	case 0x00d: return "Masteries (Barbarian only)";
	case 0x00e: return "Warcries (Barbarian only)";
	case 0x00f: return "Summoning Skills (Druid only)";
	case 0x011: return "Elemental Skills (Druid only)";
	case 0x013: return "Shadow Disciplines (Assassin only)";
    }

    // what's this?
    printf ("Unknown skill set 0x%x\n", value);
    return "???";
}

/*
 * SAVEGAME_ITEM::resolve_spell (int value)
 *
 * This will return the name of spell [value].
 *
 */
char*
SAVEGAME_ITEM::resolve_spell (int value) {
    // try to figure it out
    switch (value) {
	case 0x01a: return "Strafe (Amazon only)";
	case 0x01f: return "Freezing Arrow";
	case 0x024: return "Fire Bolt (Sorceress only)";
	case 0x025: return "Warmth (Sorceress only)";
	case 0x026: return "Charged Bolt";
	case 0x027: return "Ice Bolt (Sorceress only)";
	case 0x029: return "Ice Blast (Sorceress only)";
	case 0x02c: return "Frost Nova (Sorceress only)";	// [RS] Unsure
	case 0x02d: return "Inferno (Sorceress only)";
	case 0x02e: return "Blaze (Sorceress only)";
	case 0x030: return "Nova (Sorceress only)";
	case 0x031: return "Frost Nova (Sorceress only)";
	case 0x032: return "Shiver Armor (Sorceress only)";
	case 0x033: return "Fire Wall (Sorceress only)";
	case 0x035: return "Chain Lightning (Sorceress only)";
	case 0x03b: return "Blizzard (Sorceress only)";
	case 0x042: return "Amplify Damage (Necromancer only)";
	case 0x048: return "Weaken (Necromancer only)";
	case 0x056: return "Attract (Necromancer only)";
	case 0x058: return "Bone Prison (Necromancer only)";
	case 0x059: return "Summon Resist (Necromancer only)";
	case 0x060: return "Sacrifice (Paladin only)";
	case 0x061: return "Smite (Paladin only)"; // [RS] Unsure
	case 0x062: return "Might (Paladin only)"; // [RS] Unsure
	case 0x064: return "Resist Fire (Paladin only)"; // [RS] Unsure
	case 0x066: return "Holy Fire (Paladin only)";
	case 0x067: return "Vengeance (Paladin only)";
	case 0x06f: return "Thorns (Paladin only)";
	case 0x073: return "Vigor (Paladin only)";
	case 0x079: return "Fist of the Heavens (Paladin only)";
	case 0x07e: return "Bash (Barbarian only)"; // [RS] Unsure
	case 0x081: return "Mace Mastery (Barbarian only)"; // [RS] Unsure
	case 0x086: return "Pole Arm Mastery (Barbarian only)";
	case 0x08e: return "Battle Orders (Barbarian only)";
	case 0x08f: return "Leap Attack (Barbarian only)";
	case 0x090: return "Frenzy (Barbarian only)";
	case 0x093: return "Concentrate (Barbarian only)";
	case 0x094: return "Increased Speed (Barbarian only)";
	case 0x095: return "Find Item (Barbarian only)";
	case 0x097: return "Whirlwind (Barbarian only)";
	case 0x0e1: return "Firestorm (Druid only)";
	case 0x0e7: return "Carrion Vine (Druid only)";	// [RS] Unsure
	case 0x0eb: return "Cyclone Armor (Druid only)";
	case 0x0f0: return "Twister (Druid only)";	// [RS] Unsure
    }

    // what's this?
    printf ("unknown spell 0x%x\n", value);
    return "???????????????";
}

/*
 * SAVEGAME_ITEM::resolve_prefix (char* name, unsigned char* data, int len,
 *			 	  char* dest, int start)
 *
 * This will resolve prefix [data] into [dest]. It will return the newest
 * offset.
 *
 */
int
SAVEGAME_ITEM::resolve_prefix (char* name, unsigned char* data, int len, char* dest, int start) {
    struct SAVEGAME_ITEMDATA* idata = (struct SAVEGAME_ITEMDATA*)data;
    int	   n, v;
    char   tmp[512];

    if (SG_READBITS (start, 1))
	start += 12;
    else
	start++;

    // figure out from the name the real name
    strcpy (tmp, name);
    switch (idata->iquality) {
	 case SAVEGAME_ITEMQUALITY_LOW: // low quality
					sprintf (name, "%s %s", savegame_lqname[SG_READBITS (start, 2)], tmp);
					start += 3;
					break;
      case SAVEGAME_ITEMQUALITY_NORMAL: // normal quality
					strcpy (name, tmp);
					break;
        case SAVEGAME_ITEMQUALITY_HIGH: // high quality
					sprintf (name, "Superiour %s", tmp);
					start += 3;
					break;
       case SAVEGAME_ITEMQUALITY_MAGIC: // magic item
					strcpy (name, resolve_magic_prefix (SG_READBITS (start, 11))); start += 11;
					if (strlen (name)) strcat (name, " ");
					strcat (name, tmp);
					strcat (name, resolve_magic_suffix (SG_READBITS (start, 11))); start += 11;

					break;
	 case SAVEGAME_ITEMQUALITY_SET: // set item
					v = SG_READBITS (start, 12);
					sprintf (name, "%s - %s (%s)", resolve_set_item (v), resolve_set_item_name (v, idata), tmp);
					start += 12;
					break;
	case SAVEGAME_ITEMQUALITY_RARE: // rare item
					sprintf (name, "%s %s - Rare %s", savegame_rarename[SG_READBITS (start, 8)], savegame_rarename[SG_READBITS (start + 8, 8)], tmp);
					start += 16;

					// skip over the prefixes
					for (n = 0; n < 6; n++) {
					    if (SG_READBITS (start, 1)) {
						start += 12;
					    } else {
						start++;
					    }
					}
					break;
      case SAVEGAME_ITEMQUALITY_UNIQUE: // unique item
					sprintf (name, "%s - %s", resolve_unique_item (SG_READBITS (start, 12)), tmp); start += 12;
					break;
    }

    // rune-worded?
    if (idata->runeword) {
	// yes. grab the word
	sprintf (info, "Runeword - %s\n", resolve_runeword (SG_READBITS (start, 12)));
	start += 16;
    }

    // personalized?
    if (idata->personized) {
	strcat (info, "Personalized by ");
	for (n = 0; n < 16; n++) {
	    v = SG_READBITS (start, 7); start += 7;
	    if (!v)
		break;
	    strcat (info, "!"); 
	    info[strlen (info) - 1] = v;
	}
	strcat (info, "\n");
    }

    // return the offset
    start++;
    return start;
}

/*
 * SAVEGAME_ITEM::resolve_magic_data (char* data, int start, int len,
 *				     char* dest)
 *
 * This will resolve [len] bytes of magical data [data], starting at bit
 * [start]. The result will be appended to [dest].
 *
 */
void
SAVEGAME_ITEM::resolve_magic_data (char* data, int start, int len, char* dest) {
    struct SAVEGAME_ITEMDATA* idata = (struct SAVEGAME_ITEMDATA*)data;
    int id, i, value, value2 = 0;
    char tmp[128];

    // set item?
    if (idata->iquality == SAVEGAME_ITEMQUALITY_SET) {
	// yes. skip 5 bits
	start += 5;
    }

    while (1) {
	// fetch the bits
	id = SG_READBITS (start, 9);
        start += 9;
	// exit on time
	if (id == 0x1ff) break;
	if ((start / 8) >= len) break;

 	// look up the id
	i = 0;
	while (sg_magical_modifiers[i].id != 0x1ff) {
	    // match?
	    if (sg_magical_modifiers[i].id == id)
		// yes. break out
		break;

	    // next
	    i++;
	}

	// failure?
	if (sg_magical_modifiers[i].id == 0x1ff) {
	    // yes. bump out
	    sprintf (info, "%sType [%u] found, item aborted\n", info, id);
	    break;
	}

	// read the values
	value = (SG_READBITS (start, sg_magical_modifiers[i].data_len)
		   - sg_magical_modifiers[i].bias);

	if (sg_magical_modifiers[i].data2_len)
	    value2 = (SG_READBITS (start + sg_magical_modifiers[i].data_len,
				   sg_magical_modifiers[i].data2_len)
		   - sg_magical_modifiers[i].bias2);

	// nothing to add, yet
	strcpy (tmp, "");

	// handle the text
	switch (id) {
	    default: sprintf (tmp, sg_magical_modifiers[i].name, value, value2);
		     break;
	    case 54: // cold damage
		     sprintf (tmp, sg_magical_modifiers[i].name, SG_READBITS (start, 6), SG_READBITS (start + 6, 8), (SG_READBITS (start + 14, 8) / 25));
		     break;
	    case 57: // poison damage [XXX] Rounding incorrect!
		     sprintf (tmp, sg_magical_modifiers[i].name,
			     (SG_READBITS (start, 9) * 75) / 256,
			     (SG_READBITS (start + 9, 9) * 75) / 256,
			     (SG_READBITS (start + 18, 8) / 25));
		     break;
	   case 188: // skill set
		     sprintf (tmp, sg_magical_modifiers[i].name, value2, resolve_skill_set (value));
		     break;
	   case 195:
	   case 196:
	   case 198:
	   case 199:
	   case 201:
	   case 202: // spells
		     sprintf (tmp, sg_magical_modifiers[i].name, SG_READBITS (start + 14, 7), value2, resolve_spell (value));
		     start += 7;
		     break;
	   case 204:
	   case 205: // charges
		     sprintf (tmp, sg_magical_modifiers[i].name, value2, resolve_spell (value), SG_READBITS (start + 14, 8), SG_READBITS (start + 22, 8));
		     start += 16;
		     break;
	  case 107:
	  case 108:
	  case 109: // spells
		    sprintf (tmp, sg_magical_modifiers[i].name, value2, resolve_spell (value));
		    break;
	   case 39: // fire resist
		    fire_resist += value;
		    break;
	   case 41: // lightning resist
		    lightning_resist += value;
		    break;
	   case 43: // cold resist
		    cold_resist += value;
		    break;
	   case 45: // poison resist
		    poison_resist += value;
		    break;
	   case 83: // to amazon skill levels
		    ama_skill += value;
		    break;
	   case 84: // to paladin skill levels
		    pal_skill += value;
		    break;
	   case 85: // to necro skill levels
		    necro_skill += value;
		    break;
	   case 86: // to sorceress skill levels
		    sorc_skill += value;
		    break;
	   case 87: // to barbarian skill levels
		    barb_skill += value;
		    break;
	  case 179: // to druid skill levels
		    dru_skill += value;
		    break;
	  case 180: // to assassin skill levels
		    asa_skill += value;
		    break;
	}

	start += sg_magical_modifiers[i].data_len;
	start += sg_magical_modifiers[i].data2_len;

	// got anything to add?
	if (strlen (tmp))
	    // yes. add it
	    sprintf (info, "%s%s\n", info, tmp);
    }

    // now, do we have all resistances equal?
    if ((fire_resist == cold_resist) &&
	(cold_resist == lightning_resist) &&
	(lightning_resist == poison_resist) &&
	(fire_resist)) {
	// yes. we have an 'All Resistances +x%' thing
	sprintf (info, "%sAll Resistances +%d%%\n", info, fire_resist);
    } else {
	// no. add all individual resistances
	if (fire_resist)
	    sprintf (info, "%sFire Resist +%d%%\n", info, fire_resist);
	if (cold_resist)
	    sprintf (info, "%sCold Resist +%d%%\n", info, cold_resist);
	if (lightning_resist)
	    sprintf (info, "%sLightning Resist +%d%%\n", info, lightning_resist);
	if (poison_resist)
	    sprintf (info, "%sPoison Resist +%d%%\n", info, poison_resist);
    }

    // do we have all skill levels equal?
    if ((ama_skill == pal_skill) &&
	(pal_skill == sorc_skill) &&
	(sorc_skill == necro_skill) &&
	(necro_skill == barb_skill) &&
	(barb_skill == dru_skill) &&
	(dru_skill == asa_skill) &&
	(ama_skill)) {
	// yes. we have an '+x to All Skills' thing
	sprintf (info, "%s+%d to All Skills\n", info, ama_skill);
    } else {
	// no. handle the individual increments
	if (ama_skill)
	    sprintf (info, "%s+%d to Amazon Skill Levels\n", info, ama_skill);
	if (pal_skill)
	    sprintf (info, "%s+%d to Paladin Skill Levels\n", info, pal_skill);
	if (sorc_skill)
	    sprintf (info, "%s+%d to Sorceress Skill Levels\n", info, sorc_skill);
	if (necro_skill)
	    sprintf (info, "%s+%d to Necromancer Skill Levels\n", info, necro_skill);
	if (barb_skill)
	    sprintf (info, "%s+%d to Barbarian Skill Levels\n", info, barb_skill);
	if (dru_skill)
	    sprintf (info, "%s+%d to Druid Skill Levels\n", info, dru_skill);
	if (asa_skill)
	    sprintf (info, "%s+%d to Assassin Skill Levels\n", info, asa_skill);
    }
}

/*
 * SAVEGAME_ITEM::create (struct SAVEGAME_ITEMDATA* idata)
 *
 * This will try to generate an item from [idata].
 *
 */
void
SAVEGAME_ITEM::create (struct SAVEGAME_ITEMDATA* idata) {
    struct SAVEGAME_ITEMTYPE_DECL* idec = savegame_itemsdec;
    char* data = (char*)idata;
    char* tmp = (char*)idata + 1;
    int i, ilen = 0, start;

    // figure out the size
    while (!(((*tmp == 'J') && (*(tmp + 1) == 'M')) ||
	     ((*tmp == 'k') && (*(tmp + 1) == 'f')))) {
	ilen++; tmp++;
    }

    // scan for the item
    while (idec->name) {
	// match?
	if (((idata->type == idec->type) || (idec->type == '#')) &&
	    ((idata->subtype == idec->subtype) || (idec->subtype == '#')) &&
	    ((idata->variant == idec->variant) || (idec->variant == '#')))
		// yes, we got it! woohoo!
		break;

	// next
	idec++;
    }

    // found a match?
    if (idec->name == NULL) {
	// noooh... inform the user
	printf ("Notice: no match for type '%c%c%c'\n", idata->type, idata->subtype, idata->variant);
	return;
    }

    // copy the name
    name = (char*)malloc (256);
    strcpy (name, idec->name);

    // yay, we found it. handle the type
    switch (idec->itemtype) {
	 case SAVEGAME_ITEMTYPE_SIMPLE: // simple item;
					break;
	    case SAVEGAME_ITEMTYPE_GEM: // gem
					switch (idata->subtype) {
					    case 'c': strcpy (name, "Chipped ");
						      break;
					    case 'f': strcpy (name, "Flawed ");
						      break;
					    case 's': strcpy (name, "");
						      break;
					    case 'z':
					    case 'l': strcpy (name, "Flawless ");
						      break;
					    case 'p': strcpy (name, "Perfect ");
						      break;
					     default: strcpy (name, "??? ");
					}

					switch (idata->variant) {
					    case 'b': strcat (name, "Sapphire");
						      break;
					    case 'g': strcat (name, "Emerald");
						      break;
					    case 'r': strcat (name, "Ruby");
						      break;
					    case 'v': strcat (name, "Amethyst");
						      break;
					    case 'w': strcat (name, "Diamond");
						      break;
					    case 'y': strcat (name, "Topaz");
						      break;
					     default: strcat (name, "???");
						      break;
					}
					break;
	  case SAVEGAME_ITEMTYPE_SKULL: // skull
					switch (idata->variant) {
					    case 'c': strcpy (name, "Chipped Skull");
						      break;
					    case 'f': strcpy (name, "Flawed Skull");
						      break;
					    case 'l': strcpy (name, "Flawless Skull");
						      break;
					    case 'u': strcpy (name, "Skull");
						      break;
					    case 'z': strcpy (name, "Perfect Skull");
						      break;
					}
					break;
	   case SAVEGAME_ITEMTYPE_RUNE: // rune
					i = (idata->subtype - '0') * 10 +
					    (idata->variant - '0');
					sprintf (name, "%s Rune", savegame_rname[i]);
					break;
	 case SAVEGAME_ITEMTYPE_POTION: // potion
					break;
	   case SAVEGAME_ITEMTYPE_TOME: // tome
          case SAVEGAME_ITEMTYPE_STACK: // stack
					info = (char*)malloc (1024);
					start = 157;
					if (idec->itemtype == SAVEGAME_ITEMTYPE_TOME)
					    start += 5;
					sprintf (info, "Quantity: %u\n", (int)SG_READBITS (start, 9));
				        start += 9;
					break;
          case SAVEGAME_ITEMTYPE_ARMOR: // armor
       case SAVEGAME_ITEMTYPE_STWEAPON: // stacked weapons
         case SAVEGAME_ITEMTYPE_WEAPON: // weapon
					info = (char*)malloc (8192);
					strcpy (info, "");
					if (!idata->identified)
					    strcat (info, "Unidentified\n");
					if (idata->ethereal)
					    strcat (info, "Ethereal\n");
					if (idata->newbie)
					    strcat (info, "Newbie Item\n");

					// handle the prefix
					strcpy (name, idec->name);
					start = resolve_prefix (name, (unsigned char*)idata, ilen, info, 155);

					// armor?
					if (idec->itemtype == SAVEGAME_ITEMTYPE_ARMOR) {
					    sprintf (info, "%sDefense: %u\n", info, (int)(SG_READBITS (start, 10) - 10));
					    start += 10;
					}

					// fetch the durability
					if (SG_READBITS (start, 8)) {
					    sprintf (info, "%sDurability: %u of %u\n", info, (int)SG_READBITS (start + 8, 8), (int)SG_READBITS (start, 8));
					    start += 16;
					} else {
					    sprintf (info, "%sIndestructible\n", info);
					    start += 8;
					}

					// socketed?
					if (idata->socketed) {
					    // yes. show the info
					    sprintf (info, "%sSocketed (%u, %u used)\n", info, (int)SG_READBITS (start, 4), idata->numgems);
					    start += 4;
					}

					if (idec->itemtype == SAVEGAME_ITEMTYPE_STWEAPON) {
					    sprintf (info, "%sQuantity: %u\n", info, (int)SG_READBITS (start, 9));
					    start += 9;
					}

					resolve_magic_data ((char*)idata, start, ilen, info);
					break;
         case SAVEGAME_ITEMTYPE_AMULET: // amulet
           case SAVEGAME_ITEMTYPE_RING: // ring
          case SAVEGAME_ITEMTYPE_JEWEL: // jewel
          case SAVEGAME_ITEMTYPE_CHARM: // charm
					info = (char*)malloc (1024);
					strcpy (name, idec->name);
					start = resolve_prefix (name, (unsigned char*)idata, ilen, info, 155 + (SG_READBITS (154, 1) * 3));

					resolve_magic_data ((char*)idata, start, ilen, info);
					break;
    }
}
