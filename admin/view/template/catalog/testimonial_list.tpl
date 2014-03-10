<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/testimonial.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="location = '<?php echo $send_reminders; ?>'" class="button"><?php echo $button_send_reminders; ?></a>
				<a onclick="location = '<?php echo $settings; ?>'" class="button"><?php echo $button_settings; ?></a>
				<a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a>
				<a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
			</div>
			<div class="content">
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="list">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="left"><a href="<?php echo $sort_title; ?>" class="<?php echo ($sort == 'title') ? strtolower($order) : ''; ?>"><?php echo $column_title; ?></a></td>
							<td class="left"><a href="<?php echo $sort_author; ?>" class="<?php echo ($sort == 'author') ? strtolower($order) : ''; ?>"><?php echo $column_author; ?></a></td>
							<td class="right"><a href="<?php echo $sort_rating; ?>" class="<?php echo ($sort == 'r.rating') ? strtolower($order) : ''; ?>"><?php echo $column_rating; ?></a></td>
							<td class="left"><a href="<?php echo $sort_status; ?>" class="<?php echo ($sort == 'r.status') ? strtolower($order) : ''; ?>"><?php echo $column_status; ?></a></td>
							<td class="left"><a href="<?php echo $sort_date_added; ?>" class="<?php echo ($sort == 'r.date_added') ? strtolower($order) : ''; ?>"><?php echo $column_date_added; ?></a></td>
							<td class="right"><?php echo $column_action; ?></td>
						</tr>
					</thead>
					<tbody>
					<?php if ($testimonials) { ?>
						<?php foreach ($testimonials as $testimonial) { ?>
						<tr>
							<td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $testimonial['testimonial_id']; ?>"<?php ($testimonial['selected']) ? ' checked="checked"' : ''; ?> /></td>
							<td class="left"><?php echo $testimonial['title']; ?></td>
							<td class="left"><?php echo $testimonial['author']; ?></td>
							<td class="right"><?php echo $testimonial['rating']; ?></td>
							<td class="left"><?php echo $testimonial['status']; ?></td>
							<td class="left"><?php echo $testimonial['date_added']; ?></td>
							<td class="right">
								<?php foreach ($testimonial['action'] as $action) { ?>
									[ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
								<?php } ?>
							</td>
						</tr>
						<?php } ?>
					<?php } else { ?>
						<tr>
							<td class="center" colspan="7"><?php echo $text_no_results; ?></td>
						</tr>
					<?php } ?>
					</tbody>
				</table>
			</form>
		<div class="pagination"><?php echo $pagination; ?></div>
		</div>
	</div>
</div>
<?php echo $footer; ?>