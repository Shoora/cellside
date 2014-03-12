<?php
define('EXTENSION_NAME', "Questions &amp; Answers PRO");
define('EXTENSION_VERSION', "1.1.3");
define('EXTENSION_COMPATIBILITY', "OpenCart 1.5.1.x, 1.5.2.x, 1.5.3.x, 1.5.4.x, 1.5.5.x and 1.5.6.x");
define('EXTENSION_URL', "http://www.opencart.com/index.php?route=extension/extension/info&extension_id=12158");
define('EXTENSION_SUPPORT', "support@opencart.ee");
define('EXTENSION_SUPPORT_FORUM', "http://forum.opencart.com/viewtopic.php?f=123&t=103703");
define('OTHER_EXTENSIONS', "http://www.opencart.com/index.php?route=extension/extension&filter_username=bull5-i");
define('EXTENSION_MIN_PHP_VERSION', "5.3.0");

class ControllerModuleQuestionsAndAnswers extends Controller {
    private $error = array();
    private $defaults = array(
        'qap_installed'                             => 1,
        'qap_installed_version'                     => EXTENSION_VERSION,
        'qap_status'                                => 0,
        'qap_enable_general_questions'              => 1,
        'qap_login_to_view_general_questions'       => 0,
        'qap_login_to_view_general_question_answers'=> 0,
        'qap_login_to_view_product_questions'       => 0,
        'qap_login_to_view_product_question_answers'=> 0,
        'qap_login_to_ask_general_questions'        => 0,
        'qap_login_to_ask_product_questions'        => 0,
        'qap_moderate_new_questions'                => 1,
        'qap_allow_bbcode_in_questions'             => 0,
        'qap_allow_customer_answers'                => 0,
        'qap_allow_customer_product_answers'        => 0,
        'qap_allow_customer_general_answers'        => 0,
        'qap_login_to_answer_general_questions'     => 1,
        'qap_login_to_answer_product_questions'     => 1,
        'qap_moderate_customer_answers'             => 0,
        'qap_allow_bbcode_in_answers'               => 0,
        'qap_allow_answer_voting'                   => 1,
        'qap_available_bbcode_tags'                 => 'b,i,u,url',
        'qap_display_question_date'                 => 0,
        'qap_display_question_author'               => 1,
        'qap_display_answer_date'                   => 0,
        'qap_display_answer_author'                 => 1,
        'qap_new_question_notification'             => 1,
        'qap_new_answer_notification'               => 1,
        'qap_show_answer_in_customer_notification'  => 1,
        'qap_notification_emails'                   => '',
        'qap_questions_per_page'                    => 15,
        'qap_display_all_languages'                 => 1,
        'qap_lazy_load'                             => 0,
        'qap_remove_sql_changes'                    => 0,
        'qap_multilingual'                          => 0,
        'qap_list_questions'                        => 'all',
        'qap_list_language'                         => '*',
        'qap_min_name_length'                       => 3,
        'qap_max_name_length'                       => 25,
        'qap_min_question_length'                   => 15,
        'qap_max_question_length'                   => 300,
        'qap_min_answer_length'                     => 2,
        'qap_max_answer_length'                     => 2000,
        'qap_max_details_length'                    => 2000,
        'qap_admin_url'                             => HTTPS_SERVER,
    );

    public function __construct($registry) {
        parent::__construct($registry);
        $this->data = array_merge($this->data, $this->language->load('module/questions_and_answers'));

        $this->load->model('module/questions_and_answers');

        $this->document->setTitle($this->language->get('heading_title'));
    }

