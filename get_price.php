<?php
include 'include.php';
header('Content-Type: application/json; charset=UTF-8');

$response = "";
$allowed_keys = array("model_id", "begin", "end", "channel_id");

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

$sql = "select model_id,channel_id,price_for_period,deposit_for_period from PRICELIST
where 1=1 
and model_id='".$request["model_id"]."' 
and channel_id='".$request["channel_id"]."' 
and datediff(DATE(STR_TO_DATE('" . $request["end"] . "', '%d.%m.%Y %H:%i:%s')), DATE(STR_TO_DATE('" . $request["begin"] . "', '%d.%m.%Y %H:%i:%s'))) between period_min and period_max";

//получение цен из PRICELIST
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("get_price SELECT error: ". $key ." ". mysqli_sqlstate($db_conection) ." - ". mysqli_error($db_conection));
  };

if (mysqli_num_rows($result) == 0)
  {
  finish("get_price - price not found: ". json_encode($request,JSON_UNESCAPED_UNICODE),$send_to_frontend=true);
  };

$price = array();
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
	{
	array_push($price, $row);
	}

mysqli_free_result($result);
mysqli_close($db_conection);
//возвращаю результат
$response_array = array("error" => false, "price" => $price);
echo json_encode($response_array, JSON_UNESCAPED_UNICODE);

?>


