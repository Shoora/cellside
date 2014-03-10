<?php if( $warning_custom_files_permission ) { ?> 
 
	<?php foreach( $warning_custom_files_permission as $warning ) { ?>
		<div class="warning"><?php echo $warning; ?></div>
	<?php } ?>

<?php } ?>
<p>
	<i><?php echo $this->language->get('text_explain_customization');?></i>
</p>
<table class="form">
		<tr class="highlight"><td colspan="2"><?php echo $this->language->get('text_customize_theme'); ?></td>
		<tr>
			<td colspan="2">
				
				<select name="themecontrol[customize_theme]">
					<option value=""><?php echo $this->language->get('text_no_select'); ?></option>
					<?php foreach( $files as $file )  { $file = str_replace(".css", "", $file);?>
					<option value="<?php echo $file;?>" <?php if( $module['customize_theme']==$file){?> selected="selected" <?php } ?>><?php echo $file ;?></option>
					<?php } ?>
				</select>
				<a href="<?php echo $live_customizing_url;?>" class="button"><?php echo $this->language->get('text_live_edit');?></a>
				<p><i><?php echo $this->language->get('text_explain_customize_theme'); ?></i></p>
			</td>
		</tr>
		<tr class="highlight"><td colspan="2"><?php echo $this->language->get('text_heading_customize_bg');?></td></tr>
		<tr>
			<td>
				<label><?php echo $this->language->get('text_background_image');?></label>	
			</td>
			<td>
				<div class="group-input">
					<div class="box-patterns clearfix">	
						<div class="none" style="background:#FFF"></div>
						<?php foreach( $patterns as $pattern )  { ?>
						<div class="<?php echo str_replace(".png","",$pattern);?>" style="background:url(<?php echo $theme_url."image/pattern/".$pattern; ?>)"></div>
						<?php } ?>
					</div>
					<input name="themecontrol[body_pattern]" type="hidden" id="userparams_body_pattern" value="<?php echo $module['body_pattern'];?>"/>
					<script type="text/javascript">
						$( ".box-patterns div").click( function(){
							$("#userparams_body_pattern").val(  $(this).attr("class") );
							$( ".box-patterns div").removeClass( "active" );
							$(this).addClass( "active" );
						} );
						if( $("#userparams_body_pattern").val() ){ 
							$( ".box-patterns").find("."+ $("#userparams_body_pattern").val() ).addClass( "active" );
						}
					</script>
				</div>
				
			</td>
		</tr>
		<tr>
			<td><?php echo $this->language->get("entry_use_custom_background");?></td>
			<td> 
			<select name="themecontrol[use_custombg]">
				<?php foreach( $yesno as $v=>$op ): ?>
				<option value="<?php echo $v;?>" <?php if( $v==$module['use_custombg']){ ?> selected="selected" <?php } ?>><?php echo $op;?></option>
				<?php endforeach;?>
			</select>
			</td>
		</tr>
		<tr>
			<td><?php echo $this->language->get('entry_customize_background');?></td>
			<td>
				<?php $image = $module['bg_image'];	?>
				<div class="image">
					<img src="<?php echo $bg_thumb; ?>" alt="" id="thumb" />
					<input type="hidden" name="themecontrol[bg_image]" value="<?php echo $image; ?>" id="image" />
					<br />
					<a onclick="image_upload('image', 'thumb');"><?php echo $this->language->get("text_browse"); ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
					<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $this->language->get("text_clear"); ?></a>
				</div>
				
				<div class="clearfix"><br>
				<label><?php echo $this->language->get('text_css_background_repeat');?></label>
				 <select name="themecontrol[bg_repeat]">
					<?php foreach( $bg_repeat as $bgr ) { ?>
						<option value="<?php echo $bgr;?>" <?php if( $bgr==$module['bg_repeat']){ ?> selected="selected" <?php } ?>><?php echo $bgr; ?></option>
					<?php } ?>
				 </select>
				</div>
				<div class="clearfix"><br>
				<label><?php echo $this->language->get('text_css_background_position');?></label>
				 <select name="themecontrol[bg_position]">
					<?php foreach( $bg_position as $bgp ) { ?>
						<option value="<?php echo $bgp;?>" <?php if( $bgp==$module['bg_position']){ ?> selected="selected" <?php } ?> ><?php echo $bgp; ?></option>
					<?php } ?>
				 </select>
				</div>
			</td>
		</tr>
		<tr class="highlight"><td colspan="2"><?php echo $this->language->get('text_heading_customize_code');?></td></tr>
<tr><td>
<?php echo $this->language->get('text_customcss'); ?>
</td>
<td>
<p><i><?php echo $this->language->get('text_explain_custom_css')?></i></p>
<textarea name="themecontrol[custom_css]" rows="16" cols="80"><?php echo $module['custom_css'];?></textarea>
</td>
</tr>
<tr><td>
<?php echo $this->language->get('text_customjavascript'); ?>
</td><td>
<p><i><?php echo $this->language->get('text_explain_custom_js')?></i></p>
<textarea name="themecontrol[custom_javascript]" rows="16" cols="80"><?php echo $module['custom_javascript'];?></textarea>
</td></tr>
</table>