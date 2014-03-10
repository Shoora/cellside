<?php
class ControllerModuleReviewBox extends Controller {
	protected function index($setting) {
		$this->language->load('module/review_box');

      	$this->data['heading_title'] = (isset($setting['header'][$this->config->get('config_language_id')])) ? $setting['header'][$this->config->get('config_language_id')] : $this->language->get('heading_title');

		$this->data['button_view'] = $this->language->get('button_view');

		$this->data['reviews'] = array();

		$this->load->model('catalog/product');

		$limit = ($setting['limit']) ? $setting['limit'] : 5;

		if ($setting['type'] == 'random') {
			$results = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE status = '1' ORDER BY RAND() LIMIT " . (int)$limit);
		} else {
			$results = $this->db->query("SELECT * FROM " . DB_PREFIX . "review WHERE status = '1' ORDER BY date_added DESC LIMIT " . (int)$limit);
		}

		foreach ($results->rows as $result) {
			$this->data['reviews'][] = array(
				'review_id'  => $result['review_id'],
				'text'   	 => (utf8_strlen($result['text']) > 90) ? utf8_substr($result['text'], 0, 80) . '...' : $result['text'],
				'author'     => $result['author'],
				'date'   	 => sprintf($this->language->get('text_date'), date($this->language->get('date_format_short'), strtotime($result['date_added']))),
				'rating'     => $result['rating']
			);
		}

		$this->data['button'] = $setting['button'];
		$this->data['all'] = $this->url->link('product/allreviews');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/review_box.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/review_box.tpl';
		} else {
			$this->template = 'default/template/module/review_box.tpl';
		}

		$this->render();
	}
}
?>