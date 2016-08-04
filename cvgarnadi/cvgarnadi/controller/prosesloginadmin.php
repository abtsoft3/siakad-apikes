<?php
if(isset($_POST['username'],$_POST['password'])){
	$username=mysql_real_escape_string($_POST['username']);
	$password=mysql_real_escape_string($_POST['password']);
	session_start();
	include("model/config.php");
	$cek=mysql_query("select distinct(username),(password) from user where (username='".$_POST['username']."') and (password='".$_POST['password']."') ");
	$rows=mysql_num_rows($cek);
	if ($rows == 1)
		{
			$_SESSION['username'] =$_POST['username'];
			$_SESSION['password']=$_POST['password'];
			$data = array('stat' =>1);
			print json_encode($data);
	}
	else
		{
			$data=array('stat'=>0);
			print json_encode($data);
	}
}











?>