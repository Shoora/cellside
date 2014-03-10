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
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
   <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" ;>

	<div id="settings_tabs" class="htabs clearfix">
			<a href="#emailset"><?php echo 'Auto Print Login & Printer Select'; ?></a>
			<a href="#invset"><?php echo 'General Settings'; ?></a>
			<a href="#invset2"><?php echo 'Invoice Settings'; ?></a>
			<a href="#cache"><?php echo 'Clear Print Cache'; ?></a>
			
			
		</div>
		
		<div id="emailset" class="divtab">
     <br></br>
	<?php if($public_key){  ?>
	  <form method="post"  id="form_2" action="unlink2.php">
<input type="image" src="controller/icache/files/click.png" value="Sign Out" name="sub2"/>
 	<script type="text/javascript"> 

 $(function() {
  
  $('input[name=sub2]').click(function(){
    var _data= $('#form_2').serialize() + '&sub2=' + $(this).val();
   
   $.ajax({
    
   type: 'POST',
      url: "unlink2.php?",
      data:_data,
	
      success: function(html){
         $('div#1').html(html);
		 alert('Signed Out! Now remove Username & Password and Click Save!');
		  
      }
    });
    return false;
	 alert('Error!');
  });
});
 </script> 
<?php }
  ?>
	 <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_public_key; ?></td>
          <td><input input name="googleprint_public_key" value="<?php echo $public_key; ?>" size="56"><br />
            <?php if ($error_public_key) { ?>
            <span class="error"><?php echo $error_public_key; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_private_key; ?></td>
          <td><input type="password" input name="googleprint_private_key" value="<?php echo $private_key; ?>" size="56"><br />
            <?php if ($error_private_key) { ?>
            <span class="error"><?php echo $error_private_key; ?></span>
            <?php } ?></td>
        </tr>
<?php		
		if (empty($public_key)) 
{
?>
<img border="0" src="controller/icache/files/uberprint.jpg" alt="Uber Print" >
<br><b><font color="red">Welcome to Uber Auto Print!</font></b></br>
<br><font color="blue">For Initial Set Up, Please enter your Google User Name & Password Then Press Save</font></br>

<br><font color="green">If you receive the message 'BAD AUTHENTICATION' this can mean 2 things </font></br>
<br><font color="green">1. You have 2 step verfication on your google account please visit this link to remove it <a href="https://support.google.com/accounts/answer/1064203?hl=en " target="_blank">2 Step Verification Help</a> </font></br>
<br><font color="green">2. Google has blocked you host/server for suspicious activity, please check the gmail account associated with your Cloud Print login and see if Google has sent you a warning email stating logon from unknown location, please open the email and follow directions to allow the application. </font></br>

<?php
 }
  else {
  ?>
     </form>
 <br></br>
  <?php require('controller/icache/files/printeradmin.php');?>
 </table>
</div>
	<div id="invset" class="divtab">
  <table class="form">
  
 
	 		   
			   <td><?php echo $entry_savegoogle_drive; ?></td>
            <td><?php if ($savegoogle_drive) { ?>
              <input type="radio" name="savegoogle_drive" value="1" checked="checked" />
              <?php echo "Yes"; ?>
              <input type="radio" name="savegoogle_drive" value="0" />
              <?php echo "No"; ?>
              <?php } else { ?>
              <input type="radio" name="savegoogle_drive" value="1" />
              <?php echo "Yes"; ?>
              <input type="radio" name="savegoogle_drive" value="0" checked="checked" />
              <?php echo "No"; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </tr>
			  
			  <td><?php echo $entry_savegoogle_drive2; ?></td>
            <td><?php if ($savegoogle_drive2) { ?>
              <input type="radio" name="savegoogle_drive2" value="1" checked="checked" />
              <?php echo "Yes"; ?>
              <input type="radio" name="savegoogle_drive2" value="0" />
              <?php echo "No"; ?>
              <?php } else { ?>
              <input type="radio" name="savegoogle_drive2" value="1" />
              <?php echo "Yes"; ?>
              <input type="radio" name="savegoogle_drive2" value="0" checked="checked" />
              <?php echo "No"; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </tr>
			  
			   <tr>
			 <tr>
		    <td><?php echo $entry_custfoot23; ?></td>
            <td><?php if ($custfoot23) { ?>
              <input type="radio" name="custfoot23" value="1" checked="checked" />
              <?php echo "Invoice 2"; ?>
              <input type="radio" name="custfoot23" value="0" />
              <?php echo "Invoice 1"; ?>
              <?php } else { ?>
              <input type="radio" name="custfoot23" value="1" />
              <?php echo "Invoice 2"; ?>
              <input type="radio" name="custfoot23" value="0" checked="checked" />
              <?php echo "Invoice 1"; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td></tr>
			  
			 
  
	  </table></div>  </form>
	  
	  <div id="invset2" class="divtab">
  <table class="form">
	<td colspan="2" bgcolor="#F7F7F7"><b>Invoice1 Settings:- Customise Size & Margins</b><span class="help">(Please enter Units (eg: px, cm, em or %)</span></b></td>
		
		
				<tr><td><?php echo $entry_auto_flogo; ?></td>
           <td> <?php if (empty($auto_flogo)) { $auto_flogo = '40px'; }?>
			<?php if ($auto_flogo) { ?>
            <input name="auto_flogo" value="<?php echo $auto_flogo; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_flogo" value="<?php echo $auto_flogo; ?>" size="5" />
			  <?php } ?>
			  </td></tr>
			  <tr>
	 
	 <td><?php echo $entry_auto_width; ?></td>
           <td> <?php if (empty($auto_width)) { $auto_width = '680px'; }?>
			<?php if ($auto_width) { ?>
            <input name="auto_width" value="<?php echo $auto_width; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_width" value="<?php echo $auto_width; ?>" size="5" />
			  <?php } ?>
				  
			  <tr><td><?php echo $entry_auto_tfont; ?></td>
           <td> <?php if (empty($auto_tfont)) { $auto_tfont = '12px'; }?>
			<?php if ($auto_tfont) { ?>
            <input name="auto_tfont" value="<?php echo $auto_tfont; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_tfont" value="<?php echo $auto_tfont; ?>" size="5" />
			  <?php } ?>
		 
		 <tr><td><?php echo $entry_auto_bfont; ?></td>
           <td> <?php if (empty($auto_bfont)) { $auto_bfont = '12px'; }?>
			<?php if ($auto_bfont) { ?>
            <input name="auto_bfont" value="<?php echo $auto_bfont; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_bfont" value="<?php echo $auto_bfont; ?>" size="5" />
			  <?php } ?>
			  
			  <tr><td><?php echo $entry_auto_cfont; ?></td>
           <td> <?php if (empty($auto_cfont)) { $auto_cfont = '12px'; }?>
			<?php if ($auto_cfont) { ?>
            <input name="auto_cfont" value="<?php echo $auto_cfont; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_bfont" value="<?php echo $auto_bfont; ?>" size="5" />
			  <?php } ?>
			  
			  <tr><td><?php echo $entry_auto_border; ?></td>
           <td> <?php if (empty($auto_border)) { $auto_border = '1px'; }?>
			<?php if ($auto_border) { ?>
            <input name="auto_border" value="<?php echo $auto_border; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_border" value="<?php echo $auto_border; ?>" size="5" />
			  <?php } ?>
			  
			   <tr><td><?php echo $entry_auto_pad; ?></td>
           <td> <?php if (empty($auto_pad)) { $auto_pad = '7px'; }?>
			<?php if ($auto_pad) { ?>
            <input name="auto_pad" value="<?php echo $auto_pad; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_pad" value="<?php echo $auto_pad; ?>" size="5" />
			  <?php } ?>
		   
        			  
			  <tr><td><?php echo $entry_auto_margin; ?></td>
           <td> <?php if (empty($auto_margin)) { $auto_margin = '20px'; }?>
			<?php if ($auto_margin) { ?>
            <input name="auto_margin" value="<?php echo $auto_margin; ?>" size="5" />
			  
			  <?php } else { ?>
			  <input name="auto_margin" value="<?php echo $auto_margin; ?>" size="5" />
			  <?php } ?>
			</td></tr>

		<td colspan="2" bgcolor="#F7F7F7"><b>Invoice 2 Settings</b></td>	
		<tr> 
			  <td><?php echo $entry_invname2c2; ?></td>
           <td> <?php if (empty($invname2c2)) { $invname = ''; }?>
			<?php if ($invname2c2) { ?>
            <input name="invname2c2" value="<?php echo $invname2c2; ?>" size="20" />
			  
			  <?php } else { ?>
			  <input name="invname2c2" value="<?php echo $invname2c2; ?>" size="20" />
			  <?php } ?> </td></tr>
			 
			 <tr>
			 


			 <td><?php echo $entry_inv_skuca2; ?></td>
            <td><?php if ($inv_skuca2) { ?>
              <input type="radio" name="inv_skuca2" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="inv_skuca2" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="inv_skuca2" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="inv_skuca2" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td></tr>
			  <tr>
            <td><?php echo $entry_invpicav2; ?></td>
            <td><?php if ($invpicav2) { ?>
              <input type="radio" name="invpicav2" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="invpicav2" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="invpicav2" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="invpicav2" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 </td></tr> 
			  <tr>
			 <tr>
		    <td><?php echo $entry_custfoot2; ?></td>
            <td><?php if ($custfoot2) { ?>
              <input type="radio" name="custfoot2" value="1" checked="checked" />
              <?php echo "Enabled"; ?>
              <input type="radio" name="custfoot2" value="0" />
              <?php echo "Disabled"; ?>
              <?php } else { ?>
              <input type="radio" name="custfoot2" value="1" />
              <?php echo "Enabled"; ?>
              <input type="radio" name="custfoot2" value="0" checked="checked" />
              <?php echo "Disabled"; ?>
              <?php } ?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td></tr>
			  <tr>
			
			  <td><?php echo $entry_custfoot221; ?></td>
               <td><?php if ($custfoot221) { ?>
              <textarea name="custfoot221" cols="52" rows="5"><?php echo $custfoot221; ?></textarea>
			  
			  <?php } else { ?>
			  <textarea name="custfoot221" cols="52" rows="5"><?php echo $custfoot221; ?></textarea>
			  <?php } ?></td></tr>
         
 
 </table></div>  </form>
 <div id="cache" class="divtab">

  <form method="post"  id="form_1" action="unlink.php">
<input type="image" src="controller/icache/files/trash.png" value="Clear Cache" name="sub"/>
 	<script type="text/javascript"> 
  $(function() {
  $('input[name=sub]').click(function(){
    var _data= $('#form_1').serialize() + '&sub=' + $(this).val();
    $.ajax({
      type: 'POST',
      url: "unlink.php?",
      data:_data,
      success: function(html){
         $('div#1').html(html);
		 alert('Print Cache Cleared!');
      }
    });
    return false;
	 alert('Cache Not Cleared!');
  });
});
 </script> 
 <br></br>
 <br> This can be set up via cron job reccomend clearing cache at least once a week</br>
 <br> Example Cron Job : /usr/bin/php -q /home/**username**/public_html/**yourwebsite.com**/admin/unlink.php >/dev/null 2>&1 </br>
  </div>
</div>
	<script type="text/javascript">

	$('#settings_tabs a').tabs();

</script>
<?php
}

?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
	CKEDITOR.replace('custfoot221', {
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
</script>