<?php

/**
 * Breadcrumb
 *
 * @access	public
 * @param	array
 * @param	string
 * @param	bool
 */
 
if (!function_exists('index_value')) {
	
	function index_value($array, $key, $zero = false) {

		if (!is_array($array) && !$zero) 
			{
				return false;
			}
			
		if (!is_array($array) && $zero) 
			{
				return 0;
			}
		
		if (!isset($array[$key]) && !$zero)
			{
				return false;
			}
			
		if (!isset($array[$key]) && $zero)
			{
				return 0;
			}
			
		if (isset($array[$key]) && ($array[$key] === false || $array[$key] === 0) && !$zero) 
			{
				return false;
			}
		
		if (isset($array[$key]) && ($array[$key] === false || $array[$key] === 0) && $zero) 
			{
				return 0;
			}
			
		return $array[$key];
		
	}

}