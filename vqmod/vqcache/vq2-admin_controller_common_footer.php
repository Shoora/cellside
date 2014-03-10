<?php
class ControllerCommonFooter extends Controller {   
	protected function index() {
		$this->language->load('common/footer');
		
		$this->data['text_footer'] = sprintf($this->language->get('text_footer'), VERSION);

			if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';
			} else {			
			$this->data['logged'] = $this->user->getUserName();
			}
			
		
		if (file_exists(DIR_SYSTEM . 'config/svn/svn.ver')) {
			$this->data['text_footer'] .= '.r' . trim(file_get_contents(DIR_SYSTEM . 'config/svn/svn.ver'));
		}
		
		
			$this->template = 'admin_theme/base5builder_circloid/common/footer.tpl';
			
	
    	$this->render();
  	}
}
?>