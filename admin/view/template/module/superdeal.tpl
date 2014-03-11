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
<?php if ($_SESSION['successtxt'] ==1) { ?>
  <div class="success">Success: You have modified module Limited Deals!</div>
<?php } ?>

<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><?php echo $entry_product; ?></td>
          <td><input type="text" name="product" value="" /></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><div class="scrollbox" id="superdeal-product">
              <?php $class = 'odd'; ?>
              <?php foreach ($products as $product) { ?>
              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
              <div id="superdeal-product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" />
                <input type="hidden" value="<?php echo $product['product_id']; ?>" />
              </div>
              <?php } ?>
            </div>
            <input type="hidden" name="superdeal_product" value="<?php echo $superdeal_product; ?>" /></td>
        </tr>

		<table border="1">

		<tr>
          <td>Module W x H (px):</td>  
          <td>
		  	<input type="text" name="superdeal_width" value="<?php if (!is_numeric($superdeal_width)) echo '960'; else echo $superdeal_width?>" />
			x
			<input type="text" name="superdeal_height" value="<?php if (!is_numeric($superdeal_height)) echo '300'; else echo $superdeal_height?>" />
		  </td>
		</tr>

		<tr>
          <td>Show as:</td>
          <td>
		  	<select name="superdeal_showas">
                <option value="list" <?php if ($superdeal_showas == '' || $superdeal_showas == 'box' ) echo 'selected="seleted"';?>>List</option>
				<option value="slide" <?php if ($superdeal_showas == 'slide' ) echo 'selected="seleted"';?>>Slide</option>

			</select>
		  </td>
		</tr>

		<tr>
          <td>Slide effect <br />(leave it if you show as List):</td>
          <td>
		  	<select name="superdeal_slideeffect">
                <option value="fade" <?php if ($superdeal_slideeffect == '' || $superdeal_slideeffect == 'fade' ) echo 'selected="seleted"';?>>Fade</option>
				<option value="scrollUp" <?php if ($superdeal_slideeffect == 'scrollUp' ) echo 'selected="seleted"';?>>scrollUp</option>
				<option value="scrollDown" <?php if ($superdeal_slideeffect == 'scrollDown' ) echo 'selected="seleted"';?>>scrollDown</option>
				<option value="scrollLeft" <?php if ($superdeal_slideeffect == 'scrollLeft' ) echo 'selected="seleted"';?>>scrollLeft</option>
				<option value="scrollRight" <?php if ($superdeal_slideeffect == 'scrollRight' ) echo 'selected="seleted"';?>>scrollRight</option>
			</select>
		  </td>
		</tr>
        <tr>
		
		<td>Module Heading:</td>
          <td>
		  	<input type="text" name="module_heading" value="<?php if (!is_string($module_heading)) echo 'Enter The Title'; else echo $module_heading; ?>" >
		  </td>
		</tr>
				
		<tr>
          <td>Product Title Size(px):</td>
          <td>
		  	<input type="text" name="superdeal_titlesize" value="<?php if (!is_numeric($superdeal_titlesize)) echo '25'; else echo $superdeal_titlesize; ?>" >
		  </td>
		</tr>
		<tr>
          <td>Product Text Size(px):</td>
          <td>
		  	<input type="text" name="superdeal_producttextsize" value="<?php if (!is_numeric($superdeal_producttextsize)) echo '13'; else echo $superdeal_producttextsize; ?>" >
		  </td>
		</tr>

		<tr>
          <td>Description Length:</td>
          <td>
		  	<input type="text" name="superdeal_countdesc" value="<?php if (!is_numeric($superdeal_countdesc)) echo '100'; else echo $superdeal_countdesc; ?>" >
		  	<select name="superdeal_counttype">
                <option value="words" <?php if ( $superdeal_counttype == 'words' ) echo 'selected="seleted"';?>>Words</option>
				<option value="characters" <?php if ($superdeal_counttype == '' || $superdeal_counttype == 'characters' ) echo 'selected="seleted"';?>>Characters</option>

			</select>
		  </td>
		</tr>

		<tr>
          <td>Button Size:</td>
          <td>
		  	<select name="superdeal_buttonsize">
                <option value="small" <?php if ($superdeal_buttonsize == '' || $superdeal_buttonsize == 'small') echo 'selected="seleted"';?>>Small</option>
				<option value="medium" <?php if ($superdeal_buttonsize == 'medium' ) echo 'selected="seleted"';?>>Medium</option>
				<option value="large" <?php if ($superdeal_buttonsize == 'large'  ) echo 'selected="seleted"';?>>Large</option>
			</select>
		  </td>
		</tr>
        
        <tr>
          <td>Percent Color:</td>
          <td>
            <select name="superdeal_percentsavebutton">
                <option value="black" <?php if ($superdeal_percentsavebutton == '' || $superdeal_percentsavebutton == 'black' ) echo 'selected="seleted"';?>>Black</option>
                <option value="gray" <?php if ($superdeal_percentsavebutton == 'gray' ) echo 'selected="seleted"';?>>Gray</option>   
                <option value="white" <?php if ($superdeal_percentsavebutton == 'white' ) echo 'selected="seleted"';?>>White</option> 
                <option value="red" <?php if ($superdeal_percentsavebutton == 'red' ) echo 'selected="seleted"';?>>Red</option> 
                <option value="orange" <?php if ($superdeal_percentsavebutton == 'orange' ) echo 'selected="seleted"';?>>Orange</option> 
                <option value="magenta" <?php if ($superdeal_percentsavebutton == 'magenta' ) echo 'selected="seleted"';?>>Magenta</option> 
                <option value="yellow" <?php if ($superdeal_percentsavebutton == 'yellow' ) echo 'selected="seleted"';?>>Yellow</option> 
                <option value="blue" <?php if ($superdeal_percentsavebutton == 'blue' ) echo 'selected="seleted"';?>>Blue</option> 
                <option value="pink" <?php if ($superdeal_percentsavebutton == 'pink' ) echo 'selected="seleted"';?>>Pink</option> 
                <option value="green" <?php if ($superdeal_percentsavebutton == 'green' ) echo 'selected="seleted"';?>>Green</option> 
                <option value="rosy" <?php if ($superdeal_percentsavebutton == 'rosy' ) echo 'selected="seleted"';?>>Rosy</option> 
                <option value="brown" <?php if ($superdeal_percentsavebutton == 'brown' ) echo 'selected="seleted"';?>>Brown</option> 
                <option value="purple" <?php if ($superdeal_percentsavebutton == 'purple' ) echo 'selected="seleted"';?>>Purple</option> 
                <option value="cyan" <?php if ($superdeal_percentsavebutton == 'cyan' ) echo 'selected="seleted"';?>>Cyan</option> 
                <option value="gold" <?php if ($superdeal_percentsavebutton == 'gold' ) echo 'selected="seleted"';?>>Gold</option>              
               
            </select>
          </td>
        </tr>
        <tr>
          <td>Price Color:</td>
          <td>
            <select name="superdeal_pricesavebutton">
                <option value="black" <?php if ($superdeal_pricesavebutton == '' || $superdeal_pricesavebutton == 'black' ) echo 'selected="seleted"';?>>Black</option>
                <option value="gray" <?php if ($superdeal_pricesavebutton == 'gray' ) echo 'selected="seleted"';?>>Gray</option>   
                <option value="white" <?php if ($superdeal_pricesavebutton == 'white' ) echo 'selected="seleted"';?>>White</option> 
                <option value="red" <?php if ($superdeal_pricesavebutton == 'red' ) echo 'selected="seleted"';?>>Red</option> 
                <option value="orange" <?php if ($superdeal_pricesavebutton == 'orange' ) echo 'selected="seleted"';?>>Orange</option> 
                <option value="magenta" <?php if ($superdeal_pricesavebutton == 'magenta' ) echo 'selected="seleted"';?>>Magenta</option> 
                <option value="yellow" <?php if ($superdeal_pricesavebutton == 'yellow' ) echo 'selected="seleted"';?>>Yellow</option> 
                <option value="blue" <?php if ($superdeal_pricesavebutton == 'blue' ) echo 'selected="seleted"';?>>Blue</option> 
                <option value="pink" <?php if ($superdeal_pricesavebutton == 'pink' ) echo 'selected="seleted"';?>>Pink</option> 
                <option value="green" <?php if ($superdeal_pricesavebutton == 'green' ) echo 'selected="seleted"';?>>Green</option> 
                <option value="rosy" <?php if ($superdeal_pricesavebutton == 'rosy' ) echo 'selected="seleted"';?>>Rosy</option> 
                <option value="brown" <?php if ($superdeal_pricesavebutton == 'brown' ) echo 'selected="seleted"';?>>Brown</option> 
                <option value="purple" <?php if ($superdeal_pricesavebutton == 'purple' ) echo 'selected="seleted"';?>>Purple</option> 
                <option value="cyan" <?php if ($superdeal_pricesavebutton == 'cyan' ) echo 'selected="seleted"';?>>Cyan</option> 
                <option value="gold" <?php if ($superdeal_pricesavebutton == 'gold' ) echo 'selected="seleted"';?>>Gold</option>              
               
            </select>
          </td>
        </tr>
         <tr>
          <td>You save Color:</td>
          <td>
            <select name="superdeal_yousavebutton">
                <option value="black" <?php if ($superdeal_yousavebutton == '' || $superdeal_yousavebutton == 'black' ) echo 'selected="seleted"';?>>Black</option>
                <option value="gray" <?php if ($superdeal_yousavebutton == 'gray' ) echo 'selected="seleted"';?>>Gray</option>   
                <option value="white" <?php if ($superdeal_yousavebutton == 'white' ) echo 'selected="seleted"';?>>White</option> 
                <option value="red" <?php if ($superdeal_yousavebutton == 'red' ) echo 'selected="seleted"';?>>Red</option> 
                <option value="orange" <?php if ($superdeal_yousavebutton == 'orange' ) echo 'selected="seleted"';?>>Orange</option> 
                <option value="magenta" <?php if ($superdeal_yousavebutton == 'magenta' ) echo 'selected="seleted"';?>>Magenta</option> 
                <option value="yellow" <?php if ($superdeal_yousavebutton == 'yellow' ) echo 'selected="seleted"';?>>Yellow</option> 
                <option value="blue" <?php if ($superdeal_yousavebutton == 'blue' ) echo 'selected="seleted"';?>>Blue</option> 
                <option value="pink" <?php if ($superdeal_yousavebutton == 'pink' ) echo 'selected="seleted"';?>>Pink</option> 
                <option value="green" <?php if ($superdeal_yousavebutton == 'green' ) echo 'selected="seleted"';?>>Green</option> 
                <option value="rosy" <?php if ($superdeal_yousavebutton == 'rosy' ) echo 'selected="seleted"';?>>Rosy</option> 
                <option value="brown" <?php if ($superdeal_yousavebutton == 'brown' ) echo 'selected="seleted"';?>>Brown</option> 
                <option value="purple" <?php if ($superdeal_yousavebutton == 'purple' ) echo 'selected="seleted"';?>>Purple</option> 
                <option value="cyan" <?php if ($superdeal_yousavebutton == 'cyan' ) echo 'selected="seleted"';?>>Cyan</option> 
                <option value="gold" <?php if ($superdeal_yousavebutton == 'gold' ) echo 'selected="seleted"';?>>Gold</option>              
               
            </select>
          </td>
        </tr>
        <tr>
          <td>Item Left Color: </td>
          

          
          
          <td>
            <select name="superdeal_itemleftbutton">
                <option value="black" <?php if ($superdeal_itemleftbutton == '' || $superdeal_itemleftbutton == 'black' ) echo 'selected="seleted"';?>>Black</option>
                <option value="gray" <?php if ($superdeal_itemleftbutton == 'gray' ) echo 'selected="seleted"';?>>Gray</option>   
                <option value="white" <?php if ($superdeal_itemleftbutton == 'white' ) echo 'selected="seleted"';?>>White</option> 
                <option value="red" <?php if ($superdeal_itemleftbutton == 'red' ) echo 'selected="seleted"';?>>Red</option> 
                <option value="orange" <?php if ($superdeal_itemleftbutton == 'orange' ) echo 'selected="seleted"';?>>Orange</option> 
                <option value="magenta" <?php if ($superdeal_itemleftbutton == 'magenta' ) echo 'selected="seleted"';?>>Magenta</option> 
                <option value="yellow" <?php if ($superdeal_itemleftbutton == 'yellow' ) echo 'selected="seleted"';?>>Yellow</option> 
                <option value="blue" <?php if ($superdeal_itemleftbutton == 'blue' ) echo 'selected="seleted"';?>>Blue</option> 
                <option value="pink" <?php if ($superdeal_itemleftbutton == 'pink' ) echo 'selected="seleted"';?>>Pink</option> 
                <option value="green" <?php if ($superdeal_itemleftbutton == 'green' ) echo 'selected="seleted"';?>>Green</option> 
                <option value="rosy" <?php if ($superdeal_itemleftbutton == 'rosy' ) echo 'selected="seleted"';?>>Rosy</option> 
                <option value="brown" <?php if ($superdeal_itemleftbutton == 'brown' ) echo 'selected="seleted"';?>>Brown</option> 
                <option value="purple" <?php if ($superdeal_itemleftbutton == 'purple' ) echo 'selected="seleted"';?>>Purple</option> 
                <option value="cyan" <?php if ($superdeal_itemleftbutton == 'cyan' ) echo 'selected="seleted"';?>>Cyan</option> 
                <option value="gold" <?php if ($superdeal_itemleftbutton == 'gold' ) echo 'selected="seleted"';?>>Gold</option>              
               
            </select>
          </td>
        </tr>
        <tr>
          <td>Buy Now Color:</td>
          <td>
            <select name="superdeal_buynowbutton">
                <option value="black" <?php if ($superdeal_buynowbutton == '' || $superdeal_buynowbutton == 'black' ) echo 'selected="seleted"';?>>Black</option>
                <option value="gray" <?php if ($superdeal_buynowbutton == 'gray' ) echo 'selected="seleted"';?>>Gray</option>   
                <option value="white" <?php if ($superdeal_buynowbutton == 'white' ) echo 'selected="seleted"';?>>White</option> 
                <option value="red" <?php if ($superdeal_buynowbutton == 'red' ) echo 'selected="seleted"';?>>Red</option> 
                <option value="orange" <?php if ($superdeal_buynowbutton == 'orange' ) echo 'selected="seleted"';?>>Orange</option> 
                <option value="magenta" <?php if ($superdeal_buynowbutton == 'magenta' ) echo 'selected="seleted"';?>>Magenta</option> 
                <option value="yellow" <?php if ($superdeal_buynowbutton == 'yellow' ) echo 'selected="seleted"';?>>Yellow</option> 
                <option value="blue" <?php if ($superdeal_buynowbutton == 'blue' ) echo 'selected="seleted"';?>>Blue</option> 
                <option value="pink" <?php if ($superdeal_buynowbutton == 'pink' ) echo 'selected="seleted"';?>>Pink</option> 
                <option value="green" <?php if ($superdeal_buynowbutton == 'green' ) echo 'selected="seleted"';?>>Green</option> 
                <option value="rosy" <?php if ($superdeal_buynowbutton == 'rosy' ) echo 'selected="seleted"';?>>Rosy</option> 
                <option value="brown" <?php if ($superdeal_buynowbutton == 'brown' ) echo 'selected="seleted"';?>>Brown</option> 
                <option value="purple" <?php if ($superdeal_buynowbutton == 'purple' ) echo 'selected="seleted"';?>>Purple</option> 
                <option value="cyan" <?php if ($superdeal_buynowbutton == 'cyan' ) echo 'selected="seleted"';?>>Cyan</option> 
                <option value="gold" <?php if ($superdeal_buynowbutton == 'gold' ) echo 'selected="seleted"';?>>Gold</option>              
               
            </select>
          </td>
        </tr>
      </table>
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_image; ?></td>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left"><input type="text" name="superdeal_module[<?php echo $module_row; ?>][image_width]" value="<?php echo $module['image_width']; ?>" size="3" />
              <input type="text" name="superdeal_module[<?php echo $module_row; ?>][image_height]" value="<?php echo $module['image_height']; ?>" size="3" />
              <?php if (isset($error_image[$module_row])) { ?>
              <span class="error"><?php echo $error_image[$module_row]; ?></span>
              <?php } ?></td>
            <td class="left"><select name="superdeal_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="superdeal_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="superdeal_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="superdeal_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
          </tr>
        </tbody>
        
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="5"></td>
            <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
    delay: 0,
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
        $('#superdeal-product' + ui.item.value).remove();
        
        $('#superdeal-product').append('<div id="superdeal-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" value="' + ui.item.value + '" /></div>');

        $('#superdeal-product div:odd').attr('class', 'odd');
        $('#superdeal-product div:even').attr('class', 'even');
        
        data = $.map($('#superdeal-product input'), function(element){
            return $(element).attr('value');
        });
                        
        $('input[name=\'superdeal_product\']').attr('value', data.join());
                    
        return false;
    }
});

$('#superdeal-product div img').live('click', function() {
    $(this).parent().remove();
    
    $('#superdeal-product div:odd').attr('class', 'odd');
    $('#superdeal-product div:even').attr('class', 'even');

    data = $.map($('#superdeal-product input'), function(element){
        return $(element).attr('value');
    });
                    
    $('input[name=\'superdeal_product\']').attr('value', data.join());    
});
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {    
    html  = '<tbody id="module-row' + module_row + '">';
    html += '  <tr>';
    html += '    <td class="left"><input type="text" name="superdeal_module[' + module_row + '][image_width]" value="200" size="3" /> <input type="text" name="superdeal_module[' + module_row + '][image_height]" value="250" size="3" /></td>';    
    html += '    <td class="left"><select name="superdeal_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout) { ?>
    html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
    <?php } ?>
    html += '    </select></td>';
    html += '    <td class="left"><select name="superdeal_module[' + module_row + '][position]">';
    html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
    html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
    html += '    </select></td>';
    html += '    <td class="left"><select name="superdeal_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="superdeal_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
    html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
    html += '  </tr>';
    html += '</tbody>';
    
    $('#module tfoot').before(html);
    
    module_row++;
}
//--></script> 
<?php echo $footer; ?>
