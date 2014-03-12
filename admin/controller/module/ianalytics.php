<?php
class ControllerModuleIanalytics extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/ianalytics');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		$this->data['error_warning'] = '';
		
		$this->document->addScript('view/javascript/ianalytics/bootstrap/js/bootstrap.min.js');
		$this->document->addStyle('view/javascript/ianalytics/bootstrap/css/bootstrap.min.css');
		$this->document->addStyle('view/javascript/ianalytics/font-awesome/css/font-awesome.min.css');
		$this->document->addStyle('view/stylesheet/ianalytics.css');		

		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			if (!$this->user->hasPermission('modify', 'module/ianalytics')) {
				$this->validate();
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}

			if (!empty($_POST['OaXRyb1BhY2sgLSBDb21'])) {
				$this->request->post['iAnalytics']['LicensedOn'] = $_POST['OaXRyb1BhY2sgLSBDb21'];
			}
			if (!empty($_POST['cHRpbWl6YXRpb24ef4fe'])) {
				$this->request->post['iAnalytics']['License'] = json_decode(base64_decode($_POST['cHRpbWl6YXRpb24ef4fe']),true);
			}

			
			$this->model_setting_setting->editSetting('iAnalytics', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
			
			if (!empty($_GET['activate'])) {
				$this->session->data['success'] = $this->language->get('text_success_activation');
			}
			
			$selectedTab = (empty($this->request->post['selectedTab'])) ? 0 : $this->request->post['selectedTab'];
			$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'] . '&tab='.$selectedTab, 'SSL'));
		}
		
		$this->load->model('catalog/ianalytics');
		$this->model_catalog_ianalytics->getAnalyticsData($this->data);
		$this->data['iAnalyticsStatus'] = $this->model_setting_setting->getSetting('iAnalyticsStatus');
		$result = $this->db->query("
			SELECT table_name
			FROM information_schema.tables
			WHERE table_schema = '".DB_DATABASE."'
			AND (table_name = '".DB_PREFIX."ianalytics_product_comparisons' OR table_name = '".DB_PREFIX."ianalytics_product_opens' OR table_name = '".DB_PREFIX."ianalytics_search_data');");
		
		//create database table;
		if ($result->num_rows == 0) {
			$this->data['error_warning'] = 'Some of the needed tables were not created. Please make sure you have CREATE privileges for your database.';
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_code'] = $this->language->get('entry_code');
		
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['entry_layouts_active'] = $this->language->get('entry_layouts_active');
		$this->data['entry_highlightcolor'] = $this->language->get('entry_highlightcolor');
				
 		if (isset($this->error['code'])) {
			$this->data['error_code'] = $this->error['code'];
		} else {
			$this->data['error_code'] = '';
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
			'href'      => $this->url->link('module/ianalytics', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/ianalytics', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['currenttemplate'] =  $this->config->get('config_template');

		$this->data['modules'] = array();
		
		if (isset($this->request->post['ianalytics_module'])) {
			$this->data['modules'] = $this->request->post['ianalytics_module'];
			exit;
		} elseif ($this->config->get('ianalytics_module')) { 
			$this->data['modules'] = $this->config->get('ianalytics_module');
		}
			
				
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/ianalytics.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function pausegatheringdata() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('iAnalyticsStatus', array('status' => 'pause'));
		$this->session->data['success'] = 'iAnalytics data gathering is now <strong>paused</strong>.';
		$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'], 'SSL'));

	}

	public function resumegatheringdata() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('iAnalyticsStatus', array('status' => 'run'));
		$this->session->data['success'] = 'iAnalytics data gathering is now <strong>resumed</strong>.';
		$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	public function deletesearchkeyword() {
		if (!$this->user->hasPermission('modify', 'module/ianalytics')) {
			$this->validate();
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->language('module/ianalytics');
		
		
		if (!empty($_GET['searchValue'])) {
			$this->load->model('catalog/ianalytics');
			$this->model_catalog_ianalytics->deleteSearchKeyword($_GET['searchValue']);
			
			$this->session->data['success'] = $this->language->get('deleted_keyword');
		}
		
		$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'] . '&tab=1&searchTab=1', 'SSL'));
	}
	
	public function deleteallsearchkeyword() {
		if (!$this->user->hasPermission('modify', 'module/ianalytics')) {
			$this->validate();
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->language('module/ianalytics');
		
		
		if (!empty($_GET['searchValue'])) {
			$this->load->model('catalog/ianalytics');
			$this->model_catalog_ianalytics->deleteAllSearchKeyword($_GET['searchValue']);
			
			$this->session->data['success'] = $this->language->get('deleted_keyword');
		}
		
		$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'] . '&tab=1&searchTab=1', 'SSL'));
	}
	
	public function deleteanalyticsdata() {
		if (!$this->user->hasPermission('modify', 'module/ianalytics')) {
			$this->validate();
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->language('module/ianalytics');
		
		$this->load->model('catalog/ianalytics');
		$this->model_catalog_ianalytics->deleteAnalyticsData();
		
		$this->session->data['success'] = $this->language->get('deleted_analytics_data');
		
		$this->redirect($this->url->link('module/ianalytics', 'token=' . $this->session->data['token'] . '&tab=3', 'SSL'));
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/ianalytics')) {
			$this->error = true;
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
}
?>