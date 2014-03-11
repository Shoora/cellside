<?php
class ControllerCommonSeoUrl extends Controller {

			private function queryHandler($sql) {
				if ($this->config->get('config_seo_cache')) {
					return $this->db->cachedQuery($sql, 'seo');
				} else {
					return $this->db->query($sql);
				}
			}
			
	public function index() {
		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		// Decode URL
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);
			
			foreach ($parts as $part) {
				$query = $this->queryHandler("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
				
				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);
					
					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}
					
					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}	
					
					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}
					

					if ($url[0] == 'seller_id') {
						$this->request->get['seller_id'] = $url[1];
					}
			
					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}	
				} else {
					$this->request->get['route'] = 'error/not_found';	
				}
			}
			
			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';


			} elseif ($this->request->get['_route_'] ==  'wishlist') { $this->request->get['route'] =  'account/wishlist';
			} elseif ($this->request->get['_route_'] ==  'contact') { $this->request->get['route'] =  'information/contact';
			} elseif ($this->request->get['_route_'] ==  'account') { $this->request->get['route'] =  'account/account';
			} elseif ($this->request->get['_route_'] ==  'sitemap') { $this->request->get['route'] =  'information/sitemap';
			} elseif ($this->request->get['_route_'] ==  'manufacturer') { $this->request->get['route'] =  'product/manufacturer';
			} elseif ($this->request->get['_route_'] ==  'affiliates') { $this->request->get['route'] =  'affiliate/account';
			} elseif ($this->request->get['_route_'] ==  'special') { $this->request->get['route'] =  'product/special';
			} elseif ($this->request->get['_route_'] ==  'login') { $this->request->get['route'] =  'account/login';
			} elseif ($this->request->get['_route_'] ==  'logout') { $this->request->get['route'] =  'account/logout';
			} elseif ($this->request->get['_route_'] ==  'register') { $this->request->get['route'] =  'account/register';
			
			
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';

				} elseif (isset($this->request->get['seller_id'])) {
					if (strpos($this->request->get['_route_'], "products") !== FALSE) {
						$this->request->get['route'] = 'seller/catalog-seller/products';
					}
					else {
						$this->request->get['route'] = 'seller/catalog-seller/profile';
					}
				} elseif (strpos($this->request->get['_route_'], $this->config->get('msconf_sellers_slug')) === 0) {
					$this->request->get['route'] = 'seller/catalog-seller';
			
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';
			}
			

                            elseif($this->request->get['_route_'] == 'artists') {
                            $this->request->get['route'] = 'product/artist';
                         }
			
			if (isset($this->request->get['route'])) {

                if ($this->request->get['_route_'] == "faq") {
                    $this->request->get['route'] = 'module/questions_and_answers/faq';
                }
            
				return $this->forward($this->request->get['route']);
			}
		}
	}
	
	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));
	
		$url = ''; 
		
		$data = array();
		
		parse_str($url_info['query'], $data);
		
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {

				if ($data['route'] == 'seller/catalog-seller') {
					$url .= '/' . $this->config->get('msconf_sellers_slug') . '/';
				}
			
				
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'seller/catalog-seller/profile' && $key == 'seller_id') || ($data['route'] == 'seller/catalog-seller/products' && $key == 'seller_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
			
					$query = $this->queryHandler("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
				
					if ($query->num_rows) {
						
				if ($data['route'] == 'seller/catalog-seller/profile') {
					$url .= '/' . $this->config->get('msconf_sellers_slug') . '/' . $query->row['keyword'];
				}
				else if ($data['route'] == 'seller/catalog-seller/products') {
					$url .= '/' . $this->config->get('msconf_sellers_slug') . '/' . $query->row['keyword'] . '/products/';
				}
				else {
					$url .= '/' . $query->row['keyword'];
				}
			
						
						unset($data[$key]);
					}					

			} elseif (isset($data['route']) && $data['route'] ==   'common/home') { $url .=  '/';
			} elseif (isset($data['route']) && $data['route'] ==   'account/wishlist' && $key != 'remove') { $url .=  '/wishlist';
			} elseif (isset($data['route']) && $data['route'] ==   'information/contact') { $url .=  '/contact';
			} elseif (isset($data['route']) && $data['route'] ==   'account/account') { $url .=  '/account';
			} elseif (isset($data['route']) && $data['route'] ==   'information/sitemap') { $url .=  '/sitemap';
			} elseif (isset($data['route']) && $data['route'] ==   'product/manufacturer') { $url .=  '/manufacturer';
			} elseif (isset($data['route']) && $data['route'] ==   'affiliate/account') { $url .=  '/affiliates';
			} elseif (isset($data['route']) && $data['route'] ==   'product/special' && $key != 'page' && $key != 'sort' && $key != 'limit' && $key != 'order') { $url .=  '/special';
			} elseif (isset($data['route']) && $data['route'] ==   'account/login') { $url .=  '/login';
			} elseif (isset($data['route']) && $data['route'] ==   'account/logout') { $url .=  '/logout';
			} elseif (isset($data['route']) && $data['route'] ==   'account/register') { $url .=  '/register';
			

                } elseif ($key == 'route' &&  $value == 'module/questions_and_answers/faq') {
                    $url .= '/faq';
            
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
					
					foreach ($categories as $category) {
						$query = $this->queryHandler("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
				
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
						}							
					}
					
					unset($data[$key]);
				}
			}
		}
	
		if ($url) {
			unset($data['route']);
		
			$query = '';
		
			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . $key . '=' . $value;
				}
				
				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}	
}
?>