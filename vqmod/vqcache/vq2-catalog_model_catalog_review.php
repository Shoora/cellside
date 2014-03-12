<?php
class ModelCatalogReview extends Model {		

			public function getRatings() {
				$sql = "SELECT r.*, rd.name FROM " . DB_PREFIX . "pr_rating r LEFT JOIN " . DB_PREFIX . "pr_rating_description rd ON (r.rating_id = rd.rating_id) LEFT JOIN " . DB_PREFIX . "pr_rating_to_store r2s ON (r.rating_id = r2s.rating_id) WHERE rd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND r2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND r.status = '1' GROUP BY r.rating_id ORDER BY r.sort_order ASC";

				$query = $this->db->query($sql);

				return $query->rows;
			}

			public function getProsByReviewId($review_id) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pr_attribute WHERE review_id = '" . (int)$review_id . "' AND type = '1' AND status = '1' ORDER BY attribute_id ASC");

				return $query->rows;
			}

			public function getConsByReviewId($review_id) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "pr_attribute WHERE review_id = '" . (int)$review_id . "' AND type = '0' AND status = '1' ORDER BY attribute_id ASC");

				return $query->rows;
			}

			public function getRatingsByReviewId($review_id) {
				$sql = "SELECT rr.rating_id, rr.rating, rd.name FROM " . DB_PREFIX . "pr_rating_review rr LEFT JOIN " . DB_PREFIX . "pr_rating r ON (rr.rating_id = r.rating_id) LEFT JOIN " . DB_PREFIX . "pr_rating_description rd ON (rr.rating_id = rd.rating_id) WHERE rd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND rr.review_id = '" . (int)$review_id . "' ORDER BY r.sort_order ASC";

				$query = $this->db->query($sql);

				return $query->rows;
			}

			public function getReviewByReviewId($review_id) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$review_id . "' AND status = '1'");

				return $query->row;
			}

			public function addVoteReview($product_id, $data = array()) {
				if ($data['vote'] == '1') {
					$this->db->query("UPDATE " . DB_PREFIX . "review SET vote_yes = vote_yes + 1 WHERE product_id = '" . (int)$product_id . "' AND review_id = '" . (int)$data['review_id'] . "'");
				} elseif ($data['vote'] == '0') {
					$this->db->query("UPDATE " . DB_PREFIX . "review SET vote_no = vote_no + 1 WHERE product_id = '" . (int)$product_id . "' AND review_id = '" . (int)$data['review_id'] . "'");
				}
			}

			public function addReportAbuse($review_id, $data = array()) {
				if ($data['reason_id'] > 0) {
					$reason_info = $this->getReasonByReasonId($data['reason_id']);

					$title = $reason_info['name'];
				} else {
					$title = $data['def'];
				}

				if ($this->customer->isLogged()) {
					$customer_id = $this->customer->getId();
					$reported = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
				} else {
					$customer_id = 0;
					$reported = '';
				}

				$this->db->query("INSERT INTO " . DB_PREFIX . "pr_report SET title = '" . $title . "', reported = '" . $this->db->escape($reported) . "', review_id = '" . (int)$review_id . "', customer_id = '" . (int)$customer_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', date_added = NOW()");
			}

			public function getReasonsTitle() {
				$query = $this->db->query("SELECT r.reason_id, rd.name FROM " . DB_PREFIX . "pr_reason r LEFT JOIN " . DB_PREFIX . "pr_reason_description rd ON (r.reason_id = rd.reason_id) LEFT JOIN " . DB_PREFIX . "pr_reason_to_store r2s ON (r.reason_id = r2s.reason_id) WHERE rd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND r2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND r.status = '1'");

				return $query->rows;
			}

			public function getReasonByReasonId($reason_id) {
				$query = $this->db->query("SELECT name FROM " . DB_PREFIX . "pr_reason_description WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' AND reason_id = '" . (int)$reason_id . "'");

				return $query->row;
			}

			public function getAllReviews($data = array()) {
				$sql = "SELECT r.*, p.product_id, pd.name AS product, ROUND((r.vote_yes / (r.vote_no + r.vote_yes)) * 100) as vote FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE r.status = '1' AND p.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' GROUP BY r.review_id";

				$sort_data = array(
					'r.date_added',
					'rating',
					'vote'
				);

				if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
					$sql .= " ORDER BY " . $data['sort'];
				} else {
					$sql .= " ORDER BY r.date_added";
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

			public function getTotalAllReviews() {
				$query = $this->db->query("SELECT COUNT(r.review_id) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE r.status = '1' AND p.status = '1' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

				if (isset($query->row['total'])) {
					return $query->row['total'];
				} else {
					return 0;
				}
			}
			
	public function addReview($product_id, $data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int)$data['rating'] . "', date_added = NOW()");

			if ($this->config->get('config_product_reviews_status')) {
				$review_id = $this->db->getLastId();

				foreach ($data['rating'] as $key => $rating) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "pr_rating_review SET review_id = '" . (int)$review_id . "', rating_id = '" . (int)$key . "', rating = '" . (int)$rating . "'");
				}

				if (isset($data['review_pros'])) {
					foreach ($data['review_pros'] as $pros) {
						$pros = trim($pros);

						if (!empty($pros)) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($pros) . "', type = '1', review_id = '" . (int)$review_id . "', status = '1'");
						}
					}
				}

				if (isset($data['review_cons'])) {
					foreach ($data['review_cons'] as $cons) {
						$cons = trim($cons);

						if (!empty($cons)) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($cons) . "', type = '0', review_id = '" . (int)$review_id . "', status = '1'");
						}
					}
				}

				$avg = round(array_sum($this->request->post['rating']) / count($this->request->post['rating']));

				$this->db->query("UPDATE " . DB_PREFIX . "review SET rating = '" . $avg . "', image = '" . ((isset($data['review_image']) && $data['review_image']) ? $data['review_image'] : '') . "' WHERE review_id = '" . (int)$review_id . "'");

				if ($this->config->get('config_product_reviews_autoapprove') && $this->customer->isLogged()) {
					if ($avg >= $this->config->get('config_product_reviews_autoapprove_rating')) {
						$this->db->query("UPDATE " . DB_PREFIX . "review SET status = '1' WHERE review_id = '" . (int)$review_id . "'");
					}
				}

				if ($this->config->get('config_product_reviews_notify_status') && $this->config->get('config_product_reviews_notify_email') && $this->config->get('config_product_reviews_notification')) {
					$this->load->model('catalog/product');

					$product_info = $this->model_catalog_product->getProduct($product_id);
					$product = '<a href="' . $this->url->link('product/product', 'product_id=' . $product_id) . '">' . $product_info['name'] . '</a>';

					$data['text'] = strip_tags(html_entity_decode($data['text'], ENT_QUOTES, 'UTF-8'));
					$message = str_replace(array('{product}', '{avg}', '{review}'), array($product, $avg, $data['text']), $this->config->get('config_product_reviews_notification'));

					$mail = new Mail();
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->hostname = $this->config->get('config_smtp_host');
					$mail->username = $this->config->get('config_smtp_username');
					$mail->password = $this->config->get('config_smtp_password');
					$mail->port = $this->config->get('config_smtp_port');
					$mail->timeout = $this->config->get('config_smtp_timeout');				
					$mail->setTo($this->config->get('config_product_reviews_notify_email'));
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender($this->config->get('config_name'));
					$mail->setSubject('New product review');
					$mail->setHtml($message);
					$mail->send();
				}
			}
			
