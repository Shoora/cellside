<?php
class ControllerCatalogTestimonial extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->language('catalog/testimonial');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/testimonial');
		$this->getList();
	} 

	private function loadSetting($setting, $default = 0) {
		return isset($this->request->post[$setting]) ? $this->request->post[$setting] : (($this->config->get($setting)) ? $this->config->get($setting) : $default);
	}
	
	public function settings() {   
		$this->load->language('catalog/testimonial_settings');
		$this->data = $this->language->load('catalog/testimonial_settings');
		$this->load->model('setting/setting');
		$this->load->model('catalog/testimonial');

		$this->document->setTitle($this->language->get('heading_title'));
		
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			$settings_data = $this->request->post;
			$page_data = $settings_data['page_content'];
			unset($settings_data['page_content']);
			$this->model_catalog_testimonial->editPageContent($page_data);
			$this->model_setting_setting->editSetting('testimonial', $settings_data);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
				
		$this->data['token'] = $this->session->data['token'];
 		$this->data['error_warning'] = (isset($this->error['warning'])) ? $this->error['warning'] : '';
		$this->data['success']       = isset($this->session->data['success']) ? $this->session->data['success'] : '';
		if (isset($this->session->data['success'])) unset($this->session->data['error_warning']);

  		$this->data['breadcrumbs']   = array();
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_home'), 'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => false);
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_testimonials'), 'href' => $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => ' :: ');
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_settings'), 'href' => $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => ' :: ');
		
		$this->data['action'] = $this->url->link('catalog/testimonial/settings', 'token=' . $this->session->data['token'], 'SSL');		
		$this->data['cancel'] = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['testimonial'] = array();
		$this->data['page_content'] = $this->model_catalog_testimonial->getPageContent();
		
		// GENERAL SETTINGS CONFIG / FORM READ
		$this->data['testimonial_public_text_enabled']     = $this->loadSetting('testimonial_public_text_enabled');
		$this->data['testimonial_private_text_enabled']    = $this->loadSetting('testimonial_private_text_enabled');
		$this->data['testimonial_company_enabled']         = $this->loadSetting('testimonial_company_enabled');
		$this->data['testimonial_url_enabled']             = $this->loadSetting('testimonial_url_enabled');
		$this->data['testimonial_email_enabled']           = $this->loadSetting('testimonial_email_enabled');
		$this->data['testimonial_location_enabled']        = $this->loadSetting('testimonial_location_enabled');
		$this->data['testimonial_telephone_enabled']       = $this->loadSetting('testimonial_telephone_enabled');
		$this->data['testimonial_captcha_enabled']         = $this->loadSetting('testimonial_captcha_enabled');
		$this->data['testimonial_require_login']           = $this->loadSetting('testimonial_require_login');
		$this->data['testimonial_per_page']                = $this->loadSetting('testimonial_per_page');
		$this->data['testimonial_language_active_only']    = $this->loadSetting('testimonial_language_active_only');
		$this->data['testimonial_approval_mode']           = $this->loadSetting('testimonial_approval_mode');
		$this->data['testimonial_star_template']           = $this->loadSetting('testimonial_star_template');
		$this->data['testimonial_star_size']               = $this->loadSetting('testimonial_star_size');
		
		// COMPANY ADDRESS / OPTIMIZATION TYPE
		$this->data['testimonial_optimization_type']       = $this->loadSetting('testimonial_optimization_type', '');
		$this->data['testimonial_company']                 = $this->loadSetting('testimonial_company', '');
		$this->data['testimonial_address1']                = $this->loadSetting('testimonial_address1', '');
		$this->data['testimonial_address2']                = $this->loadSetting('testimonial_address2', '');
		$this->data['testimonial_city']                    = $this->loadSetting('testimonial_city', '');
		$this->data['testimonial_state']                   = $this->loadSetting('testimonial_state', '');
		$this->data['testimonial_postal_code']             = $this->loadSetting('testimonial_postal_code', '');
		$this->data['testimonial_country']                 = $this->loadSetting('testimonial_country', '');
		$this->data['testimonial_telephone']               = $this->loadSetting('testimonial_telephone', '');
		$this->data['testimonial_website']                 = $this->loadSetting('testimonial_website', '');

		// PRICE OF GOODS SOLD
		$this->data['testimonial_display_price']           = $this->loadSetting('testimonial_display_price');
		$this->data['testimonial_price_from']              = $this->loadSetting('testimonial_price_from');
		$this->data['testimonial_price_to']                = $this->loadSetting('testimonial_price_to');
		$this->data['testimonial_primary_currency']        = $this->loadSetting('testimonial_primary_currency');

		
		//EMAIL REMINDER SETTINGS 
		$this->data['testimonial_email_reminder_enabled']  = $this->loadSetting('testimonial_email_reminder_enabled');
		$this->data['testimonial_email_status']            = $this->loadSetting('testimonial_email_status', array());
		$this->data['testimonial_email_date']              = $this->loadSetting('testimonial_email_date');
		$this->data['testimonial_email_days']              = $this->loadSetting('testimonial_email_days');
		$this->data['testimonial_email_test']              = $this->loadSetting('testimonial_email_test', '');
		$this->data['testimonial_email_cron']              = $this->loadSetting('testimonial_email_cron', 'NOT YET RUN');
		
		
		//ORDER STATUS LOAD
		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
 
		
		//PAGE CONTENT CONFIG / FORM READ
		$this->load->model('localisation/language');		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		

		//LOAD STAR TEMPLATES
		$this->data['star_templates'] = array();
		$directories = glob(DIR_IMAGE . 'testimonials/*', GLOB_ONLYDIR);
		
		foreach ($directories as $directory) {
			$sizes = glob($directory . '/*', GLOB_ONLYDIR);
			$this->data['star_templates'][] = array('name' => basename($directory), 'subtext' => sprintf($this->language->get('text_star_template_sizes'), count($sizes)));
		}
		
		//LOAD TEMPLATE SIZE SELECTION
		$this->data['star_sizes'] = array();
		if ($this->data['testimonial_star_template']) {
			if (file_exists(DIR_IMAGE . 'testimonials/Boxed Flat Orange')) {
				$directories = glob(DIR_IMAGE . 'testimonials/Boxed Flat Orange/*', GLOB_ONLYDIR);
				
				foreach ($directories as $directory) {
					$name = explode('-', basename($directory));
					$this->data['star_sizes'][] = array('name' => $name[1], 'value' => basename($directory));
				}
			}
		}
		
		$this->template = 'catalog/testimonial_settings.tpl';
		$this->children = array('common/header', 'common/footer');				
		$this->response->setOutput($this->render());
	}
	
	public function insert() {
		$this->load->language('catalog/testimonial');
		$this->load->model('catalog/testimonial');
		$this->data = $this->load->language('catalog/testimonial');

		$this->document->setTitle($this->language->get('heading_title'));
		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_testimonial->addTestimonial($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			$url .= isset($this->request->get['sort']) ? '&sort=' . $this->request->get['sort'] : '';
			$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
			$url .= isset($this->request->get['page']) ? '&page=' . $this->request->get['page'] : '';
			$this->redirect($this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->load->language('catalog/testimonial');
		$this->load->model('catalog/testimonial');
		$this->data = $this->load->language('catalog/testimonial');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
		
			$this->model_catalog_testimonial->editTestimonial($this->request->get['testimonial_id'], $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			$url .= isset($this->request->get['sort'])  ? '&sort='  . $this->request->get['sort']  : '';
			$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
			$url .= isset($this->request->get['page'])  ?'&page='   . $this->request->get['page']  : '';
						
			$this->redirect($this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() { 
		$this->load->language('catalog/testimonial');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/testimonial');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $testimonial_id) {
				$this->model_catalog_testimonial->deleteTestimonial($testimonial_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			$url .= isset($this->request->get['sort'])  ? '&sort='  . $this->request->get['sort']  : '';
			$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
			$url .= isset($this->request->get['page'])  ?'&page='   . $this->request->get['page']  : '';
						
			$this->redirect($this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	private function getList() {
		$this->data = $this->load->language('catalog/testimonial');
		
		$sort  = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'date_added';
		$order = isset($this->request->get['order']) ? $this->request->get['order'] : 'ASC';
		$page  = isset($this->request->get['page']) ? $this->request->get['page'] : 1;
				
		$url  = '';
		$url .= isset($this->request->get['sort'])  ? '&sort='  . $this->request->get['sort']  : '';
		$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
		$url .= isset($this->request->get['page'])  ?'&page='   . $this->request->get['page']  : '';

  		$this->data['breadcrumbs']   = array();
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_home'), 'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => false);
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('heading_title'), 'href' => $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'), 'separator' => ' :: ');
							
		//SETUP BUTTONS
		$this->data['button_send_reminders'] = sprintf($this->language->get('button_send_reminders'), $this->model_catalog_testimonial->getTotalPendingReminders());
		$this->data['button_insert']         = $this->language->get('button_insert');
		$this->data['button_delete']         = $this->language->get('button_delete');
		$this->data['send_reminders']        = $this->url->link('catalog/testimonial/sendreminders', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['settings']              = $this->url->link('catalog/testimonial/settings', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['insert']                = $this->url->link('catalog/testimonial/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete']                = $this->url->link('catalog/testimonial/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['testimonials'] = array();

		$data = array('sort'  => $sort, 'order' => $order, 'start' => ($page - 1) * $this->config->get('config_admin_limit'), 'limit' => $this->config->get('config_admin_limit'));
		
		$testimonial_total = $this->model_catalog_testimonial->getTotalTestimonials();
	
		$results = $this->model_catalog_testimonial->getTestimonials($data);
 
    	foreach ($results as $result) {
			$action   = array();
			$action[] = array('text' => $this->language->get('text_edit'), 'href' => $this->url->link('catalog/testimonial/update', 'token=' . $this->session->data['token'] . '&testimonial_id=' . $result['testimonial_id'] . $url, 'SSL'));
						
			$this->data['testimonials'][] = array(
				'testimonial_id'  => $result['testimonial_id'],
				'title'       => $result['title'],
				'author'     => $result['author'],
				'rating'     => $result['rating'],
				'status'     => ($result['status'] ? $this->language->get('text_approved') : $this->language->get('text_disabled')),
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['testimonial_id'], $this->request->post['selected']),
				'action'     => $action
			);
		}	
	
		
 
		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		$this->data['success']       = isset($this->session->data['success']) ? $this->session->data['success'] : '';
		if (isset($this->session->data['success'])) unset($this->session->data['success']);
		if (isset($this->error['warning'])) unset($this->session->data['error_warning']);

		$url  = '';
		$url .= ($order == 'ASC') ? '&order=DESC' : '&order=ASC';
		$url .= isset($this->request->get['page']) ? '&page=' . $this->request->get['page'] : '';
		
		$this->data['sort_title']      = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . '&sort=title' . $url, 'SSL');
		$this->data['sort_author']     = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . '&sort=author' . $url, 'SSL');
		$this->data['sort_rating']     = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . '&sort=rating' . $url, 'SSL');
		$this->data['sort_status']     = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . '&sort=date_added' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $testimonial_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/testimonial_list.tpl';
		$this->children = array('common/header', 'common/footer');
				
		$this->response->setOutput($this->render());
	}

	private function getForm() {
	
		$this->data['heading_title']      = $this->language->get('heading_title');
		$this->data['text_enabled']       = $this->language->get('text_approved');
		$this->data['text_disabled']      = $this->language->get('text_disabled');
		$this->data['text_none']          = $this->language->get('text_none');
		$this->data['text_select']        = $this->language->get('text_select');

		$this->data['entry_title']        = $this->language->get('entry_title');
		$this->data['entry_author']       = $this->language->get('entry_author');
		$this->data['entry_company']      = $this->language->get('entry_company');
		$this->data['entry_location']     = $this->language->get('entry_location');
		$this->data['entry_url']          = $this->language->get('entry_url');
		$this->data['entry_telephone']    = $this->language->get('entry_telephone');
		$this->data['entry_email']        = $this->language->get('entry_email');
		$this->data['entry_rating']       = $this->language->get('entry_rating');
		$this->data['entry_status']       = $this->language->get('entry_status');
		$this->data['entry_public_text']  = $this->language->get('entry_public_text');
		$this->data['entry_private_text'] = $this->language->get('entry_private_text');
		$this->data['entry_good']         = $this->language->get('entry_good');
		$this->data['entry_bad']          = $this->language->get('entry_bad');
		$this->data['entry_language']     = $this->language->get('entry_language');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		$this->data['error_title']   = isset($this->error['title'])   ? $this->error['title'] : '';
		$this->data['error_author']  = isset($this->error['author'])  ? $this->error['author'] : '';
		$this->data['error_rating']  = isset($this->error['rating'])  ? $this->error['rating'] : '';

		$url = '';
		$url .= isset($this->request->get['sort'])  ? '&sort='  . $this->request->get['sort']  : '';
		$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
		$url .= isset($this->request->get['page'])  ?'&page='   . $this->request->get['page']  : '';
				
   		$this->data['breadcrumbs'] = array();
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('text_home'), 'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'), 'separator' => false);
   		$this->data['breadcrumbs'][] = array('text' => $this->language->get('heading_title'), 'href' => $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'), 'separator' => ' :: ');
										
		$this->data['action'] = !isset($this->request->get['testimonial_id']) ? $this->url->link('catalog/testimonial/insert', 'token=' . $this->session->data['token'] . $url, 'SSL') : $this->url->link('catalog/testimonial/update', 'token=' . $this->session->data['token'] . '&testimonial_id=' . $this->request->get['testimonial_id'] . $url, 'SSL');
		$this->data['cancel'] = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->get['testimonial_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$testimonial_info = $this->model_catalog_testimonial->getTestimonial($this->request->get['testimonial_id']);
		}
			

		if (isset($this->request->post['title'])) {
			$this->data['title'] = $this->loadSetting('title');
		} elseif (!empty($testimonial_info)) {
			$this->data['title'] = $testimonial_info['title'];
		} else {
			$this->data['title'] = '';
		}
				
		if (isset($this->request->post['store_id'])) {
			$this->data['store_id'] = $this->request->post['store_id'];
		} elseif (!empty($testimonial_info) && isset($testimonial_info['store_id'])) {
			$this->data['store_id'] = $testimonial_info['store_id'];
		} else {
			$this->data['store_id'] = '0';
		}

		if (isset($this->request->post['author'])) {
			$this->data['author'] = $this->request->post['author'];
		} elseif (!empty($testimonial_info)) {
			$this->data['author'] = $testimonial_info['author'];
		} else {
			$this->data['author'] = '';
		}

		if (isset($this->request->post['company'])) {
			$this->data['company'] = $this->request->post['company'];
		} elseif (!empty($testimonial_info)) {
			$this->data['company'] = $testimonial_info['company'];
		} else {
			$this->data['company'] = '';
		}

		if (isset($this->request->post['location'])) {
			$this->data['location'] = $this->request->post['location'];
		} elseif (!empty($testimonial_info)) {
			$this->data['location'] = $testimonial_info['location'];
		} else {
			$this->data['location'] = '';
		}
		
		if (isset($this->request->post['url'])) {
			$this->data['url'] = $this->request->post['url'];
		} elseif (!empty($testimonial_info)) {
			$this->data['url'] = $testimonial_info['url'];
		} else {
			$this->data['url'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($testimonial_info)) {
			$this->data['telephone'] = $testimonial_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} elseif (!empty($testimonial_info)) {
			$this->data['email'] = $testimonial_info['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['public_text'])) {
			$this->data['public_text'] = $this->request->post['public_text'];
		} elseif (!empty($testimonial_info)) {
			$this->data['public_text'] = $testimonial_info['public_text'];
		} else {
			$this->data['public_text'] = '';
		}

		if (isset($this->request->post['private_text'])) {
			$this->data['private_text'] = $this->request->post['private_text'];
		} elseif (!empty($testimonial_info)) {
			$this->data['private_text'] = $testimonial_info['private_text'];
		} else {
			$this->data['private_text'] = '';
		}
		
		if (isset($this->request->post['rating'])) {
			$this->data['rating'] = $this->request->post['rating'];
		} elseif (!empty($testimonial_info)) {
			$this->data['rating'] = $testimonial_info['rating'];
		} else {
			$this->data['rating'] = '';
		}

		if (isset($this->request->post['featured'])) {
			$this->data['featured'] = $this->request->post['featured'];
		} elseif (!empty($testimonial_info)) {
			$this->data['featured'] = $testimonial_info['featured'];
		} else {
			$this->data['featured'] = '';
		}
		
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['language_id'])) {
			$this->data['language_id'] = $this->request->post['language_id'];
		} elseif (!empty($testimonial_info)) {
			$this->data['language_id'] = $testimonial_info['language_id'];
		} else {
			$this->data['language_id'] = '';
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($testimonial_info)) {
			$this->data['status'] = $testimonial_info['status'];
		} else {
			$this->data['status'] = '';
		}

		if (isset($this->request->post['excerpt_public_text'])) {
			$this->data['excerpt_public_text'] = $this->request->post['excerpt_public_text'];
		} elseif (!empty($testimonial_info)) {
			$this->data['excerpt_public_text'] = $testimonial_info['excerpt_public_text'];
		} else {
			$this->data['excerpt_public_text'] = '';
		}
		
		if (isset($this->request->post['excerpt_title'])) {
			$this->data['excerpt_title'] = $this->request->post['excerpt_title'];
		} elseif (!empty($testimonial_info)) {
			$this->data['excerpt_title'] = $testimonial_info['excerpt_title'];
		} else {
			$this->data['excerpt_title'] = '';
		}
		
		$this->template = 'catalog/testimonial_form.tpl';
		$this->children = array('common/header', 'common/footer');
		$this->response->setOutput($this->render());
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/testimonial')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ((strlen($this->request->post['author']) < 3) || (strlen($this->request->post['author']) > 64)) {
			$this->error['author'] = $this->language->get('error_author');
		}

		if (strlen($this->request->post['title']) < 1) {
			$this->error['title'] = $this->language->get('error_title');
		}
				
		if (!isset($this->request->post['rating'])) {
			$this->error['rating'] = $this->language->get('error_rating');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/testimonial')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}	

	public function cronReminders() {
		$this->load->language('catalog/testimonial');
		$this->load->model('catalog/testimonial');

		$entries_processed = $this->model_catalog_testimonial->sendEmailReminders();
		$result =  sprintf($this->language->get('text_success_cron'), $entries_processed, date("Y-m-d H:i:s"));
		$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $result . "' WHERE `key` = 'testimonial_email_cron'");

	}
	
	public function sendReminders() {
		$this->load->language('catalog/testimonial');
		$this->load->model('catalog/testimonial');

		$entries_processed = $this->model_catalog_testimonial->sendEmailReminders();
		
		$this->session->data['success'] = sprintf($this->language->get('text_success_email'), $entries_processed);
		$url = '';
		$url .= isset($this->request->get['sort'])  ? '&sort='  . $this->request->get['sort']  : '';
		$url .= isset($this->request->get['order']) ? '&order=' . $this->request->get['order'] : '';
		$url .= isset($this->request->get['page'])  ?'&page='   . $this->request->get['page']  : '';
						
		$this->redirect($this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		$this->response->setOutput($this->render());
		
	}

	public function sendTestEmail() {
		$this->load->language('catalog/testimonial');
		$this->load->model('catalog/testimonial');
		$this->load->model('setting/setting');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$settings_data = $this->request->post;
			$page_data = $settings_data['page_content'];
			unset($settings_data['page_content']);
			$this->model_catalog_testimonial->editPageContent($page_data);
			$this->model_setting_setting->editSetting('testimonial', $settings_data);
			
			// Re-Load Settings
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");
			 
			foreach ($query->rows as $setting) {
				if (!$setting['serialized']) {
					$this->config->set($setting['key'], $setting['value']);
				} else {
					$this->config->set($setting['key'], unserialize($setting['value']));
				}
			}
		}		
		$entries_processed = $this->model_catalog_testimonial->sendEmailTest();
		$this->session->data['success'] = sprintf($this->language->get('text_success_email'), $entries_processed);
		$this->redirect($this->url->link('catalog/testimonial/settings', 'token=' . $this->session->data['token'], 'SSL'));
		$this->response->setOutput($this->render());
	}
	
}
?>