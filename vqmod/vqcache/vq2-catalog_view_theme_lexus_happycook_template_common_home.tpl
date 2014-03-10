<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); 
?>
<?php echo $header; ?>

<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-sm-<?php echo $SPAN[0];?> col-xs-12">
		<?php echo $column_left; ?>
	</aside>
<?php endif; ?>
		
<section class="col-lg-<?php echo $SPAN[1];?> col-sm-<?php echo $SPAN[1];?> col-xs-12">         
	<div id="content">
	<?php echo $content_top; ?>
	<h1 style="display: none;"><?php echo $heading_title; ?></h1>
	<?php echo $content_bottom; ?>
	</div>
</section>
	
<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>
	

		<?php if ($website['total']) { ?>
			<div style="position:absolute; top: -100000px;">
				<div itemscope itemtype="http://schema.org/LocalBusiness">
					<span itemprop="name"><?php echo $website['company']; ?></span></h1>
					<span itemprop="description"></span>
					<div itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
						<span itemprop="streetAddress"><?php echo $website['address']; ?></span>
						<span itemprop="addressLocality"><?php echo $website['city']; ?></span>
						<span itemprop="addressRegion"><?php echo $website['state']; ?></span>
						<span itemprop="postalCode"><?php echo $website['postal_code']; ?></span>
					</div>
					<span itemprop="telephone"><?php echo $website['telephone']; ?></span>
					<div itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
						<meta itemprop="worstRating" content="1">
						<meta itemprop="bestRating" content="5">
						<meta itemprop="ratingValue" content="<?php echo $website['rating']; ?>">
						<meta itemprop="reviewCount" content="<?php echo $website['total']; ?>">
					</div>
				</div>
				<a itemprop="url" href="<?php echo $website['website']; ?>"></a>
				<?php if ($this->config->get('testimonial_display_price')) { ?>
				<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer-aggregate">
					<span itemprop="lowPrice"><?php echo $website['price_from']; ?></span>
					<span itemprop="highPrice"><?php echo $website['price_to']; ?></span>
					<meta itemprop="currency" content="<?php echo $this->currency->getCode(); ?>" />
				</span>
				<?php } ?>
			</div>
		<?php } ?>			
			
<?php echo $footer; ?>