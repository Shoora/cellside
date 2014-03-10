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
    
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
   
   <div id="tabs-accountplus" class="htabs">
      <a href="#tab-account"><?php echo $text_tab_account; ?></a>
      <a href="#tab-affiliate"><?php echo $text_tab_affiliate; ?></a>
   </div>
   
   <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
     
   <div id="tab-account">
         <div id="tabs-account" class="vtabs">
              <a href="#tab-titles-account"><?php echo $text_custom_title; ?></a>
              <a href="#tab-display-account"><?php echo $text_display; ?></a>
              <a href="#tab-style-account"><?php echo $text_styles; ?></a>
          </div>

     <div id="tab-titles-account" class="vtabs-content">
      <?php foreach ($languages as $language) { ?>
		
            <table class="form">      
                <tr> 
					<td><?php echo $entry_title; ?></td> 
					<td> 
					<input type="text" name="accountplus_title<?php echo $language['language_id']; ?>" id="accountplus_title<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>
				</tr>
                
               <tr> 
					<td><?php echo $entry_title_account; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_account<?php echo $language['language_id']; ?>" id="accountplus_title_account<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_account' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
                <tr> 
					<td><?php echo $entry_title_orders; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_orders<?php echo $language['language_id']; ?>" id="accountplus_title_orders<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_orders' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
                <tr> 
					<td><?php echo $entry_title_newsletter; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_newsletter<?php echo $language['language_id']; ?>" id="accountplus_title_newsletter<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_newsletter' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
         </table>  
      <?php } ?>
     </div>
     
     
    <div id="tab-display-account" class="vtabs-content">
        
       <table class="form"> 
            <tr>
				<td colspan="2" bgcolor="#F7F7F7"><b><?php echo $text_general_display; ?></b></td>
			</tr>
            
            <tr> 
				<td><?php echo $entry_tabs; ?></td> 
				<td> 
					<?php if($accountplus_tabs) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_tabs_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_tabs_1" name="accountplus_tabs" value="1" /> 
				<label for="accountplus_tabs_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_tabs_0" name="accountplus_tabs" value="0" /> 
				</td>
			</tr>

            <tr> 
				<td><?php echo $entry_welcome_a; ?></td> 
				<td> 
					<?php if($accountplus_welcome_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_welcome_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_welcome_a_1" name="accountplus_welcome_a" value="1" /> 
				<label for="accountplus_welcome_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_welcome_a_0" name="accountplus_welcome_a" value="0" /> 
				</td>
			</tr>
            
            <tr>
				<td colspan="2" bgcolor="#F7F7F7"><b><?php echo $text_links_display; ?></b></td>
			</tr>
            
            <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_account_link; ?></b></td>
            
             <tr> 
				<td><?php echo $entry_edit_link; ?></td> 
				<td> 
					<?php if($accountplus_edit_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_edit_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_edit_link_1" name="accountplus_edit_link" value="1" /> 
				<label for="accountplus_edit_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_edit_link_0" name="accountplus_edit_link" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_password_link; ?></td> 
				<td> 
					<?php if($accountplus_password_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_password_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_password_link_1" name="accountplus_password_link" value="1" /> 
				<label for="accountplus_password_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_password_link_0" name="accountplus_password_link" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_address_link; ?></td> 
				<td> 
					<?php if($accountplus_address_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_address_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_address_link_1" name="accountplus_address_link" value="1" /> 
				<label for="accountplus_address_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_address_link_0" name="accountplus_address_link" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_wishlist_link; ?></td> 
				<td> 
					<?php if($accountplus_wishlist_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_wishlist_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_wishlist_link_1" name="accountplus_wishlist_link" value="1" /> 
				<label for="accountplus_wishlist_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_wishlist_link_0" name="accountplus_wishlist_link" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_logout_link; ?></td> 
				<td> 
					<?php if($accountplus_logout_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_logout_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_logout_link_1" name="accountplus_logout_link" value="1" /> 
				<label for="accountplus_logout_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_logout_link_0" name="accountplus_logout_link" value="0" /> 
				</td> 
			</tr>
            
            <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_order_link; ?></b></td>
            
             <tr> 
				<td><?php echo $entry_order_link; ?></td> 
				<td> 
					<?php if($accountplus_order_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_order_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_order_link_1" name="accountplus_order_link" value="1" /> 
				<label for="accountplus_order_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_order_link_0" name="accountplus_order_link" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_download_link; ?></td> 
				<td> 
					<?php if($accountplus_download_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_download_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_download_link_1" name="accountplus_download_link" value="1" /> 
				<label for="accountplus_download_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_download_link_0" name="accountplus_download_link" value="0" /> 
				</td> 
			</tr>
            
            <tr> 
				<td><?php echo $entry_reward_link; ?></td> 
				<td> 
					<?php if($accountplus_reward_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_reward_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_reward_link_1" name="accountplus_reward_link" value="1" /> 
				<label for="accountplus_reward_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_reward_link_0" name="accountplus_reward_link" value="0" /> 
				</td> 
			</tr>
            
            
             <tr> 
				<td><?php echo $entry_return_link; ?></td> 
				<td> 
					<?php if($accountplus_return_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_return_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_return_link_1" name="accountplus_return_link" value="1" /> 
				<label for="accountplus_return_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_return_link_0" name="accountplus_return_link" value="0" /> 
				</td> 
			</tr>
            
             
            
             <tr> 
				<td><?php echo $entry_transaction_link; ?></td> 
				<td> 
					<?php if($accountplus_transaction_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_transaction_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_transaction_link_1" name="accountplus_transaction_link" value="1" /> 
				<label for="accountplus_transaction_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_transaction_link_0" name="accountplus_transaction_link" value="0" /> 
				</td> 
			</tr>
            
             <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_newsletter_link; ?></b></td>
             <tr> 
				<td><?php echo $entry_newsletter_link; ?></td> 
				<td> 
					<?php if($accountplus_newsletter_link) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_newsletter_link_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_newsletter_link_1" name="accountplus_newsletter_link" value="1" /> 
				<label for="accountplus_newsletter_link_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_newsletter_link_0" name="accountplus_newsletter_link" value="0" /> 
				</td> 
			</tr>
        </table>
    </div>

     <div id="tab-style-account" class="vtabs-content">
        <table class="form">
          
           <tr>
             <td><label><?php echo $entry_style; ?></label></td>
    	  <td>
            <select name="style_a">
            	<option value="default" <?php if($style_a == 'default') { echo " selected"; }?> >Simple</option>
                <option value="icons-1" <?php if($style_a == 'icons-1') { echo " selected"; }?> >Simple Icons</option>
                <option value="icons-2" <?php if($style_a == 'icons-2') { echo " selected"; }?> >Page Icons</option>
                <option value="icons-3" <?php if($style_a == 'icons-3') { echo " selected"; }?> >Modern List</option>
                <option value="icons-4" <?php if($style_a == 'icons-4') { echo " selected"; }?> >Accordion - Simple</option>
                <option value="icons-5" <?php if($style_a == 'icons-5') { echo " selected"; }?> >Accordion - Icons</option>
                <option value="icons-6" <?php if($style_a == 'icons-6') { echo " selected"; }?> >Metro - Style 1</option>
                <option value="icons-7" <?php if($style_a == 'icons-7') { echo " selected"; }?> >Metro - Style 2</option>
            </select>
           </td>
    	 	</tr>
            
            <tr>
                 <td><label><?php echo $entry_icotype; ?></label></td>
    		  <td>
                <select name="icotype_a">
                	<option value="balloonica" <?php if($icotype_a == 'balloonica') { echo " selected"; }?> >Balloonica</option>
                    <option value="black_moon" <?php if($icotype_a == 'black_moon') { echo " selected"; }?> >Black Moon</option>
                    <option value="blue_velvet" <?php if($icotype_a == 'blue_velvet') { echo " selected"; }?> >Blue Velvet</option>
                    <option value="colorful_stickers" <?php if($icotype_a == 'colorful_stickers') { echo " selected"; }?> >Colorful Stickers</option>
                    <option value="coquette" <?php if($icotype_a == 'coquette') { echo " selected"; }?> >Coquette</option>
                    <option value="handy" <?php if($icotype_a == 'handy') { echo " selected"; }?> >Handy</option>
                    <option value="luna_blue" <?php if($icotype_a == 'luna_blue') { echo " selected"; }?> >Luna Blue</option>
                    <option value="luna_grey" <?php if($icotype_a == 'luna_grey') { echo " selected"; }?> >Luna Grey</option>
                    <option value="metro_black" <?php if($icotype_a == 'metro_black') { echo " selected"; }?> >Metro Black</option>
                    <option value="metro_white" <?php if($icotype_a == 'metro_white') { echo " selected"; }?> >Metro White</option>
                    <option value="minimalistica_blue" <?php if($icotype_a == 'minimalistica_blue') { echo " selected"; }?> >Minimalistica Blue</option>
                    <option value="minimalistica_red" <?php if($icotype_a == 'minimalistica_red') { echo " selected"; }?> >Minimalistica Red</option>
                    <option value="moon_blue" <?php if($icotype_a == 'moon_blue') { echo " selected"; }?> >Moon Blue</option>
                    <option value="moon_red" <?php if($icotype_a == 'moon_red') { echo " selected"; }?> >Moon Red</option>
                    <option value="reflection_blue" <?php if($icotype_a == 'reflection_blue') { echo " selected"; }?> >Reflection Blue</option>
                    <option value="reflection_red" <?php if($icotype_a == 'reflection_red') { echo " selected"; }?> >Reflection Red</option>
                    <option value="stickers" <?php if($icotype_a == 'stickers') { echo " selected"; }?> >Stickers</option>
                    <option value="stylistica" <?php if($icotype_a == 'stylistica') { echo " selected"; }?> >Stylistica</option>
                    <option value="symbolize" <?php if($icotype_a == 'symbolize') { echo " selected"; }?> >Symbolize</option>
                    <option value="web_purple" <?php if($icotype_a == 'web_purple') { echo " selected"; }?> >Web Purple</option>
            </select>
           </td>
    	 	</tr>
           </table> 
       </div>        

   </div>   
        
   <div id="tab-affiliate">

      <div id="tabs-affiliate" class="vtabs">
          <a href="#tab-titles-affiliate"><?php echo $text_custom_title; ?></a>
          <a href="#tab-display-affiliate"><?php echo $text_display; ?></a>
          <a href="#tab-style-affiliate"><?php echo $text_styles; ?></a>
      </div>

     <div id="tab-titles-affiliate" class="vtabs-content">
      <?php foreach ($languages as $language) { ?>
            <table class="form">      
                <tr> 
					<td><?php echo $entry_title_a; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_a<?php echo $language['language_id']; ?>" id="accountplus_title_a<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_a' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>
				</tr>
                
               <tr> 
					<td><?php echo $entry_title_account_a; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_account_a<?php echo $language['language_id']; ?>" id="accountplus_title_account_a<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_account_a' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
                <tr> 
					<td><?php echo $entry_title_tracking_a; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_tracking_a<?php echo $language['language_id']; ?>" id="accountplus_title_orders_a<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_tracking_a' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
                <tr> 
					<td><?php echo $entry_title_transaction_a; ?></td> 
					<td> 
					<input type="text" name="accountplus_title_transaction_a<?php echo $language['language_id']; ?>" id="accountplus_title_newsletter_a<?php echo $language['language_id']; ?>" size="30" value="<?php echo ${'accountplus_title_transaction_a' . $language['language_id']}; ?>" />
					<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" style="vertical-align: top;" /><br />
					</td>                    
				</tr>
         </table>  
      <?php } ?>
     </div> 

    <div id="tab-display-affiliate" class="vtabs-content">
        <table class="form">
            <tr>
				<td colspan="2" bgcolor="#F7F7F7"><b><?php echo $text_general_display; ?></b></td>
			</tr>
            
            <tr> 
				<td><?php echo $entry_tabs_a; ?></td> 
				<td> 
					<?php if($accountplus_tabs_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_tabs_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_tabs_a_1" name="accountplus_tabs_a" value="1" /> 
				<label for="accountplus_tabs_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_tabs_a_0" name="accountplus_tabs_a" value="0" /> 
				</td>
			</tr>

            <tr> 
				<td><?php echo $entry_welcome_af; ?></td> 
				<td> 
					<?php if($accountplus_welcome_af) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_welcome_af_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_welcome_af_1" name="accountplus_welcome_af" value="1" /> 
				<label for="accountplus_welcome_af_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_welcome_af_0" name="accountplus_welcome_af" value="0" /> 
				</td>
			</tr>

            <tr>
				<td colspan="2" bgcolor="#F7F7F7"><b><?php echo $text_links_display; ?></b></td>
			</tr>
            
            <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_account_link_a; ?></b></td>
            
             <tr> 
				<td><?php echo $entry_edit_link_a; ?></td> 
				<td> 
					<?php if($accountplus_edit_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_edit_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_edit_link_a_1" name="accountplus_edit_link_a" value="1" /> 
				<label for="accountplus_edit_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_edit_link_a_0" name="accountplus_edit_link_a" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_password_link_a; ?></td> 
				<td> 
					<?php if($accountplus_password_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_password_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_password_link_1" name="accountplus_password_link_a" value="1" /> 
				<label for="accountplus_password_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_password_link_0" name="accountplus_password_link_a" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_payment_link_a; ?></td> 
				<td> 
					<?php if($accountplus_payment_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_payment_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_payment_link_1" name="accountplus_payment_link_a" value="1" /> 
				<label for="accountplus_payment_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_payment_link_0" name="accountplus_payment_link_a" value="0" /> 
				</td> 
			</tr>
            
             <tr> 
				<td><?php echo $entry_logout_link_a; ?></td> 
				<td> 
					<?php if($accountplus_logout_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_logout_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_logout_link_a_1" name="accountplus_logout_link_a" value="1" /> 
				<label for="accountplus_logout_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_logout_link_a_0" name="accountplus_logout_link_a" value="0" /> 
				</td> 
			</tr>
            
            <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_tracking_link_a; ?></b></td>
            
             <tr> 
				<td><?php echo $entry_tracking_link_a; ?></td> 
				<td> 
					<?php if($accountplus_tracking_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_tracking_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_tracking_link_a_1" name="accountplus_tracking_link_a" value="1" /> 
				<label for="accountplus_tracking_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_tracking_link_a_0" name="accountplus_tracking_link_a" value="0" /> 
				</td> 
			</tr>
            
             <td colspan="1" bgcolor="#F9F9F9"><b><?php echo $text_transaction_link_a; ?></b></td>
            <tr> 
				<td><?php echo $entry_transaction_link_a; ?></td> 
				<td> 
					<?php if($accountplus_transaction_link_a) { 
					$checked1 = ' checked="checked"'; 
					$checked0 = ''; 
					} else { 
					$checked1 = ''; 
					$checked0 = ' checked="checked"'; 
					} ?> 
				<label for="accountplus_transaction_link_a_1"><?php echo $entry_yes; ?></label> 
				<input type="radio"<?php echo $checked1; ?> id="accountplus_transaction_link_a_1" name="accountplus_transaction_link_a" value="1" /> 
				<label for="accountplus_transaction_link_a_0"><?php echo $entry_no; ?></label> 
				<input type="radio"<?php echo $checked0; ?> id="accountplus_transaction_link_a_0" name="accountplus_transaction_link_a" value="0" /> 
				</td> 
			</tr>
                   
        </table>
      </div>
     <div id="tab-style-affiliate" class="vtabs-content">
        <table class="form">
          
           <tr>
             <td><label><?php echo $entry_style; ?></label></td>
    	  <td>
            <select name="style_af">
            	<option value="default" <?php if($style_af == 'default') { echo " selected"; }?> >Simple</option>
                <option value="icons-1" <?php if($style_af == 'icons-1') { echo " selected"; }?> >Simple Icons</option>
                <option value="icons-2" <?php if($style_af == 'icons-2') { echo " selected"; }?> >Page Icons</option>
                <option value="icons-3" <?php if($style_af == 'icons-3') { echo " selected"; }?> >Modern List</option>
                <option value="icons-4" <?php if($style_af == 'icons-4') { echo " selected"; }?> >Accordion - Simple</option>
                <option value="icons-5" <?php if($style_af == 'icons-5') { echo " selected"; }?> >Accordion - Icons</option>
                <option value="icons-6" <?php if($style_af == 'icons-6') { echo " selected"; }?> >Metro - Style 1</option>
                <option value="icons-7" <?php if($style_af == 'icons-7') { echo " selected"; }?> >Metro - Style 2</option>
            </select>
           </td>
    	 	</tr>
            
            <tr>
                 <td><label><?php echo $entry_icotype; ?></label></td>
    		  <td>
                <select name="icotype_af">
                	<option value="balloonica" <?php if($icotype_af == 'balloonica') { echo " selected"; }?> >Balloonica</option>
                    <option value="black_moon" <?php if($icotype_af == 'black_moon') { echo " selected"; }?> >Black Moon</option>
                    <option value="blue_velvet" <?php if($icotype_af == 'blue_velvet') { echo " selected"; }?> >Blue Velvet</option>
                    <option value="colorful_stickers" <?php if($icotype_af == 'colorful_stickers') { echo " selected"; }?> >Colorful Stickers</option>
                    <option value="coquette" <?php if($icotype_af == 'coquette') { echo " selected"; }?> >Coquette</option>
                    <option value="handy" <?php if($icotype_af == 'handy') { echo " selected"; }?> >Handy</option>
                    <option value="luna_blue" <?php if($icotype_af == 'luna_blue') { echo " selected"; }?> >Luna Blue</option>
                    <option value="luna_grey" <?php if($icotype_af == 'luna_grey') { echo " selected"; }?> >Luna Grey</option>
                    <option value="metro_black" <?php if($icotype_af == 'metro_black') { echo " selected"; }?> >Metro Black</option>
                    <option value="metro_white" <?php if($icotype_af == 'metro_white') { echo " selected"; }?> >Metro White</option>
                    <option value="minimalistica_blue" <?php if($icotype_af == 'minimalistica_blue') { echo " selected"; }?> >Minimalistica Blue</option>
                    <option value="minimalistica_red" <?php if($icotype_af == 'minimalistica_red') { echo " selected"; }?> >Minimalistica Red</option>
                    <option value="moon_blue" <?php if($icotype_af == 'moon_blue') { echo " selected"; }?> >Moon Blue</option>
                    <option value="moon_red" <?php if($icotype_af == 'moon_red') { echo " selected"; }?> >Moon Red</option>
                    <option value="reflection_blue" <?php if($icotype_af == 'reflection_blue') { echo " selected"; }?> >Reflection Blue</option>
                    <option value="reflection_red" <?php if($icotype_af == 'reflection_red') { echo " selected"; }?> >Reflection Red</option>
                    <option value="stickers" <?php if($icotype_af == 'stickers') { echo " selected"; }?> >Stickers</option>
                    <option value="stylistica" <?php if($icotype_af == 'stylistica') { echo " selected"; }?> >Stylistica</option>
                    <option value="symbolize" <?php if($icotype_af == 'symbolize') { echo " selected"; }?> >Symbolize</option>
                    <option value="web_purple" <?php if($icotype_af == 'web_purple') { echo " selected"; }?> >Web Purple</option>
            </select>
           </td>
    	 </tr>
        </table> 
       </div>        
    </form>
  </div>
</div>

<script type="text/javascript"><!--
$('#tabs-accountplus a').tabs();
$('#tabs-account a').tabs();
$('#tabs-affiliate a').tabs();
//--></script>

<?php echo $footer; ?>