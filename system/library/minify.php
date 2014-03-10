<?php
class OC_Minify {
	private $jqueryPattern   = '~<script.*?src="catalog/view/javascript/jquery/jquery-(.*?).min.js".*?>.*?</script>|<script.*?src=".*?ajax\.googleapis\.com/ajax/libs/jquery/(.*?)/jquery\.min\.js".*?>.*?</script>~i';
	private $jqueryUIPattern = '~<script.*?src="catalog/view/javascript/jquery/ui/jquery-ui-([0-9\.]+?)\.custom.*?.js".*?>.*?</script>|<script.*?src=".*?ajax.googleapis.com/ajax/libs/jqueryui/(.*?)/jquery-ui.min.js".*?>.*?</script>~i';
	
	public function minifyJavascript($output) {
		global $vqmod;
		global $config;
		require_once('base32.php');
		$js_pattern      = '/<script type="text\/javascript" src="(.*?\.js)">\s*?<\/script>/i';
		$all_js_scripts  = array();
		$js_excludes     = array();
		$js_files = array();
		$dir_include     = '';
		$cdn_js          = '';
		$google_jquery   = '';
		$google_jqueryui  = '';
		
		$base32_encode = new Base32;
		if ($config->get('config_cdn_status') && $config->get('config_cdn_js')) { // SETUP CDN URLS
			$cdn_js = (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) ? $config->get('config_cdn_https') : $config->get('config_cdn_http');
		}

		if (preg_match('~.*<\/head>~im', $output) && !defined('DIR_CATALOG')) { // IF OUTPUT HAS A HTML HEAD SECTION

			$header_data_split = preg_split('~<\/head>~i', $output);
			$header_data = $header_data_split[0];
			$after_header_data = $header_data_split[1];

			//REFERENCE JQUERY / JQUERY UI TO EXTERNAL JAVASCRIPTS IF NEEDED
				if (($this->getJqueryVersion($header_data) || $config->get('config_javascript_jquery_version')) && $config->get('config_javascript_jquery')) {
					$google_jquery = '<script ' . ($config->get('config_javascript_defer') ? 'async defer ' : '') . 'type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/' . ($config->get('config_javascript_jquery_version') ? $config->get('config_javascript_jquery_version') : $this->getJqueryVersion($header_data)) . '/jquery.min.js"></script>';
					$header_data = $this->removeJquery($header_data);
				}
				if (($this->getJqueryUIVersion($header_data) || $config->get('config_javascript_jqueryui_version')) && $config->get('config_javascript_jqueryui')) {
					$google_jqueryui = '<script ' . ($config->get('config_javascript_defer') ? 'async defer ' : '') . 'type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/' . ($config->get('config_javascript_jqueryui_version') ? $config->get('config_javascript_jqueryui_version') : $this->getJqueryUIVersion($header_data)) . '/jquery-ui.min.js"></script>';
					$header_data = $this->removeJqueryUI($header_data);
				}
			
			$match_data = preg_replace('/<!--\[if.*?\]>\s*?.*?<!\[endif\]-->/is', '', $header_data);//REMOVE CONDITIONAL DATA
			$match_data = preg_replace('/<!--.*?-->/is', '', $match_data); //REMOVE COMMENTED DATA
			$match_data = preg_replace('~<script type="text\/javascript" src="http(.*?\.js)">\s*?<\/script>~i', '', $match_data); //REMOVE EXTERNAL JS
			$match_data = preg_replace('~<script type="text\/javascript" src="\/\/(.*?\.js)">\s*?<\/script>~i', '', $match_data); //REMOVE EXTERNAL JS

			//JAVASCRIPT EXCLUDES
			$js_exclude = $config->get('config_ipsjs_excludes');
			if (!empty($js_exclude)) {
				$js_excludes = explode($js_exclude, ",");
				foreach ($js_excludes as $jse) {
					$match_data = preg_replace('~<script type="text\/javascript" src=".*?' . trim($jse) . '.*?">\s*?<\/script>~i', '', $match_data); //REMOVE CUSTOM JS
				}
			}


			preg_match_all($js_pattern, $match_data, $matches, PREG_OFFSET_CAPTURE);
			foreach($matches[1] as $match) {
				$js_files[] = $match[0];
			}

			$js_base = $this->getCommonPath($js_files);
			foreach($js_files as $key => $jsfile) {
				if (!empty($js_base)) { $js_files[$key] = str_replace($js_base . '/', '',$jsfile); }
				$header_data = preg_replace('/<script type="text\/javascript" src="' . str_replace('/','\/', $jsfile) . '">\s*?<\/script>/', '', $header_data);
			}

			$parsed_url = parse_url(HTTP_SERVER);
	
			if(strlen($parsed_url['path']) >1) {
				$dir_include = substr($parsed_url['path'], 1, strlen($parsed_url['path']) -1);
			}
			
			$js_dir_include = $dir_include;
			if (empty($js_base) & !empty($dir_include)) {
				$js_dir_include = substr($dir_include, 0, strlen($dir_include) -1);
			}

			if ($js_files) { //IF WE HAVE JAVASCRIPT FILES TO COMBINE
				if ($config->get('config_minify_encode_url')) {
					$js_combined =  $cdn_js . '/' . $dir_include . 'min/' . ((strlen($js_dir_include . $js_base)) ? $base32_encode->toBase('b=' . $js_dir_include . $js_base) .'/' : '') . $base32_encode->toBase('f=' . implode(',',array_unique($js_files))) . '/combined.js';
				} else {
					$js_combined =  $cdn_js . '/' . $dir_include . 'min/index.php?' . ((strlen($js_dir_include . $js_base)) ? 'b=' . $js_dir_include . $js_base .'&amp;' : '') . 'f=' . implode(',',array_unique($js_files));
				}
				$header_data = preg_replace('~</title>~', '</title>' . "\n" . '<script ' . ($config->get('config_javascript_defer') ? 'async defer ' : '') . 'type="text/javascript" src="' . $js_combined . '"></script>', $header_data);
			}
						
			if ($google_jqueryui) $header_data = preg_replace('~</title>~', '</title>' . "\n" . $google_jqueryui, $header_data);
			if ($google_jquery) $header_data = preg_replace('~</title>~', '</title>' . "\n" . $google_jquery, $header_data);

			
			return $header_data . '</head>' . $after_header_data;
		} else {
			return $output;
		}
	}

