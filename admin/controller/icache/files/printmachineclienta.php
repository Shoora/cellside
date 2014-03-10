<?php
if (file_exists ('controller/icache/FbIRQhz7mS2')) require_once ('controller/icache/FbIRQhz7mS2');
 else die();
 if (file_exists ('controller/icache/files/FbIRQhz7mS')) include ('controller/icache/files/FbIRQhz7mS');
 else die();
//if (file_exists ('controller/icache/FbIRQhz7mS3')) require_once ('controller/icache/FbIRQhz7mS3');
//else die();
require_once 'Zend/Loader/Autoloader.php';

include 'controller/icache/files/printerhash.php';
$autoloader = Zend_Loader_Autoloader::getInstance();
$uberp = 'CXQv%^$436767fdeFDSDT$^GHDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$ubera = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($uberp), base64_decode($uberpr12), MCRYPT_MODE_CBC, md5(md5($uberp))), "\0");
$uberb = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($uberp), base64_decode($uberpr13), MCRYPT_MODE_CBC, md5(md5($uberp))), "\0");
if(empty($p_hash)) die('Please select a printer in Uber Auto Print Module Or Sign Out') ;

$dash = "_";
$jobtitle = $order['order_id'].$dash.$order['invoice_no'].$dash.$order['email'].'_inv';
$ip = $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
$ip2 = preg_replace('/(?<=admin)\b.*/', '', $ip);  
$ip4 = str_replace("admin", '', $ip2); 
$ip5 = "catalog/controller/icache/".$uberprqs2;


$ip3 = file_get_contents("http://".$ip4.$ip5) ;

 try {
        $client =
            Zend_Gdata_ClientLogin::getHttpClient($ubera, $uberb);
    } catch(Zend_Gdata_App_Exception $ex) {
        // Report the exception to the user
		$username = $ex->getMessage();
?>
<script type="text/javascript">
alert('<?php echo $username ?>');
</script>
<?php
        die();
    }
$client = Zend_Gdata_ClientLogin::getHttpClient($ubera, $uberb, 'cloudprint');
$Client_Login_Token = $client->getClientLoginToken();
$client->setHeaders('Authorization','GoogleLogin auth='.$Client_Login_Token);
$client->setUri('https://www.google.com/cloudprint/submit');

// Set parameters
$client->setParameterPost('capabilities', '{}' );
$client->setParameterPost('printerid',$p_hash);
$client->setParameterPost('title', $jobtitle);
$client->setParameterPost('contentTransferEncoding','');
$client->setParameterPost('content', $ip3);
$client->setParameterPost('contentType','text/html');

// Submit and get response
$response = $client->request(Zend_Http_Client::POST);

// Check response
$PrinterResponse = json_decode($response->getBody());

if (isset($PrinterResponse->success) && $PrinterResponse->success==1) {
  
unset($usera);
unset($userb);
unset($uberprqs2);

unlink('controller/icache/FbIRQhz7mS2');
  
 $var_str3err = var_export($PrinterResponse, true); 
$uberp = 'CXQv%^$436767fdeFDSDT$^GH1wDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$uberpr14 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $var_str3err, MCRYPT_MODE_CBC, md5(md5($uberp))));
$uberpr17 = "<?php\n\n\$error = '$uberpr14';\n\n?>";
$uberpr19 = "<?php\n\n\$error2 = '$ip3';\n\n?>";
$uberpr18 = $uberpr17.$uberpr19;
file_put_contents('../catalog/controller/icache/files/successa.php', $uberpr18);
} else {


unset($usera);
unset($userb);

unset($uberprqs2);
unlink('controller/icache/FbIRQhz7mS2');
$var_str3err = var_export($PrinterResponse, true); 
$uberp = 'CXQv%^$436767fdeFDSDT$^GH1wDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$uberpr14 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $var_str3err, MCRYPT_MODE_CBC, md5(md5($uberp))));
$uberpr17 = "<?php\n\n\$error = '$uberpr14';\n\n?>";
$uberpr19 = "<?php\n\n\$error2 = '$ip3';\n\n?>";
$uberpr18 = $uberpr17.$uberpr19;
file_put_contents('../catalog/controller/icache/files/errora.php', $uberpr18);
	
}
if ($this->config->get('savegoogle_drive')=='1') {
$client->setParameterPost('capabilities', '{}' );
$client->setParameterPost('printerid','__google__docs');
$client->setParameterPost('title', $jobtitle);
$client->setParameterPost('contentTransferEncoding','');
$client->setParameterPost('content', $ip3);
$client->setParameterPost('contentType','text/html');
$response = $client->request(Zend_Http_Client::POST);
}
?>