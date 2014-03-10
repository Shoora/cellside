<?php
/******************************************************
 * @package  : Pav Popular tags module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/

/**
 * class ModelPavpopulartagstag 
 */
class ModelPavpopulartagstag extends Model {		
	
	public function getRandomTags($limit = 5, $min_font_size = 9, $max_font_size = 25, $font_weight) {
		$names		= array();
		$totals		= array();
		$tags		= array();
		$tagcloud	= '';
		
		$sql = "SELECT DISTINCT tag FROM " . DB_PREFIX . "product_description 
				WHERE language_id=" . (int)$this->config->get('config_language_id') . " LIMIT " . (int)$limit;
		
		$tagNameQuery = $this->db->query($sql);
		
		if (count($tagNameQuery->rows) > 0) {
			foreach ($tagNameQuery->rows as $row) {
				$sql = "SELECT pd.tag FROM " . DB_PREFIX . "product_description pd
						INNER JOIN " . DB_PREFIX . "product p ON pd.product_id = p.product_id
						WHERE 
							pd.language_id = '" . (int)$this->config->get('config_language_id') . "'
						ORDER BY p.viewed DESC";
				$tagCountQuery = $this->db->query($sql);
				if (isset($row['tag']) && !empty($row['tag'])) {
					$names[]	= $row['tag'];
					$totals[]	= $tagCountQuery->num_rows;
				}
			}
			if (isset($names) && !empty($names)) {
				$tags = array_combine($names, $totals);
				$tagcloud = $this->generateTag($tags, true, $min_font_size, $max_font_size, $font_weight);
			}
		}
		
		return $tagcloud;
	}

	private function generateTag($tags, $resize = true, $min_font_size = 9, $max_font_size = 25, $font_weight) {

		if (version_compare(VERSION, '1.5.6', '>=')) {
			$filter_tag = "tag=";
		} else {
			$filter_tag = "filter_tag=";
		}

		if ($resize == true) {
			arsort($tags);

			$max_qty = max(array_values($tags));
			$min_qty = min(array_values($tags));

			$spread = $max_qty - $min_qty;

			if ($spread == 0) {
				$spread = 1;
			}

			$step = ((int)$max_font_size - (int)$min_font_size) / ($spread);

			$cloud = array();

			foreach ($tags as $key => $value) {
				$size=rand((int)$min_font_size,(int)$max_font_size);
			
				$cloud[] = '<a href="' . $this->url->link('product/search', $filter_tag . $key) . '" style="text-decoration:none;font-size:' . $size . 'px;font-weight:' . $font_weight . ';" title="">' . $key . '</a> ';
			}
			
		} else {
		
			foreach ($tags as $key => $value) {
				$cloud[] = '<a href="' . $this->url->link('product/search', $filter_tag . $key) . '" style="text-decoration:none;" title="">' . $key . '</a> ';
			}
		}

		$tagcloud = '';

		shuffle($cloud);

		for ($x = 0; $x < count($cloud); $x++) {
			$tagcloud .= $cloud[$x];
		}

		return $tagcloud;
	}
}
?>
