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
			else {$parameters['keywords'] = '%c%p';}

		$query = $db->query("select pd.name as pname, cd.name as cname, pd.language_id as language_id, pd.product_id as product_id, p.sku as sku, p.model as model, p.upc as upc, m.name as brand  from " . DB_PREFIX . "product_description pd
				left join " . DB_PREFIX . "product_to_category pc on pd.product_id = pc.product_id
				inner join " . DB_PREFIX . "product p on pd.product_id = p.product_id
				left join " . DB_PREFIX . "category_description cd on cd.category_id = pc.category_id and cd.language_id = pd.language_id
				left join " . DB_PREFIX . "manufacturer m on m.manufacturer_id = p.manufacturer_id;");

		foreach ($query->rows as $product) {
			echo 'Generating keywords for <b>'.$product['pname'].' (from '.$product['cname'].')</b>: ';
			
			$bef = array("%", "_","\"","'","\\");
			$aft = array("", " ", " ", " ", "");
			
			$included = explode('%', str_replace(array(' ',','), '', $parameters['keywords']));
			
			$tags = array();
			
			if (in_array("p", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['pname']), ENT_COMPAT, "UTF-8")))));}
			if (in_array("c", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['cname']), ENT_COMPAT, "UTF-8")))));}
			if (in_array("s", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['sku']), ENT_COMPAT, "UTF-8")))));}
			if (in_array("m", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['model']), ENT_COMPAT, "UTF-8")))));}
			if (in_array("u", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['upc']), ENT_COMPAT, "UTF-8")))));}
			if (in_array("b", $included)) {$tags = array_merge($tags, explode(' ',trim(mysql_real_escape_string(html_entity_decode(str_replace($bef, $aft,$product['brand']), ENT_COMPAT, "UTF-8")))));}
			
			$keywords = '';
			
			foreach ($tags as $tag)
				{
				if (strlen($tag) > 2) 
					{
					
					$keywords = $keywords.' '.strtolower($tag);
					
					}
				}
				
			
			$exists = $db->query("select count(*) as times from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id']." and meta_keyword like '%". htmlspecialchars($keywords) ."%';");
			
					foreach ($exists->rows as $exist)
						{
						$count = $exist['times'];
						}
			$exists = $db->query("select length(meta_keyword) as leng from " . DB_PREFIX . "product_description where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");
			
					foreach ($exists->rows as $exist)
						{
						$leng = $exist['leng'];
						}

			if (($count == 0) && ($leng < 255)) {$db->query("update " . DB_PREFIX . "product_description set meta_keyword = concat(meta_keyword, '". htmlspecialchars($keywords) ."') where product_id = ".$product['product_id']." and language_id = ".$product['language_id'].";");}			
			
			echo " - ".((($count) || ($leng == 255))?"No new keywords ":"<span style=\"color:red;\">>$keywords</span> ")." were inserted;<br>";
			}
	}
	
?>

</body>
</html>


