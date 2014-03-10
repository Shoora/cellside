<?php
class ControllerCommonPlainFooter extends Controller {
	protected function index() {
		$this->data['scripts'] = $this->document->getScripts();

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/plain_footer.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/common/plain_footer.tpl';
		} else {
			$this->template = 'default/template/common/plain_footer.tpl';
		}

		$this->render();
	}
}
?>