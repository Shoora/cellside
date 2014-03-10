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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="<?php echo $reason; ?>" class="button"><?php echo $button_reason; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
			  <td class="left" style="width: 450px;"><?php echo $column_review; ?></td>
			  <td class="left" style="width: 300px;"><?php echo $column_title; ?></td>
              <td class="right"><?php if ($sort == 'ar.store_id') { ?>
			    <a href="<?php echo $sort_store_id; ?>" class="<?php echo strtolower($order); ?>"> <?php echo $column_store; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_store_id; ?>"> <?php echo $column_store; ?></a>
                <?php } ?></td>
			  <td class="right"><?php if ($sort == 'ar.reported') { ?>
			    <a href="<?php echo $sort_reported; ?>" class="<?php echo strtolower($order); ?>"> <?php echo $column_reported; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_reported; ?>"> <?php echo $column_reported; ?></a>
                <?php } ?></td>
			  <td class="right"><?php if ($sort == 'ar.date_added') { ?>
			    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"> <?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"> <?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
			  <td></td>
              <td></td>
              <td class="right"><select name="filter_store_id">
				  <option value="*"></option>
				  <?php foreach ($stores as $store) { ?>
				  <?php if ($store['store_id'] == $filter_store_id) { ?>
				  <option value="<?php echo $store['store_id']; ?>" selected><?php echo $store['name']; ?></option>
				  <?php } else { ?>
				  <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
				  <?php } ?>
				  <?php } ?>
				</select></td>
			  <td></td>
              <td align="right"><input type="text" name="filter_date_added_start" value="<?php echo $filter_date_added_start; ?>" class="date" size="5"/> <input type="text" name="filter_date_added_stop" value="<?php echo $filter_date_added_stop; ?>" class="date" size="5"/></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($reports) { ?>
            <?php foreach ($reports as $report) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($report['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $report['report_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $report['report_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $report['review']; ?></td>
			  <td style="width: 10px;"><?php echo $report['title']; ?></td>
			  <td class="right"><?php echo $stores[$report['store']]['name']; ?></td>
			  <td class="right"><?php echo $report['reported']; ?></td>
              <td class="right"><?php echo $report['date_added']; ?></td>
              <td class="right"><?php foreach ($report['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=product_review/report&token=<?php echo $token; ?>';

	var filter_store_id = $('select[name=\'filter_store_id\']').attr('value');
	
	if (filter_store_id != '*') {
		url += '&filter_store_id=' + encodeURIComponent(filter_store_id);
	}

	var filter_date_added_start = $('input[name=\'filter_date_added_start\']').attr('value');

	if (filter_date_added_start) {
		url += '&filter_date_added_start=' + encodeURIComponent(filter_date_added_start);
	}

	var filter_date_added_stop = $('input[name=\'filter_date_added_stop\']').attr('value');

	if (filter_date_added_stop) {
		url += '&filter_date_added_stop=' + encodeURIComponent(filter_date_added_stop);
	}

	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {
	if (e.keyCode == 13) {
		filter();
	}
});

$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<?php echo $footer; ?>