<?php
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 2.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) October 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

class ModelSampleModule extends Model {
	
	/**
	 * get data sample by actived theme
	 */
	public function getSamplesByTheme( $theme ){
		$this->load->model('setting/extension');
		$extensions = $this->model_setting_extension->getInstalled('module');
	
		$output = array();
		$files = glob(  dirname(__FILE__).'/'.$theme.'/modules/*.php' );
		foreach( $files as $dir ){
			$module = str_replace(".php","",basename( $dir ));
			if( !is_file(DIR_APPLICATION."controller/module/".$module.".php") ){	
				$moduleName = $module;
				$existed = 0;
			}else {
				$this->language->load( 'module/'.$module );		
				$moduleName = $this->language->get('heading_title');
				$existed = 1;
			}
			
			$data = $this->config->get($module . '_module');
			 
			$output[$module] = array('extension_installed' => in_array($module,$extensions), 
									 "module"    => $module ,
									 'existed'   => $existed, 
									 'installed' => empty($data)?0:1, 
									 'moduleName'=> $moduleName );
	
		}		

		return $output;
	}
	
	/**
	 * get modules having queries
	 */
	public function getModulesQuery( $theme ){
		if( is_file(dirname(__FILE__).'/'.$theme.'/sample.php') ) {
			
			require( dirname(__FILE__).'/'.$theme.'/sample.php' );
			
			$dir = dirname(__FILE__).'/'.$theme.'/';

			$this->load->model('setting/extension');
			
			$query 	    =  ModuleSample::getModulesQuery();
			$modules    = array();
			$extensions = $this->model_setting_extension->getInstalled('module');
			
	
			foreach( $query as $key=>$q ) {
				if(  in_array($key,$extensions) ){
					$this->language->load('module/' . $key);
					$modules[$key] = $this->language->get( 'heading_title' );
				}
			}
			
			return $modules;
		}	
		return array();
	}
	
	/**
	 * export data sample of modules
	 */
	public function export( $theme ) {
		if( is_file(dirname(__FILE__).'/'.$theme.'/sample.php') ) {
			require( dirname(__FILE__).'/'.$theme.'/sample.php' );
			$dir = dirname(__FILE__).'/'.$theme.'/modules/';
			$modules = ModuleSample::getModules();
			if( isset($modules) ){
				foreach( $modules as $module ){
					$data = serialize($this->config->get($module . '_module'));
					$fp = fopen( $dir.$module.'.php', 'w');
					fwrite($fp, $data );
					fclose($fp);
				}
		
			}
		}
	}

	public function backup( $theme ){
		$expdir = DIR_CACHE.'backup_'.trim($theme).'/';
		
		if( !is_dir($expdir) ){
			mkdir( $expdir, 0777 );
		}


		if( is_file(dirname(__FILE__).'/'.$theme.'/sample.php') ) {
			require( dirname(__FILE__).'/'.$theme.'/sample.php' );
			$dir =  $expdir;
			$modules = ModuleSample::getModules();
			if( isset($modules) ){
				foreach( $modules as $module ){
					$data = serialize($this->config->get($module . '_module'));
					$fp = fopen( $dir.$module.'.php', 'w');
					fwrite($fp, $data );
					fclose($fp);
				}
		
			}
		}
		return ;
	}

	public function getBackupByTheme( $theme ){
		$output = array();

		$files = glob(  DIR_CACHE.'backup_'.trim($theme).'/*.php');
		foreach( $files as $dir ){
			$module = str_replace(".php","",basename( $dir ));
			$output[$module] = $module;
		}
		return $output;
	}
	public function restoreDataModule( $theme, $module ){
		$this->load->model('setting/setting');
	//	$dir = dirname(__FILE__).'/'.$theme.'/modules/'; 
		$dir = DIR_CACHE.'backup_'.trim($theme).'/';
		if( is_file($dir.$module.'.php') ){
			$data = unserialize(file_get_contents( $dir.$module.'.php' ));


			if( is_array($data) ){
				$output = array();
				$output[$module."_module"] = $data; 
				$this->model_setting_setting->editSetting( $module, $output );	
			}
		}	 
	}
	
	/**
	 * install sample query
	 */
	public function installSampleQuery( $theme, $module ){
		if( is_file(dirname(__FILE__).'/'.$theme.'/sample.php') ) {
			require( dirname(__FILE__).'/'.$theme.'/sample.php' );
			$dir = dirname(__FILE__).'/'.$theme.'/';
			
			$this->load->model('setting/extension');
			
			$query =  ModuleSample::getModulesQuery();
			$modules = array();
			 
			if( isset($query[$module]) ){

								
								
				foreach( $query[$module] as $query ){
					$this->db->query( $query );
				}
				die('done');
			}
		}	

		die( 'could not install data sample for this' );
	}

	/**
	 * install store sample
	 */
	public function installStoreSample( $theme ){
		if( is_file(dirname(__FILE__).'/'.$theme.'/sample.php') ) {
			require( dirname(__FILE__).'/'.$theme.'/sample.php' );
			$dir = dirname(__FILE__).'/'.$theme.'/';
			$configs = ModuleSample::getStoreConfigs();

			if( isset($configs) ){
				$this->load->model('setting/setting');
				foreach( $configs as $key => $value ){
					$group = 'config';
					$store_id = 0;	
					$this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($value) . "' WHERE `group` = '" . $this->db->escape($group) . "' AND `key` = '" . $this->db->escape($key) . "' AND store_id = '" . (int)$store_id . "'");
				}
			}
		}
	}
	
	/**
	 * install sample module
	 */
	public function installSample( $theme, $module ){

		$this->load->model('setting/setting');
		$dir = dirname(__FILE__).'/'.$theme.'/modules/'; 
		if( is_file($dir.$module.'.php') ){
			$data = unserialize(file_get_contents( $dir.$module.'.php' ));

			if( is_array($data) ){
				$output = array();
				$output[$module."_module"] = $data; 
				$this->model_setting_setting->editSetting( $module, $output );	
			}
		}	 
	}
}
?>