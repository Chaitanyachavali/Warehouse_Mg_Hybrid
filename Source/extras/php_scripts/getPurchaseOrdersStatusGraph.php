<?php

header('Access-Control-Allow-Origin: *'); //To ajax request from cross domains also

mysql_connect("localhost", "root", ""); //connecting to database
mysql_select_db("warehouse_mg");

$user_id = $_POST['user_id'];
$product = $_POST['product'];

if(isset($user_id) && isset($product))
{
	$query = "select order_status,product_name, COUNT(*) as count from whm_purchases where whm_purchases.product_name = 'ERP Product 1' group by order_status, product_name";

	$output = mysql_query($query);

		$result_array = array();

		if(mysql_num_rows($output))
		{
			while($row=mysql_fetch_assoc($output))
			{
				$result_array[] = $row;
			}
		}

		
		//$rows = count($result_array);
		
		//var_dump($result_array);
		
		echo json_encode($result_array); 


}

else
	{
		echo "Invaild";
	}


?>