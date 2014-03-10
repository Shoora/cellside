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
		    
			<div id="content"><?php echo $content_top; ?>
			  
			  
            <?php if($title=='') { ?>
            <h1><?php echo $heading_title; ?></h1>
            <?php } else { ?>
            <h1><?php echo $title; ?></h1>
            <?php } ?>
            
			  
            <?php if($welcome_a==1 && $style_a<>'icons-4' && $style_a<>'icons-5') { ?>
            <h2><?php echo $text_greeting_a; ?></h2>
            <?php } ?>
            <?php if($tabs==1 && $style_a<>'icons-4' && $style_a<>'icons-5') { ?>
            <div id="tabs" class="htabs">
              <?php if($edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0 or $logout_link==0) { ?>
              <a href="#tab-account"><?php if($title_account=='') { ?><?php echo $text_my_account; ?><?php } else { ?><?php echo $title_account; ?><?php } ?></a>
              <?php } ?>
              <?php if($order_link==0 or $download_link==0 or $reward_link==0 or $return_link==0 or $transaction_link==0 ) { ?>
              <a href="#tab-order"><?php if($title_orders=='') { ?><?php echo $text_my_orders; ?><?php } else { ?><?php echo $title_orders; ?><?php } ?></a>
              <?php } ?>
              <?php if($newsletter_link==0) { ?>
              <a href="#tab-newsletter"><?php if($title_newsletter=='') { ?><?php echo $text_newsletter; ?><?php } else { ?><?php echo $title_newsletter; ?><?php } ?></a>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if($style_a=='default') { ?>
            <?php if($tabs==1) { ?>
            <div id="tab-account">
            <?php } ?>
            <?php if($edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0 or $logout_link==0) { ?>
            <?php if($tabs==0) { ?>
            <?php if($title_account=='') { ?>
            <h2><?php echo $text_my_account; ?></h2>
            <?php } else { ?>
            <h2><?php echo $title_account; ?></h2>
            <?php } ?>
            <?php } ?>
              <div class="content">
                <ul>
                  <?php if($edit_link==0) { ?>  
                  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
                  <?php } ?>
                  <?php if($password_link==0) { ?>
                  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
                  <?php } ?>
                  <?php if($address_link==0) { ?>
                  <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
                  <?php } ?>
                  <?php if($wishlist_link==0) { ?>
                  <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                  <?php } ?>
                  <?php if($logout_link==0) { ?>
                  <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                  <?php } ?>
                </ul>
              </div>
             <?php } ?> 
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?>
            <?php if($tabs==1) { ?>
            <div id="tab-order">
            <?php } ?>
              <?php if($order_link==0 or $download_link==0 or $reward_link==0 or $return_link==0 or $transaction_link==0 ) { ?>
              <?php if($tabs==0) { ?>
              <?php if($title_orders=='') { ?>
              <h2><?php echo $text_my_orders; ?></h2>
              <?php } else { ?>
              <h2><?php echo $title_orders; ?></h2>
              <?php } ?>
            
            <?php } ?>  
              <div class="content">
                <ul>
                  <?php if($order_link==0) { ?>
                  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                  <?php } ?>
                  <?php if($download_link==0) { ?>
                  <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                  <?php } ?>
                  <?php if($reward_link==0) { ?>
                  <?php if ($reward) { ?>
                  <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
                  <?php } ?>
                  <?php } ?>
                  <?php if($return_link==0) { ?>
                  <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                  <?php } ?>
                  <?php if($transaction_link==0) { ?>
                  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                  <?php } ?>
                </ul>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?>
              <?php } ?>
             </div>
             <?php if($tabs==1) { ?>
             <div id="tab-newsletter">
             <?php } ?>
              <?php if($newsletter_link==0) { ?>
              <?php if($tabs==0) { ?>
              <?php if($title_newsletter=='') { ?>
              <h2><?php echo $text_newsletter; ?></h2>
              <?php } else { ?>
              <h2><?php echo $title_newsletter; ?></h2>
              <?php } ?>
              <?php } ?>
              <div class="content">
                <ul>
                  <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                </ul>
              </div>
            <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?>
            </div>
            <?php } ?>
            
            <?php if($style_a=='icons-1') { ?>
            <?php if($tabs==1) { ?>
            <div id="tab-account">
            <?php } ?>
            <?php if($edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0 or $logout_link==0) { ?>  
              <?php if($tabs==0) { ?>
            <?php if($title_account=='') { ?>
            <h2><?php echo $text_my_account; ?></h2>
            <?php } else { ?>
            <h2><?php echo $title_account; ?></h2>
            <?php } ?>

              <?php } ?>   
              <div class="content">
                <ul>
                    <?php if($edit_link==0) { ?>
                    <div  style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/edit.png" alt="<?php echo $text_edit; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $edit; ?>" style="font-weight: bold;"><?php echo $text_edit; ?></a><br>
                    <?php echo $text_edit_desc; ?></div>
                    <?php } ?>
                    <?php if($password_link==0) { ?>
                    <div style="float: right; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/password.png" alt="<?php echo $text_password; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $password; ?>" style="font-weight: bold;"><?php echo $text_password; ?></a><br>
                    <?php echo $text_password_desc; ?></div>
                    <?php } ?>
                    <?php if($address_link==0) { ?>
                    <div style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/address.png" alt="<?php echo $text_address; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $address; ?>" style="font-weight: bold;"><?php echo $text_address; ?></a><br>
                    <?php echo $text_address_desc; ?></div>
                    <?php } ?>
                    <?php if($wishlist_link==0) { ?>
                    <div  style="float: right; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/wishlist.png" alt="<?php echo $text_wishlist; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $wishlist; ?>" style="font-weight: bold;"><?php echo $text_wishlist; ?></a><br>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                    <?php echo $text_wishlist_desc; ?></div>
                    <?php } ?>
                    <?php if($logout_link==0) { ?>
                    <div  style="float: right; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png" alt="logout" style="float: left; margin-right: 8px;  "><a href="<?php echo $logout; ?>" style="font-weight: bold;"><?php echo $text_logout; ?></a><br>
                    <?php echo $text_logout_desc; ?></div>
                    <?php } ?>
                </ul>
              </div>
            <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 

            <?php if($tabs==1) { ?>
            <div id="tab-order">
            <?php } ?>

            <?php if($order_link==0 or $download_link==0  or $reward_link==0  or $return_link==0 or $transaction_link==0) { ?>            
              <?php if($tabs==0) { ?>
              <?php if($title_orders=='') { ?>
              <h2><?php echo $text_my_orders; ?></h2>
              <?php } else { ?>
              <h2><?php echo $title_orders; ?></h2>
              <?php } ?>
              <?php } ?> 
              <div class="content">
                <ul>
                    <?php if($order_link==0) { ?>
                    <div style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/orders.png" alt="<?php echo $text_order; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $order; ?>" style="font-weight: bold;"><?php echo $text_order; ?></a><br>
                    <?php echo $text_order_desc; ?></div>
                    <?php } ?>
                    <?php if($download_link==0) { ?>    
                    <div style="float: right; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/downloads.png" alt="<?php echo $text_download; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $download; ?>" style="font-weight: bold;"><?php echo $text_download; ?></a><br>
                    <?php echo $text_download_desc; ?></div>
                    <?php } ?>
                    <?php if($reward_link==0) { ?>
                    <div style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/rewards.png" alt="<?php echo $text_reward; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $reward; ?>" style="font-weight: bold;"><?php echo $text_reward; ?></a><br>
                    <?php echo $text_reward_desc; ?></div>
                    <?php } ?>
                    <?php if($return_link==0) { ?>
                    <div style="float: right; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/returns.png" alt="<?php echo $text_return; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $return; ?>" style="font-weight: bold;"><?php echo $text_return; ?></a><br>
                    <?php echo $text_return_desc; ?></div>
                    <?php } ?>
                    <?php if($transaction_link==0) { ?>
                    <div style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/transaction.png" alt="<?php echo $text_transaction; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $transaction; ?>" style="font-weight: bold;"><?php echo $text_transaction; ?></a><br>
                    <?php echo $text_transaction_desc; ?></div>
                    <?php } ?>
                </ul>
              </div>
              <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
 
            <?php if($tabs==1) { ?>
            <div id="tab-newsletter">
            <?php } ?>
              <?php if($newsletter_link==0) { ?>      
              <?php if($tabs==0) { ?>
              <?php if($title_newsletter=='') { ?>
              <h2><?php echo $text_newsletter; ?></h2>
              <?php } else { ?>
              <h2><?php echo $title_newsletter; ?></h2>
              <?php } ?>
              
              <?php } ?> 
              <div class="content">
                <ul>
                  <div style="float: left; width: 35%; margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/newsletter.png" alt="<?php echo $text_newsletter; ?>" style="float: left; margin-right: 8px;  "><a href="<?php echo $newsletter; ?>" style="font-weight: bold;"><?php echo $text_newsletter; ?></a><br>
                  <?php echo $text_newsletter_desc; ?></div>
                </ul>
              </div>
             <?php } ?> 
            
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
            </div>
            <?php } ?>
            
            <?php if($style_a=='icons-2') { ?>
            <?php if($tabs==1) { ?>
            <div id="tab-account">
            <?php } ?> 
                    <?php if($edit_link==0) { ?>                
                    <div>
                        <a href="<?php echo $edit; ?>" id="s-account" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/edit.png);" >
                        <h5 ><?php echo $text_edit; ?></h5>
                        </a>
                    </div>
                  <?php } ?>
                  <?php if($password_link==0) { ?>
                    <div>
                	     <a href="<?php echo $password; ?>" id="s-password" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/password.png);">
                         <h5 ><?php echo $text_password; ?></h5>
                         </a>
                    </div>
                 <?php } ?>
                 <?php if($address_link==0) { ?>
                    <div>
                	     <a href="<?php echo $address; ?>" id="s-address" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/address.png);">
                         <h5 ><?php echo $text_address; ?></h5>
                         </a>
                    </div>
                 <?php } ?>
                 <?php if($wishlist_link==0) { ?>
                    <div>
                	   <a href="<?php echo $wishlist; ?>" id="s-wishlist" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/wishlist.png);">
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                       <h5 ><?php echo $text_wishlist; ?></h5>
                       </a>
                    </div>
                  <?php } ?>
                <?php if($tabs==1) { ?>
                <?php if($logout_link==0) { ?>
                    <div>
                      <a href="<?php echo $logout; ?>" id="s-logout" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png);">
                      <h5 ><?php echo $text_logout; ?></h5>
                      </a>
                    </div>
                <?php } ?>
                <?php } ?>
                  <?php if($tabs==1) { ?>
                  </div>
                  <?php } ?>
                  <?php if($tabs==1) { ?>
                  <div id="tab-order">
                  <?php } ?>
                  <?php if($order_link==0) { ?>
                    <div>
                	   <a href="<?php echo $order; ?>" id="s-orders" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/orders.png);">
                       <h5 ><?php echo $text_order; ?></h5>
                       </a>
                    </div>
                <?php } ?>
                <?php if($download_link==0) { ?>
                    <div>
                	   <a href="<?php echo $download; ?>" id="s-downloads" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/downloads.png);">
                       <h5 ><?php echo $text_download; ?></h5>
                       </a>
                    </div>
                <?php } ?>
                <?php if($reward_link==0) { ?>
                    <div>
                	   <a href="<?php echo $reward; ?>" id="s-rewards" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/rewards.png);">
                       <h5 ><?php echo $text_reward; ?></h5>
                       </a>
                    </div>
                <?php } ?>
                <?php if($return_link==0) { ?>
                    <div>
                	   <a href="<?php echo $return; ?>" id="s-returns" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/returns.png);">
                       <h5 ><?php echo $text_return; ?></h5>
                       </a>
                    </div>
                   <?php } ?>
                   <?php if($transaction_link==0) { ?> 
                    <div>
                      <a href="<?php echo $transaction; ?>" id="s-transaction" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/transaction.png);">
                      <h5 ><?php echo $text_transaction; ?></h5>
                      </a>
                    </div>
                <?php } ?>
                 <?php if($tabs==1) { ?>
                </div>
                <?php } ?>
                 <?php if($tabs==1) { ?>
                <div id="tab-newsletter">
                <?php } ?>
                <?php if($newsletter_link==0) { ?>
                    <div>
                	   <a href="<?php echo $newsletter; ?>" id="s-newsletter" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/newsletter.png);">
                       <h5 ><?php echo $text_newsletter; ?></h5>
                       </a>
                    </div>
                <?php } ?>
                 <?php if($tabs==0) { ?>
                <?php if($logout_link==0) { ?>
                    <div>
                      <a href="<?php echo $logout; ?>" id="s-logout" class="shorticons-box" style=" background-image:url(catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png);">
                      <h5 ><?php echo $text_logout; ?></h5>
                      </a>
                    </div>
                <?php } ?>
                <?php } ?>
                    <br/><br/>
                <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/page.css" /> 
            </div><?php if($tabs==1) { ?></div><?php } ?>
            <?php } ?>
            
             
            
        <?php if($style_a=='icons-3') { ?>
           <ol class="rectangle-list-a">	    		
                <?php if($account_link==0 or $edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0) { ?>
                <?php if($tabs==0) { ?>
                <?php if($title_account=='') { ?>
                <b><?php echo $text_my_account; ?></b>
                <?php } else { ?>
                <b><?php echo $title_account; ?></b>
                <?php } ?>
                <?php } ?>
                <?php } ?>
                <?php if($tabs==1) { ?>
                <div id="tab-account">
                <?php } ?>
                <ol>
                <?php if($edit_link==0) { ?>
                <li><a href="<?php echo $edit; ?>" ><?php echo $text_edit; ?><span style="color:#444;">   |  <?php echo $text_edit_desc; ?></span></a></li></li>
            	<?php } ?>  
                <?php if($password_link==0) { ?>
                <li><a href="<?php echo $password; ?>" ><?php echo $text_password; ?><span style="color:#444;">   |  <?php echo $text_password_desc; ?></span></a></li>
            	<?php } ?>  
                <?php if($address_link==0) { ?>
                <li><a href="<?php echo $address; ?>" ><?php echo $text_address;; ?><span style="color:#444;">   |  <?php echo $text_address_desc; ?></span></a></li>
            	<?php } ?>  
                <?php if($wishlist_link==0) { ?>
                <li><a href="<?php echo $wishlist; ?>" ><?php echo $text_wishlist; ?><span style="color:#444;">   |  <?php echo $text_wishlist_desc; ?></span></a></li>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                <?php } ?>
                <?php if($logout_link==0) { ?>  
                <ol>
                <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?><span style="color:#444;">   |  <?php echo $text_logout_desc; ?></span></a></li>
                </ol>
                <?php } ?>
                </ol>
                <?php if($order_link==0 or $download_link==0 or $reward_link==0 or $return_link==0 or $transaction_link==0 ) { ?>
                <?php if($tabs==0) { ?>
                <br />
                <?php if($title_orders=='') { ?>
                <b><?php echo $text_my_orders; ?></b>
                <?php } else { ?>
                <b><?php echo $title_orders; ?></b>
                <?php } ?>
                <?php } ?>
                <?php } ?>
                <?php if($tabs==1) { ?>
                </div>
                <?php } ?>
                <?php if($tabs==1) { ?>
                <div id="tab-order">
                <?php } ?>
                <ol>
                <?php if($order_link==0) { ?>
                <li><a href="<?php echo $order; ?>" ><?php echo $text_order; ?><span style="color:#444;">   |  <?php echo $text_order_desc; ?></span></a></li>
            	<?php } ?>  
                <?php if($download_link==0) { ?>
                <li><a href="<?php echo $download; ?>" ><?php echo $text_download; ?><span style="color:#444;">   |  <?php echo $text_download_desc; ?></span></a></li>
            	<?php } ?>  
                <?php if($reward_link==0) { ?>
                <li><a href="<?php echo $reward; ?>" ><?php echo $text_reward; ?><span style="color:#444;">   |  <?php echo $text_reward_desc; ?></span></a></li>
            	<?php } ?>  
                <?php if($return_link==0) { ?>
                <li><a href="<?php echo $return; ?>" ><?php echo $text_return; ?><span style="color:#444;">   |  <?php echo $text_return_desc; ?></span></a></li>
                <?php } ?>  
                <?php if($transaction_link==0) { ?>
                <li><a href="<?php echo $transaction; ?>" ><?php echo $text_transaction; ?><span style="color:#444;">   |  <?php echo $text_transaction_desc; ?></span></a></li>
            	<?php } ?>  
                </ol>
                <?php if($tabs==1) { ?>
                </div>
                <?php } ?>
                <?php if($newsletter_link==0) { ?>
                <?php if($tabs==0) { ?>
                <br />
                <?php if($title_newsletter=='') { ?>
                <b><?php echo $text_newsletter; ?></b>
                <?php } else { ?>
                <b><?php echo $title_newsletter; ?></b>
                <?php } ?>
              
                <?php } ?>
                <?php if($tabs==1) { ?>
                <div id="tab-newsletter">
                <?php } ?>
                <ol>
                <?php if($newsletter_link==0) { ?>
                <li><a href="<?php echo $newsletter; ?>" ><?php echo $text_newsletter; ?><span style="color:#444;">   |  <?php echo $text_newsletter_desc; ?></span></a></li>
                <?php } ?>
                </ol>
                </div>
                <?php } ?>
                <?php if($tabs==1) { ?>
                </div>
                <?php } ?>
             </ol>       
                
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/modern.css" />
        <?php } ?>
        
        <?php if($style_a=='icons-4') { ?>        
         <div class="container">
		  <section class="aca-container">
            <?php if($welcome_a==1) { ?>
            <div>
            <input id="aca-1" name="accordiona-1" type="radio" checked />
			<label for="aca-1">Welcome</label>
			<article class="aca-mini">
            <div style="text-align: center; padding-top: 15px;">
            <p><?php echo $text_greeting_a; ?>  </p>
            </div>
            </article>
		    </div>
            <?php } ?>
            <?php if($edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0) { ?>        
            <div>
			<input id="aca-2" name="accordiona-1" type="radio"  <?php if($welcome_a==0) { ?>checked<?php } ?>/>
			<label for="aca-2">
            <?php if($title_account=='') { ?>
            <?php echo $text_my_account; ?>
            <?php } else { ?>
            <?php echo $title_account; ?>
            <?php } ?>
            </label>
			<article class="aca-small">
			<ul class="mylist">
            <?php if($edit_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/edit.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $edit; ?>" ><?php echo $text_edit; ?></a></li>
            <?php } ?>
            <?php if($password_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/password.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $password; ?>"  ><?php echo $text_password; ?></a></li>
            <?php } ?>
            <?php if($address_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/address.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
            <?php } ?>
            <?php if($wishlist_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/wishlist.png" style="vertical-align:bottom; width:20px; height:20px padding-bottom: 3px;">&nbsp;<?php } ?> 
            <a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
            <?php } ?>
            <?php if($logout_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/address.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } ?>
            </ul>
			</article>
			</div>
			<?php } ?>
            <?php if($order_link==0 or $download_link==0 or $reward_link==0 or $return_link==0 or $transaction_link==0 ) { ?>
            <div>
			<input id="aca-3" name="accordiona-1" type="radio" />
			<label for="aca-3">
            <?php if($title_orders=='') { ?>
            <?php echo $text_my_orders; ?>
            <?php } else { ?>
            <?php echo $title_orders; ?>
            <?php } ?>
            </label>
			<article class="aca-small">
			<ul  class="mylist">
            <?php if($order_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/orders.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px; padding-top: 3px">&nbsp;<?php } ?>
            <a href="<?php echo $order; ?>" ><?php echo $text_order; ?></a></li>
            <?php } ?>
            <?php if($download_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/downloads.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $download; ?>" ><?php echo $text_download; ?></a></li>
            <?php } ?>
            <?php if($reward_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/rewards.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $reward; ?>" ><?php echo $text_reward; ?></a></li>
            <?php } ?>
            <?php if($return_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/returns.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px";>&nbsp;<?php } ?>
            <a href="<?php echo $return; ?>" ><?php echo $text_return; ?></a></li>
            <?php } ?>
            <?php if($transaction_link==0) { ?>
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/transaction.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px;">&nbsp;<?php } ?>
            <a href="<?php echo $transaction; ?>" ><?php echo $text_transaction; ?></a></li>
            <?php } ?>
            </ul>
			</article>
			</div>
            <?php } ?>
            <?php if($newsletter_link==0) { ?>
            <div>
			<input id="aca-4" name="accordiona-1" type="radio" />
			<label for="aca-4">
            <?php if($title_newsletter=='') { ?>
            <?php echo $text_newsletter; ?>
            <?php } else { ?>
            <?php echo $title_newsletter; ?>
            <?php } ?>
            </label>
			<article class="aca-mini2">
			<ul class="mylist">
            <li><?php if($style_a=='icons-1') { ?><img src="catalog/view/theme/default/image/loginplus/mini/<?php echo $icotype_a; ?>/newsletter.png" style="vertical-align:bottom; width:20px; height:20px; padding-bottom: 3px; padding-top: 3px">&nbsp;<?php } ?>
            <a href="<?php echo $newsletter; ?>" ><?php echo $text_newsletter; ?></a></li>
            </ul>
			</article>
			</div>
			<?php } ?>
		    </section>
            </div> 
            <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/accordion_s.css" />
           </div> 
          <?php } ?>
          
          <?php if($style_a=='icons-5') { ?>        
         <div class="container">
		  <section class="aca-container">
            <?php if($welcome_a==1) { ?>
            <div>
            <input id="aca-1" name="accordiona-1" type="radio" checked/>
			<label for="aca-1">Welcome</label>
			<article class="aca-mini">
            <div style="text-align: center; padding-top: 15px;">
            <p><?php echo $text_greeting_a; ?>  </p>
            </div>
            </article>
		    </div>
            <?php } ?>
            <?php if($edit_link==0 or $password_link==0  or $address_link==0  or $wishlist_link==0 or $logout_link==0) { ?>        
            <div>
			<input id="aca-2" name="accordiona-1" type="radio"   <?php if($welcome_a==0) { ?>checked<?php } ?>/>
			<label for="aca-2">
            <?php if($title_account=='') { ?>
            <?php echo $text_my_account; ?>
            <?php } else { ?>
            <?php echo $title_account; ?>
            <?php } ?>
            </label>
			<article class="aca-small">
			<ul class="mylist">
                    <?php if($edit_link==0) { ?>
                    <div  style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/edit.png" alt="<?php echo $text_edit; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $edit; ?>" style="font-weight: bold;"><?php echo $text_edit; ?></a><br>
                    <?php echo $text_edit_desc; ?></div>
                    <?php } ?>
                    <?php if($password_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/password.png" alt="<?php echo $text_password; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $password; ?>" style="font-weight: bold;"><?php echo $text_password; ?></a><br>
                    <?php echo $text_password_desc; ?></div>
                    <?php } ?>
                    <?php if($address_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/address.png" alt="<?php echo $text_address; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $address; ?>" style="font-weight: bold;"><?php echo $text_address; ?></a><br>
                    <?php echo $text_address_desc; ?></div>
                    <?php } ?>
                    <?php if($wishlist_link==0) { ?>
                    <div  style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/wishlist.png" alt="<?php echo $text_wishlist; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $wishlist; ?>" style="font-weight: bold;"><?php echo $text_wishlist; ?></a><br>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                    <?php echo $text_wishlist_desc; ?></div>
                    <?php } ?>
                    <?php if($logout_link==0) { ?>
                    <div  style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png" alt="logout" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $logout; ?>" style="font-weight: bold;"><?php echo $text_logout; ?></a><br>
                    <?php echo $text_logout_desc; ?></div>
                    <?php } ?>
            </ul>
			</article>
			</div>
			<?php } ?>
            <?php if($order_link==0 or $download_link==0 or $reward_link==0 or $return_link==0 or $transaction_link==0 ) { ?>
            <div>
			<input id="aca-3" name="accordiona-1" type="radio" />
			<label for="aca-3">
            <?php if($title_orders=='') { ?>
            <?php echo $text_my_orders; ?>
            <?php } else { ?>
            <?php echo $title_orders; ?>
            <?php } ?>
            </label>
			<article class="aca-small">
			<ul  class="mylist">
            <?php if($order_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/orders.png" alt="<?php echo $text_order; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $order; ?>" style="font-weight: bold;"><?php echo $text_order; ?></a><br>
                    <?php echo $text_order_desc; ?></div>
                    <?php } ?>
                    <?php if($download_link==0) { ?>    
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/downloads.png" alt="<?php echo $text_download; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $download; ?>" style="font-weight: bold;"><?php echo $text_download; ?></a><br>
                    <?php echo $text_download_desc; ?></div>
                    <?php } ?>
                    <?php if($reward_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/rewards.png" alt="<?php echo $text_reward; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $reward; ?>" style="font-weight: bold;"><?php echo $text_reward; ?></a><br>
                    <?php echo $text_reward_desc; ?></div>
                    <?php } ?>
                    <?php if($return_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/returns.png" alt="<?php echo $text_return; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $return; ?>" style="font-weight: bold;"><?php echo $text_return; ?></a><br>
                    <?php echo $text_return_desc; ?></div>
                    <?php } ?>
                    <?php if($transaction_link==0) { ?>
                    <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/transaction.png" alt="<?php echo $text_transaction; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $transaction; ?>" style="font-weight: bold;"><?php echo $text_transaction; ?></a><br>
                    <?php echo $text_transaction_desc; ?></div>
                    <?php } ?>
            </ul>
			</article>
			</div>
            <?php } ?>
            <?php if($newsletter_link==0) { ?>
            <div>
			<input id="aca-4" name="accordiona-1" type="radio" />
			<label for="aca-4">
            <?php if($title_newsletter=='') { ?>
            <?php echo $text_newsletter; ?>
            <?php } else { ?>
            <?php echo $title_newsletter; ?>
            <?php } ?>
              
            </label>
			<article class="aca-mini2">
			<ul class="mylist">
            <div style=" margin-bottom: 10px; padding: 5px;"><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/newsletter.png" alt="<?php echo $text_newsletter; ?>" style="float: left; margin-right: 8px;  " width=35px; height=35px;><a href="<?php echo $newsletter; ?>" style="font-weight: bold;"><?php echo $text_newsletter; ?></a><br>
                  <?php echo $text_newsletter_desc; ?></div>
            </ul>
			</article>
			</div>
			<?php } ?>
		    </section>
            </div> 
            <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/accordion_i.css" />
           </div> 
          <?php } ?>
          
          
          <?php if($style_a=='icons-6') { ?>
            <div class="alinks">
            <ul>
            <?php if($tabs==1) { ?>
            <div id="tab-account">
            <?php } ?>
                    <?php if($edit_link==0) { ?>
                    <li>
                    <a href="<?php echo $edit; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/edit.png" alt="<?php echo $text_edit; ?>" "><?php echo $text_edit; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($password_link==0) { ?>
                    <li>
                    <a href="<?php echo $password; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/password.png" alt="<?php echo $text_password; ?>" "><?php echo $text_password; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($address_link==0) { ?>
                    <li>
                    <a href="<?php echo $address; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/address.png" alt="<?php echo $text_address; ?>" "><?php echo $text_address; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($wishlist_link==0) { ?>
                    <li>
                    <a href="<?php echo $wishlist; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/wishlist.png" alt="<?php echo $text_wishlist; ?>" "><?php echo $text_wishlist; ?></a><br>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                    </li>
                    <?php } ?>
                    <?php if($logout_link==0) { ?>
                    <li>
                    <a href="<?php echo $logout; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png" alt="logout" "><?php echo $text_logout; ?></a><br>
                    </li>
                    <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
            <?php if($tabs==1) { ?>
            <div id="tab-order">
            <?php } ?>
                    <?php if($order_link==0) { ?>
                    <li>
                    <a href="<?php echo $order; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/orders.png" alt="<?php echo $text_order; ?>" "><?php echo $text_order; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($download_link==0) { ?>    
                    <li>
                    <a href="<?php echo $download; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/downloads.png" alt="<?php echo $text_download; ?>" "><?php echo $text_download; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($reward_link==0) { ?>
                    <li>
                    <a href="<?php echo $reward; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/rewards.png" alt="<?php echo $text_reward; ?>" "><?php echo $text_reward; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($return_link==0) { ?>
                    <li>
                    <a href="<?php echo $return; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/returns.png" alt="<?php echo $text_return; ?>" "><?php echo $text_return; ?></a><br>
                    </li>
                    <?php } ?>
                    <?php if($transaction_link==0) { ?>
                    <li>
                    <a href="<?php echo $transaction; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/transaction.png" alt="<?php echo $text_transaction; ?>" "><?php echo $text_transaction; ?></a><br>
                    </li>
                    <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
            <?php if($tabs==1) { ?>
            <div id="tab-newsletter">
            <?php } ?>
                <li>
                  <a href="<?php echo $newsletter; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/newsletter.png" alt="<?php echo $text_newsletter; ?>" "><?php echo $text_newsletter; ?></a><br>
                </li>  
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?>
                </ul>
            </div> 
            <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/metroui_i.css" />
            </div>
            <?php } ?>

          <?php if($style_a=='icons-7') { ?>
            <div class="alinks2">
            <ul>
            <?php if($tabs==1) { ?>
            <div id="tab-account">
            <?php } ?>
                    <?php if($edit_link==0) { ?>
                    <li class="edit">
                    <a href="<?php echo $edit; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/edit.png" alt="<?php echo $text_edit; ?>" "><p><?php echo $text_edit; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($password_link==0) { ?>
                    <li class="password">
                    <a href="<?php echo $password; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/password.png" alt="<?php echo $text_password; ?>" "><p><?php echo $text_password; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($address_link==0) { ?>
                    <li  class="address">
                    <a href="<?php echo $address; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/address.png" alt="<?php echo $text_address; ?>" "><p><?php echo $text_address; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($wishlist_link==0) { ?>
                    <li  class="wishlist">
                    <a href="<?php echo $wishlist; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/wishlist.png" alt="<?php echo $text_wishlist; ?>" "><p><?php echo $text_wishlist; ?></p></a><br>
      <li><a href="<?php echo $url_testimonial; ?>"><?php echo $text_testimonial; ?></a></li>
                    </li>
                    <?php } ?>
                    <?php if($logout_link==0) { ?>
                    <li  class="logout">
                    <a href="<?php echo $logout; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/logout.png" alt="logout" "><p><?php echo $text_logout; ?></p></a><br>
                    </li>
                    <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
            <?php if($tabs==1) { ?>
            <div id="tab-order">
            <?php } ?>
                    <?php if($order_link==0) { ?>
                    <li  class="order">
                    <a href="<?php echo $order; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/orders.png" alt="<?php echo $text_order; ?>" "><p><?php echo $text_order; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($download_link==0) { ?>    
                    <li  class="download">
                    <a href="<?php echo $download; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/downloads.png" alt="<?php echo $text_download; ?>" "><p><?php echo $text_download; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($reward_link==0) { ?>
                    <li class="reward">
                    <a href="<?php echo $reward; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/rewards.png" alt="<?php echo $text_reward; ?>" "><p><?php echo $text_reward; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($return_link==0) { ?>
                    <li  class="return">
                    <a href="<?php echo $return; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/returns.png" alt="<?php echo $text_return; ?>" "><p><?php echo $text_return; ?></p></a><br>
                    </li>
                    <?php } ?>
                    <?php if($transaction_link==0) { ?>
                    <li class="transaction">
                    <a href="<?php echo $transaction; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/transaction.png" alt="<?php echo $text_transaction; ?>" "><p><?php echo $text_transaction; ?></p></a><br>
                    </li>
                    <?php } ?>
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?> 
            <?php if($tabs==1) { ?>
            <div id="tab-newsletter">
            <?php } ?>
                <li  class="newsletter">
                  <a href="<?php echo $newsletter; ?>" ><img src="catalog/view/theme/default/image/accountplus/icons/<?php echo $icotype_a; ?>/newsletter.png" alt="<?php echo $text_newsletter; ?>" "><p><?php echo $text_newsletter; ?></p></a><br>
                </li>  
            <?php if($tabs==1) { ?>
            </div>
            <?php } ?>
                </ul>
            </div> 
            <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/accountplus/metroui_i.css" />
            </div>
            <?php } ?>


            <script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>  
            <script type="text/javascript"><!--
            $('.htabs a').tabs();
            //--></script>
            



























			  </div>
		</div>  
  <?php echo $content_bottom; ?></section>
 
	<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
	<?php endif; ?>
</div>
	
<?php echo $footer; ?> 