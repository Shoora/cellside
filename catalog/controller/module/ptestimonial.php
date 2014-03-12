<?php  
class ControllerModulePtestimonial extends Controller {
	protected function index($setting) {
		$this->language->load('module/ptestimonial');

		//READ CONFIG SETTINGS FOR TESTIMONIAL MODULE
		$this->data['settings']['public_text_enabled']  = $this->config->get('testimonial_public_text_enabled');
		$this->data['settings']['private_text_enabled'] = $this->config->get('testimonial_private_text_enabled');
		$this->data['settings']['company_enabled']      = $this->config->get('testimonial_company_enabled');
		$this->data['settings']['url_enabled']          = $this->config->get('testimonial_url_enabled');
		$this->data['settings']['telephone_enabled']    = $this->config->get('testimonial_telephone_enabled');
		$this->data['settings']['email_enabled']        = $this->config->get('testimonial_email_enabled');
		$this->data['settings']['captcha_enabled']      = $this->config->get('testimonial_captcha_enabled');
		$this->data['settings']['require_login']        = $this->config->get('testimonial_require_login');
		$this->data['settings']['view_all_enabled']     = $setting['view_all'];
		$this->data['settings']['star_template']        = $setting['star_template'];
		$this->data['settings']['star_size']            = $setting['star_size'];
		
		$this->data['testimonial_title'] = html_entity_decode($setting['testimonial_title'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');


      	$this->data['heading_title'] = $this->language->get('heading_title');
      	$this->data['text_keep_reading'] = $this->language->get('text_keep_reading');
      	$this->data['text_view_all'] = $this->language->get('text_view_all');
		$this->data['text_testimonial'] = $this->language->get('testimonial');
		$this->load->model('catalog/testimonial');
		$this->data['testimonials'] = array();
		
		$this->data['total'] = $this->model_catalog_testimonial->getTotalTestimonials();
		$results = $this->model_catalog_testimonial->getTestimonials(0, $setting['testimonial_limit'], 'RAND', $setting['featured_only']);
		
		foreach ($results as $result) {			
			$this->data['testimonials'][] = array(
				'id'			=> $result['testimonial_id'],
				'title'    		=> $result['excerpt_title'] ? $result['excerpt_title'] : $result['title'],
				'author'		=> $result['author'],
				'company'		=> $result['company'],
				'url'		    => $result['url'],
				'company'		=> $result['company'],
				'rating'		=> $result['rating'],
				'rating_text'	=> sprintf($this->language->get('text_stars'), $result['rating']),
				'description'   => ($setting['description_length']) ? substr(strip_tags(html_entity_decode($result['public_text'], ENT_QUOTES, 'UTF-8')), 0, $setting['description_length']) . '..' : $result['public_text'],
				'read_more_url' => ($setting['read_more']) ? $this->url->link('product/testimonial', 'testimonial_id='.$result['testimonial_id']) : false,
			);
		}
		
		$this->data['testimonials_url'] = $this->url->link('product/testimonial');
		$this->id = 'ptestimonial';

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ptestimonial.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/ptestimonial.tpl';
		} else {
			$this->template = 'default/template/module/ptestimonial.tpl';
		}
		
		$this->render();
	}
}
?>