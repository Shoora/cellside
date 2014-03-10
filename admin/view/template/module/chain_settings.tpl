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

<?php echo $header; ?>

<div id="content">

  <?php echo breadcrumb($breadcrumbs); ?>
  
  <?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
	<div class="success"><?php echo $success; ?></div>
  <?php } ?>
 
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a target="_blank" href="<?php echo $txt_purchase_license_url; ?>" class="button"><span><?php echo $txt_homepage; ?></span></a><a onclick="$('#form').submit();return false;" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">

		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		 
			<div id="tabs" class="htabs">
				<a href="#tab-display"><?php echo $txt_display_settings; ?></a>
				<a href="#tab-style"><?php echo $txt_style_settings; ?></a>
				<a href="#tab-actions"><?php echo $txt_action_settings; ?></a>
				<a href="#tab-options"><?php echo $txt_options_settings; ?></a>
				<a href="#tab-slider"><?php echo $txt_slider_settings; ?></a>
				<a href="#tab-ajax-loader"><?php echo $txt_ajax_loader; ?></a>
			</div>
			
			<div id="tab-display">
			<table class="form">
				<tr>
					<td><?php echo $txt_display_in_tab; ?> <div class="help"><br /><?php echo $txt_display_in_tab_hint; ?></div>
					<td><?php echo form_checkbox('chain_display_chain_tab', index_value($chain_settings, 'chain_display_chain_tab', true)); ?>
				<tr class="chain_position">
					<td><?php echo $txt_chain_position; ?> <div class="help"><br /><?php echo $txt_chain_position_hint; ?></div>
					<td>
						<?php echo form_dropdown('chain_display_chain_position_type', $chain_display_chain_position_type, index_value($chain_settings, 'chain_display_chain_position_type', true)); ?> 
						<?php echo $of_container; ?>
						<input type="text" name="chain_display_chain_position_container" value="<?php echo index_value($chain_settings, 'chain_display_chain_position_container'); ?>" />
				<tr>	
					<td><?php echo $txt_chain_image_size; ?>
					<td>
						<input type="text" name="chain_display_image_width"  size="3" maxlength="3" value="<?php echo index_value($chain_settings, 'chain_display_image_width'); ?>" /> x
						<input type="text" name="chain_display_image_height" size="3" maxlength="3" value="<?php echo index_value($chain_settings, 'chain_display_image_height'); ?>" />
				<tr>
					<td><?php echo $txt_display_you_save; ?>
					<td><?php echo form_checkbox('chain_display_you_save', index_value($chain_settings, 'chain_display_you_save', true)); ?>
				<tr>
					<td><?php echo $txt_display_old_price; ?>
					<td><?php echo form_checkbox('chain_display_old_price', index_value($chain_settings, 'chain_display_old_price', true)); ?>
				<tr>
					<td><?php echo $txt_display_discount_percent; ?>
					<td><?php echo form_checkbox('chain_display_discount_percent', index_value($chain_settings, 'chain_display_discount_percent', true)); ?>
				<tr>
					<td><?php echo $txt_chain_for_special; ?>  <div class="help"><br /><?php echo $txt_chain_for_special_hint; ?></div>
					<td><?php echo form_dropdown('chain_decrease_for_special', $chain_decrease_for_special, index_value($chain_settings, 'chain_decrease_for_special', true)); ?>
						<ul>
							<li><?php echo $txt_accumulate_price_example; ?></li>
							<li><?php echo $txt_dont_accumulate_price_example; ?></li>
						</ul>
					
			</table>
			</div>
			<div id="tab-style">
			<table class="form">
				<tr>
					<td><?php echo $txt_style; ?>
					<td>
					<?php
							$tpl = array(
								'classic' 		=> $txt_classic_module_box,
								'user_style' 	=> $txt_customized_style
							);
							echo form_dropdown('chain_style', $tpl, index_value($chain_settings, 'chain_style'));
					?>
				<tr>	
					<td><?php echo $container_margin_top; ?>
					<td><?php echo form_dropdown('chain_style_container_margin_top', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_margin_top', true)); ?>
				<tr>	
					<td><?php echo $container_margin_bottom; ?>
					<td><?php echo form_dropdown('chain_style_container_margin_bottom', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_margin_bottom', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_padding; ?> - <?php echo $txt_top; ?>
					<td><?php echo form_dropdown('chain_style_container_padding_top', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_padding_top', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_padding; ?> - <?php echo $txt_bottom; ?>
					<td><?php echo form_dropdown('chain_style_container_padding_bottom', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_padding_bottom', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_padding; ?> - <?php echo $txt_left; ?>
					<td><?php echo form_dropdown('chain_style_container_padding_left', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_padding_left', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_padding; ?> - <?php echo $txt_right; ?>
					<td><?php echo form_dropdown('chain_style_container_padding_right', $drop_down_px_array, index_value($chain_settings, 'chain_style_container_padding_right', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_border; ?> - <?php echo $txt_width; ?>
					<td><?php echo form_dropdown('chain_style_border_width', $drop_down_px_array, index_value($chain_settings, 'chain_style_border_width', true)); ?>
				<tr class="user_style">	
					<td><?php echo $txt_container_border; ?> - <?php echo $txt_color; ?>
					<td><input type="text" name="chain_style_border_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_border_color'); ?>" />
				<tr class="user_style">	
					<td><?php echo $txt_container_border; ?> - <?php echo $txt_radius; ?>
					<td><?php echo form_dropdown('chain_style_border_radius', $drop_down_px_array, index_value($chain_settings, 'chain_style_border_radius', true)); ?>
				<tr class="user_style">
					<td><?php echo $txt_show; ?> <?php echo $txt_title; ?>
					<td><?php echo form_checkbox('chain_style_header_show', index_value($chain_settings, 'chain_style_header_show')); ?>
				<tr class="user_style style_header">	
					<td><?php echo $txt_title; ?> - <?php echo $txt_font_color; ?>
					<td><input type="text" name="chain_style_header_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_header_color'); ?>" />
				<tr class="user_style style_header">	
					<td><?php echo $txt_title; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_header_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_header_fontsize', true)); ?>
				<tr class="user_style style_header">
					<td><?php echo $txt_title; ?> - <?php echo $txt_lineheight; ?>
					<td><?php echo form_dropdown('chain_style_header_line_height', $drop_down_fontsize, index_value($chain_settings, 'chain_style_header_line_height')); ?>
				<tr class="user_style style_header">
					<td><?php echo $txt_title; ?> <?php echo $txt_padding; ?> - <?php echo $txt_left; ?>
					<td><?php echo form_dropdown('chain_style_header_padding_left', $drop_down_px_array, index_value($chain_settings, 'chain_style_header_padding_left')); ?>	
				<tr>	
					<td><?php echo $txt_discount_label; ?> - <?php echo $txt_color; ?>
					<td><input type="text" name="chain_style_discount_label_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_discount_label_color'); ?>" />	
				<tr>	
					<td><?php echo $txt_discount_label; ?> - <?php echo $txt_font_color; ?>
					<td><input type="text" name="chain_style_discount_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_discount_color'); ?>" />
				<tr>	
					<td><?php echo $txt_discount_label; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_discount_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_discount_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_you_save; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_you_save_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_you_save_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_you_save; ?> - <?php echo $txt_font_color; ?>
					<td><input type="text" name="chain_style_you_save_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_you_save_color'); ?>" />
				<tr>	
					<td><?php echo $txt_plus_sign_equal_sign; ?> - <?php echo $txt_color; ?>
					<td><input type="text" name="chain_style_sign_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_sign_color'); ?>" />
				<tr>	
					<td><?php echo $txt_plus_sign_equal_sign; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_sign_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_sign_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_total_price; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_total_price_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_total_price_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_total_price; ?> - <?php echo $txt_font_color; ?>
					<td><input type="text" name="chain_style_total_price_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_total_price_color'); ?>" />
				<tr>	
					<td><?php echo $txt_price; ?> - <?php echo $txt_font_wieght; ?>
					<td><?php echo form_dropdown('chain_style_price_font_weight', $drop_down_fontweight, index_value($chain_settings, 'chain_style_price_font_weight')); ?>
				<tr>	
					<td><?php echo $txt_new_price; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_new_price_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_new_price_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_old_price; ?> - <?php echo $txt_font_size; ?>
					<td><?php echo form_dropdown('chain_style_old_price_fontsize', $drop_down_fontsize, index_value($chain_settings, 'chain_style_old_price_fontsize')); ?>
				<tr>	
					<td><?php echo $txt_old_price; ?> - <?php echo $txt_font_color; ?>
					<td><input type="text" name="chain_style_oldprice_color" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_oldprice_color'); ?>" />
				<tr>	
					<td><?php echo $txt_option_button; ?> - <?php echo $txt_color; ?> (<?php echo $txt_unselected; ?>)
					<td><input type="text" name="chain_style_options_color_unselected" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_options_color_unselected'); ?>" />
				<tr>	
					<td><?php echo $txt_option_button; ?> - <?php echo $txt_color; ?> (<?php echo $txt_selected; ?>)
					<td><input type="text" name="chain_style_options_color_selected" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_style_options_color_selected'); ?>" />
				<tr>	
					<td><?php echo $txt_extra_css; ?> <div class="help"><?php echo $txt_extra_css_hint; ?></div>
					<td><textarea name="chain_style_extra_css" style="width: 500px; height: 180px; overflow: scroll;"><?php echo index_value($chain_settings, 'chain_style_extra_css'); ?></textarea>
			</table>
			</div>
			<div id="tab-actions">
			<table class="form">
				<tr>
					<td><?php echo $txt_action_type; ?>
					<td><?php
							$actions_on_success = array(
								'message' 		=> $txt_action_show_msg,
								'redirect' 		=> $txt_action_redirect
							);
							echo form_dropdown('chain_action_on_success', $actions_on_success, index_value($chain_settings, 'chain_action_on_success'));
					?>
				<tr class="redirect_to">	
					<td><?php echo $txt_action_url_redirect_to; ?>
					<td><input type="text" name="chain_action_redirect_url" style="width: 200px;" value="<?php echo index_value($chain_settings, 'chain_action_redirect_url'); ?>" />
			</table>
			</div>
			<div id="tab-options">
			<table class="form">
				<tr>	
					<td><?php echo $txt_title_length; ?><div class="help"><?php echo $txt_cute_product_title_to; ?></div>
					<td><input type="text" name="chain_options_title_lenght" maxlength="3" size="3" value="<?php echo index_value($chain_settings, 'chain_options_title_lenght'); ?>" />
				<tr>	
					<td><?php echo $txt_show_image; ?>
					<td><?php echo form_checkbox('chain_options_show_image', index_value($chain_settings, 'chain_options_show_image')); ?>
				<tr class="style_popup_image_size">	
					<td><?php echo $txt_popup_image_size; ?>
					<td>
						<input type="text" name="chain_options_popup_image_width"  size="3" maxlength="3" value="<?php echo index_value($chain_settings, 'chain_options_popup_image_width'); ?>" /> x
						<input type="text" name="chain_options_popup_image_height" size="3" maxlength="3" value="<?php echo index_value($chain_settings, 'chain_options_popup_image_height'); ?>" />
			</table>
			</div>
			<div id="tab-slider">
			<table class="form">
				<tr>	
					<td><?php echo $txt_autoscroll; ?>
					<td><?php echo form_dropdown('chain_slider_autoscroll', $on_add_off, index_value($chain_settings, 'chain_slider_autoscroll', true)); ?>
				<tr>	
					<td><?php echo $txt_allow_mousewheel; ?> <div class="help"><br /><?php echo $txt_allow_mousewheel_hint; ?></div>
					<td><?php echo form_dropdown('chain_slider_mousewheel', $on_add_off, index_value($chain_settings, 'chain_slider_mousewheel', true)); ?>
				<tr>	
					<td><?php echo $txt_control_navigation; ?> <div class="help"><br /><?php echo $txt_control_navigation_hint; ?></div>
					<td><?php echo form_dropdown('chain_slider_nav', $on_add_off, index_value($chain_settings, 'chain_slider_nav', true)); ?>			
				<tr>	
					<td><?php echo $txt_navigation_arrows_bg; ?>
					<td><input type="text" name="chain_slider_arrows_background" class="color_picker" value="<?php echo index_value($chain_settings, 'chain_slider_arrows_background'); ?>" />	
				<tr>
					<td><?php echo $txt_navigation_arrows_padding_top; ?>
					<td><?php echo form_dropdown('chain_slider_arrows_border_top', $drop_down_px_array, index_value($chain_settings, 'chain_slider_arrows_border_top', true)); ?>
				<tr>
					<td><?php echo $txt_navigation_arrows_padding_bottom; ?>
					<td><?php echo form_dropdown('chain_slider_arrows_border_bottom', $drop_down_px_array, index_value($chain_settings, 'chain_slider_arrows_border_bottom', true)); ?>
				<tr>
					<td><?php echo $txt_navigation_arrows_color; ?>
					<td>
					
					<input type="hidden" name="chain_slider_arrows_color_left" value="<?php echo index_value($chain_settings, 'chain_slider_arrows_color_left'); ?>">
					<input type="hidden" name="chain_slider_arrows_color_right" value="<?php echo index_value($chain_settings, 'chain_slider_arrows_color_right'); ?>">
					
					<style>
					.flex_btn {
							background-image: url('../catalog/view/theme/default/image/c_arrows.png'); 
							background-repeat: no-repeat;
							width: 30px; 
							height: 33px;
							overflow: hidden;
							float: left; 
							margin: 5px;
							display: inline-block;
							border-style: solid;
					}
					.flex_box_cont {
						margin: 10px; 
						border: 1px solid #ccc; 
						padding: 5px; 
						display: inline-block;
					}
					.flex_box_cont.active {
						border-color: red;
					}
					.flex_box_cont:hover {
						border-color: #000;
						cursor: pointer;
					}
					</style>
					<div id="flex_btns"></div>
			</table>
			</div>
			
			<div id="tab-ajax-loader">
				<table class="form">
				<tr>
					<td valign=top><?php echo $txt_ajax_loader; ?> <div class="help"><br /><?php echo $txt_ajax_loader_hint; ?></div>
					<td><?php 
						$chain_ajax_loader = array(
							'0' => $txt_no,
							'ajax_loading_line_1.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_line_1.gif">',
							'ajax_loading_line_2.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_line_2.gif">',
							'ajax_loading_line_3.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_line_3.gif">',
							'ajax_loading_line_4.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_line_4.gif">',
							'ajax_loading_round_1.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_round_1.gif">',
							'ajax_loading_round_2.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_round_2.gif">',
							'ajax_loading_round_3.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_round_3.gif">',
							'ajax_loading_text_1.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_text_1.gif">',
							'ajax_loading_text_2.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_text_2.gif">',
							'ajax_loading_text_3.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_text_3.gif">',
							'ajax_loading_cogwheel.gif' => '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_cogwheel.gif">',
							'ajax_loading_percent.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_percent.gif">',
							'ajax_loading_ball.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_ball.gif">',
							'ajax_loading_packman.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_packman.gif">',
							'ajax_loading_photo.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_photo.gif">',
							'ajax_loading_cat.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_cat.gif">',
							'ajax_loading_pizza.gif' 	=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_pizza.gif">',
							'ajax_loading_car.gif' 		=> '<img style="text-align: right" src="../catalog/view/theme/default/image/ajax_loading_car.gif">',
						);
						echo form_radio('chain_ajax_loader', $chain_ajax_loader, index_value($chain_settings, 'chain_ajax_loader', true), '<br /><br /><br />', false); 
						?>
				</table>
			</div>
			
			<table class="form" style="border-top: 1px solid #ccc; background: #eee;">
				<tr>
					<td><?php echo $txt_widget; ?><div class="help"><?php echo $txt_widget_hint; ?>
					<td><a target="_blank" href="<?php echo $widget_url; ?>"><?php echo $txt_edit; ?></a>
				<tr>
					<td><?php echo $txt_use_cache; ?>
					<td><?php echo form_dropdown('chain_cache', $on_add_off, index_value($chain_settings, 'chain_cache', true)); ?>		
				<tr>
					<td><?php echo $txt_totals; ?>
					<td><a target="_blank" href="<?php echo $totals; ?>"><?php echo $txt_edit; ?></a>
				<tr>
					<td><?php echo $txt_version; ?>
					<td><?php echo $version; ?> - Open Source Version
			</table>
		</form>
		<script type="text/javascript" src="view/javascript/jquery/farbtastic.js"></script>
		<link rel="stylesheet" href="view/stylesheet/farbtastic.css" type="text/css" />
		<script type="text/javascript"><!--		
		var set_flex_btn = function() {
			var flex_btn_background = $('input[name="chain_slider_arrows_background"]').val();
			$('.flex_btn').css({
				'background-color': flex_btn_background,
				'border-color': flex_btn_background
			});
		};
		
		$('input[name="chain_slider_arrows_background"]').change(function() {
			set_flex_btn();
		});
		
		var margin_top 	= -44;
		var margin_left = -4;
		var html_line = '';
		for (i = 0; i < 30; i++) {
			html_line += '<div class="flex_box_cont">';
			for (j = 0; j < 2; j++) {
				html_line += '<div class="flex_btn" style="background-position: '+ margin_left +'px '+  margin_top +'px;">&nbsp;</div>'
				margin_left = margin_left - 41;
			}
			margin_left = -4;
			margin_top = margin_top - 40;
			html_line += '</div>';
		}
		$('#flex_btns').append(html_line);
		
		
		var show_Hide_User_Style = function() {
			if ($('select[name="chain_style"]').val() == 'classic') {
				$('tr.user_style').hide();
			} else {
				$('tr.user_style').show();
			}
			show_Hide_Title_Style();
			show_Hide_Popup_Image_Size();
			show_Hide_Redirect_to();
		};
		
		var show_Hide_Title_Style = function() {
			if ($('input[name="chain_style_header_show"]').attr('checked') == 'checked') {
				$('tr.style_header').show();
			} else {
				$('tr.style_header').hide();
			}
		};
		
		var show_Hide_Chain_Position = function() {
			if ($('input[name="chain_display_chain_tab"]').attr('checked') == 'checked') {
				$('tr.chain_position').hide();
			} else {
				$('tr.chain_position').show();
			}
		};
		
		
		var show_Hide_Popup_Image_Size = function() {
			if ($('input[name="chain_options_show_image"]').attr('checked') == 'checked') {
				$('tr.style_popup_image_size').show();
			} else {
				$('tr.style_popup_image_size').hide();
			}
		};
		var show_Hide_Redirect_to = function() {
			if ($('select[name="chain_action_on_success"]').val() == 'redirect') {
				$('tr.redirect_to').show();
			} else {
				$('tr.redirect_to').hide();
			}
		};
			
		$(document).ready(function() {
		
			$('#tabs a').tabs();
			
			$('.flex_box_cont').click(function() {
				$('input[name="chain_slider_arrows_color_left"]').val($(this).find('.flex_btn').eq(0).css('background-position'));
				$('input[name="chain_slider_arrows_color_right"]').val($(this).find('.flex_btn').eq(1).css('background-position'));
				$('.flex_box_cont').removeClass('active');
				$(this).addClass('active');
			});
			
			$('.flex_box_cont').each(function(index) {
				var $parent = $(this);
				$(this).find('.flex_btn').each(function(xyindex) {
					if (xyindex == 0 
						&& $(this).css('background-position') == $('input[name="chain_slider_arrows_color_left"]').val() 
						&& $parent.find('.flex_btn').eq(xyindex + 1).css('background-position') == $('input[name="chain_slider_arrows_color_right"]').val()) 
					{
						
						$parent.addClass('active');
						
					}
				});
			});
			
			$('select[name="chain_slider_arrows_border_top"],select[name="chain_slider_arrows_border_bottom"]').change(function() {
				$('.flex_btn').css({
					'border-top-width': $('select[name="chain_slider_arrows_border_top"]').val() + 'px',
					'border-bottom-width': $('select[name="chain_slider_arrows_border_bottom"]').val() + 'px'
				});
			});
			
			$('select[name="chain_style"]').change(function() {
				show_Hide_User_Style();
			});
			$('input[name="chain_display_chain_tab"]').change(function() {
				show_Hide_Chain_Position();
			});
			$('select[name="chain_action_on_success"]').change(function() {
				show_Hide_Redirect_to();
			});
			
			show_Hide_User_Style();
			
			$('input[name="chain_style_header_show"]').change(function() {
				show_Hide_Title_Style();
			});
			
			$('input[name="chain_options_show_image"]').change(function() {
				show_Hide_Popup_Image_Size();
			});
			
			show_Hide_Title_Style();
			show_Hide_Popup_Image_Size();
			show_Hide_Redirect_to();
			show_Hide_Chain_Position();
			
			
			$('.color_picker').each(function(index) {
				$(this).attr('id', 'color_picker_index'+index).after('<div class="farbtastic_container" id="farbtastic_container-'+index+'"></div>');
				$('#farbtastic_container-'+index).farbtastic('#color_picker_index'+index);
			});
			$('.color_picker').focus( 
				function() {
					$(this).next().slideDown(300);
				});
			$('.color_picker').blur( 
				function() {
					$(this).next().hide();
				}
			);
			
			set_flex_btn();
		});
		
		var chain_manager_ad = '<?php echo (defined(DIR_APPLICATION) && file_exists(DIR_APPLICATION . 'controller/module/chain_manager.php')) ? 'true' : 'false'; ?>';
		if (chain_manager_ad) {
			$.get('index.php?route=module/chain/chain_manager_ad&token=<?php echo $this->session->data['token']; ?>&disable_hide=1', function(add_text) {
				if (add_text) {
					$('#form').after('<div class="chain_manager_ad">'+ add_text +'</div>');
				}
			});
		}
		--></script>
		<style>
		.farbtastic_container {
			position: absolute;
			margin-top: 0px;
			z-index: 10;
			display: none;
		}
		input.color_picker {
			border: none;
			border-radius: 15px;
			box-shadow: 0 0 3px rgba(0,0,0,0.3);
			padding: 10px;
		}
		</style>
    </div>
  </div>
</div>

<?php echo $footer; ?>