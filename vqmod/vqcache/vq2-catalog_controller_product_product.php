<?php  
class ControllerProductProduct extends Controller {
	private $error = array(); 
	
	public function index() { 

				if (method_exists($this->load, 'helper')) {
					$this->load->helper('value');
				} else {
					require_once(DIR_SYSTEM . 'helper/value.php'); 
				}
			
		$this->language->load('product/product');
	
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),			
			'separator' => false
		);
		
		$this->load->model('catalog/category');	
 
         if(mysql_num_rows(mysql_query("SHOW TABLES LIKE '" . DB_PREFIX . "product_gr_details' "))==1){ 
		//richsnippets code start
	    $this->load->model('richsnippets/richsnippetsproduct');  
        $resultproduct[]= $this->model_richsnippets_richsnippetsproduct->ShowProductOtherDetails();   
        if(!empty($resultproduct[0])){
			foreach ($resultproduct as $showresults) { 
			    $this->data['productdetail'] = array(
				        'id'          => $showresults['id'],
						'business_function'       => $showresults['business_function'], 
						'get_product_gr_status'          => $showresults['get_product_gr_status'], 
				        'payment_methods'       => $showresults['payment_methods'],  
				    	'delivery_methods'       => $showresults['delivery_methods'],
				    	'product_gr_status'         => $showresults['status']
				);  
			} 
        } 
        }  
          
        //richsnippets code end
			
		
		if (isset($this->request->get['path'])) {
			$path = '';
			
			$parts = explode('_', (string)$this->request->get['path']);
			
			$category_id = (int)array_pop($parts);
				
			foreach ($parts as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
				
				$category_info = $this->model_catalog_category->getCategory($path_id);
 
		$this->data['category_name'] = $category_info['name'];
			
				
				if ($category_info) {
					$this->data['breadcrumbs'][] = array(
						'text'      => $category_info['name'],
						'href'      => $this->url->link('product/category', 'path=' . $path),
						'separator' => $this->language->get('text_separator')
					);
				}
			}
			
			// Set the last category breadcrumb
			$category_info = $this->model_catalog_category->getCategory($category_id);
				
			if ($category_info) {			
				$url = '';
				
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}	
	
				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}	
				
				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}
				
				if (isset($this->request->get['limit'])) {
					$url .= '&limit=' . $this->request->get['limit'];
				}
										
				$this->data['breadcrumbs'][] = array(
					'text'      => $category_info['name'],
					'href'      => $this->url->link('product/category', 'path=' . $this->request->get['path']),
					'separator' => $this->language->get('text_separator')
				);
			}
		}
		
		$this->load->model('catalog/manufacturer');	
		
		if (isset($this->request->get['manufacturer_id'])) {
			$this->data['breadcrumbs'][] = array( 
				'text'      => $this->language->get('text_brand'),
				'href'      => $this->url->link('product/manufacturer'),
				'separator' => $this->language->get('text_separator')
			);	
	
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}	
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
							
			$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

			if ($manufacturer_info) {	
				$this->data['breadcrumbs'][] = array(
					'text'	    => $manufacturer_info['name'],
					'href'	    => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url),					
					'separator' => $this->language->get('text_separator')
				);
			}
		}
		
		if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
			$url = '';
			
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}
						
			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}
						
			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}
			
			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}	

			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
												
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_search'),
				'href'      => $this->url->link('product/search', $url),
				'separator' => $this->language->get('text_separator')
			); 	
		}
		
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			$product_id = 0;
		}
		
		$this->load->model('catalog/product');

			$product_total = $this->model_catalog_product->getTotalOrderedProducts($product_id);
		    $this->data['product_total'] = $product_total;
			
		
		$product_info = $this->model_catalog_product->getProduct($product_id);

				
					$this->language->load('module/pcpb');					
					$this->data['text_canvas_not_support'] = $this->language->get('text_canvas_not_support');
					$this->data['text_mobile_not_support'] = $this->language->get('text_mobile_not_support');
    				$this->data['text_Build_your_own'] = $this->language->get('text_Build_your_own');
					$this->data['text_total_price'] = $this->language->get('text_total_price');
    				$this->data['text_View_your_print'] = $this->language->get('text_View_your_print');
    				$this->data['text_Your_created_print_will_lost_Continues'] = $this->language->get('text_Your_created_print_will_lost_Continues');

					$this->load->model('pcpb/pcpb');
					$dataPCPB = $this->model_pcpb_pcpb->getProductSetting($product_id);
					if($dataPCPB){
						$this->data['pcpb_enable'] = ($dataPCPB['enable'] == 1) ? true : false;
						if($this->data['pcpb_enable']){
							$optionPCPB = $this->model_pcpb_pcpb->getProductOptions($product_id);

							$optionNameID = $this->config->get('pcpb_option_save_url');
							$optionBackgroundID = $this->config->get('pcpb_option_background');
							$optionPrensentID = $this->config->get('pcpb_option_preset');

							foreach($optionPCPB as $option){
								if($option['option_id'] == $optionNameID){
									$this->data['optionPCPBID'] = $option['product_option_id'];
								}
								else if($option['option_id'] == $optionBackgroundID){
									$this->data['optionBackgroundPCPBID'] = $option['product_option_id'];
								}
								else if($option['option_id'] == $optionPrensentID){
									$this->data['optionPresentPCPBID'] = $option['product_option_id'];
								}
							}

							if (isset($this->session->data['pcpb']) && isset($this->session->data['pcpb'][$product_id])){
								$pcpbUrl = $this->session->data['pcpb'][$product_id]['url'];
								$this->data['currentPrint'] = htmlspecialchars_decode($pcpbUrl);
								$this->data['product_option_value_id'] = $this->session->data['pcpb'][$product_id]['product_option_value_id'];
								$this->data['image_option_id'] = $this->session->data['pcpb'][$product_id]['image_option_id'];
								$this->data['total_price'] = $this->session->data['pcpb'][$product_id]['total_price'];
							}
						}
					}
				
			
		
		if ($product_info) {

            // QAP start
            $modules = $this->config->get('questions_and_answers_module');

            if (is_array($modules) && count($modules)) {
                $qap = $modules[0];
            } else {
                $qap = null;
            }

            if ($this->config->get('qap_status') && isset($qap['status']) && (int)$qap['status'] && $qap['position'] == 'content_tab') {
                $this->data['qap_status'] = 1;

                $qap_module = $this->getChild('module/questions_and_answers', $qap);


                $this->data['tab_qap'] = $this->language->get('heading_title_module_product');
                $this->data['qas'] = $qap_module;
            } else {
                $this->data['qap_status'] = 0;
            }
            // QAP end
            

			$this->document->addScript('catalog/view/javascript/dialog-sellercontact.js');
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/multiseller.css');
			$this->data = array_merge($this->data, $this->load->language('multiseller/multiseller'));
			$this->load->model('localisation/country');
			$this->load->model('localisation/zone');
			$this->load->model('tool/image');
			
			$seller_id = $this->MsLoader->MsProduct->getSellerId($this->request->get['product_id']);
			$seller = $this->MsLoader->MsSeller->getSeller($seller_id);
			
			if (!$seller) {
				$this->data['seller'] = NULL;
			} else {
				$this->data['seller'] = array();
				if (!empty($seller['ms.avatar'])) {
					$this->data['seller']['thumb'] = $this->MsLoader->MsFile->resizeImage($seller['ms.avatar'], $this->config->get('msconf_seller_avatar_product_page_image_width'), $this->config->get('msconf_seller_avatar_product_page_image_height'));
				} else {
					$this->data['seller']['thumb'] = $this->MsLoader->MsFile->resizeImage('ms_no_image.jpg', $this->config->get('msconf_seller_avatar_product_page_image_width'), $this->config->get('msconf_seller_avatar_product_page_image_height'));
				}
					
				$country = $this->model_localisation_country->getCountry($seller['ms.country_id']);
				
				if (!empty($country)) {
					$this->data['seller']['country'] = $country['name'];
				} else {
					$this->data['seller']['country'] = NULL;
				}
				
				$zone = $this->model_localisation_zone->getZone($seller['ms.zone_id']);
				
				if (!empty($zone)) {			
					$this->data['seller']['zone'] = $zone['name'];
				} else {
					$this->data['seller']['zone'] = NULL;
				}
				
				if (!empty($seller['ms.company'])) {
					$this->data['seller']['company'] = $seller['ms.company'];
				} else {
					$this->data['seller']['company'] = NULL;
				}
				
				if (!empty($seller['ms.website'])) {
					$this->data['seller']['website'] = $seller['ms.website'];
				} else {
					$this->data['seller']['website'] = NULL;
				}
				
				$this->data['seller']['nickname'] = $seller['ms.nickname'];
				$this->data['seller']['seller_id'] = $seller['seller_id'];
				 
				$this->data['seller']['href'] = $this->url->link('seller/catalog-seller/profile', 'seller_id=' . $seller['seller_id']);
				
				$this->data['seller']['total_sales'] = $this->MsLoader->MsSeller->getSalesForSeller($seller['seller_id']);
				$this->data['seller']['total_products'] = $this->MsLoader->MsProduct->getTotalProducts(array(
					'seller_id' => $seller['seller_id'],
					'product_status' => array(MsProduct::STATUS_ACTIVE)
				));

				$ms_rating = $this->MsLoader->MsSeller->getRate(array('seller_id' => $seller['seller_id']), true);
				$this->data['seller']['avg_overall'] = round((float)$ms_rating['avg_overall'], 1);
				$this->data['seller']['total_votes'] = count($ms_rating['rows']);
				if ($this->data['seller']['total_votes'] == 0) {
					$this->data['seller']['avg_overall'] = $this->data['ms_catalog_seller_profile_rating_not_defined'];
				}
				
				$badges = array_unique(array_merge(
					$this->MsLoader->MsBadge->getSellerGroupBadges(array('seller_id' => $seller['seller_id'], 'language_id' => $this->config->get('config_language_id'))),
					$this->MsLoader->MsBadge->getSellerGroupBadges(array('seller_group_id' => $seller['ms.seller_group'], 'language_id' => $this->config->get('config_language_id'))),
					$this->MsLoader->MsBadge->getSellerGroupBadges(array('seller_group_id' => $this->config->get('msconf_default_seller_group_id'), 'language_id' => $this->config->get('config_language_id')))
				), SORT_REGULAR);
				
				foreach ($badges as &$badge) {
					$badge['image'] = $this->model_tool_image->resize($badge['image'], $this->config->get('msconf_badge_width'), $this->config->get('msconf_badge_height'));
				}
				$this->data['seller']['badges'] = $badges;
			}

			$this->data['ms_product_attributes'] = $this->MsLoader->MsAttribute->getProductAttributes($this->request->get['product_id'], array('multilang' => 0, 'attribute_type'=> array(MsAttribute::TYPE_TEXT, MsAttribute::TYPE_TEXTAREA, MsAttribute::TYPE_DATE, MsAttribute::TYPE_DATETIME, MsAttribute::TYPE_TIME), 'mavd.language_id' => 0));
			$this->data['ms_product_attributes'] = array_merge($this->data['ms_product_attributes'], $this->MsLoader->MsAttribute->getProductAttributes($this->request->get['product_id'], (array())));
			
			$url = '';
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
						
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}
						
			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}			

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}
						
			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}
			
			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}	
						
			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}
			
			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}	
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}	
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
																		
			$this->data['breadcrumbs'][] = array(
				'text'      => $product_info['name'],
				'href'      => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id']),
				'separator' => $this->language->get('text_separator')
			);			
			
			($product_info['custom_title'] == '')?$this->document->setTitle(((isset($category_info['name']))?($category_info['name'].' : '):'').$product_info['name']):$this->document->setTitle($product_info['custom_title']);
			$this->document->setDescription($product_info['meta_description']);
			$this->document->setKeywords($product_info['meta_keyword']);
			$this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
			$this->document->addScript('catalog/view/javascript/jquery/tabs.js');
			$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
			$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
			
			$this->data['heading_title'] = $product_info['name'];
			
			$this->data['text_select'] = $this->language->get('text_select');
			$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$this->data['text_model'] = $this->language->get('text_model');
			$this->data['text_reward'] = $this->language->get('text_reward');
			$this->data['text_points'] = $this->language->get('text_points');	
			$this->data['text_discount'] = $this->language->get('text_discount');
			$this->data['text_stock'] = $this->language->get('text_stock');
			$this->data['text_price'] = $this->language->get('text_price');
			$this->data['text_tax'] = $this->language->get('text_tax');
			$this->data['text_discount'] = $this->language->get('text_discount');
			$this->data['text_option'] = $this->language->get('text_option');
			$this->data['text_qty'] = $this->language->get('text_qty');
			$this->data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
			$this->data['text_or'] = $this->language->get('text_or');
			$this->data['text_write'] = $this->language->get('text_write');
			$this->data['text_note'] = $this->language->get('text_note');
			$this->data['text_share'] = $this->language->get('text_share');
			$this->data['text_wait'] = $this->language->get('text_wait');
			$this->data['text_tags'] = $this->language->get('text_tags');
			$this->data['text_in_same_category'] = $this->language->get('text_in_same_category');
			
			$this->data['entry_name'] = $this->language->get('entry_name');
			$this->data['entry_review'] = $this->language->get('entry_review');
			$this->data['entry_rating'] = $this->language->get('entry_rating');
			$this->data['entry_good'] = $this->language->get('entry_good');
			$this->data['entry_bad'] = $this->language->get('entry_bad');
			$this->data['entry_captcha'] = $this->language->get('entry_captcha');
			
			$this->data['button_cart'] = $this->language->get('button_cart');
			$this->data['button_wishlist'] = $this->language->get('button_wishlist');
			$this->data['button_compare'] = $this->language->get('button_compare');			
			$this->data['button_upload'] = $this->language->get('button_upload');
			$this->data['button_continue'] = $this->language->get('button_continue');
			
			$this->load->model('catalog/review');

			$this->data['tab_description'] = $this->language->get('tab_description');
			$this->data['tab_attribute'] = $this->language->get('tab_attribute');
			$this->data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

				if ($this->config->get('msconf_comments_enable')) {
					$this->language->load('multiseller/multiseller');
					$this->data['tab_comments'] = sprintf($this->language->get('ms_comments_tab_comments'), $this->MsLoader->MsComments->getTotalComments(array(
						'product_id' => $this->request->get['product_id'],
						'displayed' => 1
					)));
					
					$this->document->addScript('catalog/view/javascript/ms-comments.js');
					if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ms-comments.css')) {
						$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/ms-comments.css');
					} else {
						$this->document->addStyle('catalog/view/theme/default/stylesheet/ms-comments.css');
					}
				}
			
			$this->data['tab_related'] = $this->language->get('tab_related');
			
			$this->data['product_id'] = $this->request->get['product_id'];
