<?php
class ControllerProductReviewAttribute extends Controller {
	private $error = array();

  	public function index() {
		$this->language->load('product_review/attribute');

		$this->document->setTitle($this->language->get('heading_title')); 

		$this->load->model('catalog/product_review');

		$this->getList();
  	}

	public function update() {
    	$this->language->load('product_review/attribute');

    	$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_product_review->editAttribute($this->request->get['attribute_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_review_id'])) {
				$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
			}

			if (isset($this->request->get['filter_type'])) {
				$url .= '&filter_type=' . $this->request->get['filter_type'];
			}

			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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

			$this->redirect($this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getForm();
  	}

  	public function delete() {
    	$this->language->load('product_review/attribute');

    	$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $attribute_id) {
				$this->model_catalog_product_review->deleteAttribute($attribute_id);
	  		}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_name'])) {
				$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_review_id'])) {
				$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
			}

			if (isset($this->request->get['filter_type'])) {
				$url .= '&filter_type=' . $this->request->get['filter_type'];
			}

			if (isset($this->request->get['filter_author'])) {
				$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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

			$this->redirect($this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

    	$this->getList();
  	}
	
  	protected function getList() {
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_review_id'])) {
			$filter_review_id = $this->request->get['filter_review_id'];
		} else {
			$filter_review_id = null;
		}

		if (isset($this->request->get['filter_type'])) {
			$filter_type = $this->request->get['filter_type'];
		} else {
			$filter_type = null;
		}

		if (isset($this->request->get['filter_author'])) {
			$filter_author = $this->request->get['filter_author'];
		} else {
			$filter_author = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'a.name';
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

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_review_id'])) {
			$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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
			'href'      => $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
      		'separator' => ' :: '
   		);

		$this->data['delete'] = $this->url->link('product_review/attribute/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['attributes'] = array();

		$data = array(
			'filter_name'	   => $filter_name,
			'filter_review_id' => $filter_review_id,
			'filter_type'      => $filter_type,
			'filter_author'    => $filter_author,
			'filter_status'    => $filter_status,
			'sort'             => $sort,
			'order'            => $order,
			'start'            => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'            => $this->config->get('config_admin_limit')
		);

		$attribute_total = $this->model_catalog_product_review->getTotalAttributes($data);

		$results = array();

		if ($attribute_total) {
			$results = $this->model_catalog_product_review->getAttributes($data);
		}

		foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('product_review/attribute/update', 'token=' . $this->session->data['token'] . '&attribute_id=' . $result['attribute_id'] . $url, 'SSL')
			);

			$this->data['attributes'][] = array(
				'attribute_id' => $result['attribute_id'],
				'review_id'    => $result['review_id'],
				'review_href'  => $this->url->link('product_review/review/update', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'], 'SSL'),
				'name'         => $result['name'],
				'type'         => ($result['type'] ? $this->language->get('text_pros') : $this->language->get('text_cons')),
				'image'        => ($result['type'] ? '<img src="view/image/pros.png" style="vertical-align:middle;" alt="" />' : '<img src="view/image/cons.png" style="vertical-align:middle;" alt="" />'),
				'author'       => $result['author'],
				'status'       => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'selected'     => isset($this->request->post['selected']) && in_array($result['attribute_id'], $this->request->post['selected']),
				'action'       => $action
			);
    	}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_pros'] = $this->language->get('text_pros');
		$this->data['text_cons'] = $this->language->get('text_cons');

		$this->data['column_review'] = $this->language->get('column_review');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_type'] = $this->language->get('column_type');
		$this->data['column_author'] = $this->language->get('column_author');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');

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

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_review_id'])) {
			$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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

		$this->data['sort_name'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&sort=a.name' . $url, 'SSL');
		$this->data['sort_review'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&sort=r.review_id' . $url, 'SSL');
		$this->data['sort_type'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&sort=a.type' . $url, 'SSL');
		$this->data['sort_author'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&sort=r.author' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&sort=a.status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_review_id'])) {
			$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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
		$pagination->total = $attribute_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['filter_name'] = $filter_name;
		$this->data['filter_type'] = $filter_type;
		$this->data['filter_review_id'] = $filter_review_id;
		$this->data['filter_author'] = $filter_author;
		$this->data['filter_status'] = $filter_status;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'product_review/attribute_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}

  	protected function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_pros'] = $this->language->get('text_pros');
    	$this->data['text_cons'] = $this->language->get('text_cons');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_type'] = $this->language->get('entry_type');
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
			$this->data['error_name'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_review_id'])) {
			$url .= '&filter_review_id=' . $this->request->get['filter_review_id'];
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_author'])) {
			$url .= '&filter_author=' . urlencode(html_entity_decode($this->request->get['filter_author'], ENT_QUOTES, 'UTF-8'));
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
			'href'      => $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		if (!isset($this->request->get['attribute_id']) || !preg_match('/^\d+$/', $this->request->get['attribute_id'])) {
			$this->redirect($this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		} else {
			$this->data['action'] = $this->url->link('product_review/attribute/update', 'token=' . $this->session->data['token'] . '&attribute_id=' . $this->request->get['attribute_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['attribute_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$attribute_info = $this->model_catalog_product_review->getAttribute($this->request->get['attribute_id']);
    	}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($attribute_info)) {
			$this->data['name'] = $attribute_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['type'])) {
      		$this->data['type'] = $this->request->post['type'];
    	} elseif (!empty($attribute_info)) {
			$this->data['type'] = $attribute_info['type'];
		} else {
      		$this->data['type'] = 1;
    	}

		if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($attribute_info)) {
			$this->data['status'] = $attribute_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}

		$this->template = 'product_review/attribute_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  	}

  	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'product_review/attribute')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 255)) {
        	$this->error['name'] = $this->language->get('error_name');
    	}

    	if (!$this->error) {
			return true;
    	} else {
      		return false;
    	}
  	}

  	protected function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'product_review/attribute')) {
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
				'filter_name'   => $filter_name,
				'start'         => 0,
				'limit'         => 20
			);

			$results = $this->model_catalog_product_review->getAttributes($data);

			foreach ($results as $result) {
				$json[] = array(
					'attribute_id' => $result['attribute_id'],
					'name'         => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$this->response->setOutput(json_encode($json));
	}

	public function autocompleteauthor() {
		$json = array();

		if (isset($this->request->get['filter_author'])) {
			$this->load->model('catalog/product_review');

			if (isset($this->request->get['filter_author'])) {
				$filter_author = $this->request->get['filter_author'];
			} else {
				$filter_author = '';
			}

			$data = array(
				'filter_author' => $filter_author
			);

			$results = $this->model_catalog_product_review->getAuthors($data);

			foreach ($results as $result) {
				$json[] = array(
					'attribute_id' => 1,
					'author'       => strip_tags(html_entity_decode($result['author'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$this->response->setOutput(json_encode($json));
	}
}
?>