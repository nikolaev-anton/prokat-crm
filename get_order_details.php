<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$response = "";
$allowed_keys = array("order_id");

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

$order_id = $request["order_id"];

$sql = "select 
ORDERS.id,
STATUS.NAME as status,
ORDERS.comment, 
ORDERS.client_id, 
ORDERS.created,
ORDERS.begin, 
ORDERS.end, 
ORDERS.delivery_address_to, 
ORDERS.delivery_address_from, 
ORDERS.total_amount, 
ORDERS.total_deposit, 
ORDERS.giver_id, 
ORDERS.taker_id, 
ORDERS.give_stock_id, 
ORDERS.take_stock_id
from ORDERS, CLIENTS, STATUS
where 1=1
and ORDERS.CLIENT_ID=CLIENTS.id
and ORDERS.STATUS_ID=STATUS.ID
and ORDERS.id=".$order_id;

//получение заказов из ORDERS, CLIENTS, MODELS_TO_ORDERS
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("get_order_details SELECT error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

//если найдено несколько заказов с одним номером, возвращаем ошибку 
if(mysqli_num_rows($result) <> 1) 
	{
	finish("найдено несколько записей (заказов)");
	}
//мы уже знаем, что только одна строка, поэтому берем первую запись
$order = mysqli_fetch_array($result, MYSQLI_ASSOC);

$sql = "select
model_id,
count, 
price, 
deposit 
from MODELS_TO_ORDERS
where order_id=".$order_id;
  
//состав заказа из таблицы MODELS_TO_ORDERS
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("select from MODELS_TO_ORDERS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

$goods = array();
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
	{
	array_push($goods, $row);
	}
$order["goods"] = $goods;

mysqli_free_result($result);
mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false, "order" => $order);
echo json_encode($response_array);

?>


