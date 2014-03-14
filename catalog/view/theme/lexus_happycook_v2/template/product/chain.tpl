<?php
/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/
?>

<script type="text/javascript">
var text_select_options = '<?php echo $text_select_options_js_error ?>';
var text_success 		= '<?php echo $text_success ?>';
var chain_shoping_cart_href = '<?php echo $chain_shoping_cart_href ?>';
</script>

<? /* ADDITIONAL CSS OPTIONS FOR CUSTOMIZATION */ ?>
<style type="text/css">
#chain_container .chain_you_save, .product-info #chain_container .chain_you_save span, #chain_container .chain_you_save span{
	background: <?php echo index_value($chain_settings, 'chain_style_discount_label_color');?>;
	color: <?php echo index_value($chain_settings, 'chain_style_discount_color');?>;
	font-size: <?php echo index_value($chain_settings, 'chain_style_discount_fontsize');?>;
}

#chain_container .chain-item {
	/*width: <?php echo index_value($chain_settings, 'chain_display_image_width');?>px;*/
	padding: 5px;
}
#chain_container .chain-result {
	width: 130px;
	padding-left: 20px;
}
#chain_container .chain-symbol, #chain_container .chain-result {
	padding-top: <?php echo index_value($chain_settings, 'chain_display_image_width') / 2 - 5;?>px;
	color: <?php echo index_value($chain_settings, 'chain_style_sign_color');?>;
}
#chain_container .total_price {
	color: <?php echo index_value($chain_settings, 'chain_style_total_price_color');?>;
	font-size: <?php echo index_value($chain_settings, 'chain_style_total_price_fontsize');?>;
}
#chain_container .total_save, #chain_container .total_save span, #chain_container .product-info .total_save span {
	color: <?php echo index_value($chain_settings, 'chain_style_you_save_color');?>;
	font-size: <?php echo index_value($chain_settings, 'chain_style_you_save_fontsize');?>;
}
#chain_container .chain-symbol {
	font-size: <?php echo index_value($chain_settings, 'chain_style_sign_fontsize');?>;
}
#chain_container .chain_product_quantity {
	font-size: <?php echo index_value($chain_settings, 'chain_style_sign_fontsize');?>;
	margin-top: <?php echo index_value($chain_settings, 'chain_display_image_height') / 2.5;?>px;
	background: rgba(255,255,255,0.7);
}
#chain_container .chain_product_quantity:hover {
	background: rgba(255,255,255,0.9);
}
#chain_container {
	margin-top: 0px;
	margin-bottom: 0px;
}
#chain_container .price {
	font-size: <?php echo index_value($chain_settings, 'chain_style_new_price_fontsize');?>;
	line-height: 19px;
	padding-top: 10px;
	text-align: center;
	border-bottom: none;
	border-top: none;
	font-weight: <?php echo index_value($chain_settings, 'chain_style_price_font_weight');?>;
}
#chain_container .name {
	text-align: center;
}
#chain_container .price-old {
	font-size: <?php echo index_value($chain_settings, 'chain_style_old_price_fontsize');?>;
	color: <?php echo index_value($chain_settings, 'chain_style_oldprice_color');?>;
	text-decoration: line-through;
}
#chain_container .price-free {
	color: #159e0e;
}
#chain_container .chain_option {
	background-color: <?php echo index_value($chain_settings, 'chain_style_options_color_selected');?>;
}
#chain_container .chain_required .chain_option {
	background-color: <?php echo index_value($chain_settings, 'chain_style_options_color_unselected');?>;
}

#chain_container .flex-direction-nav a {
	background-image: url('catalog/view/theme/default/image/c_arrows.png'); 
	background-color: <?php echo index_value($chain_settings, 'chain_slider_arrows_background');?>; 
	background-position: <?php echo index_value($chain_settings, 'chain_slider_arrows_color_left');?>;
	background-repeat: no-repeat;
	border-color: <?php echo index_value($chain_settings, 'chain_slider_arrows_background');?>;
	border-style: solid;
	border-bottom-width: <?php echo index_value($chain_settings, 'chain_slider_arrows_border_top');?>px; 
	border-top-width: <?php echo index_value($chain_settings, 'chain_slider_arrows_border_bottom');?>px;
}
#chain_container .flex-direction-nav .flex-next {
	background-position: <?php echo index_value($chain_settings, 'chain_slider_arrows_color_right');?>; 
}

