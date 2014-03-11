<head>
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/pcpb/css/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="catalog/view/javascript/pcpb/css/fontselector.css" />
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css"/>
    <link href='http://fonts.googleapis.com/css?family=<?php foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                echo str_replace(" ", "+", $list_link_google_fonts['key'])."|";
            } ?>' rel='stylesheet' type='text/css'/>
	<script src="catalog/view/javascript/pcpb/jquery-1.7.2.min.js"></script>        
	<script src="catalog/view/javascript/pcpb/fabric.js"></script>
	<script src="catalog/view/javascript/pcpb/canvas2image.js"></script>
	<script src="catalog/view/javascript/pcpb/base64.js"></script>
	<script src="catalog/view/javascript/pcpb/PCPB.js"></script>
	<script src="catalog/view/javascript/pcpb/jquery.ajaxupload.js"></script>  
	<script src="catalog/view/javascript/pcpb/js/colorpicker.js"></script>
	<script src="catalog/view/javascript/pcpb/js/eye.js"></script>
	<script src="catalog/view/javascript/pcpb/js/utils.js"></script>
	<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox-min.js"></script>
    <script src="catalog/view/javascript/pcpb/jquery.fontselector.js"></script>
	<style>       
		.btn{
			height:25px;
			margin-right: 15px;
			margin-top: 5px;
		}
		.border_3d{
			-webkit-box-shadow: 0px 1px 5px rgba(97, 97, 97, 0.75);
			-moz-box-shadow:    0px 1px 5px rgba(97, 97, 97, 0.75);
			box-shadow:         0px 1px 5px rgba(97, 97, 97, 0.75);
		}
		html{
			*overflow-y: auto;
			overflow: hidden;
		}
		.modalBackground {
			background-attachment: fixed;
			background-color: #FFFFFF;
			background-image: url("image/pcpb/loading.gif");
			background-position: center center;
			background-repeat: no-repeat;
			height: 100%;
			left: 0;
			opacity: 0.6;
			position: fixed;
			top: 0;
			width: 100%;
			z-index: 100000;
		}
	</style>
	
	<!-- bxSlider Javascript file -->
	<script src="catalog/view/javascript/jquery/bxslider/jquery.bxslider.js"></script>
	<!-- bxSlider CSS file -->
	<link href="catalog/view/javascript/jquery/bxslider/jquery.bxslider.css" rel="stylesheet" />

	
</head>
<body style="margin:0;">
	<input type="hidden" name="product_option_value_id" value="<?php echo $product_option_value_id; ?>" />
	<input type="hidden" id="image_option_id" name="image_option_id" value="" />
	<input type="hidden" name="product_option_price" value="<?php echo $product_option_price; ?>" />
	<div style="margin:auto; width:<?php echo $width+700+70; ?>px; height:<?php echo $height+25; ?>px">
		<div style="float:left; width:330px;">
			<fieldset class="border_3d" style="border: 1px solid #BBB; width:300px; min-height:<?php echo $height; ?>px">
				<legend><?php echo $text_edit; ?></legend>			
				<div id="pcpb_edit_text" style="border: 1px solid #BBB;height: 185px; display: none;">
					<div style="border-bottom: 1px solid #BBB;height: 13px; line-height: 13px; padding: 10px">
						<div style="float: right;font-size: 11px;">(<a href="javascript:void(0)" onclick="pcpb.copyActiveObject();"><?php echo $text_copy; ?></a>, <a href="javascript:void(0)" onclick="pcpb.deleteActiveObject();"><?php echo $text_delete; ?></a>)</div>
						<div style="float: left;font-weight: bold;"><?php echo $text_edit_text; ?></div>
					</div>
					<div>
						<table>
							<tr>
								<td style="padding-left: 20px;" width="90px" height="35px">*<?php echo $text_content; ?>:</td>
								<td><input id="pcpb_text_content" type="text" value="TEXT" onkeyup="pcpb.saveTextSetting();"/></td>
							</tr>
							<tr>
								<td style="padding-left: 27px;" height="35px"><?php echo $text_Font; ?>:</td>
								<td>
                                    <div id="pcpb_text_font" class="fontSelect">
                                        <div class="arrow-down"></div>
                                    </div>                                    
								</td>
							</tr>
							<tr>
								<td style="padding-left: 27px;" height="35px"><?php echo $text_Font_size; ?>:</td>
								<td>
									<select id="pcpb_text_fontsize" style="width: 153px;padding: 1px 0px;margin-left: 2px;" onchange="pcpb.saveTextSetting();">
									<?php for($i = 1; $i<101; $i++) {?>
										<option><?php echo $i;?></option>
									<?php } ?>
									</select>
								</td>
							</tr>
							<tr>
								<td style="padding-left: 27px;" height="35px"><?php echo $text_Color; ?>:</td>
								<td><input id="pcpb_text_color" type="text" value="#FFF" onchange="pcpb.saveTextSetting();" onkeyup="pcpb.saveTextSetting();"/></td>

