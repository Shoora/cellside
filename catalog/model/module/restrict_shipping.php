<?php
//==============================================================================
// Restrict Shipping Methods v155.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ModelModuleRestrictShipping extends Model {		
	private $type = 'module';
	private $name = 'restrict_shipping';
	
	private function getSetting($setting) {
		$value = $this->config->get($this->name . '_' . $setting);
		return (is_string($value) && strpos($value, 'a:') === 0) ? unserialize($value) : $value;
	}
	
	public function restrict($extensions) {
		if (!$this->getSetting('status') || !$this->getSetting('data')) {
			return $extensions;
		}
		
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		
		$default_currency = $this->config->get('config_currency');
		$currency = $this->session->data['currency'];
		$language = $this->session->data['language'];
		$length_unit = ($version < 151) ? 'length_class' : 'length_class_id';
		$shipping_method = (isset($this->session->data['shipping_method'][$version < 150 ? 'id' : 'code'])) ? explode('.', $this->session->data['shipping_method'][$version < 150 ? 'id' : 'code']) : false;
		$payment_method = (isset($this->session->data['payment_method'][$version < 150 ? 'id' : 'code'])) ? $this->session->data['payment_method'][$version < 150 ? 'id' : 'code'] : false;
		
		$keycode = ($version < 150) ? 'key' : 'code';
		$total_data = array();
		$order_total = 0;
		$taxes = $this->cart->getTaxes();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'total'");
		$order_totals = $query->rows;
		$sort_order = array();
		foreach ($order_totals as $key => $value) $sort_order[$key] = $this->config->get($value[$keycode] . '_sort_order');
		array_multisort($sort_order, SORT_ASC, $order_totals);
		foreach ($order_totals as $ot) {
			if ($this->name == 'restrict_shipping' && $ot[$keycode] == 'shipping') break;
			if ($this->config->get($ot[$keycode] . '_status')) {
				$this->load->model('total/' . $ot[$keycode]);
				$this->{'model_total_' . $ot[$keycode]}->getTotal($total_data, $order_total, $taxes);
			}
			if ($this->name != 'restrict_shipping' && $ot[$keycode] == 'shipping') break;
		}
		
		$this->load->model('account/address');
		foreach (array('shipping', 'payment') as $address_type) {
			$address = array();
			if ($this->customer->isLogged()) 								$address = $this->model_account_address->getAddress($this->customer->getAddressId());
			if (isset($this->session->data['country_id']))					$address['country_id'] = $this->session->data['country_id'];
			if (isset($this->session->data['zone_id']))						$address['zone_id'] = $this->session->data['zone_id'];
			if (isset($this->session->data['postcode']))					$address['postcode'] = $this->session->data['postcode'];
			if (isset($this->session->data['shipping_country_id']))			$address['country_id'] = $this->session->data['shipping_country_id'];
			if (isset($this->session->data['shipping_zone_id']))			$address['zone_id'] = $this->session->data['shipping_zone_id'];
			if (isset($this->session->data['shipping_postcode']))			$address['postcode'] = $this->session->data['shipping_postcode'];
			if (isset($this->session->data['guest']))						$address = $this->session->data['guest'];
			if (isset($this->session->data['guest'][$address_type]))		$address = $this->session->data['guest'][$address_type];
			if (isset($this->session->data[$address_type . '_address_id']))	$address = $this->model_account_address->getAddress($this->session->data[$address_type . '_address_id']);		
			if (isset($this->session->data[$address_type . '_country_id']))	$address['country_id'] = $this->session->data[$address_type . '_country_id'];
			if (isset($this->session->data[$address_type . '_zone_id']))	$address['zone_id'] = $this->session->data[$address_type . '_zone_id'];
			if (isset($this->session->data[$address_type . '_postcode']))	$address['postcode'] = $this->session->data[$address_type . '_postcode'];
			if (empty($address['country_id']))								$address['country_id'] = $this->config->get('config_country_id');
			if (empty($address['zone_id']))									$address['zone_id'] =  $this->config->get('config_zone_id');
			if (empty($address['postcode']))								$address['postcode'] = '';
			${$address_type.'_geozones'} = array();
			$geozones = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE country_id = " . (int)$address['country_id'] . " AND (zone_id = 0 OR zone_id = " . (int)$address['zone_id'] . ")");
			foreach ($geozones->rows as $geozone) {
				${$address_type.'_geozones'}[] = $geozone['geo_zone_id'];
			}
			${$address_type.'_postcode'} = preg_replace('/[^A-Za-z0-9 ]/', '', $address['postcode']);
		}
		
		$disabled = array();
		$enabled = array();
		$geozone_comparison = ($this->name == 'restrict_shipping') ? 'shipping' : 'payment';
		$this->load->model('catalog/product');
		
		foreach ($this->getSetting('data') as $row) {
			// Generate Comparison Values
			$item = 0;
			$postcode = ($row['postcode_format'] == 'uk') ? substr_replace(substr_replace(str_replace(' ', '', ${$geozone_comparison.'_postcode'}), ' ', -3, 0), ' ', -2, 0) : ${$geozone_comparison.'_postcode'};
			$prediscounted = 0;
			$subtotal = 0;
			$taxed = 0;
			$total = $order_total;
			$volume = 0;
			$weight = 0;
			$cart_categories = array();
			$cart_manufacturers = array();
			$cart_products = array();
			
			foreach ($this->cart->getProducts() as $product) {
				$product_categories = array();
				$categories = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product['product_id'] . "'");
				foreach ($categories->rows as $category) {
					$product_categories[] = $category['category_id'];
					$cart_categories[] = $category['category_id'];
				}
				
				$manufacturer = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "product WHERE product_id = '" . $product['product_id'] . "'");
				$cart_manufacturers[] = $manufacturer->row['manufacturer_id'];
				
				$cart_products[] = $product['product_id'];
				
				if (($row['cart_comparison'] == 'cart') ||
					(empty($row['categories']) && strpos($row['category_comparison'], 'no') !== 0 && empty($row['manufacturers']) && strpos($row['manufacturer_comparison'], 'no') !== 0 && empty($row['products']) && strpos($row['product_comparison'], 'no') !== 0) ||
					(isset($row['categories']) && strpos($row['category_comparison'], 'no') !== 0 && array_intersect($product_categories, $row['categories'])) ||
					(isset($row['categories']) && strpos($row['category_comparison'], 'no') === 0 && !array_intersect($product_categories, $row['categories'])) ||
					(isset($row['manufacturers']) && strpos($row['manufacturer_comparison'], 'no') !== 0 && in_array($manufacturer->row['manufacturer_id'], $row['manufacturers'])) ||
					(isset($row['manufacturers']) && strpos($row['manufacturer_comparison'], 'no') === 0 && !in_array($manufacturer->row['manufacturer_id'], $row['manufacturers'])) ||
					(isset($row['products']) && strpos($row['product_comparison'], 'no') !== 0 && in_array($product['product_id'], $row['products'])) ||
					(isset($row['products']) && strpos($row['product_comparison'], 'no') === 0 && !in_array($product['product_id'], $row['products']))
				) {
					$item += $product['quantity'];
					
					$product_query = $this->db->query("SELECT price FROM " . DB_PREFIX . "product WHERE product_id = " . (int)$product['product_id']);
					$product_info = $this->model_catalog_product->getProduct($product['product_id']);
					$price = ($product_info['special']) ? $product_info['special'] : $product_info['price'];
					
					$prediscounted += $product['total'] + ($product['quantity'] * ($product_query->row['price'] - $price));
					$subtotal += $product['total'];
					$taxed += $this->tax->calculate($product['total'], $product['tax_class_id'], $this->config->get('config_tax'));
					
					$length = $this->length->convert($product['length'], $product[$length_unit], $this->config->get('config_' . $length_unit));
					$width = $this->length->convert($product['width'], $product[$length_unit], $this->config->get('config_' . $length_unit));
					$height = $this->length->convert($product['height'], $product[$length_unit], $this->config->get('config_' . $length_unit));
					$volume += $length * $width * $height * $product['quantity'];
					
					if ($version < 150) {
						$weight += $this->weight->convert($product['weight'] * $product['quantity'], $product['weight_class'], $this->config->get('config_weight_class'));
					} elseif ($version < 151) {
						$weight += $this->weight->convert($product['weight'], $product['weight_class'], $this->config->get('config_weight_class'));
					} else {
						$weight += $this->weight->convert($product['weight'], $product['weight_class_id'], $this->config->get('config_weight_class_id'));
					}
				}
			}
			
			$autoconvert = (!in_array($currency, $row['currencys']));
			$conversion_currency = $row['currencys'][0];
			if ($conversion_currency == 'autoconvert') {
				$conversion_currency = (isset($row['currencys'][1])) ? $row['currencys'][1] : $default_currency;
			}
			
			$total_value = ${$row['total_value']};
			$total_value = $this->currency->convert($total_value, $default_currency, $currency);
			$total_value = ($autoconvert) ? $this->currency->convert($total_value, $currency, $conversion_currency) : $total_value;
			
			foreach ($extensions as $index => $extension) {
				// Check Extensions
				if (empty($row['extensions']) || !in_array($extension[$keycode], $row['extensions']) || !$this->config->get($extension[$keycode] . '_status')) {
					continue;
				}
				
				// Check Order Criteria
				$geozone_comparison = ($this->name == 'restrict_shipping') ? 'shipping' : 'payment';
				if (empty($row['stores']) ||
					!in_array((int)$this->config->get('config_store_id'), $row['stores']) ||
					empty($row['currencys']) ||
					(!in_array('autoconvert', $row['currencys']) && !in_array($this->session->data['currency'], $row['currencys'])) ||
					empty($row['customer_groups']) ||
					!in_array((int)$this->customer->getCustomerGroupId(), $row['customer_groups']) ||
					empty($row['geo_zones']) ||
					(empty(${$geozone_comparison.'_geozones'}) && !in_array(0, $row['geo_zones'])) ||
					(!empty(${$geozone_comparison.'_geozones'}) && !array_intersect($row['geo_zones'], ${$geozone_comparison.'_geozones'})) ||
					($this->name != 'restrict_shipping' && $shipping_method && (empty($row['shipping_methods']) || !in_array($shipping_method[0], $row['shipping_methods']))) ||
					($this->name == 'restrict_total' && $payment_method && (empty($row['payment_methods']) || !in_array($payment_method, $row['payment_methods'])))
				) {
					$disabled[$index] = $extensions[$index];
					continue;
				}
				
				// Check Cart Criteria
				if (($row['min_item'] && $item < (float)$row['min_item']) ||
					($row['max_item'] && $item > (float)$row['max_item']) ||
					($row['min_total'] && $total_value < (float)$row['min_total']) ||
					($row['max_total'] && $total_value > (float)$row['max_total']) ||
					($row['min_volume'] && $volume < (float)$row['min_volume']) ||
					($row['max_volume'] && $volume > (float)$row['max_volume']) ||
					($row['min_weight'] && $weight < (float)$row['min_weight']) ||
					($row['max_weight'] && $weight > (float)$row['max_weight']) ||
					($row['date_start'] && strtotime(date('Y-m-d')) < strtotime($row['date_start'])) ||
					($row['date_end'] && strtotime(date('Y-m-d')) > strtotime($row['date_end']))
				) {
					$disabled[$index] = $extensions[$index];
					continue;
				}
				
				if ($row['postcodes']) {
					$no_matches = true;
					$postcodes = explode(',', $row['postcodes']);
					foreach ($postcodes as $pc) {
						$range = explode('-', trim($pc));
						$from = trim($range[0]);
						$to = (isset($range[1])) ? trim($range[1]) : '';
						
						if ($row['postcode_format'] == 'uk') {
							$from = str_replace(' ', '', $from);
							$from .= (strlen($from) < 5) ? '000' : '';
							$from = substr_replace(substr_replace($from, ' ', -3, 0), ' ', -2, 0);
							
							if ($to) {
								$to = str_replace(' ', '', $to);
								$to .= (strlen($to) < 5) ? 'ZZZ' : '';
								$to = substr_replace(substr_replace($to, ' ', -3, 0), ' ', -2, 0);
							} else {
								$to = str_replace('0 00', 'Z ZZ', $from);
							}
						}
						
						if ((!$to && strnatcasecmp($from, $postcode) == 0) ||
							((empty($from) || strnatcasecmp($from, $postcode) <= 0) && (empty($to) || strnatcasecmp($postcode, $to) <= 0))
						) {
							$no_matches = false;
							break;
						}
					}
					if ($no_matches) {
						$disabled[$index] = $extensions[$index];
						continue;
					}
				}
				
				// Check Categories
				if (!empty($row['categories'])) {
					$categories_intersection = array_intersect($cart_categories, $row['categories']);
					if (($row['category_comparison'] == 'any' && !$categories_intersection) ||
						($row['category_comparison'] == 'all' && array_diff($row['categories'], $cart_categories)) ||
						($row['category_comparison'] == 'not' && !array_diff($cart_categories, $row['categories'])) ||
						($row['category_comparison'] == 'onlyany' && array_diff($cart_categories, $row['categories'])) ||
						($row['category_comparison'] == 'onlyall' && array_diff(array_merge($cart_categories, $row['categories']), $categories_intersection)) ||
						($row['category_comparison'] == 'none' && $categories_intersection)
					) {
						$disabled[$index] = $extensions[$index];
						continue;
					}
				}
				
				// Check Manufacturers
				if (!empty($row['manufacturers'])) {
					$manufacturers_intersection = array_intersect($cart_manufacturers, $row['manufacturers']);
					if (($row['manufacturer_comparison'] == 'any' && !$manufacturers_intersection) ||
						($row['manufacturer_comparison'] == 'all' && array_diff($row['manufacturers'], $cart_manufacturers)) ||
						($row['manufacturer_comparison'] == 'not' && !array_diff($cart_manufacturers, $row['manufacturers'])) ||
						($row['manufacturer_comparison'] == 'onlyany' && array_diff($cart_manufacturers, $row['manufacturers'])) ||
						($row['manufacturer_comparison'] == 'onlyall' && array_diff(array_merge($cart_manufacturers, $row['manufacturers']), $manufacturers_intersection)) ||
						($row['manufacturer_comparison'] == 'none' && $manufacturers_intersection)
					) {
						$disabled[$index] = $extensions[$index];
						continue;
					}
				}
				
				// Check Products
				if (!empty($row['products'])) {
					$products_intersection = array_intersect($cart_products, $row['products']);
					if (($row['product_comparison'] == 'any' && !$products_intersection) ||
						($row['product_comparison'] == 'all' && array_diff($row['products'], $cart_products)) ||
						($row['product_comparison'] == 'not' && !array_diff($cart_products, $row['products'])) ||
						($row['product_comparison'] == 'onlyany' && array_diff($cart_products, $row['products'])) ||
						($row['product_comparison'] == 'onlyall' && array_diff(array_merge($cart_products, $row['products']), $products_intersection)) ||
						($row['product_comparison'] == 'none' && $products_intersection)
					) {
						$disabled[$index] = $extensions[$index];
						continue;
					}
				}
				
				// Passed
				$enabled[] = $extensions[$index];
			}
		}
		
		foreach ($disabled as $index => $extension) {
			if (!in_array($extension, $enabled)) {
				unset($extensions[$index]);
			}
		}
		return $extensions;
	}
}
?>