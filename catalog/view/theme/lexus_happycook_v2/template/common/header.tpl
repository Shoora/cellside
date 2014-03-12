<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

 
	//$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$helper->setDirection( $direction );
	/* Add scripts files */
	$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	//$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );
	$helper->addScript( 'catalog/view/javascript/common.js' );

	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/custom.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/jquery.bxslider.min.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/jquery.sidr.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/jquery.colorbox-min.js' );
	
	$helper->addScriptList( $scripts );
	
	$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );	
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );	


	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/stylesheet.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/custom.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/main.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/colorbox/colorbox.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/theme-responsive.css' );

	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/jquery.bxslider.css' );
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/jquery.sidr.dark.css' );
	
?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
	<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
	 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<!-- Mobile viewport optimized: h5bp.com/viewport -->
	<meta name="viewport" content="width=device-width">
	<meta charset="UTF-8" />
	<title><?php echo $title; ?></title>
	<base href="<?php echo $base; ?>" />
	<?php if ($description) { ?>
	<meta name="description" content="<?php echo $description; ?>" />
	<?php } ?>
	<?php if ($keywords) { ?>
	<meta name="keywords" content="<?php echo $keywords; ?>" />
	<?php } ?>
	<?php if ($icon) { ?>
	<link href="<?php echo $icon; ?>" rel="icon" />
	<?php } ?>
	
	<?php foreach ($helper->getCssLinks() as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>

		<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
				<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
		<?php } ?>
		
		<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
		<style> 
			body{
				background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
			}</style>
		<?php } ?>
	<?php 
		if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
		$css=array();
		$link = array();
		for( $i=1; $i<=3; $i++ ){
			if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
				$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
				$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
			}
			if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
				$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
			}
		}
		echo implode( "\r\n",$link );
	?>
	<?php } else { ?>

	<?php } ?>
	<?php foreach ($styles as $style) { ?>
	<?php if ($style['href']=='catalog/view/theme/lexus_happycook_v2/stylesheet/pavmegamenu/style.css') {continue;} ?>
	<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
	<?php } ?>
	<?php foreach( $helper->getScriptFiles() as $script )  { ?>
	<script type="text/javascript" src="<?php echo $script; ?>"></script>
	<?php } ?>


	<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
		<script type="text/javascript"><!--
			$(document).ready(function() {
				<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
			});
	//--></script>
	<?php }	?>

	<!--[if lt IE 9]>
	<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<?php } else { ?>
	<script src="catalog/view/javascript/html5.js"></script>
	<?php } ?>
	<script src="catalog/view/javascript/respond.min.js"></script>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
	<![endif]-->

	<?php if ( isset($stores) && $stores ) { ?>
	<script type="text/javascript"><!--
	$(document).ready(function() {
	<?php foreach ($stores as $store) { ?>
	$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
	<?php } ?>
	});
	//--></script>
	<?php } ?>
	<?php echo $google_analytics; ?>
