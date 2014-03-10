
<div class="action_button pull-right">
	<button class="btn btn-success newGallery" type="button"><?php echo $text_new_gallery; ?></button>
</div>

<table class="table table-striped table-hover">
	<thead>
		<tr class="center">
			<td>Name</td>
			<td>Created</td>
			<td>Modified</td>
			<td>Action</td>
		</tr>
	</thead>
	<tbody>
		<?php if(!empty($galleries)) : ?>
		<?php foreach($galleries as $gallery) : ?>
		<?php $name = empty($gallery['main']['name']) ? 'Unnamed' : $gallery['main']['name']; ?>
		<tr class="center">
			<td><?php echo $name ?></td>
			<td><?php echo $gallery['main']['date_c'] ?></td>
			<td><?php echo $gallery['main']['date_m'] ?></td>
			<td>
				<button data-id="<?php echo $gallery['main']['id']; ?>" class="btn btn-small editGallery" type="button"><?php echo $text_edit; ?></button>
				
				<button data-id="<?php echo $gallery['main']['id']; ?>" class="btn btn-small duplicateGallery" type="button"><?php echo $text_duplicate; ?></button>
				
				<button data-id="<?php echo $gallery['main']['id']; ?>" class="btn btn-small removeGallery" type="button"><?php echo $text_remove; ?></button>
			</td>
		</tr>
		<?php endforeach; ?>
		<?php endif; ?>
		<tr class="center">
			<td colspan="3"><?php if(empty($galleries)) : ?>You didn't create a Gallery yet<?php endif; ?></td>
			<td>
			</td>
		</tr>
	</tbody>	
</table>