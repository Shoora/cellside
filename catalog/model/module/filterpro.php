<?php
class ModelModuleFilterPro extends Model {
	private $filterpro_setting;

	public function __construct($registry) {
		parent::__construct($registry);

		$this->filterpro_setting = $this->config->get('filterpro_setting');
		if(VERSION == '1.5.0') {
			$this->filterpro_setting = unserialize($this->config->get('filterpro_setting'));
		}
	}


	public function getAttributes($data) {

		$sql = "SELECT DISTINCT pa.text, a.`attribute_id`, ad.`name`, ag.attribute_group_id, agd.name as attribute_group_name FROM `" . DB_PREFIX . "product_attribute` pa" .
			   " LEFT JOIN " . DB_PREFIX . "attribute a ON(pa.attribute_id=a.`attribute_id`) " .
			   " LEFT JOIN " . DB_PREFIX . "attribute_description ad ON(a.attribute_id=ad.`attribute_id`) " .
			   " LEFT JOIN " . DB_PREFIX . "attribute_group ag ON(ag.attribute_group_id=a.`attribute_group_id`) " .
			   " LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON(agd.attribute_group_id=ag.`attribute_group_id`) " .
			   " LEFT JOIN " . DB_PREFIX . "product p ON(p.product_id=pa.`product_id`) ";
		if($data['category_id']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(p.product_id=p2c.product_id) ";
		}
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON(p.product_id=p2s.product_id) ";
		$sql .= " WHERE  p.status = '1' AND p.date_available <= NOW() AND p2s.store_id =" . (int)$this->config->get('config_store_id');
		if($data['category_id']) {
			$sql .= " AND p2c.category_id = '" . (int)$data['category_id'] . "'";
		}
		if($data['manufacturer_id']) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['manufacturer_id'] . "'";
		}

		$sql .= " AND pa.language_id = '" . (int)$this->config->get('config_language_id') . "'" .
				" AND ad.language_id = '" . (int)$this->config->get('config_language_id') . "'" .
				" AND agd.language_id = '" . (int)$this->config->get('config_language_id') . "'" .
				" ORDER BY ag.sort_order, agd.name, a.sort_order, ad.name, pa.text";

		$query = $this->db->query($sql);


		$attributes = array();
		foreach($query->rows as $row) {
			if(!isset($attributes[$row['attribute_group_id']])) {
				$attributes[$row['attribute_group_id']] = array(
					'name' => $row['attribute_group_name'],
					'attribute_values' => array()
				);
			}

			if(!isset($attributes[$row['attribute_group_id']]['attribute_values'][$row['attribute_id']])) {
				$attributes[$row['attribute_group_id']]['attribute_values'][$row['attribute_id']] = array('name' => $row['name'], 'values' => array());
			}

			$row['text'] = htmlspecialchars_decode($row['text'], ENT_COMPAT);
			foreach(explode($this->filterpro_setting['attr_delimeter'], $row['text']) as $text) {
				if(!in_array($text, $attributes[$row['attribute_group_id']]['attribute_values'][$row['attribute_id']]['values'])) {
					$attributes[$row['attribute_group_id']]['attribute_values'][$row['attribute_id']]['values'][] = htmlspecialchars($text, ENT_COMPAT);

				}
			}
		}

