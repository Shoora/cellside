<?php
define('EXTENSION_NAME',            'Endless Scroller');
define('EXTENSION_VERSION',         '1.7.1');
define('EXTENSION_ID',              '5678');
define('EXTENSION_COMPATIBILITY',   'OpenCart 1.5.5.x and 1.5.6.x');
define('EXTENSION_STORE_URL',       'http://www.opencart.com/index.php?route=extension/extension/info&extension_id=' . EXTENSION_ID);
define('EXTENSION_SUPPORT_EMAIL',   'support@opencart.ee');
define('EXTENSION_SUPPORT_FORUM',   'http://forum.opencart.com/viewtopic.php?f=123&t=57210');
define('OTHER_EXTENSIONS',          'http://www.opencart.com/index.php?route=extension/extension&filter_username=bull5-i');

class ControllerModuleEndlessScroller extends Controller {
    private $error = array();
    protected $alert = array(
        'error'     => array(),
        'warning'   => array(),
        'success'   => array(),
        'info'      => array()
    );
    private $defaults = array(
        'es_installed'              => 1,
        'es_installed_version'      => EXTENSION_VERSION,
        'es_status'                 => 0,
        'es_bottom_pixels'          => 400,
        'es_use_fade_in'            => 1,
        'es_use_back_to_top'        => 1,
        'es_use_more'               => 0,
        'es_use_more_after'         => 0,
        'es_use_sticky_footer'      => 1,
        'es_max_items_per_load'     => 500
    );

    public function __construct($registry) {
        parent::__construct($registry);
        $this->load->helper('es');

        $this->language->load('module/endless_scroller');
    }

    public function index() {
        $this->document->addStyle('view/stylesheet/es/css/custom.min.css');
        $this->document->addScript('view/javascript/es/custom.min.js');
        $this->document->addScript('view/javascript/jquery/superfish/js/superfish.js');

        $this->document->setTitle($this->language->get('extension_name'));

        $this->load->model('setting/setting');

        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && !$ajax_request && $this->validateForm($this->request->post)) {
            $this->model_setting_setting->editSetting('endless_scroller', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_update');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        } else if ($this->request->server['REQUEST_METHOD'] == 'POST' && $ajax_request) {
            $response = array('success' => false);

            if ($this->validateForm($this->request->post)) {
                $original_settings = $this->model_setting_setting->getSetting('endless_scroller');

                $settings = array_merge($original_settings, $this->request->post);
                $settings['es_installed_version'] = $original_settings['es_installed_version'];

                $this->model_setting_setting->editSetting('endless_scroller', $settings);

                $response['success'] = true;
                $response['msg'] = $this->language->get("text_success_update");
            } else {
                $response = array_merge(array("error" => true), array("errors" => $this->error), array("alerts" => $this->alert));
            }

            $this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
            return;
        }

        $this->checkPrerequisites();

        $this->checkVersion();

        $this->data['heading_title'] = $this->language->get('extension_name');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_toggle_navigation'] = $this->language->get('text_toggle_navigation');
        $this->data['text_legal_notice'] = $this->language->get('text_legal_notice');
        $this->data['text_license'] = $this->language->get('text_license');
        $this->data['text_extension_information'] = $this->language->get('text_extension_information');
        $this->data['text_terms'] = $this->language->get('text_terms');
        $this->data['text_license_text'] = $this->language->get('text_license_text');
        $this->data['text_other_extensions'] = sprintf($this->language->get('text_other_extensions'), OTHER_EXTENSIONS);
        $this->data['text_support_subject'] = $this->language->get('text_support_subject');
        $this->data['text_faq'] = $this->language->get('text_faq');

        $this->data['tab_settings'] = $this->language->get('tab_settings');
        $this->data['tab_support'] = $this->language->get('tab_support');
        $this->data['tab_about'] = $this->language->get('tab_about');
        $this->data['tab_general'] = $this->language->get('tab_general');
        $this->data['tab_faq'] = $this->language->get('tab_faq');
        $this->data['tab_services'] = $this->language->get('tab_services');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_apply'] = $this->language->get('button_apply');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_close'] = $this->language->get('button_close');
        $this->data['button_upgrade'] = $this->language->get('button_upgrade');

