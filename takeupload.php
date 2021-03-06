<?
require_once("include/benc.php");
require_once("include/bittorrent.php");

ini_set("upload_max_filesize",$max_torrent_size);

function bark($msg) {
	genbark($msg, "Upload failed!");
}

loggedinorreturn();

if ((get_user_class() < UC_UPLOADER)&&(!ENA_UPLOAD_FOR_EVERYONE))
  die;

foreach(explode(":","descr:type:name") as $v) {
	if (!isset($_POST[$v]))
		bark("missing form data");
}

if (!isset($_FILES["tfile"]))
	bark("missing form data");

$f = $_FILES["tfile"];
$fname = unesc($f["name"]);
if (empty($fname))
	bark("Empty filename!");
	
$nfofile = $_FILES['nfo'];
if ($nfofile['name'] != '')
{
	if ($nfofile['size'] == 0)
  	bark("0-byte NFO");

	if ($nfofile['size'] > 65535)
  	bark("NFO is too big! Max 65,535 bytes.");

	$nfofilename = $nfofile['tmp_name'];

	if (@!is_uploaded_file($nfofilename))
  	bark("NFO upload failed");
}  	

$descr = unesc($_POST["descr"]);
if (!$descr)
  bark("You must enter a description!");

$catid = (0 + $_POST["type"]);
if (!is_valid_id($catid))
	bark("You must select a category to put the torrent in!");
	
if (!validfilename($fname))
	bark("Invalid filename!");
if (!preg_match('/^(.+)\.torrent$/si', $fname, $matches))
	bark("Invalid filename (not a .torrent).");
$shortfname = $torrent = $matches[1];
if (!empty($_POST["name"]))
	$torrent = unesc($_POST["name"]);

$tmpname = $f["tmp_name"];
if (!is_uploaded_file($tmpname))
	bark("eek");
if (!filesize($tmpname))
	bark("Empty file!");

$dict = bdec_file($tmpname, $max_torrent_size);
if (!isset($dict))
	bark("What the hell did you upload? This is not a bencoded file!");

function dict_check($d, $s) {
	if ($d["type"] != "dictionary")
		bark("not a dictionary");
	$a = explode(":", $s);
	$dd = $d["value"];
	$ret = array();
	foreach ($a as $k) {
		unset($t);
		if (preg_match('/^(.*)\((.*)\)$/', $k, $m)) {
			$k = $m[1];
			$t = $m[2];
		}
		if (!isset($dd[$k]))
			bark("dictionary is missing key(s)");
		if (isset($t)) {
			if ($dd[$k]["type"] != $t)
				bark("invalid entry in dictionary");
			$ret[] = $dd[$k]["value"];
		}
		else
			$ret[] = $dd[$k];
	}
	return $ret;
}

function dict_get($d, $k, $t) {
	if ($d["type"] != "dictionary")
		bark("not a dictionary");
	$dd = $d["value"];
	if (!isset($dd[$k]))
		return;
	$v = $dd[$k];
	if ($v["type"] != $t)
		bark("invalid dictionary entry type");
	return $v["value"];
}

list($ann, $info) = dict_check($dict, "announce(string):info");
list($dname, $plen, $pieces) = dict_check($info, "name(string):piece length(integer):pieces(string)");

if (!in_array($ann, $announce_urls, 1))
	bark("invalid announce url! must be <b>" . $announce_urls[0] . "</b>");

if (strlen($pieces) % 20 != 0)
	bark("invalid pieces");

$filelist = array();
$totallen = dict_get($info, "length", "integer");
if (isset($totallen)) {
	$filelist[] = array($dname, $totallen);
	$type = "single";
}
else {
	$flist = dict_get($info, "files", "list");
	if (!isset($flist))
		bark("missing both length and files");
	if (!count($flist))
		bark("no files");
	$totallen = 0;
	foreach ($flist as $fn) {
		list($ll, $ff) = dict_check($fn, "length(integer):path(list)");
		$totallen += $ll;
		$ffa = array();
		foreach ($ff as $ffe) {
			if ($ffe["type"] != "string")
				bark("filename error");
			$ffa[] = $ffe["value"];
		}
		if (!count($ffa))
			bark("filename error");
		$ffe = implode("/", $ffa);
		$filelist[] = array($ffe, $ll);
	}
	$type = "multi";
}

$infohash = pack("H*", sha1($info["string"]));

//////////////////////////////////////////////
//////////////Take Image Uploads//////////////

$maxfilesize = 512000; // 500kb

$allowed_types = array(
"image/gif" => "gif",
"image/pjpeg" => "jpg",
"image/jpeg" => "jpg",
"image/jpg" => "jpg"
// Add more types here if you like
);

for ($x=0; $x < 2; $x++) {

if (!($_FILES[image.$x]['name'] == "")) {
$y = $x + 1;

// Is valid filetype?
if (!array_key_exists($_FILES[image.$x]['type'], $allowed_types))
bark("Invalid file type! Image $y");

// Is within allowed filesize?
if ($_FILES[image.$x]['size'] > $maxfilesize)
bark("Invalid file size! Image $y - Must be less than 500kb");

// Where to upload?
// Update for your own server. Make sure the folder has chmod write permissions. Remember this director
$uploaddir = IMAGE_BASE;

// What is the temporary file name?
$ifile = $_FILES[image.$x]['tmp_name'];

// Calculate what the next torrent id will be
$ret = mysql_query("SHOW TABLE STATUS LIKE 'torrents'");
$row = mysql_fetch_array($ret);
$next_id = $row['Auto_increment'];

// By what filename should the tracker associate the image with?
$ifilename = $next_id . $x . substr($_FILES[image.$x]['name'], strlen($_FILES[image.$x]['name'])-4, 4);

// Upload the file
$copy = copy($ifile, $uploaddir.$ifilename);

if (!$copy)
bark("Error occured uploading image! - Image $y");

$inames[] = $ifilename;

}

}

