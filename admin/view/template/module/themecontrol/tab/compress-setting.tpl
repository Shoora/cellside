<p><i><?php echo $this->language->get('text_explain_compression');?></i></p>
<table class="form">
	<tr>
		<td><?php echo $this->language->get('enable_compress_css'); ?></td>
		<td>
			<select name="themecontrol[enable_compress_css]">
				<?php foreach( $compressions as $v=>$op ): ?>
				<option value="<?php echo $v;?>" <?php if( $v===$module['enable_compress_css']){ ?> selected="selected" <?php } ?>><?php echo $op;?></option>
				<?php endforeach;?>
			</select>
		</td>
	</tr>
	<tr>
		<td><?php echo $this->language->get('exclude_css_files'); ?></td>
		<td>
			<textarea cols="30" rows="5" name="themecontrol[exclude_css_files]"><?php echo $module['exclude_css_files'];?></textarea>
			<p><i><?php echo $this->language->get('text_exclude_compression_files');?></i></p>
		</td>
	</tr>
</table>