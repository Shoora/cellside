<?php
class ControllerModulePcpb extends Controller {
	private $error = array(); 
	 
	public function index() {
		$this->language->load('module/pcpb');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('pcpb', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->model('catalog/option');
		$options = $this->model_catalog_option->getOptions();
		$images = array();
		$texts = array();
		foreach($options as $option)
		{
			if($option['type'] == 'image'){
				$images[$option['option_id']] = $option['name'];
			}
			if($option['type'] == 'text'){
				$texts[$option['option_id']] = $option['name'];
			}
		}
		$this->data['list_background_options'] = $images;
		$this->data['list_image_options'] = $images;
		$this->data['list_url_options'] = $texts;
		
		$this->data['list_automatic'] = array(
			0 => $this->language->get('text_will_do_manually'), 
			6 => '6h',
			12 => '12h', 
			24 => '1d',
			72 => '3d'
		);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_product_mapping'] = $this->language->get('text_product_mapping');
		$this->data['text_option_background'] = $this->language->get('text_option_background');
		$this->data['text_option_preset'] = $this->language->get('text_option_preset');
		$this->data['text_option_save_url'] = $this->language->get('text_option_save_url');		
		$this->data['text_other'] = $this->language->get('text_other');
		$this->data['text_max_size_upload'] = $this->language->get('text_max_size_upload');
		$this->data['text_path_folder_save_temprarily'] = $this->language->get('text_path_folder_save_temprarily');
		$this->data['text_path_folder_save_temprarily_description'] = $this->language->get('text_path_folder_save_temprarily_description');
		$this->data['text_path_folder_save_permanently'] = $this->language->get('text_path_folder_save_permanently');
		$this->data['text_path_folder_save_permanently_description'] = $this->language->get('text_path_folder_save_permanently_description');
		$this->data['text_automatic_clean'] = $this->language->get('text_automatic_clean');
		$this->data['text_clean_folder'] = $this->language->get('text_clean_folder');
        
        $this->data['text_font'] = $this->language->get('text_font');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_add_link_google_fonts'] = $this->language->get('text_add_link_google_fonts');
        $this->data['text_add_link'] = $this->language->get('text_add_link');
        $this->data['text_list_link_google_fonts'] = $this->language->get('text_list_link_google_fonts');
        $this->data['text_remove_link'] = $this->language->get('text_remove_link');
         $this->data['text_enable_system_fonts'] = $this->language->get('text_enable_system_fonts');
		
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['error_option_background'])) {
			$this->data['error_option_background'] = $this->error['error_option_background'];
		} else {
			$this->data['error_option_background'] = '';
		}
		
		if (isset($this->error['error_option_preset'])) {
			$this->data['error_option_preset'] = $this->error['error_option_preset'];
		} else {
			$this->data['error_option_preset'] = '';
		}
		
		if (isset($this->error['error_option_save_url'])) {
			$this->data['error_option_save_url'] = $this->error['error_option_save_url'];
		} else {
			$this->data['error_option_save_url'] = '';
		}
		
		if (isset($this->error['error_max_size_upload'])) {
			$this->data['error_max_size_upload'] = $this->error['error_max_size_upload'];
		} else {
			$this->data['error_max_size_upload'] = '';
		}
		
		if (isset($this->error['error_path_folder_save_temprarily'])) {
			$this->data['error_path_folder_save_temprarily'] = $this->error['error_path_folder_save_temprarily'];
		} else {
			$this->data['error_path_folder_save_temprarily'] = '';
		}
		
