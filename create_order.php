<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$allowed_keys = array("name", "phone1", "phone2", "phone3", "comment", "client_id", "begin", "end", "delivery_address_to", "delivery_address_from", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id", "channel_id", "goods");

if (!$db_conection = db_connect()) 
  {
  finish("db_connect failed" . mysqli_sqlstate($db_conection) . mysqli_error($db_conection),$send_to_frontend=true);
  }

//получение запроса, парсинг json в array
$request_json = $_GET["request"];
$request = json_decode($request_json,true);
if($json_error <> '')
  {
  finish("request json decode error:". $json_error,$send_to_frontend=true);
  }

//поверхностная проверка request
//реализовать нормальную проверку значений
foreach(array_keys($request) as $key)
  {
  if(!in_array($key, $allowed_keys))
    {
    finish("wrong request json format. key=".$key." is not in allowed list",$send_to_frontend=true);
    }
  }

//поиск клиента или создание нового
if(empty($request["phone1"]) && empty($request["phone2"]) && empty($request["phone3"]))
  {
  finish("find/create client failed - phones are empty",$send_to_frontend=true);
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
  finish("find/create client failed",$send_to_frontend=true);
  }



//создание заказа в таблице ORDERS
$request_copy = $request;
$request_copy["client_id"] = $client_id;
// defaults
if(empty($request_copy["giver_id"])) {$request_copy["giver_id"] = 1;}
if(empty($request_copy["taker_id"])) {$request_copy["taker_id"] = 1;}
//if(empty($request_copy["give_stock_id"])) {$request_copy["give_stock_id"] = 1;}
//if(empty($request_copy["take_stock_id"])) {$request_copy["take_stock_id"] = 0;}

if(empty($request_copy["begin"])) {  finish("Заказ не создан: дата начала аренды должна быть указана",$send_to_frontend=true);}
if(empty($request_copy["end"])) {  finish("Заказ не создан: дата конца аренды должна быть указана",$send_to_frontend=true);}
if(empty($request_copy["goods"])) {  finish("Заказ не создан: выберите хотя бы один товар",$send_to_frontend=true);}
if($request_copy["give_stock_id"]==0) {  finish("Заказ не создан: где клиент будет получать заказ?",$send_to_frontend=true);}
log_error($request_copy["give_stock_id"]);

$columns = array();
$values = array();
// поля из входящего JSON, которые можно как есть пихать в БД
$ORDERS_keys = array("comment", "client_id", "begin", "end", "delivery_address_to", "delivery_address_from", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id", "channel_id");
foreach ($request_copy as $key => $value) 
  {
  if (in_array($key, $ORDERS_keys)) 
    {
    $columns[] = $key;
    $values[] = $value;
    }
  }


$sql = "INSERT INTO ORDERS (".implode(", ", $columns).") VALUES ('".implode("', '", $values)."')";
log_error($sql);

$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("insert into ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection),$send_to_frontend=true);
  };

//получаю order_id из автоинкремента
$order_id = mysqli_insert_id($db_conection);
if (!$order_id) 
  {
  finish("get order_id error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection),$send_to_frontend=true);
  };


//состав заказа - в таблицу MODELS_TO_ORDERS
// поля из входящего JSON, которые можно пихать в БД (MODELS_TO_ORDERS)
$MODELS_TO_ORDERS_keys = array("model_id", "count", "price", "deposit");
$request_copy = $request;
foreach ($request_copy["goods"] as $good) 
  {
  $columns = array();
  $values = array();
  foreach ($good as $key => $value) 
    {
    if (in_array($key, $MODELS_TO_ORDERS_keys)) 
      {
      $columns[] = $key;
      $values[] = $value;
      }
    }
  $columns[] = "order_id";
  $values[] = $order_id;
  $sql = "INSERT INTO MODELS_TO_ORDERS (".implode(", ", $columns).") VALUES ('".implode("', '", $values)."')";

  $result = mysqli_query($db_conection, $sql);
  if (!$result) 
    {
    finish("insert into MODELS_TO_ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection),$send_to_frontend=true);
    };
  }

mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false, "order_id" => $order_id);
echo json_encode($response_array);


?>


