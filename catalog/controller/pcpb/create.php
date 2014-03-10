<?php 
class ControllerPcpbCreate extends Controller {
	private $error = array(); 
     
  	public function index() {
		$rand = $this->genRndNum(3);
		$token = time() . $rand;
		$productId = $this->request->get['product_id'];
		$this->redirect($this->url->link('pcpb/create/step1', 'token=' . $token . '&product_id=' . $productId, 'SSL'));
  	}
	
	private function genRndNum($iLength = 8)
	{
		$sPassword = '';
		$sChars = "12345678901234567890";
		srand((double)microtime()*1000000);
		for($i = 0; $i < $iLength; $i++) {
			$x = mt_rand(0, strlen($sChars) -1);
			$sPassword .= $sChars{$x};
		}
		return $sPassword;
	}

	public function phpinfo(){
		phpinfo();
	}
	
	public function step1(){

		$this->language->load('module/pcpb');
		
    	$this->data['text_cancel_and_close'] = $this->language->get('text_cancel_and_close');
    	$this->data['text_next'] = $this->language->get('text_next');
    	$this->data['text_select_background'] = $this->language->get('text_select_background');

		$this->load->model('setting/setting');
		$settings = $this->model_setting_setting->getSetting('pcpb');
		$backgroundOptionId = isset($settings['pcpb_option_background']) ? $settings['pcpb_option_background'] : null;

		$this->load->model('pcpb/pcpb');
		$options = $this->model_pcpb_pcpb->getProductOptions($this->request->get['product_id']);

		$backgroundOptions = array();
		foreach ($options as $option) {
			if($option['option_id'] == $backgroundOptionId)
			{
				$backgroundOptions = $option['option_value'];
				break;
			}
		}

		foreach ($backgroundOptions as $backgroundOption) {
			$size = @getimagesize(DIR_IMAGE . $backgroundOption['image']);
			
			$this->data['images'][] = array(
				'popup' => HTTP_SERVER . 'image/' . $backgroundOption['image'],
				'thumb' => HTTP_SERVER . 'image/' . $backgroundOption['image'],
				'name' 	=> $backgroundOption['name'],
				'points' => $backgroundOption['points'],
				'price' => floatval($backgroundOption['price']),
				'width' => $size[0],
				'height'=> $size[1],
				'product_option_value_id' => $backgroundOption['product_option_value_id']
			);
		}

		//$this->echoDbg($backgroundOptions);exit();

		$this->template = 'default/template/pcpb/step1.tpl';
		$error = isset($this->request->get['error']) ? $this->request->get['error'] : null;
		if($error)
			$this->data['error'] = $error;
		//$this->data['pcpb_token'] = $this->request->get['token'];
		$this->data['sizes'] = array(
			'600x480' => '600 x 480' ,
			'800x600' => '800 x 600 (+$100)' ,
			'1024x800' => '1024 x 800 (+$200)' 
		);
		$this->data['product_id'] = $this->request->get['product_id'];
		$this->response->setOutput($this->render());
	}
	
	public function selectImage(){
		$this->language->load('module/pcpb');
		
    	$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');
    	$this->data['text_Select'] = $this->language->get('text_Select');
    	$this->data['text_cancel_and_close'] = $this->language->get('text_cancel_and_close');
    	//$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');
    	//$this->data['text_Present_Images'] = $this->language->get('text_Present_Images');

		$presentOptionId = $this->config->get('pcpb_option_preset');

		$this->load->model('pcpb/pcpb');
		$options = $this->model_pcpb_pcpb->getProductOptions($this->request->get['product_id']);

		$presentOptions = array();
		foreach ($options as $option) {
			if($option['option_id'] == $presentOptionId)
			{
				$presentOptions = $option['option_value'];
				break;
			}
		}

		/*function echoDbg( $what, $desc = '' )
		{
			if ( $desc )
				echo "<b>$desc:</b> ";
			echo "<pre>";
				print_r( $what );
			echo "</pre>\n";
		}

		echoDbg($presentOptions);exit();*/

		foreach ($presentOptions as $presentOption) {
			$imagePath = HTTP_SERVER . 'image/' . $presentOption['image'];
			$size = getimagesize($imagePath);
			$this->data['images'][] = array(
				'popup' => $imagePath,
				'thumb' => $imagePath,
				'width' => $size[0],
				'height' => $size[1],
				'name' => $presentOption['name'],
				'price' => floatval($presentOption['price']),
				'image_option_id' => $presentOption['product_option_value_id']
			);
		}

		$this->template = 'default/template/pcpb/selectImage.tpl';
		$this->response->setOutput($this->render());
	}
	
