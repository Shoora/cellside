<?php
// TYPES OF ANIMATION FUNCTION
	$skin = array(
		array('value' =>'camera_red_skin', 	'name' => 'red', 'default' => true),
		array('value' =>'camera_amber_skin', 	'name' => 'amber'),
		array('value' =>'camera_ash_skin', 	'name' => 'ash'),
		array('value' =>'camera_azure_skin', 	'name' => 'azure'),
		array('value' =>'camera_beige_skin', 	'name' => 'beige'),
		array('value' =>'camera_black_skin', 	'name' => 'black'),
		array('value' =>'camera_blue_skin', 	'name' => 'blue'),
		array('value' =>'camera_brown_skin', 	'name' => 'brown'),
		array('value' =>'camera_burgundy_skin', 	'name' => 'burgundy'),
		array('value' =>'camera_charcoal_skin', 	'name' => 'charcoal'),
		array('value' =>'camera_chocolate_skin', 	'name' => 'chocolate'),
		array('value' =>'camera_coffee_skin', 	'name' => 'coffe'),
		array('value' =>'camera_cyan_skin', 	'name' => 'cyan'),
		array('value' =>'camera_fuchsia_skin', 	'name' => 'fuchsia'),
		array('value' =>'camera_gold_skin', 	'name' => 'gold'),
		array('value' =>'camera_green_skin', 	'name' => 'green'),
		array('value' =>'camera_grey_skin', 	'name' => 'grey'),
		array('value' =>'camera_indigo_skin', 	'name' => 'indigo'),
		array('value' =>'camera_khaki_skin', 	'name' => 'khaki'),
		array('value' =>'camera_lime_skin', 	'name' => 'lime'),
		array('value' =>'camera_magenta_skin', 	'name' => 'magenta'),
		array('value' =>'camera_maroon_skin', 	'name' => 'maroon'),
		array('value' =>'camera_orange_skin', 	'name' => 'orange'),
		array('value' =>'camera_olive_skin', 	'name' => 'olive'),
		array('value' =>'camera_pink_skin', 	'name' => 'pink'),
		array('value' =>'camera_pistachio_skin', 	'name' => 'pistachio'),
		array('value' =>'camera_tangerine_skin', 	'name' => 'tangerine'),
		array('value' =>'camera_turquoise_skin', 	'name' => 'turquoise'),
		array('value' =>'camera_violet_skin', 	'name' => 'violet'),
		array('value' =>'camera_white_skin', 	'name' => 'white'),
		array('value' =>'camera_yellow_skin', 	'name' => 'yellow')
	);
	
	$fx_type = array(
		array('name' =>'random', 	'value' => 'random', 'default' => true),
		array('name' =>'scrollLeft', 	'value' => 'scrollLeft'),
		array('name' =>'scrollRight', 	'value' => 'scrollRight'),
		array('name' =>'scrollTop', 	'value' => 'scrollTop'),
		array('name' =>'scrollBottom', 	'value' => 'scrollBottom'),
		array('name' =>'scrollHorz', 	'value' => 'scrollHorz'),
		array('name' =>'simpleFade', 	'value' => 'simpleFade'),
		array('name' =>'curtainTopLeft', 	'value' => 'curtainTopLeft'),
		array('name' =>'curtainTopRight', 	'value' => 'curtainTopRight'),
		array('name' =>'curtainBottomLeft', 	'value' => 'curtainBottomLeft'),
		array('name' =>'curtainBottomRight', 	'value' => 'curtainBottomRight'),
		array('name' =>'curtainSliceLeft', 	'value' => 'curtainSliceLeft'),
		array('name' =>'curtainSliceRight', 	'value' => 'curtainSliceRight'),
		array('name' =>'blindCurtainTopLeft', 	'value' => 'blindCurtainTopLeft'),
		array('name' =>'blindCurtainTopRight', 	'value' => 'blindCurtainTopRight'),
		array('name' =>'blindCurtainBottomLeft', 	'value' => 'blindCurtainBottomLeft'),
		array('name' =>'blindCurtainBottomRight', 	'value' => 'blindCurtainBottomRight'),
		array('name' =>'blindCurtainSliceBottom', 	'value' => 'blindCurtainSliceBottom'),
		array('name' =>'blindCurtainSliceTop', 	'value' => 'blindCurtainSliceTop'),
		array('name' =>'stampede', 	'value' => 'stampede'),
		array('name' =>'mosaic', 	'value' => 'mosaic'),
		array('name' =>'mosaicReverse', 	'value' => 'mosaicReverse'),
		array('name' =>'mosaicRandom', 	'value' => 'mosaicRandom'),
		array('name' =>'mosaicSpiral', 	'value' => 'mosaicSpiral'),
		array('name' =>'mosaicSpiralReverse', 	'value' => 'mosaicSpiralReverse'),
		array('name' =>'topLeftBottomRight', 	'value' => 'topLeftBottomRight'),
		array('name' =>'bottomRightTopLeft', 	'value' => 'bottomRightTopLeft'),
		array('name' =>'simplbottomLeftTopRighteFade', 	'value' => 'bottomLeftTopRight'),
		array('name' =>'bottomLeftTopRight', 	'value' => 'bottomLeftTopRight')
	);
	
	$easing = array(
		array('name' =>'linear', 	'value' => 'linear', 'default' => true),
		array('name' =>'swing', 	'value' => 'swing'),
		array('name' =>'easeInQuad', 	'value' => 'easeInQuad'),
		array('name' =>'easeOutQuad', 	'value' => 'easeOutQuad'),
		array('name' =>'easeInOutQuad', 	'value' => 'easeInOutQuad'),
		array('name' =>'easeInCubic', 	'value' => 'easeInCubic'),
		array('name' =>'easeOutCubic', 	'value' => 'easeOutCubic'),
		array('name' =>'easeInOutCubic', 	'value' => 'easeInOutCubic'),
		array('name' =>'easeInQuart', 	'value' => 'easeInQuart'),
		array('name' =>'easeOutQuart', 	'value' => 'easeOutQuart'),
		array('name' =>'easeInOutQuart', 	'value' => 'easeInOutQuart'),
		array('name' =>'easeInQuint', 	'value' => 'easeInQuint'),
		array('name' =>'easeOutQuint', 	'value' => 'easeOutQuint'),
		array('name' =>'easeInOutQuint', 	'value' => 'easeInOutQuint'),
		array('name' =>'easeInSine', 	'value' => 'easeInSine'),
		array('name' =>'easeOutSine', 	'value' => 'easeOutSine'),
		array('name' =>'easeInOutSine', 	'value' => 'easeInOutSine'),
		array('name' =>'easeInExpo', 	'value' => 'easeInExpo'),
		array('name' =>'easeOutExpo', 	'value' => 'easeOutExpo'),
		array('name' =>'easeInOutExpo', 	'value' => 'easeInOutExpo'),
		array('name' =>'easeInCirc', 	'value' => 'easeInCirc'),
		array('name' =>'easeOutCirc', 	'value' => 'easeOutCirc'),
		array('name' =>'easeInOutCirc', 	'value' => 'easeInOutCirc'),
		array('name' =>'easeInElastic', 	'value' => 'easeInElastic'),
		array('name' =>'easeOutElastic', 	'value' => 'easeOutElastic'),
		array('name' =>'easeInOutElastic', 	'value' => 'easeInOutElastic'),
		array('name' =>'easeInBack', 	'value' => 'easeInBack'),
		array('name' =>'easeOutBack', 	'value' => 'easeOutBack'),
		array('name' =>'easeInOutBack', 	'value' => 'easeInOutBack'),
		array('name' =>'easeInBounce', 	'value' => 'easeInBounce'),
		array('name' =>'easeOutBounce', 	'value' => 'easeOutBounce'),
		array('name' =>'easeInOutBounce', 	'value' => 'easeInOutBounce'),
	);

	$global_setting = array(
		'data' => array(
			'selector_product'			=> 'input[name=product_id]',
			'attr_product'				=> 'value',
			
			'selector_category'			=> '.product-list .cart input, .product-grid .cart input',
			'attr_category'				=> 'onclick',
			
			'selector_qw_button'		=> '.product-list .image, .product-grid .image',
			'jq_relative_path_to_id'	=> '.parent().find(\'a\').attr(\'href\')',
			'position_qw_button'		=> 'append',
			'css_qw_button_style'		=> '',
			
			'selector_pagin_container'	=> '.pagination',
			'selector_pagin_activ'		=> 'b',
			'selector_pagin_element'	=> 'a',
			'attr_pagin_href'			=> 'href'
		)
	);
	
	$default_galleryOnPage = array(
		'gallery_id' 	=> '',
		'layouts'		=> '',
		'bottom_cat'	=> false,
		'position'		=> array(
							array('name' =>'Content top', 'value' => 'content_top', 'default' => true),
							array('name' =>'Content bottom', 'value' => 'content_bottom'),
							array('name' =>'Column left', 'value' => 'column_left'),
							array('name' =>'Column right', 'value' => 'column_right')
						),
		'status'		=> array(
							array('name' =>'Enabled', 'value' => '1', 'default' => true),
							array('name' =>'Disabled', 'value' => '0')
						),
		'sort_order'	=> ''
	);

	$default_options = array(
		'main'	=> array(
			'id'		=> '',
			'name' 		=> 'Unnamed',
			'created'	=> '',
			'modified'	=> ''
		),
		
		'style' => array(
			'shadow' => array(
				'container' => array(
					'status'	=> false,
					'mod_slider'=> false,
					'mod_nofull'=> false,
					'angle' 	=> 240,
					'distance'	=> -10,
					'blur'		=> 30,
					'color'		=> '#878787',
					'opacity'	=> 1,
					'shadow_val'=> ''
					
				),
				'thumb' => array(
					'status'	=> false,
					'angle' 	=> 240,
					'distance'	=> -10,
					'blur'		=> 30,
					'color'		=> '#878787',
					'opacity'	=> 1,
					'shadow_val'=> ''
				),
				'button' => array(
					'status'	=> false,
					'angle' 	=> 240,
					'distance'	=> -10,
					'blur'		=> 30,
					'color'		=> '#878787',
					'opacity'	=> 1,
					'shadow_val'=> ''
				),
			)
		),
		
		'product'	=> array(
			'button' => array(
				'add_to_cart' 		=> true,
				'add_to_wish_list' 	=> true,
				'add_to_compare' 	=> true,
				'see_full_details' 	=> true,
				'navigationHover'	=> true,
				'tooltip'			=> true
			),
			'name'					=> true,
			'description' 			=> true,
			'description_color'		=> '#ffffff',
			'description_bg_color'	=> '#666',
			'description_bg_opacity'=> 0.7,
			'images'				=> true,
			'images_position'		=> array(
				array('name' =>'Auto', 'value' => 'default', 'default' => true),
				array('name' =>'Top', 	 'value' => 'top'),
				array('name' =>'Bottom', 'value' => 'bottom')
				),
			'price'					=> true,
			'color_special_price'	=> '#3DFF84'
		),
		'tooltip' => array(
			'bg_color' 	=> '#000000',
			'color' 	=> '#ffffff',
			'opacity' 	=> 0.8
		),
		'thumb' => array(
			'position'			=> array(
				array('name' =>'Bottom', 		'value' => 'bottom', 'default' => true),
				array('name' =>'Top', 	'value' => 'top')
				),
			'width' 			=> 90,
			'height' 			=> 90,
			'distance'			=> 27,
			'color'				=> '#ffffff',
			'background_color'	=> '#1f1f1f',			
			'background_image'	=> '',		
			'easing'			=> '',
			'onClick'			=> ''
		),
		'image' => array(
			'width' 	=> 600,
			'height' 	=> 300,
		),
		'zoom_image' => array(
			'width' 	=> 1200,
			'height' 	=> 600,
		),
		'behavior' => array( 
			'mode' => array(
				array('name' =>'On Page', 		'value' => 'no-full', 'default' => true),
				array('name' =>'Full Screen', 	'value' => 'full'),
				array('name' =>'Slider', 		'value' => 'slider'),
				array('name' =>'Button', 		'value' => 'button'),
				array('name' =>'Hidden', 		'value' => 'hidden')
			), 
			'load_content'	=> array(
				array('name' =>'From active category', 	'value' => 'SG_category_path'),
				array('name' =>'From category page', 	'value' => 'SG_from_page'),
				array('name' =>'From product page', 	'value' => 'SG_from_page'),
				array('name' =>'All Products', 			'value' => 'SG_all_products', 'default' => true),
				array('name' =>'Best Seller', 			'value' => 'SG_best_seller'),
				array('name' =>'Popular Products', 		'value' => 'SG_popular_product'),
				array('name' =>'Latest Products', 		'value' => 'SG_latest_product')
				),
			'activate_mode' => array(
				array('name' =>'Full Screen', 	'value' => 'full', 'default' => true),
				array('name' =>'Overlay', 			'value' => 'overlay'),
				array('name' =>'On Page', 			'value' => 'no-full')
			),
			'slider_mode' => array(
				'add_to_cart' 	=> false,
				'name' 			=> false,
				'price' 		=> false
			),
			'allow_change_view' => true,
			'max_item'			=> '',  // not use
			'title'				=> true,
			'title_text'		=> '',
			'limit'				=> 8,
			
			'pagination'			=> true,
			'ajax_pagination_mode'	=> true,
			'items_per_pack'		=> 7,
			'activ_new_first_thumb'	=> true,
			
			'overlay_set'	=> array(
				'top'				=> '10%',
				'bottom'			=> '10%',
				'left'				=> '10%',
				'right'				=> '10%',
				'background_color'	=> '#FFFFFF',
				'opacity'			=> '0.8'
			),
			'quick_view_product'	=> true,
			'ie_turbo'				=> true,
			'zoom'					=> true,
			'zoom_to'				=> 'image'
		),
		'gallery' => array(
			'fullscreen'		=> true,
			'header_position'	=> array(
				array('name' =>'Center', 	'value' => 'center', 	'default' => true),
				array('name' =>'Left', 		'value' => 'left'),
				array('name' =>'Right', 	'value' => 'right')
			),
			'thumbnails'		=> true,
			
			'opacityOnGrid'		=> false,
			
			'autoAdvance'		=> false,	
			'mobileAutoAdvance'	=> false, 
			
			'header_bg_color'	=> '#1f1f1f',	
			'header_bg_image'	=> 'overlay11.png',
			'header_color'		=> '#ffffff',
			'color'				=> '#ffffff',
			
			'background_color'	=> '#1f1f1f',	
			'background_image'	=> 'overlay11.png',
			'border_radius'		=> 5,
			'border_color'		=> '#ffffff',
			'border_width'		=> '1px',
			
			'width'				=> '',
			'height'			=> '50%',
			'minHeight'			=> 200,
			
			'croped'			=> true, //true, false
			
			'thumbnails'		=> true,  
			
			'time'				=> 4000, 
			
			'skin'				=> $skin,	
			
			'easing'			=> $easing,
			'mobileEasing'		=> $easing,	
			'fx'				=> $fx_type,	
			'mobileFx'			=> $fx_type,
			'hover'				=>  true,
			'loaderColor'		=> 'red', 
			'loaderBgColor'		=> '#222222',
			'loaderOpacity'		=> .8,	
			'loaderPadding'		=> 5,	
			'loaderStroke'		=> 4,
			'navigation'		=> true,
			'navigationHover'	=> true,
			'mobileNavHover'	=> true,
			'opacityOnGrid'		=> true,
			'overlayer'			=> false,
			'playPause'			=> true,
			'pauseOnClick'		=> true,
			'slideOn'			=> 'random',	
			'time'				=> '4000',
			'transPeriod'		=> 800,
			'onEndTransition'	=> '',	
			'onLoaded'			=> '',				
			'onStartLoading'	=> '',			
			'onStartTransition'	=> ''
		),
		'data'	=> array(
			'css_style'			=> '',
			
			'selector_show_gallery'		=> '.product-info .image, .image-additional a', 
			
			'patterns'			=>  HTTP_SERVER .'catalog/view/theme/default/stylesheet/smartgallery/images/patterns/',

			'mode_button_html'	=> '<input type="button" value="%s" class="%s button gallery-show-button">',		
			'mode_button_style' => '',
			'mode_button_class' => '',

			'pagination_text'	=> '',				
			'galery_title'		=> ''				
		)

	);

?>