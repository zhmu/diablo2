<?php
	require "lib.php";

	$res = $GLOBALS["DB"]->query("SELECT charid,name,class,level,version FROM charachter ORDER BY name ASC");
	if (PEAR::isError($res)) { die($res->getMessage()); }

	$chars = array();
	while ($a = $res->fetchRow()) {
		$a["fullclass"] = $GLOBALS["CLASSMAP"][$a["class"]];
		$chars[] = $a;
	}

	$GLOBALS["smarty"]->assign("chars", $chars);
	$GLOBALS["smarty"]->assign("title", "Charachters");
	$GLOBALS["smarty"]->display("chars.tpl");
 ?>
