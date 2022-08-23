<?php
    //
    // unique_cat.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // fix up the id supplied
    $id = trim (preg_replace ("/\D/", "", $_REQUEST["id"]));

    // fetch the name
    $query = sprintf ("SELECT name FROM classes WHERE id='%s'", $id);
    $res = db_query ($query); list ($name) = db_fetch_result ($res);

    // did we have such an item?
    if (db_num_rows ($res) == 0) {
	// no. complain
	ShowHeader ("No such item class");
	echo "Sorry, but this item class does not seem to exist";
	ShowFooter();
	exit;
    }

    // build the page
    ShowHeader ("Unique Item Category - " . $name);

 ?><center><b>Unique Items - <?php echo $name; ?></b></center><p>
<table width="100%" cellpadding="5" cellspacing="1" bgcolor="#161616" class="defaultab">
<?php
    // fetch the items
    $query = sprintf ("SELECT i.id,i.name,i.type,i.speed,i.ohdamage_min,i.ohdamage_max,i.thdamage_min,i.thdamage_max,i.defense,i.max_durability,i.req_level,i.req_strength,i.req_dex,i.description,t.name FROM unique_items i,types t WHERE t.class_id='%s' AND i.type=t.id ORDER BY i.req_level", $id);
    $res = db_query ($query);

    // list them all
    while (list ($id, $name, $type, $speed, $ohdamage_min, $ohdamage_max, $thdamage_min, $thdamage_max, $defense, $max_dur, $req_lev, $req_str, $req_dex, $desc, $type_name) = db_fetch_result ($res)) {
	// does anyone own this item?
	$query = sprintf ("SELECT COUNT(id) FROM item_owner WHERE item_id='%s' AND item_type='%s'", $id, ITEMTYPE_UNIQUE);
	list ($got_item) = db_fetch_result (db_query ($query));
	$class = ($got_item > 0) ? "uniqitem_owner" : "uniqitem_notowner";

	// build the table row
	printf ("<tr bgcolor=\"#000000\"><td width=\"20%%\" align=\"center\"><a class=\"%s\" name=\"item%s\" href=\"owner.php?id=%s&amp;type=%s\"><img src=\"images/uniq_%s.gif\" alt=\"[%s]\" border=0><br><b>%s</b></a><br>%s<p></td><td width=\"80%%\">", $class, $id, $id, ITEMTYPE_UNIQUE, $id, $name, $name, $type_name);

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
<center><a href="javascript:history.go(-1);">Return to previous page</a></center>
<?php
    ShowFooter();
 ?>