<script>
$(function() {
    <?php if(isset($pcpb_enable) && (!$pcpb_enable)){ ?>        
	$('#pcpb_text_font').fontSelector({
		'hide_fallbacks' : true,
		'initial' : '<?php echo $list_link_google_fonts_options[0]['key'];?>,serif',
        'selected' : function() {pcpb.saveTextSetting();},
		'fonts' : [
			<?php $count = 0; 
            foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                if($count != count($list_link_google_fonts_options)-1){ ?>
            	'<?php echo $list_link_google_fonts['key'];?>,serif',                
            <?php $count ++; } 
            } ?>			
            '<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'			
			]
	});
    <?php } else { ?>
    $('#pcpb_text_font').fontSelector({
		'hide_fallbacks' : true,
		'initial' : '<?php echo $list_link_google_fonts_options[0]['key'];?>,serif',
        'selected' : function() {pcpb.saveTextSetting();},
		'fonts' : [
            'Arial,serif',
            'Times New Roman,serif',
            'Tahoma,serif',
            'Comic Sans MS,serif',
            'Courier New,serif',
            'Georgia,serif',
            'Lucida Console,serif',
            'Verdana,serif',
			<?php $count = 0; 
            foreach ($list_link_google_fonts_options as $list_link_google_fonts) { 
                if($count != count($list_link_google_fonts_options)-1){ ?>
            	'<?php echo $list_link_google_fonts['key'];?>,serif',                
            <?php $count ++; } 
            } ?>			
            '<?php echo $list_link_google_fonts_options[count($list_link_google_fonts_options)-1]['key'];?>,serif'            			
			]
	});
     <?php } ?>
});

