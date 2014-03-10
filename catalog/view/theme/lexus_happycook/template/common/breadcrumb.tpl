<div id="breadcrumb">
	<div class="container">
    <span style="color:#AF0917;font-size:16px;float:left;line-height:35px;">You are here: </span>
	<ol class="breadcrumb">
    	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ol>
	</div>
</div>