<?php
	require "lib.php";

	$id = preg_replace("/\D/", "", $_REQUEST["id"]);
	if (!$id) { die("No ID given"); };

	$res = $GLOBALS["DB"]->query("
		SELECT	name
		FROM	itemcategory
		WHERE	itemcatid=?
	", array($id));
	if (PEAR::isError($res)) { die($res->getMessage()); }
	$a = $res->fetchRow(); $catname = $a["name"];

	$res = $GLOBALS["DB"]->query("
		SELECT	it.itemtypeid,ic.name,it.name,it.level,it.tc,
			it.sockets,it.req_level,it.req_str,it.req_dex
		FROM 	itemcategory ic,itemtype it
		WHERE	ic.itemcatid=?
		AND 	ic.itemcatid=it.itemcatid
		ORDER BY it.tc ASC
	", array($id));
	if (PEAR::isError($res)) { die($res->getMessage()); }

	while ($a = $res->fetchRow()) {
		$types[$a["itemtypeid"]] = $a;
		$types[$a["itemtypeid"]]["image"] = "images/items/types/" . preg_replace("/[^a-z]/", "", strtolower($a["name"])) . ".gif";

		$ires = $GLOBALS["DB"]->query("
			SELECT	p.name,ip.value AS value,
				ip.value_min AS min,ip.value_max AS max
			FROM	itemproperty p,item_type_prop ip
			WHERE	p.itempropid=ip.itempropid
			AND	ip.itemtypeid=?
		", array($a["itemtypeid"]));
		if (PEAR::isError($ires)) { die($ires->getMessage()); }

		while ($b = $ires->fetchRow()) {
			$types[$a["itemtypeid"]]["properties"][] = $b;
		}
	}

	$GLOBALS["smarty"]->assign("catname", $catname);
	$GLOBALS["smarty"]->assign("types", $types);
	$GLOBALS["smarty"]->assign("title", "Types / " . $catname);
	$GLOBALS["smarty"]->display("item-type.tpl");
 ?>