</head>
<body id="offcanvas-container" class="offcanvas-container layout-<?php echo $layoutMode; ?> fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?>">
<section id="page" class="offcanvas-pusher" role="main">
	<section id="header">
		<!-- <div class="container"> -->
			<div class="top-bar container">
				<div class="row">
					<div class="col-lg-4 col-md-4 col-sm-5 col-xs-12 col-h login-cont">
						<?php if (!$logged) { ?>
						<?php echo $text_welcome; ?>
						<?php } else { ?>
						<?php echo $text_logged; ?>
						<?php } ?>                  
					</div>
					<div class="col-lg-1 col-md-1 col-sm-3 col-xs-8 col-h lang_cur">
						<div class="currency whiteGradient col-xs-6 no-padding">
							<?php echo $currency; ?>
						</div>
						<div class="language whiteGradient col-xs-6 no-padding">
							<?php echo $language; ?>
						</div>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 col-h call-h">
						<span class="top-call col-xs-6 col-sm-12">
							CALL US - 1-888-285-4949
							<span class="top-time col-xs-6">9:30 am - 6:00 pm CST</span>
						</span>
					</div>
					<div class="col-lg-5 col-md-5 col-sm-1 col-xs-4 col-h">
						<button id="topBarMenu" type="button" class="btn btn-default dropdown-toggle hidden-md hidden-lg" data-toggle="dropdown">
							<span class="fa fa-align-justify"></span>
						</button>
						<ul class="ulTopButtons" role="menu" aria-labelledby="topBarMenu">
							<li><a href="#" class="livechat greenGradient top-buttons">Live chat - Online <span class="fa fa-comments"></span></a></li>
							<li><a href="#" class="whiteGradient top-buttons">Visit Cash4Electronics <span class="fa fa-caret-right"></span></a></li>
							<li><a href="#" class="whiteGradient top-buttons">Visit CaseFX <span class="fa fa-caret-right"></span></a></li>
						</ul>
					</div>
				</div> <!-- row end -->
			</div> <!-- top-bar end -->
			
		<!-- </div> container end -->
	</section>


	<div class="col-xs-12 visible-xs no-padding">
		<?php if ($logo) { ?>
			<div id="logo" style="background: #ededed; padding: 10px;"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
		<?php } ?>
	</div>
	<section id="pav-mainnav">
		<div class="container">
			<div class="row">
				<div class="navbar navbar-default mobile-button col-md-2 col-sm-2 col-xs-2 hidden-lg">
					<div class="navbar-header">
						<a href="javascript:;" data-target=".navbar-collapse" data-toggle="collapse" class="visible-xs visible-sm navbar-toggle main_menu" type="button">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</a>
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-6 col-xs-8 no-padding">
					<?php if ($logo) { ?>
						<div id="logo" class="hidden-xs"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
					<?php } ?>
				</div>
				<div class="col-lg-10 col-md-8 col-sm-4 col-xs-2 cart_search">
					<?php 
								/**
								 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
								 */
								$modules = $helper->getModulesByPosition( 'mainmenu' ); 
								foreach ($modules as $module) {
									 echo $module;
								} 
					?>
					
						<div class="col-lg-1 col-md-2 col-sm-6 col-xs-12 no-padding">
							<div class="cart">
								<?php echo $cart; ?>
							</div>
						</div>
						<div class="col-lg-1 col-md-2 col-sm-6 hidden-xs no-padding sr">
							<div class="search redGradient" onClick="$('#search_f').show(200,sResize);"><span class="fa fa-search"></span></div>
						</div>
					</div> <!-- pav-menu end -->
				</div>
		</div>		
	</section>
	<div id="search_f">
		<div class="container">
			<div id="search-inner">
				<div class="hidden-xs hidden-sm col-md-3 col-lg-3 no-padding greenS"><img src="catalog/view/theme/<?php echo $themeName;?>/image/cellside-search.png" alt="" class="searchImg"></div>
				<div class="col-xs-10 col-sm-8 col-md-7 col-lg-7 no-padding inp"><div id="search"><input type="text" name="search" placeholder="<?php echo $text_search; ?>" maxlength="16" value="<?php echo $search; ?>"></div></div>
				<div class="col-xs-2 col-sm-2 col-md-1 col-lg-1 no-padding s_b"><div class="search greenGradient" onClick="window.location = '/index.php?route=product/search&amp;search='+$(this).parent().parent().find('input').val();"><span class="fa fa-search"></span></div></div>
				<div class="hidden-xs col-sm-2 col-md-1 col-lg-1 no-padding s_b"><div class="search redGradient" onClick="$('#search_f').hide();"><span class="fa fa-times-circle"></span></div></div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>	
</section>

<section id="sys-notification">
	<div class="container">

		<?php if ($error) { ?>    
			<div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
		<?php } ?>

		<div id="notification"></div>
	</div>
</section>


	