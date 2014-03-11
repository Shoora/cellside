<!-- template for view products images -->
<script id="img-wrapper-tmpl" type="text/x-jquery-tmpl">	
	<div class="rg-image-wrapper">
		{{if itemsCount > 1}}
			<div class="rg-image-nav">
				<a href="#" class="rg-image-nav-prev">Previous Image</a>
				<a href="#" class="rg-image-nav-next">Next Image</a>
			</div>
		{{/if}}
		<div class="rg-image"></div>
		<div class="rg-loading"></div>
		<div class="rg-caption-wrapper">
			<div class="rg-caption" style="display:none;">
				<p></p>
			</div>
		</div>
	</div>
</script>

<!-- JS start -->
<script>	

	var SGS 			= <?php echo json_encode( $setting); ?>; //Smart Gallery Setting

	SGS.data.mode_button_html = '<?php echo htmlspecialchars_decode($setting['data']['mode_button_html']); ?>';
	
	SGS.token 			= '<?php echo $token; ?>';
	SGS.gallery_id 		= '<?php echo $gallery_id; ?>';
	
	$(function () { 
		SG.init();
	});
	
</script>

<style>

/* ============= main style ========================================================================= */
	.camera_wrap{
		background-color	: <?php echo $setting['gallery']['background_color']; ?>!important;
		<?php if($setting['gallery']['background_image']!= 'empty'){ ?>
		background-image	: url(<?php echo $setting['data']['patterns'].$setting['gallery']['background_image']; ?>);
		<?php } ?>
		background-repeat		: repeat;
	}
	
	div[data-wrap=gallery-box]{
		width	: 100%;
	<?php if($setting['gallery']['width']){ ?>
		width	: <?php echo $setting['gallery']['width']; ?>;
	<?php } ?>
	}
	
	
	

/* ============= title style ========================================================================= */
	div[data-wrap=gallery-box] .galery-title{
		color: <?php echo $setting['gallery']['header_color']; ?>;
		text-align: <?php echo $setting['gallery']['header_position']; ?>;
		background-color	: <?php echo $setting['gallery']['header_bg_color']; ?>;
		<?php if($setting['gallery']['header_bg_image']!= 'empty'){ ?>
		background-image	: url(<?php echo $setting['data']['patterns'].$setting['gallery']['header_bg_image']; ?>);
		<?php } ?>
		background-repeat		: repeat;
	}

	
/* ============= pagination & thumb style ========================================================================= */	
	.sg-pagination-block, .info_slider_name{
		color: <?php echo $setting['thumb']['color']; ?>!important;
	}
	.info-slider-mode .pix_thumb img {
		margin-left	: <?php echo (int)$setting['thumb']['distance']/2; ?>px;		
		margin-right: <?php echo (int)$setting['thumb']['distance']/2; ?>px;
	}
	.info_slider_name{
		width: <?php echo $setting['thumb']['width'] + $setting['thumb']['distance']; ?>px;
	}

/* ============= border gallery style ========================================================================= */
	div[data-wrap=gallery-box] {
		-webkit-border-radius	:  <?php echo $setting['gallery']['border_radius']; ?>;
		-moz-border-radius		:  <?php echo $setting['gallery']['border_radius']; ?>;
		border-radius			:  <?php echo $setting['gallery']['border_radius']; ?>;
		border					:  <?php echo $setting['gallery']['border_width']; ?> solid <?php echo $setting['gallery']['border_color']; ?>;
	}



	
	
