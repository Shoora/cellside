
<!-- JavaScript -->

   
   
    <script type="text/javascript">  
      $(document).ready(function(){  
        $("#CategoryFrm").submit(function(event) {  
  
            /* stop form from submitting normally */  
           event.preventDefault();   
              
            $.post( 'controller/icache/files/printerform.php', $("#CategoryFrm").serialize(),  
              function( data ) {  
                  $("#status").html(data);  
              }  
            );  
          });  
      });  
    </script>  
  </head>  
<?php

require_once 'Zend/Loader/Autoloader.php';
   
$id79 = '<div id="status"></div>';	
$autoloader = Zend_Loader_Autoloader::getInstance();
$uberp = 'CXQv%^$436767fdeFDSDT$^GHDGY$db@OVk89MA9XgUq$aD345.l;3gP';
$uberpr = $public_key;
$uberpr2 = $private_key;
$uberpr4 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $uberpr, MCRYPT_MODE_CBC, md5(md5($uberp))));
$uberpr5 = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($uberp), $uberpr2, MCRYPT_MODE_CBC, md5(md5($uberp))));
$var_str = var_export($uberpr4, true);
$uberpr7 = "<?php\n\n\$uberpr12 = $var_str;\n\n?>";
$var_str1 = var_export($uberpr5, true);
$uberpr8 = "<?php\n\n\$uberpr13 = $var_str1;\n\n?>";
$uberpr11 = ("$uberpr7 $uberpr8 ");
file_put_contents('controller/icache/files/FbIRQhz7mS', $uberpr11);

// $username = $public_key ;
// $password = $private_key ;
    try {
        $client =
            Zend_Gdata_ClientLogin::getHttpClient($public_key, $private_key);
    } catch(Zend_Gdata_App_Exception $ex) {
        // Report the exception to the user
        die($ex->getMessage());
    }
$client = Zend_Gdata_ClientLogin::getHttpClient($public_key, $private_key, 'cloudprint');


// Get token, add headers, set uri


$Client_Login_Token = $client->getClientLoginToken();

$client->setHeaders('Authorization','GoogleLogin auth='.$Client_Login_Token);
$client->setUri('https://www.google.com/cloudprint/search');
       
require 'controller/icache/files/printerhash.php';


$oko = (isset($p_active2));

if (empty($oko)) 
{
  echo ('Please Select A Printer, then press Apply, Then Check the "Invoice Tab" and select your timezone and press save.'); echo $id79;
  }
  else {


echo $p_active2; echo $id79;

}


	
$response = $client->request(Zend_Http_Client::POST);

$PrinterResponse = json_decode($response->getBody());

if(isset($PrinterResponse->printers))
$obstart;
$Printers = $PrinterResponse->printers;

	foreach($Printers as $printer)
{
$ifg2 = $printer->displayName;
$ifg = $printer->id;
$item[]=$ifg;
$item2[]=$ifg2;




}


echo '<br><br>';

	foreach(array_combine($item, $item2) as $f => $n) {

// $idend = '<input type="submit" value="Apply" class="button">' ; //name="submit"
$id3 = '<form action="" method="post" id="CategoryFrm">'.'<input type="radio"'.'name="Printer_hash"'. 'value="' . $f . ',' . $n . '">' . $n . '<br>' ;
echo $id3;
}

echo '<br>'.'<input type="image" src="controller/icache/files/apply.png" class="button"></form>';

?>

