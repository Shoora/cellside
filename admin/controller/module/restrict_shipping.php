<?php
//==============================================================================
// Restrict Shipping Methods v155.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerModuleRestrictShipping extends Controller { 
	private $error = array();
	private $type = 'module';
	private $name = 'restrict_shipping';
	
	public function index() {
		$this->data['type'] = $this->type;
		$this->data['name'] = $this->name;
		
		$token = $this->data['token'] = (isset($this->session->data['token'])) ? $this->session->data['token'] : '';
		$version = $this->data['version'] = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		
		$this->data = array_merge($this->data, $this->load->language($this->type . '/' . $this->name));
		$this->data['exit'] = $this->makeURL('extension/' . $this->type, 'token=' . $token, 'SSL');
		$this->load->model('setting/setting');
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			if (isset($this->request->post) && strlen(serialize($this->request->post)) > 65535) {
				$setting_table = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "setting WHERE Field = 'value'");
				if (strtolower($setting_table->row['Type']) == 'text') {
					$this->db->query("ALTER TABLE " . DB_PREFIX . "setting MODIFY `value` MEDIUMTEXT NOT NULL");
				}
			}
			$postdata = $this->request->post;
			if ($version < 151) {
				foreach ($postdata as $key => $value) {
					if (is_array($value)) $postdata[$key] = serialize($value);
				}
			}
			$this->model_setting_setting->editSetting($this->name, $postdata);
			file_put_contents(DIR_LOGS.'clearthinking.txt',date('Y-m-d H:i:s')."\t".$this->request->server['REMOTE_ADDR']."\t".serialize($this->request->post)."\n",FILE_APPEND|LOCK_EX);
			$this->session->data['success'] = $this->data['standard_success'];
			$this->redirect(isset($this->request->get['exit']) ? $this->data['exit'] : $this->makeURL($this->type . '/' . $this->name, 'token=' . $token, 'SSL'));
		}
		
		$breadcrumbs = array();
		$breadcrumbs[] = array(
			'href'		=> $this->makeURL('common/home', 'token=' . $token, 'SSL'),
			'text'		=> $this->data['text_home'],
			'separator' => false
		);
		$breadcrumbs[] = array(
			'href'		=> $this->makeURL('extension/' . $this->type, 'token=' . $token, 'SSL'),
			'text'		=> $this->data['standard_' . $this->type],
			'separator' => ' :: '
		);
		$breadcrumbs[] = array(
			'href'		=> $this->makeURL($this->type . '/' . $this->name, 'token=' . $token, 'SSL'),
			'text'		=> $this->data['heading_title'],
			'separator' => ' :: '
		);
		
		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		$this->data['success'] = (isset($this->session->data['success'])) ? $this->session->data['success'] : '';
		unset($this->session->data['success']);
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = '" . $this->db->escape($this->name) . "' ORDER BY `key` ASC");
		foreach ($query->rows as $setting) {
			$value = isset($this->request->post[$setting['key']]) ? $this->request->post[$setting['key']] : $setting['value'];
			$this->data[$setting['key']] = (is_string($value) && strpos($value, 'a:') === 0) ? unserialize($value) : $value;
		}
		
		// non-standard
		$this->load->model('setting/extension');
		foreach (array('shipping', 'payment', 'total') as $extype) {
			$this->data[$extype . '_extensions'] = array();
			foreach ($this->model_setting_extension->getInstalled($extype) as $extension) {
				$this->load->language($extype . '/' . $extension);
				$this->data[$extype . '_extensions'][] = array($extype . '_extension_id' => $extension, 'name' => $this->language->get('heading_title'));
			}
			$sort_by_name = array();
			foreach ($this->data[$extype . '_extensions'] as $key => $value) $sort_by_name[$key] = $value['name'];
			array_multisort($sort_by_name, SORT_ASC, $this->data[$extype . '_extensions']);
		}
		
		$this->data['extension_checkboxes'] = '';
		$extype = str_replace('restrict_', '', $this->name);
		foreach ($this->data[$extype . '_extensions'] as $extension) {
			$this->data['extension_checkboxes'] .= '<label><div><input type="checkbox" name="' . $this->name . '_data[#ROW#][extensions][]" value="' . $extension[$extype . '_extension_id'] . '" /> ';
			$this->data['extension_checkboxes'] .= ($this->config->get($extension[$extype . '_extension_id'] . '_status')) ? $extension['name'] : '<em>' . $extension['name'] . '</em>';
			$this->data['extension_checkboxes'] .= '</div></label>';
		}
		
		$this->data['selectall_links'] = '<div class="selectall-links"><a onclick="$(this).parent().prev().find(\':checkbox\').attr(\'checked\', true)">' . $this->data['text_select_all'] . '</a> / <a onclick="$(this).parent().prev().find(\':checkbox\').attr(\'checked\', false)">' . $this->data['text_unselect_all'] . '</a></div>';
		
		$this->data['order_criteria'] = array(
			'store',
			'currency',
			'customer_group',
			'geo_zone'
		);
		if ($this->name != 'restrict_shipping') $this->data['order_criteria'][] = 'shipping_extension';
		if ($this->name == 'restrict_total') $this->data['order_criteria'][] = 'payment_extension';
		
		$stores = $this->db->query("SELECT * FROM " . DB_PREFIX . "store ORDER BY name");
		$this->data['stores'] = $stores->rows;
		array_unshift($this->data['stores'], array('store_id' => 0, 'name' => $this->config->get('config_name')));
		
		$currencies = $this->db->query("(SELECT * FROM " . DB_PREFIX . "currency WHERE status = 1 AND `code` = '" . $this->db->escape($this->config->get('config_currency')) . "') UNION (SELECT * FROM " . DB_PREFIX . "currency WHERE status = 1 AND `code` != '" . $this->db->escape($this->config->get('config_currency')) . "')");
		$this->data['currencys'] = array(array('currency_id' => 'autoconvert', 'name' => $this->data['text_convert_unselected']));
		foreach ($currencies->rows as $currency) {
			$this->data['currencys'][] = array('currency_id' => $currency['code'], 'name' => $currency['title']);
		}
		
		$this->load->model('sale/customer_group');
		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		array_unshift($this->data['customer_groups'], array('customer_group_id' => 0, 'name' => $this->data['text_not_logged_in']));
		
		$this->load->model('localisation/geo_zone');
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		array_unshift($this->data['geo_zones'], array('geo_zone_id' => 0, 'name' => $this->data['text_all_other_zones']));
		
		$this->data['cart_criteria'] = array(
			'length',
			'width',
			'height',
			'item',
			'total',
			'volume',
			'weight'
		);
		
		$this->data['item_unit'] = '#';
		$this->data['postcode_unit'] = '#';
		$this->data['total_unit'] = '&curren;';
		if ($version < 151) {
			$this->data['length_unit'] = $this->data['width_unit'] = $this->data['height_unit'] = $this->config->get('config_length_class');
			$this->data['volume_unit'] = $this->config->get('config_length_class') . '&sup3;';
			$this->data['weight_unit'] = $this->config->get('config_weight_class');
		} else {
			$length = $this->db->query("SELECT * FROM " . DB_PREFIX . "length_class_description WHERE length_class_id = '" . $this->config->get('config_length_class_id') . "'");
			$this->data['length_unit'] = $this->data['width_unit'] = $this->data['height_unit'] = $length->row['unit'];
			$this->data['volume_unit'] = $length->row['unit'] . '&sup3;';
			$weight = $this->db->query("SELECT * FROM " . DB_PREFIX . "weight_class_description WHERE weight_class_id = '" . $this->config->get('config_weight_class_id') . "'");
			$this->data['weight_unit'] = $weight->row['unit'];
		}
		
		$this->data['comparisons'] = array(
			'any',
			'all',
			'not',
			'onlyany',
			'onlyall',
			'none'
		);
		
		$this->load->model('catalog/category');
		$categories = $this->model_catalog_category->getCategories(0);
		$this->data['category_options'] = '<option value="-1">' . $this->data['text_select_category'] . '</option><option value="0">' . $this->data['text_all_products'] . '</option>';
		$this->data['category_checkboxes'] = '';
		foreach ($categories as $c) {
			$this->data['category_options'] .= '<option value="' . $c['category_id'] . '">' . $c['name'] . '</option>';
			$this->data['category_checkboxes'] .= '<label><div><input type="checkbox" name="' . $this->name . '_data[#ROW#][categories][]" value="' . $c['category_id'] . '" /> ';
			$this->data['category_checkboxes'] .= (!isset($c['status']) || $c['status']) ? $c['name'] : '<em>' . $c['name'] . '</em>';
			$this->data['category_checkboxes'] .= '</div></label>';
		}
		
		$this->load->model('catalog/manufacturer');
		$manufacturers = $this->model_catalog_manufacturer->getManufacturers();
		$this->data['manufacturer_checkboxes'] = '';
		foreach ($manufacturers as $m) {
			$this->data['manufacturer_checkboxes'] .= '<label><div><input type="checkbox" name="' . $this->name . '_data[#ROW#][manufacturers][]" value="' . $m['manufacturer_id'] . '" /> ' . $m['name'] . '</div></label>';
		}
		// end
		
		$this->template = $this->type . '/' . $this->name . '.tpl';
		$this->children = array(
			'common/header',	
			'common/footer'	
		);
		
		if ($version < 150) {
			$this->document->title = $this->data['heading_title'];
			$this->document->breadcrumbs = $breadcrumbs;
			$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
		} else {
			$this->document->setTitle($this->data['heading_title']);
			$this->data['breadcrumbs'] = $breadcrumbs;
			$this->response->setOutput($this->render());
		}
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL') {
		if (!defined('VERSION') || VERSION < 1.5) {
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			$url .= ($args) ? '&' . ltrim($args, '&') : '';
			return $url;
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			$this->error['warning'] = $this->data['standard_error'];
		}
		return ($this->error) ? false : true;
	}
	
	// non-standard
	public function getCategoryProducts() {
		$sql = "SELECT p.product_id, p.status, pd.name, p.model FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id AND pd.language_id = " . (int)$this->config->get('config_language_id') . ")";
		$sql .= (!empty($this->request->get['category_id'])) ? " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE p2c.category_id = " . (int)$this->request->get['category_id'] : "";
		$sql .= " ORDER BY p.status DESC, LOWER(pd.name) ASC";
		$query = $this->db->query($sql);
		$this->response->setOutput(json_encode($query->rows));
	}
	// end
}
?>