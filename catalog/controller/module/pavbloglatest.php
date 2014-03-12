<?php  
class Controllermodulepavbloglatest extends Controller {
	protected function index($setting) {
		static $module = 0;
		$this->load->model('pavblog/blog');
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
			
		$default = array(
			'latest' => 1,
			'limit' => 9
		);
	 
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		$this->data['cols']   = (int)$setting['cols'];  
		
		$this->data['tabs'] = array();
		
	
		
		$data = array(
			'sort'  => 'b.`created`',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);
		
		if( $setting['tabs'] == 'featured' ){			
			$data['featured'] = 1;
			$blogs = $this->model_pavblog_blog->getListBlogs( $data );
			$this->data['heading_title'] = $this->language->get('text_featured');
		}elseif( $setting['tabs'] == 'mostviewed' ){	
			$data['sort'] = 'b.`hits`';
			$blogs = $this->model_pavblog_blog->getListBlogs( $data );
			$this->data['heading_title'] = $this->language->get('text_mostviewed');
		}else {
			$blogs = $this->model_pavblog_blog->getListBlogs( $data );
			$this->data['heading_title'] = $this->language->get('text_latest');
		}
		
	
		
		
		
		
	
		foreach( $blogs as $key => $blog ){
			if( $blogs[$key]['image'] ){	
				$blogs[$key]['thumb'] = $this->model_tool_image->resize($blog['image'], $setting['width'], $setting['height'] );
			}else {
				$blogs[$key]['thumb'] = '';
			}					
			
			$blogs[$key]['description'] = html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
			$blogs[$key]['author'] = isset($users[$blog['user_id']])?$users[$blog['user_id']]:$this->language->get('text_none_author');
			$blogs[$key]['category_link'] =  $this->url->link( 'pavblog/category', "path=".$blog['category_id'] );
			$blogs[$key]['comment_count'] =  10;
			$blogs[$key]['link'] =  $this->url->link( 'pavblog/blog','id='.$blog['blog_id'] );
		}

		
		if( isset( $setting['description'][$this->config->get('config_language_id')] ) ) {	
			$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
	 	}else {
			$this->data['message'] = '';
		}
		
		

		$this->data['blogs'] = $blogs;
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavbloglatest.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavbloglatest.tpl';
		} else {
			$this->template = 'default/template/module/pavbloglatest.tpl';
		}
		
		$this->render();
	}
	
}
?>