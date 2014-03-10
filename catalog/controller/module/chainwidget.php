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

class ControllerModuleChainwidget extends Controller {
	
	protected function index($setting) {
				
					if ( ($document = $this->document) && isset($document) && method_exists($this->document, 'addScript') && method_exists($this->document, 'addStyle') ) {
						$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
						$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
					}
					
					$cache_key = 'chain_widget_'. md5($this->config->get('chains_of_products') . $this->currency->getCode() . $this->session->data['language']);

					if (method_exists($this->load, 'helper')) {
						$this->load->helper('value');
					} else {
						require_once(DIR_SYSTEM . 'helper/value.php'); 
					}

					$this->data['chain_settings'] = $this->config->get('chain_settings_data');

					if (!$this->config->get('chain_cache') || ($this->config->get('chain_cache') && !$cached_data = $this->cache->get($cache_key)))
						{		
							
							$this->data['chain_shoping_cart_href'] = $this->url->link('checkout/cart');
							
							if (version_compare(VERSION, '1.5.5', '>='))
								{
									$this->language->load('product/chain');
								}
							else 
								{
									$this->load->language('product/chain');
								}
							
							$this->data['chain_settings'] = $this->config->get('chain_settings_data');
							
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
							
							$chains = explode(',', $this->config->get('chains_of_products'));
							
							foreach ($chains as $key => $value) {
								$chains[$key] = (int)$value;
							}
							
							$this->load->model('catalog/chain');
							$this->load->library('chain');
							
							if (!isset($this->chain) || !is_object($chain)) {
								$this->chain = new Chain($this->registry, $this->load);
							}
							
							$chains = $this->model_catalog_chain->_getChainsByID($chains);
							
							$data = $this->chain->get_chain_data($chains);
							
							if (isset($data) && is_array($data)) {
								$this->data = $this->data + $data;
							} else {
								$this->log->write('Chain Module failed to load data for Widget! May be one of the bundles was deleted...');
								return;
							}
							
							if ($this->config->get('chain_cache')) {
								$this->cache->set($cache_key, $this->data);
							}
						}
					else
						{
							$this->data = $cached_data;
						}
					
					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/chain_options.php')) {
						$this->data['option_tpl'] = DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/chain_options.php';
					} else {
						$this->data['option_tpl'] = DIR_TEMPLATE . 'default/template/product/chain_options.php';
					}

					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/chainwidget.tpl')) {
						$this->template = $this->config->get('config_template') . '/template/module/chainwidget.tpl';
					} else {
						$this->template = 'default/template/module/chainwidget.tpl';
					}

					$this->response->setOutput($this->render());

	}
	
}
?>