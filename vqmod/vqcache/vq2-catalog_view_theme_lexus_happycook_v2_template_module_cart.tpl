<div id="cart">
	<div class="heading no-select" onClick="toggleCart(this);">
		<i class="fa fa-shopping-cart"></i><br>
		<a class="cart_a"><span id="cart-total"><?php echo $text_items; ?></span></a>
		<?php $count = explode(' - ', $text_items); ?>
	</div>
	<div class="content">
		<?php if ($products || $vouchers) { ?>
			<div class="checkout">
				<span class="cart-item-count">Your Products <?php echo $count[0];?></span>
				<i class="fa fa-caret-up" style="color:#363636; font-size:22px; position:absolute;top:6px; right:25px;"></i>
				<a href="<?php echo $checkout; ?>" class="green_button sm">Checkout</a>
				<a href="/index.php?route=checkout/cart" class="green_button sm">View cart</a>
			</div>
			<div class="mini-cart-info">
				<table>
					<?php foreach ($products as $product) : ?>
						<tr>
							<td class="image">
								<?php if ($product['thumb']) : ?>
									<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
								<?php endif; ?></td>
							<td class="name">
								<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
								<div>
									<?php foreach ($product['option'] as $option) : ?>
									- <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
									<?php endforeach; ?>


									<?php if ($product['recurring']): ?>
									- <small><?php echo $text_payment_profile ?> <?php echo $product['profile']; ?></small><br />
									<?php endif; ?>


								</div>
							</td>
							<td class="total"><?php echo $product['total']; ?></td>
						</tr>
					<?php endforeach; ?>
					<?php foreach ($vouchers as $voucher) : ?>
						<tr>
							<td class="image"></td>
							<td class="name"><?php echo $voucher['description']; ?></td>
							<td class="quantity">x&nbsp;1</td>
							<td class="total"><?php echo $voucher['amount']; ?></td>
							<td class="remove"><img src="catalog/view/theme/default/image/remove-small.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" onclick="(getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout' || getURLVar('route') == 'checkout/checkout_two') ? location = 'index.php?route=checkout/cart&remove=<?php echo $voucher['key']; ?>' : $('#cart').load('index.php?route=module/cart&remove=<?php echo $voucher['key']; ?>' + ' #cart > *');" /></td>
						</tr>
					<?php endforeach ?>
				</table>
			</div>		
		<?php } else { ?>
			<div class="checkout"><p style="text-align:center;">Cart is empty</p><i class="fa fa-caret-up" style="color:#363636; font-size:22px; position:absolute;top:6px; right:25px;"></i></div>
				<div class="mini-cart-info">
				<p class="emptyy"><?php echo $text_empty; ?></p>
			</div>
		<?php } ?>
	</div>
</div>