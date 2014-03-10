<?php
class ControllerCatalogQuestionsAndAnswers extends Controller {
    protected $error = array();

    private $columns = array(
        "id"                => array("display" => 0, 'index' =>  0, 'align' =>   'left', 'sort' => 'q.question_id'    , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "product"           => array("display" => 1, 'index' =>  1, 'align' =>   'left', 'sort' => ''                 , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => array("show" => "ext_name", "select" => "name"))),
        "question"          => array("display" => 1, 'index' =>  2, 'align' =>   'left', 'sort' => 'qt.question'      , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => array("show" => "question", "select" => "question"))),
        "author"            => array("display" => 1, 'index' =>  3, 'align' =>   'left', 'sort' => 'q.author'         , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "email"             => array("display" => 1, 'index' =>  4, 'align' =>   'left', 'sort' => 'q.email'          , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "date_added"        => array("display" => 1, 'index' =>  6, 'align' =>   'left', 'sort' => 'q.date_added'     , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "date_modified"     => array("display" => 0, 'index' =>  7, 'align' =>   'left', 'sort' => 'q.date_modified'  , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "answers"           => array("display" => 1, 'index' =>  8, 'align' =>  'right', 'sort' => 'answers'          , 'filter' => array("show" => 1, "type" => 0, 'autocomplete' => false)),
        "store"             => array("display" => 0, 'index' =>  9, 'align' =>   'left', 'sort' => ''                 , 'filter' => array("show" => 1, "type" => 1, 'autocomplete' => false)),
        "status"            => array("display" => 1, 'index' => 10, 'align' =>   'left', 'sort' => 'q.status'         , 'filter' => array("show" => 1, "type" => 1, 'autocomplete' => false)),
        "action"            => array("display" => 1, 'index' => 11, 'align' =>  'right', 'sort' => ''                 , 'filter' => array("show" => 0, "type" => 0, 'autocomplete' => false)),
        // filter
        "approval"          => array("display" => 0, 'index' => 99, 'align' =>       '', 'sort' => ''                 , 'filter' => array("show" => 0, "type" => 0, 'autocomplete' => false)),
    );

    public function __construct($registry) {
        parent::__construct($registry);
        $this->data = array_merge($this->data, $this->language->load('catalog/questions_and_answers'));

        $this->load->model('catalog/questions_and_answers');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->helper('questions_and_answers');
    }

    private function urlParams($add_sort = true, $add_order = true, $add_page = true, $add_filters = true, $add_approval_filter = true) {
        $url = '';

        if ($add_filters) {
            foreach($this->columns as $column => $attr) {
                if ($add_approval_filter || $column != 'approval') {
                    if (isset($this->request->get['filter_' . $column])) {
                        $url .= '&filter_' . $column . '=' . urlencode(html_entity_decode($this->request->get['filter_' . $column], ENT_QUOTES, 'UTF-8'));
                    }
                }
            }
        }

        if ($add_sort && isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if ($add_order && isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if ($add_page && isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        return $url;
    }

    public function index() {
        $this->document->addScript('view/javascript/jquery/ui/jquery-ui-timepicker-addon.js');
        $this->document->addScript('view/javascript/qap/bootstrap.min.js');
        $this->document->addScript('view/javascript/qap/bootstrapx-typeahead.min.js');
        $this->document->addScript('view/javascript/qap/bootstrapx-clickover.min.js');
        $this->document->addScript('view/javascript/qap/questions.and.answers.pro.js');
        $this->document->addStyle('view/stylesheet/qap/bootstrap.min.css');
        $this->document->addStyle('view/stylesheet/qap/font-awesome.min.css');
        $this->document->addStyle('view/stylesheet/qap/questions_and_answers.css');

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $this->load->model('setting/setting');

            $qap_settings = $this->model_setting_setting->getSetting('questions_and_answers');

            if (isset($this->request->post['list_questions'])) {
                if (in_array($this->request->post['list_questions'], array('general', 'product', 'all'))) {
                    $qap_settings['qap_list_questions'] = $this->request->post['list_questions'];
                } else {
                    $qap_settings['qap_list_questions'] = 'all';
                }
            } else if (isset($this->request->post['list_language'])) {
                $qap_settings['qap_list_language'] = $this->request->post['list_language'];
            }

            $qap_settings = $this->model_setting_setting->editSetting('questions_and_answers', $qap_settings);

            $url = $this->urlParams();

            $this->redirect($this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL'), 303);
        }

        if ($this->config->get('qap_list_questions') == "general") {
            $this->columns['product']['display'] = 0;
        }

        $this->getList();
    }

    public function insert() {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($ajax_request) {
            $response = array();

            if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateForm($this->request->post)) {
                $question_id = $this->model_catalog_questions_and_answers->addQuestion($this->request->post);

                if ($this->sendNotificationEmail($question_id, $this->request->post) !== true) {
                    $response = array_merge(array("error" => true), array("errors" => $this->error));
                } else {
                    $response['success'] = $this->language->get('text_success');
                }
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        } else if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm($this->request->post)) {
            $question_id = $this->model_catalog_questions_and_answers->addQuestion($this->request->post);

            if ($this->sendNotificationEmail($question_id, $this->request->post) !== true) {
                if ($this->error['warning']) {
                    $this->session->data['warning'] = $this->error['warning'];
                } else {
                    $this->session->data['warning'] = $this->language->get('error_notification');
                }
            } else {
                $this->session->data['success'] = $this->language->get('text_success');
            }

            $url = $this->urlParams();

            $this->redirect($this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function update() {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($ajax_request) {
            $response = array();

            if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateForm($this->request->post)) {
                $this->model_catalog_questions_and_answers->editQuestion($this->request->get['question_id'], $this->request->post);

                if ($this->sendNotificationEmail($this->request->get['question_id'], $this->request->post) !== true) {
                    $response = array_merge(array("error" => true), array("errors" => $this->error));
                } else {
                    $response['success'] = $this->language->get('text_success');
                }
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        } else if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm($this->request->post)) {
            $this->model_catalog_questions_and_answers->editQuestion($this->request->get['question_id'], $this->request->post);

            if ($this->sendNotificationEmail($this->request->get['question_id'], $this->request->post) !== true) {
                if ($this->error['warning']) {
                    $this->session->data['warning'] = $this->error['warning'];
                } else {
                    $this->session->data['warning'] = $this->language->get('error_notification');
                }
            } else {
                $this->session->data['success'] = $this->language->get('text_success');
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $url = $this->urlParams();

            $this->redirect($this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function delete() {
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $question_id) {
                $this->model_catalog_questions_and_answers->deleteQuestion($question_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $url = $this->urlParams();

            $this->redirect($this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    public function autocomplete() {
        $json = array("items" => array());

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['query']) && isset($this->request->post['field'])) {
            switch ($this->request->post['field']) {
                case 'product':
                    $this->load->model('catalog/product');

                    if (isset($this->request->get['limit'])) {
                        $limit = $this->request->get['limit'];
                    } else {
                        $limit = 20;
                    }

                    $data = array(
                        'filter_name'   => $this->request->post['query'],
                        'start'         => 0,
                        'limit'         => $limit
                    );

                    $results = $this->model_catalog_product->getProducts($data);

                    foreach ($results as $result) {
                        $json["items"][] = array(
                            'product_id' => $result['product_id'],
                            'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                            'ext_name'   => strip_tags(html_entity_decode($result['name'] . ' (' . $result['model'] . ')', ENT_QUOTES, 'UTF-8'))
                        );
                    }
                    break;
                case 'question':
                    $this->load->model('catalog/questions_and_answers');

                    if (isset($this->request->get['limit'])) {
                        $limit = $this->request->get['limit'];
                    } else {
                        $limit = 20;
                    }

                    $data = array(
                        'filter_question'   => $this->request->post['query'],
                        'start'             => 0,
                        'limit'             => $limit
                    );

                    $results = $this->model_catalog_questions_and_answers->getQuestions($data);

                    foreach ($results as $result) {
                        $json["items"][] = array(
                            'question'    => strip_tags(html_entity_decode($result['question'], ENT_QUOTES, 'UTF-8'))
                        );
                    }
                    break;
                case 'customer':
                    $this->load->model('sale/customer');

                    if (isset($this->request->get['limit'])) {
                        $limit = $this->request->get['limit'];
                    } else {
                        $limit = 20;
                    }

                    $data = array(
                        'filter_name' => $this->request->post['query'],
                        'start'       => 0,
                        'limit'       => $limit
                    );

                    $results = $this->model_sale_customer->getCustomers($data);

                    foreach ($results as $result) {
                        $json["items"][] = array(
                            'customer_id'       => $result['customer_id'],
                            "name"              => $result['firstname'] . ' ' . $result['lastname'],
                            "email"             => $result['email'],
                            "ext_name"          => $result['firstname'] . ' ' . $result['lastname'] . ' <' . $result['email'] . '>',
                        );
                    }
                    break;
                default:
                    break;
            }
        }

        $this->response->setOutput(json_encode($json));
    }

    protected function getList() {
        $filters = array();

        foreach($this->columns as $column => $attr) {
            if (!($column == "product" && isset($this->request->get['filter_' . $column]) && $this->config->get('qap_list_questions') == "general")) {
                $filters[$column] = (isset($this->request->get['filter_' . $column])) ? $this->request->get['filter_' . $column] : null;
            }
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'q.date_added';
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

        $url = $this->urlParams();

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );

        $this->data['insert'] = $this->url->link('catalog/questions_and_answers/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['delete'] = $this->url->link('catalog/questions_and_answers/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['autocomplete'] = html_entity_decode($this->url->link('catalog/questions_and_answers/autocomplete', 'token=' . $this->session->data['token'], 'SSL'), ENT_QUOTES, 'UTF-8');

        if (isset($this->request->get['filter_approval'])) {
            $url = $this->urlParams(1,1,1,1,0);

            $this->data['approval'] = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['approval'] = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url . '&filter_approval=1', 'SSL');
        }

        $qap_list_questions = $this->config->get('qap_list_questions');
        $qap_list_language = $this->config->get('qap_list_language');

        $this->data['qap_list_questions'] = (!empty($qap_list_questions)) ? $qap_list_questions : 'all';
        $this->data['qap_list_language'] = (!empty($qap_list_language)) ? $qap_list_language : '*';
        $this->data['qap_multilingual'] = $this->config->get('qap_multilingual');

        if (isset($this->columns['store']['display']) && $this->columns['store']['display']) {
            $this->load->model('setting/store');

            $stores = $this->model_setting_store->getStores();

            $this->data['stores'] = array();

            $this->data['stores'][0] = array(
                    'name' => $this->config->get('config_name'),
                    'href' => HTTP_CATALOG
                );

            foreach ($stores as $store) {
                $this->data['stores'][$store['store_id']] = array(
                    'name' => $store['name'],
                    'href' => $store['url']
                    );
            }
        }

        if ($this->config->get('qap_multilingual')) {
            $this->load->model('localisation/language');

            $languages = $this->model_localisation_language->getLanguages();

            $this->data['languages'] = $languages;
        }

        $this->data['questions'] = array();

        $data = array(
            'sort'            => $sort,
            'order'           => $order,
            'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit'           => $this->config->get('config_admin_limit')
        );

        foreach($filters as $filter => $value) {
            $data['filter_' . $filter] = $value;
        }

        $results = $this->model_catalog_questions_and_answers->getQuestions($data);

        $total = $this->model_catalog_questions_and_answers->getTotal();

        $cp_cols = $this->columns;

        foreach ($results as $result) {
            $action = array();

            $action[] = array(
                'ref' => '',
                'hide' => false,
                'text' => $this->language->get('text_edit'),
                'name' => "edit",
                'title' => $this->language->get('text_edit'),
                'btn' => array('class' => '', 'icon' => 'icon-pencil'),
                'href' => $this->url->link('catalog/questions_and_answers/update', 'token=' . $this->session->data['token'] . '&question_id=' . $result['question_id'] . $url, 'SSL')
            );

            $columns = array(
                'question_id' => $result['question_id'],
                'selected'    => isset($this->request->post['selected']) && in_array($result['question_id'], $this->request->post['selected']),
                'action'      => $action
            );
            foreach($cp_cols as $column => $attr) {
                if ($attr['display']) {
                    if ($column == 'product') {
                        $products = $this->model_catalog_questions_and_answers->getQuestionProducts($result['question_id']);
                        $question_products = array();
                        foreach($products as $product) {
                            $question_products[] = $product['name'];
                        }
                        $columns[$column] = implode("<br />", array_slice($question_products, 0, 2));
                        if (count($question_products) > 2) {
                            $columns[$column] .= ' ...';
                            $columns["{$column}_all"] = implode("<br />", $question_products);
                        } else {
                            $columns["{$column}_all"] = '';
                        }
                    } else if ($column == 'store') {
                        $stores = $this->model_catalog_questions_and_answers->getQuestionStores($result['question_id']);
                        $question_stores = array();
                        foreach($stores as $store) {
                            $question_stores[] = $this->data['stores'][$store]['name'];
                        }
                        $columns[$column] = implode("<br />", array_slice($question_stores, 0, 2));
                        if (count($question_stores) > 2) {
                            $columns[$column] .= ' ...';
                            $columns["{$column}_all"] = implode("<br />", $question_stores);
                        } else {
                            $columns["{$column}_all"] = '';
                        }
                    } else if ($column == 'status') {
                        $columns[$column] = ((int)$result['status'] ? $this->language->get('text_enabled') : '<span style="color:#FF0000;">' . $this->language->get('text_disabled') . '</span>');
                    } else if ($column == 'date_added') {
                        $columns[$column] = date($this->language->get('date_format_short'), strtotime($result['date_added']));
                    } else if ($column == 'id') {
                        $columns[$column] = $result['question_id'];
                    } else if ($column == 'answers') {
                        $columns[$column] = ((int)$result[$column]) ? (int)$result[$column] : '<span style="color:#FF0000;">' . $result[$column] . "</span>";
                        $columns['answer_count'] = (int)$result[$column];
                        $disabled_count = $this->model_catalog_questions_and_answers->getTotalQuestionDisabledAnswers($result['question_id']);
                        if ($disabled_count) {
                            $columns['disabled_answers'] = sprintf($this->language->get('text_answer_approval'), $disabled_count);
                        } else {
                            $columns['disabled_answers'] = '';
                        }

                        $answers = $this->model_catalog_questions_and_answers->getAnswers($result['question_id']);
                        foreach ($answers as &$answer) {
                            $answer['date_added'] =  date($this->language->get('date_format_short'), strtotime($answer['date_added']));
                            $answer['answer'] =  html_entity_decode($answer['answer'], ENT_QUOTES, 'UTF-8');
                        }
                        $template = new Template();
                        $template->data['text_disabled'] = $this->language->get('text_disabled');
                        $template->data['text_enabled'] = $this->language->get('text_enabled');
                        $template->data['text_no_answer_text'] = $this->language->get('text_no_answer_text');
                        $template->data['answers'] = $answers;
                        $columns['answer_texts'] = htmlentities($template->fetch('catalog/answers.tpl'), ENT_QUOTES, 'UTF-8');
                    } else if ($column == 'author') {
                        $columns[$column] = $result[$column];
                        if ($result['customer_id']) {
                            $this->load->model('sale/customer');
                            $customer = $this->model_sale_customer->getCustomer($result['customer_id']);
                            $c_link = $this->url->link('sale/customer', 'token=' . $this->session->data['token'] . '&filter_name=' . $customer['firstname'] . ' ' . $customer['lastname'], 'SSL');
                        } else {
                            $c_link = '';
                        }
                        $columns['customer'] = $c_link;
                    } else if ($column == 'question') {
                        $columns[$column] = $result[$column];
                        $columns['language_id'] = $result['language_id'];
                        $columns['question_title'] = htmlentities(html_entity_decode($result[$column], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8');
                        $columns['question_details'] = htmlentities(html_entity_decode($result['details'], ENT_QUOTES, 'UTF-8'), ENT_QUOTES, 'UTF-8');
                    } else if ($column == 'action') {
                        $columns[$column] = $action;
                    } else {
                        $columns[$column] = $result[$column];
                    }
                }
            }
            $this->data['questions'][] = $columns;
        }

        //$this->data['filter_approv'] = $this->config->get('config_language_id');

        $this->data['columns'] = array();
        foreach($this->columns as $column => $attr) {
            $this->data['columns'][$column] = $this->language->get('column_' . $column);
        }

        $column_order = array();
        uasort($cp_cols, 'column_sort');

        foreach($cp_cols as $column => $attr) {
            if ($attr['display'])
                $column_order[] = $column;
        }

        $this->data['column_order'] = $column_order;
        $this->data['column_info'] = $cp_cols;

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

        $url = $this->urlParams(false, false);

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        $this->data['sorts'] = array();
        foreach($this->columns as $column => $attr) {
            $this->data['sorts'][$column] = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . '&sort=' . $attr['sort'] . $url, 'SSL');
        }

        $url = $this->urlParams(true, true, false);

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $this->data['pagination'] = $pagination->render();

        $this->data['filters'] = $filters;

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;

        $this->template = 'catalog/questions_and_answers_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    private function sendNotificationEmail($question_id, $data) {
        function br2nl($text) {
            return preg_replace('/<br\\s*?\/??>/i', '\n', $text);
        }

        function unique_key() {
            return base_convert(base_convert(rand(0,15), 10, 16) . substr(uniqid(), 1), 16, 36);
        }

        if (isset($data['notify_author']) && (int)$data['notify_author'] && $data['activate_next_notification'] == "" && (int)$data['status'] && $data['email'] != "") {
            $product_name = "";

            // Find the latest answer
            $answer_text = '';
            $answer_author = '';
            $answer_id = null;
            if (isset($data['answers'])) {
                $answers = array_reverse($data['answers']);
                $missing_customer_language_answer = False;
                foreach ($answers as $answer) {
                    if ((int)$answer['notify'] && (int)$answer['status']) {
                        if (isset($answer['answer_text'][$data['customer_language_id']]) && preg_replace("/\s+/", "", strip_tags($answer['answer_text'][$data['customer_language_id']]))) {
                            $answer_text = html_entity_decode($answer['answer_text'][$data['customer_language_id']], ENT_QUOTES, 'UTF-8');
                            $answer_author = $answer['author'];
                            $answer_id = (isset($answer['answer_id']) && $answer['answer_id']) ? $answer['answer_id'] : null;
                            break;
                        } else {
                            $missing_customer_language_answer = True;
                        }
                    }
                }
                if ($missing_customer_language_answer && !$answer_text) {
                    $this->error['warning'] = $this->language->get('error_answer_language');

                    return false;
                }
            } else {
                // No answers yet, so nothing to send
                return true;
            }

            $question = '';
            $question_details = '';
            $question_author = '';
            if (isset($data['question_text'][$data['customer_language_id']]['question']) && preg_replace("/\s+/", "", strip_tags($data['question_text'][$data['customer_language_id']]['question']))) {
                $question = html_entity_decode($data['question_text'][$data['customer_language_id']]['question'], ENT_QUOTES, 'UTF-8');
                $question_details = html_entity_decode($data['question_text'][$data['customer_language_id']]['details'], ENT_QUOTES, 'UTF-8');
            } else {
                $this->error['warning'] = $this->language->get('error_question_language');

                return false;
            }

            $l_query = $this->db->query("SELECT language_id, filename, directory FROM " . DB_PREFIX . "language WHERE language_id = '" . (int)$data['customer_language_id'] . "'");
            $language = new Language($l_query->row['directory']);
            $language->load($l_query->row['filename']);
            $language->load('mail/question_answered');

            $next_notification_activation_key = unique_key();

            $question_author = $data['author'] ? strip_tags($data['author']) : $language->get('text_anonymous');

            if (isset($data['related_products'])) {
                if ($data['product_id'] && !in_array($data['product_id'], $data['related_products']) || !$data['product_id']) {
                    $product_id = $data['related_products'][0];
                } else {
                    $product_id = $data['product_id'];
                }
            } else {
                $product_id = null;
            }

            if (isset($data['stores'])) {
                if ($data['store_id'] && !in_array($data['store_id'], $data['stores']) || !$data['store_id']) {
                    $store_id = $data['stores'][0];
                } else {
                    $store_id = $data['store_id'];
                }
            } else {
                $store_id = '0';
            }

            $config = new Config();

            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "'");

            foreach ($query->rows as $setting) {
                if (!$setting['serialized']) {
                    $config->set($setting['key'], $setting['value']);
                } else {
                    $config->set($setting['key'], unserialize($setting['value']));
                }
            }

            if ((int)$store_id == 0) {
                $config->set('config_url', HTTP_CATALOG);
                $config->set('config_ssl', HTTPS_CATALOG);
            }

            $url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));

            if ($product_id) {
                $p_query = $this->db->query("SELECT pd.name AS name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . $l_query->row['language_id'] . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$store_id . "'");

                if (!$p_query->num_rows) {
                    $this->error['warning'] = $this->language->get('error_notification');

                    return false;
                }

                $product_name = $p_query->row['name'];

                $view_link = $url->link('product/product', 'product_id=' . $data['product_id'] . '&nnak=' . $next_notification_activation_key);
                $view_opt_out_link = $url->link('product/product', 'product_id=' . $data['product_id']);
            } else {
                $view_link = $url->link('module/questions_and_answers/faq', 'question_id=' . $question_id . '&nnak=' . $next_notification_activation_key);
                $view_opt_out_link = $url->link('module/questions_and_answers/faq', 'question_id=' . $question_id);
            }

            if ($this->config->get('config_seo_url')) {
                if (array_key_exists('vqmod', $GLOBALS)) {
                    global $vqmod;
                    require_once($vqmod->modCheck(DIR_APPLICATION . '../catalog/controller/common/seo_url.php'));
                } else {
                    require_once(DIR_APPLICATION . '../catalog/controller/common/seo_url.php');
                }

                $seo_url = new ControllerCommonSeoUrl($this->registry);
                $view_link = $seo_url->rewrite($view_link);
                $view_opt_out_link = $seo_url->rewrite($view_opt_out_link);
            }

            $subject = sprintf($language->get('text_subject'), $config->get('config_name'));

            // HTML Mail
            $template = new Template();

            $template->data['title'] = sprintf($language->get('text_subject'), html_entity_decode($config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            $template->data['text_greeting'] = $language->get('text_greeting');
            $template->data['text_answered_product'] = $language->get('text_answered_product');
            $template->data['text_answered_general'] = $language->get('text_answered_general');
            $template->data['text_answered'] = $language->get('text_answered');
            $template->data['text_view'] = $language->get('text_view');
            $template->data['text_view_opt_out'] = $language->get('text_view_opt_out');
            $template->data['text_question_detail'] = $language->get('text_question_detail');
            $template->data['text_asked'] = sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($data['date_added'])));
            $template->data['text_question_short'] = $language->get('text_question_short');
            $template->data['text_answer_short'] = $language->get('text_answer_short');
            $template->data['text_powered_by'] = $language->get('text_powered_by');
            $template->data['text_closing'] = $language->get('text_closing');

            $template->data['store_name'] = $config->get('config_name');
            $template->data['store_url'] = $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url');
            $template->data['logo'] = $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url') . 'image/' . $config->get('config_logo');
            $template->data['question'] = $question;
            $template->data['question_details'] = $question_details;
            $template->data['answer'] = $answer_text;
            $template->data['author'] = $question_author;
            $template->data['answer_author'] = strip_tags($answer_author);
            $template->data['product'] = $product_id;
            $template->data['product_name'] = $product_name;
            $template->data['product_url'] = $view_opt_out_link;
            $template->data['view_link'] = $view_link;
            $template->data['view_opt_out_link'] = $view_opt_out_link;
            $template->data['show_answer'] = (int)$this->config->get('qap_show_answer_in_customer_notification');
            $template->data['sender'] = $config->get('config_name');

            $html = $template->fetch('mail/question_answered.tpl');

            // Text Mail
            $text  = $language->get('text_greeting') . ' ' . $question_author . ",\n\n";
            $text .= (($product_id) ? sprintf($language->get('text_answered_product'), $product_name) : $language->get('text_answered_general')) . "\n\n";
            $text .= $language->get('text_view') . "\n" . $view_link . "\n\n";
            $text .= $language->get('text_view_opt_out') . "\n" . $view_opt_out_link . "\n\n";
            $text .= $language->get('text_closing') . "\n";
            $text .= $config->get('config_name') . "\n\n";

            if ((int)$this->config->get('qap_show_answer_in_customer_notification')) {
                $text .= "-----------------------------------------\n";
                $text .= $language->get('text_question_detail') . "\n";
                $text .= sprintf($language->get('text_asked'), date($language->get('date_format_short'), strtotime($data['date_added']))) . "\n";
                $text .= $question . "\n" . $question_details . "\n\n";
                $text .= $language->get('text_answered') . "\n" . $answer_text . "\n" . $answer_author . "\n";
                $text .= "-----------------------------------------\n\n";
            }

            $text = strip_tags(br2nl($text));

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->hostname = $this->config->get('config_smtp_host');
            $mail->username = $this->config->get('config_smtp_username');
            $mail->password = $this->config->get('config_smtp_password');
            $mail->port = $this->config->get('config_smtp_port');
            $mail->timeout = $this->config->get('config_smtp_timeout');
            $mail->setFrom($config->get('config_email'));
            $mail->setSender($config->get('config_name'));
            $mail->setSubject($subject);
            $mail->setHtml($html);
            $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));

            $mail->setTo($data['email']);
            $mail->send();

            $this->model_catalog_questions_and_answers->setQuestionNotificationActivation($question_id, $next_notification_activation_key);
            $this->model_catalog_questions_and_answers->setAnswerNotification($answer_id, 0);
        }

        return true;
    }

    private function getForm() {
        $this->document->addScript('view/javascript/jquery/ui/jquery-ui-timepicker-addon.js');
        $this->document->addScript('view/javascript/qap/bootstrap.min.js');
        $this->document->addScript('view/javascript/qap/bootstrapx-typeahead.min.js');
        $this->document->addScript('view/javascript/qap/bootstrapx-clickover.min.js');
        $this->document->addScript('view/javascript/qap/questions.and.answers.pro.js');
        $this->document->addScript('view/javascript/ckeditor/ckeditor.js');
        $this->document->addStyle('view/stylesheet/qap/bootstrap.min.css');
        $this->document->addStyle('view/stylesheet/qap/font-awesome.min.css');
        $this->document->addStyle('view/stylesheet/qap/questions_and_answers.css');

        $errors = array("warning", "email", "question", "stores", "related_products", "answer");

        foreach ($errors as $error) {
            if (isset($this->error[$error])) {
                $this->data["error_$error"] = $this->error[$error];
            } else {
                if (in_array($error, array("question", "answer"))) {
                    $this->data["error_$error"] = array();
                } else {
                    $this->data["error_$error"] = '';
                }
            }
        }

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $url = $this->urlParams();

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if (!isset($this->request->get['question_id'])) {
            $this->data['action'] = $this->url->link('catalog/questions_and_answers/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('catalog/questions_and_answers/update', 'token=' . $this->session->data['token'] . '&question_id=' . $this->request->get['question_id'] . $url, 'SSL');
        }

        $this->data['cancel'] = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $this->data['autocomplete'] = html_entity_decode($this->url->link('catalog/questions_and_answers/autocomplete', 'token=' . $this->session->data['token'], 'SSL'), ENT_QUOTES, 'UTF-8');

        $this->data['token'] = $this->session->data['token'];

        if (isset($this->request->get['question_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $question_info = $this->model_catalog_questions_and_answers->getQuestion($this->request->get['question_id']);
        }

        /*$this->load->model('catalog/category');

        $this->data['categories'] = $this->model_catalog_category->getCategories(0);*/

        $this->load->model('setting/store');

        $stores = $this->model_setting_store->getStores();

        $this->data['stores'] = array();

        $this->data['stores'][0] = array(
                'name' => $this->config->get('config_name'),
                'href' => HTTP_CATALOG
            );

        foreach ($stores as $store) {
            $this->data['stores'][$store['store_id']] = array(
                'name' => $store['name'],
                'href' => $store['url']
                );
        }

        $this->load->model('localisation/language');

        $this->data['languages'] = $this->model_localisation_language->getLanguages();
        $this->data['lang'] = $this->config->get('config_language');

        $this->load->model('catalog/product');

        if (!empty($question_info)) {
            $this->data['question_id'] = $question_info['question_id'];
        } else if (!empty($this->request->get['question_id'])) {
            $this->data['question_id'] = $this->request->get['question_id'];
        } else {
            $this->data['question_id'] = '';
        }

        $form = array(
            "status"                        => 0,
            "date_added"                    => "",
            "date_modified"                 => "",
            "email"                         => "",
            "author"                        => "",
            "notify_author"                 => 1,
            "allow_answers"                 => $this->config->get('qap_allow_customer_answers'),
            "activate_next_notification"    => "",
            "customer_language_id"          => $this->config->get('config_language_id'),
            "customer_id"                   => null,
            "product_id"                    => null,
            "store_id"                      => '0'
        );

        foreach ($form as $key => $v) {
            if (isset($this->request->post[$key])) {
                if (in_array($key, array("date_added", "date_modified"))) {
                    $this->data[$key ."_formatted"] = ($this->request->post[$key] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($this->request->post[$key])) : '';
                }
                $this->data[$key] = $this->request->post[$key];
            } else if (isset($question_info[$key])) {
                if (in_array($key, array("date_added", "date_modified"))) {
                    $this->data[$key ."_formatted"] = ($question_info[$key] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($question_info[$key])) : '';
                }
                $this->data[$key] = $question_info[$key];
            } else {
                $this->data[$key] = $v;
            }
        }

        if (isset($this->request->post['question_text'])) {
            $this->data['question_text'] = $this->request->post['question_text'];
        } elseif (isset($question_info['question_id'])) {
            $this->data['question_text'] = $this->model_catalog_questions_and_answers->getQuestionTexts($question_info['question_id']);
        } else {
            $this->data['question_text'] = array();
        }

        if (isset($this->request->post['answers'])) {
            $this->data['answers'] = $this->request->post['answers'];
            foreach ($this->data['answers'] as &$answer) {
                $answer['date_added_formatted'] = ($answer['date_added'] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($answer['date_added'])) : '';
                $answer['date_modified_formatted'] = ($answer['date_modified'] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($answer['date_modified'])) : '';
            }
        } elseif (isset($question_info['question_id'])) {
            $answers = $this->model_catalog_questions_and_answers->getQuestionAnswers($question_info['question_id']);
            foreach ($answers as &$answer) {
                $votes = $this->model_catalog_questions_and_answers->getAnswerVotes($answer['answer_id']);
                $answer['answer_text'] = $this->model_catalog_questions_and_answers->getAnswerTexts($answer['answer_id']);
                $answer['date_added'] = $answer['date_added'];
                $answer['date_added_formatted'] = ($answer['date_added'] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($answer['date_added'])) : '';
                $answer['date_modified'] = $answer['date_modified'];
                $answer['date_modified_formatted'] = ($answer['date_modified'] != "0000-00-00 00:00:00") ? date($this->language->get('date_format_short'), strtotime($answer['date_modified'])) : '';
                $answer['likes'] = isset($votes['likes']) ? $votes['likes'] : 0;
                $answer['dislikes'] = isset($votes['dislikes']) ? $votes['dislikes'] : 0;
                $answer['excerpt'] = isset($answer['answer_text'][$this->config->get('config_language_id')]) ? strip_tags(html_entity_decode($answer['answer_text'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8')) : "<em>[ " . $this->language->get('text_no_answer_text') . " ]</em>";
            }
            $this->data['answers'] = $answers;
        } else {
            $this->data['answers'] = array();
        }

        if (isset($this->request->post['stores'])) {
            $this->data['question_stores'] = $this->request->post['stores'];
        } elseif (isset($question_info['question_id'])) {
            $this->data['question_stores'] = $this->model_catalog_questions_and_answers->getQuestionStores($question_info['question_id']);
            if (!$this->data['question_stores']) {
                $this->data['question_stores'] = array(0);
            }
        } else {
            $this->data['question_stores'] = array(0);
        }

        if (isset($this->request->post['related_products'])) {
            $products = $this->request->post['related_products'];

            $this->data['related_products'] = array();

            foreach ($products as $product_id) {
                $product = $this->model_catalog_product->getProduct($product_id);

                if ($product) {
                    $this->data['related_products'][] = array(
                        'product_id' => $product['product_id'],
                        'name'       => $product['name']
                    );
                }
            }
        } elseif (isset($question_info['question_id'])) {
            $this->data['related_products'] = $this->model_catalog_questions_and_answers->getQuestionProducts($question_info['question_id']);
        } else {
            $this->data['related_products'] = array();
        }


        $this->template = 'catalog/questions_and_answers_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function validateForm($data) {
        if (!$this->user->hasPermission('modify', 'catalog/questions_and_answers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!empty($data['email']) && !validEmail($data['email'])) {
            $this->error['email'] = $this->language->get('error_email');
        }

        $empty = true;
        foreach($data['question_text'] as $language_id => $question) {
            if (strlen($question['question'])) {
                $empty = false;
                break;
            }
        }
        if ($empty) {
            $this->error['warning'] = $this->language->get('error_question');
        }

        if (!isset($data['stores'])) {
            $this->error['stores'] = $this->language->get('error_store');
        }

        if (!(int)$this->config->get('qap_enable_general_questions') && !isset($data['related_products'])) {
            $this->error['related_products'] = $this->language->get('error_product');
        }

        if (isset($data['answers'])) {
            foreach($data['answers'] as $idx => $answer) {
                if (!empty($answer['email']) && !validEmail($answer['email'])) {
                    $this->error['answer'][$idx]['email'] = $this->language->get('error_email');
                }
            }
        }

        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'catalog/questions_and_answers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>
