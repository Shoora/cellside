<?
require_once 'Zend/Loader/Autoloader.php';
ob_start();
include '/controller/module/recaptcha.php';
ob_end_clean();




$autoloader = Zend_Loader_Autoloader::getInstance();

$username = $public_key ;
$password = $private_key ;

$client = Zend_Gdata_ClientLogin::getHttpClient($username, $password, 'cloudprint');

// Get token, add headers, set uri
$Client_Login_Token = $client->getClientLoginToken();
$client->setHeaders('Authorization','GoogleLogin auth='.$Client_Login_Token);
$client->setUri('http://www.google.com/cloudprint/interface/search');
        echo "<table  cellpadding='2' cellspacing='2' border='2 '>";
		echo ("<tr><td width='300'><b>PRINTER NAME:</b></td><td width='300'><b>PRINTER HASH:</b></td><td><b>STATUS:</b></td></tr>");
		echo "</table>";
$response = $client->request(Zend_Http_Client::POST);

$PrinterResponse = json_decode($response->getBody());
if (isset($PrinterResponse->printers)) {
    foreach ($PrinterResponse->printers as $printer) {
		echo "<table  cellpadding='2' cellspacing='2' border='1 '>";
		echo ("<tr><td width='300'>{$printer->name}</td><td width='300'>{$printer->id}</td><td>{$printer->connectionStatus}</td>");
		echo "</table>";
    }
} else {

}


?>