<?php
//==============================================================================
// Free Shipping Plus v155.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$version = 'v155.1';

// Heading
$_['heading_title']					= 'Free Shipping Plus';

// Buttons
$_['button_save_exit']				= 'Save & Exit';
$_['button_save_keep_editing']		= 'Save & Keep Editing';
$_['button_add_row']				= 'Add Rate';

// Entries
$_['entry_status']					= 'Status:';
$_['help_status']					= 'The status for the extension as a whole.';
$_['entry_sort_order']				= 'Sort Order:';
$_['help_sort_order']				= 'The sort order for the extension, relative to other shipping extensions.';
$_['entry_heading']					= 'Heading:';
$_['help_heading']					= 'The heading under which these shipping options will appear. HTML is supported.';

// General Settings
$_['entry_general_settings']		= 'General Settings';
$_['help_general_settings']			= '
	<em>Title</em><br />
	Enter the title displayed for the shipping method (e.g. "Free Shipping"). HTML is supported. Rates with the same title will only be displayed once. For example, if you want to have Free Shipping available if the total is over $100.00 <strong>OR</strong> the weight is over 10 lbs, create two rates (one with the total criteria and one with the weight criteria) and give them the same title.<br /><br />
	<em>Text</em><br />
	Enter the text displayed in place of the cost (e.g. "Free!"). Leave this field blank to show a formatted 0.00 cost for the currency (e.g. "$0.00").<br /><br />
	<em>Compare Against</em><br />
	Select whether to compare values against the entire cart, or just applicable items in the selected category, manufacturer, and product lists.<br /><br />
	<em>Postcode Format</em><br />
	Select whether to read the postcode entered by the customer in a particular format.<br /><br />
	<em>Value for Total</em><br />
	Select the value used for comparisons against the total: the cart\'s Pre-Discounted Sub-Total (which will not include Discounts and Specials), Sub-Total, Taxed Sub-Total, or Total (at the relative Sort Order of the "Shipping" Order Total). Products that do not require shipping are NOT included in the any of these except the "Total" setting.';
$_['text_internal_notes']			= 'Internal Notes';
$_['text_title']					= 'Title';
$_['text_text']						= 'Text';
$_['text_compare_against']			= 'Compare Against';
$_['text_entire_cart']				= 'Entire Cart';
$_['text_applicable_items']			= 'Applicable Items';
$_['text_postcode_format']			= 'Postcode Format';
$_['text_uk_format']				= 'UK Format';
$_['text_value_for_total']			= 'Value for Total';
$_['text_prediscounted_subtotal']	= 'Pre-Discounted Sub-Total';
$_['text_subtotal']					= 'Sub-Total';
$_['text_taxed_subtotal']			= 'Taxed Sub-Total';

// Order Criteria
$_['entry_order_criteria']			= 'Order Criteria';
$_['help_order_criteria']			= '
	<em>Stores</em><br />
	Select the stores for which the rate is available.<br /><br />
	<em>Currencies</em><br />
	Select the currencies for which the rate is available. "Convert Unselected" will automatically convert the cart total for unselected currencies, based on your currency rates.<br /><br />
	<em>Customer Groups</em><br />
	Select the customer groups for which the rate is available. "Not Logged In" will make the rate available to any customer not currently logged in.<br /><br />
	<em>Geo Zones</em><br />
	Select the geo zones for which the rate is available. "All Other Zones" will make the rate available to all locations not within a geo zone.';
$_['text_stores']					= 'Stores';
$_['text_currencys']				= 'Currencies';
$_['text_convert_unselected']		= '<em>Convert Unselected</em>';
$_['text_customer_groups']			= 'Customer Groups';
$_['text_not_logged_in']			= '<em>Not Logged In</em>';
$_['text_geo_zones']				= 'Geo Zones';
$_['text_all_other_zones']			= '<em>All Other Zones</em>';

// Cart Criteria
$_['entry_cart_criteria']			= 'Cart Criteria';
$_['help_cart_criteria']			= '
	<em>Add</em><br />
	Optionally enter an additional factor (positive or negative, decimal or percentage) to be added to the cart values before calculations occur. Leave the field blank to have no adjustment on that value.<br /><br />
	<em>Min / Max</em><br />
	Optionally enter minimum and/or maximum values the cart must have for the rate to be enabled. Leave fields blank to have no restrictions on that criteria.<br /><br />
	<em>Postcodes</em><br />
	Enter postcode ranges using hyphens, separated by commas. For example, to restrict the rate to postcodes starting with 902 and CX, you would enter 902-90299, CX-CXZZZ.<br /><br />
	<em>Dates</em><br />
	Enter the starting and ending date for the rate. Dates are inclusive, so if you set it to end on the 15th of a month, that will be the last day it is active.';
$_['text_add']						= 'Add';
$_['text_min']						= 'Min';
$_['text_max']						= 'Max';
$_['text_length']					= 'Item Length';
$_['text_width']					= 'Item Width';
$_['text_height']					= 'Item Height';
$_['text_item']						= 'Item';
$_['text_total']					= 'Total';
$_['text_volume']					= 'Volume';
$_['text_weight']					= 'Weight';
$_['text_postcode']					= 'Postcode';
$_['text_date_start']				= 'Date Start';
$_['text_date_end']					= 'Date End';

