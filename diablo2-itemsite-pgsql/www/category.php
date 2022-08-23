<?php
	require "lib.php";

	$id = preg_replace("/\D/", "", $_REQUEST["id"]);
	if (!$id) { die("No ID given"); };

	$res = $GLOBALS["DB"]->query("
		SELECT	name
		FROM	itemcategory
		WHERE	itemcatid=?
	", array($id));
	$a = $res->fetchRow(); $catname = $a["name"];

	$res = $GLOBALS["DB"]->query("
		SELECT	i.itemid,i.name,i.req_level,i.req_str,i.req_dex,i.version,
			it.name AS itemtype,i.itemsetid,i.itemtypeid,
			it.itemcatid,it.tc
		FROM	item i,itemtype it,itemcategory ic
		WHERE	i.itemtypeid=it.itemtypeid
		AND	it.itemcatid=ic.itemcatid
		AND	it.itemcatid=?
		ORDER BY i.req_level ASC
	", array($id));
	if (PEAR::isError($res)) { die($res->getMessage()); }

	while ($a = $res->fetchRow()) {
		$item[$a["itemid"]] = $a;
		$item[$a["itemid"]]["image"] = "images/items/uniqueset/" . preg_replace("/[^a-z]/", "", strtolower($a["name"])) . ".gif";

		getItemDetails ($item, $a["itemid"], $a["itemtypeid"]);
	}

	$GLOBALS["smarty"]->assign("catname", $catname);
	$GLOBALS["smarty"]->assign("items", $item);
	$GLOBALS["smarty"]->assign("title", "Items / " . $catname);
	$GLOBALS["smarty"]->display("cat_items.tpl");
 ?>
