<?php   
class ControllermodulePavtestimonial extends Controller {
	protected function index( $setting ) {
	
		static $module = 0;
		
		$this->language->load('module/pavtestimonial'); 
		$this->load->model('tool/image');	
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavtestimonial.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavtestimonial.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavtestimonial.css');
		}
	
		$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
		
		$a = array('interval'=> 8000,'auto_play'=>0,
					'navimg_height'   =>97,
					'navimg_weight'   =>177,
					'text_interval'	  =>8000,
					'column_item'	  => '1',
					'page_items'	  => 2
		 );
		

		$setting = array_merge( $a, $setting );

		$this->data['testimonials'] = array();
		$this->data['setting'] = $setting;
		$this->data['auto_play'] = $setting['auto_play']?"true":"false";
		$this->data['auto_play_mode'] = $setting['auto_play'];
		$this->data['interval'] = (int)$setting['interval'];

		$this->data['cols'] = (int)$setting['column_item'];
		$this->data['row'] = (int)$setting['page_items'];
 
		if( isset($setting['testimonial_item'])){
			foreach( $setting['testimonial_item'] as $testimonial ){
				$testimonial['thumb'] = $this->model_tool_image->resize($testimonial['image'], $setting['width'], $setting['height']);	
				$title = isset( $testimonial['title'][$this->config->get('config_language_id')] ) ? $testimonial['title'][$this->config->get('config_language_id')]:"";
				$description = isset( $testimonial['description'][$this->config->get('config_language_id')] ) ? $testimonial['description'][$this->config->get('config_language_id')]:"";
				$profile = isset( $testimonial['profile'][$this->config->get('config_language_id')] ) ? $testimonial['profile'][$this->config->get('config_language_id')]:"";
			 	$testimonial['profile'] =  html_entity_decode( $profile, ENT_QUOTES, 'UTF-8');
				$testimonial['description'] =  html_entity_decode( $description, ENT_QUOTES, 'UTF-8');

				$this->data['testimonials'][] = $testimonial;
			}
		}

	
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavtestimonial.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavtestimonial.tpl';
		} else {
			$this->template = 'default/template/module/pavtestimonial.tpl';
		}
		
		$this->render();
	}
}
?>
