<?php
class ModelModulePcpb extends Model {
	public function createDatabaseTables() {
		$prefix = DB_PREFIX;
		$sql = <<<EOF
		CREATE TABLE IF NOT EXISTS `{$prefix}pcpb_product` (
		  `product_id` int(11) NOT NULL,
		  `enable` tinyint(1) NOT NULL DEFAULT '0',
		  `add_text` tinyint(1) NOT NULL DEFAULT '0',
		  `add_images` tinyint(1) NOT NULL DEFAULT '0',
		  `add_custom_images` tinyint(1) NOT NULL DEFAULT '0',
		  `select_image_preset` tinyint(1) NOT NULL DEFAULT '0',
		  `upload_background` tinyint(1) NOT NULL DEFAULT '0',
		  KEY `product_id` (`product_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=latin1;
EOF;
		$this->db->query($sql);
		
		$sql = <<<EOF
		CREATE TABLE IF NOT EXISTS `{$prefix}pcpb` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `token` varchar(20) NOT NULL,
		  `content` text NOT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `token` (`token`)
		) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
				
EOF;
		$this->db->query($sql);
        
		$sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Hanalei Fill','Hanalei Fill')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','New Rocker','New Rocker')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Yeseva One','Yeseva One')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Marck Script','Marck Script')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Kavoon','Kavoon')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Mouse Memoirs','Mouse Memoirs')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Flavors','Flavors')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','UnifrakturMaguntia','UnifrakturMaguntia')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Ceviche One','Ceviche One')";
        $this->db->query($sql);
        $sql = "INSERT INTO `{$prefix}setting`(`group`, `key`, `value`) VALUES ('fonts_google','Risque','Risque')";
        $this->db->query($sql);
	}
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."pcpb_product`;";
		$this->db->query($sql);
		
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."pcpb`;";
		$this->db->query($sql);
        
        $sql = "DELETE FROM `".DB_PREFIX."setting` WHERE `group` = 'fonts_google'";
		$this->db->query($sql);
	}
	public function getPcpbProduct($product_id)
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pcpb_product WHERE product_id = '" . (int)$product_id . "'");
		return $query->row;
	}
    
    public function addGoogleFonts($group, $key, $store_id = 0) {		
		$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($key) . "'");
	}
    
    public function removeGoogleFonts($key, $store_id = 0) {		
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `key` = '" . $this->db->escape($key) . "'");
	}
}
?>