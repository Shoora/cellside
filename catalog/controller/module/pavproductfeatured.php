<?php  
class ControllerModulePavproductfeatured extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$this->language->load('module/pavproductfeatured');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavproductfeatured.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavproductfeatured.css');
		} else {
			//$this->document->addStyle('catalog/view/theme/default/stylesheet/pavproductfeatured.css');
		}
		$default = array(
			'latest' => 1,
			'limit' => 9
		);
		$products = array();
	 	$this->data['block_width'] = $setting['block_width'];
	 	$this->data['addition_class'] = $setting['class'];
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		$this->data['cols']   = (int)$setting['cols'];
		$this->data['itemsperpage']   = (int)$setting['itemsperpage'];
		$this->data['tabs'] = array();

		$banner = '';
		if( isset($setting['image'][$this->config->get('config_language_id')]) ) {
			$banner = 	$setting['image'][$this->config->get('config_language_id')];
		}elseif( isset($setting['image']) ) {
			foreach ( $setting['image'] as $key => $image) {
				 if( $image ){
				 	$banner = $image;
				 	break;
				 }
			}
		}
		$this->data['banner'] = $banner;
	    $data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'featured_product' => isset($setting['featured_product'])?$setting['featured_product']:'',
			'limit' => $setting['limit']
		);
		

		if( isset($setting['description'][$this->config->get('config_language_id')]) ) {
			$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		}else {
			$this->data['message'] = '';
		}
		$this->data['heading_title'] = $this->language->get('heading_title');
		$products = $this->getProducts( $this->getFeatured($data), $setting );
		
		$this->data['products'] = $products;
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavproductfeatured.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavproductfeatured.tpl';
		} else {
			$this->template = 'default/template/module/pavproductfeatured.tpl';
		}
		
		$this->render();
	}
	private function getFeatured($option = array()){
		$products = explode(',', $option['featured_product']);
		$return = array();
		if(!empty($products)){
			$limit = (isset($option['limit']) && !empty($option['limit']))?$option['limit']: 5;
			$products = array_slice($products, 0, (int)$limit);
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				$return[] = $product_info;
			}
		}
		return $return;
	}
	private function getProducts( $results, $setting ){
		$products = array();
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
			} else {
				$image = false;
			}
						
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}
					
			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}
			
			if ($this->config->get('config_review_status')) {
				$rating = $result['rating'];
			} else {
				$rating = false;
			}
			 
			$products[] = array(
				'product_id' => $result['product_id'],
				'thumb'   	 => $image,
				'name'    	 => $result['name'],
				'price'   	 => $price,
				'special' 	 => $special,
				'rating'     => $rating,
				'description'=> (html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')),
				'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
			);
		}
		return $products;
	}
}
?>