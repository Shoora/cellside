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
      <h1><img src="view/image/order.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
		  <tr>
		    <td colspan="2">
			  <div id="languages" class="htabs">
              <?php foreach ($languages as $language) { ?>
                <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
              <?php } ?>
              </div>
              <?php foreach ($languages as $language) { ?>
              <div id="language<?php echo $language['language_id']; ?>">
                <table class="form">
                  <tr>
                    <td><?php echo $entry_template_name; ?></td>
                    <td><input type="text" name="email_description[<?php echo $language['language_id']; ?>][name]" size="100" value="<?php echo isset($email_description[$language['language_id']]) ? $email_description[$language['language_id']]['name'] : ''; ?>" />
					<?php if (isset($error_name[$language['language_id']])) { ?>
                    <span class="error"><?php echo $error_name[$language['language_id']]; ?></span>
                    <?php } ?></td>
                  </tr>
                  <tr>
                    <td><?php echo $entry_template_description; ?></td>
                    <td><textarea cols="170" rows="14" name="email_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($email_description[$language['language_id']]) ? $email_description[$language['language_id']]['description'] : ''; ?></textarea></td>
                  </tr>
                </table>
              </div>
		    <?php } ?>
			<table style="width: 100%;"><tr><td style="vertical-align: top;">
			<?php echo $entry_template_status; ?>
			<input type="checkbox" name="email_status" value="1" <?php echo $email_status; ?> /><br />
			<?php if (preg_match('/^(\d+|return_\d+)$/i', $id)) { ?>
			<?php echo $entry_template_track; ?>
			<input type="checkbox" name="email_track" value="1" <?php echo $email_track; ?> /><br />
			<?php } ?>
			<?php echo $entry_template_special; ?>
			  <select name="email_special">
			    <option value="0">0</option>
                  <?php foreach ($email_specials as $special) { ?>
                  <?php if ($special == $email_special) { ?>
                  <option value="<?php echo $special; ?>" selected="selected"><?php echo $special; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $special; ?>"><?php echo $special; ?></option>
                  <?php } ?>
                  <?php } ?>
              </select>
			  <input type="hidden" value="<?php echo $id; ?>" name="id" />
			  </td><td style="text-align: right;"><?php echo $entry_template_shortcode; ?></td></tr></table>
		    </td>
		  </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
CKEDITOR.on('instanceReady', function( ev ) {
	var blockTags = ['div','h1','h2','h3','h4','h5','h6','p','pre','li','blockquote','ul','ol',
  'table','thead','tbody','tfoot','td','th'];

	for (var i = 0; i < blockTags.length; i++) {
		ev.editor.dataProcessor.writer.setRules( blockTags[i], {
			indent : false,
			breakBeforeOpen : true,
			breakAfterOpen : false,
			breakBeforeClose : false,
			breakAfterClose : true
		});
	}
});

CKEDITOR.config.autoParagraph = false;
CKEDITOR.config.htmlEncodeOutput = false;

<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
$('#languages a').tabs();
//--></script> 
<?php echo $footer; ?>