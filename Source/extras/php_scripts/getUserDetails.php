<?php

header('Access-Control-Allow-Origin: *'); //To ajax request from cross domains also

mysql_connect("localhost", "root", ""); //connecting to database
mysql_select_db("warehouse_mg");

$user_id = $_POST['user_id'];

if(isset($user_id))
{
	$query = "select * from warehouse_mg.whm_users where user_id = '$user_id' ";

	$output = mysql_query($query);

	$outputrow = mysql_num_rows($output);

	$row = mysql_fetch_array($output);

	if($outputrow == 1)
	{
		echo json_encode($row);
	}
	else
	{
		echo "Invalid";
	}
}





?>