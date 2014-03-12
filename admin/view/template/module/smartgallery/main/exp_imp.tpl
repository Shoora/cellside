<form action="<?php echo $import_url; ?>" method="post" class="ls-box ls-import-box">
	<h5 class="header"><?php echo $text_import_ss; ?></h5>
	<div class="inner">
		<textarea name="import" rows="10" class="span10" ></textarea>
		<button class="btn btn-success importGallery" type="button"><?php echo $text_import; ?></button>
	</div>
</form>

<div class="ls-box ls-import-box">
	<h5 class="header"><?php echo $text_export_ss; ?></h5>
	<div class="inner">
		<textarea rows="10" class="span10" readonly="readonly"><?php echo base64_encode(json_encode($export_data)) ?></textarea>
		<p><?php echo $text_export_import_info; ?></p>
	</div>
</div>
