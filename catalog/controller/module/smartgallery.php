<?php class ControllerModuleSmartGallery extends Controller { private $gallery='';private function getGallery($id){ if($this->gallery !='') return $this->gallery;$this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$gallery=array();foreach($SG_data['galleries'] as $SG_gallery){ if($SG_gallery['main']['id']==$id) $gallery=$SG_gallery;} $gallery['data']['name_page'] =$this->getNamePage();$gallery['data']['category_name'] ='';$gallery['data']['selector_page'] ='';$gallery['data']['attr_page'] ='';$gallery['data']['patterns'] =HTTP_SERVER.'catalog/view/theme/default/stylesheet/smartgallery/images/patterns/';$gallery['data']['pagination_text'] ='';$gallery['data']['galery_title'] ='';$gallery['load_from_id_path'] ='';$gallery=array_merge_recursive ($gallery,$SG_data['global_setting']);$this->gallery=$gallery;return $gallery;} private function setToCashBottomCategory(){ $query=$this->db->query("SELECT * FROM ".DB_PREFIX."category WHERE status = '1';");$results=$query->rows;$bottomCategory=array();foreach ($results as $result_1) { $hasChild=false;foreach ($results as $result_2) { if($result_1['category_id']==$result_2['parent_id']){ $hasChild=true;break;} } if (!$hasChild) $bottomCategory[]=$result_1['category_id'];} $this->cache->set('SG.bottomCategory',$bottomCategory);} private function isBottomCategory(){ $bottomCategory=$this->cache->get('SG.bottomCategory');if(!isset($bottomCategory) OR !count($bottomCategory)){ $this->setToCashBottomCategory();$bottomCategory=$this->cache->get('SG.bottomCategory');if(!isset($bottomCategory) OR !count($bottomCategory))return;} if (isset($this->request->get['path'])) { $path='';$parts=explode('_',(string)$this->request->get['path']);$category_id=array_pop($parts);} else { $category_id=0;} if (in_array($category_id,$bottomCategory)) return true;return false;} protected function index($setting) { $this->language->load('module/smartgallery');if($this->getNamePage()=='category' AND $setting['bottom_cat'] AND !$this->isBottomCategory()) return;$this->getGallery($setting['gallery_id']);$this->document->addScript( 'catalog/view/javascript/smartgallery/jquery.mobile.customized.min.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/jquery.easing.1.3.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/sg-gallery.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/jquery.tipsy.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/jquery.preload.min.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/zoom.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/jquery.blockUI.js' );$this->document->addScript( 'catalog/view/javascript/smartgallery/engine-gallery.js' );$this->document->addStyle( 'catalog/view/theme/default/stylesheet/smartgallery/style.css' );$this->data['token']=isset($this->session->data['token']) ? $this->session->data['token']:'';$this->setAutoField();$this->setPaginationText();$this->setGalleryTitle();$this->setHEGToRGBA();$this->data['dir_template'] =DIR_TEMPLATE;$this->data['setting'] =$this->getGallery($setting['gallery_id']);$this->data['gallery_id'] =$setting['gallery_id'];if($this->gallery['behavior']['load_content'] !='SG_from_page'){ $parts =isset($this->request->get['path']) ? $this->request->get['path']:'';$pack =isset($this->request->get['page']) ? $this->request->get['page']:'';$products_id=isset($this->request->get['product_id']) ? (int)$this->request->get['product_id']:0;$products=$this->getproduct($setting['gallery_id'],$this->gallery['behavior']['load_content'],$data=array('parts'=>$parts,'pack'=>$pack,'products_id'=>$products_id));$this->data['htmlStructura'] =$this->GetHtmlStructure($products);$this->data['products']=$products;}else{ $this->data['htmlStructura']='';$this->data['products']='';} if (file_exists(DIR_TEMPLATE.$this->config->get('config_template').'/template/module/smartgallery.tpl')) { $this->template=$this->config->get('config_template').'/template/module/smartgallery.tpl';} else { $this->template='default/template/module/smartgallery.tpl';} $this->render();} private function GetHtmlStructure($products){ $htmlStructure='';$addMainThumb=false;foreach($products['products'] as $key=> $product){ if($product['thumb']){ $description='';$description.=$this->getInfoButtonBlock($product);if($this->gallery['product']['description']){ $description.='<span style="clear:both;">'.$product['description'].'</span>';$description.='<div class="camera_caption fadeFromBottom" >'.$description.'</div>';}else{ $description.='<div class="without_description camera_caption fadeFromBottom" >'.$description.'</div>';} if($this->gallery['data']['name_page'] !='product'){ $htmlStructure.='<div data-id="'. $product['product_id'] .'" data-thumb="'. $product['thumb'] .'" data-src="'. $product['image'] .'" >'.$description.'</div>';}else{ if($product['thumb'] AND !$addMainThumb ){ $htmlStructure.='<div data-thumb="'. $product['thumb'] .'" data-src="'. $product['image'] .'" >  </div>';$addMainThumb=true;} if($product['images']){ foreach($product['images'] as $image){ $htmlStructure.='<div data-thumb="'. $image['thumb'] .'" data-src="'. $image['image'] .'" >  </div>';} } } } } return $htmlStructure;} private function getInfoButtonBlock($product){ $infoButtonBlock='';if($this->gallery['product']['button']['add_to_cart'] OR $this->gallery['product']['button']['add_to_wish_list'] OR $this->gallery['product']['button']['add_to_compare'] OR $this->gallery['product']['button']['see_full_details'] OR $this->gallery['product']['price'] OR $this->gallery['product']['name']){ $SG_style='';if($this->gallery['product']['name'] AND $this->gallery['product']['description']) $SG_style='style="margin-top: -53px;"';$infoButtonBlock.='<span '.$SG_style.' class="SG_button_box">';if($this->gallery['product']['name']) $infoButtonBlock.='<span class="prod_button sg_name">'.$product['name'].'</span><br>';if($this->gallery['product']['button']['add_to_cart']) $infoButtonBlock.='<a original-title="Add to Cart" class="prod_button sg_butt_to_cart"  onclick="if(!$(\'.prod_button\').hasClass(\'button_loader\'))addToCart(\''. $product['product_id'] .'\');return false;" ><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>';if($this->gallery['product']['button']['add_to_wish_list']) $infoButtonBlock.='<a original-title="Add to Wish List" class="prod_button sg_butt_to_wish" onclick="if(!$(\'.prod_button\').hasClass(\'button_loader\'))addToWishList(\''. $product['product_id'] .'\');"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>';if($this->gallery['product']['button']['add_to_compare']) $infoButtonBlock.='<a original-title="Add to Compare" class="prod_button sg_butt_to_compare" onclick="if(!$(\'.prod_button\').hasClass(\'button_loader\'))addToCompare(\''. $product['product_id'] .'\');"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>';if($this->gallery['product']['button']['see_full_details']) $infoButtonBlock.='<a class="prod_button" href="'. $product['href'] .'" ><span>View Item</span></a>';if($this->gallery['product']['price']){ if($product['special']){ $price='<span style="cursor:auto; margin: 0 -10px;"><span style=" position:relative; font-size:80%; right:-20px; bottom:-7px; text-decoration: line-through;">'.$product['price'].'</span>';$price.='<span style="font-weight:bold; position:relative; left:-20px; top:-7px; color: '. $this->gallery['product']['color_special_price'] .';">'.$product['special'].'</span></span>';}else{ $price='<span style="cursor:auto;font-weight:bold;">'.$product['price'].'</span>';} $infoButtonBlock.='<a class="prod_button">'.$price.'</a>';} $infoButtonBlock.='</span>';} return $infoButtonBlock;} private function setGalleryTitle(){ $title=$this->language->get('heading_'.$this->gallery['behavior']['load_content']);if($this->gallery['behavior']['title']){ $this->gallery['data']['galery_title']=sprintf($title,$this->getCategoryName());} $this->gallery['data']['mode_button_html']=sprintf($this->gallery['data']['mode_button_html'],sprintf($title,htmlspecialchars ($this->getCategoryName(),ENT_QUOTES)),$this->gallery['data']['mode_button_class']);} private function setAutoField(){ if($this->getNamePage()=='category'){ $this->gallery['data']['selector_page']=$this->gallery['data']['selector_category'];$this->gallery['data']['attr_page']=$this->gallery['data']['attr_category'];if($this->gallery['behavior']['load_content']=='SG_category_path'){ $this->gallery['load_from_id_path']=$this->request->get['path'];} $this->gallery['data']['category_name']=$this->getCategoryName();} if($this->getNamePage()=='product'){ $this->gallery['data']['selector_page']=$this->gallery['data']['selector_product'];$this->gallery['data']['attr_page']=$this->gallery['data']['attr_product'];} } private function setPaginationText(){ $text=array();if($this->gallery['behavior']['load_content']=='SG_from_page'){ $text['prev']=$this->language->get('prev_page_text');$text['next']=$this->language->get('next_page_text');}else { $text['prev']=sprintf($this->language->get('prev_pack_text'),(int)$this->gallery['behavior']['items_per_pack']);$text['next']=sprintf($this->language->get('next_pack_text'),(int)$this->gallery['behavior']['items_per_pack']);} $this->gallery['data']['pagination_text']=$text;} private function setHEGToRGBA(){ $this->gallery['product']['description_bg_color_RGBA']=$this->hex2rgb($this->gallery['product']['description_bg_color'],$this->gallery['product']['description_bg_opacity']);} private function getNamePage(){ $name_page='other';$path =isset($this->request->get['path']) ? $this->request->get['path']:'';$product_id=isset($this->request->get['product_id']) ? $this->request->get['product_id']:'';if($path=='' AND $product_id==''){ } if($path !='' AND $product_id==''){ $name_page='category';} if($path !='' AND $product_id !=''){ $name_page='product';} return $name_page;} private function getCategoryName(){ $this->load->model('catalog/category');if( isset($this->request->get['path'])){ $parts=explode('_',$this->request->get['path']);$category_id=(int)array_pop($parts);$category=$this->model_catalog_category->getCategory($category_id);$name=$category['name'];}else{ $name='';} return $name;} public function getproduct($gallery_id='',$load_content='',$data=array('parts'=>'','pack'=>'','products_id'=>'')){ $ajax=$gallery_id=='' ? true:false;if($ajax){ if($product=$this->cache->get('SG.index_product.'.(int)$this->config->get('config_store_id'))){ echo json_encode($product);$this->cache->delete('SG.index_product.'.(int)$this->config->get('config_store_id'));return;} } $gallery_id=$gallery_id !='' ? $gallery_id:$this->request->get['gallery_id'];if($gallery_id=='') {echo '';return;} $this->getGallery($gallery_id);$load_content=$load_content !='' ? $load_content:$this->request->post['load_content'];$products_id=$data['products_id'] !='' ? $data['products_id']:(isset($this->request->post['products_id']) ? $this->request->post['products_id']:'');$parts=$data['parts'] !='' ? $data['parts']:(isset($this->request->post['load_from_id_path']) ? $this->request->post['load_from_id_path']:'');$pack=$data['pack'] !='' ? $data['pack']:(isset($this->request->post['pack']) ? $this->request->post['pack']:'');$pack=$pack !='' ? $pack:1;$product=array();switch ($load_content) { case 'SG_all_products':$product=$this->getAllProducts($pack);break;case 'SG_from_page':if(isset( $this->request->post['only_images'])){ $product=$this->getProductImages($products_id);}else{ $product=$this->getProductsFromPage($products_id);} break;case 'SG_category_path':$product=$this->getProductsFromCategory($parts,$pack);break;case 'SG_best_seller':$product=$this->getBestSeller();break;case 'SG_popular_product':$product=$this->getPopularProduct();break;case 'SG_latest_product':$product=$this->getLatestProduct();break;case 'SG_product_id':$product=$this->getProductImages($products_id);break;} if($ajax){ echo json_encode($product);}else{ $this->cache->set('SG.index_product.'.(int)$this->config->get('config_store_id'),$product);return $product;} } private function hex2rgb($hex,$opacity) { $hex=str_replace("#","",$hex);if(strlen($hex)==3) { $r=hexdec(substr($hex,0,1).substr($hex,0,1));$g=hexdec(substr($hex,1,1).substr($hex,1,1));$b=hexdec(substr($hex,2,1).substr($hex,2,1));} else { $r=hexdec(substr($hex,0,2));$g=hexdec(substr($hex,2,2));$b=hexdec(substr($hex,4,2));} if(isset($opacity)){ $rgba=array($r,$g,$b,$opacity);$color='rgba('.implode(",",$rgba).')';}else{ $rgb=array($r,$g,$b);$color='rgb('.implode(",",$rgb).')';} return $color;} private function getAllProducts($pack){ $this->load->model('catalog/product');$limit=$this->gallery['behavior']['items_per_pack'];$search_data=array( 'start' => ($pack-1) * $limit,'limit' => $limit );$product_total=$this->model_catalog_product->getTotalProducts($search_data);$results=$this->model_catalog_product->getProducts($search_data);$data=$this->prepareAnswer($results);$data=array('products'=>$data,'products_total'=>$product_total);return $data;} private function getBestSeller(){ $this->load->model('catalog/product');$limit=$this->gallery['behavior']['limit'];$results=$this->model_catalog_product->getBestSellerProducts($limit);$data=$this->prepareAnswer($results);$product_total=count($data);$data=array('products'=>$data,'products_total'=>$product_total);return $data;} private function getPopularProduct(){ $this->load->model('catalog/product');$limit=$this->gallery['behavior']['limit'];$results=$this->model_catalog_product->getPopularProducts($limit);$data=$this->prepareAnswer($results);$product_total=count($data);$data=array('products'=>$data,'products_total'=>$product_total);return $data;} private function getLatestProduct(){ $this->load->model('catalog/product');$limit=$this->gallery['behavior']['limit'];$results=$this->model_catalog_product->getLatestProducts($limit);$data=$this->prepareAnswer($results);$product_total=count($data);$data=array('products'=>$data,'products_total'=>$product_total);return $data;} private function getProductImages($products_id){ $this->load->model('catalog/product');$product_data=array();foreach ($products_id as $product_id) { $product_data[$product_id]=$this->model_catalog_product->getProduct($product_id);} $data=array('products'=> $this->prepareAnswer($product_data,true));return $data;} private function getProductsFromCategory($parts,$pack){ $this->load->model('catalog/product');$parts=explode('_',(string)$parts);$category_id=(int)array_pop($parts);$limit=$this->gallery['behavior']['items_per_pack'];$search_data=array( 'filter_category_id'=> $category_id,'start' => ($pack-1) * $limit,'limit' => $limit );$id_cache=$category_id.'.'.($pack-1) * $limit.'.'.$limit;$data=$this->cache->get('SG.prod_from_category'.$id_cache.'.' .$this->config->get('config_language_id').'.'.(int)$this->config->get('config_store_id'));if (!$data) { $product_total=$this->model_catalog_product->getTotalProducts($search_data);$results=$this->model_catalog_product->getProducts($search_data);$data=$this->prepareAnswer($results);$data=array('products'=>$data,'products_total'=>$product_total);$this->cache->set('SG.prod_from_category'.$id_cache.'.' .$this->config->get('config_language_id').'.'.(int)$this->config->get('config_store_id'),$data);} return $data;} private function getProductsFromPage($products_id){ $this->load->model('catalog/product');$product_data=array();foreach ($products_id as $product_id) { $product_data[$product_id]=$this->model_catalog_product->getProduct($product_id);} $data=array('products'=> $this->prepareAnswer($product_data));return $data;} private function prepareAnswer($results,$add_images=false){ $this->load->model('tool/image');$data=array();$image='';$thumb='';foreach ($results as $result) { if ($result['image']) { $image=$this->model_tool_image->resize($result['image'],$this->gallery['image']['width'],$this->gallery['image']['height']);$thumb=$this->model_tool_image->resize($result['image'],$this->gallery['thumb']['width'],$this->gallery['thumb']['height']);if ($this->gallery['behavior']['zoom']){ $zoom_image=$this->model_tool_image->resize($result['image'],$this->gallery['zoom_image']['width'],$this->gallery['zoom_image']['height']);} } else { $thumb=false;} $images=array();$zoom_images='';if($this->gallery['product']['images'] OR $add_images){ $images_results=$this->model_catalog_product->getProductImages($result['product_id']);foreach ($images_results as $image_r) { $image_res=$this->model_tool_image->resize($image_r['image'],$this->gallery['image']['width'],$this->gallery['image']['height']);$thumb_res=$this->model_tool_image->resize($image_r['image'],$this->gallery['thumb']['width'],$this->gallery['thumb']['height']);if ($this->gallery['behavior']['zoom']){ $zoom_image_res=$this->model_tool_image->resize($image_r['image'],$this->gallery['zoom_image']['width'],$this->gallery['zoom_image']['height']);} $images[]=array('image'=> $image_res,'thumb'=> $thumb_res);} } if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) { $price=$this->currency->format($this->tax->calculate($result['price'],$result['tax_class_id'],$this->config->get('config_tax')));} else { $price=false;} if ((float)$result['special']) { $special=$this->currency->format($this->tax->calculate($result['special'],$result['tax_class_id'],$this->config->get('config_tax')));} else { $special=false;} if ($this->config->get('config_tax')) { $tax=$this->currency->format((float)$result['special'] ? $result['special']:$result['price']);} else { $tax=false;} if ($this->config->get('config_review_status')) { $rating=(int)$result['rating'];} else { $rating=false;} if($image !=null){ $product=array( 'product_id' => $result['product_id'],'thumb' => $thumb,'image' => $image,'name' => $result['name'],'price' => $price,'special' => $special,'description' => utf8_substr(strip_tags(html_entity_decode($result['description'],ENT_QUOTES,'UTF-8')),0,200).'..' );if (count($images)) { $product ['images']=$images;} if ($this->gallery['product']['button']['see_full_details']) { $product ['href'] = $this->url->link('product/product', 'product_id=' . $result['product_id']);} $data []=$product;} } return $data;} } ?>
