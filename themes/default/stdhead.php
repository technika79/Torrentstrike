<?php echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>\n";?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?= $title ?></title>
<link rel="stylesheet" type="text/css" href="./themes/<?=$ss_uri."/".$ss_uri?>.css" />
</head>
<body>

<table width="100%" cellspacing="0" cellpadding="0" style='background: transparent'>
<tr>
<td class="clear" width="49%">
<!--
<table border=0 cellspacing=0 cellpadding=0 style='background: transparent'>
<tr>

<td class=clear>
<img src=/pic/star20.gif style='margin-right: 10px'>
</td>
<td class=clear>
<font color=white><b>Current funds: <?=$FUNDS?></b></font>
</td>
</tr>
</table>
-->

</td>
<td class="clear">
<div align="center">
<img src="./pic/logo.gif" align="middle" alt="" />
</div>
</td>
<td class="clear" width="49%" align="right">
<a href="donate.php"><img src="https://www.paypal.com/en_US/i/btn/x-click-but04.gif" border="0" alt="Make a donation" style='margin-top: 5px'/></a>
</td>
</tr></table>
<?php

$w = "width=\"100%\"";
//if ($_SERVER["REMOTE_ADDR"] == $_SERVER["SERVER_ADDR"]) $w = "width=984";

?>
<table class="mainouter" <?=$w; ?> border="1" cellspacing="0" cellpadding="10">

<!--  MENU -->

<? $fn = substr($_SERVER['PHP_SELF'], strrpos($_SERVER['PHP_SELF'], "/") + 1); ?>
<tr><td class="outer" align="center">
<table class="main" width="700" cellspacing="0" cellpadding="5" border="0">
<tr>

<td align="center" class="navigation"><a href=".">Home</a></td>
<td align="center" class="navigation"><a href="browse.php">Browse</a></td>
<td align="center" class="navigation"><a href="search.php">Search</a></td>
<td align="center" class="navigation"><a href="upload.php">Upload</a></td>
<? if (!$CURUSER) { ?>
<td align="center" class="navigation">
<a href="login.php">Login</a> / <a href="signup.php">Signup</a>
</td>
<? } else { ?>
<td align="center" class="navigation"><a href="my.php">Profile</a></td>
<? } ?>
<td align="center" class="navigation"><a href="chat.php">Chat</a></td>
<td align="center" class="navigation"><a href="phpbb2.php">Forums</a></td>
<td align="center" class="navigation"><a href="topten.php">Top 10</a></td>
<td align="center" class="navigation"><a href="log.php">Log</a></td>
<td align="center" class="navigation"><a href="rules.php">Rules</a></td>
<td align="center" class="navigation"><a href="faq.php">FAQ</a></td>
<td align="center" class="navigation"><a href="links.php">Links</a></td>
<td align="center" class="navigation"><a href="staff.php">Staff</a></td>
</tr>
</table>
</td>
</tr>
<tr><td align="center" class="outer" style="padding-top: 20px; padding-bottom: 20px">
<?
