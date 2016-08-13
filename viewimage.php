<?
require "include/bittorrent.php";
dbconn(false);

loggedinorreturn();

$pic = $_GET["pic"];

stdhead("View Image");
print("<h1>$pic</h1>\n");
print("<p align=center><img src=".IMAGE_PATH."$pic></p>\n");
?>

<h3 align=center><a href="javascript: history.go(-1)">Back</a></h3>

<?
stdfoot();
?> 