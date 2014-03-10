<?php
class ControllerModuleDAjaxSearch extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/d_ajax_search');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		$this->load->model('design/layout');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$settings = $this->request->post;
			$count_layout =  count($this->model_design_layout->getLayouts());
			
			for ($i=1;$i<=$count_layout;$i++)
			$settings['d_ajax_search_module'][] = array (
				'layout_id' => (string)$i,
				'position' => 'content_top',
				'status' => 1,
				'sort_order' => ''
			);

			$this->model_setting_setting->editSetting('d_ajax_search', $settings);	
			
			$this->session->data['success'] = $this->language->get('text_success');
	
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['entry_search_on_off'] = $this->language->get('entry_search_on_off');
		$this->data['entry_search_width'] = $this->language->get('entry_search_width');
		$this->data['entry_search_max_symbols'] = $this->language->get('entry_search_max_symbols');
		$this->data['entry_search_max_results'] = $this->language->get('entry_search_max_results');
		$this->data['entry_search_first_sybmols'] = $this->language->get('entry_search_first_sybmols');
		$this->data['entry_search_priority'] = $this->language->get('entry_search_priority');
		$this->data['entry_search_price'] = $this->language->get('entry_search_price');
		$this->data['entry_search_special'] = $this->language->get('entry_search_special');
		$this->data['entry_search_tax'] = $this->language->get('entry_search_tax');
		
		$this->data['text_on'] = $this->language->get('text_on');
		$this->data['text_off'] = $this->language->get('text_off');
		$this->data['text_product'] = $this->language->get('text_product');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_blog_article'] = $this->language->get('text_blog_article');
		$this->data['text_blog_category'] = $this->language->get('text_blog_category');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

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
			'href'      => $this->url->link('module/d__ajax_search', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/d_ajax_search', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		


		/*if (isset($this->request->post['search_on_off'])) {
			$this->data['search_on_off'] = $this->request->post['search_on_off'];
		} else {
			$this->data['search_on_off'] = $this->config->get('search_on_off');
		}	
		if (isset($this->request->post['search_width'])) {
			$this->data['search_width'] = $this->request->post['search_width'];
		} else {
			$this->data['search_width'] = $this->config->get('search_width');
		}	*/
		
		if (isset($this->request->post['d_ajax_search'])) {
			$this->data['d_ajax_search'] = $this->request->post['d_ajax_search'];
		} else {
			$this->data['d_ajax_search'] = $this->config->get('d_ajax_search');
		}	
		
		if (file_exists(DIR_APPLICATION . "controller/blog")) $this->data['is_blog']=1; else $this->data['is_blog']=0;
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
				
		$this->template = 'module/d_ajax_search.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/d_ajax_search')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	function install(){
		$this->load->model('setting/setting');
		$this->load->model('design/layout');
		
		//$settings = array('search_on_off' => 1, 'search_width' => '290px' );
		$count_layout =  count($this->model_design_layout->getLayouts());
			
			for ($i=1;$i<=$count_layout;$i++)
			$settings['d_ajax_search_module'][] = Array (
				'layout_id' => (string)$i,
				'position' => 'content_top',
				'status' => 1,
				'sort_order' => ''
			);
			$this->model_setting_setting->editSetting('d_ajax_search', $settings);
	}
}
?>