<?php
    //
    // login.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need our library
    require "lib.php";

    //
    // RequestLogin($msg='')
    //
    // This will show the 'Log in' page. If $msg is not blank, this will be
    // shown as an error.
    //
    function
    RequestLogin($msg='') {
	global $PHP_SELF;

	// build the page
	ShowHeader("Log in");
 ?>If you already have an account, feel free to log in by entering your username and password in the table below. If you don't have an account, why not <a href="join.php">join us</a>? It's free!<p>
<?php
 	// got an error?
	if ($msg != '') {
	    // yes. show it
	    printf ("<center><font color=\"#ff0000\"><b>%s</b></font></center><p>", $msg);
	}
 ?>
<form action="<?php echo $PHP_SELF; ?>" method="post">
<input type="hidden" name="action" value="login">
<center>
<table width="41%" class="defaultab" cellspacing=1 cellpadding=2>
 <tr class="tabrow">
  <td width="20%" align="right">User Name&nbsp;</td>
  <td width="1%" align="center">&nbsp;</td>
  <td width="20%">&nbsp;<input type="text" name="username"></td>
 </tr>
 <tr class="tabrow">
  <td align="right">Password&nbsp;</td>
  <td align="center">&nbsp;</td>
  <td>&nbsp;<input type="password" name="password"></td>
 </tr>
 <tr class="tabrow">
  <td colspan=3 align="center"><input type="submit" value="Log in!"></td>
 </tr>
</table><p>
<font size=2><a href="forgotpass.php">Forgot your password?</a></center>
</form>
<?php
	ShowFooter();
    }


    // grab the values
    $action = $_REQUEST["action"];
    $username = $_REQUEST["username"];
    $password = $_REQUEST["password"];
	
    // is an action given?
    if ($action == "") {
	// no. request a login
	RequestLogin();
	exit;
    }

    // we got an action. now, is the username/password combination correct?
    if (!VerifyPassword ($username, $password)) {
	// no. complain
	RequestLogin("Bad username / password combination");
	exit;
    }

    // yes. create the cookie
    SetCookie ("auth_id", $username . ":" . $password, time() + 7200);

    // redirect back to the index page
    Header ("Location: index.php");
 ?>
