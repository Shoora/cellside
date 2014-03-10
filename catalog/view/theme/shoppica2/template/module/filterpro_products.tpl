        <?php foreach ($products as $product): ?>
        <?php $tbSlot->start('product\category.products.each', array('products' => $products, 'product' => $product, 'data' => $this->data)); ?>
        <div class="s_item product_<?php echo $product['product_id']; ?>">
          <a class="s_thumb" href="<?php echo $product['href']; ?>">
            <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
          </a>
          <div class="s_item_info">
            <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
            <?php if ($product['price']): ?>
            <div class="s_price_holder s_size_<?php echo $tbData->common['price_size']; ?> <?php echo 's_' . $tbData->common['price_design']; ?>">
              <?php if (!$product['special']): ?>
              <p class="s_price"><?php echo $tbData->priceFormat($product['price']); ?></p>
              <?php else: ?>
              <p class="s_price s_promo_price"><span class="s_old_price"><?php echo $tbData->priceFormat($product['price']); ?></span><?php echo $tbData->priceFormat($product['special']); ?></p>
              <?php endif ?>
            </div>
            <?php endif; ?>
            <p class="s_description"><?php echo utf8_substr($product['description'], 0, 250); ?>...</p>
            <?php if ($product['rating']): ?>
            <p class="s_rating s_rating_5">
              <span style="width: <?php echo $product['rating'] * 2 ; ?>0%;" class="s_percent"></span>
            </p>
            <?php endif; ?>
            <?php if ($tbData->common['checkout_enabled'] || $tbData->common['wishlist_enabled'] || $tbData->common['compare_enabled']): ?>
            <div class="s_actions">
              <?php if ($product['price']): ?>
              <?php if ($tbData->common['checkout_enabled']): ?>
              <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $product['product_id']; ?>');">
                <span class="s_icon_16"><span class="s_icon"></span><?php echo $button_cart; ?></span>
              </a>
              <?php endif; ?>
              <?php endif; ?>
              <?php if ($tbData->common['wishlist_enabled']): ?>
              <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $product['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $tbData->text_wishlist; ?></a>
              <?php endif; ?>
              <?php if ($tbData->common['compare_enabled']): ?>
              <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $product['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $tbData->text_compare; ?></a>
              <?php endif; ?>
            </div>
            <?php endif; ?>
          </div>
        </div>
        <?php $tbSlot->stop(); ?>
        <?php endforeach; ?>