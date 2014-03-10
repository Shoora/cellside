<?php 
class ControllerCommonHeader extends Controller {
	protected function index() {

			$this->data = array_merge($this->data, $this->load->language('multiseller/multiseller'));
			$lang = "view/javascript/multimerch/datatables/lang/" . $this->config->get('config_admin_language') . ".txt";
			$this->data['dt_language'] = file_exists(DIR_APPLICATION . $lang) ? "'$lang'" : "undefined";
			
		$this->data['title'] = $this->document->getTitle(); 
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		
		$this->language->load('common/header');

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_attribute'] = $this->language->get('text_attribute');
		$this->data['text_attribute_group'] = $this->language->get('text_attribute_group');
		$this->data['text_backup'] = $this->language->get('text_backup');
		$this->data['text_banner'] = $this->language->get('text_banner');
		$this->data['text_catalog'] = $this->language->get('text_catalog');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_country'] = $this->language->get('text_country');
		$this->data['text_coupon'] = $this->language->get('text_coupon');
		$this->data['text_currency'] = $this->language->get('text_currency');			

			$this->data['text_clear_caches']       = $this->language->get('text_clear_caches');
			$this->data['text_clear_allbutimage']  = $this->language->get('text_clear_allbutimage');
			$this->data['text_clear_all']          = $this->language->get('text_clear_all');
			$this->data['text_clear_vqmod']        = $this->language->get('text_clear_vqmod');
			$this->data['text_clear_image']        = $this->language->get('text_clear_image');
			$this->data['text_clear_system']       = $this->language->get('text_clear_system');
			$this->data['text_clear_minify']       = $this->language->get('text_clear_minify');
			$this->data['text_clear_seo']          = $this->language->get('text_clear_seo');
			$this->data['text_clear_page']         = $this->language->get('text_clear_page');
			
		$this->data['text_customer'] = $this->language->get('text_customer');
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_customer_field'] = $this->language->get('text_customer_field');
		$this->data['text_customer_ban_ip'] = $this->language->get('text_customer_ban_ip');
		$this->data['text_custom_field'] = $this->language->get('text_custom_field');
		$this->data['text_sale'] = $this->language->get('text_sale');
		$this->data['text_design'] = $this->language->get('text_design');
		$this->data['text_documentation'] = $this->language->get('text_documentation');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_error_log'] = $this->language->get('text_error_log');
		$this->data['text_extension'] = $this->language->get('text_extension');
		$this->data['text_feed'] = $this->language->get('text_feed');
		$this->data['text_filter'] = $this->language->get('text_filter');
		$this->data['text_front'] = $this->language->get('text_front');
		$this->data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$this->data['text_dashboard'] = $this->language->get('text_dashboard');
		$this->data['text_help'] = $this->language->get('text_help');
		$this->data['text_information'] = $this->language->get('text_information');
$this->data['text_testimonial'] = $this->language->get('text_testimonial');
		$this->data['text_language'] = $this->language->get('text_language');
		$this->data['text_layout'] = $this->language->get('text_layout');
		$this->data['text_localisation'] = $this->language->get('text_localisation');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_manager'] = $this->language->get('text_manager');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_order_status'] = $this->language->get('text_order_status');
		$this->data['text_opencart'] = $this->language->get('text_opencart');
		$this->data['text_payment'] = $this->language->get('text_payment');
		$this->data['text_product'] = $this->language->get('text_product'); 

			$this->data['text_seopack'] = $this->language->get('text_seopack');
			$this->data['text_seoimages'] = $this->language->get('text_seoimages');
			$this->data['text_seoeditor'] = $this->language->get('text_seoeditor');
			$this->data['text_seoreport'] = $this->language->get('text_seoreport');
			$this->data['text_autolinks'] = $this->language->get('text_autolinks');
			
