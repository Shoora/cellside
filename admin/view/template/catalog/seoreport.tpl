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
      <h1><img src="view/image/product.png" alt="" /> <?php echo $heading_title." ($selected_language)"; ?></h1>      
	  <div class="buttons">
	 
	  <?php foreach ($languages as $language) { ?>
		 <a onclick="location = '<?php echo $action.$language['language_id']; ?>';" class="button"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
	  <? } ?>
	  <a onclick="filter();" class="button"><?php echo $button_filter; ?></a>
	  </div>
    </div>
    <div class="content">
       <table class="list">
          <thead>
            <tr> 
              
              <td class="left"><?php if ($sort == 'type') { ?>
                <a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_type; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_type; ?>"><?php echo $column_type; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'keyword') { ?>
                <a href="<?php echo $sort_keyword; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_keyword; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_keyword; ?>"><?php echo $column_keyword; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'meta_keyword') { ?>
                <a href="<?php echo $sort_meta_keyword; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_meta_keyword; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_meta_keyword; ?>"><?php echo $column_meta_keyword; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'meta_description') { ?>
                <a href="<?php echo $sort_meta_description; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_meta_description; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_meta_description; ?>"><?php echo $column_meta_description; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'tags') { ?>
                <a href="<?php echo $sort_tags; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_tags; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_tags; ?>"><?php echo $column_tags; ?></a>
                <?php } ?></td>
              
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              
              <td><select name="filter_type">
                  <option value="*"></option>
				  <?php $types = array('Category','Product','Information','Manufacturer'); ?>
				  <?php foreach($types as $type) { ?>
                  <?php if ($filter_type == $type) { ?>
                  <option value="<?php echo $type; ?>" selected="selected"><?php echo $type; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $type; ?>"><?php echo $type; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
              
              <!--<td><input type="text" name="filter_type" value="<?php echo $filter_type; ?>" /></td>-->
              <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
              <td><input type="text" name="filter_keyword" value="<?php echo $filter_keyword; ?>" /></td>
              <td><input type="text" name="filter_meta_keyword" value="<?php echo $filter_meta_keyword; ?>" /></td>
              <td><input type="text" name="filter_meta_description" value="<?php echo $filter_meta_description; ?>" /></td>
              <td><input type="text" name="filter_tags" value="<?php echo $filter_tags; ?>" /></td>
              
            </tr>
            <?php if ($products) { ?>
            <?php foreach ($products as $product) { ?>
            <tr>
              
              <td class="left"><?php echo $product['type']; ?></td>
              <td class="left"><?php echo $product['name']; ?></td>
              <td class="left"><?php echo $product['keyword']; ?></td>
              
			  <?php if ($product['meta_keyword'] <> -1) { ?>
			  <td class="left"><?php echo $product['meta_keyword']; ?></td>
			  <?php } else { ?>
			  <td class="left" style="background:lightgrey"></td>
			  <?php } ?>
			  
			  <?php if ($product['meta_description'] <> -1) { ?>
              <td class="left"><?php echo $product['meta_description']; ?></td>
			  <?php } else { ?>
			  <td class="left" style="background:lightgrey"></td>
			  <?php } ?>
			  
			  <?php if ($product['tags'] <> -1) { ?>
              <td class="left"><?php echo $product['tags']; ?></td>
			  <?php } else { ?>
			  <td class="left" style="background:lightgrey"></td>
			  <?php } ?>
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
	url = 'index.php?route=catalog/seoreport&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_type = $('select[name=\'filter_type\']').attr('value');
	
	if (filter_type != '*') {
		url += '&filter_type=' + encodeURIComponent(filter_type);
	}
	
	var filter_keyword = $('input[name=\'filter_keyword\']').attr('value');
	
	if (filter_keyword) {
		url += '&filter_keyword=' + encodeURIComponent(filter_keyword);
	}
	
	var filter_meta_keyword = $('input[name=\'filter_meta_keyword\']').attr('value');
	
	if (filter_meta_keyword) {
		url += '&filter_meta_keyword=' + encodeURIComponent(filter_meta_keyword);
	}
	
	var filter_meta_description = $('input[name=\'filter_meta_description\']').attr('value');
	
	if (filter_meta_description) {
		url += '&filter_meta_description=' + encodeURIComponent(filter_meta_description);
	}
	
	var filter_tags = $('input[name=\'filter_tags\']').attr('value');
	
	if (filter_tags) {
		url += '&filter_tags=' + encodeURIComponent(filter_tags);
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
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/seoreport/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_name\']').val(ui.item.label);
						
		return false;
	}
});


$('input[name=\'filter_keyword\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/seoreport/autocomplete&token=<?php echo $token; ?>&filter_keyword=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.keyword,
						value: item.id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_keyword\']').val(ui.item.label);
						
		return false;
	}
});

$('input[name=\'filter_meta_keyword\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/seoreport/autocomplete&token=<?php echo $token; ?>&filter_meta_keyword=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.meta_keyword,
						value: item.id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_meta_keyword\']').val(ui.item.label);
						
		return false;
	}
});

$('input[name=\'filter_meta_description\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/seoreport/autocomplete&token=<?php echo $token; ?>&filter_meta_description=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.meta_description,
						value: item.id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_meta_description\']').val(ui.item.label);
						
		return false;
	}
});

$('input[name=\'filter_tags\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/seoreport/autocomplete&token=<?php echo $token; ?>&filter_tags=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.tags,
						value: item.id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_tags\']').val(ui.item.label);
						
		return false;
	}
});
//--></script> 
<?php echo $footer; ?>