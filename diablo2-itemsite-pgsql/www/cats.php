<?php
	require "lib.php";

	$res = $GLOBALS["DB"]->query("SELECT itemcatid,name FROM itemcategory ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }

	$cats = array();
	while ($a = $res->fetchRow()) {
		$r = $GLOBALS["DB"]->query("SELECT COUNT(i.itemid) AS count FROM item i,itemtype id WHERE i.itemtypeid=id.itemtypeid AND id.itemcatid=?", array($a["itemcatid"]));
		if (PEAR::isError($r)) { die($r->getMessage()); }
		$v = $r->fetchRow();
		$a["numitems"] = $v["count"];

		$r = $GLOBALS["DB"]->query("SELECT COUNT(DISTINCT i.itemid) AS count FROM item i,itemtype id,char_item ci WHERE i.itemtypeid=id.itemtypeid AND id.itemcatid=? AND i.itemid=ci.itemid", array($a["itemcatid"]));
		if (PEAR::isError($r)) { die($r->getMessage()); }
		$v = $r->fetchRow();
		$a["numowned"] = $v["count"];

		$cats[] = $a;
	}

	$GLOBALS["smarty"]->assign("cats", $cats);
	$GLOBALS["smarty"]->assign("title", "Items");
	$GLOBALS["smarty"]->display("cats.tpl");
 ?>
