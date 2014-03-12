<?php
class ControllerModulePavtwitter extends Controller {
	protected function index($setting) {
		static $module = 0;


		$this->language->load('module/pavtwitter');

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['count'] = !empty($setting['count'])?$setting['count']:'';
		$this->data['username'] = $setting['username'];
    $this->data['widget_id'] = $setting['widget_id'];
    $this->data['theme'] = $setting['theme'];
    $this->data['link_color'] = $setting['link_color'];
    $this->data['border_color'] = $setting['border_color'];
    $this->data['width'] = $setting['width'];
    $this->data['height'] = $setting['height'];
    $this->data['show_replies'] = $setting['show_replies'];
    $this->data['chrome'] = is_array($setting['chrome'])?implode(" ",$setting['chrome']):$setting['chrome'];

		$this->data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavtwitter.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavtwitter.tpl';
		} else {
			$this->template = 'default/template/module/pavtwitter.tpl';
		}

		$this->render();
	}
}
?>
