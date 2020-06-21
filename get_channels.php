<?php
include 'include.php';
header('Content-Type: application/json; charset=UTF-8');

$response = "";

if (!$db_conection = db_connect()) 
  {
  finish("db_connect failed" . mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  }


$sql = "select id,name from CHANNELS";

//��������� ������ �������� �� STATUS
$result = mysqli_query($db_conection, $sql);
if (!$result) 
  {
  finish("get_channels SELECT error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
  };

$channels = array();
while($row = mysqli_fetch_array($result, MYSQLI_ASSOC))
	{
	array_push($channels, $row);
	}

mysqli_free_result($result);
mysqli_close($db_conection);
//��������� ���������
$response_array = array("error" => false, "channels" => $channels);
echo json_encode($response_array, JSON_UNESCAPED_UNICODE);

?>


