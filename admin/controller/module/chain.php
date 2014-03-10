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

class ControllerModuleChain extends Controller {
	private $error = array(); 
	private $success = '';
	private $_version = '1.12.4';
	private $_dev_link = 'http://shop.workshop200.com/en/chain';
	
	public function __construct($registry) {
        parent::__construct($registry);		
		$this->load->model('catalog/chain');
		
		if (method_exists($this->load, 'helper')) {
			$this->load->helper('html');
			$this->load->helper('value');
		} else {
			require_once(DIR_SYSTEM . 'helper/html.php'); 
			require_once(DIR_SYSTEM . 'helper/value.php'); 
		}
		
	}

	public function install() 
	{
		$this->load->model('setting/setting');
		$this->load->model('setting/extension');
		$this->load->model('catalog/chain');
		
		$this->model_setting_extension->install('total', 'chain');
		$this->model_catalog_chain->install();
		$this->model_setting_setting->editSetting('chain', array('chain_sort_order' => '2', 'chain_status' => '1'));
		$this->model_setting_setting->editSetting('chain_settings', array('chain_settings_data' => $this->model_catalog_chain->default_settings(),'chain_version' => $this->_version));
	}
	
	public function uninstall() 
	{
		$this->load->model('setting/setting');
		$this->load->model('setting/extension');
		$this->load->model('catalog/chain');
		
		$this->model_setting_extension->uninstall('total', 'chain');
		$this->model_setting_setting->deleteSetting('chain_settings');
		$this->model_setting_setting->deleteSetting('chain_licences');
		//$this->model_catalog_chain->uninstall(); delete product data
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/chain')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post as $key => $value) {
			if ($value !== 0 && $value !== '0' && empty($value)) {
				$this->error['warning'] = $this->language->get('error_empty_value').':'. $key;
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function index() 
	{

		$this->data['_current_file_version'] = $this->_version;
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('module/chain');
			}
		else 
			{
				$this->load->language('module/chain');
			}
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		$this->load->model('catalog/chain'); 
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && isset($this->request->post['chain_style'])) {
			
			foreach ($this->request->post as $key => $value) {
				$chain_settings[$key] = $value;
			}
			
			$this->config->set('chain_settings_data', $chain_settings);
			
			$this->model_setting_setting->editSetting('chain_settings', array('chain_settings_data' => $chain_settings, 'chain_version' => $this->_version, 'chain_cache' => $this->request->post['chain_cache']));
			
			$this->config->set('chain_version', $this->_version);
			
			$this->success = $this->language->get('text_success');

		}
		
		if ($this->success) {
			$this->data['success'] = $this->success;
		} else {
			$this->data['success'] = false;
		}	

		if ($this->config->get('chain_settings_data')) {
			$this->data['chain_settings'] = $this->config->get('chain_settings_data');
		} else {
			exit('DRAMATIC ERROR! No config data! Please, try to reinstall module');
		}
		
		if ($this->config->get('chain_version') && version_compare($this->config->get('chain_version'), $this->_version, '<'))
			{
				$this->data['update_version'] 		= true;
				$this->data['txt_update_version']	= sprintf($this->language->get('txt_update_version'), $this->_version);
			}
		else 
			{
				$this->data['update_version'] = false;
			}
		
		$this->data['heading_title'] 			= $this->language->get('heading_title');
		$this->data['text_module'] 				= $this->language->get('text_module');
		$this->data['text_success'] 			= $this->language->get('text_success');
		$this->data['text_content_top'] 		= $this->language->get('text_content_top');
		$this->data['text_content_bottom'] 		= $this->language->get('text_content_bottom');
		$this->data['text_column_left'] 		= $this->language->get('text_column_left');
		$this->data['text_column_right'] 		= $this->language->get('text_column_right');
		$this->data['entry_layout'] 			= $this->language->get('entry_layout');
		$this->data['entry_position'] 			= $this->language->get('entry_position');
		$this->data['entry_status'] 			= $this->language->get('entry_status');
		$this->data['entry_sort_order'] 		= $this->language->get('entry_sort_order');
		$this->data['of_container'] 			= $this->language->get('of_container');
		$this->data['txt_display_you_save'] 	= $this->language->get('txt_display_you_save');
		$this->data['txt_display_old_price'] 	= $this->language->get('txt_display_old_price');
		$this->data['txt_style'] 				= $this->language->get('txt_style');
		$this->data['container_margin_top'] 	= $this->language->get('container_margin_top');
		$this->data['container_margin_bottom'] 	= $this->language->get('container_margin_bottom');
		$this->data['txt_display_discount_percent'] 	= $this->language->get('txt_display_discount_percent');
		$this->data['txt_customized_style'] 	= $this->language->get('txt_customized_style');
		$this->data['txt_classic_module_box'] 	= $this->language->get('txt_classic_module_box');
		$this->data['txt_container_padding'] 	= $this->language->get('txt_container_padding');
		$this->data['txt_top'] 					= $this->language->get('txt_top');
		$this->data['txt_left'] 				= $this->language->get('txt_left');
		$this->data['txt_right'] 				= $this->language->get('txt_right');
		$this->data['txt_bottom'] 				= $this->language->get('txt_bottom');
		$this->data['txt_container_border'] 	= $this->language->get('txt_container_border');
		$this->data['txt_width'] 				= $this->language->get('txt_width');
		$this->data['txt_color'] 				= $this->language->get('txt_color');
		$this->data['txt_radius'] 				= $this->language->get('txt_radius');
		$this->data['txt_font_size'] 			= $this->language->get('txt_font_size');
		$this->data['txt_option_button'] 		= $this->language->get('txt_option_button');
		$this->data['txt_font_color'] 			= $this->language->get('txt_font_color');
		$this->data['txt_show'] 				= $this->language->get('txt_show');
		$this->data['txt_plus_sign_equal_sign']	= $this->language->get('txt_plus_sign_equal_sign');
		$this->data['txt_unselected']			= $this->language->get('txt_unselected');
		$this->data['txt_old_price']			= $this->language->get('txt_old_price');
		$this->data['txt_new_price']			= $this->language->get('txt_new_price');
		$this->data['txt_extra_css']			= $this->language->get('txt_extra_css');
		$this->data['txt_extra_css_hint']		= $this->language->get('txt_extra_css_hint');
		$this->data['txt_action_type']			= $this->language->get('txt_action_type');
		$this->data['txt_action_show_msg']		= $this->language->get('txt_action_show_msg');
		$this->data['txt_action_url_redirect_to']= $this->language->get('txt_action_url_redirect_to');
		$this->data['txt_cute_product_title_to']= $this->language->get('txt_cute_product_title_to');
		$this->data['txt_title_length']			= $this->language->get('txt_title_length');
		$this->data['txt_show_image']			= $this->language->get('txt_show_image');
		$this->data['txt_popup_image_size']		= $this->language->get('txt_popup_image_size');
		$this->data['txt_chain_image_size']		= $this->language->get('txt_chain_image_size');
		$this->data['txt_chain_position']		= $this->language->get('txt_chain_position');
		$this->data['txt_yes']					= $this->language->get('txt_yes');
		$this->data['txt_no']					= $this->language->get('txt_no');
		$this->data['txt_autoscroll']			= $this->language->get('txt_autoscroll');
		$this->data['txt_allow_mousewheel']		= $this->language->get('txt_allow_mousewheel');
		$this->data['txt_control_navigation']	= $this->language->get('txt_control_navigation');
		$this->data['txt_navigation_arrows_bg']	= $this->language->get('txt_navigation_arrows_bg');
		$this->data['txt_navigation_arrows_padding_top'] 	= $this->language->get('txt_navigation_arrows_padding_top');
		$this->data['txt_navigation_arrows_padding_bottom']	= $this->language->get('txt_navigation_arrows_padding_bottom');
		$this->data['txt_navigation_arrows_color']			= $this->language->get('txt_navigation_arrows_color');
		$this->data['txt_lineheight']			= $this->language->get('txt_lineheight');
		$this->data['txt_font_wieght']			= $this->language->get('txt_font_wieght');
		$this->data['txt_price']				= $this->language->get('txt_price');
		$this->data['txt_total_price']			= $this->language->get('txt_total_price');
		$this->data['txt_padding']				= $this->language->get('txt_padding');
		$this->data['txt_enter_license']		= $this->language->get('txt_enter_license');
		$this->data['txt_you_save']				= $this->language->get('txt_you_save');
		$this->data['txt_display_in_tab']		= $this->language->get('txt_display_in_tab');
		$this->data['txt_display_in_tab_hint']	= $this->language->get('txt_display_in_tab_hint');
		$this->data['txt_chain_position_hint']	= $this->language->get('txt_chain_position_hint');
		$this->data['txt_allow_mousewheel_hint']	= $this->language->get('txt_allow_mousewheel_hint');
		$this->data['txt_control_navigation_hint']	= $this->language->get('txt_control_navigation_hint');
		$this->data['txt_chain_for_special']	= $this->language->get('txt_chain_for_special');
		$this->data['txt_chain_for_special_hint']	= $this->language->get('txt_chain_for_special_hint');
		$this->data['txt_dont_accumulate_price']	= $this->language->get('txt_dont_accumulate_price');
		$this->data['txt_dont_accumulate_price_example']	= $this->language->get('txt_dont_accumulate_price_example');
		$this->data['txt_accumulate_price']	= $this->language->get('txt_accumulate_price');
		$this->data['txt_accumulate_price_example']	= $this->language->get('txt_accumulate_price_example');
		
		$this->data['txt_use_cache']			= $this->language->get('txt_use_cache');
		$this->data['txt_action_redirect']		= $this->language->get('txt_action_redirect');
		$this->data['txt_selected']				= $this->language->get('txt_selected');
		$this->data['txt_title'] 				= $this->language->get('txt_title');
		$this->data['txt_discount_label'] 		= $this->language->get('txt_discount_label');
		$this->data['txt_discount'] 			= $this->language->get('txt_discount');
		
		$this->data['button_save'] 				= $this->language->get('button_save');
		$this->data['button_cancel'] 			= $this->language->get('button_cancel');
		$this->data['button_add_module'] 		= $this->language->get('button_add_module');
		$this->data['button_remove'] 			= $this->language->get('button_remove');
		
		$this->data['txt_display_settings']			= $this->language->get('txt_display_settings');
		$this->data['txt_style_settings']			= $this->language->get('txt_style_settings');
		$this->data['txt_action_settings']			= $this->language->get('txt_action_settings');
		$this->data['txt_options_settings']			= $this->language->get('txt_options_settings');
		$this->data['txt_slider_settings']			= $this->language->get('txt_slider_settings');
		$this->data['txt_purchase_license']			= $this->language->get('txt_purchase_license');
		$this->data['txt_ajax_loader']				= $this->language->get('txt_ajax_loader');
		$this->data['txt_ajax_loader_hint']			= $this->language->get('txt_ajax_loader_hint');
		$this->data['txt_totals']					= $this->language->get('txt_totals');
		$this->data['txt_edit']						= $this->language->get('txt_edit');
		$this->data['txt_license']					= $this->language->get('txt_license');
		$this->data['txt_homepage']					= $this->language->get('txt_homepage');
		$this->data['txt_widget']					= $this->language->get('txt_widget');
		$this->data['txt_widget_hint']				= $this->language->get('txt_widget_hint');
		
		
		$this->data['txt_purchase_license_url']		= $this->_dev_link;
		
		$this->data['txt_version'] 	= $this->language->get('txt_version');
		$this->data['version'] 		= $this->config->get('chain_version');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->data['on_add_off'] = array(
			0 => $this->language->get('txt_no'),
			1 => $this->language->get('txt_yes'),
		);
		
		$this->data['chain_decrease_for_special'] = array(
			0 => $this->language->get('txt_accumulate_price'),
			1 => $this->language->get('txt_dont_accumulate_price'),
		);
	
		
		$this->data['drop_down_fontweight'] = array(
			'normal' 	=> 'Normal',
			'bold' 		=> 'Bold'
		);
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/chain', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/chain', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['widget_url'] = $this->url->link('module/chainwidget', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['totals'] = $this->url->link('total/chain', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$em = array();
		for ($i = 0.5; $i < 3; $i = $i + 0.1) {
			$em[$i.'em'] = $i . ' em';
		}
		
		$this->data['drop_down_px_array'] = array();
		for ($i = 0; $i <= 150; $i++) {
			$this->data['drop_down_px_array'][$i] = $i . ' px';
		}
		
		/*
		$drop_down_fontsize = array(
												'h1' => $this->language->get('txt_inherit') . ' h1',
												'h2' => $this->language->get('txt_inherit') . ' h2',
												'h3' => $this->language->get('txt_inherit') . ' h3',
												'h4' => $this->language->get('txt_inherit') . ' h4',
												'h5' => $this->language->get('txt_inherit') . ' h5'
											);
		*/
		
		for ($i = 8; $i < 50; $i++) {
			$drop_down_fontsize[$i.'px'] = $i . ' px';
		}
		
		$this->data['drop_down_fontsize'] = array_merge($drop_down_fontsize, $em);
		
		$this->data['chain_display_chain_position_type'] = array(
			'before' => $this->language->get('before'),
			'after' => $this->language->get('after'),
			'prepend' => $this->language->get('prepend'),
			'append' => $this->language->get('append')
		);
		
		$this->template = 'module/chain_settings.tpl';

		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());

	}
	
	public function save() 
	{
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('module/chain');
			}
		else 
			{
				$this->load->language('module/chain');
			}
		
		if (!isset($this->request->post['main_product_id'])) 
			{
				$this->error = '<div class="warning">'.$this->language->get('error_empty_pid').'</div>'; 
			}
			
		if (!$this->user->hasPermission('modify', 'catalog/product')) {
			$this->error = '<div class="warning">'.$this->language->get('error_permission').'</div>';
		}
		
		
		if ( !$this->error ) 
			{
				$this->load->model('catalog/chain');
				$this->load->model('setting/setting');
				
				$allow = $this->model_catalog_chain->save();
				
				$files = glob(DIR_CACHE . 'cache.chain_' . $this->request->post['main_product_id'] . '*');
				
				if ($files) {
					foreach ($files as $file) {
						if (file_exists($file)) {
							unlink($file);
						}
					}
				}
				
				$continue_btn = '<a class="button" onclick="get_chain_content()"><span>'. $this->language->get('txt_continue') .' &raquo;</span></a>';
				if (!isset($this->request->post['product'])) 
					{	
						$output = '<div class="success">'.$this->language->get('txt_product_success_deleted').'</div>' . $continue_btn; 
					}
				else 
					{
						$output = '<div class="success">'.$this->language->get('txt_product_success_saved').'</div>' . $continue_btn;
					}
			}
			
		if (!$this->error) {
			$this->response->setOutput($output);
		} else {
			$this->response->setOutput($this->error);
		}
		
	}
	public function products() 
	{
		$this->data['chains'] = array();
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('module/chain');
			}
		else 
			{
				$this->load->language('module/chain');
			}
		$this->load->model('catalog/chain');
		$this->load->model('catalog/product');
		
