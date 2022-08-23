<?php
	require "lib.php";

	$id = preg_replace("/\D/", "", $_REQUEST["id"]);
	if (!$id) { die("No ID given"); };

	$res = $GLOBALS["DB"]->query("
		SELECT	i.itemid,i.name,i.req_level,i.req_str,i.req_dex,i.version,
			it.name AS itemtype,i.itemsetid,i.itemtypeid,
			it.itemcatid,it.tc
		FROM	item i,itemtype it,itemcategory ic
		WHERE	i.itemtypeid=it.itemtypeid
		AND	it.itemcatid=ic.itemcatid
		AND	i.itemid=?
	", array($id));
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow();
	$item[$a["itemid"]] = $a;
	$item[$a["itemid"]]["image"] = "images/items/uniqueset/" . preg_replace("/[^a-z]/", "", strtolower($a["name"])) . ".gif";
	getItemDetails ($item, $a["itemid"], $a["itemtypeid"]);

	/* Fetch the set name, if any */
	if ($a["itemsetid"]) {
		$res = $GLOBALS["DB"]->query("
			SELECT	name
			FROM	itemset
			WHERE	itemsetid=?
		", array($a["itemsetid"]));
		if (PEAR::isError($res)) { die($res->getMessage()); }
		$b = $res->fetchRow();
		$item[$a["itemid"]]["setname"] = $b["name"];
	} else {
		$res = $GLOBALS["DB"]->query("
			SELECT	name
			FROM	itemcategory
			WHERE	itemcatid=?
		", array($a["itemcatid"]));
		if (PEAR::isError($res)) { die($res->getMessage()); }
		$b = $res->fetchRow();
		$item[$a["itemid"]]["catname"] = $b["name"];
	}

	/* Grab the owners of this specific item */
	$res = $GLOBALS["DB"]->query("
		SELECT	DISTINCT c.name,c.charid,COUNT(ci.itemid) AS amount
		FROM	char_item ci,charachter c
		WHERE	ci.charid=c.charid
		AND	ci.itemid=?
		GROUP BY ci.itemid,c.name,c.charid
	", array ($id));
	if (PEAR::isError($res)) { die($res->getMessage()); }
	while ($b = $res->fetchRow()) {
		$item[$a["itemid"]]["owner"][] = $b;
	}

	$GLOBALS["smarty"]->assign("item", $item[$a["itemid"]]);
	if ($item[$a["itemid"]]["itemsetid"] != "") {
		$GLOBALS["smarty"]->assign("title", "Sets / " . $item[$a["itemid"]]["setname"] . " / " . $item[$a["itemid"]]["name"]) ;
	} else {
		$GLOBALS["smarty"]->assign("title", "Items / " . $item[$a["itemid"]]["catname"] . " / " . $item[$a["itemid"]]["name"]) ;
	}
	$GLOBALS["smarty"]->display("item.tpl");
 ?>
