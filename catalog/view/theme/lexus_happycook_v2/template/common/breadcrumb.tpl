<?php
if (!isset($_COOKIE['hideTopBanner'])) {
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$modules = $helper->getModulesByPosition( 'slideshow' );
	echo $modules[0]; 
}
?>
<div id="breadcrumb">
	<div class="container">
    <span class="ur">You are here: </span>
	<ol class="breadcrumb">
    	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
	</ol>
	</div>
</div>