<?php
class ModelCatalogIanalytics extends Model {
	public $data;
	
	public function getAnalyticsData(&$mydata) {
		$this->data =& $mydata;
		
		$this->db->query("
		CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ianalytics_product_comparisons` (
		  `id` int(11) NOT NULL auto_increment COMMENT 'Primary index',
		  `date` date NOT NULL COMMENT 'Date when data is added',
		  `time` time NOT NULL COMMENT 'Time of day when data is added',
		  `from_ip` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'IP of client that generated the data',
		  `spoken_languages` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'Language of the client that generated the data',
		  `product_ids` varchar(255) collate utf8_unicode_ci NOT NULL COMMENT 'The ids of the compared products, ordered ascending. Used to determine the count of the comparison',
		  `product_names` text collate utf8_unicode_ci NOT NULL COMMENT 'Product names according to the ids',
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;");
		$this->db->query("
		CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ianalytics_product_opens` (
		  `id` int(11) NOT NULL auto_increment COMMENT 'Primary index',
		  `date` date NOT NULL COMMENT 'Date when data is added',
		  `time` time NOT NULL COMMENT 'Time of day when data is added',
		  `from_ip` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'IP of client that generated the data',
		  `spoken_languages` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'Language of the client that generated the data',
		  `product_id` int(11) NOT NULL COMMENT 'The id of the opened product',
		  `product_name` text collate utf8_unicode_ci NOT NULL COMMENT 'The name of the opened product',
		  `product_model` text collate utf8_unicode_ci NOT NULL COMMENT 'The model of the opened product',
		  `product_price` decimal(15,4) NOT NULL default '0.0000' COMMENT 'The price of the opened product',
		  `product_quantity` int(11) NOT NULL default '0' COMMENT 'The quantity of the opened product',
		  `product_stock_status` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'The stock status of the opened product',
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;");
		$this->db->query("
		CREATE TABLE IF NOT EXISTS `".DB_PREFIX."ianalytics_search_data` (
		  `id` int(11) NOT NULL auto_increment COMMENT 'Primary index',
		  `date` date NOT NULL COMMENT 'Date when data is added',
		  `time` time NOT NULL COMMENT 'Time of day when data is added',
		  `from_ip` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'IP of client that generated the data',
		  `spoken_languages` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'Language of the client that generated the data',
		  `search_value` tinytext collate utf8_unicode_ci NOT NULL COMMENT 'The searched text',
		  `search_results` int(11) NOT NULL default '0' COMMENT 'The number of found search results',
		  PRIMARY KEY  (`id`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;");
			
		//GET DATA
		$this->data['iAnalyticsMinDate'] = $this->_findMinDate();
		
		//MANAGE DATES
		$fromDate = (empty($_GET['fromDate'])) ? '' : date_parse(preg_replace('/([^0-9-])/m', '', $_GET['fromDate']));
		$toDate = (empty($_GET['toDate'])) ? '' : date_parse(preg_replace('/([^0-9-])/m', '', $_GET['toDate']));
		$now = time();
		
		if (is_array($toDate) && $toDate['warning_count'] == 0 && $toDate['error_count'] == 0) {
			if (!checkdate($toDate['month'], $toDate['day'], $toDate['year'])) {
				$toDate = date('Y-m-d', $now);
			} else {
				$toDate = str_pad($toDate['year'], 4, '0', STR_PAD_LEFT) . '-' . str_pad($toDate['month'], 2, '0', STR_PAD_LEFT) . '-' . str_pad($toDate['day'], 2, '0', STR_PAD_LEFT);
				
				if (strcmp($toDate, date('Y-m-d')) > 0) {
					$toDate = date('Y-m-d', $now);	
				}
			}
		} else {
			$toDate = date('Y-m-d', $now);	
		}
		
		if (is_array($fromDate) && $fromDate['warning_count'] == 0 && $fromDate['error_count'] == 0) {
			if (!checkdate($fromDate['month'], $fromDate['day'], $fromDate['year'])) {
				$fromDate = $this->data['iAnalyticsMinDate'];
			} else {
				$fromDate = str_pad($fromDate['year'], 4, '0', STR_PAD_LEFT) . '-' . str_pad($fromDate['month'], 2, '0', STR_PAD_LEFT) . '-' . str_pad($fromDate['day'], 2, '0', STR_PAD_LEFT);
				
				if (strcmp($fromDate, $this->data['iAnalyticsMinDate']) < 0) {
					$fromDate = $this->data['iAnalyticsMinDate'];
				}
			}
		} else {
			$fromDate = $this->data['iAnalyticsMinDate']; 
		}
		
		$enable = array();
		$interval = NULL;
		
		$interval = abs(ceil((($now - strtotime($this->data['iAnalyticsMinDate']))/86400))) + 1;
		
		switch ($interval) {
			case ($interval < 7) : 						{ $enable = array(1,0,0,0); } break;
			case ($interval >= 7 && $interval < 30) : 	{ $enable = array(1,1,0,0); } break;
			case ($interval >= 30 && $interval < 365) : { $enable = array(1,1,1,0); } break;
			case ($interval >= 365) : 					{ $enable = array(1,1,1,1); } break;
		}
		
		$select = array(1,0,0,0);
		
		if ($toDate == date('Y-m-d', $now)) {
			$interval = abs(ceil(((strtotime($toDate) - strtotime($fromDate))/86400)));
			if (empty($_GET['fromDate']) && empty($_GET['toDate'])) {
				if ($interval > 30) {
					$fromDate = date('Y-m-d', $now - 29*86400);
					$interval = abs(ceil(((strtotime($toDate) - strtotime($fromDate))/86400)));
				}
			}
			
			switch ($interval) {
				case 6 :		{ $select = array(0,1,0,0); } break;
				case 29 : 		{ $select = array(0,0,1,0); } break;
				case 364 : 		{ $select = array(0,0,0,1); } break;
				default : 		{ $select = array(1,0,0,0); } break;
			}
		} 
		
		$this->data['iAnalyticsSelectData'] = array('enable' => $enable, 'select' => $select);
		
		$this->data['iAnalyticsFromDate'] = $fromDate;
		$this->data['iAnalyticsToDate'] = $toDate;
		
		$this->data['iAnalyticsMonthlySearchesGraph'] = $this->getMonthlySearchesGraph(); 
		$this->data['iAnalyticsMonthlySearchesTable'] = $this->getMonthlySearchesTable();
		$this->data['iAnalyticsKeywordSearchHistory'] = $this->getKeywordSearchHistory();
		$this->data['iAnalyticsMostSearchedKeywords'] = $this->getMostSearchedKeywords();
		$this->data['iAnalyticsMostFoundKeywords'] = $this->getMostFoundKeywords();
		$this->data['iAnalyticsMostOpenedProducts'] = $this->getMostOpenedProducts();
		$this->data['iAnalyticsMostComparedProducts'] = $this->getMostComparedProducts();
		$this->data['iAnalyticsMostSearchedKeywordsPie'] = $this->getMostSearchedKeywordsPie();
		$this->data['iAnalyticsMostFoundKeywordsPie'] = $this->getMostFoundKeywordsPie();
		$this->data['iAnalyticsMostOpenedProductsPie'] = $this->getMostOpenedProductsPie();
		$this->data['iAnalyticsMostComparedProductsPie'] = $this->getMostComparedProductsPie();
		
		
		if (isset($this->request->post['iAnalytics'])) {
			foreach ($this->request->post['iAnalytics'] as $key => $value) {
				$this->data['data']['iAnalytics'][$key] = $this->request->post['iAnalytics'][$key];
			}
		} else {
			$configValue = $this->config->get('iAnalytics');
			$this->data['data']['iAnalytics'] = $configValue;
		}
	}
	
	public function deleteSearchKeyword($id) {
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'ianalytics_search_data WHERE id = "' . $id . '"');
	}
	
	public function deleteAllSearchKeyword($value) {
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'ianalytics_search_data WHERE search_value = "' . $value . '"');
	}
	
	public function deleteAnalyticsData() {
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'ianalytics_product_comparisons');
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'ianalytics_product_opens');
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'ianalytics_search_data');
	}
	
