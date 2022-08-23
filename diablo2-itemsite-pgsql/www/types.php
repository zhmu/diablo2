<?php
	require "lib.php";

	$res = $GLOBALS["DB"]->query("SELECT itemcatid,name FROM itemcategory ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }

	$cats = array();
	while ($a = $res->fetchRow()) {
		$types[] = $a;
	}

	$GLOBALS["smarty"]->assign("types", $types);
	$GLOBALS["smarty"]->assign("title", "Types");
	$GLOBALS["smarty"]->display("types.tpl");
 ?>