    public function index() {
        $this->load->helper("questions_and_answers");

        $this->document->addScript('view/javascript/qap/bootstrap.min.js');
        $this->document->addScript('view/javascript/qap/bootstrapx-clickover.min.js');
        $this->document->addScript('view/javascript/qap/questions.and.answers.pro.js');
        $this->document->addStyle('view/stylesheet/qap/bootstrap.min.css');
        $this->document->addStyle('view/stylesheet/qap/font-awesome.min.css');
        $this->document->addStyle('view/stylesheet/qap/questions_and_answers.css');

        $this->load->model('setting/setting');

        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && !$ajax_request && $this->validateForm($this->request->post)) {
            $this->model_setting_setting->editSetting('questions_and_answers', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        } else if ($this->request->server['REQUEST_METHOD'] == 'POST' && $ajax_request) {
            $response = array();

            if ($this->validateForm($this->request->post)) {
                $this->model_setting_setting->editSetting('questions_and_answers', $this->request->post);

                $response['success'] = $this->language->get('text_success');
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }

            $this->response->setOutput(json_encode($response));
            return;
        }

        $this->model_module_questions_and_answers->checkDatabaseStructure($this->error);

        $this->checkPrerequisites();

        $this->checkVersion();

        $this->checkLayout();

        $errors = array(
            "notice"                    => '',
            "warning"                   => '',
            "qap_notification_emails"   => '',
            "qap_questions_per_page"    => ''
        );

        foreach ($errors as $error => $default) {
            if (isset($this->error[$error])) {
                $this->data["error_$error"] = $this->error[$error];
            } else {
                $this->data["error_$error"] = $default;
            }
        }

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/questions_and_answers', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/questions_and_answers', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['ext_name'] = EXTENSION_NAME;
        $this->data['ext_version'] = EXTENSION_VERSION;
        $this->data['ext_compatibility'] = EXTENSION_COMPATIBILITY;
        $this->data['ext_url'] = EXTENSION_URL;
        $this->data['ext_support'] = EXTENSION_SUPPORT;
        $this->data['ext_support_forum'] = EXTENSION_SUPPORT_FORUM;
        $this->data['ext_subject'] = sprintf($this->language->get('text_ext_subject'), EXTENSION_NAME);
        $this->data['other_extensions_url'] = OTHER_EXTENSIONS;

        $this->load->model('design/layout');
        $this->data['layouts'] = arrayRemapKeysToIds("layout_id", $this->model_design_layout->getLayouts());

        $this->data['token'] = $this->session->data['token'];

        if (isset($this->request->post['questions_and_answers_module'])) {
            $this->data['questions_and_answers_module'] = $this->request->post['questions_and_answers_module'];
        } else {
            $modules = $this->config->get('questions_and_answers_module');
            if (isset($modules)) {
                $this->data['questions_and_answers_module'] = $modules;
            } else {
                if (!$this->data['error_notice']) {
                    $this->data['error_notice'] = $this->language->get('error_unsaved_settings');
                }

                // Find the correct product/product layout id
                $query = $this->db->query("SELECT layout_id FROM " . DB_PREFIX . "layout_route WHERE  route = 'product/product' LIMIT 1");

                if ($query->num_rows) {
                    $layout_id = (int)$query->row['layout_id'];
                } else {
                    $layout_id = -1;
                    $this->data['error_warning'] = $this->language->get('error_layout');
                }

                $this->data['questions_and_answers_module'] = array(
                    "position" => 'content_tab',
                    "layout_id" => $layout_id,
                    "sort_order" => 0,
                    "type" => 'product',
                    "status" => 0
                );
            }
        }

        # Loop through all settings for the post/config values
        foreach (array_keys($this->defaults) as $setting) {
            if (isset($this->request->post[$setting])) {
                $this->data[$setting] = $this->request->post[$setting];
            } else {
                $this->data[$setting] = $this->config->get($setting);
                if ($this->data[$setting] === null) {
                    if (!$this->data['error_notice']) {
                        $this->data['error_notice'] = $this->language->get('error_unsaved_settings');
                    }

                    if (isset($this->defaults[$setting])) {
                        $this->data[$setting] = $this->defaults[$setting];
                    }
                }
            }
        }

        $this->data['qap_admin_url'] = HTTPS_SERVER;

        $this->load->model('localisation/language');

        $languages = $this->model_localisation_language->getLanguages();

        $this->data['multilingual'] = count($languages) > 1;

        $installed_version = $this->config->get('qap_installed_version');
        $this->data['qap_installed_version'] = $installed_version ? $installed_version : '1.0.5';

        $this->template = 'module/questions_and_answers.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function install() {
        $this->model_module_questions_and_answers->applyDatabaseChanges();

        // Add FAQ layout
        $this->load->model('design/layout');
        $this->load->model('setting/store');

        $stores = $this->model_setting_store->getStores();

        $layout_data = array();
        $layout_data["name"] = $this->language->get("text_faq_layout");
        $layout_data["layout_route"] = array(0 => array(
            "store_id"  => 0,
            "route"     => "module/questions_and_answers/faq"
        ));

        foreach ($stores as $store) {
            $layout_data["layout_route"][] = array(
                "store_id"  => $store["store_id"],
                "route"     => "module/questions_and_answers/faq"
            );
        }

        $this->model_design_layout->addLayout($layout_data);

        // Find the correct product/product layout id
        $query = $this->db->query("SELECT layout_id FROM " . DB_PREFIX . "layout_route WHERE route = 'product/product' LIMIT 1");

        if ($query->num_rows) {
            $layout_id = (int)$query->row['layout_id'];
        } else {
            $layout_id = -1;
        }

        $this->load->model('setting/setting');
        $settings = array("position" => 'content_tab',
                          "layout_id" => $layout_id,
                          "sort_order" => 0,
                          "type" => 'product',
                          "status" => 0);
        $this->defaults['questions_and_answers_module'] = array(0 => $settings);
        $this->defaults["qap_notification_emails"] = $this->config->get('config_email');
        $this->model_setting_setting->editSetting('questions_and_answers', $this->defaults);
    }

