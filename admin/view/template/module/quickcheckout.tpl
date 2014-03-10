<?php echo $header; ?>
<div class="breadcrumb">
  <div class="layout">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box"> 
  <!-- 100% -->
  <div class="heading" style="background: #fff !important;">
    <div class="layout">
      <h1><i class="icon-small-module"></i> <?php echo $heading_title_main; ?> <?php echo $version; ?></h1>
      
      <div class="buttons"><?php if(isset($stores)){ ?>
      	<select onChange="location='<?php echo $route; ?>&store_id='+$(this).val()">
			<?php foreach($stores as $store){ ?>
      			<?php if($store['store_id'] ==  $quickcheckout['general']['store_id']){ ?>
                <option value="<?php echo $store['store_id']; ?>" selected="selected" ><?php echo $store['name']; ?></option>
                <?php }else{ ?>
                <option value="<?php echo $store['store_id']; ?>" ><?php echo $store['name']; ?></option>
                <?php } ?>
                
      		<?php }?>    
		</select>
        <?php }?> <a onClick="saveAndStay()" class="button"><span><?php echo $button_save_and_stay; ?></span></a><a onClick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onClick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
  </div>
  <!-- 960px -->
  <div class="content tabs">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    <div class="layout">
      <div class="tabs-menu even-height">
        <div class="wrap">
          <ul id="tabs_menu">
            <li><a href="#tab_home" class="selected"><i class="icon-small-home"></i><span><?php echo $text_home; ?></span></a></li>
            <li><a href="#tab_general_settings"><i class="icon-small-settings"></i><span><?php echo $text_general; ?></span></a></li>
            <li><a href="#tab_payment_address"><i class="icon-small-payment-address"></i><span><?php echo $text_payment_address; ?></span></a></li>
            <li><a href="#tab_shipping_address"><i class="icon-small-shipping-address"></i><span><?php echo $text_shipping_address; ?></span></a></li>
            <li><a href="#tab_shipping"><i class="icon-small-shipping-method"></i><span><?php echo $text_shipping_method; ?></span></a></li>
            <li><a href="#tab_payment"><i class="icon-small-payment-method"></i><span><?php echo $text_payment_method; ?></span></a></li>
            <li><a href="#tab_confirm"><i class="icon-small-confirm"></i><span><?php echo $text_confirm; ?></span></a></li>
            <li><a href="#tab_design_checkout"><i class="icon-small-design"></i><span><?php echo $text_design; ?></span></a></li>
          </ul>
        </div>
      </div>
      <div class="tabs-content even-height">
        <div class="wrap">
          <div id="tab_home" class="tab-item">
            <div class="title"><i class="icon-home"></i><span><?php echo $text_home; ?></span></div>
            <div class="block">
            	<table>
                <div class="h1"><?php echo $text_home_h1; ?></div>
                <div class="h2"><?php echo $text_home_h2; ?></div>
                <div class="tiles">
                  <div class="settings tile"> <a class="tile" href="#tab_general_settings"> <i class="icon-large-settings"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_general; ?></span>
                      <p><?php echo $text_general_intro; ?></p>
                    </div>
                    </a> </div>

                  <div class="payment-address tile"> <a class="tile" href="#tab_payment_address"> <i class="icon-large-payment-address"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_payment_address; ?></span>
                      <p><?php echo $text_payment_address_intro; ?></p>
                    </div>
                    </a> </div>
                  <div class="shipping-address tile"> <a class="tile" href="#tab_shipping_address"> <i class="icon-large-shipping-address"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_shipping_address; ?></span>
                      <p><?php echo $text_shipping_address_intro; ?></p>
                    </div>
                    </a> </div>
                  <div class="shipping-method tile"> <a class="home-pill" href="#tab_shipping"> <i class="icon-large-shipping-method"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_shipping_method; ?></span>
                      <p><?php echo $text_shipping_method_intro; ?></p>
                    </div>
                    </a> </div>
                  <div class="payment-method tile"> <a class="home-pill" href="#tab_payment"> <i class="icon-large-payment-method"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_payment_method; ?></span>
                      <p><?php echo $text_payment_method_intro; ?></p>
                    </div>
                    </a> </div>
                  <div class="confirm tile"> <a class="home-pill" href="#tab_confirm"> <i class="icon-large-confirm"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_confirm; ?></span>
                      <p><?php echo $text_confirm_intro; ?></p>
                    </div>
                    </a> </div>
                  <div class="design tile"> <a class="home-pill" href="#tab_design_checkout"> <i class="icon-large-design"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_design; ?></span>
                      <p><?php echo $text_design_intro; ?></p>
                    </div>
                    </a> </div>
                  <!-- <div class="profile tile"> <a class="tile" href="#tab_customer_info"> <i class="icon-large-profile"></i>
                    <div class="block-tab"> <span class="content-title-block"><?php echo $text_plugins; ?></span>
                      <p><?php echo $text_plugins_intro; ?></p>
                    </div>
                    </a> </div>-->
                </div>
              </table>
            </div>
          </div>
          <!---------------------------------- General ---------------------------------->
          <div id="tab_general_settings" class="tab-item">
            <div class="title"><i class="icon-settings"></i><span><?php echo $text_general; ?></span></div>
            <div class="block">
              <table class="form">
                <tr>
                  <td class="name"><span><?php echo $text_general_enable; ?></span><i class="icon-help" data-help="<?php echo $general_enable_tooltip; ?>"></i></td>
                  <td class="settings "><input type="hidden" value="0" name="quickcheckout[general][enable]" />
                    <?php if(isset($quickcheckout['general']['enable']) && $quickcheckout['general']['enable'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][enable]" id="checkout_enable" checked="checked" />
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][enable]" id="checkout_enable"/>
                    <?php } ?>
                    <label  for="checkout_enable"><?php echo $settings_enable; ?></label>
                  </td>
                  <td class="select-all"><a id="checkout_select_all">Select all</a> / <a id="checkout_unselect_all">Unselect all</a></td>
                </tr>
                <tr>
                  <td class="name"><span><?php echo $text_general_version; ?></span><i class="icon-help" data-help="<?php echo $general_version_tooltip; ?>"></i></td>
                  <td class="settings "><a id="version_check" class="button">Check for update</a>
                  </td>
                  <td id="version_result"></td>
                </tr>
                <tr>
                  <td class="name"><span><?php echo $text_general_debug; ?></span><i class="icon-help" data-help="<?php echo $general_debug_tooltip; ?>"></i></td>
                  <td class="settings"><input type="hidden" value="0" name="quickcheckout[general][debug]" />
                    <?php if(isset($quickcheckout['general']['debug']) && $quickcheckout['general']['debug'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][debug]" checked="checked" id="general_debug" />
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][debug]" id="general_debug" />
                    <?php } ?>
                    <label  for="general_debug"><?php echo $settings_enable; ?></label></td>
                  <td></td>
                </tr>
                <tr>
                  <td class="name"><span><?php echo $text_general_default; ?></span><i class="icon-help" data-help="<?php echo $general_default_tooltip; ?>"></i></td>
                  <td class="settings">
                    <?php if(isset($quickcheckout['general']['default_option']) && $quickcheckout['general']['default_option'] == 'guest'){ ?>
                    <input class="styled" type="radio" value="guest" name="quickcheckout[general][default_option]" checked="checked" id="general_default_option_guest" /><label  for="general_default_option_guest"><?php echo $text_guest; ?></label>
                    <input class="styled" type="radio" value="register" name="quickcheckout[general][default_option]" id="general_default_option_register" /><label  for="general_default_option_register"><?php echo $text_register; ?></label>
                    <?php }else{ ?>
                    <input class="styled" type="radio" value="guest" name="quickcheckout[general][default_option]" id="general_default_option_guest" /><label  for="general_default_option_guest"><?php echo $text_guest; ?></label>
                    <input class="styled" type="radio" value="register" name="quickcheckout[general][default_option]" checked="checked"  id="general_default_option_register" /><label  for="general_default_option_register"><?php echo $text_register; ?></label>
                    <?php } ?>
                    </td>
                  <td></td>
                </tr>
                <tr>
                  <td class="name"><span><?php echo $text_general_main_checkout; ?></span><i class="icon-help" data-help="<?php echo $general_main_checkout_tooltip; ?>"></i></td>
                  <td class="settings"><input type="hidden" value="0" name="quickcheckout[general][main_checkout]" />
                    <?php if(isset($quickcheckout['general']['main_checkout']) && $quickcheckout['general']['main_checkout'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][main_checkout]" checked="checked" id="general_main_checkout" />
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[general][main_checkout]" id="general_main_checkout" />
                    <?php } ?>
                    <label  for="general_main_checkout"><?php echo $settings_enable; ?></label></td>
                  <td></td>
                </tr>

                <tr>
                  <td class="name"><span><?php echo $text_general_min_order; ?></span><i class="icon-help" data-help="<?php echo $general_min_order_tooltip; ?>"></i></td>
                  <td class="settings"><?php if(isset($quickcheckout['general']['min_order']['value']) && $quickcheckout['general']['min_order']['value'] != ""){ ?>
                    <input type="text" value="<?php echo $quickcheckout['general']['min_order']['value']; ?>" name="quickcheckout[general][min_order][value]" id="general_min_order_value" class="styled"/>
                    <?php }else{ ?>
                    <input type="text" value="0" name="quickcheckout[general][min_order][value]" id="general_min_order_value"/>
                    <?php } ?>
                    <label for="general_min_order_value"> %s</label>
                  </td>
                  <td class="languages"><?php foreach ($languages as $language) { ?>
                    <div id="tab_general_min_order_text_<?php echo $language['language_id']; ?>">
                      <label for="general_min_order_text_<?php echo $language['language_id']; ?>" title="<?php echo $language['name']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></label>
                      <input type="text" name="quickcheckout[general][min_order][text][<?php echo $language['language_id']; ?>]" id="general_min_order_text_<?php echo $language['language_id']; ?>" value="<?php echo isset($quickcheckout['general']['min_order']['text'][$language['language_id']]) ? $quickcheckout['general']['min_order']['text'][$language['language_id']] : $language_min_order_text; ?>" >
                    </div>
                    <?php } ?>
                  </td>
                </tr>
                <tr>
                  <td class="name"><span><?php echo $text_general_default_email; ?></span><i class="icon-help" data-help="<?php echo $general_default_email_tooltip; ?>"></i></td>
                  <td class="settings"><?php if(isset($quickcheckout['general']['default_email']) && $quickcheckout['general']['default_email'] != ""){ ?>
                    <input type="text" value="<?php echo $quickcheckout['general']['default_email']; ?>" name="quickcheckout[general][default_email]" id="general_default_email" class="styled"/>
                    <?php }else{ ?>
                    <input type="text" value="0" name="quickcheckout[general][default_email]" id="general_default_email"/>
                    <?php } ?>
                   
                  </td>
                  <td></td>
                </tr>
            </table>
          <div class="title"><span><?php echo $text_position_module; ?></span><i class="icon-help" data-help="<?php echo $position_module_tooltip; ?>"></i></div>
           <table id="module" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_layout; ?></td>
              <td class="left"><?php echo $entry_position; ?></td>
              <td class="left"><?php echo $entry_status; ?></td>
              <td class="left"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($quickcheckout_modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="left"><select name="quickcheckout_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="quickcheckout_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="quickcheckout_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="left"><input type="text" name="quickcheckout_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
              <td class="left"><a onClick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><a onClick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
            </div>
          </div>
          <!---------------------------------- Payment Address ---------------------------------->
          <div id="tab_payment_address" class="tab-item">
            <div class="title"><i class="icon-payment-address"></i><span><?php echo $text_payment_address; ?></span></div>
            <div class="block">
              <table class="form">
                <thead>
                  <tr>
                    <th></th>
                    <th class="guest"><?php echo $text_guest_customer; ?></th>
                    <th class="register"><?php echo $text_registrating_customer; ?></th>
                    <th class="login"><?php echo $text_logged_in_customer; ?></th>
                  </tr>
                </thead>
                <tbody>
                <tr id="payment_address_display_input"  sort-data="-1">
                    <td class="name"><span><?php echo $text_payment_address_display_input; ?></span>
                    </td>
                    <td >

                    	<input type="hidden" value="0" name="quickcheckout[option][guest][payment_address][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['payment_address']['display']) && $quickcheckout['option']['guest']['payment_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][display]" checked="checked" id="guest_payment_address_fields_display_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][display]" id="guest_payment_address_fields_display_display" />
                      <?php } ?>
                      	<label for="guest_payment_address_fields_display_display"><?php echo $settings_display; ?></label>
                  
                    </td>
                    <td >

                    	<input type="hidden" value="0" name="quickcheckout[option][register][payment_address][display]" />
                      <?php if(isset($quickcheckout['option']['register']['payment_address']['display']) && $quickcheckout['option']['register']['payment_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][display]" checked="checked" id="register_payment_address_fields_display_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][display]" id="register_payment_address_fields_display_display" />
                      <?php } ?>
                      	<label for="register_payment_address_fields_display_display"><?php echo $settings_display; ?></label>
                     
                  </td>
                  <td >
                  
                    	<input type="hidden" value="0" name="quickcheckout[option][logged][payment_address][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['payment_address']['display']) && $quickcheckout['option']['logged']['payment_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][display]" checked="checked" id="logged_payment_address_fields_display_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][display]" id="logged_payment_address_fields_display_display" />
                      <?php } ?>
                      	<label for="logged_payment_address_fields_display_display"><?php echo $settings_display; ?></label>
                      
                  </td>
                  </tr>  
                  </tbody>
                  <tbody class="sortable ui-sortable">  
                <?php foreach($quickcheckout['step']['payment_address']['fields'] as $field){?>
                <tr id="payment_address_<?php echo $field['id']; ?>_input" class="sort-item <?php echo ($field['type'] == 'system')? 'hide' : ''; ?>" sort-data="<?php echo (isset($quickcheckout['step']['payment_address']['fields'][$field['id']]['sort_order']) ? $quickcheckout['step']['payment_address']['fields'][$field['id']]['sort_order'] : ''); ?>">
                    <td class="name"><span><?php echo $field['title']; ?>
                      <input class="sort" type="text" value="<?php echo (isset($quickcheckout['step']['payment_address']['fields'][$field['id']]['sort_order'])) ? $quickcheckout['step']['payment_address']['fields'][$field['id']]['sort_order'] : ''; ?>" name="quickcheckout[step][payment_address][fields][<?php echo $field['id']; ?>][sort_order]" />
                      </span>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['guest']['payment_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['payment_address']['fields'][$field['id']]['display']) && $quickcheckout['option']['guest']['payment_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="guest_payment_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][display]" id="guest_payment_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="guest_payment_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>

                      <?php if(isset($quickcheckout['option']['guest']['payment_address']['fields'][$field['id']]['require'])) { ?>
                      <input type="hidden" value="0" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['guest']['payment_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="guest_payment_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][payment_address][fields][<?php echo $field['id']; ?>][require]" id="guest_payment_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="guest_payment_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                   		<?php } ?>
                    <?php } ?>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['register']['payment_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['register']['payment_address']['fields'][$field['id']]['display']) &&  $quickcheckout['option']['register']['payment_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="register_payment_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][display]" id="register_payment_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="register_payment_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>
                         
                   <?php if(isset($quickcheckout['option']['register']['payment_address']['fields'][$field['id']]['require'])) { ?>
                   <input type="hidden" value="0" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['register']['payment_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="register_payment_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][payment_address][fields][<?php echo $field['id']; ?>][require]" id="register_payment_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="register_payment_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                     <?php } ?>
                  <?php } ?>
                  </td>
                  <td >
                  <?php if(isset($quickcheckout['option']['logged']['payment_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['payment_address']['fields'][$field['id']]['display']) && $quickcheckout['option']['logged']['payment_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="logged_payment_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][display]" id="logged_payment_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="logged_payment_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>

                      <?php if(isset($quickcheckout['option']['logged']['payment_address']['fields'][$field['id']]['require'])) { ?>
                      <input type="hidden" value="0" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['logged']['payment_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="logged_payment_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][payment_address][fields][<?php echo $field['id']; ?>][require]" id="logged_payment_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="logged_payment_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                  	<?php } ?>
                  <?php } ?>
                  </td>
                  </tr>          
                
                <?php } /*foreach fields*/?>
                </tbody>
              </table>
            </div>
          </div>
          <!---------------------------------- Shipping Address ---------------------------------->
          <div id="tab_shipping_address" class="tab-item">
            <div class="title"><i class="icon-shipping-address"></i><span><?php echo $text_shipping_address; ?></span></div>
            <div class="block">
              <table class="form">
                <thead>
                  <tr>
                    <th></th>
                    <th class="guest"><?php echo $text_guest_customer; ?></th>
                    <th class="register"><?php echo $text_registrating_customer; ?></th>
                    <th class="login"><?php echo $text_logged_in_customer; ?></th>
                  </tr>
                </thead>
                <tbody>
                <tr id="shipping_address_display_input" >
                    <td class="name"><span><?php echo $text_shipping_address_display_input; ?></span> <i class="icon-help" data-help="<?php echo $shipping_address_enable_tooltip; ?>"></i>
                    </td>
                    <td >

                    	<input type="hidden" value="0" name="quickcheckout[option][guest][shipping_address][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['shipping_address']['display']) && $quickcheckout['option']['guest']['shipping_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][display]" checked="checked" id="guest_shipping_address_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][display]" id="guest_shipping_address_display" />
                      <?php } ?>
                      	<label for="guest_shipping_address_display"><?php echo $settings_display; ?></label>
                        
                        <input type="hidden" value="0" name="quickcheckout[option][guest][shipping_address][require]" />
                      <?php if(isset($quickcheckout['option']['guest']['shipping_address']['require']) && $quickcheckout['option']['guest']['shipping_address']['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][require]" checked="checked" id="guest_shipping_address_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][require]" id="guest_shipping_address_require" />
                      <?php } ?>
                      	<label for="guest_shipping_address_require"><?php echo $settings_always_show; ?></label>
                  
                    </td>
                    <td >

                    	<input type="hidden" value="0" name="quickcheckout[option][register][shipping_address][display]" />
                      <?php if(isset($quickcheckout['option']['register']['shipping_address']['display']) && $quickcheckout['option']['register']['shipping_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][display]" checked="checked" id="register_shipping_address_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][display]" id="register_shipping_address_display" />
                      <?php } ?>
                      	<label for="register_shipping_address_display"><?php echo $settings_display; ?></label>
                        
                        <input type="hidden" value="0" name="quickcheckout[option][register][shipping_address][require]" />
                      <?php if(isset($quickcheckout['option']['register']['shipping_address']['require']) && $quickcheckout['option']['register']['shipping_address']['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][require]" checked="checked" id="register_shipping_address_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][require]" id="register_shipping_address_require" />
                      <?php } ?>
                      	<label for="register_shipping_address_require"><?php echo $settings_always_show; ?></label>
                     
                  </td>
                  <td >
                  
                    	<input type="hidden" value="0" name="quickcheckout[option][logged][shipping_address][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['shipping_address']['display']) && $quickcheckout['option']['logged']['shipping_address']['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][display]" checked="checked" id="logged_shipping_address_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][display]" id="logged_shipping_address_display" />
                      <?php } ?>
                      	<label for="logged_shipping_address_display"><?php echo $settings_display; ?></label>
                        
                        <input type="hidden" value="0" name="quickcheckout[option][logged][shipping_address][require]" />
                      <?php if(isset($quickcheckout['option']['logged']['shipping_address']['require']) && $quickcheckout['option']['logged']['shipping_address']['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][require]" checked="checked" id="logged_shipping_address_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][require]" id="logged_shipping_address_require" />
                      <?php } ?>
                      	<label for="logged_shipping_address_require"><?php echo $settings_always_show; ?></label>
                      
                  </td>
                  </tr>
                  </tbody>
                 <tbody class="sortable ui-sortable">    
                <?php foreach($quickcheckout['step']['shipping_address']['fields'] as $field){?>
                <tr id="shipping_address_<?php echo $field['id']; ?>_input" class="sort-item <?php echo ($field['type'] == 'system')? 'hide' : ''; ?>" sort-data="<?php echo (isset($quickcheckout['step']['shipping_address']['fields'][$field['id']]['sort_order']) ? $quickcheckout['step']['shipping_address']['fields'][$field['id']]['sort_order'] : ''); ?>">
                    <td class="name"><span><?php echo $field['title']; ?>
                      <input class="sort" type="text" value="<?php echo (isset($quickcheckout['step']['shipping_address']['fields'][$field['id']]['sort_order'])) ? $quickcheckout['step']['shipping_address']['fields'][$field['id']]['sort_order'] : ''; ?>" name="quickcheckout[step][shipping_address][fields][<?php echo $field['id']; ?>][sort_order]" />
                      </span>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['guest']['shipping_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['shipping_address']['fields'][$field['id']]['display']) && $quickcheckout['option']['guest']['shipping_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="guest_shipping_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][display]" id="guest_shipping_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="guest_shipping_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>
                        
                      <?php if(isset($quickcheckout['option']['guest']['shipping_address']['fields'][$field['id']]['require'])) { ?>
                      <input type="hidden" value="0" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['guest']['shipping_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="guest_shipping_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][shipping_address][fields][<?php echo $field['id']; ?>][require]" id="guest_shipping_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="guest_shipping_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                   		<?php } ?>
                    <?php } ?>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['register']['shipping_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if($quickcheckout['option']['register']['shipping_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="register_shipping_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][display]" id="register_shipping_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="register_shipping_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>

                    <?php if(isset($quickcheckout['option']['register']['shipping_address']['fields'][$field['id']]['require'])) { ?>
                    <input type="hidden" value="0" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['register']['shipping_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="register_shipping_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][shipping_address][fields][<?php echo $field['id']; ?>][require]" id="register_shipping_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="register_shipping_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                     <?php } ?>
                  <?php } ?>
                  </td>
                  <td >
                  <?php if(isset($quickcheckout['option']['logged']['shipping_address']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['shipping_address']['fields'][$field['id']]['display']) && $quickcheckout['option']['logged']['shipping_address']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="logged_shipping_address_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][display]" id="logged_shipping_address_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="logged_shipping_address_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>

                      <?php if(isset($quickcheckout['option']['logged']['shipping_address']['fields'][$field['id']]['require'])) { ?>
                     <input type="hidden" value="0" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['logged']['shipping_address']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="logged_shipping_address_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][shipping_address][fields][<?php echo $field['id']; ?>][require]" id="logged_shipping_address_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="logged_shipping_address_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                  	<?php } ?>
                  <?php } ?>
                  </td>
                  </tr>          
                
                <?php } /*foreach fields*/?>
                </tbody>
              </table>
            </div>
          </div>
          
          <!---------------------------------- Shipping Methods ---------------------------------->
          <div id="tab_shipping" class="tab-item">
            <div class="title"><i class="icon-shipping-method"></i><span><?php echo $text_shipping_method; ?></span></div>
            <div class="block">
              <table class="form">

                <tbody>
                  <tr>
                    <td class="name"><span><?php echo $text_shipping_method_display; ?></span><i class="icon-help" data-help="<?php echo $shipping_method_display_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][shipping_method][display]" />
                      <?php if(isset($quickcheckout['step']['shipping_method']['display']) && $quickcheckout['step']['shipping_method']['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display]" checked="checked"  id="shipping_method_display" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display]"  id="shipping_method_display" />
                      
                      <?php } ?><label for="shipping_method_display"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_shipping_method_display_options; ?></span><i class="icon-help" data-help="<?php echo $shipping_method_display_options_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][shipping_method][display_options]" />
                      <?php if(isset($quickcheckout['step']['shipping_method']['display']) && $quickcheckout['step']['shipping_method']['display_options'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display_options]" checked="checked"  id="shipping_method_display_options" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display_options]"  id="shipping_method_display_options" />
                      
                      <?php } ?><label for="shipping_method_display_options"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_shipping_method_display_title; ?></span><i class="icon-help" data-help="<?php echo $shipping_method_display_title_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][shipping_method][display_title]" />
                      <?php if(isset($quickcheckout['step']['shipping_method']['display']) && $quickcheckout['step']['shipping_method']['display_title'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display_title]" checked="checked"  id="shipping_method_display_title" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][shipping_method][display_title]"  id="shipping_method_display_title" />
                      
                      <?php } ?><label for="shipping_method_display_title"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                   <tr>
                  <td class="name"><span><?php echo $text_shipping_method_input_style; ?></span><i class="icon-help" data-help="<?php echo $shipping_method_input_style_tooltip; ?>"></i></td>
                  <td class="settings">
                    <?php if(isset($quickcheckout['step']['shipping_method']['input_style']) && $quickcheckout['step']['shipping_method']['input_style'] == 'radio'){ ?>
                    <input class="styled" type="radio" value="radio" name="quickcheckout[step][shipping_method][input_style]" checked="checked" id="shipping_method_input_style_radio" />
                    <label  for="shipping_method_input_style_radio"><?php echo $text_radio_style; ?></label>
                    <input class="styled" type="radio" value="select" name="quickcheckout[step][shipping_method][input_style]" id="shipping_method_input_style_select" />
                    <label  for="shipping_method_input_style_select"><?php echo $text_select_style ; ?></label>
                    <?php }else{ ?>
                    <input class="styled" type="radio" value="radio" name="quickcheckout[step][shipping_method][input_style]" id="shipping_method_input_style_radio" />
                    <label  for="shipping_method_input_style_radio"><?php echo $text_radio_style; ?></label>
                    <input class="styled" type="radio" value="select" name="quickcheckout[step][shipping_method][input_style]" checked="checked"  id="shipping_method_input_style_select" />
                    <label  for="shipping_method_input_style_select"><?php echo $text_select_style; ?></label>
                    <?php } ?>
                    </td>
                  <td></td>
                </tr>
                <tr>
                    <td class="name"><span><?php echo $text_shipping_method_default_option; ?></span><i class="icon-help" data-help="<?php echo $shipping_method_default_option_tooltip; ?>"></i></td>
                    <td>
                    <select name="quickcheckout[step][shipping_method][default_option]">
                    	<?php foreach ($shipping_methods as $shipping_method) {?>
                            	<?php if(isset($quickcheckout['step']['shipping_method']['default_option']) && $quickcheckout['step']['shipping_method']['default_option'] == $shipping_method['code']){ ?>
                                <option value="<?php echo $shipping_method['code']; ?>" selected="selected"><?php echo $shipping_method['title']; ?></option>
                                <?php }else{ ?>
                                <option value="<?php echo $shipping_method['code']; ?>"><?php echo $shipping_method['title']; ?></option>
                                <?php } ?>
                    	<?php } ?>
                     </select>
                    </td>
                    <td></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          
          <!---------------------------------- Payment Methods ---------------------------------->
          <div id="tab_payment" class="tab-item">
            <div class="title"><i class="icon-payment-method"></i><span><?php echo $text_payment_method; ?></span></div>
            <div class="block">
              <table class="form">

                <tbody>
                  <tr>
                    <td class="name"><span><?php echo $text_payment_method_display; ?></span><i class="icon-help" data-help="<?php echo $payment_method_display_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][payment_method][display]" />
                      <?php if(isset($quickcheckout['step']['payment_method']['display']) && $quickcheckout['step']['payment_method']['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display]" checked="checked"  id="payment_method_display" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display]"  id="payment_method_display" />
                      
                      <?php } ?><label for="payment_method_display"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_payment_method_display_options; ?></span><i class="icon-help" data-help="<?php echo $payment_method_display_options_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][payment_method][display_options]" />
                      <?php if(isset($quickcheckout['step']['payment_method']['display']) && $quickcheckout['step']['payment_method']['display_options'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display_options]" checked="checked"  id="payment_method_display_options" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display_options]"  id="payment_method_display_options" />
                      
                      <?php } ?><label for="payment_method_display_options"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                   <tr>
                  <td class="name"><span><?php echo $text_payment_method_input_style; ?></span><i class="icon-help" data-help="<?php echo $payment_method_input_style_tooltip; ?>"></i></td>
                  <td class="settings">
                    <?php if(isset($quickcheckout['step']['payment_method']['input_style']) && $quickcheckout['step']['payment_method']['input_style'] == 'radio'){ ?>
                    <input class="styled" type="radio" value="radio" name="quickcheckout[step][payment_method][input_style]" checked="checked" id="payment_method_input_style_radio" />
                    <label  for="payment_method_input_style_radio"><?php echo $text_radio_style; ?></label>
                    <input class="styled" type="radio" value="select" name="quickcheckout[step][payment_method][input_style]" id="payment_method_input_style_select" />
                    <label  for="payment_method_input_style_select"><?php echo $text_select_style ; ?></label>
                    <?php }else{ ?>
                    <input class="styled" type="radio" value="radio" name="quickcheckout[step][payment_method][input_style]" id="payment_method_input_style_radio" />
                    <label  for="payment_method_input_style_radio"><?php echo $text_radio_style; ?></label>
                    <input class="styled" type="radio" value="select" name="quickcheckout[step][payment_method][input_style]" checked="checked"  id="payment_method_input_style_select" />
                    <label  for="payment_method_input_style_select"><?php echo $text_select_style; ?></label>
                    <?php } ?>
                    </td>
                  <td></td>
                </tr>
                <tr>
                    <td class="name"><span><?php echo $text_payment_method_display_images; ?></span><i class="icon-help" data-help="<?php echo $payment_method_display_images_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[step][payment_method][display_images]" />
                      <?php if(isset($quickcheckout['step']['payment_method']['display']) && $quickcheckout['step']['payment_method']['display_images'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display_images]" checked="checked"  id="payment_method_display_images" />
                      
                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[step][payment_method][display_images]"  id="payment_method_display_images" />
                      
                      <?php } ?><label for="payment_method_display_images"><?php echo $settings_display; ?></label></td>
                    <td></td>
                  </tr>
                <tr>
                    <td class="name"><span><?php echo $text_payment_method_default_option; ?></span><i class="icon-help" data-help="<?php echo $payment_method_default_option_tooltip; ?>"></i></td>
                    <td>
                    <select name="quickcheckout[step][payment_method][default_option]">
                    	<?php foreach ($payment_methods as $payment_method) {?>
                            	<?php if(isset($quickcheckout['step']['payment_method']['default_option']) && ($quickcheckout['step']['payment_method']['default_option'] == $payment_method['code'])){ ?>
                                <option value="<?php echo $payment_method['code']; ?>" selected="selected"><?php echo $payment_method['title']; ?></option>
                                <?php }else{ ?>
                                <option value="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></option>
                                <?php } ?>
                    	<?php } ?>
                     </select>
                    </td>
                    <td></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          
          <!---------------------------------- Confirm ---------------------------------->
          <div id="tab_confirm" class="tab-item">
            <div class="title"><i class="icon-cart"></i><span><?php echo $text_cart; ?></span></div>
            <div class="block">
              <table class="form">
                <th></th>
                    <th class="guest"><?php echo $text_guest_customer; ?></th>
                    <th class="register"><?php echo $text_registrating_customer; ?></th>
                    <th class="login"><?php echo $text_logged_in_customer; ?></th>
                <tbody>
                <tr>
                    <td class="name"><span><?php echo $text_cart_display; ?></span><i class="icon-help"  data-help="<?php echo $cart_display_tooltip; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[option][guest][cart][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['cart']['display']) && $quickcheckout['option']['guest']['cart']['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][display]" checked="checked"  id="option_guest_cart_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][display]"  id="option_guest_cart_display" />
                     
                      <?php } ?> <label for="option_guest_cart_display"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][register][cart][display]" />
                      <?php if(isset($quickcheckout['option']['register']['cart']['display']) && $quickcheckout['option']['register']['cart']['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][display]" checked="checked"  id="option_register_cart_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][display]"  id="option_register_cart_display" />
                     
                      <?php } ?> <label for="option_register_cart_display"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][logged][cart][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['cart']['display']) && $quickcheckout['option']['logged']['cart']['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][display]" checked="checked"  id="option_logged_cart_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][display]"  id="option_logged_cart_display" />
                     
                      <?php } ?> <label for="option_logged_cart_display"><?php echo $settings_display; ?></label></td>
                  </tr>

                  
                  <?php $fields = array('image', 'name', 'model', 'quantity', 'price', 'total');?>
                  <?php foreach($fields as $field){ ?>
                  <tr>
                    <td class="name"><span><?php $field_name = 'text_cart_columns_'.$field; echo $$field_name;  ?></span></td>
                    <td><input type="hidden" value="0" name="quickcheckout[option][guest][cart][columns][<?php echo $field; ?>]" />
                      <?php if(isset($quickcheckout['option']['guest']['cart']['columns'][$field]) && $quickcheckout['option']['guest']['cart']['columns'][$field] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][columns][<?php echo $field; ?>]" checked="checked"  id="option_guest_cart_columns_<?php echo $field; ?>" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][columns][<?php echo $field; ?>]"  id="option_guest_cart_columns_<?php echo $field; ?>"/>
                     
                      <?php } ?> <label for="option_guest_cart_columns_<?php echo $field; ?>"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][register][cart][columns][<?php echo $field; ?>]" />
                      <?php if(isset($quickcheckout['option']['register']['cart']['columns'][$field]) && $quickcheckout['option']['register']['cart']['columns'][$field] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][columns][<?php echo $field; ?>]" checked="checked"  id="option_register_cart_columns_<?php echo $field; ?>" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][columns][<?php echo $field; ?>]"  id="option_register_cart_columns_<?php echo $field; ?>" />
                     
                      <?php } ?> <label for="option_register_cart_columns_<?php echo $field; ?>"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][logged][cart][columns][<?php echo $field; ?>]" />
                      <?php if(isset($quickcheckout['option']['logged']['cart']['columns'][$field]) && $quickcheckout['option']['logged']['cart']['columns'][$field] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][columns][<?php echo $field; ?>]" checked="checked"  id="option_logged_cart_columns_<?php echo $field; ?>" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][columns][<?php echo $field; ?>]"  id="option_logged_cart_columns_<?php echo $field; ?>" />
                     
                      <?php } ?> <label for="option_logged_cart_columns_<?php echo $field; ?>"><?php echo $settings_display; ?></label></td>
                  </tr>
                  <?php } ?>
                  
                   <?php $fields = array('coupon', 'voucher', 'reward');?>
                  <?php foreach($fields as $field){ ?>
                  <tr>
                    <td class="name"><span><?php $field_name = 'text_cart_option_'.$field; echo $$field_name;  ?></span><i class="icon-help" data-help="<?php $field_name = 'cart_option_'.$field.'_tooltip'; echo $$field_name; ?>"></i></td>
                    <td><input type="hidden" value="0" name="quickcheckout[option][guest][cart][option][<?php echo $field; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['cart']['option'][$field]['display']) && $quickcheckout['option']['guest']['cart']['option'][$field]['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][option][<?php echo $field; ?>][display]" checked="checked"  id="option_guest_cart_option_<?php echo $field; ?>_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][cart][option][<?php echo $field; ?>][display]"  id="option_guest_cart_option_<?php echo $field; ?>_display"/>
                     
                      <?php } ?> <label for="option_guest_cart_option_<?php echo $field; ?>_display"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][register][cart][option][<?php echo $field; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['register']['cart']['option'][$field]['display']) && $quickcheckout['option']['register']['cart']['option'][$field]['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][option][<?php echo $field; ?>][display]" checked="checked"  id="option_register_cart_option_<?php echo $field; ?>_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][cart][option][<?php echo $field; ?>][display]"  id="option_register_cart_option_<?php echo $field; ?>_display" />
                     
                      <?php } ?> <label for="option_register_cart_option_<?php echo $field; ?>_display"><?php echo $settings_display; ?></label></td>
                      <td><input type="hidden" value="0" name="quickcheckout[option][logged][cart][option][<?php echo $field; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['cart']['option'][$field]['display']) && $quickcheckout['option']['logged']['cart']['option'][$field]['display'] == 1){ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][option][<?php echo $field; ?>][display]" checked="checked"  id="option_logged_cart_option_<?php echo $field; ?>_display" />

                      <?php }else{ ?>
                      <input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][cart][option][<?php echo $field; ?>][display]"  id="option_logged_cart_option_<?php echo $field; ?>_display" />
                     
                      <?php } ?> <label for="option_logged_cart_option_<?php echo $field; ?>_display"><?php echo $settings_display; ?></label></td>                </tr>   
                                
                  <?php } ?>
                  
                  </tbody>
                 </table>
                 <div class="title"><i class="icon-confirm"></i><span><?php echo $text_confirm; ?></span></div>
                 <table class="form">
                <th></th>
                    <th class="guest"><?php echo $text_guest_customer; ?></th>
                    <th class="register"><?php echo $text_registrating_customer; ?></th>
                    <th class="login"><?php echo $text_logged_in_customer; ?></th>
                <tbody>
                <tbody class="sortable ui-sortable">
                  <?php foreach($quickcheckout['step']['confirm']['fields'] as $field){?>
                <tr id="confirm_<?php echo $field['id']; ?>_input" class="sort-item <?php echo ($field['type'] == 'system')? 'hide' : ''; ?>" sort-data="<?php echo (isset($quickcheckout['step']['confirm']['fields'][$field['id']]['sort_order']) ? $quickcheckout['step']['confirm']['fields'][$field['id']]['sort_order'] : ''); ?>">
                    <td class="name"><span><?php echo $field['title']; ?>
                      <input class="sort" type="text" value="<?php echo (isset($quickcheckout['step']['confirm']['fields'][$field['id']]['sort_order'])) ? $quickcheckout['step']['confirm']['fields'][$field['id']]['sort_order'] : ''; ?>" name="quickcheckout[step][confirm][fields][<?php echo $field['id']; ?>][sort_order]" />
                      </span>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['guest']['confirm']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['guest']['confirm']['fields'][$field['id']]['display']) && $quickcheckout['option']['guest']['confirm']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="guest_confirm_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][display]" id="guest_confirm_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="guest_confirm_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>
                        
                      
                      <?php if(isset($quickcheckout['option']['guest']['confirm']['fields'][$field['id']]['require'])) { ?>
                      <input type="hidden" value="0" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['guest']['confirm']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="guest_confirm_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][guest][confirm][fields][<?php echo $field['id']; ?>][require]" id="guest_confirm_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="guest_confirm_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                   		<?php } ?>
                    <?php } ?>
                    </td>
                    <td >
                    <?php if(isset($quickcheckout['option']['register']['confirm']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['register']['confirm']['fields'][$field['id']]['display']) &&  $quickcheckout['option']['register']['confirm']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="register_confirm_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][display]" id="register_confirm_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="register_confirm_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>
                        
                      
                    <?php if(isset($quickcheckout['option']['register']['confirm']['fields'][$field['id']]['require'])) { ?>
                    <input type="hidden" value="0" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['register']['confirm']['fields'][$field['id']]['require'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="register_confirm_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][register][confirm][fields][<?php echo $field['id']; ?>][require]" id="register_confirm_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="register_confirm_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                     <?php } ?>
                  <?php } ?>
                  </td>
                  <td >
                  <?php if(isset($quickcheckout['option']['logged']['confirm']['fields'][$field['id']]['display'])) { ?>
                    	<input type="hidden" value="0" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][display]" />
                      <?php if(isset($quickcheckout['option']['logged']['confirm']['fields'][$field['id']]['display']) && $quickcheckout['option']['logged']['confirm']['fields'][$field['id']]['display'] == 1){ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][display]" checked="checked" id="logged_confirm_fields_<?php echo $field['id']; ?>_display"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="1" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][display]" id="logged_confirm_fields_<?php echo $field['id']; ?>_display" />
                      <?php } ?>
                      	<label for="logged_confirm_fields_<?php echo $field['id']; ?>_display"><?php echo $settings_display; ?></label>
                        
                      
                      <?php if(isset($quickcheckout['option']['logged']['confirm']['fields'][$field['id']]['require'])) { ?>
                      <input type="hidden" value="0" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][require]" />
                       <?php if($quickcheckout['option']['logged']['confirm']['fields'][$field['id']]['require'] == 4){ ?>
                      	<input class="styled" type="checkbox" value="4" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][require]" checked="checked" id="logged_confirm_fields_<?php echo $field['id']; ?>_require"/>
                      <?php }else{ ?>
                      	<input class="styled" type="checkbox" value="4" name="quickcheckout[option][logged][confirm][fields][<?php echo $field['id']; ?>][require]" id="logged_confirm_fields_<?php echo $field['id']; ?>_require" />
                      <?php } ?>
                      	<label for="logged_confirm_fields_<?php echo $field['id']; ?>_require"><?php echo $settings_require; ?></label>
                  	<?php } ?>
                  <?php } ?>
                  </td>
                  </tr>          
                
                <?php } /*foreach fields*/?>
                 
                </tbody>
              </table>
            </div>
          </div>
          <div id="tab_design_checkout" class="tab-item">
            <div class="title"><i class="icon-design"></i><span><?php echo $text_design; ?></span></div>
            <div class="block">
              <table class="form">

                <tbody>
                  <tr>
                    <td class="name"><span><?php echo $text_general_theme; ?></span><i class="icon-help"  data-help="<?php echo $general_theme_tooltip; ?>"></i></td>
                    <td class="settings" colspan="2">
                    <select name="quickcheckout[general][theme]">
                    	<?php foreach ($themes as $theme) {?>
                            	<?php if($quickcheckout['general']['theme'] == $theme){ ?>
                                <option value="<?php echo $theme; ?>" selected="selected"><?php echo $theme; ?></option>
                                <?php }else{ ?>
                                <option value="<?php echo $theme; ?>"><?php echo $theme; ?></option>
                                <?php } ?>
                    	<?php } ?>
                     </select>
                     </td>
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_general_block_style; ?></span><i class="icon-help"  data-help="<?php echo $general_block_style_tooltip; ?>"></i></td>
                    <td class="settings" colspan="2"><?php if(isset($quickcheckout['general']['block_style']) && $quickcheckout['general']['block_style'] == 'row'){ ?>
                      <input class="styled" type="radio" value="row" name="quickcheckout[general][block_style]" checked="checked" id="block_style_row" />
                      <label for="block_style_row"><?php echo $text_style_row; ?></label>
                      <input class="styled" type="radio" value="block" name="quickcheckout[general][block_style]" id="block_style_block" />
                      <label for="block_style_block"><?php echo $text_style_block; ?></label>
                      <?php }else{ ?>
                      <input class="styled" type="radio" value="row" name="quickcheckout[general][block_style]" id="block_style_row" />
                      <label for="block_style_row"><?php echo $text_style_row; ?></label>
                      <input class="styled" type="radio" value="block" name="quickcheckout[general][block_style]" checked="checked" id="block_style_block"/>
                      <label for="block_style_block"><?php echo $text_style_block; ?></label>
                      <?php } ?></td>
                    
                  </tr>
                  <tr>
                  <td class="name"><span><?php echo $text_step_login_option; ?></span><i class="icon-help" data-help="<?php echo $step_login_option_tooltip; ?>"></i></td>
                  <td class="settings "><input type="hidden" value="0" name="quickcheckout[step][login][option][login][display]" />
                    <?php if(isset($quickcheckout['step']['login']['option']['login']['display']) && $quickcheckout['step']['login']['option']['login']['display'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][login][display]" checked="checked" id="step_login_option_login_display"/>
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][login][display]" id="step_login_option_login_display" />
                    <?php } ?>
                    <label for="step_login_option_login_display"><?php echo $step_login_option_login_display; ?></label>
                    
                    <input type="hidden" value="0" name="quickcheckout[step][login][option][register][display]" />
                    <?php if(isset($quickcheckout['step']['login']['option']['register']['display']) && $quickcheckout['step']['login']['option']['register']['display'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][register][display]" checked="checked" id="step_login_option_register_display"/>
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][register][display]" id="step_login_option_register_display" />
                    <?php } ?>
                    <label for="step_login_option_register_display"><?php echo $step_login_option_register_display; ?></label>
                    
                     <input type="hidden" value="0" name="quickcheckout[step][login][option][guest][display]" />
                    <?php if(isset($quickcheckout['step']['login']['option']['guest']['display']) && $quickcheckout['step']['login']['option']['guest']['display'] == 1){ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][guest][display]" checked="checked" id="step_login_option_guest_display"/>
                    <?php }else{ ?>
                    <input class="styled" type="checkbox" value="1" name="quickcheckout[step][login][option][guest][display]" id="step_login_option_guest_display" />
                    <?php } ?>
                    <label for="step_login_option_guest_display"><?php echo $step_login_option_guest_display; ?></label>
                    </td>
                </tr>
                   <tr>
                    <td class="name"><span><?php echo $text_general_login_style; ?></span><i class="icon-help"  data-help="<?php echo $general_login_style_tooltip; ?>"></i></td>
                    <td class="settings" colspan="2"><?php if(isset($quickcheckout['general']['login_style']) && $quickcheckout['general']['login_style'] == 'block'){ ?>
                      <input class="styled" type="radio" value="block" name="quickcheckout[general][login_style]" checked="checked" id="login_style_block" />
                      <label for="login_style_block"><?php echo $text_style_block; ?></label>
                      <input class="styled" type="radio" value="popup" name="quickcheckout[general][login_style]" id="login_style_popup" />
                      <label for="login_style_popup"><?php echo $text_style_popup; ?></label>
                      <?php }else{ ?>
                      <input class="styled" type="radio" value="block" name="quickcheckout[general][login_style]" id="login_style_block" />
                      <label for="login_style_block"><?php echo $text_style_block; ?></label>
                      <input class="styled" type="radio" value="popup" name="quickcheckout[general][login_style]" checked="checked" id="login_style_popup"/>
                      <label for="login_style_popup"><?php echo $text_style_popup; ?></label>
                      <?php } ?></td>
                    
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_general_column; ?></span><i class="icon-help" data-help="<?php echo $general_column_tooltip; ?>"></i></td>
                    <td  colspan="2" style="position:static"><div class="columns">
                        <input type="text"  class="column-data-1 col" name="quickcheckout[general][column_width][1]" value="<?php echo $quickcheckout['general']['column_width'][1]; ?>" /><input type="text"  class="column-data-2 col" name="quickcheckout[general][column_width][2]" value="<?php echo $quickcheckout['general']['column_width'][2]; ?>" /><input type="text"  class="column-data-3 col" name="quickcheckout[general][column_width][3]" value="<?php echo $quickcheckout['general']['column_width'][3]; ?>" />
                      </div>
                      <div id="slider"></div>
                      <ul class="column column-1" col-data="1">
                        <li class="portlet" col-data="<?php echo $quickcheckout['step']['payment_address']['column']; ?>" row-data="<?php echo $quickcheckout['step']['payment_address']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-payment-address"></i><?php echo $text_payment_address; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_payment_address_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][payment_address][column]" value="<?php echo $quickcheckout['step']['payment_address']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][payment_address][row]" value="<?php echo $quickcheckout['step']['payment_address']['row']; ?>" />
                          </div>
                        </li>
                        <li class="portlet" col-data="<?php echo $quickcheckout['step']['shipping_address']['column']; ?>" row-data="<?php echo $quickcheckout['step']['shipping_address']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-shipping-address"></i><?php echo $text_shipping_address; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_shipping_address_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][shipping_address][column]" value="<?php echo $quickcheckout['step']['shipping_address']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][shipping_address][row]" value="<?php echo $quickcheckout['step']['shipping_address']['row']; ?>" />
                          </div>
                        </li>
                       <li class="portlet" col-data="<?php echo $quickcheckout['step']['shipping_method']['column']; ?>" row-data="<?php echo $quickcheckout['step']['shipping_method']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-shipping-method"></i><?php echo $text_shipping_method; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_shipping_method_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][shipping_method][column]" value="<?php echo $quickcheckout['step']['shipping_method']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][shipping_method][row]" value="<?php echo $quickcheckout['step']['shipping_method']['row']; ?>" />
                          </div>
                        </li>
                        <li class="portlet" col-data="<?php echo $quickcheckout['step']['payment_method']['column']; ?>" row-data="<?php echo $quickcheckout['step']['payment_method']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-payment-method"></i><?php echo $text_payment_method; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_payment_method_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][payment_method][column]" value="<?php echo $quickcheckout['step']['payment_method']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][payment_method][row]" value="<?php echo $quickcheckout['step']['payment_method']['row']; ?>" />
                          </div>
                        </li>
                        <li class="portlet" col-data="<?php echo $quickcheckout['step']['cart']['column']; ?>" row-data="<?php echo $quickcheckout['step']['cart']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-confirm"></i><?php echo $text_cart; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_cart_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][cart][column]" value="<?php echo $quickcheckout['step']['cart']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][cart][row]" value="<?php echo $quickcheckout['step']['cart']['row']; ?>" />
                          </div>
                        </li>
                        <li class="portlet" col-data="<?php echo $quickcheckout['step']['confirm']['column']; ?>" row-data="<?php echo $quickcheckout['step']['confirm']['row']; ?>">
                          <div class="portlet-header"><i class="icon-small-confirm"></i><?php echo $text_confirm; ?></div>
                          <div class="portlet-content">
                          	<div class="text"><?php echo $text_confirm_description; ?></div>
                            <div class="text"><i class="icon-drag"></i><i class="icon-drag"></i></div>
                            <input type="text"  class="sort col-data" name="quickcheckout[step][confirm][column]" value="<?php echo $quickcheckout['step']['confirm']['column']; ?>" />
                            <input type="text"  class="sort row-data" name="quickcheckout[step][confirm][row]" value="<?php echo $quickcheckout['step']['confirm']['row']; ?>" />
                          </div>
                        </li>
                      </ul>
                      <ul class="column column-2" col-data="2">
                      </ul>
                      <ul class="column column-3" col-data="3">
                      </ul>
                      <br style="clear:both">
                     </td>
                  </tr>
                  <tr>
                    <td class="name"><span><?php echo $text_general_custom_style; ?></span><i class="icon-help" data-help="<?php echo $general_custom_style_tooltip; ?>"></i></td>
                    <td colspan="2"><?php if(isset($quickcheckout['general']['checkout_style'])){ ?>
                      <textarea name="quickcheckout[general][checkout_style]" id="general_checkout_style" ><?php echo $quickcheckout['general']['checkout_style']; ?></textarea>
                      <?php }else{ ?>
                      <textarea name="quickcheckout[general][checkout_style]" id="general_checkout_style"></textarea>
                      <?php } ?></td>
                  </tr>
                  <td class="name"><span><?php echo $text_general_trigger; ?></span><i class="icon-help" data-help="<?php echo $general_trigger_tooltip; ?>"></i></td>
                    <td colspan="2"><?php if(isset($quickcheckout['general']['trigger'])){ ?>
                      <input name="quickcheckout[general][trigger]" class="full-width" value="<?php echo $quickcheckout['general']['trigger']; ?>" />
                      <?php }else{ ?>
                      <input name="quickcheckout[general][trigger]" class="full-width" value="" />
                      <?php } ?></td>
                  </tr>                 
                </tbody>
              </table>
              <!--<table class="form" style="background:#FFC">
                            <tbody>
                                  <tr>
                                  <td>
                                  Support email:<br>
                                  <small>(At Dreamvention we believe in trust. We know that trust does not come easy and it takes years of quality service to build up trustworthy relationship. That is why we give a great deal of attention to customer service. When you contact us, you can be sure to talk to a professional expert that will guide you through any issue and not overwhelm you with technical data.)</small>
                                  </td>
                                  <td>
                                  <a href="mailto:info@dreamvention.com?subject=QuickCheckout_Support_<?php echo $_SERVER["SERVER_NAME"];?>">info@dreamvention.com</a>
                                  </td>
                                  <td>
                                  Visit our Opencart Extensions Page for more great paid and free products.<br>
                                  <a href="http://www.opencart.com/index.php?route=extension/extension&filter_username=Dreamvention" target="_blank">More Extensions from Dreamvention</a><br><br>
    
                                  or visit our website at <a href="http://www.dreamvention.com/"  target="_blank">www.dreamvention.com</a>
                                  </td>
                                  </tr>   
                                  </tbody>          
                            </table>--> 
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- layout-->
    </form>
  </div>
  <!-- content tabs--> 
