<?php  
class ControllerInformationUnlocking extends Controller {
	public function index() {

		//$this->language->load('information/about');
		//$this->document->setTitle($this->language->get('heading_title'));

		//Language

		//Logic

		$this->data['themeName'] = $this->config->get('config_template');

		//Load View

        $this->template = $this->config->get('config_template') . '/template/information/unlocking.tpl';

        $this->children = array( //Required. The children files for the page.
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
	}
}
?>