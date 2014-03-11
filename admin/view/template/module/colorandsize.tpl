<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $back; ?>';" class="button"><?php echo $button_back; ?></a></div>
    </div>
    <div class="content">
	 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
		<tr>
		  <td><?php echo $entry_colorandsize; ?> (<?php echo $cp ? $text_enabled : $text_disabled; ?>)</td>
		  <td><a href="<?php echo $cp_action; ?>"><?php echo $cp ? $text_uninstall : $text_install; ?></a></td>
    	</tr>
	    <tr>
		  <td><?php echo $entry_colorandsize_plus; ?> (<?php echo $cpp ? $text_enabled : $text_disabled; ?>)</td>
		  <td><a href="<?php echo $cpp_action; ?>"><?php echo $cpp ? $text_uninstall : $text_install; ?></a></td>
		</tr>
		<tr>
		  <td><?php echo $entry_colour; ?></td>
		  <td><input type="text" name="colorandsize_colour" size="100" value="<?php echo $colour; ?>" /></td>
		</tr>
		<tr>
		  <td><?php echo $entry_size; ?></td>
		  <td><input type="text" name="colorandsize_size" size="100" value="<?php echo $size; ?>" /></td>
		</tr>
	  </table>
	 </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>