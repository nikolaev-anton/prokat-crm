<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$response = "";
$client_stock_id=3; //номер виртуального склада "в прокате"
$allowed_keys = array("order_id", "giver_id");

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

//если задан сотрудник, выдающий заказ, то принудительно меняем его в заказе. Такое может быть, если заказ предварительно не отредактировали
if(!empty($request["giver_id"]))
	{
	$giver_sql = ",giver_id=".$request["giver_id"];
	}
else
	{
	$giver_sql="";
	}

$sql = "update ORDERS set 
status_id=1, BEGIN=SYSDATE()"
.$giver_sql.
" where id=".$order_id;
echo $sql."<br>";
//изменение заказа в БД (таблица ORDERS)
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("give_order UPDATE error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };
mysqli_free_result($result);


//перемещение товаров из места выдачи в виртуальный склад "в прокате"  

$sql = 
"SELECT 
  GIVE_STOCK_ID 
FROM 
  ORDERS
WHERE 
  ORDERS.ID=".$order_id;
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("select from ORDERS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };
$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
$give_stock_id = intval($row["GIVE_STOCK_ID"]);
mysqli_free_result($result);


//смотрим, сколько каких моделей в заказе
$sql = 
"SELECT 
  MODEL_ID, COUNT 
FROM 
  MODELS_TO_ORDERS 
WHERE 
  ORDER_ID=".$order_id;
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("select from MODELS_TO_ORDERS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };
$models = array();
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
	{
	$model_counts[intval($row["MODEL_ID"])] = intval($row["COUNT"]);
	}
mysqli_free_result($result);


//изменение склада единицам товара помодельно. Не придумал, как это за один запрос сделать
foreach(array_keys($model_counts) as $model_id)
	{
	//достаем список item'ов одной модели
	$sql = "select ID from ITEMS where STOCK_ID=".$give_stock_id." and MODEL_ID=".$model_id." LIMIT ".$model_counts[$model_id];
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
		{
		finish("select from ITEMS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
		};
	$items = array();
	while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
		{
		array_push($items, $row["ID"]);
		}
	mysqli_free_result($result);
	
	//меняем склад этому списку item'ов
	$sql = "update ITEMS set STOCK_ID=".$client_stock_id." where ID in (" . implode(",",$items) . ")";
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
		{
		finish("update ITEMS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
		};
	mysqli_free_result($result);

	//создаем движение
	$sql = "insert into MOVEMENTS(COMMENT, FROM_STOCK_ID, TO_STOCK_ID, ITEM_ID) values ";
	for($i=count($items); $i>0; $i--)
		{
		$sql = $sql . "('giving order # ".$order_id."',".$give_stock_id.",".$client_stock_id.",".$items[$i-1].")";
		if($i <> 1)
			{
			$sql = $sql . ",";
			}
		};
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
		{
		finish("insert into MOVEMENTS error: ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
		};
	mysqli_free_result($result);
	}

mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false);
echo json_encode($response_array);



?>


