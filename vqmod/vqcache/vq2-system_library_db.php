<?php
class DB {
	private $driver;

			public $total_queries;
			public $total_query_time;
			public $total_slow_queries;
			public $query_data;
			
	
	public function __construct($driver, $hostname, $username, $password, $database) {
$driver = 'ipsmysql';
		if (file_exists(DIR_DATABASE . $driver . '.php')) {
			require_once(VQMod::modCheck(DIR_DATABASE . $driver . '.php'));
		} else {
			exit('Error: Could not load database file ' . $driver . '!');
		}
				
		$this->driver = new $driver($hostname, $username, $password, $database);
$this->total_query_time = 0; $this->total_queries = 0; $this->total_slow_queries = 0; $this->query_data = array();
	}
		

			public function cachedQuery($sql, $cachedir) {
				return $this->driver->cachedQuery($sql, $cachedir);
			}
			
  	public function query($sql) {
$this->total_queries++;
		
			// Log Time
			$trace = debug_backtrace();
			$filename = (isset($trace[0]['file'])) ? $trace[0]['file'] : '---';
			$query_time = (time() + microtime());
			$result = $this->driver->query($sql);
			$exec_time = (time() + microtime()) - $query_time;
			$this->total_query_time = $this->total_query_time + $exec_time;
			if ($exec_time > 0.1) {
				$this->total_slow_queries = $this->total_slow_queries + 1;
				$this->query_data[] = array('filename' => $filename, 'exec_time' => $exec_time, 'sql' => $sql);
			}

			return $result;
			
  	}
	
	public function escape($value) {
		return $this->driver->escape($value);
	}
	
  	public function countAffected() {
		return $this->driver->countAffected();
  	}

  	public function getLastId() {
		return $this->driver->getLastId();
  	}	
}
?>