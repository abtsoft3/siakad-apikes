<?php
$hostname = 'localhost';   // Hostname
$dbname   = 'cvgarnadi';      // Nama Database
$username = 'root';        // Username Database
$password = ''; // Database password

// Koneksi ke databse
$connection=mysql_connect($hostname, $username, $password);
// Pilih database
if(!$connection){
	DIE(mysql_error().'Koneksi ke server gagal !');
}else{
	mysql_select_db($dbname) or DIE('Database tidak tersedia !');
}
?>
