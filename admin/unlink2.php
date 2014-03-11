<?php
  
unlink ('controller/icache/files/FbIRQhz7mS');
unlink ('controller/icache/files/printerhash.php');
sleep(1);
$hash = "<?php \n\n \n\n ?>";
file_put_contents('controller/icache/files/printerhash.php', $hash);
 ?>