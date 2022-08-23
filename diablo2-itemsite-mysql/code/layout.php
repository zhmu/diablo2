<?php
    //
    // layout.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //
 
    //
    // ShowHeader($title)
    //
    // This will show the page header, along with title $title.
    //
    function
    ShowHeader($title) {
 ?><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head><title><?php echo $title; ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="styles/style.css" rel="Stylesheet" type="text/css">
</head><body>
<table width="80%" border=0 class="toptab" cellspacing=0 cellpadding=2 align="center">
 <tr class="tabrow">
  <td colspan=4 align="center"><a href="index.php"><img src="images/logo.png" alt="[Diablo2]" border=0></a></td>
 </tr>
 <tr class="tabrow">
  <td width="25%" align="center"><a href="sets.php">Set Items</a></td>
  <td width="25%" align="center"><a href="uniques.php">Unique Items</a></td>
  <td width="25%" align="center"><a href="chars.php">Characters</a></td>
  <td width="25%" align="center"><?php
	// are we logged in?
	if ($GLOBALS["logged_in"] == 1) {
	    // yes. show the 'my profile / logout' link
 ?><a href="you.php">Your Characters</a> / <a href="logout.php">Logout</a><?php
	} else {
	    // no. show the 'login' link
 ?><a href="login.php">Log In</a><?php
	}
 ?></tr>
</table><p>
<table width="90%" align="center" class="defaultab">
 <tr>
  <td width="100%">
<?php
    }

    //
    // ShowFooter()
    //
    // This will show the page footer.
    //
    function
    ShowFooter() {
 ?><p></td>
 </tr>
</table></body></html>
<?php
    }
 ?>