	public function step2(){
		$this->language->load('module/pcpb');
		
    	$this->data['text_edit'] = $this->language->get('text_edit');
    	$this->data['text_copy'] = $this->language->get('text_copy');
    	$this->data['text_delete'] = $this->language->get('text_delete');
    	$this->data['text_edit_text'] = $this->language->get('text_edit_text');
    	$this->data['text_Edit_Background'] = $this->language->get('text_Edit_Background');
    	$this->data['text_content'] = $this->language->get('text_content');
    	$this->data['text_Font'] = $this->language->get('text_Font');
    	$this->data['text_Font_size'] = $this->language->get('text_Font_size');
    	$this->data['text_Color'] = $this->language->get('text_Color');
    	$this->data['text_Edit_Image'] = $this->language->get('text_Edit_Image');
    	$this->data['text_Upload'] = $this->language->get('text_Upload');
    	$this->data['text_Select_from_list'] = $this->language->get('text_Select_from_list');
    	$this->data['text_Flip'] = $this->language->get('text_Flip');
    	$this->data['text_Horizontal'] = $this->language->get('text_Horizontal');
    	$this->data['text_Vertical'] = $this->language->get('text_Vertical');
    	$this->data['text_cancel_and_close'] = $this->language->get('text_cancel_and_close');
    	$this->data['text_Back'] = $this->language->get('text_Back');
    	$this->data['text_Custom_your_product'] = $this->language->get('text_Custom_your_product');
    	$this->data['text_Add_Text'] = $this->language->get('text_Add_Text');
    	$this->data['text_Add_Image'] = $this->language->get('text_Add_Image');
    	$this->data['text_Change_Background'] = $this->language->get('text_Change_Background');
    	$this->data['text_Reset_Background'] = $this->language->get('text_Reset_Background');
    	$this->data['text_Finish'] = $this->language->get('text_Finish');
    	$this->data['text_All_text_image_cleared'] = $this->language->get('text_All_text_image_cleared');
    	$this->data['text_All_text_image_converted'] = $this->language->get('text_All_text_image_converted');
    	$this->data['text_Dimension_required'] = $this->language->get('text_Dimension_required');

		$token = isset($this->request->post['token']) ? $this->request->post['token'] : null;
		$size = isset($this->request->post['size']) ? $this->request->post['size'] : null;
		$product_id = isset($this->request->post['product_id']) ? $this->request->post['product_id'] : null;
		$link = isset($this->request->post['link']) ? $this->request->post['link'] : '';
		$product_option_value_id = isset($this->request->post['product_option_value_id']) ? $this->request->post['product_option_value_id'] : '';
		$product_option_price = isset($this->request->post['product_option_price']) ? $this->request->post['product_option_price'] : '';
		
		$this->load->model('pcpb/pcpb');
		//$token = isset($this->request->post['link']) ? $this->request->post['link'] : time();
		if($this->model_pcpb_pcpb->getDataByToken($token)){
			$this->redirect($this->url->link('pcpb/create/step1', 'token=' . $token . '&product_id=' . $product_id . '&error=token existed', 'SSL'));
		}
        
		$this->load->model('setting/setting');
        $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
        
        foreach ($list_fonts_google as $key=>$name){
            $this->data['list_link_google_fonts_options'][] = array(
                'key'     =>      $key,
                'pcpb_fonts_google'     =>      $name
            );    
        }
        		
        $this->data['pcpb_enable'] = ($this->config->get('pcpb_enable') == 1) ? true : false;
        
        $background = isset($this->request->post['background']) ? $this->request->post['background'] : null;
		
		if(!$size || !$product_id)
			die('error');
		$wh = explode('x', $size);
		$width = $wh[0];
		$height = $wh[1];
		
		$this->template = 'default/template/pcpb/step2.tpl';
		$this->data['width'] = $width;
		$this->data['height'] = $height;
		$this->data['product_id'] = $product_id;
		$this->data['link'] = $link;
		$this->data['product_option_value_id'] = $product_option_value_id;
		$this->data['product_option_price'] = $product_option_price;
		
		if($background)
			$this->data['background'] = $background;

		$this->load->model('pcpb/pcpb');
		$settings = $this->model_pcpb_pcpb->getProductPcpbOptions($product_id);
		//$this->echoDbg($settings);exit();
		$this->data['add_text_enable'] = $settings['add_text'];
		$this->data['add_images_enable'] = $settings['add_images'];
		$this->data['change_bg_enable'] = $settings['upload_background'];

		$this->response->setOutput($this->render());
	}
	
