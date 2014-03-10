<!-- Quick Checkout v4.0 by Dreamvention.com quickcheckout/payment_method.tpl -->
<div id="payment_method_wrap" <?php echo (!$data['display']) ? 'class="hide"' : ''; ?>>
<?php if ($error_warning) { ?>
<div class="error"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<div class="box box-border" >
  <div class="box-heading <?php if (!$data['display']) {  echo 'hide';  } ?>"><i class="icon-payment-method"></i> <span><?php echo $data['title']; ?></span></div>
  <div class="box-content ">
  	<?php if ($data['description']) { ?> <div class="description"><?php echo $data['description']; ?></div> <?php } ?>
    <div class="<?php if (!$data['display_options']) {  echo 'hide';  } ?>">
      <?php if($data['input_style'] == 'select'){ ?>
      <select name="payment_method" class="payment-method-select" data-refresh="6" >
        <?php foreach ($payment_methods as $payment_method) { ?>
        <?php if ($payment_method['code'] == $code || !$code) { ?>
        <?php $code = $payment_method['code']; ?>
        <option  value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" selected="selected" ><?php echo $payment_method['title']; ?></option>
        <?php } else { ?>
        <option  value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" ><?php echo $payment_method['title']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
      <?php }else{?>
      <?php foreach ($payment_methods as $payment_method) { ?>
      <div class="radio-input">
        <?php if ($payment_method['code'] == $code || !$code) { ?>
        <?php $code = $payment_method['code']; ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" class="styled"  data-refresh="6"/>
        <?php } else { ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" class="styled"  data-refresh="6"/>
        <?php } ?>
        <label for="<?php echo $payment_method['code']; ?>">
          <?php if(file_exists(DIR_IMAGE.'data/payment/'.$payment_method['code'].'.png')) { ?>
          <img class="payment-image <?php if (!$data['display_images']) {  echo 'hide';  } ?>" src="image/data/payment/<?php echo $payment_method['code']; ?>.png" />
          <?php } ?>
          <?php echo $payment_method['title']; ?></label>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
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
