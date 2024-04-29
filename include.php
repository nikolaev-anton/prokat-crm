<?php
//error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED); 
$db_server = "localhost"; //Имя сервера
$db_user = "prokatparu_crm";  //Пользователь БД
$db_password = "kuqebUy7";  //Пароль к БД
$db_name = "prokatparu_crm";  //Имя БД
$log_file = 'log_error.txt';  //Имя файла с логом ошибок

function db_connect() {
    global $db_server, $db_user, $db_password, $db_name;

    $link = mysqli_connect($db_server,$db_user,$db_password,$db_name);
    if (!$link) {
        log_error("Ошибка: Невозможно установить соединение с MySQL." . "Код ошибки errno: " . mysqli_connect_errno() . "Текст ошибки error: " . mysqli_connect_error());
        return false;
    }
    // изменение кодировки
    if (!mysqli_set_charset($link, "utf8")) {
        log_error("Ошибка при установке кодировки: %s\n", mysqli_error($link));
        mysqli_close($link);
        return false;
    }
    return $link;
}

function finish($text, $send_to_frontend) {
  global $db_conection;
  log_error($text);
  if($send_to_frontend === true) {
    $response_array = array("error" => true, "error_text" => $text);
    echo json_encode($response_array, JSON_UNESCAPED_UNICODE);
    db_disconnect($db_conection);
  }
  exit;
}

function db_disconnect($link) {
    mysqli_close($link);
}

function log_error($s) {
    global $log_file;
    file_put_contents($log_file, $s . PHP_EOL, FILE_APPEND);
}

function nvl(&$var, $default = "") {
    return isset($var) ? $var
                       : $default;
}

function get_client_by_phone($phone) {
	global $db_conection;
	// передали пустой телефон - возвращаем "ничего"
	if(empty($phone)) 
		{
		return "";
		}

	$sql = "select id from CLIENTS where phone1='".$phone."' or phone2='".$phone."' or phone3='".$phone."'";

	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
	  {
	  finish("select from CLIENTS error: " . mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
	  };

	//если найдено несколько клиентов возвращаем "" - будет создан новый клиент. Нелогично, но лучше не придумал 
	if(mysqli_num_rows($result) <> 1) 
		{
		return "";
		}
	//мы уже знаем, что только одна строка, поэтому берем первую запись
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
    return $row["id"];
}

function create_client($name, $phone1, $phone2, $phone3, $comment) {
	global $db_conection;

	$sql = "insert into CLIENTS( 
	name,
	phone1,
	phone2,
	phone3,
	comment, 
	created
	)
	values
	(".
	"'" . $name . "'"
	. ", '" . $phone1 . "'"
	. ", '" . $phone2 . "'"
	. ", '" . $phone3 . "'"
	. ", '" . $comment . "'"
	. ", SYSDATE()" 
	. ")";
	  
	//создание клиента в таблице CLIENTS
	$result = mysqli_query($db_conection, $sql);
	if (!$result) 
	  {
	  finish("insert into CLIENTS error: " . mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
	  };

	//получаю client_id из автоинкремента
	$client_id = mysqli_insert_id($db_conection);
	if (!$client_id) 
	  {
	  finish("get client_id error: ". $key ." ". mysqli_sqlstate($db_conection) . mysqli_error($db_conection));
	  };
  
    return $client_id;
}

?>



