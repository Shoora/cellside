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

// Session
$session = new Session();
$registry->set('session', $session);  

echo '<html>
<body>
<FORM><INPUT TYPE="BUTTON" VALUE="Go Back" 
ONCLICK="history.go(-1)"></FORM>
';

// Database 
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

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
			else {$parameters['tags'] = '%c%p';}

		$db->query("update " . DB_PREFIX . "product_description set tag = lower( tag );");
		$query = $db->query("select pd.name as pname, pd.tag, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand from " . DB_PREFIX . "product_description pd
				inner join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
				inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
				inner join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
				left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id;");
		$new = 0;
		foreach ($query->rows as $product) {
			$newp = 0; $newtags ='';
			echo 'Generating tags for <b>'.$product['pname'].' (from '.$product['cname'].')</b>: ';
			
			$included = explode('%', str_replace(array(' ',','), '', $parameters['tags']));
			
			$tags = array();
			
			
			$bef = array("%", "_","\"","'","\\",",");
			$aft = array("", " ", " ", " ", "", "");
			
			if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['pname']))))));}
			if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['cname']))))));}
			if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['sku']))))));}
			if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['model']))))));}
			if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['upc']))))));}
			if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(htmlspecialchars_decode(str_replace($bef, $aft,$product['brand']))))));}
			
			foreach ($tags as $tag)
				{
				if (strlen($tag) > 2) 
					{
					if ((strpos($product['tag'], strtolower($tag)) === false) && (strpos($newtags, strtolower($tag)) === false))
						{
							$newtags .= ' '.strtolower($tag).',';
							$new++; $newp++;
						}			
					}
				}
			
			echo trim($newtags,' ,');
			
			if ($product['tag']) {
				$newtags = trim($product['tag'] . $newtags,' ,');
				$db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
				}
				else {
				$newtags = trim($newtags,' ,');
				$db->query("update " . DB_PREFIX . "product_description set tag = '$newtags' where product_id = '". $product['product_id'] ."' and language_id = '". $product['language_id'] ."';");
				}
			echo " - $newp tags were inserted;<br>";
			}

		echo "<br>A total of $new new tags were inserted.";
		$db->query("update " . DB_PREFIX . "product_description set tag = lower( tag );");
	}
?>

</body>
</html>


