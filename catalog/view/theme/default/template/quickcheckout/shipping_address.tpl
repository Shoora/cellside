<!-- Quick Checkout v4.0 by Dreamvention.com quickcheckout/register.tpl -->
<div id="shipping_address_wrap" <?php echo (!$data['display'] || $payment_address['shipping']) ? 'class="hide"' : ''; ?>>
  <div class="box box-border">
    <div class="box-heading"><i class="icon-shipping-address"></i> <span><?php echo $data['title']; ?></span></div>
    <div class="box-content">
    <div class="description"><?php echo $data['description']; ?></div>
<?php if ($addresses) { ?>
    <div id="shipping_address_exists_1_block" class="radio-input">
      <input type="radio" name="shipping_address[exists]" value="1" id="shipping_address_exists_1" <?php echo ($shipping_address['exists']) ? 'checked="checked"' : ''; ?>  class="styled" data-refresh="3" autocomplete='off' />
      <label for="shipping_address_exists_1"><?php echo $text_address_existing; ?></label>
    </div>
    <div id="shipping_address_exists_list" <?php echo (!$shipping_address['exists']) ?  'class="hide"' : ''; ?>>
      <select name="shipping_address[address_id]" style="width: 100%; margin-bottom: 15px;" data-refresh="4">
        <?php foreach ($addresses as $address) { ?>
            <?php if ($address['address_id'] == $shipping_address['address_id']) { ?>
            	<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
            <?php } else { ?>
            	<option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
            <?php } ?>
        <?php } ?>
      </select>
    </div>
    <div id="shipping_address_exists_0_block" class="radio-input">
      <input type="radio" name="shipping_address[exists]" value="0" id="shipping_address_exists_0" <?php echo (!$shipping_address['exists']) ? 'checked="checked"' : ''; ?>  class="styled" data-refresh="3" autocomplete='off' />
      <label for="shipping_address_exists_0"><?php echo $text_address_new; ?></label>
    </div>
<?php } ?>

