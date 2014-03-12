<?php $id = rand(1,10); $span =  floor(12/$limit); $this->language->load('module/themecontrol') ;?>
<div class="box highlight shopbybrand-box tag hidden-phone">
  <div class="box-heading"><span><?php echo $this->language->get('Popular Tags');?></span></div>
  <div class="box-content clearfix">
    <?php foreach ($banners as $i=> $banner) {  ?>
	<a href="<?php echo $banner['link']; ?>">
		<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" />
	</a>
   <?php } ?>
 </div>
 </div>  

 