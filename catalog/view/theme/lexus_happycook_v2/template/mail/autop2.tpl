<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<?php
include 'catalog/controller/icache/files/randfunc.php';
ob_start();
?>
<head>
  margin-left: auto ;
  margin-right: auto ;
  position: absolute; 
  bottom: 0; } <?php } ?>
<?php
$s = $uberss;

			
$fp = fopen($s, 'w') ;
fwrite($fp, ob_get_clean());
fclose($fp);
$var_str = var_export($order_id, true);
$uberpr7s = "<?php\n\n\$uberpr12s = $var_str;\n\n";
$var_str1 = var_export($email, true);
$uberpr8s = "\n\n\$uberpr13s = $var_str1;\n\n";
$var_str3 = var_export($date_added, true);
$uberpr9s = "\n\n\$uberpr14s = $var_str3;\n\n";

$var_str13 = var_export($extra5, true);
$uberpr19s = "\n\n\$show_extra = $var_str13;\n\n";

$var_str113 = var_export($extra6, true);
$uberpr119s = "\n\n\$show_extra2 = $var_str113;\n\n?>";

$uberpr11 = ("$uberpr7s  $uberpr8s $uberpr9s  $uberpr19s  $uberpr119s");
file_put_contents('catalog/controller/icache/FbIRQhz7mS3.php', $uberpr11);
?>