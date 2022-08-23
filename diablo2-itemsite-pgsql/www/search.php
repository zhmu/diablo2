<?php
	require "lib.php";

	/* Operators */
	$modops = array(
		"0" => array(id => 0, name => ">="),
		"1" => array(id => 1, name => "="),
		"2" => array(id => 2, name => "<="),
	);
	$spellops = array(
		"0" => array(id => 0, value => "", name => "[any]"),
		"1" => array(id => 1, value => "O", name => "Cast on striking"),
		"2" => array(id => 2, value => "W", name => "Cast when struck"),
		"3" => array(id => 3, value => "A", name => "Cast on attack"),
		"4" => array(id => 4, value => "C", name => "Charges"),
		"5" => array(id => 5, value => "S", name => "+spell"),
		"6" => array(id => 6, value => "I", name => "Cast when you die"),
		"7" => array(id => 6, value => "L", name => "Cast when you level-up"),
	);

	/* Fetch the item categories */
	$res = $GLOBALS["DB"]->query("SELECT itemcatid,name FROM itemcategory ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	while ($a = $res->fetchRow()) { $itemcats[] = $a; };

	/* Fetch all item properties */
	$res = $GLOBALS["DB"]->query("SELECT itempropid,name FROM itemproperty ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	while ($a = $res->fetchRow()) { $itemprops[] = $a; };

	/* Fetch all spells */
	$res = $GLOBALS["DB"]->query("SELECT spellid,name FROM spell ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }
	while ($a = $res->fetchRow()) { $spells[] = $a; };

	/* Pollute the input array */
	$in["itemcatid"] = preg_replace("/\D/", "",$_REQUEST["itemcat"]);
	$in["clevel"] = preg_replace("/\D/", "", $_REQUEST["clevel"]);
	$in["onlyfound"] = $_REQUEST["onlyfound"];
	$in["only109"] = $_REQUEST["only109"];
	$maxmod = 0;
	while (list ($n) = @each ($_REQUEST["domod"])) {
		$in["mods"][$n] = array(
			num => $n,
			id => preg_replace("/\D/", "", $_REQUEST["mod"][$n]),
			value => preg_replace("/\D/", "", $_REQUEST["modval"][$n]),
			op => preg_replace("/\D/", "", $_REQUEST["modop"][$n])
		);
		if ($maxmod < $n) { $maxmod = $n; }
	}
	$maxspell = 0;
	while (list ($n) = @each ($_REQUEST["dospell"])) {
		$in["spells"][$n] = array(
			num => $n,
			id => preg_replace("/\D/", "", $_REQUEST["spell"][$n]),
			op => preg_replace("/\D/", "", $_REQUEST["spellop"][$n])
		);
		if ($maxspell < $n) { $maxspell = $n; }
	}

	/* Handle the 'modifier add' and 'search' actions' */
	if ($_REQUEST["addmod"] != "") {
		$in["mods"][$maxmod + 1] = array(
			num => $maxmod + 1,
			id => 0,
			value => "",
			op => 0
		);
	} elseif ($_REQUEST["addspell"] != "") {
		$in["spells"][$maxspell + 1] = array(
			num => $maxspell + 1,
			id => 0,
			value => "",
		);
	} elseif (count($_REQUEST["delmod"]) > 0) {
		while (list ($n) = each($_REQUEST["delmod"])) {
			unset ($in["mods"][$n]);
		}
	} elseif (count($_REQUEST["delspell"]) > 0) {
		while (list ($n) = each($_REQUEST["delspell"])) {
			unset ($in["spells"][$n]);
		}
	} elseif ($_REQUEST["search"] != "") {
		/* Yes. Construct the query */
		$attrs = "";
		if ($in["itemcatid"] != "") { $attrs = "AND ic.itemcatid=" . $in["itemcatid"] . "\n"; }
		if ($in["clevel"] != "") { $attrs .= "AND i.req_level<" . $in["clevel"] . "\n"; }
		if ($in["onlyfound"] != "") {
			$attrs .= "AND EXISTS (
					SELECT NULL
					FROM char_item chi
					WHERE chi.itemid=i.itemid
				    )\n";
		}
		if ($in["only109"] != "") {
			$attrs .= "AND i.version=109\n";
		}
		while (list ($n) = @each ($in["mods"])) {
			$id = $in["mods"][$n]["id"]; $value = $in["mods"][$n]["value"];
			$clevel = is_numeric($in["clevel"]) ? $in["clevel"] : 1;
			$opid = $in["mods"][$n]["op"];
			if (!isset ($modops[$opid])) { $opid = 0; };
			$op = $modops[$opid]["name"];
			if ($value != "") {
				$valuechk1 = " AND   (
							(ip.value $op $value) OR
							(ip.value_max $op $value) OR
							(ip.value_perlevel * $clevel $op $value)
						)";
				$valuechk2 = " AND   (
							(ipc.value $op $value) OR
							(ipc.value_max $op $value)
						)";
			} else {
				$valuechk1 = "";
				$valuechk2 = "";
			}
			$attrs .= "AND EXISTS (
						SELECT NULL
						FROM item_item_prop ip
						WHERE ip.itemid=i.itemid
						AND   ip.itempropid=$id
						$valuechk1
						UNION ALL
						SELECT NULL
						FROM item_itemprop_cache ipc
						WHERE ipc.itemid=i.itemid
						AND   ipc.itempropid=$id
						$valuechk2
					)";
		}	
		while (list ($n) = @each ($in["spells"])) {
			$id = $in["spells"][$n]["id"];
			$opid = $in["spells"][$n]["op"];
			if (!isset ($spellops[$opid])) { $opid = 0; };
			$opattr = "";
			if ($spellops[$opid]["value"] != "") {
				$opattr = "AND type='" . $spellops[$opid]["value"] . "'\n";
			}
			$attrs .= "AND EXISTS (
						SELECT NULL
						FROM item_spell isl
						WHERE isl.itemid=i.itemid
						AND   isl.spellid=$id
						$opattr
					)";
		}	

		/* Off we go */
		$res = $GLOBALS["DB"]->query("
			SELECT	i.itemid,i.name,i.req_level,i.req_str,i.req_dex,i.version,
				it.name AS itemtype,i.itemsetid,i.itemtypeid,
				it.itemcatid,it.tc
			FROM	item i,itemtype it,itemcategory ic
			WHERE	i.itemtypeid=it.itemtypeid
			AND	it.itemcatid=ic.itemcatid
			$attrs
			ORDER BY i.req_level ASC
		");
		if (PEAR::isError($res)) { die($res->getMessage()); }

		while ($a = $res->fetchRow()) {
			$item[$a["itemid"]] = $a;
			$item[$a["itemid"]]["image"] = "images/items/uniqueset/" . preg_replace("/[^a-z]/", "", strtolower($a["name"])) . ".gif";

			getItemDetails ($item, $a["itemid"], $a["itemtypeid"]);
		}
		$GLOBALS["smarty"]->assign("items", $item);
		$GLOBALS["smarty"]->assign("numitems", count ($item));
	}
	$GLOBALS["smarty"]->assign("itemcats", $itemcats);
	$GLOBALS["smarty"]->assign("itemprops", $itemprops);
	$GLOBALS["smarty"]->assign("spells", $spells);
	$GLOBALS["smarty"]->assign("modops", $modops);
	$GLOBALS["smarty"]->assign("spellops", $spellops);
	$GLOBALS["smarty"]->assign("in", $in);
	$GLOBALS["smarty"]->assign("title", "Search");
	$GLOBALS["smarty"]->display("search.tpl");
 ?>
