<?php
class ControllerModulePtestimonial extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/ptestimonial');
		$this->load->model('setting/setting');
		$this->data = $this->load->language('module/ptestimonial');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['testimonial_version'] = "2.0";
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('ptestimonial', $this->request->post);		
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['text_display_title'] = $this->language->get('text_display_title');
		$this->data['text_display_title_description'] = $this->language->get('text_display_description');
		$this->data['text_display_order_latest'] = $this->language->get('text_display_order_latest');
		$this->data['text_display_order_random'] = $this->language->get('text_display_order_random');
		
		$this->data['text_required_field'] = $this->language->get('text_required_field');
		$this->data['text_help']           = $this->language->get('text_help');
		$this->data['text_content_top']    = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left']    = $this->language->get('text_column_left');
		$this->data['text_column_right']   = $this->language->get('text_column_right');
		$this->data['text_enabled']        = $this->language->get('text_enabled');
		$this->data['text_disabled']       = $this->language->get('text_disabled');
		$this->data['text_left']           = $this->language->get('text_left');
		$this->data['text_right']          = $this->language->get('text_right');

		$this->data['button_add_module']   = $this->language->get('button_add_module');
		$this->data['button_remove']       = $this->language->get('button_remove');
		$this->data['button_save']         = $this->language->get('button_save');
		$this->data['button_cancel']       = $this->language->get('button_cancel');

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['tab_module']    = $this->language->get('tab_module');
		$this->data['token']         = $this->session->data['token'];
		$this->data['action']        = $this->url->link('module/ptestimonial', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel']        = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

  		$this->data['breadcrumbs']   = array();
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_home'), 'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => false);
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_module'), 'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => ' :: ');
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('heading_title'), 'href' => $this->url->link('module/ptestimonial', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => ' :: ');

		//LOAD MODULE VALUE DATA
		$this->data['modules'] = array();
		if (isset($this->request->post['ptestimonial_module'])) {
			$this->data['modules'] = $this->request->post['ptestimonial_module'];
		} elseif ($this->config->get('ptestimonial_module')) { 
			$this->data['modules'] = $this->config->get('ptestimonial_module');
		}
		
		//LOAD STAR TEMPLATES SELECTION
		$this->data['star_templates'] = array();
		$directories = glob(DIR_IMAGE . 'testimonials/*', GLOB_ONLYDIR);
		
		foreach ($directories as $directory) {
			$sizes = glob($directory . '/*', GLOB_ONLYDIR);
			$this->data['star_templates'][] = array('name' => basename($directory), 'subtext' => sprintf($this->language->get('text_star_template_sizes'), count($sizes)));
		}

		//LOAD STAR TEMPLATE SIZE SELECTION
		$this->data['star_sizes'] = array();
		if (file_exists(DIR_IMAGE . 'testimonials/Boxed Flat Orange')) {
			$directories = glob(DIR_IMAGE . 'testimonials/Boxed Flat Orange/*', GLOB_ONLYDIR);
		
			foreach ($directories as $directory) {
				$name = explode('-', basename($directory));
				$this->data['star_sizes'][] = array('name' => $name[1], 'value' => basename($directory));
			}
		}
		
		if (isset($this->request->post['testimonial_title'])) {
			$this->data['testimonial_title'] = $this->request->post['testimonial_title'];
		} else {
			$this->data['testimonial_title'] = $this->config->get('testimonial_title');
		}

		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';


		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();


		$this->template = 'module/ptestimonial.tpl';
		$this->children = array('common/header', 'common/footer');
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/ptestimonial')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}


	public function install() { }
	public function uninstall() { }
}
?>