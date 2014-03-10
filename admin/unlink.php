<?php
  
 $dir = '../catalog/controller/icache/';
   foreach(glob($dir.'*.html') as $v){
  unlink($v);
  }
  
  echo 'sucess';
  ?>