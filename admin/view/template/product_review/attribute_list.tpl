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
      <div class="buttons"><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
			  <td class="left"><?php if ($sort == 'a.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'r.review_id') { ?>
			    <a href="<?php echo $sort_review; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_review; ?>
				<?php } else { ?>
                <a href="<?php echo $sort_review; ?>"><?php echo $column_review; ?></a>
                <?php } ?></td>
              <td class="right" colspan="2"><?php if ($sort == 'a.type') { ?>
			    <a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_type; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_type; ?>"> <?php echo $column_type; ?></a>
                <?php } ?></td>
			  <td class="right"><?php if ($sort == 'r.author') { ?>
			    <a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_author; ?>"> <?php echo $column_author; ?></a>
                <?php } ?></td>
			  <td class="right"><?php if ($sort == 'a.status') { ?>
			    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"> <?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
			  <td><input type="text" name="filter_review_id" value="<?php echo $filter_review_id; ?>" style="width: 50px;" /></td>
			  <td class="right" colspan="2"><select name="filter_type">
                  <option value="*"></option>
                  <?php if ($filter_type) { ?>
                  <option value="1" selected="selected"><?php echo $text_pros; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_pros; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_type) && !$filter_type) { ?>
                  <option value="0" selected="selected"><?php echo $text_cons; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_cons; ?></option>
                  <?php } ?>
                </select></td>
			  <td class="right"><input type="text" name="filter_author" value="<?php echo $filter_author; ?>" /></td>
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
            <?php if ($attributes) { ?>
            <?php foreach ($attributes as $attribute) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($attribute['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $attribute['attribute_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $attribute['attribute_id']; ?>" />
                <?php } ?></td>
			  <td class="left"><?php echo $attribute['name']; ?></td>
			  <td class="left"><a href="<?php echo $attribute['review_href']; ?>"><?php echo $attribute['review_id']; ?></a></td>
			  <td class="right"><?php echo $attribute['type']; ?></td>
			  <td style="width: 10px;"><?php echo $attribute['image']; ?></td>
			  <td class="right"><?php echo $attribute['author']; ?></td>
              <td class="right"><?php echo $attribute['status']; ?></td>
              <td class="right"><?php foreach ($attribute['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
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
	url = 'index.php?route=product_review/attribute&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').attr('value');

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_review_id = $('input[name=\'filter_review_id\']').attr('value');

	if (filter_review_id) {
		url += '&filter_review_id=' + encodeURIComponent(filter_review_id);
	}

	var filter_type = $('select[name=\'filter_type\']').attr('value');

	if (filter_type != '*') {
		url += '&filter_type=' + encodeURIComponent(filter_type);
	}

	var filter_author = $('input[name=\'filter_author\']').attr('value');

	if (filter_author) {
		url += '&filter_author=' + encodeURIComponent(filter_author);
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
<script type="text/javascript"><!--
$('input[name=\'filter_name\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=product_review/attribute/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.attribute_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'filter_name\']').val(ui.item.label);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('input[name=\'filter_author\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=product_review/attribute/autocompleteauthor&token=<?php echo $token; ?>&filter_author=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item.author,
						value: item.attribute_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'filter_author\']').val(ui.item.label);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
//--></script>
<?php echo $footer; ?>