</div>
<!-- box -->
<?php $main_width = 100/576;
$column_1 =  $quickcheckout['general']['column_width'][1]/$main_width; 
$column_2 = $quickcheckout['general']['column_width'][2]/$main_width;
$column_3 = $quickcheckout['general']['column_width'][3]/$main_width; ?>
<style>
.full-width{
	width:100%}
  .column-1, .column-data-1{width:<?php echo $column_1; ?>px;}
 .column-2, .column-data-2{
	 width:<?php echo $column_2; ?>px;} 
 .column-3, .column-data-3{width:<?php echo $column_3; ?>px;}

</style>
<script type="text/javascript">
var editor = CodeMirror.fromTextArea(document.getElementById("general_checkout_style"), {});


	function resizeMenu(){
	/*	$("#tabs_menu").css({minHeight:($('.content').height())});
		console.log($('.content').height());*/
	}
	$(document).ready(function(){
		resizeMenu();
		
		
	})
	$('#tabs_menu a').tabs();
	$('#tabs_menu a').click(function(){
		resizeMenu();
	})
	$('.tile a').click(function(){
		$('#tabs_menu a[href='+$(this).attr('href')+']').trigger('click')
		resizeMenu();
		return false	
	})

	$('.active a').click(function(){
		$('.active .activeClass').removeClass('activeClass');
		$(this).addClass('activeClass');
	});

      $(function(){
        $("input:checkbox.styled, input:radio.styled").uniform();
      });

