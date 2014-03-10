<?php  
class ControllerModulePavcarousel extends Controller {
	protected function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		 
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavcarousel.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavcarousel.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/pavcarousel.css');
		}

		$this->data['limit'] = $setting['limit'];
		$this->data['columns'] = (int)$setting['columns'];

		$this->data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (file_exists(DIR_IMAGE . $result['image'])) {
				$this->data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height'])
				);
			}
		}

		$this->data['module'] = $module++; 

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavcarousel.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavcarousel.tpl';
		} else {
			$this->template = 'default/template/module/pavcarousel.tpl';
		}

		$this->render(); 
	}
}
?>