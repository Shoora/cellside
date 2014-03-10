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
 
class ControllerProductChain extends Controller {
	
	protected $cache_save = false;
	protected $cache_array = array();
	private $error = array();
	
	public function __construct($registry) {
        parent::__construct($registry);
	}
	
	function index($show = true) {
		
		$this->load->model('catalog/chain');
		
		if (method_exists($this->load, 'helper')) {
			$this->load->helper('value');
		} else {
			require_once(DIR_SYSTEM . 'helper/value.php'); 
		}
		
		if (isset($this->request->get['p_id']) && $this->request->get['p_id']) 
			{
				$main_product_info = $this->request->get['p_id'];
				$query_chain = $this->model_catalog_chain->_getChains($main_product_info);
			}
		else 
			{
				header("HTTP/1.0 404 Not Found");
				exit('chains is not set && product_id is not set');
			}

		if (is_object($query_chain)) {
			$query_chain = $query_chain->rows;
		}
		
		if (count($query_chain) == 0) {
			exit;
		}
		
		if (!$this->config->get('chain_cache') || !$cached_data = $this->cache->get('chain_' . $main_product_info . '_'. md5($this->currency->getCode() . $this->session->data['language'])))
			{
				
				$total_price = array();
				
				if (version_compare(VERSION, '1.5.5', '>='))
					{
						$this->language->load('product/chain');
					}
				else 
					{
						$this->load->language('product/chain');
					}
				
				$this->data['chain_settings'] = $this->config->get('chain_settings_data');
				
				if ( index_value($this->data['chain_settings'], 'chain_action_redirect_url') ) {
					$this->data['chain_shoping_cart_href'] = index_value($this->data['chain_settings'], 'chain_action_redirect_url');
				} else {
					$this->data['chain_shoping_cart_href'] = $this->url->link('checkout/cart');
				}
				
				$this->data['heading_title'] = $this->language->get('heading_title');
				$this->data['chain_add_to_cart_btn'] = $this->language->get('chain_add_to_cart_btn');
				$this->data['text_total_save'] = $this->language->get('text_total_save');
				$this->data['text_free'] = $this->language->get('text_free');
				$this->data['text_options'] = $this->language->get('text_options');
				$this->data['text_select_options'] = $this->language->get('text_select_options');
				$this->data['text_select_options_js_error'] = $this->language->get('text_select_options_js_error');
				$this->data['text_success'] = $this->language->get('text_success');
				
				$this->data['text_select'] = $this->language->get('text_select');
				$this->data['text_option'] = $this->language->get('text_option');
				$this->data['text_quantity'] = $this->language->get('text_quantity');
				
				$this->load->library('chain');
				
				if (!isset($this->chain) || !is_object($chain)) {
					$this->chain = new Chain($this->registry, $this->load);
				}
				
				if ($query_chain_result = $this->chain->get_chain_data($query_chain, $this->data['chain_settings'])) {
					$this->data = $this->data + $query_chain_result;
				} else {
					exit;
				}
				
				if ($this->config->get('chain_cache')) {
					$this->cache->set('chain_' . $main_product_info . '_'. md5($this->currency->getCode() . $this->session->data['language'] ), $this->data);
				}
			}
		else 
			{
				$this->data = $cached_data;
			}
			
		if ($show) 
			{
			
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/chain_options.php')) {
					$this->data['option_tpl'] = DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/chain_options.php';
				} else {
					$this->data['option_tpl'] = DIR_TEMPLATE . 'default/template/product/chain_options.php';
				}
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/chain.tpl')) {
					$this->template = $this->config->get('config_template') . '/template/product/chain.tpl';
				} else {
					$this->template = 'default/template/product/chain.tpl';
				}