//////////////////////////////////////////////

// Replace punctuation characters with spaces

$torrent = str_replace("_", " ", $torrent);

$nfo = sqlesc(str_replace("\x0d\x0d\x0a", "\x0d\x0a", @file_get_contents($nfofilename)));
$ret = mysql_query("INSERT INTO torrents (search_text, filename, owner, visible, info_hash, name, size, numfiles, type, descr, ori_descr, image1, image2, category, save_as, added, last_action, nfo) VALUES (" .
      implode(",", array_map("sqlesc", array(searchfield("$shortfname $dname $torrent"), $fname, $CURUSER["id"], "no", $infohash, $torrent, $totallen, count($filelist), $type, $descr, $descr, $inames[0], $inames[1], 0 + $_POST["type"], $dname))) .
      ", '" . get_date_time() . "', '" . get_date_time() . "', $nfo)");
if (!$ret) {
	if (mysql_errno() == 1062)
		bark("torrent already uploaded!");
	bark("mysql puked: ".mysql_error());
}
$id = mysql_insert_id();

@mysql_query("DELETE FROM files WHERE torrent = $id");
foreach ($filelist as $file) {
	@mysql_query("INSERT INTO files (torrent, filename, size) VALUES ($id, ".sqlesc($file[0]).",".$file[1].")");
}

move_uploaded_file($tmpname, "$torrent_dir/$id.torrent");

write_log("Torrent $id ($torrent) was uploaded by " . $CURUSER["username"]);



/* RSS feeds */

if (($fd1 = @fopen("rss.xml", "w")) && ($fd2 = fopen("rssdd.xml", "w")))
{
	$cats = "";
	$res = mysql_query("SELECT id, name FROM categories");
	while ($arr = mysql_fetch_assoc($res))
		$cats[$arr["id"]] = $arr["name"];
	$s = "<?xml version=\"1.0\" encoding=\"iso-8859-1\" ?>\n<rss version=\"0.91\">\n<channel>\n" .
		"<title>TorrentBits</title>\n<description>0-week torrents</description>\n<link>$DEFAULTBASEURL/</link>\n";
	@fwrite($fd1, $s);
	@fwrite($fd2, $s);
	$r = mysql_query("SELECT id,name,descr,filename,category FROM torrents ORDER BY added DESC LIMIT 15") or sqlerr(__FILE__, __LINE__);
	while ($a = mysql_fetch_assoc($r))
	{
		$cat = $cats[$a["category"]];
		$s = "<item>\n<title>" . htmlspecialchars($a["name"] . " ($cat)") . "</title>\n" .
			"<description>" . htmlspecialchars($a["descr"]) . "</description>\n";
		@fwrite($fd1, $s);
		@fwrite($fd2, $s);
		@fwrite($fd1, "<link>$DEFAULTBASEURL/details.php?id=$a[id]&amp;hit=1</link>\n</item>\n");
		$filename = htmlspecialchars($a["filename"]);
		@fwrite($fd2, "<link>$DEFAULTBASEURL/download.php/$a[id]/$filename</link>\n</item>\n");
	}
	$s = "</channel>\n</rss>\n";
	@fwrite($fd1, $s);
	@fwrite($fd2, $s);
	@fclose($fd1);
	@fclose($fd2);
}

/* Email notifs */
/*******************

$res = mysql_query("SELECT name FROM categories WHERE id=$catid") or sqlerr();
$arr = mysql_fetch_assoc($res);
$cat = $arr["name"];
$res = mysql_query("SELECT email FROM users WHERE enabled='yes' AND notifs LIKE '%[cat$catid]%'") or sqlerr();
$uploader = $CURUSER['username'];

$size = mksize($totallen);
$description = ($html ? strip_tags($descr) : $descr);

$body = <<<EOD
A new torrent has been uploaded.

Name: $torrent
Size: $size
Category: $cat
Uploaded by: $uploader

Description
-------------------------------------------------------------------------------
$description
-------------------------------------------------------------------------------

You can use the URL below to download the torrent (you may have to login).

$DEFAULTBASEURL/details.php?id=$id&hit=1

-- 
$SITENAME
EOD;
$to = "";
$nmax = 100; // Max recipients per message
$nthis = 0;
$ntotal = 0;
$total = mysql_num_rows($res);
while ($arr = mysql_fetch_row($res))
{
  if ($nthis == 0)
    $to = $arr[0];
  else
    $to .= "," . $arr[0];
  ++$nthis;
  ++$ntotal;
  if ($nthis == $nmax || $ntotal == $total)
  {
    if (!mail("Multiple recipients <$SITEEMAIL>", "New torrent - $torrent", $body,
    "From: $SITEEMAIL\r\nBcc: $to", "-f$SITEEMAIL"))
	  stderr("Error", "Your torrent has been been uploaded. DO NOT RELOAD THE PAGE!\n" .
	    "There was however a problem delivering the e-mail notifcations.\n" .
	    "Please let an administrator know about this error!\n");
    $nthis = 0;
  }
}
*******************/

header("Location: $BASEURL/details.php?id=$id&uploaded=1");

?>