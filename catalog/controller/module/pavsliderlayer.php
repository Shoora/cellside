<?php  
/******************************************************
 * @package Pav Sliders Layers module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

class Controllermodulepavsliderlayer extends Controller {
	protected function index( $setting ) {

		static $module = 0;
		
		$this->load->model('pavsliderlayer/slider');
		$this->load->model('tool/image');	
		
		$model = $this->model_pavsliderlayer_slider;
		$group_id = (int)$setting['group_id'];

		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/sliderlayer/css/typo.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/sliderlayer/css/typo.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/sliderlayer/css/typo.css');
		}
		
		$this->document->addScript('catalog/view/javascript/layerslider/jquery.themepunch.plugins.min.js');	 
		$this->document->addScript('catalog/view/javascript/layerslider/jquery.themepunch.revolution.min.js');	 


 	 	$url =   $this->config->get('config_secure') ? $this->config->get('config_ssl') : $this->config->get('config_url'); 
 		
 		$this->data['url'] = $url;

 		$sliderGroup = $model->getSliderGroupById( $group_id );
		$sliders = $model->getSlidersByGroupId( $group_id );
		$this->data['sliderParams'] = $sliderGroup['params'];
	 
		if( isset($sliderGroup['params']['fullwidth']) && (!empty($sliderGroup['params']['fullwidth']) || $sliderGroup['params']['fullwidth'] == 'boxed') ){
			$sliderGroup['params']['image_cropping'] = false; 
		}
		foreach( $sliders as $key=> $slider ){
			$slider["layers"] = array();
			$slider['params'] = unserialize( $slider["params"] ); 
			$slider['layersparams'] = unserialize( $slider["layersparams"] ); 
			
			if( $sliderGroup['params']['image_cropping']) { 
				 $slider['main_image'] = $model->resize($slider['image'], $sliderGroup['params']['width'], 
				 								$sliderGroup['params']['height'],'a');
			}else { 
				 $slider['main_image'] = $url."image/".$slider['image'];
			}	
			if( $sliderGroup['params']['image_cropping']) { 
				if( $slider['params']['slider_thumbnail'] ) {
					$slider['thumbnail'] = $model->resize( $slider['params']['slider_thumbnail'], $sliderGroup['params']['thumbnail_width'], 
					 								$sliderGroup['params']['thumbnail_height'],'a'); 
				}else {
					$slider['thumbnail'] = $model->resize($slider['image'], $sliderGroup['params']['thumbnail_width'], 
					 								$sliderGroup['params']['thumbnail_height'],'a'); 
				}
			}else {
				if( $slider['params']['slider_thumbnail'] ) {
					 $slider['thumbnail'] = $url."image/".$slider['params']['slider_thumbnail'];
				}else {
					 $slider['thumbnail'] = $url."image/".$slider['image'];
				}
				
			}
			$sliders[$key] = $slider;
		} 

		// echo '<pre>'.print_r( $sliders,1 ); die;
		$this->data['sliders'] = $sliders; 


		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavsliderlayer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavsliderlayer.tpl';
		} else {
			$this->template = 'default/template/module/pavsliderlayer.tpl';
		}
		
		$this->render();
	}
}
?>