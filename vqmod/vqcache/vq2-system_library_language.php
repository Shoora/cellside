<?php
class Language {
	private $default = 'english';
	private $directory;
	private $data = array();
 
	public function __construct($directory) {
		$this->directory = $directory;
	}
	
  	public function get($key) {
   		return (isset($this->data[$key]) ? $this->data[$key] : $key);
  	}
	
// template email - start
		public function loadlanguage($filename) {
			$file = str_replace('catalog', 'admin', DIR_LANGUAGE) . $this->directory . '/' . $filename . '.php';
  
			if (file_exists($file)) {
				$_ = array();

				require(VQMod::modCheck($file));

				$this->data = array_merge($this->data, $_);

				return $this->data;
			}

			$file = str_replace('catalog', 'admin', DIR_LANGUAGE) . $this->default . '/' . $filename . '.php';

			if (file_exists($file)) {
				$_ = array();

				require(VQMod::modCheck($file));

				$this->data = array_merge($this->data, $_);
return $this->data; // MXI

				return $this->data;
			} else {
				trigger_error('Error: Could not load language ' . $filename . '!');
				exit();
			}
		}
		// template email - stop
	public function load($filename) {
		$file = DIR_LANGUAGE . $this->directory . '/' . $filename . '.php';
    	
		if (file_exists($file)) {
			$_ = array();
	  		
			require(VQMod::modCheck($file));
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		}
		
		$file = DIR_LANGUAGE . $this->default . '/' . $filename . '.php';
		
		if (file_exists($file)) {
			$_ = array();
	  		
			require(VQMod::modCheck($file));
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		} else {
			trigger_error('Error: Could not load language ' . $filename . '!');
		//	exit();
		}
  	}
}
?>
