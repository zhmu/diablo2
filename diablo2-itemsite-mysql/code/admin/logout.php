<?php
    //
    // index.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "cplib.php";

    // farewell to cookies
    SetCookie ("authid", "", 0);

    // let's go back to the index page
    Header ("Location: index.php");
 ?>
