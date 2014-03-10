<?php 
class ControllerProducttestimonial extends Controller {
	private $error = array(); 
	
	public function index() {
	
    	$this->language->load('product/testimonial');		
		$this->load->model('catalog/testimonial');
		
		$this->data['page_content'] = array();
		$this->data['page_content'] = $this->model_catalog_testimonial->getPageContent();

		$this->data['page_content']['heading_content'] = html_entity_decode($this->data['page_content']['heading_content']);
		$this->data['page_content']['form_content'] = html_entity_decode($this->data['page_content']['form_content']);
		$this->data['heading_title'] = $this->data['page_content']['heading_title'];

		$this->data['breadcrumbs']   = array();
		$this->data['breadcrumbs'][] = array('href' => $this->url->link('common/home'), 'text' => $this->language->get('text_home'), 'separator' => FALSE);
   		$this->data['breadcrumbs'][] = array('href' => $this->url->link('product/testimonial'), 'text' => $this->data['page_content']['heading_title'], 'separator' => $this->language->get('text_separator'));

		
		//SET PAGE TITLE AND META DATA
		$this->document->setTitle($this->data['page_content']['page_title']);
		$this->document->setDescription($this->data['page_content']['meta_description']);
		$this->document->setKeywords($this->data['page_content']['meta_keywords']);
			
		$testimonial_total = $this->model_catalog_testimonial->getTotalTestimonials();
			
						
		$this->data['text_author']              = $this->language->get('text_author');
		$this->data['text_rating']              = $this->language->get('text_rating');
		$this->data['text_success_message']     = $this->language->get('text_success_message');
		$this->data['text_no_rating']           = $this->language->get('text_no_rating');
		$this->data['text_login_required']      = $this->language->get('text_login_required');
		$this->data['text_login_required_link'] = $this->language->get('text_login_required_link');
		$this->data['login_required_link']      = $this->url->link('account/login');
		$this->data['text_login_required']      = sprintf($this->language->get('text_login_required'), 
														'<a href="' . $this->url->link('account/login') . '">' . $this->language->get('text_login_required_link') . '</a>');
		
		$this->data['button_submit_testimonial'] = $this->language->get('button_submit_testimonial');

		$this->data['entry_title']        = $this->language->get('entry_title');
		$this->data['entry_author']       = $this->language->get('entry_author');
		$this->data['entry_private_text'] = $this->language->get('entry_private_text');
		$this->data['entry_public_text']  = $this->language->get('entry_public_text');
		$this->data['entry_url']          = $this->language->get('entry_url');
		$this->data['entry_company']      = $this->language->get('entry_company');
		$this->data['entry_location']     = $this->language->get('entry_location');
		$this->data['entry_email']        = $this->language->get('entry_email');
		$this->data['entry_telephone']    = $this->language->get('entry_telephone');
		$this->data['entry_captcha']      = $this->language->get('entry_captcha');
		$this->data['entry_rating']       = $this->language->get('entry_rating');
		$this->data['entry_good']         = $this->language->get('entry_good');
		$this->data['entry_bad']          = $this->language->get('entry_bad');
			
			
		//READ CONFIG SETTINGS FOR TESTIMONIAL MODULE
		$this->data['settings']['public_text_enabled']  = $this->config->get('testimonial_public_text_enabled');
		$this->data['settings']['private_text_enabled'] = $this->config->get('testimonial_private_text_enabled');
		$this->data['settings']['company_enabled']      = $this->config->get('testimonial_company_enabled');
		$this->data['settings']['location_enabled']     = $this->config->get('testimonial_location_enabled');
		$this->data['settings']['url_enabled']          = $this->config->get('testimonial_url_enabled');
		$this->data['settings']['telephone_enabled']    = $this->config->get('testimonial_telephone_enabled');
		$this->data['settings']['email_enabled']        = $this->config->get('testimonial_email_enabled');
		$this->data['settings']['captcha_enabled']      = $this->config->get('testimonial_captcha_enabled');
		$this->data['settings']['require_login']        = $this->config->get('testimonial_require_login');
		$this->data['settings']['star_template']        = $this->config->get('testimonial_star_template');
		$this->data['settings']['star_size']            = $this->config->get('testimonial_star_size');
			
		//READ COMPANY DATA / SEO SETTINGS
		$this->data['website']['company']     = $this->config->get('testimonial_company');
		$this->data['website']['address']     = $this->config->get('testimonial_address1');
		$this->data['website']['city']        = $this->config->get('testimonial_city');
		$this->data['website']['state']       = $this->config->get('testimonial_state');
		$this->data['website']['postal_code'] = $this->config->get('testimonial_postal_code');
		$this->data['website']['country']     = $this->config->get('testimonial_country');
		$this->data['website']['website']     = $this->config->get('testimonial_website');
		$this->data['website']['telephone']   = $this->config->get('testimonial_telephone');
		$summary                              =  $this->model_catalog_testimonial->getSummaryData();
		$this->data['website']['total']       = $summary['total'];
		$this->data['website']['rating']      = $summary['rating'];

			
		// FORM DATA
		$this->data['action'] = $this->url->link('product/testimonial');
		if (isset($this->request->post['author'])) {
			$this->data['author'] = $this->request->post['author'];
		} elseif ($this->customer->isLogged()) {
			$this->data['author'] = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
		} else {
			$this->data['author'] = '';
		}
		$this->data['title']        = (isset($this->request->post['title'])) ? $this->request->post['title'] : '';
		$this->data['public_text']  = (isset($this->request->post['public_text'])) ? $this->request->post['public_text'] : '';
		$this->data['private_text'] = (isset($this->request->post['private_text'])) ? $this->request->post['private_text'] : '';
		$this->data['company']      = (isset($this->request->post['company'])) ? $this->request->post['company'] : '';
		$this->data['location']     = (isset($this->request->post['location'])) ? $this->request->post['location'] : '';
		$this->data['telephone']    = (isset($this->request->post['telephone'])) ? $this->request->post['telephone'] : '';
		$this->data['email']        = (isset($this->request->post['email'])) ? $this->request->post['email'] : '';
		$this->data['url']          = (isset($this->request->post['url'])) ? $this->request->post['url'] : '';
		$this->data['rating']       = (isset($this->request->post['rating'])) ? $this->request->post['rating'] : '';
		$this->data['captcha']      = (isset($this->request->post['captcha'])) ? $this->request->post['captcha'] : '';

			
		if (!$testimonial_total) {
			//$this->data->breadcrumbs[] = array(
			//		'href'      => $this->url->link('product/testimonial'),
			//		'text'      => $this->language->get('text_error'),
			//		'separator' => $this->language->get('text_separator')
			//	);
				
	  		$this->document->setTitle ($this->language->get('text_error'));
      		$this->data['heading_title'] = $this->language->get('text_error');
      		$this->data['text_error'] = $this->language->get('text_error');
      		$this->data['button_continue'] = $this->language->get('button_continue');
      		$this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';
		}
	
		$this->page_limit = $this->config->get('testimonial_per_page');
		$page = (isset($this->request->get['page'])) ? $this->request->get['page'] : 1;

		if ( isset($this->request->get['testimonial_id']) ){
			$results = $this->model_catalog_testimonial->getTestimonial($this->request->get['testimonial_id']);
		}
		else{
			$results = $this->model_catalog_testimonial->getTestimonials(($page - 1) * $this->page_limit, $this->page_limit);
		}
			
		$this->data['testimonials'] = array();
		
		foreach ($results as $result) {
			$this->data['testimonials'][] = array(
				'title'    		=> $result['title'],
				'author'		=> $result['author'],
				'company'		=> $result['company'],
				'location'		=> $result['location'],
				'url'		    => str_replace('https://','',str_replace('http://','',$result['url'])),
				'rating'		=> $result['rating'],
				'rating_text'	=> sprintf($this->language->get('text_stars'), $result['rating']),
				'description'	=> html_entity_decode($result['public_text'])
			);
		}
			
		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
			
			
		if ( isset($this->request->get['testimonial_id']) ){
			$this->data['showall_url'] = $this->url->link('product/testimonial'); 	
		} else {
			$pagination = new Pagination();
			$pagination->total = $testimonial_total;
			$pagination->page = $page;
			$pagination->limit = $this->page_limit; 
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('product/testimonial', $url . '&page={page}');
			$this->data['pagination'] = $pagination->render();	
		}

		// HANDLE FORM POST
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['title'])) {
			if ($this->validate()) {
				$this->model_catalog_testimonial->addTestimonial($this->request->post, $this->config->get('testimonial_approval_mode'));
				$this->data['success'] = true;
			}
		}
		//POPULATE ERROR DATA
		$this->data['error_author']       = (isset($this->error['author'])) ? $this->error['author'] : '';
		$this->data['error_title']        = (isset($this->error['title'])) ? $this->error['title'] : '';
		$this->data['error_captcha']      = (isset($this->error['captcha'])) ? $this->error['captcha'] : '';
		$this->data['error_public_text']  = (isset($this->error['public_text'])) ? $this->error['public_text'] : '';
		$this->data['error_private_text'] = (isset($this->error['private_text'])) ? $this->error['private_text'] : '';
		$this->data['error_company']      = (isset($this->error['company'])) ? $this->error['company'] : '';
		$this->data['error_location']     = (isset($this->error['location'])) ? $this->error['location'] : '';
		$this->data['error_has_errors']   = ($this->error) ? $this->language->get('error_has_errors') : '';

		// READ ERROR DATA
		$this->data['error_author']   = (isset($this->error['author'])) ? $this->error['author'] : '';
		$this->data['error_title']    = (isset($this->error['title'])) ? $this->error['title'] : '';
		$this->data['error_rating']   = (isset($this->error['rating'])) ? $this->error['rating'] : '';
		$this->data['error_captcha']  = (isset($this->error['captcha'])) ? $this->error['captcha'] : '';
		
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/testimonial.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/testimonial.tpl';
		} else {
			$this->template = 'default/template/product/testimonial.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);		
		
		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));

	}
	private function validate() {
		if ((strlen($this->request->post['author']) < 3) || (strlen($this->request->post['author']) > 64)) {
			$this->error['author'] = $this->language->get('error_author');
		}

		if (strlen($this->request->post['title']) < 1) {
			$this->error['title'] = $this->language->get('error_title');
		}
				
		if (!isset($this->request->post['rating'])) {
			$this->error['rating'] = $this->language->get('error_rating');
		}
		
		$captcha_required = $this->config->get('testimonial_captcha_enabled');
		if ((int)$captcha_required && (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha']))) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
}
?>