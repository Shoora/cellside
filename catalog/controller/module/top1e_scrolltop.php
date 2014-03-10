<?php  
class ControllerModuleTop1eScrollTop extends Controller {
	protected function index() 
	{
		

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
				$this->document->addScript('catalog/view/javascript/top1e_scrolltop/easing.js');
                $this->document->addScript('catalog/view/javascript/top1e_scrolltop/jquery.ui.totop.js');
                if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/top1e_scrolltop/ui.totop.css')) {
                        $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/top1e_scrolltop/ui.totop.css');
                } else {
                        $this->document->addStyle('catalog/view/theme/default/stylesheet/top1e_scrolltop/ui.totop.css');
                }

		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/top1e_scrolltop.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/top1e_scrolltop.tpl';
		} else {
			$this->template = 'default/template/module/top1e_scrolltop.tpl';
		}
		$this->render();
	}
}
?>