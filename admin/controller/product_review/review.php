<?php
class ControllerProductReviewReview extends Controller {
	private $error = array();

	public function index() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/review');

		$this->getList();
	}

	public function insert() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/review');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_review->addReview($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/review');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_review->editReview($this->request->get['review_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function save() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (isset($this->request->post['status'])) {
				foreach ($this->request->post['status'] as $review_id => $status) {
					$this->model_catalog_product_review->changeStatus($review_id, $status);
				}
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/review');
		$this->load->model('catalog/product_review');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $review_id) {
				$this->model_catalog_review->deleteReview($review_id);
				$this->model_catalog_product_review->deleteRatingByReviewId($review_id);
				$this->model_catalog_product_review->deleteAttributeByReviewId($review_id);
				$this->model_catalog_product_review->deleteReportByReviewId($review_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	public function deletevote() {
		$this->language->load('product_review/review');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product_review');

		if (isset($this->request->get['review_id']) && $this->validateDeleteVote()) {
			$this->model_catalog_product_review->deleteVote($this->request->get['review_id'], $this->request->get['vote']);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	public function deleteimage() {
		$this->language->load('product_review/review');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['review_id'])) {
			if (!preg_match('/^[0-9]+$/', $this->request->post['review_id'])) {
				$json['error'] = $this->language->get('error_review_id');
			}

			if (!isset($json['error'])) {
				$this->load->model('catalog/product_review');
				$this->load->model('tool/image');

				$this->model_catalog_product_review->deleteImage($this->request->post['review_id']);

				$no_image = $this->model_tool_image->resize('no_image.jpg', 40, 40);

				$json['success'] = '<img src="' . $no_image . '" alt="" style="padding: 1px; border: 1px solid #DDDDDD;" />';
			}
		}

		$this->response->setOutput(json_encode($json));
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'r.date_added';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

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
			'href'      => $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		$this->data['save'] = $this->url->link('product_review/review/save', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['insert'] = $this->url->link('product_review/review/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('product_review/review/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('catalog/product_review');
		$this->load->model('tool/image');

		$this->data['reviews'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);

		$review_total = $this->model_catalog_review->getTotalReviews();

		$results = $this->model_catalog_review->getReviews($data);

    	foreach ($results as $result) {
			$action = array();

			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('product_review/review/update', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'] . $url, 'SSL')
			);

			if ($result['image'] && file_exists(DIR_IMAGE . 'product_review/review/' . $result['image'])) {
				$image = $this->model_tool_image->resize('product_review/review/' . $result['image'], 40, 40);
				$popup = $this->model_tool_image->resize('product_review/review/' . $result['image'], 600, 600);
			} else {
				$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				$popup = '';
			}

			$this->data['reviews'][] = array(
				'review_id'  => $result['review_id'],
				'image'      => $image,
				'popup'      => $popup,
				'name'       => $result['name'],
				'author'     => $result['author'],
				'ratings'    => $this->model_catalog_product_review->getRatingsByReviewId($result['review_id']),
				'rating_avg' => $result['rating'],
				'pros'       => (int)$result['pros'],
				'cons'       => (int)$result['cons'],
				'href_pros'  => $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&filter_review_id=' . $result['review_id'] . '&filter_type=1', 'SSL'),
				'href_cons'  => $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'] . '&filter_review_id=' . $result['review_id'] . '&filter_type=0', 'SSL'),
				'vote_yes'   => $result['vote_yes'],
				'vote_no'    => $result['vote_no'],
				'href_vote_yes' => $this->url->link('product_review/review/deletevote', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'] . '&vote=yes', 'SSL'),
				'href_vote_no'  => $this->url->link('product_review/review/deletevote', 'token=' . $this->session->data['token'] . '&review_id=' . $result['review_id'] . '&vote=no', 'SSL'),
				'status'     => $result['status'],
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['review_id'], $this->request->post['selected']),
				'action'     => $action
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_delete'] = $this->language->get('text_delete');

		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_product'] = $this->language->get('column_product');
		$this->data['column_author'] = $this->language->get('column_author');
		$this->data['column_rating'] = $this->language->get('column_rating');
		$this->data['column_avg'] = $this->language->get('column_avg');
		$this->data['column_pros'] = $this->language->get('column_pros');
		$this->data['column_cons'] = $this->language->get('column_cons');
		$this->data['column_vote_yes'] = $this->language->get('column_vote_yes');
		$this->data['column_vote_no'] = $this->language->get('column_vote_no');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');

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

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_product'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL');
		$this->data['sort_author'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=r.author' . $url, 'SSL');
		$this->data['sort_avg'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=rating_avg' . $url, 'SSL');
		$this->data['sort_pros'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=pros' . $url, 'SSL');
		$this->data['sort_cons'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=cons' . $url, 'SSL');
		$this->data['sort_vote_yes'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=r.vote_yes' . $url, 'SSL');
		$this->data['sort_vote_no'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=r.vote_no' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=r.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . '&sort=r.date_added' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $review_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'product_review/review_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['error_select'] = $this->language->get('error_select');

		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_browse'] = $this->language->get('text_browse');

		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_author'] = $this->language->get('entry_author');
		$this->data['entry_rating'] = $this->language->get('entry_rating');
		$this->data['entry_pros'] = $this->language->get('entry_pros');
		$this->data['entry_cons'] = $this->language->get('entry_cons');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_text'] = $this->language->get('entry_text');
		$this->data['entry_good'] = $this->language->get('entry_good');
		$this->data['entry_bad'] = $this->language->get('entry_bad');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['product'])) {
			$this->data['error_product'] = $this->error['product'];
		} else {
			$this->data['error_product'] = '';
		}

 		if (isset($this->error['author'])) {
			$this->data['error_author'] = $this->error['author'];
		} else {
			$this->data['error_author'] = '';
		}

 		if (isset($this->error['text'])) {
			$this->data['error_text'] = $this->error['text'];
		} else {
			$this->data['error_text'] = '';
		}

 		if (isset($this->error['rating'])) {
			$this->data['error_rating'] = $this->error['rating'];
		} else {
			$this->data['error_rating'] = '';
		}

		$url = '';

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
			'href'      => $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		if (!isset($this->request->get['review_id'])) {
			$this->data['action'] = $this->url->link('product_review/review/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('product_review/review/update', 'token=' . $this->session->data['token'] . '&review_id=' . $this->request->get['review_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['review_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$review_info = $this->model_catalog_review->getReview($this->request->get['review_id']);
		}

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('catalog/product_review');

		if (isset($this->request->post['product_id'])) {
			$this->data['product_id'] = $this->request->post['product_id'];
		} elseif (!empty($review_info)) {
			$this->data['product_id'] = $review_info['product_id'];
		} else {
			$this->data['product_id'] = '';
		}

		if (isset($this->request->post['product'])) {
			$this->data['product'] = $this->request->post['product'];
		} elseif (!empty($review_info)) {
			$this->data['product'] = $review_info['product'];
		} else {
			$this->data['product'] = '';
		}

		if (isset($this->request->post['author'])) {
			$this->data['author'] = $this->request->post['author'];
		} elseif (!empty($review_info)) {
			$this->data['author'] = $review_info['author'];
		} else {
			$this->data['author'] = '';
		}

		if (isset($this->request->post['text'])) {
			$this->data['text'] = $this->request->post['text'];
		} elseif (!empty($review_info)) {
			$this->data['text'] = $review_info['text'];
		} else {
			$this->data['text'] = '';
		}

		if (isset($this->request->post['product_rating'])) {
			$this->data['product_rating'] = base64_encode(serialize($this->request->post['product_rating']));
		} elseif (!empty($review_info) && $this->model_catalog_product_review->getRatingsByReviewId($review_info['review_id'])) {
			$_product_rating = array();

			foreach ($this->model_catalog_product_review->getRatingsByReviewId($review_info['review_id']) as $rating) {
				$_product_rating[$rating['rating_id']] = $rating['rating'];	
			}

			$this->data['product_rating'] = base64_encode(serialize($_product_rating));
		} else {
			$this->data['product_rating'] = '';

			if (isset($this->request->post['rating'])) {
				$this->data['product_rating'] = base64_encode(serialize($this->request->post['rating']));
			} elseif (!empty($review_info)) {
				$this->data['product_rating'] = base64_encode(serialize($review_info['rating']));
			} else {
				$this->data['product_rating'] = '';
			}
		}

		if (isset($this->request->post['pros'])) {
			$this->data['pros'] = $this->request->post['pros'];
		} elseif (!empty($review_info)) {
			$this->data['pros'] = $this->model_catalog_product_review->getProsByReviewId($review_info['review_id']);
		} else {
			$this->data['pros'] = array();
		}

		if (isset($this->request->post['cons'])) {
			$this->data['cons'] = $this->request->post['cons'];
		} elseif (!empty($review_info)) {
			$this->data['cons'] = $this->model_catalog_product_review->getConsByReviewId($review_info['review_id']);
		} else {
			$this->data['cons'] = array();
		}

		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (!empty($review_info)) {
			$this->data['image'] = $review_info['image'];
		} else {
			$this->data['image'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && file_exists(DIR_IMAGE . 'product_review/review/' . $this->request->post['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($review_info) && $review_info['image'] && file_exists(DIR_IMAGE . 'product_review/review/' . $review_info['image'])) {
			$this->data['thumb'] = $this->model_tool_image->resize('product_review/review/' . $review_info['image'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($review_info)) {
			$this->data['status'] = $review_info['status'];
		} else {
			$this->data['status'] = '';
		}

		$this->template = 'product_review/review_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function rating() {
		$this->language->load('product_review/review');

		$this->load->model('catalog/product_review');
		$this->load->model('catalog/product');

		if ((isset($this->request->get['product_id']) && preg_match('/^[0-9]+$/', $this->request->get['product_id'])) && (isset($this->request->get['review_id']) && preg_match('/^[0-9]+$/', $this->request->get['review_id'])) && isset($this->request->post['prc'])) {
			if ($this->request->get['product_id'] > 0) {
				$this->response->setOutput($this->prepareTpl($this->request->post['prc'], $this->request->get['product_id'], ($this->request->get['review_id'] ? 'edit' : 'new')));
			} else {
				$this->response->setOutput('<div class="warning">' . $this->language->get('error_loading') . '</div>');
			}
		} else {
			$this->response->setOutput('<div class="warning">' . $this->language->get('error_loading') . '</div>');
		}
	}

	private function prepareTpl($data, $product_id, $key) {
		$ratings = $this->model_catalog_product_review->getRatings(array('sort'  => 'r.date_added', 'order' => 'ASC', 'start' => 0, 'limit' => 999));

		$product_store = $this->model_catalog_product->getProductStores($product_id);

		if (!$product_store) {
			return'<div class="warning">' . $this->language->get('error_product_store') . '</div>';
		}

		$data = unserialize(stripslashes(base64_decode($data)));

		if ((!$data || (!is_array($data) && preg_match('/^[1-5]$/', $data))) && $key == 'edit') {
			$default = '<td></td><td>';
			for ($i = 1; $i <= 5; $i++) {
				if ($data == $i) {
					$default .= '<input type="radio" name="rating" value="' . $i . '" checked />';
				} else {
					$default .= '<input type="radio" name="rating" value="' . $i . '" />';
				}

				$default.=  '&nbsp;';
			}
		} else {
			$default = '';
		}

		$html = '<table>
			      <tr><td></td><td><b class="rating">' . $this->language->get('entry_bad') . '</b></td>' . $default . '<td><b class="rating">' . $this->language->get('entry_good') . '</b></td></tr>
				  <tbody>';

		foreach ($ratings as $row) {
			if (array_intersect(explode("#", $row['stores']), $product_store)) {
				if (($key == 'edit' && isset($data[$row['rating_id']])) || ($key == 'new' && $row['status'])) {
					$html .= '<tr><td>' . $row['name'] . '</td><td>';

					for ($i = 1; $i <= 5; $i++) {
						if (isset($data[$row['rating_id']]) && $data[$row['rating_id']] == $i) {
							$html .= '<input type="radio" name="product_rating[' . $row['rating_id'] . ']" value="' . $i . '" checked />';
						} else {
							$html .= '<input type="radio" name="product_rating[' . $row['rating_id'] . ']" value="' . $i . '" />';
						}

						$html .=  '&nbsp;';
					}

					$html .= '</td><td></td></tr>';
				}
			}
		}

		$html .= '</tbody></table>';

		return $html;
	}

	public function upload() {
		$this->language->load('product_review/review');

		$json = array();

		if (!$this->user->hasPermission('modify', 'product_review/review')) {
      		$json['error'] = $this->language->get('error_permission');
    	}

		if (!isset($json['error'])) {
			if (!empty($this->request->files['file']['name'])) {
				$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));

				if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
					$json['error'] = $this->language->get('error_filename');
				}

				$allowed = array('jpeg', 'jpg', 'jpe', 'gif', 'png', 'bmp');

				if (!in_array(substr(strrchr($filename, '.'), 1), $allowed)) {
					$json['error'] = $this->language->get('error_filetype');
				}

				$allowed = array('image/jpeg', 'image/gif', 'image/png', 'image/bmp');

				if (!in_array($this->request->files['file']['type'], $allowed)) {
					$json['error'] = $this->language->get('error_filetype');
				}

				if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
					$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
				}
			} else {
				$json['error'] = $this->language->get('error_upload');
			}
		}

		if (!$json && is_uploaded_file($this->request->files['file']['tmp_name']) && file_exists($this->request->files['file']['tmp_name'])) {
			$file = basename(md5($filename . time())) . basename($filename);

			$json['file'] = $file;

			move_uploaded_file($this->request->files['file']['tmp_name'], DIR_IMAGE . 'product_review/review/' . $file);

			$json['success'] = $this->language->get('text_upload');
		}

		$this->response->setOutput(json_encode($json));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'product_review/review')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['product_id']) {
			$this->error['product'] = $this->language->get('error_product');
		}

		if ((utf8_strlen($this->request->post['author']) < 3) || (utf8_strlen($this->request->post['author']) > 64)) {
			$this->error['author'] = $this->language->get('error_author');
		}

		if (utf8_strlen($this->request->post['text']) < 1) {
			$this->error['text'] = $this->language->get('error_text');
		}

		if (!isset($this->request->post['product_rating']) && !isset($this->request->post['rating'])) {
			$this->error['rating'] = $this->language->get('error_rating');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'product_review/review')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDeleteVote() {
		if (!$this->user->hasPermission('modify', 'product_review/review')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			if ((!isset($this->request->get['review_id']) || !isset($this->request->get['vote'])) || !preg_match('/yes|no/i', $this->request->get['vote'])) {
				$this->error = true;
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'product_review/review')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function optimize() {
		if ($this->validate()) {
			$this->load->language('product_review/review');

			$this->load->model('catalog/product_review');

			$this->model_catalog_product_review->optimizeTable();

			$this->session->data['success'] = $this->language->get('text_success_optimize');

			$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
}
?>