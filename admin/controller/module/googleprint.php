<?php
class ControllerModuleGooglePrint extends Controller {
	private $error = array(); 

	public function index() {  

	
		$this->load->language('module/googleprint');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('googleprint', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		 $this->data['token'] = $this->session->data['token'];  		
	    $this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_help'] = $this->language->get('text_help');

		$this->data['entry_private_key'] = $this->language->get('entry_private_key');
		$this->data['entry_public_key'] = $this->language->get('entry_public_key');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_auto_width'] = $this->language->get('entry_auto_width');
		$this->data['entry_auto_flogo'] = $this->language->get('entry_auto_flogo');
		$this->data['entry_auto_tfont'] = $this->language->get('entry_auto_tfont');
		$this->data['entry_auto_bfont'] = $this->language->get('entry_auto_bfont');
		$this->data['entry_auto_cfont'] = $this->language->get('entry_auto_cfont');
		$this->data['entry_auto_margin'] = $this->language->get('entry_auto_margin');
		$this->data['entry_auto_time'] = $this->language->get('entry_auto_time');
		$this->data['entry_auto_border'] = $this->language->get('entry_auto_border');
		$this->data['entry_auto_pad'] = $this->language->get('entry_auto_pad');
		$this->data['entry_savegoogle_drive'] = $this->language->get('entry_savegoogle_drive');
		$this->data['entry_savegoogle_drive2'] = $this->language->get('entry_savegoogle_drive2');
		$this->data['entry_invnameav2'] = $this->language->get('entry_invnameav2');
		$this->data['entry_invname2c2'] = $this->language->get('entry_invname2c2');
		$this->data['entry_custfoot2'] = $this->language->get('entry_custfoot2');
		$this->data['entry_custfoot23'] = $this->language->get('entry_custfoot23');
		$this->data['entry_custfoot221'] = $this->language->get('entry_custfoot221');
		$this->data['entry_invpicav2'] = $this->language->get('entry_invpicav2');
		$this->data['entry_inv_skuca2'] = $this->language->get('entry_inv_skuca2');
$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_On'] = $this->language->get('text_On');
		$this->data['text_Off'] = $this->language->get('text_Off');
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
			'href'      => $this->url->link('module/googleprint', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/googleprint', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('module/googleprint', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['private_key'])) {
			$this->data['private_key'] = $this->request->post['googleprint_private_key'];
		} else {
			$this->data['private_key'] = $this->config->get('googleprint_private_key');
		}	

		if (isset($this->request->post['savegoogle_drive'])) {
			$this->data['savegoogle_drive'] = $this->request->post['savegoogle_drive'];
		} else {
			$this->data['savegoogle_drive'] = $this->config->get('savegoogle_drive');
		}	
		
		if (isset($this->request->post['savegoogle_drive2'])) {
			$this->data['savegoogle_drive2'] = $this->request->post['savegoogle_drive2'];
		} else {
			$this->data['savegoogle_drive2'] = $this->config->get('savegoogle_drive2');
		}	
		
		if (isset($this->request->post['public_key'])) {
			$this->data['public_key'] = $this->request->post['googleprint_public_key'];
		} else {
			$this->data['public_key'] = $this->config->get('googleprint_public_key');
		}
		
						
		if (isset($this->request->post['autotime'])) {
			$this->data['autotime'] = $this->request->post['autotime'];
		} else {
			$this->data['autotime'] = $this->config->get('autotime');
			
		}
		
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		

		if (isset($this->error['private_key'])) {
			$this->data['error_private_key'] = $this->error['private_key'];
		} else {
			$this->data['error_private_key'] = '';
		}
		
	
		if (isset($this->error['public_key'])) {
			$this->data['error_public_key'] = $this->error['public_key'];
		} else {
			$this->data['error_public_key'] = '';
		}
		
		if (isset($this->request->post['auto_width'])) {
			$this->data['auto_width'] = $this->request->post['auto_width'];
		} else {
			$this->data['auto_width'] = $this->config->get('auto_width');
			
		}
		
		if (isset($this->request->post['auto_tfont'])) {
			$this->data['auto_tfont'] = $this->request->post['auto_tfont'];
		} else {
			$this->data['auto_tfont'] = $this->config->get('auto_tfont');
			
		}
		
		if (isset($this->request->post['auto_bfont'])) {
			$this->data['auto_bfont'] = $this->request->post['auto_bfont'];
		} else {
			$this->data['auto_bfont'] = $this->config->get('auto_bfont');
			
		}
		
		if (isset($this->request->post['auto_cfont'])) {
			$this->data['auto_cfont'] = $this->request->post['auto_cfont'];
		} else {
			$this->data['auto_cfont'] = $this->config->get('auto_cfont');
			
		}
		
		if (isset($this->request->post['auto_margin'])) {
			$this->data['auto_margin'] = $this->request->post['auto_margin'];
		} else {
			$this->data['auto_margin'] = $this->config->get('auto_margin');
			
		}
		
		if (isset($this->request->post['auto_flogo'])) {
			$this->data['auto_flogo'] = $this->request->post['auto_flogo'];
		} else {
			$this->data['auto_flogo'] = $this->config->get('auto_flogo');
			
		}
		
		if (isset($this->request->post['auto_border'])) {
			$this->data['auto_border'] = $this->request->post['auto_border'];
		} else {
			$this->data['auto_border'] = $this->config->get('auto_border');
			
		}
		
		if (isset($this->request->post['auto_pad'])) {
			$this->data['auto_pad'] = $this->request->post['auto_pad'];
		} else {
			$this->data['auto_pad'] = $this->config->get('auto_pad');
			
		}
		
	if (isset($this->request->post['invnameav2'])) {
			$this->data['invnameav2'] = $this->request->post['invnameav2'];
		} else {
			$this->data['invnameav2'] = $this->config->get('invnameav2');
		}
		
		if (isset($this->request->post['invname2c2'])) {
			$this->data['invname2c2'] = $this->request->post['invname2c2'];
		} else {
			$this->data['invname2c2'] = $this->config->get('invname2c2');
		}	

	if (isset($this->request->post['custfoot2'])) {
			$this->data['custfoot2'] = $this->request->post['custfoot2'];
		} else {
			$this->data['custfoot2'] = $this->config->get('custfoot2');
		}

if (isset($this->request->post['custfoot23'])) {
			$this->data['custfoot23'] = $this->request->post['custfoot23'];
		} else {
			$this->data['custfoot23'] = $this->config->get('custfoot23');
		}			

	if (isset($this->request->post['custfoot221'])) {
			$this->data['custfoot221'] = $this->request->post['custfoot221'];
		} else {
			$this->data['custfoot221'] = $this->config->get('custfoot221');
		}		

		if (isset($this->request->post['invpicav2'])) {
			$this->data['invpicav2'] = $this->request->post['invpicav2'];
		} else {
			$this->data['invpicav2'] = $this->config->get('invpicav2');
		}	

		if (isset($this->request->post['inv_skuca2'])) {
			$this->data['inv_skuca2'] = $this->request->post['inv_skuca2'];
		} else {
			$this->data['inv_skuca2'] = $this->config->get('inv_skuca2');
		}	
		
		$this->template = 'module/googleprint.tpl';
		$this->children = array(
			'common/header',
			'common/footer'	
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/googleprint')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
?>