				$this->response->setOutput($this->render());
			} 
		else 
			{
				return $this->data;
			}
	
	}
	
	public function add_chain() {

		$this->load->model('catalog/chain');
		$chain_settings = $this->config->get('chain_settings_data');
		
		if (method_exists($this->load, 'helper')) {
			$this->load->helper('value');
		} else {
			require_once(DIR_SYSTEM . 'helper/value.php'); 
		}
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('product/chain');
			}
		else 
			{
				$this->load->language('product/chain');
			}
		
		$chain_id = $this->request->post['chain_id'];
		
		if (!$chain_id or !is_numeric($chain_id))
			{
				$this->error = 'ERROR CODE #1204 - '. $this->language->get('error_no_chain_posted');
			}
		else
			{		
				$chain = $this->model_catalog_chain->_getChain($chain_id);
			}
		
		if (isset($chain) and empty($chain)) 
			{
				$this->error = 'ERROR CODE #1404_A - '. $this->language->get('error_no_chain_exist');
			}
		
		if (!$this->error)
			{
				$this->session->data['add_chain_started'] = time();
				
				$chain_products = unserialize($chain['chain']);
				$quantity 		= @unserialize($chain['quantity']);
				if ($quantity === false) {
					$quantity = array();
				}
				
				$json['pids'][] = (int)$chain['main_product_id'] ;
				
				foreach ($chain_products as $product_id => $price) 
					{
						$json['pids'][] = (int)$product_id;
					}
				
				$this->load->model('catalog/product');
				
				$full_price = 0;
				$chain_price = 0;
				
				foreach($json['pids'] as $product_id) {
				
					if (!isset($this->request->post['chain_product_id'][$product_id]) || $this->request->post['chain_product_id'][$product_id] != $product_id) 
						{
							$this->error = 'ERROR CODE #1404_B - '. $this->language->get('error_no_chain_exist');
							break;
						}
				
					if (!$this->error)
						{
							
							if (!$product_info = $this->model_catalog_product->getProduct($product_id))
								{
									$this->error = sprintf($this->language->get('error_no_product'), $product_id);
									break;
								}
							else 
								{
									if (isset($quantity[$product_id]) && is_numeric($quantity[$product_id])) {
										$product_quantity = $quantity[$product_id];
									} else {
										$product_quantity = 1;
									}
										
									$product_info['special'] 	= $product_quantity * $product_info['special'];
									$product_info['price'] 		= $product_quantity * $product_info['price'];
								}
							
							if (!$this->_add_to_cart($product_info)) 
								{
									break;
								}
							
							if ( array_key_exists($product_id, $chain_products) )
								{
									
									if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) 
										{
											$combo_price = $chain_products[$product_id];
											
											$_real_price 							= $product_info['special'] ? $product_info['special'] : $product_info['price'];
											$product_info['_real_price_with_tax'] 	= $this->tax->calculate($_real_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
											$full_price 							= $full_price + $product_info['_real_price_with_tax'];
											
											
											if (is_numeric($combo_price))
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
																	$combo_price = $product_info['_real_price_with_tax'];
																}
														} 
													else 
														{
															if ($product_info['special'] >= $combo_price) 
																{
																	$_new_price = $combo_price - ($product_info['price'] - $product_info['special']);
																	if ($_new_price < 0) {
																		$_new_price = 0;
																	}
																	$combo_price = $this->tax->calculate($_new_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
																}
															else 
																{
																	$_new_price = $combo_price - ($product_info['price'] - $product_info['special']);
																	$combo_price = $this->tax->calculate($_new_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
																}
														}
												} else {
													$combo_price = $this->tax->calculate($combo_price, $product_info['tax_class_id'], $this->config->get('config_tax'));
												}
											}
											
											$chain_price 	= $chain_price + $combo_price;
										}
								}
						}
					
				}
				
				if (!$this->error) 
					{
						$total_save = $full_price - $chain_price;
						if (isset($total_save)) 
							{
								$this->session->data['chain'][] = array(
									'chain_id ' => $chain_id,
									'save'		=> $total_save,
									'products'  => $json['pids'],
									'quantity' 	=> $quantity
								);
							}
					} 
				else 
					{
						$json['error'] = $this->error;
					}
				
			}
		else 
			{
				$json['error'] = $this->error;
			}
		
		$this->response->setOutput(json_encode($json));
		
	}
	
	private function _add_to_cart($product_info) {

		$return = true;
			
		if (isset($this->request->post['chain_quantity'][$product_info['product_id']])) {
			$quantity = $this->request->post['chain_quantity'][$product_info['product_id']];
		} else {
			$quantity = 1;
		}
													
		if (isset($this->request->post['option'][$product_info['product_id']])) {
			$option = array_filter($this->request->post['option'][$product_info['product_id']]);
		} else {
			$option = array();	
		}
		
		$product_options = $this->model_catalog_product->getProductOptions($product_info['product_id']);
		
		foreach ($product_options as $product_option) {
			if ($product_option['required'] && empty($option)) {
				$this->error = $this->language->get('error_no_chain_exist') .'<br />'. sprintf($this->language->get('error_required_options'), $product_info['name']);
				$return = false;
			}
		}
		
		if ($return) {
			if (version_compare(VERSION, '1.5.6', '>=')) {
				$this->cart->add($product_info['product_id'], $quantity, $option, 0);
			} else {
				$this->cart->add($product_info['product_id'], $quantity, $option);
			}
			
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			
		} 
		
		return $return;
			
	}
	
	function chain_manager_ad() {
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('product/chain');
			}
		else 
			{
				$this->load->language('product/chain');
			}
		
		$this->data['text_chain_manager_ad_title'] = $this->language->get('text_chain_manager_ad_title');
		$this->data['text_chain_manager_ad_body'] = $this->language->get('text_chain_manager_ad_body');
		$this->data['text_chain_manager_ad_details'] = $this->language->get('text_chain_manager_ad_details');
		$this->data['text_chain_manager_ad_desc'] = $this->language->get('text_chain_manager_ad_desc');
	}
	
}