<?php

$time_start = microtime(true);
define('VERSION', '1.5.2.1');               // Version
require_once('config.php');                 // Configuration
if (!defined('DIR_APPLICATION')) { exit; }  // Install 
require_once(DIR_SYSTEM . 'startup.php');

$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);  // Database
$config = new Config();                     // Config

$entries = 0;
$stores = getStores($db);
foreach ($stores as $store) {
	$categories = getCategoryIDS($db, $store);
	$product_total = 0;
	foreach ($categories as $category) {
		$product_total = getTotalProducts($db, array('filter_category_id'  => $category['category_id'], 'filter_sub_category' => true), $store);
		$db->query("UPDATE ".DB_PREFIX."category_to_store SET product_count = '" . $product_total . "' WHERE category_id = '" . $category['category_id'] . "' AND store_id = '" . $store . "'");
		$entries++;
	}
}
$time_end = microtime(true);
$time = $time_end - $time_start;

$result =  'Last Run: ' . date("Y-m-d H:i:s") . ' - Processed ' . $entries . ' entries in ' . $time  . ' seconds.';
$db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $result . "' WHERE `key` = 'config_ipscron_status'");
echo $result;



function getStores($db) {
	$stores = array();
	
	$query = $db->query("SELECT * FROM " . DB_PREFIX . "store");
	$store_data = $query->rows;
	$stores[] = 0;
	foreach ($query->row as $s) {
		$stores[] = $s['store_id'];
	}
	return $stores;
}

function getCategoryIDS($db, $store) {
	$query = $db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c2s.store_id = '" . (int)$store ."' AND status = '1'");
	return $query->rows;
}

function getCategoriesByParentId($db,$category_id, $store) {
	$category_data = array();
	$category_query = $db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c2s.store_id = '" . (int)$store . "' AND status = '1' AND parent_id = '" . (int)$category_id . "'");
	
	foreach ($category_query->rows as $category) {
		$category_data[] = $category['category_id'];
		$children = getCategoriesByParentId($db, $category['category_id'], $store);
		if ($children) { $category_data = array_merge($children, $category_data); }
	}
	return $category_data;
}


function getTotalProducts($db, $data = array(), $store) {
	$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)";

	if (!empty($data['filter_category_id'])) {
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";			
	}
	
	$sql .= " WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . $store . "'";

	
	if (!empty($data['filter_category_id'])) {
		if (!empty($data['filter_sub_category'])) {
			$implode_data = array();
			$implode_data[] = "p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
			
			$categories = getCategoriesByParentId($db, $data['filter_category_id'], $store);
				
			foreach ($categories as $category_id) {
				$implode_data[] = "p2c.category_id = '" . (int)$category_id . "'";
			}
						
			$sql .= " AND (" . implode(' OR ', $implode_data) . ")";			
		} else {
			$sql .= " AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";
		}
	}		
			
	$query = $db->query($sql);
	
	return $query->row['total'];
}

?>