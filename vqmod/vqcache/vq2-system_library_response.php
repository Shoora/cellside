<?php
class Response {
	private $headers = array(); 
	private $level = 0;
	private $output;
	
	public function addHeader($header) {
		$this->headers[] = $header;
	}

	public function redirect($url) {
		header('Location: ' . $url);
		exit;
	}
	
	public function setCompression($level) {
		$this->level = $level;
	}
		
	public function setOutput($output) {

			global $config;
			$min = new OC_Minify;

			if ($config->get('config_minify_javascript') && !defined('DIR_CATALOG')) {
				$output = $min->minifyJavascript($output);
			}

			if ($config->get('config_minify_css') && !defined('DIR_CATALOG')) {
				$output = $min->minifyCSS($output);
			}

			if ($config->get('config_cdn_status') && !defined('DIR_CATALOG')) {
				$dir_include = '';
				$parsed_url = parse_url(HTTP_SERVER);
				if(strlen($parsed_url['path']) >1) {
					$dir_include = substr($parsed_url['path'], 1, strlen($parsed_url['path']) -1);
					$dir_include = trim($dir_include, '/');
				}
				
				$cdn_domain = (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) ? $config->get('config_cdn_https') : $config->get('config_cdn_http');
				$cdn_domain = trim($cdn_domain, '/');
				$cdn_domain .= '/';
				if ($config->get('config_cdn_images')) {
					$output = str_replace(HTTP_IMAGE, $cdn_domain . $dir_include . '/image/', $output);
					$output = str_replace(HTTPS_IMAGE, $cdn_domain . $dir_include . '/image/', $output);
					$output = str_replace('src="/image/data', 'src="' . $cdn_domain . $dir_include . '/image/data', $output);
					$output = str_replace('src="catalog/view/theme/' . $config->get("config_template") . '/image/', 'src="' . $cdn_domain . $dir_include . '/catalog/view/theme/' . $config->get("config_template") . '/image/', $output);
					$output = str_replace('src="catalog/view/theme/default/image/', 'src="' . $cdn_domain . $dir_include . '/catalog/view/theme/default/image/', $output);
				}
				if ($config->get('config_cdn_js')) {
					$output = str_replace('src="catalog/view/javascript/', 'src="' . $cdn_domain . $dir_include . '/catalog/view/javascript/', $output);
				}
				if ($config->get('config_cdn_css')) {
					$output = str_replace('href="catalog/view/theme/' . $config->get("config_template") . '/stylesheet/', 'href="' . $cdn_domain . $dir_include . '/catalog/view/theme/' . $config->get("config_template") . '/stylesheet/', $output);
					$output = str_replace('href="catalog/view/theme/default/stylesheet/', 'href="' . $cdn_domain . $dir_include . '/catalog/view/theme/default/stylesheet/', $output);
				}
			}
			
			if ($config->get('config_minify_html') && !defined('DIR_CATALOG') && json_decode($output) == null) {
				preg_match_all('!(<script.*?>.*?</script>)!is',$output,$pre);
				$output = preg_replace('!(<script.*?>.*?</script>)!is', '#pre#', $output);
				$output = preg_replace('/[\r\n\t]+/', ' ', $output);
				$output = preg_replace('/>\s+</', '><', $output);
				$output = preg_replace('/\s+/', ' ', $output);
				if (!empty($pre[0])) {
					foreach ($pre[0] as $original) {
						$output = preg_replace('!#pre#!', $original, $output,1);
					}
				}
			}
			
		$this->output = $output;
	}

	private function compress($data, $level = 0) {
		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
			$encoding = 'gzip';
		} 

		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
			$encoding = 'x-gzip';
		}

		if (!isset($encoding)) {
			return $data;
		}

		if (!extension_loaded('zlib') || ini_get('zlib.output_compression')) {
			return $data;
		}

		if (headers_sent()) {
			return $data;
		}

		if (connection_status()) { 
			return $data;
		}
		
		$this->addHeader('Content-Encoding: ' . $encoding);

		return gzencode($data, (int)$level);
	}

	public function output() {
		if ($this->output) {
			if ($this->level) {
				$ouput = $this->compress($this->output, $this->level);
			} else {
				$ouput = $this->output;
			}	
				
			if (!headers_sent()) {
				foreach ($this->headers as $header) {
					header($header, true);
				}
			}
			
			echo $ouput;
		}
	}
}
?>