$(function() {
	$('#checkout_select_all').click(function(){
		$('input:checkbox').attr('checked', 'checked')
		$.uniform.update();
	})
	
	$('#checkout_unselect_all').click(function(){
		$('input:checkbox').removeAttr('checked')
		$.uniform.update();
	})
	
	$('.sortable > tr').tsort({attr:'sort-data'});
	
	$( ".sortable" ).sortable({
		revert: true,
		cursor: "move",
		items: "> .sort-item",
		containment: "document",
		 distance: 5 ,
		opacity: 0.8,
		stop: function( event, ui ) {
			$(this).find("tr").each(function(i, el){
				$(this).find(".sort").val($(el).index())
				//alert($('[name="'+$(this).find(".sort").attr('name')+'"]').val())
			});
		}
	});
	var main_width = 100 / 576;
	
        $( "#slider" ).slider({
			range: true,	  
            min: 0,
            max: 576,
			step: 5.76,
            values: [ <?php echo $column_1; ?>,  <?php echo ($column_1 + $column_2); ?>],
			slide: function( event, ui ) {
				
				$('.column-data-1').val(Math.round(main_width*(ui.values[ 0 ])))
							  .attr('width-data', ui.values[ 0 ])
							  .attr('left-data', 0)
							  .css({'width' : parseInt( ui.values[ 0 ] ) + 'px'})
				$('.column-data-2').val(Math.round(main_width*(ui.values[ 1 ] - ui.values[ 0 ])))
							  .attr('width-data',ui.values[ 1 ] - ui.values[ 0 ])
							  .attr('left-data', parseInt(ui.values[ 0 ]+10))
							  .css({'width' : parseInt( ui.values[ 1 ] - ui.values[ 0 ]) + 'px'})
				$('.column-data-3').val(Math.round(main_width*(576 - ui.values[ 1 ])))
							  .attr('width-data',576 - ui.values[ 1 ])
							  .attr('left-data', parseInt(ui.values[ 1 ]))
							  .css({'width' : parseInt( 576 - ui.values[ 1 ]) + 'px'})
				$('.column-1').css({'width' :  parseInt( ui.values[ 0 ]) +'px' })
				$('.column-2').css({'width' : parseInt( ui.values[ 1 ] - ui.values[ 0 ])+'px'})
				$('.column-3').css({'width' :  parseInt(576 - ui.values[ 1 ]) +'px'})
				
              
			}
		});
	$( ".column" ).sortable({
            connectWith: ".column",
			scroll: false,
			stop: function( event, ui ) {
			$('.column').find("li").each(function(i, el){
				
				$(this).find(".row-data").val($(el).index())
				$(this).find(".col-data").val($(this).parent().attr('col-data'))

			});
			}
        });
 
    $( ".column" ).disableSelection();
	$('.column > li').tsort({attr:'row-data'});
	$('.column > li').each(function(){
				$(this).appendTo('.column-' + $(this).attr('col-data'));					
									})
	$(".sort-item  td:last-child").append('<i class="icon-drag"></i>')
	
	
	$('#general_checkout_style').autosize();  
	$('#checkout_settings').val(decodeURIComponent(($('#form').serialize())))
	
	$('#checkout_settings_checkbox').live('click', function(){
		if($(this).attr('checked')) {
			$('#checkout_settings').fadeIn()
			$('#checkout_settings').select()
			}else{
			$('#checkout_settings').fadeOut()
			
			}										  
	  })
	 $('#checkout_settings').click(function(){
		 $(this).select()
		 })
});

