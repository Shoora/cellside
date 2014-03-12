<?php

			$s = $uberss;

			
$fp = fopen($s, 'w') ;
fwrite($fp, ob_get_contents());
fclose($fp);

?>