	function excludedIPs() {
		$configValue = $this->config->get('iAnalytics');
		$ips = array();
		if (!empty($configValue['BlacklistedIPs'])) {
			$ips = $configValue['BlacklistedIPs'];
			$ips = str_replace("\n\r", "\n", $ips);
			$ips = explode("\n", $ips);
			foreach ($ips as $i => $val) {
				$ips[$i] = '"'.trim($val).'"';
			}
		}
		
		return $ips;
	}
	
	function getMonthlySearchesGraph() {
		if (empty($this->data['iAnalyticsVendorId'])) {
			$days = array(array('Day','Successful queries','Zero-results queries'));
			
			for ($i=$this->data['iAnalyticsFromDate']; strcmp($i, $this->data['iAnalyticsToDate']) <= 0; $i = date('Y-m-d', strtotime($i) + 86400 + 43201)) {
				$theday = date("j-n-Y",strtotime($i));
				$days[] = array(date("j-n-Y",strtotime($i)),$this->getNumberSearchesByDay($i,'success'),$this->getNumberSearchesByDay($i,'fail'));
			}
			return $days;
		} else {
			
		}
	}
	
	function getKeywordSearchHistory($limit=1000) {
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'ianalytics_search_data WHERE' . (!empty($excludedIPs) ? ' `from_ip` NOT IN (' . implode(',', $excludedIPs) . ') AND' : '') . ' `date` >= "'.$this->data['iAnalyticsFromDate'].'" AND `date` <= "'.$this->data['iAnalyticsToDate'].'" ORDER BY `date` DESC, `time` DESC LIMIT 0, '.$limit);
		
