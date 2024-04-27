<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$response = "";
$allowed_keys = array("name", "phone1", "phone2", "phone3", "comment", "client_id", "begin", "end", "delivery_address_to", "delivery_address_from", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id", "goods");

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

//поверхностна€ проверка request
//реализовать нормальную проверку значений
foreach(array_keys($request) as $key)
  {
  if(!in_array($key, $allowed_keys))
    {
    finish("wrong request json format. key=".$key." is not in allowed list");
    }
  }

//поиск клиента или создание нового
if(empty($request["phone1"]) && empty($request["phone2"]) && empty($request["phone3"]))
  {
  finish("find/create client failed - phones are empty");
  }

$client_id = get_client_by_phone($request["phone1"]);
if(empty($client_id))
  {
  $client_id = get_client_by_phone($request["phone2"]);
  if(empty($client_id))
    {
    $client_id = get_client_by_phone($request["phone3"]);
    if(empty($client_id))
      {
      $client_id = create_client($request["name"], $request["phone1"], $request["phone2"], $request["phone3"], "autocreate");
      };
    };
  };
if(empty($client_id))
  {
  finish("find/create client failed");
  }


//создание заказа в таблице ORDERS
$request_copy = $request;
$request_copy["client_id"] = $client_id;
// defaults
if(empty($request_copy["giver_id"])) {$request_copy["giver_id"] = 1;}
if(empty($request_copy["taker_id"])) {$request_copy["taker_id"] = 1;}
if(empty($request_copy["give_stock_id"])) {$request_copy["give_stock_id"] = 1;}
if(empty($request_copy["take_stock_id"])) {$request_copy["take_stock_id"] = 1;}

$columns = array();
$values = array();
// пол€ из вход€щего JSON, которые можно как есть пихать в Ѕƒ
$ORDERS_keys = array("comment", "client_id", "begin", "end", "delivery_address_to", "delivery_address_from", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id");
foreach ($request_copy as $key => $value) 
  {
//log_error($key."=".$value);
  if (in_array($key, $ORDERS_keys)) 
    {
    $columns[] = $key;
    $values[] = $value;
    }
  }

$sql = "INSERT INTO ORDERS (".implode(", ", $columns).") VALUES ('".implode("', '", $values)."')";

//log_error($sql);

$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("insert into ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

//получаю order_id из автоинкремента
$order_id = mysqli_insert_id($db_conection);
if (!$order_id) 
  {
  finish("get order_id error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

$request_copy = $request;
//log_error(json_encode($request_copy));
//log_error(json_encode($request_copy["goods"]));
//log_error(implode('|',$request_copy["goods"]));	  

//состав заказа - в таблицу MODELS_TO_ORDERS
// пол€ из вход€щего JSON, которые можно пихать в Ѕƒ (MODELS_TO_ORDERS)
$MODELS_TO_ORDERS_keys = array("model_id", "count", "price", "deposit");
log_error(var_dump($request_copy["goods"]));
foreach ($request_copy["goods"] as $good) 
  {
  $columns = array();
  $values = array();
//log_error(var_dump($good));
  foreach ($good as $key => $value) 
    {
//log_error($key."=".$value);
    if (in_array($key, $MODELS_TO_ORDERS_keys)) 
      {
      $columns[] = $key;
      $values[] = $value;
      }
    }
  $columns[] = "order_id";
  $values[] = $order_id;
  $sql = "INSERT INTO MODELS_TO_ORDERS (".implode(", ", $columns).") VALUES ('".implode("', '", $values)."')";
  //log_error($sql);

  $result = mysqli_query($db_conection, $sql);
  if (!$result) 
    {
    finish("insert into MODELS_TO_ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
    };
  }




/*
foreach($request["goods"] as $good)
	{
	$sql = "insert into MODELS_TO_ORDERS( 
	order_id, 
	model_id,
	count, 
	price, 
	deposit 
	)
	values
	(".
	$order_id
	. ", " . $good["model_id"]
	. ", " . $good["count"]
	. ", " . $good["price"]
	. ", " . $good["deposit"]
	. ")";
log_error($sql);	  
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
	  {
	  finish("insert into MODELS_TO_ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
	  };
	}
*/
  
mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false, "order_id" => $order_id);
echo json_encode($response_array);

log_error(json_encode($response_array));


?>


