<?php

class ModelModuleBulkProductToCategory extends Model {
	function getCategories($parent_id = 0, $level = 0) {
		$categories = array();
		$result = $this->db->query(
			"SELECT cd.category_id, cd.name FROM `" . DB_PREFIX . "category_description` cd LEFT JOIN `" . DB_PREFIX . "category` c ON c.category_id = cd.category_id WHERE c.parent_id = " . (int) $parent_id . " AND cd.language_id = " . $this->config->get('config_language_id') . " ORDER BY c.sort_order, cd.name"
		);

		if($result->rows) {
			foreach($result->rows as $row) {
				$categories[$row['category_id']] = array(
					'name' => str_repeat('-', $level * 3) . ' ' . $row['name'],
					'category_id' => $row['category_id']
				);
				$subcats = $this->getCategories($row['category_id'], $level + 1);
				if(!empty($subcats)) {
					foreach($subcats as $subcat) {
						$categories[$subcat['category_id']] = $subcat;
					}
				}
			}
		}

		return $categories;
	}

	function getProducts() {
		$result = $this->db->query(
			"SELECT pd.name, pd.product_id, LOWER(pd.name) AS lower_name, p.image, p.manufacturer_id FROM `" . DB_PREFIX . "product_description` pd LEFT JOIN " . DB_PREFIX . "product p ON p.product_id = pd.product_id WHERE pd.language_id = " . $this->config->get('config_language_id') . " ORDER BY lower_name"
		);

		return $result->rows;
	}
	
	function getProductCategories() {
		$result = $this->db->query("SELECT product_id, CONCAT('|', GROUP_CONCAT(category_id SEPARATOR '||'), '|') AS categories FROM `" . DB_PREFIX . "product_to_category` GROUP BY product_id ORDER BY product_id ASC");
		
		$tmp = array();
		foreach($result->rows as $row) {
			$tmp[$row['product_id']] = $row['categories'];
		}
		
		return $tmp;
	}

	function getProductsByCategory($category_id) {
		$result = $this->db->query(
			"SELECT p2c.product_id FROM " . DB_PREFIX . "product_to_category p2c WHERE p2c.category_id = " . (int) $category_id
		);
		return $result->rows;
	}

	function saveProductsToCategory($category_id, $products) {
		$prods = array();
		foreach($products as $product) {
			$product = (int) $product;
			if($product) $prods[] = '(' . $product . ', ' . (int) $category_id .')';
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE category_id = " . (int) $category_id);

		if(!empty($prods)) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category (product_id, category_id) VALUES " . implode(', ', $prods));
		}

	}
}