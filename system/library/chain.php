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

final class Chain {
	
	public $no_image = 'no_image_chain.jpg';
	
	public function __construct($registry, $load) {
		$this->config = $registry->get('config');
		$this->customer = $registry->get('customer');
		$this->session = $registry->get('session');
		$this->db = $registry->get('db');
		$this->tax = $registry->get('tax');
		$this->weight = $registry->get('weight');
		$this->currency = $registry->get('currency');
		$this->load = $registry->get('load');
		$this->url = $registry->get('url');
		$this->log = $registry->get('log');

		$load->model('catalog/product');
		$load->model('tool/image');
		$this->model_catalog_product = $registry->get('model_catalog_product');
		$this->model_tool_image = $registry->get('model_tool_image');
	}

	public function get_chain_data($query_chain, $chain_settings = false) {
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		
		if (!$chain_settings) {
			$chain_settings = $this->config->get('chain_settings_data');
		}
		
		foreach ($query_chain as $row) {
			
			$skip = false;
			$chain_total 	= 0;
			$full_price 	= 0;
			$chain_id 		= $row['chain_discount_id'];
			$chain 			= unserialize($row['chain']);
			$quantity 		= @unserialize($row['quantity']);
			if ($quantity === false) {
				$quantity = array();
			}
			
			$chain = array($row['main_product_id'] => '*') + $chain;
			
			$i = 0;
			foreach ($chain as $product_id => $combo_price) {
				$i++;
				$main_item = false;
				if (isset($quantity[$product_id]) && is_numeric($quantity[$product_id])) {
					$product_quantity = $quantity[$product_id];
				} else {
					$product_quantity = 1;
				}
				
				$product_info = $this->model_catalog_product->getProduct($product_id);
				
				if (!$product_info) 
					{
						$this->log->write('Warning! Chain Module has issue. One of the chains include product with ID '.$product_id.' which does not exist.');
						$skip = true;
						break;
					}
				
				$product_info['product_quantity'] 	= $product_quantity;
				$product_info['special'] 			= $product_quantity * $product_info['special'];
				$product_info['price'] 				= $product_quantity * $product_info['price'];
				
				if (!$product_info['image']) {
					$product_info['image'] = $this->no_image;
				}
				
				$product_info['thumb'] = $this->model_tool_image->resize($product_info['image'], $chain_settings['chain_display_image_width'], $chain_settings['chain_display_image_height']);
				if (index_value($chain_settings, 'chain_options_show_image')) {
					$product_info['popup'] = $this->model_tool_image->resize($product_info['image'], $chain_settings['chain_options_popup_image_width'], $chain_settings['chain_options_popup_image_height']);
				} else {
					$product_info['popup'] = false;
				}
				
				if ((float)$product_info['special']) {
					$product_info['special_price_with_tax'] = $this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'));
					$product_info['special_price_string'] = $this->currency->format($product_info['special_price_with_tax']);
				} else {
					$product_info['special_price_with_tax'] = false;
					$product_info['special_price_string'] = false;
				}
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$product_info['full_price_with_tax'] = $this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'));
					if (isset($combo_price) && $combo_price === '*') {
						$main_item = true;
						if ($product_info['special_price_with_tax']) {
							$combo_price = $product_info['special_price_with_tax'];
						} else {
							$combo_price = $product_info['full_price_with_tax'];
						}
					}
					$product_info['price_string'] = $this->currency->format($product_info['full_price_with_tax']);
					$full_price = $full_price + ($product_info['full_price_with_tax']);
				} else {
					$product_info['price_string'] = false;
				}
				
				$bad_combo_price = false;
				
				if (isset($combo_price)) 
					{
						
						if (is_numeric($combo_price) and $main_item === false) 
							{
								
								$combo_price = $product_quantity * $combo_price;
								
								if ($product_info['special']) {
									if (index_value($chain_settings, 'chain_decrease_for_special')) 
										{
											if ($product_info['special'] >= $combo_price) 
												{
													$combo_price = $this->tax->calculate($combo_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
												}
											else 
												{
													$combo_price = $this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'));
												}
										} 
									else 
										{
											$new_combo_price = $combo_price - ($product_info['price'] -$product_info['special']);
											$combo_price = $this->tax->calculate($new_combo_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
											if ($new_combo_price < 0 || $combo_price < 0) 
												{
													$combo_price = 0;
												}
										}
								} else {
									$combo_price = $this->tax->calculate($combo_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
								}
							} 
						elseif (!$main_item) 
							{
								if ($combo_price !== '*') 
									{
										$this->log->write("\r\n".'========================================'."\r\n".'Warning! Chain Module has issue. One of the chains include product with ID '.$product_id.' which have wrong combo price. It is "'.(isset($combo_price) ? $combo_price : '').'"'."\r\n".'========================================');
										$skip = true;
										break;
									}
							}
					} 
				else 
					{
						$this->log->write("\r\n".'========================================'."\r\n".'Warning! Chain Module has issue. One of the chains include product with ID '.$product_id.' doesn`t have price'."\r\n".'========================================');
						$skip = true;
						break;
					}

				$chain_total = $chain_total + $combo_price;
				
				if ($this->config->get('config_review_status')) {
					$product_info['rating'] = $product_info['rating'];
				} else {
					$product_info['rating'] = false;
				}
				
				$product_info['options'] = array();
				
				foreach ($this->model_catalog_product->getProductOptions($product_id) as $option) { 
					if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
						$option_value_data = array();
						
						foreach ($option['option_value'] as $option_value) {
							if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
								if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
									$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
								} else {
									$price = false;
								}
								
								$option_value_data[] = array(
									'product_option_value_id' => $option_value['product_option_value_id'],
									'option_value_id'         => $option_value['option_value_id'],
									'name'                    => $option_value['name'],
									'image'                   => isset($option_value['image']) ? $this->model_tool_image->resize($option_value['image'], 50, 50) : '',
									'price'                   => $price,
									'price_prefix'            => $option_value['price_prefix']
								);
							}
						}
						
						$product_info['options'][] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option_value_data,
							'required'          => $option['required']
						);					
					} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
						$product_info['options'][] = array(
							'product_option_id' => $option['product_option_id'],
							'option_id'         => $option['option_id'],
							'name'              => $option['name'],
							'type'              => $option['type'],
							'option_value'      => $option['option_value'],
							'required'          => $option['required']
						);						
					}
				}
				
				$product_info['href'] = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
				
				$products[$chain_id][$i] 							= $product_info;
				$products[$chain_id][$i]['combo_price'] 			= $combo_price;
				$products[$chain_id][$i]['combo_price_string'] 	= $this->currency->format($combo_price);
				
				if ($combo_price < $product_info['full_price_with_tax'] && $combo_price != 0) {
					$products[$chain_id][$i]['you_save'] = round(($product_info['full_price_with_tax'] - $combo_price) / $product_info['full_price_with_tax'] * 100);
				} else {
					$products[$chain_id][$i]['you_save'] = false;
				}
				
				unset($product_info);
				
			}
			
			if ($skip) {
				if (count($query_chain) > 1) {
					unset($products[$chain_id]);
					continue;
				} else {
					return false;
				}
			}
			
			$save = $full_price - $chain_total;
			$output['total_price'][$chain_id] 		= $this->currency->format($chain_total);
			$output['total_save'][$chain_id] 		= $this->currency->format($save);
			$output['total_save_int'][$chain_id] 	= $save;
			unset($save);
		}
		
		if (isset($products) && $products) {
			$output['products'] = $products;
		} else {
			return false;
		}
		
		return $output;
		
	}
	
}