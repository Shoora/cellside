<?php  
class ControllerModulePavproductcarousel extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
		$this->load->model('pavproductcarousel/product'); 
		$this->load->model('tool/image');
		$this->language->load('module/pavproductcarousel');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavproductcarousel.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavproductcarousel.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavproductcarousel.css');
		}
		$default = array(
			'latest' => 1,
			'limit' => 9
		);
	 	$a = array('interval'=> 8000,'auto_play'=>0 );
		$setting = array_merge( $a, $setting );
		$this->data['prefix'] = isset($setting['prefix'])?$setting['prefix']:'';
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		$this->data['auto_play'] = $setting['auto_play']?"true":"false";
		$this->data['auto_play_mode'] = $setting['auto_play'];
		$this->data['interval'] = (int)$setting['interval'];
		$this->data['cols']   = (int)$setting['cols'];
		$this->data['itemsperpage']   = (int)$setting['itemsperpage'];
		
		$this->data['tooltip']   = isset($setting['tooltip'])?(int)$setting['tooltip']:0;
		$this->data['tooltip_placement'] = isset($setting['tooltip_placement'])?$setting['tooltip_placement']:'top';
		$this->data['tooltip_show'] = isset($setting['tooltip_show'])?(int)$setting['tooltip_show']:100;
		$this->data['tooltip_hide'] = isset($setting['tooltip_hide'])?(int)$setting['tooltip_hide']:100;
		$this->data['show_button'] = isset($setting['btn_view_more'])?$setting['btn_view_more']:0;
		
		$this->data['byCategory'] = $this->model_catalog_category->getCategories(59); // subcategories of SHOP NOW
		foreach ($this->data['byCategory'] as $key => $value) {
		 	$this->data['byModel'][$value['category_id']] = $this->model_catalog_category->getCategories($value['category_id']);
		}
		$this->load->model('catalog/manufacturer'); 
		$this->data['byBrand'] = $this->model_catalog_manufacturer->getManufacturers();
		// print_r($this->data['byBrand'] ); die();

		
		// if (strpos($_GET['path'], '_') !== FALSE) {
		// 	$cat_model_id = explode('_', $_GET['path']);
		// 	$this->data['refineSearch'] = $this->model_catalog_category->getCategories($cat_model_id[1]); // subcategories of Current brand
		// }
		
		$currenttab = reset($setting['tabs']);
		$button_link = '';
		if($currenttab == 'latest') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/latest');
		} elseif($currenttab == 'featured') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/featured');
		} elseif($currenttab == 'bestseller') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/bestseller');
		} elseif($currenttab == 'special') {
			$button_link = $this->url->link('product/special');
		} elseif($currenttab == 'mostviewed') { $button_link = $this->url->link('product/product');
			//$button_link = $this->url->link('product/mostviewed');
		} else {
			 $button_link = $this->url->link('product/product');
		}
		
		
		
		$this->data['button_link'] = $button_link;
		
		$this->data['view_more'] = $this->language->get('label_btn_view_more');
		
		$this->data['tabs'] = array();
		
		$data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);
		
	
		 $setting['tabs'] = array_flip(  $setting['tabs'] );
	
		$tabs = array(
			'latest' 	 => array(),
			'featured'   => array( ),
			'bestseller' => array(),
			'special'   => array(),
			'mostviewed' => array()
		);	
		if( isset($setting['description'][$this->config->get('config_language_id')]) ) {
			$this->data['message'] = html_entity_decode($setting['description'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
		}else {
			$this->data['message'] = '';
		}
		if(isset($setting['tabs']['featured'])){
			$products = $this->getProducts( $this->getFeatured($data), $setting );
			$this->data['heading_title'] = $this->language->get('Featured');
		}
		if( isset($setting['tabs']['latest']) ){
			$products = $this->getProducts( $this->model_catalog_product->getProducts( $data ), $setting );
			$this->data['heading_title'] = $this->language->get('text_latest');
	 	}
		if( isset($setting['tabs']['bestseller']) ){
			$products = $this->getProducts( $this->model_catalog_product->getBestSellerProducts( $data['limit'] ), $setting );
			$this->data['heading_title'] = $this->language->get('text_bestseller');
			//print_r($setting); die();
	 	}
		if( isset($setting['tabs']['special']) ){
			$products = $this->getProducts( $this->model_catalog_product->getProductSpecials( $data ), $setting );
			$this->data['heading_title'] = $this->language->get('text_special');
		}
		if( isset($setting['tabs']['mostviewed']) ){
			$products = $this->getProducts( $this->model_pavproductcarousel_product->getMostviewedProducts( $data['limit'] ), $setting );
			$this->data['heading_title'] = $this->language->get('text_mostviewed');
		}
//	  	echo '<pre>'.print_r( $tabs['special'],1 ); die;
		$this->data['products'] = $products;
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavproductcarousel.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavproductcarousel.tpl';
		} else {
			$this->template = 'default/template/module/pavproductcarousel.tpl';
		}
		
		$this->render();
	}
	private function getFeatured($option = array()){
		$products = explode(',', $this->config->get('featured_product'));
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
				'quantity'   => $result['quantity'],
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