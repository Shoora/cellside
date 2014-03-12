<?php
class ControllerModuleDAjaxSearch extends Controller {
	protected function index($setting) {
		if ($this->config->get('d_ajax_search')) {
		$d_ajax_search=$this->config->get('d_ajax_search');
		if ($d_ajax_search['search_on_off']) {
			$this->document->addScript('catalog/view/javascript/d_ajax_search/d_ajax_search.js');
			
			if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/d_ajax_search.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/d_ajax_search.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/d_ajax_search.css');
			}
			$this->data['search_width'] = $d_ajax_search['search_width'];
	
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/d_ajax_search.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/d_ajax_search.tpl';
			} else {
				$this->template = 'default/template/module/d_ajax_search.tpl';
			}
			$this->render();
		}
		}
	}
	
	public function ajaxsearch() {
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$d_ajax_search=$this->config->get('d_ajax_search');
		
		$data = array(); $data_i=0;
		if( isset($this->request->get['keyword']) ) {
			$keywords = strtolower( $this->request->get['keyword'] );
			if( strlen($keywords) >= 1 ) {
				$parts = explode( ' ', $keywords );
				$procent="%"; if (isset($d_ajax_search['search_first_symbols'])) $procent="";
				
				for($i=0;$i<5;$i++) {
				/*  Products  */
				if (isset($d_ajax_search['search_product_on']) && (int)$d_ajax_search['search_product_sort']==$i) {
				if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
				$add = '';
				foreach( $parts as $part ) {
					$add .= ' AND (LOWER(pd.name) LIKE "' . $procent . $this->db->escape($part) . '%"';
					$add .= ' OR LOWER(p.model) LIKE "' . $procent . $this->db->escape($part) . '%")';
				}
				$add = substr( $add, 4 );
				$sql  = "SELECT pd.product_id, pd.name, p.model, p.image, p.price, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special FROM " . DB_PREFIX . "product_description AS pd ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "product AS p ON p.product_id = pd.product_id ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "product_to_store AS p2s ON p2s.product_id = pd.product_id ";
				$sql .= "WHERE " . $add . " AND p.status = 1 ";
				$sql .= "AND pd.language_id = " . (int)$this->config->get('config_language_id');
				$sql .= " AND p2s.store_id =  " . (int)$this->config->get('config_store_id'); 
				$sql .= " ORDER BY p.sort_order ASC, LOWER(pd.name) ASC";
				if ((int)$d_ajax_search['search_max_results']>0) $sql .= " LIMIT " . ((int)$d_ajax_search['search_max_results']-$data_i);
				
				$res = $this->db->query( $sql );
				if( $res ) {
					$res = ( isset($res->rows) ) ? $res->rows : $res->row;
					
                    $this->load->model('tool/image');
					$this->load->model('catalog/product');
                    
					foreach( $res as $key => $values ) {
						if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
						$product_info = $this->model_catalog_product->getProduct($values['product_id']);
						if ($values['image']) {
							$image = $this->model_tool_image->resize($values['image'],  40,  40);
						} else {
							$image = false;
						}
                        if (isset($d_ajax_search['search_price'])) {
                        if ($values['price']) {
							if (isset($d_ajax_search['search_tax'])) $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
							else $price = $this->currency->format($values['price']);
						} else {
							$price = false;
						}

						if (isset($d_ajax_search['search_special'])) {
						 if ($values['special']) {
							if (isset($d_ajax_search['search_tax'])) $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
							else $special = $this->currency->format($values['special']);
						} else {
							$special = false;
						}
						}
						else {$special = false;}
						}
						else {$special=false; $price=false;}
						
						$name=strip_tags(html_entity_decode($values['name'], ENT_QUOTES, 'UTF-8')); $name2=$name;
						if ((int)$d_ajax_search['search_max_symbols']>0) $name=utf8_substr($name, 0, (int)$d_ajax_search['search_max_symbols']) . '';
						if (strrpos($name, " ")!==false && $name!=$name2) $name=utf8_substr($name, 0, strrpos($name, " "));
						
						$model=$values['model'];
						
						$data[$data_i] = array(
							'thumb' => $image,
                            'price' => $price,
							'special' => $special,
                            'name' => $name,
							'model' => $model,
							'href'  => $this->url->link('product/product', 'product_id=' . $values['product_id'])
						);
						}
						$data_i++;
					}
				}
				}
				}
				
				/*  Categories  */
				if (isset($d_ajax_search['search_category_on']) && (int)$d_ajax_search['search_category_sort']==$i) {
				if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
				$add = '';
				foreach( $parts as $part ) {
					$add .= ' AND (LOWER(cd.name) LIKE "' . $procent . $this->db->escape($part) . '%")';
				}
				$add = substr( $add, 4 );
				$sql  = "SELECT cd.category_id, cd.name, c.image FROM " . DB_PREFIX . "category_description AS cd ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "category AS c ON c.category_id = cd.category_id ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "category_to_store AS cs ON cs.category_id = cd.category_id ";
				$sql .= "WHERE " . $add . " AND c.status = 1 ";
				$sql .= "AND cd.language_id = " . (int)$this->config->get('config_language_id');
				$sql .= " AND cs.store_id =  " . (int)$this->config->get('config_store_id'); 
				$sql .= " ORDER BY c.sort_order ASC, LOWER(cd.name) ASC";
				if ((int)$d_ajax_search['search_max_results']>0) $sql .= " LIMIT " . ((int)$d_ajax_search['search_max_results']-$data_i);
				
				$res = $this->db->query( $sql );
				if( $res ) {
					$res = ( isset($res->rows) ) ? $res->rows : $res->row;
					                    
                    $this->load->model('tool/image');
                    
					foreach( $res as $key => $values ) {
						if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
						if ($values['image']) {
							$image = $this->model_tool_image->resize($values['image'],  40,  40);
						} else {
							$image = false;
						}
						
                        $special=false; $price=false;	
						
						$name=strip_tags(html_entity_decode($values['name'], ENT_QUOTES, 'UTF-8')); $name2=$name;
						if ((int)$d_ajax_search['search_max_symbols']>0) $name=utf8_substr($name, 0, (int)$d_ajax_search['search_max_symbols']) . '';
						if (strrpos($name, " ")!==false && $name!=$name2) $name=utf8_substr($name, 0, strrpos($name, " "));
						$data[$data_i] = array(
							'thumb' => $image,
                            'price' => $price,
							'special' => $special,
                            'name' => $name,
							'model' => false,
							'href'  => $this->url->link('product/category', 'path=' . $values['category_id'])
						);
						}
						$data_i++;
					}
				}
				}
				}
				/*  Manufacture  */
				if (isset($d_ajax_search['search_manufacturer_on']) && (int)$d_ajax_search['search_manufacturer_sort']==$i) {
				if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
				$add = '';
				foreach( $parts as $part ) {
					$add .= ' AND (LOWER(m.name) LIKE "' . $procent . $this->db->escape($part) . '%")';
				}
				$add = substr( $add, 4 );
				$sql  = "SELECT m.manufacturer_id, m.name, m.image FROM " . DB_PREFIX . "manufacturer AS m ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "manufacturer_to_store AS ms ON ms.manufacturer_id = m.manufacturer_id ";
				$sql .= "WHERE " . $add . " ";
				$sql .= " AND ms.store_id =  " . (int)$this->config->get('config_store_id'); 
				$sql .= " ORDER BY m.sort_order ASC, LOWER(m.name) ASC";
				if ((int)$d_ajax_search['search_max_results']>0) $sql .= " LIMIT " . ((int)$d_ajax_search['search_max_results']-$data_i);
				
				$res = $this->db->query( $sql );
				if( $res ) {
					$res = ( isset($res->rows) ) ? $res->rows : $res->row;
					                    
                    $this->load->model('tool/image');
                    
					foreach( $res as $key => $values ) {
						if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
						if ($values['image']) {
							$image = $this->model_tool_image->resize($values['image'],  40,  40);
						} else {
							$image = false;
						}
						
                        $special=false; $price=false;	
						
						$name=strip_tags(html_entity_decode($values['name'], ENT_QUOTES, 'UTF-8')); $name2=$name;
						if ((int)$d_ajax_search['search_max_symbols']>0) $name=utf8_substr($name, 0, (int)$d_ajax_search['search_max_symbols']) . '';
						if (strrpos($name, " ")!==false && $name!=$name2) $name=utf8_substr($name, 0, strrpos($name, " "));
						$data[$data_i] = array(
							'thumb' => $image,
                            'price' => $price,
							'special' => $special,
                            'name' => $name,
							'model' => false,
							'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $values['manufacturer_id'])
						);
						}
						$data_i++;
					}
				}
				}
				}
				/*  Blog Article  */
				if (isset($d_ajax_search['search_blog_aticle_on']) && (int)$d_ajax_search['search_blog_article_sort']==$i) {
				if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
				$add = '';
				foreach( $parts as $part ) {
					$add .= ' AND (LOWER(ad.title) LIKE "' . $procent . $this->db->escape($part) . '%")';
				}
				
				$add = substr( $add, 4 );
				$sql  = "SELECT ad.article_id, ad.title, a.image FROM " . DB_PREFIX . "blog_article_description AS ad ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "blog_article AS a ON a.article_id = ad.article_id ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "blog_article_to_store AS as2 ON as2.article_id = ad.article_id ";
				$sql .= "WHERE " . $add . " AND a.status = 1 ";
				$sql .= "AND ad.language_id = " . (int)$this->config->get('config_language_id');
				$sql .= " AND as2.store_id =  " . (int)$this->config->get('config_store_id'); 
				$sql .= " ORDER BY a.sort_order ASC, LOWER(ad.title) ASC";
				if ((int)$d_ajax_search['search_max_results']>0) $sql .= " LIMIT " . ((int)$d_ajax_search['search_max_results']-$data_i);
				
				$res = $this->db->query( $sql );
				
				if( $res ) {
					$res = ( isset($res->rows) ) ? $res->rows : $res->row;
					                    
                    $this->load->model('tool/image');
                    
					foreach( $res as $key => $values ) {
						if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
						if ($values['image']) {
							$image = $this->model_tool_image->resize($values['image'],  40,  40);
						} else {
							$image = false;
						}
						
                        $special=false; $price=false;	
						
						$name=strip_tags(html_entity_decode($values['title'], ENT_QUOTES, 'UTF-8')); $name2=$name;
						if ((int)$d_ajax_search['search_max_symbols']>0) $name=utf8_substr($name, 0, (int)$d_ajax_search['search_max_symbols']) . '';
						if (strrpos($name, " ")!==false && $name!=$name2) $name=utf8_substr($name, 0, strrpos($name, " "));
						$data[$data_i] = array(
							'thumb' => $image,
                            'price' => $price,
							'special' => $special,
                            'name' => $name,
							'model' => false,
							'href'  => $this->url->link('blog/article', 'article_id=' . $values['article_id'])
						);
						}
						$data_i++;
					}
				}
				}
				}
				/*  Blog Category  */
				if (isset($d_ajax_search['search_blog_category_on']) && (int)$d_ajax_search['search_blog_category_sort']==$i) {
				if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
				$add = '';
				foreach( $parts as $part ) {
					$add .= ' AND (LOWER(cd.name) LIKE "' . $procent . $this->db->escape($part) . '%")';
				}
				
				$add = substr( $add, 4 );
				$sql  = "SELECT cd.category_id, cd.name, c.image FROM " . DB_PREFIX . "blog_category_description AS cd ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "blog_category AS c ON c.category_id = cd.category_id ";
				$sql .= "LEFT JOIN " . DB_PREFIX . "blog_category_to_store AS cs ON cs.category_id = cd.category_id ";
				$sql .= "WHERE " . $add . " AND c.status = 1 ";
				$sql .= "AND cd.language_id = " . (int)$this->config->get('config_language_id');
				$sql .= " AND cs.store_id =  " . (int)$this->config->get('config_store_id'); 
				$sql .= " ORDER BY c.sort_order ASC, LOWER(cd.name) ASC";
				if ((int)$d_ajax_search['search_max_results']>0) $sql .= " LIMIT " . ((int)$d_ajax_search['search_max_results']-$data_i);
				
				$res = $this->db->query( $sql );
				
				if( $res ) {
					$res = ( isset($res->rows) ) ? $res->rows : $res->row;
					                    
                    $this->load->model('tool/image');
                    
					foreach( $res as $key => $values ) {
						if ($data_i<(int)$d_ajax_search['search_max_results'] || (int)$d_ajax_search['search_max_results']==0) {
						if ($values['image']) {
							$image = $this->model_tool_image->resize($values['image'],  40,  40);
						} else {
							$image = false;
						}
						
                        $special=false; $price=false;	
						
						$name=strip_tags(html_entity_decode($values['name'], ENT_QUOTES, 'UTF-8')); $name2=$name;
						if ((int)$d_ajax_search['search_max_symbols']>0) $name=utf8_substr($name, 0, (int)$d_ajax_search['search_max_symbols']) . '';
						if (strrpos($name, " ")!==false && $name!=$name2) $name=utf8_substr($name, 0, strrpos($name, " "));
						$data[$data_i] = array(
							'thumb' => $image,
                            'price' => $price,
							'special' => $special,
                            'name' => $name,
							'model' => false,
							'href'  => $this->url->link('blog/category', 'category_id=' . $values['category_id'])
						);
						}
						$data_i++;
					}
				}
				}
				}
				
				}
			}
		}
		echo json_encode( $data ); 
	}
}
?>