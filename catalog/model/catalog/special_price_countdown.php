<?php
class ModelCatalogSpecialPriceCountDown extends Model {

	public function getProductSpecialDates($product_id) {
	
		(string) $display_output = null;
		(string) $minute = 60;
		(string) $hour = 60 * $minute;
		(string) $day = 24 * $hour;
		
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}	
		
		$query = $this->db->query("SELECT date_start, date_end  FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' AND customer_group_id = '" . (int)$customer_group_id . "' AND ((date_start = '0000-00-00' OR date_start < NOW()) AND (date_end = '0000-00-00' OR date_end > NOW())) ORDER BY priority ASC, price ASC LIMIT 1");
		
		if ($query->num_rows) {
			
			$time_left = strtotime($query->row["date_end"]) - strtotime(date('Y-m-d'));
			$days_left = floor($time_left/$day);
		
			if ($time_left > 0)
			{
				$display_output = getdate();
				$display_output["days_left"] = $days_left;
			}
		}
		
		return $display_output;
		
	}
}
?>