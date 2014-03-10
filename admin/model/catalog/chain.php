<?php
/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/

class ModelCatalogChain extends Model {
	
	private $_default_settings = array(
			'chain_display_chain_position_type' 		=> 'after',
			'chain_display_chain_position_container' 	=> '.product-info',
			'chain_display_image_width' 				=> '100',
			'chain_display_image_height' 				=> '100',
			'chain_display_you_save' 					=> 'on',
			'chain_display_old_price' 					=> 'on',
			'chain_display_discount_percent' 			=> 'on',
			'chain_style' 								=> 'classic',
			'chain_style_container_margin_top' 			=> '10',
			'chain_style_container_margin_bottom' 		=> '5',
			'chain_style_container_padding_top' 		=> '10',
			'chain_style_container_padding_bottom' 		=> '10',
			'chain_style_container_padding_left' 		=> '5',
			'chain_style_container_padding_right' 		=> '5',
			'chain_style_border_width' 					=> '1',
			'chain_style_border_color' 					=> '#cccccc',
			'chain_style_border_radius' 				=> '5',
			'chain_style_header_show' 					=> 'on',
			'chain_style_header_color' 					=> '#333333',
			'chain_style_header_fontsize' 				=> '1.5em',
			'chain_style_discount_label_color' 			=> '#f28300',
			'chain_style_discount_color' 				=> '#ffffff',
			'chain_style_discount_fontsize' 			=> '0.9em',
			'chain_style_old_price_fontsize'			=> '16px',
			'chain_style_sign_color' 					=> '#000000',
			'chain_style_new_price_fontsize' 			=> '19px',
			'chain_style_options_color_unselected' 		=> '#cc0808',
			'chain_style_options_color_selected' 		=> '#048cec',
			'chain_style_extra_css' 					=> ".chain-item { \r\n\t/* for example you can add CSS here */ \r\n }",
			'chain_action_on_success' => 'redirect',
			'chain_action_redirect_url' => 'index.php?route=checkout/cart',
			'chain_options_title_lenght' => '180',
			'chain_options_popup_image_width' => '200',
			'chain_options_popup_image_height' => '200',
			'chain_slider_autoscroll' => '0',
			'chain_options_show_image' => 'on',
			'chain_slider_mousewheel' => '1',
			'chain_slider_nav' => '0',
			'chain_slider_arrows_background' => '#000000',
			'chain_slider_arrows_border_top' => '10',
			'chain_slider_arrows_border_bottom' => '10',
			'chain_slider_arrows_color_left' => '-4px -84px',
			'chain_slider_arrows_color_right' => '-45px -84px',
			'chain_style_header_line_height' => '1.5em', //
			'chain_style_price_font_weight' => 'bold',
			'chain_style_oldprice_color' => '#F00000',
			'display_chain_position' => 'custom',
			'chain_style_sign_fontsize' => '25px',
			'chain_style_total_price_fontsize' => '20px',
			'chain_style_header_padding_left' => '0px',
			'chain_style_you_save_fontsize' => '0.9em',
			'chain_style_you_save_color' => '#555555',
			'chain_style_total_price_color' => '#000000',
			'chain_display_chain_tab' => '0',
			'chain_ajax_loader' => '0'
		);
	
	public function __construct($registry) {
        parent::__construct($registry);
		$config = $registry->get('config');
	}
	
	public function default_settings() {
		return $this->_default_settings;
	}
	

	public function install() 
	{
		$sql = 	"CREATE TABLE IF NOT EXISTS `". DB_PREFIX ."chain_discount` (
				`chain_discount_id` INT(11) NOT NULL AUTO_INCREMENT,
				`main_product_id` INT(11) NOT NULL,
				`chain` TEXT NOT NULL,
				`quantity` TEXT NOT NULL,
				`order` INT(11) NOT NULL,
				PRIMARY KEY (`chain_discount_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;";
				
		$this->db->query($sql);
	}
	
	public function uninstall() 
	{
		$sql = "DROP TABLE `". DB_PREFIX ."chain_discount";
		$this->db->query($sql);
	}
	
	public function insert_chain($data) {
		$this->db->query("INSERT `". DB_PREFIX ."chain_discount` 
							(`main_product_id`, `chain`, `quantity`, `order`) 
								VALUES 
							('". (int)$data['main_product_id'] ."', '". $data['chain'] ."', '". $data['quantity'] ."', '".$data['order']."')");
	}
	public function update_chain($data, $id) {
		$this->db->query("UPDATE `". DB_PREFIX ."chain_discount` SET `chain`='". $data['chain'] ."', `quantity`='". $data['quantity'] ."', `order`='".$data['order']."' WHERE chain_discount_id=".(int)$id);
	}
	
	
	public function delete($main_product_id) {
		$this->db->query("DELETE FROM `". DB_PREFIX ."chain_discount` WHERE `main_product_id`=".(int)$main_product_id);
	}
	
	public function delete_chain($chain_id) {
		$this->db->query("DELETE FROM `". DB_PREFIX ."chain_discount` WHERE `chain_discount_id`=".(int)$chain_id);
	}
	
	function getChains($main_product_id) {	
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."chain_discount` WHERE `main_product_id`=". (int)$main_product_id. " ORDER BY `order` ASC");
		return $query->rows;
	}
	
	function getChain($chain_id) {
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."chain_discount` WHERE `chain_discount_id`=". (int)$chain_id);
		return $query->row;	
	}
	
	
	public function save() {
		
		$data = array();
		
		if ( isset($this->request->post['chain_delete']) ) 
			{
				foreach ($this->request->post['chain_delete'] as $chain_id) {
					$this->delete_chain($chain_id);
				}
			}
		
		if (isset($this->request->post['product']))
			{
				$order = 0;
				foreach ($this->request->post['product'] as $group_id => $product_row) {
					$order++;
					$data[$group_id]['main_product_id'] = $this->request->post['main_product_id'];
					$data[$group_id]['chain'] = serialize($product_row);
					$data[$group_id]['quantity'] = isset($this->request->post['chain_quantity'][$group_id]) ? serialize($this->request->post['chain_quantity'][$group_id]) : serialize(array());
					$data[$group_id]['order'] = $order;
					if (isset($this->request->post['update_chain'][$group_id])) {
						$data[$group_id]['action'] = 'update';
					} else {
						$data[$group_id]['action'] = 'delete';
					}
				}
			}

			foreach($data as $group_id => $row) {
				if ($row['action'] == 'update') {
					$this->update_chain($row, $group_id);
				} else {
					$this->insert_chain($row);
				}
			}

		
		
		return true;
		
	}
	
	function count_chains() {
		$query = $this->db->query("SELECT COUNT(*) AS `chains_count` FROM `". DB_PREFIX ."chain_discount`");
		return $query->row['chains_count'];
	}
	
}