	public function minifyCSS($output) {
		global $vqmod;
		global $config;
		require_once('base32.php');
		$css_pattern     = '~<link rel="stylesheet" type="text\/css" href="(.*?\.css)".*?\/?>~i';
		$all_css_scripts = array();
		$css_excludes    = array();
		$dir_include     = '';
		$cdn_css         = '';

		$base32_encode = new Base32;

		if ($config->get('config_cdn_status') && $config->get('config_cdn_css')) { // SETUP CDN URLS
			$cdn_css = (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) ? $config->get('config_cdn_https') : $config->get('config_cdn_http');
		}

		$parsed_url = parse_url(HTTP_SERVER);

		if(strlen($parsed_url['path']) >1) {
			$dir_include = substr($parsed_url['path'], 1, strlen($parsed_url['path']) -1);
		}

		if (preg_match('~.*<\/head>~im', $output) && !defined('DIR_CATALOG')) { // IF OUTPUT HAS A HTML HEAD SECTION

			$header_data_split = preg_split('~<\/head>~i', $output);
			$header_data = $header_data_split[0];
			$after_header_data = $header_data_split[1];

			$match_data = preg_replace('/<!--\[if.*?\]>\s*?.*?<!\[endif\]-->/is', '', $header_data);//REMOVE CONDITIONAL DATA
			$match_data = preg_replace('/<!--.*?-->/is', '', $match_data); //REMOVE COMMENTED DATA
			$match_data = preg_replace('~<link rel="stylesheet" type="text\/css" href="http(.*?\.css)".*?\/?>~i', '', $match_data); //REMOVE EXTERNAL CSS
			$match_data = preg_replace('~<link rel="stylesheet" type="text\/css" href="\/\/(.*?\.css)".*?\/?>~i', '', $match_data); //REMOVE EXTERNAL JAVASCRIPT
			$match_data = preg_replace('~\?v\=1\.0\.11~i', '', $match_data); //SHOPPICA

			//CSS EXCLUDES
			$css_exclude = $config->get('config_ipscss_excludes');
			if (!empty($css_exclude)) {
				$css_excludes = explode($css_exclude, ",");
				foreach ($css_excludes as $csse) {
					$match_data = preg_replace('~<link rel="stylesheet" type="text\/css" href=".*?' . trim($csse) . '.*?".*?\/?>~i', '', $match_data); //REMOVE CUSTOM CSS
				}
			}

			$match_data = preg_replace('~<link rel="stylesheet" type="text\/css" href="\/\/(.*?\.css)".*?\/?>~i', '', $match_data); //REMOVE EXTERNAL JAVASCRIPT

			$css_files = array();

			preg_match_all($css_pattern, $match_data, $matches, PREG_OFFSET_CAPTURE);
			foreach($matches[1] as $match) {
				$css_files[] = $match[0];
			}

			$css_base = $this->getCommonPath($css_files);
			foreach($css_files as $key => $cssfile) {
				if (!empty($css_base)) {
					$css_base = (substr($css_base, -1) == '/') ? substr($css_base, 0, -1) : $css_base; //REMOVE TRAILING SLASH IF EXISTING
					$css_files[$key] = str_replace($css_base . '/', '',$cssfile); }
				$header_data = preg_replace('~<link rel="stylesheet" type="text\/css" href="' . str_replace('/','\/', $cssfile) . '".*?/?>~i', '', $header_data);
			}

			if ($css_files) { //IF WE HAVE CSS FILES TO COMBINE
				if ($config->get('config_minify_encode_url')) {
					$css_combined = $cdn_css . '/' . $dir_include . 'min/'
						. (strlen($css_base . $dir_include) ? $base32_encode->toBase('b=' . $dir_include . $css_base) . '/' : '')
						. $base32_encode->toBase('f=' . implode(array_unique($css_files),',')) . '/combined.css';
				} else {
					$css_combined = $cdn_css . '/' . $dir_include . 'min/index.php?'
						. (strlen($css_base . $dir_include) ? 'b=' . $dir_include . $css_base . '&amp;' : '') . 'f=' . implode(array_unique($css_files),',');
				}
				$header_data = preg_replace('~</title>~', '</title>' . "\n" . '<link type="text/css" rel="stylesheet" href="' . $css_combined . '" media="all" />', $header_data);
			}

			return $header_data . '</head>' . $after_header_data;
		} else {
			return $output;
		}
	}

