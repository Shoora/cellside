<div class="action_button pull-right">
	<button class="btn btn-primary saveGlobal" type="button">Save</button>
	<button class="btn set_def_all" type="button">Restore default values</button>
</div>
<form class="form-horizontal">
	<table class="table table-condensed no-border">
	<tbody>
	<!-- Product Page start -->
		<tr>
		<td colspan="2"><legend>Product Page</legend></td>
		</tr>
		<tr>
			<td>
				<fieldset>
				<div class="control-group">
					<label class="control-label" for="data-selector_product">HTML element of product</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_product" name="selector_product" value="<?php echo $options['data']['selector_product']; ?>" >
						<button value="<?php echo $default_global_setting['selector_product']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
				</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>HTML element of product:</dt>
				<dd>
					Define HTML elements, where Gallery will search products. You can use Jquery or CSS selector for select elements.
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-attr_product">HTML Attribute</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-attr_product" name="attr_product" value="<?php echo $options['data']['attr_product']; ?>">
						<button value="<?php echo $default_global_setting['attr_product']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>HTML Attribute:</dt>
				<dd>
					Define HTML Attribute, which contain Id of product.
				</dd>
			</td>
		</tr>	<!-- Product Page end -->	
	
	<!-- Category Page start -->
		<tr>
		<td colspan="2"><legend>Category Page</legend></td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-selector_category">HTML element of product</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_category" name="selector_category" value="<?php echo $options['data']['selector_category']; ?>">
						<button value="<?php echo $default_global_setting['selector_category']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>HTML element of product:</dt>
				<dd>
					Define HTML elements, where Gallery will search products.You can use Jquery or CSS selector for select elements.
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-attr_category">HTML Attribute</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-attr_category" name="attr_category" value="<?php echo $options['data']['attr_category']; ?>">
						<button value="<?php echo $default_global_setting['attr_category']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>HTML Attribute:</dt>
				<dd>
					Define HTML Attribute, which contain Id of product.
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-selector_qw_button">Container for Button "Quick View"</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_qw_button" name="selector_qw_button" value="<?php echo $options['data']['selector_qw_button']; ?>">
						<button value="<?php echo $default_global_setting['selector_qw_button']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Container for Button "Quick View":</dt>
				<dd>
					Define container, where will be add Button "Quick View".
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-jq_relative_path_to_id">Relative path to product's Id</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-jq_relative_path_to_id" name="jq_relative_path_to_id" value="<?php echo $options['data']['jq_relative_path_to_id']; ?>">
						<button value="<?php echo $default_global_setting['jq_relative_path_to_id']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Relative path to product's Id:</dt>
				<dd>
					Define relative path from Button "Quick View" to HTML element with product's link, which contain Id of product.
				</dd>
			</td>
		</tr>

		<tr> <!-- *******Position for Button Quick View-->
			<td>
				<fieldset>
				<div class="control-group">
					<label class="control-label" for="data-position_qw_button">Position for Button Quick View</label>
					<div class="controls">
						<input type="hidden" name="data[data][position_qw_button]" value="append">
						<input id="data-position_qw_button" type="checkbox" value="prepend" <?php if($options['data']['position_qw_button'] == 'prepend') echo ' checked="checked" '; ?> name="position_qw_button" class="append_prepend" />
					</div>
				</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Position for Button Quick View:</dt>
					<dd>
						Specify where will be add Button Quick View to container (first / last). This is can usefull for specific themes.
					</dd>
				</dl>
			</td>
		</tr>
		
		<tr><!-- *******custom CSS for button-->
			<td>
				<fieldset>
				<div class="control-group">
					<label class="control-label" for="data-css_qw_button_style">Custom CSS for Button "Quick View"</label>
					<div class="controls">
						<textarea id="data-css_qw_button_style" name="css_qw_button_style" rows="3"><?php echo $options['data']['css_qw_button_style']; ?></textarea>
					</div>
				</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt>Custom CSS for Button "Quick View":</dt>
					<dd>
						Here you can type own styles Button "Quick View".<p class="info-warning">(!)Please, add "!important" for every style.</p> For example "border: 1px solid red!important;".
					</dd>
				</dl>
			</td>
		</tr><!-- Category Page end -->
		
		
		<!-- Pagination start -->
		<tr>
		<td colspan="2"><legend>Pagination</legend></td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-selector_pagin_container">Container Selector</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_pagin_container" name="selector_pagin_container" value="<?php echo $options['data']['selector_pagin_container']; ?>">
						<button value="<?php echo $default_global_setting['selector_pagin_container']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Container Selector:</dt>
				<dd>
					Define HTML Container for pagination block on page.
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-selector_pagin_activ">Active Element Selector</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_pagin_activ" name="selector_pagin_activ" value="<?php echo $options['data']['selector_pagin_activ']; ?>">
						<button value="<?php echo $default_global_setting['selector_pagin_activ']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Active Element Selector:</dt>
				<dd>
					Define active HTML element of current page in pagination block
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-selector_pagin_element">Element Selector</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-selector_pagin_element" name="selector_pagin_element" value="<?php echo $options['data']['selector_pagin_element']; ?>">
						<button value="<?php echo $default_global_setting['selector_pagin_element']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Element Selector:</dt>
				<dd>
					Define common not active HTML element in pagination block
				</dd>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
					<div class="control-group">
					<label class="control-label" for="data-attr_pagin_href">Attribute with URL</label>
					<div class="controls">
						<div class="input-append">
						<input type="text" id="data-attr_pagin_href" name="attr_pagin_href" value="<?php echo $options['data']['attr_pagin_href']; ?>">
						<button value="<?php echo $default_global_setting['attr_pagin_href']; ?>" class="btn set_def_val" type="button">Default value</button>
						</div>
					</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dt>Attribute with URL:</dt>
				<dd>
					Attribute of pagination element, which contain URL to next or previous Page
				</dd>
			</td>
		</tr>	<!-- Pagination end -->
	</tbody>
	</table>
</form>
