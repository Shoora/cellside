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

class ControllerTotalChain extends Controller { 
	private $error = array(); 
	 
	public function index() { 
		$this->language->load('total/total');
		$this->language->load('module/chain');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('chain', $this->request->post);
		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['entry_totlas_color'] = $this->language->get('entry_totlas_color');
		$this->data['entry_chane_totlas_color'] = $this->language->get('entry_chane_totlas_color');
		
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
					
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
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/chain', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('total/chain', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['chain_status'])) {
			$this->data['chain_status'] = $this->request->post['chain_status'];
		} else {
			$this->data['chain_status'] = $this->config->get('chain_status');
		}
		
		if (isset($this->request->post['chain_totals_color'])) {
			$this->data['chain_totals_color'] = $this->request->post['chain_totals_color'];
		} else {
			$this->data['chain_totals_color'] = $this->config->get('chain_totals_color');
		}
		
		if (isset($this->request->post['chain_chane_totals_color'])) {
			$this->data['chain_chane_totals_color'] = $this->request->post['chain_chane_totals_color'];
		} else {
			$this->data['chain_chane_totals_color'] = $this->config->get('chain_chane_totals_color');
		}

		if (isset($this->request->post['chain_sort_order'])) {
			$this->data['chain_sort_order'] = $this->request->post['chain_sort_order'];
		} else {
			$this->data['chain_sort_order'] = $this->config->get('chain_sort_order');
		}
																		
		$this->template = 'total/chain.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'total/total')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>