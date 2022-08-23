<?php
    //
    // index.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // build the page
    ShowHeader("");

    // grab the statistics
    $query = sprintf ("SELECT COUNT(id) FROM accounts");
    list ($nof_accounts) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM characters");
    list ($nof_chars) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM set_items");
    list ($nof_setitems) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM unique_items");
    list ($nof_uniqueitems) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM item_owner");
    list ($nof_owned_items) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM set_items");
    list ($nof_set_items) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM item_owner WHERE (item_type&%s)", ITEMTYPE_SET);
    list ($nof_owned_set_items) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM unique_items");
    list ($nof_unique_items) = db_fetch_result (db_query ($query));
    $query = sprintf ("SELECT COUNT(id) FROM item_owner WHERE (item_type&%s)", ITEMTYPE_UNIQUE);
    list ($nof_owned_unique_items) = db_fetch_result (db_query ($query));

    // count the number of items per set
    $query = sprintf ("SELECT id FROM sets");
    $res = db_query ($query); $nof_sets = db_num_rows ($res);

    // figure out how much sets we completed
    while (list ($setid) = db_fetch_result ($res)) {
	// count the total number of items
	$query = sprintf ("SELECT COUNT(id) FROM set_items WHERE set_id='%s'", $setid);
	list ($num_items) = db_fetch_result (db_query ($query));

	// count the number of collected items
	$query = sprintf ("SELECT COUNT(i.id) FROM item_owner i,set_items s WHERE i.item_id=s.id AND s.set_id='%s' AND i.item_type&%s", $setid, ITEMTYPE_SET);
	list ($col_items) = db_fetch_result (db_query ($query));

	// if the numbers match, we completed a set
	if ($num_items == $col_items) { $nof_completed_sets++; };
    }

    // calculate the total items, and the collected ones
    $total_items = $nof_unique_items + $nof_set_items;
    $owned_items = $nof_owned_unique_items + $nof_owned_set_items;
 ?>Welcome!<p>

Current site statistics:<p>

<table width="100%" class="defaultab">
 <tr>
  <td width="30%">Total number of accounts</td>
  <td width="70%"><?php echo $nof_accounts; ?></td>
 </tr>
 <tr>
  <td>Total number of characters</td>
  <td><?php echo $nof_chars; ?></td>
 </tr>
 <tr>
  <td colspan=2>&nbsp;</td>
 </tr>
 <tr>
  <td>Collected / Total Set Items</td>
  <td><?php echo $nof_owned_set_items . " / " . $nof_set_items . " (" . ($nof_owned_set_items / $nof_set_items) * 100 . "%)"; ?></td>
 </tr>
 <tr>
  <td>Completed / Total Sets</td>
  <td><?php echo $nof_completed_sets . " / " . $nof_sets . " (" . ($nof_completed_sets / $nof_sets) * 100 . "%)"; ?></td>
 </tr>
 <tr>
  <td colspan=2>&nbsp;</td>
 </tr>
 <tr>
  <td>Collected / Total Unique Items</td>
  <td><?php echo $nof_owned_unique_items . " / " . $nof_unique_items . " (" . ($nof_owned_unique_items / $nof_unique_items) * 100 . "%)"; ?></td>
 </tr>
 <tr>
  <td>Collected / Total Items</td>
  <td><?php echo $nof_owned_items . " / " . $total_items . " (" . ($nof_owned_items / $total_items) * 100 . "%)"; ?></td>
 </tr>
</table><p>
<?php
    ShowFooter();
 ?>
