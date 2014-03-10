<?php
//==============================================================================
// Restrict Shipping Methods v155.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$type = 'Shipping Method';
$version = 'v155.1';

// Heading
$_['heading_title']					= 'Restrict ' . $type . 's';

// Buttons
$_['button_save_exit']				= 'Save & Exit';
$_['button_save_keep_editing']		= 'Save & Keep Editing';
$_['button_add_row']				= 'Add Restriction';
$_['button_show_examples']			= 'Show Examples';

// Extensions
$_['entry_status']					= 'Status:';
$_['entry_extensions']				= $type . 's';
$_['help_extensions']				= '
	Select the ' . strtolower($type) . '(s) to which these restrictions apply. Disabled ' . strtolower($type) . 's are displayed in italics.<br /><br />
	Note that restrictions determine when ' . strtolower($type) . 's are ENABLED. For instance, if you check only the "US Dollar" currency for a ' . strtolower($type) . ', then it will be available only to customers using US Dollars.';
$_['text_internal_notes']			= 'Internal Notes';

// Order Criteria
$_['entry_order_criteria']			= 'Order Criteria';
$_['help_order_criteria']			= '
	<em>Stores</em><br />
	Select the stores for which the ' . strtolower($type) . ' is available.<br /><br />
	<em>Currencies</em><br />
	Select the currencies for which the ' . strtolower($type) . ' is available. "Convert Unselected" will automatically convert the order total for unselected currencies, based on your currency rates.<br /><br />
	<em>Customer Groups</em><br />
	Select the customer groups for which the ' . strtolower($type) . ' is available. "Not Logged In" will make the ' . strtolower($type) . ' available to any customer not currently logged in.<br /><br />
	<em>Geo Zones</em><br />
	Select the geo zones for which the ' . strtolower($type) . ' is available. "All Other Zones" will make the ' . strtolower($type) . ' available to all locations not within a geo zone.
	' . ($type == 'Shipping Method' ? '' : '
	<br /><br />
	<em>Shipping Methods</em><br />
	Select the shipping methods for which the ' . strtolower($type) . ' is available.'
	) . ($type != 'Order Total' ? '' : '
	<br /><br />
	<em>Payment Methods</em><br />
	Select the payment methods for which the ' . strtolower($type) . ' is available.'
	);
$_['text_stores']					= 'Stores';
$_['text_currencys']				= 'Currencies';
$_['text_convert_unselected']		= '<em>Convert Unselected</em>';
$_['text_customer_groups']			= 'Customer Groups';
$_['text_not_logged_in']			= '<em>Not Logged In</em>';
$_['text_geo_zones']				= 'Geo Zones';
$_['text_all_other_zones']			= '<em>All Other Zones</em>';
$_['text_shipping_extensions']		= 'Shipping Methods';
$_['text_payment_extensions']		= 'Payment Methods';

// Cart Criteria
$_['entry_cart_criteria']			= 'Cart Criteria';
$_['help_cart_criteria']			= '
	<em>Min / Max</em><br />
	Optionally enter minimum and/or maximum values the cart must have for the ' . strtolower($type) . ' to be enabled. Leave fields blank to have no restrictions on that criteria.<br /><br />
	<em>Value for Total</em><br />
	Select the value used for order total comparisons: the cart\'s Pre-Discounted Sub-Total (using all products\' original prices instead of Special or Discount prices), Sub-Total, Taxed Sub-Total, or Total (at the point ' . ($type == 'Shipping Method' ? 'of' : 'after') . ' the "Shipping" Order Total). (&curren;) means currency-unit, such as ($) or (&euro;), for the selected currencies<br /><br />
	<em>Postcodes</em><br />
	Enter postcode ranges using hyphens, separated by commas. For example, to restrict the ' . strtolower($type) . ' to postcodes starting with 902 and CX, you would enter 902-90299, CX-CXZZZ.<br /><br />
	<em>Postcode Format</em><br />
	Select whether to read the postcode entered by the customer in a particular format.<br /><br />
	<em>Dates</em><br />
	Enter the starting and ending date for the ' . strtolower($type) . '. Dates are inclusive, so if you set it to end on the 15th of a month, that will be the last day it is active.<br /><br />
	<em>Compare Against</em><br />
	Select whether to compare Cart Criteria values against the entire cart, or just applicable items in the category / manufacturer / product lists.';
