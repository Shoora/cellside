<?php
class ControllerLandingLanding extends Controller {
    private $error = array();
    private $productObject = NULL;
    private $categoryGroupForLanding = array(803,809,815,873,871,872);


    public function index() {
        try{
            $this->loadModuls();



            $this->getCategory();

            $this->data['review_status'] = $this->config->get('config_review_status');
            $this->data['heading_title'] = $this->language->get('heading_title'); //Get "heading title" from language file.
            $this->data['add_item']      = $this->language->get('button_cart');
            $data = array(
                'filter_custom'=>array(array('query'=>"`date_modified` > '2014-02-01'","concat"=>"AND"))

                //  'filter_category_id' => $category_id,
                //  'filter_filter'      => $filter,
                // 'sort'               => $sort,
                // 'order'              => $order,
                //'start'              => (1 - 1) * 6,
                //'limit'              => 6
            );

            $this->data['product'] = $this->getProductList( $data);
            $data1 = array(
                //  'filter_category_id' => $category_id,
                //  'filter_filter'      => $filter,
                // 'sort'               => $sort,
                // 'order'              => $order,
                //'start'              => (2 - 1) * 6,
                //'limit'              => 6
            );


           // $this->data['product1'] = $this->getProductList( $data1);




///render template
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/landing/landing.tpl')) { //if file exists in your current template folder
            $this->template = $this->config->get('config_template') . '/template/landing/landing.tpl'; //get it
        } else {
            $this->template = 'default/template/landing/landing.tpl'; //or get the file from the default folder
        }

        $this->children = array( //Required. The children files for the page.

            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
        }catch(Exception $e){
            var_dump(array($e->getMessage(),$e->getTrace(),$e->getLine()));
            die();
        }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }


    function loadModuls(){
        $this->language->load('module/product');
        $this->language->load('product/category');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');

        $this->load->model('landing/product');


        $this->language->load('landing/landing'); //Optional. This calls for your language file
        $this->language->load('landing/english');
        $this->document->setTitle($this->language->get('heading_title')); //Optional. Set the title of your web page.
        $this->load->model('tool/image');

    }


    function getCategory(){
        $allRootCategory =  $this->model_catalog_category->getCategories(0);
        $list = $this->categoryGroupForLanding;
        $result = array_filter($allRootCategory, function($innerArray)use($list){
           if(in_array($innerArray['category_id'],$list)){
               return true;
           }

        });



        foreach($result as $key => $categoty){
            $children =  $this->model_catalog_category->getCategories($categoty['category_id']);
            $result[$key]['link'] = $this->url->link('landing/landing', 'type_id='.$categoty['category_id']);
            foreach($children as $key1=>$child){
                $children[$key1]['link'] =$this->url->link('landing/landing', 'category_id='.$child['category_id'].'&type_id='.$categoty['category_id']);
            }
            $result[$key]['children'] = $children;
        }


     $this->data['category'] = $result;
    }




   private function getProductList($filter = NULL){


        $dataBack = array();
        $results  = $this->model_landing_product->getProducts($filter );

         //$product->getProducts($filter );




        foreach ($results as $result) {
            $result['symbol']           = $this->currency->getSymbolLeft();
            $result['price_format']     = $this->currency->format($result['price'],$this->currency->getCode());
            $result['special_format']   = $this->currency->format($result['special'],$this->currency->getCode());
            $result['special_simple']   = $this->currency->format($result['special'],null,false);
            $result['price_simple']     = $this->currency->format($result['special'],null,false);
            if($result['special']){
                $result['percentage']   = $this->getPercentage($result['price_format'],$result['special_format']);
            }else{
                $result['percentage']   = NULL;
            }
            $result['time_left']        = $this->timeLeft($result['date_modified']);
            $cache = DIR_IMAGE.'cache/'. $result['image'];
            $result['thumbsmall'] ='image/cache/'. $result['image'];
            if (!file_exists($cache)){
                $image = new Image(DIR_IMAGE.$result['image']);
                $image->resize(348,275);
                $image->save($cache);

            }


            $dataBack[] = $result;
        }

       return  $dataBack;

    }

   private function getPercentage($price,$special){
        $price      = preg_replace("/\D/","",$price);
        $special    = preg_replace("/\D/","",$special);
       return round(100*$price/$special-100);
    }

   private function timeLeft($dateTime,$now = NULL){
        $date     = new DateTime($dateTime);

        $second   = date("s");


        $date1 = strtotime($dateTime);
        $date2 = time();
        $subTime = $date1 - $date2;
        $y = ($subTime/(60*60*24*365));
        $d = ($subTime/(60*60*24))%365;

        if($d){
            $h = ($subTime/(60*60))%24*$d;
        }else{
            $h = ($subTime/(60*60))%24;
        }
        $m = ($subTime/60)%60;



        return abs($h).":". sprintf("%1$02d",abs($m)).":".$second;
    }



}
?>