<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 2.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) October 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

if(!class_exists("ThemeControlHelper") ) {	

	define( "PAV_CSS_CACHE", DIR_CACHE."pavo-asset/" );
	define( "PAV_SUB_PATH", 'system/cache/pavo-asset/' );

	/**
	 * ThemeControlHelper Class 
	 * 
	 */
	class ThemeControlHelper extends Controller{
	
		/**
		 * @var Array $positions
		 * 
		 * @access private
		 */
		private $positions = array();
		
		/**
		 * @var Array $modulesList
		 * 
		 * @access private
		 */
		private $modulesList = array();
		
		/**
		 * @var Array $cparams
		 * 
		 * @access private
		 */
		public $cparams = array();
		
		/**
		 * @var Integer $layout_id
		 * 
		 * @access private
		 */
		private $layout_id = 0;
		
		/**
		 * @var String $theme
		 * 
		 * @access private
		 */
		private $theme = '';
		
		private $skin = '';
		/**
		 * @var String $pageClass
		 * 
		 * @access private
		 */
		private $pageClass = '';

		/**
		 * @var Array $_jsFiles
		 * 
		 * @access private
		 */
		private $_jsFiles = array();
		
		/**
		 * @var Array $positions
		 * 
		 * @access private
		 */
		private $_cssFiles = array();
		
		/**
		 * @var Array $positions
		 * 
		 * @access private
		 */
		private $_themeDir = '';

		/**
		 * @var String $_themeLessDir
		 * 
		 * @access private
		 */
		private $_themeLessDir = '';

		/**
		 * @var String $_themeURL
		 * 
		 * @access private
		 */
		private $_themeURL = '';

		/**
		 * @var String $_lessDevURL
		 * 
		 * @access private
		 */
		private $_lessDevURL = '';

		/**
		 * @var String $_lessDevDir
		 * 
		 * @access private
		 */
		private $_lessDevDir = '';

		/**
		 * @var String $_direction language direction;
		 * 
		 * @access private
		 */
		private  $_direction = 'ltr';

		/**
		 * get instance of this 
		 */
		public static function getInstance( $registry, $theme='default'){
			static $_instance;
			if( !$_instance ){
				$_instance = new ThemeControlHelper( $registry, $theme  );
			}
			return $_instance;
		}
		
		/**
		 * Constructor 
		 */
		public function __construct( $registry, $theme ){
			/* list of pavo framework positions */
			$this->positions = array( 'mainmenu',
									  'slideshow',
									  'promotion',
									  'showcase',
									  'content_top',
									  'column_left',
									  'column_right',
									  'content_bottom',
									  'mass_bottom',
									  'footer_top',
									  'footer_center',
									  'footer_bottom'
										
			);
		
			parent::__construct( $registry );

			$config = $this->config->get( 'themecontrol' );
			$direction = $this->language->get('direction');


			$this->setTheme( $theme );
		 
		 	$this->setThemeDir( DIR_TEMPLATE.$theme ); 

			$this->addParam( 'skin', $config['skin'] );
			$this->addParam('layout', isset($config['layout'])?$config['layout']:"fullwidth" );

			$this->addParam( 'body_pattern', $config['body_pattern'] );
			$this->themeURL =  'catalog/view/theme/'.$theme.'/stylesheet/';


			$this->setDirection( $this->language->get( 'direction' ) );
			$params = array('layout', 'body_pattern','skin') ;
			if( $config['enable_paneltool'] ){
				if( isset($this->request->get['pavreset']) && isset($config['enable_development_mode']) && $config['enable_development_mode'] ){
					$files = glob( DIR_CACHE.$theme.'/*.css' );  
					if ($files) {
						foreach ($files as $file) {
							if (file_exists($file)) {
								unlink($file);
							}
						}
					}
				}

				$this->triggerUserParams(  $params );
			}
 
			$this->language->load( 	'module/themecontrol' );

			/** ENABLE DEVELOPMENT MODE s**/
			$this->skin = $this->getParam('skin');  

			if( isset($config['enable_development_mode']) && $config['enable_development_mode'] ){
				/* export direct to stylesheet folder of  the theme */
				require_once( $this->_themeDir.'/development/libs/lessparser.php' );

				$developmentDir = $this->_themeDir.'/development/';
				$lessparser = new PavoLessParser( $developmentDir,$this->_themeDir, HTTP_SERVER.$this->themeURL );

				if( isset($this->request->get['compileless']) ){
					$lessparser->setLastTimeChanged( time() )->compileLess();
					die( 'done' );
				}

				if( $config['enable_development_mode'] == 'compile-export' ){
					$lessparser->compileLess();
					$this->autoLoadThemeCss();
				}else {	
					/* export direct to stylesheet to cache folder */
					$this->_lessDevURL = 'system/cache/'.$theme.'/';
					$this->_lessDevDir  = DIR_CACHE.$theme.'/';
					if( !is_dir(DIR_CACHE.$theme) ){
						mkdir( DIR_CACHE.$theme );
					}

					$cssFiles = $lessparser->setDevelopmentMode( $this->_lessDevURL,  $this->_lessDevDir )
						->compileLessDevelopment( $this->skin, $this->_direction );
					if( $cssFiles ){
						foreach( $cssFiles as $css ){
							$this->addCss( $css );
						}
					}	
				}
			}else {
				$this->autoLoadThemeCss();
			}
			
			$this->loadLocalThemeCss();
			$this->modules = $this->loadModules();	
		}
		
		/*
		 * set direction language (rtl or ltr)
		 */
		public function setDirection( $direction ){
			$this->_direction = $direction;
		}

		public function getDirection(){
			return $this->_direction;
		}
		/**
		 * set base path and less path of current theme. 
		 */
		public function setThemeDir( $dir ){
			$this->_themeDir = $dir; 
			$this->_themeLessDir = $dir.'/development/less/';
		}
		
		/**
		 * set name of actived theme.
		 */
		public function setTheme( $theme){
			$this->theme = $theme;
			return $this;
		}
		
		/**
		 *  add script files to collection.
		 */
		public function addScript( $path ){
			$this->_jsFiles[$path] = $path;
		}

		/**
		 * add list of script files
		 */
        public  function addScriptList( $scripts ){
			if( is_array($scripts) && !empty($scripts) ){
				$this->_jsFiles = array_merge( $this->_jsFiles, $scripts ); 
			}
        }
		
		/**
		 *  get list of theme script files and opencart script files.
		 */
		public function getScriptFiles(){
			return $this->_jsFiles;
		}

		/**
		 *  add single css file to collection
		 */
		public function addCss( $path ){
			$this->_cssFiles[md5($path)] =  array( 'href' => $path, 'rel' => 'stylesheet', 'media' => 'screen' );
		}
		
		/**
		 *  add single css file to collection
		 */
		public function addCssList( $styles ){
			if( is_array($styles) && !empty($styles) ){
				$this->_cssFiles = array_merge( $this->_cssFiles, $styles ); 
			}
		}
	
		/**
		 * get all less files in development folder matching to load css files.
		 */
		private function autoLoadThemeCss(){
			/* load global and defaul stylesheets file */
			$files = glob( $this->_themeLessDir . '*.less');
			if ($files) {
				if( $this->getDirection() == 'rtl' ) {
					$this->addCss( $this->themeURL.'bootstrap-rtl.css' ); 
				} else {
					$this->addCss( $this->themeURL.'bootstrap.css' ); 
				}
				foreach ($files as $file) {	 
					if( !preg_match("#bootstrap\.#", $file) ){
						if( $this->skin && preg_match("#stylesheet\.#", $file) ){ 
							continue;
						}else {
							$this->addCss( $this->themeURL.str_replace(".less", ".css", basename($file)) );	
						}
					}
				}
		 
			}
			/* add stylesheets for actived skin files */
			if( $this->skin ){
				$files = glob( $this->_themeLessDir . 'opencart/skins/'.$this->skin.'/*.less');
		 		if( $files ){
			 		foreach ($files as $file) {	 
					 	 $this->addCss( $this->themeURL.$this->skin.'/'.str_replace(".less", ".css", basename($file)) );		
					}
				}		
			} 
			/* if current language is rtl */
		 	if( $this->getDirection() == 'rtl' ){
		 		$files = glob( $this->_themeLessDir . 'opencart/rtl/*.less');


		 		if( $files ){
			 		foreach ($files as $file) {	 
						 $this->addCss( $this->themeURL.str_replace(".less", ".css", basename($file)) );		
					}
				}
		 	}
		}

		/**
		 * Local Custom Css;
		 */
		public function loadLocalThemeCss(){
			$files = glob( $this->_themeDir . '/stylesheet/local/*.css' );
			foreach( $files as $file ){
				if( filesize($file) ){
					$this->addCss( $this->themeURL. 'local/'.basename($file) );
				}
			}
		}	
		/**
		 * get all css files added for the theme
		 * this process compile - merge css files base  if theme configuration enable compression
		 */
		public function getCssLinks(){ 
			$config = $this->config->get( 'themecontrol' );	
			$compress = $config['enable_compress_css'];

			/** ENABLE DEVELOPMENT MODE s**/
			if( isset($config['enable_development_mode']) && $config['enable_development_mode'] ){
				$compress = false;
			}
			/** ENABLE COMPRESSION MODE **/
			if( trim($compress) && $this->_themeDir && is_dir($this->_themeDir) ){
				$excludes = explode( ",", $config['exclude_css_files'] );
				$output = array();
				
				require_once( $this->_themeDir.'/development/libs/cache.php' );
				require_once( $this->_themeDir.'/development/libs/csscompressor.php' );

				$pcache = new PavCache(); 
				
				$pcache->setExtension( 'css' );
				if( $compress == 'compress-merge' ){
					$siteURL = HTTP_SERVER;
					$all = '';
					$aKey = md5(serialize($this->_cssFiles).serialize($excludes));
				
					 if( !$pcache->isExisted( ($aKey) ) ){ 
						foreach( $this->_cssFiles as $key => $file ){
							$css =  preg_match("#^http#", $file['href'] ) ?$file['href']:$siteURL.$file['href'];
							$t = explode( "/", ($css) )	;	
							$content = file_get_contents( $css );
							if( !in_array($t[count($t)-1], $excludes)  ){
								if( !empty($content)  ){
									$content  = PavoCompressHelper::process( $content, $css ); 
								}
							} 
							$all .= $content;
						}
						$pcache->set( ($aKey), $all );
					}

					$_cssFiles= array();
					if( $excludes ){
						foreach( $this->_cssFiles as $key => $file ){
							$css = $file['href'];
							$t = explode( "/", ($css) )	;	
							if( in_array($t[count($t)-1], $excludes)  ){
								$_cssFiles[$key] = $file;		
							}
						}
					}
					$_cssFiles[$aKey] = array( 'rel' => 'stylesheet', 'href' =>  PAV_SUB_PATH.($aKey).".css" , 'media' => '' );
					$this->_cssFiles = $_cssFiles;
					$output = $this->_cssFiles; 
				} else {
					$siteURL = HTTP_SERVER;
					foreach( $this->_cssFiles as $key => $file ){
						$css =  preg_match("#^http#", $file['href'] ) ?$file['href']:$siteURL.$file['href'];
						$t = explode( "/", ($css) )	;	
						if( !in_array($t[count($t)-1], $excludes)  ){
							$content = file_get_contents( $css );
							if( !empty($content)  ){
								 if( !$pcache->isExisted( md5($key) ) ){
									$content  = PavoCompressHelper::process( $content, $css ); 
									$pcache->set( md5($key), $content );
								 }
								 $this->_cssFiles[$key]['href'] = PAV_SUB_PATH.md5($key).".css";
							}else {
								unset( $this->_cssFiles[$key] );
							}
						}
					}
					$output = $this->_cssFiles;
				}
				return $output;
			}
			return $this->_cssFiles;
		}
		
		/**
		 * trigger to process user paramters using for demostration
		 */
		public function triggerUserParams(  $params ){
			
			if( isset($this->request->get['pavreset']) ){ 
				foreach( $params as $param ){
					$kc = $this->theme."_".$param;
					$this->addParam($param,null);	
					setcookie ($kc, null, 0, '/');
					if( isset($_COOKIE[$kc]) ){
						$this->cparams[$kc] = null;
						$_COOKIE[$kc] = null;
					}
				}
				
			}
			
			$exp = time() + 60*60*24*355; 
			foreach( $params as $param ){
				$kc = $this->theme."_".$param;
				if( isset($this->request->post['userparams']) && ($data = $this->request->post['userparams']) ){
					if( isset($data[$param]) ){
						setcookie ($kc, $data[$param], $exp, '/');
						$this->cparams[$kc] = $data[$param];
					}
				}
				if( isset($_COOKIE[$kc]) ){ 
					$this->cparams[$kc] = $_COOKIE[$kc];
				}
			}
			
			if( isset($this->request->post['userparams']) || isset($this->request->get['pavreset'])  ){  
				
				$this->redirect(  $this->url->link("common/home", '', 'SSL') );
			}
		}
		
	 	/**
	 	 * get user parameter
	 	 */
		public function getParam( $param , $value= '' ){
			return isset($this->cparams[$this->theme."_".$param])?$this->cparams[$this->theme."_".$param]:$value;
		}
		
		/**
		 * add custom parameter 
		 */
		public function addParam( $key, $value ){
			$this->cparams[$this->theme."_".$key] = $value;
		}
		
		/**
		 * get current page class.
		 */
		public function getPageClass(){
			return $this->pageClass ;
		}

		/**
		 * detect layout ID by route in request
		 */
		public function getLayoutId(){
			$this->load->model('catalog/product');
			$this->load->model('catalog/information');
			$this->load->model('design/layout');

			if( !$this->layout_id ) {
				if (isset($this->request->get['route'])) {
					$route = (string)$this->request->get['route'];
					$this->pageClass = 'page-'.str_replace( "/", "-", $route );
				} else {
					$route = 'common/home';
					$this->pageClass = 'page-home';
				}
		
		
				$layout_id = 0;
			
				if ($route == 'product/category' && isset($this->request->get['path'])) {
					$path = explode('_', (string)$this->request->get['path']);
						
					$layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));		
					$this->pageClass = 'page-category';		

				}
				
				if ($route == 'product/product' && isset($this->request->get['product_id'])) {
					$layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
					$this->pageClass = 'page-product';		
				}
				
				if ($route == 'information/information' && isset($this->request->get['information_id'])) {
					$layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
					$this->pageClass = 'page-information';		
				}
				
				if (!$layout_id) {
					$layout_id = $this->model_design_layout->getLayout($route);
				}
						
				if (!$layout_id) {
					$layout_id = $this->config->get('config_layout_id');
				}
				if( preg_match( "#product/#", $route )  && $route != 'product/product' ){ 
					/* JQUERY SHOW CATEGORY*/
					$this->document->addScript('catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js');
					$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
				}
				$this->layout_id = $layout_id;
			}
			return $this->layout_id;
		}
		
		/**
		 * load all modules asigned for positions with current layout.
		 */
		public function loadModules (){ 
			$this->load->model('setting/extension');
			$extensions = $this->model_setting_extension->getExtensions('module');		
			$module_data = array();
			$layout_id = $this->getLayoutId();
			foreach ($extensions as $extension) {
				$modules = $this->config->get($extension['code'] . '_module');
				
				if ($modules) {
					foreach ($modules as $module) {  
						if ( ($module['layout_id'] == $layout_id || $module['layout_id'] == '99999' ) && in_array(trim($module['position']), $this->positions) && $module['status']) {
							$module_data[$module['position']][] = array(
								'code'       => $extension['code'],
								'setting'    => $module,
								'sort_order' => $module['sort_order']
							);				
						}
					}
				}
			}
	
			foreach( $module_data as $position => $modules ){
				$sort_order = array(); 
				foreach ($modules as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}
				array_multisort($sort_order, SORT_ASC, $module_data[$position]);
			}

			$this->data['modules'] = array();
			$output = array();
			foreach( $module_data as $position => $modules ){
				foreach ($modules as $module) {
					$module = $this->getChild('module/' . $module['code'], $module['setting']);
					
					if ($module) {
						$output[$position][] = $module;
					}
				} 
			} 
			$this->modulesList = $output;
		// 	echo '<pre>'.print_R( $output,1 );die;
		}
		
		/**
		 * get collection of modules by position
		 */
		public function getModulesByPosition( $position ){
			if( isset($this->modulesList[$position]) ){
				return $this->modulesList[$position];
			}
			return ;
		}
		
		/**
		 * caculate span width of column base grid 12 of twitter.
		 * 
		 * @param Array $ospan 
		 * @param Numberic $cols number of columns
		 */
		public function calculateSpans( $ospans=array(), $cols ){
			$tmp = array_sum($ospans);
			$spans = array();
			$t = 0; 
			for( $i=1; $i<= $cols; $i++ ){
				if( array_key_exists($i,$ospans) ){
					$spans[$i] = 'col-lg-'.$ospans[$i]. ' col-md-'.$ospans[$i] ;
					
				}else{		
					if( (12-$tmp)%($cols-count($ospans)) == 0 ){
						$ts=((12-$tmp)/($cols-count($ospans)));
						$spans[$i] = "col-lg-".$ts.' col-md-'.$ts;
						
					}else {
						if( $t == 0 ) {
							$ts = ( floor((11-$tmp)/($cols-count($ospans))) + 1 ) ;
							$spans[$i] = "col-lg-".$ts;
						}else {
							$ts = ( floor((11-$tmp)/($cols-count($ospans))) + 0 );
							$spans[$i] = "col-lg-".$ts .' col-md-'.$ts;
						}
						$t++;
					}					
				}
			}
			return $spans;
		}

		/**
		 * 
		 */
		public static function renderEdtiorThemeForm( $theme ){ 
			$customizeXML = DIR_TEMPLATE.$theme.'/development/customize/themeeditor.xml'; 
		 	$output = array( 'selectors' => array(), 'elements' => array() );
	 		if( file_exists($customizeXML) ){
				$info = simplexml_load_file( $customizeXML );
				if( isset($info->selectors->items) ){
					foreach( $info->selectors->items as $item ){
						$vars = get_object_vars($item);
						if( is_object($vars['item']) ){
							$tmp = get_object_vars( $vars['item'] );
							$vars['selector'][] = $tmp;
						}else {
							foreach( $vars['item'] as $selector ){
								$tmp = get_object_vars( $selector );
								if( is_array($tmp) && !empty($tmp) ){
									$vars['selector'][] = $tmp;
								}
							}
						}
						unset( $vars['item'] );
						$output['selectors'][$vars['match']] = $vars;
					}
				}

				if( isset($info->elements->items) ){
					foreach( $info->elements->items as $item ){
						$vars = get_object_vars($item);
						if( is_object($vars['item']) ){
							$tmp = get_object_vars( $vars['item'] );
							$vars['selector'][] = $tmp;
						}else {
							foreach( $vars['item'] as $selector ){
								$tmp = get_object_vars( $selector );
								if( is_array($tmp) && !empty($tmp) ){
									$vars['selector'][] = $tmp;
								}
							}
						}
						unset( $vars['item'] );
						$output['elements'][$vars['match']] = $vars;
					}
				}
			}

			return $output;
		}	

		/**
		 * 
		 */
		public function getPattern( $theme ){
			$output = array(); 

 			$path = DIR_TEMPLATE .$theme .'/image/pattern/'; 
			if( $theme && is_dir($path) ) {   
				$files = glob( $path.'*' );
				foreach( $files as $dir ){
					if( preg_match("#.png|.jpg|.gif#", $dir)){
						$output[] = str_replace("","",basename( $dir ) );
					}
				}			
			}
			return $output;
		}

		/**
		 * 
		 */
		public function renderAddon( $addon ){
			$output = '';
			$path   = $this->_themeDir.'/template/common/addon/'.$addon.'.tpl';
		
			if( file_exists($path) ){ 
				ob_start();
				require_once( $path );
				$output  = ob_get_contents();
				ob_end_clean();
			}

			return $output;
		}

		/**
		 * 
		 */
		public function renderModule( $module, $args = array() ){
		 	if( file_exists(DIR_APPLICATION.'controller/'.$module.'.php') ){
				return $this->getChild( $module );
			}
			return ;
		}	
	}
}	
?>