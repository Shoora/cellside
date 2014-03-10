<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
<div id="group-content">

<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12"> 
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php echo $content_top; ?>
 
 
 


 	<link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook/stylesheet/style.css">
    <link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook/stylesheet/checkbox_login.css">
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web' rel='stylesheet' type='text/css'>
  

  <div class="register">
  
  <div class="container ">
    <div class="row">
  
  
  
      <div class="col-sm-5 formu">
        <header>Create an account</header>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
		<input placeholder="First Name * " type="text" name="firstname" value="<?php echo $firstname; ?>" />
        <?php if ($error_firstname) { ?>
        <span class="error"><?php echo $error_firstname; ?></span>
        <?php } ?>
      	
        <input placeholder="Last Name * " type="text" name="lastname" value="<?php echo $lastname; ?>" />
        <?php if ($error_lastname) { ?>
        <span class="error"><?php echo $error_lastname; ?></span>
        <?php } ?>
      	<input class="large" type="text" name="email" placeholder="Email * " value="<?php echo $email; ?>" />
        <?php if ($error_email) { ?>
        <span class="error"><?php echo $error_email; ?></span>
     <input type="password" name="password" placeholder="Password * " value="<?php echo $password; ?>" />
				<?php if ($error_password) { ?>
				<span class="error"><?php echo $error_password; ?></span>
				<?php } ?>   <?php } ?>
     
     	<input  type="password" name="confirm" placeholder="Repeat password * " value="<?php echo $confirm; ?>" />
        
        <div class="select_label">
        <label>
        <select class="form-control" name="country_id">
				  <option value=""><?php echo $text_select; ?></option>
				  <?php foreach ($countries as $country) { ?>
				  <?php if ($country['country_id'] == $country_id) { ?>
				  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
				  <?php } else { ?>
				  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
				  <?php } ?>
				  <?php } ?>
				</select>
				<?php if ($error_country) { ?>
				<span class="error"><?php echo $error_country; ?></span>
				<?php } ?>
              
              </label>​

            </div>
            
        <div class="select_label">
        <label>
            <select class="form-control" name="zone_id">
				</select>
				<?php if ($error_zone) { ?>
				<span class="error"><?php echo $error_zone; ?></span>
				<?php } ?>
         </label>​
        </div>    
            
      <input class="large" type="text" placeholder="Company Name" name="company" value="<?php echo $company; ?>" />
      <input class="large" type="text" name="telephone" placeholder="Telephone *" value="<?php echo $telephone; ?>" />
        <?php if ($error_telephone) { ?>
        <span class="error"><?php echo $error_telephone; ?></span>
        <?php } ?>
	<input type="text" name="fax" placeholder="Fax" value="<?php echo $fax; ?>" />
	<input type="text" name="city" placeholder="City" value="<?php echo $city; ?>" />
				<?php if ($error_city) { ?>
				<span class="error"><?php echo $error_city; ?></span>
				<?php } ?>
  
  <input class="large" placeholder="Address 1" type="text" name="address_1" value="<?php echo $address_1; ?>" />
				<?php if ($error_address_1) { ?>
				<span class="error"><?php echo $error_address_1; ?></span>
				<?php } ?>
     <input class="large" placeholder="Address 2" type="text" name="address_2" value="<?php echo $address_1; ?>" />
      <input  type="text" name="postcode" value="<?php echo $postcode; ?>" />
    <input type="hidden" name="newsletter" value="0" />
    <input type="hidden" name="agree" value="1" />
				
      <div class="obligatory">*Obligatory fields</div> <input type="image" src="catalog/view/theme/lexus_happycook/img/create_account.png" />
    </form>
    </div>
  
    
    <div class="col-sm-7 login">
        <header>Already have an account?</header>
          <div class="row login_choice">
            <div class="col-sm-6 login_account">
              <form action="index.php?route=account/login" method="post" enctype="multipart/form-data">
              <input type="email" value="" placeholder="Email" />
              <input type="password" value="" placeholder="Password"/>
              <div class="login_button"><input type="image" src="catalog/view/theme/lexus_happycook/img/login_button.png" /></div>
              <div class="check">  <input type="checkbox" name="checkbox2" id="checkbox2" class="css-checkbox" /><label for="checkbox2" class="css-label"></label>Remember me</div>
              </form>

            </div>
            <div class="col-sm-6 login_social">
              <a href="#"> <img src="catalog/view/theme/lexus_happycook/img/facebook.png"> </a>
              <p>or</p>
               <a href="#"> <img src="catalog/view/theme/lexus_happycook/img/twitter.png"> </a>
            </div>
          </div>
      </div>
  </div>
</div>



		
		
	  <?php echo $content_bottom; ?>
	<script type="text/javascript"><!--
	$('input[name=\'customer_group_id\']:checked').live('change', function() {
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

	$('input[name=\'customer_group_id\']:checked').trigger('change');
	//--></script> 
	<script type="text/javascript"><!--
	$('select[name=\'country_id\']').bind('change', function() {
		$.ajax({
			url: 'index.php?route=account/register/country&country_id=' + this.value,
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

	$('select[name=\'country_id\']').trigger('change');
	//--></script> 
	<script type="text/javascript"><!--
	$(document).ready(function() {
		$('.colorbox').colorbox({
			width: 640,
			height: 480
		});
	});
	//--></script> 
</section>	

		<?php if( $SPAN[2] ): ?>
		<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
			<?php echo $column_right; ?>
		</aside>
		<?php endif; ?>
</div>

<?php echo $footer; ?>