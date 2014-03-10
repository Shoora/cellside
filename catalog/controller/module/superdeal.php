<?php
class ControllerModuleSuperDeal extends Controller {
    protected function index($setting) {
        static $module = 0;
        $this->language->load('module/superdeal'); 
        

        $this->document->addScript('catalog/view/javascript/jquery.countdown.js');
        $this->document->addStyle('catalog/view/theme/default/stylesheet/superdeal.css');

        $this->data['heading_title'] = $this->language->get('heading_title'); 
        $this->data['buynow'] = $this->language->get('text_buynow');
        $this->data['yousave'] = $this->language->get('text_yousave'); 
        $this->data['percentsave'] = $this->language->get('text_percentsave'); 
        $this->data['price'] = $this->language->get('text_price'); 
        $this->data['itemleft'] = $this->language->get('text_itemleft'); 
        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->load->model('catalog/product'); 
        $this->load->model('tool/image');
        $this->data['products'] = array();
        $this->data['superdeal_yousavebutton'] = $this->config->get('superdeal_yousavebutton');
        $this->data['superdeal_itemleftbutton'] = $this->config->get('superdeal_itemleftbutton');
        $this->data['superdeal_pricesavebutton'] = $this->config->get('superdeal_pricesavebutton');
        $this->data['superdeal_percentsavebutton'] = $this->config->get('superdeal_percentsavebutton');
        $this->data['superdeal_buynowbutton'] = $this->config->get('superdeal_buynowbutton');
		
		$this->data['superdeal_buttonsize'] = $this->config->get('superdeal_buttonsize');
		$showas = $this->data['superdeal_showas'] = $this->config->get('superdeal_showas');
		$this->data['superdeal_slideeffect'] = $this->config->get('superdeal_slideeffect');
		$this->data['superdeal_titlesize'] = $this->config->get('superdeal_titlesize');
		$countdesc = $this->config->get('superdeal_countdesc');
		$counttype = $this->config->get('superdeal_counttype');
		$this->data['modulestyle'] = 'width:'.$this->config->get('superdeal_width').'px;'.'min-height:'.$this->config->get('superdeal_height').'px;';
		$this->data['boxheight'] = 'height:'.$this->config->get('superdeal_height') - 20 .'px;';
		$this->data['fontsize'] = "font-size:".$this->config->get('superdeal_producttextsize').'px;';
		$this->data['module_heading'] = $this->config->get('module_heading');

		
		if ($showas == 'slide'){
			$this->document->addScript('catalog/view/javascript/jquery.cycle.all.min.js');
		}
        
        
        //$module =   $this->config->get('superdeal_module');

        $products = explode(',', $this->config->get('superdeal_product'));     

        foreach ($products as $product_id) {
            $product_info = $this->model_catalog_product->getProduct($product_id);
            
            $oRow = $this->db->query("SELECT* FROM " . DB_PREFIX . "product_special WHERE product_id = ".$product_id);
            
            foreach ($oRow->rows as $row  ){
               $date_start = $row['date_start']; 
               $date_end = $row['date_end'];
               
            }
            //echo "<pre>"; var_dump($product_info); echo "</pre>";
            
            
            if ($product_info) {
                if ($product_info['image']) {
                    $image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
                } else {
                    $image = false;
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }
                        
                if ((float)$product_info['special']) {
                    $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }
                
                if ((float)$product_info['special']) {
                    $yousave= $this->currency->format($this->tax->calculate($product_info['price'] - $product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $yousave = false;
                }
                
                if ($this->config->get('config_review_status')) {
                    $rating = $product_info['rating'];
                } else {
                    $rating = false;
                }
                
                $timeleft = strtotime($date_end) - strtotime(date('Y-m-d'));
				
                if ($timeleft > 0){
                    $day = explode('-', $date_end);
                    $yleft  = $day[0];
                    $mleft  = $day[1];
                    $dleft  = $day[2];
              
                }
                else {
                    $yleft  = 0;
                    $mleft  = 0;
                    $dleft  = 0;    
                }
				
				
				
                if ($counttype == 'words'){
					$description = explode(' ',strip_tags(htmlspecialchars_decode($product_info['description'])));               
	                $strDesc = array();
	                if($countdesc>0){
	                    $totalword = $countdesc;
	                }else{
	                    $totalword = count($description);
	                }
	                
	                for($i = 0 ; $i<$totalword; $i++){
	                    if ($description[$i] != ""){
	                      $strDesc[]= $description[$i]   ;  
	                    }
	                   
	                }
	                $desc = implode(' ', $strDesc);
				}else{
					$description = strip_tags(htmlspecialchars_decode($product_info['description']));
					$desc = substr($description,0,$countdesc);
				}
                
                   
                $this->data['products'][] = array(
                    'product_id'    => $product_info['product_id'],
                    'thumb'         => $image,
                    'name'          => $product_info['name'],
                    'description'   => $desc,
                    'price'         => $price,
                    'special'       => $special,
                    'rating'        => $rating,
                    'reviews'       => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
                    'href'          => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
                    'date_start'    => $date_start,
                    'date_end'      => $date_end,
                    'percentsave'   => ceil(((($product_info['price']- $product_info['special'])/$product_info['price'])*100)).'%',
                    'yousave'       => $yousave,
                    'yleft'         => $yleft,
                    'mleft'         => $mleft,
                    'dleft'         => $dleft,
                    'hleft'         => 24 - date('H'), 
                    'mileft'        => 60-date('i'),
                    'sleft'         => rand(0,60),
                    'timeleft'      => $timeleft,
                    'quantity'      => $product_info['quantity'],
                );
                
            }
        }
        
        $this->data['module'] = $module++;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/superdeal.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/superdeal.tpl';
        } else {
            $this->template = 'default/template/module/superdeal.tpl';
        }

        $this->render();
    }
	protected function date_diff($end)
	{	
		$endtime = strtotime($end);
	
		$today = time () ;
		$difference =($endtime-$today) ;
		
		$days =(int) ($difference/86400) ;
		
		return $days;   
	}


}
//ALTER TABLE `product_special` CHANGE `date_start` `date_start` DATETIME NOT NULL DEFAULT '0000-00-00',
//CHANGE `date_end` `date_end` DATETIME NOT NULL DEFAULT '0000-00-00'
?>
