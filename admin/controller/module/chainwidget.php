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
	
	private $error = array();
	
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
	
	function validate() {
		if (isset($this->request->post['chainwidget_module'])) {
			foreach ($this->request->post['chainwidget_module'] as $module) {
				$position[] = $module['layout_id'];
			}
			$position_ = array_unique($position);
			if (count($position_) < count($position)) {
				$this->error['warning'] = $this->language->get('error_same_page');
			}
		}

		if ($this->error) {
			return false;
		} else {
			return true;
		}
		
	}
	
	public function index() {


		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('module/chainwidget');
			}
		else
			{
				$this->load->language('module/chainwidget');
			}

		$this->document->setTitle($this->language->get('txt_widget'));

		$this->load->model('setting/setting');
		$this->load->model('catalog/chain');
		
		if ($this->model_catalog_chain->count_chains() == 0) {
			$this->error['warning'] = $this->language->get('error_no_chains');
			$this->data['block_form'] = true;
		} else {
			$this->data['block_form'] = false;
		}
		
		$main_chain = false;
		$chainwidget = false;
		
		$this->load->model('setting/extension');
		
		$extensions = $this->model_setting_extension->getInstalled('module');
		
		foreach ($extensions as $key => $value) {
			if ($value == 'chain') {
				$main_chain = true;
			}
			if ($value == 'chainwidget') {
				$chainwidget = true;
			}
		}
		
		if (!$main_chain) {
			$this->error['warning'] = $this->language->get('error_main_module_off');
			$this->data['block_form'] = true;
		} else {
			$this->data['block_form'] = false;
		}
		
		if (!$chainwidget) {
			$install_url = $this->url->link('extension/module/install', 'token=' . $this->session->data['token'].'&extension=chainwidget', 'SSL');
			$this->error['warning'] = sprintf($this->language->get('error_widget_module_off'), $install_url);
			$this->data['block_form'] = true;
		} else {
			$this->data['block_form'] = false;
		}

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && !$this->error) {

			$this->model_setting_setting->editSetting('chainwidget', $this->request->post);

			$files = glob(DIR_CACHE . 'cache.chain_widget_*');
				
			if ($files) {
				foreach ($files as $file) {
					if (file_exists($file)) {
						unlink($file);
					}
				}
			}
				
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));

		}
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}


		// Breadcrumbs Widget

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
       		'text'      => $this->language->get('txt_widget'),
			'href'      => $this->url->link('module/chainwidget', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		// Lang widget
		$this->data['heading_title'] = $this->language->get('txt_widget');
		$this->data['txt_chains'] = $this->language->get('txt_chains');
		$this->data['txt_chains_hint'] = $this->language->get('txt_chains_hint');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');

		$this->data['action'] = $this->url->link('module/chainwidget', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['position'] = array(
			'content_top' => $this->language->get('text_content_top'),
			'content_bottom' => $this->language->get('text_content_bottom')
		);

		$this->data['modules'] = array();

		$this->data['chains_list'] = $this->widget_chains_of_products();
		$this->data['chains_ids'] = implode(',',array_flip($this->data['chains_list']));

		if (isset($this->request->post['chainwidget_module'])) {
			$this->data['modules'] = $this->request->post['chainwidget_module'];
		} elseif ($this->config->get('chainwidget_module')) {
			$this->data['modules'] = $this->config->get('chainwidget_module');
		}

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/chain_widget.tpl';

		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function widget_chains_of_products() {

		$output = array();

		$this->load->model('catalog/product');

		if ($chains_of_products = $this->config->get('chains_of_products'))
			{
				$chains_of_products = explode(',', $chains_of_products);

				foreach($chains_of_products as $chain_id)
					{
						$products = array();
						$this_chain_name = array();

						if ($chain_row = $this->model_catalog_chain->getChain($chain_id))
							{
								$products[] = $this->model_catalog_product->getProduct($chain_row['main_product_id']);

								if (!empty($chain_row['chain']))
									{
										$chain_array = unserialize($chain_row['chain']);

										foreach($chain_array as $pid => $cp)
											{
												$products[] = $this->model_catalog_product->getProduct($pid);
											}
										foreach ($products as $product)
											{
												$this_chain_name[] = $product['name'];
											}
									}
								$output[$chain_id] = implode(' + ', $this_chain_name);
							}
					}
			}

		return $output;

	}
}