/* ============= shadow gallery style ========================================================================= */
<?php if($setting['style']['shadow']['container']['status']){ ?>
	/* ============= shadow gallery style START */
	<?php if($setting['style']['shadow']['container']['mod_slider']){ ?>  
		div[data-wrap=gallery-box].slider-screen{
			-webkit-box-shadow: <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
			-moz-box-shadow:    <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
			box-shadow:         <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
		}
	<?php } ?>	
	
	<?php if($setting['style']['shadow']['container']['mod_nofull']){ ?>  
		div[data-wrap=gallery-box].no-full-screen{
			-webkit-box-shadow: <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
			-moz-box-shadow:    <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
			box-shadow:         <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
		}
	<?php } ?>	
	
	.blockMsg{
		-webkit-box-shadow: <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
		-moz-box-shadow:    <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
		box-shadow:         <?php echo $setting['style']['shadow']['container']['shadow_val']; ?>;
	}
<?php } ?>	
	
	<?php if($setting['style']['shadow']['thumb']['status']){ ?>
	/* ============= shadow thumb style START */
	.pix_thumb img{
		-webkit-box-shadow: <?php echo $setting['style']['shadow']['thumb']['shadow_val']; ?>;
		-moz-box-shadow:    <?php echo $setting['style']['shadow']['thumb']['shadow_val']; ?>;
		box-shadow:         <?php echo $setting['style']['shadow']['thumb']['shadow_val']; ?>;
	}
	<?php } ?>
	
	<?php if($setting['style']['shadow']['button']['status']){ ?>
	/* ============= shadow button style START */
	.camera_wrap .prod_button, .camera_play, .camera_stop, .camera_prev, .camera_next, .full_screen_button, .close_gallery{
		-webkit-box-shadow: <?php echo $setting['style']['shadow']['button']['shadow_val']; ?>;
		-moz-box-shadow:    <?php echo $setting['style']['shadow']['button']['shadow_val']; ?>;
		box-shadow:         <?php echo $setting['style']['shadow']['button']['shadow_val']; ?>;
	}
	<?php } ?>
	

	.controll-panel{
		color: <?php echo $setting['gallery']['color']; ?>;
	}
	
	.controll-panel a{
		color: <?php echo $setting['gallery']['color']; ?>;
	}
	
	.camera_caption > div,
	.prod_button, 
	.camera_commands, .camera_next, .camera_prev,
	.full_screen_button, .close_gallery,
	.sg-zoom-button{
		background: <?php echo $setting['product']['description_bg_color']; ?>!important;
		background: <?php echo $setting['product']['description_bg_color_RGBA']; ?>!important;
		color: <?php echo $setting['product']['description_color']; ?>!important;
	}

	.SG_button_box .prod_button span{
		color: <?php echo $setting['product']['description_color']; ?>!important;
	}

	.camera_prevThumbs, .camera_nextThumbs, .camera_thumbs_cont{
		background-repeat		: repeat!important;
		background-color		: <?php echo $setting['thumb']['background_color']; ?>!important;
		<?php if($setting['thumb']['background_image'] != 'empty'){ ?>
		background-image	: url(<?php echo $setting['data']['patterns'].$setting['thumb']['background_image']; ?>)!important;
		<?php } ?>
	}





	
	.mode_button {
		
		<?php echo $setting['data']['mode_button_style']; ?>
	}
	
	.camera_prevThumbs div, .camera_nextThumbs div, 
	.camera_prev > span, .camera_next > span,
	.camera_commands > .camera_play,.camera_commands > .camera_stop,
	.full_screen_button span, .close_gallery span,
	.page_next > i , .page_prev > i,
	.sg_butt_to_cart span , .sg_butt_to_wish span , .sg_butt_to_compare span, 
	.icon-loupe{
		background-image: url(catalog/view/theme/default/stylesheet/smartgallery/images/skins/<?php echo $setting['gallery']['skin']; ?>);
		background-repeat : no-repeat;
	}
	
	.tipsy-inner { 
		background-color: <?php echo $setting['tooltip']['bg_color']; ?>; 
		color: <?php echo $setting['tooltip']['color']; ?>;
	}
	.tipsy-arrow-n { border-bottom-color: <?php echo $setting['tooltip']['bg_color']; ?>; }
	.tipsy-arrow-s { border-top-color: <?php echo $setting['tooltip']['bg_color']; ?>; }
	.tipsy-arrow-e { border-left-color: <?php echo $setting['tooltip']['bg_color']; ?>; }
	.tipsy-arrow-w { border-right-color: <?php echo $setting['tooltip']['bg_color']; ?>; }
	
	
	
/* ============= custom style for button Quick View
========================================================================= */
	.SG_qw_button{
		<?php echo $setting['data']['css_qw_button_style']; ?>;
	}
	
/* ============= custom style Gallery container
========================================================================= */
	<?php echo $setting['data']['css_style']; ?>		
	
</style>
<div data-wrap="gallery-box">
	<div id="smart-gallery" class="<?php echo str_replace('.png', '', $setting['gallery']['skin']); ?>" ><?php echo $htmlStructura; ?></div>
</div>