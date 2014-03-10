<?php
class ControllerProductReviewReport extends Controller {
	private $error = array();

  	public function index() {
		$this->language->load('product_review/report');

		$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/product_review');

		$this->getList();
  	}

  	public function insert() {
    	$this->language->load('product_review/report');

    	$this->document->setTitle($this->language->get('heading_title_reason'));

		$this->load->model('catalog/product_review');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateReasonForm()) {
			$this->model_catalog_product_review->addReason($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success_reason');

			$url = '';

			if (isset($this->request->get['filter_store_id'])) {
				$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}

    	$this->getForm();
  	}

  	public function update() {
    	$this->language->load('product_review/report');

    	$this->document->setTitle($this->language->get('heading_title_reason'));

		$this->load->model('catalog/product_review');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateReasonForm()) {
			$this->model_catalog_product_review->editReason($this->request->get['reason_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success_reason');

			$url = '';

			if (isset($this->request->get['filter_store_id'])) {
				$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getForm();
  	}

  	public function deleteReport() {
    	$this->language->load('product_review/report');

    	$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

		if ((isset($this->request->post['selected']) || isset($this->request->get['report_id'])) && $this->validateDelete()) {
			if (isset($this->request->post['selected'])) {
				foreach ($this->request->post['selected'] as $report_id) {
					$this->model_catalog_product_review->deleteReport($report_id);
				}
			} elseif (isset($this->request->get['report_id']) && preg_match('/^\d+$/', $this->request->get['report_id'])) {
				$review_id = false;

				if (isset($this->request->get['review_id'])) {
					$review_id = $this->request->get['review_id'];
				}

				$this->model_catalog_product_review->deleteReport($this->request->get['report_id'], $review_id);
			}

			$this->session->data['success'] = $this->language->get('text_success_report');

			$url = '';

			if (isset($this->request->get['filter_store_id'])) {
				$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
			}

			if (isset($this->request->get['filter_date_added_start'])) {
				$url .= '&filter_date_added_start=' . $this->request->get['filter_date_added_start'];
			}

			if (isset($this->request->get['filter_date_added_stop'])) {
				$url .= '&filter_date_added_stop=' . $this->request->get['filter_date_added_stop'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/report', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getList();
  	}

	public function deleteReason() {
    	$this->language->load('product_review/report');

    	$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $reason_id) {
				$this->model_catalog_product_review->deleteReason($reason_id);
			}

			$this->session->data['success'] = $this->language->get('text_success_reason');

			$url = '';

			if (isset($this->request->get['filter_store_id'])) {
				$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->reason();
  	}

  	protected function getList() {				
		if (isset($this->request->get['filter_store_id'])) {
			$filter_store_id = $this->request->get['filter_store_id'];
		} else {
			$filter_store_id = null;
		}

		if (isset($this->request->get['filter_date_added_start'])) {
			$filter_date_added_start = $this->request->get['filter_date_added_start'];
		} else {
			$filter_date_added_start = null;
		}

		if (isset($this->request->get['filter_date_added_stop'])) {
			$filter_date_added_stop = $this->request->get['filter_date_added_stop'];
		} else {
			$filter_date_added_stop = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'ar.date_added';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_date_added_start'])) {
			$url .= '&filter_date_added_start=' . $this->request->get['filter_date_added_start'];
		}

		if (isset($this->request->get['filter_date_added_stop'])) {
			$url .= '&filter_date_added_stop=' . $this->request->get['filter_date_added_stop'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
      		'separator' => ' :: '
   		);

		$this->data['reason'] = $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('product_review/report/deleteReport', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['reports'] = array();

		$data = array(
			'filter_store_id'	        => $filter_store_id,
			'filter_date_added_start'   => $filter_date_added_start,
			'filter_date_added_stop'    => $filter_date_added_stop,
			'sort'                      => $sort,
			'order'                     => $order,
			'start'                     => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'                     => $this->config->get('config_admin_limit')
		);

		$report_total = $this->model_catalog_product_review->getTotalReports($data);

		$results = array();

		if ($report_total) {
			$results = $this->model_catalog_product_review->getReports($data);
		}

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_delete'),
				'href' => $this->url->link('product_review/report/deleteReport', 'token=' . $this->session->data['token'] . '&report_id=' . $result['report_id'] . $url, 'SSL')
			);

			$action[] = array(
				'text' => $this->language->get('text_delete_review'),
				'href' => $this->url->link('product_review/report/deleteReport', 'token=' . $this->session->data['token'] . '&report_id=' . $result['report_id'] . '&review_id=' . $result['review_id'] . $url, 'SSL')
			);

			$this->data['reports'][] = array(
				'report_id'   => $result['report_id'],
				'review'      => '<a href="' . $this->url->link('product_review/review/update', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'], 'SSL') . '">' . utf8_substr(strip_tags(html_entity_decode($result['text'], ENT_QUOTES, 'UTF-8')), 0, 190) . '..' . '</a>',
				'title'       => $result['title'],
				'store'       => $result['store_id'],
				'reported'    => ($result['customer_id']) ? '<a href="' . $this->url->link('sale/customer/update', 'token=' . $this->session->data['token'] . '&customer_id=' . $result['customer_id'], 'SSL') . '">' . $result['reported'] . '</a>' : $result['reported'],
				'date_added'  => date($this->language->get('date_format_long'), strtotime($result['date_added'])),
				'selected'    => isset($this->request->post['selected']) && in_array($result['report_id'], $this->request->post['selected']),
				'action'      => $action
			);
    	}

		$this->data['stores'] = array();
		$this->data['stores'][] = array('store_id' => '0', 'name' => $this->language->get('text_default'));

		$this->load->model('setting/store');

		$stores = $this->model_setting_store->getStores();

		foreach ($stores as $store) {
			$this->data['stores'][$store['store_id']] = array(
				'store_id' => $store['store_id'],
				'name'     => $store['name']
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_review'] = $this->language->get('column_review');
		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_store'] = $this->language->get('column_store');
		$this->data['column_reported'] = $this->language->get('column_reported');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_reason'] = $this->language->get('button_reason');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');

 		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_date_added_start'])) {
			$url .= '&filter_date_added_start=' . $this->request->get['filter_date_added_start'];
		}

		if (isset($this->request->get['filter_date_added_stop'])) {
			$url .= '&filter_date_added_stop=' . $this->request->get['filter_date_added_stop'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_store_id'] = $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . '&sort=ar.store_id' . $url, 'SSL');
		$this->data['sort_reported'] = $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . '&sort=ar.reported' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . '&sort=ar.date_added' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_date_added_start'])) {
			$url .= '&filter_date_added_start=' . $this->request->get['filter_date_added_start'];
		}

		if (isset($this->request->get['filter_date_added_stop'])) {
			$url .= '&filter_date_added_stop=' . $this->request->get['filter_date_added_stop'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $report_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['filter_store_id'] = $filter_store_id;
		$this->data['filter_date_added_start'] = $filter_date_added_start;
		$this->data['filter_date_added_stop'] = $filter_date_added_stop;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'product_review/report_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}

	public function reason() {
		$this->language->load('product_review/report');

		$this->document->setTitle($this->language->get('heading_title_reason')); 

		$this->load->model('catalog/product_review');

		if (isset($this->request->get['filter_store_id'])) {
			$filter_store_id = $this->request->get['filter_store_id'];
		} else {
			$filter_store_id = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'rd.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_reason'),
			'href'      => $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
      		'separator' => ' :: '
   		);

		$this->data['insert'] = $this->url->link('product_review/report/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('product_review/report/deleteReason', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['reasons'] = array();

		$data = array(
			'filter_store_id' => $filter_store_id,
			'filter_status'   => $filter_status,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
		);

		$reason_total = $this->model_catalog_product_review->getTotalReasons($data);

		$results = array();

		if ($reason_total) {
			$results = $this->model_catalog_product_review->getReasons($data);
		}

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('product_review/report/update', 'token=' . $this->session->data['token'] . '&reason_id=' . $result['reason_id'] . $url, 'SSL')
			);

			$this->data['reasons'][] = array(
				'reason_id' => $result['reason_id'],
				'name'      => $result['name'],
				'stores'    => $this->model_catalog_product_review->getReasonStores($result['reason_id']),
				'status'    => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'selected'  => isset($this->request->post['selected']) && in_array($result['reason_id'], $this->request->post['selected']),
				'action'    => $action
			);
    	}

		$this->data['stores'] = array();
		$this->data['stores'][] = array('store_id' => '0', 'name' => $this->language->get('text_default'));

		$this->load->model('setting/store');

		$stores = $this->model_setting_store->getStores();

		foreach ($stores as $store) {
			$this->data['stores'][$store['store_id']] = array(
				'store_id' => $store['store_id'],
				'name'     => $store['name']
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title_reason');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_store'] = $this->language->get('column_store');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');

 		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_name'] = $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . '&sort=rd.name' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . '&sort=r.status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $reason_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['filter_store_id'] = $filter_store_id;
		$this->data['filter_status'] = $filter_status;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'product_review/reason_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

  	protected function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title_reason');

    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_status'] = $this->language->get('entry_status');

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_store_id'])) {
			$url .= '&filter_store_id=' . $this->request->get['filter_store_id'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
   		);

		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('product_review/report', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title_reason'),
			'href'      => $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		if (!isset($this->request->get['reason_id'])) {
			$this->data['action'] = $this->url->link('product_review/report/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('product_review/report/update', 'token=' . $this->session->data['token'] . '&reason_id=' . $this->request->get['reason_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('product_review/report/reason', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['reason_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$reason_info = $this->model_catalog_product_review->getReason($this->request->get['reason_id']);
    	}

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (isset($this->request->get['reason_id'])) {
			$this->data['name'] = $this->model_catalog_product_review->getReasonDescriptions($this->request->get['reason_id']);
		} else {
			$this->data['name'] = array();
		}

		$this->data['stores'] = array();
		$this->data['stores'][] = array('store_id' => '0', 'name' => $this->language->get('text_default'));

		$this->load->model('setting/store');

		$stores = $this->model_setting_store->getStores();

		foreach ($stores as $store) {
			$this->data['stores'][$store['store_id']] = array(
				'store_id' => $store['store_id'],
				'name'     => $store['name']
			);
		}

		if (isset($this->request->post['reason_store'])) {
			$this->data['reason_store'] = $this->request->post['reason_store'];
		} elseif (isset($this->request->get['reason_id'])) {
			$this->data['reason_store'] = $this->model_catalog_product_review->getReasonStores($this->request->get['reason_id']);
		} else {
			$this->data['reason_store'] = array(0);
		}

		if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($reason_info)) {
			$this->data['status'] = $reason_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}

		$this->template = 'product_review/reason_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}

  	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'product_review/report')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	foreach ($this->request->post['name'] as $language_id => $value) {
      		if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 64)) {
        		$this->error['name'][$language_id] = $this->language->get('error_name');
      		}
    	}

    	if (!$this->error) {
			return true;
    	} else {
      		return false;
    	}
  	}

	protected function validateReasonForm() {
    	if (!$this->user->hasPermission('modify', 'product_review/report')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	foreach ($this->request->post['name'] as $language_id => $value) {
      		if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 255)) {
        		$this->error['name'][$language_id] = $this->language->get('error_name');
      		}
    	}

    	if (!$this->error) {
			return true;
    	} else {
      		return false;
    	}
  	}

  	protected function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'product_review/report')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/product_review');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			$data = array(
				'filter_name' => $filter_name,
				'start'       => 0,
				'limit'       => 20
			);

			$results = $this->model_catalog_product_review->getRatings($data);

			foreach ($results as $result) {
				$json[] = array(
					'rating_id' => $result['rating_id'],
					'name'      => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>