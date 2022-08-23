<?php
    //
    // lib.php
    //
    // (c) 2002 Rink Springer, <rink@next-future.nl>
    //

    // we need the database settings
    require "db_settings.php";

    // include the layout files for convenience
    require "layout.php";

    // ERROR_MAIL is the email address where MySQL errors will end up
    define (ERROR_MAIL, "you@example.com");

    // ITEMTYPE_xxx indicates the item type
    define (ITEMTYPE_UNIQUE, 1);
    define (ITEMTYPE_SET, 2);

    //
    // MailError ($err)
    //
    // This will mail $err to ERROR_MAIL.
    //
    function
    MailError ($err) {
	global $SERVER_NAME;

	$subject = "[$SERVER_NAME] - Website Error";
	$body = "Hello,

We just got a fatal error at $SERVER_NAME. The error is:

$err

You may want to fix this.

Regards,
lib.php :-)";

	// off it goes!
	Mail (ERROR_MAIL, $subject, $body, "From: webmaster@$SERVER_NAME");
    }

    //
    // db_query ($query)
    //
    // This will execute query $query and return a MySQL result handle. If
    // anything fails, the webmaster will be emailed and the script aborted.
    //
    function
    db_query ($query) {
	// execute the query
	$res = mysql_query ($query);
	if (!$res) {
	    // this failed. complain
	    MailError ("Cannot execute query\n\n$query\n\nError was\n\n" . mysql_error());
	    die ("Sorry, but a MySQL database query went wrong. The webmaster has already been informed about this");
	}

	// return the handle
	return $res;
    }

    //
    // db_fetch_result ($res)
    //
    // This will return an array of one result row from $res, or FALSE if there
    // are no more result rows.
    //
    function
    db_fetch_result ($res) {
	return @mysql_fetch_array ($res);
    }

    //
    // db_fetch_insert_id()
    //
    // This will grab the recently used ID when inserting a new line.
    //
    function
    db_fetch_insert_id() {
	// we must query for the ID, to ensure PHP will not overflow it's
	// variables.
	$query = sprintf ("SELECT LAST_INSERT_ID()");
	list ($id) = db_fetch_result (db_query ($query));
	return $id;
    }

    //
    // db_num_rows($res)
    //
    // This will return the number of rows SELECT-ed in result handle $res.
    //
    function
    db_num_rows($res) {
	return @mysql_num_rows ($res);
    }

    //
    // VerifyPassword ($username, $password)
    //
    // This will verify whether username $username with password $password is
    // correct. It will return non-zero on success or zero on failure.
    //
    function
    VerifyPassword ($username, $password) {
	// build the query
	$query = sprintf ("SELECT id FROM accounts WHERE username='%s' AND password='%s'", $username, $password);
	$res = db_query ($query);
	list ($GLOBALS["account_id"]) = db_fetch_result ($res);

	// did this work?
	if (db_num_rows ($res) == 0) {
	    // no. the account is invalid
	    return 0;
	}

	// the account is valid
	return 1;
    }
 
    // open the database connection
    if (!mysql_connect (DB_HOSTNAME, DB_USERNAME, DB_PASSWORD)) {
	// this failed. complain
	MailError ("Can't connect - " . mysql_error());
	die ("Cannot connect to MySQL server");
    }

    // select the correct database
    if (!mysql_select_db (DB_DBNAME)) {
	// this failed. complain	
	MailError ("Can't select database - " . mysql_error());
	die ("Cannot select correct MySQL database");
    }

    // is an authentication cookie given?
    if ($_COOKIE["auth_id"] != "") {
	// yes. split it up
	list ($username, $pwd) = explode (":", $_COOKIE["auth_id"]);

	// is it correct?
	if (!VerifyPassword ($username, $pwd)) {
	    // no. get rid of the cookie
	    SetCookie ("auth_id", "");
	} else {
	    // yes. we are logged in now
	    $GLOBALS["logged_in"] = 1;
	}
    }
 ?>
