<?

require_once("include/bittorrent.php");


function bark($msg) {
  stdhead();
  stdmsg("Delete failed!", $msg);
  stdfoot();
  exit;
}

if (!mkglobal("id"))
	bark("missing form data");

$id = 0 + $id;
if (!$id)
	die();



loggedinorreturn();

$res = mysql_query("SELECT name,owner,seeders,image1,image2 FROM torrents WHERE id = $id");
$row = mysql_fetch_array($res);
if (!$row)
	die();

if ($CURUSER["id"] != $row["owner"] && get_user_class() < UC_MODERATOR)
	bark("You're not the owner! How did that happen?\n");

$rt = 0 + $_POST["reasontype"];

if (!is_int($rt) || $rt < 1 || $rt > 5)
	bark("Invalid reason $rt.");

$r = $_POST["r"];
$reason = $_POST["reason"];

if ($rt == 1)
	$reasonstr = "Dead: 0 seeders, 0 leechers = 0 peers total";
elseif ($rt == 2)
	$reasonstr = "Dupe" . ($reason[0] ? (": " . trim($reason[0])) : "!");
elseif ($rt == 3)
	$reasonstr = "Nuked" . ($reason[1] ? (": " . trim($reason[1])) : "!");
elseif ($rt == 4)
{
	if (!$reason[2])
		bark("Please describe the violated rule.");
  $reasonstr = "TB rules broken: " . trim($reason[2]);
}
else
{
	if (!$reason[3])
		bark("Please enter the reason for deleting this torrent.");
  $reasonstr = trim($reason[3]);
}

deletetorrent($id);

if ($row["image1"]) {
 $img1 = IMAGE_BASE."$row[image1]";
 $del = unlink($img1);
}
if ($row["image2"]) {
 $img2 = IMAGE_BASE."$row[image2]";
 $del = unlink($img2);
}

write_log("Torrent $id ($row[name]) was deleted by $CURUSER[username] ($reasonstr)\n");

stdhead("Torrent deleted!");

if (isset($_POST["returnto"]))
	$ret = "<a href=\"" . htmlspecialchars($_POST["returnto"]) . "\">Go back to whence you came</a>";
else
	$ret = "<a href=\"./\">Back to index</a>";

?>
<h2>Torrent deleted!</h2>
<p><?= $ret ?></p>
<?

stdfoot();

?>