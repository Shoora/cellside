<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/


class ControllerModulePavmegamenu extends Controller {

	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->load->model( 'menu/megamenu' );
		
		$this->language->load('module/pavmegamenu');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavmegamenu.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavmegamenu.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavmegamenu.css');
		}
		
	 
		$this->data['module'] = $module++;
		
		$parent = '1';
		$this->data['treemenu'] = $this->model_menu_megamenu->getTree();
		// $this->data['']
			
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavmegamenu.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavmegamenu.tpl';
		} else {
			$this->template = 'default/template/module/pavmegamenu.tpl';
		}
		
		
		
		
		$this->render();
	}
}
?>