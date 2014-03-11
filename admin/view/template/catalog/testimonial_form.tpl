<?php echo $header; ?>
	<style type="text/css">
	.box > .content h2 { border-bottom: 1px dotted #000000; color: #FF802B; font-size: 15px; font-weight: bold; padding-bottom: 3px; text-transform: uppercase; }
	</style>
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
      <h1><img src="view/image/testimonial.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_title; ?></td>
            <td><input type="text" name="title" value="<?php echo $title; ?>" size="70" />
              <?php if ($error_title) { ?>
              <span class="error"><?php echo $error_title; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_public_text; ?></td>
            <td><textarea name="public_text" cols="60" rows="8"><?php echo $public_text; ?></textarea>
          </tr>
          <tr>
            <td><?php echo $entry_private_text; ?></td>
            <td><textarea name="private_text" cols="60" rows="8"><?php echo $private_text; ?></textarea>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_author; ?></td>
            <td><input type="text" name="author" value="<?php echo $author; ?>"  size="50" />
              <?php if ($error_author) { ?>
              <span class="error"><?php echo $error_author; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_company; ?></td>
            <td><input type="text" name="company" value="<?php echo $company; ?>" size="50" />
          </tr>
          <tr>
            <td><?php echo $entry_location; ?></td>
            <td><input type="text" name="location" value="<?php echo $location; ?>" size="50" />
          </tr>
          <tr>
            <td><?php echo $entry_url; ?></td>
            <td><input type="text" name="url" value="<?php echo $url; ?>" size="50" />
          </tr>
          <tr>
            <td><?php echo $entry_telephone; ?></td>
            <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" size="50" />
          </tr>
          <tr>
            <td><?php echo $entry_email; ?></td>
            <td><input type="text" name="email" value="<?php echo $email; ?>" size="50" />
          </tr>
          <tr>
            <td><?php echo $entry_language; ?></td>
            <td><select name="language_id">
                  <?php foreach ($languages as $language) { ?>                  
                  <option value="<?php echo $language['language_id']; ?>" <?php echo ($language['language_id'] == $language_id) ? 'selected="selected"' : ''; ?>><?php echo $language['name']; ?></option>
                  <?php } ?>
            </select></td>
 	 </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_rating; ?></td>
            <td><b class="rating"><?php echo $entry_bad; ?></b>&nbsp;
              <input type="radio" name="rating" value="1"<?php echo ($rating == 1) ? ' checked' : ''; ?> />&nbsp;
              <input type="radio" name="rating" value="2"<?php echo ($rating == 2) ? ' checked' : ''; ?> />&nbsp;
              <input type="radio" name="rating" value="3"<?php echo ($rating == 3) ? ' checked' : ''; ?> />&nbsp;
              <input type="radio" name="rating" value="4"<?php echo ($rating == 4) ? ' checked' : ''; ?> />&nbsp;
              <input type="radio" name="rating" value="5"<?php echo ($rating == 5) ? ' checked' : ''; ?> />&nbsp;
			  <b class="rating"><?php echo $entry_good; ?></b>
              <?php if ($error_rating) { ?>
              <span class="error"><?php echo $error_rating; ?></span>
              <?php } ?>
			  </td>
          </tr>
          <tr>
            <td><?php echo $entry_featured; ?></td>
            <td><select name="featured">
                <option value="1"<?php echo ($featured) ? ' selected="selected"' : ''; ?>><?php echo $text_yes; ?></option>
                <option value="0"<?php echo (!$featured) ? ' selected="selected"' : ''; ?>><?php echo $text_no; ?></option>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status">
                <option value="1"<?php echo ($status) ? ' selected="selected"' : ''; ?>><?php echo $text_enabled; ?></option>
                <option value="0"<?php echo (!$status) ? ' selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
              </select></td>
          </tr>
        </table>
		<h2><?php echo $heading_excerpts;?></h2>
		<table class="form">
			<tr>
				<td colspan="2"><div style="width:500px;"><?php echo $text_excerpts; ?></div></td>
			</tr>
			<tr>
				<td><?php echo $entry_excerpt_title; ?></td>
				<td><input type="text" name="excerpt_title" value="<?php echo $excerpt_title; ?>" size="70" /></td>
			</tr>
			<tr>
			<td><?php echo $entry_excerpt_public_text; ?></td>
			<td><textarea name="excerpt_public_text" cols="60" rows="8"><?php echo $excerpt_public_text; ?></textarea>
			</tr>
		</table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>