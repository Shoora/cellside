<?php  
class ControllerInformationAbout extends Controller {
	public function index() {

		$this->language->load('information/about');
		$this->document->setTitle($this->language->get('heading_title'));

		//Language

		$this->data['top_title'] = $this->language->get('top_title');
		$this->data['top_description'] = $this->language->get('top_description');
		$this->data['learn_button'] = $this->language->get('learn_button');
		$this->data['contact_button'] = $this->language->get('contact_button');
		$this->data['location_button'] = $this->language->get('location_button');
		$this->data['learn_title'] = $this->language->get('learn_title');
		$this->data['learn_description'] = $this->language->get('learn_description');
		$this->data['contact_title'] = $this->language->get('contact_title');
		$this->data['contact_description'] = $this->language->get('contact_description');
		$this->data['others_title'] = $this->language->get('others_title');

		//Logic

		$this->data['themeName'] = $this->config->get('config_template');

		//Load View

        $this->template = $this->config->get('config_template') . '/template/information/about.tpl';

        $this->children = array( //Required. The children files for the page.
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
	}
}
?>