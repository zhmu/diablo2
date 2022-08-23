<?php
    //
    // sets.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    ShowHeader("Set Items");

    // fetch the set item total
    $query = sprintf ("SELECT COUNT(id) FROM set_items");
    list ($totalitems) = db_fetch_result (db_query ($query));

    // fetch the set items
    $query = sprintf ("SELECT id,name FROM sets ORDER BY name");
    $res = db_query ($query);
    $nofsets = db_num_rows ($res);

 ?>Diablo 2: Lord of Destruction features <?php echo $nofsets; ?> sets, resulting in a total of <?php echo $totalitems; ?> items. Below is a list of all currently known sets. Sets in <font color="#00FF00"><b>green</b></font> are fully completed, which means I have all set items. Sets in <font color="#C0C0C0"><b>gray</b></font> are incomplete, but I have some items for them. Finally, sets in <font color="#FF0000"><b>red</b></font> indicate I have nothing of that set.<p>

<center><table width="80%" class="defaultab">
<?php
    // show the set
    $row = 0; $col = 0;
    while (list ($id, $name) = db_fetch_result ($res)) {
	// new row?
	if ($row == 0) {
	    // yes. do it
	    echo "<tr>";
	    $row = 1;
	}

	// count the number of items in the set
	$query = sprintf ("SELECT COUNT(id) FROM set_items WHERE set_id='%s'", $id);
	list ($set_nofitems) = db_fetch_result (db_query ($query));

	// count the number of items we have
	$query = sprintf ("SELECT COUNT(i.id) FROM item_owner i, set_items s WHERE i.item_type=%s AND i.item_id=s.id AND s.set_id=%s", ITEMTYPE_SET, $id);
	list ($set_ouritems) = db_fetch_result (db_query ($query));

	// do we have all items?
	if ($set_nofitems == $set_ouritems) {
	    // yes. we have the entire set
	    $class = "set_allitems";
	} else if ($set_ouritems == 0) {
	    // we have no items
	    $class = "set_noitems";
	} else {
	    // we have some items
	    $class = "set_items";
	}

	// list the item	
	printf ("<td width=\"50%%\" align=\"center\"><a class=\"%s\" href=\"set.php?id=%s\">%s</a></td>", $class, $id, $name);

	// next column
	$col++;

	// need to go to the next row?
	if ($col == 2) {
	    // yes. do it
	    echo "</tr>";
	    $col = 0; $row = 0;
	}
    }
    echo "</table></center>";

    ShowFooter();
 ?>
