<?
require_once("include/bittorrent.php");

function bark($msg) {
	genbark($msg, "Edit failed!");
}

////////////////////////////////////////////////
function uploadimage($x, $imgname, $tid) {

$maxfilesize = 512000; // 500kb

$allowed_types = array(
"image/gif" => "gif",
"image/pjpeg" => "jpg",
"image/jpeg" => "jpg",
"image/jpg" => "jpg"
// Add more types here if you like
);

if (!($_FILES[image.$x]['name'] == "")) {

if ($imgname != "") {
// Make sure is same as in takeedit.php (except for the $imgname bit)
$img = IMAGE_BASE."$imgname";
$del = @unlink($img);
}

$y = $x + 1;

// Is valid filetype?
if (!array_key_exists($_FILES[image.$x]['type'], $allowed_types))
bark("Invalid file type! Image $y");

// Is within allowed filesize?
if ($_FILES[image.$x]['size'] > $maxfilesize)
bark("Invalid file size! Image $y - Must be less than 500kb");

// Where to upload?
// Make sure is same as on takeupload.php
$uploaddir = IMAGE_BASE;

// What is the temporary file name?
$ifile = $_FILES[image.$x]['tmp_name'];

// By what filename should the tracker associate the image with?
$ifilename = $tid . $x . substr($_FILES[image.$x]['name'], strlen($_FILES[image.$x]['name'])-4, 4);

// Upload the file
$copy = copy($ifile, $uploaddir.$ifilename);

if (!$copy)
bark("Error occured uploading image! - Image $y");

return $ifilename;

}

}
////////////////////////////////////////////////

if (!mkglobal("id:name:descr:type"))
	bark("missing form data");

$id = 0 + $id;
if (!$id)
	die();



loggedinorreturn();

$res = mysql_query("SELECT owner, filename, save_as, image1, image2 FROM torrents WHERE id = $id");
$row = mysql_fetch_array($res);
if (!$row)
	die();

if ($CURUSER["id"] != $row["owner"] && get_user_class() < UC_MODERATOR)
	bark("You're not the owner! How did that happen?\n");

$updateset = array();

$fname = $row["filename"];
preg_match('/^(.+)\.torrent$/si', $fname, $matches);
$shortfname = $matches[1];
$dname = $row["save_as"];

$img1action = $_POST['img1action'];
if ($img1action == "update")
$updateset[] = "image1 = " .sqlesc(uploadimage(0, $row[image1], $id));
if ($img1action == "delete") 
{
	if ($row[image1]) 
	{
	$del = unlink(IMAGE_BASE."$row[image1]");
	$updateset[] = "image1 = ''";
	}
} 
$img2action = $_POST['img2action'];
if ($img2action == "update")
$updateset[] = "image2 = " .sqlesc(uploadimage(0, $row[image2], $id));
if ($img2action == "delete") 
{
	if ($row[image2]) 
	{
	$del = unlink(IMAGE_BASE."$row[image2]");
	$updateset[] = "image2 = ''";
	}
} 


$nfoaction = $_POST['nfoaction'];
if ($nfoaction == "update")
{
  $nfofile = $_FILES['nfo'];
  if (!$nfofile) die("No data " . var_dump($_FILES));
  if ($nfofile['size'] > 65535)
    bark("NFO is too big! Max 65,535 bytes.");
  $nfofilename = $nfofile['tmp_name'];
  if (@is_uploaded_file($nfofilename) && @filesize($nfofilename) > 0)
    $updateset[] = "nfo = " . sqlesc(str_replace("\x0d\x0d\x0a", "\x0d\x0a", file_get_contents($nfofilename)));
}
else
  if ($nfoaction == "remove")
    $updateset[] = "nfo = ''";

$updateset[] = "name = " . sqlesc($name);
$updateset[] = "search_text = " . sqlesc(searchfield("$shortfname $dname $torrent"));
$updateset[] = "descr = " . sqlesc($descr);
$updateset[] = "ori_descr = " . sqlesc($descr);
$updateset[] = "category = " . (0 + $type);
if ($CURUSER["admin"] == "yes") {
	if ($_POST["banned"]) {
		$updateset[] = "banned = 'yes'";
		$_POST["visible"] = 0;
	}
	else
		$updateset[] = "banned = 'no'";
}
$updateset[] = "visible = '" . ($_POST["visible"] ? "yes" : "no") . "'";

mysql_query("UPDATE torrents SET " . join(",", $updateset) . " WHERE id = $id");

write_log("Torrent $id ($name) was edited by $CURUSER[username]");

$returl = "details.php?id=$id&edited=1";
if (isset($_POST["returnto"]))
	$returl .= "&returnto=" . urlencode($_POST["returnto"]);
header("Refresh: 0; url=$returl");


?>