$('#pcpb_text_color').ColorPicker({
	color: '#0000ff',
	onShow: function (colpkr) {
		$(colpkr).fadeIn(500);
		return false;
	},
	onHide: function (colpkr) {
		$(colpkr).fadeOut(500);
		return false;
	},
	onChange: function (hsb, hex, rgb) {
		$('#pcpb_text_color').val('#' + hex);
		pcpb.saveTextSetting();
	},
	onSubmit: function(hsb, hex, rgb) {
		$('#pcpb_text_color').val('#' + hex);
		pcpb.saveTextSetting();
	}
});
								</script>
							</tr>
							
						</table>
					</div>
				</div>
				<div id="pcpb_edit_image" style="border: 1px solid #BBB;height: 140px; display: none;">
					<div style="border-bottom: 1px solid #BBB;height: 13px; line-height: 13px; padding: 10px">
						<div style="float: right;font-size: 11px;">(<a href="javascript:void(0)" onclick="pcpb.copyActiveObject();"><?php echo $text_copy; ?></a>, <a href="javascript:void(0)" onclick="pcpb.deleteActiveObject();"><?php echo $text_delete; ?></a>)</div>
						<div style="float: left;font-weight: bold;"><?php echo $text_Edit_Image; ?></div>
					</div>
					<div>
						<div style="height: 35px; line-height:35px; margin-left: 20px;">
							<?php echo $text_Upload; ?>: <input id="pcpb_image_upload" onclick="return false;" type="file" style="width: 200px; margin-left: 15px;"/>
						</div>
						<div style="height: 35px; line-height:35px; margin-left: 20px;">
							<?php echo $text_Select_from_list; ?>: <input id="pcpb_image_select" class="button" type="button" value="Select" onclick="changeImage();" style="margin-left: 111px;"/>
						</div>
						<div style="height: 35px; line-height:35px; margin-left: 20px;">
							<?php echo $text_Flip; ?>:
							<input id="pcpb_image_horizontal" type="button" value="<?php echo $text_Horizontal; ?>" class="button" style="margin-left: 80px;" onclick="pcpb.flipHorizontalImage()"/>
							<input id="pcpb_image_vertical" type="button" value="<?php echo $text_Vertical; ?>" class="button" onclick="pcpb.flipVerticalImage()"/>
						</div>
					</div>
				</div>
				<div id="pcpb_edit_background" style="border: 1px solid #BBB;height: 110px; display: none;">
					<div style="border-bottom: 1px solid #BBB;height: 13px; line-height: 13px; padding: 10px">
						<div style="float: left;font-weight: bold;"><?php echo $text_Edit_Background; ?></div>
					</div>
					<div>
						<div style="height: 35px; line-height:35px; margin-left: 20px;">
							<?php echo $text_Upload; ?>: <input id="pcpb_background_upload" onclick="return false;" type="file" style="width: 200px; margin-left: 15px;"/>
						</div>
						<div style="height: 35px; line-height:35px; margin-left: 20px;">
							<?php echo $text_Dimension_required; ?>: <?php echo $width . ' x ' . $height; ?>
						</div>
					</div>
				</div>
			</fieldset>
			<div style="margin-top: 10px; text-align: center;">
				<input class="button" type="button" value="<?php echo $text_cancel_and_close; ?>" onclick="btnBackAndClose()"/>
				<input class="button" type="button" value="<?php echo $text_Back; ?>" onclick="btnBack()"/>
			</div>
		</div>
		<fieldset class="border_3d" style="float:left; margin-left:10px; border: 1px solid #BBB">
			<legend><?php echo $text_Custom_your_product; ?></legend>
			<div>
				<canvas id="pcpb_canvas" width="<?php echo $width; ?>" height="<?php echo $height ?>" style="border: 1px solid #DDD"></canvas>
			</div>
			<div style="margin-top: 5px;" id="btn-pcpb">
				<div id="selector-layout" style="display:none;width:100%;margin:10px 0;padding: 10px 0;height:100px;"><ul class="bxslider" style="margin:0;"></ul></div>
				<?php if($add_text_enable == 1) { ?>
					<input class="button btn" type="button" value="<?php echo $text_Add_Text; ?>" onclick="pcpb.addText('New Text',<?php echo $width; ?>,<?php echo $height; ?>)"/>
				<?php } ?>
				<?php if($add_images_enable == 1) { ?>
					<input type="button" class="button btn" value="<?php echo $text_Add_Image;?>" onclick="pcpb.addImage('image/pcpb/sample.jpg',<?php echo $width; ?>,<?php echo $height; ?>)"/>
				<?php } ?>
				<?php if($change_bg_enable == 1) { ?>
					<input type="button" class="button btn" value="<?php echo $text_Change_Background; ?>" id="btn_change_background" onclick="btnChangeBackground()"/>
					<input type="button" class="button btn"value="<?php echo $text_Reset_Background; ?>" onclick="setOriginBackground();" />
				<?php } ?>
				<input class="button" type="button" style="float: right;" onclick="finish()" value="<?php echo $text_Finish; ?>" />
				<div style="margin-top: 5px;">
					<input type="button" class="button btn" value="Move to Front" onclick="pcpb.movetoFront()"/>
					<input type="button" class="button btn" value="Move to Back" onclick="pcpb.movetoBack()"/>
				</div>
			</div>
		</fieldset>
	</div>
	<div id="spinner" class="modalBackground" style="display: none;"></div>
	
	<script>
		
		var slider = $('.bxslider').bxSlider({
				minSlides: 1,
				maxSlides: 4,
				slideWidth: 100,
				slideMargin: 10,
				pager: false
			});
			
		//resize popup
		var width = <?php echo 388 + $width; ?>;
		if(width < 910)
			width = 910;
		var height = <?php echo 150 + $height; ?>;
		var changeBGInit = false;
		var changeImageInit = false;
		parent.resizePopupPCPB(width, height);
		function setOptionImageId(id){
			$('#image_option_id').val(id);
		}
		function btnBackAndClose(){
			if(!confirm('<?php echo $text_All_text_image_cleared; ?>'))
				return;
			parent.closePopupPCPB();
		}
		function btnBack(){
			if(!confirm('<?php echo $text_All_text_image_cleared; ?>'))
				return;
			location.href='index.php?route=pcpb/create&product_id=<?php echo $product_id ?>'
		}
		function btnChangeBackground(){
			$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
			$('#pcpb_edit_background').show();
			if(changeBGInit == false){
				changeBGInit = true;
				$('#pcpb_background_upload').ajaxUploadPrompt({
					type: 'POST',
					url: 'index.php?route=pcpb/upload',
					dataType: 'json',
					success: function(datas){
						if(typeof(datas) == 'string')
						{
							//fix for IE problem
							eval('datas = ' + datas);
						}
						if(datas.errorCode != 0)
							alert(datas.errorMessage);
						else{
							var imagePath = datas.imagePath;
							setBackground(imagePath);
						}
					}
				});
			}
		}
		function changeImage(){
			$.colorbox({
				overlayClose: false,
				opacity: 0.5,
				iframe: true,
				href: 'index.php?route=pcpb/create/selectImage&product_id=<?php echo $product_id ?>',
				width: '90%',
				height: '100%',
				open: true
			});
		}
		function setBackground(imagePath){
			if(typeof(imagePath) != 'undefined' && imagePath != '')
				pcpb.setBackgroundImage(imagePath);
		}
		function setOriginBackground(){
			if(typeof(originBG) != 'undefined' && originBG != '')
				pcpb.setBackgroundImage(originBG);
		}
		function closePopupPCPB(){
			$.colorbox.close();
		}
		function finish(){
			if(!confirm('<?php echo $text_All_text_image_converted; ?>'))
				return;
			var canvasData = pcpb.saveToImage();
			//split data to pieces with 90kb/piece
			var pieceCount = parseInt(canvasData.length/90000+1);
			var link = '<?php echo $link; ?>';
			var pieceIndex = 0;
			$('#spinner').show();
			sendData(pieceIndex, pieceCount, canvasData);
		}
		function sendData(index, count, data){
			var dataSend = data.substring(index*90000, (index+1)*90000);
			$.ajax({
				type: 'POST',
				url: 'index.php?route=pcpb/create/step3',
				dataType: 'json',
				data: {imageData: dataSend, imageIndex: index+1, imageCount: count},
				success: function(datas){
					console.log(datas);
					if(datas.errorCode != 0)
						alert(datas.errorMessage);
					else{
						index++;
						if(index<count)
							sendData(index,count,data);
						else{
							var token = datas.token;
							location.href='index.php?route=pcpb/create/finish&token=' + token + '&product_id=<?php echo $product_id ?>&product_option_price=<?php echo $product_option_price;?>&product_option_value_id=<?php echo $product_option_value_id; ?>&image_option_id=' + $('#image_option_id').val();						
						}
					}
				}
			})
		}

		//init for canvas manager
		var pcpb = new PCPB('pcpb_canvas');
		<?php if (!empty($background)) { ?>
			var originBG = '<?php echo $background;?>';
			pcpb.setBackgroundImage(originBG);
		<?php } ?>
		
	</script>
</body>