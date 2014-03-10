<!-- Quick Checkout v4.0 by Dreamvention.com quickcheckout/shipping_method.tpl -->
<div id="shipping_method_wrap" <?php echo (!$data['display']) ? 'class="hide"' : ''; ?>>
<?php if ($error_warning) { ?>
<div class="error"><?php echo $error_warning; ?></div>
<?php } ?>

<?php if ($shipping_methods) { ?>

<div class="box box-border">
<div class="box-heading "><i class="icon-shipping-method"></i> <span><?php echo $data['title']; ?></span></div>
<div class="box-content">
<?php if ($data['description']) { ?> <div class="description"><?php echo $data['description']; ?></div> <?php } ?>

<div class="<?php if (!$data['display_options']) {  echo 'hide';  } ?>">

<?php if($data['input_style'] == 'select'){ ?>
<select name="shipping_method" class="shipping-method-select" data-refresh="5">
    <?php foreach ($shipping_methods as $shipping_method) { ?>
    <?php foreach ($shipping_method['quote'] as $quote) { ?>
            <?php if ($quote['code'] == $code || !$code) { ?>
            <?php $code = $quote['code']; ?>
            <option  value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" selected="selected" ><?php echo $quote['title']; ?> <?php echo $quote['text']; ?></option>
            <?php } else { ?>
            <option  value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" ><?php echo $quote['title']; ?> <?php echo $quote['text']; ?></option>
            <?php } ?>
            <?php } ?>
        <?php } ?>
</select> 
<?php } else { ?> 


<?php foreach ($shipping_methods as $shipping_method) { ?>
    <div class="title <?php if (!$data['display_title']) {  echo 'hide';  } ?>"><?php echo $shipping_method['title']; ?></div>
    <?php if (!$shipping_method['error']) { ?>
        <?php foreach ($shipping_method['quote'] as $quote) { ?>
            <div class="radio-input">
                <?php if ($quote['code'] == $code || !$code) { ?>
                    <?php $code = $quote['code']; ?>
                    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked"  data-refresh="5" class="styled"/>
                <?php } else { ?>
                    <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>"  data-refresh="5" class="styled"/>
                <?php } ?>
                <label for="<?php echo $quote['code']; ?>"><span class="text"><?php echo $quote['title']; ?></span><span class="price"><?php echo $quote['text']; ?></span></label>
            </div>
        <?php } ?>
    <?php } else { ?>
    	<div class="error alert alert-error"><?php echo $shipping_method['error']; ?></div>
    <?php } ?>
<?php } ?>


<?php } ?>

</div>
<div class="clear"></div>
</div>
</div>

<?php } ?>
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






