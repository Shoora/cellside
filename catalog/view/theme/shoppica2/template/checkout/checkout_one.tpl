<?php echo $header; ?>
<!--
//-----------------------------------------
// Author: 	Qphoria@gmail.com
// Web: 	http://www.OpenCartGuru.com/
// Title: 	Uber Checkout 1.5.x
//-----------------------------------------
-->

<style type="text/css">
.login-form {
	width:100%;
	border:0px;
}
.login-form input[type=text], .login-form input[type=password], .login-form select {
	width:30%;
}
.register-form {
	width:100%;
	border:0px;
}
.register-form input[type=text], .register-form input[type=password], .register-form select {
	width:90%;
}
</style>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="s_wrap">
        <div id="breadcrumbs" class="s_col_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->


  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->

  <div id="content" class="s_wrap">

    <?php if ($tbData->common['column_position'] == "left" && $column_right): ?>
    <div id="left_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  <div>

    <?php echo $content_top; ?>
    <?php if ($error_warning) { ?>
    <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
    <?php } ?>

    <!-- LOGIN FORM -->
    <div class="left s_1_2">
	<form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data" id="login">
	<h2 class="s_title_1"><?php echo $text_returning_customer; ?></h2>

		  <div class="s_row_2 clearfix">
            <label><?php echo $entry_email; ?></label>
            <input type="text" name="email_login" value="" size="30" class="required" title="" />
          </div>

          <div class="s_row_2 clearfix">
            <label><?php echo $entry_password; ?></label>
            <input type="password" name="password_login" value="" size="30" class="required" title="" />
          </div>
		  
		  <div class="s_row_2 clearfix">
            <a href="<?php echo str_replace('&', '&amp;', $forgotten); ?>"><?php echo $text_forgotten_password; ?></a>
          </div>

		  <div class="s_submit clearfix">
          <div class="right" style="text-align:right;"><a onclick="$('#login').submit();" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_login; ?></span></a></div>
        </div>
		<?php if ($redirect) { ?>
      <input type="hidden" name="redirect" value="<?php echo str_replace('&', '&amp;', $redirect); ?>" />
      <?php } ?>
    </form>
 	</div>


    <div class="clear s_sep border_eee"></div>
    <!-- LOGIN FORM -->

    <div style="text-align: center; padding: 15px 0 25px 0;"><b style="font-size:15px;"><?php echo $text_or; ?></b></div>


      <!-- BILLING FORM -->
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="register">
        <div class="left s_1_2">

	      <h2><?php echo $text_your_details; ?></h2>

	      <div class="s_row_2<?php if ($error_firstname): ?> s_error_row<?php endif; ?> clearfix">
	        <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
	        <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
	        <?php if ($error_firstname): ?>
            <p class="s_error_msg"><?php echo $error_firstname; ?></p>
            <?php endif; ?>
	      </div>

	      <div class="s_row_2<?php if ($error_lastname): ?> s_error_row<?php endif; ?> clearfix">
	        <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
	        <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
	        <?php if ($error_lastname): ?>
            <p class="s_error_msg"><?php echo $error_lastname; ?></p>
            <?php endif; ?>
	      </div>
          <?php if (file_exists(DIR_SYSTEM . '../catalog/model/account/customer_group.php')) { ?>
		  <div class="s_row_2<?php if ($error_email): ?> s_error_row<?php endif; ?> clearfix" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
	        <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
			<select name="customer_group_id" class="required">
	          <?php foreach ($customer_groups as $customer_group) { ?>
	          <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
	          <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
	          <?php } else { ?>
	          <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
	          <?php } ?>
	          <?php } ?>
	        </select>
	      </div>
          <?php } ?>

		  <div class="s_row_2 clearfix">
	        <label><?php echo $entry_company; ?></label>
	        <input type="text" name="company" value="<?php echo $company; ?>" size="30" />
	      </div>

		  <?php if (!is_null($this->config->get('config_customer_group_display'))) { //v153+ ?>

		  <div id="company-id-display" class="s_row_2<?php if ($error_company_id): ?> s_error_row<?php endif; ?> s_sep clearfix">
	        <label><strong id="company-id-required" class="s_red">*</strong> <?php echo $entry_company_id; ?></label>
	        <input type="text" name="company_id" value="<?php echo $company_id; ?>" size="30" />
	        <?php if ($error_company_id): ?>
            <p class="s_error_msg"><?php echo $error_company_id; ?></p>
            <?php endif; ?>
	      </div>
	      <div id="tax-id-display" class="s_row_2<?php if ($error_tax_id): ?> s_error_row<?php endif; ?> s_sep clearfix">
	        <label><strong id="tax-id-required" class="s_red">*</strong> <?php echo $entry_tax_id; ?></label>
	        <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" size="30" />
	        <?php if ($error_tax_id): ?>
            <p class="s_error_msg"><?php echo $error_tax_id; ?></p>
            <?php endif; ?>
	      </div>
		  <?php } ?>

         <div class="s_row_2<?php if ($error_email): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_email; ?></label>
            <input type="text" name="email" value="<?php echo $email; ?>" size="30" class="required" title="<?php echo $this->language->get('error_email'); ?>" />
            <?php if ($error_email): ?>
            <p class="s_error_msg"><?php echo $error_email; ?></p>
            <?php endif; ?>
          </div>

          <div class="s_row_2<?php if ($error_telephone): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_telephone; ?></label>
            <input type="text" name="telephone" value="<?php echo $telephone; ?>" size="30" class="required" title="<?php echo $this->language->get('error_telephone'); ?>" />
            <?php if ($error_telephone): ?>
            <p class="s_error_msg"><?php echo $error_telephone; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_fax; ?></label>
            <input type="text" name="fax" value="<?php echo $fax; ?>" size="30" />
          </div>

          <div class="s_row_2<?php if ($error_address_1): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_address_1; ?></label>
            <input type="text" name="address_1" value="<?php echo $address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
            <?php if ($error_address_1): ?>
            <p class="s_error_msg"><?php echo $error_address_1; ?></p>
            <?php endif; ?>
          </div>

           <div class="s_row_2 clearfix">
            <label><?php echo $entry_address_2; ?></label>
            <input type="text" name="address_2" value="<?php echo $address_2; ?>" size="30" />
          </div>
          <div class="s_row_2<?php if ($error_city): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_city; ?></label>
            <input type="text" name="city" value="<?php echo $city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
            <?php if ($error_city): ?>
            <p class="s_error_msg"><?php echo $error_city; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_postcode): ?> s_error_row<?php endif; ?> clearfix">
            <label id="postcode"><strong class="s_red">*</strong> <?php echo $entry_postcode; ?></label>
            <input type="text" name="postcode" value="<?php echo $postcode; ?>" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
            <?php if ($error_postcode): ?>
            <p class="s_error_msg"><?php echo $error_postcode; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_country): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_country; ?></label>
            <select id="country_id" name="country_id" class="large-field required" onchange="$('select[name=\'zone_id\']').load('index.php?route=checkout/checkout_one/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country): ?>
              <?php if ($country['country_id'] == $country_id): ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php else: ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php endif; ?>
              <?php endforeach; ?>
            </select>
            <?php if ($error_country): ?>
            <p class="s_error_msg"><?php echo $error_country; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_zone): ?> s_error_row<?php endif; ?> s_sep clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_zone; ?></label>
            <select id="zone_id" class="required" name="zone_id"></select>
            <?php if ($error_zone): ?>
            <p class="s_error_msg"><?php echo $error_zone; ?></p>
            <?php endif; ?>
          </div>
        </div>
		<!-- BILLING FORM -->


	  <div class="left s_1_2" <?php if (($this->cart->hasProducts() && !$this->cart->hasShipping()) || $this->config->get('uber_checkout_no_ship_address')) { ?>style="display:none;"<?php } ?>>
	  <h2><?php echo $text_shipping_address; ?></h2>
	  <table>
        <tr>
          <td width="100%">
			<?php if ($shipping_indicator) { ?>
      		<input style="vertical-align: middle;" type="checkbox" value="1" checked="checked" onchange="(this.checked) ? $('#shippingAddress').slideDown('fast') : $('#shippingAddress').slideUp('fast');" name="shipping_indicator" id="shipping_indicator" style="margin: 15px 5px 20px 5px;" /><label for="shipping_indicator"><span style="vertical-align: middle;"><?php echo $text_indicator; ?></span></label>
      		<?php } else { ?>
        	<input style="vertical-align: middle;" type="checkbox" value="1" onclick="(this.checked) ? $('#shippingAddress').slideDown('fast') : $('#shippingAddress').slideUp('fast');" name="shipping_indicator" id="shipping_indicator" style="margin: 15px 5px 20px 5px;" /><label for="shipping_indicator"><?php echo $text_indicator; ?></label>
      		<?php } ?>
          </td>
        </tr>
      </table>
		<!-- SHIPPING FORM -->

		<div id="shippingAddress" style="<?php if (!$shipping_indicator) { ?>display:none<?php } ?>">





	      <div class="s_row_2<?php if ($error_shipping_firstname): ?> s_error_row<?php endif; ?> clearfix">
	        <label><strong class="s_red">*</strong> <?php echo $entry_firstname; ?></label>
	        <input type="text" name="shipping_firstname" value="<?php echo $shipping_firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
	        <?php if ($error_shipping_firstname): ?>
            <p class="s_error_msg"><?php echo $error_shipping_firstname; ?></p>
            <?php endif; ?>
	      </div>

	      <div class="s_row_2<?php if ($error_shipping_lastname): ?> s_error_row<?php endif; ?> clearfix">
	        <label><strong class="s_red">*</strong> <?php echo $entry_lastname; ?></label>
	        <input type="text" name="shipping_lastname" value="<?php echo $shipping_lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
	        <?php if ($error_shipping_lastname): ?>
            <p class="s_error_msg"><?php echo $error_shipping_lastname; ?></p>
            <?php endif; ?>
	      </div>

	      <div class="s_row_2 clearfix">
	        <label><?php echo $entry_company; ?></label>
	        <input type="text" name="shipping_company" value="<?php echo $shipping_company; ?>" size="30" />
	      </div>


          <div class="s_row_2<?php if ($error_shipping_address_1): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_address_1; ?></label>
            <input type="text" name="shipping_address_1" value="<?php echo $shipping_address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
            <?php if ($error_shipping_address_1): ?>
            <p class="s_error_msg"><?php echo $error_shipping_address_1; ?></p>
            <?php endif; ?>
          </div>

           <div class="s_row_2 clearfix">
            <label><?php echo $entry_address_2; ?></label>
            <input type="text" name="shipping_address_2" value="<?php echo $shipping_address_2; ?>" size="30" />
          </div>
          <div class="s_row_2<?php if ($error_shipping_city): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_city; ?></label>
            <input type="text" name="shipping_city" value="<?php echo $shipping_city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
            <?php if ($error_shipping_city): ?>
            <p class="s_error_msg"><?php echo $error_shipping_city; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_postcode): ?> s_error_row<?php endif; ?> clearfix">
            <label id="postcode"><strong class="s_red">*</strong> <?php echo $entry_postcode; ?></label>
            <input type="text" name="shipping_postcode" value="<?php echo $postcode; ?>" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
            <?php if ($error_postcode): ?>
            <p class="s_error_msg"><?php echo $error_postcode; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_shipping_country): ?> s_error_row<?php endif; ?> clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_country; ?></label>
            <select id="shipping_country_id" name="shipping_country_id" class="large-field required" onchange="$('select[name=\'shipping_zone_id\']').load('index.php?route=checkout/checkout_one/zone&country_id=' + this.value + '&zone_id=<?php echo $shipping_zone_id; ?>');">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country): ?>
              <?php if ($country['country_id'] == $shipping_country_id): ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php else: ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php endif; ?>
              <?php endforeach; ?>
            </select>
            <?php if ($error_shipping_country): ?>
            <p class="s_error_msg"><?php echo $error_shipping_country; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_zone): ?> s_error_row<?php endif; ?> s_sep clearfix">
            <label><strong class="s_red">*</strong> <?php echo $entry_zone; ?></label>
            <select id="shipping_zone_id" class="required" name="shipping_zone_id"></select>
            <?php if ($error_shipping_zone): ?>
            <p class="s_error_msg"><?php echo $error_shipping_zone; ?></p>
            <?php endif; ?>
          </div>

		</div>
		<!-- SHIPPING FORM -->
		</div>
		
		<div class="left s_1_2">

	  	<!-- PASSWORD FORM -->
        <h2 class="s_title_1"><?php echo $text_create_account; ?> <?php if ($guest_checkout) { echo $text_optional; } ?></h2>
        <div class="content">
          <p><?php echo $text_password_info; ?></p>


          <div class="s_row_2<?php if ($error_password): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php if (!$guest_checkout) { ?><strong class="s_red">*</strong> <?php } ?><?php echo $entry_password; ?></label>
            <input type="password" name="password" value="<?php echo $password; ?>" size="30" class="required" title="<?php echo $this->language->get('error_password'); ?>" />
            <?php if ($error_password): ?>
            <p class="s_error_msg"><?php echo $error_password; ?></p>
            <?php endif; ?>
          </div>

          <div class="s_row_2<?php if ($error_confirm): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php if (!$guest_checkout) { ?><strong class="s_red">*</strong> <?php } ?><?php echo $entry_confirm; ?></label>
            <input type="password" name="confirm" value="<?php echo $confirm; ?>" size="30" class="required" title="<?php echo $this->language->get('error_confirm'); ?>" />
            <?php if ($error_confirm): ?>
            <p class="s_error_msg"><?php echo $error_confirm; ?></p>
            <?php endif; ?>
          </div>

          <div class="s_row_2 clearfix">
            <label><strong><?php echo $entry_newsletter; ?></strong></label>
            <div class="s_full clearfix">
              <?php if ($newsletter == 1): ?>
              <label class="s_radio"><input type="radio" name="newsletter" value="1" checked="checked" /> <?php echo $text_yes; ?></label>
              <label class="s_radio"><input type="radio" name="newsletter" value="0" /> <?php echo $text_no; ?></label>
              <?php else: ?>
              <label class="s_radio"><input type="radio" name="newsletter" value="1" /> <?php echo $text_yes; ?></label>
              <label class="s_radio"><input type="radio" name="newsletter" value="0" checked="checked" /> <?php echo $text_no; ?></label>
              <?php endif; ?>
            </div>
        </div>
        </div>
		<!-- PASSWORD FORM -->
		
		
		<!-- CAPTCHA FORM -->
        <?php if ($captcha) { ?>
		<b style="margin-bottom: 2px; display: block;"><?php echo $text_captcha; ?></b>
        <div class="content">
          <table class="register-form">
            <tr>
			  <td><img src="index.php?route=checkout/checkout_one/captcha" alt="" id="captcha" /></td>
              <td><input type="text" name="captcha" value="" autocomplete="off"/>
			  	<?php if ($error_captcha) { ?>
                <span class="error"><?php echo $error_captcha; ?></span>
                <?php } ?>
              </td>
            </tr>
          </table>
        </div>
		<?php } ?>
		<!-- CAPTCHA FORM -->
		
	  </div>

	  <div class="clear s_sep border_eee"></div>

	  <!-- Agree -->
      <?php if ($text_agree) { ?>
	  <div class="buttons agree">
		<div class="right" style="width:100%"><?php echo $text_agree; ?>
		  <?php if ($agree) { ?>
		  <input type="checkbox" name="agree" value="1" checked="checked" />
		  <?php } else { ?>
		  <input type="checkbox" name="agree" value="1" />
		  <?php } ?>
		</div>
      </div>
      <?php } ?>
	  <div class="s_submit clearfix">
	    <div class=""><a href="<?php echo str_replace('&', '&amp;', $back); ?>" class="s_button_1 s_ddd_bgr left"><span class="s_text"><?php echo $button_back; ?></span></a></div>
	    <div class=""><a onclick="checkRegSubmit();" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a></div>
	  </div>

    </form>
  </div>
