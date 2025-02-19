<?php
include 'include.php';
header('Content-Type: text/html; charset=UTF-8');

$response = "";
$allowed_keys = array("name", "phone1", "phone2", "phone3", "comment", "client_id", "begin", "end", "delivery_address_to", "delivery_address_from", "total_amount", "total_deposit", "giver_id", "taker_id", "give_stock_id", "take_stock_id", "goods");

if (!$db_conection = db_connect()) 
  {
  finish("db_connect failed" . mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  }

//��������� �������, ������� json � array
$request_json = $_GET["request"];
$request = json_decode($request_json,true);
if($json_error <> '')
  {
  finish("request json decode error:". $json_error);
  }

//������������� �������� request
//����������� ���������� �������� ��������
foreach(array_keys($request) as $key)
  {
  if(!in_array($key, $allowed_keys))
    {
    finish("wrong request json format. key=".$key." is not in allowed list");
    }
  }

//����� ������� ��� �������� ������
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
  finish("create client failed");
  }

 
$sql = "insert into ORDERS( 
status_id,
comment, 
client_id, 
created,
begin, 
end, 
delivery_address_to, 
delivery_address_from, 
total_amount, 
total_deposit, 
giver_id, 
taker_id, 
give_stock_id, 
take_stock_id
)
values
(".
0
. ", '" . $request["comment"] . "'"
. ", " . $client_id
. ", SYSDATE()" 
. ", STR_TO_DATE('" . $request["begin"] . "', '%d.%m.%Y %H:%i:%s')"
. ", STR_TO_DATE('" . $request["end"] . "', '%d.%m.%Y %H:%i:%s')"
. ", '" . $request["delivery_address_to"] . "'"
. ", '" . $request["delivery_address_from"] . "'"
. ", " . $request["total_amount"]
. ", " . $request["total_deposit"]
. ", " . $request["giver_id"]
. ", " . $request["taker_id"]
. ", " . $request["give_stock_id"]
. ", " . $request["take_stock_id"]
. ")";
  
//echo $sql."<BR><BR>";  

//�������� ������ � ������� ORDERS
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("insert into ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

//������� order_id �� ��������������
$order_id = mysqli_insert_id($db_conection);
if (!$order_id) 
  {
  finish("get order_id error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

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
	  
	//������ ������ - � ������� MODELS_TO_ORDERS
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
	  {
	  finish("insert into MODELS_TO_ORDERS error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
	  };
	}

  
mysqli_close($db_conection);
//��������� ���������
$response_array = array("error" => false, "order_id" => $order_id);
echo json_encode($response_array);



?>


