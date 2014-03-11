<div id="cart">
  <div class="heading"><i class="fa fa-shopping-cart"></i>
    <a class="cart_a"><span id="cart-total"><?php echo $text_items; ?></span> <span style="margin-left:5px;" class="fa fa-caret-down"></span></a></div>
  <div class="content">
    <?php if ($products || $vouchers) { ?>
	<div class="checkout col-xs-4"><i class="fa fa-caret-up" style="color:#363636; font-size:22px; position:absolute;top:-14px; right:25px;"></i><a href="<?php echo $checkout; ?>"><img style="margin:0;" src="../image/checkout-btt.png" alt="checkout"></a></div>
    <div class="mini-cart-info">
      <table>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="image"><?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
            <?php } ?></td>
          <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <div>
              <?php foreach ($product['option'] as $option) { ?>
              - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
              <?php } ?>


              <?php if ($product['recurring']): ?>
              - <small><?php echo $text_payment_profile ?> <?php echo $product['profile']; ?></small><br />
              <?php endif; ?>


            </div></td>
			<td class="total"><?php echo $product['total']; ?></td>
         <!-- <td class="quantity">x&nbsp;<?php echo $product['quantity']; ?></td>
          
          <td class="remove"><img src="catalog/view/theme/default
/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $product['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $product['key']; ?>' + ' #cart > *');" /></td>-->
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="image"></td>
          <td class="name"><?php echo $voucher['description']; ?></td>
          <td class="quantity">x&nbsp;1</td>
          <td class="total"><?php echo $voucher['amount']; ?></td>
          <td class="remove"><img src="catalog/view/theme/default
/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') ? location = 'index.php?route=checkout/cart&remove=<?php echo $voucher['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $voucher['key']; ?>' + ' #cart > *');" /></td>
        </tr>
        <?php } ?>
      </table>
    </div>
   <!-- <div class="mini-cart-total col-xs-8">
      <table>
        <?php foreach ($totals as $total) { ?>
        <tr>
          <td class="right"><b><?php echo $total['title']; ?>:</b></td>
          <td class="right"><?php echo $total['text']; ?></td>
        </tr>
        <?php } ?>
      </table>
    </div> -->
    
    <?php } else { ?>
	<div class="checkout col-xs-4"><p style="text-align:center;">Cart is empty</p><i class="fa fa-caret-up" style="color:#363636; font-size:22px; position:absolute;top:-14px; right:25px;"></i></div>
    <div class="mini-cart-info">
    <p class="emptyy"><?php echo $text_empty; ?></p>
	</div>
    <?php } ?>
  </div>
</div>