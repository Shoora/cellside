<?php

/**
 * Breadcrumb
 *
 * @access public
 * @param array
 * @param string
 * @param string
 * @return string
 */
 
if (!function_exists('breadcrumb')) {
	
	function breadcrumb($breadcrumbs, $class = false, $attr = false) {

		$output = '<div class="breadcrumb '. $class .'" '.$attr.'>';
		foreach ($breadcrumbs as $breadcrumb) {
			$output .= $breadcrumb['separator'].'<a href="'. $breadcrumb['href'] .'">'. $breadcrumb['text'].'</a>';
		}
		$output .= '</div>';
		return $output;
	}

}

/**
 * Drop-down Menu (CodeIgniter function)
 *
 * @access public
 * @param string
 * @param array
 * @param string
 * @param string
 * @return string
 */
if ( ! function_exists('form_dropdown'))
{
	function form_dropdown($name = '', $options = array(), $selected = array(), $extra = '')
	{
		if ( ! is_array($selected))
		{
			$selected = array($selected);
		}

		// If no selected state was submitted we will attempt to set it automatically
		if (count($selected) === 0)
		{
			// If the form name appears in the $_POST array we have a winner!
			if (isset($_POST[$name]))
			{
				$selected = array($_POST[$name]);
			}
		}

		if ($extra != '') $extra = ' '.$extra;

		$multiple = (count($selected) > 1 && strpos($extra, 'multiple') === FALSE) ? ' multiple="multiple"' : '';

		$form = '<select name="'.$name.'"'.$extra.$multiple.">\n";

		foreach ($options as $key => $val)
		{
			$key = (string) $key;

			if (is_array($val) && ! empty($val))
			{
				$form .= '<optgroup label="'.$key.'">'."\n";

				foreach ($val as $optgroup_key => $optgroup_val)
				{
					$sel = (in_array($optgroup_key, $selected)) ? ' selected="selected"' : '';

					$form .= '<option value="'.$optgroup_key.'"'.$sel.'>'.(string) $optgroup_val."</option>\n";
				}

				$form .= '</optgroup>'."\n";
			}
			else
			{
				$sel = (in_array($key, $selected)) ? ' selected="selected"' : '';

				$form .= '<option value="'.$key.'"'.$sel.'>'.(string) $val."</option>\n";
			}
		}

		$form .= '</select>';

		return $form;
	}
}

/**
 * Multi-select menu (CodeIgniter function)
 *
 * @access public
 * @param string
 * @param array
 * @param mixed
 * @param string
 * @return type
 */
if ( ! function_exists('form_multiselect'))
{
	function form_multiselect($name = '', $options = array(), $selected = array(), $extra = '')
	{
		if ( ! strpos($extra, 'multiple'))
		{
			$extra .= ' multiple="multiple"';
		}

		return form_dropdown($name, $options, $selected, $extra);
	}
}

/**
 * Checkbox Field
 *
 * @access public
 * @param string
 * @param string
 * @param string
 * @param string
 * @return string
 */
if ( ! function_exists('form_checkbox'))
{
	function form_checkbox($name = false, $checked = FALSE, $value = false, $extra = '')
	{
		return '<input '.($name ? 'name="'.$name.'"' : '').' type="checkbox" value="'.($value ? $value : 'on').'" '.($checked ? 'checked' : '').' '.$extra.' />';
	}
} 

/**
 * Radio Button CodeIgniter function
 *
 * @access public
 * @param mixed
 * @param string
 * @param bool
 * @param string
 * @return string
 */
if ( ! function_exists('form_radio'))
{
	function form_radio($name, $data = array(), $checked = FALSE, $after = '', $extra = '')
	{
		if ( ! is_array($data))
		{
			return false;
		}
		
		$output = '';
		
		foreach($data as $value => $text) {
			$output .= '<input name="'.$name.'" type="radio" value="'.$value.'" '.((string)$checked === (string)$value ? 'checked' : '').' '.$extra.'> '. $text;
			$output .= $after;
		}
		
		return $output;
	}
}
 