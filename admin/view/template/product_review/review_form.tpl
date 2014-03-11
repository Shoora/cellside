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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" id="button-save" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_author; ?></td>
            <td><input type="text" name="author" value="<?php echo $author; ?>" />
              <?php if ($error_author) { ?>
              <span class="error"><?php echo $error_author; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_product; ?></td>
            <td><input type="text" name="product" value="<?php echo $product; ?>" <?php if ($product_id) { echo'readonly'; } ?> />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <?php if ($error_product) { ?>
              <span class="error"><?php echo $error_product; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_text; ?></td>
            <td><textarea name="text" cols="60" rows="8"><?php echo $text; ?></textarea>
              <?php if ($error_text) { ?>
              <span class="error"><?php echo $error_text; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_rating; ?></td>
            <td><input type="hidden" name="rating" value="" />
			  <div id="rating">
			  <div class="warning"><?php echo $error_select; ?></div>
			  </div>
			  <?php if ($error_rating) { ?>
              <span class="error"><?php echo $error_rating; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_pros; ?></td>
            <td><table id="pros">
				<tr>
			      <td width="20"><img src="view/image/pros.png" alt="" title="" style="vertical-align: middle;" /></td>
				  <td><input type="text" name="pv" value="" size="90" /> <a onclick="addPros();" class="button">+</a></td>
			    </tr>
				<tbody>
				<?php foreach ($pros as $row) { ?>
				<tr>
				  <td width="20"><img src="view/image/delete.png" alt="" title="" id="delete" style="vertical-align: middle; cursor: pointer;" /></td>
				  <td><input type="hidden" name="pros[][name]" value="<?php echo $row['name']; ?>" /><?php echo $row['name']; ?></td>
			    </tr>
				<?php } ?>
				</tbody>
			  </table></td>
          </tr>
		  <tr>
            <td><?php echo $entry_cons; ?></td>
            <td><table id="cons">
				<tr>
			      <td width="20"><img src="view/image/cons.png" alt="" title="" style="vertical-align: middle;" /></td>
				  <td><input type="text" name="pc" value="" size="90" /> <a onclick="addCons();" class="button">+</a></td>
			    </tr>
				<tbody>
				<?php foreach ($cons as $row) { ?>
				<tr>
				  <td width="20"><img src="view/image/delete.png" alt="" title="" id="delete" style="vertical-align: middle; cursor: pointer;" /></td>
				  <td><input type="hidden" name="cons[][name]" value="<?php echo $row['name']; ?>" /><?php echo $row['name']; ?></td>
			    </tr>
				<?php } ?>
				</tbody>
			  </table></td>
          </tr>
		  <tr>
              <td><?php echo $entry_image; ?></td>
              <td valign="top"><?php if ($image) { ?><div class="image" style="margin-bottom: 10px;"><img src="<?php echo $thumb; ?>" alt="" id="thumb" /></div><?php } ?>
                <div><input type="hidden" name="image" value="<?php echo $image; ?>" id="image" />
				<a id="review_image" class="button"><?php echo $text_browse; ?></a></div></td>
            </tr>
		  <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	},
	select: function(event, ui) {
		$('input[name=\'product\']').val(ui.item.label);
		$('input[name=\'product_id\']').val(ui.item.value);

		generateRating(ui.item.value);

		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

var product_id = '<?php echo $product_id ? (int)$product_id : 0; ?>';
var review_id = '<?php echo (isset($_GET['review_id'])) ? (int)$_GET['review_id'] : 0; ?>';

function generateRating(id) {
	if (id == product_id) {
		rating = '<?php echo $product_rating; ?>';
	} else {
		rating = '';
	}

	$.ajax({
		url: 'index.php?route=product_review/review/rating&token=<?php echo $token; ?>&product_id=' + encodeURIComponent(id) + '&review_id=' + encodeURIComponent(review_id),
		type: 'post',
		data: {prc : rating},
		dataType: 'html',
		beforeSend: function() {
			$('#rating').html('<div class="wait"><img src="view/image/loading.gif" /></div>');
			$('#button-save').attr('disabled', true);
		},	
		complete: function() {
			$('#button-save').attr('disabled', false);
		},
		success: function(html) {
			$('#rating').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function addPros() {
	pros = $('input[name="pv"]').val().replace(/(<([^>]+)>)/ig,"").trim();

	if (pros == '') {
		return;
	}

	$('#pros > tbody tr:last').after('<tr><td width="20"><img src="view/image/delete.png" alt="" title="" id="delete" style="vertical-align: middle; cursor: pointer;" /></td><td><input type="hidden" name="pros[][name]" value="' + pros + '" />' + pros + '</td></tr>');
	$('input[name="pv"]').val('');
}

function addCons() {
	cons = $('input[name="pc"]').val().replace(/(<([^>]+)>)/ig,"").trim();

	if (cons == '') {
		return;
	}

	$('#cons > tbody tr:last').after('<tr><td width="20"><img src="view/image/delete.png" alt="" title="" id="delete" style="vertical-align: middle; cursor: pointer;" /></td><td><input type="hidden" name="cons[][name]" value="' + cons + '" />' + cons + '</td></tr>');
	$('input[name="pc"]').val('');
}

$('table#pros tr img#delete, table#cons img#delete').live('click', function() {
	$(this).parent().parent().remove();	
});

$(document).ready(function(){
	if (product_id != '0') {
		generateRating(product_id);
	}
});
//--></script>
<script type="text/javascript" src="view/javascript/jquery/ajaxupload.js"></script> 
<script type="text/javascript"><!--
new AjaxUpload('#review_image', {
	action: 'index.php?route=product_review/review/upload&token=<?php echo $token; ?>',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#review_image').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#review_image').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#review_image').attr('disabled', false);

		$('.error').remove();

		if (json['success']) {
			alert(json['success']);

			$('input[name=\'image\']').attr('value', json['file']);
			$('td > div.image').remove();
		}

		if (json['error']) {
			$('#review_image').after('<span class="error">' + json['error'] + '</span>');
		}

		$('.loading').remove();	
	}
});
//--></script>
<?php echo $footer; ?>