// Product Criteria
$_['entry_categories']				= 'Categories';
$_['entry_manufacturers']			= 'Manufacturers';
$_['entry_products']				= 'Products';
$_['help_categories']				= '
	<em>Categories</em><br />
	Select the categories that cart products need to match for the rate to be enabled. Disabled categories are displayed in italics. To have no restriction on product categories, leave all the categories unselected.<br /><br />
	<em>Comparison</em><br />
	ANY = The cart has at least one product from a selected category. It can have products from other categories, as well.<br /><br />
	ALL = The cart has products from all selected categories. It can have products from other categories, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> from a selected category. It can have products from selected categories, as well.<br /><br />
	ONLY ANY = The cart has only products from selected categories. It <strong>cannot</strong> have products from unselected categories.<br /><br />
	ONLY ALL = The cart has only products from all selected categories. It <strong>cannot</strong> have products from unselected categories.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> from a selected category. It <strong>cannot</strong> have products from selected categories.';
$_['help_manufacturers']			= '
	<em>Manufacturers</em><br />
	Select the manufacturers that cart products need to match for the rate to be enabled. To have no restriction on product manufacturers, leave all the manufacturers unselected.<br /><br />
	<em>Comparison</em><br />
	ANY = The cart has at least one product from a selected manufacturer. It can have products from other manufacturers, as well.<br /><br />
	ALL = The cart has products from all selected manufacturers. It can have products from other manufacturers, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> from a selected manufacturer. It can have products from selected manufacturers, as well.<br /><br />
	ONLY ANY = The cart has only products from selected manufacturers. It <strong>cannot</strong> have products from unselected manufacturers.<br /><br />
	ONLY ALL = The cart has only products from all selected manufacturers. It <strong>cannot</strong> have products from unselected manufacturers.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> from a selected manufacturer. It <strong>cannot</strong> have products from selected manufacturers.';
$_['help_products']					= '
	<em>Products</em><br />
	Select the products that cart products need to match for the rate to be enabled. Disabled products are marked as such.<br /><br />
	<em>Adding / Removing Products</em>
	<ol style="margin-top: 0; padding-left: 15px">
	<li>Click the gear icon above any product box. A dialog will appear that will scroll with the page.</li>
	<li>Select a category from the dropdown at the top of the dialog that appears.</li>
	<li>Highlight the relevant products in the box below the dropdown. (You can shift-click or control-click to highlight more than one at a time.)</li>
	<li>Click the green plus button in the row where you want to add those products.</li>
	<li>To remove products, highlight them and click the red minus button above the box.</li>
	</ol>
	<em>Comparison</em><br />
	ANY = The cart has at least one product on the list. It can have products not on the list, as well.<br /><br />
	ALL = The cart has all of the products on the list. It can have products not on the list, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> on the list. It can have products on the list, as well.<br /><br />
	ONLY ANY = The cart has only products on the list. It <strong>cannot</strong> have products not on the list.<br /><br />
	ONLY ALL = The cart has only all of the products on the list. It <strong>cannot</strong> have products not on the list.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> on the list. It <strong>cannot</strong> have products on the list.';
$_['entry_product_criteria']		= 'Products';
$_['text_select_category']			= '--- Select Category ---';
$_['text_all_products']				= 'All Products';
$_['text_DISABLED']					= 'DISABLED';
$_['text_cart_must_match']			= 'Cart must match';
$_['text_ANY']						= 'ANY';
$_['text_ALL']						= 'ALL';
$_['text_NOT']						= 'NOT';
$_['text_ONLYANY']					= 'ONLY ANY';
$_['text_ONLYALL']					= 'ONLY ALL';
$_['text_NONE']						= 'NONE';
$_['text_of_these_categories']		= 'of these categories';
$_['text_of_these_manufacturers']	= 'of these manufacturers';
$_['text_of_these_products']		= 'of these products';

// Actions
$_['help_actions']					= '
	<em>Remove</em><br />
	Click the red minus button to remove the rate. Note that if it is the last rate remaining, it will instead be cleared of all values.<br /><br />
	<em>Copy</em><br />
	Click the gray and blue button to copy the rate to the end of the list.';

// Copyright
$_['copyright']						= '<div style="text-align: center" class="help">' . $_['heading_title'] . ' ' . $version . ' &copy; <a target="_blank" href="http://www.getclearthinking.com">Clear Thinking, LLC</a></div>';

// Standard Text
$_['standard_module']				= 'Modules';
$_['standard_shipping']				= 'Shipping';
$_['standard_payment']				= 'Payments';
$_['standard_total']				= 'Order Totals';
$_['standard_feed']					= 'Product Feeds';
$_['standard_success']				= 'Success: You have modified ' . $_['heading_title'] . '!';
$_['standard_error']				= 'Warning: You do not have permission to modify ' . $_['heading_title'] . '!';
?>