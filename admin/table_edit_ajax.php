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



if($_POST['id'])
{
$id=mysql_escape_String($_POST['id']);
$keyword = $db->escape($_POST['keyword']);
$meta_keyword = $db->escape($_POST['meta_keyword']);
$meta_description = $db->escape($_POST['meta_description']);
$tags = $db->escape($_POST['tags']);
$language_id = $db->escape($_POST['lang']);

if (strpos('x'.$id, 'Product') != false)
	{
	$id = str_replace('Product','',$id);
	$id = (int)$id;
	
	$query = $db->query("delete from " . DB_PREFIX . "url_alias where query = 'product_id=$id';");
	$query = $db->query("insert into " . DB_PREFIX . "url_alias(query, keyword) values('product_id=$id','$keyword');");
	
	$query = $db->query("update " . DB_PREFIX . "product_description set meta_keyword = '$meta_keyword' where product_id = $id and language_id = $language_id;");
	$query = $db->query("update " . DB_PREFIX . "product_description set meta_description = '$meta_description' where product_id = $id and language_id = $language_id;");
	
	$query = $db->query("delete from " . DB_PREFIX . "product_tag where product_id = $id and language_id = $language_id;");
		$tagz = explode(',', $tags);
				
				foreach ($tagz as $tag) {
					$query = $db->query("INSERT INTO " . DB_PREFIX . "product_tag SET product_id = $id, language_id = $language_id, tag = '" . $db->escape(trim($tag)) . "'");
				}
	
	
	}

if (strpos('x'.$id, 'Category') != false)
	{
	$id = str_replace('Category','',$id);
	$id = (int)$id;
	
	$query = $db->query("delete from " . DB_PREFIX . "url_alias where query = 'category_id=$id';");
	$query = $db->query("insert into " . DB_PREFIX . "url_alias(query, keyword) values('category_id=$id','$keyword');");
	
	$query = $db->query("update " . DB_PREFIX . "category_description set meta_keyword = '$meta_keyword' where category_id = $id and language_id = $language_id;");
	$query = $db->query("update " . DB_PREFIX . "category_description set meta_description = '$meta_description' where category_id = $id and language_id = $language_id;");
		
	}
	
if (strpos('x'.$id, 'Information') != false)
	{
	$id = str_replace('Information','',$id);
	$id = (int)$id;
	
	$query = $db->query("delete from " . DB_PREFIX . "url_alias where query = 'information_id=$id';");
	$query = $db->query("insert into " . DB_PREFIX . "url_alias(query, keyword) values('information_id=$id','$keyword');");
			
	}
	
if (strpos('x'.$id, 'Manufacturer') != false)
	{
	$id = str_replace('Manufacturer','',$id);
	$id = (int)$id;
	
	$query = $db->query("delete from " . DB_PREFIX . "url_alias where query = 'manufacturer_id=$id';");
	$query = $db->query("insert into " . DB_PREFIX . "url_alias(query, keyword) values('manufacturer_id=$id','$keyword');");
			
	}
	

	
}
?>







