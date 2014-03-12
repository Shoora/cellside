<?php
class ModelCatalogTestimonial extends Model {
	public function addTestimonial($data, $status) {
	
		$private_text = (isset($data['private_text'])) ? $this->db->escape(strip_tags($data['private_text'])) : '';
		$public_text = (isset($data['public_text'])) ? $this->db->escape(strip_tags($data['public_text'])) : '';
		$company = (isset($data['company'])) ? $this->db->escape($data['company']) : '';
		$url = (isset($data['url'])) ? $this->db->escape($data['url']) : '';
		$telephone = (isset($data['telephone'])) ? $this->db->escape($data['telephone']) : '';
		$email = (isset($data['email'])) ? $this->db->escape($data['email']) : '';		$location = (isset($data['location'])) ? $this->db->escape($data['location']) : '';

		$language = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1' AND code = '" . $this->language->get('code') . "'"); 
		$this->db->query("INSERT INTO " . DB_PREFIX . "testimonial SET
				title = '" . $this->db->escape($data['title']) . "',
				author = '" . $this->db->escape($data['author']) . "', 
				private_text = '" . $private_text . "', 
				public_text = '" . $public_text . "', 
				company = '" . $company . "', 
				location = '" . $location . "', 
				url = '" . $url . "', 
				telephone = '" . $telephone . "', 
				email = '" . $email . "', 				language_id = '" . $language->row['language_id'] . "',
				rating = '" . (int)$data['rating'] . "', 
				status = '" . $status ."',
				date_added = NOW()");				
		$this->cache->delete('testimonial');
		$this->notifyAdmin();
	}

	public function getPageContent() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial_content WHERE language_id = '" . (int)$this->config->get('config_language_id') . "'");		
		return $query->row;
	}

	public function getTestimonial($testimonial_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial WHERE testimonial_id = '" . (int)$testimonial_id . "' AND status = '1'");	
		return $query->rows;
	}
	
	public function getTestimonials($start = 0, $limit = 20, $order = false, $featured = false) {
		$language = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1' AND code = '" . $this->language->get('code') . "'"); 
		$sql = "SELECT * FROM " . DB_PREFIX . "testimonial WHERE status = '1'";
		if ($this->config->get('testimonial_active_language_only')) {
			$sql .= " AND language_id = '" . $language->row['language_id'] . "'";
		}
		
		if ($featured) {
			$sql .= " AND featured = '1'";
		}
		
		if ($order) {
			if ($order == 'RAND') {
				$sql .= " ORDER BY RAND()";
			}
		} else {
			$sql .= " ORDER BY date_added DESC";
		}
		
		$sql .= " LIMIT " . (int)$start . "," . (int)$limit;
		$query = $this->db->query($sql);	
		return $query->rows;
	}
	
	public function getTotalTestimonials() {
		$language = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1' AND code = '" . $this->language->get('code') . "'"); 
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "testimonial WHERE status = '1'";
		if ($this->config->get('testimonial_active_language_only')) {
			$sql .= " AND language_id = '" . $language->row['language_id'] . "'";
		}
		$query = $this->db->query($sql);
		return $query->row['total'];
	}
	
	public function getSummaryData() {
		$query = $this->db->query("SELECT SUM(rating)/COUNT(*) as rating, COUNT(*) as total FROM " . DB_PREFIX . "testimonial WHERE status ='1'");
		return $query->row;
	}
	
	public function notifyAdmin() {
		$this->language->load('mail/testimonial');
		$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));
		
		$message = sprintf($this->language->get('text_approval'), $this->config->get('config_name')) . "\n\n";				
		$message .= $this->language->get('text_thanks') . "\n";
		$message .= $this->config->get('config_name');
		
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($this->config->get('config_email'));
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
		$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
		$mail->send();
		
	}
}
?>