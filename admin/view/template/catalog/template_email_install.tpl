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
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
  </div>
  <style>
  .notInstall { text-align: center; }
  .notInstall a { display: block; margin-top: 30px; font-size: 22px; font-weight: bold; padding: 4px 5px 5px 5px; text-decoration: none; }
  .notInstall a:hover { padding: 4px 5px 5px 5px; text-decoration: underline; }
  </style>
  <div class="content">
	<div class="notInstall">
      <h1>Template email module is not installed.</h1>
	  <a href="<?php echo $action; ?>">Install</a>
    </div>
  </div>
</div>
<?php echo $footer; ?>