$_['text_min']						= 'Min';
$_['text_max']						= 'Max';
$_['text_length']					= 'Item Length';
$_['text_width']					= 'Item Width';
$_['text_height']					= 'Item Height';
$_['text_item']						= 'Item';
$_['text_prediscounted_subtotal']	= 'Pre-Discounted';
$_['text_subtotal']					= 'Sub-Total';
$_['text_taxed_subtotal']			= 'Taxed Sub-Total';
$_['text_total']					= 'Total';
$_['text_volume']					= 'Volume';
$_['text_weight']					= 'Weight';
$_['text_postcode']					= 'Postcode';
$_['text_postcode_format']			= 'Postcode Format';
$_['text_uk_format']				= 'UK Format';
$_['text_date_start']				= 'Date Start';
$_['text_date_end']					= 'Date End';
$_['text_compare_against']			= 'Compare Against';
$_['text_entire_cart']				= 'Entire Cart';
$_['text_applicable_items']			= 'Applicable Items';

// Product Criteria
$_['entry_categories']				= 'Categories';
$_['entry_manufacturers']			= 'Manufacturers';
$_['entry_products']				= 'Products';
$_['help_categories']				= '
	<em>Categories</em><br />
	Select the categories that cart products need to match for the ' . strtolower($type) . ' to be enabled. Disabled categories are displayed in italics. To have no restriction on product categories, leave all the categories unselected.<br /><br />
	<em>Comparison</em><br />
	ANY = The cart has at least one product from a selected category. It can have products from other categories, as well.<br /><br />
	ALL = The cart has products from all selected categories. It can have products from other categories, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> from a selected category. It can have products from selected categories, as well.<br /><br />
	ONLY ANY = The cart has only products from selected categories. It <strong>cannot</strong> have products from unselected categories.<br /><br />
	ONLY ALL = The cart has only products from all selected categories. It <strong>cannot</strong> have products from unselected categories.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> from a selected category. It <strong>cannot</strong> have products from selected categories.';
$_['help_manufacturers']			= '
	<em>Manufacturers</em><br />
	Select the manufacturers that cart products need to match for the ' . strtolower($type) . ' to be enabled. To have no restriction on product manufacturers, leave all the manufacturers unselected.<br /><br />
	<em>Comparison</em><br />
	ANY = The cart has at least one product from a selected manufacturer. It can have products from other manufacturers, as well.<br /><br />
	ALL = The cart has products from all selected manufacturers. It can have products from other manufacturers, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> from a selected manufacturer. It can have products from selected manufacturers, as well.<br /><br />
	ONLY ANY = The cart has only products from selected manufacturers. It <strong>cannot</strong> have products from unselected manufacturers.<br /><br />
	ONLY ALL = The cart has only products from all selected manufacturers. It <strong>cannot</strong> have products from unselected manufacturers.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> from a selected manufacturer. It <strong>cannot</strong> have products from selected manufacturers.';
$_['help_products']					= '
	<em>Products</em><br />
	Select the products the cart needs to match for the ' . strtolower($type) . ' to be enabled. Disabled products are marked as such. To have no restriction on products, leave the product list empty.<br /><br />
	<em>Adding / Removing Products</em>
	<ol style="margin-top: 0; padding-left: 15px"><li>Click the gear icon above any product box. A dialog will appear that will scroll with the page.</li>
	<li>Select a category from the dropdown at the top of the dialog that appears.</li>
	<li>Highlight the relevant products in the box below the dropdown. (You can shift-click or control-click to highlight more than one at a time.)</li>
	<li>Click the green plus button in the restriction where you want to add those products.</li>
	<li>To remove products, highlight them and click the red minus button above the box.</li></ol>
	<em>Comparison</em><br />
	ANY = The cart has at least one product on the list. It can have products not on the list, as well.<br /><br />
	ALL = The cart has all of the products on the list. It can have products not on the list, as well.<br /><br />
	NOT = The cart has at least one product <strong>not</strong> on the list. It can have products on the list, as well.<br /><br />
	ONLY ANY = The cart has only products on the list. It <strong>cannot</strong> have products not on the list.<br /><br />
	ONLY ALL = The cart has only all of the products on the list. It <strong>cannot</strong> have products not on the list.<br /><br />
	NONE = The cart has at least one product <strong>not</strong> on the list. It <strong>cannot</strong> have products on the list.';