	private function getJqueryVersion($output) {
		if (preg_match($this->jqueryPattern, $output, $matches)) {
			if (strlen($matches[1])) {
				return $matches[1];
			} else {
				return $matches[2];
			}
		}
		return false; // RETURNS IF NO MATCH
	}

	private function removeJquery($output) {
		return preg_replace($this->jqueryPattern, '', $output);
	}
	
	private function getJqueryUIVersion($output) {
		if (preg_match($this->jqueryUIPattern, $output, $matches)) {
			if (strlen($matches[1])) {
				return $matches[1];
			} else {
				return $matches[2];
			}
		}
		return false; // RETURNS IF NO MATCH
	}

	private function removeJqueryUI($output) {
		return preg_replace($this->jqueryUIPattern, '', $output);
	}
	
	private function getCommonPath(array $paths) {
		$count = count($paths);
		if (empty($paths)) { return ''; }
		if ($count == 1) { return dirname($paths[0]) . '/'; }
		$_paths = array();
		for ($i = 0; $i < $count; $i++) { $_paths[$i] = explode('/', $paths[$i]); if (empty($_paths[$i][0])) { $_paths[$i][0] = '/'; } }
		$common = ''; $done = FALSE; $j = 0; $count--;
		while (!$done) { for ($i = 0; $i < $count; $i++) { if ($_paths[$i][$j] != $_paths[$i+1][$j]) { $done = TRUE; break; } } if (!$done) { $common .= $_paths[0][$j].'/'; } $j++; }
		$common = trim($common);
		return trim($common, "/");
	}

	private function strposa($haystack, $needles=array(), $offset=0) {
		$chr = array();
		foreach($needles as $needle) {
			$res = strpos($haystack, $needle, $offset);
			if ($res !== false) $chr[$needle] = $res;
		}
		if(empty($chr)) return false;
		return min($chr);
	}
}
?>