// template email - start
		$this->load->model('catalog/template_email');

		$result = $this->model_catalog_template_email->getTemplateEmail('reviews.added');
			
		if ((sizeof($result['description']) > 0) && ($result['status'] == '0' || $result['status'] == '')) {
			$tpl_data = array();
			$product_name = $this->model_catalog_template_email->getProduct((int)$product_id);

			$tpl_data = array(
				'author'  => html_entity_decode($data['name'], ENT_QUOTES, 'UTF-8'),
				'review'  => html_entity_decode($data['text'], ENT_QUOTES, 'UTF-8'),
				'rating'  => $data['rating'],
				'product' => '<a href="' . $this->url->link('product/product', 'product_id=' . (int)$product_id, 'SSL') . '">' . $product_name['name'] . '</a>'
			);

			$this->model_catalog_template_email->sendReviewsNoticeTemplateEmail($tpl_data, $result);
		}
		// template email - stop
	}
		
	public function getReviewsByProductId($product_id, $start = 0, $limit = 20, $sort = 'r.date_added-DESC') {

			$sort = explode("-", $sort);

			$sort_data = array(
				'r.date_added',
				'rating',
				'vote'
			);

			if (isset($sort[1]) && in_array($sort[0], $sort_data)) {
				$sql = " ORDER BY " . $sort[0] . ' ' . $sort[1];
			} else {
				$sql = " ORDER BY r.date_added DESC";
			}
			
		if ($start < 0) {
			$start = 0;
		}
		
		if ($limit < 1) {
			$limit = 20;
		}		
		
		$query = $this->db->query("SELECT r.review_id, r.author, r.image AS review_image, r.vote_yes, r.vote_no, IFNULL((SELECT AVG(t.rating) as total FROM " . DB_PREFIX . "pr_rating_review t WHERE t.review_id = r.review_id), r.rating) as rating, ROUND((r.vote_yes / (r.vote_no + r.vote_yes)) * 100) as vote, r.text, p.product_id, pd.name, p.price, p.image, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' " . $sql . " LIMIT " . (int)$start . "," . (int)$limit);
			
		return $query->rows;
	}

	public function getTotalReviewsByProductId($product_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row['total'];
	}
}
?>