		$this->data['text_profile'] = $this->language->get('text_profile');
		$this->data['text_reports'] = $this->language->get('text_reports');
		$this->data['text_report_sale_order'] = $this->language->get('text_report_sale_order');
		$this->data['text_report_sale_tax'] = $this->language->get('text_report_sale_tax');
		$this->data['text_report_sale_shipping'] = $this->language->get('text_report_sale_shipping');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_sale_coupon'] = $this->language->get('text_report_sale_coupon');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$this->data['text_report_customer_online'] = $this->language->get('text_report_customer_online');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_report_customer_reward'] = $this->language->get('text_report_customer_reward');
		$this->data['text_report_customer_credit'] = $this->language->get('text_report_customer_credit');
		$this->data['text_report_affiliate_commission'] = $this->language->get('text_report_affiliate_commission');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_review'] = $this->language->get('text_review');

        $this->data['text_questions_and_answers'] = $this->language->get('text_questions_and_answers');
            
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_return_action'] = $this->language->get('text_return_action');
		$this->data['text_return_reason'] = $this->language->get('text_return_reason');
		$this->data['text_return_status'] = $this->language->get('text_return_status');
		$this->data['text_support'] = $this->language->get('text_support');
		$this->data['text_shipping'] = $this->language->get('text_shipping');
		$this->data['text_setting'] = $this->language->get('text_setting');
		$this->data['text_stock_status'] = $this->language->get('text_stock_status');
		$this->data['text_system'] = $this->language->get('text_system');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_tax_class'] = $this->language->get('text_tax_class');
		$this->data['text_tax_rate'] = $this->language->get('text_tax_rate');
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_user'] = $this->language->get('text_user');
		$this->data['text_user_group'] = $this->language->get('text_user_group');
		$this->data['text_users'] = $this->language->get('text_users');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_voucher_theme'] = $this->language->get('text_voucher_theme');
		$this->data['text_weight_class'] = $this->language->get('text_weight_class');
		$this->data['text_length_class'] = $this->language->get('text_length_class');
          $this->data['text_template_email'] = $this->language->get('text_template_email');
		$this->data['text_googleprint'] = $this->language->get('text_googleprint');

				$this->load->model('setting/extension');
				$extensions = $this->model_setting_extension->getInstalled('module');
				$this->data['pavblog_installed'] = false;
				if(in_array("pavblog", $extensions)){
					$this->data['pavblog_installed'] = true;
				}

				$this->data['text_pavblog_manage_cate'] = $this->language->get('text_pavblog_manage_cate');
				$this->data['text_pavblog_manage_blog'] = $this->language->get('text_pavblog_manage_blog');
				$this->data['text_pavblog_add_blog'] = $this->language->get('text_pavblog_add_blog');
				$this->data['text_pavblog_manage_comment'] = $this->language->get('text_pavblog_manage_comment');
				$this->data['text_pavblog_general_setting'] = $this->language->get('text_pavblog_general_setting');
				$this->data['text_pavblog_front_mods'] = $this->language->get('text_pavblog_front_mods');
				$this->data['text_pavblog_blog'] = $this->language->get('text_pavblog_blog');
				$this->data['text_pavblog_category'] = $this->language->get('text_pavblog_category');
				$this->data['text_pavblog_comment'] = $this->language->get('text_pavblog_comment');
				$this->data['text_pavblog_latest'] = $this->language->get('text_pavblog_latest');
		$this->data['text_zone'] = $this->language->get('text_zone');

				
				$this->load->model('setting/setting');
                $list_fonts_google = $this->model_setting_setting->getSetting('fonts_google');
                if($list_fonts_google != null){
                    foreach ($list_fonts_google as $key=>$name){
                        $this->data['list_link_google_fonts_options'][] = array(
                            'key'     =>      $key,
                            'pcpb_fonts_google'     =>      $name
                        );    
                    }
                }
				
			
        $this->data['text_openbay_extension'] = $this->language->get('text_openbay_extension');
        $this->data['text_openbay_dashboard'] = $this->language->get('text_openbay_dashboard');
        $this->data['text_openbay_orders'] = $this->language->get('text_openbay_orders');
        $this->data['text_openbay_items'] = $this->language->get('text_openbay_items');
        $this->data['text_openbay_ebay'] = $this->language->get('text_openbay_ebay');
        $this->data['text_openbay_amazon'] = $this->language->get('text_openbay_amazon');
        $this->data['text_openbay_amazonus'] = $this->language->get('text_openbay_amazonus');
        $this->data['text_openbay_play'] = $this->language->get('text_openbay_play');
        $this->data['text_openbay_settings'] = $this->language->get('text_openbay_settings');
        $this->data['text_openbay_links'] = $this->language->get('text_openbay_links');
        $this->data['text_openbay_report_price'] = $this->language->get('text_openbay_report_price');
        $this->data['text_openbay_order_import'] = $this->language->get('text_openbay_order_import');
		
		$this->data['text_paypal_express'] = $this->language->get('text_paypal_manage');
		$this->data['text_paypal_express_search'] = $this->language->get('text_paypal_search');
		$this->data['text_recurring_profile'] = $this->language->get('text_recurring_profile');

		if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';
			
			$this->data['home'] = $this->url->link('common/login', '', 'SSL');
		} else {
			
			$this->data['logged'] = $this->user->getUserName();
			
			$this->data['text_low_stock'] = $this->language->get('text_low_stock');
			$this->data['text_out_stock'] = $this->language->get('text_out_stock');
			
            $this->data['pp_express_status'] = $this->config->get('pp_express_status');
            
			$this->data['home'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['affiliate'] = $this->url->link('sale/affiliate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute'] = $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute_group'] = $this->url->link('catalog/attribute_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['country'] = $this->url->link('localisation/country', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['coupon'] = $this->url->link('sale/coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['currency'] = $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer'] = $this->url->link('sale/customer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_fields'] = $this->url->link('sale/customer_field', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_group'] = $this->url->link('sale/customer_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_ban_ip'] = $this->url->link('sale/customer_ban_ip', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['custom_field'] = $this->url->link('design/custom_field', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['download'] = $this->url->link('catalog/download', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['error_log'] = $this->url->link('tool/error_log', 'token=' . $this->session->data['token'], 'SSL');
          $this->data['template_email'] = $this->url->link('catalog/template_email', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['product_reviews_review'] = $this->url->link('product_review/review', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_reviews_rating'] = $this->url->link('product_review/rating', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_reviews_report'] = $this->url->link('product_review/report', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_reviews_attribute'] = $this->url->link('product_review/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_reviews_optimize'] = $this->url->link('product_review/review/optimize', 'token=' . $this->session->data['token'], 'SSL');
			
			$this->data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['filter'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['geo_zone'] = $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], 'SSL');
$this->data['testimonial'] = $this->url->link('catalog/testimonial', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['information'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['contact'] = $this->url->link('sale/contact', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['manager'] = $this->url->link('extension/manager', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['manufacturer'] = $this->url->link('catalog/manufacturer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['option'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order_status'] = $this->url->link('localisation/order_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['payment'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['seopack'] = $this->url->link('catalog/seopack', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoimages'] = $this->url->link('catalog/seoimages', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoeditor'] = $this->url->link('catalog/seoeditor', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seoreport'] = $this->url->link('catalog/seoreport', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['autolinks'] = $this->url->link('catalog/autolinks', 'token=' . $this->session->data['token'], 'SSL');
			
			$this->data['profile'] = $this->url->link('catalog/profile', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_order'] = $this->url->link('report/sale_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_tax'] = $this->url->link('report/sale_tax', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_shipping'] = $this->url->link('report/sale_shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_return'] = $this->url->link('report/sale_return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_coupon'] = $this->url->link('report/sale_coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_viewed'] = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_purchased'] = $this->url->link('report/product_purchased', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_online'] = $this->url->link('report/customer_online', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_order'] = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_reward'] = $this->url->link('report/customer_reward', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_credit'] = $this->url->link('report/customer_credit', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_affiliate_commission'] = $this->url->link('report/affiliate_commission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');

            if ($this->config->get('qap_status')) {
                $this->data['qap'] = $this->url->link('catalog/questions_and_answers', 'token=' . $this->session->data['token'], 'SSL');
            }
            
			$this->data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');			
			$this->data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['setting'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['store'] = HTTP_CATALOG;
			$this->data['stock_status'] = $this->url->link('localisation/stock_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_class'] = $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_rate'] = $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['total'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['voucher'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['voucher_theme'] = $this->url->link('sale/voucher_theme', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['weight_class'] = $this->url->link('localisation/weight_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['length_class'] = $this->url->link('localisation/length_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['googleprint'] = $this->url->link('module/googleprint', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['pavblogs_category_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavblogcategory&token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_latest_comment_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavblogcomment&token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_latest_mod'] = $this->url->link('module/pavblog/frontmodules', 'mod=pavbloglatest&token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_category'] = $this->url->link('module/pavblog/category', 'token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_blogs'] = $this->url->link('module/pavblog/blogs', 'token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_add_blog'] = $this->url->link('module/pavblog/blog', 'token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_comments'] = $this->url->link('module/pavblog/comments', 'token=' . $this->session->data['token'], 'SSL');
				$this->data['pavblogs_general'] = $this->url->link('module/pavblog/modules', 'token=' . $this->session->data['token'], 'SSL');
				
			$this->data['zone'] = $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], 'SSL');

            $this->data['openbay_link_extension']           = $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_orders']              = $this->url->link('extension/openbay/orderList', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_items']               = $this->url->link('extension/openbay/itemList', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay']                = $this->url->link('openbay/openbay', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_settings']       = $this->url->link('openbay/openbay/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_links']          = $this->url->link('openbay/openbay/viewItemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_ebay_orderimport']    = $this->url->link('openbay/openbay/viewOrderImport', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon']              = $this->url->link('openbay/amazon', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon_settings']     = $this->url->link('openbay/amazon/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazon_links']        = $this->url->link('openbay/amazon/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus']            = $this->url->link('openbay/amazonus', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus_settings']   = $this->url->link('openbay/amazonus/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_amazonus_links']      = $this->url->link('openbay/amazonus/itemLinks', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play']                = $this->url->link('openbay/play', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play_settings']       = $this->url->link('openbay/play/settings', 'token=' . $this->session->data['token'], 'SSL');
            $this->data['openbay_link_play_report_price']   = $this->url->link('play/product/pricingReport', 'token=' . $this->session->data['token'], 'SSL');

            $this->data['openbay_markets'] = array(
                'ebay' => $this->config->get('openbay_status'),
                'amazon' => $this->config->get('amazon_status'),
                'amazonus' => $this->config->get('amazonus_status'),
                'play' => $this->config->get('play_status')
            );

			$this->data['paypal_express'] = $this->url->link('payment/pp_express', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['paypal_express_search'] = $this->url->link('payment/pp_express/search', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['recurring_profile'] = $this->url->link('sale/recurring', 'token=' . $this->session->data['token'], 'SSL');



			// Call the model that checks the table for the enabled widgets
			$this->load->model('common/admin_circloid_dashboard_editor');

			// Check if theme tables have been installed
			$tables_exist = $this->model_common_admin_circloid_dashboard_editor->tablesExist();

			if($tables_exist['color_preset'] && $tables_exist['widget_layout']){

				// Get Colors Profiles for the theme
				$this->data['css_detail'] = $this->model_common_admin_circloid_dashboard_editor->getColorProfileCss();

				// Low Stock
				$this->data['low_stock'] = $this->model_common_admin_circloid_dashboard_editor->getLowStock();
				$this->data['low_stock_link'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&filter_quantity=10', 'SSL');

				// Out Of Stock
				$this->data['out_stock'] = $this->model_common_admin_circloid_dashboard_editor->getOutOfStock();
				$this->data['out_stock_link'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . '&filter_quantity=0', 'SSL');

			}else{
				// Display Message and "Install" button that will install the tables
				$this->data['theme_not_installed'] = TRUE;
			}

			

			$this->data['ms_link_sellers'] = $this->url->link('multiseller/seller', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_seller_groups'] = $this->url->link('multiseller/seller-group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_attributes'] = $this->url->link('multiseller/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_products'] = $this->url->link('multiseller/product', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_payment'] = $this->url->link('multiseller/payment', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_transactions'] = $this->url->link('multiseller/transaction', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_comments'] = $this->url->link('multiseller/comment', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['ms_link_settings'] = $this->url->link('module/multiseller', 'token=' . $this->session->data['token'], 'SSL'); 
			$this->data['ms_link_badge'] = $this->url->link('multiseller/badge', 'token=' . $this->session->data['token'], 'SSL'); 
			

			$query_review = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "pr_rating'");

			if ($query_review->num_rows <= 0) {
				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_attribute` (
  				`attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  				`name` varchar(255) NOT NULL,
  				`type` tinyint(1) NOT NULL,
  				`review_id` int(11) NOT NULL,
  				`status` tinyint(1) NOT NULL,
  				PRIMARY KEY (`attribute_id`),
  				KEY `review_id` (`review_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_rating` (
  				`rating_id` int(11) NOT NULL AUTO_INCREMENT,
  				`sort_order` int(3) NOT NULL DEFAULT '0',
  				`status` tinyint(1) NOT NULL,
  				PRIMARY KEY (`rating_id`),
  				UNIQUE KEY `rating_id` (`rating_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_rating_description` (
 				 `rating_id` int(11) NOT NULL,
 				 `language_id` int(11) NOT NULL,
 				 `name` varchar(64) NOT NULL,
 				 PRIMARY KEY (`rating_id`,`language_id`),
				  KEY `name` (`name`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_rating_review` (
				  `rating_review_id` int(11) NOT NULL AUTO_INCREMENT,
 				 `review_id` int(11) NOT NULL,
 				 `rating_id` int(11) NOT NULL,
 				 `rating` tinyint(1) NOT NULL,
 				 PRIMARY KEY (`rating_review_id`,`rating_id`),
 				 KEY `review_id` (`review_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_rating_to_store` (
				  `rating_id` int(11) NOT NULL,
 				 `store_id` int(11) NOT NULL,
 				 PRIMARY KEY (`rating_id`,`store_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_reason` (
 				 `reason_id` int(11) NOT NULL AUTO_INCREMENT,
 				 `status` tinyint(1) NOT NULL,
 				 PRIMARY KEY (`reason_id`),
				  UNIQUE KEY `reason_id` (`reason_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_reason_description` (
 				 `reason_id` int(11) NOT NULL,
  				`language_id` int(11) NOT NULL,
  				`name` varchar(255) NOT NULL,
 				 PRIMARY KEY (`reason_id`,`language_id`),
  				KEY `name` (`name`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_reason_to_store` (
  				`reason_id` int(11) NOT NULL,
  				`store_id` int(11) NOT NULL,
  				PRIMARY KEY (`reason_id`,`store_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "pr_report` (
  				`report_id` int(11) NOT NULL AUTO_INCREMENT,
  				`title` varchar(255) NOT NULL,
  				`reported` varchar(94) NOT NULL,
  				`review_id` int(11) NOT NULL,
  				`customer_id` int(11) NOT NULL,
  				`store_id` int(11) NOT NULL,
  				`date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  				PRIMARY KEY (`report_id`,`store_id`),
  				UNIQUE KEY `report_id` (`report_id`),
  				KEY `review_id` (`review_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` DROP 'vote_yes'");
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` DROP 'vote_no'");
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` DROP 'image'");

				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` ADD `vote_yes` INT(9) NOT NULL DEFAULT '0'");
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` ADD `vote_no` INT(9) NOT NULL DEFAULT '0'");
				$this->db->query("ALTER TABLE `" . DB_PREFIX . "review` ADD `image` varchar(255) NOT NULL DEFAULT ''");
			}
			
			if (isset($this->request->get['route']) && $this->config->get('config_product_reviews_status')) {
				if (((trim($this->request->get['route']) == 'catalog/review' || substr($this->request->get['route'], 0-strlen('catalog/review')) == 'catalog/review') && !stristr($this->request->get['route'], 'product_review'))) {
					$this->redirect($this->url->link('product_review/review', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}
			
			$this->data['stores'] = array();
			
			$this->load->model('setting/store');
			
			$results = $this->model_setting_store->getStores();
			
			foreach ($results as $result) {
				$this->data['stores'][] = array(
					'name' => $result['name'],
					'href' => $result['url']
				);
			}			
		}
		
		
			$this->template = 'admin_theme/base5builder_circloid/common/header.tpl';
			
		
if (isset($this->session->data['token'])) { $this->data['product'] = $this->ocw->buildURL('catalog/product_manager', 'token=' . $this->session->data['token'], 'SSL'); }
		$this->render();
	}
}
?>