    public function uninstall() {
        if ($this->config->get("qap_remove_sql_changes")) {
            $this->model_module_questions_and_answers->revertDatabaseChanges();
        }

        // Remove FAQ layout
        $query = $this->db->query("SELECT layout_id FROM " . DB_PREFIX . "layout_route WHERE route = 'module/questions_and_answers/faq' LIMIT 1");
        if ($query->num_rows) {
            $this->load->model('design/layout');
            $this->model_design_layout->deleteLayout($query->row['layout_id']);
        }

        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('questions_and_answers');
    }

    public function upgrade() {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        $response = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateUpgrade()) {
            $qap_installed_version = $this->config->get('qap_installed_version');
            $installed_version = $qap_installed_version ? $qap_installed_version : '1.0.5';
            if ($this->model_module_questions_and_answers->upgradeDatabaseStructure($installed_version, $this->error)) {
                $this->load->model('setting/setting');

                $settings = $this->model_setting_setting->getSetting('questions_and_answers');
                $settings['qap_installed_version'] = EXTENSION_VERSION;

                $this->model_setting_setting->editSetting('questions_and_answers', $settings);

                $this->session->data['success'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);
                $response['success'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error));
            }
        } else {
            $response = array_merge(array("error" => true), array("errors" => $this->error));
        }

        if (!$ajax_request) {
            $this->redirect($this->url->link('module/questions_and_answers', 'token=' . $this->session->data['token'], 'SSL'));
        } else {
            $this->response->setOutput(json_encode($response));
            return;
        }
    }

    private function checkPrerequisites() {
        if (!class_exists('VQMod')) {
            $this->error['warning'] = $this->language->get('error_vqmod');
        }

        if (version_compare(phpversion(), EXTENSION_MIN_PHP_VERSION) < 0) {
            $this->error['warning'] = sprintf($this->language->get('error_php_version'), phpversion(), EXTENSION_MIN_PHP_VERSION);
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function checkVersion() {
        $qap_installed_version = $this->config->get('qap_installed_version');
        $installed_version = $qap_installed_version ? $qap_installed_version : '1.0.5';

        if ($installed_version != EXTENSION_VERSION) {
            $this->error['warning'] = sprintf($this->language->get('error_version'), EXTENSION_VERSION, $this->url->link('module/questions_and_answers/upgrade', 'token=' . $this->session->data['token'], 'SSL'));
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function checkLayout() {
        $settings = $this->config->get('questions_and_answers_module');
        $layout_id = (int)$settings[0]['layout_id'];

        if (!$this->error && $layout_id == -1) {
            $this->error['warning'] = $this->language->get('error_layout');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/questions_and_answers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return $this->checkVersion() && $this->model_module_questions_and_answers->checkDatabaseStructure($this->error) && $this->checkPrerequisites() && $this->checkLayout();
        } else {
            return false;
        }
    }

    private function validateUpgrade() {
        if (!$this->user->hasPermission('modify', 'module/questions_and_answers')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function validateForm($data) {
        if (!empty($data["qap_notification_emails"])) {
            $emails = explode(",", $data["qap_notification_emails"]);
            foreach ($emails as $email) {
                if (!validEmail($email))
                    $this->error['qap_notification_emails'] = $this->language->get('error_email');
            }
        } else if (empty($this->request->post["qap_notification_emails"]) && (int)$this->request->post["qap_new_question_notification"]) {
            $this->error['qap_notification_emails'] = $this->language->get('error_missing_email');
        }

        if (!is_numeric($this->request->post["qap_questions_per_page"]) || (int)$this->request->post["qap_questions_per_page"] < 0) {
            $this->error['qap_questions_per_page'] = $this->language->get('error_questions_per_page');
        }

        if (!class_exists('VQMod')) {
            $this->error['warning'] = $this->language->get('error_vqmod');
        }

        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }

        if (!$this->error) {
            return $this->validate();
        } else {
            return false;
        }
    }
}
?>
