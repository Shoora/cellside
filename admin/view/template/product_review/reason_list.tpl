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
      <div class="buttons"><a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
			  <td class="left" style="width: 550px;"><?php if ($sort == 'rd.name') { ?>
			    <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"> <?php echo $column_title; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"> <?php echo $column_title; ?></a>
                <?php } ?></td>
			  <td class="right"><?php echo $column_store; ?></td>
			  <td class="right"><?php if ($sort == 'r.status') { ?>
			    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"> <?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"> <?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
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
			  <td class="right"><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($reasons) { ?>
            <?php foreach ($reasons as $reason) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($reason['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $reason['reason_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $reason['reason_id']; ?>" />
                <?php } ?></td>
			  <td style="width: 10px;"><?php echo $reason['name']; ?></td>
			  <td class="right"><?php foreach ($reason['stores'] as $store) { echo $stores[$store]['name'] . '<br />'; } ?></td>
              <td class="right"><?php echo $reason['status']; ?></td>
              <td class="right"><?php foreach ($reason['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
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
	url = 'index.php?route=product_review/report/manage&token=<?php echo $token; ?>';

	var filter_store_id = $('select[name=\'filter_store_id\']').attr('value');
	
	if (filter_store_id != '*') {
		url += '&filter_store_id=' + encodeURIComponent(filter_store_id);
	}

	var filter_status = $('select[name=\'filter_status\']').attr('value');

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
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
//--></script> 
<?php echo $footer; ?>