<?php
$uploadDir = 'uploads/';
if (!is_dir($uploadDir)) {
  mkdir($uploadDir);
}
if (isset($_FILES['uploadfile']) && $_FILES['uploadfile']['error'] === 0) {
  $fileName = $_FILES['uploadfile']['name'];
  $fileSize = $_FILES['uploadfile']['size'];
  $dest = $uploadDir . $fileName;
  if (move_uploaded_file($_FILES['uploadfile']['tmp_name'], $dest)) {
    echo "<h2>Upload Success!</h2>";
    echo "<p>File: " . $fileName . "</p>";
    echo "<p>Size: " . $fileSize . " bytes</p>";
  } else {
    echo "<h2>Upload Failed.</h2>";
  }
} else {
  echo "<h2>No file selected.</h2>";
}
?>
<br>
<a href="4-12.html">Back</a>
