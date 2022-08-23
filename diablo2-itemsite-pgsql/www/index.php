<?php
	require "lib.php";

	// grab the total number of set item
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(itemid) AS amount
		FROM item
		WHERE itemsetid IS NOT NULL
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $setitems_total = $a["amount"];
	// grab the total number of set item owned
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(DISTINCT ci.itemid) AS amount
		FROM char_item ci,item i
		WHERE ci.itemid=i.itemid AND i.itemsetid IS NOT NULL
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $setitems_owned = $a["amount"];

	// grab the total number of unique items (1.09)
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(itemid) AS amount
		FROM item
		WHERE itemsetid IS NULL
		AND version=109
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $uniqueitems109_total = $a["amount"];

	// grab the total number of unique item owned (1.09)
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(DISTINCT ci.itemid) AS amount
		FROM char_item ci,item i
		WHERE ci.itemid=i.itemid AND i.itemsetid IS NULL
		AND i.version=109
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $uniqueitems109_owned = $a["amount"];

	// grab the total number of unique items (1.10+)
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(itemid) AS amount
		FROM item
		WHERE itemsetid IS NULL
		AND version>=110
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $uniqueitems110_total = $a["amount"];

	// grab the total number of unique item owned (1.10+)
	$res = $GLOBALS["DB"]->query("
		SELECT COUNT(DISTINCT ci.itemid) AS amount
		FROM char_item ci,item i
		WHERE ci.itemid=i.itemid AND i.itemsetid IS NULL
		AND i.version>=110
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $uniqueitems110_owned = $a["amount"];

	// fetch the number of items per set
	$res = $GLOBALS["DB"]->query("
		SELECT	i.itemsetid,COUNT(DISTINCT ci.itemid) AS itemcount
		FROM	char_item ci,item i
		WHERE	ci.itemid=i.itemid
		AND	i.itemsetid IS NOT NULL
		GROUP BY i.itemsetid
	");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	while ($a = $res->fetchRow()) {
		$res2 = $GLOBALS["DB"]->query("
			SELECT	COUNT(itemid) AS count
			FROM	item
			WHERE	itemsetid=?
		", array ($a["itemsetid"]));
		if (PEAR::isError($res2)) { die($res2->getMessage()); }
		$b = $res2->fetchRow();

		$setitems++;
		if ($a["itemcount"] == $b["count"]) {
			$setcomplete++;
		}
	}

	$GLOBALS["smarty"]->assign("uniqueitems109_total", $uniqueitems109_total);
	$GLOBALS["smarty"]->assign("uniqueitems109_owned", $uniqueitems109_owned);
	$GLOBALS["smarty"]->assign("uniqueitems109_pct", sprintf("%.02f", ($uniqueitems109_owned  / $uniqueitems109_total) * 100));
	$GLOBALS["smarty"]->assign("uniqueitems110_total", $uniqueitems110_total);
	$GLOBALS["smarty"]->assign("uniqueitems110_owned", $uniqueitems110_owned);
	$GLOBALS["smarty"]->assign("uniqueitems110_pct", sprintf("%.02f", ($uniqueitems110_owned  / $uniqueitems110_total) * 100));
	$GLOBALS["smarty"]->assign("items109_total", ($setitems_total + $uniqueitems109_total));
	$GLOBALS["smarty"]->assign("items109_owned", ($setitems_owned + $uniqueitems109_owned));
	$GLOBALS["smarty"]->assign("items109_pct", sprintf("%.02f", (($setitems_owned + $uniqueitems109_owned)  / ($setitems_total + $uniqueitems109_total)) * 100));
	$GLOBALS["smarty"]->assign("items_total", ($setitems_total + $uniqueitems109_total + $uniqueitems110_total));
	$GLOBALS["smarty"]->assign("items_owned", ($setitems_owned + $uniqueitems109_owned + $uniqueitems110_owned));
	$GLOBALS["smarty"]->assign("items_pct", sprintf("%.02f", (($setitems_owned + $uniqueitems109_owned + $uniqueitems110_owned)  / ($setitems_total + $uniqueitems109_total + $uniqueitems110_total) * 100)));
	$GLOBALS["smarty"]->assign("setitems_total", $setitems_total);
	$GLOBALS["smarty"]->assign("setitems_owned", $setitems_owned);
	$GLOBALS["smarty"]->assign("setitems_pct", sprintf("%.02f", ($setitems_owned  / $setitems_total) * 100));
	$GLOBALS["smarty"]->assign("sets_total", $setitems ? $setitems : 0);
	$GLOBALS["smarty"]->assign("sets_complete", $setcomplete ? $setcomplete : 0);
	$GLOBALS["smarty"]->assign("sets_pct", sprintf("%.02f",  (($setcomplete / ($setitems ? $setitems : 1)) * 100)));

	$GLOBALS["smarty"]->display("index.tpl");
 ?>
