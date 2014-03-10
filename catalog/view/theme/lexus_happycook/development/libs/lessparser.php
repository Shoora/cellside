<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/


/**
 * This class uses parser less files in development folder and compile and export theme to css and put inside stylesheet of theme folder.
 * 
 * It supports tow option to export css
 * 	1) development mode: need configure target development directory and URL directory. It will compile and export file by file and not export in stylesheet folder of theme
 *  2) Compile mode: all less files are compiled and exported in stylesheet file of theme.
 *  
 * development directory structure:
 *  - developmemnt/
 *          less/
 *				+ opencart/
 *				+ mixins/
 *				+ opencart/
 *				+ vars/
 *				- less files which import other less files inside it.					
 *          libs/
 *				- csscompressor.php
 *				- lessc.inc.php
 *
 *  theme directory structure :
 *	- THEME_NAME:
 *			 - stylesheets/ <- this folder is where store less files compiled.			
 *				       + rtl/
 *					   + skin
 *			  
 */

class PavoLessParser {

	/**
	 * @var String $_themeDir;
	 * 
	 * @access private
	 */
	private $_themeDir;
	
	/**
	 * @var String $_lessDevDir;
	 * 
	 * @access private
	 */
	private $_developmentDir = null;

	/**
	 * @var String $_lessDevDir;
	 * 
	 * @access private
	 */
	private $_lessDevDir = null; 

	/**
	 * @var String $_themeLessDir;
	 * 
	 * @access private
	 */
	private $_themeLessDir = '';
	/**
	 * @var Array $_css;
	 * 
	 * @access private
	 */
	private $_css = array(); 

	/**
	 * @var String $themeURL;
	 * 
	 * @access private
	 */
	private $themeURL = '/';

	/**
	 * @var String $_lessDevURL;
	 * 
	 * @access private
	 */
	private $_lessDevURL = '/';

	/**
	 * @var String $_lessAppFolder is folder name of application 
	 *
	 * @access private
	 */
	private $_lessAppFolder = 'opencart';
	/*
	 * Constructor
	 */
	public function __construct ( $_developmentDir, $_themeDir, $url  ){

		$this->_developmentDir   = $_developmentDir;
		$this->_themeDir    	 = $_themeDir;
		$this->themeURL 		 = $url ;


 		$this->_themeLessDir 	 = $this->_developmentDir.'less/';
 		$this->_libsDir 		 = $this->_developmentDir . 'libs/';

 		$this->lastTimeChanged = $this->lastTimeChangedVars(); 
	}

  	/**
	 * set configure path and url using for development mode.
	 */
 	public function setDevelopmentMode( $lessDevURL, $_lessDevTargetDir ){

 		$this->_lessDevURL = $lessDevURL;
 		$this->_lessDevTargetDir = $_lessDevTargetDir;
 		

 		return $this;
 	}

 	/**
	 * inmport class in library
	 */
 	public function importLib( $file ){
		require_once( $this->_libsDir.$file );
 	}


 	public function getTimeChangedSkinVars( $skin ){

 		$tmp   = array();
 		$files = glob( $this->_themeLessDir . 'opencart/skins/'.$skin.'/vars/*.less' );

 		if( $files ){
 			$tmp = array_merge_recursive($tmp, $files);
 		}
 		$files = glob( $this->_themeLessDir . 'opencart/skins/'.$skin.'/mixins/*.less' );

 		if( $files ){
 		 	$tmp = array_merge_recursive($tmp, $files);
 		}

 		if( !empty($tmp)) {
	 		$t = filemtime( $tmp[0] );
	 		foreach( $tmp as $file ){
	 			$t = max( $t, filemtime($file) );
	 		}
	 		return $t;
	 	}
	 	return 0;	
 	}


 	public function lastTimeChangedVars(){
 		$tmp = array();
 		$files = glob( $this->_themeLessDir . 'vars/*.less' );
 		if( $files ){
 			$tmp = array_merge_recursive($tmp, $files);
 		}
 		$files = glob( $this->_themeLessDir . 'mixins/*.less' );
 		if( $files ){
 		 	$tmp = array_merge_recursive($tmp, $files);
 		}

 		$t = filemtime( $tmp[0] );
 		foreach( $tmp as $file ){
 			$t = max( $t, filemtime($file) );
 		}

 		return $t;
 	}
 
