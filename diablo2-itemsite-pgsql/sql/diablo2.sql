DROP TABLE item_type_prop;
DROP TABLE item_item_prop;
DROP TABLE item_itemprop_cache;
DROP TABLE item;
DROP TABLE itemproperty;
DROP TABLE itemtype;
DROP TABLE itemcategory;
DROP TABLE itemset;
DROP TABLE charachter;
DROP TABLE spell;

DROP SEQUENCE itemcatid_seq;
DROP SEQUENCE itemtypeid_seq;
DROP SEQUENCE itempropid_seq;
DROP SEQUENCE itemsetid_seq;
DROP SEQUENCE itemid_seq;
DROP SEQUENCE charid_seq;
DROP SEQUENCE spellid_seq;

CREATE SEQUENCE itemcatid_seq;
CREATE SEQUENCE itemtypeid_seq;
CREATE SEQUENCE itempropid_seq;
CREATE SEQUENCE itemsetid_seq;
CREATE SEQUENCE itemid_seq;
CREATE SEQUENCE charid_seq;
CREATE SEQUENCE spellid_seq;

CREATE TABLE itemcategory (
	itemcatid INTEGER NOT NULL DEFAULT nextval('itemcatid_seq'),
	name VARCHAR(32) NOT NULL,
	PRIMARY KEY (itemcatid)
);

CREATE TABLE itemtype (
	itemtypeid INTEGER NOT NULL DEFAULT nextval('itemtypeid_seq'),
	name VARCHAR(64) NOT NULL,
	itemcatid INTEGER NOT NULL,
	-- this is an interesting one: an item can be of a category,
	-- but be associated with another category for bonusses
	itemclasscatid INTEGER,
	-- item level, 0 = normal, 1 = exceptional, 2 = elite
	level INTEGER NOT NULL,
	-- treasure class
	tc INTEGER,
	sockets INTEGER,
	-- requiremens
	req_level INTEGER,
	req_str INTEGER,
	req_dex INTEGER,
	CHECK (sockets >= 0 AND sockets <= 6),
	CHECK (level >= 0 AND level <= 2),
	CHECK (tc >= 3 AND tc <= 90),
	CHECK (req_level >= 2 AND req_level <= 99),
	CHECK (req_str > 0 AND req_str <= 300),
	CHECK (req_dex > 0 AND req_dex <= 300),
	PRIMARY KEY (itemtypeid),
	FOREIGN KEY (itemcatid) REFERENCES itemcategory (itemcatid)
);

CREATE TABLE itemproperty (
	itempropid INTEGER NOT NULL DEFAULT nextval('itempropid_seq'),
	name VARCHAR(64) NOT NULL,
	PRIMARY KEY (itempropid)
);

CREATE TABLE item_type_prop (
	itemtypeid INTEGER NOT NULL,
	itempropid INTEGER NOT NULL,
	value INTEGER,
	value_min INTEGER,
	value_max INTEGER,
	-- do not allow value and value_{min,max} to be filled out at the
	-- same time; but all three NULL is fine.
	CHECK ((value IS NOT NULL AND value_min IS NULL AND value_max IS NULL)
	OR (value IS NULL AND value_min IS NOT NULL AND value_max IS NOT NULL)
	OR (value IS NULL AND value_min IS NULL AND value_max IS NULL)),
	PRIMARY KEY (itemtypeid, itempropid),
	FOREIGN KEY (itemtypeid) REFERENCES itemtype (itemtypeid),
	FOREIGN KEY (itempropid) REFERENCES itemproperty (itempropid)
);

CREATE TABLE itemset (
	itemsetid INTEGER NOT NULL DEFAULT nextval('itemsetid_seq'),
	name VARCHAR(64) NOT NULL,
	PRIMARY KEY (itemsetid)
);

CREATE TABLE item (
	itemid INTEGER NOT NULL DEFAULT nextval('itemid_seq'),
	name VARCHAR(64) NOT NULL,
	itemtypeid INTEGER NOT NULL,
	itemsetid INTEGER,
	sockets INTEGER,
	-- requirements
	req_level INTEGER,
	req_str INTEGER,
	req_dex INTEGER,
	-- diablo2 version in which the item features
	version INTEGER,
	CHECK (version >= 109 AND version <= 111),
	CHECK (sockets >= 0 AND sockets <= 6),
	CHECK (req_level >= 2 AND req_level <= 99),
	CHECK (req_str > 0 AND req_str <= 300),
	CHECK (req_dex > 0 AND req_dex <= 300),
	PRIMARY KEY (itemid),
	FOREIGN KEY (itemtypeid) REFERENCES itemtype (itemtypeid),
	FOREIGN KEY (itemsetid) REFERENCES itemset (itemsetid)
);

