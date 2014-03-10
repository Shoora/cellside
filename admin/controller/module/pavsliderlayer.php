<?php
class ControllerModulePavsliderlayer extends Controller {
	private $error = array(); 
	
	public function getModel( $model='slider' ){
		$model = "model_pavsliderlayer_"+$model;
		return $this->{$model};
	}
	protected function preload(){
		$this->language->load('module/pavsliderlayer');
		$this->load->model('tool/image');
		$this->load->model( 'pavsliderlayer/slider' );
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
	//	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		
			
		//	$this->request->post['pavsliderlayer_module'][0]['banner_image'] = 	$this->request->post['banner_image'];
		//	unset($this->request->post['banner_image']);
			
	
		//	$this->model_setting_setting->editSetting('pavsliderlayer', $this->request->post);		
			
			//$this->session->data['success'] = $this->language->get('text_success');
						
		//	 v
	//	}
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');			
				
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_width'] = $this->language->get('entry_width');
		$this->data['entry_height'] = $this->language->get('entry_height');
		
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);		
		$this->data['entry_show_image'] = $this->language->get( 'entry_show_image' );
		$this->data['entry_module_title'] = $this->language->get( 'entry_module_title' );
		$this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['entry_image_navigator'] = $this->language->get( 'entry_image_navigator' );
		$this->data['entry_navigator_width'] = $this->language->get( 'entry_navigator_width' );
		$this->data['entry_navigator_height'] = $this->language->get( 'entry_navigator_height' );
		
	}
	public function index() {   
		$this->preload();
		$model = $this->model_pavsliderlayer_slider; 

		$model->checkInstall();
		// process input post to insert or update 
		if ( ($this->request->server['REQUEST_METHOD'] == 'POST') ) {
			
			$module = array();

			if( !isset($this->request->post['pavsliderlayer_module']) ){
				$this->request->post['pavsliderlayer_module'] = array();
			}
		 	$module['pavsliderlayer_module'] = $this->request->post['pavsliderlayer_module'];
		  
			if( $this->request->post['action_mode'] == 'module-only' ) { 
				$this->model_setting_setting->editSetting( 'pavsliderlayer', $module );	
			}else if( $this->validateSliderGroup() ) {
				$data = array();  
				$data['title']  = $this->request->post['slider']['title'] ;
				$data['params'] = serialize( $this->request->post['slider'] );
				$data['id']     = $this->request->post['id'];
				$data['id'] = $model->saveSliderGroupData( $data , $this->request->post['id'] );
					$id = 'id='.$data['id']."&";
				if( !empty($this->request->post['action_mode']) &&  $this->request->post['action_mode'] == 'create-new' ){					
				 	$id = '';		
				}

				$this->model_setting_setting->editSetting( 'pavsliderlayer', $module );
				$this->redirect($this->url->link('module/pavsliderlayer', $id.'token=' . $this->session->data['token'], 'SSL'));
			}
		}



 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['success_msg'] = array();
		if( isset($this->request->get['msg_idone'])  ){
			if($this->request->get['msg_idone']){
				$this->data['success_msg'] =  $this->language->get('import_data_done');
			}else{
				$this->data['error_warning'] = $this->language->get('import_data_error');
			}
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
			'href'      => $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_limit'] = $this->language->get('entry_limit');
		$this->data['entry_scroll'] = $this->language->get('entry_scroll');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['action'] = $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['actionImport'] = $this->url->link('module/pavsliderlayer/import', 'token=' . $this->session->data['token'], 'SSL');
			


		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		$this->data['modules'] = array();
		$this->data['positions'] = array( 'mainmenu',
										  'slideshow',
										  'promotion',
										  'content_top',
										  'column_left',
										  'column_right',
										  'content_bottom',
										  'footer_top',
										  'footer_center',
										  'footer_bottom'
		);
		$this->data['yesno'] = array( 1=> $this->language->get('text_yes'), 0=>$this->language->get('text_no') );

		$this->data['shadow_types'] = array(
			0  	=> $this->language->get('text_no_shadow'),
			1  => 1,
			2  => 2,
			3  => 3
		);
		$this->data['linepostions'] = array(
			'bottom'  => $this->language->get('text_bottom'),
			'top'     => $this->language->get('text_top')
		);
		$this->data['navigator_types'] = array(
			'none'  => $this->language->get('text_none'),
			'bullet'     => $this->language->get('text_bullet'),
			'thumb'     => $this->language->get('text_thumbnail'),
			'both'     => $this->language->get('text_both')
				
		);
		$this->data['navigation_arrows'] = array(
			'none'    			 => $this->language->get('text_none'),
			'nexttobullets' 	 => $this->language->get('text_nexttobullets'),
			'verticalcentered'   => $this->language->get('text_verticalcentered')
			
				
		);
		
		$this->data['navigation_style'] = array(
			'round' 	    => $this->language->get('text_round'),
			'navbar'        => $this->language->get('text_navbar'),
			'round-old'     => $this->language->get('text_round_old') ,
			'square-old'    => $this->language->get('text_square_old') ,
			'navbar-old'    => $this->language->get('text_navbar_old') 
				
		);

		$d = array('layout_id'=>'','position'=>'','status'=>'','sort_order'=>'1',
		'banner_image'=>array(),'width'=>940,'height'=>350,
		'image_navigator' => 0,
		'navimg_height'   =>97,
		'navimg_weight'   =>177
		);


		$id = isset($this->request->get['id']) ? $this->request->get['id']:0;
		$sliderGroup = $model->getSliderGroupById( $id );
	 	

		$params = $sliderGroup['params'] ;
		 
		$this->data['id'] = $id;
		if (isset($this->request->post['pavsliderlayer_module'])) {
			$this->data['modules'] = $this->request->post['pavsliderlayer_module'];
		} elseif ($this->config->get('pavsliderlayer_module')) { 
			$this->data['modules'] = $this->config->get('pavsliderlayer_module');
		}	
		if( !empty($this->data['modules']) ){
			 $d = array_merge($d,$this->data['modules'][0]);			
		}
		$this->data['module'] = $d;
		if( $d['banner_image'] ){
			$tmp = array();$i=1;
			foreach( $d['banner_image'] as $key => $banner ){
				$banner['link'] = isset($banner['link'])?trim($banner['link']):"";
				$banner['thumb'] = $this->model_tool_image->resize($banner['image'], 100, 100);
				$tmp[$i++] = $banner;
			}
			 $d['banner_image'] = $tmp;
		}


		$this->data['slidergroups'] = $model->getListSliderGroups();
		// echo '<pre>'.print_r( $this->data['slidergroups'] ,1  ); die; 
		$this->data['params'] = $params;
		$this->data['fullwidth'] = array( '' 		   => $this->language->get('Boxed'),
										  'fullwidth'  => $this->language->get('Fullwidth'),
										  'fullscreen' => $this->language->get('Fullscreen') );
		$this->data['banner_image'] = $d['banner_image'];
		$this->load->model('design/layout');
		$this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
		
		$this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());
		
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();


		$this->document->addScript('view/javascript/sliderlayer/script.js');
		$this->document->addStyle('view/stylesheet/sliderlayer/style.css');

		$this->document->addScript('view/javascript/sliderlayer/jquery-cookie.js');

		$this->template = 'module/sliderlayer/sliders.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function layer(){
		$this->preload();
		$id = isset($this->request->get['id'] ) ? $this->request->get['id'] : 0;

		if( !isset($this->request->get['group_id'])  || !$this->request->get['group_id']){
			$this->redirect( $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL') );
		}	
		$groupID = (int)$this->request->get['group_id'];

		$model = $this->model_pavsliderlayer_slider; 

	 	$this->data['success_msg'] = array();
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
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
			'href'      => $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);	
		$this->data['action'] = $this->url->link('module/pavsliderlayer/savedata', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL');		
		$this->data['token'] = $this->session->data['token'];
		$this->data['actionUpdatePostURL'] = $this->url->link('module/pavsliderlayer/savepos', 'token=' . $this->session->data['token'], 'SSL');

		$sliderGroup = $model->getSliderGroupById( $groupID );
		if( !$sliderGroup ){
			$this->redirect( $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL') );
		}


	//	$this->data['text_browse'] = $this->language->get( 'text_browse' );
	 	// echo '<pre>'.print_r( $sliderGroup , 1 ); die;
		$this->data['sliderGroup']  = $sliderGroup;
		$this->data['sliderHeight'] = (int) $sliderGroup['params']['height'];
		$this->data['sliderWidth']  = (int) $sliderGroup['params']['width'];  
		//// get list  slider 
		$sliders = $model->getSlidersByGroupId( $groupID );
		$this->data['sliders'] = $sliders;
		$this->data['group_id'] = $groupID;
		$dslider = array(
			'status' => 1,

		);

		$this->data['transtions'] = array(
			'random' => 'Randdom',
			'slidehorizontal'=> 'Slide Horizontal',
			'slidevertical' => 'Slide Vertical',
			'boxslide' => 'Box Slide',
			'boxfade' => 'Box Fade',
			'slotzoom-horizontal'=> 'Slot Zoom Horizontal',
			'slotslide-horizontal'=> 'Slot Slide Horizontal',
			'slotfade-horizontal'=> 'Slot Fade Horizontal',
			'slotzoom-vertical'=> 'Slot Zoom Vertical',
			'slotslide-vertical'=> 'Slot Slide Vertical',
			'slotfade-vertical'=> 'Slot Fade Vertical',
			'curtain-1' => 'Curtain 1',
			'curtain-2' => 'Curtain 2',
			'curtain-3' => 'Curtain 3',
			'slideleft' => 'Slide Left',
			'slideright' => 'Slide Right',
			'slideup' => 'Slide Up',
			'slidedown' => 'Slide Down',
			'papercut' => 'Page Cut',
			'3dcurtain-horizontal'=> '3dcurtain Horizontal',
			'3dcurtain-vertical'=> '3dcurtain Vertical',
			'flyin'=> 'Fly In',
			'turnoff' => 'Turn Off',
			'custom-1' => 'Custom 1',
			'custom-2' => 'Custom 2',
			'custom-3' => 'Custom 3',
			'custom-4' => 'Custom 4'
		);

		$default = array(
			'title' => '',
			'slider_link' => '',
			'slider_usevideo' => '0',
			'slider_videoid' => '',
			'slider_videoplay' => '0',
			'fullwidth'=> '',
			'image' => 'data/slide_image.jpg',
			'layersparams'=> '',
			'slider_transition' => 'random',
			'slider_delay'   => '0',
			'slider_status'  => 1,
			'slider_transition' => 'random',
			'slider_duration'    => '300',
 			'slider_rotation'   => '0',
			'slider_enable_link' => 0,
			'slider_link'  => '',
			'slider_thumbnail' => '',
			'slider_slot' =>'7',	
			'slider_image'   => 'data/slide_image.jpg',
			'slider_id'   => '',
			'id'  => '',
			'slider_title' => '',
			'slider_enable_link' => '',
			'params' => array()
				
		);

		

 
		$this->data['usevideo'] = array( '0'=> $this->language->get('No'),'youtube'=>'Youtube','vimeo'=>'Vimeo');
		 
		$slider = $model->getSliderById( $id ); 
		$times = array();
		$layers = array(); 	

		$slider = array_merge( $default, $slider ); 

		if( $slider['layersparams'] ){
			$std = unserialize( $slider['layersparams'] );
			$layers = $std->layers;
			
			foreach( $layers as $k=>$l ){
				$layers[$k]['layer_caption'] = addslashes( str_replace("'",'"',html_entity_decode( $l['layer_caption'] , ENT_QUOTES, 'UTF-8')) ); 
			}
		}

 	
 

		$params = $slider['params'] ? unserialize( $slider['params'] ) : array();	
		$params = array_merge( $default, $params ); 



		if( $params['slider_thumbnail'] ){
			$this->data['slider_thumbnail'] =  $this->model_tool_image->resize(  $params['slider_thumbnail'], 
						$sliderGroup['params']['thumbnail_width'], $sliderGroup['params']['thumbnail_height'] );
		}else {
			$this->data['slider_thumbnail'] = '';
		}


	  
		$this->data['yesno'] = array( 1=> $this->language->get('text_yes'), 0=>$this->language->get('text_no') );
		$this->data['slider_title'] = $slider['title'];
		$this->data['params'] = $params; 
		$this->data['layers'] = $layers;
		$this->data['slider_id']  = $id;
		$this->data['slider_image'] = $slider['image'];  // echo HTTP_CATALOG.'image2wbmp(image)/'.$slider['image'];die;
		$this->data['slider_image_src'] = HTTP_CATALOG.'image/'.$slider['image'];
		 
		$typoFile = 	HTTP_CATALOG."catalog/view/theme/default/stylesheet/sliderlayer/css/typo.css";	
		if( file_exists( DIR_CATALOG ."view/theme/". $this->config->get('config_template')."/stylesheet/sliderlayer/css/typo.css" ) ){
			$typoFile = 	HTTP_CATALOG."catalog/view/theme/". $this->config->get('config_template')."/stylesheet/sliderlayer/css/typo.css";	
		}
		$this->document->addStyle( $typoFile  );
		
		
		$this->document->addScript('view/javascript/sliderlayer/script.js');
		$this->document->addStyle('view/stylesheet/sliderlayer/style.css');
		$this->template = 'module/sliderlayer/layer.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());

	}

	public function savepos(){
		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			die( $this->language->get('error_permission') ); 
		}
		if( isset($this->request->post['id'])  && is_array($this->request->post['id']) ){
			 $this->preload();
			 foreach( $this->request->post['id'] as $id => $pos ){
			 	 $this->model_pavsliderlayer_slider->updatePost((int)$id, $pos );
			 }

			
		}
		 die('done');
	}
	public function copythis(){
		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			die( $this->language->get('error_permission') ); 
		}
	 	$this->preload();
	 	$model = $this->model_pavsliderlayer_slider;
	 	if( isset($this->request->get['id']) ){
	 		$id = (int) $this->request->get['id'];
	 		$slider = $slider = $model->getSliderById( $id );
	 		$slider['title'] = 'Copy Of ' . $slider['title'];
	 		$slider['id'] = 0;
	 		$id = $model->saveData( $slider );

	 		$url = $this->url->link('module/pavsliderlayer/layer', 'id='.$id.'&group_id='.$slider['group_id'].'&token=' . $this->session->data['token'], 'SSL');
	 		$this->redirect( $url );
	 	}
	 	die("Having Error");
	}
 	
 	public function import(){
 		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			die( $this->language->get('error_permission') ); 
		}
 		$this->preload();
		$done = 0;
 		if( isset($_FILES['import_file']['name']) ){
 			$path = $_FILES['import_file']['tmp_name'];

 			$content = trim(file_get_contents( $path ));

 			$data = unserialize( $content );
 		 
 			if( is_object($data) && isset($data->group) && isset($data->sliders) ){
 		 
 				$id = $this->model_pavsliderlayer_slider->saveSliderGroupData( $data->group );
 				if( $id ) {
 					foreach( $data->sliders as $slider ){
 						$slider['id'] = 0;
 						$slider['group_id'] = $id;
 						$this->model_pavsliderlayer_slider->saveData( $slider );
 					}
 				} 
				$done = 1;	
 			}
 		}
 		 
 		
 		$url = $this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'].'&msg_idone='.$done, 'SSL');
	 	$this->redirect( $url );

 	}
 	public function export(){
 		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			die( $this->language->get('error_permission') ); 
		}
 		$this->preload();

 		if( isset($this->request->get['id']) ){
 			$id = (int) $this->request->get['id'];
 			$sliderGroup = $this->model_pavsliderlayer_slider->getSliderGroupById( $id );
 			$sliderGroup['id'] = 0;
 			$sliderGroup['params'] = serialize( $sliderGroup['params'] );
 			$export = new stdClass();
 			$export->group = $sliderGroup; 
 			$export->sliders = $this->model_pavsliderlayer_slider->getSlidersByGroupId( $id );

 			header("Content-Type: plain/text");
			header("Content-Disposition: Attachment; filename=export_group_".time().".txt");
			header("Pragma: no-cache");

			echo  serialize($export); 
 		}
 	}
 	public function deleteslider(){
 		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			$group_id = 0; 
		}else {
	 		$this->preload();
			if( isset($this->request->get['id']) ){ 
				$this->model_pavsliderlayer_slider->deleteslider( (int)($this->request->get['id']) );
			}
			$group_id = $this->request->get['group_id'];
		}
		
		$url = $this->url->link('module/pavsliderlayer/layer', 'group_id='.$group_id.'&token=' . $this->session->data['token'], 'SSL');
	 	$this->redirect( $url );
 	}


	public function savedata () {
		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->language->get('error_permission') );
		}
		$this->preload();
	 	
	 	$output = new stdClass();
	 	$output->id =	0;
	 	$output->error = 1;
	 	$output->message = $this->language->get('text_could_not_save');
	 	$model = $this->model_pavsliderlayer_slider; 
	 // 	echo '<pre>' . print_r( $this->request->post, 1 ) ; die;
	  	if( empty($this->request->post['slider_title']) ){
	  		$output->message = $this->language->get('error_missing_title');	
	  		echo json_encode( $output );exit();
	  	}
	  	if( $this->request->post ){

	  		$layersparams = new stdClass();
	  		$layersparams->layers = array();
	  		$params = serialize( $this->request->post );

			if( isset($this->request->post['layers'])  && !empty($this->request->post['layers']) ){
					
				$layersparams = new stdClass();
				$times 		 	= $this->request->post['layer_time'];
				$tmp 			= $this->request->post['layers'];	
				


				$layers = $this->request->post['layers'];

				foreach (  $layers as $key => $value ) {
						$value['time_start'] = $times[$value['layer_id']];
					 	$times[$value['layer_id']] = $value;
				}

				$k = 0;
				foreach( $times as $key => $value ) {
					if( is_array($times) ) {
						$value['layer_id'] = $k+1;
						$layersparams->layers[$k] = $value;
						$k++;
					}
				}
			
				unset( $this->request->post['layer_time'] );
				unset( $this->request->post['layers'] );


				$params = serialize( $this->request->post ); 
			}

			$data = array(
				'layersparams' => serialize($layersparams),
				'group_id'     => $this->request->post['slider_group_id'],
				'title'   	   => $this->request->post['slider_title'],
				'id'		   => $this->request->post['slider_id'],
				'image'        => $this->request->post['slider_image'],
				'params'	   =>  $params,	
				'status'       => $this->request->post['slider_status']
			);
		  
			$id = $model->saveData( $data );
		 	$output->id     = $id;
		 	$output->error  = 0;
		}
 		echo json_encode( $output );exit();
	}

	/**
	 * Delete 
	 */
	public function delete(){
		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}else {
			$this->preload();
			if( isset($this->request->get['id']) ){ 
				$this->model_pavsliderlayer_slider->delete( (int)($this->request->get['id']) );
			}
		}
		$this->redirect($this->url->link('module/pavsliderlayer', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function preview () {	
		$this->preload();
		
		if( isset($this->request->get['id']) ){
			$this->template = 'module/sliderlayer/previewgroup.tpl';
			$sliderGroup = $this->model_pavsliderlayer_slider->getSliderGroupById( (int)$this->request->get['id'] );
			$this->data['sliderParams'] = $sliderGroup['params'];
			$sliders =  $this->model_pavsliderlayer_slider->getSlidersByGroupId( (int)$this->request->get['id'] );

			foreach( $sliders as $key=> $slider ){
				$slider["layers"] = array();
				$slider['params'] = unserialize( $slider["params"] ); 
				$slider['layersparams'] = unserialize( $slider["layersparams"] ); 
				
				if( $sliderGroup['params']['image_cropping']) { 
					 $slider['main_image'] = $this->model_pavsliderlayer_slider->resize($slider['image'], $sliderGroup['params']['width'], 
					 								$sliderGroup['params']['height'],'a');
				}else { 
					 $slider['main_image'] = HTTP_CATALOG."image/".$slider['image'];
				}	
				
				if( $slider['params']['slider_thumbnail'] ) {
					$slider['thumbnail'] = $this->model_pavsliderlayer_slider->resize( $slider['params']['slider_thumbnail'], $sliderGroup['params']['thumbnail_width'], 
					 								$sliderGroup['params']['thumbnail_height'],'a'); 
				}else {
					$slider['thumbnail'] = $this->model_pavsliderlayer_slider->resize($slider['image'], $sliderGroup['params']['thumbnail_width'], 
					 								$sliderGroup['params']['thumbnail_height'],'a'); 
				}
				// echo '<pre>'.print_r( $slider,1 ); die;

				$sliders[$key] = $slider;
			} 
 
			$this->data['sliders'] = $sliders; 

			 $this->template = 'module/sliderlayer/previewgroup.tpl';
		}else { 
		  	if( !isset($this->request->post['slider_preview_data']) ){
		  		die( $this->language->get('text_could_not_show_preview') );
		  	}
			$a =  trim( html_entity_decode($this->request->post['slider_preview_data']) ) ;  
			$a= json_decode( $a );

			// 	echo '<pre>'.print_r( $a ,1 );y
			$sliderGroup = $this->model_pavsliderlayer_slider->getSliderGroupById( $a->params->slider_group_id);

			$this->data['sliderParams'] = $sliderGroup['params'];
		 
			$this->data['slider'] = $a;
	 		$this->template = 'module/sliderlayer/preview.tpl';
 		}
		$this->response->setOutput($this->render());
	}


	public function typo(){

		if (isset($this->request->get['field'])) {
			$this->data['field'] = $this->request->get['field'];
		} else {
			$this->data['field'] = '';
		}
 
	 
	 	$typoFile = 	HTTP_CATALOG."catalog/view/theme/default/stylesheet/sliderlayer/css/typo.css";	
		if( file_exists( DIR_CATALOG ."view/theme/". $this->config->get('config_template')."/stylesheet/sliderlayer/css/typo.css" ) ){
			$typoFile = 	HTTP_CATALOG."catalog/view/theme/". $this->config->get('config_template')."/stylesheet/sliderlayer/css/typo.css";	
		}
		$content = file_get_contents(  $typoFile );

		$this->data['typoFile'] = $typoFile; 
		$data = preg_match_all("#\.tp-caption\.(\w+)\s*{\s*#", $content, $matches);
	
	
		$this->data['captions'] = array();

		if( isset($matches[1]) ){
			$this->data['captions']  = $matches[1];
		}  	

		$this->template = 'module/sliderlayer/typo.tpl';
		$this->response->setOutput($this->render());
	}
	protected function validateSliderGroup() {

		if (!$this->user->hasPermission('modify', 'module/pavsliderlayer')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		 
		if( !isset($this->request->post['slider']) ){
			$this->error['warning'] = $this->language->get('error_missing_slider_data');
		}elseif(  $this->request->post['slider'] && empty($this->request->post['slider']['title']) ){
			$this->error['warning'] = $this->language->get('error_missing_slider_title');
		}				

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>