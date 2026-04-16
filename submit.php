<?php
$uploadDir = 'uploads/';
$file = $uploadDir . 'registrations.txt';
if (!is_dir($uploadDir)) {
  mkdir($uploadDir);
}
$username  = $_POST['username'] ?? '';
$password  = $_POST['password'] ?? '';
$name    = $_POST['name'] ?? '';
$gender   = $_POST['gender'] ?? '';
$birthdate  = $_POST['birthdate'] ?? '';
$phone    = $_POST['phone'] ?? '';
$nationality = $_POST['nationality'] ?? '';
$address   = $_POST['address'] ?? '';
$jobType   = $_POST['job_type'] ?? '';
$data = "========================================\n";
$data .= "Date: " . date('Y-m-d H:i:s') . "\n";
$data .= "Username: $username\n";
$data .= "Password: $password\n";
$data .= "Full Name: $name\n";
$data .= "Gender: $gender\n";
$data .= "Date of Birth: $birthdate\n";
$data .= "Phone: $phone\n";
$data .= "Nationality: $nationality\n";
$data .= "Address: $address\n";
$data .= "Job Type: $jobType\n";
$data .= "========================================\n\n";
if (file_put_contents($file, $data, FILE_APPEND)) {
  echo "<h2>Registration Successful!</h2>";
  echo "<p>Name: $name</p>";
  echo "<p>Username: $username</p>";
  echo "<p>Your data has been saved.</p>";
} else {
  echo "<h2>Error: Could not save data.</h2>";
}
?>
<br>
<a href="4-q1.html">Back to Registration</a>