	public function step3(){
		if(isset($this->request->post['imageData'])){
			$imageData = isset($this->session->data['imageData']) ? $this->session->data['imageData'] : '';
			$imageData .= $this->request->post['imageData'];

			$imageIndex = $this->request->post['imageIndex'];
			$imageCount = $this->request->post['imageCount'];
			if($imageIndex < $imageCount){
				$this->session->data['imageData'] = $imageData;
				$res = array(
					'errorCode' => 0
				);
				echo (json_encode($res));
				exit();
			}

			unset($this->session->data['imageData']);

			//$imageData = $this->request->post['imageData'];
			$filteredData=substr($imageData, strpos($imageData, ",")+1);
			$unencodedData=base64_decode($filteredData);
			$fileName = time() . '.png';
			
			$mainDir = $this->config->get('pcpb_path_folder_save_temprarily');
			if(!$mainDir || $mainDir == '' || !is_writable(DIR_IMAGE . $mainDir))
				$mainDir = 'pcpb/temp/';
			
			$imagePath = DIR_IMAGE . $mainDir . $fileName;
			$fp = fopen($imagePath , 'wb');
			fwrite($fp, $unencodedData);
			fclose($fp);
			
			$token = time();
			$content = HTTP_SERVER . 'image/' . $mainDir . $fileName;
			$this->load->model('pcpb/pcpb');
			$id = $this->model_pcpb_pcpb->insertImage($token, $content);
			
			if($id > 0){
				$res = array(
					'errorCode' => 0,
					'token' => $token
				);
				echo (json_encode($res));
				exit();
			}
		}
		$res = array(
			'errorCode' => 1,
			'errorMessage' => 'save fail'
		);
		echo (json_encode($res));
		exit();
		
	}
	
	public function finish(){
		$this->template = 'default/template/pcpb/finish.tpl';
		$token = isset($this->request->get['token'])?$this->request->get['token']:null;
		$product_id = isset($this->request->get['product_id'])?$this->request->get['product_id']:null;
		$product_option_value_id = isset($this->request->get['product_option_value_id'])?$this->request->get['product_option_value_id']:null;
		$image_option_id = isset($this->request->get['image_option_id'])?$this->request->get['image_option_id']:null;
		$product_option_price = isset($this->request->get['product_option_price'])?$this->request->get['product_option_price']:null;
		if(!$token || !$product_id)
			die('no token found');
			
		$this->load->model('pcpb/pcpb');
		$data = $this->model_pcpb_pcpb->getDataByToken($token);
		$this->data['image_link'] = $data['content'];
		$this->data['view_link'] = $this->url->link('pcpb/view', 'token=' . $token, 'SSL');
		$this->data['product_option_value_id'] = $product_option_value_id;
		$this->data['image_option_id'] = $image_option_id;
		$this->data['product_option_price'] = $product_option_price;

		$this->load->model('catalog/product');
		
		$product_info = $this->model_catalog_product->getProduct($product_id);

		$product_price = floatval($product_info['special']) > 0 ?  $product_info['special']: $product_info['price'];
		$product_price = floatval($product_price) + floatval($product_option_price);
		$this->data['total_price'] = $this->currency->format($this->tax->calculate($product_price, $product_info['tax_class_id'], $this->config->get('config_tax')));

		if (!$this->session->data['pcpb'])
			$this->session->data['pcpb'] = array();
		$this->session->data['pcpb'][$product_id] = array(
			'url' => $this->url->link('pcpb/view', 'token=' . $token, 'SSL'),
			'product_option_value_id' => $product_option_value_id,
			'image_option_id' => $image_option_id,
			'token' => $token,
			'product_option_price' => $product_option_price,
			'total_price' => $this->data['total_price']

		);
		$this->response->setOutput($this->render());
	}
	
	function echoDbg( $what, $desc = '' )
	{
		if ( $desc )
			echo "<b>$desc:</b> ";
		echo "<pre>";
			print_r( $what );
		echo "</pre>\n";
	}
}
?>