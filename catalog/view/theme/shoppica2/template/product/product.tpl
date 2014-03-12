<?php echo $header; ?>
  
  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="s_wrap">
        <div id="breadcrumbs" class="s_col_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content" class="s_wrap">

    <?php if ($tbData->common['column_position'] == "left" && $column_right): ?>
    <div id="left_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="product_page" class="s_main_col">

      <?php echo $content_top; ?>

      <span class="clear"></span>

      <div id="product" itemscope itemtype="http://data-vocabulary.org/Product">
        <meta itemprop="name" content="<?php echo $heading_title; ?>" />

        <?php $tbSlot->start('product\product.product_images', array('data' => $this->data)); ?>
        <div id="product_images">
          <div id="product_image_preview_holder" class="clearfix">
            <?php if ($tbData->common['product_gallery_type'] == 'prettyphoto'): ?>
            <a id="product_image_preview" class="clearfix" rel="prettyPhoto[gallery]" href="<?php echo $popup; ?>">
              <img id="image" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image" />
            </a>
            <?php endif; ?>
            <?php if ($tbData->common['product_gallery_type'] == 'cloudzoom'): ?>
            <a id="product_image_preview" class="cloud-zoom clearfix" rel="showTitle: false, <?php if ($tbData->common['product_zoom_position'] == 'inside'): ?>position: 'inside', adjustX: -2, adjustY: -2<?php else: ?><?php if ($tbData->common['language_direction'] == 'ltr'): ?>position: 'right', adjustX: 20<?php else: ?>position: 'left', adjustX: -20<?php endif; ?>, adjustY: -2<?php endif; ?>" href="<?php echo $popup; ?>">
              <img id="image" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" itemprop="image" />
            </a>
            <?php endif; ?>
          </div>
          <?php if ($images && $tbData->common['product_gallery_position'] == 'under_preview'): ?>
          <div id="product_gallery">
            <ul class="s_thumbs clearfix">
              <?php if ($tbData->common['product_gallery_type'] == 'prettyphoto'): ?>
              <?php foreach ($images as $image): ?>
              <li>
                <a class="s_thumb" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" rel="prettyPhoto[gallery]">
                  <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                </a>
              </li>
              <?php endforeach; ?>
              <?php endif; ?>
              <?php if ($tbData->common['product_gallery_type'] == 'cloudzoom'): ?>
              <li>
                <a class="s_thumb cloud-zoom-gallery" rel="useZoom: 'product_image_preview', smallImage: '<?php echo $popup; ?>'" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>">
                  <img src="<?php echo $thumb; ?>" width="<?php echo $this->config->get('config_image_additional_width'); ?>" height="<?php echo $this->config->get('config_image_additional_height'); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                </a>
              </li>
              <?php foreach ($images as $image): ?>
              <li>
                <a class="s_thumb cloud-zoom-gallery" rel="useZoom: 'product_image_preview', smallImage: '<?php echo $image['popup']; ?>'" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>">
                  <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                </a>
              </li>
              <?php endforeach; ?>
              <?php endif; ?>
            </ul>
          </div>
          <?php endif; ?>
        </div>
        <?php $tbSlot->stop(); ?>

        <?php $tbSlot->start('product\product.product_price', array('data' => $this->data)); ?>
        <?php if ($price): ?>
        <div id="product_price" class="s_price_holder s_size_4 s_label">
          <?php if (!$special): ?>
          <p class="s_price" itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
            <meta itemprop="currency" content="<?php echo $this->currency->getCode(); ?>" />
            <span itemprop="price">
            <?php echo $tbData->priceFormat($price); ?>
            </span>
          </p>
          <?php else: ?>
          <p class="s_price s_promo_price" itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
            <meta itemprop="currency" content="<?php echo $this->currency->getCode(); ?>" />
            <span class="s_old_price"><?php echo $tbData->priceFormat($price); ?></span>
            <span itemprop="price">
            <?php echo $tbData->priceFormat($special); ?>
            </span>
          </p>
          <?php endif; ?>
          <?php if ($tax): ?>
          <p class="s_price_tax"><?php echo $text_tax; ?> <?php echo $tax; ?></p>
          <?php endif; ?>
          <?php if ($points): ?>
          <p class="s_reward_points"><small><?php echo $text_points; ?> <?php echo $points; ?></small></p>
          <?php endif; ?>
        </div>
        <?php endif; ?>
        <?php $tbSlot->stop(); ?>

        <?php $tbSlot->start('product\product.product_info', array('data' => $this->data)); ?>
        <div id="product_info">

          <dl class="clearfix">
            <dt><?php echo $text_stock; ?></dt>
            <dd itemprop="availability" content="<?php echo strtolower(str_replace(' ', '_', $stock)); ?>"><?php echo $stock; ?></dd>
            <dt><?php echo $text_model; ?></dt>
            <dd><?php echo $model; ?></dd>
            <?php if ($reward): ?>
            <dt><?php echo $text_reward; ?></dt>
            <dd><?php echo $reward; ?></dd>
            <?php endif; ?>
            <?php if ($tbData->common['manufacturers_enabled'] && $manufacturer): ?>
            <dt><?php echo $text_manufacturer; ?></dt>
            <dd itemprop="brand"><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></dd>
            <?php endif; ?>
          </dl>

          <?php if ($review_status || $tbData->common['product_social_share_enabled']): ?>
          <div id="product_share" class="clearfix">
            <?php if ($review_status): ?>
            <?php if ($rating): ?>
            <div class="s_rating_holder" itemscope itemtype="http://data-vocabulary.org/Review-aggregate">
              <meta itemprop="name" content="<?php echo $heading_title; ?>" />
              <img itemprop="photo" class="none" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
              <p class="s_rating s_rating_5"><span style="width: <?php echo $rating * 2 ; ?>0%;" class="s_percent"></span></p>
              <span class="s_average" itemprop="rating" itemscope itemtype="http://data-vocabulary.org/Rating">
                <span itemprop="average"><?php echo $rating; ?></span>/<span itemprop="best">5</span>
              </span>
              <span class="s_total">(<a class="s_999" href="<?php echo $tbData->current_url; ?>#product_tabs"><span itemprop="count"><?php echo $reviews; ?></span></a>)</span>
              <br />
              <a class="s_review_write s_icon_10 s_main_color" href="<?php echo $tbData->current_url; ?>#product_tabs"><span class="s_icon s_main_color_bgr"></span> <?php echo $text_write; ?></a>
            </div>
            <?php else: ?>
            <div class="s_rating_holder">
              <p class="s_rating s_rating_5 s_rating_blank"></p>
              <span class="s_average"><span class="s_total"><?php echo $tbData->text_product_not_yet_rated; ?></span></span>
              <br />
              <a class="s_review_write s_icon_10 s_main_color" href="<?php echo $tbData->current_url; ?>#product_tabs"><span class="s_icon s_main_color_bgr"></span> <?php echo $text_write; ?></a>
            </div>
            <?php endif; ?>
            <?php endif; ?>
            <?php if ($tbData->common['product_social_share_enabled']): ?>
            <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style ">
              <script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://apis.google.com/js/plusone.js"></script>
              <div class="s_plusone"><g:plusone size="medium"></g:plusone></div>
              <a class="addthis_button_tweet"></a>
              <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
            </div>
            <script type="text/javascript" src="http<?php if($tbData->isHTTPS) echo 's'?>://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4e20919036eba525"></script>
            <!-- AddThis Button END -->
            <?php endif; ?>
          </div>
          <?php endif; ?>


        <?php if ($tbData->right_column_empty): ?>
        </div>
        <div id="product_buy_col">
        <?php endif; ?>

          <?php if ($price && ($tbData->common['checkout_enabled'] || $tbData->common['wishlist_enabled'] || $tbData->common['compare_enabled'])): ?>
          <form id="product_add_to_cart_form">

            <?php $tbSlot->start('product\product.product_options', array('data' => $this->data)); ?>
            <?php if ($options) require TB_Utils::vqmodCheck('catalog/view/theme/' . $this->config->get('config_template') . '/template/product/product_options.tpl'); ?>
            <?php $tbSlot->stop(); ?>

            <?php if ($price && $discounts): ?>
            <div id="product_discounts">
              <h3><?php echo $tbData->text_product_discount; ?></h3>
              <table width="100%" class="s_table" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <th><?php echo $tbData->text_product_order_quantity; ?></th>
                  <th><?php echo $tbData->text_product_price_per_item; ?></th>
                </tr>
                <?php foreach ($discounts as $discount): ?>
                <tr>
                  <td><?php echo sprintf($tbData->text_product_discount_items, $discount['quantity']); ?></td>
                  <td><?php echo $discount['price']; ?></td>
                </tr>
                <?php endforeach; ?>
              </table>
            </div>
            <?php endif; ?>

            <div id="product_buy" class="clearfix">
              <?php if ($tbData->common['checkout_enabled']): ?>
              <label for="product_buy_quantity"><?php echo $text_qty; ?></label>
              <input id="product_buy_quantity" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
              <a id="add_to_cart" class="s_button_1 s_main_color_bgr">
                <span class="s_text s_icon_24"><span class="s_icon"></span> <?php echo $button_cart; ?></span>
              </a>
              <?php endif; ?>

              <?php if ($minimum > 1): ?>
              <p class="s_purchase_info"><?php echo $text_minimum; ?></p>
              <?php endif; ?>

              <span class="clear"></span>

              <p class="s_actions">
                <?php if ($tbData->common['wishlist_enabled']): ?>
                <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $product_id; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_wishlist; ?></a>
                <?php endif; ?>
                <?php if ($tbData->common['compare_enabled']): ?>
                <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $product_id; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_compare; ?></a>
                <?php endif; ?>
              </p>
            </div>

            <?php if ($tbData->common['checkout_enabled']): ?>
            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
            <?php endif; ?>
          </form>
          <?php endif; ?>

        </div>
        <?php $tbSlot->stop(); ?>

        <?php $tbSlot->start('product\product.product_tabs', array('data' => $this->data)); ?>
        <div id="product_tabs" class="clear"></div>

        <?php
        $tabs_num = 1;
        if ($attribute_groups) $tabs_num++;
        if ($review_status) $tabs_num++;
        if ($images && $tbData->common['product_gallery_position'] == 'tab') $tabs_num++;
        ?>

        <div class="s_tabs">
          <?php if ($tabs_num > 1): ?>
          <ul class="s_tabs_nav s_<?php echo $tabs_num ?>col_wrap clearfix">
            <li class="s_1_<?php echo $tabs_num ?>"><a href="#product_description"><?php echo $tab_description; ?></a></li>
            <?php if ($attribute_groups): ?>
            <li class="s_1_<?php echo $tabs_num ?>"><a href="#product_attributes"><?php echo $tab_attribute; ?></a></li>
            <?php endif; ?>
            <?php if ($review_status): ?>
            <li class="s_1_<?php echo $tabs_num ?>"><a href="#product_reviews"><?php echo $tab_review; ?></a></li>
            <?php endif; ?>
            <?php if ($images && $tbData->common['product_gallery_position'] == 'tab'): ?>
            <li class="s_1_<?php echo $tabs_num ?>"><a href="#product_gallery"><?php echo $tbData->text_product_tab_images; ?> (<?php echo count($images); ?>)</a></li>
            <?php endif; ?>
          </ul>
          <?php endif; ?>

          <div class="s_tab_box">
            <h2 class="s_head"><?php echo $tab_description; ?></h2>
            <div id="product_description" itemprop="description"><?php echo $description; ?></div>

            <?php if ($attribute_groups): ?>
            <h2 class="s_head"><?php echo $tab_attribute; ?></h2>
            <div id="product_attributes">
              <table class="s_table_1" width="100%" cellpadding="0" cellspacing="0" border="0">
                <?php foreach ($attribute_groups as $attribute_group): ?>
                <thead>
                  <tr>
                    <th colspan="2"><?php echo $attribute_group['name']; ?></th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute): ?>
                  <tr>
                    <td width="30%"><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php endforeach; ?>
                </tbody>
                <?php endforeach; ?>
              </table>
            </div>
            <?php endif; ?>

            <?php if ($review_status): ?>
            <h2 class="s_head"><?php echo $tab_review; ?></h2>
            <div id="product_reviews">
              <div id="review" class="s_listing"></div>
              <h2 class="s_title_1"><span><?php echo $text_write; ?></span></h2>
              <div id="review_title" class="clear"></div>
              <div class="s_row_3 s_1_3 clearfix">
                <label><strong><?php echo $entry_name; ?></strong></label>
                <div class="s_full">
                  <input type="text" name="name" value="" />
                </div>
              </div>
              <div class="s_row_3 clearfix">
                <label><strong><?php echo $entry_review; ?></strong></label>
                <div class="s_full">
                  <textarea name="text" rows="8"></textarea>
                  <p class="s_legend"><?php echo $text_note; ?></p>
                </div>
              </div>
              <div class="s_row_3 clearfix">
                <label><strong><?php echo $entry_rating; ?></strong></label>
                <span class="clear"></span>
                <span><?php echo $entry_bad; ?></span>&nbsp;
                <input type="radio" name="rating" value="1" />
                &nbsp;
                <input type="radio" name="rating" value="2" />
                &nbsp;
                <input type="radio" name="rating" value="3" />
                &nbsp;
                <input type="radio" name="rating" value="4" />
                &nbsp;
                <input type="radio" name="rating" value="5" />
                &nbsp; <span><?php echo $entry_good; ?></span>
              </div>
              <div class="s_row_3 clearfix">
                <label><strong><?php echo $entry_captcha; ?></strong></label>
                <input type="text" name="captcha" value="" autocomplete="off" />
                <span class="clear"></span>
                <br />
                <img src="index.php?route=product/product/captcha" id="captcha" />
              </div>
              <span class="clear border_ddd"></span>
              <br />
              <a onclick="review();" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
              <span class="clear"></span>
            </div>
            <?php endif; ?>

            <?php if ($images && $tbData->common['product_gallery_position'] == 'tab'): ?>
            <h2 class="s_head"><?php echo $tbData->text_product_tab_images; ?> (<?php echo count($images); ?>)</h2>
            <div id="product_gallery">
              <ul class="s_thumbs clearfix">
                <?php if ($tbData->common['product_gallery_type'] == 'prettyphoto'): ?>
                <?php foreach ($images as $image): ?>
                <li>
                  <a class="s_thumb" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" rel="prettyPhoto[gallery]">
                    <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                  </a>
                </li>
                <?php endforeach; ?>
                <?php endif; ?>
                <?php if ($tbData->common['product_gallery_type'] == 'cloudzoom'): ?>
                <li>
                  <a class="s_thumb cloud-zoom-gallery" rel="useZoom: 'product_image_preview', smallImage: '<?php echo $popup; ?>'" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>">
                    <img src="<?php echo $thumb; ?>" width="<?php echo $this->config->get('config_image_additional_width'); ?>" height="<?php echo $this->config->get('config_image_additional_height'); ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                  </a>
                </li>
                <?php foreach ($images as $image): ?>
                <li>
                  <a class="s_thumb cloud-zoom-gallery" rel="useZoom: 'product_image_preview', smallImage: '<?php echo $image['popup']; ?>'" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>">
                    <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                  </a>
                </li>
                <?php endforeach; ?>
                <?php endif; ?>
              </ul>
            </div>
            <?php endif; ?>
          </div>

        </div>
        <?php $tbSlot->stop(); ?>

        <?php $products = $tbSlot->filter('product\product.filter_related_products', $products, array('data' => $this->data)); ?>
        <?php $tbSlot->start('product\product.related_products_listing', array('products' => $products, 'data' => $this->data)); ?>
        <?php if ($products): ?>
        <div id="related_products">
          <h2 class="s_title_1"><span><?php echo $tab_related; ?></span></h2>
          <div class="s_listing s_grid_view <?php echo $tbData->common['products_per_row']; ?> clearfix">
            <?php foreach ($products as $product): ?>
            <?php $tbSlot->start('product\product.related_products.each', array('products' => $products, 'product' => $product, 'data' => $this->data)); ?>
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
          </div>
        </div>
        <?php endif; ?>
        <?php $tbSlot->stop(); ?>


        <?php $tbSlot->start('product\product.product_tags', array('data' => $this->data)); ?>
        <?php if ($tags): ?>
        <div class="clear"></div>

        <div id="product_tags">
          <h2 class="s_title_1"><span><?php echo $text_tags; ?></span></h2>
          <ul class="clearfix">
            <?php foreach ($tags as $tag): ?>
            <li><a href="<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?></a></li>
            <?php endforeach; ?>
          </ul>
        </div>
        <?php endif; ?>
        <?php $tbSlot->stop(); ?>

      </div>

      <span class="clear"></span>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($tbData->common['column_position'] == "right" && $column_right): ?>
    <div id="right_col" class="s_side_col">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <?php if ($tbData->is_mobile == '0'): ?>

    <?php if ($tbData->common['product_gallery_type'] == 'prettyphoto'): ?>
    <link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_javascript_url; ?>prettyphoto/css/prettyPhoto.css" media="all" />
    <script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>prettyphoto/js/jquery.prettyPhoto.js"></script>
    <?php endif; ?>

    <?php if ($tbData->common['product_gallery_type'] == 'cloudzoom'): ?>
    <link rel="stylesheet" type="text/css" href="<?php echo $tbData->theme_javascript_url; ?>cloudzoom/css/jquery.cloud-zoom.css" media="all" />
    <script type="text/javascript" src="<?php echo $tbData->theme_javascript_url; ?>cloudzoom/js/jquery.cloud-zoom.min.js"></script>
    <?php endif; ?>

    <?php endif; ?>


    <script type="text/javascript">

    jQuery( function($) {

      function set_product_info() {
        var w = $("html").width();
        if (w < 768) {
          $(".s_tabs").tabs("destroy");
          $(".s_tab_box").accordion ({
            autoHeight:         false,
            collapsible:        true,
            active:             false
          });
        }
        else {
          $(".s_tab_box").accordion("destroy");
          $(".s_tabs").tabs({ fx: { opacity: 'toggle', duration: 300 } });
        }
      }

      set_product_info();

      <?php if ($tbData->is_mobile == '0'): ?>

      $(window).resize(function() {
        set_product_info();
      });

      <?php if ($tbData->common['product_gallery_type'] == 'prettyphoto'): ?>
      $("#product_images a[rel^='prettyPhoto'], #product_gallery a[rel^='prettyPhoto']").prettyPhoto({
        theme: 'light_square',
        opacity: 0.5,
        deeplinking: false,
        ie6_fallback: false,
        social_tools: ''
      });
      <?php endif; ?>

      <?php else: ?>

      $("#product_images a.s_thumb").bind("click", function() {
        $("#product_image_preview > img").attr("src", ($(this).attr("href")));
        return false;
      });

      <?php endif; ?>

      <?php if ($review_status): ?>
      $(".s_review_write, .s_total a").bind("click", function() {
        $('.s_tabs').tabs('select', '#product_reviews');
      });

      $('#review .pagination a').live('click', function() {
        $('#review').slideUp('slow');
        $('#review').load(this.href);
        $('#review').slideDown('slow');

        return false;
      });

      $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
      <?php endif; ?>

    });
    <?php if ($review_status): ?>
    function review() {
      $.ajax({
        type: 'POST',
        url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
        dataType: 'json',
        data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
        beforeSend: function() {
          $('#review_button').attr('disabled', 'disabled');
          $('#review_title').after('<div class="wait"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
        },
        complete: function() {
          $('#review_button').attr('disabled', '');
          $('.iF').remove();
        },
        success: function(data) {
          if (data.error) {
            simpleNotice('Error!', data.error, 'failure');
          }

          if (data.success) {
            simpleNotice('Success!', data.success, 'success');

            $('input[name=\'name\']').val('');
            $('textarea[name=\'text\']').val('');
            $('input[name=\'rating\']:checked').attr('checked', '');
            $('input[name=\'captcha\']').val('');
          }
        }
      });
    }
    <?php endif; ?>
    <?php if ($tbData->common['checkout_enabled']): ?>
    $('#add_to_cart').bind('click', function() {
      $.ajax({
        url: 'index.php?route=tb/cartCallback',
        type: 'post',
        data: $('#product_add_to_cart_form input[type=\'text\'], #product_add_to_cart_form input[type=\'hidden\'], #product_add_to_cart_form input[type=\'radio\']:checked, #product_add_to_cart_form input[type=\'checkbox\']:checked, #product_add_to_cart_form select, #product_add_to_cart_form textarea'),
        dataType: 'json',
        success: function(json) {
          $("#product_info p.s_error_msg").remove();

          if (json['error']) {
            if (json['error']['warning']) {
              productNotice(json['title'], json['thumb'], json['error']['warning'], 'failure');
              $('.warning').fadeIn('slow');
            }

            for (i in json['error']) {
              $('#option-' + i).append('<p class="s_error_msg">' + json['error'][i] + '</p>');
            }
          }

          if (json['success']) {
            productNotice(json['title'], json['thumb'], json['success'], 'success');
            $('#cart_menu span.s_grand_total').html(json['total_sum']);
            <?php if ($tbData->is_mobile == '0'): ?>
            $('#cart_menu div.s_cart_holder').html(json['html']);
            <?php endif; ?>
          }
        }
      });

      return false;
    });
    <?php endif; ?>
    </script>

  </div>
  <!-- end of content -->

<?php echo $footer; ?>