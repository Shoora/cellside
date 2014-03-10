<?php

// Config
require_once('config.php');

// Install 
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Application Classes
require_once(DIR_SYSTEM . 'library/customer.php');
require_once(DIR_SYSTEM . 'library/affiliate.php');
require_once(DIR_SYSTEM . 'library/currency.php');
require_once(DIR_SYSTEM . 'library/tax.php');
require_once(DIR_SYSTEM . 'library/weight.php');
require_once(DIR_SYSTEM . 'library/length.php');
require_once(DIR_SYSTEM . 'library/cart.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);   

// Database 
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// Session
$session = new Session();
$registry->set('session', $session);  

echo '<html>
<body>
<FORM><INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)"></FORM>';

if ((!isset($_GET['token'])) || ($_GET['token'] != $session->data['token'])) 	{

		header('Location: ' . HTTP_SERVER);
	}
	else {

		$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = 'seopack'");

		foreach ($query->rows as $result) {
					if (!$result['serialized']) {
						$data[$result['key']] = $result['value'];
					} else {
						$data[$result['key']] = unserialize($result['value']);
					}
				}
				
		if (isset($data)) {$parameters = $data['parameters'];}
			else {$parameters['ctitles'] = '';}
			
		if (!isset($parameters['ctitles'])) {$parameters['ctitles'] = '';}

		$query = $db->query("select pd.name as pname, p.price as price, cd.name as cname, pd.description as pdescription, pd.language_id as language_id, pd.product_id as product_id, p.model as model, p.sku as sku, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
				left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
				inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
				left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
				left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id;");

		foreach ($query->rows as $product) {
			echo 'Generating Custom Titles for <b>'.$product['pname'].' (from '.$product['cname'].')</b>: ';
			
			$bef = array("%", "_","\"","'","\\", "\r", "\n");
			$aft = array("", " ", " ", " ", "", "", "");
			
			$ncategory = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['cname']), ENT_COMPAT, "UTF-8")));
			$nproduct = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['pname']), ENT_COMPAT, "UTF-8")));
			$model = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['model']), ENT_COMPAT, "UTF-8")));
			$sku = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['sku']), ENT_COMPAT, "UTF-8")));
			$upc = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['upc']), ENT_COMPAT, "UTF-8")));
			$brand = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['brand']), ENT_COMPAT, "UTF-8")));
			$price = trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft, number_format($product['price'], 2)), ENT_COMPAT, "UTF-8")));
			
			$bef = array("%c", "%p", "%m", "%s", "%u", "%b", "%$");
			$aft = array($ncategory, $nproduct, $model, $sku, $upc, $brand, $price);
			
			$ctitles = str_replace($bef, $aft,  $parameters['ctitles']);
			$db->query("update " . DB_PREFIX . "product_description set custom_title = '". htmlspecialchars($ctitles) ."' where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");			
			
			echo " - ".( (!$parameters['ctitles']) ?" No ":"<span style=\"color:red;\">$ctitles</span> ")." custom title was set;<br>";
			}
	}
	
?>

</body>
</html>


