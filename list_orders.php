<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$response = "";
$allowed_keys = array("order_id", "status", "name", "phone", "phone1", "phone2", "phone3", "comment", "client_id", "begin", "end", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id");

if (!$db_conection = db_connect()) 
  {
  finish("db_connect failed" . mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  }

//получение запроса, парсинг json в array
$request_json = $_GET["request"];
$request = json_decode($request_json,true);
if($json_error <> '')
  {
  finish("request json decode error:". $json_error);
  }

//поверхностная проверка request
//реализовать нормальную проверку значений
foreach(array_keys($request) as $key)
  {
  if(!in_array($key, $allowed_keys))
    {
    finish("wrong request json format. key=".$key." is not in allowed list");
    }
  }

 
$sql = "select 
ORDERS.id
from ORDERS, CLIENTS, STATUS
where 1=1
and ORDERS.STATUS_ID=STATUS.ID
and ORDERS.CLIENT_ID=CLIENTS.id";

foreach(array_keys($request) as $key)
  {
  if($key == "phone" or $key == "phone1" or $key == "phone2" or $key == "phone3") 
	  {$sql  = $sql . " and (phone1='".$request[$key]."' or phone2='".$request[$key]."' or phone3='".$request[$key]."')";}
  elseif($key == "comment") 
	  {$sql  = $sql . " and ORDERS.comment='".$request[$key]."'";}
  elseif($key == "status") 
	  {$sql  = $sql . " and STATUS.NAME='".$request[$key]."'";}
  elseif($key == "client_id") 
	  {$sql  = $sql . " and client_id=".$request[$key];}
  elseif($key == "order_id") 
	  {$sql  = $sql . " and ORDERS.id=".$request[$key];}
  elseif($key == "begin") 
	  {$sql  = $sql . " and DATE(begin)=DATE(STR_TO_DATE('" . $request[$key] . "', '%d.%m.%Y %H:%i:%s'))";}
  elseif($key == "end") 
	  {$sql  = $sql . " and DATE(end)=DATE(STR_TO_DATE('" . $request[$key] . "', '%d.%m.%Y %H:%i:%s'))";}
  elseif($key == "total_amount") 
	  {$sql  = $sql . " and total_amount=".$request[$key];}
  elseif($key == "total_deposit") 
	  {$sql  = $sql . " and total_deposit=".$request[$key];}
  elseif($key == "giver_id") 
	  {$sql  = $sql . " and giver_id=".$request[$key];}
  elseif($key == "taker_id") 
	  {$sql  = $sql . " and taker_id=".$request[$key];}
  elseif($key == "give_stock_id") 
	  {$sql  = $sql . " and give_stock_id=".$request[$key];}
  elseif($key == "take_stock_id") 
	  {$sql  = $sql . " and take_stock_id=".$request[$key];}
  }

//получение заказов из ORDERS, CLIENTS, MODELS_TO_ORDERS
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("list_orders SELECT error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

$orders = array();
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
	{
	array_push($orders, intval($row["id"]));
	}

mysqli_free_result($result);
mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false, "orders" => $orders);
echo json_encode($response_array);



?>


