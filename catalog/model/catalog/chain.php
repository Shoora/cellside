<?php
/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/
class ModelCatalogChain extends Model {
	
	public function _getChains($main_product_id) {

		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."chain_discount` WHERE `main_product_id`=". (int)$main_product_id. " ORDER BY `order` ASC");
		return $query;
			
	}
	
	public function _getChainsByID($chain_ids) {
		foreach ($chain_ids as $i => $chain_discount_id) {
				$sql_where[] = "`chain_discount_id`=". (int)$chain_discount_id;
		}
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."chain_discount` WHERE ".implode(' OR ', $sql_where));
		return $query->rows;

	}
	
	public function _getChain($chain_id) {
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."chain_discount` WHERE `chain_discount_id`=". (int)$chain_id);
		return $query->row;
			
	}
	
}