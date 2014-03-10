<?php  
class Controllermodulepavblogcategory extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('pavblog/category');
		$this->load->model('tool/image');
		$this->language->load('module/pavblog');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		
		if( !defined("_PAVBLOG_MEDIA_") ){
			if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavblog.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavblog.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/pavblog.css');
			}
			define("_PAVBLOG_MEDIA_",true);
		}
		$this->document->addScript('catalog/view/javascript/jquery/pavblog_script.js');	
		$default = array(
			'latest' => 1,
			'limit' => 9
		);
	  
		$tree = $this->model_pavblog_category->getTree();
		
		$this->data['tree'] = $tree;
		// echo '<pre>'.print_r( $tree,1 ); die;
		
		$this->data['heading_title'] = $this->language->get('blog_category_heading_title');
		
		
		
		
		
	
	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavblogcategory.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavblogcategory.tpl';
		} else {
			$this->template = 'default/template/module/pavblogcategory.tpl';
		}
		
		$this->render();
	}
	
}
?>