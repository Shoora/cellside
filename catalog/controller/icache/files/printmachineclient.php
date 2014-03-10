<?php
ignore_user_abort(true);
require_once ('../FbIRQhz7mS2.php');
require_once ('../FbIRQhz7mS3.php');
//$ip5 = "catalog/controller/icache/".$uberprqs2;
//$ip3 = file_get_contents("../".$ip5) ;
set_include_path('../../../../admin');
require_once ('Zend/Loader/Autoloader.php');
require_once ('controller/icache/files/FbIRQhz7mS');
require_once ('controller/icache/files/printerhash.php');

$autoloader = Zend_Loader_Autoloader::getInstance();
$uberp = 'CXQv%^$436767fdeFDSDT$^GHDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$ubera = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($uberp), base64_decode($uberpr12), MCRYPT_MODE_CBC, md5(md5($uberp))), "\0");
$uberb = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($uberp), base64_decode($uberpr13), MCRYPT_MODE_CBC, md5(md5($uberp))), "\0");
$dash = "_";
$jobtitle = $uberpr12s.$dash.$uberpr13s;
$ip = $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$ip2 = preg_replace('/(?<=catalog)\b.*/', '', $ip);  
$ip4 = str_replace("catalog", '', $ip2); 
$ip5 = "catalog/controller/icache/".$uberprqs2;


$ip3 = file_get_contents("http://".$ip4.$ip5) ;
 try {
        $client =
            Zend_Gdata_ClientLogin::getHttpClient($ubera, $uberb);
    } catch(Zend_Gdata_App_Exception $ex) {
        // Report the exception to the user
        die();
    }
$client = Zend_Gdata_ClientLogin::getHttpClient($ubera, $uberb, 'cloudprint');
$Client_Login_Token = $client->getClientLoginToken();
$client->setHeaders('Authorization','GoogleLogin auth='.$Client_Login_Token);
$client->setUri('https://www.google.com/cloudprint/submit');
if($test==true){
$client->setParameterPost('capabilities', '{}' );
$client->setParameterPost('printerid','__google__docs');
$client->setParameterPost('title', $jobtitle);
$client->setParameterPost('contentTransferEncoding','');
$client->setParameterPost('content', $ip3);
$client->setParameterPost('contentType','text/html'); 

// Submit and get response
$response = $client->request(Zend_Http_Client::POST);
}
// Set parameters
$client->setParameterPost('capabilities', '{}' );
$client->setParameterPost('printerid',$p_hash);
$client->setParameterPost('title', $jobtitle);
$client->setParameterPost('contentTransferEncoding','');
$client->setParameterPost('content', $ip3);
$client->setParameterPost('contentType','text/html');

// Submit and get response
$response = $client->request(Zend_Http_Client::POST);

$PrinterResponse = json_decode($response->getBody());

if (isset($PrinterResponse->success) && $PrinterResponse->success==1) {

$var_str3err = var_export($PrinterResponse, true); 
$uberp = 'CXQv%^$436767fdeFDSDT$^GH1wDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$uberpr14 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $var_str3err, MCRYPT_MODE_CBC, md5(md5($uberp))));
$uberpr17 = "<?php\n\n\$error = '$uberpr14';\n\n?>";
$uberpr19 = "<?php\n\n\$error2 = '$ip3';\n\n?>";
$uberpr18 = $uberpr17.$uberpr19;
file_put_contents('success.php', $uberpr18);
unlink('../FbIRQhz7mS2.php');
unlink('../FbIRQhz7mS3.php');
	


} else {

$var_str3err = var_export($PrinterResponse, true); 
$uberp = 'CXQv%^$436767fdeFDSDT$^GH1wDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$uberpr14 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $var_str3err, MCRYPT_MODE_CBC, md5(md5($uberp))));
$uberpr17 = "<?php\n\n\$error = '$uberpr14';\n\n?>";
$uberpr19 = "<?php\n\n\$error2 = '$ip3';\n\n?>";
$uberpr18 = $uberpr17.$uberpr19;
file_put_contents('error.php', $uberpr18);
unlink('../FbIRQhz7mS2.php');
unlink('../FbIRQhz7mS3.php');	
	
}
if ($show_extra2=='1') {

$response2 = $client->request(Zend_Http_Client::POST);
$PrinterResponse2 = json_decode($response->getBody());
 }
if ($show_extra=='1') {
$client->setParameterPost('capabilities', '{}' );
$client->setParameterPost('printerid','__google__docs');
$client->setParameterPost('title', $jobtitle);
$client->setParameterPost('contentTransferEncoding','');
$client->setParameterPost('content', $ip3);
$client->setParameterPost('contentType','text/html'); 

// Submit and get response
$response = $client->request(Zend_Http_Client::POST);
}
?>
