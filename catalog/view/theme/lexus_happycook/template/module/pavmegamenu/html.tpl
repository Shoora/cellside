<?php if( isset($widget_name)){
?>
<div <?php if($widget_name == 'Earn money'){?> class="hwgreen" <?php } else { ?> class="hwrap" <?php } ?>>
<?php if($widget_name == 'Repair Services'){ echo '<div class="repairservices"><span class="menu-title" style="font-size:18px; color:#ffffff">' . $widget_name . '</span></div>'; } elseif($widget_name == 'Repair widget') { } elseif($widget_name == 'Shop now widget') {} else { ?><span class="menu-title"><?php echo $widget_name; ?></span><?php } ?>
<?php
}?>
<div class="<?php if($widget_name !== 'Repair Services') { ?>widget-html<?php } else { ?>widget-shop<?php } ?>">
	<div class="widget-inner">
		<?php echo $html; ?>
	</div>
</div>
</div>