		$_chains = $this->model_catalog_chain->getChains($this->request->get['product_id']);
		
		foreach ($_chains as $key => $row) {
			$chain = unserialize($row['chain']);
			
			$quantity = @unserialize($row['quantity']);
			if ($quantity === false) {
				$quantity = array();
			}
			$this->data['chains'][$key]['quantity'] = $quantity;
			
			foreach($chain as $product_id => $combo_price) {
				$this->data['chains'][$key]['data'][$product_id] = $this->model_catalog_product->getProduct($product_id);
				$this->data['chains'][$key]['data'][$product_id]['combo_price'] = $combo_price;
			}
			if (isset($this->data['chains'][$key])) {
				$this->data['chains'][$key]['chain_discount_id'] = $row['chain_discount_id'];
			}
			
		}
		
		$this->data['txt_enter_license']		= $this->language->get('txt_enter_license');
		$this->data['entry_quantity']		= $this->language->get('entry_quantity');
		$this->data['entry_product_name'] = $this->language->get('entry_product_name');
		$this->data['entry_price'] = $this->language->get('entry_price');
		$this->data['entry_combo_price'] = $this->language->get('entry_combo_price');
		$this->data['entry_delete_combo'] = $this->language->get('entry_delete_combo');
		$this->data['entry_up'] = $this->language->get('entry_up');
		$this->data['entry_down'] = $this->language->get('entry_down');
		$this->data['entry_total_price'] = $this->language->get('entry_total_price');
		$this->data['entry_add_combo'] = $this->language->get('entry_add_combo');
		$this->data['entry_save_combo'] = $this->language->get('entry_save_combo');
		$this->data['entry_view_module'] = $this->language->get('entry_view_module');
		