.chain_style_single_container {
	border-style: solid;
	border-color: <?php echo index_value($chain_settings, 'chain_style_border_color');?>;
	border-width: <?php echo index_value($chain_settings, 'chain_style_border_width');?>px;
	border-radius: <?php echo index_value($chain_settings, 'chain_style_border_radius');?>px;
	border-radius: <?php echo index_value($chain_settings, 'chain_style_border_radius');?>px;
	padding-top: <?php echo index_value($chain_settings, 'chain_style_container_padding_top');?>px;
	padding-left: <?php echo index_value($chain_settings, 'chain_style_container_padding_left');?>px;
	padding-right: <?php echo index_value($chain_settings, 'chain_style_container_padding_right');?>px;
	padding-bottom: <?php echo index_value($chain_settings, 'chain_style_container_padding_bottom');?>px;
	margin-top: <?php echo index_value($chain_settings, 'chain_style_container_margin_top');?>px;
	margin-bottom: <?php echo index_value($chain_settings, 'chain_style_container_margin_bottom');?>px;
}

.chain_style_single_container_header {
	color: <?php echo index_value($chain_settings, 'chain_style_header_color');?>;
	font-size: <?php echo index_value($chain_settings, 'chain_style_header_fontsize');?>;
	line-height: <?php echo index_value($chain_settings, 'chain_style_header_line_height');?>;
	padding-left: <?php echo index_value($chain_settings, 'chain_style_header_padding_left');?>px;
}

<?php echo index_value($chain_settings, 'chain_style_extra_css');?>
</style>

