<?php
    //
    // uniques.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    ShowHeader("Unique Items");
 ?>Diablo 2: Lord of Destruction features a lot of unique items. In order to add some structure to them, they are nicely sorted per category in the list below:<p>
<?php
    // fetch all classes
    $query = sprintf ("SELECT c.id,c.name,COUNT(i.id) FROM classes c,unique_items i,types t WHERE c.id=t.class_id AND t.id=i.type GROUP BY c.id ORDER BY c.name");
    $res = db_query ($query);

    // list them
    echo "<ul>";
    while (list ($id, $name, $count) = db_fetch_result ($res)) {
	printf ("<li><a href=\"unique_cat.php?id=%s\">%s</a> (%s item%s)</li>", $id, $name, $count, ($count != 1) ? "s" : "");
    }
    echo "</ul>";

    ShowFooter();
 ?>