	/**
	 * enable development mode to compile less file.
	 */
	public function compileLessDevelopment( $skin=null, $direction='ltr' ){
		
		$this->importLib( 'lessc.inc.php' );
		$this->importLib( 'csscompressor.php' );

		$lessTarget = $this->_lessDevTargetDir;

 		$lessDir = $skin ? $this->_themeLessDir.$this->_lessAppFolder.'/skins/'.$skin.'/':$this->_themeLessDir;

 		 if( $skin ){
            $t 						= $this->getTimeChangedSkinVars( $skin );
            $this->lastTimeChanged = max( $this->lastTimeChanged, $t );
        }

  		$this->compileBootstrap();

  		if( $direction == 'rtl' ){
 			$this->addCss( $this->themeURL. 'bootstrap-rtl.css' );
		} else {
			$this->addCss( $this->themeURL. 'bootstrap.css' );
		}

 		$files = glob( $lessDir . '*.less' );

 	 	 $dfiles  = glob( $this->_themeLessDir. '*.less');
 	 	 if( $dfiles ){
 	 	 	
 	 	 	foreach ($dfiles as $file) {	
 	 	 	
 	 	 		$filename =  basename($file) ;
 	 	 		if( $filename == 'bootstrap.less' ){  
					continue;
				}
				if( $filename == 'stylesheet.less' ){
					continue;
				}else { 
					$this->_rcomplie( $file, $this->_themeDir, $lessTarget );
				}

			}
 	 	 }
 	 	 
		if ($files) {
			foreach ($files as $file) {	 
				 $filename =  basename($file) ;

				 $cssFile = str_replace( ".less", "-less.css", $filename );

				 if( $filename == 'bootstrap.less' ){   
				 	continue;
				 }else {
				 	$this->_rcomplie( $file, $lessDir, $lessTarget );	
				 }
				
			}
		}
		if( $direction == 'rtl' ) {
		
			$files = glob( $this->_themeLessDir . $this->_lessAppFolder . '/rtl/*.less' );
			if ($files) {
				foreach ($files as $file) {	 
					$filename =  basename($file) ;
					$cssFile = str_replace( ".less", "-less.css", $filename );
					$this->compileFile( $file, $lessTarget.$cssFile );
					$this->addCss( $this->_lessDevURL. $cssFile );
				}
			}
		}	
		return $this->css;
	}

	/**
	 * read including less file and compiles those files in target folder.
	 */
	protected function _rcomplie( $file,$lessDir, $lessTarget ){
		$less = new lessc();
		$content = file_get_contents( $file );
	 	$content = preg_replace('!/\*[^*]*\*+([^/][^*]*\*+)*/!', '', $content);
	 
	 	preg_match_all('#^\s*@import\s+"([^"]*)"#im', $content, $matches);

	 	if( isset($matches[1]) && ($lessFiles=$matches[1]) ){
	 		 $mixs = '';
	 		 $vars = '';
	 		 $lastTime = '';

	 		 foreach( $lessFiles as $lessFile ){
	 		 	if(  preg_match("#mixins#", $lessFile) ){
	 		 		$content = file_get_contents( $lessDir.$lessFile );
	 		 		$mixs .= $content;
	 		 	}	
	 		 	if(  preg_match("#vars#", $lessFile) ){  
	 		 		$content = file_get_contents( $lessDir.$lessFile );
	 		 		$vars .= $content;	
	 		 	}
	 		 }

	 		 $mixvars = $mixs . "\r\n". $vars;
				
	 		 foreach( $lessFiles as $lessFile ){

	 		 	 if(  preg_match("#mixins#", $lessFile) ){
	 		 	 		continue;
	 		 	 }	
	 		 	 if(  !preg_match("#vars#", $lessFile) && file_exists($lessDir.$lessFile ) ){

	 		 	 	 $content = file_get_contents( $lessDir.$lessFile );
	 		 		 $cssURL  = $this->themeURL.str_replace( $this->_lessAppFolder.'/','',str_replace( '\\','/', $lessFile ) );

	 		 	 	 $lessFile = str_replace("../","",$lessFile);
	 		 	 	 $expfile = str_replace( '/','-', $lessFile );	
	 		 	 	 $expfile = str_replace( ".less", "-less.css", $expfile );

					 $isChange = true;	 				
	 				 
	 				 /* check this file have any changes based on file time */
	 		 	 	 if( $this->hasChange( $lessDir.$lessFile, $lessTarget.$expfile )  ){
	 		 	 		$out = $less->compile(  $mixvars . "\r\n". $content );
	 		 	 		$out = PavoCompressHelper::replaceURL( $out , $cssURL );
	 		 	 	  	$aa = file_put_contents( $lessTarget.$expfile , $out );
	 		 	 	 }	

		 	 		 $this->addCss( $this->_lessDevURL. $expfile.'?r='.rand(1,9) );		
	 		 	 }
	 		 }/* end foreach */
	 	}
	}

