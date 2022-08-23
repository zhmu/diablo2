<?php
	require "lib.php";

	$in["sort"] = preg_replace("/\D/", "", $_REQUEST["sort"]) + 0;
	$in["only109"] = $_REQUEST["only109"];

	$items = array();
	if ($_REQUEST["generate"] != "") {
		$attrs = "";
		if ($in["sort"] == 0) {
			$sortby = "i.name ASC";
		} else {
			$sortby = "COUNT(ci.itemid) DESC";
		}
		if ($in["only109"] != "") {
			$attrs .= " AND i.version=109";
		}

		/* Query all items */
		$res = $GLOBALS["DB"]->query("
			SELECT  i.itemid,i.name,COUNT(ci.itemid) AS amount,
		                it.name AS itemtype
			FROM    char_item ci,item i,itemtype it
			WHERE   ci.itemid=i.itemid
			AND	it.itemtypeid=i.itemtypeid
			$attrs
			GROUP BY i.itemid,i.name,it.name
			ORDER BY $sortby");
		if (PEAR::isError($res)) { die($res->getMessage()); }

		while ($a = $res->fetchRow()) {
			/* Fetch the item set, if any */
			$sres = $GLOBALS["DB"]->query("
				SELECT  s.itemsetid,s.name
				FROM    itemset s,item i
				WHERE   i.itemsetid=s.itemsetid
				AND     i.itemid=?
			", array ($a["itemid"]));
			if (PEAR::isError($sres)) { die($sres->getMessage()); }
			$e = $sres->fetchRow();
			$a["itemsetid"] = $e["itemsetid"];
			$a["itemset"] = $e["name"];

			$items[] = $a;
		}
	}

	$GLOBALS["smarty"]->assign("in", $in);
	$GLOBALS["smarty"]->assign("items", $items);
	$GLOBALS["smarty"]->assign("title", "Overview");
	$GLOBALS["smarty"]->display("overview.tpl");
 ?>
