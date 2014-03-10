<div class="action_button pull-right">
	<button class="btn btn-primary saveGalleryToPage" type="button">Save</button>
	<button class="btn btn-success newGalleryToPage" type="button">Add Gallery</button>
</div>

<table class=" pr_to_pg_table table table-striped table-hover">
	<thead>
		<tr>
		<th class=""><?php echo $text_gallery; ?></th>
		<th class=""><?php echo $page_layout; ?><i title="Attention: one Gallery on one Layout" class="icon-asterisk"></i></th>
		<th class="">Show only on Bottom Categories</th>
		<th class=""><?php echo $page_position; ?></th>
		<th class=""><?php echo $page_status; ?></th>
		<th class=""><?php echo $page_sort_order; ?></th>
		<th class=""><?php echo $text_action; ?></th>
		</tr>
	</thead>
<?php $gallery_index = 0; ?>
<?php if(count($galleries) AND count($galleriseOnPage)) : ?>
	<?php foreach($galleriseOnPage as $index => $galleryOnPage) : ?>	
	<tbody data-index="<?php echo $gallery_index; ?>"  class="gallery_index" data-id="<?php echo $galleryOnPage['id']; ?>" >
		<tr>
			<td>
				<input type="hidden" name="data[<?php echo $gallery_index; ?>][id]" data-name="id" value="<?php echo $galleryOnPage['id']; ?>" />
				<select class="span2" name="data[<?php echo $gallery_index; ?>][gallery_id]" data-name="gallery_id" >
				<?php foreach($galleries as $gallery) : ?>
					<?php $name = empty($gallery['main']['name']) ? 'Unnamed' : $gallery['main']['name']; ?>	
					
					<option value="<?php echo $gallery['main']['id']; ?>" <?php if($gallery['main']['id'] == $galleryOnPage['gallery_id']) { echo 'selected="selected"';} ?> >
						<?php echo $name; ?>
					</option>

				<?php endforeach; ?>
				</select>
			</td>
			<td>
				<select class="span2" name="data[<?php echo $gallery_index; ?>][layout_id]" data-name="layout_id" >
				<?php foreach($default_galleryOnPage['layouts'] as $layout) : ?>
									
					<option value="<?php echo $layout['layout_id']; ?>" <?php if($galleryOnPage['layout_id'] == $layout['layout_id']) { echo 'selected="selected"';} ?>>
						<?php echo $layout['name']; ?>
					</option>
					
				<?php endforeach; ?>
				</select>
			</td>
			<td>
				<fieldset>
				<div class="control-group">
					<div class="controls">
						<input type="hidden" name="data[<?php echo $gallery_index; ?>][bottom_cat]" value="">
						<input type="checkbox" value="true" <?php if($galleryOnPage['bottom_cat']) echo ' checked="checked" '; ?> name="data[<?php echo $gallery_index; ?>][bottom_cat]" class="on_off" />
					</div>
				</div>
				</fieldset>
			</td>
			<td>
				<select class="span2" name="data[<?php echo $gallery_index; ?>][position]" data-name="position" >
				<?php foreach($default_galleryOnPage['position'] as $position) : ?>
					
					<option value="<?php echo $position['value']; ?>" <?php if($galleryOnPage['position'] == $position['value']) { echo 'selected="selected"';} ?>>
						<?php echo $position['name']; ?>
					</option>
					
				<?php endforeach; ?>
				</select>
			</td>
			<td>
				<select class="span2" name="data[<?php echo $gallery_index; ?>][status]" data-name="status" >
				<?php foreach($default_galleryOnPage['status'] as $status) : ?>
					
					<option value="<?php echo $status['value']; ?>" <?php if($galleryOnPage['status'] == $status['value']) { echo 'selected="selected"';} ?>>
						<?php echo $status['name']; ?>
					</option>
					
				<?php endforeach; ?>
				</select>
			</td>
			<td>
				<input class="span1" type="text" name="data[<?php echo $gallery_index; ?>][sort_order]" value="<?php echo $galleryOnPage['sort_order'] ?>" data-name="sort_order" />
			</td>
			<td>
				<button class="btn btn-small removeGalleryToPage" type="button"><?php echo $text_remove; ?></button>
			</td>
		</tr>
	</tbody>
		<?php $gallery_index++; ?>
	<?php endforeach; ?>
<?php endif; ?>	
</table>




<table class="hidden template-galleryToPage" data-galleries_count="<?php echo count($galleries); ?>" >
<tbody data-index="<?php echo $gallery_index; ?>"  class="gallery_index" data-id="" >
	<tr>
		<td>
			<input type="hidden" name="id" data-name="id" value="" />
			<select class="span2" name="gallery_id" data-name="gallery_id">
			<?php foreach($galleries as $index => $gallery) : ?>
				<?php $name = empty($gallery['main']['name']) ? 'Unnamed' : $gallery['main']['name']; ?>	
				
				<option value="<?php echo $gallery['main']['id']; ?>" <?php if($index == 0) { echo 'selected="selected"';} ?> >
					<?php echo $name; ?>
				</option>

			<?php endforeach; ?>
			</select>
		</td>
		<td>
			<select class="span2" name="layout_id" data-name="layout_id">
			<?php foreach($default_galleryOnPage['layouts'] as $index => $layout) : ?>
				
				<option value="<?php echo $layout['layout_id']; ?>" <?php if($index == 0) { echo 'selected="selected"';} ?>>
					<?php echo $layout['name']; ?>
				</option>
				
			<?php endforeach; ?>
			</select>
		</td>
		<td>
			<fieldset>
			<div class="control-group">
				<div class="controls">
					<input type="hidden" name="bottom_cat" value="" data-name="bottom_cat">
					<input type="checkbox" value="true" name="bottom_cat" class="on_off"  data-name="bottom_cat"/>
				</div>
			</div>
			</fieldset>
		</td>
		<td>
			<select class="span2" name="position" data-name="position">
			<?php foreach($default_galleryOnPage['position'] as $index => $position) : ?>
				
				<option value="<?php echo $position['value']; ?>" <?php if($index == 0) { echo 'selected="selected"';} ?>>
					<?php echo $position['name']; ?>
				</option>
				
			<?php endforeach; ?>
			</select>
		</td>
		<td>
			<select class="span2" name="status" data-name="status">
			<?php foreach($default_galleryOnPage['status'] as $index => $status) : ?>
				
				<option value="<?php echo $status['value']; ?>" <?php if($index == 0) { echo 'selected="selected"';} ?>>
					<?php echo $status['name']; ?>
				</option>
				
			<?php endforeach; ?>
			</select>
		</td>
		<td>
			<input class="span1" type="text" name="sort_order" value="" data-name="sort_order"/>
		</td>
		<td>
			<button class="btn btn-small removeGalleryToPage" type="button"><?php echo $text_remove; ?></button>
		</td>
	</tr>
</tbody>
</table>
<script type="text/javascript">
	var galleryToPage_index = <?php echo $gallery_index; ?>;
</script>