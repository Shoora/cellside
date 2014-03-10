<?php  
class ControllerModuleIanalytics extends Controller {
	protected function index() {
		$this->language->load('module/ianalytics');

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->load->model('setting/setting');
		$iAnalyticsStatus = $this->model_setting_setting->getSetting('iAnalyticsStatus');
		
		if ((!empty($iAnalyticsStatus['status']) && $iAnalyticsStatus['status'] == 'run') || empty($iAnalyticsStatus['status'])) {
			$this->trackSearch();
			$this->trackProducts();
			$this->trackComparedProducts();
		}
		
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['data']['iAnalytics'] = str_replace('http', 'https', $this->config->get('iAnalytics'));
		} else {
			$this->data['data']['iAnalytics'] = $this->config->get('iAnalytics');
		}
		$this->data['currenttemplate'] =  $this->config->get('config_template');

		
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ianalytics.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/ianalytics.tpl';
		} else {
			$this->template = 'default/template/module/ianalytics.tpl';
		}
		
		
		
		$this->render();
	}
	
	
	function trackSearch() {
		
		if (VERSION == '1.5.5' || VERSION == '1.5.5.1') {
			if(empty($this->request->get['search'])) {
				return;
			}
			$searchVal = $this->request->get['search'];
		} else {
			if(empty($this->request->get['filter_name'])) {
				return;
			}
			$searchVal = $this->request->get['filter_name'];
		}
		
		$today = date("Y-m-d"); 
		$time = date("H:i:s"); 
		$FromIP = (!empty($_SERVER['REMOTE_ADDR'])) ? $_SERVER['REMOTE_ADDR'] : '';
		$SpokenLanguages = (!empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';
		$ResultsFound = $this->getSearchTotalResults($searchVal);
		
		$data = array(
			'ianalytics_search_data' => array (
				'date' => $today,
				'time' => $time,
				'from_ip' => $FromIP,
				'spoken_languages' => $SpokenLanguages,
				'search_value' => $searchVal,
				'search_results' => $ResultsFound
			)
		);
		
		$this->addData($data);
	}
	
	function trackProducts() {
		if(!empty($this->request->get['route'])) {
			if ($this->request->get['route'] != 'product/product') {
				return;
			}
		} else {
			return;	
		}
		$productID = $this->request->get['product_id'];
		$productInfo = $this->getProductInfo($productID);
		$today = date("Y-m-d"); 
		$time = date("H:i:s"); 
		$FromIP = (!empty($_SERVER['REMOTE_ADDR'])) ? $_SERVER['REMOTE_ADDR'] : '';
		$SpokenLanguages = (!empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';
		
		$data = array(
			'ianalytics_product_opens' => array (
				'date' => $today,
				'time' => $time,
				'from_ip' => $FromIP,
				'spoken_languages' => $SpokenLanguages,
				'product_id' => $productID,
				'product_name' => $productInfo['name'],
				'product_model' => $productInfo['model'],
				'product_price' => $productInfo['price'],
				'product_quantity' => $productInfo['quantity'],
				'product_stock_status' => $productInfo['stock_status']
			)
		);			

		$this->addData($data);

	}
	
	
	function trackComparedProducts() {
		if(!empty($this->request->get['route'])) {
			if ($this->request->get['route'] != 'product/compare') {
				return;
			}
		} else {
			return;	
		}
		$productsCompared = $this->session->data['compare'];
		
		if (count($productsCompared) < 2) return;
		
		$namedProductsCompared = array();
		$idsProductsCompared = array();
		foreach($productsCompared as $key => $value) {
			$productInfo = $this->getProductInfo($value);
			$namedProductsCompared[] = $productInfo['name'];
			$idsProductsCompared[] = $value;
		}

		sort($idsProductsCompared);

		$today = date("Y-m-d"); 
		$time = date("H:i:s"); 
		$FromIP = (!empty($_SERVER['REMOTE_ADDR'])) ? $_SERVER['REMOTE_ADDR'] : '';
		$SpokenLanguages = (!empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';
		
		$data = array(
			'ianalytics_product_comparisons' => array (
				'date' => $today,
				'time' => $time,
				'from_ip' => $FromIP,
				'spoken_languages' => $SpokenLanguages,
				'product_ids' => implode(',',$idsProductsCompared),
				'product_names' => implode(' vs. ', $namedProductsCompared)
			)
		);
		
		$this->addData($data);

	}
	
	function addData($data) {
		foreach ($data as $table => $tableData) {
			$insertFields = array();
			$insertData = array();
			
			foreach ($tableData as $fieldName => $fieldValue) {
				$insertFields[] = $fieldName;
				$insertData[] = '"'.$this->db->escape($fieldValue).'"';
			}
			
			$this->db->query('INSERT INTO ' . DB_PREFIX . $table . ' ('. implode(',', $insertFields) .') VALUES ('.implode(',', $insertData).')');
		}
	}
	
	function getSearchTotalResults($filter_name) {
		$data = array(
			'filter_name' => $filter_name
		);
		$this->load->model('catalog/product');
		return $this->model_catalog_product->getTotalProducts($data);
	}
	
	function getProductInfo($product_id) {
		$this->load->model('catalog/product');
		$product_info = $this->model_catalog_product->getProduct($product_id);
		return $product_info;
	}

}
?>