<?php
    //
    // you.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    //
    // ResolveLevel ($exp)
    //
    // This will return the level of a charachter which has experience $exp.
    //
    function
    ResolveLevel ($exp) {
	global $LEVEL;

	// scan the level
	reset ($LEVEL);
	while (list ($no, $x) = each ($LEVEL)) {
	    // dissect the required exp and next exp
	    list ($req, $next) = explode (":", $x);

	    // match?
	    if (($exp >= $req) and ($exp <= ($req + $next))) {
		// yes. return the number
		return $no;
	    }
	}

	// I wonder which level this is... let's give it the max
	return 99;
    }

    //
    // Overview()
    //
    // This will show an overview of all characters the user has.
    //
    function
    Overview() {
	global $TYPE;

	// fetch the accounts
	$query = sprintf ("SELECT id,name,type,experience FROM characters WHERE owner_id='%s' ORDER BY name ASC", $GLOBALS["account_id"]);
	$res = db_query ($query); $numchars = db_num_rows ($res);

	// build the page
	ShowHeader ("Your characters");
 ?>This section of the site will allow you to manage your Diablo2 characters, including all unique or set items posessed by them. You are expected to be honest here, so please don't lie.<p>
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td width="100%" align="center">Your current charachters are:</td>
 </tr>
<?php
	// do we have any characters?
	if ($numchars == 0) {
	    // nope. inform the user
	} else {
	    // yes. display them all
	    while (list ($id, $name, $typeid, $exp) = db_fetch_result ($res)) {
		// go
		printf ("<tr><td>&nbsp;<a href=\"%s?action=edit&charid=%s\">%s</a> (%s level %s)</td></tr>", $P_SERVER["HP_SELF"], $id, $name, $TYPE[$typeid], ResolveLevel ($exp));
	    }
	}
 ?></table><p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="add">
<center><input type="submit" value="Create Character"></center>
</form>
<?php
    }

    //
    // Edit()
    //
    // This will edit character $charid.
    //
    function
    Edit() {
	global $TYPE;
	$charid = $_REQUEST["charid"];

	// grab the charachter information
	$query = sprintf ("SELECT name,type,experience FROM characters WHERE id='%s' AND owner_id='%s'", $charid, $GLOBALS["account_id"]);
	$res = db_query ($query);
	list ($name, $type, $exp) = db_fetch_result ($res);

	// did this character actually exist?
	if (db_num_rows ($res) == 0) {
	    // nope. complain
	    ShowHeader("Edit character");
 ?>Sorry, but this character is not possessed by you! *hears character cry for freedom -- you cannot possess me!!*
<?php
	    ShowFooter();
	    exit;
	}

	// display the information
	ShowHeader ("Edit character - " . $name);
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doedit">
<input type="hidden" name="charid" value="<?php echo $charid; ?>">
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td colspan=2 align="center">Editing character <b><?php echo $name; ?></b></td>
 </tr>
 <tr>
  <td width="20%">&nbsp;Character Name</td>
  <td width="80%"><input type="text" name="charname" value="<?php echo htmlspecialchars ($name); ?>"></td>
 </tr>
 <tr>
  <td>&nbsp;Character Type</td>
  <td><select name="chartype"><?php
	// make a drop down box of all charachter types
	while (list ($typeid, $typename) = each ($TYPE)) {
	    // display it
	    printf ("<option value=\"%s\"%s>%s</option>", $typeid, ($typeid == $type) ? " selected" : "", $typename);
	}
 ?></select></td>
 </tr>
 <tr>
  <td>&nbsp;Character Experience</td>
  <td><input type="text" name="exp" value="<?php echo htmlspecialchars ($exp); ?>"></td>
 </tr>
 <tr>
  <td>&nbsp;</td>
 </tr>
 <tr>
  <td colspan=2 align="center"><input type="submit" value="Submit Changes"></form></td>
 </tr>
</table><p>
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td align="center"><b><?php echo $name; ?></b>'s Equipment</b></td>
 </tr>
<?php
	// fetch all equipment
	$query = sprintf ("SELECT id,item_id,item_type FROM item_owner WHERE owner_id='%s'", $charid);
	$res = db_query ($query); $num_items = db_num_rows ($res);
	while (list ($id, $item_id, $item_type) = db_fetch_result ($res)) {
	    // unique item?
	    if ($item_type & ITEMTYPE_UNIQUE) {
		// yes. set the appropriate vars
		$itype = "Unique item"; $itab = "unique_items";
	    } else {
		// no. set the appropriate vars
		$itype = "Set item"; $itab = "set_items";
	    }

	    // grab the item name
	    $query = sprintf ("SELECT name FROM %s WHERE id='%s'", $itab, $item_id);
	    list ($iname) = db_fetch_result (db_query ($query));

	    // display the item
	    printf ("<tr><td>%s (<a href=\"" . $_SERVER["PHP_SELF"] . "?action=removeitem&id=%s\">Remove Item</a>)</td></tr>", $itype . ": <b>" . $iname . "</b>", $id);
	}
 ?>
 <tr>
  <td align="center"><br><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post"><input type="hidden" name="action" value="additem"><input type="hidden" name="charid" value="<?php echo $charid; ?>"><input type="submit" value="Add Item"></form></td>
 </tr>
</table><p>
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td align="center"><br><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post"><input type="hidden" name="action" value="delete"><input type="hidden" name="charid" value="<?php echo $charid; ?>"><input type="submit" value="Delete Character (warning: don't click unless serious!)"></form></td>
 </tr>
</table>
<?php
	ShowFooter();
    }

    // 
    // RemoveItem()
    // 
    // This will get rid of item $itemid.
    //
    function
    RemoveItem() {
	$id = $_REQUEST["id"];

	// start on the layout
	ShowHeader ("Remove Item");

	// fetch the charachter id of the item record
	$query = sprintf ("SELECT owner_id FROM item_owner WHERE id='%s'", $id);
	list ($ownerid) = db_fetch_result (db_query ($query));

	// figure out who owns this character
	$query = sprintf ("SELECT owner_id FROM characters WHERE id='%s'", $ownerid);
	list ($accountid) = db_fetch_result (db_query ($query));

	// match?
	if ($GLOBALS["account_id"] != $accountid) {
	    // no. complain
	    printf ("Sorry, but this item does not belong to you... you know stealing is illegal, no?");
	    ShowFooter();
	    exit;
	}

	// bye bye
	$query = sprintf ("DELETE FROM item_owner WHERE id='%s'", $id);	
	db_query ($query);

	// it has been done
 ?>The item has successfully been dropped into the black void of discarded items... please wait a few days until we recycle it into those neat little paperclips.
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="edit">
<input type="hidden" name="charid" value="<?php echo $ownerid; ?>">
<input type="submit" value="Return to the character">
</form>
<?php
	ShowFooter();
    }

    //
    // AddItem()
    //
    // Add an item
    //
    function
    AddItem() {
	// be paranoid
	$charid = preg_replace ("/\D/", "", $_REQUEST["charid"]);

	// build the page
	ShowHeader ("Add Item");
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doadditem">
<input type="hidden" name="charid" value="<?php echo $charid; ?>">
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td colspan=2 align="center">Add Item</td>
 </tr>
 <tr>
  <td colspan=2>&nbsp;</td>
 </tr>
 <tr>
  <td width="50%" align="center"><input type="radio" name="itemtype" value="<?php echo ITEMTYPE_UNIQUE; ?>" checked>Unique Item</td>
  <td width="50%">&nbsp;<select name="uniqueitem"><?php
	// fetch all unique items
	$query = sprintf ("SELECT id,name FROM unique_items ORDER BY name ASC");
	$res = db_query ($query);

	// list them all
	while (list ($itemid, $itemname) = db_fetch_result ($res)) {
	    printf ("<option value=\"%s\">%s</option>", $itemid, $itemname);
	}
 ?></option></td>
 </tr>
 <tr>
  <td width="50%" align="center"><input type="radio" name="itemtype" value="<?php echo ITEMTYPE_SET; ?>">Set Item</td>
  <td width="50%">&nbsp;<select name="setitem"><?php
	// fetch all unique items
	$query = sprintf ("SELECT id,name FROM set_items ORDER BY name ASC");
	$res = db_query ($query);

	// list them all
	while (list ($itemid, $itemname) = db_fetch_result ($res)) {
	    printf ("<option value=\"%s\">%s</option>", $itemid, $itemname);
	}
 ?></option></td>
 </tr>
</table><p>
<center><input type="submit" value="Yes, I have this item! Add it to my virtual charachter too"!></center>
</form>
<?php
	ShowFooter();
    }

    //
    // DoAddItem()
    //
    // This will add the item to the character.
    //
    function
    DoAddItem() {
	$charid = $_REQUEST["charid"];
	$itemtype = $_REQUEST["itemtype"];
	$setitem = $_REQUEST["setitem"];
	$uniqueitem = $_REQUEST["uniqueitem"];

	// spit out the header
	ShowHeader ("Add Item");

	// do we even own this character?
	$query = sprintf ("SELECT owner_id FROM characters WHERE id='%s'", $charid);
	list ($ownerid) = db_fetch_result (db_query ($query));
	if ($ownerid != $GLOBALS["account_id"]) {
	    // nope. complain
	    echo "Hey, you don't own this charachter... and you are *not* Robin Hood (and even if you were, you'd get this message, so get over it)";
	    ShowFooter();
	    exit;
	}

	// unique item?	
	if ($itemtype == ITEMTYPE_UNIQUE) {
	    // yes. use the correct value
	    $type = $uniqueitem;
	} elseif ($itemtype == ITEMTYPE_SET) {
	    // no, but it's a set item. use the correct value
	    $type = $setitem;
	} else {
	    // what's this?
	    echo "Sorry, but this item is neither set nor unique... that means it's either some useless normal item, a magical item or some rare item, all of which we don't care much about anyway....";
	    ShowFooter();
	    exit;
	}

	// okay, it seems to be valid. add the stuff
	$query = sprintf ("INSERT INTO item_owner VALUES (NULL,'%s','%s','%s')", $charid, $type, $itemtype);
	db_query ($query);

	// inform the user
 ?>Thank you, we have successfully added the item to your virtual character. Thank you for your honesty!<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="edit">
<input type="hidden" name="charid" value="<?php echo $charid; ?>">
<input type="submit" value="Return to the character">
</form>
<?php
	ShowFooter();
    }

    //
    // DoEdit()
    //
    // This will actually edit character $charid.
    //
    function
    DoEdit() {
	global $TYPE;
	$charid = $_REQUEST["charid"];
	$charname = $_REQUEST["charname"];
	$chartype = $_REQUEST["chartype"];
	$exp = $_REQUEST["exp"];

	// show the header
	ShowHeader("Edit character");

	// did this character actually exist?
	$query = sprintf ("SELECT id FROM characters WHERE id='%s' AND owner_id='%s'", $charid, $GLOBALS["account_id"]);
	if (db_num_rows (db_query ($query)) == 0) {
	    // nope. complain
 ?>Sorry, but this character is not possessed by you! *hears character cry for freedom -- you cannot possess me!!*
<?php
	    ShowFooter();
	    exit;
	}

	// empty fields?
	$charname = strip_tags ($charname);
	$chartype = preg_replace ("/\D/", "", $chartype);
	$exp = preg_replace ("/\D/", "", $exp);
	if (($charname == "") or ($chartype == "") or ($exp == "")) {
	    // yes. complain
	    echo "Sorry, but all fields must be filled in (sensibly, mind you)";
	    ShowFooter();
	    exit;
	}

	// valid character type?
	if ($TYPE[$chartype] == "") {
	    // no. complain
	    echo "Sorry, but your character type is invalid... this shouldn't happen, but it did... who to blame? You!";
	    ShowFooter();
	    exit;
	}

	// update the character
	$query = sprintf ("UPDATE characters SET name='%s',type='%s',experience='%s' WHERE id='%s' AND owner_id='%s'", $charname, $chartype, $exp, $charid, $GLOBALS["account_id"]);
	db_query ($query);

	// all set
 ?>Thank you, your virtual character feels a lot more complete now.
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="edit">
<input type="hidden" name="charid" value="<?php echo $charid; ?>">
<input type="submit" value="Return to the character">
</form>
<?php
	ShowFooter();
    }

    //
    // Add()
    //
    // This will add a character.
    //
    function
    Add() {
	global $TYPE;

	// display the information
	ShowHeader ("Add character");
 ?><form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<input type="hidden" name="action" value="doadd">
<table width="100%" cellpadding="2" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td colspan=2 align="center">Adding new character</td>
 </tr>
 <tr>
  <td width="20%">&nbsp;Character Name</td>
  <td width="80%"><input type="text" name="charname"></td>
 </tr>
 <tr>
  <td>&nbsp;Character Type</td>
  <td><select name="chartype"><?php
	// make a drop down box of all charachter types
	while (list ($typeid, $typename) = each ($TYPE)) {
	    // display it
	    printf ("<option value=\"%s\">%s</option>", $typeid, $typename);
	}
 ?></select></td>
 </tr>
 <tr>
  <td>&nbsp;Character Experience</td>
  <td><input type="text" name="exp"></td>
 </tr>
 <tr>
  <td>&nbsp;</td>
 </tr>
 <tr>
  <td colspan=2 align="center"><input type="submit" value="Add Character"></form></td>
 </tr>
</table>
<?php
	ShowFooter();
    }

    //
    // DoAdd()
    //
    // This will actually add the character.
    //
    function
    DoAdd() {
	global $TYPE;
	$charname = $_REQUEST["charname"];
	$chartype = $_REQUEST["chartype"];
	$exp = $_REQUEST["exp"];

	// show the header
	ShowHeader ("Add character");

	// empty fields?
	$charname = strip_tags ($charname);
	$chartype = preg_replace ("/\D/", "", $chartype);
	$exp = preg_replace ("/\D/", "", $exp);
	if (($charname == "") or ($chartype == "") or ($exp == "")) {
	    // yes. complain
	    echo "Sorry, but all fields must be filled in (sensibly, mind you)";
	    ShowFooter();
	    exit;
	}

	// valid character type?
	if ($TYPE[$chartype] == "") {
	    // no. complain
	    echo "Sorry, but your character type is invalid... this shouldn't happen, but it did... who to blame? You!";
	    ShowFooter();
	    exit;
	}

	// off we go
	$query = sprintf ("INSERT INTO characters VALUES (NULL,'%s','%s','%s','%s',0)", $GLOBALS["account_id"], $charname, $chartype, $exp);
	db_query ($query);

	// all done
 ?>The character has successfully been created. Thank you for being so honest and not lying about your character!<p>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to your characters overview"></center>
</form>
<?php
	ShowFooter();
    }

    //
    // DeleteChar()
    //
    // This will delete character $charid.
    //
    function
    DeleteChar() {
	global $TYPE;
	$charid = preg_replace ("/\D/", "", $_REQUEST["charid"]);

	// show the header
	ShowHeader("Delete character");

	// did this character actually exist?
	$query = sprintf ("SELECT id FROM characters WHERE id='%s' AND owner_id='%s'", $charid, $GLOBALS["account_id"]);
	if (db_num_rows (db_query ($query)) == 0) {
	    // nope. complain
 ?>This charachter is not even yours, and you attempt to banish him into oblivion! We're sorry, but the positions as Prime Evils have been taken. Perhaps there will be some vacancies within the next 10.000 years. Until that time, feel free to spend your own time into oblivion. Don't forget to send a postcard while at it, though! Thank you, and have a nice day.
<?php
	    ShowFooter();
	    exit;
	}

	// kill all its items
	$query = sprintf ("DELETE FROM item_owner WHERE owner_id='%s'", $charid);
	db_query ($query);

	// send it the way of the dinosaur
	$query = sprintf ("DELETE FROM characters WHERE id='%s' AND owner_id='%s'", $charid, $GLOBALS["account_id"]);
	db_query ($query);

	// all set
 ?>The character is now successfully floating somewhere in oblivion, exact location unknown. Thank you for making his day.
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<center><input type="submit" value="Return to your characters overview"></center>
</form>
<?php
    }

    // are we logged in?
    if ($GLOBALS["logged_in"] != 1) {
	// no. redirect the user back
	Header ("Location: index.php");
	exit;
    }

    // grab all levels
    $query = sprintf ("SELECT id,exp_req,exp_next FROM levels");
    $res = db_query ($query);
    while (list ($levelno, $exp_req, $exp_next) = db_fetch_result ($res)) {
	// put them into the array
	$LEVEL[$levelno] = $exp_req . ":" . $exp_next;
    }

    // fetch all character types
    $query = sprintf ("SELECT id,name FROM char_types");
    $res = db_query ($query);
    while (list ($typeid, $name) = db_fetch_result ($res)) {
	$TYPE[$typeid] = $name;
    }

    // is an action given?
    $action = $_REQUEST["action"];
    if ($action == "") {
	// no. just show the overview
	Overview();
    } elseif ($action == "edit") {
	// edit the character
	Edit();
    } elseif ($action == "removeitem") {
	// get rid of an item
	RemoveItem();
    } elseif ($action == "additem") {
	// add an item
	AddItem();
    } elseif ($action == "doadditem") {
	// actually add an item
	DoAddItem();
    } elseif ($action == "doedit") {
	// actually edit the character
	DoEdit();
    } elseif ($action == "add") {
	// add a character
	Add();
    } elseif ($action == "doadd") {
	// actually add the character
	DoAdd();
    } elseif ($action == "delete") {
	// delete the character
	DeleteChar();
    }
 ?>
