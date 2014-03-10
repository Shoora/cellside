<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

				
				<link rel="stylesheet" type="text/css" href="view/stylesheet/fontselector.css" />
                <?php if(isset($list_link_google_fonts_options)){ ?>
                <link href='http://fonts.googleapis.com/css?family=<?php foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                                echo str_replace(" ", "+", $list_link_google_fonts['key'])."|";
                            } ?>' rel='stylesheet' type='text/css'/>
                <?php } ?>
                <script type="text/javascript" src="view/javascript/jquery/jquery.fontselector.js"></script>
				
			
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="view/javascript/jquery/superfish/js/superfish.js"></script>
<script type="text/javascript" src="view/javascript/common.js"></script>

				<script type="text/javascript"> if (!window.console) console = {log: function() {}}; var msGlobals = { config_admin_limit: '<?php echo $this->config->get('config_admin_limit'); ?>', config_language: <?php echo $dt_language; ?> }; </script>
			
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript">
//-----------------------------------------
// Confirm Actions (delete, uninstall)
//-----------------------------------------
$(document).ready(function(){
    // Confirm Delete
    $('#form').submit(function(){
        if ($(this).attr('action').indexOf('delete',1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
    // Confirm Uninstall
    $('a').click(function(){
        if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
        });
    </script>
</head>
<body>
<div id="container">
    <div id="header">
  <div class="div1">
    <div class="div2"><img src="view/image/logo.png" title="<?php echo $heading_title; ?>" onclick="location = '<?php echo $home; ?>'" /></div>
    <?php if ($logged) { ?>
    <div class="div3"><img src="view/image/lock.png" alt="" style="position: relative; top: 3px;" />&nbsp;<?php echo $logged; ?></div>
    <?php } ?>
  </div>
  <?php if ($logged) { ?>
  <div id="menu">
    <ul class="left" style="display: none;">
      <li id="dashboard"><a href="<?php echo $home; ?>" class="top"><?php echo $text_dashboard; ?></a></li>
      <li id="catalog"><a class="top"><?php echo $text_catalog; ?></a>
        <ul>
          <li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
          <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
<li><a class="parent">SEO</a>
			<ul>			
			<li><a href="<?php echo $seopack; ?>"><?php echo $text_seopack; ?></a></li>
			<li><a href="<?php echo $seoimages; ?>"><?php echo $text_seoimages; ?></a></li>
			<li>
				<?php if (file_exists(DIR_APPLICATION.'controller/catalog/autolinks.php')) { ?>
				<a href="<?php echo $autolinks; ?>"><?php echo $text_autolinks; ?></a>
				<?php } else { ?>
				<a onclick="alert('Auto Internal Links is not installed!\nYou can purchase Auto Internal Links from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=5650\nor you can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="button"><?php echo $text_autolinks; ?></a>
				<?php } ?>
			</li>
			<li>
				<?php if (file_exists(DIR_APPLICATION.'controller/catalog/seoeditor.php')) { ?>
				<a href="<?php echo $seoeditor; ?>"><?php echo $text_seoeditor; ?></a>
				<?php } else { ?>
				<a onclick="alert('Advanced SEO Editor is not installed!\nYou can purchase Advanced SEO Editor from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6183\nor you can purchase the whole Opencart SEO Pack PRO:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=6182');" class="button"><?php echo $text_seoeditor; ?></a>
				<?php } ?>
			</li>
			<li><a href="<?php echo $seoreport; ?>"><?php echo $text_seoreport; ?></a></li>
			</ul>
			</li>
          <li><a href="<?php echo $filter; ?>"><?php echo $text_filter; ?></a></li>
          <li><a href="<?php echo $profile; ?>"><?php echo $text_profile; ?></a></li>
          <li><a class="parent"><?php echo $text_attribute; ?></a>
            <ul>
              <li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
              <li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>

			  <li><a class="parent">Product Reviews</a>
                <ul>
				  <li><a href="<?php echo $product_reviews_review; ?>">Reviews</a></li>
				  <li><a href="<?php echo $product_reviews_rating; ?>">Manage ratings</a></li>
				  <li><a href="<?php echo $product_reviews_report; ?>">Abuse reports</a></li>
				  <li><a href="<?php echo $product_reviews_attribute; ?>">Pros and Cons</a></li>
				  <li><a href="<?php echo $product_reviews_optimize; ?>">Optimize tables</a></li>
				</ul>
			  </li>
          <li><a href="<?php echo $review; ?>"><?php echo $text_review; ?></a></li>

          <?php if(isset($qap)) { ?>
          <li><a href="<?php echo $qap; ?>"><?php echo $text_questions_and_answers; ?></a></li>
          <?php } ?>
            
          <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
<li><a href="<?php echo $testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
        </ul>
      </li>
      <li id="extension"><a class="top"><?php echo $text_extension; ?></a>
        <ul>
          <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
          <li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
          <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
          <li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
          <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
          <li><a href="<?php echo $googleprint; ?>"><?php echo $text_googleprint; ?></a></li>
            <li><a class="parent"><?php echo $text_openbay_extension; ?></a>
                <ul>
                    <li><a href="<?php echo $openbay_link_extension; ?>"><?php echo $text_openbay_dashboard; ?></a></li>
                    <li><a href="<?php echo $openbay_link_orders; ?>"><?php echo $text_openbay_orders; ?></a></li>
                    <li><a href="<?php echo $openbay_link_items; ?>"><?php echo $text_openbay_items; ?></a></li>

                    <?php if($openbay_markets['ebay'] == 1){ ?>
                    <li><a class="parent" href="<?php echo $openbay_link_ebay; ?>"><?php echo $text_openbay_ebay; ?></a>
                        <ul>
                            <li><a href="<?php echo $openbay_link_ebay_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                            <li><a href="<?php echo $openbay_link_ebay_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                            <li><a href="<?php echo $openbay_link_ebay_orderimport; ?>"><?php echo $text_openbay_order_import; ?></a></li>
                       </ul>
                    </li>
                    <?php } ?>

                    <?php if($openbay_markets['amazon'] == 1){ ?>
                    <li><a class="parent" href="<?php echo $openbay_link_amazon; ?>"><?php echo $text_openbay_amazon; ?></a>
                        <ul>
                            <li><a href="<?php echo $openbay_link_amazon_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                            <li><a href="<?php echo $openbay_link_amazon_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                        </ul>
                    </li>
                    <?php } ?>

                    <?php if($openbay_markets['amazonus'] == 1){ ?>
                    <li><a class="parent" href="<?php echo $openbay_link_amazonus; ?>"><?php echo $text_openbay_amazonus; ?></a>
                        <ul>
                            <li><a href="<?php echo $openbay_link_amazonus_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                            <li><a href="<?php echo $openbay_link_amazonus_links; ?>"><?php echo $text_openbay_links; ?></a></li>
                        </ul>
                    </li>
                    <?php } ?>

                    <?php if($openbay_markets['play'] == 1){ ?>
                    <li><a class="parent" href="<?php echo $openbay_link_play; ?>"><?php echo $text_openbay_play; ?></a>
                        <ul>
                            <li><a href="<?php echo $openbay_link_play_settings; ?>"><?php echo $text_openbay_settings; ?></a></li>
                            <li><a href="<?php echo $openbay_link_play_report_price; ?>"><?php echo $text_openbay_report_price; ?></a></li>
                        </ul>
                    </li>
                    <?php } ?>
                </ul>
            </li>
        </ul>
      </li>
      <li id="sale"><a class="top"><?php echo $text_sale; ?></a>
        <ul>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $recurring_profile; ?>"><?php echo $text_recurring_profile; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a class="parent"><?php echo $text_customer; ?></a>
            <ul>
              <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
              <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
              <li><a href="<?php echo $customer_ban_ip; ?>"><?php echo $text_customer_ban_ip; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
          <li><a class="parent"><?php echo $text_voucher; ?></a>
            <ul>
              <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
            </ul>
          </li>
          <!-- PAYPAL MANAGE NAVIGATION LINK -->
          <?php if ($pp_express_status) { ?>
           <li><a class="parent" href="<?php echo $paypal_express; ?>"><?php echo $text_paypal_express; ?></a>
             <ul>
               <li><a href="<?php echo $paypal_express_search; ?>"><?php echo $text_paypal_express_search; ?></a></li>
             </ul>
           </li>
          <?php } ?>
          <!-- PAYPAL MANAGE NAVIGATION LINK END -->
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
        </ul>
      </li>
      <li id="system"><a class="top"><?php echo $text_system; ?></a>
        <ul>
          <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
          <li><a class="parent"><?php echo $text_design; ?></a>
            <ul>
              <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
              <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_users; ?></a>
            <ul>
              <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
              <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_localisation; ?></a>
            <ul>
              <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
              <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
              <li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
              <li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
              <li><a class="parent"><?php echo $text_return; ?></a>
                <ul>
                  <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                  <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                  <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                </ul>
              </li>
              <li><a href="<?php echo $country; ?>"><?php echo $text_country; ?></a></li>
              <li><a href="<?php echo $zone; ?>"><?php echo $text_zone; ?></a></li>
              <li><a href="<?php echo $geo_zone; ?>"><?php echo $text_geo_zone; ?></a></li>
              <li><a class="parent"><?php echo $text_tax; ?></a>
                <ul>
                  <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                  <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                </ul>
              </li>
              <li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
              <li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
          <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
          <li><a href="<?php echo $template_email; ?>"><?php echo $text_template_email; ?></a></li>
        </ul>
      </li>
      <li id="reports"><a class="top"><?php echo $text_reports; ?></a>
        <ul>
          <li><a class="parent"><?php echo $text_sale; ?></a>
            <ul>
              <li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
              <li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
              <li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
              <li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
              <li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_product; ?></a>
            <ul>
              <li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
              <li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_customer; ?></a>
            <ul>
              <li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
              <li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
              <li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
              <li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_affiliate; ?></a>
            <ul>
              <li><a href="<?php echo $report_affiliate_commission; ?>"><?php echo $text_report_affiliate_commission; ?></a></li>
            </ul>
          </li>
        </ul>
      </li>

				<?php if($pavblog_installed): ?>
				<li id="pavblogs"><a class="top"><?php echo $text_pavblog_blog; ?></a>
					<ul>
			          <li><a href="<?php echo $pavblogs_category; ?>"><?php echo $text_pavblog_manage_cate; ?></a></li>
			          <li><a href="<?php echo $pavblogs_blogs; ?>"><?php echo $text_pavblog_manage_blog; ?></a></li>
			          <li><a href="<?php echo $pavblogs_add_blog; ?>"><?php echo $text_pavblog_add_blog; ?></a></li>
			          <li><a href="<?php echo $pavblogs_comments; ?>"><?php echo $text_pavblog_manage_comment; ?></a></li>
			          <li><a href="<?php echo $pavblogs_general; ?>"><?php echo $text_pavblog_general_setting; ?></a></li>
			          <li><a class="parent"><?php echo $text_pavblog_front_mods; ?></a>
					      <ul>
			                  <li><a href="<?php echo $pavblogs_category_mod; ?>"><?php echo $text_pavblog_category; ?></a></li>
			                  <li><a href="<?php echo $pavblogs_latest_comment_mod; ?>"><?php echo $text_pavblog_comment; ?></a></li>
			                  <li><a href="<?php echo $pavblogs_latest_mod; ?>"><?php echo $text_pavblog_latest; ?></a></li>
		                  </ul>
		              </li>
			        </ul>
			    </li>
			    <?php endif; ?>
				
      <li id="help"><a class="top"><?php echo $text_help; ?></a>
        <ul>
          <li><a href="http://www.opencart.com" target="_blank"><?php echo $text_opencart; ?></a></li>
          <li><a href="http://www.opencart.com/index.php?route=documentation/introduction" target="_blank"><?php echo $text_documentation; ?></a></li>
          <li><a href="http://forum.opencart.com" target="_blank"><?php echo $text_support; ?></a></li>
        </ul>
      </li>
    </ul>

				<ul class="left">
				<li id="multiseller" style="background: url('view/image/split.png') center left no-repeat"><a class="top"><?php echo $ms_menu_multiseller; ?></a>
					<ul>
						<li><a href="<?php echo $ms_link_sellers; ?>"><?php echo $ms_menu_sellers; ?></a></li>
						<li><a href="<?php echo $ms_link_seller_groups; ?>"><?php echo $ms_menu_seller_groups; ?></a></li>
						<li><a href="<?php echo $ms_link_attributes; ?>"><?php echo $ms_menu_attributes; ?></a></li>
						<li><a href="<?php echo $ms_link_products; ?>"><?php echo $ms_menu_products; ?></a></li>
						<li><a href="<?php echo $ms_link_transactions; ?>"><?php echo $ms_menu_transactions; ?></a></li>
						<li><a href="<?php echo $ms_link_payment; ?>"><?php echo $ms_menu_payment; ?></a></li>
						<li><a href="<?php echo $ms_link_badge; ?>"><?php echo $ms_menu_badge; ?></a></li>
						<li><a href="<?php echo $ms_link_comments; ?>"><?php echo $ms_menu_comments; ?></a></li>
						<li><a href="<?php echo $ms_link_settings; ?>"><?php echo $ms_menu_settings; ?></a></li>
					</ul>
				</li>
				</ul>
			

			<ul class="left">
			<li id="clear-all-caches"><a class="top"><?php echo $text_clear_caches; ?></a>
				<ul>
					<li><a href="<?php echo $this->url->link('tool/clearcache/butimage', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_allbutimage; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_all; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache/vqmod', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_vqmod; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache/image', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_image; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache/system', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_system; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache/minify', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_minify; ?></a></li>
					<li><a href="<?php echo $this->url->link('tool/clearcache/seo', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_seo; ?></a></li>
					<?php if (file_exists(DIR_SYSTEM . '../pagecache/caching.php')) { ?><li><a href="<?php echo $this->url->link('tool/clearcache/page', 'token=' . $this->session->data['token'], 'SSL') ?>"><?php echo $text_clear_page; ?></a></li> <?php } ?>
				</ul>
			</li>
			</ul>
			
    <ul class="right" style="display: none;">
      <li id="store"><a href="<?php echo $store; ?>" target="_blank" class="top"><?php echo $text_front; ?></a>
        <ul>
          <?php foreach ($stores as $stores) { ?>
          <li><a href="<?php echo $stores['href']; ?>" target="_blank"><?php echo $stores['name']; ?></a></li>
          <?php } ?>
        </ul>
      </li>
      <li><a class="top" href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
    </ul>
  </div>
  <?php } ?>
</div>
