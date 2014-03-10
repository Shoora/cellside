<?php 
class ControllerProductFilter extends Controller {
	public function index() {
		$this->language->load('product/filter');

		$sort = 'p.sort_order';
		$order = 'ASC';
		$limit = $this->config->get('config_catalog_limit');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('product/filter'),
			'separator' => $this->language->get('text_separator')
		);

		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_display'] = $this->language->get('text_display');
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_grid'] = $this->language->get('text_grid');
		$this->data['text_sort'] = $this->language->get('text_sort');
		$this->data['text_limit'] = $this->language->get('text_limit');

		$url = '';

		if(isset($this->request->get['limit'])) {
			$url .= '&limit=' . $this->request->get['limit'];
		}

		$this->data['sorts'] = array();

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_default'),
			'value' => 'p.sort_order-ASC',
			'href' => $this->url->link('product/filter', 'sort=p.sort_order&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_name_asc'),
			'value' => 'pd.name-ASC',
			'href' => $this->url->link('product/filter', 'sort=pd.name&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_name_desc'),
			'value' => 'pd.name-DESC',
			'href' => $this->url->link('product/filter', 'sort=pd.name&order=DESC' . $url)
		);

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_price_asc'),
			'value' => 'p.price-ASC',
			'href' => $this->url->link('product/filter', 'sort=p.price&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_price_desc'),
			'value' => 'p.price-DESC',
			'href' => $this->url->link('product/filter', 'sort=p.price&order=DESC' . $url)
		);

		if($this->config->get('config_review_status')) {
			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_rating_desc'),
				'value' => 'rating-DESC',
				'href' => $this->url->link('product/filter', 'sort=rating&order=DESC' . $url)
			);

			$this->data['sorts'][] = array(
				'text' => $this->language->get('text_rating_asc'),
				'value' => 'rating-ASC',
				'href' => $this->url->link('product/filter', 'sort=rating&order=ASC' . $url)
			);
		}

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_model_asc'),
			'value' => 'p.model-ASC',
			'href' => $this->url->link('product/filter', 'sort=p.model&order=ASC' . $url)
		);

		$this->data['sorts'][] = array(
			'text' => $this->language->get('text_model_desc'),
			'value' => 'p.model-DESC',
			'href' => $this->url->link('product/filter', 'sort=p.model&order=DESC' . $url)
		);

		$url = '';

		if(isset($this->request->get['sort'])) {
			$url .= 'sort=' . $this->request->get['sort'];
		}

		if(isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$this->data['limits'] = array();

		$this->data['limits'][] = array(
			'text' => $this->config->get('config_catalog_limit'),
			'value' => $this->config->get('config_catalog_limit'),
			'href' => $this->url->link('product/filter',  $url . '&limit=' . $this->config->get('config_catalog_limit'))
		);

		$this->data['limits'][] = array(
			'text' => 25,
			'value' => 25,
			'href' => $this->url->link('product/filter',  $url . '&limit=25')
		);

		$this->data['limits'][] = array(
			'text' => 50,
			'value' => 50,
			'href' => $this->url->link('product/filter',  $url . '&limit=50')
		);

		$this->data['limits'][] = array(
			'text' => 75,
			'value' => 75,
			'href' => $this->url->link('product/filter',  $url . '&limit=75')
		);

		$this->data['limits'][] = array(
			'text' => 100,
			'value' => 100,
			'href' => $this->url->link('product/filter',  $url . '&limit=100')
		);


		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['limit'] = $limit;

		$this->data['continue'] = $this->url->link('common/home');

		if(file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/filter.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/product/filter.tpl';
		} else {
			$this->template = 'default/template/product/filter.tpl';
		}

		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
	}

}

?>