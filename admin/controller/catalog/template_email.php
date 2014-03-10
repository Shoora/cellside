<?php
class ControllerCatalogTemplateEmail extends Controller {
	private $error = array();
	private $emails = array('customer' => array('register', 'register.approval', 'password.reset', 'approve', 'voucher'), 'affiliate' => array('register', 'password.reset', 'approve', 'order', 'add.transaction'), 'contact' => array('confirmation'), 'reviews' => array('added'), 'cron' => array('invoice'));
	private $template_id = array('return_', 'mail_');

	public function index() {
		$query_te = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "template_email'");

		if ($query_te->num_rows > 0) {
			
		} else {
			$this->redirect($this->url->link('catalog/template_email/installdb', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->load->language('catalog/template_email');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/template_email');
		
		$this->getList();
	}

	public function update() {
		$this->load->language('catalog/template_email');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/template_email');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_template_email->editEmail($this->request->get['id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

	public function delete() { 
		$this->load->language('catalog/template_email');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/template_email');

		$selected_ids = array();

		if (isset($this->request->post['sselected'])) {
			$selected_ids[] = $this->request->post['sselected'];
		}

		if (isset($this->request->post['eselected'])) {
			$selected_ids[] = $this->request->post['eselected'];
		}

		/*if (isset($this->request->post['rselected'])) {
			$selected_ids[] = $this->request->post['rselected'];
		}*/

		if (isset($this->request->post['mselected'])) {
			$selected_ids[] = $this->request->post['mselected'];
		}

		if ($selected_ids && $this->validateDelete()) {
			foreach ($selected_ids as $ids) {
				foreach ($ids as $id) {
					$this->model_catalog_template_email->deleteEmail($id);
				}
			}

			$this->session->data['success'] = $this->language->get('text_delete_success');
						
			$this->redirect($this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getList();
	}

	private function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
				
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/template_email', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
						
		$this->load->model('localisation/order_status');
		//$this->load->model('localisation/return_status');

		$this->data['delete'] = $this->url->link('catalog/template_email/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
		$this->data['promo_insert'] = $this->url->link('catalog/template_email/promo', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['order_statuses'] = array();
		$this->data['return_statuses'] = array();
		$this->data['services'] = array();
		$this->data['mails'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => 0,
			'limit' => 100
		);

		$results = $this->model_localisation_order_status->getOrderStatuses($data);
 
    	foreach ($results as $result) {
			$action = array();

			$result_email = $this->model_catalog_template_email->getTemplateEmailByOrderStatusId($result['order_status_id']);
			$email_name = '- - -';

			if ($result_email) {
				$email_name = ($result_email['name'] <> '') ? '<a onClick="window.open(\'' . $this->url->link('catalog/template_email/email', 'token=' . $this->session->data['token'] . '&id=' . $result['order_status_id'] . $url, 'SSL') . '\')">' . $result_email['name'] . '</a>' : '- - -';
			}
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=' . $result['order_status_id'] . $url, 'SSL')
			);

			$this->data['order_statuses'][] = array(
				'order_status_id' => $result['order_status_id'],
				'name'            => $result['name'] . (($result['order_status_id'] == $this->config->get('config_order_status_id')) ? $this->language->get('text_default') : null),
				'selected'        => isset($this->request->post['sselected']) && in_array($result['order_status_id'], $this->request->post['sselected']),
				'template_name'   => $email_name,
				'action'          => $action
			);
		}

		/*$results = $this->model_localisation_return_status->getReturnStatuses($data);

		foreach ($results as $result) {
			$action = array();

			$result_email = $this->model_catalog_template_email->getTemplateEmailByReturnStatusId('return_' . $result['return_status_id']);
			$email_name = '- - -';

			if ($result_email) {
				$email_name = ($result_email['name'] <> '') ? '<a onClick="window.open(\'' . $this->url->link('catalog/template_email/email', 'token=' . $this->session->data['token'] . '&id=return_' . $result['return_status_id'] . $url, 'SSL') . '\')">' . $result_email['name'] . '</a>' : '- - -';
			}
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=return_' . $result['return_status_id'] . $url, 'SSL')
			);

			$this->data['return_statuses'][] = array(
				'return_status_id' => 'return_' . $result['return_status_id'],
				'name'             => $result['name'] . (($result['return_status_id'] == $this->config->get('config_return_status_id')) ? $this->language->get('text_default') : null),
				'selected'         => isset($this->request->post['rselected']) && in_array($result['return_status_id'], $this->request->post['rselected']),
				'template_name'    => $email_name,
				'action'           => $action
			);
		}*/

		$this->data['promo'] = $this->model_catalog_template_email->getPromoText();

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['entry_template_promo'] = $this->language->get('entry_template_promo');
		$this->data['entry_generate_invoice'] = $this->language->get('entry_generate_invoice');
		$this->data['entry_generate_invoice_status'] = $this->language->get('entry_generate_invoice_status');
		$this->data['entry_statuses_to_admin'] = $this->language->get('entry_statuses_to_admin');
		$this->data['entry_send_invoice'] = $this->language->get('entry_send_invoice');
		$this->data['entry_thumbnail_image_product'] = $this->language->get('entry_thumbnail_image_product');
		$this->data['entry_cron'] = $this->language->get('entry_cron');
		$this->data['entry_cron_send_invoice'] = $this->language->get('entry_cron_send_invoice');
		$this->data['entry_cron_send_invoice_from'] = $this->language->get('entry_cron_send_invoice_from');
		$this->data['entry_cron_send_invoice_date_empty'] =  $this->language->get('entry_cron_send_invoice_date_empty');

		$this->data['column_action'] = $this->language->get('column_action');
		$this->data['column_template_email'] = $this->language->get('column_template_email');
		$this->data['column_id'] = $this->language->get('column_id');

		$this->data['tab_type1'] = $this->language->get('tab_type1');
		$this->data['tab_type2'] = $this->language->get('tab_type2');
		$this->data['tab_type3'] = $this->language->get('tab_type3');
		$this->data['tab_type4'] = $this->language->get('tab_type4');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_mail'] = $this->language->get('button_mail');

		$link = explode('admin/', $this->url->link('common/template_email/croninvoice'));
		$this->data['text_cron_link'] = sprintf($this->language->get('text_cron_link'), $link[0] . $link[1]);
		$this->data['text_to'] = $this->language->get('text_to');
		$this->data['text_count_orders'] = sprintf($this->language->get('text_count_orders'), $this->model_catalog_template_email->getTotalOrdersByDate($this->config->get('template_email_send_invoice_from'), $this->config->get('template_email_send_invoice_to')));
 
		$this->load->model('localisation/language');
 
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		$this->data['sort_name'] = $this->url->link('catalog/template_email', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->post['template_email_send_invoice'])) {
			$this->data['template_email_send_invoice'] = 'checked';
		} elseif ($this->config->get('template_email_send_invoice')) {
			$this->data['template_email_send_invoice'] = ($this->config->get('template_email_send_invoice') == 1) ? 'checked' : '';
		} else {
			$this->data['template_email_send_invoice'] = '';
		}

		if (isset($this->request->post['template_email_send_invoice_from'])) {
			$this->data['template_email_send_invoice_from'] = $this->request->post['template_email_send_invoice_from'];
		} elseif ($this->config->get('template_email_send_invoice_from')) {
			$this->data['template_email_send_invoice_from'] = $this->config->get('template_email_send_invoice_from');
		} else {
			$this->data['template_email_send_invoice_from'] = '';
		}

		if (isset($this->request->post['template_email_send_invoice_to'])) {
			$this->data['template_email_send_invoice_to'] = $this->request->post['template_email_send_invoice_to'];
		} elseif ($this->config->get('template_email_send_invoice_to')) {
			$this->data['template_email_send_invoice_to'] = $this->config->get('template_email_send_invoice_to');
		} else {
			$this->data['template_email_send_invoice_to'] = '';
		}

		if (isset($this->request->post['template_email_generate_invoice'])) {
			$this->data['template_email_generate_invoice'] = 'checked';
		} elseif ($this->config->get('template_email_generate_invoice')) {
			$this->data['template_email_generate_invoice'] = ($this->config->get('template_email_generate_invoice') == 1) ? 'checked' : '';
		} else {
			$this->data['template_email_generate_invoice'] = '';
		}

		if (isset($this->request->post['template_email_generate_invoice_status'])) {
			$this->data['template_email_generate_invoice_status'] = $this->request->post['template_email_generate_invoice_status'];
		} elseif ($this->config->get('template_email_generate_invoice_status')) {
			$this->data['template_email_generate_invoice_status'] = $this->config->get('template_email_generate_invoice_status');
		} else {
			$this->data['template_email_generate_invoice_status'] = '0';
		}

		if (isset($this->request->post['template_email_statuses_to_admin'])) {
			$this->data['template_email_statuses_to_admin'] = 'checked';
		} elseif ($this->config->get('template_email_statuses_to_admin')) {
			$this->data['template_email_statuses_to_admin'] = ($this->config->get('template_email_statuses_to_admin') == 1) ? 'checked' : '';
		} else {
			$this->data['template_email_statuses_to_admin'] = '';
		}

		if (isset($this->request->post['template_email_product_thumbnail_width'])) {
			$this->data['template_email_product_thumbnail_width'] = $this->request->post['template_email_product_thumbnail_width'];
		} elseif ($this->config->get('template_email_product_thumbnail_width')) {
			$this->data['template_email_product_thumbnail_width'] = $this->config->get('template_email_product_thumbnail_width');
		} else {
			$this->data['template_email_product_thumbnail_width'] = '';
		}

		if (isset($this->request->post['template_email_product_thumbnail_height'])) {
			$this->data['template_email_product_thumbnail_height'] = $this->request->post['template_email_product_thumbnail_height'];
		} elseif ($this->config->get('template_email_product_thumbnail_height')) {
			$this->data['template_email_product_thumbnail_height'] = $this->config->get('template_email_product_thumbnail_height');
		} else {
			$this->data['template_email_product_thumbnail_height'] = '';
		}

		foreach ($this->emails as $key => $email) {
			foreach ($email as $ek => $value) {
				$action = array();

				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=' . $key . '.' . $value . $url, 'SSL')
				);

				$email_name = '- - -';
				$result_title = $this->model_catalog_template_email->getTemplateEmailByOrderStatusId($key . '.' . $value);

				if ($result_title) {
					$email_name = ($result_title['name'] <> '') ? '<a onClick="window.open(\'' . $this->url->link('catalog/template_email/email', 'token=' . $this->session->data['token'] . '&id=' . $key . '.' . $value . $url, 'SSL') . '\')">' . $result_title['name'] . '</a>' : '- - -';
				}

				$this->data['services'][] = array (
					'id'            => $key . '.' . $value,
					'name'          => $key . '.' . $value,
					'selected'      => isset($this->request->post['eselected']) && in_array($key . '.' . $value, $this->request->post['eselected']),
					'template_name' => $email_name,
					'action'        => $action
				);
			}
		}

		$results = $this->model_catalog_template_email->getTemplateEmailForMail();
		$template_mail_last_id = '0';
 
    	foreach ($results as $result) {
			$action = array();

			$email_name = '- - -';

			if ($result['name']) {
				$email_name = '<a onClick="window.open(\'' . $this->url->link('catalog/template_email/email', 'token=' . $this->session->data['token'] . '&id=' . $result['id'] . $url, 'SSL') . '\')">' . $result['name'] . '</a>';
			}
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=' . $result['id'] . $url, 'SSL')
			);

			$this->data['mails'][] = array(
				'id'              => $result['id'],
				'name'            => $result['id'],
				'selected'        => isset($this->request->post['mselected']) && in_array($result['id'], $this->request->post['mselected']),
				'template_name'   => $email_name,
				'action'          => $action
			);

			$template_mail_last_id = preg_replace('/[^0-9]+/', '', $result['id']);
		}

		$this->data['mail_template_insert'] = $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=mail_' . ($template_mail_last_id + 1), 'SSL');

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/template_email_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
  	}

	private function getForm() {
		if (!isset($this->request->get['id']) && strlen($this->request->get['id']) <= 0) {
			$this->redirect($this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL'));
		}

     	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_template_name'] = $this->language->get('entry_template_name');
		$this->data['entry_template_description'] = $this->language->get('entry_template_description');
		$this->data['entry_template_status'] = $this->language->get('entry_template_status');
		$this->data['entry_template_special'] = $this->language->get('entry_template_special');
		$this->data['entry_template_promo'] = $this->language->get('entry_template_promo');
		$this->data['entry_template_track'] = $this->language->get('entry_template_track');

		if (strpos($this->request->get['id'], 'mail_') !== false) {
			$load_short_code = 'mail_';
		} else {
			$load_short_code = (strpos($this->request->get['id'], '.')) ? str_replace('.', '_', $this->request->get['id']) . '_' : '';

			if (strlen($load_short_code) <= 0 && ($this->request->get['id'] == $this->config->get('config_order_status_id'))) {
				$load_short_code = 'default_';
			}
		}

		$this->data['entry_template_shortcode'] = $this->language->get('entry_template_' . $load_short_code . 'shortcode');

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
    
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}
		
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
      	 	'text'      => $this->language->get('text_home'),	
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/template_email', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('catalog/template_email/update', 'token=' . $this->session->data['token'] . '&id=' . $this->request->get['id'] . $url, 'SSL');
			
		$this->data['cancel'] = $this->url->link('catalog/template_email', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$this->data['id'] = $this->request->get['id'];
		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$template_email_info = $this->model_catalog_template_email->getTemplateEmail($this->request->get['id']);

		if (isset($this->request->post['email_description'])) {
			$this->data['email_description'] = $this->request->post['email_description'];
		} elseif (isset($this->request->get['id'])) {
			$this->data['email_description'] = $template_email_info['description'];
		} else {
			$this->data['email_description'] = array();
		}

		if (isset($this->request->post['email_status'])) {
			$this->data['email_status'] = 'checked';
		} elseif (isset($this->request->get['id'])) {
			$this->data['email_status'] = ($template_email_info['status'] == 1) ? 'checked' : '';
		} else {
			$this->data['email_status'] = '';
		}

		if (isset($this->request->post['email_track'])) {
			$this->data['email_track'] = 'checked';
		} elseif (isset($this->request->get['id'])) {
			$this->data['email_track'] = ($template_email_info['track'] == 1) ? 'checked' : '';
		} else {
			$this->data['email_track'] = '';
		}

		$this->data['email_specials'] = array('2', '3', '4', '5', '10', '15');

		if (isset($this->request->post['email_special'])) {
			$this->data['email_special'] = $this->request->post['email_special'];
		} elseif (isset($this->request->get['id'])) {
			$this->data['email_special'] = $template_email_info['special'];
		} else {
			$this->data['email_special'] = 0;
		}

		$this->template = 'catalog/template_email_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());	
  	}

	public function email() {
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['direction'] = $this->language->get('direction');
		$this->data['language'] = $this->language->get('code');
		$this->data['name'] = '';
		$this->data['description'] = '';

		$this->load->model('catalog/template_email');

		if (isset($this->request->get['id'])) {
			$result = $this->model_catalog_template_email->getTemplateEmailByOrderStatusId($this->request->get['id']);
	
			$this->data['name'] = $result['name'];
			$this->data['description'] = $result['description'];
		}

		$this->template = 'catalog/template_email_preview.tpl';

		$this->response->setOutput($this->render());
	}

	public function promo() {
		$this->load->language('catalog/template_email');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/template_email');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePromoForm()) {
			$this->model_catalog_template_email->addTextPromo($this->request->post['promo']);
			unset($this->request->post['promo']);

			$this->load->model('setting/setting');

			$this->model_setting_setting->editSetting('template_email', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getList();
	}

	public function loadtemplate() {
		if (isset($this->request->get['id']) && utf8_strlen($this->request->get['id']) > 1) {
			$this->load->model('catalog/template_email');

			$result = $this->model_catalog_template_email->getTemplateEmail($this->request->get['id']);
			$output = $result['description'][(int)$this->config->get('config_language_id')]['description'];

			//$this->response->Header('Content-Type: text/html; charset=utf-8');
			//echo htmlspecialchars($output);
			$this->response->setOutput($output);
		}
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/template_email')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['email_description'] as $language_id => $value) {
			if ((strlen(utf8_decode($value['name'])) < 2) || (strlen(utf8_decode($value['name'])) > 180)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}
		
		if ((!isset($this->request->post['id']) || !isset($this->request->get['id'])) || $this->request->post['id'] != $this->request->get['id']) {
			$this->error['warning'] = $this->language->get('error_status_id');
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/template_email')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validatePromoForm() {
		if (!$this->user->hasPermission('modify', 'catalog/template_email')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'catalog/template_email')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function installdb() {
		$this->load->language('catalog/template_email');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_install'),
			'href'      => $this->url->link('catalog/template_email/installdb', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['heading_title'] = $this->language->get('heading_title_install');

		$this->data['action'] = $this->url->link('catalog/template_email/installdb', 'token=' . $this->session->data['token'] . '&install=true', 'SSL');

		if ($this->validate()) {
			if (!empty($this->request->get['install'])) {
				$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "template_email");
				//$this->db->query("ALTER TABLE " . DB_PREFIX . "order_history DROP COLUMN `email_track`");
				//$this->db->query("ALTER TABLE `" . DB_PREFIX . "order` DROP COLUMN `invoice_sent`");

				$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "template_email (
					`id` varchar(80) COLLATE utf8_bin NOT NULL,
					`language_id` int(11) NOT NULL,
					`name` varchar(180) COLLATE utf8_bin NOT NULL,
					`description` text COLLATE utf8_bin NOT NULL,
					`status` tinyint(1) NOT NULL DEFAULT '0',
					`track` tinyint(1) NOT NULL DEFAULT '0',
					`special` tinyint(2) NOT NULL DEFAULT '0',
					`promo` varchar(200) COLLATE utf8_bin NOT NULL,
					PRIMARY KEY (`id`,`language_id`),
					KEY `name` (`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("ALTER TABLE " . DB_PREFIX . "order_history ADD `email_track` VARCHAR(255) NOT NULL DEFAULT '----------'");

				$this->db->query("ALTER TABLE `" . DB_PREFIX . "order` ADD `invoice_sent` TINYINT(1) NOT NULL DEFAULT '0'");

				$this->session->data['success'] = $this->language->get('text_success_install');

				$this->redirect($this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->template = 'catalog/template_email_install.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
}
?>