<?php
class ControllerOpenbayAmazon extends Controller {
    
    public function allUpdate() {
        $this->load->model('amazon/amazon');
        $this->load->model('catalog/product');
        
        $itemLinks = $this->model_amazon_amazon->getProductLinks();
        
        $ids = array();
        foreach($itemLinks as $link) {
            $ids[] = $link['product_id'];
        }
        echo "Products to be updated:";
        print_r($ids);
        $this->amazon->putStockUpdateBulk($ids, true);
        echo "Completed. More info amazon_stocks.log";
    }
    
    public function stockUpdates() {
        $this->data = array_merge($this->data, $this->load->language('amazon/stock_updates'));
        
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');
        
        
        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/overview&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/stockUpdates&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_stock_updates'),
            'separator' => ' :: '
        );
        
        $this->template = 'amazon/stock_updates.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        $this->data['link_overview'] = $this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL');
        
        $requestArgs = array();
        
        if (isset($this->request->get['filter_date_start'])) {
            $requestArgs['date_start'] = date("Y-m-d", strtotime($this->request->get['filter_date_start']));
        } else {
            $requestArgs['date_start'] = date("Y-m-d");
        }
        
        if (isset($this->request->get['filter_date_end'])) {
            $requestArgs['date_end'] = date("Y-m-d", strtotime($this->request->get['filter_date_end']));
        } else {
            $requestArgs['date_end'] = date("Y-m-d");
        }
        
        $this->data['date_start'] = $requestArgs['date_start'];
        $this->data['date_end'] = $requestArgs['date_end'];

        $xml = $this->amazon->getStockUpdatesStatus($requestArgs);
        $simpleXmlObj = simplexml_load_string($xml);
         $this->data['tableData'] = array();
        if($simpleXmlObj !== false) {
            
            $tableData = array();
            
            foreach($simpleXmlObj->update as $updateNode) {
                $row = array('date_requested' => (string) $updateNode->date_requested,
                    'date_updated' => (string) $updateNode->date_updated,
                    'status' => (string) $updateNode->status,
                    );
                $data = array();
                foreach($updateNode->data->product as $productNode) {
                    $data[] = array('sku' => (string) $productNode->sku,
                        'stock' => (int) $productNode->stock
                        );
                }
                $row['data'] = $data;
                $tableData[(int)$updateNode->ref] = $row;
            }
            
            $this->data['tableData'] = $tableData;
            
        } else {
            $this->data['error'] = 'Could not connect to OpenBay PRO API.';
        }
        
        $this->data['token'] = $this->session->data['token']; 
        
        $this->response->setOutput($this->render());
        
        
    }
    
    public function index() {
        $this->redirect($this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL'));
        return;
    }
    
    public function overview() {
        $this->load->model('setting/setting');
        $this->load->model('localisation/order_status');
        $this->load->model('amazon/amazon');
        $this->load->model('sale/customer_group');
        
        $this->data = array_merge($this->data, $this->load->language('amazon/overview'));
        
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->template = 'amazon/overview.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }
        
        $this->data['validation']               = $this->amazon->validate();
        $this->data['links_settings']           = $this->url->link('openbay/amazon/settings', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['links_subscription']       = $this->url->link('openbay/amazon/subscription', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['links_itemlink']           = $this->url->link('openbay/amazon/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['links_stockUpdates']       = $this->url->link('openbay/amazon/stockUpdates', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['links_savedListings']       = $this->url->link('openbay/amazon/savedListings', 'token=' . $this->session->data['token'], 'SSL');

        
        
        $this->response->setOutput($this->render());
    }
    
    public function subscription(){   
        $this->data = array_merge($this->data, $this->load->language('amazon/subscription'));
        
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');
        
        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/overview&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/subscription&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_my_account'),
            'separator' => ' :: '
        );
        
        $this->data['link_overview'] = $this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL');
        
        $responseXml = simplexml_load_string($this->amazon->callWithResponse('plans/getPlans'));
        
        $plans = array();
        
        if ($responseXml) {
            foreach ($responseXml->Plan as $plan) {
                $plans[] = array(
                    'title' => (string) $plan->Title,
                    'description' => (string) $plan->Description,
                    'order_frequency' => (string) $plan->OrderFrequency,
                    'product_listings' => (string) $plan->ProductListings,
                    'price' => (string) $plan->Price,
                );
            }
        }
        
        $this->data['plans'] = $plans;
        
        $responseXml = simplexml_load_string($this->amazon->callWithResponse('plans/getUsersPlans'));
        
        $plan = false;
        
        if ($responseXml) {
            $plan = array(
                'user_status' => (string) $responseXml->UserStatus,
                'title' => (string) $responseXml->Title,
                'description' => (string) $responseXml->Description,
                'price' => (string) $responseXml->Price,
                'order_frequency' => (string) $responseXml->OrderFrequency,
                'product_listings' => (string) $responseXml->ProductListings,
                'listings_remain' => (string) $responseXml->ListingsRemain,
                'listings_reserved' => (string) $responseXml->ListingsReserved,
            );
        }
        
        $this->data['user_plan'] = $plan;
        $this->data['server'] = $this->amazon->getServer();
        $this->data['token'] = $this->config->get('openbay_amazon_token');
        
        $this->template = 'amazon/subscription.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        $this->response->setOutput($this->render());
    }
    
    public function settings() {
        $this->data = array_merge($this->data, $this->load->language('amazon/settings'));
        $this->load->language('amazon/listing');
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');
        
        $this->load->model('setting/setting');
        $this->load->model('localisation/order_status');
        $this->load->model('amazon/amazon');
        $this->load->model('sale/customer_group');
        
        $settings = $this->model_setting_setting->getSetting('openbay_amazon');
        
        if (isset($settings['openbay_amazon_orders_marketplace_ids'])) {
            $settings['openbay_amazon_orders_marketplace_ids'] = $this->is_serialized($settings['openbay_amazon_orders_marketplace_ids']) ? (array)unserialize($settings['openbay_amazon_orders_marketplace_ids']) : $settings['openbay_amazon_orders_marketplace_ids'];
        }
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {     
            
            if (!isset($this->request->post['openbay_amazon_orders_marketplace_ids'])) {
                $this->request->post['openbay_amazon_orders_marketplace_ids'] = array();
            }
            
            $settings = array_merge($settings, $this->request->post);
            $this->model_setting_setting->editSetting('openbay_amazon', $settings);
            
            $this->config->set('openbay_amazon_token', $this->request->post['openbay_amazon_token']);
            $this->config->set('openbay_amazon_enc_string1', $this->request->post['openbay_amazon_enc_string1']);
            $this->config->set('openbay_amazon_enc_string2', $this->request->post['openbay_amazon_enc_string2']);
            
            $this->model_amazon_amazon->scheduleOrders($settings);
            
            $this->session->data['success'] = $this->language->get('lang_setttings_updated');
            $this->redirect($this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL'));
            return;
        }
        
        $this->data['link_overview'] = $this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/overview&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/settings&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_settings'),
            'separator' => ' :: '
        );
        
        $this->data['marketplace_ids']                  = (isset($settings['openbay_amazon_orders_marketplace_ids']) ? (array)$settings['openbay_amazon_orders_marketplace_ids'] : array() );
        $this->data['default_listing_marketplace_ids']  = ( isset($settings['openbay_amazon_default_listing_marketplace_ids']) ? (array)$settings['openbay_amazon_default_listing_marketplace_ids'] : array() );
        
                
                
                
        $this->data['marketplaces'] = array(
            array('name' => $this->language->get('lang_de'), 'id' => 'A1PA6795UKMFR9', 'code' => 'de'),
            array('name' => $this->language->get('lang_fr'), 'id' => 'A13V1IB3VIYZZH', 'code' => 'fr'),
            array('name' => $this->language->get('lang_it'), 'id' => 'APJ6JRA9NG5V4', 'code' => 'it'),
            array('name' => $this->language->get('lang_es'), 'id' => 'A1RKKUPIHCS9HS', 'code' => 'es'),
            array('name' => $this->language->get('lang_uk'), 'id' => 'A1F83G8C2ARO7P', 'code' => 'uk'),
        );
        
        $this->data['conditions'] = array(
            'New' => $this->language->get('text_new'),
            'UsedLikeNew' => $this->language->get('text_used_like_new'),
            'UsedVeryGood' => $this->language->get('text_used_very_good'),
            'UsedGood' => $this->language->get('text_used_good'),
            'UsedAcceptable' => $this->language->get('text_used_acceptable'),
            'CollectibleLikeNew' => $this->language->get('text_collectible_like_new'),
            'CollectibleVeryGood' => $this->language->get('text_collectible_very_good'),
            'CollectibleGood' => $this->language->get('text_collectible_good'),
            'CollectibleAcceptable' => $this->language->get('text_collectible_acceptable'),
            'Refurbished' => $this->language->get('text_refurbished'),
        );
        
        $this->data['is_enabled'] = isset($settings['amazon_status']) ? $settings['amazon_status'] : '';
        $this->data['openbay_amazon_token'] = isset($settings['openbay_amazon_token']) ? $settings['openbay_amazon_token'] : '';
        $this->data['openbay_amazon_enc_string1'] = isset($settings['openbay_amazon_enc_string1']) ? $settings['openbay_amazon_enc_string1'] : '';
        $this->data['openbay_amazon_enc_string2'] = isset($settings['openbay_amazon_enc_string2']) ? $settings['openbay_amazon_enc_string2'] : '';
        $this->data['openbay_amazon_listing_tax_added'] = isset($settings['openbay_amazon_listing_tax_added']) ? $settings['openbay_amazon_listing_tax_added'] : '0.00';
        $this->data['openbay_amazon_order_tax'] = isset($settings['openbay_amazon_order_tax']) ? $settings['openbay_amazon_order_tax'] : '00';
        $this->data['openbay_amazon_default_listing_marketplace'] = isset($settings['openbay_amazon_default_listing_marketplace']) ? $settings['openbay_amazon_default_listing_marketplace'] : '';
        $this->data['openbay_amazon_listing_default_condition'] = isset($settings['openbay_amazon_listing_default_condition']) ? $settings['openbay_amazon_listing_default_condition'] : '';
        
        $unshippedStatusId = isset($settings['openbay_amazon_order_status_unshipped']) ? $settings['openbay_amazon_order_status_unshipped'] : '';
        $partiallyShippedStatusId = isset($settings['openbay_amazon_order_status_partially_shipped']) ? $settings['openbay_amazon_order_status_partially_shipped'] : '';
        $shippedStatusId = isset($settings['openbay_amazon_order_status_shipped']) ? $settings['openbay_amazon_order_status_shipped'] : '';
        $canceledStatusId = isset($settings['openbay_amazon_order_status_canceled']) ? $settings['openbay_amazon_order_status_canceled'] : '';
        
        $amazonOrderStatuses = array(
            'unshipped' => array('name' => $this->language->get('lang_unshipped'), 'order_status_id' => $unshippedStatusId),
            'partially_shipped' => array('name' => $this->language->get('lang_partially_shipped'), 'order_status_id' => $partiallyShippedStatusId),
            'shipped' => array('name' => $this->language->get('lang_shipped'), 'order_status_id' => $shippedStatusId),
            'canceled' => array('name' => $this->language->get('lang_canceled'), 'order_status_id' => $canceledStatusId),
        );
        
        $this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
        $this->data['openbay_amazon_order_customer_group'] = isset($settings['openbay_amazon_order_customer_group']) ? $settings['openbay_amazon_order_customer_group'] : '';
        
        $this->data['amazon_order_statuses'] = $amazonOrderStatuses;
        $this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

        $this->data['subscription_url'] = $this->url->link('openbay/amazon/subscription', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['itemLinks_url'] = $this->url->link('amazon/product/linkItems', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['openbay_amazon_notify_admin'] = isset($settings['openbay_amazon_notify_admin']) ? $settings['openbay_amazon_notify_admin'] : '';
       
        
        $this->template = 'amazon/settings.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        $pingInfo = simplexml_load_string($this->amazon->callWithResponse('ping/info'));
        
        $api_status = false;
        $api_auth = false;
        if($pingInfo) {
            $api_status = ((string)$pingInfo->Api_status == 'ok') ? true : false;
            $api_auth = ((string)$pingInfo->Auth == 'true') ? true : false;
        }
        
        $this->data['API_status'] = $api_status;
        $this->data['API_auth'] = $api_auth;
        
        $this->response->setOutput($this->render());
        
    }
    
    private function is_serialized( $data ) {
        // if it isn't a string, it isn't serialized
        if (!is_string($data)) {
            return false;
        }
        $data = trim($data);
        if ('N;' == $data) {
            return true;
        }
        if (!preg_match('/^([adObis]):/', $data, $badions)) {
            return false;
        }
        switch ($badions[1]) {
            case 'a' :
            case 'O' :
            case 's' :
                if (preg_match("/^{$badions[1]}:[0-9]+:.*[;}]\$/s", $data)) {
                    return true;
                }
                break;
            case 'b' :
            case 'i' :
            case 'd' :
                if (preg_match("/^{$badions[1]}:[0-9.E-]+;\$/", $data)) {
                    return true;
                }
                break;
        }
        return false;
    }
    
    public function itemLinks() {
        $this->data = array_merge($this->data, $this->load->language('amazon/item_links'));
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');
        
        $this->data['link_overview'] = $this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/overview&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/itemLinks&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_item_links'),
            'separator' => ' :: '
        );
        
        $this->data['token'] = $this->session->data['token']; 
        
        $this->data['addItemLinkAjax'] = $this->url->link('openbay/amazon/addItemLinkAjax', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['removeItemLinkAjax'] = $this->url->link('openbay/amazon/removeItemLinkAjax', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['getItemLinksAjax'] = $this->url->link('openbay/amazon/getItemLinksAjax', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['getUnlinkedItemsAjax'] = $this->url->link('openbay/amazon/getUnlinkedItemsAjax', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['getOpenstockOptionsAjax'] = $this->url->link('openbay/amazon/getOpenstockOptionsAjax', 'token=' . $this->session->data['token'], 'SSL');
       
        $this->template = 'amazon/item_links.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        $this->response->setOutput($this->render());
    }
    
    public function savedListings() {
        
        $this->data = array_merge($this->data, $this->load->language('amazon/saved_listings'));
        
        $this->document->setTitle($this->language->get('lang_title'));
        $this->document->addStyle('view/stylesheet/openbay.css');
        $this->document->addScript('view/javascript/openbay/faq.js');
        
        $this->data['link_overview'] = $this->url->link('openbay/amazon/overview', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/openbay&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_openbay'),
            'separator' => ' :: '
        );
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/overview&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_overview'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=openbay/amazon/savedListings&token=' . $this->session->data['token'],
            'text'      => $this->language->get('lang_saved_listings'),
            'separator' => ' :: '
        );
        
        $this->template = 'amazon/saved_listings.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        $this->data['token'] = $this->session->data['token']; 
        $this->load->model('amazon/amazon');
        $saved_products = $this->model_amazon_amazon->getSavedProducts();
        
        $this->data['saved_products'] = array();
        
        foreach($saved_products as $saved_product) {
            $this->data['saved_products'][] = array(
                'product_id' => $saved_product['product_id'],
                'product_name' => $saved_product['product_name'],
                'product_model' => $saved_product['product_model'],
                'product_sku' => $saved_product['product_sku'],
                'amazon_sku' => $saved_product['amazon_sku'],
                'var' => $saved_product['var'],
                'edit_link' => $this->url->link('amazon/product', 'token=' . $this->session->data['token'] . '&product_id=' . $saved_product['product_id'] . '&var=' . $saved_product['var'], 'SSL'),
            );
        } 
        
        $this->data['deleteSavedAjax'] = $this->url->link('openbay/amazon/deleteSavedAjax', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['uploadSavedAjax'] = $this->url->link('amazon/product/uploadSavedAjax', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->response->setOutput($this->render());
    }
    
    public function install(){
        $this->load->model('amazon/amazon');
        $this->load->model('setting/setting');
        $this->load->model('setting/extension');

        $this->model_amazon_amazon->install();
        $this->model_setting_extension->install('openbay', $this->request->get['extension']);
    }
    
    public function uninstall(){
        $this->load->model('amazon/amazon');
        $this->load->model('setting/setting');
        $this->load->model('setting/extension');

        $this->model_amazon_amazon->uninstall();
        $this->model_setting_extension->uninstall('openbay', $this->request->get['extension']);
        $this->model_setting_setting->deleteSetting($this->request->get['extension']);
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'openbay/amazon')) {
            $this->error = $this->language->get('error_permission');
        }

        if (empty($this->error)) {
            return true;
        }

        return false;
    }
    
    public function getOpenstockOptionsAjax() {
        $options = array();
        if($this->amazon->addonLoad('openstock') == true && isset($this->request->get['product_id'])) {
            $this->load->model('openstock/openstock');
            $this->load->model('tool/image');
            $options = $this->model_openstock_openstock->getProductOptionStocks($this->request->get['product_id']);
        }
        if(empty($options)) {
            $options = false;
        }
        $this->response->setOutput(json_encode($options)); 
    }
    
    public function addItemLinkAjax() {
        if(isset($this->request->get['product_id']) && isset($this->request->get['amazon_sku'])) {
            $amazon_sku = $this->request->get['amazon_sku'];
            $product_id = $this->request->get['product_id'];
            $var = isset($this->request->get['var']) ? $this->request->get['var'] : '';
            
        } else {
            $result = json_encode('error');
            $this->response->setOutput($result);
            return;
        }
        $this->load->model('amazon/amazon');
        $this->load->library('amazon');
        $this->model_amazon_amazon->linkProduct($amazon_sku, $product_id, $var);
        $logger = new Log('amazon_stocks.log');
        $logger->write('addItemLink() called for product id: ' . $product_id . ', amazon sku: ' . $amazon_sku . ', var: ' . $var);
        
        if($var != '' && $this->amazon->addonLoad('openstock') == true) {
            $logger->write('Using openStock');
            $this->load->model('tool/image');
            $this->load->model('openstock/openstock');
            $optionStocks = $this->model_openstock_openstock->getProductOptionStocks($product_id);
            $quantityData = array();
            foreach($optionStocks as $optionStock) {
                if(isset($optionStock['var']) && $optionStock['var'] == $var) {
                    $quantityData[$amazon_sku] = $optionStock['stock'];
                    break;
                }
            }
            if(!empty($quantityData)) {
                $logger->write('Updating quantities with data: ' . print_r($quantityData, true));
                $this->amazon->updateQuantities($quantityData);
            } else {
                $logger->write('No quantity data will be posted.');
            } 
        } else {
            $this->amazon->putStockUpdateBulk(array($product_id));
        }
        
        $result = json_encode('ok');
        $this->response->setOutput($result);   
        $logger->write('addItemLink() exiting');
    }
    
    public function removeItemLinkAjax() {
        if(isset($this->request->get['amazon_sku'])) {
            $amazon_sku = $this->request->get['amazon_sku'];            
        } else {
            $result = json_encode('error');
            $this->response->setOutput($result);
            return;
        }
        $this->load->model('amazon/amazon');
        
        $this->model_amazon_amazon->removeProductLink($amazon_sku);
        
        $result = json_encode('ok');
        $this->response->setOutput($result);   
    }
    
    public function getItemLinksAjax() {
        $this->load->model('amazon/amazon');
        $this->load->model('catalog/product');
        
        $itemLinks = $this->model_amazon_amazon->getProductLinks();
        $result = json_encode($itemLinks);
        $this->response->setOutput($result);   
    }
    
    public function getUnlinkedItemsAjax() {
        $this->load->model('amazon/amazon');
        $this->load->model('catalog/product');
        
        $unlinkedProducts = $this->model_amazon_amazon->getUnlinkedProducts();
        $result = json_encode($unlinkedProducts);
        $this->response->setOutput($result);  
    }
    
    public function deleteSavedAjax() {
        if(!isset($this->request->get['product_id']) || !isset($this->request->get['var'])) {
            return;
        }
        
        $this->load->model('amazon/amazon');
        $this->model_amazon_amazon->deleteSaved($this->request->get['product_id'], $this->request->get['var']);
    }
}
