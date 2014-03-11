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

<section id="content-section" class="home-page">
	<?php 

		$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
		/**
		 * Slideshow modules
		 */
		$modules = $helper->getModulesByPosition( 'slideshow' ); 
		if( $modules ){
		?>
		<section id="pav-slideshow" class="pav-slideshow hidden-xs">
				<?php foreach ($modules as $module) { ?>
					<?php echo $module; ?>
				<?php } ?>
		</section>
		<?php } ?>


		<?php
		/**
		 * Promotion modules
		 * $ospans allow overrides width of columns base on thiers indexs. format array( column-index=>span number ), example array( 1=> 3 )[value from 1->12]
		 */
		$modules = $helper->getModulesByPosition( 'showcase' ); 
		$ospans = array();

		if( count($modules) ){
		$cols = isset($config['block_showcase'])&& $config['block_showcase']?(int)$config['block_showcase']:count($modules);	
		$class = $helper->calculateSpans( $ospans, $cols );
		?>
		<section class="pav-showcase" id="pav-showcase">
			<div class="container">
			<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
					<?php if(  $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row"><?php } ?>	
					<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
					<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
			<?php  $j++;  } ?>	
			</div>
		</section>
		<?php } ?>


		<?php
		/**
		 * Promotion modules
		 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
		 */
		$modules = $helper->getModulesByPosition( 'promotion' ); 
		$ospans = array(1=>8,2=>4);

		if( count($modules) ){
		$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);	
		$class = $helper->calculateSpans( $ospans, $cols );
		?>
		<section class="pav-promotion" id="pav-promotion">
			<div class="container">
			<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
					<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
						<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
					<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>		
			<?php  $j++;  } ?>	
			</div>
		</section>
		<?php } ?>


			<?php if( isset($themeConfig['enable_offsidebars']) && $themeConfig['enable_offsidebars'] ) { ?>
			<section id="columns" class="offcanvas-siderbars"><div class="container">
			<div class="row visible-xs"><div class="container"> 
				<div class="offcanvas-sidebars-buttons">
					<button type="button" data-for="column-left" class="pull-left btn btn-danger"><i class="glyphicon glyphicon-indent-left"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>
					
					<button type="button" data-for="column-right" class="pull-right btn btn-danger"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="glyphicon glyphicon-indent-right"></i></button>
				</div>
			</div></div>
			<?php }else { ?>
			<section id="columns">
				<div class="container">
				<?php } ?>
				<div class="row">
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

</section> <!-- content end -->

<?php
	/**
	 * Footer Top Position
	 * $ospans allow overrides width of columns base on thiers indexs. format array( 1=> 3 )[value from 1->12]
	 */
	$modules = $helper->getModulesByPosition( 'mass_bottom' ); 
	$ospans = array( );
	$cols   = 1;
	if( count($modules) ) { 
?>
<section id="pav-mass-bottom">
	<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {   ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row"><?php } ?>	
			<div class="col-lg-<?php echo floor(12/$cols);?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>
	</div>	
</section>
<?php } ?>

<?php echo $footer; ?>