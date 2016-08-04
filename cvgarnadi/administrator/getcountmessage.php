<?php
require_once('../controller/model/config.php');
$query="select count(Id) as total from leavemessage";
$execute = mysql_query($query) or die("Error Mengambil Data");
$count = mysql_fetch_assoc($execute);
mysql_close($connection);
$result = array('data'=>$count['total']);
print json_encode($result);
?>