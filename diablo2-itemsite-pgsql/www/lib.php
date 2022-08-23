<?php
	require "config.php";
	require "DB.php";
	require "Smarty.class.php";

	$GLOBALS["CLASSMAP"] = array(
		"am" => "Amazon",
		"as" => "Assassin",
		"ba" => "Barbarian",
		"dr" => "Druid",
		"ne" => "Necromancer",
		"pa" => "Paladin",
		"so" => "Sorceress"
	);

	function getItemDetails (&$item, $itemid, $itemtypeid) {
		/* reset the itemclass-values */
		$item[$itemid]["base"] = array();

		/* Grab the damage and durability */
		$pres = $GLOBALS["DB"]->query("
			SELECT p.name,ip.value_min AS min,ip.value_max AS max,ip.value
			FROM	item_type_prop ip,itemproperty p
			WHERE	ip.itemtypeid=? AND ip.itempropid=p.itempropid
			AND p.name IN ('Defense', 'One-handed Damage', 'Two-handed Damage', 'Durability')
		", array($itemtypeid));
		if (PEAR::isError($pres)) { die($pres->getMessage()); }
		while ($b = $pres->fetchRow()) {
			$item[$itemid]["base"][$b["name"]] = $b;
		}

		/* Fetch the item's properties, too */
		$ires = $GLOBALS["DB"]->query("
			SELECT	p.name,ip.value AS value,
			ip.value_min AS min,ip.value_max AS max,ip.value_perlevel AS perlevel
			FROM	itemproperty p,item_item_prop ip
			WHERE	p.itempropid=ip.itempropid
			AND	ip.itemid=?
		", array($itemid));
		if (PEAR::isError($ires)) { die($ires->getMessage()); }

		while ($b = $ires->fetchRow()) {
			$item[$itemid]["properties"][] = $b;
		}

		/* Fetch the item's cached properties, too */
		$cres = $GLOBALS["DB"]->query("
			SELECT	p.name,ip.value AS value,
			ip.value_min AS min,ip.value_max AS max
			FROM	itemproperty p,item_itemprop_cache ip
			WHERE	p.itempropid=ip.itempropid
			AND	ip.itemid=?
		", array($itemid));
		if (PEAR::isError($cres)) { die($cres->getMessage()); }

		while ($b = $cres->fetchRow()) {
			$item[$itemid]["cacheprops"][] = $b;

			/* If we have a cached value of a base property, this certainly overrides
			 * the base property, so get rid of it */
			if ($item[$itemid]["base"][$b["name"]]) {
				unset($item[$itemid]["base"][$b["name"]]);
			}
		}

		/* Grab the number of items owned of this type */
		$ores = $GLOBALS["DB"]->query("
			SELECT	COUNT(charid) AS amount
			FROM	char_item
			WHERE	itemid=?
		", array($itemid));
		if (PEAR::isError($ores)) { die($ores->getMessage()); }
		$c = $ores->fetchRow();
		$ores = $GLOBALS["DB"]->query("
			SELECT	COUNT(charid) AS amount
			FROM	char_item
			WHERE	itemid=?
			AND	ethereal='Y'
		", array($itemid));
		if (PEAR::isError($ores)) { die($ores->getMessage()); }
		$d = $ores->fetchRow();

		/* Fetch the item set, if any */
		$sres = $GLOBALS["DB"]->query("
			SELECT	s.itemsetid,s.name
			FROM	itemset s,item i
			WHERE	i.itemsetid=s.itemsetid
			AND	i.itemid=?
		", array ($itemid));
		if (PEAR::isError($sres)) { die($sres->getMessage()); }
		$e = $sres->fetchRow();
		$item[$itemid]["itemsetid"] = $e["itemsetid"];
		$item[$itemid]["itemset"] = $e["name"];

		if ($e["name"]) {
			/* Figure out the total set items */
			$sres = $GLOBALS["DB"]->query("
				SELECT 	COUNT(itemid) AS amount
				FROM	item
				WHERE	itemsetid=?
			", array ($e["itemsetid"]));
			if (PEAR::isError($sres)) { die($sres->getMessage()); }
			$f = $sres->fetchRow();
			$item[$itemid]["total"] = $f["amount"];

			/* Figure out how many we own */
			$sres = $GLOBALS["DB"]->query("
				SELECT 	COUNT(DISTINCT i.itemid) AS amount
				FROM	item i,char_item ci
				WHERE	ci.itemid=i.itemid
				AND 	i.itemsetid=?
			", array ($e["itemsetid"]));
			if (PEAR::isError($sres)) { die($sres->getMessage()); }
			$f = $sres->fetchRow();
			$item[$itemid]["owned"] = $f["amount"];
		}

		$item[$itemid]["amount"] = $c["amount"];
		$item[$itemid]["numether"] = $d["amount"];

		/* Fetch the spells bound to the item, if any */
		$sres = $GLOBALS["DB"]->query("
			SELECT	s.name,i.level_val AS lval,i.type,
			i.level_min AS lmin,i.level_max AS lmax,
			i.pct_val AS pval,i.pct_min AS pmin,
			i.pct_max AS pmax,i.num_charges,
			s.charachter
			FROM	spell s,item_spell i
			WHERE	i.spellid=s.spellid
			AND	i.itemid=?
		", array($itemid));
		if (PEAR::isError($sres)) { die($sres->getMessage()); }

		while ($b = $sres->fetchRow()) {
			$b["class"] = $GLOBALS["CLASSMAP"][$b["charachter"]];
			$item[$itemid]["spells"][] = $b;
		}
	}

	// Initialize the database connection
	$DB =& DB::connect(DB_DSN);
	if (PEAR::isError($DB)) { die($DB->getMessage()); }
	$DB->setFetchMode(DB_FETCHMODE_ASSOC);
	$GLOBALS["DB"] = &$DB;

	// Say hello to Smarty
	$smarty = new Smarty();
	$smarty->template_dir = TEMPLATE_PATH;
	$smarty->compile_dir = COMPILE_PATH;
	$GLOBALS["smarty"] = &$smarty;
 ?>