	/**
	 * check source files and target files having changes based on file time.
	 */
	function hasChange( $sfile, $tfile ){
		if( !file_exists($sfile) || !file_exists($tfile) ){
			return true; 
		}else if( $this->lastTimeChanged > filemtime($tfile) ){  
			return true;
		}
		return filemtime($sfile ) > filemtime($tfile) ;
	}

	/*
	 * add css to collection.
	 */
	protected function addCss( $file ){
		$this->css[] = $file;
	}

	/**
	 * compile less to css and save cache.
	 */
	public function compileFile( $sfile, $tfile ){
		if( $this->hasChange($sfile, $tfile) ){  
			$less = new lessc();
			$less->compileFile( $sfile, $tfile );
			//@touch( $tfile , filemtime($sfile) ); 
		}
	}
	
	public function compileBootstrap(){
		$lessTarget =  $this->_themeDir.'/stylesheet/';
		$bootstrapLess =  $this->_themeLessDir . $this->_lessAppFolder. '/rtl/bootstrap/bootstrap.less' ;
		$this->compileFile(  $bootstrapLess, $lessTarget.'bootstrap-rtl.css' );
		$this->compileFile(  $this->_themeLessDir.'bootstrap.less', $lessTarget."bootstrap.css"  ); 
	}

	public function setLastTimeChanged( $time ){
		$this->lastTimeChanged = $time;
		return $this;
	}

	/**
	 * compile less to css and export to stylesheet folder
	 */
	public function compileLess(){

		$this->importLib( 'lessc.inc.php' );
		$lessTarget =  $this->_themeDir.'/stylesheet/';
		$this->compileBootstrap();

	 	/* import bootstrap framework */
 		$files = glob( $this->_themeLessDir . '*.less' );

		if ($files) {
			$this->compile( $files, $lessTarget );
		}


		$skins = glob( $this->_themeLessDir . $this->_lessAppFolder.'/skins/*' , GLOB_ONLYDIR );

		if( $skins ){
			
			$tchanged = $this->lastTimeChanged;

			foreach( $skins as $folder ){
			  	$dir = basename( $folder );
			 	$target = $this->_themeDir.'/stylesheet/'.$dir.'/';
			 	if( !is_dir($target) ){
			 	 	mkdir( $target, 0755 );
			 	} 

			 	$t = $this->getTimeChangedSkinVars( $dir );
			 	$this->lastTimeChanged = max( $this->lastTimeChanged, $t );

			 	$files = glob( $folder. '/*.less' );
			 	if( $files ) { 
		 			$this->compile( $files, $target );	
				}

				$this->lastTimeChanged = $tchanged; 
			}
		}

		/* build bootstrap framework and others for rtl */
		$bootstrapLess =  $this->_themeLessDir .$this->_lessAppFolder. '/rtl/bootstrap/bootstrap.less' ;
 		$this->compileFile( $bootstrapLess, $this->_themeDir.'/stylesheet/bootstrap-rtl.css' );	
 		
		$files = glob( $this->_themeLessDir . $this->_lessAppFolder. '/rtl/*.less' );
		$target = $lessTarget;

		if( $files && is_dir($target) ) { 
			$this->compile( $files, $target );
		} 

		return true;
	}

	/**
	 *  compile list of files and generates to css in target folder.
	 */
	protected function compile( $files, $target ){
 		foreach( $files as $file ){
		 	$cssFile = str_replace( ".less", ".css", basename($file) );	
		 	$this->compileFile( $file, $target.$cssFile );
	 	} 
	}
}

?>