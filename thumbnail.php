<?php
# Constants
// Relative Server/url path to image folder (no beginning,no ending slash)
define(IMAGE_BASE, 'C:/Program Files/Apache Group/Apache/htdocs/torrentstrikev4/pics');
define(MAX_WIDTH, 250);
define(MAX_HEIGHT, 250);

# Get image location
$image_file = str_replace('..', '', $_SERVER['QUERY_STRING']);
$image_path = IMAGE_BASE . "/$image_file";

# Load image
$img = null;
$ext = strtolower(end(explode('.', $image_path)));

if ($ext == 'jpg' || $ext == 'jpeg') {
$img = imagecreatefromjpeg($image_path);
} else if ($ext == 'png') {
$img = imagecreatefrompng($image_path);
# Only if your version of GD includes GIF support
} else if ($ext == 'gif') {
$img = imagecreatefromgif($image_path);
}

# If an image was successfully loaded, test the image for size
if ($img) {

# Get image size and scale ratio
$width = imagesx($img);
$height = imagesy($img);
$scale = min(MAX_WIDTH/$width, MAX_HEIGHT/$height);

# If the image is larger than the max shrink it
if ($scale < 1) {
$new_width = floor($scale*$width);
$new_height = floor($scale*$height);

# Create a new temporary image
$tmp_img = imagecreatetruecolor($new_width, $new_height);

# Copy and resize old image into new image
imageCopyResampled($tmp_img, $img, 0, 0, 0, 0,
$new_width, $new_height, $width, $height);
imagedestroy($img);
$img = $tmp_img;
}
}

# Create error image if necessary
if (!$img) {
$img = imagecreate(MAX_WIDTH, MAX_HEIGHT);
imagecolorallocate($img,0,0,0);
$c = imagecolorallocate($img,70,70,70);
imageline($img,0,0,MAX_WIDTH,MAX_HEIGHT,$c2);
imageline($img,MAX_WIDTH,0,0,MAX_HEIGHT,$c2);
}

# Display the image
header("Content-type: image/jpeg");
imagejpeg($img,"",95);
?> 