		$this->data['product'] = $this->model_catalog_product->getProduct($this->request->get['product_id']);

		$this->data['action'] = $this->url->link('module/chain', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['view_module'] = $this->url->link('module/chain', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		
		
		$this->template = 'module/chain.tpl';
		
		$this->response->setOutput($this->render());

	}
	
	public function autocomplete() {
	
		$json = array();
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_category_id'])) {
			$this->load->model('catalog/product');
			
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			
			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}
						
			if (isset($this->request->get['filter_category_id'])) {
				$filter_category_id = $this->request->get['filter_category_id'];
			} else {
				$filter_category_id = '';
			}
			
			if (isset($this->request->get['filter_sub_category'])) {
				$filter_sub_category = $this->request->get['filter_sub_category'];
			} else {
				$filter_sub_category = '';
			}
			
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];	
			} else {
				$limit = 10;	
			}			
						
			$data = array(
				'filter_name'         => $filter_name,
				'filter_model'        => $filter_model,
				'filter_category_id'  => $filter_category_id,
				'filter_sub_category' => $filter_sub_category,
				'start'               => 0,
				'limit'               => $limit
			);
			
			$products_results = $this->model_catalog_product->getProducts($data);
			
			foreach ($products_results as $result) {
			
				$products_chains = $this->model_catalog_chain->getChains($result['product_id']);
				
				if (empty($products_chains)) 
					{
						continue;
					} 
				else 
					{
						
						foreach ($products_chains as $row) 
							{
							
								$chains = array();
							
								if (empty($row['chain'])) 
									{
										continue;
									} 
								else 
									{
										$chain_array = unserialize($row['chain']);
									}
								
								if (!is_array($chain_array)) 
									{
										continue;
									}
								
								$chains[$row['chain_discount_id']][] = $row['main_product_id'];
								
								foreach ($chain_array as $product_id => $combo_price) 
									{
										$chains[$row['chain_discount_id']][] = $product_id;
									}
								
							
						
								foreach($chains as $chain_id => $chain) 
									{
										$this_chain_data = array();
										
										foreach ($chain as $product_id) 
											{												
												$this_chain_data[] = $this->model_catalog_product->getProduct($product_id);
											}
										
										$this_chain_name = array();
										
										foreach ($this_chain_data as $product) 
											{
												$this_chain_name[] = $product['name'];
											}
											
										$json[] = array(
											'chain_id' => $chain_id,
											'name' => implode(' + ', $this_chain_name)
										);
									}
							
							}
							
				}
					
			}
			
		}

		$this->response->setOutput(json_encode($json));
	}
	
	public function chain_manager_ad() {
	
		if (!$this->config->get('hide_chain_manager_ad') && ($ioncube_loader_version = $this->check_ioncube_loader())) {
		
			if (version_compare(VERSION, '1.5.5', '>='))
				{
					$this->language->load('module/chain');
				}
			else 
				{
					$this->load->language('module/chain');
				}
				
			$output = '<div class="text_chain_manager_ad box">';
				$output .= '<div class="heading">';
				$output .= '<h1>'. $this->language->get('text_chain_manager_ad_title') .'</h1>';
					if (!isset($this->request->get['disable_hide'])) {
						$output .= '<div class="buttons">';
							$output .= '<a href="javascript:hide_chain_manager_ad();" class="button"><span>'.$this->language->get('text_chain_manager_btn').'</span></a>';
						$output .= '</div>';
					}
				$output .= '</div>';
				$output .= '<div class="content" style="min-height: 10px; font-size: 1.2em; line-height: 1.2em;">';
				$output .= sprintf($this->language->get('text_chain_manager_ad_body'), $ioncube_loader_version,  $this->_dev_link .'_manager');
				$output .= '</div>';
			$output .= '</div>';
			$this->response->setOutput($output);
		
		}
	}
	
	public function hide_chain_manager_ad() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('hide_chain_manager_ad', array('hide_chain_manager_ad' => '1'));
	}
	
	private function check_ioncube_loader() {
		
		if ( extension_loaded('ionCube Loader') && function_exists('ioncube_loader_version') ) {
			$ioncube_loader_version = ioncube_loader_version();
			if (version_compare($ioncube_loader_version, '4.4', ">=")) {
				return $ioncube_loader_version;
			} else {
				return false;
			}
		}
	}
	
	
}
