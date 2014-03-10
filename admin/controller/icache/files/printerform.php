<?php

 
 $oko = (isset($_POST["Printer_hash"]));


if (empty($oko)) 
{
 
  }
  else {
$radio = explode(',',$_POST["Printer_hash"]);  
$radio1 = $radio[0]; // printer hash
$radio2 = $radio[1]; // printer name 
$active = ("<font size='3px'><img src='controller/icache/files/printersave.png' border=0> <font color=\"green\"><em><b>$radio[1] </font></em></b> </font><font size='2px'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;will be saved, Thank You.");
$acitve2 = ("<font size='3px'><img src='controller/icache/files/printersave.png' border=0> <font color=\"blue\"><em><b>$radio[1] </font></font><font size='2px'></em></u> </b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;is currently saved.");

$man1 = var_export($radio1, true);
$man2 = var_export($active, true);
$man3 = var_export($acitve2, true);
$fuckyeah1 = "<?php\n\n\$p_active = $man2;\n\n";
$fuckyeah4 = "\n\n\$p_active2 = $man3;\n\n";
$fuckyeah2 = "\n\n\$p_hash = $man1;\n\n?>";
$fuckyeah3 = $fuckyeah1 . $fuckyeah4. $fuckyeah2 ;
file_put_contents('printerhash.php', $fuckyeah3);
}

require 'printerhash.php';

$oko = (isset($p_active));

if (empty($oko)) 
{
  echo ('Please Select A Printer, then press Apply, Then Check the "Invoice Tab" and select your timezone and press save.');
  }
  else {


echo $p_active;

}

?>