/*function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=f2b06e3035867ee1624458759982f6ac&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Image Manager',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=f2b06e3035867ee1624458759982f6ac&image=' + encodeURIComponent($('#' + field).val()),
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
};*/


var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="quickcheckout_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="quickcheckout_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="quickcheckout_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="left"><input type="text" name="quickcheckout_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}

function saveAndStay(){
	$('#general_checkout_style').val(editor.getValue())
    $.ajax( {
      type: "POST",
      url: $('#form').attr( 'action' ) + '&save',
      data: $('#form').serialize(),
	  beforeSend: function() {
		$('#form').fadeTo('slow', 0.5);
		},
	  complete: function() {
		$('#form').fadeTo('slow', 1);		
		},
      success: function( response ) {
        console.log( response );
      }
    } );	
}
$('#version_check').click(function(){
	$.ajax( {
      type: "POST",
      url: 'index.php?route=module/quickcheckout/version_check&token=<?php echo $token; ?>',
	  dataType: 'json',
	  beforeSend: function() {
		$('#form').fadeTo('slow', 0.5);
		},
	  complete: function() {
		$('#form').fadeTo('slow', 1);		
		},
      success: function( json ) {
        console.log( json );
		if(json['error']){
			$('#version_result').html('<div class="warning">' + json['error'] + '</div>')
		}
		if(json['attention']){
			$html = '';
			if(json['update']){
				 $.each(json['update'] , function(k, v) {
						$html += '<div>Version: ' +k+ '</div><div>'+ v +'</div>';
				 });
			}
			 $('#version_result').html('<div class="attention">' + json['attention'] + $html + '</div>')
		}
		if(json['success']){
			$('#version_result').html('<div class="success">' + json['success'] + '</div>')
		}	
      }
	})
})

$(document).ajaxStart(function(){
    $(".wait").show();
})
$(document).ajaxStop(function(){
    $(".wait").hide();
});
//--></script> 
<div class="wait"><span></span></div>
<?php echo $footer; ?>