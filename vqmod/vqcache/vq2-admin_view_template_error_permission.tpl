<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    
			<div class="heading"><h1><img src="view/image/admin_theme/base5builder_circloid/icon-warning.png" alt="<?php echo $heading_title; ?>" width="32" height="32" /> <?php echo $heading_title; ?></h1>
			

    </div>
    <div class="content">
      <div style="border: 1px solid #DDDDDD; background: #F7F7F7; text-align: center; padding: 15px;"><?php echo $text_permission; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>