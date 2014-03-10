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
      <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="chain_status">
                <?php if ($chain_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="chain_sort_order" value="<?php echo $chain_sort_order; ?>" size="1" /></td>
		<tr>
			<td><?php echo $entry_chane_totlas_color; ?></td>
			<td><input type="checkbox" value="on" <?php echo ($chain_chane_totals_color ? 'checked' : '') ?> name="chain_chane_totals_color"></td>
		</tr>
		<tr class="chain_chane_totals_color">
            <td><?php echo $entry_totlas_color; ?></td>
            <td><input type="text" name="chain_totals_color" class="color_picker" id="color_picker" value="<?php echo ($chain_totals_color ? $chain_totals_color : '#090101'); ?>" />
				<div class="farbtastic_container" id="farbtastic_container" style="display: none;"></div></td>
         </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<style>
.farbtastic_container {
	position: absolute;
	margin-top: 0px;
	z-index: 10;
	display: none;
}
input.color_picker {
	border: none;
	border-radius: 15px;
	box-shadow: 0 0 3px rgba(0,0,0,0.3);
	padding: 10px;
}
</style>
<script type="text/javascript" src="view/javascript/jquery/farbtastic.js"></script>
<link rel="stylesheet" href="view/stylesheet/farbtastic.css" type="text/css" />
<script>
var show_Hide_Color = function() {
			if ($('input[name="chain_chane_totals_color"]').attr('checked') == 'checked') {
				$('tr.chain_chane_totals_color').show();
			} else {
				$('tr.chain_chane_totals_color').hide();
			}
		};
show_Hide_Color();
$(document).ready(function() {

	$('#farbtastic_container').farbtastic('#color_picker');

	$('.color_picker').focus( 
		function() {
			$(this).next().slideDown(300);
		});
	$('.color_picker').blur( 
		function() {
			$(this).next().hide();
		}
	);
	
	$('input[name="chain_chane_totals_color"]').change(function() {
		show_Hide_Color();
	});

});

</script>
<?php echo $footer; ?>