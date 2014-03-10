<?php
class ControllerModuleQuestionsAndAnswers extends Controller {
    private $error = array();

    public function __construct($registry) {
        parent::__construct($registry);

        $this->language->load('module/questions_and_answers');

        $this->load->model('module/questions_and_answers');

        $this->load->helper('questions_and_answers');
    }

    public function index($settings) {
        $this->data['heading'] = ($settings['type'] == 'general') ? $this->language->get('heading_title_module_general') : $this->language->get('heading_title_module_product');
        $this->data['status'] = (int)$this->config->get('qap_status') && (($settings['type'] == 'general' && (int)$this->config->get('qap_enable_general_questions') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_ask_general_questions'))) || ($settings['type'] == 'product'));
        $this->data['position'] = $settings['position'];

        $settings['faq'] = (isset($this->request->get['_route_']) && $this->request->get['_route_'] == "module/questions_and_answers/faq" || isset($this->request->get['route']) && $this->request->get['route'] == "module/questions_and_answers/faq") ? true : false;
        if ($settings['type'] == 'general') {
            $this->data['module'] = $this->questionForm($settings);
        } else {
            $this->data['module'] = $this->pq($settings);
        }

        $template = 'qap_module';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $template . '.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/' . $template . '.tpl';
        } else {
            $this->template = 'default/template/module/' . $template . '.tpl';
        }

        $this->response->setOutput($this->render());
    }

    public function questionForm($conf = null) {
        $this->document->addScript('catalog/view/javascript/qap.js');

        if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css');
        } else {
            $this->document->addStyle('catalog/view/theme/default/stylesheet/qap.css');
        }

        if (!$conf) {
            $settings = array();

            if (isset($this->request->get['type'])) {
                $settings['type'] = $this->request->get['type'];
            } else {
                $settings['type'] = ((int)$this->config->get('qap_enable_general_questions')) ? 'general' : 'product';
            }

            if (isset($this->request->get['position'])) {
                $settings['position'] = $this->request->get['position'];
            } else {
                $settings['position'] = 'content_bottom';
            }

            if (isset($this->request->get['index'])) {
                $settings['index'] = $this->request->get['index'];
            } else {
                $settings['index'] = 0;
            }

            if (isset($this->request->get['faq'])) {
                $settings['faq'] = true;
            } else {
                $settings['faq'] = false;
            }
        } else{
            $settings = $conf;
        }

        $this->data['heading'] = $this->language->get('heading_title_module_general');
        $this->data['text_name'] = $this->language->get('text_name');
        $this->data['text_email'] = $this->language->get('text_email');
        $this->data['text_question'] = $this->language->get('text_question');
        $this->data['text_details'] = $this->language->get('text_details');
        $this->data['text_view_faq'] = $this->language->get('text_view_faq');
        $this->data['text_notify'] = $this->language->get('text_notify');
        $this->data['text_captcha'] = $this->language->get('text_captcha');
        $this->data['text_bbcode'] = $this->language->get('text_bbcode');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_question'] = $this->language->get('entry_main_question');
        $this->data['entry_details'] = $this->language->get('entry_details');
        $this->data['entry_captcha'] = $this->language->get('entry_captcha');

        $this->data['button_submit'] = $this->language->get('button_submit');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['status'] = (int)$this->config->get('qap_status') && (($settings['type'] == 'general' && (int)$this->config->get('qap_enable_general_questions') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_ask_general_questions'))) || ($settings['type'] == 'product' && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_ask_product_questions'))));
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['type'] = $settings['type'];
        $this->data['position'] = $settings['position'];
        $this->data['idx'] = $settings['index'];
        $this->data['name'] = $this->customer->getFirstname();
        $this->data['email'] = $this->customer->getEmail();

        $this->data['bbcode'] = (int)$this->config->get('qap_allow_bbcode_in_questions') && $this->config->get('qap_available_bbcode_tags');
        $this->data['max_name_len'] = $this->config->get('qap_max_name_length');
        $this->data['max_question_len'] = $this->config->get('qap_max_question_length');
        $this->data['max_details_len'] = $this->config->get('qap_max_details_length');

        $this->data['action'] = $this->url->link('module/questions_and_answers/ask');
        $this->data['view_faq'] = $this->url->link('module/questions_and_answers/faq');
        $this->data['captcha_img'] = $this->url->link('product/product/captcha');
        $this->data['bbcode_tags'] = $this->url->link('module/questions_and_answers/bbcode');
        $this->data['display_faq_link'] = !$settings['faq'] && $settings['type'] != 'product' && (int)$this->config->get('qap_enable_general_questions');

        if (isset($this->session->data['qap_success'])) {
            $this->data['success'] = $this->session->data['qap_success'];
        } else {
            $this->data['success'] = '';
        }

        $errors = array("warning", "name", "email", "question", "details", "captcha");

        foreach ($errors as $error) {
            if (isset($this->session->data['qap_errors'][$error]) && isset($this->session->data['qap_form_data']['index']) && $this->session->data['qap_form_data']['index'] == $settings['index']) {
                $this->data["error_$error"] = $this->session->data['qap_errors'][$error];
            } else {
                $this->data["error_$error"] = '';
            }
        }

        $form = array(
            "name"          => $this->customer->getFirstname(),
            "email"         => $this->customer->getEmail(),
            "question"      => "",
            "details"       => "",
            "notify"        => 1,
            "captcha"       => "",
            "product_id"    => ($settings['type'] == 'product' && isset($this->request->get['product_id'])) ? $this->request->get['product_id'] : null,
        );

        foreach ($form as $key => $v) {
            if (isset($this->session->data['qap_form_data'][$key]) && isset($this->session->data['qap_form_data']['index']) && $this->session->data['qap_form_data']['index'] == $settings['index']) {
                $this->data[$key] = $this->session->data['qap_form_data'][$key];
            } else {
                $this->data[$key] = $v;
            }
        }

        if (isset($this->session->data['qap_form_data']['index']) && $this->session->data['qap_form_data']['index'] == $settings['index']) {
            unset($this->session->data['qap_success']);
            unset($this->session->data['qap_errors']);
            unset($this->session->data['qap_form_data']);
        }

        $template = 'qap_question_form';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $template . '.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/' . $template . '.tpl';
        } else {
            $this->template = 'default/template/module/' . $template . '.tpl';
        }

        if ($conf) {
            return $this->render();
        } else {
            $this->response->setOutput($this->render());
        }
    }

    public function answerForm() {
        if (isset($this->request->get['type'])) {
            $type = $this->request->get['type'];
        } else {
            $type = ((int)$this->config->get('qap_enable_general_questions')) ? 'general' : 'product';
        }

        if (isset($this->request->get['question_id'])) {
            $question_id = (int)$this->request->get['question_id'];
            $question = $this->model_module_questions_and_answers->getQuestion($question_id);
        } else {
            $question_id = null;
            $question = null;
        }

        if (isset($this->request->get['product_id'])) {
            $product_id = (int)$this->request->get['product_id'];
        } else {
            $product_id = null;
        }

        $this->data['heading'] = $this->language->get('heading_title_add_an_answer');

        $this->data['text_name'] = $this->language->get('text_name');
        $this->data['text_email'] = $this->language->get('text_email');
        $this->data['text_answer'] = $this->language->get('text_answer');
        $this->data['text_view_faq'] = $this->language->get('text_view_faq');
        $this->data['text_captcha'] = $this->language->get('text_captcha');
        $this->data['text_bbcode'] = $this->language->get('text_bbcode');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_question'] = $this->language->get('entry_question');
        $this->data['entry_answer'] = $this->language->get('entry_answer');
        $this->data['entry_captcha'] = $this->language->get('entry_captcha');

        $this->data['button_submit'] = $this->language->get('button_submit');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['status'] = $question_id && (int)$this->config->get('qap_status') && (int)$this->config->get('qap_allow_customer_answers') && (($type == 'general' && (int)$this->config->get('qap_enable_general_questions') && (int)$this->config->get('qap_allow_customer_general_answers') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_answer_general_questions'))) || ($type == 'product' && (int)$this->config->get('qap_allow_customer_product_answers') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_answer_product_questions'))));
        $this->data['product_id'] = $product_id;
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['name'] = $this->customer->getFirstname();
        $this->data['email'] = $this->customer->getEmail();
        $this->data['question'] = isset($question['question']) ? html_entity_decode($question['question'], ENT_QUOTES, 'UTF-8') : '';
        $this->data['details'] = isset($question['details']) ? html_entity_decode($question['details'], ENT_QUOTES, 'UTF-8') : '';

        $this->data['bbcode'] = (int)$this->config->get('qap_allow_bbcode_in_answers') && $this->config->get('qap_available_bbcode_tags');
        $this->data['max_name_len'] = $this->config->get('qap_max_name_length');
        $this->data['max_answer_len'] = $this->config->get('qap_max_answer_length');

        $this->data['action'] = $this->url->link('module/questions_and_answers/answer');
        $this->data['view_faq'] = $this->url->link('module/questions_and_answers/faq');
        $this->data['captcha_img'] = $this->url->link('product/product/captcha');
        $this->data['bbcode_tags'] = $this->url->link('module/questions_and_answers/bbcode');

        if (isset($this->session->data['qap_success'])) {
            $this->data['success'] = $this->session->data['qap_success'];
        } else {
            $this->data['success'] = '';
        }

        $errors = array("warning", "name", "email", "answer", "captcha");

        foreach ($errors as $error) {
            if (isset($this->session->data['qap_errors'][$error]) && isset($this->session->data['qap_form_data']['question_id']) && $this->session->data['qap_form_data']['question_id'] == $question_id) {
                $this->data["error_$error"] = $this->session->data['qap_errors'][$error];
            } else {
                $this->data["error_$error"] = '';
            }
        }

        $form = array(
            "name"          => $this->customer->getFirstname(),
            "email"         => $this->customer->getEmail(),
            "answer"        => "",
            "captcha"       => "",
            "question_id"   => $question_id,
        );

        foreach ($form as $key => $v) {
            if (isset($this->session->data['qap_form_data'][$key]) && isset($this->session->data['qap_form_data']['question_id']) && $this->session->data['qap_form_data']['question_id'] == $question_id) {
                $this->data[$key] = $this->session->data['qap_form_data'][$key];
            } else {
                $this->data[$key] = $v;
            }
        }

        if (isset($this->session->data['qap_form_data']['question_id']) && $this->session->data['qap_form_data']['question_id'] == $question_id) {
            unset($this->session->data['qap_success']);
            unset($this->session->data['qap_errors']);
            unset($this->session->data['qap_form_data']);
        }

        $template = 'qap_answer_form';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $template . '.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/' . $template . '.tpl';
        } else {
            $this->template = 'default/template/module/' . $template . '.tpl';
        }

        $this->response->setOutput($this->render());
    }

    public function ask() {
        $json = array();

        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && !$ajax_request) {
            if ($this->validateQuestion($this->request->post)) {
                $data = $this->prepareQuestionData($this->request->post);
                $this->model_module_questions_and_answers->addQuestion($data);

                $this->session->data['qap_success'] = $this->language->get('text_success_question');
                $this->session->data['qap_form_data']['index'] = $this->request->post['index'];
            } else {
                $this->session->data['qap_errors'] = $this->error;
                $this->session->data['qap_form_data'] = $this->request->post;
            }

            if (isset($this->request->server['HTTP_REFERER'])) {
                $this->redirect($this->request->server['HTTP_REFERER']);
                return;
            }
        } else if ($this->request->server['REQUEST_METHOD'] == 'POST' && $ajax_request) {
            $response = array();

            if ($this->validateQuestion($this->request->post)) {
                $data = $this->prepareQuestionData($this->request->post);
                $this->model_module_questions_and_answers->addQuestion($data);

                $response['success'] = $this->language->get('text_success_question');
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        }

        $this->redirect($this->url->link('common/home'));
    }

    public function answer() {
        $json = array();

        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && !$ajax_request) {
            if ($this->validateAnswer($this->request->post)) {
                $data = $this->prepareAnswerData($this->request->post);
                $this->model_module_questions_and_answers->addAnswer($data);

                $this->session->data['qap_success'] = $this->language->get('text_success_answer');
            } else {
                $this->session->data['qap_errors'] = $this->error;
                $this->session->data['qap_form_data'] = $this->request->post;
            }

            if (isset($this->request->server['HTTP_REFERER'])) {
                $this->redirect($this->request->server['HTTP_REFERER']);
                return;
            }
        } else if ($this->request->server['REQUEST_METHOD'] == 'POST' && $ajax_request) {
            $response = array();

            if ($this->validateAnswer($this->request->post)) {
                $data = $this->prepareAnswerData($this->request->post);
                $this->model_module_questions_and_answers->addAnswer($data);

                $response['success'] = $this->language->get('text_success_answer');
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        }

        $this->redirect($this->url->link('common/home'));
    }

    public function vote() {
        $json = array();

        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($this->request->server['REQUEST_METHOD'] == 'GET' && !$ajax_request) {
            if ($this->validateVote($this->request->get)) {
                $data = $this->request->get;
                $this->model_module_questions_and_answers->updateVote($data['answer_id'], $data['vote'], $this->customer->getId(), isset($data['remove']));

                $this->session->data['qap_success'] = $this->language->get('text_success_vote');
            } else {
                $this->session->data['qap_errors'] = $this->error;
            }

            if (isset($this->request->server['HTTP_REFERER'])) {
                $this->redirect($this->request->server['HTTP_REFERER']);
                return;
            }
        } else if ($this->request->server['REQUEST_METHOD'] == 'GET' && $ajax_request) {
            $response = array();

            if ($this->validateVote($this->request->get)) {
                $data = $this->request->get;
                $this->model_module_questions_and_answers->updateVote($data['answer_id'], $data['vote'], $this->customer->getId(), isset($data['remove']));

                $response['rating'] = $this->model_module_questions_and_answers->getAnswerVotes($data['answer_id']);
                $response['my_vote'] = isset($data['remove']) ? 0 : (int)$data['vote'];
                $response['helpful_link'] = html_entity_decode($this->url->link('module/questions_and_answers/vote', 'vote=1&answer_id=' . $data['answer_id'] . (($response['my_vote'] > 0) ? '&remove=1' : '')), ENT_QUOTES, 'UTF-8');
                $response['unhelpful_link'] = html_entity_decode($this->url->link('module/questions_and_answers/vote', 'vote=-1&answer_id=' . $data['answer_id'] . (($response['my_vote'] < 0) ? '&remove=1' : '')), ENT_QUOTES, 'UTF-8');

                $response['success'] = $this->language->get('text_success_vote');
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        }

        $this->redirect($this->url->link('common/home'));
    }

    public function bbcode() {
        $this->document->addScript('catalog/view/javascript/qap.js');

        if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css');
        } else {
            $this->document->addStyle('catalog/view/theme/default/stylesheet/qap.css');
        }

        $this->document->setTitle($this->language->get('heading_title_bbcode'));

        $this->data['text_name'] = $this->language->get('text_name');
        $this->data['text_tag'] = $this->language->get('text_tag');
        $this->data['text_syntax'] = $this->language->get('text_syntax');

        $tags = $this->config->get('qap_available_bbcode_tags');
        $this->data['tags'] = explode(",", $tags);

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qap_bbcode.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qap_bbcode.tpl';
        } else {
            $this->template = 'default/template/module/qap_bbcode.tpl';
        }

        $this->children = array(
            'common/plain_footer',
            'common/plain_header'
        );

        return $this->response->setOutput($this->render());
    }

    public function faq() {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if (!(int)$this->config->get('qap_status') || !(int)$this->config->get('qap_enable_general_questions')) {
            $this->redirect($this->url->link('common/home'));
        }

        $this->document->addScript('catalog/view/javascript/qap.js');

        if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css');
        } else {
            $this->document->addStyle('catalog/view/theme/default/stylesheet/qap.css');
        }

        $this->document->setTitle($this->language->get('heading_title_faq_long'));

        if (isset($this->request->get['qsearch'])) {
            $search = html_entity_decode($this->request->get['qsearch'], ENT_QUOTES, 'UTF-8');
        } else if (isset($this->request->post['qsearch'])) {
            $search = html_entity_decode($this->request->post['qsearch'], ENT_QUOTES, 'UTF-8');
        } else {
            $search = '';
        }

        if (isset($this->request->get['question_id'])) {
            $search = "id:" . $this->request->get['question_id'];

            if (isset($this->request->get['nnak'])) {
                $this->model_module_questions_and_answers->activateNextNotification($this->request->get['question_id'], $this->request->get['nnak']);
            }
        }

        if (isset($this->request->get['qsort'])) {
            $sort = $this->request->get['qsort'];
        } else if (isset($this->request->post['qsort'])) {
            $sort = $this->request->post['qsort'];
        } else {
            $sort = 'helpful';
        }

        if (isset($this->request->get['qpage'])) {
            $page = $this->request->get['qpage'];
        } else {
            $page = 1;
        }

        $display_url = '';

        if ($search) {
            $display_url .= 'qsearch=' . urlencode($search);
        }

        if ($sort) {
            $display_url .= '&qsort=' . $sort;
        }

        if ((int)$page != 1 && !isset($this->request->post['qsort']) && !isset($this->request->post['qsearch'])) {
            $display_url .= '&qpage=' . $page;
        }

        $display_url = $this->url->link('module/questions_and_answers/faq', $display_url);

        if (isset($this->request->post['redirect']) && (int)$this->request->post['redirect'] && !$ajax_request) {
            $this->redirect($display_url, 303);
            return;
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title_faq'),
            'href'      => $this->url->link('module/questions_and_answers/faq'),
            'separator' => ' » '
        );

        if (isset($this->session->data['qap_success']) && !isset($this->session->data['qap_form_data']['index'])) {
            $this->data['success'] = $this->session->data['qap_success'];
            unset($this->session->data['qap_success']);
        } else {
            $this->data['success'] = '';
        }

        if (isset($this->session->data['qap_errors']["warning"]) && !isset($this->session->data['qap_form_data']['index'])) {
            $this->data["error_warning"] = $this->language->get('error_submit_answer');
            unset($this->session->data['qap_errors']);
        } else {
            $this->data["error_warning"] = '';
        }

        $url = '';

        if ($search) {
            $url .= 'qsearch=' . urlencode($search);
        }

        if ($sort) {
            $url .= '&qsort=' . $sort;
        }

        if ($page && $page != 1) {
            $url .= '&qpage=' . $page;
        }

        $this->data['show_ask_button'] = ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_ask_general_questions'));
        $this->data['show_answer_button'] = (int)$this->config->get('qap_allow_customer_answers') && (int)$this->config->get('qap_allow_customer_general_answers') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_answer_general_questions'));
        $this->data['login_required_to_answer'] = (int)$this->config->get('qap_allow_customer_answers') && (int)$this->config->get('qap_allow_customer_general_answers') && (int)$this->config->get('qap_login_to_answer_general_questions');

        $this->data['heading_title'] = $this->language->get('heading_title_faq_long');
        $this->data['heading_title_module_general'] = $this->language->get('heading_title_module_general');
        $this->data['heading_title_add_an_answer'] = $this->language->get('heading_title_add_an_answer');

        $this->data['text_no_questions'] = ($search) ? $this->language->get('text_no_results') : (($this->data['show_ask_button']) ? $this->language->get('text_be_first_to_ask') : $this->language->get('text_no_questions'));
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_search'] = $this->language->get('text_search');
        $this->data['pr'] = isset($this->request->get['pr']);
        $this->data['text_clear_search'] = $this->language->get('text_clear_search');
        $this->data['text_search_questions'] = $this->language->get('text_search_questions');
        $this->data['text_question_short'] = $this->language->get('text_question_short');
        $this->data['text_answer_short'] = $this->language->get('text_answer_short');
        $this->data['text_num_answers_alt'] = $this->language->get('text_num_answers_alt');
        $this->data['text_expand_all'] = $this->language->get('text_expand_all');
        $this->data['text_collapse_all'] = $this->language->get('text_collapse_all');
        $this->data['text_was_helpful'] = $this->language->get('text_was_helpful');
        $this->data['text_login_to_vote'] = $this->language->get('text_login_to_vote');
        $this->data['text_helpful_answer'] = $this->language->get('text_helpful_answer');
        $this->data['text_unhelpful_answer'] = $this->language->get('text_unhelpful_answer');
        $this->data['text_login_to_view_answers'] = sprintf($this->language->get('text_login_to_view_answers'), $this->url->link('account/login', 'redirect=1'));
        $this->data['text_login_to_view_questions'] = sprintf($this->language->get('text_login_to_view_questions'), $this->url->link('account/login', 'redirect=1'));
        $this->data['error_ajax_request'] = $this->language->get('error_ajax_request');

        $this->data['display_question_author'] = (int)$this->config->get('qap_display_question_author');
        $this->data['display_question_date'] = (int)$this->config->get('qap_display_question_date');
        $this->data['display_answer_author'] = (int)$this->config->get('qap_display_answer_author');
        $this->data['display_answer_date'] = (int)$this->config->get('qap_display_answer_date');
        $this->data['allow_answer_voting'] = (int)$this->config->get('qap_allow_answer_voting');
        $this->data['login_to_view_questions'] = (int)$this->config->get('qap_login_to_view_general_questions') && !$this->customer->isLogged();
        $this->data['login_to_view_question_answers'] = (int)$this->config->get('qap_login_to_view_general_question_answers') && !$this->customer->isLogged();

        $this->data['question_id'] = isset($this->request->get['question_id']) ? $this->request->get['question_id'] : null;
        $this->data['type'] = "general";
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['button_ask'] = $this->language->get('button_ask');
        $this->data['button_login_ask'] = $this->language->get('button_login_ask');
        $this->data['button_answer'] = $this->language->get('button_answer');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_submit'] = $this->language->get('button_submit');
        $this->data['button_login_answer'] = $this->language->get('button_login_answer');
        $this->data['login_link'] = $this->url->link('account/login', 'redirect=1');
        $this->data['question_form_link'] = $this->url->link('module/questions_and_answers/questionForm', 'type=general&position=content_modal&faq=1');
        $this->data['answer_form_link'] = $this->url->link('module/questions_and_answers/answerForm', 'type=general&question_id=');
        $this->data['search_link'] = $this->url->link('module/questions_and_answers/faq');
        $this->data['update_link'] = $this->url->link('module/questions_and_answers/faq', $url);
        $this->data['vote_helpful'] = $this->url->link('module/questions_and_answers/vote', $url . '&vote=1&answer_id=');
        $this->data['vote_unhelpful'] = $this->url->link('module/questions_and_answers/vote', $url . '&vote=-1&answer_id=');

        $this->data['sorts'] = array(
            "helpful"           => $this->language->get('text_sort_helpful'),
            "recent"            => $this->language->get('text_sort_recent'),
            "oldest"            => $this->language->get('text_sort_oldest'),
            "recent_answers"    => $this->language->get('text_sort_recent_answers'),
            "oldest_answers"    => $this->language->get('text_sort_oldest_answers'),
            "most_answers"      => $this->language->get('text_sort_most_answers'),
            "least_answers"     => $this->language->get('text_sort_least_answers'),
        );

        $per_page = (int)$this->config->get('qap_questions_per_page');

        $data = array(
            'type'          => 'general',
            'search'        => explode(" ", $search),
            'sort'          => $sort,
            'start'         => ($page - 1) * $per_page,
            'limit'         => $per_page
        );

        $results = $this->model_module_questions_and_answers->getQuestionsAndAnswers($data);

        foreach ($results as &$q) {
            $q['question'] = html_entity_decode($q['question'], ENT_QUOTES, 'UTF-8');
            $q['details'] = html_entity_decode($q['details'], ENT_QUOTES, 'UTF-8');
            $q['author'] = $q['author'] ? $q['author'] : $this->language->get('text_anonymous');
            $q['date_added'] = date($this->language->get('date_format_short'), strtotime($q['date_added']));

            foreach ($q['answers'] as &$a) {
                $a['answer'] = html_entity_decode($a['answer'], ENT_QUOTES, 'UTF-8');
                $a['author'] = $a['author'] ? $a['author'] : $this->language->get('text_anonymous');
                $a['date_added'] = date($this->language->get('date_format_short'), strtotime($a['date_added']));
            }
        }

        $this->data['total_questions'] = $this->model_module_questions_and_answers->getTotalQuestions();
        $this->data['total_answers'] = $this->model_module_questions_and_answers->getTotalAnswers($data);

        $this->data['questions'] = $results;

        if (!$search && empty($results)) {
            $this->data['update_link'] .= "&pr=1"; //partial reload
        }

        $url = '';

        if ($search) {
            $url .= '&qsearch=' . urlencode($search);
        }

        if ($sort) {
            $url .= '&qsort=' . $sort;
        }

        $this->data['text_total_questions'] = $this->language->get('text_num_questions');
        $this->data['text_total_answers'] = $this->language->get('text_num_answers');
        $this->data['search'] = $search;
        $this->data['sort'] = $sort;

        $pagination = new Pagination();
        $pagination->total = $this->data['total_questions'];
        $pagination->page = $page;
        $pagination->limit = $per_page;
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('module/questions_and_answers/faq', $url . '&qpage={page}');

        $this->data['pagination'] = $pagination->render();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qap_questions.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qap_questions.tpl';
        } else {
            $this->template = 'default/template/module/qap_questions.tpl';
        }

        $this->data['questions_answers'] = $this->render();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qap_faq.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qap_faq.tpl';
        } else {
            $this->template = 'default/template/module/qap_faq.tpl';
        }

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        if ($ajax_request) {
            if (isset($this->request->get['pr'])) {
                $this->response->setOutput(json_encode(array("content" => $this->render())));
            } else {
                $this->response->setOutput(json_encode(array("content" => $this->data['questions_answers'], "url" => html_entity_decode($display_url, ENT_QUOTES, 'UTF-8'))));
            }
        } else {
            $this->response->setOutput($this->render());
        }
    }

    public function pq($conf = null) {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if (!is_array($conf) || !count($conf)) {
            $settings = array();

            $modules = $this->config->get('questions_and_answers_module');

            if (is_array($modules) && count($modules)) {
                $settings = $modules[0];
            }
        } else {
            $settings = $conf;
        }

        $product_id = isset($this->request->get['product_id']) ? $this->request->get['product_id'] : (isset($this->request->post['product_id']) ? $this->request->post['product_id'] : null);
        // $product_name = "";

        if (!(int)$this->config->get('qap_status') || !isset($settings['status']) || !(int)$settings['status'] || !$product_id || (!$conf && !$ajax_request && !$this->request->post)) {
            if ($conf) {
                return "";
            } else if ($ajax_request) {
                $this->response->setOutput(json_encode(array()));
            } else {
                $this->redirect($this->getRedirectUrl());
            }
            return;
        }

        if (!$ajax_request) {
            $this->document->addScript('catalog/view/javascript/qap.js');

            if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css')) {
                $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/qap.css');
            } else {
                $this->document->addStyle('catalog/view/theme/default/stylesheet/qap.css');
            }

            /*$this->load->model("catalog/product");
            $product = $this->model_catalog_product->getProduct($product_id);
            $product_name = $product['name'];*/
        }

        if (isset($this->request->get['qsearch'])) {
            $search = html_entity_decode($this->request->get['qsearch'], ENT_QUOTES, 'UTF-8');
        } else if (isset($this->request->post['qsearch'])) {
            $search = html_entity_decode($this->request->post['qsearch'], ENT_QUOTES, 'UTF-8');
        } else {
            $search = '';
        }

        if (isset($this->request->get['question_id'])) {
            $search = "id:" . $this->request->get['question_id'];

            if (isset($this->request->get['nnak'])) {
                $this->model_module_questions_and_answers->activateNextNotification($this->request->get['question_id'], $this->request->get['nnak']);
            }
        }

        if (isset($this->request->get['qsort'])) {
            $sort = $this->request->get['qsort'];
        } else if (isset($this->request->post['qsort'])) {
            $sort = $this->request->post['qsort'];
        } else {
            $sort = 'helpful';
        }

        if (isset($this->request->get['qpage'])) {
            $page = $this->request->get['qpage'];
        } else {
            $page = 1;
        }

        $display_url = '';

        if (isset($this->request->server['HTTP_REFERER'])) {
            $url_info = parse_url(htmlspecialchars_decode($this->request->server['HTTP_REFERER']));

            $query = array();

            if (isset($url_info['query'])) {
                parse_str($url_info['query'], $query);
            } else {
                $query = array();
            }

            if ((int)$page != 1) {
                $query['qpage'] = $page;
            } else {
                unset($query['qpage']);
            }

            if (isset($this->request->post['qsearch']) && $this->request->post['qsearch']) {
                $query['qsearch'] = $search;
                unset($query['qpage']);
            } else {
                unset($query['qsearch']);
            }

            if (isset($this->request->post['qsort'])) {
                $query['qsort'] = $sort;
                unset($query['qpage']);
            }

            $query = http_build_query($query);

            $display_url = $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . $url_info['path'] . ($query ? "?" . $query : "") . (!empty($url_info['fragment']) ? $url_info['fragment'] : "");
        }

        if (isset($this->request->post['redirect']) && (int)$this->request->post['redirect'] && !$ajax_request) {
            $this->redirect($display_url, 303);
            return;
        }

        if (isset($this->session->data['qap_success']) && !isset($this->session->data['qap_form_data']['index'])) {
            $this->data['success'] = $this->session->data['qap_success'];
            unset($this->session->data['qap_success']);
        } else {
            $this->data['success'] = '';
        }

        if (isset($this->session->data['qap_errors']["warning"]) && !isset($this->session->data['qap_form_data']['index'])) {
            $this->data["error_warning"] = $this->language->get('error_submit_answer');
            unset($this->session->data['qap_errors']);
        } else {
            $this->data["error_warning"] = '';
        }

        $url = 'product_id=' . $product_id;

        if ($search) {
            $url .= '&qsearch=' . urlencode($search);
        }

        if ($sort) {
            $url .= '&qsort=' . $sort;
        }

        if ($page && $page != 1) {
            $url .= '&qpage=' . $page;
        }

        $this->data['show_ask_button'] = ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_ask_product_questions'));
        $this->data['show_answer_button'] = (int)$this->config->get('qap_allow_customer_answers') && (int)$this->config->get('qap_allow_customer_product_answers') && ($this->customer->isLogged() || !(int)$this->config->get('qap_login_to_answer_product_questions'));
        $this->data['login_required_to_answer'] = (int)$this->config->get('qap_allow_customer_answers') && (int)$this->config->get('qap_allow_customer_product_answers') && (int)$this->config->get('qap_login_to_answer_product_questions');

        $this->data['heading_title_add_an_answer'] = $this->language->get('heading_title_add_an_answer');
        $this->data['heading_title_ask_a_question'] = $this->language->get('heading_title_module_general');

        $this->data['text_no_questions'] = ($search) ? $this->language->get('text_no_results') : (($this->data['show_ask_button']) ? $this->language->get('text_be_first_to_ask') : $this->language->get('text_no_questions'));
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_search'] = $this->language->get('text_search');
        $this->data['text_clear_search'] = $this->language->get('text_clear_search');
        $this->data['text_search_questions'] = $this->language->get('text_search_questions');
        $this->data['text_question_short'] = $this->language->get('text_question_short');
        $this->data['text_answer_short'] = $this->language->get('text_answer_short');
        $this->data['text_expand_all'] = $this->language->get('text_expand_all');
        $this->data['text_collapse_all'] = $this->language->get('text_collapse_all');
        $this->data['text_was_helpful'] = $this->language->get('text_was_helpful');
        $this->data['text_login_to_vote'] = $this->language->get('text_login_to_vote');
        $this->data['text_helpful_answer'] = $this->language->get('text_helpful_answer');
        $this->data['text_unhelpful_answer'] = $this->language->get('text_unhelpful_answer');
        $this->data['text_login_to_view_answers'] = sprintf($this->language->get('text_login_to_view_answers'), $this->url->link('account/login', 'redirect=1'));
        $this->data['text_login_to_view_questions'] = sprintf($this->language->get('text_login_to_view_questions'), $this->url->link('account/login', 'redirect=1'));
        $this->data['error_ajax_request'] = $this->language->get('error_ajax_request');

        $this->data['lazy_load'] = (int)$this->config->get('qap_lazy_load');
        $this->data['display_question_author'] = (int)$this->config->get('qap_display_question_author');
        $this->data['display_question_date'] = (int)$this->config->get('qap_display_question_date');
        $this->data['display_answer_author'] = (int)$this->config->get('qap_display_answer_author');
        $this->data['display_answer_date'] = (int)$this->config->get('qap_display_answer_date');
        $this->data['allow_answer_voting'] = (int)$this->config->get('qap_allow_answer_voting');
        $this->data['login_to_view_questions'] = (int)$this->config->get('qap_login_to_view_product_questions') && !$this->customer->isLogged();
        $this->data['login_to_view_question_answers'] = (int)$this->config->get('qap_login_to_view_product_question_answers') && !$this->customer->isLogged();

        $this->data['question_id'] = isset($this->request->get['question_id']) ? $this->request->get['question_id'] : null;
        $this->data['product_id'] = $product_id;
        $this->data['type'] = "product";
        $this->data['pr'] = isset($this->request->get['pr']);
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['button_ask'] = $this->language->get('button_ask');
        $this->data['button_login_ask'] = $this->language->get('button_login_ask');
        $this->data['button_answer'] = $this->language->get('button_answer');
        $this->data['button_login_answer'] = $this->language->get('button_login_answer');
        $this->data['button_submit'] = $this->language->get('button_submit');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['login_link'] = $this->url->link('account/login', 'redirect=1');
        $this->data['question_form_link'] = $this->url->link('module/questions_and_answers/questionForm', 'type=product&position=content_modal&product_id=' . $product_id);
        $this->data['answer_form_link'] = $this->url->link('module/questions_and_answers/answerForm', 'type=product&product_id=' . $product_id . '&question_id=');
        $this->data['search_link'] = $this->url->link('module/questions_and_answers/pq');
        $this->data['update_link'] = $this->url->link('module/questions_and_answers/pq', $url);
        $this->data['vote_helpful'] = $this->url->link('module/questions_and_answers/vote', $url . '&vote=1&answer_id=');
        $this->data['vote_unhelpful'] = $this->url->link('module/questions_and_answers/vote', $url . '&vote=-1&answer_id=');

        $this->data['sorts'] = array(
            "helpful"           => $this->language->get('text_sort_helpful'),
            "recent"            => $this->language->get('text_sort_recent'),
            "oldest"            => $this->language->get('text_sort_oldest'),
            "recent_answers"    => $this->language->get('text_sort_recent_answers'),
            "oldest_answers"    => $this->language->get('text_sort_oldest_answers'),
            "most_answers"      => $this->language->get('text_sort_most_answers'),
            "least_answers"     => $this->language->get('text_sort_least_answers'),
        );

        $per_page = (int)$this->config->get('qap_questions_per_page');

        $data = array(
            'type'          => 'product',
            'product_id'    => $product_id,
            'search'        => explode(" ", $search),
            'sort'          => $sort,
            'start'         => ($page - 1) * $per_page,
            'limit'         => $per_page
        );

        if (!($this->data['lazy_load'] && !$ajax_request)) {
            $results = $this->model_module_questions_and_answers->getQuestionsAndAnswers($data);
        } else {
            $results = array();
        }

        foreach ($results as &$q) {
            $q['question'] = html_entity_decode($q['question'], ENT_QUOTES, 'UTF-8');
            $q['details'] = html_entity_decode($q['details'], ENT_QUOTES, 'UTF-8');
            $q['author'] = $q['author'] ? $q['author'] : $this->language->get('text_anonymous');
            $q['date_added'] = date($this->language->get('date_format_short'), strtotime($q['date_added']));

            foreach ($q['answers'] as &$a) {
                $a['answer'] = html_entity_decode($a['answer'], ENT_QUOTES, 'UTF-8');
                $a['author'] = $a['author'] ? $a['author'] : $this->language->get('text_anonymous');
                $a['date_added'] = date($this->language->get('date_format_short'), strtotime($a['date_added']));
            }
        }

        if (!($this->data['lazy_load'] && !$ajax_request)) {
            $this->data['total_questions'] = $this->model_module_questions_and_answers->getTotalQuestions();
            $this->data['total_answers'] = $this->model_module_questions_and_answers->getTotalAnswers($data);
        } else {
            $this->data['total_questions'] = 0;
            $this->data['total_answers'] = 0;
        }

        $this->data['questions'] = $results;

        if (!$search && empty($results) || !$ajax_request && !isset($this->request->get['pr']) && $this->data['lazy_load']) {
            $this->data['update_link'] .= "&pr=1"; //partial reload
        }

        $url = 'product_id=' . $product_id;

        if ($search) {
            $url .= '&qsearch=' . urlencode($search);
        }

        if ($sort) {
            $url .= '&qsort=' . $sort;
        }

        $this->data['text_total_questions'] = sprintf($this->language->get('text_num_questions'), $this->data['total_questions']);
        $this->data['text_total_answers'] = sprintf($this->language->get('text_num_answers'), $this->data['total_answers']);
        $this->data['search'] = $search;
        $this->data['sort'] = $sort;

        $pagination = new Pagination();
        $pagination->total = $this->data['total_questions'];
        $pagination->page = $page;
        $pagination->limit = $per_page;
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('module/questions_and_answers/pq', $url . '&qpage={page}');

        $this->data['pagination'] = $pagination->render();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qap_questions.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qap_questions.tpl';
        } else {
            $this->template = 'default/template/module/qap_questions.tpl';
        }

        $this->data['questions_answers'] = $this->render();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qap_product_questions.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/qap_product_questions.tpl';
        } else {
            $this->template = 'default/template/module/qap_product_questions.tpl';
        }

        if ($conf) {
            return $this->render();
        } else if ($ajax_request) {
            if (isset($this->request->get['pr'])) {
                $this->response->setOutput(json_encode(array("content" => $this->render())));
            } else {
                $this->response->setOutput(json_encode(array("content" => $this->data['questions_answers'], "url" => html_entity_decode($display_url, ENT_QUOTES, 'UTF-8'))));
            }
        } else {
            $this->response->setOutput($this->render());
        }
    }

    protected function prepareQuestionData($data) {
        $data['name'] = trim(strip_tags(htmlspecialchars_decode($data['name'])));
        $data['email'] = trim(strip_tags(htmlspecialchars_decode($data['email'])));
        $data['question'] = trim(strip_tags(htmlspecialchars_decode($data['question'])));
        $data['details'] = htmlentities($this->parseBBCode(trim(strip_tags(htmlspecialchars_decode($data['details']))), "question"), ENT_QUOTES, 'UTF-8');
        $data['notify'] = isset($data['notify']) ? (int)$data['notify'] : 0;

        return $data;
    }

    protected function prepareAnswerData($data) {
        $data['name'] = trim(strip_tags(htmlspecialchars_decode($data['name'])));
        $data['email'] = trim(strip_tags(htmlspecialchars_decode($data['email'])));
        $data['answer'] = htmlentities($this->parseBBCode(trim(strip_tags(htmlspecialchars_decode($data['answer']))), "answer"), ENT_QUOTES, 'UTF-8');
        $data['question_id'] = (int)$data['question_id'];
        $data['product_id'] = isset($data['product_id']) ? (int)$data['product_id'] : null;

        return $data;
    }

    protected function parseBBCode($data, $type="question") {
        $this->load->library("jbbcode");

        $tags = $this->config->get('qap_available_bbcode_tags');
        $tags = explode(",", $tags);

        $parser = new JBBCode\Parser();

        foreach ($tags as $tag) {
            switch ($tag) {
                case 'b':
                    /* [b] bold tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('b', '<strong>{param}</strong>');
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'i':
                    /* [i] italics tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('i', '<em>{param}</em>');
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'u':
                    /* [i] underline tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('u', '<u>{param}</u>');
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 's':
                    /* [s] strike trhough tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('s', '<strike>{param}</strike>');
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'url':
                    $urlValidator = new JBBCode\validators\UrlValidator();

                    /* [url] link tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('url', '<a href="{param}" target="_blank">{param}</a>');
                    $builder->setParseContent(false)->setBodyValidator($urlValidator);
                    $parser->addCodeDefinition($builder->build());

                    /* [url=http://example.com] link tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('url', '<a href="{option}" target="_blank">{param}</a>');
                    $builder->setUseOption(true)->setParseContent(true)->setOptionValidator($urlValidator);
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'img':
                    $urlValidator = new JBBCode\validators\UrlValidator();

                    /* [img] image tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('img', '<img src="{param}" />');
                    $builder->setUseOption(false)->setParseContent(false)->setBodyValidator($urlValidator);
                    $parser->addCodeDefinition($builder->build());

                    /* [img=alt text] image tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('img', '<img src="{param} alt="{option}" />');
                    $builder->setUseOption(true)->setParseContent(true)->setOptionValidator($urlValidator);
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'code':
                    /* [code] code tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('code', '<code>{param}</code>');
                    $builder->setParseContent(false);
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'quote':
                    /* [quote] quote tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('quote', '<blockquote><p>{param}</blockquote>');
                    $parser->addCodeDefinition($builder->build());

                    /* [quote=cite text] quote tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('quote', '<blockquote><p>{param}<p><small>{option}</small></blockquote>');
                    $builder->setUseOption(true);
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'color':
                    /* [color] text color tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('color', '<span style="color:{option}">{param}</span>');
                    $builder->setUseOption(true)->setOptionValidator(new JBBCode\validators\CssColorValidator());
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'size':
                    require_once(DIR_SYSTEM . 'library/jBBCode/validators/CssSizeValidator.php');

                    /* [size] text size tag */
                    $builder = new JBBCode\CodeDefinitionBuilder('size', '<span style="font-size:{option}%">{param}</span>');
                    $builder->setUseOption(true)->setOptionValidator(new JBBCode\validators\CssSizeValidator());
                    $parser->addCodeDefinition($builder->build());
                    break;
                case 'list':
                    /* [list] unordered list container tag */
                    $li = new ListCodeDefinition();
                    $parser->addCodeDefinition($li);

                    /* [list=] ordered list container tag */
                    $li = new ListCodeDefinition(true);
                    $parser->addCodeDefinition($li);
                    break;
                default:
                    break;
            }
        }

        $parser->parse($data);

        if ($type == "question" && (int)$this->config->get('qap_allow_bbcode_in_questions') || $type == "answer" && (int)$this->config->get('qap_allow_bbcode_in_answers')) {
            return $parser->getAsHtml();
        } else {
            return $parser->getAsText();
        }
    }

    protected function validateQuestion($data) {
        $data['name'] = (isset($data['name'])) ? trim(strip_tags(htmlspecialchars_decode($data['name']))) : '';
        $data['email'] = (isset($data['email'])) ? trim(strip_tags(htmlspecialchars_decode($data['email']))) : '';
        $data['question'] = (isset($data['question'])) ? trim(strip_tags(htmlspecialchars_decode($data['question']))) : '';
        $data['details'] = (isset($data['details'])) ? trim(strip_tags(htmlspecialchars_decode($data['details']))) : '';

        if ((utf8_strlen($data['name']) < $this->config->get('qap_min_name_length')) || (utf8_strlen($data['name']) > $this->config->get('qap_max_name_length'))) {
            $this->error['name'] = sprintf($this->language->get('error_name'), $this->config->get('qap_min_name_length'), $this->config->get('qap_max_name_length'));
        }

        if (utf8_strlen($data['email']) > 0 && !validEmail(utf8_decode($data['email']))) {
            $this->error['email'] = $this->language->get('error_email');
        }

        if ((utf8_strlen($data['question']) < $this->config->get('qap_min_question_length')) || (utf8_strlen($data['question']) > $this->config->get('qap_max_question_length'))) {
            $this->error['question'] = sprintf($this->language->get('error_question'), $this->config->get('qap_min_question_length'), $this->config->get('qap_max_question_length'));
        }

        if (utf8_strlen($data['details']) > $this->config->get('qap_max_details_length')) {
            $this->error['details'] = sprintf($this->language->get('error_details'), $this->config->get('qap_max_details_length'));
        }

        if (!$this->customer->isLogged() && (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $data['captcha']))) {
            $this->error['captcha'] = $this->language->get('error_captcha');
        }

        if (!$this->error) {
            return true;
        } else {
            if (!isset($this->error['warning'])) {
                $this->error['warning'] = $this->language->get('error_warning');
            }
            return false;
        }
    }

    protected function validateAnswer($data) {
        $data['name'] = trim(strip_tags(htmlspecialchars_decode($data['name'])));
        $data['email'] = trim(strip_tags(htmlspecialchars_decode($data['email'])));
        $data['answer'] = trim(strip_tags(htmlspecialchars_decode($data['answer'])));

        if ((utf8_strlen($data['name']) < $this->config->get('qap_min_name_length')) || (utf8_strlen($data['name']) > $this->config->get('qap_max_name_length'))) {
            $this->error['name'] = sprintf($this->language->get('error_name'), $this->config->get('qap_min_name_length'), $this->config->get('qap_max_name_length'));
        }

        if (utf8_strlen($data['email']) > 0 && !validEmail(utf8_decode($data['email']))) {
            $this->error['email'] = $this->language->get('error_email');
        }

        if ((utf8_strlen($data['answer']) < $this->config->get('qap_min_answer_length')) || (utf8_strlen($data['answer']) > $this->config->get('qap_max_answer_length'))) {
            $this->error['answer'] = sprintf($this->language->get('error_answer'), $this->config->get('qap_min_answer_length'), $this->config->get('qap_max_answer_length'));
        }

        if (!$this->customer->isLogged() && (!isset($this->session->data['captcha']) || ($this->session->data['captcha'] != $data['captcha']))) {
            $this->error['captcha'] = $this->language->get('error_captcha');
        }

        if (!isset($data['question_id'])) {
            $this->error['question_id'] = true;
        }

        if (!$this->error) {
            return true;
        } else {
            if (!isset($this->error['warning'])) {
                $this->error['warning'] = $this->language->get('error_warning');
            }
            return false;
        }
    }

    protected function validateVote($data) {
        if (!$this->customer->isLogged() || !(int)$this->config->get('qap_allow_answer_voting') || !isset($data['answer_id']) || !isset($data['vote']) || !in_array($data['vote'], array('1', '-1'))) {
            $this->error['warning'] = $this->language->get('error_submit_vote');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function getRedirectUrl() {
        $url = '';

        if (isset($this->request->server['HTTP_REFERER'])) {
            $url_info = parse_url(htmlspecialchars_decode($this->request->server['HTTP_REFERER']));

            $query = array();

            if (isset($url_info['query'])) {
                parse_str($url_info['query'], $query);
            } else {
                $query = array();
            }

            if (isset($this->request->get['qsearch']) && $this->request->get['qsearch']) {
                $query['qsearch'] = html_entity_decode($this->request->get['qsearch'], ENT_QUOTES, 'UTF-8');
            } else {
                unset($query['qsearch']);
            }

            if (isset($this->request->get['qsort'])) {
                $query['qsort'] = $this->request->get['qsort'];
            }

            if (isset($this->request->get['qpage']) && (int)$this->request->get['qpage'] != 1) {
                $query['qpage'] = $this->request->get['qpage'];
            } else {
                unset($query['qpage']);
            }

            $query = http_build_query($query);

            $url = $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . $url_info['path'] . ($query ? "?" . $query : "") . (!empty($url_info['fragment']) ? $url_info['fragment'] : "");
        } else {
            $url = $this->url->link('common/home');
        }

        return $url;
    }
}
?>