		if (isset($this->error['error_path_folder_save_permanently'])) {
			$this->data['error_path_folder_save_permanently'] = $this->error['error_path_folder_save_permanently'];
		} else {
			$this->data['error_path_folder_save_permanently'] = '';
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
			'href'      => $this->url->link('module/pcpb', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
   		
		if (isset($this->request->post['pcpb_option_background'])) {
			$this->data['pcpb_option_background'] = $this->request->post['pcpb_option_background'];
		} else {
			$this->data['pcpb_option_background'] = $this->config->get('pcpb_option_background');
		}
		
		if (isset($this->request->post['pcpb_option_preset'])) {
			$this->data['pcpb_option_preset'] = $this->request->post['pcpb_option_preset'];
		} else {
			$this->data['pcpb_option_preset'] = $this->config->get('pcpb_option_preset');
		}
		
		if (isset($this->request->post['pcpb_option_save_url'])) {
			$this->data['pcpb_option_save_url'] = $this->request->post['pcpb_option_save_url'];
		} else {
			$this->data['pcpb_option_save_url'] = $this->config->get('pcpb_option_save_url');
		}
		
        if (isset($this->request->post['pcpb_enable'])) {
			$this->data['pcpb_enable'] = ($this->request->post['pcpb_enable'] == 1) ? true : false;
		} else {
			$this->data['pcpb_enable'] = ($this->config->get('pcpb_enable') == 1) ? true : false;
		}
        
        $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
        
        foreach ($list_fonts_google as $key=>$name){
            $this->data['list_link_google_fonts_options'][] = array(
                'key'     =>      $key,
                'pcpb_fonts_google'     =>      $name
            );    
        }
        
		$this->setData('pcpb_max_size_upload', 1024);
		
		$this->setData('pcpb_path_folder_save_temprarily', 'pcpb/temp/');
		
		$this->setData('pcpb_path_folder_save_permanently', 'pcpb/view/');
		
		$this->setData('pcpb_automatic_clean', '24');
        
        $this->data['token'] = $this->session->data['token'];
		
		$this->data['action'] = $this->url->link('module/pcpb', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->template = 'module/pcpb.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function install()
	{
		$this->load->model('module/pcpb');
		$this->model_module_pcpb->createDatabaseTables();
	}
	public function uninstall()
	{
		$this->load->model('module/pcpb');
		$this->model_module_pcpb->dropDatabaseTables();
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/pcpb')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
			
		if (!$this->request->post['pcpb_option_background']) {
			$this->error['error_option_background'] = $this->language->get('error_option_background');
		}
		if (!$this->request->post['pcpb_option_preset']) {
			$this->error['error_option_preset'] = $this->language->get('error_option_preset');
		}
		if (!$this->request->post['pcpb_option_save_url']) {
			$this->error['error_option_save_url'] = $this->language->get('error_option_save_url');
		}
		if (!$this->request->post['pcpb_max_size_upload']) {
			$this->error['error_max_size_upload'] = $this->language->get('error_max_size_upload');
		}
		if (!$this->request->post['pcpb_path_folder_save_temprarily']) {
			$this->error['error_path_folder_save_temprarily'] = $this->language->get('error_path_folder_save_temprarily');
		}
		if (!$this->request->post['pcpb_path_folder_save_permanently']) {
			$this->error['error_path_folder_save_permanently'] = $this->language->get('error_path_folder_save_permanently');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}
	
	function echoDbg( $what, $desc = '' )
	{
		if ( $desc )
			echo "<b>$desc:</b> ";
		echo "<pre>";
			print_r( $what );
		echo "</pre>\n";
	}
    
    public function addGoogleFonts()
	{
	    $linkGoogleFonts = $this->request->post['fonts'];
        $file_headers = @get_headers($linkGoogleFonts);
        if($file_headers[0] == 'HTTP/1.1 404 Not Found') 
        {            
            $this->response->setOutput(json_encode(""));
        }
        else
        {   
            $arrLinkGoogleFonts = explode('=', $linkGoogleFonts);
    		$fontsPlus = $arrLinkGoogleFonts[1];
            $pos = strpos($linkGoogleFonts, "css?family");
            if($pos > 0 && $fontsPlus != null && $fontsPlus != "")
            {
                $fonts = str_replace("+", " ", $fontsPlus);
        		$this->load->model('module/pcpb');
        		$this->model_module_pcpb->addGoogleFonts('fonts_google', $fonts);
                
                $this->response->setOutput(json_encode($fonts));
            } 
            else
            {
                $this->response->setOutput(json_encode(""));
            }           
        }        
	}
    
    public function reLoadFonts()
	{
	   $json = array();
	    $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
        
        foreach ($list_fonts_google as $key=>$name){
            $json = array(
                'key'     =>      $key,
                'pcpb_fonts_google'     =>      $name
            );    
        }
        
        $this->response->setOutput(json_encode($json));
	}
    
    public function removeGoogleFonts()
	{
	    $fonts = $this->request->post['fonts'];
        
		$this->load->model('module/pcpb');
		$this->model_module_pcpb->removeGoogleFonts($fonts);
        
        $this->response->setOutput(json_encode($fonts));
	}
}
?>