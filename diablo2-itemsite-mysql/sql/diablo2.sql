-- MySQL dump 8.21
--
-- Host: localhost    Database: diablo2
---------------------------------------------------------
-- Server version	3.23.49-log

--
-- Table structure for table 'accounts'
--

CREATE TABLE accounts (
  id bigint(20) NOT NULL auto_increment,
  username varchar(64) NOT NULL default '',
  password varchar(64) NOT NULL default '',
  email varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'accounts'
--


INSERT INTO accounts VALUES (1,'User','user','you@example.com');

--
-- Table structure for table 'admins'
--

CREATE TABLE admins (
  id bigint(20) NOT NULL auto_increment,
  username varchar(64) NOT NULL default '',
  password varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'admins'
--


INSERT INTO admins VALUES (1,'admin','admin');

--
-- Table structure for table 'char_types'
--

CREATE TABLE char_types (
  id int(11) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'char_types'
--


INSERT INTO char_types VALUES (1,'Amazon');
INSERT INTO char_types VALUES (2,'Assassin');
INSERT INTO char_types VALUES (3,'Necromancer');
INSERT INTO char_types VALUES (4,'Barbarian');
INSERT INTO char_types VALUES (5,'Paladin');
INSERT INTO char_types VALUES (6,'Sorceress');
INSERT INTO char_types VALUES (7,'Druid');
INSERT INTO char_types VALUES (8,'Hardcore Amazon');
INSERT INTO char_types VALUES (9,'Hardcore Assassin');
INSERT INTO char_types VALUES (10,'Hardcore Necromancer');
INSERT INTO char_types VALUES (11,'Hardcore Barbarian');
INSERT INTO char_types VALUES (12,'Hardcore Paladin');
INSERT INTO char_types VALUES (13,'Hardcore Sorceress');
INSERT INTO char_types VALUES (14,'Hardcore Druid');

--
-- Table structure for table 'characters'
--

CREATE TABLE characters (
  id bigint(20) NOT NULL auto_increment,
  owner_id bigint(20) NOT NULL default '0',
  name varchar(64) NOT NULL default '',
  type tinyint(4) NOT NULL default '0',
  experience bigint(20) NOT NULL default '0',
  flags bigint(20) NOT NULL default '0',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'characters'
--

--
-- Table structure for table 'classes'
--

CREATE TABLE classes (
  id int(11) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'classes'
--


INSERT INTO classes VALUES (1,'Ring');
INSERT INTO classes VALUES (2,'Amulet');
INSERT INTO classes VALUES (3,'Helms');
INSERT INTO classes VALUES (4,'Armor');
INSERT INTO classes VALUES (5,'Shields');
INSERT INTO classes VALUES (6,'Gloves');
INSERT INTO classes VALUES (7,'Boots');
INSERT INTO classes VALUES (8,'Belts');
INSERT INTO classes VALUES (9,'Axes');
INSERT INTO classes VALUES (10,'Bows');
INSERT INTO classes VALUES (11,'Crossbows');
INSERT INTO classes VALUES (12,'Daggers');
INSERT INTO classes VALUES (13,'Maces');
INSERT INTO classes VALUES (14,'Polearms');
INSERT INTO classes VALUES (15,'Scepters');
INSERT INTO classes VALUES (16,'Spears');
INSERT INTO classes VALUES (17,'Staves');
INSERT INTO classes VALUES (18,'Swords');
INSERT INTO classes VALUES (19,'Wands');
INSERT INTO classes VALUES (20,'Throwing Weapons');
INSERT INTO classes VALUES (21,'Claws');

--
-- Table structure for table 'item_owner'
--

CREATE TABLE item_owner (
  id bigint(20) NOT NULL auto_increment,
  owner_id bigint(20) NOT NULL default '0',
  item_id bigint(20) NOT NULL default '0',
  item_type int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'item_owner'
--

--
-- Table structure for table 'levels'
--

CREATE TABLE levels (
  id int(11) NOT NULL auto_increment,
  exp_req bigint(20) NOT NULL default '0',
  exp_next bigint(20) NOT NULL default '0',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'levels'
--


INSERT INTO levels VALUES (1,0,500);
INSERT INTO levels VALUES (2,500,1000);
INSERT INTO levels VALUES (3,1500,2250);
INSERT INTO levels VALUES (4,3750,4125);
INSERT INTO levels VALUES (5,7875,6300);
INSERT INTO levels VALUES (6,14175,8505);
INSERT INTO levels VALUES (7,22680,10206);
INSERT INTO levels VALUES (8,32886,11510);
INSERT INTO levels VALUES (9,44396,13319);
INSERT INTO levels VALUES (10,57715,14429);
INSERT INTO levels VALUES (11,72144,18036);
INSERT INTO levels VALUES (12,90180,22545);
INSERT INTO levels VALUES (13,112725,28181);
INSERT INTO levels VALUES (14,140906,35226);
INSERT INTO levels VALUES (15,176132,44033);
INSERT INTO levels VALUES (16,220165,55042);
INSERT INTO levels VALUES (17,275207,68801);
INSERT INTO levels VALUES (18,344008,86002);
INSERT INTO levels VALUES (19,430010,107503);
INSERT INTO levels VALUES (20,537513,134378);
INSERT INTO levels VALUES (21,671891,167973);
INSERT INTO levels VALUES (22,839864,209966);
INSERT INTO levels VALUES (23,1049830,262457);
INSERT INTO levels VALUES (24,1312287,328072);
INSERT INTO levels VALUES (25,1640359,410090);
INSERT INTO levels VALUES (26,2050449,512612);
INSERT INTO levels VALUES (27,2563061,640765);
INSERT INTO levels VALUES (28,3203826,698434);
INSERT INTO levels VALUES (29,3902260,761293);
INSERT INTO levels VALUES (30,4663553,829810);
INSERT INTO levels VALUES (31,5493363,904492);
INSERT INTO levels VALUES (32,6397855,985897);
INSERT INTO levels VALUES (33,7383752,1074627);
INSERT INTO levels VALUES (34,8458379,1171344);
INSERT INTO levels VALUES (35,9629723,1276765);
INSERT INTO levels VALUES (36,10906488,1391674);
INSERT INTO levels VALUES (37,12298162,1516924);
INSERT INTO levels VALUES (38,13815086,1653448);
INSERT INTO levels VALUES (39,15468534,1802257);
INSERT INTO levels VALUES (40,17270791,1964461);
INSERT INTO levels VALUES (41,19235252,2141263);
INSERT INTO levels VALUES (42,21376515,2333976);
INSERT INTO levels VALUES (43,23710491,2544034);
INSERT INTO levels VALUES (44,26254525,2772997);
INSERT INTO levels VALUES (45,29027522,3022566);
INSERT INTO levels VALUES (46,32050088,3294598);
INSERT INTO levels VALUES (47,35344686,3591112);
INSERT INTO levels VALUES (48,38935798,3914311);
INSERT INTO levels VALUES (49,42850109,4266600);
INSERT INTO levels VALUES (50,47116709,4650593);
INSERT INTO levels VALUES (51,51767302,5069147);
INSERT INTO levels VALUES (52,56836449,5525370);
INSERT INTO levels VALUES (53,62361819,6022654);
INSERT INTO levels VALUES (54,68384473,6564692);
INSERT INTO levels VALUES (55,74949165,7155515);
INSERT INTO levels VALUES (56,82104680,7799511);
INSERT INTO levels VALUES (57,89904191,8501467);
INSERT INTO levels VALUES (58,98405658,9266598);
INSERT INTO levels VALUES (59,107672256,10100593);
INSERT INTO levels VALUES (60,117772849,11009646);
INSERT INTO levels VALUES (61,128782495,12000515);
INSERT INTO levels VALUES (62,140783010,13080560);
INSERT INTO levels VALUES (63,153863570,14257811);
INSERT INTO levels VALUES (64,168121381,15541015);
INSERT INTO levels VALUES (65,183662396,16939705);
INSERT INTO levels VALUES (66,200602101,18464279);
INSERT INTO levels VALUES (67,219066380,20126064);
INSERT INTO levels VALUES (68,239192444,21937409);
INSERT INTO levels VALUES (69,261129853,23911777);
INSERT INTO levels VALUES (70,285041630,26063836);
INSERT INTO levels VALUES (71,311105466,28409582);
INSERT INTO levels VALUES (72,339515048,30966444);
INSERT INTO levels VALUES (73,370481492,33753424);
INSERT INTO levels VALUES (74,404234916,36791232);
INSERT INTO levels VALUES (75,441026148,40102443);
INSERT INTO levels VALUES (76,481128591,43711663);
INSERT INTO levels VALUES (77,524840254,47645713);
INSERT INTO levels VALUES (78,572485967,51933826);
INSERT INTO levels VALUES (79,624419793,56607872);
INSERT INTO levels VALUES (80,681027665,61702579);
INSERT INTO levels VALUES (81,742730244,67255812);
INSERT INTO levels VALUES (82,809986056,73308835);
INSERT INTO levels VALUES (83,883294891,79906630);
INSERT INTO levels VALUES (84,963201521,87098226);
INSERT INTO levels VALUES (85,1050299747,94937067);
INSERT INTO levels VALUES (86,1145236814,103481403);
INSERT INTO levels VALUES (87,1248718217,112794729);
INSERT INTO levels VALUES (88,1361512946,122946255);
INSERT INTO levels VALUES (89,1484459201,134011418);
INSERT INTO levels VALUES (90,1618470619,146072446);
INSERT INTO levels VALUES (91,1764543065,159218965);
INSERT INTO levels VALUES (92,1923762030,173548673);
INSERT INTO levels VALUES (93,2097310703,189168053);
INSERT INTO levels VALUES (94,2286478756,206193177);
INSERT INTO levels VALUES (95,2492671933,224750564);
INSERT INTO levels VALUES (96,2717422497,244978115);
INSERT INTO levels VALUES (97,2962400612,267026144);
INSERT INTO levels VALUES (98,3229426756,291058498);
INSERT INTO levels VALUES (99,3520485254,0);

--
-- Table structure for table 'set_items'
--

CREATE TABLE set_items (
  id bigint(20) NOT NULL auto_increment,
  set_id int(11) NOT NULL default '0',
  name varchar(64) NOT NULL default '',
  type int(11) NOT NULL default '0',
  speed int(11) NOT NULL default '0',
  ohdamage_min int(11) NOT NULL default '0',
  ohdamage_max int(11) NOT NULL default '0',
  thdamage_min int(11) NOT NULL default '0',
  thdamage_max int(11) NOT NULL default '0',
  defense int(11) NOT NULL default '0',
  max_durability int(11) NOT NULL default '0',
  req_level int(11) NOT NULL default '0',
  req_strength int(11) NOT NULL default '0',
  req_dex int(11) NOT NULL default '0',
  description text NOT NULL,
  PRIMARY KEY  (id),
  KEY set_id (set_id)
) TYPE=MyISAM;

--
-- Dumping data for table 'set_items'
--


INSERT INTO set_items VALUES (1,1,'Angelic Mantle',4,0,0,0,0,0,64,26,12,36,0,'+40% Enhanced Defense\nDamage Reduced by 3');
INSERT INTO set_items VALUES (2,1,'Angelic Sickle',5,2,4,9,0,0,0,32,12,25,25,'350% Damage to Undead\n+75 to Attack Rating');
INSERT INTO set_items VALUES (3,1,'Angelic Halo',3,0,0,0,0,0,0,0,12,0,0,'Replenish Life +6\n+20 to Life');
INSERT INTO set_items VALUES (4,1,'Angelic Wings',6,0,0,0,0,0,0,0,12,0,0,'20% Damage Taken Goes to Mana\n+3 to Light Radius');
INSERT INTO set_items VALUES (6,2,'Arcanna\'s Deathwand',8,2,0,0,12,28,0,50,15,0,0,'+1 to Sorceress Skill Levels\n25% Deadly Strike\n150% Damage to Undead');
INSERT INTO set_items VALUES (7,2,'Arcanna\'s Head',7,0,0,0,0,0,8,18,15,15,0,'Replenish Life +4\nAttacker Takes Damage of 2');
INSERT INTO set_items VALUES (8,2,'Arcanna\'s Flesh',9,0,0,0,0,0,90,60,15,41,0,'+2 to Light Radius\nDamage Reduced by 3');
INSERT INTO set_items VALUES (9,2,'Arcanna\'s Sign',6,0,0,0,0,0,0,0,15,0,0,'Regenerate Mana 20%\n+15 to Mana');
INSERT INTO set_items VALUES (10,3,'Arctic Furs',10,0,0,0,0,0,22,20,2,0,0,'+275-325% Enhanced Defense\nAll Resistances +10');
INSERT INTO set_items VALUES (11,3,'Arctic Binding',11,0,0,0,0,0,33,14,2,0,0,'Cold Resist 40%\n+30 Defense');
INSERT INTO set_items VALUES (12,3,'Arctic Mitts',12,0,0,0,0,0,9,18,3,45,0,'+20 to Life\n10% Increased Attack Speed');
INSERT INTO set_items VALUES (13,3,'Arctic Horn',13,3,0,0,10,22,0,0,2,35,55,'+50% Enhanced Damage\n20% Bonus To Attack Rating');
INSERT INTO set_items VALUES (14,4,'Berserker\'s Headgear',14,0,0,0,0,0,90,30,3,51,0,'+15 Defense\nFire Resist 25%');
INSERT INTO set_items VALUES (15,4,'Beserker\'s Hatchet',16,0,6,14,0,0,0,24,3,43,0,'30% Bonus to Attack Rating\n5% Mana Stolen per Hit');
INSERT INTO set_items VALUES (16,4,'Berserker\'s Hauberk',15,0,0,0,0,0,90,30,3,51,0,'+1 to Barbarian Skill Levels\nMagic Damage Reduced by 2');
INSERT INTO set_items VALUES (17,5,'Cathan\'s Visage',17,0,0,0,0,0,9,20,11,23,0,'Cold Resist 25%\n+20 to Mana');
INSERT INTO set_items VALUES (18,5,'Cathan\'s Mesh',18,0,0,0,0,0,87,45,11,24,0,'+15 Defense\nRequirements -50%');
INSERT INTO set_items VALUES (19,5,'Cathan\'s Rule',19,0,0,0,6,13,0,40,11,0,0,'+1 to Fire Skills\n+10 Maximum Fire Damage\n150% Damage to Undead');
INSERT INTO set_items VALUES (20,5,'Cathan\'s Sigil',6,0,0,0,0,0,0,0,11,0,0,'Attacker Takes Lightning Damage of 5\n10% Faster Hit Recovery');
INSERT INTO set_items VALUES (21,5,'Cathan\'s Seal',3,0,0,0,0,0,0,0,11,0,0,'6% Life Stolen per Hit\nDamage Reduced by 2');
INSERT INTO set_items VALUES (22,6,'Civerb\'s Cudgel',20,2,8,36,0,0,0,60,9,37,0,'+ (1 per Charachter Level) 1-99 to Maximum Level\n+17-23 to Max Damage (varies)\n150% Damage to Undead\n+75 to Attack Rating');
INSERT INTO set_items VALUES (23,6,'Civerb\'s Icon',6,0,0,0,0,0,0,0,9,0,0,'Replenish Life +4\nRegenerate Mana 40%');
INSERT INTO set_items VALUES (24,6,'Civerb\'s Ward',21,0,0,0,0,0,27,24,9,34,0,'+15 Defense\n+15% Increased Block');
INSERT INTO set_items VALUES (25,7,'Cleglaw\'s Tooth',22,2,3,9,0,0,0,44,4,55,39,'50% Deadly Strike\n30% Bonus to Attack Rating');
INSERT INTO set_items VALUES (26,7,'Cleglaw\'s Pincers',23,0,0,0,0,0,8,16,4,25,0,'Slows Target by 25%\nKnockback');
INSERT INTO set_items VALUES (27,7,'Cleglaw\'s Claw',24,0,0,0,0,0,25,16,4,22,0,'Poison Length Reduced by 75%\n+17 Defense');
INSERT INTO set_items VALUES (28,8,'Death\'s Touch',25,3,11,26,0,0,0,44,6,71,45,'+25% Enhanced Damage\n4% Life Stolen per Hit');
INSERT INTO set_items VALUES (29,8,'Death\'s Hand',26,0,0,0,0,0,2,12,6,0,0,'Poison Length Reduced by 75%\nPoison Resist 50%');
INSERT INTO set_items VALUES (30,8,'Death\'s Guard',27,0,0,0,0,0,22,12,6,0,0,'Cannot be Frozen\n+20 Defense');
INSERT INTO set_items VALUES (31,9,'Hsarus\' Iron Fist',28,0,0,0,0,0,4,12,3,12,0,'Damage Reduced by 2\n+10 Strength');
INSERT INTO set_items VALUES (32,9,'Hsarus\' Iron Stay',29,0,0,0,0,0,5,16,3,25,0,'Cold Resist 20%\n+20 to Life');
INSERT INTO set_items VALUES (33,9,'Hsarus\' Iron Heel',30,0,0,0,0,0,8,16,3,30,0,'20% Faster Run/Walk\nFire Resist 25%');
INSERT INTO set_items VALUES (34,10,'Infernal Cranium',31,0,0,0,0,0,3,12,5,0,0,'20% Damage Taken Goes to Mana\nAll Resistances +10');
INSERT INTO set_items VALUES (35,10,'Infernal Sign',32,0,0,0,0,0,31,18,5,45,0,'+25 Defense\n+20 to Life');
INSERT INTO set_items VALUES (36,10,'Infernal Torch',33,3,13,14,0,0,0,30,5,0,0,'+1 to Necromancer Skill Levels\n+8 to Min Damage\n150% Damage to Undead');
INSERT INTO set_items VALUES (37,11,'Iratha\'s Coil',34,0,0,0,0,0,25,50,15,55,0,'Lightning Resist +30%\nFire Resist +30%');
INSERT INTO set_items VALUES (38,11,'Iratha\'s Collar',6,0,0,0,0,0,0,0,15,0,0,'Poison Length Reduced by 75%\nPoison Resist 30%');
INSERT INTO set_items VALUES (39,11,'Iratha\'s Cord',32,0,0,0,0,0,31,18,15,45,0,'+25 Defense\n+5 to Minimum Damage');
INSERT INTO set_items VALUES (40,11,'Iratha\'s Cuff',12,0,0,0,0,0,9,18,15,45,0,'Half Freeze Duration\nCold Resist 30%');
INSERT INTO set_items VALUES (41,12,'Isenhart\'s Lightbrand',35,3,17,18,0,0,0,32,8,48,0,'+10 to Minimum Damage\n20% Increased Attack Speed');
INSERT INTO set_items VALUES (42,12,'Isenhart\'s Horns',36,0,0,0,0,0,23,30,8,41,0,'Damage Reduced by 2\n+6 to Dexterity');
INSERT INTO set_items VALUES (43,12,'Isenhart\'s Case',37,0,0,0,0,0,105,50,8,30,0,'Magic Damage Reduced by 2\n+40 Defense');
INSERT INTO set_items VALUES (44,12,'Isenhart\'s Parry',38,0,0,0,0,0,70,40,8,60,0,'Attacker Takes Lightning Damage of 4\n+40 Defense');
INSERT INTO set_items VALUES (45,13,'Milabrega\'s Diadem',34,0,0,0,0,0,25,50,17,55,0,'+15 to Mana\n+15 to Life');
INSERT INTO set_items VALUES (46,13,'Milabrega\'s Robe',39,0,0,0,0,0,218,60,17,100,0,'Damage Reduced by 2\nAttacker Takes Damage of 3');
INSERT INTO set_items VALUES (47,13,'Milabrega\'s Orb',40,0,0,0,0,0,42,30,17,47,0,'+25 Defense\n20% Better Chance of Getting Magic Items');
INSERT INTO set_items VALUES (48,13,'Milabrega\'s Rod',41,0,16,27,0,0,0,70,17,55,0,'+50% Enhanced Damage\n150% Damage to Undead\n+1 to Paladin Skills\n+2 to Light Radious');
INSERT INTO set_items VALUES (49,14,'Sigon\'s Visor',42,0,0,0,0,0,55,40,6,53,0,'+25 Defense\n+30 to Mana');
INSERT INTO set_items VALUES (50,14,'Sigon\'s Shelter',43,0,0,0,0,0,170,55,6,70,0,'+25% Enhanced Defense\nLightning Resist 30%');
INSERT INTO set_items VALUES (51,14,'Sigon\'s Sabot',44,0,0,0,0,0,12,24,5,70,0,'20% Faster Run/Walk\nCold Resist 40%');
INSERT INTO set_items VALUES (52,14,'Sigon\'s Guard',45,0,0,0,0,0,22,60,6,75,0,'+1 to All Skills\n+20% Increased Block');
INSERT INTO set_items VALUES (53,14,'Sigon\'s Wrap',46,0,0,0,0,0,8,24,6,60,0,'Fire Resist 20%\n+20 to Life');
INSERT INTO set_items VALUES (54,14,'Sigon\'s Gage',47,0,0,0,0,0,12,24,6,60,0,'+20 to Attack Rating\n+10 to Strength');
INSERT INTO set_items VALUES (55,15,'Tancred\'s Skull',48,0,0,0,0,0,33,40,20,25,0,'+10% Enhanced Damage\n+40 to Attack Rating');
INSERT INTO set_items VALUES (56,15,'Tancred\'s Spine',49,0,0,0,0,0,150,70,20,80,0,'+40 to Life\n+15 to Strength');
INSERT INTO set_items VALUES (57,15,'Tancred\'s Hobnails',50,0,0,0,0,0,2,12,20,0,0,'Heal Stamina Plus 25%\n+10 to Dexterity');
INSERT INTO set_items VALUES (58,15,'Tancred\'s Crowbill',51,4,14,21,0,0,0,26,20,49,33,'+80% Enhanced Damage\n+75 to Attack Rating');
INSERT INTO set_items VALUES (59,15,'Tancred\'s Weird',6,0,0,0,0,0,0,0,20,0,0,'Damage Reduced by 2\nMagic Damage Reduced by 1');
INSERT INTO set_items VALUES (60,16,'Vidala\'s Barb',52,2,0,0,3,18,0,0,14,40,50,'Adds 1-20 Lightning Damage');
INSERT INTO set_items VALUES (61,16,'Vidala\'s Ambush',53,0,0,0,0,0,64,24,14,15,0,'+50 Defense\n+11 to Dexterity');
INSERT INTO set_items VALUES (62,16,'Vidala\'s Fetlock',54,0,0,0,0,0,9,18,14,50,0,'30% Faster Run/Walk\n+150 to Maximum Stamina');
INSERT INTO set_items VALUES (63,16,'Vidala\'s Snare',6,0,0,0,0,0,0,0,14,0,0,'Cold Resist 20%\n+15 to Life');
INSERT INTO set_items VALUES (64,17,'Aldur\'s Stony Gaze',55,0,0,0,0,0,158,20,36,56,0,'+90 Defense\n24% Faster Hit Recovery\n+5 to Light Radius\nRegenerate Mana 17%\nCold Resist +25%');
INSERT INTO set_items VALUES (65,17,'Aldur\'s Advance',56,0,0,0,0,0,39,0,45,95,0,'Indestructible\n40% Faster Run/Walk\n+180 Maximum Stamina\n10% Damage Taken Goes to Mana\nHeal Stamina Plus 32%\n+50 to Life');
INSERT INTO set_items VALUES (66,17,'Aldur\'s Deception',57,0,0,0,0,0,746,70,76,115,0,'+300 Defense\nRequirements -50%\nLightning Resist +30%\n+15 to Dexterity\n+20 to Strength\n+1 to Elemental Skills (Druid only)\n+1 to Shape Shifting Skills (Druid only)');
INSERT INTO set_items VALUES (67,17,'Aldur\'s Rhythm',58,4,63,96,0,0,0,72,42,74,0,'+200% Enhanced Damage\n+200% Damage to Demons\n150% Damage to Undead\nAdds 50-75 Lightning Damage\n30% Increased Attack Speed\n10% Life Stolen per Hit\n5% Mana Stolen per Hit');
INSERT INTO set_items VALUES (68,18,'Bul-Kathos\' Sacred Charge',59,2,75,195,174,345,0,50,63,189,110,'35% Chance of Crushing Blow\n+200% Enhanced Damage\nAll Resistances +20\n20% Increased Attack Speed\nKnockback');
INSERT INTO set_items VALUES (69,18,'Bul-Kathos\' Tribal Guardian',60,3,120,156,0,0,0,44,66,147,124,'+200% Enhanced Damage\n+50 Poison Damage over 2 Seconds\nFire Resist +50%\n+20 to Strength\n20% Increased Attack Speed');
INSERT INTO set_items VALUES (70,19,'Cow King\'s Horns',61,0,0,0,0,0,126,12,25,20,0,'35% Damage Takes Goes to Mana\nHalf Freeze Duration\n+75 Defense\nAttacker Takes Damage of 10');
INSERT INTO set_items VALUES (71,19,'Cow King\'s Hide',62,0,0,0,0,0,51,32,18,27,0,'18% Chance to Cast Level 5 Chain Lightning When Struck\n+60% Enhanced Defense\nAll Resistances +18\n+30 to Life');
INSERT INTO set_items VALUES (72,19,'Cow King\'s Hooves',63,0,0,0,0,0,30,14,13,18,0,'+25-35 Defense\n30% Faster Run/Walk\nAdds 25-35 Fire Damage\n+20 to Dexterity\n25% Better Chance of Getting Magic Items');
INSERT INTO set_items VALUES (73,20,'Telling of Beads',6,0,0,0,0,0,0,0,30,0,0,'+1 to All Skill Levels\nPoison Resist +35-50%\nCold Resist +18%\nAttacker Takes Damage of 8-10');
INSERT INTO set_items VALUES (74,20,'Laying of Hands',64,0,0,0,0,0,79,12,63,50,0,'+25 Defense\n20% Increased Attack Speed\n+350% Damage to Demons\nFire Resist +50%\n10% Chance to Cast Level 3 Holy Bolt on Attack');
INSERT INTO set_items VALUES (75,20,'Dark Adherent',65,0,0,0,0,0,666,20,43,77,0,'+305-415 Defense\nFire Resist +24%\n25% Chance of Casting Level 3 Nova When Struck\nAdds 4-6 Poison Damage over 2 Seconds');
INSERT INTO set_items VALUES (76,20,'Rite of Passage',66,0,0,0,0,0,53,12,29,20,0,'+25 Defense\n30% Faster Run/Walk\n+15-25 Maximum Stamina\nHalf Freeze Duration');
INSERT INTO set_items VALUES (77,20,'Credendum',67,0,0,0,0,0,108,16,65,106,0,'+50 Defense\nAll Resistances +15\n+10 to Dexterity\n+10 to Strength');
INSERT INTO set_items VALUES (78,21,'Griswold\'s Heart',68,0,0,0,0,0,917,60,45,102,0,'+500 Defense\nRequirements -40%\n+20 to Strength\n+2 to Defensive Aura Skills (Paladin only)\nSocketed (3)');
INSERT INTO set_items VALUES (79,21,'Griswold\'s Valor',69,0,0,0,0,0,166,50,69,105,0,'+50-70% Enhanced Defense\nRequirements -40%\nAll Resistances +5\n20-30% Better Chance of Getting Magic Items\nSocketed (2)');
INSERT INTO set_items VALUES (80,21,'Griswold\'s Redemption',70,2,102,118,0,0,0,70,53,59,42,'+175% Enhanced Damage\n350% Damage to Undead\nRequirements -20%\n40% Increased Attack Speed\nSocketed (3)');
INSERT INTO set_items VALUES (81,21,'Griswold\'s Honor',71,0,0,0,0,0,246,90,68,148,0,'65% Faster Block Rate\n+108 Defense\nSocketed (3)');
INSERT INTO set_items VALUES (82,22,'Haemosu\'s Adament',72,0,0,0,0,0,688,50,44,52,0,'+500 Defense\n+40 Damage vs. Melee\n+35 Damage vs. Missile\nRequirements -20%\n+75 to Life');
INSERT INTO set_items VALUES (83,22,'Dangoon\'s Teaching',73,3,41,50,0,0,0,60,68,145,46,'+(1.5 per Character Level) + 1.5-148.5 to Maximum Damage\n150% Damage to Undead\n40% Increased Attack Speed\n10% Chance to Cast Level 3 Frost Nova on Attack\nAdds 20-30 Fire Damage');
INSERT INTO set_items VALUES (84,22,'Taebaek\'s Glory',74,0,0,0,0,0,203,0,81,185,0,'+50 Defense\n+25% Increased Chance of Blocking\nLightning Resist +30%\nIndestructible\n30% Faster Block Rate\n+100 to Mana\nAttacker Takes Damage of 30');
INSERT INTO set_items VALUES (85,22,'Ondal\'s Almighty',75,0,0,0,0,0,164,40,69,116,0,'10% Chance to Cast Level 3 Weaken on Attack\n24% Faster Hit Recovery\nRequirements -40%\n+50 Defense\n+15 to Dexterity\n+10 to Strength');
INSERT INTO set_items VALUES (86,23,'Hwanin\'s Splendor',76,0,0,0,0,0,158,50,45,103,0,'+100% Enhanced Defense\nReplenish Life +20\nMagic Damage Reduced by 10\nCold Resist +37%');
INSERT INTO set_items VALUES (87,23,'Hwanin\'s Justice',77,3,0,0,45,162,0,0,28,95,0,'+200% Enhanced Defense\nAdds 5-25 Lightning Damage\n40% Increased Attack Speed\n+330 to Attack Rating\nIndestructible\n10% Chance to Cast Level 3 Ice Blast on Striking');
INSERT INTO set_items VALUES (88,23,'Hwanin\'s Refuge',78,0,0,0,0,0,376,36,30,86,0,'+200 Defense\n10% Chance to Cast Level 3 Static Field When Struck\nPoison Resist +27%\n+100 to Life');
INSERT INTO set_items VALUES (89,23,'Hwanin\'s Blessing',29,0,0,0,0,0,6,16,35,25,0,'+(1.5 per Character Level) 1.5-148.5 Defense\nAdds 3-33 Lightning Damage\nPrevent Monster Heal\n12% Damage Taken Goes to Mana');
INSERT INTO set_items VALUES (90,24,'Immortal King\'s Will',79,0,0,0,0,0,160,55,47,65,0,'+4 to Light Radius\n+125 Defense\n37% Extra Gold from Monsters\n25-40% Better Chance of Finding Magic Items\n+2 to Warcries Skills (Barbarian only)');
INSERT INTO set_items VALUES (91,24,'Immortal King\'s Stone Crusher',80,4,0,0,234,321,0,0,76,225,0,'+200% Enhanced Damage\n+200% Damage to Demons\n+150% Damage to Undead\n40% Increased Attack Speed\nIndestructible\n35-40% Chance of Crushing Blow');
INSERT INTO set_items VALUES (92,24,'Immortal King\'s Soul Cage',81,0,0,0,0,0,887,60,76,232,0,'+400 Defense\n5% Chance to Cast Level 5 Enchant when Struck\nPoison Resist +50%\n+2 to Combat Skills (Barbarian only)');
INSERT INTO set_items VALUES (93,24,'Immortal King\'s Detail',82,0,0,0,0,0,77,24,29,110,0,'+36 Defense\nLightning Resist +31%\nFire Resist +28%\n+25 to Strength');
INSERT INTO set_items VALUES (94,24,'Immortal King\'s Forge',83,0,0,0,0,0,108,24,30,110,0,'12% Chance to Cast Level 4 Charged Bolt when Struck\n+65 Defense\n+20 to Dexterity\n+20 to Strength');
INSERT INTO set_items VALUES (95,24,'Immortal King\'s Pillar',84,0,0,0,0,0,118,24,31,125,0,'+75 Defense\n40% Faster Run/Walk\n+110 to Attack Rating\n+44 to Life');
INSERT INTO set_items VALUES (96,25,'M\'avina\'s True Sight',85,0,0,0,0,0,200,20,64,0,0,'+150 Defense\nReplenish Life +10\n+25 to Mana\n30% Increased Attack Speed');
INSERT INTO set_items VALUES (97,25,'M\'avina\'s Caster',86,3,0,0,43,210,0,0,70,108,52,'+188% Enhanced Damage\n40% Increased Attack Speed\n+50 to Attack Rating\n10% Chance to Cast Level 3 Nova When Struck');
INSERT INTO set_items VALUES (98,25,'M\'avina\'s Embrace',87,0,0,0,0,0,767,48,70,122,0,'Requirements -30%\n10% Chance to Cast Level 3 Glacial Spike When Struck\nMagic Damage Reduced by 5-12\n+ (4 per Character Level) 4-396 Defense\n+2 to Passive and Magic Skills (Amazon only)\n+350 Defense');
INSERT INTO set_items VALUES (99,25,'M\'avina\'s Icy Clutch',89,0,0,0,0,0,85,18,32,88,0,'+45-50 Defense\n6-18 Cold Damage\nHalf Freeze Duration\n56% Extra Gold from Monsters\n+10 to Strength\n+15 to Dexterity');
INSERT INTO set_items VALUES (100,25,'M\'avina\'s Tenet',88,0,0,0,0,0,81,14,45,20,0,'+50 Defense\n20% Faster Run/Walk\n+5 to Light Radius\n5% Mana Stolen per Hit');
INSERT INTO set_items VALUES (101,26,'Natalya\'s Totem',90,0,0,0,0,0,195,40,59,58,0,'+135 Defense\nMagic Damage Reduced by 3\nAll Resistances +10\n+25 to Dexterity\n+10 to Strength');
INSERT INTO set_items VALUES (102,26,'Natalya\'s Mark',91,3,123,156,0,0,0,68,79,118,118,'+200% Enhanced Damage\n+200% Damage to Undead\n+200% Damage to Demons\nAdds 12-17 Fire Damage\nIgnore Target\'s Defense\n40% Increased Attack Speed\n+50 Cold Damage');
INSERT INTO set_items VALUES (103,26,'Natalya\'s Shadow',92,0,0,0,0,0,540,36,73,149,0,'+ (1 per Character Level) 1-99 to Life\nPoison Length Reduced by 75%\nPoison Resist +25%\n+150 to Defense\n+2 to Shadow Disciplines Skills (Assasin only)');
INSERT INTO set_items VALUES (104,26,'Natalya\'s Soul',93,0,0,0,0,0,112,66,25,65,0,'+75 Defense\n40% Faster Run/Walk\nHeal Stamina Plus (0.25 per Characther Level)\nCold Resist +15%\nLightning Resist +15%');
INSERT INTO set_items VALUES (105,27,'Naj\'s Circlet',94,0,0,0,0,0,95,35,28,0,0,'+75 Defense\n+25-35 Fire Damage\n+5 to Light Radius\n12% Chance to Cast Level 5 Chain Lightening When Struck\n+15 to Strength');
INSERT INTO set_items VALUES (106,27,'Naj\'s Light Plate',95,0,0,0,0,0,721,60,71,79,0,'+300 Defense\nRequirements -60%\n45% Damage Taken Goes to Mana\n+1 to All Skill Levels\nAll Resistances +25\n+65 to Life');
INSERT INTO set_items VALUES (107,27,'Naj\'s Puzzler',96,2,0,0,200,232,0,35,78,44,37,'+150% Enhanced Damage\n150% Damage to Undead\nAdds 6-45 Lightning Damage\n30% Faster Cast Rate\n+1 to All Skill Levels\n+70 to Mana\n+35 to Energy');
INSERT INTO set_items VALUES (108,28,'Guillaume\'s Face',97,0,0,0,0,0,187,40,34,115,0,'+120% Enhanced Defense\n30% Faster Hit Recovery\n15% Deadly Strike\n35% Chance of Crushing Blow\n+15 to Strength');
INSERT INTO set_items VALUES (109,28,'Whitstan\'s Guard',98,0,0,0,0,0,129,64,29,53,0,'+175% Enhanced Defense\nHalf Freeze Duration\n40% Faster Block Rate\n+55% Increased Chance of Blocking\n+5 to Light Radius');
INSERT INTO set_items VALUES (110,28,'Magnus\' Skin',99,0,0,0,0,0,49,14,37,20,0,'+50% Enhanced Defense\n20% Increased Attack Speed\n+100 to Attack Rating\n+3 to Light Radius\nFire Resist +15%');
INSERT INTO set_items VALUES (111,28,'Wilhelm\'s Pride',100,0,0,0,0,0,64,18,42,88,0,'+75% Enhanced Defense\n5% Life Stolen per Hit\nCold Resist +10%');
INSERT INTO set_items VALUES (112,29,'Sander\'s Paragon',31,0,0,0,0,0,4,12,25,0,0,'+(1 per Character Level) 1-99 Defense\nAttacker Takes Damage of 8\n35% Chance of Getting Better Magic Items');
INSERT INTO set_items VALUES (113,29,'Sander\'s Superstition',101,3,7,14,0,0,0,15,25,0,0,'+75% Enhanced Damage\n150% Damage to Undead\n20% Faster Cast Rate\n+25 to Mana\n8% Mana Steal\n25-75 Cold Damage');
INSERT INTO set_items VALUES (114,29,'Sander\'s Taboo',102,0,0,0,0,0,25,14,28,0,0,'Adds 9-11 Poison Damage over 3 Seconds\n+20-25 Defense\n+40 to Life\n20% Increased Attack Speed');
INSERT INTO set_items VALUES (115,29,'Sander\'s Riprap',63,0,0,0,0,0,5,14,20,18,0,'40% Faster Run/Walk\n+100 to Attack Rating\n+10 to Dexterity\n+5 to Strength');
INSERT INTO set_items VALUES (116,30,'Sazabi\'s Mental Sheath',103,0,0,0,0,0,175,30,43,82,0,'+1 to All Skill Levels\nLightning Resist +15-20%\nFire Resist +15-20%\n+100 Defense');
INSERT INTO set_items VALUES (117,30,'Sazabi\'s Cobalt Redeemer',104,2,12,192,0,0,0,0,73,99,109,'+150% Enhanced Damage\n418% Damage to Demons\nAdds 25-35 Cold Daamge\n40% Increased Attack Speed\nIndestructible\n+15 to Dexterity\n+5 to Strength');
INSERT INTO set_items VALUES (118,30,'Sazabi\'s Ghost Liberator',105,0,0,0,0,0,810,30,67,165,0,'+400 Defense\n30% Faster Hit Recovery\n+300 to Attack Rating Against Demons\n+50-75 to Life\n+25 to Strength');
INSERT INTO set_items VALUES (119,31,'Tal Rasha\'s Lidless Eye',106,2,18,42,0,0,0,50,65,0,0,'20% Faster Cast Rate\n+77 to Mana\n+57 to Life\n+10 to Energy\n+1 to Lightning Mastery (Sorceress only)\n+2 to Fire Mastery (Sorceress only)\n+1 to Cold Mastery');
INSERT INTO set_items VALUES (120,31,'Tal Rasha\'s Horadric Crest',2,0,0,0,0,0,99,20,66,65,0,'10% Life Stolen per Hit\n10% Mana Stolen per Hit\nAll Resistances +15\n+45 Defense\n+30 to Mana\n+60 to Life');
INSERT INTO set_items VALUES (121,31,'Tal Rasha\'s Guardianship',107,0,0,0,0,0,833,55,71,84,0,'+400 Defense\nRequirements -60%\nMagic Damage Reduced by 15\nCold Resist +40%\nLightning Resist +40%\nFire Resist +40%\n88% Better Chance of Getting Magic Items');
INSERT INTO set_items VALUES (122,31,'Tal Rasha\'s Fine-Spun Cloth',108,0,0,0,0,0,35,16,53,47,0,'Requirements -20%\n37% Damage Taken Goes to Mana\n+30 to Mana\n+20 to Dexterity\n10-15% Better Chance of Getting Magic Items');
INSERT INTO set_items VALUES (123,31,'Tal Rasha\'s Adjudication',6,0,0,0,0,0,0,0,67,0,0,'+2 to Sorceress Skill Levels\nLightning Resist +33%\nAdds 3-32 Lightning Damage\n+42 to Mana\n+50 to Life');
INSERT INTO set_items VALUES (124,32,'Trang-Oul\'s Guise',109,0,0,0,0,0,180,40,65,108,0,'24% Faster Hit Recovery\nReplenish Life +5\n+80-100 Defense\n+150 to Mana\nAttacker Takes Damage of 20');
INSERT INTO set_items VALUES (125,32,'Trang-Oul\'s Scales',110,0,0,0,0,0,787,70,49,84,0,'+150% Enhanced Defense\nRequirements -40%\n40% Faster Run/Walk\nPoison Resist +40%\n+100 Defense vs. Missiles\n+2 to Summoning Skills (Necromancer only)');
INSERT INTO set_items VALUES (126,32,'Trang-Oul\'s Wing',111,0,0,0,0,0,175,20,54,50,0,'+125 Defense\n+30% Increased Chance of Blocking\nPoison Resist +40%\nFire Resist +38-45%\n+15 to Dexterity\n+25 to Strength\n+2 to Poison and Bone Skills (Necromancer only)');
INSERT INTO set_items VALUES (127,32,'Trang-Oul\'s Girth',112,0,0,0,0,0,134,18,62,91,0,'+75-100 Defense\nRequirements -40%\nCannot Be Frozen\nReplenish Life +5\n+25-50 to Mana\n+30 Maximum Stamina\n+66 to Life');
INSERT INTO set_items VALUES (128,32,'Trang-Oul\'s Claws',113,0,0,0,0,0,67,16,45,58,0,'20% Faster Cast Rate\nCold Resist +30%\n+30 Defense\n+2 to Curses (Necromancer only)');

--
-- Table structure for table 'sets'
--

CREATE TABLE sets (
  id int(11) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'sets'
--


INSERT INTO sets VALUES (1,'Angelic Raiment');
INSERT INTO sets VALUES (2,'Arcanna\'s Tricks');
INSERT INTO sets VALUES (3,'Arctic Gear');
INSERT INTO sets VALUES (4,'Beserker\'s Arsenal');
INSERT INTO sets VALUES (5,'Cathan\'s Traps');
INSERT INTO sets VALUES (6,'Civerb\'s Vestments');
INSERT INTO sets VALUES (7,'Cleglaw\'s Brace');
INSERT INTO sets VALUES (8,'Death\'s Disguise');
INSERT INTO sets VALUES (9,'Hsaru\'s Defense');
INSERT INTO sets VALUES (10,'Infernal Tools');
INSERT INTO sets VALUES (11,'Iratha\'s Finery');
INSERT INTO sets VALUES (12,'Isenhart\'s Armory');
INSERT INTO sets VALUES (13,'Milabrega\'s Regalia');
INSERT INTO sets VALUES (14,'Sigon\'s Complete Steel');
INSERT INTO sets VALUES (15,'Tancred\'s Battlegear');
INSERT INTO sets VALUES (16,'Vidala\'s Rig');
INSERT INTO sets VALUES (17,'Aldur\'s Watchtower');
INSERT INTO sets VALUES (18,'Bul-Kathos\' Children');
INSERT INTO sets VALUES (19,'Cow King\'s Leathers');
INSERT INTO sets VALUES (20,'The Disciple');
INSERT INTO sets VALUES (21,'Griswold\'s Legacy');
INSERT INTO sets VALUES (22,'Heaven\'s Brethren');
INSERT INTO sets VALUES (23,'Hwanin\'s Majesty');
INSERT INTO sets VALUES (24,'Immortal King');
INSERT INTO sets VALUES (25,'M\'avina\'s Battle Hymn');
INSERT INTO sets VALUES (26,'Natalya\'s Odium');
INSERT INTO sets VALUES (27,'Naj\'s Ancient Vestige');
INSERT INTO sets VALUES (28,'Orphan\'s Call');
INSERT INTO sets VALUES (29,'Sander\'s Folly');
INSERT INTO sets VALUES (30,'Sazabi\'s Grand Tribute');
INSERT INTO sets VALUES (31,'Tal Rasha\'s Wrappings');
INSERT INTO sets VALUES (32,'Trang-Oul\'s Avatar');

--
-- Table structure for table 'speeds'
--

CREATE TABLE speeds (
  id int(11) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'speeds'
--


INSERT INTO speeds VALUES (1,'Very Fast');
INSERT INTO speeds VALUES (2,'Fast');
INSERT INTO speeds VALUES (3,'Normal');
INSERT INTO speeds VALUES (4,'Slow');
INSERT INTO speeds VALUES (5,'Very Slow');

--
-- Table structure for table 'types'
--

CREATE TABLE types (
  id int(11) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  class_id int(11) NOT NULL default '0',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'types'
--


INSERT INTO types VALUES (1,'Dimensional Blade',18);
INSERT INTO types VALUES (2,'Death Mask',3);
INSERT INTO types VALUES (3,'Ring',1);
INSERT INTO types VALUES (4,'Ring Mail',4);
INSERT INTO types VALUES (5,'Sabre',18);
INSERT INTO types VALUES (6,'Amulet',2);
INSERT INTO types VALUES (7,'Skull Cap',3);
INSERT INTO types VALUES (8,'War Staff',17);
INSERT INTO types VALUES (9,'Light Plate',4);
INSERT INTO types VALUES (10,'Quilted Armor',4);
INSERT INTO types VALUES (11,'Light Belt',8);
INSERT INTO types VALUES (12,'Light Gauntlets',6);
INSERT INTO types VALUES (13,'Short War Bow',10);
INSERT INTO types VALUES (14,'Helm',3);
INSERT INTO types VALUES (15,'Splint Mail',4);
INSERT INTO types VALUES (16,'Double Axe',9);
INSERT INTO types VALUES (17,'Mask',3);
INSERT INTO types VALUES (18,'Chain Mail',4);
INSERT INTO types VALUES (19,'Battle Staff',17);
INSERT INTO types VALUES (20,'Grand Scepter',13);
INSERT INTO types VALUES (21,'Large Shield',5);
INSERT INTO types VALUES (22,'Long Sword',18);
INSERT INTO types VALUES (23,'Chain Gloves',6);
INSERT INTO types VALUES (24,'Small Shield',5);
INSERT INTO types VALUES (25,'War Sword',18);
INSERT INTO types VALUES (26,'Leather Gloves',6);
INSERT INTO types VALUES (27,'Sash',8);
INSERT INTO types VALUES (28,'Buckler',5);
INSERT INTO types VALUES (29,'Belt',8);
INSERT INTO types VALUES (30,'Chain Boots',7);
INSERT INTO types VALUES (31,'Cap',3);
INSERT INTO types VALUES (32,'Heavy Belt',8);
INSERT INTO types VALUES (33,'Grim Wand',19);
INSERT INTO types VALUES (34,'Crown',3);
INSERT INTO types VALUES (35,'Broad Sword',18);
INSERT INTO types VALUES (36,'Full Helm',3);
INSERT INTO types VALUES (37,'Breast Plate',4);
INSERT INTO types VALUES (38,'Gothic Shield',5);
INSERT INTO types VALUES (39,'Ancient Armor',4);
INSERT INTO types VALUES (40,'Kite Shield',5);
INSERT INTO types VALUES (41,'War Scepter',13);
INSERT INTO types VALUES (42,'Great Helm',3);
INSERT INTO types VALUES (43,'Gothic Plate',4);
INSERT INTO types VALUES (44,'Greaves',7);
INSERT INTO types VALUES (45,'Tower Shield',5);
INSERT INTO types VALUES (46,'Plated Belt',8);
INSERT INTO types VALUES (47,'Gauntlets',6);
INSERT INTO types VALUES (48,'Bone Helm',3);
INSERT INTO types VALUES (49,'Full Plate Mail',4);
INSERT INTO types VALUES (50,'Boots',7);
INSERT INTO types VALUES (51,'Military Pick',13);
INSERT INTO types VALUES (52,'Long Battle Bow',10);
INSERT INTO types VALUES (53,'Leather Armor',4);
INSERT INTO types VALUES (54,'Light Plated Boots',7);
INSERT INTO types VALUES (55,'Hunter\'s Guise',3);
INSERT INTO types VALUES (56,'Battle Boots',7);
INSERT INTO types VALUES (57,'Shadow Plate',4);
INSERT INTO types VALUES (58,'Jagged Star',13);
INSERT INTO types VALUES (59,'Colossus Blade',18);
INSERT INTO types VALUES (60,'Mythical Sword',18);
INSERT INTO types VALUES (61,'War Hat',3);
INSERT INTO types VALUES (62,'Studded Leather',4);
INSERT INTO types VALUES (63,'Heavy Boots',7);
INSERT INTO types VALUES (64,'Bramble Mitts',6);
INSERT INTO types VALUES (65,'Dusk Shroud',4);
INSERT INTO types VALUES (66,'Demonhide Boots',7);
INSERT INTO types VALUES (67,'Mithril Coil',8);
INSERT INTO types VALUES (68,'Ornate Plate',4);
INSERT INTO types VALUES (69,'Corona',3);
INSERT INTO types VALUES (70,'Caduceus',15);
INSERT INTO types VALUES (71,'Vortex Shield',5);
INSERT INTO types VALUES (72,'Cuirass',4);
INSERT INTO types VALUES (73,'Reinforced Mace',13);
INSERT INTO types VALUES (74,'Ward',19);
INSERT INTO types VALUES (75,'Spired Helm',3);
INSERT INTO types VALUES (76,'Grand Crown',3);
INSERT INTO types VALUES (77,'Bill',14);
INSERT INTO types VALUES (78,'Tigulated Mail',4);
INSERT INTO types VALUES (79,'Avenger Guard',3);
INSERT INTO types VALUES (80,'Ogre Maul',13);
INSERT INTO types VALUES (81,'Sacred Armor',4);
INSERT INTO types VALUES (82,'War Belt',8);
INSERT INTO types VALUES (83,'War Gauntlets',6);
INSERT INTO types VALUES (84,'War Boots',7);
INSERT INTO types VALUES (85,'Diadem',3);
INSERT INTO types VALUES (86,'Grand Matron Bow',10);
INSERT INTO types VALUES (87,'Kraken Shell',4);
INSERT INTO types VALUES (88,'Sharkskin Belt',8);
INSERT INTO types VALUES (89,'Battle Gauntlets',6);
INSERT INTO types VALUES (90,'Grim Helm',3);
INSERT INTO types VALUES (91,'Scissors Suwayyah',21);
INSERT INTO types VALUES (92,'Loricated Mail',4);
INSERT INTO types VALUES (93,'Mesh Boots',7);
INSERT INTO types VALUES (94,'Circlet',3);
INSERT INTO types VALUES (95,'Hellforge Plate',4);
INSERT INTO types VALUES (96,'Elder Staff',17);
INSERT INTO types VALUES (97,'Winged Helm',3);
INSERT INTO types VALUES (98,'Round Shield',5);
INSERT INTO types VALUES (99,'Sharkskin Gloves',6);
INSERT INTO types VALUES (100,'Battle Belt',8);
INSERT INTO types VALUES (101,'Bone Wand',19);
INSERT INTO types VALUES (102,'Heavy Gloves',6);
INSERT INTO types VALUES (103,'Basinet',3);
INSERT INTO types VALUES (104,'Cryptic Sword',18);
INSERT INTO types VALUES (105,'Balrog Skin',4);
INSERT INTO types VALUES (106,'Swirling Crystal',19);
INSERT INTO types VALUES (107,'Lacquered Plate',4);
INSERT INTO types VALUES (108,'Mesh Belt',8);
INSERT INTO types VALUES (109,'Bone Visage',3);
INSERT INTO types VALUES (110,'Chaos Armor',4);
INSERT INTO types VALUES (111,'Cantor Trophy',4);
INSERT INTO types VALUES (112,'Troll Belt',8);
INSERT INTO types VALUES (113,'Heavy Bracers',6);
INSERT INTO types VALUES (114,'Crystal Sword',18);
INSERT INTO types VALUES (115,'Arbalest',11);
INSERT INTO types VALUES (116,'War Fork',16);
INSERT INTO types VALUES (117,'Short Battle Bow',10);
INSERT INTO types VALUES (118,'Plate Mail',4);
INSERT INTO types VALUES (119,'War Hammer',13);
INSERT INTO types VALUES (120,'Morning Star',13);
INSERT INTO types VALUES (121,'Scale Mail',4);
INSERT INTO types VALUES (122,'Light Crossbow',11);
INSERT INTO types VALUES (123,'Giant Sword',18);
INSERT INTO types VALUES (124,'Cudgel',13);
INSERT INTO types VALUES (125,'Bone Shield',5);
INSERT INTO types VALUES (126,'Kris',12);
INSERT INTO types VALUES (127,'Lochaber Axe',14);
INSERT INTO types VALUES (128,'Great Sword',18);
INSERT INTO types VALUES (129,'Hatchet',9);
INSERT INTO types VALUES (130,'Scythe',14);
INSERT INTO types VALUES (131,'War Axe',9);
INSERT INTO types VALUES (132,'Wand',19);
INSERT INTO types VALUES (133,'Defender',5);
INSERT INTO types VALUES (134,'Axe',9);
INSERT INTO types VALUES (135,'Trident',14);
INSERT INTO types VALUES (136,'War Scythe',14);
INSERT INTO types VALUES (137,'Halberd',14);
INSERT INTO types VALUES (138,'Double Bow',10);
INSERT INTO types VALUES (139,'Long War Bow',10);
INSERT INTO types VALUES (140,'Military Axe',9);
INSERT INTO types VALUES (141,'Dacian Falx',18);
INSERT INTO types VALUES (142,'Cleaver',9);
INSERT INTO types VALUES (143,'Long Bow',10);
INSERT INTO types VALUES (144,'Ceremonial Pike',16);
INSERT INTO types VALUES (145,'Slayer Guard',3);
INSERT INTO types VALUES (146,'Hierophant Trophy',5);
INSERT INTO types VALUES (147,'Greater Talons',21);
INSERT INTO types VALUES (148,'Gilded Shield',5);
INSERT INTO types VALUES (149,'Ceremonial Bow',10);
INSERT INTO types VALUES (150,'Totemic Mask',3);
INSERT INTO types VALUES (151,'Ceremonial Javelin',16);
INSERT INTO types VALUES (152,'Hard Leather Armor',4);
INSERT INTO types VALUES (153,'Field Plate',4);
INSERT INTO types VALUES (154,'Spiked Shield',5);
INSERT INTO types VALUES (155,'Sallet',3);
INSERT INTO types VALUES (156,'Casque',3);
INSERT INTO types VALUES (157,'Ghost Armor',4);
INSERT INTO types VALUES (158,'Serpentskin Armor',4);
INSERT INTO types VALUES (159,'Demonhide Armor',4);
INSERT INTO types VALUES (160,'Trellised Armor',4);
INSERT INTO types VALUES (161,'Linked Mail',4);
INSERT INTO types VALUES (162,'Mesh Armor',4);
INSERT INTO types VALUES (163,'Russet Armor',4);
INSERT INTO types VALUES (164,'Mage Plate',4);
INSERT INTO types VALUES (165,'Templar Coat',4);
INSERT INTO types VALUES (166,'Sharktooth Armor',4);
INSERT INTO types VALUES (167,'Embossed Plate',4);
INSERT INTO types VALUES (168,'Tomb Wand',19);
INSERT INTO types VALUES (169,'Burnt Wand',19);
INSERT INTO types VALUES (170,'Scutum',5);
INSERT INTO types VALUES (171,'Dragon Shield',5);
INSERT INTO types VALUES (172,'Barbed Shield',5);
INSERT INTO types VALUES (173,'Pavise',5);
INSERT INTO types VALUES (174,'Grim Shield',5);
INSERT INTO types VALUES (175,'Ancient Shield',5);
INSERT INTO types VALUES (176,'Demonhide Gloves',6);
INSERT INTO types VALUES (177,'Sharkskin Boots',7);
INSERT INTO types VALUES (178,'Demonhide Sash',8);
INSERT INTO types VALUES (179,'Shako',3);
INSERT INTO types VALUES (180,'Wire Fleece',4);
INSERT INTO types VALUES (181,'Petrified Wand',19);
INSERT INTO types VALUES (182,'Luna',5);
INSERT INTO types VALUES (183,'Monarch',5);
INSERT INTO types VALUES (184,'Vampirefang Belt',8);
INSERT INTO types VALUES (185,'Hand Axe',9);
INSERT INTO types VALUES (186,'Large Axe',9);
INSERT INTO types VALUES (187,'Broad Axe',9);
INSERT INTO types VALUES (188,'Battle Axe',9);
INSERT INTO types VALUES (189,'Great Axe',9);
INSERT INTO types VALUES (190,'Giant Axe',9);
INSERT INTO types VALUES (191,'Short Bow',10);
INSERT INTO types VALUES (192,'Hunter\'s Bow',10);
INSERT INTO types VALUES (193,'Composite Bow',10);
INSERT INTO types VALUES (194,'Crossbow',11);
INSERT INTO types VALUES (195,'Heavy Crossbow',11);
INSERT INTO types VALUES (196,'Repeating Crossbow',11);
INSERT INTO types VALUES (197,'Dagger',12);
INSERT INTO types VALUES (198,'Dirk',12);
INSERT INTO types VALUES (199,'Blade',12);
INSERT INTO types VALUES (200,'Club',13);
INSERT INTO types VALUES (201,'Spiked Club',13);
INSERT INTO types VALUES (202,'Mace',13);
INSERT INTO types VALUES (203,'Flail',13);
INSERT INTO types VALUES (204,'Maul',13);
INSERT INTO types VALUES (205,'Great Maul',13);
INSERT INTO types VALUES (206,'Bardiche',14);
INSERT INTO types VALUES (207,'Voulge',14);
INSERT INTO types VALUES (208,'Poleaxe',14);
INSERT INTO types VALUES (209,'Scepter',13);
INSERT INTO types VALUES (210,'Spear',16);
INSERT INTO types VALUES (211,'Brandistock',16);
INSERT INTO types VALUES (212,'Spetum',16);
INSERT INTO types VALUES (213,'Pike',16);
INSERT INTO types VALUES (214,'Short Staff',17);
INSERT INTO types VALUES (215,'Long Staff',17);
INSERT INTO types VALUES (216,'Gnarled Staff',17);
INSERT INTO types VALUES (217,'Short Sword',18);
INSERT INTO types VALUES (218,'Scimitar',18);
INSERT INTO types VALUES (219,'Falchion',18);
INSERT INTO types VALUES (220,'Two-handed Sword',18);
INSERT INTO types VALUES (221,'Claymore',18);
INSERT INTO types VALUES (222,'Bastard Sword',18);
INSERT INTO types VALUES (223,'Flamberge',18);
INSERT INTO types VALUES (224,'Yew Wand',19);
INSERT INTO types VALUES (225,'Twin Axe',9);
INSERT INTO types VALUES (226,'Crowbill',9);
INSERT INTO types VALUES (227,'Naga',9);
INSERT INTO types VALUES (228,'Bearded Axe',9);
INSERT INTO types VALUES (229,'Tabar',9);
INSERT INTO types VALUES (230,'Gothic Axe',9);
INSERT INTO types VALUES (231,'Ancient Axe',9);
INSERT INTO types VALUES (232,'Edge Bow',10);
INSERT INTO types VALUES (233,'Razor Bow',10);
INSERT INTO types VALUES (234,'Cedar Bow',10);
INSERT INTO types VALUES (235,'Short Siege Bow',10);
INSERT INTO types VALUES (236,'Large Siege Bow',10);
INSERT INTO types VALUES (237,'Rune Bow',10);
INSERT INTO types VALUES (238,'Gothic Bow',10);
INSERT INTO types VALUES (239,'Ballista',11);
INSERT INTO types VALUES (240,'Siege Crossbow',11);
INSERT INTO types VALUES (241,'Chu-Ko-Nu',11);
INSERT INTO types VALUES (242,'Poignard',12);
INSERT INTO types VALUES (243,'Rondel',12);
INSERT INTO types VALUES (244,'Cinquedeas',12);
INSERT INTO types VALUES (245,'Stiletto',12);
INSERT INTO types VALUES (246,'Barbed Club',13);
INSERT INTO types VALUES (247,'Flanged Mace',13);
INSERT INTO types VALUES (248,'Knout',13);
INSERT INTO types VALUES (249,'Battle Hammer',13);
INSERT INTO types VALUES (250,'War Club',13);
INSERT INTO types VALUES (251,'Martel de Fer',13);
INSERT INTO types VALUES (252,'Battle Scythe',14);
INSERT INTO types VALUES (253,'Partizan',14);
INSERT INTO types VALUES (254,'Bec-De-Corbin',14);
INSERT INTO types VALUES (255,'Grim Scythe',14);
INSERT INTO types VALUES (256,'Rune Scepter',13);
INSERT INTO types VALUES (257,'Holy Water Sprinkler',13);
INSERT INTO types VALUES (258,'Divine Scepter',13);
INSERT INTO types VALUES (259,'War Spear',16);
INSERT INTO types VALUES (260,'Fuscina',16);
INSERT INTO types VALUES (261,'Yari',16);
INSERT INTO types VALUES (262,'Lance',16);
INSERT INTO types VALUES (263,'Jo Staff',17);
INSERT INTO types VALUES (264,'Quarterstaff',17);
INSERT INTO types VALUES (265,'Cedar Staff',17);
INSERT INTO types VALUES (266,'Gothic Staff',17);
INSERT INTO types VALUES (267,'Rune Staff',17);
INSERT INTO types VALUES (268,'Gladius',18);
INSERT INTO types VALUES (269,'Cutlass',18);
INSERT INTO types VALUES (270,'Shamshir',18);
INSERT INTO types VALUES (271,'Tulwar',18);
INSERT INTO types VALUES (272,'Battle Sword',18);
INSERT INTO types VALUES (273,'Rune Sword',18);
INSERT INTO types VALUES (274,'Ancient Sword',18);
INSERT INTO types VALUES (275,'Espandon',18);
INSERT INTO types VALUES (276,'Tusk Sword',18);
INSERT INTO types VALUES (277,'Gothic Sword',18);
INSERT INTO types VALUES (278,'Zweihander',18);
INSERT INTO types VALUES (279,'Executioner Sword',18);
INSERT INTO types VALUES (280,'Battle Dart',20);
INSERT INTO types VALUES (281,'Francisca',20);
INSERT INTO types VALUES (282,'Grave Wand',19);
INSERT INTO types VALUES (283,'Champion Axe',9);
INSERT INTO types VALUES (284,'Decapitator',9);
INSERT INTO types VALUES (285,'Crusader Bow',10);
INSERT INTO types VALUES (286,'Hydra Bow',10);
INSERT INTO types VALUES (287,'Devil Star',13);
INSERT INTO types VALUES (288,'Thunder Maul',13);
INSERT INTO types VALUES (289,'Legendary Mallet',13);
INSERT INTO types VALUES (290,'Phase Blade',18);
INSERT INTO types VALUES (291,'Champion Sword',18);
INSERT INTO types VALUES (293,'Giant Thresher',14);
INSERT INTO types VALUES (294,'Bone Knife',12);

--
-- Table structure for table 'unique_items'
--

CREATE TABLE unique_items (
  id bigint(20) NOT NULL auto_increment,
  name varchar(64) NOT NULL default '',
  type int(11) NOT NULL default '0',
  speed int(11) NOT NULL default '0',
  ohdamage_min int(11) NOT NULL default '0',
  ohdamage_max int(11) NOT NULL default '0',
  thdamage_min int(11) NOT NULL default '0',
  thdamage_max int(11) NOT NULL default '0',
  defense int(11) NOT NULL default '0',
  max_durability int(11) NOT NULL default '0',
  req_level int(11) NOT NULL default '0',
  req_strength int(11) NOT NULL default '0',
  req_dex int(11) NOT NULL default '0',
  description text NOT NULL,
  PRIMARY KEY  (id)
) TYPE=MyISAM;

--
-- Dumping data for table 'unique_items'
--


INSERT INTO unique_items VALUES (1,'Ginther\'s Rift',1,1,34,89,0,0,0,60,37,85,60,'+100-150% Enhanced Damage\r\nAdds 50-120 Magic Damage\r\n30% Increased Attack Rate\r\nMagic Damage Reduced by 7-12\r\nRepairs 1 Durability in 5 Seconds');
INSERT INTO unique_items VALUES (2,'Blackhorn\'s Face',2,0,0,0,0,0,262,20,41,55,0,'+180-220% Enhanced Defense\r\nSlows Target by 20%\r\nAttacker Takes Lightning Damage of 25\r\nPrevent Monster Heal\r\n+20 Lightning Absorb\r\nLightning Resist +15%');
INSERT INTO unique_items VALUES (3,'Dwarf Star',3,0,0,0,0,0,0,0,45,0,0,'Fire Absorb 15%\r\nHeal Stamina Plus 15%\r\n+40 Maximum Stamina\r\n+40 Life\r\n100% Extra Gold from Monsters\r\nMagic Damage Reduced by 12-15');
INSERT INTO unique_items VALUES (4,'Langer Briser',115,3,0,0,34,94,0,0,32,52,61,'+170-200% Enhanced Damage\r\n+10-30 To Maximum Damage\r\n33% Chance of Open Wounds\r\nAdds 1-212 Lightning Damage\r\n+30 to Life\r\nKnockback\r\n30-60% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (5,'Skewer of Krinitz',5,2,9,20,0,0,0,32,10,25,25,'+50% Enhanced Damage\r\nAdds 3-7 Damage\r\nIgnore Target\'s Defense\r\n7% Mana Stolen per Hit\r\n+10 to Dexterity\r\n+10 to Strength');
INSERT INTO unique_items VALUES (6,'Soulfeast Tine',116,2,0,0,46,110,0,43,35,64,76,'+150-190% Enhanced Damage\r\nRequirements -20%\r\n7% Life Stolen per Hit\r\n7% Mana Stolen per Hit\r\n20% Stamina Drain');
INSERT INTO unique_items VALUES (7,'Stormstrike',117,2,0,0,11,22,0,0,25,30,40,'+70-90% Enhanced Damage\r\nAdds 1-30 Lightning Damage\r\nPiercing Attack\r\n+28 to Attack Rating\r\nLightning Resist +25%\r\n+8 to Strength');
INSERT INTO unique_items VALUES (8,'Rattlecage',43,0,0,0,0,0,335,66,29,70,0,'+200 Defense\r\n25% Chance of Crushing Blow\r\nHit Causes Monster to Flee 40%\r\n+45 To Attack Rating');
INSERT INTO unique_items VALUES (9,'Boneflesh',118,0,0,0,0,0,235,60,26,65,0,'+100-120% Enhanced Defense\r\n5% Life Stolen per Hit\r\n25% Chance of Open Wounds\r\n+35 to Attack Rating');
INSERT INTO unique_items VALUES (10,'Azurewrath',114,2,12,32,0,0,0,45,13,43,0,'+100% Enhanced Damage\r\nAdds 5-10 Magic Damage\r\nAdds 3-6 Cold Damage, Cold Duration: 4 seconds\r\n50% Deadly Strike\r\n10% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (11,'Manald Heal',3,0,0,0,0,0,0,0,15,0,0,'4-7% Mana Stolen per Hit\r\nReplenish Life +5-8\r\nRegenerate Mana 20%\r\n+20 to Life');
INSERT INTO unique_items VALUES (12,'Ironstone',119,4,41,62,0,0,0,55,27,53,0,'+100-150% Enhanced Damage\r\n150% Damage to Undead\r\nAdds 1-10 Lightning Damage\r\n+100-150 to Attack Rating\r\n+10 to Strength');
INSERT INTO unique_items VALUES (13,'Bloodrise',120,2,17,37,0,0,0,72,15,36,0,'+120% Enhanced Damage\r\n150% Damage to Undead\r\n25% Chance of Open Wounds\r\n10% Increased Attack Speed\r\n5% Life Stolen per Hit\r\n50% Bonus to Attack Rating\r\n+3 to Sacrifice (Paladin only)\r\n+2 to Light Radius');
INSERT INTO unique_items VALUES (14,'Hawkmail',121,0,0,0,0,0,110,36,15,44,0,'+80-100% Enhanced Defense\r\n10% Faster Run/Walk\r\n15% to Max Cold Resist\r\nCold Resist +15%\r\nCannot Be Frozen');
INSERT INTO unique_items VALUES (15,'Leadcrow',122,3,0,0,11,17,0,0,9,21,27,'+70% Enhanced Damage\r\n25% Deadly Strike\r\n+40 to Attack Rating\r\nPoison Resist +30%\r\n+10 to Life\r\n+10 to Dexterity');
INSERT INTO unique_items VALUES (16,'Hellplague',22,2,6,34,0,0,0,44,22,55,39,'+70-80% Enhanced Damage\r\n+2 to Fire Skills\r\nAdds 25-75 Fire Damage\r\nAdds 28-56 Poison Damage over 6 Seconds\r\n5% Life Stolen per Hit\r\n5% Mana Stolen per Hit');
INSERT INTO unique_items VALUES (17,'Kinemil\'s Awl',123,2,7,33,19,57,0,50,23,56,34,'+80-100% Enhanced Damage\r\n+100-150 To Attack Rating\r\nAdds 6-(20-40) Fire Damage\r\n+20 to Mana\r\n+6 to Holy Fire (Paladin only)');
INSERT INTO unique_items VALUES (18,'Dark Clan Crusher',124,2,20,64,0,0,0,24,34,25,0,'+195% Enhanced Damage\r\n+200% Damage to Demons\r\n150% Damage to Undead\r\n+200 to Attack Rating against Demons\r\n+20-25% Bonus to Attack Rating\r\n+15 Life after each Demon Kill\r\n+2 to Druid Skill Levels');
INSERT INTO unique_items VALUES (19,'Bverrit Keep',45,0,0,0,0,0,78,146,19,75,0,'+80-120% Defense\r\n+30 Defense\r\n10% Increased Chance of Blocking\r\nFire Resist +75%\r\n+5 to Strength\r\nMagic Damage Reduced by 5');
INSERT INTO unique_items VALUES (20,'Wall of the Eyeless',125,0,0,0,0,0,50,40,20,25,0,'+30-40% Enhanced Defense\r\n+10 Defense\r\n+5 to Mana after each Kill\r\n20% Faster Cast Rate\r\n3% Mana Stolen per Hit\r\nPoison Resist +20%');
INSERT INTO unique_items VALUES (21,'The Jade Tan Do',126,1,2,11,0,0,0,24,19,0,45,'+100-150 to Attack Rating\r\n+180 Poison Damage over 4 Seconds\r\nPoison Resist +95%\r\n+20% to Maximum Poison Resist\r\nCannot Be Frozen');
INSERT INTO unique_items VALUES (22,'The Meat Scraper',127,2,0,0,18,159,0,50,41,80,0,'+150-200% Enhanced Damage\r\n50% Chance of Open Wounds\r\n30% Increased Attack Speed\r\n10% Life Stolen per Hit\r\n25% Better Chance of Getting Magic Items\r\n+3 To Masteries (Barbarian only)');
INSERT INTO unique_items VALUES (23,'The Patriarch',128,3,26,42,52,86,0,50,29,100,60,'+100-120% Enhanced Damage\r\nHit Blinds Target\r\n100% Extra Gold from Monsters\r\nMagic Damage Reduced by 3\r\nDamage Reduced by 3');
INSERT INTO unique_items VALUES (24,'Coldkill',129,1,28,56,0,0,0,28,36,25,25,'+150-190% Enhanced Damage\r\n30% Increased Attack Speed\r\n10% Chance to Cast Level 10 Ice Blast on Attack\r\n10% Chance to Cast Level 5 Frost Nova When Struck\r\n+40 Cold Damage - 2 Second Duration\r\n15% to Maximum Cold Resist\r\nCold Resist +15%');
INSERT INTO unique_items VALUES (25,'Nagelring',3,0,0,0,0,0,0,0,15,0,0,'Magic Damage Reduced by 3\r\n+50-75 To Attack Rating\r\nAttacker Takes Damage of 3*\r\n15-30% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (26,'Crescent Moon',6,0,0,0,0,0,0,0,60,0,0,'10% Damage Taken Goes to Mana\r\n+45 to Mana\r\n3-6% Life Stolen per Hit\r\n11-15% Mana Stolen per Hit\r\nMagic Damage Reduced by 10\r\n-2 to Light Radius');
INSERT INTO unique_items VALUES (27,'Stone of Jordan',3,0,0,0,0,0,0,0,29,0,0,'1 to All Skill Levels\r\nIncrease Maximum Mana 25%\r\nAdds 1-12 Lightning Damage\r\n+20 to Mana');
INSERT INTO unique_items VALUES (28,'Atma\'s Scarab',6,0,0,0,0,0,0,0,60,0,0,'5% Chance to Cast Level 2 Amplify Damage on Attack\r\n20% Bonus to Attack Rating\r\n+29-39 Poison Damage over 4 Seconds\r\nPoison Resist +75%\r\n+3 to Light Radius\r\nAttacker Takes Damage of 5');
INSERT INTO unique_items VALUES (29,'Raven Frost',3,0,0,0,0,0,0,0,45,0,0,'+150-250 to Attack Rating\r\nAdds 15-45 Cold Damage\r\nCannot Be Frozen\r\n+15-20 to Dexterity\r\n+40 to Mana\r\nCold Absorb 20%');
INSERT INTO unique_items VALUES (30,'Bul-Kathos\' Wedding Band',3,0,0,0,0,0,0,0,58,0,0,'+1 to All Skill Levels\r\n+(0.5 per Character Level) 0.5-49.5 to Life\r\n3-5% Life Stolen per Hit\r\n+50 Maximum Stamina');
INSERT INTO unique_items VALUES (31,'Constricting Ring',3,0,0,0,0,0,0,0,95,0,0,'All Resistances +100\r\nReplenish Life -30\r\n100% Better Chance to Find Magic Items\r\n+15 to Maximum Resistances');
INSERT INTO unique_items VALUES (32,'Nokozan Relic',6,0,0,0,0,0,0,0,10,0,0,'20% Faster Hit Recovery\r\nFire Resist +50%\r\n+10 to Maximum Fire Resist\r\nAdds 3-6 Fire Damage\r\n+3 to Light Radius');
INSERT INTO unique_items VALUES (33,'The Eye of Etlich',6,0,0,0,0,0,0,0,15,0,0,'+1-5 to Light Radius\r\n+1 to All Skill Levels\r\n3-7% Life Stolen per Hit\r\nAdds (1-2) to (3-5) Cold Damage\r\nCold Duration: 2-12 Seconds\r\n+10-40 Defense vs. Missile');
INSERT INTO unique_items VALUES (34,'The Mahim-Oak Curio',6,0,0,0,0,0,0,0,25,0,0,'+10 Defense\r\n+10% Enhanced Defense\r\n+10% Bonus to Attack Rating\r\nAll Resistances +10\r\n+10 to Vitality\r\n+10 to Energy\r\n+10 to Dexterity\r\n+10 to Strength');
INSERT INTO unique_items VALUES (35,'Saracen\'s Chance',6,0,0,0,0,0,0,0,47,0,0,'10% Chance to Cast Level 2 Iron Maiden When Struck\r\nAll Resistances +15-25\r\n+12 to Dexterity\r\n+12 to Energy\r\n+12 to Vitality\r\n+12 to Strength');
INSERT INTO unique_items VALUES (36,'The Cat\'s Eye',6,0,0,0,0,0,0,0,50,0,0,'30% Faster Run/Walk\r\n20% Increased Attack Speed\r\n+100 Defense vs. Missiles\r\n+100 Defense\r\n+25 to Dexterity');
INSERT INTO unique_items VALUES (37,'Soul Harvest',130,3,0,0,16,39,0,65,19,41,41,'+88% Enhanced Damage\n+45 to Attack Rating\n10% Mana Stolen per Hit\n30% Chance of Open Wounds\n+5 to Energy\nAll Resistances +20');
INSERT INTO unique_items VALUES (38,'Venom Ward',37,0,0,0,0,0,111,50,20,30,0,'+61% Enhanced Defense\n+15% to Maximum Poison Resist\nPoison Resist +90%\nPoison Length Reduced by 50%\n+2 to Light Radius');
INSERT INTO unique_items VALUES (39,'Goblin Toe',54,0,0,0,0,0,33,18,22,50,0,'25% Chance of Crushing Blow\n+53% Enhanced Defense\n+15 Defense\nDamage Reduced by 1\nMagic Damage Reduced by 1\n-1 to Light Radius');
INSERT INTO unique_items VALUES (40,'Rakescar',131,1,21,36,0,0,0,26,27,67,0,'30% Increased Attack Speed\n+94% Enhanced Damage\n+50 to Attack Rating\n+38 Poison Damage over 3 Seconds\nPoison Resist +50%');
INSERT INTO unique_items VALUES (41,'Wizendraw',52,1,0,0,7,34,0,0,26,40,50,'20% Increased Attack Speed\nFires Magic Arrows\n+80% Enhanced Damage\n+61 to Attack Rating\n+15 to Energy\n+30 to Mana\nCold Resist +26%');
INSERT INTO unique_items VALUES (42,'Rusthandle',20,3,17,37,0,0,0,60,18,37,0,'+1 to Paladin Skill Levels\n+58% Enhanced Damage\nAdds 3-7 Damage\n+110% Damage to Undead\n8% Life Stolen per Hit\nMagic Damage Reduced by 1\n+3 to Thorns (Paladin Only)\n+3 to Vengeance (Paladin Only)');
INSERT INTO unique_items VALUES (43,'Goldskin',49,0,0,0,0,0,356,255,28,80,0,'+120% Enhanced Defense\nAll Resistances +35%\nAttacker Takes Damage of 10\n100% Extra Gold from Monsters\n+2 to Light Radius');
INSERT INTO unique_items VALUES (44,'Torch of Iro',132,2,2,4,0,0,0,15,5,0,0,'+1 to Necromancer Skill Levels\nAdds 5-9 Fire Damage\n6% Life Stolen per Hit\n+10 to Energy\nRegenerate Mana 5%\n+3 to Light Radius\n150% Damage to Undead');
INSERT INTO unique_items VALUES (45,'Thundergod\'s Vigor',82,0,0,0,0,0,154,24,47,110,0,'5% Chance to Cast Level 7 Fist of the Heavens When Struck\nAdds 1-50 Lightning Damage\n+191% Enhanced Defense\n+20 to Strength\n+20 to Vitality\n+10% to Maximum Lightning Resist\n+20 Lightning Absorb\n+3 to Lightning Fury (Amazon only)\n+3 to Lightning Strike (Amazon Only)');
INSERT INTO unique_items VALUES (46,'Sparking Mail',18,0,0,0,0,0,136,45,17,48,0,'Adds 1-20 Lightning Damage\n+79% Enhanced Damage\nLightning Resist +30%\nAttacker Takes Lightning Damage of 14');
INSERT INTO unique_items VALUES (47,'Visceratuant',133,0,0,0,0,0,122,68,28,38,0,'+1 to Sorceress Skill Levels\n30% Faster Block Rate\n30% Increased Chance of Blocking\n+145% Enhanced Damage\nAttacker Takes Lightning Damage of 10');
INSERT INTO unique_items VALUES (48,'The Hand of Broc',26,0,0,0,0,0,14,12,6,0,0,'3% Mana Stolen per Hit\n3% Life Stolen per Hit\n+18% Enhanced Defense\n+10 Defense\n+20 to Mana\nPoison Resist +10%');
INSERT INTO unique_items VALUES (49,'Deathspade',134,2,16,20,0,0,0,24,9,32,0,'+70% Enhanced Damage\n+8 to Minimum Damage\n15% Bonus to Attack Rating\nHit Blinds Target\n+4 to Mana After Each Kill');
INSERT INTO unique_items VALUES (50,'Pelta Lunata',28,0,0,0,0,0,39,23,2,12,0,'40% Faster Block Rate\n20% Increased Chance of Blocking\n+30% Enhanced Defense\n+30 Defense\n+2 to Strength\n+10 to Vitality\n+10 to Energy');
INSERT INTO unique_items VALUES (51,'Razortine',135,2,13,21,0,0,0,35,12,38,24,'30% Increased Attack Speed\n+35% Enhanced Damage\n50% Target Defense\nSlows Target by 25%\n+15 to Strength\n+8 to Dexterity');
INSERT INTO unique_items VALUES (52,'Tearhaunch',44,0,0,0,0,0,63,24,29,70,0,'20% Faster Run/Walk\n+80% Enhanced Defense\n+35% Defense\n+5 to Strength\n+5 to Dexterity\nAll Resistances +10%\n+2 to Vigor (Paladin only)');
INSERT INTO unique_items VALUES (53,'The Grim Reaper',136,1,34,44,0,0,0,55,29,80,80,'+20% Enhanced Damage\n+15 to Minimum Damage\n5% Mana Stolen per Hit\n100% Deadly Strike\nPrevent Monster Heal');
INSERT INTO unique_items VALUES (54,'Snakecord',11,0,0,0,0,0,14,14,12,0,0,'+12 Poison Damage over 3 Seconds\n+21% Enhanced Defense\n+10 Defense\nReplenish Life +5\nPoison Resist +25%\nPoison Length Reduced by 50%');
INSERT INTO unique_items VALUES (55,'Woestave',137,3,0,0,15,55,0,55,28,75,47,'+20% Enhanced Damage\n50% Chance of Open Wounds\nPrevent Monster Heal\nHit Blinds Target +3\nFreezes Target\nSlows Target by 50%\n-50 to Monster Defense per Hit\n-3 to Light Radius');
INSERT INTO unique_items VALUES (56,'Endlesshail',138,2,33,76,0,0,0,0,36,58,73,'+182% Enhanced Damage\nAdds 15-30 Cold Damage\n+50 Defense vs. Missile\n+40 to Mana\nCold Resist +35%\n+5 to Strafe (Amazon only)');
INSERT INTO unique_items VALUES (57,'Bladebone',16,2,8,20,0,0,0,24,15,43,0,'20% Increased Attack Speed\n+45% Enhanced Damage\n+100% Damage to Undead\n+40 to Attack Rating against Demons\nAdds 8-12 Fire Damage\n+20 Defense');
INSERT INTO unique_items VALUES (58,'Blastbark',139,2,0,0,7,44,0,0,28,50,65,'+1 to Amazon Skill Levels\n+87% Enhanced Damage\n3% Mana Stolen per Hit\n+5 to Strength\n+2 to Exploding Arrow (Amazon only)');
INSERT INTO unique_items VALUES (59,'Warlord\'s Trust',140,3,0,0,41,96,0,30,35,73,0,'+175% Enhanced Damage\n+75 Defense\n.. to Vitality (Based on Character Level\nReplenish Life +20\nAll Resistances +10\nRepairs 1 Durability in 4 Seconds');
INSERT INTO unique_items VALUES (60,'Hotspur',50,0,0,0,0,0,10,12,6,0,0,'Adds 3-6 Fire Damage\n+16% Enhanced Defense\n+6 Defense\n+15 to Life\n+15% to Maximum Fire Resist\nFire Resist +45%');
INSERT INTO unique_items VALUES (61,'Bladebuckle',46,0,0,0,0,0,53,24,29,60,0,'30% Faster Hit Recovery\n+92% Enhanced Defense\n+30 Defense\n+5 to Strength\n+10 to Dexterity\nDamage Reduced by 3\nAttacker Takes Damage of 8');
INSERT INTO unique_items VALUES (62,'Bing Sz Wang',141,3,34,76,66,153,0,50,43,64,0,'5% Chance to Cast Level 3 Frozen Orb on Attack\n+147% Enhanced Damage\nAdds 50-140 Cold Damage\nFreezes Target +2\n+20 to Strength\nRequirements -30%');
INSERT INTO unique_items VALUES (63,'Butcher\'s Pupil',142,1,62,149,0,0,0,0,39,68,0,'Indestructible\n30% Increased Attack Speed\n+193% Enhanced Damage\nAdds 30-50 Damage\n35% Deadly Strike\n25% Chance of Open Wounds');
INSERT INTO unique_items VALUES (64,'Raven Claw',143,2,0,0,6,18,0,0,15,22,19,'Fires Explosive Arrows or Bolts\n+69% Enhanced Damage\n50% Bonus to Attack Rating\n+3 to Strength\n+3 to Dexterity');
INSERT INTO unique_items VALUES (65,'The Iron Jang Bong',8,5,0,0,26,58,0,50,28,0,0,'+2 to Sorceress Skill Levels\n20% Faster Cast Rate\n+100% Enhanced Damage\n50% Bonus to Attack Rating\n+30 Defense\n150% Damage to Undead\n+3 to Frost Nova (Sorceress only)\n+2 to Blaze (Sorceress only)\n+2 to Nova (Sorceress only)');
INSERT INTO unique_items VALUES (66,'Wormskull',48,0,0,0,0,0,33,25,21,0,0,'+1 to Necromancer Skill Levels\n+80 Poison Damage over 8 Seconds\n5% Life Stolen per Hit\n+10 to Mana\nPoison Resist +25%');
INSERT INTO unique_items VALUES (67,'Lycander\'s Flank',144,2,0,0,132,356,0,25,42,115,98,'+150-200% Enhanced Damage\nAdds 25-50 Damage\n+2 to Amazon Skill Levels\n30% Increased Attack Speed\n5-9% Life Stolen per Hit\n+20 to Strength\n+20 to Vitality\n+20% Enhanced Defense\n+2 to Javelin and Spear Skills (Amazon only)');
INSERT INTO unique_items VALUES (68,'Arreat\'s Face',145,0,0,0,0,0,235,55,42,118,0,'150-200% Enhanced Defense\n30% Faster Hit Recovery\n20% Bonus to Attack Rating\n+2 to Barbarian Skill Levels\n3-6% Life Stolen per Hit\nAll Resistances +30\n+20 to Strength\n+20 to Dexterity\n+2 to Combat Skills (Barbarian only)');
INSERT INTO unique_items VALUES (69,'Homunculus',146,0,0,0,0,0,58,20,42,58,0,'+150-200% Enhanced Defense\n25% Damage Taken Goes to Mana\n40% Increased Chance of Blocking\n30% Faster Block Rate\n+2 to Necromancer Skill Levels\n+20 to Energy\nRegenerate Mana 33%\nAll Resistances +40\n+2 to Curses Skills (Necromancer only)');
INSERT INTO unique_items VALUES (70,'The Oculus',106,0,18,42,0,0,0,50,42,0,0,'+3 to Sorceress Skill Levels\n+5 to Mana after each Kill\nAll Resistances +20\n25% Chance to Cast Level 1 Teleport when Struck\n30% Faster Cast Rate\n+20 to Vitality\n+20 to Energy\n+20% Enhanced Defense\n50% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (71,'Bartuc\'s Cut-Throat',147,0,80,158,0,0,0,69,42,79,79,'+150-200% Enhanced Damage\nAdds 25-50 Damage\n30% Faster Hit Recovery\n20% Bonus to Attack Rating\n5-9% Life Stolen per Hit\n+20 to Strength\n+20 to Dexterity\n+2 to Assassin Skill Levels\n+1 to Martial Arts Skills (Assassin only)');
INSERT INTO unique_items VALUES (72,'Herald Of Zakarum',148,0,0,0,0,0,362,50,40,104,0,'+150-200% Enhanced Defense\n30% Increased Chance of Blocking\n30% Faster Block Rate\n20% Bonus to Attack Rating\n+20 to Strength\n+20 to Vitality\nAll Resistances +50\n+2 to Paladin Skill Levels\n+2 to Combat Skills (Paladin only)');
INSERT INTO unique_items VALUES (73,'Lycander\'s Aim',149,0,0,0,70,176,0,0,43,95,118,'+150-200% Enhanced Damage\nAdds 25-50 Damage\n20% Increased Attack Speed\n+2 to Amazon Skill Levels\n5-8% Mana Stolen per Hit\n+20 to Energy\n+20 to Dexterity\n+20% Enhanced Defense\n+2 to Bow And Crossbow Skills (Amazon only)');
INSERT INTO unique_items VALUES (74,'Ialal\'s Mane',150,0,0,0,0,0,185,20,42,65,0,'+150-200% Enhanced Defense\n30% Faster Hit Recovery\n20% Bonus to Attack Rating\n+2 to Druid Skills\nAll Resistances +30\n+5 to Mana after each Kill\n+20 to Strength\n+2 to Shape Shifting Skills (Druid only)');
INSERT INTO unique_items VALUES (75,'Titan\'s Revenge',151,0,70,212,0,0,0,0,42,25,109,'+150-200% Enhanced Damage\nAdds 25-50 Damage\n+2 to Amazon Skill Levels\n5-9% Life Stolen per Hit\n30% Faster Run/Walk\n+20 to Strength\n+20 to Dexterity\nReplenishes Quantity [30]\nIncreased Stack Size [60]\n+2 to Javelin and Spear Skills (Amazon only)');
INSERT INTO unique_items VALUES (76,'Biggin\'s Bonnet',31,0,0,0,0,0,20,60,3,0,0,'+30% Enhanced Damage\n+14 Defense\n+30 to Attack Rating\n+15 to Mana\n+15 to Life');
INSERT INTO unique_items VALUES (77,'Tarnhelm',7,0,0,0,0,0,8,18,15,15,0,'+1 to All Skill Levels\n25-50% Better Chance of Getting Magic Items\n75% Extra Gold from Monsters');
INSERT INTO unique_items VALUES (78,'Coif of Glory',14,0,0,0,0,0,25,24,14,26,0,'+10 Defense\nAttacker Takes Lightning Damage of 7\nHit Blinds Target\nLightning Resist +15%\n+100 Defense vs. Missiles');
INSERT INTO unique_items VALUES (79,'Duskdeep',36,0,0,0,0,0,39,30,17,41,0,'+30-50% Enhanced Defense\n+10-20 Defense\nDamage Reduced by 7\nAll Resistances +15\n+8 to Maximum Damage\n-2 to Light Radius');
INSERT INTO unique_items VALUES (80,'Howltusk',42,0,0,0,0,0,54,40,25,63,0,'35% Damage taken Goes to Mana\n+80% Enhanced Defense\nMagic Damage Reduced by 2\nAttacker Takes Damage of 3\nKnockback\nHit Causes Monster to Flee 25%');
INSERT INTO unique_items VALUES (81,'The Face of Horror',17,0,0,0,0,0,34,20,20,23,0,'+25 Defense\n+50% Damage to Undead\nHit Causes Monsters to Flee 50%\nAll Resistances +10\n+20 to Strength');
INSERT INTO unique_items VALUES (82,'Undead Crown',34,0,0,0,0,0,72,50,29,55,0,'30-60% Enhanced Defense\n+50% Damage vs. Undead\n+50-100 Attack Rating vs. Undead\nHalf Freeze Duration\n5% Life Stolen per Hit\nPoison Resist +50%\n+40 Defense\n+3 to Skeleton Mastery (Necromancer only)');
INSERT INTO unique_items VALUES (83,'Greyform',10,0,0,0,0,0,28,20,7,12,0,'+20 Defense\n5% Life Stolen per Hit\nMagic Damage Reduced by 3\nCold Resist +20%\nFire Resist +20%\n+10 to Dexterity');
INSERT INTO unique_items VALUES (84,'Blinkbat\'s Form',53,0,0,0,0,0,39,24,12,15,0,'+25 Defense\n+50 Defense vs. Missile\n10% Faster Run/Walk\n40% Faster Hit Recovery\nAdds 3-6 Fire Damage');
INSERT INTO unique_items VALUES (85,'The Centurion',152,0,0,0,0,0,51,28,14,20,0,'+30 Defense\nReplenish Life +5\n+50 to Attack Rating\n+15 to Mana\n+15 to Max Stamina\n+15 to Life\n25% Slower Stamina Drain\nDamage Reduced by 2');
INSERT INTO unique_items VALUES (86,'Twitchthroe',62,0,0,0,0,0,57,32,16,27,0,'+25 Defense\n25% Increased chance of blocking\n20% Faster Hit Recovery\n20% Increased Attack Speed\n+10 to Dexterity\n+10 to Strength');
INSERT INTO unique_items VALUES (87,'Darkglow',4,0,0,0,0,0,76,26,14,36,0,'+70-100% Enhanced Defense\n5% to Max Poison Resist\n5% to Max Cold Resist\n5% to Max Lightning Resist\n5% to Max Fire Resist\n+50 Defense vs. Melee\n+20 to Attack Rating\nAll Resistances +10\n+3 to Light Radius');
INSERT INTO unique_items VALUES (88,'Iceblink',15,0,0,0,0,0,172,30,22,51,0,'70-80% Enhanced Defense\nFreezes Target\nCold Resist +30%\nMagic Damage Reduced by 1\n+4 to Light Radius');
INSERT INTO unique_items VALUES (89,'Heavenly Garb',9,0,0,0,0,0,216,60,29,41,0,'+100% Enhanced Defense\nRegenerate Mana 25%\nAll Resistances +10\n+15 to Energy\n+50% Damage to Undead\n+100 to Attack Rating against Undead');
INSERT INTO unique_items VALUES (90,'Rockfleece',153,0,0,0,0,0,241,48,28,50,0,'+100-130% Enhanced Defense\nRequirements -10%\nDamage Reduced by 10%\n+5 to Strength\nDamage Reduced by 5');
INSERT INTO unique_items VALUES (91,'Silks of the Victor',39,0,0,0,0,0,512,60,28,100,0,'+100-120% Enhanced Defense\n+1 to All Skills\n5% Mana Stolen per Hit\n+2 to Light Radius');
INSERT INTO unique_items VALUES (92,'Umbral Disk',24,0,0,0,0,0,46,28,9,22,0,'+40-50% Enhanced Defense\n+30 Defense\n30% Increased Chance of Blocking\nHit Blinds Target\n+20 to Life\n+10 to Dexterity\n-2 to Light Radius');
INSERT INTO unique_items VALUES (93,'Stormguild',21,0,0,0,0,0,54,39,13,34,0,'+50-60% Enhanced Defense\n+30 Defense\n+30% Increased Chance of Blocking\nLightning Resist +25%\nAdds 1-6 Lightning Damage\nAttacker Takes Lightning Damage of 3\nMagic Damage Reduced by 1');
INSERT INTO unique_items VALUES (94,'Steelclash',40,0,0,0,0,0,56,50,17,47,0,'60-100% Enhanced Defense\n+20 Defense\n25% Increased Chance of Blocking\n20% Faster Block Rate\nAll Resistances +15\n+1 to Paladin Skills\n+3 to Light Radius\nDamage Reduced by 3');
INSERT INTO unique_items VALUES (95,'Swordback Hold',154,0,0,0,0,0,51,40,15,30,0,'+30-60% Enhance Defense\n+10 Defense\n20% Increased Chance of Blocking\n50% Chance of Open Wounds\nAttacker Takes Damage of 10');
INSERT INTO unique_items VALUES (96,'The Ward',38,0,0,0,0,0,112,40,26,60,0,'+100% Enhanced Defense\n+40 Defense\n10% Increased Chance of Blocking\nAll Resistances +30-50\nMagic Damage Reduced by 2\n+10 to Strength');
INSERT INTO unique_items VALUES (97,'Bloodfist',102,0,0,0,0,0,17,14,9,0,0,'+10-20% Enhanced Defense\n+10 Defense\n10% Increased Attack Speed\n30% Faster Hit Recovery\n+40 to Life\n+5 to Minimum Damage');
INSERT INTO unique_items VALUES (98,'Chance Guard',23,0,0,0,0,0,26,16,15,25,0,'+20-30% Enhanced Defense\n+15 Defense\n+25 to Attack Rating\n25-40% Better Chance of Getting Magic Items\n200% Extra Gold from Monsters\n+2 to Light Radius');
INSERT INTO unique_items VALUES (99,'Magefist',12,0,0,0,0,0,24,18,23,45,0,'20-30% Enhanced Defense\n+10 Defense\n+1 to Fire Skills\n20% Faster Cast Rate\nRegenerate Mana 25%\nAdds 1-6 Fire Damage');
INSERT INTO unique_items VALUES (100,'Frostburn',47,0,0,0,0,0,48,24,29,60,0,'10-20% Enhanced Defense\n+30 Defense\n+5% Enhanced Damage\nMaximum Mana 40%\nAdds 1-6 Cold Damage, Cold Duration: 2 seconds');
INSERT INTO unique_items VALUES (101,'Gorefoot',63,0,0,0,0,0,21,14,9,18,0,'+20-30% Enhanced Defense\n20% Faster Run/Walk\n2% Mana Stolen per Hit\nAttacker Takes Damage of 2\n+12 Defense\n+2 to Leap (Barbarian only)');
INSERT INTO unique_items VALUES (102,'Treads of Cthon',30,0,0,0,0,0,24,16,15,30,0,'+30-40% Enhanced Defense\n+12 Defense\n50% Stamina Drain\n30% Faster Run/Walk\n+50 Defense vs. Missile\n+10 to Life');
INSERT INTO unique_items VALUES (103,'Lenymo',27,0,0,0,0,0,2,12,7,0,0,'Regenerate Mana 30%\nAll Resistances +5\n+15 to Mana\n+1 to Light Radius');
INSERT INTO unique_items VALUES (104,'Nightsmoke',29,0,0,0,0,0,23,16,20,25,0,'+30-50% Enhanced Defense\n+15 Defense\n50% Damage Taken Goes to Mana\nDamage Reduced by 2\nAll Resistances +10\n+20 to Mana');
INSERT INTO unique_items VALUES (105,'Goldwrap',32,0,0,0,0,0,35,18,27,45,0,'40-60% Enhanced Defense\n+25 Defense\n10% Increased Attack Speed\n30% Better Chance of Getting Magic Items\n50-80% Extra Gold from Monsters\n+2 to Light Radius');
INSERT INTO unique_items VALUES (106,'Peasant Crown',61,0,0,0,0,0,108,12,28,20,0,'+100% Enhanced Defense\n+1 to All Skills\n15% Faster Run/Walk\nReplenish Life +6-12\n+20 to Energy\n+20 to Vitality');
INSERT INTO unique_items VALUES (107,'Rockstopper',155,0,0,0,0,0,201,18,31,43,0,'+160-220% Enhanced Defense\nDamage Reduced by 10%\n30% Faster Hit Recovery\nCold Resist +20-40%\nFire Resist +20-50%\nLightning Resist +20-40%\n+15 to Vitality');
INSERT INTO unique_items VALUES (108,'Stealskull',156,0,0,0,0,0,248,24,35,59,0,'200-240% Enhanced Defense\n10% Increased Attack speed\n10% Faster Hit Recovery\n5% Life Stolen per Hit\n5% Mana Stolen per Hit\n30-50% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (109,'Darksight Helm',103,0,0,0,0,0,283,30,38,82,0,'+ (2 per Character Level) 2-198 Defense\n6% Chance to Cast Level 3 Dim Vision When Struck\nLevel 5 Cloak of Shadows (30 Charges)\nCannot Be Frozen\nFire Resist +20-40%\n5% Mana Stolen per Hit\n-4 to Light Radius');
INSERT INTO unique_items VALUES (110,'Valkyrie Wing',97,0,0,0,0,0,297,40,44,115,0,'+150-200% Defense\n+1-2 to Amazon Skill Levels\n20% Faster Run/Walk\n20% Faster Hit Recovery\n+2-4 To Mana after each Kill');
INSERT INTO unique_items VALUES (111,'Crown of Thieves',76,0,0,0,0,0,342,50,49,103,0,'+160-200% Enhanced Defense\n9-12% Life Stolen per Hit\nFire Resist +33%\n+35 to Mana\n+50 to Life\n+25 to Dexterity\n80-100% Extra Gold from Monsters');
INSERT INTO unique_items VALUES (112,'Vampire Gaze',90,0,0,0,0,0,252,40,41,58,0,'+100% Enhanced Defense\nAdds 6-22 Cold Damage - 4 Second Duration\n15% Stamina Drain\n6-8% Life Stolen per Hit\n6-8% Mana Stolen per Hit\nDamage Reduced by 15-20%\nMagic Damage Reduced by 10-15');
INSERT INTO unique_items VALUES (113,'The Spirit Shroud',157,0,0,0,0,0,295,20,28,38,0,'+150% Enhanced Defense\nCannot Be Frozen\n+1 to All Skills\nReplenish Life +10\nMagic Damage Reduced by 7-11');
INSERT INTO unique_items VALUES (114,'Skin of the Vipermagi',158,0,0,0,0,0,279,24,29,43,0,'+120% Enhanced Defense\n+1 to All Skills\n30% Faster Cast Rate\nMagic Damage Reduced by 9-13\nAll Resistances +20-35');
INSERT INTO unique_items VALUES (115,'Skin of the Flayed One',159,0,0,0,0,0,397,58,31,50,0,'+150-190% Enhanced Defense\nRepairs 1 Durability in 10-20 Seconds\n5-7% Life Stolen per Hit\nReplenish Life +15-25\nAttacker Takes Damage of 15');
INSERT INTO unique_items VALUES (116,'Iron Pelt',160,0,0,0,0,0,605,157,33,61,0,'+50-100% Enhanced Defense\n+ (3 Per Character Level) 3-297 Defense\nDamage Reduced by 15-20\nMagic Damage Reduced by 10-16\n+25 To Life');
INSERT INTO unique_items VALUES (117,'Crow Caw',78,0,0,0,0,0,534,36,37,86,0,'+150-180% Enhanced Defense\n15% Increased Attack Speed\n15% Faster Hit Recovery\n35% Chance of Open Wounds\n+15 Dexterity');
INSERT INTO unique_items VALUES (118,'Spirit Forge',161,0,0,0,0,0,449,26,35,74,0,'+120-160% Enhanced Defense\n+ (1.25 Per Character Level) 1.5-123.75 Life\nFire Resist +5%\nAdds 20-65 Fire Damage\n+15 to Strength\n+4 to Light Radius\nSocketed (2)');
INSERT INTO unique_items VALUES (119,'Duriel\'s Shell',72,0,0,0,0,0,732,50,41,65,0,'+160-200% Enhanced Defense(varies)\n+ (1.25 Per Character Level) 1.25-123.75 Defense\n+ (1 Per Character Level) 1-99 To Life\nResist Fire +20%\nResist Lightning +20%\nResist Poison +20%\nResist Cold +50%\nCannot Be Frozen\n+15 to Strength');
INSERT INTO unique_items VALUES (120,'Shaftstop',162,0,0,0,0,0,684,45,38,92,0,'+160-220% Enhanced Defense\nDamage Reduced by 30%\n+250 Defense vs. Missile\n+60 to Life');
INSERT INTO unique_items VALUES (121,'Skullder\'s Ire',163,0,0,0,0,0,732,90,42,97,0,'+160-200% Enhanced Defense\nRepairs 1 Durability in 4-5 Seconds\n+ (1.25 Per Character Level) 1.25-123.75 % Better Chance of Getting Magic Items\n+1 to All Skill Levels\nMagic Damage Reduced by 10');
INSERT INTO unique_items VALUES (122,'Que-Hegan\'s Wisdom',164,0,0,0,0,0,681,60,51,55,0,'+140-160% Enhanced Defense\n+1 to All Skill Levels\n+3 to Mana After Each Kill\n20% Faster Cast Rate\n20% Faster Hit Recovery\nMagic Damage Reduced by 6-10\n+15 to Energy');
INSERT INTO unique_items VALUES (123,'Guardian Angel',165,0,0,0,0,0,825,60,45,118,0,'+180-200% Enhanced Defense\n+20% Increased Chance of Blocking\n+30% Faster Block Rate\n+ (2.5 Per Character Level) 2.5-247.5 to Attack Rating Against Demons\n+1 to Paladin Skill Levels\n+4 to Light Radius\n15% to Maximum Poison Resist\n15% to Maximum Cold Resist\n15% to Maximum Lightning Resist\n15% to Maximum Fire Resist');
INSERT INTO unique_items VALUES (124,'Toothrow',166,0,0,0,0,0,888,63,48,103,0,'160-220% Enhanced Defense\n+40-60 Defense\n40% Chance of Open Wounds\nFire Resist +15%\n+10 Strength\nAttacker Takes Damage of 20-40');
INSERT INTO unique_items VALUES (125,'Atma\'s Wail',167,0,0,0,0,0,988,105,51,125,0,'+120-160% Enhanced Defense\n+ (2 Based on Character) 2-198 Defense\n30% Faster Hit Recovery\nReplenish Life +10\nIncrease Maximum Mana 15%\n+15 to Dexterity\n+20% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (126,'Black Hades',110,0,0,0,0,0,1029,70,53,140,0,'+140-200% Enhanced Defense\n+30-60% Damage to Demons\n+200-250 to Attack Rating against Demons\nHalf Freeze Duration\nSocketed (3)\n-2 to Light Radius');
INSERT INTO unique_items VALUES (127,'Corpsemourn',68,0,0,0,0,0,1262,60,55,170,0,'+150-180% Enhanced Defense\nLevel 5 Corpse Explosion\nAdds 12-36 Fire Damage\n6% Chance to Cast Level 2 Iron Maiden when Struck\nCold Resist +35%\n+10 to Vitality\n+8 to Strength');
INSERT INTO unique_items VALUES (128,'Moser\'s Blessed Circle',98,0,0,0,0,0,179,64,31,53,0,'+180-220% Enhanced Defense\n+25% Increased Chance of Blocking\n30% Faster Block Rate\nAll Resistances +25\nSocketed (2)');
INSERT INTO unique_items VALUES (129,'Stormchaser',170,0,0,0,0,0,198,62,35,71,0,'+160-220% Enhanced Defense\n+20% Increased Chance of Blocking\n4% Chance to Cast Level 5 Tornado when Struck\n4% Chance to Cast Level 6 Blizzard when Struck\n10% Faster Block Rate\n+150 to Attack Rating\nLightning Resist +50%\nHalf Freeze Duration\nAdds 1-60 Lightning Damage');
INSERT INTO unique_items VALUES (130,'Tiamat\'s Rebuke',171,0,0,0,0,0,204,116,38,91,0,'+140-200% Enhanced Defense\nAdds 27-53 Cold Damage - 3 Second Duration\nAdds 35-95 Fire Damage\nAdds 1-120 Lightning Damage\n3% Chance to Cast Level 6 Hydra when Struck\n5% Chance to Cast Level 7 Nova when Struck\n5% Chance to Cast Level 9 Frost Nova when Struck\nAll Resistances +25-35%');
INSERT INTO unique_items VALUES (131,'Lance Guard',172,0,0,0,0,0,173,55,35,65,0,'+70-120% Enhanced Defense\n15% Damage Taken Goes to Mana\n30% Faster Hit Recovery\n20% Deadly Strike\n+50 to Life\nAttacker Takes Damage of 47');
INSERT INTO unique_items VALUES (132,'Gerke\'s Sanctuary',173,0,0,0,0,0,268,172,44,133,0,'+180-240% Enhanced Defense\n+30% Increased Chance of Blocking\nAll Resistances +20-30\nReplenish Life +15\nDamage Reduced by 11-16\nMagic Damage Reduced by 14-18');
INSERT INTO unique_items VALUES (133,'Lidless Wall',174,0,0,0,0,0,347,40,41,58,0,'+80-130% Enhanced Defense\n+1 to All Skill Levels\nIncrease Maximum Mana 10%\n20% Faster Cast Rate\n+3-5 to Mana After Each Kill\n+10 to Energy\n+1 to Light Radius');
INSERT INTO unique_items VALUES (134,'Radament\'s Sphere',175,0,0,0,0,0,282,100,50,110,0,'+160-200% Enhanced Defense\n+20% Increased Chance of Blocking\n+20% Faster Block Rate\n5% Chance To Cast Level 5 Poison Nova when Struck\nLevel 6 Poison Explosion (40 Charges)\nPoison Resist +75%\n+80 Poison Damage over 4 Seconds');
INSERT INTO unique_items VALUES (135,'Venom Grip',176,0,0,0,0,0,118,12,29,20,0,'130-160% Enhanced Defense\n+15-25 Defense\n5% Chance of Crushing Blow\n+60 Poison Damage over 4 Seconds\n5% Life Stolen per Hit\n5% to Maximum Poison Resist\nPoison Resist +30%');
INSERT INTO unique_items VALUES (136,'Gravepalm',99,0,0,0,0,0,112,14,32,20,0,'+140-180% Enhanced Defense\n+100-200% Damage to Undead\n+100-200 to Attack Rating Against Undead\n+10 to Energy\n+10 to Strength');
INSERT INTO unique_items VALUES (137,'Ghoulhide',113,0,0,0,0,0,130,16,36,58,0,'+150-190% Enhanced Defense\n+ (4 per Character Level) 4-396 to Attack Rating against Undead\n+ (2 per Character Level) 2-198 % Damage to Undead\n4% Mana Stolen per Hit\n+20 to Life');
INSERT INTO unique_items VALUES (138,'Lava Gout',89,0,0,0,0,0,144,38,42,68,0,'+150-200% Enhanced Defense\n2% Chance to Cast Level 10 Enchant on Striking\nHalf Freeze Duration\nAdds 13-46 Fire Damage\n+20% Increased Attack Speed\nFire Resist +24%');
INSERT INTO unique_items VALUES (139,'Hellmouth',83,0,0,0,0,0,162,39,47,110,0,'150-200% Enhanced Defense\n4% Chance To Cast Level 12 Firestorm on Striking\n2% Chance To Cast Level 4 Meteor on Striking\n+15 Fire Absorb\nAdds 15-72 Fire Damage');
INSERT INTO unique_items VALUES (140,'Infernostride',66,0,0,0,0,0,105,12,29,20,0,'+120-150% Enhanced Defense\n+15 Defense\n20% Faster Run/Walk\n5% Chance to Cast Level 8 Blaze when Struck\nFire Resist +30%\n10% to Maximum Fire Resist\nAdds 12-33 Fire Damage\n47-70% Extra Gold from Monsters\n+2 to Light Radius');
INSERT INTO unique_items VALUES (141,'Waterwalk',177,0,0,0,0,0,124,14,32,18,0,'180-210% Enhanced Defense\n20% Faster Run/Walk\n+100 Defense vs. Missile\n+15 to Dexterity\n+5% to Maximum Fire Resist\nHeal Stamina Plus _50%\n+40 to Maximum Stamina\n+45-65 to Life');
INSERT INTO unique_items VALUES (142,'Silkweave',93,0,0,0,0,0,130,16,36,65,0,'+150-190% Enhanced Defense\n30% Faster Run/Walk\n+5 to Mana after each Kill\nIncrease Maximum Mana 10%\n+200 Defense vs. Missile');
INSERT INTO unique_items VALUES (143,'War Traveller',56,0,0,0,0,0,139,48,42,95,0,'+150-190% Enhanced Defense\n25% Faster Run/Walk\n+10 to Vitality\n+10 to Strength\nAdds 15-25 Damage\n40% Slower Stamina Drain\nAttacker Takes Damage of 5-10\n30-50% Better Chance of Getting Magic Items');
INSERT INTO unique_items VALUES (144,'Gore Rider',84,0,0,0,0,0,162,34,48,93,0,'160-200% Enhanced Defense\n30% Faster Run/Walk\n10% Chance of Open Wounds\n15% Chance of Crushing Blow\n15% Deadly Strike\nRequirements -25%\n+20 to Maximum Stamina');
INSERT INTO unique_items VALUES (145,'String of Ears',178,0,0,0,0,0,113,22,29,20,0,'+150-180% Enhanced Defense\n+15 Defense\n6-8% Life Stolen per Hit\nDamage Reduced By 10-15%\nMagic Damage Reduced 10-15');
INSERT INTO unique_items VALUES (146,'Razortail',88,0,0,0,0,0,107,14,32,20,0,'+120-150% Enhanced Defense\n+15 Defense\n+10 to Maximum Damage\nPiercing Attack (33)\n+15 to Dexterity\nAttacker Takes Damage of (1 per Character Level) 1-99');
INSERT INTO unique_items VALUES (147,'Gloom\'s Trap',108,0,0,0,0,0,102,16,36,58,0,'+120-150% Enhanced Defense\n5% Mana Stolen per Hit\nIncrease Maximum Mana 15%\nRegenerate Mana 15%\n+15 to Vitality\n-3 to Light Radius');
INSERT INTO unique_items VALUES (148,'Snowclash',100,0,0,0,0,0,116,18,42,88,0,'+130-170% Enhanced Defense\n5% Chance to Cast Level 7 Blizzard when Struck\n+15 Cold Absorb\n15% to Maximum Cold Resist\nAdds 13-21 Cold Damage\n+2 To Chilling Armor (Sorceress only)\n+2 To Blizzard (Sorceress only)\n+3 To Glacial Spike (Sorceress only)');
INSERT INTO unique_items VALUES (149,'Harlequin Crest',179,0,0,0,0,0,141,12,52,50,0,'+2 to All Skills\n+ (1.5 per Character Level) 1.5-148.5 to Life\n+ (1.5 per Character Level) 1.5-148.5 to Mana\nDamage Reduced by 10%\n50% Better Chance of Getting Magic Items\n+2 to Strength\n+2 to Dexterity\n+2 to Vitality\n+2 to Energy');
INSERT INTO unique_items VALUES (150,'Veil of Steel',75,0,0,0,0,0,396,60,73,192,0,'+60% Enhanced Defense\n+140 to Defense\nAll Resistances +50\n+15 to Strength\n+15 to Vitality\n-4 to Light Radius');
INSERT INTO unique_items VALUES (151,'The Gladiator\'s Bane',180,0,0,0,0,0,1496,135,85,111,0,'+150-200% Enhanced Defense\n+50 Defense\nCannot Be Frozen\n30% Faster Hit Recovery\nPoison Length Reduced by 50%\nAttacker Takes Damage of 20\nDamage Reduced by 15-20\nMagic Damage Reduced by 15-20');
INSERT INTO unique_items VALUES (152,'Arkaine\'s Valor',105,0,0,0,0,0,1551,30,85,165,0,'+200% Enhanced Defense\n+1-2 to All Class Skill Levels\n+ (0.5 er Character Level) 0.5-49.5 to Vitality\n30% Faster Hit Recovery\nDamage Reduced by 10-15');
INSERT INTO unique_items VALUES (153,'Blackoak Shield',182,0,0,0,0,0,372,129,61,100,0,'+160-200% Enhanced Defense\n+ (0.5 Per Character Level) 0.5-49.5 to Dexterity\n+ (0.625 per Character Level) 0.625-61.875 Cold Absorb\n+ (1.25 per Character Level) 1.25-123.75 to Life\n4% Chance to Cast Level 5 Weaken when Struck\n50% Faster Block Rate\nHalf Freeze Duration');
INSERT INTO unique_items VALUES (154,'Stormshield',183,0,0,0,0,0,532,0,73,157,0,'+ (3.75 Per Character Level) 3.75-371.25 Defense\n+25% Increased Chance of Blocking\n35% Faster Block Rate\nDamage Reduced by 35%\nCold Resist +60%\nLightning Resist +25%\n+30 to Strength\nAttacker Takes Lightning Damage of 10\nIndestructible');
INSERT INTO unique_items VALUES (155,'Nosferatu\'s Coil',184,0,0,0,0,0,63,14,51,50,0,'Slows Target by 10%\n+2 to Mana after each Kill\n5% Life Stolen per Hit\n+15 to Strength\n10% Increased Attack Speed\n-3 to Light Radius');
INSERT INTO unique_items VALUES (156,'The Gnasher',185,3,6,11,0,0,0,28,5,0,0,'+60-70% Enhanced Damage\n20% Chance of Crushing Blow\n50% Chance of Open Wounds\n+30 To Attack Rating');
INSERT INTO unique_items VALUES (157,'Skull Splitter',51,0,12,24,0,0,0,26,21,49,33,'+60-100% Enhanced Damage\nAdds 1-(12-15) Lightning Damage\n+50-100 To Attack Rating\n15% Chance of Open Wounds\nHit Blinds Target +2\nRegenerate Mana 20%');
INSERT INTO unique_items VALUES (158,'Axe of Fechmar',186,2,0,0,11,26,0,30,8,35,0,'+70-90% Enhanced Damage\nFreezes Target +3\nCold Resist +50%\n+2 to Light Radius');
INSERT INTO unique_items VALUES (159,'Goreshovel',187,3,0,0,15,37,0,35,14,48,0,'+40-50% Enhanced Damage\n+9 to Maximum Damage\n60% Chance of Open Wounds*\n30% Increased Attack Speed\n+25 to Strength');
INSERT INTO unique_items VALUES (160,'The Chieftain',188,4,0,0,26,66,0,40,19,54,0,'+100% Enhanced Damage\n20% Increased Attack Speed\nAdds 1-40 Lightning Damage\nAll Resistances +10-20\n+6 to Mana after each Kill');
INSERT INTO unique_items VALUES (161,'Brainhew',189,4,0,0,29,55,0,50,25,63,39,'+50-80% Enhanced Damage\n+14 to Minimum Damage\nAdds 15-35 Fire Damage\n10-13% Mana Stolen per Hit\n+25 to Mana\n+4 to Light Radius');
INSERT INTO unique_items VALUES (162,'The Humongous',190,2,0,0,47,124,0,50,29,84,0,'+80-120% Enhanced Damage\nAdds 8-(15-25) damage\n33% Chance of Crushing Blow\nRequirements +20%\n+20-30 to Strength');
INSERT INTO unique_items VALUES (163,'Pluckeye',191,5,0,0,4,10,0,15,7,0,15,'+100% Enhanced Damage\n+28 to Attack Rating\n3% Mana Stolen per Hit\n+10 to Life\n+2 to Mana after each Kill\n+2 to Light Radius');
INSERT INTO unique_items VALUES (164,'Witherstring',192,2,0,0,5,13,0,0,13,0,28,'+40-50% Enhanced Damage\nFires Magic Arrows\nAdds 1-3 Damage\n30% Increased Attack Speed\n+50 to Attack Rating');
INSERT INTO unique_items VALUES (165,'Rogue\'s Bow',193,2,0,0,7,14,0,0,20,25,35,'+40-60% Enhanced Damage\n+100% Damage to Undead\n30% Deadly Strike\n50% Increased Attack Speed\n+60 to Attack Rating\nAll Resistances +10');
INSERT INTO unique_items VALUES (166,'Hellclap',13,3,0,0,11,28,0,0,27,35,55,'+70-90% Enhanced Damage\nAdds 15-(30-50) Fire Damage\n10% Increased Attack Speed\n+50-75 to Attack Rating\n+1 to Fire Skills\nFire Resist +40%\n+12 to Dexterity');
INSERT INTO unique_items VALUES (167,'Ichorsting',194,3,0,0,15,25,0,0,18,40,33,'+50% Enhanced Damage\nAdds 30 Poison Damage over 3 Seconds\n20% Increased Attack Speed\nPiercing Attack (50)\n+50 to Attack Rating\n+20 to Dexterity');
INSERT INTO unique_items VALUES (168,'Hellcast',195,4,0,0,25,48,0,0,27,60,40,'+70-80% Enhanced Damage\nFires Explosive Arrows or Bolts\nAdds 15-35 Fire Damage\n20% Increased Attack Speed\n+70 to Attack Rating\n15% to Max Fire Resist\nFire Resist +15%');
INSERT INTO unique_items VALUES (169,'Doomslinger',196,5,0,0,11,26,0,0,28,40,50,'+60-100% Enhanced Damage\nPiercing Attack (35)\n30% Increased Attack Speed\n+1 to Amazon Skill Levels\n+15 to Life');
INSERT INTO unique_items VALUES (170,'Gull',197,1,2,19,0,0,0,16,4,0,0,'Adds 1-15 damage\n100% Better Chance of getting Magic Items\n-5 to Mana');
INSERT INTO unique_items VALUES (171,'The Diggler',197,3,6,15,0,0,0,20,11,0,25,'+50% Enhanced Damage\nIgnore Target\'s Defense\n30% Increased Attack Speed\nCold Resist +25%\nFire Resist +25%\n+10 to Dexterity');
INSERT INTO unique_items VALUES (172,'Spectral Shard',199,2,4,15,0,0,0,24,25,35,51,'50% Faster Cast Rate\n+55 to Attack Rating\nAll Resistances +10\n+50 To Mana');
INSERT INTO unique_items VALUES (173,'Felloak',200,2,3,12,0,0,0,24,3,0,0,'+70-80% Enhanced Damage\n150% Damage to Undead\nAdds 6-8 Fire Damage\nKnockback\nLightning Resist +60%\nFire Resist +20%');
INSERT INTO unique_items VALUES (174,'Stoutnail',201,3,12,18,0,0,0,36,5,0,0,'+100% Enhanced Damage\n150% Damage to Undead\n+7 to Vitality\nAttacker Takes Damage of 3-10\nMagic Damage Reduced by 2');
INSERT INTO unique_items VALUES (175,'Crushflange',202,3,6,17,0,0,0,60,9,27,0,'+50-60% Enhanced Damage\n150% Damage to Undead\n33% Chance of Crushing Blow\nKnockback\nFire Resist +50%\n+15 to Strength\n+2 to Light Radius');
INSERT INTO unique_items VALUES (176,'The General\'s Tan Do Li Ga',203,2,4,60,0,0,0,30,21,41,35,'+50-60% Enhanced Damage\n150% Damage to Undead\nAdds 1-20 Damage\n20% Increased Attack Speed\n5% Mana Stolen per Hit\nSlows Target by 50%\n+25 Defense');
INSERT INTO unique_items VALUES (177,'Bonesnap',204,4,0,0,93,176,0,60,24,69,0,'+200-300% Enhanced Damage\n50-200% Damage to Undead\n40% Chance of Crushing Blow\nCold Resist +30%\nFire Resist +30%');
INSERT INTO unique_items VALUES (178,'Steeldriver',205,5,0,0,97,206,0,60,29,50,0,'+150-250% Enhanced Damage\n150% Damage to Undead\n40% Increased Attack Speed\nRequirements -50%\nHeal Stamina +25%');
INSERT INTO unique_items VALUES (179,'Dimoak\'s Hew',206,4,0,0,4,56,0,50,8,40,0,'+100% Enhanced Damage\n20% Increased Attack Speed\n+15 Dexterity\n-8 Defense');
INSERT INTO unique_items VALUES (180,'Steelgoad',207,3,0,0,11,39,0,90,14,50,0,'+60-80% Enhanced Damage\n30% Deadly Strike\n+30 to Attack Rating\nAll Resistances +5\nHit Causes monster to Flee 75%');
INSERT INTO unique_items VALUES (181,'The Battlebranch',208,4,0,0,28,68,0,65,25,62,0,'+50-70% Enhanced Damage\n30% Increased Attack Speed\n+50-100 to Attack Rating\n7% Life Stolen per Hit\n+10 to Dexterity');
INSERT INTO unique_items VALUES (182,'Knell Striker',209,3,11,21,0,0,0,50,5,25,0,'+70-80% Enhanced \n150% Damage to Undead\n25% Chance of Crushing Blow\n+35 to Attack Rating\nPoison Resist +20%\nFire Resist +20%\n+15 to Mana');
INSERT INTO unique_items VALUES (183,'Stormeye',41,2,19,39,0,0,0,70,30,55,0,'+80-120% Enhanced Damage\n150% Damage to Undead\nAdds 3-5 Cold Damage, Cold Duration: 3 seconds\nAdds 1-6 Lightning Damage\nReplenish Life +10\n+1 To Fist of the Heavens (Paladin only)\n+3 To Holy Shock (Paladin only)\n+4-5 To Resist Lightning (Paladin only)');
INSERT INTO unique_items VALUES (184,'The Dragon Chang',210,2,0,0,14,16,0,30,8,0,0,'+200% Damage To Undead\n+10 to Minimum Damage\nAdds 3-6 Fire Damage\n+35 to Attack Rating\n+2 To Light Radius');
INSERT INTO unique_items VALUES (185,'Bloodthief',211,1,0,0,12,30,0,28,17,40,50,'+50-70% Enhanced Damage\n35% Chance of Open Wounds\n8-12% Life stolen per Hit\n+26 to Life\n+10 to Strength');
INSERT INTO unique_items VALUES (186,'Lance of Yaggai',212,3,0,0,15,23,0,28,22,54,35,'Adds 1-60 Lightning Damage\nAll Resistances +15\n40% Increased Attack Speed\nAttacker takes Damage of 8');
INSERT INTO unique_items VALUES (187,'The Tannr Gorerod',213,5,0,0,27,128,0,25,27,60,45,'+80-100% Enhanced Damage\nAdds 23-54 Fire Damage\n+60 to Attack Rating\nFire Resist +15%\n15% to Maximum Fire Resist\n+30 to Life\n+3 to Light Radius');
INSERT INTO unique_items VALUES (188,'Bane Ash',214,2,0,0,3,14,0,20,5,0,0,'+50-60% Enhanced Damage\n150% Damage to Undead\n20% Increased Attack Speed\n+30 to Mana\nFire Resist +50%\nAdds 4-6 Fire Damage\n+5 to Fire Bolt (Sorceress only)\n+2 to Warmth (Sorceress only)');
INSERT INTO unique_items VALUES (189,'Serpent Lord',215,3,0,0,2,11,0,30,9,0,0,'+30-40% Enhanced Damage\n150% Damage to Undead\n+12 Poison Damage over 3 Seconds\n100% Mana Stolen per Hit\n50% Target Defense\n+10 to Mana\nPoison Resist +50%\n-1 to Light Radius');
INSERT INTO unique_items VALUES (190,'Spire of Lazarus',216,4,0,0,4,12,0,35,18,0,0,'150% Damage to Undead\nAdds 1-28 Lightning Damage\n+1 to Sorceress Skill Levels\n+2 to Lightning (Sorceress only)\n+1 to Chain Lightning (Sorceress only)\n+3 to Static Field (Sorceress only)\nRegenerate Mana 43%\n+15 to Energy\nDamage Reduced by 5\nLightning Resist +75%');
INSERT INTO unique_items VALUES (191,'The Salamander',19,3,0,0,6,13,0,40,21,0,0,'150% Damage to Undead\nAdds 15-32 Fire Damage\nFire Resist +30%\n+2 To Fire Skills\n+3 To Warmth (Sorceress only)\n+2 To Fire Ball (Sorceress only)\n+1 To Fire Wall (Sorceress only)');
INSERT INTO unique_items VALUES (192,'Rixot\'s Keen',217,3,11,16,0,0,0,24,2,0,0,'+100% Enhanced Damage\n+5 to Minimum Damage\n25% Chance of Crushing Blow\n20% Bonus to Attack Rating\n+25 Defense\n+2 to Light Radius');
INSERT INTO unique_items VALUES (193,'Blood Crescent',218,1,4,12,0,0,0,22,7,0,21,'+60-80% Enhanced Damage\n33% Chance of Open Wounds\n15% Increased Attack Speed\n15% Life Stolen per Hit\nAll Resistances +15\n+15 to Life\n+4 to Light Radius');
INSERT INTO unique_items VALUES (194,'Gleamscythe',219,5,16,36,0,0,0,32,13,33,0,'+60-100% Enhanced Damage\nAdds 3-5 Cold Damage - 2 Second Duration\n20% Increased Attack Speed\n+20 Defense\n+30 to Mana\n+3 to Light Radius');
INSERT INTO unique_items VALUES (195,'Griswold\'s Edge',35,3,14,33,0,0,0,32,17,48,0,'+80-120% Enhanced Damage\nAdds (10-12) to (15-25) Fire Damage\n10% Increased Attack Speed\n+100 to Attack Rating\n+12 to Strength\nKnockback');
INSERT INTO unique_items VALUES (196,'Culwen\'s Point',25,3,15,37,0,0,0,44,29,71,45,'+70-80% Enhanced Damage\n+1 to all skill levels\nPoison Length Reduced by 50%\n20% Increased Attack Speed\n20% Faster Hit Recovery\n+60 to Attack Rating');
INSERT INTO unique_items VALUES (197,'Shadowfang',220,3,6,20,18,36,0,44,12,35,27,'+100% Enhanced Damage\nAdds 10-30 Cold Damage, Cold Duration: 3 seconds\n9% Mana Stolen per Hit\n9% Life Stolen per Hit\nCold Resist 20%\n-2 to Light Radius');
INSERT INTO unique_items VALUES (198,'Soulflay',221,4,10,26,23,62,0,50,19,47,0,'70-100% Enhanced Damage\n+10% Increased Attack Speed\n4% Life Stolen per Hit\n4-10% Mana Stolen per Hit\nAll Resistances +5');
INSERT INTO unique_items VALUES (199,'Blacktongue',222,4,12,32,31,46,0,40,26,62,0,'+50-60% Enhanced Damage\n+113 Poison Damage over 6 Seconds\nPrevent Monster Heal\n+50 to Attack Rating\nPoison Resist +50%');
INSERT INTO unique_items VALUES (200,'Ripsaw',223,4,18,47,25,69,0,50,26,70,49,'+80-100% Enhanced Damage\n+15 To Maximum Damage\n80% Chance of Open Wounds\n6% Mana Stolen per Hit');
INSERT INTO unique_items VALUES (201,'Maelstrom',224,1,2,8,0,0,0,15,14,0,0,'150% Damage to Undead\nAdds 1-9 Lightning Damage\n+13 to Mana\n30% Faster Cast Rate\nLightning Resist +40%\n+1-3 to Iron Maiden (Necromancer only)\n+1-3 to Amplify Damage (Necromancer only)\n+1-3 to Terror (Necromancer only)\n+1-3 to Corpse Explosion (Necromancer only)');
INSERT INTO unique_items VALUES (202,'Gravespine',101,3,3,7,0,0,0,15,20,0,0,'150% Damage to Undead\n+2 to Necromancer Skill Levels\nAdds 4-8 Cold Damage, Cold Duration: 3 seconds\n5% Mana Stolen per Hit\n+25-50 Mana\n+10 to Dexterity\n+10 to Strength');
INSERT INTO unique_items VALUES (203,'Ume\'s Lament',33,3,5,11,0,0,0,15,28,0,0,'150% Damage to Undead\n+2 to Necromancer Skill Levels\n20% Faster Cast Rate\n+40 to Mana\nHit Causes Monster to Flee [64]\n+2 to Decrepify (Necromancer only)\n+3 to Terror (Necromancer only)');
INSERT INTO unique_items VALUES (204,'Islestrike',225,4,37,113,0,0,0,24,43,85,0,'+170-190% Enhanced Damage\n25% Chance of Crushing Blow\n+2 to Druid Skills\n+50 Defense vs. Missile\n+10 to Energy\n+10 to Vitality\n+10 to Dexterity\n+10 to Strength\n+1 to Fury (Druid only)\n+1 to Maul (Druid only)');
INSERT INTO unique_items VALUES (205,'Pompeii\'s Wrath',226,2,36,94,0,0,0,26,45,94,70,'+140-170% Enhanced Damage\nAdds 35-150 Fire Damage\nSlows Target by 50%\n4% Chance to Cast Level 8 Volcano on Attack\nKnockback');
INSERT INTO unique_items VALUES (206,'Guardian Naga',227,3,42,148,0,0,0,26,48,121,0,'150-180% Enhanced Damage\n+20 to Maximum Damage\n+250 Poison Damage over 10 Seconds\n5% Chance to Cast Level 8 Poison Nova on Attack\nPoison Resist +30%\nAttacker Takes Damage of 15');
INSERT INTO unique_items VALUES (207,'Spellsteel',228,3,0,0,58,132,0,35,39,37,0,'+165% Enhanced Damage\n10% Faster Cast Rate\nRequirements -60%\nRegenerate Mana 25%\n+100 to Mana\nLevel 12 Firestorm (60 Charges)\nLevel 20 Holy Bolt (100 Charges)\nLevel 3 Decrepify (30 Charges)\nLevel l Teleport (20 Charges)\nMagic Damage Reduced by 12-15');
INSERT INTO unique_items VALUES (208,'Stormrider',229,4,0,0,85,231,0,90,41,101,0,'+100% Enhanced Damage\nAdds 35-75 Damage\nAdds 1-200 Lightning Damage\n15% Chance to Cast Level 5 Charged Bolt when Struck\n10% Chance to Cast Level 19-31 Charged Bolt on Striking\n5% Chance to Cast Level 10 Chain Lightning on Striking\nAttacker Takes Lightning Damage of 15');
INSERT INTO unique_items VALUES (209,'Boneslayer Blade',230,2,0,0,53,227,0,50,42,115,79,'+180-220% Enhanced Damage\n+ (5 Per Character Level) 5-495 to Attack Rating against Undead\n+ (2.5 Per Character Level) 2.5-247.5% Damage to Undead\n50% Chance to Cast Level 16-20 Holy Bolt When Struck\nLevel 20 Holy Bolt (200 Charges)\n20% Increased Attack Speed\n35% Bonus to Attack Rating\n+8 to Strength');
INSERT INTO unique_items VALUES (210,'The Minotaur',231,4,0,0,125,288,0,50,45,125,0,'+140-200% Enhanced Damage\nAdds 20-30 Damage\nSlows Target by 50%\n30% Chance of Crushing Blow\nHit Blinds Target +2\nHalf Freeze Duration\n+15-20 to Strength');
INSERT INTO unique_items VALUES (211,'Skystrike',232,4,0,0,17,60,0,0,28,25,43,'+150-200% Enhanced Damage\nAdds 1-250 Lightning Damage\n2% Chance to Cast Level 6 Meteor on Striking\n30% Increased Attack Rate\n+100 to Attack Rating\n+1 to Amazon Skill Levels\n+10 to Energy');
INSERT INTO unique_items VALUES (212,'Riphook',233,4,0,0,25,73,0,0,31,25,62,'180-220% Enhanced Damage\nSlows Target by 30%\n30% Chance of Open Wounds\n30% Increased Attack Speed\n7-10% Life Stolen per Hit\n+35 to Mana');
INSERT INTO unique_items VALUES (213,'Kuko Shakaku',234,3,0,0,27,84,0,0,33,53,49,'+150-180% Enhanced Damage\nFires Explosive Arrows or Bolts\nPiercing Attack (50)\nAdds 40-180 Fire Damage\n+3 to Immolation Arrow (Amazon only)\n+3 to Bow and Crossbow Skills (Amazon only)');
INSERT INTO unique_items VALUES (214,'Witchwild String',235,3,0,0,35,83,0,0,39,65,80,'+150-170% Enhanced Damage\nFires Magic Arrows\n2% Chance to Cast Level 5 Amplify Damage on Attack\n+ (1 Per Character Level) 1-99 % Deadly Strike\nAll Resistances +40');
INSERT INTO unique_items VALUES (215,'Cliffkiller',236,2,0,0,36,171,0,0,41,80,95,'+190-230% Enhanced Damage\nAdds (5-10)-(20-30) Damage\n+2 to Amazon Skill Levels\n+80 Defense vs. Missile\n+50 to Life\nKnockback');
INSERT INTO unique_items VALUES (216,'Magewrath',237,3,0,0,53,140,0,0,43,73,103,'+120-150% Enhanced Damage\nAdds 20-50 Damage\n+200-250 To Attack Rating\n+1 to Amazon Skill Levels\nHit Blinds Target\n15% Mana Stolen per Hit\nMagic Damage Reduced by 9-13\n+10 to Dexterity\n+3 to Guided Arrow (Amazon only)');
INSERT INTO unique_items VALUES (217,'Goldstrike Arch',238,4,0,0,33,153,0,0,46,95,118,'+200-250% Enhanced Damage\n+100-200% Damage to Demons\n+100-200% Damage to Undead\n50% Increased Attack Speed\n5% Chance To Cast Level (5-7) Fist Of Heavens on Attack\nReplenish Life +12\n+100-150% Bonus to Attack Rating');
INSERT INTO unique_items VALUES (218,'Pus Spitter',240,3,0,0,52,137,0,0,36,32,28,'+150-220% Enhanced Damage\n+150 Poison Damage over 8 Seconds\nRequirements -60%\n9% Chance to Cast Level 6 Poison Nova when Struck\n4% Chance to Cast Level 1 Lower Resist on Striking\n+ (5 Per Character Level) 5-495 to Attack Rating\n10% Increased Attack Speed\n+2 to Necromancer Skill Levels\n10% to Maximum Poison Resist\nPoison Resist +25%');
INSERT INTO unique_items VALUES (219,'Buriza-Do Kyanon',239,4,0,0,85,415,0,0,41,110,80,'150-200% Enhanced Damage\n+ (2.5 Per Character Level) 2.5-247.5 to Maximum Damage\nAdds 32-196 Cold Damage - 4 Second Duration\nPiercing Attack (100)\nFreezes Target +3\n+75-150 Defense(varies)\n+35 to Dexterity\n80% Increased Attack Speed');
INSERT INTO unique_items VALUES (220,'Demon Machine',241,1,0,0,33,139,0,0,49,80,95,'+123% Enhanced Damage\n+66 to Maximum Damage\nFires Explosive Arrows or Bolts\n+632 to Attack Rating\nPiercing Attack (66)\n+321 Defense\n+36 to Mana');
INSERT INTO unique_items VALUES (221,'Spineripper',242,1,36,91,0,0,0,16,32,25,0,'+200-240% Enhanced Damage\nAdds 15-27 Damage\n15% Increased Attack Speed\n+1 to Necromancer Skill Levels\nPrevent Monster Heal\nIgnore Target\'s Defense\n8% Life Stolen per Hit\n+10 to Dexterity');
INSERT INTO unique_items VALUES (222,'Heart Carver',243,3,46,126,0,0,0,20,36,25,58,'+190-240% Enhanced Damage\nAdds 15-35 Damage\n35% Deadly Strike\nIgnore Target\'s Defense\n+4 to Grim Ward (Barbarian only)\n+4 to Find Item (Barbarian only)\n+4 to Find Potion (Barbarian only)');
INSERT INTO unique_items VALUES (223,'Blackbog\'s Sharp',244,0,30,76,0,0,0,24,38,25,68,'488 Poison Damage over 10 Seconds\nAdds 15-45 Damage\n30% Increased Attack Speed\nSlows Target by 50%\n+50 Defense\n+4 to Poison Nova (Necromancer only)\n+4 to Poison Explosion (Necromancer only)\n+5 to Poison Dagger (Necromancer only)');
INSERT INTO unique_items VALUES (224,'Stormspike',245,2,47,90,0,0,0,24,41,47,97,'+150% Enhanced Damage\nAdds 1-120 Lightning Damage\n25% Chance to Cast Level 3 Charged Bolt when Struck\nLightning Resist + (1 Per Character Level) 1-99 %\nAttacker Takes Lightning Damage of 20');
INSERT INTO unique_items VALUES (225,'Fleshrender',246,3,62,128,0,0,0,56,38,30,0,'+130-200% Enhanced Damage\nAdds 35-50 Damage\n150% Damage to Undead\n20% Deadly Strike\n20% Chance of Crushing Blow\n25% Chance of Open Wounds\n+1 to Druid Skills\n+2 to Shape Shifting Skills (Druid only)\nPrevent Monster Heal');
INSERT INTO unique_items VALUES (226,'Sureshril Frost',247,3,45,77,0,0,0,60,39,61,0,'+150-180% Enhanced Damage\nAdds 5-10 Damage\n150% Damage to Undead\nAdds 63-112 Cold Damage\nFreezes Target +3\nLevel 9 Frozen Orb (50 Charges)\nCannot Be Frozen');
INSERT INTO unique_items VALUES (227,'Moonfall',58,4,56,95,0,0,0,72,42,74,0,'+120-150% Enhanced Damage\nAdds 10-15 Damage\n150% Damage to Undead\nAdds 55-115 Fire Damage\n5% Chance to Cast Level 6 Meteor on Striking\nLevel 11 Meteor (60 Charges)\nMagic Damage Reduced by 9-12');
INSERT INTO unique_items VALUES (228,'Baezil\'s Vortex',248,2,36,108,0,0,0,30,45,82,73,'+160-200% Enhanced Damage\n150% Damage to Undead\nAdds 1-150 Lightning Damage\n20% Increased Attack Speed\n5% Chance to Cast Level 8 Nova on Attack\nLevel 15 Nova (80 Charges)\nLightning Resist +25%\n+100 to Mana');
INSERT INTO unique_items VALUES (229,'Earthshaker',249,5,100,165,0,0,0,105,43,100,0,'180% Enhanced Damage\n150% Damage to Undead\n5% Chance to Cast Level 7 Fissure on Attack\n30% Increased Attack Speed\nHit Blinds Target\nKnockback\n+3 To Elemental Skills (Druid only)');
INSERT INTO unique_items VALUES (230,'Bloodtree Stump',250,4,0,0,151,252,0,0,48,124,0,'+180-220% Enhanced Damage\n150% Damage to Undead\n50% Chance of Crushing Blow\nAll Resistances +20\n+25 to Strength\n+2 to Masteries (Barbarian only)\n+3 to Mace Masteries (Barbarian only)');
INSERT INTO unique_items VALUES (231,'The Gavel of Pain',251,5,0,0,154,290,0,0,45,169,0,'+130-160% Enhanced Damage\nAdds 12-30 Damage\n150% Damage to Undead\n5% Chance to Cast Level 1 Iron Maiden when Struck\n5% Chance to Cast Level 1 Amplify Damage on Attack\nLevel 8 Amplify Damage (3 Charges)\nAttacker Takes Damage of 26\nIndestructible');
INSERT INTO unique_items VALUES (232,'Blackleach Blade',77,3,0,0,30,253,0,50,42,50,0,'+100-140% Enhanced Damage\n+ (1.25 per Character Level) 1.25-123.75 to Maximum Damage\n5% Chance to Cast Level 5 Weaken on Attack\nRequirements -25%\n-2 to Light Radius\n8% Life Stolen per Hit');
INSERT INTO unique_items VALUES (233,'Athena\'s Wrath',252,2,0,0,47,227,0,82,42,82,82,'+150-180% Enhanced Damage\n+ (1 per Character Level) 1-99 to Maximum Damage\n+ (1 per Character Level) 1-99 to Life\n30% Increased Attack Speed\n+1-3 to Druid Skill Levels\n+15 to Dexterity');
INSERT INTO unique_items VALUES (234,'Pierre Tombale Couant',253,4,0,0,103,263,0,65,43,113,67,'160-220% Enhanced Damage\nAdds 12-20 Damage\n55% Deadly Strike\n+100-200 to Attack Rating\n+3 to Barbarian Skill Levels\n6% Mana Stolen per Hit\n30% Faster Hit Recovery');
INSERT INTO unique_items VALUES (235,'Husoldal Evo',254,2,0,0,56,290,0,55,44,133,91,'+160-200% Enhanced Damage\nAdds 20-32 Damage\n20% Increased Attack Speed\n+200-250 to Attack Rating\nPrevent Monster Heal\nReplenish Life +20');
INSERT INTO unique_items VALUES (236,'Grim\'s Burning Dead',255,2,0,0,74,198,0,55,45,70,70,'140-180% Enhanced Damage\nAdds 131-232 Fire Damage\n+3 to Necromancer Skill Levels\n50% Target Defense\n+20% Enhanced Defense\n+200-250 to Attack Rating\nFire Resist +45%\nRequirements -50%\nAttacker Takes Damage of 8');
INSERT INTO unique_items VALUES (237,'Zakarum\'s Hand',256,3,39,80,0,0,0,50,37,58,0,'180-220% Enhanced Damage\n150% Damage to Undead\n30% Increased Attack Speed\n6% Chance to Cast Level 5 Blizzard on Attack\n8% Mana Stolen per Hit\nIgnore Target\'s Defense\nRegenerate Mana 10%\nHeal Stamina Plus 15%\n+2 to Holy Shock (Paladin only)\n+2 to Holy Freeze (Paladin only)');
INSERT INTO unique_items VALUES (238,'The Fetid Sprinkler',257,4,54,132,0,0,0,60,38,76,0,'160-190% Enhanced Damage\nAdds 15-25 Damage\n150% Damage to Undead\n+2 to Paladin Skill Levels\n10% Chance to Cast Level 1 Confuse on Attack\n5% Chance to Cast Level 1 Decrepify on Attack\n+160 Poison Damage over 4 Seconds\n+150-200 to Attack Rating');
INSERT INTO unique_items VALUES (239,'Hand of Blessed Light',258,2,59,146,0,0,0,70,42,103,0,'+130-160% Enhanced Damage\nAdds 20-45 Damage\n150% Damage to Undead\n+2 to Paladin Skill Levels\n100% Bonus to Attack Rating\nRegenerate Mana 15%\n+50 Defense\n5% Chance to Cast Level 4 Fist Of Heavens on Striking\n+2 to Fist Of The Heavens (Paladin only)\n+4 to Holy Bolt (Paladin only)\n+4 to Light Radius');
INSERT INTO unique_items VALUES (240,'The Impaler',259,2,0,0,24,99,0,30,31,25,25,'+140-170% Enhanced Damage\n40% Chance of Open Wounds\n+20% Increased Attack Speed\nIgnore Target\'s Defense\n+150 to Attack Rating\nPrevent Monster Heal\n+5 To Impale (Amazon only)\n+3 To Power Strike (Amazon only)');
INSERT INTO unique_items VALUES (241,'Kelpie Snare',260,3,0,0,78,156,0,35,33,77,25,'+140-180% Enhanced Damage\nAdds 30-50 Damage\nSlows Target by 75%\n+ (1.25 per Character Level) 1.25-123.75 to Life\nFire Resist +50%\n+10 to Strength');
INSERT INTO unique_items VALUES (242,'Hone Sundan',261,3,0,0,98,220,0,28,37,101,0,'+160-200% Enhanced Damage\nAdds 20-40 Damage\n45% Chance of Crushing Blow\nRepairs 1 Durability in 10 Seconds\nSocketed (3)');
INSERT INTO unique_items VALUES (243,'Spire of Honor',262,5,0,0,90,385,0,25,39,110,88,'+150-200% Enhanced Damage\nAdds 20-40 Damage\n+ (1.5 Per Character Level) 1.5-148.5 % Damage to Demons\n20% Faster Hit Recovery\nReplenish Life +20\n+25% Bonus to Attack Rating\n+25% Enhanced Defense\n+3 to Combat Skills (Paladin only)\n+3 to Light Radius');
INSERT INTO unique_items VALUES (244,'Razorswitch',6,2,0,0,6,21,0,0,28,18,0,'150% Damage to Undead\n+1 to All Skill Levels\n30% Faster Cast Rate\nMagic Damage Reduced by 15\nAll Resistances +50\n+175 to Mana\n+80 to Life\nAttacker Takes Damage of 15');
INSERT INTO unique_items VALUES (245,'Ribcracker',264,3,0,0,57,173,0,130,31,25,0,'+200-300% Enhanced Damage\nAdds 30-65 Damage\n150% Damage to Undead\n50% Chance of Crushing Blow\n50% Increased Attack Speed\n50% Faster Hit Recovery\n+100% Enhanced Defense\n+100 Defense\n+15 to Dexterity');
INSERT INTO unique_items VALUES (246,'Chromatic Ire',265,4,0,0,11,32,0,35,35,25,0,'150% Damage to Undead\n20% Faster Cast Rate\n+3 to Sorceress Skill Levels\nIncrease Maximum Life 20-25%\nAll Resistances +20-40\nAttacker Takes Lightning Damage of 20\n+1 to Cold Mastery (Sorceress only)\n+1 to Lightning Mastery (Sorceress only)\n+1 to Fire Mastery (Sorceress only)');
INSERT INTO unique_items VALUES (247,'Warpspear',266,3,0,0,14,34,0,40,39,25,0,'150% Damage to Undead\nIgnore Target\'s Defense\n+250 Defense vs. Missiles\n+3 to Sorceress Skill Levels\n+3 to Energy Shield (Sorceress only)\n+3 to Telekinesis (Sorceress only)\n+3 to Teleport (Sorceress only)');
INSERT INTO unique_items VALUES (248,'Skull Collector',267,5,0,0,24,58,0,50,41,25,0,'150% Damage To Undead\n+20 to Mana after Each Kill\nIncrease Maximum Mana 20%\n+ (1 per Character Level) 1-99% Better Chance of Getting Magic Items\n+2 to All Skill Levels');
INSERT INTO unique_items VALUES (249,'Bloodletter',268,3,33,100,0,0,0,54,30,25,0,'Adds 12-45 Damage\n+90 to Attack Rating\n20% Increased Attack Speed\n10% Slower Stamina Drain\n8% Life Stolen per Hit\n+1-3 to Whirlwind (Barbarian only)\n+2-4 to Sword Mastery (Barbarian only)');
INSERT INTO unique_items VALUES (250,'Coldsteel Eye',269,1,27,77,0,0,0,76,31,25,52,'+200-250% Enhanced Damage\n50% Chance of Deadly Strike\n20% Increased Attack Speed\n6% Mana Stolen per Hit\nSlows Target by 30%\nHit Blinds Target');
INSERT INTO unique_items VALUES (251,'Hexfire',270,2,61,105,0,0,0,32,33,58,58,'+140-160% Enhanced Damage\nAdds 35-40 Damage\n+3 to Fire Skills\nLevel 6 Hydra (36 Charges)\nIgnore Target\'s Defense\nFire Resist +25%\n10% to Maximum Fire Resist');
INSERT INTO unique_items VALUES (252,'Blade of Ali Baba',271,5,27,89,0,0,0,32,35,70,42,'+60-120% Enhanced Damage\n+ (2.5 per Character Level) 2.5-247.5 % Extra Gold from Monsters\n+ (1 Per Character Level) 1-99 % Better Chance of Getting Magic Items\n+15 to Mana\n+5-15 to Dexterity\nSocketed (2)');
INSERT INTO unique_items VALUES (253,'Headstriker',272,3,42,186,0,0,0,32,39,92,43,'150% Enhanced Damage\n+ (1 per Character Level) 1-99 to Maximum Damage (Based on Character Level)\n(0.75 per Character Level) 0.75-74.25 % Deadly Strike\nPrevent Monster Heal\n+15 to Strength');
INSERT INTO unique_items VALUES (254,'Plague Bearer',273,2,37,152,0,0,0,44,41,103,79,'150% Enhanced Damage\nAdds 10-45 Damage\n+300 Poison Damage over 8 Seconds\n5% Chance to Cast Level 4 Poison Nova on Striking\nPoison Resist +45%\n+5 to Rabies (Druid only)');
INSERT INTO unique_items VALUES (255,'The Atlantean',274,3,57,154,0,0,0,144,42,127,88,'+200-250% Enhanced Damage\n+2 to Paladin Skill Levels\n50% Bonus to Attack Rating\n+75 Defense\n+8 to Vitality\n+12 to Dexterity\n+16 to Strength');
INSERT INTO unique_items VALUES (256,'Crainte Vomir',275,3,23,81,49,123,0,44,42,73,61,'+160-200% Enhanced Damage\n50% Increased Attack Speed\nSlows Target by 35%\n-70 to Monster Defense per Hit\n20% Faster Run/Walk\nDamage Reduced by 10%');
INSERT INTO unique_items VALUES (257,'The Vile Husk',276,3,27,95,50,177,0,50,44,104,71,'+150-200% Enhanced Damage(varies)\n+ (7.5 per Character Level) 7-742.5% Damage to Undead\n+ (10 per Character Level) 10-990 to Attack Rating\n+250 Poison Damage over 6 Seconds\n6% Chance to Cast Level 1 Amplify Damage on Attack\nPoison Resist +50%');
INSERT INTO unique_items VALUES (258,'Cloudcrack',277,4,37,123,100,183,0,40,45,113,20,'+150-200% Enhanced Damage\n6% Chance to Cast Level 7 Fist of The Heavens on Attack\nAdds 1-240 Lightning Damage\n10% to Maximum Lightning Resist\n+30 Defense\nAttacker Takes Lightning Damage of 15\n+2 to Defensive Auras (Paladin only)\n+2 to Offensive Auras (Paladin only)\n+2 to Light Radius');
INSERT INTO unique_items VALUES (259,'Todesfaelle Flamme',278,2,44,93,66,143,0,50,46,125,94,'120-160% Enhanced Damage\nAdds 50-200 Fire Damage\n10% Chance To Cast Level 6 Fire Ball on Attack\nLevel 10 Fire Wall (20 Charges)\nLevel 10 Enchant (45 Charges)\n+10 Fire Absorb\nFire Resist +40%');
INSERT INTO unique_items VALUES (260,'Swordguard',279,4,67,114,129,226,0,50,48,85,55,'+170-180% Enhanced Damage\n+ (5 per Character Level) 5-495 Defense\n30% Damage taken Goes to Mana\nRequirements -50%\nAll Resistances +10-20\n20% Faster Hit Recovery\n20% Increased Chance of Blocking\n+100 Defense vs. Missile\n+200 Defense vs. Melee');
INSERT INTO unique_items VALUES (261,'Death Bit',280,3,20,47,0,0,0,0,44,25,52,'+130-180% Enhanced Damage\n40% Deadly Strike\n+200-450 to Attack Rating\n7-9% Life Stolen per Hit\n4-6% Mana Stolen per Hit');
INSERT INTO unique_items VALUES (262,'The Scalper',281,4,30,69,0,0,0,0,57,80,25,'+150-200% Enhanced Damage\n33% Chance of Open Wounds\n+4 to Mana after Each Kill\n20% Increased Attack Speed\n25% Bonus to Attack Rating\n4-6% Life Stolen per Hit');
INSERT INTO unique_items VALUES (263,'Suicide Branch',169,3,8,18,0,0,0,15,33,25,0,'150% Damage to Undead\n+1 to All Skills\n50% Faster Cast Rate\nIncrease Maximum Mana 10%\nAll Resistances +10\n+40 to Life\nAttacker Takes Damage of 25');
INSERT INTO unique_items VALUES (264,'Carin Shard',181,4,8,24,0,0,0,15,35,25,0,'150% Damage to Undead\n+ (1.25 per Character Level) 1.25-123.75 to Mana\n+ (1.25 per Character Level) 1.25-123.75 to Life \n+1 to Necromancer Skill Levels\n+2 to Summoning Skills (Necromancer only)\n10% Faster Cast Rate\n30% Faster Hit Recovery\nReplenish Life +5');
INSERT INTO unique_items VALUES (265,'Arm Of King Leoric',168,1,10,22,0,0,0,15,36,25,0,'150% Damage to Undead\n10% Chance to Cast Level 2 Bone Prison when Struck\n5% Chance to Cast Level 10 Bone Spirit when Struck\n+ (1.25 per Character Level) 1.25-123.75 to Mana\n10% Faster Cast Rate\n+2 to Terror (Necromancer only)\n+2 to Raise Skeletal Mage (Necromancer only)\n+3 to Skeleton Mastery (Necromancer only)\n+3 to Raise Skeleton (Necromancer only)\n+2 to Summoning Skills (Necromancer only)\n+2 to Poison And Bone Skills (Necromancer only)');
INSERT INTO unique_items VALUES (266,'Blackhand Key',282,3,23,54,0,0,0,15,41,25,0,'150% Damage to Undead\n+2 To Necromancer Skill Levels\n+1 To Curses (Necromancer only)\n20% Damage Taken Goes to Mana\n30% Faster Cast Rate\nFire Resist +37%\n+50 to Life\nLevel 13 Grim Ward (30 Charges)\n-2 to Light Radius');
INSERT INTO unique_items VALUES (267,'Messerschmidt\'s Reaver',283,2,0,0,180,532,0,75,70,167,59,'+200% Enhanced Damage\n+ (2.5 per Character Level) 2.5-247.5 to Maximum Damage\nAdds 20-240 Fire Damage\n100% Bonus to Attack Rating\n+15 to Energy\n+15 to Vitality\n+15 to Dexterity\n+15 to Strength');
INSERT INTO unique_items VALUES (268,'Hellslayer',284,4,0,0,100,685,0,40,66,189,33,'+100% Enhanced Damage\n+ (3 per Character Level) 3-297% Enhanced Maximum Damage\nAdds 150-250 Fire Damage\n+ (0.5 per Character Level) 0.5-49.5 to Strength\n+ (0.5 per Character Level) 0.5-49.5 to Vitality\n10% Chance to Cast Level 19-20 Fire Ball on Attack\n+25 to Life');
INSERT INTO unique_items VALUES (269,'Eaglehorn',285,4,0,0,48,318,0,0,69,97,121,'+200% Enhanced Damage\n+ (2 per Character Level) 2-198% Enhanced Maximum Damage (Based on Character Level)\n+1 to Amazon Skill Levels\n+ (6 per Character Level) 6-594 to Attack Rating (Based on Character Level)\n+25 to Dexterity\nIgnores Target\'s Defense');
INSERT INTO unique_items VALUES (270,'Windforce',286,4,0,0,38,550,0,0,74,134,167,'+250% Enhanced Damage\n+ (3.125 per Character Level) 3.125-309.375 to Maximum Damage\n20% Increased Attack Speed\n6-8% Mana Stolen per Hit\nHeal Stamina Plus 30%\n+10 to Strength\n+5 to Dexterity\nKnockback');
INSERT INTO unique_items VALUES (271,'Baranar\'s Star',287,4,132,162,0,0,0,172,65,153,44,'200% Enhanced Damage\n150% Damage to Undead\nAdds 1-200 Fire Damage\nAdds 1-200 Lightning Damage\nAdds 1-200 Cold Damage\n50% Increased Attack Speed\n200% Bonus to Attack Rating\n+15 to Dexterity\n+15 to Strength');
INSERT INTO unique_items VALUES (272,'The Cranium Basher',288,5,0,0,113,635,0,0,87,253,0,'+200-240% Enhanced Damage\nAdds 20-20 Damage\n150% Damage to Undead\n75% Chance of Crushing Blow\n4% Chance to Cast Level 1 Amplify Damage on Attack\n20% Increased Attack Speed\nAll Resistances +25\n+25 to Strength\nIndestructible');
INSERT INTO unique_items VALUES (273,'Schaefer\'s Hammer',289,5,102,340,0,0,0,0,79,189,0,'+100-130% Enhanced Damage (varies)\n+ (2 per Charachter Level) 2-198 to Maximum Damage\nAdds 50-200 Lightning Damage\n150% Damage to Undead\n20% Chance to Cast Level 10 Static Field on Attack\n20% Increased Attack Speed\n+ (8 per Character Level) 8-792 to Attack Rating\nLightning Resist +75%\n+50 to Life\n+1 to Light Radius\nIndestructible');
INSERT INTO unique_items VALUES (274,'Lightsabre',290,1,90,138,0,0,0,0,58,25,136,'+150-200% Enhanced Damage (varies)\nAdds 10-30 Damage\nAdds 60-120 Magic Damage\nAdds 1-200 Lightning Damage\n5-8% Mana Stolen per Hit (varies)\n5% Chance to Cast Level (8-16) Chain Lightning on Attack\n20% Increased Attack Speed\nIgnore Target\'s Defense\nLightning Absorb 25%\n+7 to Light Radius');
INSERT INTO unique_items VALUES (275,'Doombringer',291,2,100,292,231,394,0,0,69,163,103,'+180-250% Enhanced Damage\nAdds 30-100 Damage\n8% Chance to Cast Level 3 Weaken on Attack\n40% Bonus to Attack Rating\nIncrease Maximum Life 20%\n5-7% Life Stolen per Hit\nIndestructible');
INSERT INTO unique_items VALUES (276,'The Grandfather',59,2,67,180,155,674,0,0,81,108,110,'+150-250% Enhanced Damage\n+ (2.5 Per Character Level) 2.5-247.5 to Maximum Damage\n+50% Bonus to Attack Rating\n+80 to Life\n+20 to Dexterity\n+20 to Strength\n+20 to Vitality\n+20 to Energy\nIndestructible');
INSERT INTO unique_items VALUES (277,'Stormspire',293,2,0,0,102,402,0,0,70,188,140,'150-250% Enhanced Damage\nAdds 1-237 Lightning Damage\n2% Chance to Cast Level 31 Charged Bolt when Struck\n5% Chance to Cast Level 5 Chain Lightning when Struck\n30% Increased Attack Speed\nLightning Resist +50%\n+10 to Strength\nAttacker Takes Lightning Damage of 27\nIndestructible');
INSERT INTO unique_items VALUES (278,'Wizardspike',294,1,23,49,0,0,0,0,61,38,75,'+ (2 per Character Level) 2-198 to Mana\n50% Faster Cast Rate\nRegenerate Mana 15%\nIncrease Maximum Mana 15%\nAll Resistances +75\nIndestructible');