<div id="shipping_address" <?php echo ($shipping_address['exists']) ?  'class="hide"' : '';?>>

      <?php foreach($shipping_address['fields'] as $field){
    	if(isset($field['type'])){
    		switch ($field['type']) {
     			case "heading":
		?>
        <?php if($field['display']){ ?>
        <div class="clear"></div>
        </div>
    </div>
  </div>
  <div id="<?php echo $field['id']; ?>_input" class="box box-border sort-item <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
    <div class="box-heading"><?php echo $field['title']; ?></div>
    <div class="box-content">
    	<div>
      <?php } ?>
      <?php		break; 
      			case "label":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="label-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
        <p name="shipping_address[<?php echo $field['id']; ?>]" id="shipping_address_<?php echo $field['id']; ?>" class="label-text" />
        <?php echo isset($field['value'])? $field['value'] : ''; ?>
        </p>
      </div>
      <?php		break; 
      			case "radio":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="radio-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
        <ul>
          <?php foreach ($field['options'] as $option) { ?>
          <?php if ($option['value'] == $field['value']) { ?>
          <li>
            <input type="radio" name="shipping_address[<?php echo $field['id']; ?>]" value="<?php echo $option['value']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="shipping_address_<?php echo $field['id'].$option['value']; ?>" checked="checked" class="styled"  autocomplete='off'/>
            <label for="<?php echo $field['id'].$option['value']; ?>"><?php echo $option['title']; ?></label>
          </li>
          <?php } else { ?>
          <li>
            <input type="radio" name="shipping_address[<?php echo $field['id']; ?>]" value="<?php echo $option['value']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="shipping_address_<?php echo $field['id'].$option['value']; ?>"  class="styled"  autocomplete='off'/>
            <label for="<?php echo $field['id'].$option['value']; ?>"><?php echo $option['title']; ?></label>
          </li>
          <?php } ?>
          <?php } ?>
        </ul>
      </div>
      <?php		break; 
      			case "checkbox":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="checkbox-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <?php if($field['value'] == 1){?>
        <input type="checkbox" name="shipping_address[<?php echo $field['id']; ?>]" id="shipping_address_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="1" checked="checked" class="styled"  autocomplete='off' />
        <?php }else{?>
        <input type="checkbox" name="shipping_address[<?php echo $field['id']; ?>]" id="shipping_address_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>"value="1" class="styled"  autocomplete='off' />
        <?php } ?>
        <label for="shipping_address_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span>  <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
      </div>
      <?php		break; 
      			case "select":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="select-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span>  <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
        <select name="shipping_address[<?php echo $field['id']; ?>]" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="shipping_address_<?php echo $field['id']; ?>">
          <option value=""><?php echo $text_select; ?></option>
          <?php if(!empty($field['options'])) { ?>
              <?php foreach ($field['options'] as $option) { ?>
                  <?php if ($option['value'] == $field['value']) { ?>
                  <option value="<?php echo $option['value']; ?>" selected="selected"><?php echo $option['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $option['value']; ?>"><?php echo $option['name']; ?></option>
                  <?php } ?>
              <?php } ?>
          <?php } ?>
        </select>
      </div>
      <?php		break; 
      			case "password":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="password-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span>  <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
        <input type="password" name="shipping_address[<?php echo $field['id']; ?>]" id="shipping_address<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="<?php echo isset($field['value'])? $field['value'] : ''; ?>" />
      </div>
      <?php		break; 
      			case "textarea":
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="textarea-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span>  <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
        <textarea name="shipping_address[<?php echo $field['id']; ?>]" id="shipping_address_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>"><?php echo isset($field['value'])? $field['value'] : ''; ?></textarea>
      </div>
      <?php		break; 
      			default:
        ?>
      <div id="<?php echo $field['id']; ?>_input" class="text-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
        <label for="shipping_address_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span>  <?php echo (!empty($field['tooltip']))? '<i class="icon-help" rel="tooltip" data-help="'.$field['tooltip'] .'"></i>' : '' ; ?></label>
        <input type="text" name="shipping_address[<?php echo $field['id']; ?>]" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="shipping_address_<?php echo $field['id']; ?>" value="<?php echo isset($field['value'])? $field['value'] : ''; ?>" />
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
      <div class="clear"></div>
    </div>
  </div>
</div>
</div>
<script type="text/javascript"><!--
$('input[name=\'shipping_address[exists]\']').live('click', function() {
	if (this.value == '0') {
		$('#shipping_address_exists_list').hide();
		$('#shipping_address').show();
	} else {
		$('#shipping_address_exists_list').show();
		$('#shipping_address').hide();
	}
});
//--></script>
<script type="text/javascript"><!--
function refreshShippingAddessZone(value) {
	$.ajax({
		url: 'index.php?route=module/quickcheckout/country&country_id=' + value,
		dataType: 'json',
		beforeSend: function() {
	
		},
		complete: function() {
		
		},			
		success: function(json) {
			/*if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
			}*/
			
			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $shipping_address['fields']['zone_id']['value']; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#shipping_address_wrap select[name=\'shipping_address[zone_id]\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

refreshShippingAddessZone($('#shipping_address_wrap select[name=\'shipping_address[country_id]\']').val())
$('#shipping_address_wrap select[name=\'shipping_address[country_id]\']').bind('change', function(){
	refreshShippingAddessZone($(this).val())	
})
//$('.sort-item').tsort({attr:'sort-data'});


/*$(function(){
if($('input[name="payment_address[shipping]"]').attr('checked') == 'checked'){
		$('#shipping_address').addClass('hide')
	}
	
});*/
//--></script>
<script><!--
$(function(){
	if($.isFunction($.fn.uniform)){
        $(" .styled, input:radio.styled").uniform().removeClass('styled');
	}
	if($.isFunction($.fn.colorbox)){
		$('.colorbox').colorbox({
			width: 640,
			height: 480
		});
	}
	if($.isFunction($.fn.fancybox)){
		$('.fancybox').fancybox({
			width: 640,
			height: 480
		});
	}
});
//--></script>
