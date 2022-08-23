<?php
    //
    // set.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // fetch the set name
    $id = $_REQUEST["id"];
    $query = sprintf ("SELECT name FROM sets WHERE id='%s'", $id);
    $res = db_query ($query); list ($name) = db_fetch_result ($res);
    if (db_num_rows ($res) == 0) {
	// there's no such set. complain
	ShowHeader("No such set");
	echo "Sorry, but that set does not seem to exist.";
	ShowFooter();
	exit;
    }
 
    // build the page 
    ShowHeader("Set - " . $name);
 ?><center><b><?php echo $name; ?></b></center><p>
<table width="100%" cellpadding="5" cellspacing="1" bgcolor="#161616" class="defaultab">
<?php

    // fetch all set items
    $query = sprintf ("SELECT id,name,type,speed,ohdamage_min,ohdamage_max,thdamage_min,thdamage_max,defense,max_durability,req_level,req_strength,req_dex,description FROM set_items WHERE set_id=%s", $id);
    $res = db_query ($query);

    // list them all
    while (list ($id, $name, $type, $speed, $ohdamage_min, $ohdamage_max, $thdamage_min, $thdamage_max, $defense, $max_dur, $req_lev, $req_str, $req_dex, $desc) = db_fetch_result ($res)) {
	// check whether we have the item and generate the class
	$query = sprintf ("SELECT COUNT(id) FROM item_owner WHERE item_id='%s' AND item_type='%s'", $id, ITEMTYPE_SET);
	list ($got_item) = db_fetch_result (db_query ($query));
	$class = ($got_item > 0) ? "setitem_owner" : "setitem_notowner";

	// fetch the type
	$query = sprintf ("SELECT name FROM types WHERE id='%s'", $type);
	list ($type_name) = db_fetch_result (db_query ($query));

	// build the table row
	printf ("<tr bgcolor=\"#000000\"><td width=\"20%%\" align=\"center\"><a class=\"%s\" name=\"item%s\" href=\"owner.php?id=%s&amp;type=%s\"><img src=\"images/set_%s.gif\" alt=\"[%s]\" border=0><br><b>%s</b></a><br>%s<p></td><td width=\"80%%\">", $class, $id, $id, ITEMTYPE_SET, $id, $name, $name, $type_name);

	// now, show all information
	if (($ohdamage_min > 0) && ($ohdamage_max > 0)) { printf ("One-Hand Damage: <b>%s</b> to <b>%s</b><br>", $ohdamage_min, $ohdamage_max); }
	if (($thdamage_min > 0) && ($thdamage_max > 0)) { printf ("Two-Hand Damage: <b>%s</b> to <b>%s</b><br>", $thdamage_min, $thdamage_max); }
	if ($defense > 0) { printf ("Defense: <b>%s</b><br>", $defense); }
	if ($req_lev > 0) { printf ("Required Level: <b>%s</b><br>", $req_lev); }
	if ($req_str > 0) { printf ("Required Strength: <b>%s</b><br>", $req_str); }
	if ($req_dex > 0) { printf ("Required Dexterity: <b>%s</b><br>", $req_dex); }
	if ($max_dur > 0) { printf ("Maximum Durability: <b>%s</b><br>", $max_dur); }
	printf ("<font color=\"#4850B8\">%s</font>", nl2br ($desc));

	echo "<p></td></tr>";
    }

    // show the footer
 ?></table><p>
<center><a href="sets.php">Return to set overview</a></center>
<?php

    ShowFooter();
 ?>
