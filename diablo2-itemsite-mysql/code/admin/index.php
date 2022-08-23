<?php
    //
    // index.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "cplib.php";

    // build the page
    cpShowHeader("Introduction");

 ?>Hello <?php echo $GLOBALS["authname"]; ?><p>
Please chose what you'd like to do:<p>
<table width="100%">
 <tr>
  <td width="50%" align="center"><a href="type.php">Item Types</a></td>
  <td width="50%" align="center"><a href="unique.php">Unique Items</a></td>
 </tr>
</table>
<?php
    cpShowFooter();
 ?>
