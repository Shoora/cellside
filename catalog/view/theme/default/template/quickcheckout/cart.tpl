<!-- Quick Checkout v4.0.4 by Dreamvention.com quickcheckout/cart.tpl -->
<div id="cart_wrap">
  <div class="checkout-product <?php echo (!$data['display']) ? 'hide' : ''; ?>" >
    <?php if(isset($error)){ 
    foreach ($error as $error_message){ ?>
    <div class="error"><?php echo $error_message; ?></div>
    <?php }
 } ?>
    <table class="table cart clear">
      <thead>
        <tr>
          <td class="image <?php echo (!$data['columns']['image'])?  'hide' :""; ?>"></td>
          <td class="name <?php echo (!$data['columns']['name'])?  'hide' :""; ?>"><?php echo $column_name; ?></td>
          <td class="model <?php echo (!$data['columns']['model'])?  'hide' :""; ?>"><?php echo $column_model; ?></td>
          <td class="quantity <?php echo (!$data['columns']['quantity'])?  'hide' :""; ?>"><?php echo $column_quantity; ?></td>
          <td class="price  <?php echo (!$data['columns']['price'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' :""; ?> "><?php echo $column_price; ?></td>
          <td class="total <?php  echo (!$data['columns']['total'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' :""; ?>"><?php echo $column_total; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($products as $product) { ?>
        <tr <?php echo(!$product['stock']) ? 'class="stock"' : '' ;?>>
          <td class="image <?php echo (!$data['columns']['image'])?  'hide' : '' ?> "><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" /></a></td>
          <td class="name  <?php echo (!$data['columns']['name'])?  'hide' : '' ?> "><a href="<?php echo $product['href']; ?>"> <img src="<?php echo $product['thumb']; ?>" class="hide <?php echo (!$data['columns']['image'])?  '' : 'show' ?>"/> <?php echo $product['name']; ?> <?php echo (!$product['stock'])? '<span class="out-of-stock">***</span>' : '' ?></a>
            <?php foreach ($product['option'] as $option) { ?>
            <div> &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small> </div>
            <?php } ?></td>
          <td class="model  <?php echo (!$data['columns']['model'])?  'hide' : '' ?> "><?php echo $product['model']; ?></td>
          <td class="quantity  <?php echo (!$data['columns']['quantity'])?  'hide' : '' ?> "><i class="icon-small-minus decrease" data-product="<?php echo $product['product_id']; ?>"></i>
            <input type="text" value="<?php echo $product['quantity']; ?>" class="product-qantity" name="cart[<?php echo $product['product_id']; ?>]"  data-refresh="3"/>
            <i class="icon-small-plus increase" data-product="<?php echo $product['product_id']; ?>"></i></td>
          <td class="price <?php echo (!$data['columns']['price'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' : ''; ?> "><?php echo $product['price']; ?></td>
          <td class="total <?php echo (!$data['columns']['total'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' : ''; ?> "><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $vouchers) { ?>
        <tr>
          <td class="name <?php echo (!$data['columns']['image'])?  'hide' : '' ?> "></td>
          <td class="name <?php echo (!$data['columns']['name'])?  'hide' : '' ?> "><?php echo $vouchers['description']; ?></td>
          <td class="model <?php echo (!$data['columns']['model'])?  'hide' : '' ?> "></td>
          <td class="quantity <?php echo (!$data['columns']['quantity'])?  'hide' : '' ?> ">1</td>
          <td class="price <?php echo (!$data['columns']['price'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' : ''; ?> "><?php echo $vouchers['amount']; ?></td>
          <td class="total <?php echo (!$data['columns']['total'] || ($this->config->get('config_customer_price') && !$this->customer->isLogged()))?  'hide' : '' ?> "><?php echo $vouchers['amount']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <table class="table summary">
      <tbody  class=" <?php if($this->config->get('config_customer_price') && !$this->customer->isLogged()){ echo 'hide';}?>">
        <tr class="coupon <?php if(!$coupon_status || !$data['option']['coupon']['display']){ echo 'hide';} ?>">
          <td class="text" ><b><?php echo $text_use_coupon; ?>:</b></td>
          <td class="total"><input type="text" value="<?php echo (isset($coupon))?  $coupon : ''; ?>" name="coupon" id="coupon"  />
            <i class="icon-confirm" id="confirm_coupon"></i></td>
        </tr>
        <tr class="voucher <?php if(!$voucher_status || !$data['option']['voucher']['display']){ echo 'hide';} ?>">
          <td  class="text" ><b><?php echo $text_use_voucher; ?>:</b></td>
          <td class="total"><input type="text" value="<?php echo (isset($voucher))?  $voucher : ''; ?>" name="voucher" id="voucher"  />
            <i class="icon-confirm" id="confirm_voucher"></i></td>
        </tr>
        <tr class="reward <?php if(!$reward_status || !$data['option']['reward']['display']){ echo 'hide';} ?>">
          <td  class="text" ><b><?php echo $text_use_reward; ?>:</b></td>
          <td class="total "><input type="text" value="<?php echo (isset($reward))?  $reward : ''; ?>" name="reward" id="reward"  />
            <i class="icon-confirm" id="confirm_reward"></i></td>
        </tr>
        <?php foreach ($totals as $total) { ?>
        <tr>
          <td class="text" ><b><?php echo $total['title']; ?>:</b></td>
          <td class="total"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </div>
  <div class="clear"></div>
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