        $this->data['help_bottom_pixels'] = $this->language->get('help_bottom_pixels');
        $this->data['help_use_fade_in'] = $this->language->get('help_use_fade_in');
        $this->data['help_use_more'] = $this->language->get('help_use_more');
        $this->data['help_use_more_after'] = $this->language->get('help_use_more_after');
        $this->data['help_use_sticky_footer'] = $this->language->get('help_use_sticky_footer');
        $this->data['help_max_items_per_load'] = $this->language->get('help_max_items_per_load');

        $this->data['entry_extension_status'] = $this->language->get('entry_extension_status');
        $this->data['entry_bottom_pixels'] = $this->language->get('entry_bottom_pixels');
        $this->data['entry_use_fade_in'] = $this->language->get('entry_use_fade_in');
        $this->data['entry_use_back_to_top'] = $this->language->get('entry_use_back_to_top');
        $this->data['entry_use_more'] = $this->language->get('entry_use_more');
        $this->data['entry_use_more_after'] = $this->language->get('entry_use_more_after');
        $this->data['entry_use_sticky_footer'] = $this->language->get('entry_use_sticky_footer');
        $this->data['entry_max_items_per_load'] = $this->language->get('entry_max_items_per_load');
        $this->data['entry_installed_version'] = $this->language->get('entry_installed_version');
        $this->data['entry_extension_name'] = $this->language->get('entry_extension_name');
        $this->data['entry_extension_compatibility'] = $this->language->get('entry_extension_compatibility');
        $this->data['entry_extension_store_url'] = $this->language->get('entry_extension_store_url');
        $this->data['entry_copyright_notice'] = $this->language->get('entry_copyright_notice');

        $this->data['error_ajax_request'] = $this->language->get('error_ajax_request');