<? /* MAIN TPL FOR CHAIN */ ?>
<div id="together">
		<?php if (index_value($chain_settings, 'chain_style') == 'classic') { ?>
			<h2 class="relatedhead green" style=""><?php echo $heading_title; ?></h2>
				<div class="box-content">
		<?php } elseif (index_value($chain_settings, 'chain_style') == 'user_style') { ?>
			<div class="chain_style_single_container">
			<?php if (index_value($chain_settings, 'chain_style_header_show')) { ?>
				<div class="chain_style_single_container_header"><?php echo $heading_title; ?></div>
			<?php } ?>
		<?php } ?>

		<div class="flexslider-chain">
			<ul id="chain-ul" class="slides">
				<?php foreach($products as $chain_id => $chain) : ?>
					<li id="chain<?php echo $chain_id; ?>">
						<input type="hidden" name="chain_id" value="<?php echo $chain_id; ?>">
						
						<div class="box-products">
							<div class="carousel-inner" style="overflow:hidden;margin-top:25px;">
								<p class="save_line"><?php echo $text_together_save; ?></p>
								<div class="container">
									<!-- chain products -->
									<?php foreach($chain as $key => $product) : ?>
										
											<div class="chain-item together-block col-xs-3" id="chain-item<?php echo $product['product_id']; ?>" item-name="<?php echo $product['name']; ?>">
												
												<input type="hidden" value="<?php echo $product['product_id']; ?>" name="chain_product_id[<?php echo $product['product_id']; ?>]">
												<input type="hidden" value="<?php echo $product['product_quantity']; ?>" name="chain_quantity[<?php echo $product['product_id']; ?>]">
												
												<div class="item-block col-xs-7 text-center">
													<?php if ($product['you_save'] > 0 && index_value($chain_settings, 'chain_display_discount_percent')) { ?>
														<div class="chain_you_save">
															<span>-<?php echo $product['you_save']; ?></span>%
														</div>
													<?php } ?>
													
													<?php if ($product['product_quantity'] > 1) { ?>
														<div class="chain_product_quantity" title="<?php printf($text_quantity, $product['product_quantity']); ?>">
															<?php echo $product['product_quantity']; ?>x
														</div>
													<?php } ?> 
													
													<!--options-->
													<?php if (!empty($product['options'])) { ?>
															<a title="<?php echo $text_options; ?>" data-chain_id="<?php echo $chain_id; ?>" data-id="<?php echo $product['product_id']; ?>" class="chain_option"></a>
													<?php } ?>
													
													<?php if ($product['options']) { ?>
														<div class="container_for_chan_options" id="chain_options_list<?php echo $product['product_id']; ?>" style="display: none;">
														<div class="chain_options_list" data-id="<?php echo $product['product_id']; ?>" data-chain_id="<?php echo $chain_id; ?>">
														<div class="chain_options_header attention">
														
															<?php  
															
																if (mb_strlen($product['name'], 'utf-8') < index_value($chain_settings, 'chain_options_title_lenght')) { 
																	$product_title = '<span class="chain_options_header_product_name">'.$product['name'].'</span>'; 
																} else { 
																	$product_title = '<span class="chain_options_header_product_name">'. mb_substr($product['name'], 0, index_value($chain_settings, 'chain_options_title_lenght'), 'utf-8') . '</span>...'; 
																}; 
																printf($text_select_options, $product_title);
															?>
														</div>
														<?php if (index_value($chain_settings, 'chain_options_show_image') && $product['popup']) { ?>
															<div class="image"><img src="<?php echo $product['popup']; ?>" alt="<?php echo $product['name']; ?>" ></div>
														<?php } ?>
														
														<?php foreach ($product['options'] as $option) { 
															$p_id = $product['product_id'];
															include $option_tpl;
															unset($p_id);
														 } ?>
														
														<?php /*
														<div style="text-align: center; display: none;">
															<a class="button chain_options_save" data-chain_id="<?php echo $chain_id; ?>" data-product_id="<?php echo $product['product_id']; ?>">Save</a>
														</div>
														*/ ?>
														
														</div>
														</div>
													<?php } ?>
													<!--/options-->

													<?php if ($product['thumb']) : ?>
														<div class="image">
															<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
														</div>
													<?php endif; ?>
													<?php if ($product['rating']) : ?>
														<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
													<?php else : ?>
														<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
													<?php endif; ?>
													<div class="name">
														<a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
													</div>
													<?php if ($product['price_string']) { ?>
														<div class="price">
															<?php if ($product['combo_price'] == $product['full_price_with_tax']) { ?>
																<?php if ($product['special']) { ?>
																	<span class="price-old">
																		<?php echo $product['price_string']; ?><br />
																	</span>
																	<?php echo $product['special_price_string']; ?>
																<?php } else { ?>
																	<?php echo $product['price_string']; ?>
																<?php } ?>
															<?php } else { ?>
																<?php if (index_value($chain_settings, 'chain_display_old_price') && $product['combo_price'] < $product['full_price_with_tax']) { ?>
																	<span class="price-old">
																		<?php echo $product['price_string']; ?><br />
																	</span>
																<?php } ?>
																<?php if ($product['combo_price'] > 0) { ?>
																	<span class="price-new">
																		 <?php echo $product['combo_price_string']; ?>
																	</span>
																<?php } else { ?>
																	<span class="price-free">
																		 <?php echo $text_free; ?>
																	</span>
																<?php } ?>
																
															<?php } ?>
														</div>
													<?php } ?>
													<!-- <p class="price">
														<?php if($value['special']) { echo $value['special']; } else { echo $value['price']; } ?>
													</p> -->
												</div>
												<div class="symbol col-xs-5">
													<?php 
														if ($key == count($chain)) {
															echo '=';
														} else { echo '+'; }
													?>
												</div>
											
											</div><!-- / .chain-item -->
										
									<?php endforeach; ?>
									<!--/ chain products -->
									<div class="total col-xs-3">
										<div class="price-total"><?php echo $total_price[$chain_id]; ?></div>
										<div class="cart" style="width:auto !important;"><a href="javascript:void(0);" id="button-cart" class="add_cart cart-single btn btn-lg btn-success" onclick="addChainToCart('<?php echo $chain_id; ?>')"><span class="fa fa-shopping-cart"></span>Add to Cart</a></div>
										<?php if (index_value($chain_settings, 'chain_display_you_save')) { ?>
											<div class="save text-center"><?php echo $text_total_save.' '.$total_save[$chain_id]; ?></span></div>
										<?php } ?>
										<div class="save text-center"><?php echo $text_save_single; ?></div>
									</div>
								</div>
							</div>
						</div>
					</li>
				<?php endforeach; ?>
			</ul>
		</div>
	</div>	
</div>	