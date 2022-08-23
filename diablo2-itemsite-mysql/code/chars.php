<?php
    //
    // chars.php
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

    ShowHeader("Characters");
 ?>Charachters
<?php
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
    while (list ($id, $name) = db_fetch_result ($res)) {
	$TYPE[$id] = $name;
    }
 
    // fetch all characters
    $query = sprintf ("SELECT id,name,type,experience FROM characters ORDER BY name ASC");
    $res = db_query ($query);

    // list them
    echo "<ul>";
    while (list ($id, $name, $typeid, $exp) = db_fetch_result ($res)) {
	printf ("<li><a href=\"char.php?id=%s\">%s</a> (%s level %s)</li>", $id, $name, $TYPE[$typeid], ResolveLevel ($exp));
    }
    echo "</ul>";

    ShowFooter();
 ?>
