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
  <?php if (isset($success) && $success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      	
     
      <div class="buttons pull-right">
      			<a onclick="$('#form').submit();" class="button"><?php echo $this->language->get('Save All And Edit Group'); ?></a>
      			<a onclick="$('#action_mode').val('create-new');$('#form').submit();" class="button"><?php echo $this->language->get('Save All And Create New Group'); ?></a>
      			<a onclick="$('#action_mode').val('module-only');$('#form').submit();" class="button grey"><?php echo 'Save Modules Only'; ?></a>
      			<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
        	</div>

    </div>
    <div class="page-content">
    
    	

 	 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    	<div class="htabs" id="tabs-modules">
	    			
	    			<a href="#tab-slidergroups" ><?php echo $this->language->get("Slider Groups Management");?></a>
	    			<a href="#tab-listmodules"  ><?php echo $this->language->get("Modules Asignment");?></a>
	    			 <a href="#tab-importtools"  ><?php echo $this->language->get("Import Tools");?></a>
	    	</div>


	    	<div id="tab-listmodules">

	    			<table id="module" class="list">
					          <thead>
					            <tr>
					              <td class="left"><?php echo $entry_banner; ?></td>
					           
					              
					            
					              <td class="left"><?php echo $entry_layout; ?></td>
					              <td class="left"><?php echo $entry_position; ?></td>
					              <td class="left"><?php echo $entry_status; ?></td>
					              <td class="right"><?php echo $entry_sort_order; ?></td>
					              <td></td>
					            </tr>
					          </thead>
					          <?php $module_row = 0; ?>
					          <?php foreach ($modules as $module) { ?>
					          <tbody id="module-row<?php echo $module_row; ?>">
					            <tr>
					              <td class="left"><select name="pavsliderlayer_module[<?php echo $module_row; ?>][group_id]">
					                 <?php foreach ($slidergroups as $sg) { ?>
					                  <?php if ($sg['id'] == $module['group_id']) { ?>
					                  <option value="<?php echo $sg['id']; ?>" selected="selected"><?php echo $sg['title']; ?></option>
					                  <?php } else { ?>
					                  <option value="<?php echo $sg['id']; ?>"><?php echo $sg['title']; ?></option>
					                  <?php } ?>
					                  <?php } ?>
					                </select></td>
					               
					              <td class="left">
					              	<select name="pavsliderlayer_module[<?php echo $module_row; ?>][layout_id]">
					                  <?php foreach ($layouts as $layout) { ?>
					                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
					                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
					                  <?php } else { ?>
					                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
					                  <?php } ?>
					                  <?php } ?>
					                </select></td>
					              <td class="left"><select name="pavsliderlayer_module[<?php echo $module_row; ?>][position]">
					                  <?php if ($module['position'] == 'content_top') { ?>
					                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
					                  <?php } else { ?>
					                  <option value="content_top"><?php echo $text_content_top; ?></option>
					                  <?php } ?>
					                  <?php if ($module['position'] == 'content_bottom') { ?>
					                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
					                  <?php } else { ?>
					                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
					                  <?php } ?>
					                  <?php if ($module['position'] == 'column_left') { ?>
					                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
					                  <?php } else { ?>
					                  <option value="column_left"><?php echo $text_column_left; ?></option>
					                  <?php } ?>
					                  <?php if ($module['position'] == 'column_right') { ?>
					                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
					                  <?php } else { ?>
					                  <option value="column_right"><?php echo $text_column_right; ?></option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'mainmenu') { ?>
					                  <option value="mainmenu" selected="selected">Main Menu</option>
					                  <?php } else { ?>
					                  <option value="mainmenu">Main Menu</option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'slideshow') { ?>
					                  <option value="slideshow" selected="selected">Slideshow</option>
					                  <?php } else { ?>
					                  <option value="slideshow">Slideshow</option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'promotion') { ?>
					                  <option value="promotion" selected="selected">Promotion</option>
					                  <?php } else { ?>
					                  <option value="promotion">Promotion</option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'footer_top') { ?>
					                  <option value="footer_top" selected="selected">Footer Top</option>
					                  <?php } else { ?>
					                  <option value="footer_top">Footer Top</option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'footer_center') { ?>
					                  <option value="footer_center" selected="selected">Footer Center</option>
					                  <?php } else { ?>
					                  <option value="footer_center">Footer Center</option>
					                  <?php } ?>
									  
									  <?php if ($module['position'] == 'footer_bottom') { ?>
					                  <option value="footer_bottom" selected="selected">Footer Bottom</option>
					                  <?php } else { ?>
					                  <option value="footer_bottom">Footer Bottom</option>
					                  <?php } ?>
									  
					                </select></td>
					              <td class="left"><select name="pavsliderlayer_module[<?php echo $module_row; ?>][status]">
					                  <?php if ($module['status']) { ?>
					                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
					                  <option value="0"><?php echo $text_disabled; ?></option>
					                  <?php } else { ?>
					                  <option value="1"><?php echo $text_enabled; ?></option>
					                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
					                  <?php } ?>
					                </select></td>
					              <td class="right"><input type="text" name="pavsliderlayer_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
					              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
					            </tr>
					          </tbody>
					          <?php $module_row++; ?>
					          <?php } ?>
					          <tfoot>
					            <tr>
					              <td colspan="5"></td>
					              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
					            </tr>
					          </tfoot>
					        </table>

	    	</div>
	    	
    
     <div id="tab-slidergroups">
	    	
     
      	<input type="hidden" name="action_mode" id="action_mode">
		<div class="groups">
				<h4><?php echo $this->language->get('Slider Groups');?></h4>
				<ul>
					<?php foreach( $slidergroups as $sgroup ) {  ?> <li>	
					<a <?php if( $sgroup['id'] == $id ) { ?> class="active" <?php } ?> href="<?php echo $this->url->link('module/pavsliderlayer', 'id='.$sgroup['id'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $sgroup['title'];?>
						<span>(ID:<?php echo $sgroup['id'];?>)</span>
					</a> 


					</li>
					<?php } ?>
				</ul>
		</div>	
		<div class="group-form">
			<h4><?php echo $this->language->get('Slider Group Form');?>

					<?php if( $id ) { ?>
					<?php echo $this->language->get('Edit');?> <span><?php echo $params['title'];?></span>
					<?php } else { ?>
					<?php echo $this->language->get('Create New');?>
					<?php } ?>
			</h4>
			<table class="form">
				<tr>
					<td>ID: <?php echo $id;?>
						<input type="hidden" name="id" value="<?php echo $id; ?>"> 
					</td>
					<td>
						  <?php if( $id ) { ?> 
						<div class="buttons">
							
							<a id="btn-preview-ingroup" href="<?php echo  $this->url->link('module/pavsliderlayer/preview', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL');?>" class="button grey" id="preview"><?php echo $this->language->get('Preview Sliders In Group');?></a>

							<a href="<?php echo  $this->url->link('module/pavsliderlayer/layer', 'group_id='.$id.'&token=' . $this->session->data['token'], 'SSL');?>" class="btn btn-green" id="preview-sliders"><?php echo 'Manages Sliders'; ?></a>

							<a href="<?php echo  $this->url->link('module/pavsliderlayer/delete', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL');?>" onclick="return confirm('Are you sure to delete this');" class="btn " id="preview-sliders">
								<?php echo 'Delete'; ?>
							</a>


							<a href="<?php echo  $this->url->link('module/pavsliderlayer/export', 'id='.$id.'&token=' . $this->session->data['token'], 'SSL');?>"  class="btn orange" id="preview-sliders">
								<?php echo $this->language->get('Export Group And Sliders'); ?>
							</a>
						</div>	
						<?php } ?>
					</td>	
				<tr>
				<tr>
					<td><?php echo $this->language->get('Slide Group Title');?></th>
					 <td><input type="text" name="slider[title]" value="<?php echo $params['title'];?>"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Delay');?></td>
					<td><input type="text" name="slider[delay]" value="<?php echo $params['delay'];?>"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('FullWidth Mode');?></td>
					<td>
				 		<select name="slider[fullwidth]">
							<?php foreach( $fullwidth as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( isset($params['fullwidth']) && ($key == $params['fullwidth']) ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>
							
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Slider Demension');?></td>
					<td>
						<label><?php echo $this->language->get('Width');?></label>
						<input type="text" name="slider[width]" value="<?php echo $params['width'];?>"/>
						<label>Height</label>
						<input type="text" name="slider[height]" value="<?php echo $params['height'];?>"/>
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Touch Mobile');?></td>
					<td>	
						<select name="slider[touch_mobile]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['touch_mobile'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>
							
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Stop On Hover');?></td>
					<td>
						<select name="slider[stop_on_hover]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['stop_on_hover'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Shuffle Mode');?></td>
					<td>
						<select name="slider[shuffle_mode]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['shuffle_mode'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Image Cropping');?></td>
					<td>
						<select name="slider[image_cropping]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['image_cropping'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
			</table> 
			<h4><?php echo $this->language->get('Image Cropping');?></h4>
			<table class="form">
				<tr>
					<td><?php echo $this->language->get('Shadow Type');?></th>
					 <td>
					 	<select name="slider[shadow_type]">
							<?php foreach( $shadow_types as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['shadow_type'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					 </td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Show Time Line');?></td>
					<td>
						<select name="slider[show_time_line]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['show_time_line'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td>Time Liner Position</td>
					<td>
						<select name="slider[time_line_position]">
							<?php foreach( $linepostions as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['time_line_position'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Background Color');?></td>
					<td>
						<input type="text" name="slider[background_color]" value="<?php echo $params['background_color'];?>"/>		
						 
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Margin');?></td>
					<td>
						<input type="text" name="slider[margin]" value="<?php echo $params['margin'];?>"/> Example: 5px 0; or 5px 10px 20px
					 
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Padding(border)');?></td>
					<td>
						<input type="text" name="slider[padding]" value="<?php echo $params['padding'];?>"/> Example: 5px 0; or 5px 10px 20px
					 
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Show Background Image');?></td>
					<td>
						<select name="slider[background_image]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['background_image'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Background URL');?></td>
					<td>
						<input type="text" value="<?php echo $params['background_url'];?>" name="slider[background_url]"/>
							 
					</td>
				</tr>
				
			</table> 
			<h4><?php echo $this->language->get('Navigator');?></h4>
			<table class="form">
				<tr>
					<td><?php echo $this->language->get('Navigator Type');?></th>
					 <td>
					 	<select name="slider[navigator_type]">
							<?php foreach( $navigator_types as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['navigator_type'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					 </td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Arrows');?></td>
					<td>
						<select name="slider[navigator_arrows]">
							<?php foreach( $navigation_arrows as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['navigator_arrows'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Style');?></td>
					<td>
						<select name="slider[navigation_style]">
							<?php foreach( $navigation_style as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['navigation_style'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Offset Horizontal');?></td>
					<td><input type="text" value="<?php echo $params['offset_horizontal'];?>" name="slider[offset_horizontal]"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Offset Vertical');?></td>
					<td><input type="text" value="<?php echo $params['offset_vertical'];?>" name="slider[offset_vertical]"/></td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Always Show Navigator');?></td>
					<td>
						<select name="slider[show_navigator]">
							<?php foreach( $yesno as $key => $value ) { ?>
							<option value="<?php echo $key;?>" <?php if( $key == $params['show_navigator'] ){ ?> selected="selected" <?php } ?> ><?php echo $value; ?></option>
							 <?php } ?>	
						</select>	
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Hide Navigator After');?></td>
					<td><input type="text" value="<?php echo $params['hide_navigator_after'];?>" name="slider[hide_navigator_after]"/></td>
				</tr>	
			</table> 
			<h4><?php echo $this->language->get('Thumbnails');?></h4>
			<table class="form">
				 
				<tr>
					<td><?php echo $this->language->get('Thumbnail Width');?></td>
					<td>
						<input type="text" value="<?php echo $params['thumbnail_width'];?>" name="slider[thumbnail_width]"/>
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Thumbnail Height');?> </td>
					<td>
						<input type="text" value="<?php echo $params['thumbnail_height'];?>" name="slider[thumbnail_height]"/>
					</td>
				</tr>
				<tr>
					<td><?php echo $this->language->get('Number of Thumbnails');?> </td>
					<td>
						<input type="text" value="<?php echo $params['thumbnail_amount'];?>" name="slider[thumbnail_amount]"/>
					</td>
				</tr>
			</table> 
			
			<h4><?php echo $this->language->get('Mobile Visiblity');?></h4>
			<table class="form">
				 <tr>
					<td><?php echo $this->language->get('Hide Under Width');?></td>
					<td>
						<input type="text" value="<?php echo $params['hide_screen_width'];?>" name="slider[hide_screen_width]"/>
					</td>
				</tr>

			</table> 
			
			

		</div>
      
  	</div></form>
      <div class="clearfix"></div>


      <div id="tab-importtools">
	    	<form method="post" enctype="multipart/form-data" action="<?php echo $actionImport; ?>">
		   
		 
			<input type="file" class="input_import_slider" name="import_file">
			
			<input type="submit" value="<?php echo $this->language->get('Import Slider');?>"  >
			</form>
	   </div>	


    </div>
  </div>
</div>
 <script type="text/javascript">

	$("#btn-preview-ingroup").click( function(){
		var url = $(this).attr("href");
			$('#dialog').remove();
			$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe name="iframename2" src="'+url+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
			$('#dialog').dialog({
				title: '<?php echo $this->language->get("Preview Management");?>',
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
 	<script type="text/javascript">
 	
 		$(".htabs a").tabs();
		$('#tabs-modules a').click( function(){
			$.cookie("sactived_tab", $(this).attr("href") );
		} );

		if( $.cookie("sactived_tab") !="undefined" ){
			$('#tabs-modules a').each( function(){ 
				if( $(this).attr("href") ==  $.cookie("sactived_tab") ){
					$(this).click();
					return ;
				}
			} );
			
		}
    	
    	</script>


   <script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="pavsliderlayer_module[' + module_row + '][banner_id]">';
	<?php foreach ($slidergroups as $sg) { ?>
	html += '      <option value="<?php echo $sg['id']; ?>"><?php echo addslashes($sg['title']); ?></option>';
	<?php } ?>
	html += '    </select></td>';	
 
	html += '    <td class="left"><select name="pavsliderlayer_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></td>';	
	html += '    <td class="left"><select name="pavsliderlayer_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '      <option value="mainmenu"><?php echo $this->language->get("Main Menu");?></option>';
	html += '      <option value="slideshow"><?php echo $this->language->get("Slideshow");?></option>';
	html += '      <option value="promotion"><?php echo $this->language->get("Promotion");?></option>';
	html += '      <option value="footer_top"><?php echo $this->language->get("Footer Top");?></option>';
	html += '      <option value="footer_center"><?php echo $this->language->get("Footer Center");?></option>';
	html += '      <option value="footer_bottom"><?php echo $this->language->get("Footer Bottom");?></option>';
	
	html += '    </select></td>';
	html += '    <td class="left"><select name="pavsliderlayer_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="pavsliderlayer_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>   	
<?php echo $footer; ?>