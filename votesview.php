<?

require "include/bittorrent.php";
dbconn(false);
loggedinorreturn();


$requestid = $_GET[requestid];

$res2 = mysql_query("select count(addedrequests.id) from addedrequests inner join users on addedrequests.userid = users.id inner join requests on addedrequests.requestid = requests.id WHERE addedrequests.requestid =$requestid") or die(mysql_error());
$row = mysql_fetch_array($res2);
$count = $row[0];


$perpage = 50;

list($pagertop, $pagerbottom, $limit) = pager($perpage, $count, $_SERVER["PHP_SELF"] ."?" );

$res = mysql_query("select users.id as userid,users.username, users.downloaded,users.uploaded, requests.id as requestid, requests.request from addedrequests inner join users on addedrequests.userid = users.id inner join requests on addedrequests.requestid = requests.id WHERE addedrequests.requestid =$requestid $limit") or sqlerr();

stdhead("Voters");

$res2 = mysql_query("select request from requests where id=$requestid");
$arr2 = mysql_fetch_assoc($res2);

print("<h1>Voters for <a href=\"reqdetails.php?id=$requestid\"><b>$arr2[request]</b></a></h1>");
print("<p>Vote for this <a href=\"addrequest.php?id=$requestid\"><b>request</b></a></p>");

echo $pagertop;

if (mysql_num_rows($res) == 0)
print("<p align=\"center\"><b>Nothing found</b></p>\n");
else
{
//print("<table border=1 cellspacing=0 cellpadding=5>\n");
begin_table();
print("<tr><td class=\"colhead\">Username</td><td class=\"colhead\" align=\"left\">Uploaded</td><td class=\"colhead\" align=\"left\">Downloaded</td>".
"<td class=\"colhead\" align=\"left\">Share Ratio</td></tr>\n");

while ($arr = mysql_fetch_assoc($res))
{

if ($arr["downloaded"] > 0)
{
$ratio = number_format($arr["uploaded"] / $arr["downloaded"], 3);
$ratio = "<font color=" . get_ratio_color($ratio) . ">$ratio</font>";
}
else
if ($arr["uploaded"] > 0)
$ratio = "Inf.";
else
$ratio = "---";
$uploaded =mksize($arr["uploaded"]);
$joindate = "$arr[added] (" . get_elapsed_time(sql_timestamp_to_unix_timestamp($arr["added"])) . " ago)";
$downloaded = mksize($arr["downloaded"]);
if ($arr["enabled"] == 'no')
$enabled = "<font color = red>No</font>";
else
$enabled = "<font color = green>Yes</font>";

print("<tr><td class=\"row1\"><a href=\"userdetails.php?id=$arr[userid]\"><b>$arr[username]</b></a></td><td class=\"row1\" align=\"left\">$uploaded</td><td class=\"row1\" align=\"left\">$downloaded</td><td class=\"row1\" align=\"left\">$ratio</td></tr>\n");
}
//print("</table>\n");
end_table();
}

stdfoot();

?>
