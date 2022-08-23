<?php
    //
    // index.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    // remove the cookie
    SetCookie ("auth_id", "", 0);

    // redirect to the main page
    Header ("Location: index.php"); 
 ?>
