<?php
class ModelCatalogTestimonial extends Model {
	public function editPageContent($data) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "testimonial_content");		
		foreach ($data as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "testimonial_content SET 
				language_id = '" . (int)$language_id . "', 
				meta_keywords = '" . $this->db->escape($value['meta_keywords']) . "', 
				meta_description = '" . $this->db->escape($value['meta_description']) . "', 
				form_content = '" . $this->db->escape($value['form_content']) . "', 
				heading_content = '" . $this->db->escape($value['heading_content']) . "', 
				form_title = '" . $this->db->escape($value['form_title']) . "', 
				heading_title = '" . $this->db->escape($value['heading_title']) . "', 
				page_title = '" . $this->db->escape($value['page_title']) . "',
				email_subject = '" . $this->db->escape($value['email_subject']) . "',
				email_content = '" . $this->db->escape($value['email_content']) . "'");
		}
	
	}
	
	public function getPageContent() {
		$page_content_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "testimonial_content");
		
		foreach ($query->rows as $result) {
			$page_content_data[$result['language_id']] = $result;
		}
		
		return $page_content_data;
	}
	
	public function addTestimonial($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "testimonial SET
				title               = '" . $this->db->escape($data['title']) . "',
				author              = '" . $this->db->escape($data['author']) . "', 
				private_text        = '" . $this->db->escape(strip_tags($data['private_text'])) . "', 
				public_text         = '" . $this->db->escape(strip_tags($data['public_text'])) . "', 
				company             = '" . $this->db->escape($data['company']) . "', 
				location            = '" . $this->db->escape($data['location']) . "', 
				excerpt_title       = '" . $this->db->escape($data['excerpt_title']) . "',
				excerpt_public_text = '" . $this->db->escape(strip_tags($data['excerpt_public_text'])) . "', 
				url                 = '" . $this->db->escape($data['url']) . "', 
				telephone           = '" . $this->db->escape($data['telephone']) . "', 
				email               = '" . $this->db->escape($data['email']) . "', 
				rating              = '" . (int)$data['rating'] . "', 
				status              = '" . (int)$data['status'] . "', 
				featured            = '" . (int)$data['featured'] . "',
				language_id         = '" . (int)$data['language_id'] . "', 
				date_added          = NOW()");
				//store_id = '" . $this->db->escape($data['store_id']) . "', 
				
	}
	
	public function editTestimonial($id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "testimonial SET 
				title               = '" . $this->db->escape($data['title']) . "',
				author              = '" . $this->db->escape($data['author']) . "', 
				private_text        = '" . $this->db->escape(strip_tags($data['private_text'])) . "', 
				public_text         = '" . $this->db->escape(strip_tags($data['public_text'])) . "', 
				excerpt_title       = '" . $this->db->escape($data['excerpt_title']) . "',
				excerpt_public_text = '" . $this->db->escape(strip_tags($data['excerpt_public_text'])) . "', 
				company             = '" . $this->db->escape($data['company']) . "', 
				location            = '" . $this->db->escape($data['location']) . "', 
				url                 = '" . $this->db->escape($data['url']) . "', 
				telephone           = '" . $this->db->escape($data['telephone']) . "', 
				email               = '" . $this->db->escape($data['email']) . "', 
				rating              = '" . (int)$data['rating'] . "', 
				status              = '" . (int)$data['status'] . "',
				featured            = '" . (int)$data['featured'] . "',
				language_id         = '" . (int)$data['language_id'] . "'
				WHERE testimonial_id = '" . (int)$id . "'");
	}
	
	public function deleteTestimonial($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "testimonial WHERE testimonial_id = '" . (int)$id . "'");
	}
	
	public function getTestimonial($id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "testimonial WHERE testimonial_id = '" . (int)$id . "'");
		
		return $query->row;
	}

	public function getTestimonials($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "testimonial";
		
		$sort_data = array(
			'title',
			'author',
			'rating',
			'status',
			'date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY date_added";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		
		$query = $this->db->query($sql);
		
		return $query->rows;	
	}
	
	public function getTotalTestimonials() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "testimonial");
		return $query->row['total'];
	}
	
	public function getTotalTestimonialsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "testimonial WHERE status = '0'");
		return $query->row['total'];
	}

	public function getTotalPendingReminders() {
		if ($this->config->get('testimonial_email_status')) {
			$accepted_statuses = $this->config->get('testimonial_email_status');
		} else {
			$accepted_statuses = array('99999');
		}
		
		if ($this->config->get('testimonial_email_days')) {
			$days_interval = $this->config->get('testimonial_email_days');
		} else {
			$days_interval = 0;
		}
		
		$check_date = ($this->config->get('testimonial_email_date')) ? 'date_modified' : 'date_added';
		
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE feedback_reminder = '0' AND date_add(" . $check_date . ", INTERVAL " . $days_interval . " DAY) <= NOW() AND order_status_id IN (" . implode(',', $accepted_statuses) . ")");
		return $query->row['total'];
	}
	
	public function sendEmailReminders() {
		$total_dispatched = 0;
		$content = $this->getPageContent();
		$lang = $this->config->get('config_language_id'); 
		$accepted_statuses = $this->config->get('testimonial_email_status');
		if (empty($accepted_statuses)) { return 0; }
		$check_date = ($this->config->get('testimonial_email_date')) ? 'date_modified' : 'date_added';
		$reminders = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE feedback_reminder = '0' AND date_add(" . $check_date . ", INTERVAL " . $this->config->get('testimonial_email_days') . " DAY) <= NOW() AND order_status_id IN (" . implode(',', $accepted_statuses) . ")");
		
		if ($reminders->num_rows) {
			foreach ($reminders->rows as $reminder) {
				$message = $content[$lang]['email_content'];
				$message = str_replace('{first_name}', $reminder['firstname'], $message);
				$message = str_replace('{last_name}', $reminder['lastname'], $message);
				$message = str_replace('{feedback_link}',  HTTP_CATALOG . 'index.php?route=product/testimonial', $message);
				
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');	
				$mail->setTo($reminder['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject(html_entity_decode($content[$lang]['email_subject'], ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
				
				$this->db->query("UPDATE `" . DB_PREFIX . "order` SET feedback_reminder = '1' WHERE order_id = '" . $reminder['order_id'] . "'");
				$total_dispatched = $total_dispatched + 1;	
			}
		}
		return $total_dispatched;
	}	

	public function sendEmailTest() {
		$content = $this->getPageContent();
		$lang = $this->config->get('config_language_id'); 
		
		$message = $content[$lang]['email_content'];
		$message = str_replace('{first_name}', 'FirstNameTest', $message);
		$message = str_replace('{last_name}', 'LastNameTest', $message);
		$message = str_replace('{feedback_link}',  HTTP_CATALOG . 'index.php?route=product/testimonial', $message);
		
		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');	
		$mail->setTo($this->config->get('testimonial_email_test'));
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject(html_entity_decode($content[$lang]['email_subject'], ENT_QUOTES, 'UTF-8'));
		$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
		$mail->send();
	}	
}
?>