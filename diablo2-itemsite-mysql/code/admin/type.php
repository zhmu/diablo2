<?php
    //
    // unique.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "cplib.php";

    // TYPES_PER_PAGE are the number of types we will show on a single page
    define (TYPES_PER_PAGE, 40);

    //
    // Overview()
    //
    // This will show a list of all types.
    //
    function
    Overview() {
	$page = $_REQUEST["page"];

	// grab the number of items
	$query = sprintf ("SELECT COUNT(id) FROM types");
	list ($noftypes) = db_fetch_result (db_query ($query));

	// calculate the number of pages
	$nofpages = ceil ($noftypes / TYPES_PER_PAGE);

	// is a page given?
	$page = trim (preg_replace ("/\D/", "", $page));
	if ($page == "") {
	    // no. default to page #1
	    $page = 1;
	}

	// build the page
	cpShowHeader("Item Types", "Overview");

	// fetch the items
	$query = sprintf ("SELECT id,name,class_id FROM types ORDER BY name ASC LIMIT %s,%s", ($page - 1) * TYPES_PER_PAGE, TYPES_PER_PAGE);
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
	while (list ($id, $name, $classid) = db_fetch_result ($res)) {
	    // grab the type
	    $query = sprintf ("SELECT name FROM classes WHERE id='%s'", $classid);
	    list ($class) = db_fetch_result (db_query ($query));

	    // there we go!
	    printf ("<tr class=\"overrow\"><td>&nbsp;<a href=\"" . $_SERVER["PHP_SELF"] . "?action=edit&id=%s\">%s</a> (%s)</td></tr>", $id, $name, $class);
	}
 ?>
</table><p>
<center>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="add">
<input type="submit" value="Add Type">
</form>
</center>
<?php
	cpShowFooter();
    }

    //
    // ListClasses ($id)
    //
    // This will build a list of all item classses, in which class $id is
    // selected.
    //
    function
    ListClasses ($id) {
	// grab all classes
	$query = sprintf ("SELECT id,name FROM classes");
	$res = db_query ($query);

	// list them all
	echo "<select name=\"class\">";
	while (list ($classid, $name) = db_fetch_result ($res)) {
	    // display it
	    printf ("<option value=\"%s\"%s>%s</option>", $classid, ($classid == $id) ? " selected" : "", $name);
	}
	echo "</select>";
    }

    //
    // Edit()
    //
    // This will show the page for editing type $id.
    //
    function
    Edit() {
	$id = $_REQUEST["id"];

	// fetch the type information
	$query = sprintf ("SELECT name,class_id FROM types WHERE id='%s'", $id);
	list ($name, $classid) = db_fetch_result (db_query ($query));

	// display the info
	cpShowHeader("Item Types", "Edit type " . $name);
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doedit">
<input type="hidden" name="id" value="<?php echo $id; ?>">
<table width="100%" class="content_tab">
 <tr class="content_row">
  <td width="20%">&nbsp;Item ID</td>
  <td width="80%">&nbsp;<b><?php echo $id; ?></b></td>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Type Name</td>
  <td>&nbsp;<input type="text" name="name" value="<?php echo htmlspecialchars ($name); ?>"></td>
 </tr>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Type Class</td>
  <td>&nbsp;<?php ListClasses ($classid); ?></td>
 </tr>
</table><p>
<table width="100%">
 <tr valign="top">
  <td width="50%" align="center"><input type="submit" value="Submit Modifications"></form></td>
  <td width="50%" align="center"><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post"><input type="submit" value="Cancel Modifications"></form></td>
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
	$class = $_REQUEST["class"];

	// build the query
	$query = sprintf ("UPDATE types SET name='%s',class_id='%s' WHERE id='%s'", $name, $class, $id);
	db_query ($query);

	cpShowHeader("Item Types", "Edit Type");
 ?>Thank you, the item has successfully been updated.<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to the type overview"></center>
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
	cpShowHeader("Item Types", "Add Type");
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doadd">
<table width="100%" class="content_tab">
 <tr class="content_row">
  <td width="20%">&nbsp;Item Name</td>
  <td width="80%">&nbsp;<input type="text" name="name"></td>
 </tr>
 </tr>
 <tr class="content_row">
  <td>&nbsp;Item Class</td>
  <td>&nbsp;<?php ListClasses (0); ?></td>
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
	$class = $_REQUEST["class"];

	// build the query
	$query = sprintf ("INSERT INTO types VALUES (NULL,'%s','%s')", $name, $class);
	db_query ($query);

	// inform the user
	cpShowHeader("Item Types", "Add Item");
 ?>Thank you, the type has successfully been added.<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to the type overview"></center>
</form>
<?php
	cpShowFooter();
    }

    // is an action given?
    $action = $_REQUEST["action"];
    if ($action == "") {
	// nope. show the overview of item types
	Overview();
    } elseif ($action == "edit") {
	// actually edit a type
	Edit();
    } elseif ($action == "doedit") {
	// submit the modifications
	DoEdit();
    } elseif ($action == "add") {
	// add an type
	Add();
    } elseif ($action == "doadd") {
	// actually add the type
	DoAdd();
    }
 ?>
