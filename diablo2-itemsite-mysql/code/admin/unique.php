<?php
    //
    // unique.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "cplib.php";

    // ITEMS_PER_PAGE are the number of items we will show on a single page
    define (ITEMS_PER_PAGE, 30);

    //
    // Overview()
    //
    // This will show a list of all unique items.
    //
    function
    Overview() {
	$page = $_REQUEST["page"];

	// grab the number of items
	$query = sprintf ("SELECT COUNT(id) FROM unique_items");
	list ($nofitems) = db_fetch_result (db_query ($query));

	// calculate the number of items
	$nofpages = ceil ($nofitems / ITEMS_PER_PAGE);

	// is a page given?
	$page = trim (preg_replace ("/\D/", "", $page));
	if ($page == "") {
	    // no. default to page #1
	    $page = 1;
	}

	// build the page
	cpShowHeader("Unique Items", "Overview");

	// fetch the items
	$query = sprintf ("SELECT id,name,type FROM unique_items ORDER BY name ASC LIMIT %s,%s", ($page - 1) * ITEMS_PER_PAGE, ITEMS_PER_PAGE);
	$res = db_query ($query);

	// display the overview
 ?><table width="100%" class="overtab" cellpadding=1 cellspacing=1>
 <tr>
  <td>&nbsp;Pages: <?php
	// list all pages
	for ($i = 1; $i <= $nofpages; $i++) {
	    // current page?
	    if ($page == $i) {
		// yes. don't hyperlink it
		printf ("[<b>%s</b>] ", $i);
	    } else {
		// no. hyperlink it
		printf ("[<a class=\"overlink\" href=\"" . $_SERVER["PHP_SELF"] . "?page=%s\">%s</a>] ", $i, $i);
	    }
	}
 ?></td></tr>
<?php
	// list all items
	while (list ($id, $name, $typeid) = db_fetch_result ($res)) {
	    // grab the type
	    $query = sprintf ("SELECT name FROM types WHERE id='%s'", $typeid);
	    list ($type) = db_fetch_result (db_query ($query));

	    // there we go!
	    printf ("<tr class=\"overrow\"><td>&nbsp;<a href=\"" . $_SERVER["PHP_SELF"] . "?action=edit&id=%s\">%s</a> (%s)</td></tr>", $id, $name, $type);
	}
 ?>
</table><p>
<center>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="add">
<input type="submit" value="Add Item">
</form>
</center>
<?php
	cpShowFooter();
    }

    //
    // ListTypes ($id)
    //
    // This will build a list of all item types, in which type $id is selected.
    //
    function
    ListTypes ($id) {
	// grab all types
	$query = sprintf ("SELECT id,name FROM types ORDER BY name ASC");
	$res = db_query ($query);

	// list them all
	echo "<select name=\"type\">";
	while (list ($typeid, $name) = db_fetch_result ($res)) {
	    // display it
	    printf ("<option value=\"%s\"%s>%s</option>", $typeid, ($typeid == $id) ? " selected" : "", $name);
	}
	echo "</select>";
    }

    //
    // ListSpeeds ($id)
    //
    // This will build a list of all item speeds which speed $id is selected.
    //
    function
    ListSpeeds ($id) {
	// grab all speeds
	$query = sprintf ("SELECT id,name FROM speeds");
	$res = db_query ($query);

	// list them all
	echo "<select name=\"speed\">";
	while (list ($speedid, $name) = db_fetch_result ($res)) {
	    // display it
	    printf ("<option value=\"%s\"%s>%s</option>", $speedid, ($speedid == $id) ? " selected" : "", $name);
	}
	printf ("<option value=\"0\"%s>N/A</option>", ($id == 0) ? " selected" : "");
	echo "</select>";
    }

    //
    // Edit()
    //
    // This will show the page for editing item $id.
    //
    function
    Edit() {
	$id = $_REQUEST["id"];

	// fetch the item information
	$query = sprintf ("SELECT name,type,speed,ohdamage_min,ohdamage_max,thdamage_min,thdamage_max,defense,max_durability,req_level,req_strength,req_dex,description FROM unique_items WHERE id='%s'", $id);
	list ($name, $typeid, $speedid, $ohdamage_min, $ohdamage_max, $thdamage_min, $thdamage_max, $defense, $max_durability, $req_level, $req_strength, $req_dex, $desc) = db_fetch_result (db_query ($query));

	// display the info
	cpShowHeader("Unique Items", "Edit item " . $name);
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doedit">
<input type="hidden" name="id" value="<?php echo $id; ?>">
<table width="100%" class="content_tab">
 <tr class="content_row">
  <td width="20%">&nbsp;Item ID</td>
  <td width="80%">&nbsp;<b><?php echo $id; ?></b></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Name</td>
  <td>&nbsp;<input type="text" name="name" value="<?php echo htmlspecialchars ($name); ?>"></td>
 </tr>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Type</td>
  <td>&nbsp;<?php ListTypes ($typeid); ?></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Speed</td>
  <td>&nbsp;<?php ListSpeeds ($speedid); ?></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;One-Hand Damage</td>
  <td>&nbsp;<input type="text" name="ohdamage_min" value="<?php echo htmlspecialchars ($ohdamage_min); ?>"> to <input type="text" name="ohdamage_max" value="<?php echo htmlspecialchars ($ohdamage_max); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Two-Hand Damage</td>
  <td>&nbsp;<input type="text" name="thdamage_min" value="<?php echo htmlspecialchars ($thdamage_min); ?>"> to <input type="text" name="thdamage_max" value="<?php echo htmlspecialchars ($thdamage_max); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Defense</td>
  <td>&nbsp;<input type="text" name="defense" value="<?php echo htmlspecialchars ($defense); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Maximum Durability</td>
  <td>&nbsp;<input type="text" name="max_durability" value="<?php echo htmlspecialchars ($max_durability); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Level</td>
  <td>&nbsp;<input type="text" name="req_level" value="<?php echo htmlspecialchars ($req_level); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Strength</td>
  <td>&nbsp;<input type="text" name="req_strength" value="<?php echo htmlspecialchars ($req_strength); ?>"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Dexterity</td>
  <td>&nbsp;<input type="text" name="req_dexterity" value="<?php echo htmlspecialchars ($req_dex); ?>"></td>
 </tr>
 <tr class="content_row" valign="top">
  <td>&nbsp;Description</td>
  <td>&nbsp;<textarea name="description" rows=10 cols=50><?php echo htmlspecialchars ($desc); ?></textarea></td>
 </tr>
</table><p>
<table width="100%">
 <tr valign="top">
  <td width="50%" align="center"><input type="submit" value="Submit Modifications"></form></td>
  <td width="50%" align="center"><form action="<?php echo $PHP_SELF; ?>" method="post"><input type="submit" value="Cancel Modifications"></form></td>
 </tr>
</table>
<?php
	cpShowFooter();
    }

    //
    // DoEdit()
    //
    // This will actually submit the modifications.
    //
    function
    DoEdit() {
	$id = $_REQUEST["id"];
	$name = $_REQUEST["name"];
	$type = $_REQUEST["type"];
	$speed = $_REQUEST["speed"];
	$ohdamage_min = $_REQUEST["ohdamage_min"];
	$ohdamage_max = $_REQUEST["ohdamage_max"];
	$thdamage_min = $_REQUEST["thdamage_min"];
	$thdamage_max = $_REQUEST["thdamage_max"];
	$defense = $_REQUEST["defense"];
	$max_durability = $_REQUEST["max_durability"];
	$req_level = $_REQUEST["req_level"];
	$req_strength = $_REQUEST["req_strength"];
	$req_dexterity = $_REQUEST["req_dexterity"];
	$description = $_REQUEST["description"];

	// fix up the fields
	$description = preg_replace ("/\r/", "", $description);

	// build the query
	$query = sprintf ("UPDATE unique_items SET name='%s',type='%s',speed='%s',ohdamage_min='%s',ohdamage_max='%s',thdamage_min='%s',thdamage_max='%s',defense='%s',max_durability='%s',req_level='%s',req_strength='%s',req_dex='%s',description='%s' WHERE id='%s'", $name, $type, $speed, $ohdamage_min, $ohdamage_max, $thdamage_min, $thdamage_max, $defense, $max_durability, $req_level, $req_strength, $req_dexterity, $description, $id);
	db_query ($query);

	cpShowHeader("Unique Items", "Edit Item");
 ?>Thank you, the item has successfully been edited.<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to the item overview"></center>
</form>
<?php
	cpShowFooter();
    }

    //
    // Add()
    //
    // This will show the page for adding an item.
    //
    function
    Add() {
	// display the info
	cpShowHeader("Unique Items", "Add Item");
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doadd">
<table width="100%" class="content_tab">
 <tr class="content_row">
  <td width="20%">&nbsp;Item Name</td>
  <td width="80%">&nbsp;<input type="text" name="name"></td>
 </tr>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Type</td>
  <td>&nbsp;<?php ListTypes (0); ?></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Speed</td>
  <td>&nbsp;<?php ListSpeeds (0); ?></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;One-Hand Damage</td>
  <td>&nbsp;<input type="text" name="ohdamage_min" value="0"> to <input type="text" name="ohdamage_max" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Two-Hand Damage</td>
  <td>&nbsp;<input type="text" name="thdamage_min" value="0"> to <input type="text" name="thdamage_max" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Defense</td>
  <td>&nbsp;<input type="text" name="defense" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Maximum Durability</td>
  <td>&nbsp;<input type="text" name="max_durability" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Level</td>
  <td>&nbsp;<input type="text" name="req_level" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Strength</td>
  <td>&nbsp;<input type="text" name="req_strength" value="0"></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Required Dexterity</td>
  <td>&nbsp;<input type="text" name="req_dexterity" value="0"></td>
 </tr>
 <tr class="content_row" valign="top">
  <td>&nbsp;Description</td>
  <td>&nbsp;<textarea name="description" rows=10 cols=50></textarea></td>
 </tr>
</table><p>
<table width="100%">
 <tr valign="top">
  <td width="50%" align="center"><input type="submit" value="Add Item"></form></td>
  <td width="50%" align="center"><form action="<?php echo $PHP_SELF; ?>" method="post"><input type="submit" value="Cancel Modifications"></form></td>
 </tr>
</table>
<?php
	cpShowFooter();
    }

    //
    // DoAdd()
    //
    // This will actually add the new item.
    //
    function
    DoAdd() {
	$name = $_REQUEST["name"];
	$type = $_REQUEST["type"];
	$speed = $_REQUEST["speed"];
	$ohdamage_min = $_REQUEST["ohdamage_min"];
	$ohdamage_max = $_REQUEST["ohdamage_max"];
	$thdamage_min = $_REQUEST["thdamage_min"];
	$thdamage_max = $_REQUEST["thdamage_max"];
	$defense = $_REQUEST["defense"];
	$max_durability = $_REQUEST["max_durability"];
	$req_level = $_REQUEST["req_level"];
	$req_strength = $_REQUEST["req_strength"];
	$req_dexterity = $_REQUEST["req_dexterity"];
	$description = $_REQUEST["description"];

	// fix up the fields
	$description = preg_replace ("/\r/", "", $description);
	$description = preg_replace ("/\n/", "\\n", $description);

	// build the query
	$query = sprintf ("INSERT INTO unique_items VALUES (NULL,'%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')", $name, $type, $speed, $ohdamage_min, $ohdamage_max, $thdamage_min, $thdamage_max, $defense, $max_durability, $req_level, $req_strength, $req_dexterity, $description);
	db_query ($query);

	// inform the user
	cpShowHeader("Unique Items", "Add Item");
 ?>Thank you, the item has successfully been added. The new item's ID is <b><?php echo db_fetch_insert_id(); ?></b>.<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to the item overview"></center>
</form>
<?php
	cpShowFooter();
    }

    // is an action given?
    $action = $_REQUEST["action"];
    if ($action == "") {
	// nope. show the overview of unique items
	Overview();
    } elseif ($action == "edit") {
	// actually edit an item
	Edit();
    } elseif ($action == "doedit") {
	// submit the modifications
	DoEdit();
    } elseif ($action == "add") {
	// add an item
	Add();
    } elseif ($action == "doadd") {
	// actually add the item
	DoAdd();
    }
 ?>
