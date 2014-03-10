<?php  
class ControllerCommonHome extends Controller {
	public function index() {
$this->document->setKeywords($this->config->get('config_meta_keywords'));
				$this->document->addLink(HTTP_SERVER, 'canonical');
		$this->document->setTitle($this->config->get('config_title'));

				$this->document->addLink($this->config->get('config_url'), 'canonical');
		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->data['heading_title'] = $this->config->get('config_title');

			$this->load->model('catalog/testimonial');
			//READ COMPANY DATA / SEO SETTINGS
			$this->data['website']['company']     = $this->config->get('testimonial_company');
			$this->data['website']['address']     = $this->config->get('testimonial_address1');
			$this->data['website']['city']        = $this->config->get('testimonial_city');
			$this->data['website']['state']       = $this->config->get('testimonial_state');
			$this->data['website']['postal_code'] = $this->config->get('testimonial_postal_code');
			$this->data['website']['country']     = $this->config->get('testimonial_country');
			$this->data['website']['website']     = $this->config->get('testimonial_website');
			$this->data['website']['telephone']   = $this->config->get('testimonial_telephone');
			$summary                              = $this->model_catalog_testimonial->getSummaryData();
			$this->data['website']['total']       = $summary['total'];
			$this->data['website']['rating']      = $summary['rating'];
			
			$this->data['website']['display_price'] = $this->config->get('testimonial_display_price');
			if ($this->config->get('testimonial_price_from')) {
				$this->data['website']['price_from'] = $this->config->get('testimonial_price_from');
			} else {
				$this->data['website']['price_from'] = false;
			}
			if ($this->config->get('testimonial_price_to')) {
				$this->data['website']['price_to'] = $this->config->get('testimonial_price_to');
			} else {
				$this->data['website']['price_to'] = false;
			}
			
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/home.tpl';
		} else {
			$this->template = 'default/template/common/home.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
										
		$this->response->setOutput($this->render());
	}
}
?>