<?php  
class Controllermodulepavblogcomment extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('pavblog/comment');
		$this->load->model('catalog/product'); 
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
			
		 
		$this->data['heading_title'] = $this->language->get('blogcomment_heading_title');
		
		$comments = $this->model_pavblog_comment->getLatest( (int)$setting['limit'] );
		foreach( $comments as $k => $comment ){
			$comments[$k]['link'] = $this->url->link( 'pavblog/blog',"id=".$comment['blog_id']."#comment".$comment['comment_id'] );
		}
		$this->data['comments'] = $comments;
	
	
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavblogcomment.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavblogcomment.tpl';
		} else {
			$this->template = 'default/template/module/pavblogcomment.tpl';
		}
		
		$this->render();
	}
	
}
?>