		if ($result->num_rows == 0) {
			return array(0 => 'No Data Gathered Yet');	
		} else {
			$k = array(array('Keyword','Date','Time','Results Found','User Language','IP address','ID'));
			foreach($result->rows as $i => $search) {
				array_push($k, array($search['search_value'],$search['date'],$search['time'],$search['search_results'],$search['spoken_languages'],$search['from_ip'],$search['id']));
			}	
		}
		
		return $k;
	}
	
	function getMostSearchedKeywordsPie() {
		$keywords = $this->_getMostSearchedKeywordsRaw(3);
		$keys = array_keys($keywords);
		$values = array_values($keywords);
		if (count($values) == 2) {
			return $keys[0].':'.$values[0].':#3F4E21;'.$keys[1].':'.$values[1].':#617733;';
		}
		
		if (count($values) == 1) {
			return $keys[0].':'.$values[0].':#3F4E21;';
		}
		
		if (count($values) == 0) {
			return 'No Data Gathered Yet:100:#3F4E21;';
		}
		$pattern = $keys[0].':'.$values[0].':#3F4E21;'.$keys[1].':'.$values[1].':#617733;'.$keys[2].':'.$values[2].':#819D44;';
		return $pattern;
	}
	
	function getMostFoundKeywordsPie() {
		$keywords = $this->_getMostSearchedKeywordsRaw(3,false);
		$keys = array_keys($keywords);
		$values = array_values($keywords);
		if (count($values) == 2) {
			return $keys[0].':'.$values[0].':#718b3b;'.$keys[1].':'.$values[1].':#a0c74e;';
		}
		
		if (count($values) == 1) {
			return $keys[0].':'.$values[0].':#718b3b;';
		}
		
		if (count($values) == 0) {
			return 'No Data Gathered Yet:100:#718b3b;';
		}
		$pattern = $keys[0].':'.$values[0].':#718b3b;'.$keys[1].':'.$values[1].':#a0c74e;'.$keys[2].':'.$values[2].':#CFE3A6;';
		return $pattern;
	}
	

	function getMostOpenedProductsPie() {
		$opens = $this->_getMostOpenedProductsRaw('product_name');
		$keys = array_keys($opens);
		$values = array_values($opens);
		if (count($values) == 2) {
			return $keys[0].':'.$values[0].':#003A88;'.$keys[1].':'.$values[1].':#005CD9;';
		}
		
		if (count($values) == 1) {
			return $keys[0].':'.$values[0].':#003A88;';
		}
		
		if (count($values) == 0) {
			return 'No Data Gathered Yet:100:#003A88;';
		}
		$pattern = $keys[0].':'.$values[0].':#003A88;'.$keys[1].':'.$values[1].':#005CD9;'.$keys[2].':'.$values[2].':#519BFF;';
		return $pattern;
	}
	
	function getMostComparedProductsPie() {
		$comparisons = $this->_getMostComparedProductsRaw();
		
		$keys = array_keys($comparisons);
		$values = array_values($comparisons);

		if (count($values) == 2) {
			return $keys[0].':'.$values[0].':#CE3CFF;'.$keys[1].':'.$values[1].':#DD77FF;';
		}
		
		if (count($values) == 1) {
			return $keys[0].':'.$values[0].':#CE3CFF;';
		}
		
		if (count($values) == 0) {
			return 'No Data Gathered Yet:100:#CE3CFF;';
		}
		
		$pattern = $keys[0].':'.$values[0].':#CE3CFF;'.$keys[1].':'.$values[1].':#DD77FF;'.$keys[2].':'.$values[2].':#EFBFFF;';
		return $pattern;
	}
	
	
	function _getMostOpenedProductsRaw($param='product_id') {
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('SELECT '.$param.', COUNT(*) as count FROM ' . DB_PREFIX . 'ianalytics_product_opens WHERE' . (!empty($excludedIPs) ? ' `from_ip` NOT IN (' . implode(',', $excludedIPs) . ') AND' : '') . ' `date` >= "'.$this->data['iAnalyticsFromDate'].'" AND `date` <= "'.$this->data['iAnalyticsToDate'].'" GROUP BY `product_id` ORDER BY count DESC, `date` DESC, `time` DESC');
		
		if ($result->num_rows == 0) {
			return array('No Data Gathered Yet' => 0);
		} else {
			$k = array();
			foreach($result->rows as $i => $search) {
				$k[$search[$param]] = $search['count'];
			}
			arsort($k);
		}
		
		return $k;
	}
	
	function _getMostComparedProductsRaw() {
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('SELECT product_ids as pids, (SELECT product_names FROM ' . DB_PREFIX . 'ianalytics_product_comparisons WHERE product_ids = pids ORDER BY `date` DESC, `time` DESC LIMIT 0,1) as comparison, COUNT(*) as count FROM ' . DB_PREFIX . 'ianalytics_product_comparisons WHERE' . (!empty($excludedIPs) ? ' `from_ip` NOT IN (' . implode(',', $excludedIPs) . ') AND' : '') . ' `date` >= "'.$this->data['iAnalyticsFromDate'].'" AND `date` <= "'.$this->data['iAnalyticsToDate'].'" GROUP BY pids ORDER BY count DESC');
		
		if ($result->num_rows == 0) {
			return array('No Data Gathered Yet' => 0);
		} else {
			$k = array();
			foreach($result->rows as $i => $search) {
				$k[$search['comparison']] = $search['count'];
			}
			arsort($k);	
		}
		
		return $k;
	}
	
	function _getMostSearchedKeywordsRaw($limit=1000,$returnZeroResultsToo = true) {
		$temp = array();
		
		if ($returnZeroResultsToo == false) $condition = ' AND search_results != "0"'; else $condition = '';
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('SELECT `search_value`, COUNT(*) as count FROM ' . DB_PREFIX . 'ianalytics_search_data WHERE' . (!empty($excludedIPs) ? ' `from_ip` NOT IN (' . implode(',', $excludedIPs) . ') AND' : '') . ' `date` >= "'.$this->data['iAnalyticsFromDate'].'" AND `date` <= "'.$this->data['iAnalyticsToDate'].'"'.$condition.' GROUP BY `search_value` ORDER BY count DESC LIMIT 0, '.$limit);
		if ($result->num_rows == 0) {
			return array('No Data Gathered Yet' => 0);
		} else {
			$res = array();
			foreach($result->rows as $row) {
				$res[$row['search_value']] = $row['count'];	
			}
			arsort($res);
			return $res;
		}
		return $results;
	}
	
	function getMostComparedProducts() {
		$k = array(array('Products','Comparisons'));
		$temp = $this->_getMostComparedProductsRaw();
		if($temp === array('No Data Gathered Yet' => 0)) {
			return array(0 => 'No Data Gathered Yet');
		}
		foreach ($temp as $key => $value) {
			array_push($k, array($key,$value));
		}
		
		
		
		return $k;
	}
	
	function getMostOpenedProducts() {
		$k = array(array('Product','Opens'));
		$temp = $this->_getMostOpenedProductsRaw('product_name');
		foreach ($temp as $key => $value) {
			array_push($k, array($key,$value));
		}
		
		return $k;
	}
	
	function getMostFoundKeywords() {
		$k = array(array('Keyword','Queries'));
		$temp = $this->_getMostSearchedKeywordsRaw(1000,false);
		foreach ($temp as $key => $value) {
			array_push($k, array($key,$value));
		}
		
		return $k;
	}
	
	function getMostSearchedKeywords() {
		$k = array(array('Keyword','Searches'));
		$temp = $this->_getMostSearchedKeywordsRaw();
		foreach ($temp as $key => $value) {
			array_push($k, array($key,$value));
		}
		
		return $k;
	}
	
	function getMonthlySearchesTable() {
		if (empty($this->data['iAnalyticsVendorId'])) {
			$days = array(array('Day','Total Search Queries','Successful Search Queries','Zero-Results Search Queries'));
			
			for ($i=$this->data['iAnalyticsToDate']; strcmp($i, $this->data['iAnalyticsFromDate']) >= 0; $i = date('Y-m-d', strtotime($i) - 43201)) {
				$succeeded = $this->getNumberSearchesByDay($i,'success');
				$failed = $this->getNumberSearchesByDay($i,'fail');
				$days[] = array(date("j-n-Y",strtotime($i)), $succeeded+$failed, $succeeded, $failed);
			}
			
			return $days;
		} else {
			
		}
	}
	
	function getNumberSearchesByDay(&$day, $type='success') {
		$success=0;
		$fail=0;
		if ($type == 'success') $condition = 'search_results != "0"';
		else $condition = 'search_results = "0"';
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('SELECT COUNT(*) as count FROM ' . DB_PREFIX . 'ianalytics_search_data WHERE' . (!empty($excludedIPs) ? ' `from_ip` NOT IN (' . implode(',', $excludedIPs) . ') AND' : '') . ' `date` >= "'.$this->data['iAnalyticsFromDate'].'" AND `date` <= "'.$this->data['iAnalyticsToDate'].'" AND `date`="'.$day.'" AND '.$condition.' GROUP BY `date`');
		$count = empty($result->row['count']) ? 0 : (int)$result->row['count'];
		
		return $count;
	}


	function _findMinDate() {
		$excludedIPs = $this->excludedIPs();
		$result = $this->db->query('
		SELECT LEAST(
			(SELECT MIN(`date`) FROM '.DB_PREFIX.'ianalytics_product_comparisons' . (!empty($excludedIPs) ? ' WHERE `from_ip` NOT IN (' . implode(',', $excludedIPs) . ')' : '') . '),
			(SELECT MIN(`date`) FROM '.DB_PREFIX.'ianalytics_product_opens' . (!empty($excludedIPs) ? ' WHERE `from_ip` NOT IN (' . implode(',', $excludedIPs) . ')' : '') . '),
			(SELECT MIN(`date`) FROM '.DB_PREFIX.'ianalytics_search_data' . (!empty($excludedIPs) ? ' WHERE `from_ip` NOT IN (' . implode(',', $excludedIPs) . ')' : '') . ')
		) as min
		');
		
		if ($result->num_rows > 0) return $result->row['min'];
		else return '0000-00-00';
	}
}

?>