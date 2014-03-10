<?php 
	/******************************************************
	 * @package Pav Megamenu module for Opencart 1.5.x
	 * @version 1.1
	 * @author http://www.pavothemes.com
	 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
	 * @license		GNU General Public License version 2
	*******************************************************/

	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$themeConfig = $this->config->get('themecontrol');
	$themeName =  $this->config->get('config_template');
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );  
?>
</div></div></section>



<section id="footer">
	<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_top' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_top'])&& $themeConfig['block_footer_top']?(int)$themeConfig['block_footer_top']:count($modules);
	//if( $cols < count($modules) ){ $cols = count($modules); }
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-top">
		<div class="container">
			<div class="row">
				<div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
					<?php echo $modules[0]; ?>
				</div>
				<div class="col-xs-6 col-sm-6 col-md-3 col-lg-3">
					<div class="box pav-block gallerylastest">
						<h2 class="h2head"><span class="dot" style="background-color:#ededed !important;">Gallery</span><span class="divider"></span><a href="#" class="blg-vw-all">View All</a></h2>
						<div class="pavblog-latest clearfix">
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
							<div class="col-xs-6 col-sm-6 col-md-6 col-lg-6"><a class="gallery" rel="gal" href="catalog/view/theme/<?php echo $themeName;?>/image/sample2.png"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sample3.png" alt=""></a></div>
						</div>
					</div>
				</div>	
				<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
					<?php echo $modules[1]; ?>
				</div>
			</div>
			
		</div>
	</div>
	<?php } ?>
	<?php
	/**
	 * Footer Center Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_center' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_center'])&& $themeConfig['block_footer_center']?(int)$themeConfig['block_footer_center']:count($modules);
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-center">
		<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
				<div class="col-lg-12 col-md-12"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>	
		</div>
	</div>
<?php } elseif((isset($themeConfig['enable_footer_center'])&&$themeConfig['enable_footer_center'])) { ?>
<div class="footer-center">

		<div class="container"><div class="row">
		  <?php if ($informations) { ?>
			<div class="column col-xs-12 col-sm-6 col-lg-2">
				<div class="box">
					<div class="box-heading"><span><?php echo $text_information; ?></span></div>
					<ul class="list">
					  <?php foreach ($informations as $information) { ?>
					  <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
					  <?php } ?>
					</ul>
				</div>
			</div>
		  <?php } ?>
		  
		<div class="column col-xs-12 col-sm-6 col-lg-2">
			<div class="box">
				<div class="box-heading"><span><?php echo $text_service; ?></span></div>
				<ul class="list">
				  <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
				  <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
				  <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
				   <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
				  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
				</ul>
			</div>
		</div>
		  
		<div class="column col-xs-12 col-sm-6 col-lg-2">
			<div class="box">
			<div class="box-heading"><span><?php echo $text_extra; ?></span></div>
			<ul class="list">
			  <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
			  <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
			  <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
			  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
			</ul>
		  </div>
		</div>
		  
		<div class="column col-xs-12 col-sm-6 col-lg-2">
			<div class="box">
				<div class="box-heading"><span><?php echo $text_account; ?></span></div>
				<ul class="list">
				  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
				  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
				  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
				  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
				  <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
				</ul>
			</div>
		</div>
		  
		<?php if( isset($themeConfig['widget_contact_data'][$LANGUAGE_ID]) ) {

		 ?>
		<div class="column col-xs-12 col-sm-6 col-lg-4">
			<div class="box contact-us">
				<div class="box-heading"><span><?php echo $this->language->get('text_contact_us'); ?></span></div>
				<?php echo html_entity_decode( $themeConfig['widget_contact_data'][$LANGUAGE_ID], ENT_QUOTES, 'UTF-8' ); ?>
		</div>
		</div>
		 <?php } ?>

		 </div> 
	</div></div>
<?php  } ?>	

	<div class="bottom-panel">
		<div class="buttons_s">
			<div class="container">
				<div class="col-xs-6 col-md-6 col-sm-6 col-lg-6 but">
					<a href="#">
						<span class="b-icon support"></span>
						<p>Awesome Support <br> <span>cellside offers the best customer support! online, phone &amp; emails!</span></p>
					</a>
				</div>
				<div class="col-xs-6 col-md-6 col-sm-6 col-lg-6 but">
					<a href="#">
						<span class="b-icon plane"></span>
						<p>Fast Shipping <br> <span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut.</span></p>
					</a>
				</div>
			</div>
		</div>
		<div class="subscribe">
			<div class="container">
				<form action="#">
					<div class="col-xs-10 col-sm-10 col-md-6 col-lg-6"><span class="fa fa-envelope pull-left"></span><p>Subscribe to our Cellside E-LIST and get a $10.00 Gift Card</p></div>
					<div class="col-xs-6 col-sm-6 col-md-3 col-lg-3"><input class="email" type="email" name="email" placeholder="E-mail" required=""></div>
					<div class="col-xs-6 col-sm-6 col-md-2 col-lg-2"><input type="submit" value="SUBSCRIBE"></div>
				</form>
			</div>
		</div>
	</div>

	<?php
	/**
	 * Footer Bottom
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'footer_bottom' ); 
	$ospans = array(1=>3, 2=>2,3=>4,4=>3);
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_bottom'])&& $themeConfig['block_footer_bottom']?(int)$themeConfig['block_footer_bottom']:count($modules);	
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	
	
	<div class="footer-bottom">
		<div class="container">
			<?php echo $modules[0]; ?>
		</div>
	</div>
	<?php } ?>

	<!--
	OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
	Please donate via PayPal to donate@opencart.com
	//-->
	<div id="powered">
		<div class="container" style='text-align:center;height:50px;font-family:myriad pro;color:#111111;'>
				
				<div style='float:left;margin-top:20px;'>
					© 2012 Cellside.ca  All Rights Reserved.
				</div>
				
				<div style='display:inline-block;'>
					<img src='/catalog/view/theme/lexus_happycook/image/pay.png' style='height:40px;margin-top:11px'>
				</div>
				
				<div style='float:right;margin-top:20px;'>
					<img src='/catalog/view/theme/lexus_happycook/image/copyright.png' style='margin-top:-10px'>
				</div>				
		</div>
	</div>
</section>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<?php if( isset($themeConfig['enable_paneltool']) && $themeConfig['enable_paneltool'] ){  ?>
	<?php  echo $helper->renderAddon( 'panel' );?>
<?php } ?>
</section> 

                        <?php $this->load->library('couponpop'); ?>
                        

			<?php
			if ($this->config->get('config_firebug_analyzer') && !headers_sent()) {
				require_once(DIR_SYSTEM . "library/fb.php");
				$time = microtime();
				$time = explode(' ', $time);
				$time = $time[1] + $time[0];
				$finish = $time;
				$start = explode(' ', $GLOBALS['start']);
				$start = $start[1] + $start[0];
				$GLOBALS['total_time'] = round(($finish - $start), 4);
				FB::log('INCREASE PAGE SPEED V4.1 BY HUNTER BUSINESS MANAGEMENT');
				FB::info('Total Database Queries : ' . $this->db->total_queries);
				FB::info('Time Spent Database Querying : ' . round($this->db->total_query_time,4) . ' seconds.');
				if ($this->db->total_slow_queries) {
					FB::error('Slow Database Queries : ' . round($this->db->total_slow_queries, 4));
				}
				FB::info('Page Generation Time : ' . $GLOBALS['total_time'] . ' seconds.');
			
				if ($this->config->get('config_firebug_queries')) {
					FB::log($this->db->query_data);
				}
			}
			?>
			
</body></html>
<script>
	$(document).ready(function(){
	  $('.bxslider').bxSlider();
	  $('.gallery').colorbox();
	  $('.main_menu').sidr({
			name: 'sidr-existing-content',
			source: '.megamenu'
		});
	});
</script>