$_['text_products']					= 'Products';
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

// Actions and Examples
$_['help_actions']					= '
	<em>Remove</em><br />
	Click the red minus button to remove the restriction. Note that if it is the last restriction remaining, it will instead be cleared of all values.<br /><br />
	<em>Copy</em><br />
	Click the gray and blue button to copy the restriction to the end of the list.';
$_['help_examples']					= '
	<h2 class="selected">Example 1</h2><h2>Example 2</h2><h2>Example 3</h2>
	<div id="example1">
		Suppose you want to restrict USPS from appearing unless the cart contains at least 2 lbs or 500 cubic inches of products from your "Alpha" manufacturer. You also only want it available to postcodes starting with 4 or 9. Then you would enter:<br /><br />
		<strong>RESTRICTION #1</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> USPS</li>
			<li><strong>Weight Min:</strong> 2</li>
			<li><strong>Postcodes:</strong> 4-49999, 9-99999</li>
			<li><strong>Compare Against:</strong> Applicable Items</li>
			<li><strong>Manufacturer Comparison:</strong> ANY</li>
			<li><strong>Manufacturers:</strong> Alpha</li>
		</ul>
		<strong>RESTRICTION #2</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> USPS</li>
			<li><strong>Volume Min:</strong> 500</li>
			<li><strong>Postcodes:</strong> 4-49999, 9-99999</li>
			<li><strong>Compare Against:</strong> Applicable Items</li>
			<li><strong>Manufacturer Comparison:</strong> ANY</li>
			<li><strong>Manufacturers:</strong> Alpha</li>
		</ul>
	</div>
	<div id="example2" style="display: none">
		Suppose within the U.S., you want to give Free Shipping for the month of May when the cart contains at least 3 of Products A, B, or C (and only those products). For international locations, you only want to give Free Shipping when at least 5 of only those products are in the cart, and the taxed sub-total is at least $100 (or the foreign currency equivalent). Then you would enter:<br /><br />
		<strong>RESTRICTION #1</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> Free Shipping</li>
			<li><strong>Geo Zones:</strong> U.S.</li>
			<li><strong>Items Min:</strong> 3</li>
			<li><strong>Date Start:</strong> 2012-05-01</li>
			<li><strong>Date End:</strong> 2012-05-31</li>
			<li><strong>Product Comparison:</strong> ONLY ANY</li>
			<li><strong>Products:</strong> A, B, C</li>
		</ul>
		<strong>RESTRICTION #2</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> Free Shipping</li>
			<li><strong>Currencies:</strong> Convert Unselected, US Dollar</li>
			<li><strong>Geo Zones:</strong> All Other Zones (or your international geo zones)</li>
			<li><strong>Items Min:</strong> 5</li>
			<li><strong>Taxed Sub-Total Min:</strong> 100</li>
			<li><strong>Date Start:</strong> 2012-05-01</li>
			<li><strong>Date End:</strong> 2012-05-31</li>
			<li><strong>Product Comparison:</strong> ONLY ANY</li>
			<li><strong>Products:</strong> A, B, C</li>
		</ul>
	</div>
	<div id="example3" style="display: none">
		Suppose for your Default customer group you want the Pickup From Store shipping method to be the only one available when the cart contains products from your "Pickup Only" category. If there are other products in the cart, or the customer is part of your Wholesale customer group, you want UPS to be the only shipping method available. Then you would enter:<br /><br />
		<strong>RESTRICTION #1</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> Pickup From Store</li>
			<li><strong>Customer Groups:</strong> Default</li>
			<li><strong>Category Comparison:</strong> ONLY ANY</li>
			<li><strong>Categories:</strong> Pickup Only</li>
		</ul>
		<strong>RESTRICTION #2</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> UPS</li>
			<li><strong>Customer Groups:</strong> Default</li>
			<li><strong>Category Comparison:</strong> NOT</li>
			<li><strong>Categories:</strong> Pickup Only</li>
		</ul>
		<strong>RESTRICTION #3</strong>
		<ul>
			<li><strong>Shipping Methods:</strong> UPS</li>
			<li><strong>Customer Groups:</strong> Wholesale</li>
		</ul>
	</div>';

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