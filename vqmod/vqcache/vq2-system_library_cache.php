<?php
class Cache { 
	private $expire = 3600; 

	public function get($key) {

			global $config;
			if (extension_loaded('apc') && $config->get('config_memory_cache') == 1) { 
				return unserialize(apc_fetch($key)); 
			} else if (extension_loaded('xcache') && $config->get('config_memory_cache') == 2) {
				return unserialize(xcache_get($key));
			} else {
			
		$files = glob(DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');

		if ($files) {
			$cache = file_get_contents($files[0]);
			
			$data = unserialize($cache);
			
			foreach ($files as $file) {
				$time = substr(strrchr($file, '.'), 1);

      			if ($time < time()) {
					if (file_exists($file)) {
						unlink($file);
					}
      			}
    		}
			
			return $data;			
}
		}
	}

  	public function set($key, $value) {

			global $config;
			if (extension_loaded('apc') && $config->get('config_memory_cache') == 1) { 
				apc_store($key,serialize($value), $this->expire);
			} else if (extension_loaded('xcache') && $config->get('config_memory_cache') == 2) {
				xcache_set($key, serialize($value), $this->expire);
			} else {
			
    	$this->delete($key);
		
		$file = DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.' . (time() + $this->expire);
    	
		$handle = fopen($file, 'w');

    	fwrite($handle, serialize($value));
		
    	fclose($handle);
}
  	}
	
  	public function delete($key) {

			global $config;
			if (extension_loaded('apc') && $config->get('config_memory_cache') == 1) { 
				apc_delete($key); 
			} else if (extension_loaded('xcache') && $config->get('config_memory_cache') == 2) {
				xcache_unset($key);
			} else {
			
		$files = glob(DIR_CACHE . 'cache.' . preg_replace('/[^A-Z0-9\._-]/i', '', $key) . '.*');
		
		if ($files) {
    		foreach ($files as $file) {
      			if (file_exists($file)) {
					unlink($file);
				}
    		}
		}
  	}
}
}
?>