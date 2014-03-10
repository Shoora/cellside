<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <style>
  <?php echo html_entity_decode($this->config->get('config_product_reviews_page_css'), ENT_QUOTES, 'UTF-8'); ?>
  </style>
  <?php if ($reviews) { ?>
  <div class="product-filter">
    <div class="display"></div>
    <div class="limit"><?php echo $text_limit; ?>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    <div class="sort"><?php echo $text_sort; ?>
      <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
  </div>
  <div class="product-compare"></div>
  <div class="product-list all_review">
    <?php foreach ($reviews as $review) { ?>
    <div>
	  <div class="all_review_right">
	    <ul>
	      <?php if ($review['ratings']) { ?>
		  <?php foreach ($review['ratings'] as $rating) { ?>
		  <li><?php echo $rating['name']; ?><img src="image/product_review/stars-<?php echo $this->config->get('config_product_reviews_appearance_customer_rating'); ?>-<?php echo $rating['rating']; ?>.png" alt="<?php echo $rating['rating']; ?>" /></li>
		  <?php } ?>
		  <?php } else { ?>
		  <li><img src="image/product_review/stars-<?php echo $this->config->get('config_product_reviews_appearance_customer_rating'); ?>-<?php echo $review['rating']; ?>.png" alt="<?php echo $review['rating']; ?>" /></li>
		  <?php } ?>
	    </ul>
	  </div>
	  <div class="all_review_left">
	    <div class="author"><?php echo $review['author']; ?> <span class="date"><?php echo $review['date']; ?></span></div>
        <div class="description"><?php echo $review['text']; ?></div>
	    <a href="<?php echo $review['href']; ?>"><?php echo $review['product']; ?></a>
	  </div>
    </div>
    <?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php }?>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>