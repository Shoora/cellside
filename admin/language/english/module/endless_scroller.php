<?php
$_['extension_name']                = 'Endless Scroller';

// Heading
$_['heading_title']                 = '<i class="fa fa-angle-double-down" style="font-size:14px;color:#F7951D;"></i> <strong>' . $_['extension_name'] . '</strong>';

// Buttons
$_['button_apply']                  = 'Apply';
$_['button_upgrade']                = 'Upgrade';

// Tabs
$_['tab_settings']                  = 'Settings';
$_['tab_support']                   = 'Support';
$_['tab_about']                     = 'About';
$_['tab_general']                   = 'General';
$_['tab_faq']                       = 'FAQ';
$_['tab_services']                  = 'Services';

// Text
$_['text_success_upgrade']          = '<strong>Success!</strong> You have upgraded ' . $_['extension_name'] . ' to version <strong>%s</strong>!';
$_['text_success_update']           = '<strong>Success!</strong> You have updated ' . $_['extension_name'] . ' settings!';
$_['text_toggle_navigation']        = 'Toggle navigation';
$_['text_license']                  = 'License';
$_['text_extension_information']    = 'Extension information';
$_['text_legal_notice']             = 'Legal notice';
$_['text_terms']                    = 'Terms &amp; Conditions';
$_['text_support_subject']          = $_['extension_name'] . ' support needed';
$_['text_license_text']             = 'Please be aware that this product has a <strong>per-domain license</strong>, meaning you can use it <em>only on a single domain</em> (sub-domains count as separate domains). <strong>You will need to purchase a separate license for each domain you wish to use this extension on.</strong>';
$_['text_other_extensions']         = 'If you like this extension you might also be interested in <a href="%s" class="alert-link" target="_blank">my other extensions</a>.';
$_['text_module']                   = 'Modules';
$_['text_faq']                      = 'Frequently Asked Questions';

// Help texts
$_['help_bottom_pixels']            = 'The number of pixels from the bottom of the product list div that triggers the load event.';
$_['help_use_fade_in']              = 'Fade in fetched products one-by-one.';
$_['help_use_more']                 = 'Instead of auto loading the next page when user reaches the end of the product list, use a button to initiate the loading of the next page. This way the user can access the page footer without having to scroll through all the pages.';
$_['help_use_more_after']           = 'Disables auto loading after <em>x</em> pages and displays the "More" button. If "More" is clicked, enables auto loading for another <em>x</em> pages. If set to 0, uses "More" button for each page load.';
$_['help_use_sticky_footer']        = 'Show a sticky footer with current progress while scrolling through the pages. This shows the users how many products have been loaded and how much is left.';
$_['help_max_items_per_load']       = 'The maximum number of products you can load at once. This limits the actual number of pages the backend code will output with a single page load, so you cannot request 2000 pages and load the entire site in one page.';

// Entry
$_['entry_extension_status']        = 'Extension status:';
$_['entry_bottom_pixels']           = 'Bottom Pixels:';
$_['entry_use_fade_in']             = 'Fade-In:';
$_['entry_use_back_to_top']         = '"Back to Top" Button:';
$_['entry_use_more']                = '"More" Button:';
$_['entry_use_more_after']          = '"More" Button After:';
$_['entry_use_sticky_footer']       = 'Sticky Footer:';
$_['entry_max_items_per_load']      = 'Max Items Per Load:';
$_['entry_installed_version']       = 'Installed version:';
$_['entry_extension_name']          = 'Name:';
$_['entry_extension_compatibility'] = 'Compatibility:';
$_['entry_extension_store_url']     = 'Store URL:';
$_['entry_copyright_notice']        = 'Copyright notice:';

// Error
$_['error_permission']              = '<strong>Error!</strong> You do not have permission to modify extension ' . $_['extension_name'] . '!';
$_['error_warning']                 = '<strong>Warning!</strong> Please check the form carefully for errors!';
$_['error_vqmod']                   = '<strong>Error!</strong> vQmod does not seem to be installed. <a href="http://code.google.com/p/vqmod/" class="alert-link">Get vQmod!</a>';
$_['error_unsaved_settings']        = '<strong>Warning!</strong> There are unsaved settings! Please save the settings.';
$_['error_version']                 = '<strong>Info!</strong> ' . $_['extension_name'] . ' version <strong>%s</strong> installation files found. You need to upgrade ' . $_['extension_name'] . '!';
$_['error_ajax_request']            = 'An AJAX error occured!';
$_['error_positive_integer_zero']   = 'This value must be a positive integer greater than or equal to 0.';
$_['error_positive_integer']        = 'This value must be a positive integer greater than 0.';
?>