		foreach($attributes as $attribute_group_id => $attribute_group) {
			foreach($attribute_group['attribute_values'] as $attribute_id => $attribute) {
				sort($attributes[$attribute_group_id]['attribute_values'][$attribute_id]['values']);
			}
		}
		return $attributes;
	}

	public function getManufacturers($data) {
		if($data['manufacturer_id']) {
			return array();
		}
		$sql = "SELECT DISTINCT m.`manufacturer_id`, m.`name` FROM `" . DB_PREFIX . "manufacturer` m" .
			   " LEFT JOIN " . DB_PREFIX . "product p ON(p.manufacturer_id=m.`manufacturer_id`) ";
		if($data['category_id']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(p.product_id=p2c.product_id) ";
		}
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON(p.product_id=p2s.product_id) " .
				" WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		if($data['category_id']) {
			$sql .= " AND p2c.category_id = '" . (int)$data['category_id'] . "'";
		}
		$sql .= " ORDER BY m.sort_order, m.name";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getTags($data) {
		$sql = "SELECT CONCAT(p2t.`tag`, ' (', count(*), ')') as 'name', p2t.tag FROM `" . DB_PREFIX . "product_tag` p2t" .
			   " LEFT JOIN " . DB_PREFIX . "product p ON(p.product_id=p2t.`product_id`) ";
		if($data['category_id']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(p.product_id=p2c.product_id) ";
		}
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON(p.product_id=p2s.product_id) " .
				" WHERE p.status = '1' AND p2t.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.date_available <= NOW() AND p2s.store_id =" . (int)$this->config->get('config_store_id');
		if($data['category_id']) {
			$sql .= " AND p2c.category_id = '" . (int)$data['category_id'] . "'";
		}
		if($data['manufacturer_id']) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['manufacturer_id'] . "'";
		}
		$sql .= " GROUP BY p2t.`tag` ORDER BY p2t.`tag`";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getSubCategories($data) {
		$sql = "SELECT DISTINCT cd.category_id, CONCAT(cd.name, ' (', COUNT(*), ')' ) AS 'name' FROM `" . DB_PREFIX . "category` c" .
			   " LEFT JOIN " . DB_PREFIX . "category_description cd ON(cd.category_id=c.category_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(c.category_id=p2c.category_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product p ON(p.product_id=p2c.`product_id`) " .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON(p.product_id=p2s.product_id) " .
			   " WHERE c.status=1 AND c.parent_id = '" . (int)$data['category_id'] . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id =" . (int)$this->config->get('config_store_id');
		if($data['manufacturer_id']) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['manufacturer_id'] . "'";
		}

		$sql .= " GROUP BY cd.category_id ORDER BY `c`.`sort_order`, `cd`.`name`";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getOptions($data) {
		$sql_image = ", ov.image";
		if(version_compare("1513", VERSION)<0) {
			$sql_image = "";
		}
		$sql = "SELECT DISTINCT ovd.option_value_id, ovd.*, od.name as 'option_name'" . $sql_image . " FROM `" . DB_PREFIX . "option_value_description` ovd
    LEFT JOIN " . DB_PREFIX . "option_value ov ON(ovd.option_value_id=ov.option_value_id)
    LEFT JOIN " . DB_PREFIX . "option_description od ON(ov.option_id=od.option_id)
    LEFT JOIN `" . DB_PREFIX . "option` o ON(ov.option_id=o.option_id)
    LEFT JOIN " . DB_PREFIX . "product_option_value pov ON(ovd.`option_value_id`=pov.`option_value_id`)
    LEFT JOIN " . DB_PREFIX . "product p ON(pov.product_id = p.product_id) ";
		if($data['category_id']) {
			$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(p.product_id = p2c.product_id) ";
		}
		$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON(p.product_id=p2s.product_id)
	WHERE ovd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'  AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id =" . (int)$this->config->get('config_store_id');

		if($data['category_id']) {
			$sql .= " AND p2c.category_id = '" . (int)$data['category_id'] . "'";
		}
		if($data['manufacturer_id']) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['manufacturer_id'] . "'";
		}
		$sql .= " ORDER BY o.sort_order, ov.sort_order, ovd.option_id ";
		$query = $this->db->query($sql);
		$options = array();
		foreach($query->rows as $row) {
			if(!isset($options[$row['option_id']])) {
				$options[$row['option_id']] = array('option_id' => $row['option_id'],
													'name' => $row['option_name'],
													'option_values' => array());
			}

		if(version_compare("1513", VERSION)<0) {
			$row['image'] = "";
		}
			$options[$row['option_id']]['option_values'][] = array('option_value_id' => $row['option_value_id'], 'name' => $row['name'], 'image' => $row['image']);
		}
		return $options;
	}

	public function getPriceLimits($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT max(coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) ) AS max_price, min(coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) ) AS min_price FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)";
		if($data['category_id']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		}

		$sql .= " WHERE p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		if($data['category_id']) {
			$sql .= " AND p2c.category_id = '" . (int)$data['category_id'] . "'";
		}
		if($data['manufacturer_id']) {
			$sql .= " AND p.manufacturer_id = '" . (int)$data['manufacturer_id'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getTotalProducts($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT count(*) as total FROM " .
			   "(SELECT DISTINCT p.product_id, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   " p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		if($data['attribute_value'] || $data['attr_slider']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";
		}

		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";

				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}

		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	private function getCustomerGroup() {
		if($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
			return $customer_group_id;
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
			return $customer_group_id;
		}
	}

	public function getTotalManufacturers($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT count(*) as total, manufacturer_id FROM " .
			   "(SELECT DISTINCT p.product_id, m.manufacturer_id, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "manufacturer m ON(m.manufacturer_id=p.manufacturer_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";

		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";
				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}


		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}


		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		$sql .= " GROUP BY " . "manufacturer_id";
		$query = $this->db->query($sql);

		$result = array();
		foreach($query->rows as $row) {
			$result[] = array('id' => $row['manufacturer_id'], 't' => $row['total']);
		}
		return $result;
	}

	public function getTotalTags($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT CONCAT(`tag`, ' (', count(*), ')') as 'name', tag FROM " .
			   "(SELECT DISTINCT p.product_id, tag, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "manufacturer m ON(m.manufacturer_id=p.manufacturer_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}
		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";
				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND p2t.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		$sql .= " GROUP BY `tag` ORDER BY `tag`";
		$query = $this->db->query($sql);
		foreach($query->rows as $i => $row) {
			if($data['tags'] && in_array($row['tag'], $data['tags'])) {
				$query->rows[$i]['checked'] = "1";
			}
		}
		return $query->rows;
	}

	public function getTotalCategories($data, $category_id) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT CONCAT(`name`, ' (', count(*), ')') as 'name', `category_id` FROM " .
			   "(SELECT DISTINCT p.product_id, cd.name, cd.category_id, c.sort_order, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "manufacturer m ON(m.manufacturer_id=p.manufacturer_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)" .
			   " LEFT JOIN `" . DB_PREFIX . "category` c ON(p2c.category_id=c.category_id) " .
			   " LEFT JOIN " . DB_PREFIX . "category_description cd ON(cd.category_id=c.category_id) ";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";

		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";
				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND c.status=1 AND c.parent_id = '" . $category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		$sql .= " GROUP BY category_id ORDER BY sort_order, name";

		$query = $this->db->query($sql);
		foreach($query->rows as $i => $row) {
			if($data['categories'] && in_array($row['category_id'], $data['categories'])) {
				$query->rows[$i]['checked'] = "1";
			}
		}
		return $query->rows;
	}

	public function getTotalAttributes($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT count(*) as total, attribute_id, text  FROM " .
			   "(SELECT DISTINCT p.product_id, p2a.attribute_id, p2a.text, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "manufacturer m ON(m.manufacturer_id=p.manufacturer_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";

		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}

		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;
				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";
				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}


		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND p.status = '1' AND p.date_available <= NOW( ) AND p2a.language_id='" . (int)$this->config->get('config_language_id') . "' AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		$sql .= " GROUP BY " . "attribute_id, text";
		$query = $this->db->query($sql);

		$result = array();
		$attributes = array();
		foreach($query->rows as $row) {
			$row['text'] = htmlspecialchars_decode($row['text'], ENT_COMPAT);
			foreach(explode($this->filterpro_setting['attr_delimeter'], $row['text']) as $text) {
				if(!isset($attributes[$row['attribute_id'] . "." . $text])) {
					$attributes[$row['attribute_id'] . "." . $text] = array('id' => $row['attribute_id'], 'text' => $text, 't' => $row['total']);
				} else {
					$attributes[$row['attribute_id'] . "." . $text]['t'] += $row['total'];
				}
			}
		}

		foreach($attributes as $attribute) {
			$result[] = array('id' => $attribute['id'], 'text' => $attribute['text'], 't' => $attribute['t']);
		}
		return $result;
	}

	public function getTotalOptions($data) {

		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT count(*) as total, option_value_id FROM " .
			   "(SELECT DISTINCT p.product_id, pov.option_value_id, coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
			   "(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
			   "p.price) as realprice " .
			   " FROM " . DB_PREFIX . "product p" .
			   " LEFT JOIN " . DB_PREFIX . "manufacturer m ON(m.manufacturer_id=p.manufacturer_id) " .
			   " LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
			   " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";
		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}

		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
							" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
							" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
							" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
							" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
					$i++;
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)$min_price;
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');
		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice >=" . (int)$min_price;
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		$sql .= " GROUP BY " . "option_value_id";
		$query = $this->db->query($sql);

		$result = array();
		foreach($query->rows as $row) {
			$result[] = array('id' => $row['option_value_id'], 't' => $row['total']);
		}

		return $result;
	}

	public function getProducts($data) {
		$customer_group_id = $this->getCustomerGroup();

		$sql = "SELECT product_id FROM(";
		$sql .= "SELECT DISTINCT p.product_id, pd.name, p.model, p.quantity, p.price, p.sort_order, p.date_added ";
		if(isset($data["sort"]) && $data["sort"] == "rating") {
			$sql .= ", (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating ";
		}
		$sql .= ", coalesce((SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1), " .
				"(SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1), " .
				"p.price) as realprice ";
		$sql .= "FROM " . DB_PREFIX . "product p" .
				" LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (pov.product_id=p.product_id)" .
				" LEFT JOIN " . DB_PREFIX . "product_description pd ON (pd.product_id=p.product_id)" .
				" LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p2s.product_id=p.product_id)" .
				" LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p2c.product_id=p.product_id)";
		if($data['attribute_value'] || $data['attr_slider']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_attribute p2a ON (p2a.product_id=p.product_id)";
		}

		if($data['tags']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_tag p2t ON (p2t.product_id=p.product_id)";
		}

		if ($data['filter']) {
			$sql .= " LEFT JOIN " . DB_PREFIX . "product_filter pf ON (p2c.product_id = pf.product_id)";
		}

		$sql .= " WHERE 1";

		if($data['instock']) {
			$sql .= " AND p.quantity > 0 AND (pov.quantity is null OR pov.quantity > 0)";
		}

		if($data['categories']) {
			$sql .= " AND p2c.category_id IN (" . implode(",", $data['categories']) . ")";
		}

		$option_filters = array();
		if($data['option_value']) {
			foreach($data['option_value'] as $option_value) {
				$option_filters[] = "option_value_id IN(" . implode(",", $option_value) . ")";
			}
		}

		if($option_filters) {
			if($this->filterpro_setting['option_mode'] == 'and') {
				foreach($option_filters as $i => $option_filter) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_option_value pov" . $i .
							" WHERE pov" . $i . ".product_id=pov.product_id AND pov" . $i . "." . $option_filter . ($data['instock'] ? "AND pov" . $i . ".quantity > 0"
							: "") . ") ";
				}
			} else {
				$sql .= " AND (" . implode(" OR ", $option_filters) . ")";
			}
		}

		if($data['manufacturer']) {
			$sql .= " AND p.manufacturer_id IN(" . implode(", ", $data['manufacturer']) . ")";
		}

		if($data['tags']) {
			$sql .= " AND p2t.tag IN( '" . implode("', '", array_map(array($this->db, 'escape'), $data['tags'])) . "') AND p2t.language_id='" . (int)$this->config->get('config_language_id') . "' ";
		}

		$d = $this->filterpro_setting['attr_delimeter'];

		if($data['attribute_value']) {
			if($this->filterpro_setting['attribute_mode'] == 'and') {
				$i = 0;

				foreach($data['attribute_value'] as $attribute_id => $values) {
					if($this->filterpro_setting['attribute_value_mode'] == 'or') {
						$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
								" AND (p2a" . $i . ".text = '" . implode("' OR p2a" . $i . ".text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '" . implode($d . "%' OR p2a" . $i . ".text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
								" OR p2a" . $i . ".text like '%" . $d . implode("' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
								" OR p2a" . $i . ".text like '%" . $d . implode($d . "%' OR p2a" . $i . ".text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')) ";
						$i++;
					} else {
						foreach($values as $value) {
							$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id=p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id .
									" AND (p2a" . $i . ".text = '" . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '" . $this->db->escape($value) . $d . "%'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . "'" .
									" OR p2a" . $i . ".text like '%" . $d . $this->db->escape($value) . $d . "%')) ";
							$i++;
						}
					}
				}
			} else {
				foreach($data['attribute_value'] as $attribute_id => $values) {
					$attribute_filters[] = "p2a.attribute_id = " . (int)$attribute_id .
										   " AND (p2a.text = '" . implode("' OR p2a.text = '", array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '" . implode($d . "%' OR p2a.text like '", array_map(array($this->db, 'escape'), $values)) . $d . "%'" .
										   " OR p2a.text like '%" . $d . implode("' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . "'" .
										   " OR p2a.text like '%" . $d . implode($d . "%' OR p2a.text like '%" . $d, array_map(array($this->db, 'escape'), $values)) . $d . "%')";
				}
				$sql .= " AND (" . implode(" OR ", $attribute_filters) . ")";
			}
		}

		if($data['attr_slider']) {
			$i = 0;
			foreach($data['attr_slider'] as $attribute_id => $values) {
				if(!isset($values['min'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 <= " . $values['max'] . ")) ";
				} elseif(!isset($values['max'])) {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 >= " . $values['min'] . ")) ";

				} else {
					$sql .= " AND EXISTS (select 1 FROM " . DB_PREFIX . "product_attribute p2a" . $i . " WHERE p2a" . $i . ".product_id = p2a.product_id AND p2a" . $i . ".attribute_id = " . (int)$attribute_id . " AND " .
							"(p2a" . $i . ".text * 1 BETWEEN " . $values['min'] . " AND " . $values['max'] . ")) ";
				}
				$i++;
			}
		}

		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND p.price >=" . (int)($min_price);
		}

		if ($data['filter']) {
			$sql .= " AND pf.filter_id IN (" .implode(",", $data['filter']). ")";
		}

		$sql .= " AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW( ) AND p2s.store_id = " . (int)$this->config->get('config_store_id');

		$sort_data = array(
			'pd.name' => 'name',
			'p.model' => 'model',
			'p.quantity' => 'quantity',
			'p.price' => 'realprice',
			'p.sort_order' => 'sort_order',
			'p.date_added' => 'date_added',
			'rating' => 'rating'
		);

		$sql .= ") as innertable WHERE 1 ";
		if($data['min_price'] >= 0) {
			$min_price = $this->currency->convert((int)$data['min_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= "AND realprice >=" . (int)($min_price);
		}
		if($data['max_price'] > 0) {
			$max_price = $this->currency->convert($data['max_price'], $this->currency->getCode(), $this->config->get('config_currency'));
			$sql .= " AND realprice <=" . ($max_price);
		}

		if(isset($data['sort']) && array_key_exists($data['sort'], $sort_data)) {
			$data['sort'] = $sort_data[$data['sort']];
			if($data['sort'] == 'name' || $data['sort'] == 'model') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		} else {
			$sql .= " ORDER BY  sort_order";
		}
		if(isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(name) DESC";
		} else {
			$sql .= " ASC, LCASE(name) ASC";
		}


		if(isset($data['start']) || isset($data['limit'])) {
			if($data['start'] < 0) {
				$data['start'] = 0;
			}

			if($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);
//		var_dump($sql);
		$product_data = array();
		if($query->rows) {
			$this->load->model('catalog/product');
			foreach($query->rows as $result) {
				$product_data[$result['product_id']] = $this->model_catalog_product->getProduct($result['product_id']);
			}
		}
		return $product_data;
	}

	public function getTaxRates($tax_class_id) {
		$query = $this->db->query("SELECT tr1.rate, tr1.type FROM " . DB_PREFIX . "tax_rate tr1 LEFT JOIN " . DB_PREFIX . "tax_rule tr2 ON (tr1.tax_rate_id=tr2.tax_rate_id) " .
								  "WHERE tr2.tax_class_id=" . (int)$tax_class_id . " ORDER BY tr2.priority");
		return $query->rows;
	}

}
