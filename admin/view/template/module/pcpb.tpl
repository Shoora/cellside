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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <h2><?php echo $text_product_mapping;?></h2>
		<table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $text_option_background; ?></td>
            <td>
	            <select name="pcpb_option_background">
	            	<?php foreach ($list_background_options as $key=>$name) {?>
	            		<option value="<?php echo $key;?>" <?php if ($pcpb_option_background == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php } ?>
	            </select>
                <?php if ($error_option_background) { ?>
                	<span class="error"><?php echo $error_option_background; ?></span>
                <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $text_option_preset; ?></td>
            <td>
	            <select name="pcpb_option_preset">
	            	<?php foreach ($list_background_options as $key=>$name):?>
	            		<option value="<?php echo $key;?>" <?php if ($pcpb_option_preset == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php endforeach;?>
	            </select>
                <?php if ($error_option_preset) { ?>
                	<span class="error"><?php echo $error_option_preset; ?></span>
                <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $text_option_save_url; ?></td>
            <td>
	            <select name="pcpb_option_save_url">
	            	<?php foreach ($list_url_options as $key=>$name):?>
	            		<option value="<?php echo $key;?>" <?php if ($pcpb_option_save_url == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php endforeach;?>
	            </select>
                <?php if ($error_option_save_url) { ?>
                	<span class="error"><?php echo $error_option_save_url; ?></span>
                <?php } ?></td>
          </tr>
        </table>
		<h2><?php echo $text_other;?></h2>		
		<table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $text_max_size_upload; ?></td>
            <td>
	            <input type="text" name="pcpb_max_size_upload" value="<?php echo $pcpb_max_size_upload;?>"/>
                <?php if ($error_max_size_upload) { ?>
                	<span class="error"><?php echo $error_max_size_upload; ?></span>
                <?php } ?></td>
          </tr>
          <tr>
            <td>
            	<span class="required">*</span> <?php echo $text_path_folder_save_temprarily; ?>
            	<br/>
            	<span class="help"><?php echo $text_path_folder_save_temprarily_description;?></span>
            </td>
            <td>
	            <input type="text" name="pcpb_path_folder_save_temprarily" value="<?php echo $pcpb_path_folder_save_temprarily;?>"/>
                <?php if ($error_path_folder_save_temprarily) { ?>
                	<span class="error"><?php echo $error_path_folder_save_temprarily; ?></span>
                <?php } ?></td>
          </tr>
          <tr>
            <td>
            	<span class="required">*</span> <?php echo $text_path_folder_save_permanently; ?>
            	<br/>
            	<span class="help"><?php echo $text_path_folder_save_permanently_description;?></span>
            </td>
            <td>
	            <input type="text" name="pcpb_path_folder_save_permanently" value="<?php echo $pcpb_path_folder_save_permanently;?>"/>
                <?php if ($error_path_folder_save_permanently) { ?>
                	<span class="error"><?php echo $error_path_folder_save_permanently; ?></span>
                <?php } ?></td>
          </tr>
          <tr>
            <td>
            	<?php echo $text_automatic_clean; ?>
            </td>
            <td>
	            <select name="pcpb_automatic_clean">
	            	<?php foreach ($list_automatic as $key=>$name):?>
	            		<option value="<?php echo $key;?>" <?php if ($pcpb_automatic_clean == $key) echo "selected='selected'" ?>><?php echo $name;?></option>
	            	<?php endforeach;?>
	            </select>
	        </td>
          </tr>
          <tr>
            <td colspan="2">
            	<a href="javascript:void(0);" onclick="cleanTemp()" class="button"><?php echo $text_clean_folder?></a>
	        </td>
          </tr>
        </table>
        <h2><?php echo $text_font;?></h2>		
		<table class="form">
          <tr>
              <td><?php echo $text_enable_system_fonts; ?></td>
              <td>
              		<input type="radio" name="pcpb_enable" value="1" <?php if ($pcpb_enable) echo "checked='checked'";?> />
                	<?php echo $text_yes; ?>
                	<input type="radio" name="pcpb_enable" value="0" <?php if (!$pcpb_enable) echo "checked='checked'";?>/>
                	<?php echo $text_no; ?>
              </td>
          </tr>
          <tr>
            <td>
            	<?php echo $text_add_link_google_fonts; ?>
            </td>
            <td>
	            <input type="text" id="fonts_google" value=""  style="display:inline-block;"/>
                <a onclick="addGoogleFonts();" class="button"><?php echo $text_add_link;?></a>
                <div style="display:none;" id="msg_fonts_google" class="success">
	               <span>Add google fonts success</span>
                </div>
                <div style="display:none;" id="msg_fonts_google_error" class="warning">
	               <span>Link not exist</span>
                </div>
            </td>            
          </tr>
          <tr>
            <td><?php echo $text_list_link_google_fonts; ?></td>
            <td>
				<select id="pcpb_text_font" style="width: 153px;padding: 1px 0px;margin-left: 2px;">
                    <?php foreach ($list_link_google_fonts_options as $list_link_google_fonts) {
                        $fontsName = str_replace(" ", "", $list_link_google_fonts['key']);
                        ?>
                        <option value="<?php echo $list_link_google_fonts['key'];?>" id="<?php echo $fontsName;?>"><?php echo $list_link_google_fonts['key'];?></option>        
                    <?php } ?>
				</select>
                <a onclick="removeGoogleFonts();" class="button"><?php echo $text_remove_link;?></a>
                <div style="display:none;" id="msg_fonts_google_remove" class="success">
	               <span>Remove google fonts success</span>
                </div>
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

function addGoogleFonts(){
    $('#msg_fonts_google_remove').attr("style","display:none");
    $('#msg_fonts_google').attr("style","display:none");
    $('#msg_fonts_google_error').attr("style","display:none");
    var fonts = $('#fonts_google').val();    
	$.ajax({
		url: 'index.php?route=module/pcpb/addGoogleFonts&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'fonts=' + fonts,
		success: function(json){
		  if(json != null && json != "")
          {
            var nameFonts =  json.replace(/ /g, "");
			$('#msg_fonts_google').attr("style","display:inline-block");
            $('#pcpb_text_font').append("<option value="+ json +" id="+ nameFonts +">"+ json +"</option>");            
          }
          else
          {
            $('#msg_fonts_google_error').attr("style","display:inline-block");
          }
		},
        error: function(){
            $('#msg_fonts_google_error').attr("style","display:inline-block");
        }
	});
}
function removeGoogleFonts(){
    $('#msg_fonts_google_remove').attr("style","display:none");
    $('#msg_fonts_google').attr("style","display:none");
    $('#msg_fonts_google_error').attr("style","display:none");
    var fonts = $('#pcpb_text_font').val(); 
    var re = /((\s*\S+)*)\s*/;
    fonts = fonts.replace(re, "$1");   
	$.ajax({
		url: 'index.php?route=module/pcpb/removeGoogleFonts&token=<?php echo $token; ?>',
        type: 'post',
		dataType: 'json',
        data: 'fonts=' + fonts,
		success: function(json){
            var nameFonts =  fonts.replace(/ /g, "");
		    $('#'+nameFonts).remove();
			$('#msg_fonts_google_remove').attr("style","display:inline-block");        
		}
	});
}
//--></script>
<script>    
	function cleanTemp(){
		$.ajax({
			method: 'POST',
			url: '/index.php?route=pcpb/upload/clean',
			dataType: 'json',
			success: function(datas){
				if(datas.errorCode == 0)
					alert('Done');
			}
		})
	}
</script>
<?php echo $footer; ?>