</div>

<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script>

<script type="text/javascript"><!--

function checkRegSubmit() {

	<?php if ($text_agree) { ?>
	if (!$('input[name=\'agree\']').is(':checked')) {
		alert('<?php echo $text_must_agree; ?>');
		return false;
	}
	<?php } ?>

	$('#register').submit();
}

$(document).ready(function () {
	if ($('#country_id').val()) {
		var country_id =  $('#country_id').val();
		$('select[name=\'zone_id\']').load('index.php?route=checkout/checkout_one/zone&country_id=' + country_id + '&zone_id=<?php echo $zone_id; ?>');
	}

	if ($('#shipping_country_id').val()) {
		var shipping_country_id =  $('#shipping_country_id').val();
		$('select[name=\'shipping_zone_id\']').load('index.php?route=checkout/checkout_one/zone&country_id=' + shipping_country_id + '&zone_id=<?php echo $shipping_zone_id; ?>');
	}
});

//--></script>

<script type="text/javascript"><!--
$('select[name=\'customer_group_id\']').live('change', function() {
	var customer_group = [];

<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}

		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}

		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}

		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}
	}
});

$('select[name=\'customer_group_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout_one/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
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

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}

	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

//--></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />


<script type="text/javascript"><!--
if (jQuery().colorbox) {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		width: "80%",
		height: "80%"
	});
}
if (jQuery().fancybox) {
	$('.fancybox').fancybox({cyclic: true});
	$('.colorbox').fancybox({cyclic: true});
}
//--></script>
<link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_javascript_url; ?>prettyphoto/css/prettyPhoto.css" media="all" />
<script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>prettyphoto/js/jquery.prettyPhoto.js"></script>
<script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
    
<?php if (!$this->config->get('uber_checkout_popup')) { ?>
<?php echo $footer; ?>
<?php } ?>