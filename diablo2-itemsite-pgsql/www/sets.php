<?php
	require "lib.php";

	$res = $GLOBALS["DB"]->query("
		SELECT	itemsetid,name
		FROM	itemset
		ORDER BY name ASC
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }

	$sets = array();
	while ($a = $res->fetchRow()) {
		$ores = $GLOBALS["DB"]->query("
			SELECT	COUNT(DISTINCT ci.itemid) AS amount
			FROM	char_item ci,item i
			WHERE	i.itemid=ci.itemid
			AND	i.itemsetid=?
		", array ($a["itemsetid"]));
		if (PEAR::isError($ores)) { die($ores->getMessage()); }
		$b = $ores->fetchRow();

		$ares = $GLOBALS["DB"]->query("
			SELECT	COUNT(itemid) AS total
			FROM	item
			WHERE	itemsetid=?
		", array ($a["itemsetid"]));
		if (PEAR::isError($ares)) { die($ares->getMessage()); }
		$c = $ares->fetchRow();

		$a["amount"] = $b["amount"]; $a["total"] = $c["total"];
		$sets[] = $a;
	}

	$GLOBALS["smarty"]->assign("sets", $sets);
	$GLOBALS["smarty"]->assign("title", "Sets");
	$GLOBALS["smarty"]->display("sets.tpl");
 ?>
