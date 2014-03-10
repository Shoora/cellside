<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  

<div id="group-content">
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12"> 
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php echo $content_top; ?> 
  <h1><?php echo $heading_title; ?></h1>
  <div class="login-content">
  
  


 	<link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook/stylesheet/style.css">
    <link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook/stylesheet/checkbox_login.css">
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web' rel='stylesheet' type='text/css'>
  
  <div class="login">
  
  <div class="container ">
    <div class="row">
      <div class="col-sm-7">
        <header>Already have an account?</header>
          <div class="row login_choice">
            <div class="col-sm-6 login_account">
             
             <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<div class="content">
					  <input class="form-control" type="text" name="email" placeholder="Email" value="<?php echo $email; ?>" />
					  <br />
					  <input class="form-control" type="password" placeholder="Password" name="password" value="<?php echo $password; ?>" />
					   <div class="login_button"> <input type="image" src="catalog/view/theme/lexus_happycook/img/login_button.png" alt="Submit button"></div>
              <div class="check">  <input type="checkbox" name="checkbox2" id="checkbox2" class="css-checkbox" /><label for="checkbox2" class="css-label"></label>Remember me</div>
					  <br />
                     
					 
					  <?php if ($redirect) { ?>
					  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
					  <?php } ?>
					</div>
				</form>
                
             
             
            </div>
            <div class="col-sm-6 login_social">
              <a href="#"> <img src="catalog/view/theme/lexus_happycook/img/facebook.png"> </a>
              <p>or</p>
               <a href="#"> <img src="catalog/view/theme/lexus_happycook/img/twitter.png"> </a>
            </div>
          </div>
      </div>
      <div class="col-sm-4 register">
        <div class="row">
          <div class="col-sm-10">
            <header>Don't have an account?</header>
            <p> <a href="<?php echo $register; ?>" >Sign up</a> for free.</p>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-10">
            <header>Forgot your password?</header>
            <p> <a href="<?php echo $forgotten; ?>">Reset it here</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>

  </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
			
  </div>
  <?php echo $content_bottom; ?>
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
</section>
<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div>
<?php echo $footer; ?>