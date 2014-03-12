<?php if ($status) { ?>
<?php if ($position == "column_left" || $position == "column_right") { ?>
<div class="box">
	<div class="box-heading"><?php echo $heading; ?></div>
	<div class="box-content qap-column"><?php echo $module; ?></div>
</div>
<?php } else if ($position == "content_tab") { ?>
<?php echo $module; ?>
<?php } else { ?>
<div class="box">
	<div class="box-heading"><?php echo $heading; ?></div>
	<div class="box-content qap-content"><?php echo $module; ?></div>
</div>
<?php } ?>
<?php } ?>