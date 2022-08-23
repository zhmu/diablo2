<?php
    //
    // char.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // get the supplied variables
    $id = trim (preg_replace ("/\D/", "", $_REQUEST["id"]));

    // fetch the character information
    $query = sprintf ("SELECT name,type,experience FROM characters WHERE id='%s'", $id);
    $res = db_query ($query);
    list ($name, $type, $exp) = db_fetch_result ($res);

    // did this yield any results?
    if (db_num_rows ($res) == 0) {
	// no. complain
	ShowHeader("No such character");
	echo "Sorry, but this character does not seem to exist";
	ShowFooter();
	exit;
    }

    // fetch the character type
    $query = sprintf ("SELECT name FROM char_types WHERE id=%s", $type);
    list ($type_name) = db_fetch_result (db_query ($query));

    // figure out the level
    $query = sprintf ("SELECT id FROM levels WHERE exp_req<=%s ORDER BY exp_req DESC LIMIT 1", $exp, $exp);
    list ($level) = db_fetch_result (db_query ($query));

    // show the page
    ShowHeader ("Information on character " . $name);
 ?><center>Information about <b><?php echo $name; ?></b><p>
<table width="80%" cellpadding="5" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr>
  <td width="20%" align="center">[image]<p><b><?php echo $name; ?></b><br><?php echo $type_name; ?><p>Level <?php echo $level; ?></td>
  <td width="80%">Items owned:<p>
<?php
    // figure out all items owned by this character
    $query = sprintf ("SELECT item_id,item_type FROM item_owner WHERE owner_id=%s", $id);	
    $res = db_query ($query);

    // does this character own any items?
    if (db_num_rows ($res) > 0) {
	// yes. show them
	echo "<ul>";
	while (list ($item_id, $item_type) = db_fetch_result ($res)) {
	    // figure out which table to use
	    switch ($item_type) {
		case ITEMTYPE_UNIQUE: // unique item. fetch the name and type
				      $query = sprintf ("SELECT i.name,t.name FROM unique_items i, types t WHERE i.id=%s AND t.id=i.type", $item_id);
				      list ($name, $type) = db_fetch_result (db_query ($query));
				      $link = "unique.php?id=$item_id";
				      break;
		   case ITEMTYPE_SET: // set item. fetch the name and type
				      $query = sprintf ("SELECT i.name,t.name,i.set_id FROM set_items i, types t WHERE i.id=%s AND t.id=i.type", $item_id);
				      list ($name, $type, $setid) = db_fetch_result (db_query ($query));
				      $link = "set.php?id=$setid#item$item_id";
				      break;
	    }

	    //
	    printf ("<li><a href=\"%s\">%s</a> (%s)</li>", $link, $name, $type);
	}
	echo "</ul>";
    } else {
	// no. inform the viewer
	echo "This charachter does not own any items";
    }
 ?>
 </tr>
</table><p>
<center><a href="javascript:history.go(-1);">Return to previous page</a></center>
<?php
    ShowFooter();
 ?>