$this->data['snippet_price'] = $product_info['price']; 
           $this->data['snippet_status'] = $this->model_catalog_product->getProductGrStatus($product_id);
          $this->data['snippet_language']=$this->config->get('config_language');
	      $this->data['snippet_currency']=$this->config->get('config_currency');
	      
          
			$this->data['manufacturer'] = $product_info['manufacturer'];
			$this->data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
			$this->data['model'] = $product_info['model'];
			$this->data['reward'] = $product_info['reward'];
			$this->data['points'] = $product_info['points'];

			$this->data['quantity'] = $product_info['quantity'];
			
			if ($product_info['quantity'] <= 0) {
				$this->data['stock'] = $product_info['stock_status'];
			} elseif ($this->config->get('config_stock_display')) {
				$this->data['stock'] = $product_info['quantity'];
			} else {
				$this->data['stock'] = $this->language->get('text_instock');
			}
			
			$this->load->model('tool/image');

			if ($product_info['image']) {
				$this->data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
			} else {
				$this->data['popup'] = '';
			}
			
			if ($product_info['image']) {
				
				$module_label = $this->config->get('boss_label_products_setting');
				/*$this->load->model('bosslabelproducts/bossimage');
				$checklabel = $this->model_bosslabelproducts_bossimage->checkLabel($product_id);*/
				if($module_label['product'] == 1 && $checklabel == 1){
					$this->data['thumb'] = $this->model_bosslabelproducts_bossimage->label_resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'), $product_id);					
				}else{
					$this->data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
				}
			
			} else {
				$this->data['thumb'] = '';
			}
			
			$this->data['images'] = array();
			
			$results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);
			
			foreach ($results as $result) {
				$this->data['images'][] = array(
					'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
					'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'))
				);
			}	

			///////////////////////////////
			$products_same_cat = $this->model_catalog_product->getProducts(array(
				'filter_category_id' => $category_info['category_id'],
				'filter_sub_category' => true,
				'limit' => 36
			));
			$temp = array();
			foreach ($products_same_cat as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
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
				
				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}				
				
				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
								
				$temp[] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'rating'      => $result['rating'],
					'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'        => $this->url->link('product/product', 'path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'] . $url)
				);
			}
			shuffle($temp);
			$this->data['same_products'] = $temp;

			$this->data['themeName'] = $this->config->get('config_template');
		    
			/////////////////////////////////////////

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$this->data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$this->data['price'] = false;
			}
						
			if ((float)$product_info['special']) {

		$this->data['saving'] = round((($product_info['price'] - $product_info['special'])/$product_info['price'])*100, 0);	
		

$this->document->addScript('catalog/view/javascript/countdown_default_theme.js');
$this->document->addStyle('catalog/view/theme/default/stylesheet/countdown_default_theme.css');
					
$this->load->model('catalog/special_price_countdown');	
$this->language->load('product/special_price_countdown');
					
$this->data['text_special_price'] = $this->language->get('text_special_price');
$this->data['text_calculating_time'] = $this->language->get('text_calculating_time');
					
$this->data['date_end'] = $this->model_catalog_special_price_countdown->getProductSpecialDates($this->request->get['product_id']);

				$this->data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$this->data['special'] = false;
			}
			
			if ($this->config->get('config_tax')) {
				$this->data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
			} else {
				$this->data['tax'] = false;
			}
			
			$discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);
			
			$this->data['discounts'] = array(); 
			
			foreach ($discounts as $discount) {
				$this->data['discounts'][] = array(
					'quantity' => $discount['quantity'],
					'price'    => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
				);
			}
			
			$this->data['options'] = array();
			
			foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) { 
				if ($option['type'] == 'select' || $option['type'] == 'radio' || $option['type'] == 'checkbox' || $option['type'] == 'image') { 
					$option_value_data = array();
					
					foreach ($option['option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
							} else {
								$price = false;
							}
							
							$option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),

				'imagelarge'              => $this->model_tool_image->resize($option_value['option_image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_width')),
				'imagemedium'             => $this->model_tool_image->resize($option_value['option_image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height')),
			
								'price'                   => $price,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}
					
					$this->data['options'][] = array(
						'product_option_id' => $option['product_option_id'],
						'option_id'         => $option['option_id'],
						'name'              => $option['name'],
						'type'              => $option['type'],
						'option_value'      => $option_value_data,
						'required'          => $option['required']
					);					
				} elseif ($option['type'] == 'text' || $option['type'] == 'textarea' || $option['type'] == 'file' || $option['type'] == 'date' || $option['type'] == 'datetime' || $option['type'] == 'time') {
					$this->data['options'][] = array(
						'product_option_id' => $option['product_option_id'],
						'option_id'         => $option['option_id'],
						'name'              => $option['name'],
						'type'              => $option['type'],
						'option_value'      => $option['option_value'],
						'required'          => $option['required']
					);						
				}
			}
							
			if ($product_info['minimum']) {
				$this->data['minimum'] = $product_info['minimum'];
			} else {
				$this->data['minimum'] = 1;
			}
			
			$this->data['review_status'] = $this->config->get('config_review_status');
			$this->data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
 
		$this->data['totalreviews'] = sprintf((int)$product_info['reviews']);
			
			$this->data['rating'] = (int)$product_info['rating'];

			$temp = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
			$temp = explode('-----', $temp);
			$this->data['description'] = $temp[0];
			$this->data['technical'] = $temp[1];
			$this->data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);
			
			$this->data['products'] = array();

			
			$results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
			
			foreach ($results as $result) {
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
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
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}
							
				$this->data['products'][] = array(
					'product_id' => $result['product_id'],
					'thumb'   	 => $image,
					'name'    	 => $result['name'],
					'price'   	 => $price,
					'special' 	 => $special,
					'rating'     => $rating,
					'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id'])
				);
			}	
			
			$this->data['tags'] = array();
			
			if ($product_info['tag']) {		
				$tags = explode(',', $product_info['tag']);
				
				foreach ($tags as $tag) {
					$this->data['tags'][] = array(
						'tag'  => trim($tag),
						'href' => $this->url->link('product/search', 'tag=' . trim($tag))
					);
				}
			}
            
            $this->data['text_payment_profile'] = $this->language->get('text_payment_profile');
            $this->data['profiles'] = $this->model_catalog_product->getProfiles($product_info['product_id']);
			
			$this->model_catalog_product->updateViewed($this->request->get['product_id']);
			

			if(isset($product_info['sku'])){$this->data['snippet_code']=$product_info['sku'];}
			elseif(!isset($product_info['sku'])&& isset($product_info['ean'])){$this->data['snippet_code']=$product_info['ean'];}
		      elseif(!isset($product_info['ean'])&& isset($product_info['upc'])){
				$this->data['snippet_code']=$product_info['upc'];
			}
			else{$this->data['snippet_code']=$product_info['isbn'];}
	
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/product/product.tpl';
			} else {
				$this->template = 'default/template/product/product.tpl';
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
		} else {
			$url = '';
			
			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}
						
			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}	
						
			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}			

			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}	
					
			if (isset($this->request->get['tag'])) {
				$url .= '&tag=' . $this->request->get['tag'];
			}
							
			if (isset($this->request->get['description'])) {
				$url .= '&description=' . $this->request->get['description'];
			}
					
			if (isset($this->request->get['category_id'])) {
				$url .= '&category_id=' . $this->request->get['category_id'];
			}
			
			if (isset($this->request->get['sub_category'])) {
				$url .= '&sub_category=' . $this->request->get['sub_category'];
			}	
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}	
			
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}
														
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('product/product', $url . '&product_id=' . $product_id),
        		'separator' => $this->language->get('text_separator')
      		);			
		
      		$this->document->setTitle($this->language->get('text_error'));

      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
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
	
	public function review() {
    	$this->language->load('product/product');
		
		$this->load->model('catalog/review');

		$this->data['text_on'] = $this->language->get('text_on');
		$this->data['text_no_reviews'] = $this->language->get('text_no_reviews');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['reviews'] = array();
		
		$review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);
			
		$results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);
      		
		foreach ($results as $result) {
        	$this->data['reviews'][] = array(
        		'author'     => $result['author'],
				'text'       => $result['text'],
				'rating'     => (int)$result['rating'],
        		'reviews'    => sprintf($this->language->get('text_reviews'), (int)$review_total),
        		'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
        	);
      	}			
			
		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = 5; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');
			
		$this->data['pagination'] = $pagination->render();
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/review.tpl';
		} else {
			$this->template = 'default/template/product/review.tpl';
		}
		
		$this->response->setOutput($this->render());
	}
	
    public function getRecurringDescription() {
        $this->language->load('product/product');
        $this->load->model('catalog/product');

			$product_total = $this->model_catalog_product->getTotalOrderedProducts($product_id);
		    $this->data['product_total'] = $product_total;
			
        
        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }
        
        if (isset($this->request->post['profile_id'])) {
            $profile_id = $this->request->post['profile_id'];
        } else {
            $profile_id = 0;
        }
        
        if (isset($this->request->post['quantity'])) {
            $quantity = $this->request->post['quantity'];
        } else {
            $quantity = 1;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        $profile_info = $this->model_catalog_product->getProfile($product_id, $profile_id);
        
        $json = array();
        
        if ($product_info && $profile_info) {
            
            if (!$json) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );
                
                if ($profile_info['trial_status'] == 1) {
                    $price = $this->currency->format($this->tax->calculate($profile_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
                    $trial_text = sprintf($this->language->get('text_trial_description'), $price, $profile_info['trial_cycle'], $frequencies[$profile_info['trial_frequency']], $profile_info['trial_duration']) . ' ';
                } else {
                    $trial_text = '';
                }
                
                $price = $this->currency->format($this->tax->calculate($profile_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
                
                if ($profile_info['duration']) {
                    $text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $profile_info['cycle'], $frequencies[$profile_info['frequency']], $profile_info['duration']);
                } else {
                    $text = $trial_text . sprintf($this->language->get('text_payment_until_canceled_description'), $price, $profile_info['cycle'], $frequencies[$profile_info['frequency']], $profile_info['duration']);
                }
                
                $json['success'] = $text;
            }
        }
        
        $this->response->setOutput(json_encode($json));	
    }

    public function write() {
		$this->language->load('product/product');
		
		$this->load->model('catalog/review');
		
		$json = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}
			
			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}
	
			if (empty($this->request->post['rating'])) {
				$json['error'] = $this->language->get('error_rating');
			}
	
			if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
				$json['error'] = $this->language->get('error_captcha');
			}
				
			if (!isset($json['error'])) {
				$this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);
				
				$json['success'] = $this->language->get('text_success');
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function captcha() {
		$this->load->library('captcha');
		
		$captcha = new Captcha();
		
		$this->session->data['captcha'] = $captcha->getCode();
		
		$captcha->showImage();
	}
	
	public function upload() {
		$this->language->load('product/product');
		
		$json = array();
		
		if (!empty($this->request->files['file']['name'])) {
			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));
			
			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
        		$json['error'] = $this->language->get('error_filename');
	  		}	  	

			// Allowed file extension types
			$allowed = array();
			
			$filetypes = explode("\n", $this->config->get('config_file_extension_allowed'));
			
			foreach ($filetypes as $filetype) {
				$allowed[] = trim($filetype);
			}
			
			if (!in_array(substr(strrchr($filename, '.'), 1), $allowed)) {
				$json['error'] = $this->language->get('error_filetype');
       		}	
			
			// Allowed file mime types		
		    $allowed = array();
			
			$filetypes = explode("\n", $this->config->get('config_file_mime_allowed'));
			
			foreach ($filetypes as $filetype) {
				$allowed[] = trim($filetype);
			}
							
			if (!in_array($this->request->files['file']['type'], $allowed)) {
				$json['error'] = $this->language->get('error_filetype');
			}
						
			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
			}
		} else {
			$json['error'] = $this->language->get('error_upload');
		}
		
		if (!$json && is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {
			$file = basename($filename) . '.' . md5(mt_rand());
			
			// Hide the uploaded file name so people can not link to it directly.
			$json['file'] = $this->encryption->encrypt($file);
			
			move_uploaded_file($this->request->files['file']['tmp_name'], DIR_DOWNLOAD . $file);
						
			$json['success'] = $this->language->get('text_upload');
		}	
		
		$this->response->setOutput(json_encode($json));		
	}
}
?>