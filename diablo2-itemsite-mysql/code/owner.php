<?php
    //
    // owner.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // get the supplied values
    $item_id = trim (preg_replace ("/\D/", "", $_REQUEST["id"]));
    $item_type = trim (preg_replace ("/\D/", "", $_REQUEST["type"]));

    // figure out the item table
    $tab = ($item_type == ITEMTYPE_UNIQUE) ? "unique_items" : "set_items";
    $prefix = ($item_type == ITEMTYPE_UNIQUE) ? "uniq" : "set";

    // figure out the item's name
    $query = sprintf ("SELECT name,type FROM %s WHERE id='%s'", $tab, $item_id);
    $res = db_query ($query);
    list ($name, $type) = db_fetch_result ($res);

    // got any matches?
    if (db_num_rows ($res) == 0) {
	// no. complain
	ShowHeader ("No such item");
	echo "Sorry, but this item could not be found";
	ShowFooter();
	exit;
    }

    // fetch the type
    $query = sprintf ("SELECT name FROM types WHERE id=%s", $type);
    list ($type_name) = db_fetch_result (db_query ($query));

    // build the page
    ShowHeader("Owners of " . $name);
 ?><center>Owners of <b><?php echo $name; ?></b><p>
<table width="100%" cellpadding="5" cellspacing="1" bgcolor="#161616" class="defaultab">
 <tr bgcolor="#000000"><td width="20%" align="center"><img src="images/<?php echo $prefix . "_" . $item_id . ".gif"; ?>" alt="[<?php echo $name; ?>"><br><b><?php echo $name; ?></b><br><?php echo $type_name; ?></td>
 <td width="80%"><?php

    // fetch the owners
    $query = sprintf ("SELECT c.id,c.name FROM item_owner i,characters c WHERE item_id=%s AND item_type=%s AND i.owner_id=c.id", $item_id, $item_type);
    $res = db_query ($query); $num_owners = db_num_rows ($res);

    // got any owners?
    if ($num_owners == 0) {
	// no. show that
	printf ("This item is not owned by anybody");
    } else {
	// yes. show that
	printf ("This item is currently owned by %s character%s<p>", $num_owners, ($num_owners != 1) ? "s" : "");

	// list the owners
	echo "<ul>";
	while (list ($id, $name) = db_fetch_result ($res)) {
	    printf ("<li><a href=\"char.php?id=%s\">%s</a></li>", $id, $name);
	}
	echo "</ul>";
    }

    // show the footer
 ?></td>
 </tr>
</table><p>
<center><a href="javascript:history.go(-1);">Return to previous page</a></center>
<?php
    ShowFooter();
 ?>