CREATE TABLE item_item_prop (
	itemid INTEGER NOT NULL,
	itempropid INTEGER NOT NULL,
	value INTEGER,
	value_min INTEGER,
	value_max INTEGER,
	value_perlevel FLOAT,
	-- do not allow value value_{min,max} or value_perrevel to be filled
	-- out at the same time; but all fou4 NULL is fine.
	CHECK ((value IS NOT NULL AND value_min IS NULL AND value_max IS NULL AND value_perlevel IS NULL)
	OR (value IS NULL AND value_min IS NOT NULL AND value_max IS NOT NULL AND value_perlevel IS NULL)
	OR (value IS NULL AND value_min IS NULL AND value_max IS NULL AND value_perlevel IS NOT NULL)
	OR (value IS NULL AND value_min IS NULL AND value_max IS NULL AND value_perlevel IS NULL)),
--	PRIMARY KEY (itemid, itempropid),
	FOREIGN KEY (itemid) REFERENCES item (itemid),
	FOREIGN KEY (itempropid) REFERENCES itemproperty (itempropid)
);

CREATE TABLE item_itemprop_cache (
	itemid INTEGER NOT NULL,
	itempropid INTEGER NOT NULL,
	value INTEGER,
	value_min INTEGER,
	value_max INTEGER,
	-- do not allow value or value_{min,max} to be filled
	-- out at the same time
	CHECK ((value IS NOT NULL AND value_min IS NULL AND value_max IS NULL)
	OR (value IS NULL AND value_min IS NOT NULL AND value_max IS NOT NULL)),
	-- this does not have to hold...
	-- PRIMARY KEY (itemid, itempropid),
	FOREIGN KEY (itemid) REFERENCES item (itemid),
	FOREIGN KEY (itempropid) REFERENCES itemproperty (itempropid)
);

CREATE TABLE charachter (
	charid INTEGER NOT NULL DEFAULT nextval('charid_seq'),
	class CHAR(2) NOT NULL,
	name VARCHAR(32) NOT NULL,
	level INTEGER NOT NULL,
	version INTEGER NOT NULL,
	CHECK (class IN ('am', 'as', 'ba', 'dr', 'ne', 'pa', 'so')),
	CHECK (level >= 1 AND level <= 99),
	CHECK (version >= 109 AND version <= 111),
	PRIMARY KEY (charid)
);

CREATE TABLE char_item (
	charid INTEGER NOT NULL,
	itemid INTEGER NOT NULL,
	ethereal CHAR NOT NULL DEFAULT 'N',
	CHECK (ethereal IN ('Y', 'N')),
	FOREIGN KEY (charid) REFERENCES charachter (charid),
	FOREIGN KEY (itemid) REFERENCES item (itemid)
);

CREATE INDEX charitem_charid_idx ON char_item (charid);

CREATE TABLE spell (
	spellid INTEGER NOT NULL DEFAULT nextval('spellid_seq'),
	name VARCHAR(32) NOT NULL,
	charachter CHAR(2),
	CHECK (charachter IN ('am', 'as', 'ba', 'dr', 'ne', 'pa', 'so', '*')),
	PRIMARY KEY (spellid)
);

CREATE TABLE item_spell (
	itemid INTEGER NOT NULL,
	spellid INTEGER NOT NULL,
	type CHAR(1) NOT NULL,
	-- level of the spell
	level_val INTEGER,
	level_min INTEGER,
	level_max INTEGER,
	-- chance to cast it, if not charged spell
	pct_val INTEGER,
	pct_min INTEGER,
	pct_max INTEGER,
	-- number of charges, if this is a charged spell
	num_charges INTEGER,
	-- either level_val must be specified, or min/max, but not both
	CHECK ((level_val IS NOT NULL AND level_min IS NULL AND level_max IS NULL) OR
	       (level_val IS NULL AND level_min IS NOT NULL AND level_max IS NOT NULL)),
	-- ensure a valid type is given
	-- (On striking, When Struck, on Attack, Charges, Skill, when you dIe, when you Level-up, when you Kill an enemy)
	CHECK (type IN ('O', 'W', 'A', 'C', 'S', 'I', 'L', 'K')),
	-- charges are only allowed if the type is for charges
	CHECK (type != 'C' OR num_charges IS NOT NULL),
	-- either pct_val is specified, or pct_min/max, but not both (only
	-- on non-charged items)
	CHECK ((type = 'C' OR type = 'S') OR (
		(pct_val IS NOT NULL AND pct_min IS NULL AND pct_max IS NULL) OR
		(pct_val IS NULL AND pct_min IS NOT NULL AND pct_max IS NOT NULL)
	)),
	FOREIGN KEY (itemid) REFERENCES item (itemid),
	FOREIGN KEY (spellid) REFERENCES spell (spellid)
);