        $this->data['ext_name'] = EXTENSION_NAME;
        $this->data['ext_version'] = EXTENSION_VERSION;
        $this->data['ext_id'] = EXTENSION_ID;
        $this->data['ext_compatibility'] = EXTENSION_COMPATIBILITY;
        $this->data['ext_store_url'] = EXTENSION_STORE_URL;
        $this->data['ext_support_email'] = EXTENSION_SUPPORT_EMAIL;
        $this->data['ext_support_forum'] = EXTENSION_SUPPORT_FORUM;
        $this->data['other_extensions_url'] = OTHER_EXTENSIONS;

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'active'    => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'active'    => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('extension_name'),
            'href'      => $this->url->link('module/endless_scroller', 'token=' . $this->session->data['token'], 'SSL'),
            'active'    => true
        );

        $this->data['save'] = $this->url->link('module/endless_scroller', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['upgrade'] = $this->url->link('module/endless_scroller/upgrade', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['update_pending'] = !$this->checkVersion();

        $this->data['installed_version'] = $this->installedVersion();

        # Loop through all settings for the post/config values
        foreach (array_keys($this->defaults) as $setting) {
            if (isset($this->request->post[$setting])) {
                $this->data[$setting] = $this->request->post[$setting];
            } else {
                $this->data[$setting] = $this->config->get($setting);
                if ($this->data[$setting] === null) {
                    if (!isset($this->alert['warning']['unsaved']) && $this->checkVersion())  {
                        $this->alert['warning']['unsaved'] = $this->language->get('error_unsaved_settings');
                    }
                    if (isset($this->defaults[$setting])) {
                        $this->data[$setting] = $this->defaults[$setting];
                    }
                }
            }
        }

        if (isset($this->session->data['error'])) {
            $this->error = $this->session->data['error'];

            unset($this->session->data['error']);
        }

        if (isset($this->error['warning'])) {
            $this->alert['warning']['warning'] = $this->error['warning'];
        }

        if (isset($this->error['error'])) {
            $this->alert['error']['error'] = $this->error['error'];
        }

        if (isset($this->session->data['success'])) {
            $this->alert['success']['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        }

        $this->data['errors'] = $this->error;

        $this->data['token'] = $this->session->data['token'];

        $this->data['alerts'] = $this->alert;

        $this->template = 'module/endless_scroller.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    public function install() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('endless_scroller', $this->defaults);
    }

    public function uninstall() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->deleteSetting('endless_scroller');
    }

    public function upgrade() {
        $ajax_request = isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';

        $response = array('success' => false);

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateUpgrade()) {
            $this->load->model('setting/setting');

            $settings = array();

            // Go over all settings, add new values and remove old ones
            foreach ($this->defaults as $setting => $default) {
                $value = $this->config->get($setting);
                if ($value === null) {
                    $settings[$setting] = $default;
                } else {
                    $settings[$setting] = $value;
                }
            }

            $settings['es_installed_version'] = EXTENSION_VERSION;

            $this->model_setting_setting->editSetting('endless_scroller', $settings);

            $this->session->data['success'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);
            $response['success'] = true;
            $response['msg'] = sprintf($this->language->get('text_success_upgrade'), EXTENSION_VERSION);
        } else {
            $response = array_merge(array("error" => true), array("errors" => $this->error), array("alerts" => $this->alert));
        }

        if (!$ajax_request) {
            $this->redirect($this->url->link('module/endless_scroller', 'token=' . $this->session->data['token'], 'SSL'));
        } else {
            $this->response->setOutput(json_enc($response, JSON_UNESCAPED_SLASHES));
            return;
        }
    }

    private function checkPrerequisites() {
        $errors = false;

        if (!class_exists('VQMod')) {
            $errors = true;
            $this->alert['error']['vqmod'] = $this->language->get('error_vqmod');
        }

        return !$errors;
    }

    private function checkVersion() {
        $errors = false;

        $installed_version = $this->installedVersion();

        if ($installed_version != EXTENSION_VERSION) {
            $errors = true;
            $this->alert['info']['version'] = sprintf($this->language->get('error_version'), EXTENSION_VERSION);
        }

        return !$errors;
    }

    private function validate() {
        $errors = false;

        if (!$this->user->hasPermission('modify', 'module/endless_scroller')) {
            $errors = true;
            $this->alert['error']['permission'] = $this->language->get('error_permission');
        }

        if (!$errors) {
            return $this->checkVersion() && $this->checkPrerequisites();
        } else {
            return false;
        }
    }

    private function validateForm($data) {
        $errors = false;

        if (!is_numeric($data['es_use_more_after']) || (int)$data['es_use_more_after'] != $data['es_use_more_after'] || (int)$data['es_use_more_after'] < 0) {
            $errors = true;
            $this->error['es_use_more_after'] = $this->language->get('error_positive_integer_zero');
        }

        if (!is_numeric($data['es_bottom_pixels']) || (int)$data['es_bottom_pixels'] != $data['es_bottom_pixels'] || (int)$data['es_bottom_pixels'] < 0) {
            $errors = true;
            $this->error['es_bottom_pixels'] = $this->language->get('error_positive_integer_zero');
        }

        if (!is_numeric($data['es_max_items_per_load']) || (int)$data['es_max_items_per_load'] != $data['es_max_items_per_load'] || (int)$data['es_max_items_per_load'] <= 0) {
            $errors = true;
            $this->error['es_max_items_per_load'] = $this->language->get('error_positive_integer');
        }

        if ($errors) {
            $errors = true;
            $this->alert['warning']['warning'] = $this->language->get('error_warning');
        }

        if (!$errors) {
            return $this->validate();
        } else {
            return false;
        }
    }

    private function validateUpgrade() {
        $errors = false;

        if (!$this->user->hasPermission('modify', 'module/endless_scroller')) {
            $errors = true;
            $this->alert['error']['permission'] = $this->language->get('error_permission');
        }

        return !$errors;
    }

    private function installedVersion() {
        $installed_version = $this->config->get('es_installed_version');
        return $installed_version ? $installed_version : '1.6.1';
    }
}
?>
