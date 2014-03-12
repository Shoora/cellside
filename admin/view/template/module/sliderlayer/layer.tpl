<?php echo $header; $module_row=0; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success_msg) { ?>
  <div class="success"><?php echo $success_msg; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">

      		<a onclick="$('#slider-form').submit();" class="button"><?php echo $button_save; ?></a>
      		<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      		<a id="btn-preview-ingroup" href="<?php echo  $this->url->link('module/pavsliderlayer/preview', 'id='.$group_id.'&token=' . $this->session->data['token'], 'SSL');?>" class="button green" id="preview"><?php echo $this->language->get('Preview Sliders In Group');?></a>
      </div>
    </div>

    <div class="page-content">
    		<h3><?php echo $this->language->get('List Of Sliders In Group');?>: <a href="<?php echo  $this->url->link('module/pavsliderlayer', 'id='.$group_id.'&token=' . $this->session->data['token'], 'SSL');?>"><span><?php echo $sliderGroup['title'];?></span></a></h3>
    	 	<div>
				<p class="explain"><?php echo $this->language->get('drap and drop to sort slider in list');?></p>
    	 	</div>
    		<div class="group-sliders clearfix">
    			<div class="new-slider-item">
	    			<a href="<?php echo  $this->url->link('module/pavsliderlayer/layer', 'group_id='.$group_id.'&token=' . $this->session->data['token'], 'SSL')?>">
	    			</a>
	    			<div><?php echo $this->language->get('text_create_new');?></div>
    			</div>
    			<?php foreach( $sliders as $slider )  { ?>
    				<div class="slider-item <?php echo ( $slider['id'] == $slider_id ? 'active':'');?>" id="slider_<?php echo $slider['id'];?>">
    					<a class="image" href="<?php echo  $this->url->link('module/pavsliderlayer/layer', 'id='.$slider['id'].'&group_id='.$slider['group_id'].'&token=' . $this->session->data['token'], 'SSL')?>">
    						<img src="<?php echo HTTP_CATALOG."image/".$slider["image"];?>" height="86"/>
    					</a>
    					<a  title="<?php echo $this->language->get('text_clone_this');?>" class="slider-clone" href="<?php echo  $this->url->link('module/pavsliderlayer/copythis', 'id='.$slider['id'].'&group_id='.$slider['group_id'].'&token=' . $this->session->data['token'], 'SSL')?>"><span>Clone</span></a>
    					<a  title="<?php echo $this->language->get('text_delete_this');?>" class="slider-delete" href="<?php echo  $this->url->link('module/pavsliderlayer/deleteslider', 'id='.$slider['id'].'&group_id='.$slider['group_id'].'&token=' . $this->session->data['token'], 'SSL')?>" onclick="return confirm('<?php echo $this->language->get('text_confirm_delete');?>')"><span>Delete</span></a>

    					<a class="slider-status<?php if( !$slider['status']) { ?> slider-status-off <?php } ?>" href="<?php echo  $this->url->link('module/pavsliderlayer/layer', 'id='.$slider['id'].'&group_id='.$slider['group_id'].'&token=' . $this->session->data['token'], 'SSL')?>"><span>Status</span></a>
    					<div><?php echo $slider['title']; ?></div>
    				</div>	
    			<?php } ?>
    		</div>


    		<div class="clearfix"></div>
    		<?php if( $slider_id )  { ?> 
    		<h3><?php echo $this->language->get('text_edit_slider');?> <span><?php echo $slider_title;?></span></h3>
    		<?php  } else { ?>
    			<h3><?php echo $this->language->get('text_create_new_slider');?></h3>
    		<?php } ?>
 			<form action="" method="post" id="slider-editor-form">
 				 <div id="slider-warning" class=""></div>
 					<input type="hidden" id="slider_group_id" name="slider_group_id" value="<?php echo $group_id;?>"/>
	    		<div class="slider-params-wrap">
	    				<div class="slider-params">
	    					<table class="form">
	    						<tr>
	    							<td> <?php echo $this->language->get("Title")?> </td>
	    							<td><input type="text" name="slider_title" size="100" value="<?php echo $slider_title;?>"></td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Status")?> </td>
	    							<td>
	    								<select name="slider_status">
	    									<?php foreach( $yesno as $key => $value ) { ?>
	    									<option value="<?php echo $key;?>" <?php if( $key == $params['slider_status'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
	    									 <?php } ?>
	    									
	    								</select>	
	    								</td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Transition")?></td>
	    							<td>
	    								<select name="slider_transition">
	    									<?php foreach( $transtions as $key => $value ) { ?>
	    									<option value="<?php echo $key;?>" <?php if( $key == $params['slider_transition'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
	    									 <?php } ?>
	    								</select>	
	    								</td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Slot Amount");?></td>
	    							<td><input type="text" name="slider_slot" value="<?php echo $params['slider_slot'];?>"></td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Transition Rotation")?></td>
	    							<td><input type="text" name="slider_rotation" value="<?php echo $params['slider_rotation'];?>"></td>
	    						</tr>
	    						<tr>
	    							<td> <?php echo $this->language->get("Transition Duration")?> </td>
	    							<td><input type="text" name="slider_duration" value="<?php echo $params['slider_duration'];?>" ></td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Delay")?>  </td>
	    							<td><input type="text" name="slider_delay" value="<?php echo $params['slider_delay'];?>"></td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Enable Link")?>  </td>
	    							<td> 
	    							 	<select value="slider_enable_link">
	    									<?php foreach( $yesno as $key => $value ) { ?>
	    									<option value="<?php echo $key;?>" <?php if( $key == $params['slider_enable_link'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
	    									 <?php } ?>
	    									
	    								</select>	
	    							</td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get("Link")?></td>
	    							<td><input type="text" name="slider_link" value="<?php echo $params['slider_link'];?>"></td>
	    						</tr>
	    						<tr>
	    							<td> <?php echo $this->language->get("Thumbnail")?> </td>
	    						
	    							
	    								 <td class="left"><div class="image">
	    								 			<?php $no_image= ''; ?>
	    				<img src="<?php echo $slider_thumbnail; ?>" alt="" id="thumb_slider_thumbnail" />
                 	<input type="hidden" name="slider_thumbnail" id="slider_thumbnail" value="<?php echo $params['slider_thumbnail'];?>">
                  <br />
                  <a onclick="image_upload('slider_thumbnail', 'thumb_slider_thumbnail');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb_slider_thumbnail').attr('src', '<?php echo $no_image; ?>'); $('#slider_thumbnail').attr('value', '');"><?php echo $text_clear; ?></a></div></td>

	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get('Full Width Video');?></td>
	    							<td>
	    								<div>
	    								<select name="slider_usevideo">
	    									<?php foreach( $usevideo as $key => $value ) { ?>
	    									<option value="<?php echo $key;?>" <?php if( $key == $params['slider_usevideo'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
	    									 <?php } ?>
	    									
	    								</select>
	    								</div>
	    								<div>
	    									<?php echo $this->language->get('Video ID');?>
	    									<input type="text" name="slider_videoid" value="<?php echo $params['slider_videoid'];?>">
	    								</div>
	    							</td>
	    						</tr>
	    						<tr>
	    							<td><?php echo $this->language->get('Auto Play');?></td>
	    							<td>
	    								<select name="slider_videoplay">
	    									<?php foreach( $yesno as $key => $value ) { ?>
	    									<option value="<?php echo $key;?>" <?php if( $key == $params['slider_videoplay'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
	    									 <?php } ?>
	    									
	    								</select>	
	    							</td>
	    						</tr>
	    					</table>	
	    				</div>
					  	
			  	</div>
			  	<input name="slider_id" type="hidden" id="slider_id" value="<?php echo $slider_id;?>" />	
			  	<input name="slider_image" id="slider-image" type="hidden" value="<?php echo $slider_image;?>">
		 	 </form>
		 	 <div class="clearfix"></div>
	<div class="buttons">
				  			<div class="btn orange" id="btn-update-slider">
				  				<?php echo $this->language->get("Update Image Slider")?>
				  			</div>

				  			<div class="btn pull-right " onclick="$('#slider-form').submit();" class="button"><?php echo $button_save; ?></div>	
				  			
				  			<div class="btn pull-right grey" id="btn-preview-slider">
				  				<?php echo $this->language->get("Preview This Slider")?>
				  			</div>

        
    </div>
<div class="layers-wrapper clearfix" id="slider-toolbar">
		<h3><?php echo $this->language->get("Layers Editor")?></h3> 
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"  id="slider-form">

				<div class="slider-toolbar">
						<h4><?php echo $this->language->get("Tools Action")?></h4>
						<ul>
							<li><div class="btn btn-create" href="#" data-action="add-image"><div class="icon-image icon"></div><?php echo $this->language->get("Add Layer Image")?></div></li>
							<li><div class="btn btn-create" href="#" data-action="add-video"><div class="icon-video icon"></div><?php echo $this->language->get("Add Layer Video")?></div></li>
							<li><div class="btn btn-create" href="#" data-action="add-text"><div class="icon-text icon"></div><?php echo $this->language->get("Add Layer Text")?></div></li>
						</ul>	
						<div class="btn-delete" data-action="delete-layer"><div class="icon-delete icon"></div></div>
			    </div>
		 		<div class="slider-layers" >
				

			   
			    <div class="slider-editor-wrap" style="width:<?php echo $sliderWidth;?>px;height:<?php echo $sliderHeight;?>px">	
			    	<div class="simage">
			    		<img src="<?php echo $slider_image_src;?>">
			    	</div>
				    <div class="slider-editor" id="slider-editor" style="width:<?php echo $sliderWidth;?>px;height:<?php echo $sliderHeight;?>px">
				    		
				    </div>
				</div>
						<div class="layer-video-inpts" id="dialog-video">
							 
								<table class="form">
									<tr>
										<td><?php echo $this->language->get("Video Type")?></td>
										<td>
												<select name="layer_video_type" id="layer_video_type">
													<option value="youtube"><?php echo $this->language->get("Youtube");?></option>
													<option value="vimeo"><?php echo $this->language->get("Vimeo");?></option>
												</select>	
										</td>
									</tr>
									<tr>
										<td>Video ID</td>
										<td><input name="layer_video_id" type="text" id="dialog_video_id">
											<p><?php echo $this->language->get("for example youtube");?>: <b>VA770wpLX-Q</b> and vimeo: <b>17631561</b> </p>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<label><?php echo $this->language->get("Height")?></label>
											<input name="layer_video_height" type="text" value="200">
											<label><?php echo $this->language->get("Width")?></label>
											<input name="layer_video_width" type="text" value="300">
											
										</td>
								   </tr>
									<tr>
										<td colspan="2">
					                        <input type="hidden" name="layer_video_thumb" id="layer_video_thumb">
					                        <div class="buttons">
												<div class="btn layer-find-video"><?php echo $this->language->get("Find Video")?></div>
												<div class="btn layer-apply-video" id="apply_this_video" style="display:none;"><?php echo $this->language->get("Use This Video")?></div>
												<div class="btn btn-green" onclick="$('#dialog-video').hide();"><?php echo $this->language->get("Close");?></div>
											</div>
										</td>
									</tr>	
								</table>
								
								<div id="video-preview"></div>
						</div>	


			 			 <div class="slider-foot">

			  
		  		 				 <div class="layer-collection-wrapper">
		  		 				 	 <h4><?php echo $this->language->get("Layer Collection")?></h4>
							    	 <div class="layer-collection" id="layer-collection"></div>	
							 	</div>
								 <div class="layer-form" id="layer-form">
								 			<h4><?php echo $this->language->get("Edit Layer Data")?></h4>
								 			<input type="hidden" id="layer_id" name="layer_id"/>
									  		<input type="hidden" id="layer_content" name="layer_content"/>
									  		<input type="hidden" id="layer_type" name="layer_type"/>

											<table class="form">
												<tr>
													<td>Class Style</td>
													<td>

														<input type="text" name="layer_class" id="input-layer-class"/>
														<span class="buttons">
															<span class="btn btn-clear" onclick="$('#input-layer-class').val('')">><?php echo $this->language->get("Clear");?></span> |
															<span class="btn btn-typo" id="btn-insert-typo"><?php echo $this->language->get("Insert Typo")?></span>
														</span>

													</td>
												</tr>
												<tr>
													<td><?php echo $this->language->get("Text")?></td>
													<td>
														<textarea style="width:90%; height:60px" name="layer_caption" id="input-slider-caption" data-for="caption-layer" ></textarea>
														<br/>
														<?php echo $this->language->get("Allow insert html code");?>
													</td>
												</tr>

												<tr>
													<td><?php echo $this->language->get("Effect")?></td>
													<td><label><?php echo $this->language->get("Animation")?></label>
															<select name="layer_animation">
																<option selected="selected" value="fade"><?php echo $this->language->get("Fade");?></option>
																<option value="sft"><?php echo $this->language->get("Short from Top");?></option>
																<option value="sfb"><?php echo $this->language->get("Short from Bottom");?></option>
																<option value="sfr"><?php echo $this->language->get("Short from Right");?></option>
																<option value="sfl"><?php echo $this->language->get("Short from Left");?></option>
																<option value="lft"><?php echo $this->language->get("Long from Top");?></option>
																<option value="lfb"><?php echo $this->language->get("Long from Bottom");?></option>
																<option value="lfr"><?php echo $this->language->get("Long from Right");?></option>
																<option value="lfl"><?php echo $this->language->get("Long from Left");?></option>
																<option value="randomrotate"><?php echo $this->language->get("Random Rotate");?></option>
															</select>	
															<p>	
																<label><?php echo $this->language->get("Easing")?></label>
																<select name="layer_easing">
																	<option value="easeOutBack">easeOutBack</option>
																	<option value="easeInQuad">easeInQuad</option>
																	<option value="easeOutQuad">easeOutQuad</option>
																	<option value="easeInOutQuad">easeInOutQuad</option>
																	<option value="easeInCubic">easeInCubic</option>
																	<option value="easeOutCubic">easeOutCubic</option>
																	<option value="easeInOutCubic">easeInOutCubic</option>
																	<option value="easeInQuart">easeInQuart</option>
																	<option value="easeOutQuart">easeOutQuart</option>
																	<option value="easeInOutQuart">easeInOutQuart</option>
																	<option value="easeInQuint">easeInQuint</option>
																	<option value="easeOutQuint">easeOutQuint</option>
																	<option value="easeInOutQuint">easeInOutQuint</option>
																	<option value="easeInSine">easeInSine</option>
																	<option value="easeOutSine">easeOutSine</option>
																	<option value="easeInOutSine">easeInOutSine</option>
																	<option value="easeInExpo">easeInExpo</option>
																	<option selected="selected" value="easeOutExpo">easeOutExpo</option>
																	<option value="easeInOutExpo">easeInOutExpo</option>
																	<option value="easeInCirc">easeInCirc</option>
																	<option value="easeOutCirc">easeOutCirc</option>
																	<option value="easeInOutCirc">easeInOutCirc</option>
																	<option value="easeInElastic">easeInElastic</option>
																	<option value="easeOutElastic">easeOutElastic</option>
																	<option value="easeInOutElastic">easeInOutElastic</option>
																	<option value="easeInBack">easeInBack</option>
																	<option value="easeOutBack">easeOutBack</option>
																	<option value="easeInOutBack">easeInOutBack</option>
																	<option value="easeInBounce">easeInBounce</option>
																	<option value="easeOutBounce">easeOutBounce</option>
																	<option value="easeInOutBounce">easeInOutBounce</option>
																</select>	
															</p>	
													</td>

												</tr>	
												<tr>
													<td><?php echo $this->language->get("Speed")?>								
													</td>
													<td>
														<input name="layer_speed" type="text">
													</td>
													
												</tr>
												<tr>
													<td>
														<?php echo $this->language->get("Position");?>
													</td>
													<td>
														<label><?php echo $this->language->get("Top");?>:</label><input size="3" type="text" name="layer_top">
														<label><?php echo $this->language->get("Left");?>:</label><input size="3" type="text" name="layer_left">
												</tr>
											</table>
											<div class="other-effect">
													<h5><?php echo $this->language->get("Other Animation");?></h5>
														<table class="form">
															<tr>
																<td><?php echo $this->language->get("End Time");?></td>
																<td><input type="text" name="layer_endtime"> </td>
															</tr>
															<tr>
																<td><?php echo $this->language->get("End Speed");?></td>
																<td><input type="text" name="layer_endspeed"> </td>
															</tr>
															<tr>
																<td><?php echo $this->language->get("End Animation");?></td>
																<td>
																	<select type="text" name="layer_endanimation"> 
																	<option selected="selected" value="auto"><?php echo $this->language->get("Choose Automatic");?></option>
																	<option value="fadeout"><?php echo $this->language->get("Fade Out");?></option>
																	<option value="stt"><?php echo $this->language->get("Short to Top");?></option>
																	<option value="stb"><?php echo $this->language->get("Short to Bottom");?></option>
																	<option value="stl"><?php echo $this->language->get("Short to Left");?></option>
																	<option value="str"><?php echo $this->language->get("Short to Right");?></option>
																	<option value="ltt"><?php echo $this->language->get("Long to Top");?></option>
																	<option value="ltb"><?php echo $this->language->get("Long to Bottom");?></option>
																	<option value="ltl"><?php echo $this->language->get("Long to Left");?></option>
																	<option value="ltr"><?php echo $this->language->get("Long to Right");?></option>
																	<option value="randomrotateout"><?php echo $this->language->get("Random Rotate Out");?></option>
																</select>
																</td>
															</tr>	
															<tr>
																<td><?php echo $this->language->get("End Easing");?></td>
																<td>
																	<select   name="layer_endeasing"> 
																	<option selected="selected" value="nothing">No Change</option>
																	<option value="easeOutBack">easeOutBack</option>
																	<option value="easeInQuad">easeInQuad</option>
																	<option value="easeOutQuad">easeOutQuad</option>
																	<option value="easeInOutQuad">easeInOutQuad</option>
																	<option value="easeInCubic">easeInCubic</option>
																	<option value="easeOutCubic">easeOutCubic</option>
																	<option value="easeInOutCubic">easeInOutCubic</option>
																	<option value="easeInQuart">easeInQuart</option>
																	<option value="easeOutQuart">easeOutQuart</option>
																	<option value="easeInOutQuart">easeInOutQuart</option>
																	<option value="easeInQuint">easeInQuint</option>
																	<option value="easeOutQuint">easeOutQuint</option>
																	<option value="easeInOutQuint">easeInOutQuint</option>
																	<option value="easeInSine">easeInSine</option>
																	<option value="easeOutSine">easeOutSine</option>
																	<option value="easeInOutSine">easeInOutSine</option>
																	<option value="easeInExpo">easeInExpo</option>
																	<option value="easeOutExpo">easeOutExpo</option>
																	<option value="easeInOutExpo">easeInOutExpo</option>
																	<option value="easeInCirc">easeInCirc</option>
																	<option value="easeOutCirc">easeOutCirc</option>
																	<option value="easeInOutCirc">easeInOutCirc</option>
																	<option value="easeInElastic">easeInElastic</option>
																	<option value="easeOutElastic">easeOutElastic</option>
																	<option value="easeInOutElastic">easeInOutElastic</option>
																	<option value="easeInBack">easeInBack</option>
																	<option value="easeOutBack">easeOutBack</option>
																	<option value="easeInOutBack">easeInOutBack</option>
																	<option value="easeInBounce">easeInBounce</option>
																	<option value="easeOutBounce">easeOutBounce</option>
																	<option value="easeInOutBounce">easeInOutBounce</option>
																</select>
																</td>
															</tr>		
														</table>

											</div>
									 </div>
				</div>
    </div>

</form>

</div>
  </div>
</div>
<script type="text/javascript"><!--
 


$(".group-sliders").sortable({ accept:".slider-item",
								  update:function() {   
								  	 var ids = $( ".slider-item" ).sortable( "toArray" );
								  	 var params = '';
								  	 var j=1;
								  	 $.each( ids, function(i,e){
								  	 	params += 'id['+$(e).attr('id').replace("slider_","")+']='+(j++)+"&";
								  	 } );

								  	 $.ajax({
										 url:'<?php echo str_replace("&amp;","&",$actionUpdatePostURL); ?>',
										data: params,
										type:'POST'
										});
								  	 // alert( params );
 							      } 
});

$("#btn-update-slider").click( function(){ 
			var field = 'slider-image';
			$('#dialog').remove();
			
			$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
			
			$('#dialog').dialog({
				title: 'Image Management',
				close: function (event, ui) {
					if ( $('#' + field).attr('value')) { 
						var src= '<?php echo HTTP_CATALOG?>image/'+$('#' + field).attr('value');
						$(".slider-editor-wrap .simage").html( '<img src="'+src+'">'  ); 
					}
				},	
				bgiframe: false,
				width: 700,
				height: 400,
				resizable: false,
				modal: false
		});
});


//--></script> 

<?php 


 // echo '<pre>'.print_r( $sliderGroup,1 ); die;
?> 
<script type="text/javascript">
	$( document ).ready( function(){
		var JSONLIST = '<?php echo json_encode( $layers ); ?>';
		 
		var $pavoEditor = $(document).pavoSliderEditor(); 
		var SURLIMAGE = 'index.php?token=<?php echo $token; ?>';
		var SURL = '<?php echo HTTP_CATALOG ?>';
		$pavoEditor.process(SURL, SURLIMAGE, <?php echo $sliderGroup['params']['delay']; ?> ); 
		$pavoEditor.createList( JSONLIST  );
	});


	$("#btn-preview-ingroup").click( function(){
		var url = $(this).attr("href");
			$('#dialog').remove();
			$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe name="iframename2" src="'+url+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
			$('#dialog').dialog({
				title: 'Preview Management',
				close: function (event, ui) {
 
				},	
				bgiframe: true,
				width: 1000,
				height: 500,
				resizable: false,
				modal: true
		});	 
		return false; 
	} );
</script>
<script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
<?php echo $footer; ?>