<?php define('SG_VER','1.2.3');class ControllerModuleSmartGalleryIndex extends Controller { protected $error=array();protected $success=array();protected function getDefaultOptions(){ require 'file/default_option.php';return array('default_options'=> $default_options,'global_setting'=> $global_setting,'default_galleryOnPage'=>$default_galleryOnPage);} protected function needUpdateVer(){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');if(isset($SG_data['sg_ver']) AND $SG_data['sg_ver']==SG_VER) return false;return true;} protected function updateVer(){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$defaultData=$this->getDefaultOptions();$this->load->model('design/layout');foreach($SG_data['galleries'] as $key=> $gallery){ $SG_data['galleries'][$key]=array_replace_recursive ($defaultData['default_options'],$SG_data['galleries'][$key]);} foreach($SG_data['smartgallery/index_module'] as $key=> $gallery_on_page){ $SG_data['smartgallery/index_module'][$key]=array_replace_recursive ($defaultData['default_galleryOnPage'],$SG_data['smartgallery/index_module'][$key]);} $defaultData['default_galleryOnPage']['layouts']=$this->model_design_layout->getLayouts();$SG_data['global_setting']=array_replace_recursive ($defaultData['global_setting'],$SG_data['global_setting']);$smartGallery=array( 'smartgallery/index_module'=> $SG_data['smartgallery/index_module'],'galleries' => $SG_data['galleries'],'default_options' => $defaultData['default_options'],'default_galleryOnPage' => $defaultData['default_galleryOnPage'],'global_setting' => $SG_data['global_setting'],'sg_ver' => SG_VER );$this->load->model('setting/setting');$this->model_setting_setting->editSetting('smartgallery/index',$smartGallery);} protected function setUpdateText(){ $header="<h3>Gallery update!</h3><h5>List of new function:</h5>";$footer="<i class=\"custom-icon-off\"></i>";$update_texts=array( '1.1.0'=>$header."<dt>Add ZOOM function</dt>\       <dd>Look here: \"Edit/New Gallery\" -> \"Main Setting\" -> \"Zoom image\"</dd>\      <dt>Added customization for button \"Quick View\"</dt>\       <dd>Look here: \"Global Setting\" -> \"Position for Button Quick View-specify where will be add it to container (first / last) \"</dd>\      <dt>Change Logic and Name for \"Crop\"</dt>\       <dd>Look here: \"Edit/New Gallery\" -> \"Size Setting\" -> \"Image resize\"</dd>".$footer,'1.1.1'=> $header."<dt>Add additional ZOOM setting </dt>\       <dd>Look here: \"Edit/New Gallery\" -> \"Main Setting\" -> \"Container for Zoom\"</dd>".$footer,'1.2.0'=> $header."<dt>Added field for enter title for Gallery</dt>\       <dd>Look here: \"Edit/New Gallery\" -> \"Main Setting\" -> \"Title of Gallery\"</dd>\      <dt>Added button for choose position for vertical slider</dt>\       <dd>Look here: \"Edit/New Gallery\" -> \"Product Setting\" -> \"Position for Vertical slider\"</dd>\      <dt>Changed behavior for Zoom function in Image container</dt>\       <dd>Now, Zoom image fills all area of Gallery</dd>".$footer,'1.2.1'=> $header."<dt>Added new field \"Show only Bottom Categories\"</dt>\       <dd>Look here: </dd>".$footer,'1.2.2'=> $header."<dt>Solved Bug</dt>\       <dd>with single quote in category Name</dd>".$footer, '1.2.3'=> $header."<dt>Changed</dt>\       <dd>CSS for support bootstrap; script for count total products for Gallery</dd>".$footer );if($this->needUpdateVer()){ $this->data['SG_VER_status']='true';$this->data['update_text']=$update_texts[SG_VER];}else{ $this->data['SG_VER_status']='false';$this->data['update_text']='';} } public function install() { $this->db->query('ALTER TABLE '.DB_PREFIX.'setting CHANGE value value MEDIUMTEXT');$defaultData=$this->getDefaultOptions();$this->load->model('design/layout');$defaultData['default_galleryOnPage']['layouts']=$this->model_design_layout->getLayouts();$smartGallery=array( 'smartgallery/index_module'=> array(),'galleries' => array(),'default_options' => $defaultData['default_options'],'default_galleryOnPage' => $defaultData['default_galleryOnPage'],'global_setting' => $defaultData['global_setting'],'sg_ver' => SG_VER );$this->load->model('setting/setting');$this->model_setting_setting->editSetting('smartgallery/index',$smartGallery);} public function uninstall(){ } public function index() { $this->data=$this->language->load('module/smartgallery/index');$this->document->setTitle($this->language->get('heading_title'));$this->setUpdateText();if($this->needUpdateVer()) $this->updateVer();$this->document->addScript( 'view/stylesheet/smartgallery/bootstrap/js/bootstrap.min.js' );$this->document->addStyle( 'view/stylesheet/smartgallery/bootstrap/css/bootstrap.min.css' );$this->document->addStyle( 'view/stylesheet/smartgallery/bootstrap/css/bootstrap-responsive.min.css' );$this->document->addScript( 'view/javascript/smartgallery/plugin/iphone-style-checkboxes.js' );$this->document->addScript( 'view/javascript/smartgallery/plugin/jscolor/jscolor.js' );$this->document->addScript( 'view/javascript/smartgallery/plugin/jquery.dd.min.js' );$this->document->addScript( 'view/javascript/smartgallery/plugin/jquery.knob.js' );$this->document->addScript( 'view/javascript/smartgallery/plugin/color_master/jquery.minicolors.js' );$this->document->addStyle( 'view/javascript/smartgallery/plugin/color_master/jquery.minicolors.css' );$this->document->addScript( 'view/javascript/smartgallery/plugin/block_ui.js' );$this->document->addScript( 'view/javascript/smartgallery/smartgallery.js' );$this->document->addScript( 'view/javascript/smartgallery/plugin/cookie_jq.js' );$this->document->addStyle( 'view/stylesheet/smartgallery/style.css' );if (isset($this->success['success'])) { $this->data['success']=$this->success['success'];} else if(isset($this->session->data['success'])) { $this->data['success']=$this->session->data['success'];unset ($this->session->data['success']);} else { $this->data['success']='';} if (isset($this->error['warning'])) { $this->data['error_warning']=$this->error['warning'];} else if(isset($this->session->data['error'])) { $this->data['error']=$this->session->data['error'];unset ($this->session->data['error']);}else { $this->data['error_warning']='';} $this->data['breadcrumbs']=$this->getBreadCrumbs();$this->load->model('setting/setting');$this->setData();$this->data['token']=$this->session->data['token'];$this->setURLs();$this->load->model('design/layout');$this->data['layouts']=$this->model_design_layout->getLayouts();$this->template='module/smartgallery/smartgallery.tpl';$this->children=array( 'common/header','common/footer' );$this->response->setOutput($this->render());} public function getgallery(){ $this->data=$this->language->load('module/smartgallery/index');$id=$this->request->post['id'];if(!$id){ $gallery=$this->getDefaultGallery();$overlays=$this->getOverlay('');$gallery['gallery']['background_image']=$overlays;$gallery['thumb']['background_image']=$overlays;$gallery['gallery']['header_bg_image']=$overlays;$gallery['gallery']['skin']=$this->getSkin('');}else{ $gallery=$this->getGallery_id($id);$gallery['gallery']['background_image']=$this->getOverlay($gallery['gallery']['background_image']);$gallery['thumb']['background_image']=$this->getOverlay($gallery['thumb']['background_image']);$gallery['gallery']['header_bg_image']=$this->getOverlay($gallery['gallery']['header_bg_image']);$gallery['gallery']['skin']=$this->getSkin($gallery['gallery']['skin']);} $this->data['options']=$gallery;$this->load->model('design/layout');$this->data['layouts']=$this->model_design_layout->getLayouts();$this->template='module/smartgallery/edit/index.tpl';$this->response->setOutput($this->render());} public function savegallery(){ $this->load->model('setting/setting');$data=$this->request->post['data'];$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');if($data['main']['id']==''){ $data['main']['id'] =$this->generateRandomString();$data['main']['date_c']=date("Y-m-d H:i:s",time());$data['main']['date_m']=date("Y-m-d H:i:s",time());$SG_data['galleries'][]=$this->changeToSave($data);$this->success['success']='Success: You have added New Gallery!';}else{ $gallery=$this->getGallery_id($data['main']['id'],true);$date_c=$gallery['main']['date_c'];$gallery=array_merge ($gallery,$data);$gallery['main']['date_c']=$date_c;$gallery['main']['date_m']=date("Y-m-d H:i:s",time());$index=$this->getGallery_index($gallery);if($index !==false) $SG_data['galleries'][$index]=$this->changeToSave($gallery);$this->success['success']='Success: You have edit Gallery!';} $this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();$this->delCache();} public function changeToSave($data){ $data=$this->changeToInt($data);$data=$this->changeToFloat($data);$data=$this->changeToBool($data);$data=$this->changeToMetric($data);return $data;} public function changeToInt($data){ $fieldToChange=array( "['gallery']['loaderPadding']","['gallery']['loaderStroke']","['gallery']['border_radius']","['gallery']['time']","['gallery']['transPeriod']","['behavior']['limit']","['behavior']['items_per_pack']","['thumb']['width']","['thumb']['height']","['thumb']['distance']","['image']['width']","['image']['height']","['zoom_image']['width']","['zoom_image']['height']" );foreach($fieldToChange as $field){ eval('$data'.$field.' = intval($data'.$field.');');} return $data;} public function changeToFloat($data){ $fieldToChange=array( "['gallery']['loaderOpacity']" );foreach($fieldToChange as $field){ eval('$data'.$field.' = floatval($data'.$field.');');} return $data;} public function changeToBool($data){ $fieldToChange=array( "['product']['button']['add_to_cart']","['product']['button']['add_to_wish_list']","['product']['button']['add_to_compare']","['product']['button']['see_full_details']","['product']['button']['navigationHover']","['product']['description']","['gallery']['fullscreen']","['gallery']['thumbnails']","['gallery']['croped']","['gallery']['navigation']","['gallery']['navigationHover']","['gallery']['mobileNavHover']","['gallery']['playPause']","['gallery']['autoAdvance']","['gallery']['mobileAutoAdvance']","['gallery']['hover']","['gallery']['pauseOnClick']","['gallery']['overlayer']","['gallery']['opacityOnGrid']","['behavior']['zoom']","['behavior']['allow_change_view']","['behavior']['title']","['behavior']['quick_view_product']","['behavior']['pagination']","['behavior']['ajax_pagination_mode']","['behavior']['activ_new_first_thumb']" );foreach($fieldToChange as $field){ eval('$data'.$field.' = $data'.$field.' ? true : false;');} return $data;} public function changeToMetric($data){ $fieldToChange=array( "['gallery']['height']","['gallery']['minHeight']","['gallery']['border_radius']","['gallery']['border_width']","['gallery']['width']","['behavior']['overlay_set']['top']","['behavior']['overlay_set']['bottom']","['behavior']['overlay_set']['left']","['behavior']['overlay_set']['right']" );foreach($fieldToChange as $field){ eval('$val = $data'.$field.';');if($val !=''){ $pref='px';if(strripos($val,'%') !==false) $pref='%';$val=intval($val).$pref;} eval('$data'.$field.' = $val;');} return $data;} public function removegallery(){ $id=$this->request->post['id'];if(!$id)return;$this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');foreach($SG_data['smartgallery/index_module'] as $i=> $val){ if($val['gallery_id']==$id) unset($SG_data['smartgallery/index_module'][$i]);} foreach($SG_data['galleries'] as $i=> $galery){ if($galery['main']['id']==$id) unset($SG_data['galleries'][$i]);} $this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();} public function duplicategallery(){ $id=$this->request->post['id'];if(!$id)return;$this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$gallery=$this->getGallery_id($id,true);$gallery['main']['name'] =$gallery['main']['name'].' #';$gallery['main']['id'] =$this->generateRandomString();$gallery['main']['date_c'] =date("Y-m-d H:i:s",time());$gallery['main']['date_m'] =date("Y-m-d H:i:s",time());$SG_data['galleries'][]=$gallery;$this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();} protected function setToCashBottomCategory(){ $query=$this->db->query("SELECT * FROM ".DB_PREFIX."category WHERE status = '1';");$results=$query->rows;$bottomCategory=array();foreach ($results as $result_1) { $hasChild=false;foreach ($results as $result_2) { if($result_1['category_id']==$result_2['parent_id']){ $hasChild=true;break;} } if (!$hasChild) $bottomCategory[]=$result_1['category_id'];} $this->cache->set('SG.bottomCategory',$bottomCategory);} public function savegallerytopage(){ $this->load->model('setting/setting');$data=$this->request->post['data'];foreach($data as $i=> $val){ if($val['id']=='') $data[$i]['id']=$this->generateRandomString();$data[$i]['bottom_cat']=$data[$i]['bottom_cat'] ? true:false;if($data[$i]['bottom_cat']) $this->setToCashBottomCategory();} $SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$SG_data['smartgallery/index_module']=$data;$this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();} public function removegallerytopage($id=''){ $this->load->model('setting/setting');if(!$id) $id=$this->request->post['id'];$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');foreach($SG_data['smartgallery/index_module'] as $i=> $val){ if($val['id']==$id) unset($SG_data['smartgallery/index_module'][$i]);} $this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();} public function saveglobsetting(){ $this->load->model('setting/setting');$data=$this->request->post['data'];$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$SG_data['global_setting']=$data;$this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->getPageForAjax();$this->delCache();} public function import(){ $this->load->model('setting/setting');$data=json_decode(base64_decode($this->request->post['import']),true);if(!is_array($data)) { $this->error['warning']='Error: Your import data is corrupted!';}else{ $SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$SG_data['smartgallery/index_module']=$data['galleriseOnPage'];$SG_data['galleries']=$data['galleries'];$SG_data['global_setting']=$data['global_setting'];$this->model_setting_setting->editSetting('smartgallery/index',$SG_data);$this->success['success']='Success: You have imported Galleries!';} $this->getPageForAjax();} protected function getPageForAjax(){ $this->data=$this->language->load('module/smartgallery/index');$this->load->model('setting/setting');if (isset($this->success['success'])) { $this->data['success']=$this->success['success'];} else if(isset($this->session->data['success'])) { $this->data['success']=$this->session->data['success'];unset ($this->session->data['success']);} else { $this->data['success']='';} if (isset($this->error['warning'])) { $this->data['error_warning']=$this->error['warning'];} else if(isset($this->session->data['error'])) { $this->data['error']=$this->session->data['error'];unset ($this->session->data['error']);}else { $this->data['error_warning']='';} $this->setData();$this->setUpdateText();$this->data['token']=$this->session->data['token'];$this->setURLs();$this->load->model('design/layout');$this->data['layouts']=$this->model_design_layout->getLayouts();$this->template='module/smartgallery/smartgallery_ajax.tpl';$this->response->setOutput($this->render());} protected function setData(){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$this->data['galleries'] =$SG_data['galleries'];$this->data['galleriseOnPage'] =$SG_data['smartgallery/index_module'];$this->data['default_galleryOnPage']=$SG_data['default_galleryOnPage'];$this->data['export_data'] =array( 'galleriseOnPage' => $SG_data['smartgallery/index_module'],'galleries' => $SG_data['galleries'],'global_setting'=> $SG_data['global_setting'] );$this->data['options'] =array_merge_recursive ($SG_data['default_options'],$SG_data['global_setting']);$defaultData=$this->getDefaultOptions();$this->data['default_global_setting']=$defaultData['global_setting']['data'];$this->data['SG_VER']=SG_VER;} protected function setURLs(){ $this->data['action'] =$this->url->link('module/smartgallery/index','token='.$this->session->data['token'],'SSL');$this->data['cancel'] =$this->url->link('extension/module','token='.$this->session->data['token'],'SSL');$this->data['save_gallery_url'] =$this->url->link('module/smartgallery/index/savegallery','token='.$this->session->data['token'],'SSL');$this->data['get_gallery_url']=$this->url->link('module/smartgallery/index/getgallery','token='.$this->session->data['token'],'SSL');$this->data['duplicate_gallery_url']=$this->url->link('module/smartgallery/index/duplicategallery','token='.$this->session->data['token'],'SSL');$this->data['remove_gallery_url']=$this->url->link('module/smartgallery/index/removegallery','token='.$this->session->data['token'],'SSL');$this->data['save_gallery_to_page_url']=$this->url->link('module/smartgallery/index/savegallerytopage','token='.$this->session->data['token'],'SSL');$this->data['remove_gallery_to_page_url']=$this->url->link('module/smartgallery/index/removegallerytopage','token='.$this->session->data['token'],'SSL');$this->data['save_glob_setting_url']=$this->url->link('module/smartgallery/index/saveglobsetting','token='.$this->session->data['token'],'SSL');$this->data['import_url']=$this->url->link('module/smartgallery/index/import','token='.$this->session->data['token'],'SSL');$this->data['support_getproducts_url']='http://smartshopbox.com/support/getproducts/';} protected function getBreadCrumbs(){ $this->language->load('module/smartgallery/index');$breadcrumbs=array();$breadcrumbs[]=array( 'text' => $this->language->get('text_home'),'href' => $this->url->link('common/home','token='.$this->session->data['token'],'SSL'),'separator'=> false );$breadcrumbs[]=array( 'text' => $this->language->get('text_module'),'href' => $this->url->link('extension/module','token='.$this->session->data['token'],'SSL'),'separator'=> ' :: ' );$breadcrumbs[]=array( 'text' => $this->language->get('heading_title'),'href' => $this->url->link('module/smartgallery/smartgallery','token='.$this->session->data['token'],'SSL'),'separator'=> ' :: ' );return $breadcrumbs;} protected function getGallery_id($id,$original=false){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');$gallery=array();foreach($SG_data['galleries'] as $SG_gallery){ if($SG_gallery['main']['id']==$id) $gallery=$SG_gallery;} if($original)return $gallery;$SG_default=$this->getDefaultGallery();$fieldToChange=array( "['thumb']['position']","['behavior']['mode']","['behavior']['activate_mode']","['behavior']['load_content']","['gallery']['easing']","['gallery']['fx']","['gallery']['mobileFx']","['gallery']['header_position']","['product']['images_position']" );foreach($fieldToChange as $field){ eval('$gallery'.$field.' = $this->getGalleryValue($SG_default, $gallery, $field);');} return $gallery;} protected function getGalleryValue(&$SG_default,&$SG_gallery,$field){ eval('$SG_def_par = $SG_default'.$field.';');eval('$SG_gal_par = $SG_gallery'.$field.';');foreach($SG_def_par as $i=> $val){ unset($SG_def_par[$i]['default']);if($val['value']==$SG_gal_par){ $SG_def_par[$i]['default']=true;} } return $SG_def_par;} protected function getGallery_index($gallery){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');foreach($SG_data['galleries'] as $index=> $SG_gallery){ if($SG_gallery['main']['id']==$gallery['main']['id']) return $index;} return false;} protected function getDefaultGallery(){ $this->load->model('setting/setting');$SG_data =$this->model_setting_setting->getSetting('smartgallery/index');return $SG_data['default_options'];} protected function validate() { if (!$this->user->hasPermission('modify','module/smartgallery')) { $this->error['warning']=$this->language->get('error_permission');} if (isset($this->request->post['smartgallery_module'])) { foreach ($this->request->post['smartgallery_module'] as $key=> $value) { if (!$value['image_width'] || !$value['image_height']) { $this->error['image'][$key]=$this->language->get('error_image');} } } if (!$this->error) { return true;} else { return false;} } protected function generateRandomString($length=5) { return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyz"),0,$length);} protected function getSkin($default_val){ $dirImage =DIR_CATALOG."view/theme/default/stylesheet/smartgallery/images/skins";$pathImage =HTTP_CATALOG."catalog/view/theme/default/stylesheet/smartgallery/images/skins/";$files=$this->getFiles($dirImage,$pathImage);if(isset($default_val)){ foreach($files as $key=> $val) { if($default_val==$val['value'])$files[$key]['default']=true;} }else{ $files[0]['default']=true;} return $files;} protected function getOverlay($default_val){ $dirImage =DIR_CATALOG."view/theme/default/stylesheet/smartgallery/images/patterns";$pathImage =HTTP_CATALOG."catalog/view/theme/default/stylesheet/smartgallery/images/patterns/";$files=$this->getFiles($dirImage,$pathImage,true);if(isset($default_val)){ foreach($files as $key=> $val) { if($default_val==$val['value'])$files[$key]['default']=true;} }else{ $files[0]['default']=true;} return $files;} protected function getFiles($dir,$path='',$addEmpty=false) { $files=array();if ($handle=opendir($dir)) { while (false !==($file=readdir($handle))) { if ($file !="." && $file !="..") { if(preg_match("/\.(?:jp(?:e?g|e|2)|gif|png|tiff?|ttf|bmp|ico)$/i ",$file) ){ $name=ucfirst(str_replace ('_',' ',$file));$pos=strrpos($file,'.');if ($pos !==false) { $name=ucfirst(str_replace ('_',' ',substr($file,0,$pos)));} if($path!=''){ $files[]=array( "name" => $name,"value"=> $file,"url"=> $path.$file );}else{ $files[]=array( "name" => $name,"value"=> $file );} } } } closedir($handle);} $sort_numcie=array();foreach($files as $key=> $val) { $sort_numcie[]=$val['name'];} array_multisort($sort_numcie,SORT_ASC,$files);if($addEmpty) array_unshift($files,array("name" => 'Without background',"value"=> 'empty',"url"=> ''));return $files;} protected function getDirs($dir) { $dirs=array();if ($handle=opendir($dir)) { while (false !==($dir_=readdir($handle))) { if (!is_file($dir_) && $dir_!='.' && $dir_!='..' && $dir_!='') { if(is_dir($dir.'/'.$dir_)) $dirs[]=(string)$dir_;} } } sort($dirs,SORT_STRING );return $dirs;} protected function delCache() { $files=glob(DIR_CACHE.'cache.SG*');if ($files) { foreach ($files as $file) { if (file_exists($file)) { unlink($file);clearstatcache();} } } } } ?>
