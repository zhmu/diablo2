<?php
    //
    // cplib.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our more generic library, too
    require "../lib.php";

    //
    // cpShowHeader($section='', $subsection='')
    //
    // This will actually show the header with title $section, section
    // $section and subsection $subsection;
    //
    function
    cpShowHeader($section='',$subsection='') {
 ?><html><head><title><?php echo $section; if ($subsection != "") { echo " > " . $subsection; } ?></title></head>
<link href="style.css" rel="Stylesheet" type="text/css">
<body>
<table width="100%" class="toptab" cellspacing=0 cellpadding=3>
 <tr class="toprow">
  <td width="80%" class="topcell1">Diablo II Control Panel</td>
  <td width="20%" class="topcell2" align="right">Logged in as <b><?php echo $GLOBALS["authname"]; ?></b>&nbsp;<br>[<a href="logout.php">Logout</a>]&nbsp;</td>
 </tr>
 <tr class="toprow2">
  <td colspan=2 class="topcell3"><a class="toplink" href="index.php">Control Panel</a><?php
	// got a section?
	if ($section != "") {
	    // yes. do we have a subsection too?
	    if ($subsection != "") {
		// yes. display the section and subsection
		printf (" > <a class=\"toplink\" href=\"%s\">%s</a> > %s", $_SERVER["PHP_SELF"], $section, $subsection);
	    } else {
		// no. just a section then
		printf (" > %s", $section);
	    }
	}
 ?></td>
 </tr>
 <tr>
  <td colspan=2>
<?php
    }

    //
    // cpShowFooter()
    //
    // This will actually show the footer.
    //
    function
    cpShowFooter() {
 ?></td>
 </tr>
</table></body></html>
<?php
    }

    //
    // RequestAuth ($msg='')
    //
    // This will request authentication details, with an optional error $msg.
    //
    function
    RequestAuth ($msg='') {
 ?><html><head><title>Authentication Needed</title></head><body>
<form action="<?php echo $_SERVER["PHP_SELF"]; ?>" method="post">
<table width="80%" border=1 align="center">
 <tr>
  <td>
   <table width="100%" border=0>
    <tr>
     <td colspan=3 align="center"><br>
     Before we can grant you access, you must first authenticate yourself. Please enter your username and password<?php if ($msg != "") { echo "<p><font color=\"#ff0000\"><b>" . $msg . "</b></font>"; }; ?><p> </td>
    </tr>
    <tr>
     <td width="50%" align="right">Username</td>
     <td width="1%" align="center">&nbsp;</td>
     <td width="50%"" align="left"><input type="text" name="username"></td>
    </tr>
    <tr>
     <td align="right">Password</td>
     <td align="center">&nbsp;</td>
     <td align="left"><input type="password" name="password"></td>
    </tr>
    <tr>
     <td colspan=3 align="center"><br><input type="submit" value="Authenticate"><p></td>
    </tr>
   </table>
  </td>
 </tr>
</table></form>
</body></html>
<?php
    }

    //
    // Authenticate ($uname, $pwd)
    // 
    // This will verify username/password pair $uname and $pwd. It will
    // set some global variables on success and return one, or zero if they
    // won't do.
    //
    function
    Authenticate ($uname, $pwd) {
	// try to fetch the user id
	$query = sprintf ("SELECT id FROM admins WHERE username='%s' AND password='%s'", $uname, $pwd);
	$res = db_query ($query);
	list ($GLOBALS["accountid"]) = db_fetch_result ($res);

	// did this work?
	if (db_num_rows ($res) == 0) {
	    // no. complain
	    return 0;
	}

	// woohoo, this worked!
	return 1;
    }

    // is an authentication cookie given?
    if ($_COOKIE["authid"] == "") {
	// no. are the username and password fields filled out?
	$username = trim (strip_tags ($_REQUEST["username"]));
	$password = trim (strip_tags ($_REQUEST["password"]));
	if (($username == "") and ($password == "")) {
	    // no. request authentiction
	    RequestAuth();
	    exit;
	}

	// authenticate ourselves
	if (!Authenticate ($username, $password)) {
	    // sorry, but no access
	    RequestAuth ("Access denied");
	    exit;
	}

	// this worked. create the cookie
	SetCookie ("authid", $username . ":" . $password, time() + 7200);
	$GLOBALS["authname"] = $username;
    } else {
	// yes. split the username and password
	list ($GLOBALS["authname"], $pwd) = explode (":", $_COOKIE["authid"]);

	// got a match?
	if (!Authenticate ($GLOBALS["authname"], $pwd)) {
	    // nope. sorry, but no access
	    SetCookie ("authid", "", 0);
	    RequestAuth ("Access denied");
	    exit;
	}
    }
 ?>
