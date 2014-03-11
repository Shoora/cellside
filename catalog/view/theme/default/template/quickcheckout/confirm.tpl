<!-- Quick Checkout v4.0 by Dreamvention.com quickcheckout/cofirm.tpl -->
<div id="confirm_wrap">
  <div class="box">
    <div class="box-heading"></div>
    <div class="box-content">
      <div id="confirm_inputs">
        <?php foreach($confirm['fields'] as $field){
    	if(isset($field['type'])) {
    		switch ($field['type']) {
     			case "heading":
		?>
        <?php if($field['display']){ ?>
        <br class="clear"/>
      </div>
    </div>
    <div id="<?php echo $field['id']; ?>_input" class="box box-border sort-item <?php echo $field['id']; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
      <div class="box-heading"><?php echo $field['title']; ?></div>
      <div class="box-content">
        <?php } ?>
        <?php		break; 
      			case "label":
        ?>
        <div id="<?php echo $field['id']; ?>_input" class="label-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <p name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" class="label-text" />
          <?php echo isset($field['value'])? $field['value'] : ''; ?>
          </p>
        </div>
        <?php		break; 
      			case "radio":
        ?>
        <div id="<?php echo $field['id']; ?>_input" class="radio-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <ul>
            <?php foreach ($field['options'] as $option) { ?>
            <?php if ($option['value'] == $field['value']) { ?>
            <li>
              <input type="radio" name="confirm[<?php echo $field['id']; ?>]" value="<?php echo $option['value']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="confirm_<?php echo $field['id'].$option['value']; ?>" checked="checked" class="styled"  autocomplete='off'/>
              <label for="confirm_<?php echo $field['id'].$option['value']; ?>"><?php echo $option['title']; ?></label>
            </li>
            <?php } else { ?>
            <li>
              <input type="radio" name="confirm[<?php echo $field['id']; ?>]" value="<?php echo $option['value']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="confirm_<?php echo $field['id'].$option['value']; ?>"  class="styled"  autocomplete='off'/>
              <label for="confirm_<?php echo $field['id'].$option['value']; ?>"><?php echo $option['title']; ?></label>
            </li>
            <?php } ?>
            <?php } ?>
          </ul>
        </div>
        <?php
        	break;
    		case "checkbox":
		?>
        <div id="<?php echo $field['id']; ?>_input" class="checkbox-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <?php if($field['value'] == 1){?>
          <input type="checkbox" name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="1" checked="checked" class="styled"  autocomplete='off' />
          <?php }else{?>
          <input type="checkbox" name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="0" class="styled"  autocomplete='off' />
          <?php } ?>
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
        </div>
        <?php
        	break;
    		case "select":
		?>
        <div id="<?php echo $field['id']; ?>_input" class="select-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <select name="confirm[<?php echo $field['id']; ?>]" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" id="confirm_<?php echo $field['id']; ?>">
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
        <?php
      		break;
       		case "password":
		?>
        <div id="<?php echo $field['id']; ?>_input" class="password-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <input type="password" name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="<?php echo isset($field['value'])? $field['value'] : ''; ?>" />
        </div>
        <?php		break; 
      			case "textarea":
        ?>
        <div id="<?php echo $field['id']; ?>_input" class="textarea-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <textarea name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>"><?php echo isset($field['value'])? $field['value'] : ''; ?></textarea>
        </div>
        <?php
    		break;
            default:
   	 ?>
        <div id="<?php echo $field['id']; ?>_input" class="text-input sort-item <?php echo (!$field['display'])? 'hide' : ''; ?> <?php echo ($field['class'])? $field['class'] : ''; ?>" sort-data="<?php echo $field['sort_order']; ?>">
          <label for="confirm_<?php echo $field['id']; ?>"> <span class="required <?php echo (!isset($field['require']) ||  !$field['require']) ? 'hide' : ''; ?>">*</span> <span class="text"><?php echo $field['title']; ?></span> </label>
          <input type="text" name="confirm[<?php echo $field['id']; ?>]" id="confirm_<?php echo $field['id']; ?>" data-require="<?php echo (isset($field['require']) && $field['require']) ? 'require' : ''; ?>" data-refresh="<?php echo ($field['refresh']) ? $field['refresh'] : 0; ?>" value="<?php echo isset($field['value'])? $field['value'] : ''; ?>" />
        </div>
        <?php } ?>
        <?php } ?>
        <?php } ?>
      </div>
      <div id="payment_input">
        <div id="confirm_payment"><?php echo(isset($payment)) ? $payment : '';?></div>
        <div class="buttons">
          <div class="right">
            <input type="button" id="confirm_order" class="button btn btn-primary" value="<?php if(isset($payment)){ echo $button_confirm; }else{ echo $button_continue;  } ?>" />
          </div>
        </div>
      </div>
      <div class="clear"></div>
    </div>
  </div>
</div>
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
