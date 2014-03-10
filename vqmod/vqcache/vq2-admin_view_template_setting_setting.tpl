<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    
			<div class="heading"><h1><img src="view/image/admin_theme/base5builder_circloid/icon-settings.png" alt="<?php echo $heading_title; ?>" width="32" height="32" /> <?php echo $heading_title; ?></h1>
			

      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a><a href="#tab-store"><?php echo $tab_store; ?></a><a href="#tab-local"><?php echo $tab_local; ?></a><a href="#tab-option"><?php echo $tab_option; ?></a><a href="#tab-image"><?php echo $tab_image; ?></a><a href="#tab-ftp"><?php echo $tab_ftp; ?></a><a href="#tab-mail"><?php echo $tab_mail; ?></a><a href="#tab-fraud"><?php echo $tab_fraud; ?></a><a href="#tab-server"><?php echo $tab_server; ?></a><a href="#tab-ips"><?php echo $tab_ips; ?></a><a href="#tab-contact"><?php echo $tab_contact; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_name; ?></td>
              <td><input type="text" name="config_name" value="<?php echo $config_name; ?>" size="40" />
                <?php if ($error_name) { ?>
                <span class="error"><?php echo $error_name; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_owner; ?></td>
              <td><input type="text" name="config_owner" value="<?php echo $config_owner; ?>" size="40" />
                <?php if ($error_owner) { ?>
                <span class="error"><?php echo $error_owner; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_address; ?></td>
              <td><textarea name="config_address" cols="40" rows="5"><?php echo $config_address; ?></textarea>
                <?php if ($error_address) { ?>
                <span class="error"><?php echo $error_address; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_email; ?></td>
              <td><input type="text" name="config_email" value="<?php echo $config_email; ?>" size="40" />
                <?php if ($error_email) { ?>
                <span class="error"><?php echo $error_email; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
              <td><input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" />
                <?php if ($error_telephone) { ?>
                <span class="error"><?php echo $error_telephone; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_fax; ?></td>
              <td><input type="text" name="config_fax" value="<?php echo $config_fax; ?>" /></td>
            </tr>
          </table>
        </div>
        <div id="tab-store">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_title; ?></td>
              <td><input type="text" name="config_title" value="<?php echo $config_title; ?>" />
                <?php if ($error_title) { ?>
                <span class="error"><?php echo $error_title; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_meta_description; ?></td>
              <td><textarea name="config_meta_description" cols="40" rows="5"><?php echo $config_meta_description; ?></textarea></td>
            </tr>

				<tr>
				  <td><?php echo $entry_meta_keywords; ?></td>
				  <td><textarea name="config_meta_keywords" cols="40" rows="5"><?php echo $config_meta_keywords; ?></textarea></td>
				</tr>
				
            <tr>
              <td><?php echo $entry_template; ?></td>
              <td><select name="config_template" onchange="$('#template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value));">
                  <?php foreach ($templates as $template) { ?>
                  <?php if ($template == $config_template) { ?>
                  <option value="<?php echo $template; ?>" selected="selected"><?php echo $template; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $template; ?>"><?php echo $template; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td></td>
              <td id="template"></td>
            </tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="config_layout_id">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $config_layout_id) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-local">
          <table class="form">
            <tr>
              <td><?php echo $entry_country; ?></td>
              <td><select name="config_country_id">
                  <?php foreach ($countries as $country) { ?>
                  <?php if ($country['country_id'] == $config_country_id) { ?>
                  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_zone; ?></td>
              <td><select name="config_zone_id">
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_language; ?></td>
              <td><select name="config_language">
                  <?php foreach ($languages as $language) { ?>
                  <?php if ($language['code'] == $config_language) { ?>
                  <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_admin_language; ?></td>
              <td><select name="config_admin_language">
                  <?php foreach ($languages as $language) { ?>
                  <?php if ($language['code'] == $config_admin_language) { ?>
                  <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_currency; ?></td>
              <td><select name="config_currency">
                  <?php foreach ($currencies as $currency) { ?>
                  <?php if ($currency['code'] == $config_currency) { ?>
                  <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_currency_auto; ?></td>
              <td><?php if ($config_currency_auto) { ?>
                <input type="radio" name="config_currency_auto" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_currency_auto" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_currency_auto" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_currency_auto" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_length_class; ?></td>
              <td><select name="config_length_class_id">
                  <?php foreach ($length_classes as $length_class) { ?>
                  <?php if ($length_class['length_class_id'] == $config_length_class_id) { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>" selected="selected"><?php echo $length_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $length_class['length_class_id']; ?>"><?php echo $length_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_weight_class; ?></td>
              <td><select name="config_weight_class_id">
                  <?php foreach ($weight_classes as $weight_class) { ?>
                  <?php if ($weight_class['weight_class_id'] == $config_weight_class_id) { ?>
                  <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-option">
          <h2><?php echo $text_items; ?></h2>
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_catalog_limit; ?></td>
              <td><input type="text" name="config_catalog_limit" value="<?php echo $config_catalog_limit; ?>" size="3" />
                <?php if ($error_catalog_limit) { ?>
                <span class="error"><?php echo $error_catalog_limit; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_admin_limit; ?></td>
              <td><input type="text" name="config_admin_limit" value="<?php echo $config_admin_limit; ?>" size="3" />
                <?php if ($error_admin_limit) { ?>
                <span class="error"><?php echo $error_admin_limit; ?></span>
                <?php } ?></td>
            </tr>
          </table>
          <h2><?php echo $text_product; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_product_count; ?></td>
              <td><?php if ($config_product_count) { ?>
                <input type="radio" name="config_product_count" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_product_count" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_product_count" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_product_count" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_review; ?></td>
              <td><?php if ($config_review_status) { ?>
                <input type="radio" name="config_review_status" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_review_status" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_review_status" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_review_status" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_download; ?></td>
              <td><?php if ($config_download) { ?>
                <input type="radio" name="config_download" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_download" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_download" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_download" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>          
          </table>
          <h2><?php echo $text_voucher; ?></h2>
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_voucher_min; ?></td>
              <td><input type="text" name="config_voucher_min" value="<?php echo $config_voucher_min; ?>" />
                <?php if ($error_voucher_min) { ?>
                <span class="error"><?php echo $error_voucher_min; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_voucher_max; ?></td>
              <td><input type="text" name="config_voucher_max" value="<?php echo $config_voucher_max; ?>" />
                <?php if ($error_voucher_max) { ?>
                <span class="error"><?php echo $error_voucher_max; ?></span>
                <?php } ?></td>
            </tr>
          </table>
          <h2><?php echo $text_tax; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_tax; ?></td>
              <td><?php if ($config_tax) { ?>
                <input type="radio" name="config_tax" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_tax" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_tax" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_tax" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_vat; ?></td>
              <td><?php if ($config_vat) { ?>
                <input type="radio" name="config_vat" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_vat" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_vat" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_vat" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_tax_default; ?></td>
              <td><select name="config_tax_default">
                  <option value=""><?php echo $text_none; ?></option>
                  <?php  if ($config_tax_default == 'shipping') { ?>
                  <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                  <?php } else { ?>
                  <option value="shipping"><?php echo $text_shipping; ?></option>
                  <?php } ?>
                  <?php  if ($config_tax_default == 'payment') { ?>
                  <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                  <?php } else { ?>
                  <option value="payment"><?php echo $text_payment; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_tax_customer; ?></td>
              <td><select name="config_tax_customer">
                  <option value=""><?php echo $text_none; ?></option>
                  <?php  if ($config_tax_customer == 'shipping') { ?>
                  <option value="shipping" selected="selected"><?php echo $text_shipping; ?></option>
                  <?php } else { ?>
                  <option value="shipping"><?php echo $text_shipping; ?></option>
                  <?php } ?>
                  <?php  if ($config_tax_customer == 'payment') { ?>
                  <option value="payment" selected="selected"><?php echo $text_payment; ?></option>
                  <?php } else { ?>
                  <option value="payment"><?php echo $text_payment; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
          <h2><?php echo $text_account; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_customer_online; ?></td>
              <td><?php if ($config_customer_online) { ?>
                <input type="radio" name="config_customer_online" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_customer_online" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_customer_online" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_customer_online" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_group; ?></td>
              <td><select name="config_customer_group_id">
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php if ($customer_group['customer_group_id'] == $config_customer_group_id) { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_group_display; ?></td>
              <td><div class="scrollbox">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($customer_group['customer_group_id'], $config_customer_group_display)) { ?>
                    <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                    <?php echo $customer_group['name']; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="config_customer_group_display[]" value="<?php echo $customer_group['customer_group_id']; ?>" />
                    <?php echo $customer_group['name']; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
                <?php if ($error_customer_group_display) { ?>
                <span class="error"><?php echo $error_customer_group_display; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_customer_price; ?></td>
              <td><?php if ($config_customer_price) { ?>
                <input type="radio" name="config_customer_price" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_customer_price" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_customer_price" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_customer_price" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_account; ?></td>
              <td><select name="config_account_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($informations as $information) { ?>
                  <?php if ($information['information_id'] == $config_account_id) { ?>
                  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
          <h2><?php echo $text_checkout; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_cart_weight; ?></td>
              <td><?php if ($config_cart_weight) { ?>
                <input type="radio" name="config_cart_weight" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_cart_weight" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_cart_weight" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_cart_weight" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_guest_checkout; ?></td>
              <td><?php if ($config_guest_checkout) { ?>
                <input type="radio" name="config_guest_checkout" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_guest_checkout" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_guest_checkout" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_guest_checkout" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_checkout; ?></td>
              <td><select name="config_checkout_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($informations as $information) { ?>
                  <?php if ($information['information_id'] == $config_checkout_id) { ?>
                  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_order_edit; ?></td>
              <td><input type="text" name="config_order_edit" value="<?php echo $config_order_edit; ?>" size="3" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_invoice_prefix; ?></td>
              <td><input type="text" name="config_invoice_prefix" value="<?php echo $config_invoice_prefix; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_order_status; ?></td>
              <td><select name="config_order_status_id">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $config_order_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_complete_status; ?></td>
              <td><select name="config_complete_status_id">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $config_complete_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
          <h2><?php echo $text_stock; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_stock_display; ?></td>
              <td><?php if ($config_stock_display) { ?>
                <input type="radio" name="config_stock_display" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_display" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_stock_display" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_display" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_stock_warning; ?></td>
              <td><?php if ($config_stock_warning) { ?>
                <input type="radio" name="config_stock_warning" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_warning" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_stock_warning" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_warning" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_stock_checkout; ?></td>
              <td><?php if ($config_stock_checkout) { ?>
                <input type="radio" name="config_stock_checkout" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_checkout" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_stock_checkout" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_stock_checkout" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_stock_status; ?></td>
              <td><select name="config_stock_status_id">
                  <?php foreach ($stock_statuses as $stock_status) { ?>
                  <?php if ($stock_status['stock_status_id'] == $config_stock_status_id) { ?>
                  <option value="<?php echo $stock_status['stock_status_id']; ?>" selected="selected"><?php echo $stock_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $stock_status['stock_status_id']; ?>"><?php echo $stock_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
          <h2><?php echo $text_affiliate; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_affiliate; ?></td>
              <td><select name="config_affiliate_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($informations as $information) { ?>
                  <?php if ($information['information_id'] == $config_affiliate_id) { ?>
                  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_commission; ?></td>
              <td><input type="text" name="config_commission" value="<?php echo $config_commission; ?>" size="3" /></td>
            </tr>
          </table>
          <h2><?php echo $text_return; ?></h2>
          <table class="form">
            <tr>
              <td><?php echo $entry_return; ?></td>
              <td><select name="config_return_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($informations as $information) { ?>
                  <?php if ($information['information_id'] == $config_return_id) { ?>
                  <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_return_status; ?></td>
              <td><select name="config_return_status_id">
                  <?php foreach ($return_statuses as $return_status) { ?>
                  <?php if ($return_status['return_status_id'] == $config_return_status_id) { ?>
                  <option value="<?php echo $return_status['return_status_id']; ?>" selected="selected"><?php echo $return_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-image">
          <table class="form">
            <tr>
              <td><?php echo $entry_logo; ?></td>
              <td><div class="image"><img src="<?php echo $logo; ?>" alt="" id="thumb-logo" />
                  <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="logo" />
                  <br />
                  <a onclick="image_upload('logo', 'thumb-logo');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb-logo').attr('src', '<?php echo $no_image; ?>'); $('#logo').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
            </tr>
            <tr>
              <td><?php echo $entry_icon; ?></td>
              <td><div class="image"><img src="<?php echo $icon; ?>" alt="" id="thumb-icon" />
                  <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="icon" />
                  <br />
                  <a onclick="image_upload('icon', 'thumb-icon');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb-icon').attr('src', '<?php echo $no_image; ?>'); $('#icon').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_category; ?></td>
              <td><input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" size="3" />
                x
                <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" size="3" />
                <?php if ($error_image_category) { ?>
                <span class="error"><?php echo $error_image_category; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_thumb; ?></td>
              <td><input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" size="3" />
                x
                <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" size="3" />
                <?php if ($error_image_thumb) { ?>
                <span class="error"><?php echo $error_image_thumb; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_popup; ?></td>
              <td><input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" size="3" />
                x
                <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" size="3" />
                <?php if ($error_image_popup) { ?>
                <span class="error"><?php echo $error_image_popup; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_product; ?></td>
              <td><input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" size="3" />
                x
                <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" size="3" />
                <?php if ($error_image_product) { ?>
                <span class="error"><?php echo $error_image_product; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_additional; ?></td>
              <td><input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" size="3" />
                x
                <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" size="3" />
                <?php if ($error_image_additional) { ?>
                <span class="error"><?php echo $error_image_additional; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_related; ?></td>
              <td><input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" size="3" />
                x
                <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" size="3" />
                <?php if ($error_image_related) { ?>
                <span class="error"><?php echo $error_image_related; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_compare; ?></td>
              <td><input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" size="3" />
                x
                <input type="text" name="config_image_compare_height" value="<?php echo $config_image_compare_height; ?>" size="3" />
                <?php if ($error_image_compare) { ?>
                <span class="error"><?php echo $error_image_compare; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_wishlist; ?></td>
              <td><input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" size="3" />
                x
                <input type="text" name="config_image_wishlist_height" value="<?php echo $config_image_wishlist_height; ?>" size="3" />
                <?php if ($error_image_wishlist) { ?>
                <span class="error"><?php echo $error_image_wishlist; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_image_cart; ?></td>
              <td><input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" size="3" />
                x
                <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" size="3" />
                <?php if ($error_image_cart) { ?>
                <span class="error"><?php echo $error_image_cart; ?></span>
                <?php } ?></td>
            </tr>
          </table>
        </div>
        <div id="tab-ftp">
          <table class="form">
            <tr>
              <td><?php echo $entry_ftp_host; ?></td>
              <td><input type="text" name="config_ftp_host" value="<?php echo $config_ftp_host; ?>" />
                <?php if ($error_ftp_host) { ?>
                <span class="error"><?php echo $error_ftp_host; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_ftp_port; ?></td>
              <td><input type="text" name="config_ftp_port" value="<?php echo $config_ftp_port; ?>" />
                <?php if ($error_ftp_port) { ?>
                <span class="error"><?php echo $error_ftp_port; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_ftp_username; ?></td>
              <td><input type="text" name="config_ftp_username" value="<?php echo $config_ftp_username; ?>" />
                <?php if ($error_ftp_username) { ?>
                <span class="error"><?php echo $error_ftp_username; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_ftp_password; ?></td>
              <td><input type="text" name="config_ftp_password" value="<?php echo $config_ftp_password; ?>" />
                <?php if ($error_ftp_password) { ?>
                <span class="error"><?php echo $error_ftp_password; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_ftp_root; ?></td>
              <td><input type="text" name="config_ftp_root" value="<?php echo $config_ftp_root; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_ftp_status; ?></td>
              <td><?php if ($config_ftp_status) { ?>
                <input type="radio" name="config_ftp_status" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_ftp_status" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_ftp_status" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_ftp_status" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
          </table>
        </div>
        <div id="tab-mail">
          <table class="form">
            <tr>
              <td><?php echo $entry_mail_protocol; ?></td>
              <td><select name="config_mail_protocol">
                  <?php if ($config_mail_protocol == 'mail') { ?>
                  <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                  <?php } else { ?>
                  <option value="mail"><?php echo $text_mail; ?></option>
                  <?php } ?>
                  <?php if ($config_mail_protocol == 'smtp') { ?>
                  <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                  <?php } else { ?>
                  <option value="smtp"><?php echo $text_smtp; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_mail_parameter; ?></td>
              <td><input type="text" name="config_mail_parameter" value="<?php echo $config_mail_parameter; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_host; ?></td>
              <td><input type="text" name="config_smtp_host" value="<?php echo $config_smtp_host; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_username; ?></td>
              <td><input type="text" name="config_smtp_username" value="<?php echo $config_smtp_username; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_password; ?></td>
              <td><input type="text" name="config_smtp_password" value="<?php echo $config_smtp_password; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_port; ?></td>
              <td><input type="text" name="config_smtp_port" value="<?php echo $config_smtp_port; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_smtp_timeout; ?></td>
              <td><input type="text" name="config_smtp_timeout" value="<?php echo $config_smtp_timeout; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_alert_mail; ?></td>
              <td><?php if ($config_alert_mail) { ?>
                <input type="radio" name="config_alert_mail" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_alert_mail" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_alert_mail" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_alert_mail" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_account_mail; ?></td>
              <td><?php if ($config_account_mail) { ?>
                <input type="radio" name="config_account_mail" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_account_mail" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_account_mail" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_account_mail" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_alert_emails; ?></td>
              <td><textarea name="config_alert_emails" cols="40" rows="5"><?php echo $config_alert_emails; ?></textarea></td>
            </tr>
          </table>
        </div>
        <div id="tab-fraud">
          <table class="form">
            <tr>
              <td><?php echo $entry_fraud_detection; ?></td>
              <td><?php if ($config_fraud_detection) { ?>
                <input type="radio" name="config_fraud_detection" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_fraud_detection" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_fraud_detection" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_fraud_detection" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_fraud_key; ?></td>
              <td><input type="text" name="config_fraud_key" value="<?php echo $config_fraud_key; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_fraud_score; ?></td>
              <td><input type="text" name="config_fraud_score" value="<?php echo $config_fraud_score; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_fraud_status; ?></td>
              <td><select name="config_fraud_status_id">
                  <?php foreach ($order_statuses as $order_status) { ?>
                  <?php if ($order_status['order_status_id'] == $config_fraud_status_id) { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-server">
          <table class="form">
            <tr>
              <td><?php echo $entry_secure; ?></td>
              <td><?php if ($config_secure) { ?>
                <input type="radio" name="config_secure" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_secure" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_secure" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_secure" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_shared; ?></td>
              <td><?php if ($config_shared) { ?>
                <input type="radio" name="config_shared" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_shared" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_shared" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_shared" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_robots; ?></td>
              <td><textarea name="config_robots" cols="40" rows="5"><?php echo $config_robots; ?></textarea></td>
            </tr>                    
            <tr>
              <td><?php echo $entry_seo_url; ?></td>
              <td><?php if ($config_seo_url) { ?>
                <input type="radio" name="config_seo_url" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_seo_url" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_seo_url" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_seo_url" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_file_extension_allowed; ?></td>
              <td><textarea name="config_file_extension_allowed" cols="40" rows="5"><?php echo $config_file_extension_allowed; ?></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_file_mime_allowed; ?></td>
              <td><textarea name="config_file_mime_allowed" cols="60" rows="5"><?php echo $config_file_mime_allowed; ?></textarea></td>
            </tr>              
            <tr>
              <td><?php echo $entry_maintenance; ?></td>
              <td><?php if ($config_maintenance) { ?>
                <input type="radio" name="config_maintenance" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_maintenance" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_maintenance" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_maintenance" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_password; ?></td>
              <td><?php if ($config_password) { ?>
                <input type="radio" name="config_password" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_password" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_password" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_password" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>            
            <tr>
              <td><?php echo $entry_encryption; ?></td>
              <td><input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>" />
                <?php if ($error_encryption) { ?>
                <span class="error"><?php echo $error_encryption; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_compression; ?></td>
              <td><input type="text" name="config_compression" value="<?php echo $config_compression; ?>" size="3" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_error_display; ?></td>
              <td><?php if ($config_error_display) { ?>
                <input type="radio" name="config_error_display" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_error_display" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_error_display" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_error_display" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_error_log; ?></td>
              <td><?php if ($config_error_log) { ?>
                <input type="radio" name="config_error_log" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_error_log" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="config_error_log" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="config_error_log" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_error_filename; ?></td>
              <td><input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>" />
                <?php if ($error_error_filename) { ?>
                <span class="error"><?php echo $error_error_filename; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_google_analytics; ?></td>
              <td><textarea name="config_google_analytics" cols="40" rows="5"><?php echo $config_google_analytics; ?></textarea></td>
            </tr>
          </table>
        </div>
		<div id="tab-contact">
          <table class="form">
            <tr>
              <td><?php echo $entry_map; ?></td>
              <td><textarea name="config_map" cols="100" rows="10"><?php echo $config_map; ?></textarea></td>
            </tr>
          </table>
        </div>

			<div id="tab-ips">
					<link rel="stylesheet" type="text/css" href="data:text/css;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4NCi5qcXVlcnktbXNnYm94IHsgYmFja2dyb3VuZDp1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFBWUFBQUEzQ0FNQUFBQVlOTXR5QUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQUFBWlFURlJGN3U3dTRPRGdmL3ROdkFBQUFCSkpSRUZVZU5waVlBUURobEV3UUFBZ3dBQUtjZ0FIY2N5am1RQUFBQUJKUlU1RXJrSmdnZz09KSByZXBlYXQteCBsZWZ0IGJvdHRvbTsgcGFkZGluZy1ib3R0b206NTVweDsgZm9udC1zdHlsZTpub3JtYWw7IH0NCi5qcXVlcnktbXNnYm94LXdyYXBwZXIgeyBwYWRkaW5nOjIwcHggMjBweCA0MHB4IDEwMHB4OyB9DQouanF1ZXJ5LW1zZ2JveC1idXR0b25zIHsgcGFkZGluZzoxNXB4OyB0ZXh0LWFsaWduOnJpZ2h0OyBwb3NpdGlvbjphYnNvbHV0ZTsgYm90dG9tOjA7IHJpZ2h0OjA7IH0NCi5qcXVlcnktbXNnYm94LWJ1dHRvbnMgYnV0dG9uLCAuanF1ZXJ5LW1zZ2JveC1idXR0b25zIGlucHV0IHsgbWFyZ2luLWxlZnQ6MTBweDsgbWluLXdpZHRoOjg1cHg7IHBhZGRpbmc6MCAxNHB4IDJweDsgaGVpZ2h0OjI0cHg7IGN1cnNvcjpwb2ludGVyOyB9DQouanF1ZXJ5LW1zZ2JveC1pbnB1dHMgeyBtYXJnaW4tdG9wOjRweDsgfQ0KLmpxdWVyeS1tc2dib3gtaW5wdXRzIGlucHV0IHsgZGlzcGxheTpibG9jazsgcGFkZGluZzozcHggMnB4OyBib3JkZXI6MXB4IHNvbGlkICNkZGRkZGQ7IG1hcmdpbjozcHggMCA2cHggMDsgd2lkdGg6OTUlOyB9DQouanF1ZXJ5LW1zZ2JveC1sYWJlbCB7IGZvbnQtd2VpZ2h0OmJvbGQ7IGZvbnQtc2l6ZToxMXB4OyB9DQouanF1ZXJ5LW1zZ2JveC1hbGVydCB7IGJhY2tncm91bmQ6IHVybChkYXRhOmltYWdlL3BuZztiYXNlNjQsaVZCT1J3MEtHZ29BQUFBTlNVaEVVZ0FBQUVBQUFBQkFDQVlBQUFDcWFYSGVBQUFBR1hSRldIUlRiMlowZDJGeVpRQkJaRzlpWlNCSmJXRm5aVkpsWVdSNWNjbGxQQUFBRE1OSlJFRlVlTnJzVzJsc1hOVVZQbStaZmJObnZHZTh4ZzR4U1V3aHBTbVEwQVVKaVJLVm9rcjhLNkpRQW1sUW8xUlVrQ0IxWVV1TEZFUmJ0alNsUmJSQ1FFRnNLWFFSTFJRaktFbWNGWk00QzdHZDJJN3RqR2M4bnZITXZIbnY5cnR2SnBtWnpOaGplMlpTa25ERnhmRjdkenZuZnVlYzc5ejdMRERHNkVJdUlsM2c1WUpYZ0V5SHJ2NENBVjhvNE95V3I2RCtFWFVZbFNVci8vY1cxS1ZuZXpFQzYxbVIrcTN0UDZXZDdlRFZEekdEYXdPek5CRXpWR0oyVStJNWk1SVFHeVpoc3BlRWVPQmhyT08rRXE4amhRQWVCay9WVWhZbytrbk4zTEJCY3k2RDhGNDhNYVgySC85bXhuclNYTXRJTTNrMzhMWWxYVXVhek9McFJaUlFmblpneFdQTTNMaWEyUmJyZnBjeUprMnZNakY3QnpGei9XcjAyVlM2QmFVcVppenh6dTlmdm82Wkt0WXkrOFdKQitvb1VleFRZdkhEZUJsTUdxS0RCTG1OeUxpUVNQSVFzeTBpUVpuNHNkcTkvRFBwNHM3SFN3Q0JOQlBROEh1eUZydG8zY3U5VExBOHlteExNQUg4YmF5SFdPZ05Zc3F1bFBENmdvSjQxb1YzcjZNTkZFTVNhWTRPRWlUVGI0TTdycWdwdXZ4cE1wZldCQml0WVpZR3lHT0RZQWVJVGY0ZHowSlRXd0Rlc2NtMzBQWWcrdGlKME5kbWxnWi92cVpSTEpVSkFBRndCc2xhektMdXZlcFNKam52SlVzelVYd0lndjE3R3NFeks0djhDMzFPd0JjMEF6aDJ1dU9tNmlYRlJVQktabEczaDFPMVdNTHZ1VktDSUYxa2JjSnYwYVR3MFV6c1RWZTFDUHE4QjkrZ0V0bWF5RzRSMXdpQ0lCYlZCeVNyWEFyYng1Z3J5ZVFtd1R3UDh1L0diZzZuTVE4RGNPY2lRWFFtZVlDQUdrT2ZDV2d1d0xjL0FZUDRJUG9lSURJdkpvdmoyTzFENzE3K05wVHdHaXRDdkU2WFdTNDI5Sld1Sy9oT3ZTYmFGK2dDc2NrZFNmOENRVVY0ZTBNcmpSeXhVM2hVb2NoNEtMRUlrNVZzRlhWVTBhcVNKUFNnbjQvakNIMjdFQjJBSW94bEM0emNpWWR2NkMrS1lBS3BaSWdWM2ZHdEVxeDE0RFlWUk9FUDhIczR1Zk5tckh3QjlXejFrNjMrTXJJM0x5SlBlWVArS2o0Wm9ORGdQdXArODNXYS84MTJzdHIyUUV4L0lsSkVQaVhCc296TUx1KzFJKyt5VlVEQjB3V2pnSlVJQWJGdFg3VWdkajBsT3JEN0NweFlkRThLYjdLTGZMMWwxUEtkaldTclc1elYxN1BvT3FxN2FoWDEvZU1uMU5oUmliRG9TN0xrUFVETmZCTHNyZVFNRFQzNS9NYTJQK0h4UkxFUUlCTC81VlF0T1BDejFZSWRrSlVkZ085T1RCUk4rVmZBWDNRc3pTbjg2ZDJ3dU1pejVCWjQvcktVbjlMQ3VpbVFzWXdFV3dOZHU4ekpVU0FVdU03VHRXaEVLUHJoc25vbW1qZUpkb1M5V0IreDJQNHp3cHRBdHRyRmVjZHh0VnlwdDgwSWkrQVFGTzBqUHJiZGJ0MjA3Ym5GODRwR2hJckZBOUIvdGVob3dZZ20wc0lmWjhkM29FRVN4MmNRUTJINzJ1UVovVFdNdVIza3lLb3JvYkhHK01OQ3dtSW1EeWlDQ1VUZXYvekxnc0c1WHJUVkk0cGg1NVZqR1REVHF4b2haZnhvZmlTTlFORDRSSFovcFJkajkwQUJEZVIwbGEvditVdkhwWjhMRTVoODczSUJmYmVKcmxZOTBySEpYYm5ablJvbVdUeVJQNHdHQVhkMU12Y1lrK0FVTUgrT05HK2xjZnQzditHVy91OG1nSDdYQzVZcUVoSDZXUGdUU0RBQ3pWSjJqVU1Cd3JIOFIxVGFNV1NLNGR4aktJT1lZejlRNEVWVXJhVEgxalpjTnhlSFdEUVRDTCt6bFBPSU55VysreW95dXNqZWFlaHRsRVNCTXowbGp3SUcwRFkwNVRnc0FoU29FeVNWelNlUFEzN3p2cHRyRFFXYXdOd1JnRDYzaWJZNjdINDFkZ2JDeDMzVEpEbWMzZ1pKRGZWTmYwd3R3d21xc2FuSGlaL1VrU1phYXhFV2Eyak5qWlczelJZRkdRaGdLcmZQUkoxTm1mamJaWGFrRWsvTDduWjRyZ0hZWjNkdTJKNWhCckd4M1ZNdlRCa0N6SUVTVFp0MkhOMFhSSWZJNExtWUhCYmpreS8rck1VK0t3V2t5VHhuQktEOU90blpBSlptUnhxZmdHVmk0ZE5VT0RkbC9MT3BvOG5nQjhrSWtHOGNrS013R0tMUkNZTFpRRmN2c2ErYkRRb0s5Z0hCclYveUNwTGxmb09uWFNjb0xQTEp6UEo4SGdsb2FKb0ljRlFQbHpNYWF4STBPM3FNREJVTFFZNHN2L2pvOFl1OFo4VUhqTDl4Q2NJZTZ6ZTR3ZmdraWJUZ3g3a1hxVU1lLzRzaHE0c29XREJTM2drL3liR3BFU0RGdVNtQkxDbkFwc3J5S2tFTGZvUk9ScExMVzZpeDByQjZwdVFvWGVaWm53ZWcvU1VpT0x0YzNnWVlIb0tBdldrc0RsNWExZlNmdVJFVklTRStsb2dFUXJiek5paWZRUUhjQjhTU0dTUlFMUW5JcnhEdUpURnhkSkRCbW9DWThHRXl1T2VUemRlM2Z0L3YybC9CMHgyek9RK0FFNFFta2pWZjhiL1NZVURublVaUG03NUlOczV0Rm4wamNld3VFcDh3Qkl1cStyUGNEb3d6dWdsRXpONGNGRGhNQWo4SGlDdXA5bnhOTVNoMVVrbU5yeVFkWkRvS0VHR01GUXVvM0NiT2lDS255endyRStDa1I3SlZrbHpXU05yRUhrdytESTRPUlhDWWF4a25UVlBYZUloaW96dXpVK214SHYxZDRzSmlxcjdJQ2FBTUxZUTVvOGs1NDhOUXpBR1M0QXdkN3FwYkR6M1QvdTJTT01HeEZ4ZHowdk9xc2VvaUNOMVAybkJud3NiemhiNnNVSWljSUpEdEI5VEFQaDBkTXhwRFRhR09JbXJDRHdGQnhxcDJjdHZFVjFjc3Nzc3pkNEl6TkFHOC81N3NySVhmRTRtTjdkQUZ5VXBZWmxDWkVvS3pHOHlPQUVBQUtlSFpqYWNyQXVZUkFBcjgyMG0yVlFPZFhucHVuZmZtNmNMaUdTYVFQeGs2K2VkRlJzYkVQeGpMdlpqd0JHei93T3gzL2pTZkQ1R3NaUHNBTVQ0S09FZm1OaVlFMFVhM3d5d1BrYW55SW5KYURNODhlbXV0cFdqSkVONnROYnJua1dRQjZmRjNZVkoxeG1mOFdWVlZTT0NNRDdsQmVqSEZEK2pLbWZ1NDhBdSsvNUpvRU1sVTBVdzNMblBlTlJVS01zSmdQdHNmZmJhOVVaQ05qNWdxR29nRkQ0UDFIU3Z3R2dsOWtROG91OVloclczVlQrVllEUHcrZUZCWFRrR0hNbGdiWDZPeHZKb2NvMzIvNm55bytRVTg3c3ZwQTJaNktNcFBlc3lWalNUS0p0Sk83QzdLMlNHTCtJajF2MEFhNXdKOGs3UjQ2Z3lnb0FMSE9MYUx4TG9ieU9UMmtuZThoNGZGRFlnczJwVEg0dE1sUWNOYkZsNHFXUjMzY1BnemZ6Zmk4VWl4N283d1g2ZzB0OUZoT01UQWZ2Q0NWcktmSExwbng4YVdsL0M0Njh4a2FFWUk0THR2cXFnSFNPT2srbmNYNS9wTU5KSEE3d3pNbFNUSWlTU084UVFvTW9MWVBwcmxHK1ppWWhveVRzbldUSHp0WmI3QW5VREJuZWtveUx3WW1VSUJKNTVhY0wzQjZibmQ1SzRqemJjTkRHKzhjT0VsQ3dtT0JUUWNxS094bzM0S25lelhIOXM4ZFZSZTNVRlZMdVFDNHowSmN5am9pTm9QSmV3bGsyY3BsYmtIYis5K1JIc2RTbmpyOUlWS1BoOHc5RVNiQk52Y2FxNXU0aFFOOE4rZkNEY0ZGc0ZhVFFNbmEwbXNXazR0eTY4N2ZVY1FHdGhISjd2ZnBvSGg5Nm5PSGdEQk9WcTRLWXgxazJCckpYTjFJNVdQKzdiZS9TMjNTYitFelBJQldzNDQrWDJUcDRhTXJrbzR2bmYxZzR6Q3BaZWhnRVl5dWxkUzNmSlZHYSs0SW5nZDZIU1JFSm1FQXZxNVhSVG9EOFBZdUgxZ2h5dkk2S3lpSDN4TnZRVW8yTUpSa0pFTW5VbUZCMy9kNmhRRWFZdTF0aGtMUVZnSkhKbzc2VW12b29YR1E1WXM0ZE1MZjhmYjhMYkZtSk9ON1lkVEhDUnJYUXU1clBMbWwrK3FjK1U5RDhEUE5TYllwR3gxZ2xqc1NjVG11WktUaks5UFJETFlQSGszTHRGR0xNNmNDSy9NdHhzVTJRVnVVRU1kODR6OE93TWg4MHd3alJZZTN6Uy9ScEJORDF2cjVzTVpnZlR3RTVvNThQMmNWWW1TckFYektrQnZnN2JGbXBjRmp1aHkyT2Exa2QxaWZ2Q3ZhK2RWWjM0amxHb3NvQTVhcWhwQWVpUnc2NTB6UzI5bldsVW9JTkxIejcybXV4WFIyL0MyeFp4YkcrMGkwV2dnUzNVOXRWVWFmdVM5KzRpWXl3UmFSWk1WOWdMYjl5TTNENDhVeC9aUEp5d2FkZ0lVdU92KzFJbFBCajJONmU5NG04U0pVdkhtWmlFa2NJSERaSUZzZG9kdC9VZjNlaGVtY29GVVJMakI1SzRoZ1Nta1FtT2wrR3FNUmNaSU8vUTh4YUJncVhFbENmYkVCeEpzb28vVTNxM0VrTkh4TnFXWVd4dmVUbEpMRTVrOXRlVHdCVytxdi9mby9mMGJtN1IwSG5DTjBlV0IwL2dFMFRKSUpTa0liU3lNM1RqK1QyTERIK3JFS01HTUVmcjRZUWkvRUNuVko2dXhnQzZid1ZsUEV0SFg4ZVNYa0QyU3pnTmFKRkZOSmp4VXdzSjB1c3VVS0ozdG9vMkNJbGRYOHhoVFMvd3J4UHQ2bGZSUFphMFVIZ0NCT1BzTE8ydEY0U1JyZ0h0R3pnbzUvRUxwSnVEVHhnZTgwbm4rTjFUYXhCQXBjZjFiUEs0RU9mMVQyWGVpd1VoeENNam51Q3FoS0kxT3FQeUNrbjliSUtRVG9hZEM0MGdPVllHS1N3QStQMVZWUlFvRkpIcXBLOFF2VUFSZEFXa05EcXFLOElEZjc0WVN4UE51NTFWVm9vQy9uSGIzeHpjLzBhbmYwT3JYS3hsZml6YzkwUC9UVU5qNDRKaXZnc0loRzZseDZkd1hIREp3V2NaOEh0clpLMjVlK2ZzVHorcG5aL3dqWnZ3VWptekkvT0tzNWVIajBzczNWMTdsTFpQdUtMT0kxeGdsb2ZwY2RuclJPQnNhQ3FxZHIrNE52L2FienVEaHBQRDhkSWVmNzQwTFI5Wm5mM0xYc3ZHNEVUOTQ2dWpXd3lPU05EcjMvOFJPdjVYZ29ZOWZkS0VHSUh0c3Fpc2szakNRT0wwa1d6Sm1TcFI5UDN1dUZKYmNlUjcrSnBKS1VCSm5namtLTk1PQWdsTktDQ2ZiblE4SWlDY0YxN2lNVXlyZ2xCS1NDRkRwUEM3Q2hmN244LzhUWUFEUWhkZm1vWVhWd0FBQUFBQkpSVTVFcmtKZ2dnPT0pIG5vLXJlcGVhdCAyMHB4IDIwcHg7IH0NCi5qcXVlcnktbXNnYm94LWluZm8geyBiYWNrZ3JvdW5kOiB1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFFQUFBQUJBQ0FZQUFBQ3FhWEhlQUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQURucEpSRUZVZU5yc1czdHdWT1VWUC9mZWZlZEZYcHNRWGlJaHlzUDR3S3FnRlZHb01GWTZDaDByTm1weHRLWnFyYlVkLzhDV0dRZnR0TTdZcWhVTGRxQWpLbW8xZ0lpaUJnVkZIdktJUENJdkUxNGhKSnRrMzN0Mzl6NTd6dDF2d3dZM0pKdmRCVHY0elp5NWR6ZDN2Kzg4ZitlYzc3dmhkRjJIODNud2NKNFAwN1JQL0Q5NHdBOEtPSjlESU4wSmZubUJ0ZC9Qdm5Za09od3ZwZXpqV0NRN3V3OGlIV0QzYlRqbmlSVG1USXQvN3FhUGZNWk4vVS95TTZyWnFSLzdKK0xsS3FTSmpJYm5tVGx3TUpVWFdRUXdNZitUTlIwOGttYmNoMlRVaG1Ka3BtK1J2a0xhVElUODdjZ3dmOHdETXBRR3AzN2tJOHZPUnJvTjZjWUtCeStVMlhrb3QvRkExMXdUbDlKOGZsbXZkRVcweXJhd051ZGtXS1A1dy9qMUJxUzNrRmJVMzF6Z1M0dGhKcmNwWGZsdld1dWJqSmRhaDRtN1kzUytBQmNpVmFEQXA0dWI2akxrTFhsbUFVYmxDY1puVlFjN0ttTDZJYitLcEN6RmRaZmgxeSt2bTE2d09RMzVTUUVEMDhDTkgzcnZJTUVySE1Ma3k0cE5jR0d1Y0Vyb1hxYU1vS3ZMTVU4SEVkMWNZODhKR0FwMklmWnJDOCtCTlFrMGt4cUdvbUtKSmp2TjBCUlFhM2E2NVJya1l5MHA0dE1aZzk1TFRRRnhEOUJTVThDVU5aNUxTSENubmErOWZyQVZCdHY1cEZiMlN6cjRVY2lBSEx1UHBMZ09LU1RmVEFUR05kZDh5cWM0dksxRVR5TTZMcXJUMTdkR3B5TmZ6K09mbnZ2c2xzSmovVklBNDRlYnZOcHQzS3ovYVdHZlA3cmhmYzhDcThETnU3YmNBbU1MVFQzY1hFSExka1EwNklqcTRFWEtkSUdOamdHRExCdzRiUnlVSUs0SUNZdHJ1UFp1and4YlhCTElLanlKc2p6ZEQxbjZId0tvSkVMeDJ2SEY1cHBKWlJhd3N0VjFadWtUb2c0SVdKRE5yb0lNMW9tS0plTDlHamd4VG9ibGNKQ0Ruc0doRTE1YWJJYlJCU2I0NHFTMEFQa2Rnajk1ZnNPdFJRZjZDZ0ZlMThnZGVsLzQrbFh1ZXdVZE50MDh6Rll6cGNMYUxYd1FCVy9vVW1FSEVpSzF3YUIrbGtoRmZpa3pmTldwd202M0N1Rlkyc1FVeThITnc2eHdRNFcxbHRkaFAvSSt1L2NRaUJGUHNkQWJEdng0UlZjdGV0dlMyYVBzaG5acGNVWEZpc1ViVzl3ZGpRRlpLa1NEbEZoazVhQWM4YVBVeGhtTWN3QXB6MFhVRWRGaFM0Y0tUZWdWRkliRTQvZ2lNL3hzcEIwRVhmOHZ5akNuTnd3ZzRza1Zrb1hCZFhXZDk5b0ZXSGg3cFFOSzhJWWVhUlUxK05LbHdQSFF3Q3hPTVVMMVFJRWNnV09OSjJENzVtYll0L01ZQ0I2L29SQWVCdTRSaHdNYVlvQUtMdlFNK3E0aVI0RGJSemt3cThEcktNdk1aQ0ZBbE5RRHJuMm40enBNTzB0bmpzcEJ4Z1RLd2RDSVZtLzA2aERWT05CZ1lHUkN5K2ZxQ3V4dlBBa3pMc3FISjZZTmdYdXZLZ0d4MHc5UkpCdVdoZ09kbTBoRTc5emwwZUdnTDJhZ3Nod1R6TGpBUWRLdVFwa3FrM21BS1ZuODQzZTEwL0NIcFRZQm9pajkxMjROZkhMNkVFYzVYdXdLd0w5cXFxREFmcW9ObVhGSk1memxrMVlJb3RaOVV2cUFlU1JFNlZlRFM0c1FLSE5OY1AwUU82dy9HbnFjZ0R3UkF3d1ExRkFMV29JSFhQT21hMEZWa1hsT1phSFpFSDVIcHdaZVNjOEllSkdMVnpydFBZU1BqeXVHNVdCcTR6SUdsSlF0ZG5acFJwOVJYV3FGWWZtV0I2OSt2ZlVQcDFKblRPNGVHSEQxOHZaeTdGSG0zVERNZ1lDQ0V6RExEd1NjS0M2amlNNGhWSjRQZ2NxTitORWUxQ0NrSk84SmVKTUpPdkdaQURJdTRwcXlPckIxRTZrTDU5cmxqb1hEbEJFT0VBVGgyVEYvV21IckZRUHcrdWlFTXB2aHFvMGVEVHdwb253RUJmWlRyZzdGaE8wU1k4S1RFaUlLdWJjT3h4V0xjWVhUaXFnR0w0QUxueWNGZU1NNmRLQWJ1M0FPRDk2TCtEdzlNeEFsdUhEOUF6NFZxMGtleHFFbjVGeDQyZTg1SEhHNXVRbXZ0blpYbnlhZUUzODlvUWpjVWl6dSt6UElVeUpZN2xJdTdxdW1JdHRUNFZKVndNTzBZU2JJeDhxT1BPWHpWc1dvS2VJSzcyMVlNWVBZVExGcnF1TkhwVHhnVlExTEd0eHdlUEZqOWd2dS8zdms5RjVnNXFoaXExRm43L1ZvMEZmcExxa3h5MkxwbWRJSTRHLzJZUEZ5Q0pFYXc4MVFRQmpuaUtoOUt6Q01vUkdXcVN6V3dZR0t0RnM0Nks4cTltSjJ1TTdKdzVCY000UnZlZmpHSFhkWHJMM2lQeWUwUkFYY05xcklZdVRUeUJtRVVyV1ltMHBxZW1VdGJZWTRNQzFLSE9zTXRmNjN6UFI3Q2pWU0ppbkMwUTlGMExNdEdGYVZKR05PSWUxWjFLUHNra2xUdTVlOXFzUmhncTFkeUV3di9UTlpYSlRTVDRmayt0ckpkbWoxaHcyVUhqRjJCQnhWWStHUVdsTVBNZEJFbm5LeGtMS2F6NnlHUTM0ZHh1WmhSY3RiYUtmSzJqQjNxQnozZ0NLYm1SOHBJaE9TcWlkMXZWQWY4Wm1TQXBEUmE3REN2TmhaWkh4K3V5a0tWczRPMGdBWElMMTVFRUF0MkxUa1kzbk45NktISUtVOVFRQk9zSTdCajVRTndpWldBeFJSZlg1UzdDa2szZnV3dEpSVnlOaWdYb3AyZTZaZFBBaUdGY1UyVkQ5c2RobDRvS1ZaQkZHbWtUQno1R04vWWVrRktOc3hxMkJGYXM2cm5sb2MyRjBmaUtmQklodHkxaFVsb1RtRG9qaFpaeEJMWDRYci9pNFRaQlY0aVBoQzNjTFRxRUMzTlBPWm1WL0JVdDB0WW1oRUlPbmZ1L0I3Ry9KZ3E3allTZmFJZTBEWXlPRXkweVM2ZkNDaVo2Vy94OVlDQ2swOVhjckJhMGJ0b1did25KSkFNb3JMRk5oN2VrSVhlcG1FTGEwYzZOS00rb3Rod0FtL0tFTSszb2FsbVBEWkdvUlRaUEhFTWJyRUFsK0dXSStld2JWSUZnVXhiWkNETjlLN2tjVW9mV09hQ3pSODRETVV3TEtBTzZ5cWJYNVJMUmRsRHJJNUNHdkk0b2xqWElVRHpFY2xBN3hrTGJQclVTaTdzVEtOSzBIQy9DMkhRazJxNkRNOG9Mc1VSdHJvOVVYVHJyLzcyZ3loZzVFcXRIamlvT2FJaTBZTTVXUmpYVktDQi9zTVNyT2lLSUhpNzl3VlQ2U21oRTV3aFNTR1ovTTJXL2JjSDRzZlFaRU1pMzhuTmZLS2dROWFscUtQeW5WQ3RiQlBCTEY1MjNxV1BYdFVndThwWWhpVWdnTGdlRDVMQ3NCYVhsZVR0c09FQzdzazR3QWtheU1VVmlDTXhWZm55cWZveUkwZ1grVTFSRXFpcGlkR0IxVlpmMWJ5aTBaWm1nMmlBdzhIeUVtWnkwRmNzRklxek5MYVJGRnZFQ0xIdjFta1JZUEVoR1FvNExSMitHWFo2MGVrMUxJU2l4VGpRM0tUZTlkRnBSWURIL1FzNFkrSzFaenNENEpyK2FQTG1mV3BHMVI2N0FnZGViTHFzQ3JMejBTN3ZGbGhnbHBacHlPNUFnZ1hyQmlXbEFteUFvU2RiclQrbnBjVjkxR1JrZ05seWU5NEFJMWo4OGZNVTd5K0ZYSlF6SUlIQUl3dFMvNCtBZUdDanBrZ1ZoRm1kbDNaaDY3ZmNyQ3VmZEdzVjVucjAvc0kwYUh6OS9YSUFnbEhUZnBMMGZiTzJ5emxaWkRKckNCaldUMStTRTZ2ZjdlWkJTTlZhVnJtYWhFdEVnRUpyUi82ZW1VZFdaek9aWmtDbE5pZVlKSnQ4Uk1MeHEvVElxRjdvdGl5cWxFcFk1WndZU095dFMxNXBkT0YxV2VMYkFOUnlaemxLYXVSREpHREcrWUhQbDk0aUxrOXZSa1JIanl2VVRPMnhiVmU4azdiMzY1YzV2emQ1b0pJQzd4Z3JoZ01uTldTdGpYYVFqcjhlYk1NRDFhYjRMSVNIdXptR09qdGMydXd0RkdCSmw5Nkd5MDlMQjhNZ2RMdWd1akJkZk84Ny81MkhYTjlFajVnV0YvdDQzaGN4OEZ4M01LU1I3N2dkRVY5WG5DV0FwK2ZseFpUWk4yREhnMmUyb0o5QityVEluQkczcWZkR2pwUnBuWTJFMldBNXNOTTV1cUE4TzY2UndKcjUyOWp3bFB0VDBmQ0VaS3Q3SW05TVFWb1p5aTk4RGtWbGZEU29MdmZiaFNDNWJWQzJmQlpRbGtwZEhjV0E2bk4wY0x0b280MGtQZEcrdHFoVlVIdDZBQzU1ZURLNkw0MWRlTEdGdzh5NGIzVTc1QU5VQ1l0Zmk3UXJ4Y2ttQkxvM1p3ZGhRL1UrelJSbk11WGxBQ1hsd3ZmcDZGNWZhQjFkSUxhdnY4Vjc3S2ZMMkhhalRETGsvQWhrdVgwRnlUNjlZWUkvbEJCSlFROWk2YytsamRyY2IzSk0vcFhmT0hnYVp6VENaemRkazRGMTBVUjlFNFV2TzNidXVnM3ErdkNXeGMxTWJTUE1NdDdtZVhWWkcrSW5ERUVraWtoOE80RDlDN08rcnc3bHRYdzNwRjM4WVhPYXI2b0VMaWNuTE5vYnF4VS9YN1FQUjZNOTQ3dFNtdkRpdEQ3ajMzS0doeXE4a0lNOFB3czVyVWtxVDcxZDRSb0lsUUNSYThTZUt2bTM3U2ZtWFByaTdjS1plUHY1SEtMSjNJRitSZ2FlZWdWOXF3SWJWZzdGQUtkM04xN3ZFN2F0N291dW0xeEUzTjNoVms5d0FRblBtVzlsMWRnVG9WQWl0dFFiTUlvS3NKWU1MVDZrVGZ4dXNZeWJ0Wkk4N2haTS9tQ0lWTTRXLzRsaGhJYzJQYmlsYU5ycXNDcEtGZ1pScW1CTndTSFVEQ3NSM3c3TmQveGJaR056NjFSMi9jRW1jV1ZoTkkyRUsveWtsazkyU3N5Sm4yQU96QU1ITU1NWmNOUzQ3dEJwR2E4WHlRNHh3MHlWOTk1dVZCY2RUbGZOT28rN3FJcUFFRTR3NmxGQVBSZ2tIWW1ZMjJiUkgyeDFLRXJrYU42c0wwQmhXMkliSGk2NGRScGdCSGpNaE5jWkJSbW4xVzlIMWFOeTkxdkREaUROeEEyaEpqN2tmWnRxcXZScDlZLzJXNmI4UStaRzFwOUgvQkM3eGt2SEFidGVBdW9MZHYvcXJuMjdOZERIVUY1NzFzdHAyMzdhMHhvaFFrdU1ZSERiRjNaMk1WUHdaMEhoQUY5S1lJcEk2NElNMTkrNWVSQnpnSUk4Snh4dXZ2ZEEwWUo5Q1BIUUQyNlpVSDBnNGZlVHhCU1paYldFcXd0TVF0SDQyc1I5ZVhxdlh2QUFER2dQMEJKekRydTMyWXhtZmc1TTY4b2hPVUhrcHdxcVNqWDRTT2duV2g0Z1FrdnNSZ1dtY0JLZ2dMaVY3Vy9MdDRQUHRQRGdIN0VXRzNWeUNKb0QzUGRyN0VsQWh3MEh3YTk3Y0NyMGZmbXhqY29DTG03bUFKVTVsaFo0aTRCQTdMeFQxTzJ1VjhWOER6M3Qrb3hUdGp1T2UzWW13Q3V1Um4wOW05ZWtWYmV0WVJaT3NDcXRTRFZHMmVsZ01xbUIrQ2M4NnJIT3NGcXQ4QzN6ZW9wOTBmQTR3ekw3M3BCWG1OWS9wd0luMVVQc055emRXYU93L3pIeTZ2TFliOGIyMXNOWWowdnRxYWN5d1ZhNjdabmxJOGZXczNjUHNqY1BvQjh5R2UxaE5hekFJTG11N2RNd0N5d2F2S2tFY0R6UEh6dFVrSDNCNEJyYWNGNnZmbE5kZWMvWDlPUHJlOWtsdmN6eS92Wlp6Z25Dc2hVUjJxdTJTS2c4TnNuVHh3TzVhVzU4T2x1Ti9pYnVvRHpkSHl1dCsxWXBYNzIrQ2FHNXZHTkNROXpleG5PeGRBekhBSTRqOTFrNHVDTHpjZmdzNDFIZ2hoa0gwQ2c1UjFsOVM5bzV5R1hDUi9ma3FJV05YdzJZNzQzRCtENE9adlNtdWczYzYvc3ZsKzRaRHNKcW1wdlRLSmloZHJEWXFROHB1OTRoMFpYNmVGNktTUHdpMnVtOWZ1MEZaQzB6SHhqa3BrSkh0OURDelBCbzdqZU9iTjZzbUhLMHJ4YVFuT2lkWi9EemRuMHZmdFA3YXg0d1AvVE9PLy9kZlovQWd3QUp1dnV3T1NERk9ZQUFBQUFTVVZPUks1Q1lJST0pIG5vLXJlcGVhdCAyMHB4IDIwcHg7IH0NCi5qcXVlcnktbXNnYm94LWVycm9yIHsgYmFja2dyb3VuZDogdXJsKGRhdGE6aW1hZ2UvcG5nO2Jhc2U2NCxpVkJPUncwS0dnb0FBQUFOU1VoRVVnQUFBRUFBQUFCQUNBWUFBQUNxYVhIZUFBQUFHWFJGV0hSVGIyWjBkMkZ5WlFCQlpHOWlaU0JKYldGblpWSmxZV1I1Y2NsbFBBQUFDd0JKUkVGVWVOcnNtMnRzRk5jVng4L01QbWU5Zm9UWVhodHNLT0JIZ0lSSGVKZ0VBMm9vRkFnUXBhSnFwYXJ1bHo2eXdoalhyUnZhaUFiU1J4cVRwUWJzbGtTcStxV0lxcXBTaFZhcWFCb2hpQlBDQjJ5UXNYbllPSmpZeHJGNStMSDJydGU3YzN2TzNidG1zZnpZbloyMXFjaVZSanV6TzNQdS9mL3V1ZWZlZThhV0dHUHdPQmNaSHZQeTJBTXd4bXpocFplbVY4SDc3My9wQVY4QzBIc0lTSklVc1FGV1VmSGdvcVptRmhRV3RzZTF4VFUxQ3RiaDBkTFdoOW90Wmo5cHJHa3daRFNhS1pMdDJPRUNxN1VNdk41RGVQbUdkUEprcjU2NjBiNFpQNXhnTUZSQ0lMQWI3VmRGOHR4NGdFTGFkQmtDNnZidEx2YmtrMld3WVFPd3ZMd3lOUDRtZm1mWFN6emFNcVBOU2paL2ZpV3NXd2ZNWWptSzN4VS9FakhBdjIwYkZ5K3RYbzNXWkpEeTg0SGw1RGhWeGlyd043c085czFxVUx4VFdyZ1F3RzRINmZublFVVUkrRnZ4dEFJWWZ2RkZGNlNtbHNuUFBjZkZvL3NIaldKRHBkeGNaMEJWRCtJOTloanM4NTZYVUx5OGFGSHd5MENBUTVEWHJPR2VnUGNVVHd1QW9hMWJYWXpFWTg4ekhHZnM3bDFRVDUwQzF0VEV4NWUwWUFISWVYbXYrQkVDM212WFlKLzNQRkRQbzNpeXlXN2NBUFgwYVdBRU9pR0JReUJQd0h1THB4U0FaOHNXRjZTbmx4bEZ6N043OTREVjFQRGVZZlgxdktGVURPZ0pCZ0VCbjFHaXNNL0ZTemlVREU4L0hReGFMUzNBTGwwQzZPc0wxalUwQkJKNmdyR3drSHNDUGxNOEpRQUdOMjkyU1NTK29BQVlpY2VlWng5OUJNenZEL1lTSGRoUTF0d01GR2NOMkh0R2hJREQ0UkErcTBSZ243dTlMTVNURFFMS0xsNThZTCszRjFTRXdEMEJJWmdRQWlBRWZMWTRyZ0RjbXphNUlDMnR6RVFCejJBQUlMY2ZMVjRjS2tIQTRjQVhHeWpFUko0UUNCeENHOG9FOXMycXFsWWFVTHp4bVdlQ1BVOXVIeTQrZFBUMGNBZzg3aVFtZ25udFdtQm04MUcwRVJXRWlOY0JmUnMzdWd3T1I1a1ZJekNKWjkzZG9INzhjVEFvVFVSNDhXSUtpUHpjaDhOajZPclZZN0lrbFNWOThJRW4vRDYwVC9OOEpZSnltdkdaY1BFVGx1UmtNSkFIV0syZzl2ZUQ5OHdaOG96ZGFMOHFrblZBUkFCNk5teHdHVE15eXF3WWRFTGlBMkxNUitSbVM1YUFISUtBbnVFTlF0aVQ4dUdIUG1HZml6Zm41enZOZUMrZiszRUlUU28rMUY2RUlLTUhTQUtDSnhnb2Q2UDlxcGdCM0gzaEJTN2VScFJwekZQUFJ5Rit4T2JTcFlEak9oamhFWUpIUUJBL1YxcFF2Q1ZNUEl0US9FT2VnSXNrakFVY3dvQ0FrSHI2ZEpWbUFGM3IxN3RNSkI0TlN5aGU3ZXJTSkg3RUV3aUM4QVJ2WFIwTVhydDJESU1RczZKNDY3SmxEM29lZjlOU3VDZFFXOGtUY0xib0p3Z2V6L2ZUejV6NVU5UUFPdGV0eTVBVjVYYlM5dTFjUEhkN0RIaGF4WThGd1NPRUtqcUlENGRnV0wrZWUwTGcvbjNvUFhXcU52UHMyZVdhUEtDanNOQmx4Ylc5a3AwTmZoS1AwVjZQWW5qMjJSRUlJK3Q5bkRFQ3RiVzYySmRTVXNDQU1jRjk3aHgwdExlWExEbC8vbyswcXRZVUE5cldyUG1EeFdCd1d2WGVoeTlmRHBLSUNiUm04Ris0b0o5eGJQOEFmalM3M2NmWDF0YnV4OU83ZVBTSFE0Z1lBSjVMVFFVRjd5UWFqVDlRb3QxNzAzeE5Ya1ByQlBxazRTUG1jVG9uQ0h6RGd3RnZKRm9ialh5bWtXaWRnZWY4TThyaVZsVzQ3dkdjK0dwZDNXRUtOM2pjRWNlUXBta1FyeTBYVjZ4NEo5MWsrcDVObm5qdHhIdytZTVBET04vNWdxSmozcTdoRHROa0FzbHM1Z2RNVUQrMTFvMWdTZnlHUzVlTzBOWko5RHlKNzlIa0FlS2FhclZjV0xic21NTnNMcktOOWdTc1ZNVVZHVitheHZrOUF3ZUJVWjdEQ0JlUGJRcUozMWhmSHhMdkZ1NVB5Um1mWUtRdEkwUVFWaVVtMnFybno2OTJtRXhGQ2RRVDJOUHF3SUErUGEzQk0yUUNvU2o4dkJmYjBJVGl2OTdRTUtsNHpTa3hEc0Z1dHgyWk42L2FBVkNrdU4zVG50U2tEWmtidDhaTnc4TW50alkyUmlRK3Bwd2dRVmlKRUE3UG5WdWQ3dmNYSllna3lMU0l4M2IyMld6UUhBaWMySGJsU3NUaVkwNktFb1NkTTJZazdzbk1QT0tZSmdqaDRuZGN1emFtZUd3L20yd3ZvT25ORUQ2c291RitGYUNreE9HQURJdWx5RDZGRUVoOEQ0NzlablQ3bDV1YXhoV3YrYjFBTkJEd3BLUTRQUjB5Y0hhd0R3MU5qWGdNZmswKzMvR2ROMjVVeFNJK0pnRGhFSHlxdXFjVUlkRHNrQmhIQ0tUcVBybzlCcnpqMzJwcGlWbThMbWx4Z3JBNU1kRnJ3bFdXT2pwcm8vTkJhd3dEVG5jR3hwUlVvMUdPVmJ6bUlCaGVhbkp6ZVRJamVjWU1aOEt0VzNFZkFyUXFISmczRDVwYlcvKzZyN1B6cDVlOTNqc1RpWTlMRUF5VnMvUG5jL0V6Y25PZER0elNEalUyZ3ZmOCtmaUp4NzJCYmVOR3NPTndBNnYxMjRjbHFhOVhWWC84OHMyYm1wZWZtb2ZBNmJsenpRRlZyVXpKeWVIaVJ6WS9jVHhVWEhuNnU3dDVWVlJuV2w3ZUQ1TWx5WVZ0VVRSRDFUSUUvanRuRHUvNTFQeDhaeWJ1N1htYTYvSmw4TVN4OThPTFVsQUFGdkcrNEhaZEhYUmZ2WG9NVzF6MnRkWldUN1JESUdvQS81azllMFQ4TENIZTI5QUFuazgvbmRLRmtMSjZOVmpGNjdJT2hOQVZoRkMrNmRZdGQ5d0EvRHNyaTR0UFEvRlpZaTlQNGdlbldIeW8yTkFUck1JVDJoSENGMWV1Y0FoYjJ0cmN1Z1A0MTh5WlhIejZVMDg1czFlc0NJcEh0NTh1OFE5QkVDOVIybXByb2JPeGtVUFkxdEhoMWczQXlZd01MdDVCNGxldURJcXZyNGVCYVJZL0FnR0hneElHNFhaREE0ZXdvN1BUSGZNMCtJLzBkQzQrWThFQ1p4YjJQRDFJUFQ5dzdodzhLb1hhd2xRVmxNV0xZUmJPRHFxcXZ0S0JReFBidmxjc2tyVE5BbjlQVFIwUlAyZlZxbUFxbTNyK0VSSWZYaEp3T0NqaTVjcm42QW50OWZYa0NYdDMzcm5UcThrRGNKNy9kZWJDaGM0NTVQYjRBSWwzNnlpZW1pRHBDTUNOUTVLRTJSQkN0dkNFdHZwNldwNitHZlZtNkVSS1NvYkJZaW5QV3JvVTFKRDRUejdSVlh3N0xtdXQ2THFwTWI1c0NTLzlOQnl3dmVRSnc3Z3hHd3dFQnNXQ1Q0MTZDQnhQVHE1SWNqaks1ODJhcFd1MHB4cmJVSHdMWXljTUFKWjh4cjZScGlNRUt2ZG56b1NyWFYxL0srbnZMNk5Ma1I1WG81NEYvcEtVVktFd1ZwNkZ1ekJaSi9HZjQ1citNeFJmUGpCdzVBbEprbCszMlVwekFMNlpyaE9FTHd3R3VBN3czazhHQnQ2aUdJbEh0NEF3SERVQWVqSHlydDErS0lXeDB1d1lJVkJOdDFBODlmemV3Y0dSVEU2MkxIdGZWWlFEc3huN3JpTkdDSjFDZlBuZzRFSFI0MjRCb0VjVEFIRnRQcW9vaDlJQWRtVmpBMld0NHJGeExSaGVmdUh4akU1ajlhMDJHcFh2bUV5VldZd1ZaYWlxTnZHeUROY2w2YjFYUFo2UWVCci85MFR2RDJrYUF1S2F2akFmc1ZwZHFRaGhkcFFReUVvcml2OE14Yi9tOVk2WHZaVnlaRG1oeEd5dTBnTGh0aEQvYzY5M1V2R2Fsc0loQ0pVV2l5dVZzVjF6c0lHUlFLQmFXN0Z4Skg2Znp6ZGhBcE95elFTaDJHVGlFRElqaEVEaXI2SGJ2K2J6UlNSZTgyWW9CT0gzWm5ORUVNTEYvM0o0T0tMc0xVSElrMldiMDJpc2pnUUM3M2tTUHp3Y3NmaVl0c01oQ0M2VGlRK0hyNHdEZ1dxOVNlSXg0TzMzKzZOS1hYTUlrbVQ3a1lBd2M1eThSQWMyaGNUdjgvdkhGQytTdHZybUE4SWhIRFFhWFdsalFBZ1hmeUFRMEpTM0Q3MlF4VHFPWlk4QmdjU1QyNzhlQ0l3clBpNEprZEVRS2d5R2h5Q0V4R08wUC82clFDQ20xSFVJQXRieEVBUXVIZ1BlL2tuRXh4VkFPSVRmeVhJUUF0NS9FNzhpOGI5UlZWM3k5aUVJV01leGJJQWkrbzdjL29DcVRpbys3Z0RDSWZ4V2t0NUlCUGhaRzhDN2J6SDJaejNFajRhd1Q1SjJld0FTMzJic24rS25DY1hIRENDU2NuM1hMc2lycnVZUUZnRTRHbkJYaXVkV3NmWWVFWS8zeGZTWEUxZ0hoNERIRTNpa2lLOTdKb3YyRTd6UTBRZEFwZmdzRGU1c0tYK1FSRGxMU2gzUUNvL0VWNDd6aWpyYVVocmMxUkdFaEZBdVJJdjRjQUM2L2RlWUVPa1R2UkphZStzbVh0U2hDcy9xRVljbThSRnZoNlB4Z09rcXBWbzNabnA3d1A5cmVld0JTSS83djgvL1Q0QUJBQnFWcWZXN3ZEZ1NBQUFBQUVsRlRrU3VRbUNDKSBuby1yZXBlYXQgMjBweCAyMHB4OyB9DQouanF1ZXJ5LW1zZ2JveC1wcm9tcHQgeyBiYWNrZ3JvdW5kOiB1cmwoZGF0YTppbWFnZS9wbmc7YmFzZTY0LGlWQk9SdzBLR2dvQUFBQU5TVWhFVWdBQUFFQUFBQUJBQ0FZQUFBQ3FhWEhlQUFBQUdYUkZXSFJUYjJaMGQyRnlaUUJCWkc5aVpTQkpiV0ZuWlZKbFlXUjVjY2xsUEFBQURvcEpSRUZVZU5ya1d3bVFGT1VWZnQwOTk3R3pOOGZ1d25MZlFZMUhzVEdvaUVTallLeFlDZEdJSm9vV2lsaGxKWVlxb2trcGxtVnBUTVVZU1pYUllIbEdFRVZGUUJBMUZWRkV1Wlp6V2RtRGdUMW01ejU2K3Z6ei9wNGVtTjJkM1oyZW1jV2s2S3BYYyt4MDkvKys5OTczanIrWElZVEErWHlZQ3IzQU5kc2kvOWNBc0hDZUgrYzlBTDFDZ0dFWXd4ZFkyNVRNNlhldnRnbzErRElGWlNMSzk3UDhKSURTakxJUDVkZ3Y2NjJ4SEs5YkVBQk1KZ21tQVNnV01jNy9LSEk5dml4Q21lY3lNUlBMYlN4NHpBeFUyL29EblZRQXdoSUJINzRKQ0FRa0ZUN0RyNm04dm4xQnliRWlyV2Y0QVppL05Ud09YNWFoM0RiT3pZMGM3K0tneHNGQ2lkbVlkM1VrVlRnZFYrRm9SSWFnUUw3QnI5WlFoOXYrSTQ5U3dOcUdENENydDRTblU4VWRKbWI1eFpVbW1GVENnWU5qaXVKSlBZSUtCNElLSEE3S2dDdDc2T05yUFUvbGN4MWM0L0FBTUc5emFMV05ZMWJOcVRiRE5JOEpzdW1OT2tCQ0p1anFCR0p5RmpKQ09yWnhBQmdxWUVmSmxwK2pHQ0pmQnlRNEdKQTFqOWh4WGVtTEJ0ZFpYQUN1K2pCRVkzelp6SExUOVEyb3ZKWHRyWGxBSk9CUEVnamlLNjhZQTdYVXdtaEMrY0xlQjFIcUVSK2ZGcUdiVi8rQ0gzLy95WTlMWXptdXQzZ0FYUGxCY0NWYTZva0ZkVllZNCtUT2ZDK2pwZHNUS25UeEtvaHFjVktWR3oyaXhzSEFDUHZackszaUVuZjVKUGk2VzN5UGVzT25ONVJ0eVdITnhRSGdpdmNEVDFUWnVaV0w2bTNnTkRGbkZHK05xZENCaWl2RFZGMWptTUZZSndPakhHZUJhSXNxc0ttTkI0eXVKWjh0TEg5bGlIVVhEc0RjallFLzFicE5EOTVRYndXTDd2SWR5TmJmb3ZLU0N1ZmtjR05HbVZyQ2dzdVN1bjgzZXR6R0ZoNTRtZHoxN3h2TFh4eGs3WVZWZ2o5ODE3K3F5czQrU0MxdlJyQWtURWdIL0FvY0NhTzdLeFM0Y3lNUjVKU3Y4Yjd0Q0RyOWpHdUNuNHl6bzBIZ0g3akdtd2RhUHpWc1g4a1pnTXMzOU56aDRHRDF3bnE3ZGxJTUdYbFhqd0xkU0hJMEhzKzEwSkJyUXVBYkF4aHkrTDRDaTZ6cngrTGFDRm1IYTUyZUZRQThzYS9rQk1BUDF2dm00SVgvdVhDOEV4eVlyMExVQWowcXVoeGVGSmljQllNTVV5Uk5jMWdSb3JuS3JDeVVvcmp4dlkxanRSQTBjajBxWFdpQVBmNVUrTlc0VERDMzFnNnFMSy9JRllDYzJtSDBsR1hYMUR1aENoTjFSRXJkTUZlaW96UmhSZkxDdFlFTFk5ZXNxaENQeE1FZlRKeEIzMkl4UVluREFwNUtsMVlHUjBXaWxjYTVjaWxOczNSTkYxV3dNTFBjQXQ2by9aNkd0N3I4TzM4MllsVWZQWXlUNEp4L2RhK2FWbWxkdmFEZWdYR09idTlUSUprajJhRmhvZHpLZ0VWSVFzZXBFRFNlQ0lLQVpER2p4Z2t6VWRKSEJGMnBQU0RBenVZd05NeW9nc21UcXlIQ21DR0VZTWdHTWtvRmt1SUZDQUwxaHBjYnd4Q1B4eS9ZdGFSK2Y0WXV4Z1lpbDczUk5kTENNYXNiUnRzd3poQmxqTGVFZ1VvY3o0WDJwZzZJQldKdzNhd0tXRFYvT3RTVld3Yzk1ODJ2dXVIVkwxdGc4b1FxS0s4dXcrYUk1T3h0UGdUc0dQTENWQThIYzJyc3NLMHBlUjhhOVI2aVcxUlZpVEVBTUVZZXVCZ3ZST1ArSU5iaTJKUVlTbGZvN1RCdlJpWDhhdmE0bk05WmZHazFnbFVPVDI5cEJ5bklnYnVrUkx0dnJuZHVqUkhrRnhWbVZGaGhyOXUrOU1JMWg5N0FyejlKYzBET2FmQ1NWenBveUs3OFhyVk5LMjY4Q1dJNFhXRmV4aWJmYkRqUGUrd21lT3ltOFNDSG8xREdxVUJyTFNQM1BSekV0SXh2TGtYUFpjejJlOUVMT01OWkFOM2w3bG1vUEl1L09CSlM4MHBWQW9hTFgyU3dacyt2Tkh6NGhyRVE2NGxvSkdya3ZwUkFqK09hSjVSWm9jUmx2M25LSTVzbUlBZ01EWUcrWWhyWS9lSE82VlUyT0JIQnVKZnpyOXBvMGJLakpRNDNUM1ZwcGZJeFhOakJJTTBpQkdxZExGeFN5Y0cwTW5aQVQ2aHpzZERDcFJRemNyUmdLTlE1Q1V5dnNvTy9jdXp0K05VZlVDYzVKdzY0OE1WVEYxUzd6ZFBkV0Z4OEZWQ2drQW8zaW1Id1ZZaURwbjJDbHE0aUltZ3RNYjBtTFdTT0lpQkxKcGxoYW1sMkVHcEt6SEJTUUE4QTQxNTBQS3JDRk9TQ3p5M094Zmh4TmJxOG5CTUhvR3RjVzE5bWhqWkVrWFowaFZSc1Niemw2U1RHWlloT2VJalcwOU0wcFdqekFkQXF5VTliRXdNcVVlVTJhNy9ONTk1ZXZKOFZDYnpVWlJ0ZmYvL2E2ZnZ1cW1WekNnRkU2dG94SGlzMk9NU3c2MldQcDhISDByR0VOSEFJRVJiaWN2N3I4R0tqTnJiVURKMGpKaTdBandkUk4ySFFFSmp4ZkJ1SGFmTUttNFdEWUdoNDJ6czY1eWpENG9VUHhQRlRXZGJmSEEybEtrTWx6NlcweGdCR3VTMVlsRGd1eG85WWlQWUdnTTFpL1RFbFZnNzhBblVqWnRpRTF2R2xXQ3Fxd1FoY1BjbWRkZkYwbXVRVnpSZ3ErZDhuZ3M3bE1IUEFtR3hUYVcxMjZONng3S0M5QUNJMHBkVE9ZZTR2elAzcHFUS1NIZTNhWkFXMFNwTG9reHhhSUpXZzVWMmNDQ1FTZ1lhSkUvcWRUNnUvdDQ2TDBKVklkWDZGSENLRGR1YXM5ZmlXbHFFYzZxZ09HQUpFSVRVdVJNeVB4S1VhMUpqMkNpSVNteWlUUVJmdHdMdU94UlRWMVhJYS9uN3J4S3kvK2FoTmdtMG5WZWpCckdIRzlWdXdLbVB6SERLSEpXekNXTmJobkhabFdmeklweUhVVVJvUUFFVEhSZWl3STBmclV5dnplTG1rUkNDWFdTcWQvbzdHL0M5MWRzQ3E2K3EwWE4vM2FFTHVlZVdZb21XTk0xTW05RWdMblJoallVbGZqV3hpMGZSTDIzQnplWjJIaG4xbVQyREt3Z0YyTGUwTVlYNXE1VGpkd1RHNFRlRkcxM2Z6WVpnM3VYZEhtRDVPWXVaNWZMY0lMVmdqQ0gydW5hUnRza2hiYkFKMnZJN0RraHNRWWMyTDBJTmNsWlJzMk15ZWdNM2lBVXBTSG5qS1E5MDhnS2tsZ05ZUlpHTjVtYnB3cll1QmNwWFhtcDYrQngyd1BQT05nR1VzMFdxRXdhWkJVU1RJYml4MDZPdFFkUUlkMTlGMUs0a3doWlJ0L3UxRVpzQTZBTkdKQ1pMYWp3RHA1d1JhUENIbXo0eDB2TTFFdzNEZmxhT3kvdjNkWmhIMkIxSnBqK1RJT3hFRUlJYS9kMWtac0EyeS9aWkVhNG1kVGJHMDBkTmVrSTBEZkFuMFBYUEdDbmd4NWU2RjdwazY4VzdqbkV6V21RQzEvdGFUQkhwNFluaXNycUpkUXduS0VRVGNkclkvV2VMQzZTQkc4QjdndGJrY0N1cEpCc29DemJHWUNKNnFsTlVqQ2RWd25BODJJS2wxWjYvNUQzU0pXdGNvRm5DdnBFUzVTVVVRR0kwbzA0ZUUxbGQ0dmtYbEkwcTZMaVVLR1pBRW0yTnhFV3pJNnBGRWtVcmg5TWdOWlZ5bExldmZEbllKbUUxTVE1THZrTjVBV1IrSjFJRk81dFMzNFVWc1NKUmt6SnRSb3BCMENQUXp4OGsvVG91Sm90TG9ENGdhMlJSemxFMWpsUitndFc0THlVQmJncUxkQzdraEZFOFJaREl1Z0J6eEhkTHhVV3NlT1V5R2FvWStrL25rTE01c0tXcnQzNDBSK014aEU2dzlJVUNHaDJvRERCOXZ4M1JGdFBLMVdBY3Ywb3lCSU1SNEVOcjM3cUZsaThibmc5VUJPaEZ1a1dPSjVZeTdwS2dBSUxWQUc2YllrRUJMNFZSdXBpbVg1bW02MFNJUFErOGxDRmhQaEJNUTJmSE1QaDBBUlIwS0FFUm9teHBQZ0VwWHhCWHZPU3BhOUkzM3NPRGhBeER2am9DSTdGcUJ3VnBiVmdwZWl4TzhNVkwwL1VVMUdnTTVjT3A5SW1oUEpZZzVlVURuRXpQRjZ0ODFQZ2VSNkhMTzR5bktRbWc5WDQ4WndPcnp3cVJLQmhvdXI5VEtZTG9mc0xteEcrcWNwU0RaeXpRUWlrbThVamdLd29uUE4rdldGN1dON0tFQTBHZUNhNVJnZURsVFVod0FhUGRYbWd6QVRiUGR2YXJBQm4wVS92QTdKMEJtWE1nRkpvaEx4VkdlQ0FJb3daN2owYTJQZnFNckw2UThJSWV4dU8rcFdZZlZwTEJlaWNTS3dzb3VqUG5aVlV6V0VwZ2VkQXp1bEtMYTR6RkYyMEQxQjBEcU9MeUJ4ajNsV3VvUUZRL3VKemx2anFLcnJKRjcvRVZaREl0ZHk0eFI5a0V0TnJFNnRmTmNqUHNwU2JRK3VuOTA0NHFOdXZYcDRGSHFPeE1jRklEQW4yZnZVQk9KdnlrOWdhTFVBTWtoTmtuQ01xZTVmMUVBNk9nQ3FYMzNrMFRVQW9yWFJURzhQVTVrNlNuRjF3T3FLQlcwSUQrV3VkdTlBK2Y0R0M1emI5aXE3U01Vckx3L0NQTHBZK3RqRzVhK28xdWZOa0dDWi9rZVloaUEwUE9YdFJGUlhLbTBlMU1uNWZsVUI3WERiaDhEYng5WCtxVTYrcmNuZG9ud2JaQVUvcVFKbndTMXN3dUV4dlhyOU5pUDZ5Sm4yeHJMNlJraHVxM2tXdnJGWDVuSzZ2dVkwYU1LYUlZQVJtSTNlUGxvRnE0ZXc0RUg2M1Z2RkdEVENSbjIrUWdFa3FTd0I2eGtCZFNXVmxCYXYzaVNmKy91RGJyaWRFODhpRHJKN21WN2pPME9uKzBtQ1VFTVZqanYvSStOTVpudmhLcksvTG8xek1UdEVRSWJFZ3BzYlZYQnpLVytpMHU2NVF1cWVOQ2liZTJnZGh4NkNaVlB1MzVFZDM4bG0yRnpCa0EvV1hYODRyM0hvRjJtRDdQY0FaWDVnVUF0ak0ybUpyMzd4RUtVVjRHMHR3TTVmZlFOZnQzaUYvU2lKMHA1bGNaKyt2a0FROXZqV1p1TE4yOXNKL0d1cDVXMnBwZlZ6czVVYS9WZGl5eWoyN2VBZXJMeE5mNnRuejZySzArdFRwK0tURkREWlJpeG54ajZseGs5RkE2YkxsbnhFS2NzWkJsZXVBM3FhckZmNE9BN09SS1kydEh0U2ZlUmw0UjNibmtoZy9Ub0E0RXhHdmQ5cXR2OFE2QVBDRDN5N21lWFdSWi9HR1VTaVh0SlhSMldlcTV6cHpqMWFKOFBtSzR1VUwxZlBDcDk5RUM2MXFmSysvWFlsN0tzdmYrUUp0OW5oZkczTkh6czVrV3YzY3E0UnY0YXFtc3ZJNk5ISTZTbTRWVStGZ1BtMUNrZ3Z1YjF5b0cxcjZyTkgzUm11SDFBVjE0a1daU3czckdyZUFCa2dFQW5uQ1dtbTk1ZXhYanE3b2Z5TWlEVjFmVFp0K0lyanZrZEFoMTdTZmYrRGZLTzMyelhhU0ROOWlHZCtHUXlnQUtXMjRzTVFMcEdvTjB1aW91cG5EbUNuYk55S2VPdSt6bVVWb3dtWldVQXRKM09seU5FMUMwUUFDYUlmQmJ0UWNVUGJGQSswUlFudXRWNVhmbXd0bmRFeUtEUHNwaVhmRmw4QURMT3BiNVBKNTUwOThYTnpYMzhLcVp5MWlLd1Y4d0ZwOHRGS0VkWXJVRHM5aFFnVm12dm1PWjVZQlNGam5BMGNtUFE0c0RIVHBQb3lTM2srTWJONnJGMVhsMXhSVzlyNHhsNVhzeGsrd0VCdUMxSEFJd2N5N2VmVGVqUHpiZWt2WUVDUVZtUjduM1oySXZ1bncwakxyeVVzWHJxd0ZJeUdSak9CU2JibUY3OExQRk5vRW9Sa09KZVZQb2dhZHUraDN5N3FTdGRQbVFNTkhoZDZiZ09oTUxkdWpQdkdxcGdBTmhiZHZhdlMxNXZZUFVNUTgxczE0V0NRb21CMDRYUjZ4QzI5MTVQYWhkZGw3Nks4M3BmcnltTzl5NTRkalFzQUdRQXdlakttbld4NkdMV0Fjb0VBektVemxROExUU3R5WGcvcFpqY09xd0FaQUdEelZDYVRXOVRaUUNRelFPb3BZZnRXWjFoVHRxOWdDSVoxdjJmT2M3Ny94Mytyd0FEQUJiUG5la3VXeU1vQUFBQUFFbEZUa1N1UW1DQykgbm8tcmVwZWF0IDIwcHggMjBweDsgfQ0KLmpxdWVyeS1tc2dib3gtY29uZmlybSB7IGJhY2tncm91bmQ6IHVybChkYXRhOmltYWdlL3BuZztiYXNlNjQsaVZCT1J3MEtHZ29BQUFBTlNVaEVVZ0FBQUVBQUFBQkFDQVlBQUFDcWFYSGVBQUFBR1hSRldIUlRiMlowZDJGeVpRQkJaRzlpWlNCSmJXRm5aVkpsWVdSNWNjbGxQQUFBRGI1SlJFRlVlTnJzVzNsMFZPVVZ2MitXSkpOOVh3QVRFZ1ZrcTBWMlJIRnAxUlpyaTFLdGVGd1EvMmhhQlRmT3dXSmQ2bDVQYmZXZ0tWcFJVYXE0QkVYd0ZCU2xJa0VsSVVWQXdwSVFza0dXU1pqSlRHWjc3L3Q2NzN2ZkM1TmxRbWJ5QmowSEgrZnkzcng1NzN2M2Q1ZmZ2ZC8zSmhMbkhNN2t6UVJuK0diNW53TitqSUFmRFhBbXA4QlFCL2hweXVDdnhYVEx4MTJXK0RnT3hTYU9YU2dIeFBGeEhMTXhqREdIdEVtN09yUXFNQ25WV010V25vQ1p1SnVHTWxOSWZpekdtMFhTdnJkWlRvYWZndUtWdGVNQXF1Tm42dUZobEc5UWRwQ2dmaFVHNjZkRmdGRlZjRmVINnRuNUtQTlFMazIwZ0RrQlFaTEVtd0dzWVNZYkd1RWNqd0xudUdWWTRBcW80M3Z3OUg5UjFxS3NPejhOaHVSN0hiZFUzcTRkVFU2TGJLQ0tEcGlEdTJLckJOZW54d0trV0JFMEFwWU16bFdHYW5aaHFIU2dNZHI5R0RVYzNzRFRKYWozamdqMTFneXcwNjdGMjVUMDhGUkd3MTFQd0pPc01DYzdWb0prcS9HZ1Ezb1B4WUdHT083aFpKVC9rQ0ZRLy9WaDZoOVpDdXkwODRrRUhFTzcrS3dFU2ZWMktDWEJxQ1pUNm1sY09rNjFra2pna3VIS28yNStKZXIxSEo1K2RtcUdWQmRPQ3Bqb1lMQkcrS2FOUDRhcC9HMUJBaFNQU2FiYzV0RGpIOWVFaWIxaC93WVlNOEhDWVJ4V29oSHhzQVFOY3hSMVhENVlBNUJZMkNEQWY5WEtpY1dMYytMZ3B1SHhBR2FwcDNmVndVNVQ2T3NQSWhXa29MRElSdjVKaXdHb2Q4TmpxTzl3UFBYY2pDenB3RUNjSWlKQXMyeW9iVWNMdTFVQ1huWjJFdHlVbnlEQUM5QTBpRUo3b1ZjNDBodFl1RUxQVklRTytvQ1lFVkNVQ0RBU0l4UVZyRUxkNTRlT0FBMzNnQnhRMXN5STNWOGNreXFwcFl3SFdZK0huOGJxZjUwZUdiNXJja045dXcrY0hxMzRqeCtlQU9PR0pVQVNOUWRoanEwYnc4UlBSa1JtSEVBc05od0hUdkIzRWNPTnMzSk0vdzdGQVNGVDRNdmo3RmFzM1NwNG0rbGttRE1lUHZER0RoOXMzbWVIZDNhMlFMMURBY21XQUZJTXhxeFphMFQ1OW1QQVBXNlloYTViTkNjUHBoZWxRTGprckFocm1BUmhKcUxEeHFTb1JsaURXRnl6YzAzciswc0I2WXNtOVZhNE1POWtwN0x0R0p1TkEyMGJueWFwall3T1BKS21pYnd5ZDhWK2FHQ0pJR1hrYU1CRGVkUGxBTmJTQkhmUFNvYUZGdzZEU0pzMGVxWnVDQ2VXeS8wZFJKY3dDakVlRHNLb2NRQkRaS3lYVy9GejhkbkpXcnRLbDhtb2lVSk1ESkhKRmJOSGd5a3ZmMER3cXVLSktXQXVHZ3YvcUZRd1l0cFZsby9rZWFTcnJPcUxrWURsTWg5NVFaYVZlM3RoVk1YRWVNK3cvcnhCZVN3elRscVFoczBOblpiVkMwK1dqYkFGNy8zWmNCYmVGQldOOVdxbHUwZTVDbGRJWjFrQXk0bVhJQzNPL1B0UGEzMzNCYWNBU1k4KzRMTjZKUmRUWi9uSUpFazlGMUNHQmw2dkVxTXpMWkNNSldvRVZwR0Y1d0k4UFlORHlVVWNGay9rTUNLeGZ5UHNaeG5JSGY3SURTK01RQmpvdURCWlFzcXhQUFAzZHo2TEM5a0g0UEdTWVFqZWpIUWdpeHZEcmRNYytuSUZmWDVpcWdMVGNxVHVhS1BkcEF5QTM0eEUyU1NCMDk4ckhaQW82enVja0UyV2c4amJiSHEyakUrTHhmcWRZNU5nOUhsVDc1RWs2Y2xQanNxOEJ3ZHNycFZ0ZVBXeVhMeElwdkFSOWYyVXdyVnJBMnJJb2NmWnlmRFNoYzVQeXBUQXIyakgrblcwajFjN09hVi81U1dUR2tGMFhVRG9wQXhXcnlEUm56Y01XL2VZV052amw4Ky9PYllQQjZCY25SRW5nWVFGTllDeGMwcXlJYUxCbXdLREpFZ2x4SGx5YlgxYlY3OEdtRndRMzJOc25kd0NMSHhTOWlPbUdHemRrNUdIcnl0ZWR1a1ZoVmFUeGdGTUl5cVVlWmsydEpRaVFqaUUwTFdLOENRYlFuNlNVT0g5b0tJRkdud3hmY0JmVTBSZTR5SHZWU05JMGZKOE1LMmpmZzhTUENTbFpNeFRKNEpNNVlEdWhKMFdqNTBQV1pjUDBEOHpnNXArcXRWdXpJa1ZGVjZRTXZ1V3h3VkZBVFN5NlpROHBPdERMYm9rbldxUmhVTWkydG9TRTBzclZiRy9QTWNhMEVrd0hiRVgwaUFCMWcreGlkd3phaU05TGRpcC9LbTBGbHhwUlgyKy8rTUVEbG54SmpYS3dsa3dJUU9ZcGRDRVNUaUlEQzJ4dHJINGthcUJ4MFFoaEpKT2EzVnF6UThpTDBVbE55M25HRGRPcUV0YitYazlsQ3M1M2Uyd3ZzMHI1UERiSXFhVjREREhwWlR4SzZJSjR0Q3ZFSGVZUWJKT3ZXUnVodW9IY1hNNmxiN2dtczhNNkFQNkUvSk81ZEZPV0YxdFZUdS80RzFhTm9lN0p1cmdJMytHckdqTzdMYzN3Ty9NU0lZRll5Wm1VK1pZbUJabW5vQ2lsUmt0bkxoS0dGRlpoMGYzcjZsMGdDbXJvTWQ1S3ZjUG5hK0FUemFHWjFTUFMraHRrOVRuUEJuSVlXOVRKNUU2QnpSNi9GemtldlRBa3k2SG05MncwNU9LM3UvNVhmRllSVjA1bGcxOHRoN3laSFFwNkp3WEowaGxtOTUzYUFiUUxORHVaWEM4SzhCeVRWRmMyVFFoUzFVMGVCQjhUcC92THNobUtnRWIvckthYXhGdEZjQThDTjd0NnF4Mk96dDZSSUM2Qk5EaDRmUFRiTkd6Z01yVTFyNGxqM0kvemlxQlY0N1N3aHJYVm9Bb0VwdytEaWZzcmJ2MWJ5eEJVK0YxOWk2WW54SVhUUVB3ZnNzcDYzSmo2TWNaMW1PRTdtRTR0TGdaVk8zYXZsWHZsSU1qWUgxSEY1WVFKR1p6bEY2WkVyZk16TGZCcUdIc1pOT0N6N2RKTVJGTnZzTGRhQVd1M2MzaDlhZnVvVmR1QVZKSnJ3Snd5K1E0MStzVjNtZWFYWHhwYnBJVU5TK2syVXlRWldLcWtTV3hzQ2t6YlFJVzdaWGxKaWVEbXYyN1YzcmN0RTRFZnMwQVFXYkg0NUpHaDdJMFBjR00rUktkS21EQlRtekwzbGExRjNCNlpaZzhNaGt1bjVBSkZueGdORlBBajk1djdtVHd3ckliM3hMZTk5SkVVZThFMVczaEZOc1JuNTg5VWRmT1FuWlNrUXJabVdweXlaWTZlUFpyRDJ4MVo4QXVHQTR2N1dIWUV0ZWdncXpIZk1Ob3FiRXpxTjVYV2RKU1gwMVRUeDlsQkVWQW55V3gyMmNrTEQ5MklyRE83dWFHS2tCYlhhc0hOclFrZ1dsRUVVZ3BHV29uU010Zmgyd0Y4TW5lZHVRRktTcmdqenM1SER4VVUvcm9MUmVzRnFGUHYwZnd2ZlJWRncrMUtQckM0UllGbkI3ampFQ3N0N3ZKQTZiMDdMNlRJMXNDVkxhYlZVNHdHanhocUxVclVMYnh6Vkt4ZXQ0bERDQ3JDeUw5dlJzc25wMjhwYXZMZmN1QlpnWGNQdGI5Rm1WSVF0cFlRNjhLSjZVbUd2T2NJSEY0c09RaGhqMWxteC9hdU9ySlF5THNuYlF2MmU1VzZhOEhCd1J2ZDEyVy9ZYnpoR1B4L21NTVhMNmhSd0xOS0tlZkZSZlNBT2RsU2tEekVhTThiM2R4cUVMZGQyM2RzSHpGdmZNMmlkQW44SjJhOXpYYytteXd2M2RuL0w1ZkRIdXhvOTIrWkYrakFpMmRReU5HNHJpa09CTXNudERYMm5Qek9jd2VZVkVYTEl3QTM0emw3aEI2L3N1UFhydHo1ZjNYYnhIZ3FmZW5uMFY0Q1p1TzI4TFlRQ3VxWEVGaWVtSHB5OXYzT1hMT0tpNFlubmx0UWFZSklwMHZVS3M3UFZPR2Y4NDJ3VGV0V3AyZGtNWWd6OGFnSzhDSFhBWXBnbzYyS1ZCZFhmdEIrU2RyU3plKzhwZURBano5SXFpZDhwK3dhengzaW5lRHZZeEF2ODJwZVBpOVF3Nm5KKysyRWVrbVNFOEkzd29VYUY1OFlKekU0T0ljU1RSQ0hEeitvVGRCTGNqMDlWaSs2dy92ZmZtWlJUTldpY1Vzci9BOGdYY1RsdDVMYVJZMmlQNFRiNVRSQ0s2SDU0KzZ1L2h2R3o1dEtSeS9NQ2NuNitjVURZa1J6QjNVaHh1MHhrWXMzNERBang0NVVscSthVTNwNXRWUFZRdTI5d3JQbnhDZVYzclBTMEJmR1IyYzl6UWpsTng3RmIxbDNicDR4ZGFiN1BsamJzektUUHBKYnFvSlV1SlAxeStFdFBCdFEwNXFjWEN3Mjl2TGord3BXL2ZxZzcvN1RFeHdxTXR6QzhKemlwenZnNUlQTmdWNkdZR2hFYWlPeXMvZmNmRy9jUC9PYlkrLy82djhjNmZja0pxZVBqTWp5UVJwbUJxSlVaaFIwa1NxRTcxTkhtOUZrbXR0ckMwdDM3eW05Tk0zVlkrcnJ6R0YxenNGY05JendFUDgrb1B4Q0F5Z1Z3ZnFvdEFRNmdOWExiLzJiZHh2bkQ3M3RrS1VxOVB6Q2k5SlNFcWVTRWJRSmNrbWhVMmMxTHQ3a1JoMTBBNjM3UEYwZHV5eU45YnMzTEJ5MmNhNi9UdGQrb3Vmb05hMlUrL3krdk42dndhSTlPOEZCRGw2Qk10NnZ0NjR5b1ZTZzhjclI0dytQL1dDZVgrWWxGYzBZVkx1eUhHTEpoVmFRREtISHF2RFRRQTVObDNhY2h3Qmx3TytWciszNjZpenJiRVN3VmF1ZTI1SlpkQkt2U0pDM1NjODNTVU00Tk40OWRTZzlFc0dMSU9EakFiaUJyY0lQN0orWE1QQlhZNjFUOS9lZlBNajd3WkdqUjIveUd3T3pmSXVMNGREVFZpNmRtOTd1cTVxWjFXbi9aaHJ4L3FWRGNITzBuOFNKTHl0VDJVOVFyemlIT05oZUxPN0RCcXhDS0ViUWhoRE40UzE4THlMNW1Rbm0vcDlZNnoyQmVqcHFnWUZEbFo4L3RpcnkzKzlJUWlrRXZUekh5VUl0RStJck11cFFuMmdraHdSQnd5R0tFblpSei91ak1FcC9vSXh1VlpvZHNsOURFQ2hYdFhBb0daZitmTUN2Ri9rY0pjQUxBY1pRTjhyZ3czeFFaWGlvWERBSUF4UlhKQnBFVzl5ZTNWc01vR1hvZTV3MWVxWDdybFVYNkFnNXJZTEF5Z2lzS0swUUIvRUFkSEEvOGdHWndxeS9sOUg1VnJBNVdjOVdseXZuOE1CRFB1NlEzdGZMcmx6MWlyaDZVN1JyYm1vM3pnZHZVVFVVa0NFMS9MUmVSYXd4V0RENG1UZEJPajJhdUJydnl0Ly9wWDdMbnZyK3dMZkt3V01IZmpCOWM2cmJUSFMwckhETE5EcFk5M3ZGcHZzVEpXYWI3Yzk4Y1lEVjMwa3d0NGx3cjRUd1FmZ05HN2RFY0FOWEl2OTgzckhaRW1DRDZjVVdkVlZYd2U5aE1ENlhvdFQwMk4xTlc5dmVlM0JONnQyZk5RbVBPOFVubmVLejZkMTAzRWJGZ0VQZk9nd0kvanlLU05qSUN2UkRBZU95MURiS2tOYmgrZUwyajFmZkxqMjBldktCSnZyQ3hNZEl1d0Q4RDFzM09nVXdIRnM1UFh5STM3NHVwcUFzWS9ibTZyZlczbkgxTDM0ZGFJQXJ5OUowUlRWY3pwelBwUUJwUHRMVHd4cG9CdG0yYnFQM3lyekVGRGx5V3RTcVZsSlFLRWZJU1NKcGthZm9kSGUvKzF4bnlFbERwODVwUHN0Qml2Z0VudXJFSzR2UWdyZ1BqUzRiSVRpUm0yV0tJM0xnaVluK2h4ZFFmQS91TC9Vam9vQkVLZ2lEUENEMzg3NFA1Mzl2d0FEQUVSMDZoUlZ1anNIQUFBQUFFbEZUa1N1UW1DQykgbm8tcmVwZWF0IDIwcHggMjBweDsgfQ0K" />
					<script type="text/javascript" src="data:text/javascript;base64,LyohCiAqIGpRdWVyeSBNc2dCb3ggLSBmb3IgalF1ZXJ5IDEuMysKICogaHR0cDovL2NvZGVjYW55b24ubmV0L2l0ZW0vanF1ZXJ5LW1zZ2JveC85MjYyNj9yZWY9YWVyb2FscXVpbWlhCiAqCiAqIENvcHlyaWdodCAyMDEwLCBFZHVhcmRvIERhbmllbCBTYWRhCiAqIFlvdSBuZWVkIHRvIGJ1eSBhIGxpY2Vuc2UgaWYgeW91IHdhbnQgdXNlIHRoaXMgc2NyaXB0LgogKiBodHRwOi8vY29kZWNhbnlvbi5uZXQvd2lraS9idXlpbmcvaG93dG8tYnV5aW5nL2xpY2Vuc2luZy8KICoKICogVmVyc2lvbjogMS4zLjUgKEF1ZyAxOSAyMDEyKQogKgogKiBJbmNsdWRlcyBqUXVlcnkgRWFzaW5nIHYxLjEuMgogKiBodHRwOi8vZ3NnZC5jby51ay9zYW5kYm94L2pxdWVyeS5lYXNJbmcucGhwCiAqIENvcHlyaWdodCAoYykgMjAwNyBHZW9yZ2UgU21pdGgKICogUmVsZWFzZWQgdW5kZXIgdGhlIE1JVCBMaWNlbnNlLgogKi8KCjtldmFsKGZ1bmN0aW9uKHAsYSxjLGssZSxyKXtlPWZ1bmN0aW9uKGMpe3JldHVybihjPGE/Jyc6ZShwYXJzZUludChjL2EpKSkrKChjPWMlYSk+MzU/U3RyaW5nLmZyb21DaGFyQ29kZShjKzI5KTpjLnRvU3RyaW5nKDM2KSl9O2lmKCEnJy5yZXBsYWNlKC9eLyxTdHJpbmcpKXt3aGlsZShjLS0pcltlKGMpXT1rW2NdfHxlKGMpO2s9W2Z1bmN0aW9uKGUpe3JldHVybiByW2VdfV07ZT1mdW5jdGlvbigpe3JldHVybidcXHcrJ307Yz0xfTt3aGlsZShjLS0paWYoa1tjXSlwPXAucmVwbGFjZShuZXcgUmVnRXhwKCdcXGInK2UoYykrJ1xcYicsJ2cnKSxrW2NdKTtyZXR1cm4gcH0oJyhwKCQpe0EgbT0oMWEuMVEuMzEmJjFSKDFhLjFRLjFVLDEwKTw3JiYxUigxYS4xUS4xVSwxMCk+NCk7bigkLnY9PT1TKXskLlooe3Y6cChhLGIpe24oYSl7dj1wKCl7SCBhLjJuKGJ8fDYsMkkpfX07SCB2fX0pfTskLlooMWEuMnIsezFOOnAoeCx0LGIsYyxkLHMpe24ocz09UylzPTEuMlM7SCBjKigodD10L2QtMSkqdCooKHMrMSkqdCtzKSsxKStifX0pOyQuWigkLjJaW1wnOlwnXSx7QjpwKGEpe0ggJChhKS4yZygpfX0pOyQuWih7MUo6ezJGOnt1OlwnMm8tQ1wnLE06M2MsRToySixGOlwnMjVcJywxajpcJyMyUlwnLDFXOk8sUDp7XCcxai0xTVwnOlwnIzN0XCcsXCcxUFwnOjAuNX0sMUs6MkwsMXI6MXQsMjY6MlcsMTk6e1wnMmNcJzoxMCxcJzFUXCc6MXQsXCcxM1wnOlwnMU5cJyxcJzJmXCc6Mn0scjp7XCcxN1wnOlEsXCcxa1wnOlwnI1wnLFwnMWRcJzpcJzFIXCd9LDJsOlwnMTJcJ30sODp7fSw5OntDOltdLFk6W10scjpbXSxXOltdLFg6W119LDFnOlEsaTowLDFEOlEsMnE6cChhKXs2Ljg9JC5aKE8sNi44LGEpOzYuUC5ELncoNi44LlApOzYuUC44LjFMPSE2LjguMVc7Ni45LkMudyh7XCdFXCc6Ni44LkUsXCdGXCc6Ni44LkYsXCcxai0xTVwnOjYuOC4xan0pOzYuMWIoKX0sUDp7MXg6cChiKXs2Ljg9Yjs2LkQ9JChcJzxUIDJzPSJcJysyeCAyeSgpLjJHKCkrXCciPjwvVD5cJyk7Ni5ELncoJC5aKHt9LHtcJzExXCc6XCcyS1wnLFwnMTJcJzowLFwnTFwnOjAsXCcxUFwnOjAsXCcxNlwnOlwnMXNcJyxcJ3otMnRcJzo2LjguTX0sNi44LjFPKSk7Ni5ELjFpKCQudihwKGEpe24oNi44LjFMKXtuKCQuMVgoNi44LjFwKSl7Ni44LjFwKCl9SXs2LjFvKCl9fWEuMWYoKX0sNikpOzYuMW09Tzs2LjI4KCk7SCA2fSwyODpwKCl7Ni4xQT0kKDFCLjIyKTs2LjFBLlIoNi5EKTtuKG0pezYuRC53KHtcJzExXCc6XCcxRVwnfSk7QSBhPTFSKDYuRC53KFwnTVwnKSk7bighYSl7YT0xO0EgYj02LkQudyhcJzExXCcpO24oYj09XCcyWVwnfHwhYil7Ni5ELncoe1wnMTFcJzpcJzNJXCd9KX02LkQudyh7XCdNXCc6YX0pfWE9KCEhKDYuOC5NfHw2LjguTT09PTApJiZhPjYuOC5NKT82LjguTTphLTE7bihhPDApe2E9MX02Lk49JChcJzwzMiAycz0iMzNcJysyeCAyeSgpLjJHKCkrXCciIDM0PSIzNiIgMzg9MCAzYj0iIj48L1Q+XCcpOzYuTi53KHtNOmEsMTE6XCcxRVwnLDEyOjAsTDowLDFHOlwnMXNcJyxFOjAsRjowLDFQOjB9KTs2Lk4uM3AoNi5EKTskKFwnM3MsIDIyXCcpLncoe1wnRlwnOlwnMXQlXCcsXCdFXCc6XCcxdCVcJyxcJzJpLUxcJzowLFwnMmktMkhcJzowfSl9fSwxNTpwKHgseSl7Ni5ELncoe1wnRlwnOjAsXCdFXCc6MH0pO24oNi5OKTYuTi53KHtcJ0ZcJzowLFwnRVwnOjB9KTtBIGE9e3g6JCgxQikuRSgpLHk6JCgxQikuRigpfTs2LkQudyh7XCdFXCc6XCcxdCVcJyxcJ0ZcJzp5P3k6YS55fSk7big2Lk4pezYuTi53KHtcJ0ZcJzowLFwnRVwnOjB9KTs2Lk4udyh7XCcxMVwnOlwnMUVcJyxcJ0xcJzowLFwnMTJcJzowLFwnRVwnOjYuRC5FKCksXCdGXCc6eT95OmEueX0pfUggNn0sMTg6cCgpe24oITYuMW0pSCA2O24oNi4xMyk2LjEzLjFTKCk7Ni4xQS5VKFwnMTVcJywkLnYoNi4xNSw2KSk7Ni4xNSgpO24oNi5OKTYuTi53KHtcJzE2XCc6XCcyZFwnfSk7Ni4xbT1ROzYuMTM9Ni5ELjJNKDYuOC4xSywkLnYocCgpezYuRC4xVihcJzE4XCcpfSw2KSk7SCA2fSwxbzpwKCl7big2LjFtKUggNjtuKDYuMTMpNi4xMy4xUygpOzYuMUEuMlAoXCcxNVwnKTtuKDYuTik2Lk4udyh7XCcxNlwnOlwnMXNcJ30pOzYuMW09Tzs2LjEzPTYuRC4yUSg2LjguMXIsJC52KHAoKXs2LkQuMVYoXCcxb1wnKTs2LkQudyh7XCdGXCc6MCxcJ0VcJzowfSl9LDYpKTtIIDZ9fSwxeDpwKCl7Ni44PSQuWihPLDYuMkYsNi44KTs2LlAuMXgoezFPOjYuOC5QLDFMOiE2LjguMVcsTTo2LjguTS0xLDFLOjYuOC4xSywxcjo2LjguMXJ9KTs2LjkuQz0kKFwnPFQgSz0iXCcrNi44LnUrXCciPjwvVD5cJyk7Ni45LkMudyh7XCcxNlwnOlwnMXNcJyxcJzExXCc6XCcxRVwnLFwnMTJcJzowLFwnTFwnOjAsXCdFXCc6Ni44LkUsXCdGXCc6Ni44LkYsXCd6LTJ0XCc6Ni44Lk0sXCcyYi0yVFwnOlwnMlUtMmJcJyxcJy0yYS0xWS0xWlwnOlwnMCAwIDIwIDIxKDAsIDAsIDAsIDAuNSlcJyxcJy0ycC0xWS0xWlwnOlwnMCAwIDIwIDIxKDAsIDAsIDAsIDAuNSlcJyxcJzFZLTFaXCc6XCcwIDAgMjAgMjEoMCwgMCwgMCwgMC41KVwnLFwnLTJhLTFHLTIzXCc6XCcyNFwnLFwnLTJwLTFHLTIzXCc6XCcyNFwnLFwnMUctMjNcJzpcJzI0XCcsXCcxai0xTVwnOjYuOC4xan0pOzYuOS5ZPSQoXCc8VCBLPSJcJys2LjgudStcJy1ZIj48L1Q+XCcpOzYuOS5DLlIoNi45LlkpOzYuOS5yPSQoXCc8ciAxaz0iXCcrNi44LjM3K1wnIiAxZD0iMUgiPjwvcj5cJyk7Ni45LlkuUig2Ljkucik7Ni45Llkudyh7RjoobT8xdTpcJzI1XCcpLFwnMzktRlwnOjF1LFwnM2FcJzoxfSk7JChcJzIyXCcpLlIoNi45LkMpOzYuMjkoKTtIIDYuOS5DfSwyOTpwKCl7JCgxaCkuVShcJzE1XCcsJC52KHAoKXtuKDYuMWcpezYuUC4xNSgpOzYuMWIoKX19LDYpKTskKDFoKS5VKFwnM2RcJywkLnYocCgpe24oNi4xZyl7Ni4xYigpfX0sNikpOzYuOS5DLlUoXCczZVwnLCQudihwKGEpe24oYS4zaT09MjcpezYuMTQoUSl9fSw2KSk7Ni45LnIuVShcJ1ZcJywkLnYocChhKXskKFwnMWNbcT1WXToxSSwgR1txPVZdOjFJLCBHOjFJXCcsNi45LnIpLjFWKFwnMWlcJyk7bighOC5yLjE3KXthLjFmKCl9fSw2KSk7Ni5QLkQuVShcJzE4XCcsJC52KHAoKXskKDYpLjJlKFwnMThcJyl9LDYpKTs2LlAuRC5VKFwnMW9cJywkLnYocCgpeyQoNikuMmUoXCcxNFwnKX0sNikpfSwxODpwKGcsaCxqKXtBIGs9W1wnMmhcJyxcJzJOXCcsXCcyT1wnLFwnMWVcJyxcJzJqXCddOzYuOS5DLjJrKDYuOC51LCQudihwKGMpe2g9JC5aKE8se3E6XCcyaFwnLHI6e1wnMTdcJzpRfX0saHx8e30pO24oMUYgaC5XPT09IlMiKXtuKGgucT09XCcyalwnfHxoLnE9PVwnMWVcJyl7QSBkPVt7cTpcJ1ZcJyxCOlwnMm1cJ30se3E6XCcxcVwnLEI6XCcyVlwnfV19SXtBIGQ9W3txOlwnVlwnLEI6XCcybVwnfV19fUl7QSBkPWguV307bigxRiBoLlg9PT0iUyImJmgucT09XCcxZVwnKXtBIGY9W3txOlwnMlhcJyx1OlwnMWVcJyxCOlwnXCd9XX1Je0EgZj1oLlh9OzYuMXA9JC4xWChqKT9qOnAoZSl7fTtuKDFGIGYhPT0iUyIpezYuOS5YPSQoXCc8VCBLPSJcJys2LjgudStcJy1YIj48L1Q+XCcpOzYuOS5yLlIoNi45LlgpOyQuMXooZiwkLnYocChpLGEpe24oYS5xPT1cJzMwXCcpezF5PWEuSj9cJzxKIEs9IlwnKzYuOC51K1wnLUoiPlwnOlwnXCc7MXc9YS5KP2EuSitcJzwvSj5cJzpcJ1wnO2EuQj1hLkI9PT1TP1wnMVwnOmEuQjsxdj1hLnU9PT1TPzYuOC51K1wnLUotXCcraTphLnU7Ni45LlguUigkKDF5K1wnPDFjIHE9IlwnK2EucStcJyIgMU89IjE2OjM1OyBFOjI1OyIgdT0iXCcrMXYrXCciIEI9IlwnK2EuQitcJyIgMnU9IjJ2Ii8+IFwnKzF3KSl9SXsxeT1hLko/XCc8SiBLPSJcJys2LjgudStcJy1KIj5cJythLko6XCdcJzsxdz1hLko/XCc8L0o+XCc6XCdcJzthLkI9YS5CPT09Uz9cJ1wnOmEuQjsydz1hLjFuPT09U3x8YS4xbj09UT9cJ1wnOlwnMW49Ik8iXCc7MXY9YS51PT09Uz82LjgudStcJy1KLVwnK2k6YS51OzYuOS5YLlIoJCgxeStcJzwxYyBxPSJcJythLnErXCciIHU9IlwnKzF2K1wnIiBCPSJcJythLkIrXCciIDJ1PSIydiIgXCcrMncrXCcvPlwnKzF3KSl9fSw2KSl9Ni45Llc9JChcJzxUIEs9IlwnKzYuOC51K1wnLVciPjwvVD5cJyk7Ni45LnIuUig2LjkuVyk7bihoLnIuMTcpezYuOS5yLjFDKFwnMWtcJyxoLnIuMWs9PT1TP1wnI1wnOmguci4xayk7Ni45LnIuMUMoXCcxZFwnLGguci4xZD09PVM/XCcxSFwnOmguci4xZCk7Ni44LnIuMTc9T31JezYuOS5yLjFDKFwnMWtcJyxcJyNcJyk7Ni45LnIuMUMoXCcxZFwnLFwnMUhcJyk7Ni44LnIuMTc9UX1uKGgucSE9XCcxZVwnKXskLjF6KGQsJC52KHAoaSxhKXtuKGEucT09XCdWXCcpezYuOS5XLlIoJChcJzxHIHE9IlYiIEs9IlwnKzYuOC51K1wnLUctViBcJysoYVsiSyJdfHwiIikrXCciPlwnK2EuQitcJzwvRz5cJykuVShcJzFpXCcsJC52KHAoZSl7Ni4xNChhLkIpO2UuMWYoKX0sNikpKX1JIG4oYS5xPT1cJzFxXCcpezYuOS5XLlIoJChcJzxHIHE9IkciIEs9IlwnKzYuOC51K1wnLUctMXEgXCcrKGFbIksiXXx8IiIpK1wnIj5cJythLkIrXCc8L0c+XCcpLlUoXCcxaVwnLCQudihwKGUpezYuMTQoUSk7ZS4xZigpfSw2KSkpfX0sNikpfUkgbihoLnE9PVwnMWVcJyl7JC4xeihkLCQudihwKGksYSl7bihhLnE9PVwnVlwnKXs2LjkuVy5SKCQoXCc8RyBxPSJWIiBLPSJcJys2LjgudStcJy1HLVYgXCcrKGFbIksiXXx8IiIpK1wnIj5cJythLkIrXCc8L0c+XCcpLlUoXCcxaVwnLCQudihwKGUpe24oJChcJzFjWzFuPSJPIl06MnooOkIpXCcpLjJBPjApeyQoXCcxY1sxbj0iTyJdOjJ6KDpCKToxSVwnKS4yQigpOzYuMTkoKX1JIG4oNi44LnIuMTcpe0ggT31JezYuMTQoNi4yQygkKFwnMWNcJyw2LjkuWCkpKX1lLjFmKCl9LDYpKSl9SSBuKGEucT09XCcxcVwnKXs2LjkuVy5SKCQoXCc8RyBxPSJHIiBLPSJcJys2LjgudStcJy1HLTFxIFwnKyhhWyJLIl18fCIiKStcJyI+XCcrYS5CK1wnPC9HPlwnKS5VKFwnMWlcJywkLnYocChlKXs2LjE0KFEpO2UuMWYoKX0sNikpKX19LDYpKX07Ni45LnIuM2YoZyk7JC4xeihrLCQudihwKGksZSl7Ni45LlkuM2coNi44LnUrXCctXCcrZSl9LDYpKTs2LjkuWS4zaCg2LjgudStcJy1cJytoLnEpOzYuMWIoKTs2LjFnPU87Ni5QLjE4KCk7Ni45LkMudyh7MTY6XCcyZFwnLEw6KCgkKDFCKS5FKCktNi44LkUpLzIpfSk7Ni4xYigpOzJEKCQudihwKCl7QSBiPSQoXCcxYywgR1wnLDYuOS5DKTtuKGIuMkEpe2IuM2ooMCkuMkIoKX19LDYpLDYuOC4yNil9LDYpKTs2LmkrKztuKDYuaT09MSl7Ni45LkMuMkUoNi44LnUpfX0sMkM6cChiKXtIICQuM2soYixwKGEpe0ggJChhKS4yZygpfSl9LDFiOnAoKXtBIGE9e3g6JCgxaCkuRSgpLHk6JCgxaCkuRigpfTtBIGI9e3g6JCgxaCkuM2woKSx5OiQoMWgpLjNtKCl9O0EgYz02LjkuQy4zbigpO0EgeT0wO0EgeD0wO3k9Yi54KygoYS54LTYuOC5FKS8yKTtuKDYuOC4ybD09IjNvIil7eD0oYi55K2EueSsxdSl9SXt4PShiLnktYyktMXV9big2LjFnKXtuKDYuMUQpezYuMUQuMVN9Ni4xRD02LjkuQy4xbCh7TDp5LDEyOmIueSsoKGEueS1jKS8yKX0sezFUOjYuOC4yNiwyazpRLDJyOlwnMU5cJ30pfUl7Ni45LkMudyh7MTI6eCxMOnl9KX19LDE0OnAoYSl7Ni45LkMudyh7MTY6XCcxc1wnLDEyOjB9KTs2LjFnPVE7bigkLjFYKDYuMXApKXs2LjFwLjJuKDYsJC4zcShhKSl9MkQoJC52KHAoKXs2LmktLTs2LjkuQy4yRSg2LjgudSl9LDYpLDYuOC4xcik7big2Lmk9PTEpezYuUC4xbygpfTYuMWIoKTs2Ljkuci4zcigpfSwxOTpwKCl7QSB4PTYuOC4xOS4yYztBIGQ9Ni44LjE5LjFUO0EgdD02LjguMTkuMTM7QSBvPTYuOC4xOS4yZjtBIGw9Ni45LkMuMTEoKS5MO0EgZT02LjkuQzszdShpPTA7aTxvO2krKyl7ZS4xbCh7TDpsK3h9LGQsdCk7ZS4xbCh7TDpsLXh9LGQsdCl9O2UuMWwoe0w6bCt4fSxkLHQpO2UuMWwoe0w6bH0sZCx0KX19LEM6cChhLGIsYyl7bigxRiBhPT0iM3YiKXskLjFKLjJxKGEpfUl7SCAkLjFKLjE4KGEsYixjKX19fSk7JChwKCl7bigzdygkLjN4LjJvKT4xLjIpeyQuMUouMXgoKX1JezN5IjN6IDFhIDFVIDNBIDNCIDNDIDNEIDNFIDNGLiAzRyAzSCAxYSAxLjMrIjt9fSl9KSgxYSk7Jyw2MiwyMzEsJ3x8fHx8fHRoaXN8fG9wdGlvbnN8ZXNxdWVsZXRvfHx8fHx8fHx8fHx8fHxpZnx8ZnVuY3Rpb258dHlwZXxmb3JtfHx8bmFtZXxwcm94eXxjc3N8fHx8dmFyfHZhbHVlfG1zZ2JveHxlbGVtZW50fHdpZHRofGhlaWdodHxidXR0b258cmV0dXJufGVsc2V8bGFiZWx8Y2xhc3N8bGVmdHx6SW5kZXh8c2hpbXx0cnVlfG92ZXJsYXl8ZmFsc2V8YXBwZW5kfHVuZGVmaW5lZHxkaXZ8YmluZHxzdWJtaXR8YnV0dG9uc3xpbnB1dHN8d3JhcHBlcnxleHRlbmR8fHBvc2l0aW9ufHRvcHx0cmFuc2l0aW9ufGNsb3NlfHJlc2l6ZXxkaXNwbGF5fGFjdGl2ZXxzaG93fHNoYWtlfGpRdWVyeXxtb3ZlQm94fGlucHV0fG1ldGhvZHxwcm9tcHR8cHJldmVudERlZmF1bHR8dmlzaWJsZXx3aW5kb3d8Y2xpY2t8YmFja2dyb3VuZHxhY3Rpb258YW5pbWF0ZXxoaWRkZW58cmVxdWlyZWR8aGlkZXxjYWxsYmFja3xjYW5jZWx8Y2xvc2VEdXJhdGlvbnxub25lfDEwMHw4MHxpTmFtZXxmTGFiZWx8Y3JlYXRlfGlMYWJlbHxlYWNofHRhcmdldHxkb2N1bWVudHxhdHRyfGFuaW1hdGlvbnxhYnNvbHV0ZXx0eXBlb2Z8Ym9yZGVyfHBvc3R8Zmlyc3R8TXNnQm94T2JqZWN0fHNob3dEdXJhdGlvbnxoaWRlT25DbGlja3xjb2xvcnxlYXNlT3V0QmFja3xzdHlsZXxvcGFjaXR5fGJyb3dzZXJ8cGFyc2VJbnR8c3RvcHxkdXJhdGlvbnx2ZXJzaW9ufHRyaWdnZXJ8bW9kYWx8aXNGdW5jdGlvbnxib3h8c2hhZG93fDE1cHh8cmdiYXxib2R5fHJhZGl1c3w2cHh8YXV0b3xtb3ZlRHVyYXRpb258fGluamVjdHxhZGRldmVudHN8bW96fHdvcmR8ZGlzdGFuY2V8YmxvY2t8dHJpZ2dlckhhbmRsZXJ8bG9vcHN8dmFsfGFsZXJ0fG1hcmdpbnxjb25maXJtfHF1ZXVlfGVtZXJnZWZyb218QWNjZXB0fGFwcGx5fGpxdWVyeXx3ZWJraXR8Y29uZmlnfGVhc2luZ3xpZHxpbmRleHxhdXRvY29tcGxldGV8b2ZmfGlSZXF1aXJlZHxuZXd8RGF0ZXxub3R8bGVuZ3RofGZvY3VzfHRvQXJndW1lbnRzfHNldFRpbWVvdXR8ZGVxdWV1ZXxkZWZhdWx0c3xnZXRUaW1lfHJpZ2h0fGFyZ3VtZW50c3w1MjB8Zml4ZWR8MjAwfGZhZGVJbnxpbmZvfGVycm9yfHVuYmluZHxmYWRlT3V0fEZGRkZGRnw3MDE1OHx3cmFwfGJyZWFrfENhbmNlbHw1MDB8dGV4dHxzdGF0aWN8ZXhwcnxjaGVja2JveHxtc2llfGlmcmFtZXxJRl98c2Nyb2xsaW5nfGlubGluZXxub3xmb3JtYWN0aW9ufGZyYW1lYm9yZGVyfG1pbnx6b29tfHNyY3wxMDAwMHxzY3JvbGx8a2V5ZG93bnxwcmVwZW5kfHJlbW92ZUNsYXNzfGFkZENsYXNzfGtleUNvZGV8Z2V0fG1hcHxzY3JvbGxMZWZ0fHNjcm9sbFRvcHxvdXRlckhlaWdodHxib3R0b218aW5zZXJ0QWZ0ZXJ8bWFrZUFycmF5fGVtcHR5fGh0bWx8MDAwMDAwfGZvcnxvYmplY3R8cGFyc2VGbG9hdHxmbnx0aHJvd3xUaGV8dGhhdHx3YXN8bG9hZGVkfGlzfHRvb3xvbGR8TXNnQm94fHJlcXVpcmVzfHJlbGF0aXZlJy5zcGxpdCgnfCcpLDAse30pKTs="></script>
					<style type="text/css">
						button { margin-left: 10px; }
						.btn-advanced { -moz-box-shadow:inset 0px 1px 0px 0px #ffffff; -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff; box-shadow:inset 0px 1px 0px 0px #ffffff; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) ); background:-moz-linear-gradient( center top, #ededed 5%, #dfdfdf 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf'); background-color:#ededed; -moz-border-radius:3px; -webkit-border-radius:3px; border-radius:3px; border:1px solid #dcdcdc; display:inline-block; color:#777777; font-family:arial; font-size:11px; font-weight:bold; padding:6px 12px; text-decoration:none; text-shadow:1px 1px 0px #ffffff; }
						.btn-advanced:hover { cursor: pointer; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) ); background:-moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed'); background-color:#dfdfdf; }
						.btn-advanced:active { cursor: pointer; position:relative; top:1px; }
					</style>
				<h2><?php echo $heading_minify_javascript; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_minify_javascript; ?></td>
						<td>
							<input type="radio" name="config_minify_javascript" value="1" <?php echo ($config_minify_javascript) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_minify_javascript" value="0" <?php echo (!$config_minify_javascript) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_javascript_jquery; ?></td>
						<td>
							<input type="radio" onchange="jquery_version_display_toggle();" name="config_javascript_jquery" value="1" <?php echo ($config_javascript_jquery) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" onchange="jquery_version_display_toggle();" name="config_javascript_jquery" value="0" <?php echo (!$config_javascript_jquery) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr id="config_javascript_jquery_version" style="display:none;">
						<td><?php echo $entry_javascript_jquery_version; ?></td>
						<td><input type="text" name="config_javascript_jquery_version" size="2" value="<?php echo $config_javascript_jquery_version; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_javascript_jqueryui; ?></td>
						<td>
							<input type="radio" onchange="jqueryui_version_display_toggle();" name="config_javascript_jqueryui" value="1" <?php echo ($config_javascript_jqueryui) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" onchange="jqueryui_version_display_toggle();" name="config_javascript_jqueryui" value="0" <?php echo (!$config_javascript_jqueryui) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr id="config_javascript_jquery_ui_version" style="display:none;">
						<td><?php echo $entry_javascript_jqueryui_version; ?></td>
						<td><input type="text" name="config_javascript_jqueryui_version" size="2" value="<?php echo $config_javascript_jqueryui_version; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_javascript_defer; ?></td>
						<td>
							<input type="radio" name="config_javascript_defer" value="1" <?php echo ($config_javascript_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_javascript_defer" value="0" <?php echo (!$config_javascript_defer) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<script type="text/javascript"><!--
						function jqueryui_version_display_toggle() {
							if ($('input:radio[name=config_javascript_jqueryui]:checked').val() == 1) {
								$('#config_javascript_jquery_ui_version').show();
							} else {
								$('#config_javascript_jquery_ui_version').hide();
							}
							
						}
						function jquery_version_display_toggle() {
							if ($('input:radio[name=config_javascript_jquery]:checked').val() == 1) {
								$('#config_javascript_jquery_version').show();
							} else {
								$('#config_javascript_jquery_version').hide();
							}
							
						}
						jqueryui_version_display_toggle();
						jquery_version_display_toggle();
					// --></script>
				</table>
				
				<h2><?php echo $heading_minify_css; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_minify_css; ?></td>
						<td>
							<input type="radio" name="config_minify_css" value="1" <?php echo ($config_minify_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_minify_css" value="0" <?php echo (!$config_minify_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_minify_encode_images; ?></td>
						<td>
							<input type="radio" name="config_minify_encode_images" value="1" <?php echo ($config_minify_encode_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_minify_encode_images" value="0" <?php echo (!$config_minify_encode_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_minify_image_size; ?></td>
						<td>
							<select name="config_minify_image_size">
								<?php for ($i = 1; $i <= 10; $i++) { ?>
								<option value="<?php echo ($i * 1024); ?>" <?php echo (($i * 1024) == $config_minify_image_size) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> KB<?php echo ($i == 3) ? ' ' . $text_default : ''; ?></option>
								<?php } ?>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_minify_image_occurs; ?></td>
						<td>
							<select name="config_minify_image_occurs">
								<?php for ($i = 1; $i <= 10; $i++) { ?>
								<option value="<?php echo $i; ?>" <?php echo ($i == $config_minify_image_occurs) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> <?php echo ($i == 1) ? $text_time : $text_times; ?><?php echo ($i == 3) ? ' ' . $text_default : ''; ?></option>
								<?php } ?>
							</select>
						</td>
					</tr>
				</table>
				
				<h2><?php echo $heading_minify_settings; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_minify_encode_url; ?></td>
						<td>
							<input type="radio" name="config_minify_encode_url" value="1" <?php echo ($config_minify_encode_url) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_minify_encode_url" value="0" <?php echo (!$config_minify_encode_url) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_minify_storage; ?></td>
						<td>
							<?php if (extension_loaded('apc')) { ?>
							<input type="radio" name="config_minify_storage" value="1" <?php echo ($config_minify_storage) ? 'checked="checked"' : ''; ?> /><?php echo $text_in_memory_apc; ?>
							<input type="radio" name="config_minify_storage" value="0" <?php echo (!$config_minify_storage) ? 'checked="checked"' : ''; ?> /><?php echo $text_file_system; ?>
							<?php } else { ?>
								<?php echo $text_memory_none; ?><input type="hidden" name="config_minify_storage" value="0" />
							<?php } ?>
						</td>
					</tr>
					<tr>
						<td valign="top"><?php echo $entry_minify_advanced; ?></td>
						<td><span  class="btn-advanced" onclick="$('#optimize-advanced').slideToggle('slow'); if ($(this).html() == '<?php echo $text_show_advanced; ?>') { $(this).html('<?php echo $text_hide_advanced; ?>'); } else { $(this).html('<?php echo $text_show_advanced; ?>'); }"><?php echo $text_show_advanced; ?></span>
							<div id="optimize-advanced" style="display:none;">
							<table class="form">
								<tr>
									<td><?php echo $entry_minify_logging; ?></td>
									<td>
										<input type="radio" name="config_minify_logging" value="1" <?php echo ($config_minify_logging) ? 'checked="checked"' : ''; ?> /><?php echo $text_on; ?>
										<input type="radio" name="config_minify_logging" value="0" <?php echo (!$config_minify_logging) ? 'checked="checked"' : ''; ?> /><?php echo $text_off . ' ' . $text_default; ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $entry_minify_debug_mode; ?></td>
									<td>
										<input type="radio" name="config_minify_debug_mode" value="1" <?php echo ($config_minify_debug_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_on; ?>
										<input type="radio" name="config_minify_debug_mode" value="0" <?php echo (!$config_minify_debug_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_off . ' ' . $text_default; ?>
									</td>
								</tr>
								<tr>
									<td><?php echo $entry_minify_max_age; ?></td>
									<td>
										<select name="config_minify_max_age">
											<?php for ($i = 1; $i <= 100; $i++) { ?>
											<option value="<?php echo ($i * 86400); ?>" <?php echo (($i * 86400) == $config_minify_max_age) ? 'selected="selected"' : ''; ?>><?php echo $i; ?> <?php echo ($i == 1) ? $text_day : $text_days; ?><?php echo ($i == 10) ? ' ' . $text_default : ''; ?></option>
											<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $entry_minify_file_path; ?></td>
									<td>
										<input type="text" name="config_minify_file_path" value="<?php echo $config_minify_file_path; ?>" />
									</td>
								</tr>
								<tr>
									<td><?php echo $entry_minify_file_locking; ?></td>
									<td>
										<input type="radio" name="config_minify_file_locking" value="1" <?php echo ($config_minify_file_locking) ? 'checked="checked"' : ''; ?> /><?php echo $text_on . ' ' . $text_default; ?>
										<input type="radio" name="config_minify_file_locking" value="0" <?php echo (!$config_minify_file_locking) ? 'checked="checked"' : ''; ?> /><?php echo $text_off; ?>
									</td>
								</td>
								<tr>
									<td><?php echo $entry_ipsjs_excludes; ?></td>
									<td><textarea name="config_ipsjs_excludes" cols="40"><?php echo $config_ipsjs_excludes; ?></textarea></td>
								</tr>
								<tr>
									<td><?php echo $entry_ipscss_excludes; ?></td>
									<td><textarea name="config_ipscss_excludes" cols="40"><?php echo $config_ipscss_excludes; ?></textarea></td>
								</tr>
							</table>
							</div>
						</td>
					</tr>
				</table>
				
				<h2><?php echo $heading_data_caching; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_category_counts; ?></td>
						<td>
							<input type="radio" name="config_category_counts" value="1" <?php echo ($config_category_counts) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="config_category_counts" value="0" <?php echo (!$config_category_counts) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_ipscron_status; ?></td>
						<td><span class="help" id="ipscron_status"><?php echo $config_ipscron_status; ?></span><input type="hidden" name="config_ipscron_status" value="<?php echo $config_ipscron_status; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_memory_cache; ?></td>
						<td>
							<?php if (extension_loaded('apc') || extension_loaded('xcache')) { ?>
								<select name="config_memory_cache">
									<option value="0"><?php echo $text_memory_file; ?></option>
									<?php if (extension_loaded('apc')) { ?><option value="1" <?php if ($config_memory_cache == 1) { echo 'selected="selected"'; } ?>><?php echo $text_memory_apc; ?></option><?php } ?>
									<?php if (extension_loaded('xcache')) { ?><option value="2" <?php if ($config_memory_cache == 2) { echo 'selected="selected"'; } ?>><?php echo $text_memory_xcache; ?></option><?php } ?>
								</select>
							<?php } else { ?>
								<?php echo $text_memory_none; ?><input type="hidden" name="config_memory_cache" value="0" />
							<?php } ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_seo_cache; ?></td>
						<td>
							<input type="radio" name="config_seo_cache" value="1" <?php echo ($config_seo_cache) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="config_seo_cache" value="0" <?php echo (!$config_seo_cache) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
				</table>
				
				<h2><?php echo $heading_html_images; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_minify_html; ?></td>
						<td>
							<input type="radio" name="config_minify_html" value="1" <?php echo ($config_minify_html) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_minify_html" value="0" <?php echo (!$config_minify_html) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_jpeg_compression; ?></td>
						<td>
							<input type="text" name="config_jpeg_compression" value="<?php echo $config_jpeg_compression; ?>" />
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_logo_dimensions; ?></td>
						<td>
							<input type="text" name="config_logo_width" value="<?php echo $config_logo_width; ?>" size="3" />
							x
							<input type="text" name="config_logo_height" value="<?php echo $config_logo_height; ?>" size="3" />
						</td>
					</tr>
					<tr>
						<td valign="top"><?php echo $entry_image_dimensions; ?></td>
						<td><?php echo $text_image_dimensions; ?></td>
					</tr>
				</table>

				<h2><?php echo $heading_content_delivery; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_cdn_status; ?></td>
						<td>
							<input type="radio" name="config_cdn_status" value="1" <?php echo ($config_cdn_status) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_cdn_status" value="0" <?php echo (!$config_cdn_status) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_cdn_http; ?></td>
						<td><input type="text" name="config_cdn_http" size="80" value="<?php echo $config_cdn_http; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_cdn_https; ?></td>
						<td><input type="text" name="config_cdn_https" size="80" value="<?php echo $config_cdn_https; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_cdn_images; ?></td>
						<td>
							<input type="radio" name="config_cdn_images" value="1" <?php echo ($config_cdn_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_cdn_images" value="0" <?php echo (!$config_cdn_images) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_cdn_css; ?></td>
						<td>
							<input type="radio" name="config_cdn_css" value="1" <?php echo ($config_cdn_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_cdn_css" value="0" <?php echo (!$config_cdn_css) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_cdn_js; ?></td>
						<td>
							<input type="radio" name="config_cdn_js" value="1" <?php echo ($config_cdn_js) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="config_cdn_js" value="0" <?php echo (!$config_cdn_js) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
			</table>
			<h2><?php echo $heading_speed_analyzer ?></h2>
			<table class="form">
					<tr>
						<td><?php echo $entry_firebug_analyzer; ?></td>
						<td>
							<input type="radio" name="config_firebug_analyzer" value="1" <?php echo ($config_firebug_analyzer) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="config_firebug_analyzer" value="0" <?php echo (!$config_firebug_analyzer) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_firebug_queries; ?></td>
						<td>
							<input type="radio" name="config_firebug_queries" value="1" <?php echo ($config_firebug_queries) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="config_firebug_queries" value="0" <?php echo (!$config_firebug_queries) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
			</table>
			</div>
			
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#template').load('index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent($('select[name=\'config_template\']').attr('value')));
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'config_country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/country&token=<?php echo $token; ?>&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt="" /></span>');
		},		
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'config_zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_country_id\']').trigger('change');
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>