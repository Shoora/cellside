<?php
class ModelCatalogReview extends Model {
	public function addReview($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['author']) . "', product_id = '" . $this->db->escape($data['product_id']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = NOW()");

			if ($this->config->get('config_product_reviews_status')) {
				$review_id = $this->db->getLastId();

				$this->db->query("UPDATE " . DB_PREFIX . "review SET image = '" . $data['image'] . "' WHERE review_id = '" . (int)$review_id . "'");

				if (isset($data['product_rating'])) {
					foreach ($data['product_rating'] as $key => $rating) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "pr_rating_review SET review_id = '" . (int)$review_id . "', rating_id = '" . (int)$key . "', rating = '" . (int)$rating . "'");
					}

					$avg = round(array_sum($data['product_rating']) / count($data['product_rating']));

					$this->db->query("UPDATE " . DB_PREFIX . "review SET rating = '" . $avg . "' WHERE review_id = '" . (int)$review_id . "'");
				}

				if (isset($data['pros'])) {
					foreach ($data['pros'] as $pros) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($pros['name']) . "', type = '1', review_id = '" . (int)$review_id . "', status = '1'");
					}
				}

				if (isset($data['cons'])) {
					foreach ($data['cons'] as $cons) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($cons['name']) . "', type = '0', review_id = '" . (int)$review_id . "', status = '1'");
					}
				}
			}
			
	
		$this->cache->delete('product');
	}
	
	public function editReview($review_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['author']) . "', product_id = '" . $this->db->escape($data['product_id']) . "', text = '" . $this->db->escape(strip_tags($data['text'])) . "', rating = '" . (int)$data['rating'] . "', status = '" . (int)$data['status'] . "', date_added = NOW() WHERE review_id = '" . (int)$review_id . "'");

			$this->db->query("UPDATE " . DB_PREFIX . "review SET image = '" . $data['image'] . "' WHERE review_id = '" . (int)$review_id . "'");

			$this->db->query("DELETE FROM " . DB_PREFIX . "pr_rating_review WHERE review_id = '" . (int)$review_id . "'");

			if (isset($data['product_rating'])) {
				foreach ($data['product_rating'] as $key => $rating) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "pr_rating_review SET review_id = '" . (int)$review_id . "', rating_id = '" . (int)$key . "', rating = '" . (int)$rating . "'");
				}

				$avg = round(array_sum($data['product_rating']) / count($data['product_rating']));

				$this->db->query("UPDATE " . DB_PREFIX . "review SET rating = '" . $avg . "' WHERE review_id = '" . (int)$review_id . "'");
			}

			$this->db->query("DELETE FROM " . DB_PREFIX . "pr_attribute WHERE review_id = '" . (int)$review_id . "' AND type = '1'");

			if (isset($data['pros'])) {
				foreach ($data['pros'] as $pros) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($pros['name']) . "', type = '1', review_id = '" . (int)$review_id . "', status = '1'");
				}
			}

			$this->db->query("DELETE FROM " . DB_PREFIX . "pr_attribute WHERE review_id = '" . (int)$review_id . "' AND type = '0'");

			if (isset($data['cons'])) {
				foreach ($data['cons'] as $cons) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "pr_attribute SET name = '" . $this->db->escape($cons['name']) . "', type = '0', review_id = '" . (int)$review_id . "', status = '1'");
				}
			}
			
	
		$this->cache->delete('product');
	}
	
	public function deleteReview($review_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE review_id = '" . (int)$review_id . "'");
		
		$this->cache->delete('product');
	}
	
	public function getReview($review_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT pd.name FROM " . DB_PREFIX . "product_description pd WHERE pd.product_id = r.product_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS product FROM " . DB_PREFIX . "review r WHERE r.review_id = '" . (int)$review_id . "'");
		
		return $query->row;
	}

	public function getReviews($data = array()) {
		$sql = "SELECT r.review_id, r.image, r.vote_yes, r.vote_no, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "pr_attribute a WHERE a.type = '1' AND a.review_id = r.review_id) AS pros, (SELECT COUNT(*) AS total FROM " . DB_PREFIX . "pr_attribute a WHERE a.type = '0' AND a.review_id = r.review_id) AS cons, r.rating AS rating_avg, r.product_id, pd.name, r.author, r.rating, r.status, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product_description pd ON (r.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";																																					  
		
		$sort_data = array(
			'pd.name',
			'r.author',
			'r.rating',

			'rating_avg',
			'pros',
			'cons',
			'r.vote_yes',
			'r.vote_no',
			
			'r.status',
			'r.date_added'
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
	
	public function getTotalReviews() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review");
		
		return $query->row['total'];
	}
	
	public function getTotalReviewsAwaitingApproval() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review WHERE status = '0'");
		
		return $query->row['total'];
	}	
}
?>