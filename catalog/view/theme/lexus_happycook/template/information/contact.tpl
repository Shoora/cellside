<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );
    $themeConfig = $this->config->get( 'themecontrol' );
?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?> 
<div class="container" style="margin-top:50px;">
<div class="contact_map"><iframe src="<?php echo $map; ?>" width="1170" height="300" frameborder="0" style="border:0"></iframe></div></div>
<div id="group-content">
<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
	<?php echo $column_left; ?>
</aside>
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
 
<div id="content"><?php echo $content_top; ?>
  
  <!--<h1><?php //echo $heading_title; ?></h1>-->

         <?php  if(  isset($themeConfig['contact_customhtml']) && isset($themeConfig['contact_customhtml'][$this->config->get('config_language_id')]) && trim($themeConfig['contact_customhtml'][$this->config->get('config_language_id')]) ){ ?>
        <div class="contact-customhtml">
            <?php echo ($themeConfig['contact_customhtml'][$this->config->get('config_language_id')]); ?>
        </div>
        <?php } ?> 

		
		
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_location; ?></h2>
    <div class="contact-info">
      <div class="content"><div class="left"><b><?php echo $text_address; ?></b><br />
        <?php echo $store; ?><br />
        <?php echo $address; ?></div>
      <div class="right">
        <?php if ($telephone) { ?>
        <b><?php echo $text_telephone; ?></b><br />
        <?php echo $telephone; ?><br />
        <br />
        <?php } ?>
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
      </div>
    </div>
    </div>
	
	<div class="container content">
		<div class="row">
			<div class="col-sm-12">
				<h1><?php echo $heading_title; ?></h1>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				
			</div>
		</div>
		<div class="row">
			<div class="col-sm-4">
				<input class="form-control" type="text" name="name" value="<?php echo $name; ?>" />
			</div>
			<div class="col-sm-4">
				<input class="form-control" type="text" name="lname" value="<?php echo $lname; ?>" />
			</div>
			<div class="col-sm-4">
				<input class="form-control" type="text" name="email" value="<?php echo $email; ?>" />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<textarea class="form-control" name="enquiry" cols="40" rows="10" style="width: 99%;"><?php echo $enquiry; ?></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6">
			</div>
			<div class="col-sm-6 pull-right">
				<input type="submit" value="<?php echo $button_continue; ?>" class="button" />
			</div>
		</div>
	</div>
	
    <h2><?php echo $text_contact; ?></h2>
    <div class="content">
    <b><?php echo $entry_name; ?></b><br />
    <input class="form-control" type="text" name="name" value="<?php echo $name; ?>" />
    <br />
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_email; ?></b><br />
    <input class="form-control" type="text" name="email" value="<?php echo $email; ?>" />
    <br />
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_enquiry; ?></b><br />
    <textarea class="form-control" name="enquiry" cols="40" rows="10" style="width: 99%;"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input class="form-control" type="text" name="captcha" value="<?php echo $captcha; ?>" />
    <br />
    <img src="index.php?route=information/contact/captcha" alt="" />
    <?php if ($error_captcha) { ?>
    <span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>
    </div>
    <div class="buttons">
      <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
    </div>
  </form>
  <?php echo $content_bottom; ?></div>
</section> 
<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div>
<?php echo $footer; ?>