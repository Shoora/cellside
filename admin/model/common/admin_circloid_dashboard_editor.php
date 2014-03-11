<?php
class ModelCommonAdminCircloidDashboardEditor extends Model {

	public function installTheme(){
		
		$file = DIR_APPLICATION . 'base5builder_circloid_install/install_circloid_color_widget.sql';

		if ($sql = file($file)) {
			$query = '';

			foreach($sql as $line) {
				$tsl = trim($line);

				if (($sql != '') && (substr($tsl, 0, 2) != "--") && (substr($tsl, 0, 1) != '#')) {
					$query .= $line;

					if (preg_match('/;\s*$/', $line)) {
						$query = str_replace("CREATE TABLE IF NOT EXISTS `oc_", "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX, $query);
						$query = str_replace("INSERT INTO `oc_", "INSERT INTO `" . DB_PREFIX, $query);

						$result = $this->db->query($query);

						if(!$result){
							// return FALSE;
							echo "false";
						}

						$query = '';
					}
				}
			}
		}
		return TRUE;

	}

	public function tablesExist(){

		$data['color_preset'] = 0;
		$data['widget_layout'] = 0;

		// Check if Color Profile table exists
		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "circloid_color_preset'");

		if($query->num_rows > 0){
			$data['color_preset'] = 1;
		}

		// Check if Widget Layout table exists
		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "circloid_widget_layout'");

		if($query->num_rows > 0){
			$data['widget_layout'] = 1;
		}

		return $data;
	}

	public function getWidgets(){

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout ORDER BY id ASC");

		return $query->rows;
	}

	public function getWidget($id){

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . $id . "'");

		return $query->row;
	}

	public function getColorProfile(){

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_color_preset ORDER BY id ASC");

		return $query->rows;
	}

	public function getColorProfileCss(){

		$query = $this->db->query("SELECT css_name FROM " . DB_PREFIX . "circloid_color_preset WHERE enabled = '1'");

		return $query->row;
	}

	public function enableColorProfile($id){

		// First disable all fields that have "enabled" as "1", then set the row with id = $id as enabled = "1"

		$this->db->query("UPDATE " . DB_PREFIX . "circloid_color_preset SET enabled = '0' WHERE enabled = '1'");

		$this->db->query("UPDATE " . DB_PREFIX . "circloid_color_preset SET enabled = '1' WHERE id = '" . $this->db->escape($id) . "'");

		// Check if the table has been updated and return true

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_color_preset WHERE enabled = '1'");

		if($query->row['id'] == $id){

			$data = $query->row;

			return $data;
		}

		return FALSE;

	}

	public function enableWidgetLayout($id){

		// First disable all fields that have "enabled" as "1", then set the row with id = $id as enabled = "1"

		$this->db->query("UPDATE " . DB_PREFIX . "circloid_widget_layout SET enabled = '0' WHERE enabled = '1'");

		$this->db->query("UPDATE " . DB_PREFIX . "circloid_widget_layout SET enabled = '1' WHERE id = '" . $this->db->escape($id) . "'");

		// Check if the table has been updated and return true

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . $id . "' AND enabled = '1'");

		if($query->row){

			return TRUE;
		}

		return FALSE;

	}

	public function copyWidgetLayout($id, $new_layout_name, $new_description){

		// Copy the $id row and rename the new row as $new_layout_name

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . (int)$id . "'");

		if(isset($query->row['id'])){

			$layout_copy = $query->row['layout'];

			$insert = $this->db->query("INSERT INTO " . DB_PREFIX . "circloid_widget_layout SET layout_name = '" . $this->db->escape($new_layout_name) . "', description = '" . $this->db->escape($new_description) . "', layout = '" . $this->db->escape($layout_copy) . "'");

			if($insert){
				return TRUE;
			}

			return FALSE;

		}

		return FALSE;

	}

	public function deleteWidgetLayout($id){
		// If it is a preset, return error saying you cannot delete a preset
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . (int)$id . "'");

		if($query->row['creator'] == "theme" || $query->row['enabled'] == 1){
			return FALSE;
		}else{
			$this->db->query("DELETE FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . (int)$id . "'");
			return TRUE;
		}
	}

	public function checkLayoutCreator($id){
		// If $id exists, check if it is a user theme or preset
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "circloid_widget_layout WHERE id = '" . (int)$id . "'");

		if(isset($query->row['creator'])){
			if($query->row['creator'] != "user"){
				return FALSE;
			}else{
				return TRUE;
			}
		}else{
			return FALSE;
		}

	}

	public function updateWidgetLayout($id, $layout_name, $description, $layout){

		// First find the row with $id then update it. If it doesn't exist, the return an error

		$this->db->query("UPDATE " . DB_PREFIX . "circloid_widget_layout SET layout_name = '" . $this->db->escape($layout_name) . "', description = '" . $this->db->escape($description) . "', layout = '" . $this->db->escape($layout) . "' WHERE id = '" . $this->db->escape($id) . "'");

		return TRUE;

	}

	public function getLowStock(){
		// Get total number of Low Stock items
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE quantity <= '10'");
		
		return $query->row['total'];
	}
	
	public function getOutOfStock(){
		// Get total number of Out OF Stock items
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE quantity = '0'");
		
		return $query->row['total'];
	}

	public function getNewsletterSubscribers(){
		// Get total number of Newsletter Subscribers
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE newsletter = '1'");
		
		return $query->row['total'];
	}
}
?>