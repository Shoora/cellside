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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/order.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $promo_insert; ?>" method="post" enctype="multipart/form-data" id="formPromo">
        <table class="form">
          <tr>
            <td><?php echo $entry_template_promo; ?></td>
            <td><?php foreach ($languages as $language) { ?>
              <input type="text" size="100" maxlength="200" name="promo[<?php echo $language['language_id']; ?>][description]" value="<?php echo isset($promo[$language['language_id']]) ? $promo[$language['language_id']]['description'] : ''; ?>" />
              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error"><?php echo $error_name[$language['language_id']]; ?></span><br />
              <?php } ?>
              <?php } ?></td>
          </tr>
		  <tr>
		    <td><?php echo $entry_cron; ?></td>
			<td style="position: relative;"><b><?php echo $entry_cron_send_invoice; ?> <input type="checkbox" value="1" name="template_email_send_invoice" <?php echo $template_email_send_invoice; ?> /></b><br>
			  <?php echo $entry_cron_send_invoice_from; ?> <input type="text" class="date" disabled name="template_email_send_invoice_from" value="<?php echo $template_email_send_invoice_from; ?>" size="11" /> <?php echo $text_to; ?> <input type="text" class="date" disabled name="template_email_send_invoice_to" value="<?php echo $template_email_send_invoice_to; ?>" size="11" />
			  <?php echo $entry_cron_send_invoice_date_empty; ?><br />
			  <?php echo $text_cron_link; ?><span style="background: purple; display: block; padding: 4px; color: #fff; position: absolute; top: 10px; right: 10px; white-space: nowrap;"><?php echo $text_count_orders; ?></span></td>
		  </tr>
		  <tr>
		    <td></td>
			<td><?php echo $entry_generate_invoice; ?> <input type="checkbox" value="1" name="template_email_generate_invoice" <?php echo $template_email_generate_invoice; ?> /> 
			   <?php echo $entry_generate_invoice_status; ?> <?php if ($order_statuses) { ?>
			   <select name="template_email_generate_invoice_status">
			      <option value="0">- - -</option>
               <?php foreach ($order_statuses as $order_status) { ?>
			   <?php if ($order_status['order_status_id'] != $this->config->get('config_order_status_id')) { ?>
			      <?php if ($order_status['order_status_id'] == $template_email_generate_invoice_status) { ?>
			      <option value="<?php echo $order_status['order_status_id']; ?>" selected><?php echo $order_status['name']; ?></option>
				  <?php } else { ?>
				  <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
				  <?php } ?>
               <?php } ?>
			   <?php } ?>
			   </select>
               <?php } ?><br />
			  <?php echo $entry_statuses_to_admin; ?> <input type="checkbox" value="1" name="template_email_statuses_to_admin" <?php echo $template_email_statuses_to_admin; ?> /></td>
		  </tr>
		  <tr>
		    <td></td>
			<td><?php echo $entry_thumbnail_image_product; ?> <input type="text" name="template_email_product_thumbnail_width" value="<?php echo $template_email_product_thumbnail_width; ?>" size="3" /> x <input type="text" name="template_email_product_thumbnail_height" value="<?php echo $template_email_product_thumbnail_height; ?>" size="3" /></td>
		  </tr>
		  <tr>
			<td></td><td><div class="buttons"><a onclick="$('#formPromo').submit();" class="button"><span><?php echo $button_save; ?></span></a></div></td>
		  </tr>
		</table>
	  </form>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<div id="templates" class="htabs">
		  <a href="#type1"><?php echo $tab_type1; ?></a>
		  <!--<a href="#type2"><?php echo $tab_type2; ?></a>-->
		  <a href="#type3"><?php echo $tab_type3; ?></a>
		  <a href="#type4"><?php echo $tab_type4; ?></a>
		</div>
		<div id="type1">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'sselected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_id; ?></a>
                <?php } ?></td>
				<td class="left"><?php echo $column_template_email; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($order_statuses) { ?>
            <?php foreach ($order_statuses as $order_status) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($order_status['selected']) { ?>
                <input type="checkbox" name="sselected[]" value="<?php echo $order_status['order_status_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="sselected[]" value="<?php echo $order_status['order_status_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $order_status['name']; ?></td>
			  <td><?php echo $order_status['template_name']; ?></td>
              <td class="right"><?php foreach ($order_status['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
		</div>
		<!--<div id="type2">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'rselected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_id; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_id; ?></a>
                <?php } ?></td>
				<td class="left"><?php echo $column_template_email; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($return_statuses) { ?>
            <?php foreach ($return_statuses as $return_status) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($return_status['selected']) { ?>
                <input type="checkbox" name="rselected[]" value="<?php echo $return_status['return_status_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="rselected[]" value="<?php echo $return_status['return_status_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $return_status['name']; ?></td>
			  <td><?php echo $return_status['template_name']; ?></td>
              <td class="right"><?php foreach ($return_status['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
		</div>-->
		<div id="type3">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'eselected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_id; ?></td>
				<td class="left"><?php echo $column_template_email; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($services) { ?>
            <?php foreach ($services as $service) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($service['selected']) { ?>
                <input type="checkbox" name="eselected[]" value="<?php echo $service['id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="eselected[]" value="<?php echo $service['id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $service['name']; ?></td>
			  <td><?php echo $service['template_name']; ?></td>
              <td class="right"><?php foreach ($service['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
		</div>
		<div id="type4">
		<div style="text-align: right; padding-bottom: 15px;"><a href="<?php echo $mail_template_insert; ?>" class="button"><span><?php echo $button_mail; ?></span></a></div>
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'mselected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_id; ?></td>
				<td class="left"><?php echo $column_template_email; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($mails) { ?>
            <?php foreach ($mails as $mail) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($mail['selected']) { ?>
                <input type="checkbox" name="mselected[]" value="<?php echo $mail['id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="mselected[]" value="<?php echo $mail['id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $mail['name']; ?></td>
			  <td><?php echo $mail['template_name']; ?></td>
              <td class="right"><?php foreach ($mail['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
		</div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#templates a').tabs();

if ($("input[name='template_email_generate_invoice']").is(":checked")) {
  $("select[name='template_email_generate_invoice_status']").attr('disabled', 'disabled');
}

$("input[name='template_email_generate_invoice']").click(function() {
  if ($(this).is(":checked")) {
    $("select[name='template_email_generate_invoice_status']").attr('disabled', 'disabled');
  } else {
    $("select[name='template_email_generate_invoice_status']").removeAttr('disabled');
  }
});

if ($("input[name='template_email_send_invoice']").is(":checked")) {
  $(".date").removeAttr('disabled');
}

$("input[name='template_email_send_invoice']").click(function() {
  if ($(this).is(":checked")) {
    $(".date").removeAttr('disabled');
  } else {
    $(".date").attr('disabled', 'disabled');
  }
});

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
//--></script> 
<?php echo $footer; ?> 