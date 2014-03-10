<?php

			//Tabs
			$_['tab_ips']                  = 'Increase Page Speed 4.1';
			
			//Heading
			$_['heading_minify_javascript']  = 'Javascript Handling';
			$_['heading_minify_css']         = 'CSS Handling';
			$_['heading_minify_settings']    = 'Minify Settings';
			$_['heading_html_images']        = 'HTML &amp; Image Handling';
			$_['heading_data_caching']       = 'Data Caching Configuration';
			$_['heading_content_delivery']   = 'Content Delivery';
			$_['heading_speed_analyzer']     = 'Speed Analysis';
			
			//Entry
			$_['entry_minify_javascript']            = 'Minify JavaScript:<br /><span class="help">The combination, minification, compression, and caching for JavaScript files.</span>';
			$_['entry_javascript_jquery']            = 'jQuery Google:<br /><span class="help">Serve JQuery library seperately over Google C.D.N. (requires minifier)</span>';
			$_['entry_javascript_jquery_version']    = 'jQuery Version:<span class="help">If using Google C.D.N, the optimizer will attempt to automatically detect the and use the version on page, ultimately you may specify an override here.</span>';
			$_['entry_javascript_jqueryui']          = 'jQuery UI Google:<br /><span class="help">Serve JQuery UI library seperately over Google C.D.N. (requires minifier)</span>';
			$_['entry_javascript_jqueryui_version']  = 'jQuery UI Version:<span class="help">If using Google C.D.N, the optimizer will attempt to automatically detect the and use the version on page, ultimately you may specify an override here.</span>';
			$_['entry_javascript_defer']             = 'Defer Javascript:<br /><span class="help">Defer Parsing of all JavaScript until document has completed loading. (BETA FEATURE - DO NOT ACTIVATE)</span>';

			$_['entry_minify_css']           = 'Minify CSS:<br /><span class="help">The combination, minification, compression, and caching for CSS.</span>';
			$_['entry_minify_cache']         = 'Minify Cache Enabled:<br /><span class="help">The combination, minification, compression, and caching for CSS & Javascript (global on/off).</span>';
			$_['entry_minify_encode_images'] = 'Encode Small Images:<br /><span class="help">Encode Small images to be inline in CSS files to save additional server requests.</span>'; 
			$_['entry_minify_image_size']    = 'Maximum Image Size:<br /><span class="help">The largest size of image which should be encoded in CSS files.</span>'; 
			$_['entry_minify_image_occurs']  = 'Image Occurance:<br /><span class="help">The largest number of times an image can occur and be encoded in CSS.</span>'; 
			$_['entry_minify_encode_url']    = 'Encode URL(s):<br /><span class="help">Encodes the combined urls used for CSS & JavaScript so that they do not contain dynamic parameters (must be off to use debugging).</span>'; 
			$_['entry_minify_storage']       = 'Storage Location:<br /><span class="help">Controls the storage location of the combined files (memory being faster).</span>'; 
			$_['entry_minify_advanced']      = 'Advanced Settings:<br /><span class="help">Unless you are attempting to resolve a problem, leave these settings at default values.</span>';
			$_['entry_minify_logging']       = 'Error Logging:<br /><span class="help">Error logging for Minification libraries.</span>';
			$_['entry_minify_debug_mode']    = 'Debug Mode:<br /><span class="help">Loads URLS in debugging mode (produces a detailed, non-functional output for visual debugging).</span>';
			$_['entry_minify_max_age']       = 'Maximum Age:<br /><span class="help">The cache lifetime specified to client browsers when serving combined CSS/JS files.</span>';
			$_['entry_minify_file_path']     = 'File Path:<br /><span class="help">Full file path to the \'min\' folder within OpenCart (blank = autodetect).</span>';
			$_['entry_minify_file_locking']  = 'File Locking:<br /><span class="help">The mode in which files should be accessed.</span>';

			$_['entry_firebug_analyzer']     = 'Speed Analyzer:<br /><span class="help">Enables page generation stats and database query time statistics to FireFox. (firebug and firephp browser plug-ins required)</span>';
			$_['entry_firebug_queries']      = 'Slow Query Output:<br /><span class="help">Displays slow queries into firebug console to assist in determining what database queries (3rd party modules) are slowing down your site. (DO NO LEAVE ENABLED, ONLY USE FOR DEBUGGING)</span>';
			$_['entry_ipsjs_excludes']       = 'Javascript Exclude:<br /><span class="help">Javascript to exclude from I.P.S combination. Seperated by comma.</span>';
			$_['entry_ipscss_excludes']      = 'CSS Exclude:<br /><span class="help">CSS to exclude from I.P.S combination. Seperated by comma.</span>';

			$_['entry_minify_html']          = 'Minify HTML Enabled:<br /><span class="help">If HTML content should be minified prior to compression.</span>';
			$_['entry_jpeg_compression']     = 'JPEG Compression:<br /><span class="help">Compression quality settings for JPEG images (value between 0-100).</span>';
			$_['entry_logo_dimensions']      = 'Logo Dimensions:<br /><span class="help">Adds dimension specifiers to logo. (0\'s = disabled)</span>';
			$_['entry_image_dimensions']     = 'Image Dimension Specifiers:<br /><span class="help">Adds dimensions to various areas of OpenCart modules.</span>';

			$_['entry_memory_cache']         = 'Memory Data Caching:<br /><span class="help">If enabled on your server, you may choose a memory caching mechanism.</span>';
			$_['entry_ipscron_status']       = 'Category Counts DB Cache:';
			$_['entry_category_counts']      = 'Category Counts:';
			$_['entry_seo_cache']            = 'SEO URL Cache:';
			
			$_['entry_minify_cache']       = 'Minify Cache Enabled:<br /><span class="help">The combination, minification, compression, and caching for CSS & Javascript.</span>';
			$_['entry_minify_html']        = 'Minify HTML Enabled:<br /><span class="help">If HTML content should be minified prior to compression.</span>';
			$_['entry_advanced_imaging']   = 'Advanced Image Processing:<br /><span class="help">Make use of Yahoo\'s Smush.It imaging service to compress images. (not recommended for OC 1.5.4+)</span>';
			$_['entry_memory_cache']       = 'Memory Data Caching:<br /><span class="help">If enabled on your server, you may choose a memory caching mechanism.</span>';
			$_['entry_ipsjs_excludes']     = 'Javascript Exclude:<br /><span class="help">Javascript to exclude from I.P.S combination. Seperated by comma.</span>';
			$_['entry_ipscss_excludes']    = 'CSS Exclude:<br /><span class="help">CSS to exclude from I.P.S combination. Seperated by comma.</span>';
			
			$_['entry_cdn_status']         = 'CDN Status:<br /><span class="help">Globally enable/disable content serving via our CDN/sub-domain.</span>';
			$_['entry_cdn_http']           = 'CDN HTTP URL:<br /><span class="help">If you are using a CDN (or a sub-domain for cookieless delivery), you may specify the HTTP base url here.</span>';
			$_['entry_cdn_https']          = 'CDN HTTPS URL:<br /><span class="help">If you are using a CDN (or a sub-domain for cookieless delivery), you may specify the HTTPS base url here.</span>';
			$_['entry_cdn_images']         = 'Serve Images:<br /><span class="help">Serve Images via the CDN.</span>';
			$_['entry_cdn_css']            = 'Serve CSS:<br /><span class="help">Serve CSS via the CDN.</span>';
			$_['entry_cdn_js']             = 'Serve JavaScript:<br /><span class="help">Serve JavaScript via the CDN.</span>';
			
			// Texts
			$_['text_enabled']             = 'Enabled';
			$_['text_disabled']            = 'Disabled';
			$_['text_on']                  = 'On';
			$_['text_off']                 = 'Off';
			$_['text_default']             = '(default)';
			$_['text_file_system']         = 'File System';
			$_['text_in_memory_apc']       = 'In-Memory (APC)'; 
			$_['text_memory_file']         = 'File Caching';
			$_['text_memory_apc']          = 'APC Caching';
			$_['text_memory_xcache']       = 'Xcache Caching';
			$_['text_memory_none']         = 'No supported in-memory caching has been detected with your web hosting.';
			$_['text_image_dimensions']    = '<span class="help">Carousel: <strong>On</strong><br />Banners: <strong>On</strong><br />Slideshow: <strong>On</strong><br />Featured: <strong>On</strong><br /></span>';
			$_['text_show_advanced']       = 'show advanced settings';
			$_['text_hide_advanced']       = 'hide advanced settings';
			$_['text_day']                 = 'Day';
			$_['text_days']                = 'Days';
			$_['text_time']                = 'Time';
			$_['text_times']               = 'Times';
			
// Heading
$_['heading_title']                = 'Settings';

// Text
$_['text_success']                 = 'Success: You have modified settings!';
$_['text_items']                   = 'Items';
$_['text_product']                 = 'Products';
$_['text_voucher']                 = 'Vouchers';
$_['text_tax']                     = 'Taxes';
$_['text_account']                 = 'Account';
$_['text_checkout']                = 'Checkout';
$_['text_stock']                   = 'Stock';
$_['text_affiliate']               = 'Affiliates';
$_['text_return']                  = 'Returns';
$_['text_image_manager']           = 'Image Manager';
$_['text_browse']                  = 'Browse';
$_['text_clear']                   = 'Clear';
$_['text_shipping']                = 'Shipping Address';
$_['text_payment']                 = 'Payment Address';
$_['text_mail']                    = 'Mail';
$_['text_smtp']                    = 'SMTP';

// Entry
$_['entry_name']                   = 'Store Name:';
$_['entry_owner']                  = 'Store Owner:';
$_['entry_address']                = 'Address:';
$_['entry_email']                  = 'E-Mail:';
$_['entry_telephone']              = 'Telephone:';
$_['entry_fax']                    = 'Fax:';
$_['entry_meta_keywords'] = 'Meta Keywords:';
$_['entry_title']                  = 'Title:';
$_['entry_meta_description']       = 'Meta Tag Description:';
$_['entry_layout']                 = 'Default Layout:';
$_['entry_template']               = 'Template:';
$_['entry_country']                = 'Country:';
$_['entry_zone']                   = 'Region / State:';
$_['entry_language']               = 'Language:';
$_['entry_admin_language']         = 'Administration Language:';
$_['entry_currency']               = 'Currency:<br /><span class="help">Change the default currency. Clear your browser cache to see the change and reset your existing cookie.</span>';
$_['entry_currency_auto']          = 'Auto Update Currency:<br /><span class="help">Set your store to automatically update currencies daily.</span>';
$_['entry_length_class']           = 'Length Class:';
$_['entry_weight_class']           = 'Weight Class:';
$_['entry_catalog_limit'] 	       = 'Default Items Per Page (Catalog):<br /><span class="help">Determines how many catalog items are shown per page (products, categories, etc)</span>';
$_['entry_admin_limit']   	       = 'Default Items Per Page (Admin):<br /><span class="help">Determines how many admin items are shown per page (orders, customers, etc)</span>';
$_['entry_product_count']          = 'Category Product Count:<br /><span class="help">Show the number of products inside the subcategories in the storefront header category menu. Be warned, this will cause an extreme performance hit for stores with a lot of subcategories!</span>';
$_['entry_review']       	       = 'Allow Reviews:<br /><span class="help">Enable/Disable new review entry and display of existing reviews</span>';
$_['entry_download']               = 'Allow Downloads:';
$_['entry_voucher_min']            = 'Voucher Min:<br /><span class="help">Minimum amount a customer can purchase a voucher for.</span>';
$_['entry_voucher_max']            = 'Voucher Max:<br /><span class="help">Maximum amount a customer can purchase a voucher for.</span>';
$_['entry_tax']                    = 'Display Prices With Tax:';
$_['entry_vat']                    = 'VAT Number Validate:<br /><span class="help">Validate VAT number with http://ec.europa.eu service.</span>';
$_['entry_tax_default']            = 'Use Store Tax Address:<br /><span class="help">Use the store address to calculate taxes if no one is logged in. You can choose to use the store address for the customers shipping or payment address.</span>';
$_['entry_tax_customer']           = 'Use Customer Tax Address:<br /><span class="help">Use the customers default address when they login to calculate taxes. You can choose to use the default address for the customers shipping or payment address.</span>';
$_['entry_customer_online']        = 'Customers Online:<br /><span class="help">Track customers online via the customer reports section.</span>';
$_['entry_customer_group']         = 'Customer Group:<br /><span class="help">Default customer group.</span>';
$_['entry_customer_group_display'] = 'Customer Groups:<br /><span class="help">Display customer groups that new customers can select to use such as wholesale and business when signing up.</span>';
$_['entry_customer_price']         = 'Login Display Prices:<br /><span class="help">Only show prices when a customer is logged in.</span>';
$_['entry_account']                = 'Account Terms:<br /><span class="help">Forces people to agree to terms before an account can be created.</span>';
$_['entry_cart_weight']            = 'Display Weight on Cart Page:<br /><span class="help">Show the cart weight on the cart page</span>';
$_['entry_guest_checkout']         = 'Guest Checkout:<br /><span class="help">Allow customers to checkout without creating an account. This will not be available when a downloadable product is in the shopping cart.</span>';
$_['entry_checkout']               = 'Checkout Terms:<br /><span class="help">Forces people to agree to terms before an a customer can checkout.</span>';
$_['entry_order_edit']             = 'Order Editing:<br /><span class="help">Number of days allowed to edit an order. This is required because prices and discounts may change over time corrupting the order if it\'s edited.</span>';
$_['entry_invoice_prefix']         = 'Invoice Prefix:<br /><span class="help">Set the invoice prefix (e.g. INV-2011-00). Invoice ID\'s will start at 1 for each unique prefix</span>';
$_['entry_order_status']           = 'Order Status:<br /><span class="help">Set the default order status when an order is processed.</span>';
$_['entry_complete_status']        = 'Complete Order Status:<br /><span class="help">Set the order status the customers order must reach before they are allowed to access their downloadable products and gift vouchers.</span>';
$_['entry_stock_display']          = 'Display Stock:<br /><span class="help">Display stock quantity on the product page.</span>';
$_['entry_stock_warning']          = 'Show Out Of Stock Warning:<br /><span class="help">Display out of stock message on the shopping cart page if a product is out of stock but stock checkout is yes. (Warning always shows if stock checkout is no)</span>';
$_['entry_stock_checkout']         = 'Stock Checkout:<br /><span class="help">Allow customers to still checkout if the products they are ordering are not in stock.</span>';
$_['entry_stock_status']           = 'Out of Stock Status:<br /><span class="help">Set the default out of stock status selected in product edit.</span>';
$_['entry_affiliate']              = 'Affiliate Terms:<br /><span class="help">Forces people to agree to terms before an affiliate account can be created.</span>';
$_['entry_commission']             = 'Affiliate Commission (%):<br /><span class="help">The default affiliate commission percentage.</span>';
$_['entry_return']                 = 'Return Terms:<br /><span class="help">Forces people to agree to terms before an return account can be created.</span>';
$_['entry_return_status']          = 'Return Status:<br /><span class="help">Set the default return status when an returns request is submitted.</span>';
$_['entry_logo']                   = 'Store Logo:';
$_['entry_icon']                   = 'Icon:<br /><span class="help">The icon should be a PNG that is 16px x 16px.</span>';
$_['entry_image_category']         = 'Category Image Size:';
$_['entry_image_thumb']            = 'Product Image Thumb Size:';
$_['entry_image_popup']            = 'Product Image Popup Size:';
$_['entry_image_product']          = 'Product Image List Size:';
$_['entry_image_additional']       = 'Additional Product Image Size:';
$_['entry_image_related']          = 'Related Product Image Size:';
$_['entry_image_compare']          = 'Compare Image Size:';
$_['entry_image_wishlist']         = 'Wish List Image Size:';
$_['entry_image_cart']             = 'Cart Image Size:';
$_['entry_ftp_host']               = 'FTP Host:';
$_['entry_ftp_port']               = 'FTP Port:';
$_['entry_ftp_username']           = 'FTP Username:';
$_['entry_ftp_password']           = 'FTP Password:';
$_['entry_ftp_root']               = 'FTP Root:<span class="help">The directory your opencart installation is stored in normally \'public_html/\'.</span>';
$_['entry_ftp_status']             = 'Enable FTP:';
$_['entry_mail_protocol']          = 'Mail Protocol:<span class="help">Only choose \'Mail\' unless your host has disabled the php mail function.</span>';
$_['entry_mail_parameter']         = 'Mail Parameters:<span class="help">When using \'Mail\', additional mail parameters can be added here (e.g. "-femail@storeaddress.com").</span>';
$_['entry_smtp_host']              = 'SMTP Host:';
$_['entry_smtp_username']          = 'SMTP Username:';
$_['entry_smtp_password']          = 'SMTP Password:';
$_['entry_smtp_port']              = 'SMTP Port:';
$_['entry_smtp_timeout']           = 'SMTP Timeout:';
$_['entry_account_mail']           = 'New Account Alert Mail:<br /><span class="help">Send a email to the store owner when a new account is registered.</span>';
$_['entry_alert_mail']             = 'New Order Alert Mail:<br /><span class="help">Send a email to the store owner when a new order is created.</span>';
$_['entry_alert_emails']           = 'Additional Alert E-Mails:<br /><span class="help">Any additional emails you want to receive the alert email, in addition to the main store email. (comma separated)</span>';
$_['entry_fraud_detection']        = 'Use MaxMind Fraud Detection System:<br /><span class="help">MaxMind is a fraud detections service. If you don\'t have a license key you can <a href="http://www.maxmind.com/?rId=opencart" target="_blank"><u>sign up here</u></a>. Once you have obtained a key copy and paste it into the field below.</span>';
$_['entry_fraud_key']              = 'MaxMind License Key:</span>';
$_['entry_fraud_score']            = 'MaxMind Risk Score:<br /><span class="help">The higher the score the more likly the order is fraudulent. Set a score between 0 - 100.</span>';
$_['entry_fraud_status']           = 'MaxMind Fraud Order Status:<br /><span class="help">Orders over your set score will be assigned this order status and will not be allowed to reach the complete status automatically.</span>';
$_['entry_secure']                 = 'Use SSL:<br /><span class="help">To use SSL check with your host if a SSL certificate is installed and added the SSL URL to the catalog and admin config files.</span>';
$_['entry_shared']                 = 'Use Shared Sessions:<br /><span class="help">Try to share the session cookie between stores so the cart can be passed between different domains.</span>';
$_['entry_robots']                 = 'Robots:<br /><span class="help">A list of web crawler user agents that shared sessions will not be used with. Use separate lines for each user agent.</span>';
$_['entry_seo_url']                = 'Use SEO URL\'s:<br /><span class="help">To use SEO URL\'s apache module mod-rewrite must be installed and you need to rename the htaccess.txt to .htaccess.</span>';
$_['entry_file_extension_allowed'] = 'Allowed File Extensions:<br /><span class="help">Add which file extensions are allowed to be uploaded. Use a new line for each value.</span>';
$_['entry_file_mime_allowed']      = 'Allowed File Mime Types:<br /><span class="help">Add which file mime types are allowed to be uploaded. Use a new line for each value.</span>';
$_['entry_maintenance']            = 'Maintenance Mode:<br /><span class="help">Prevents customers from browsing your store. They will instead see a maintenance message. If logged in as admin, you will see the store as normal.</span>';
$_['entry_password']               = 'Allow Forgotten Password:<br /><span class="help">Allow forgotten password to be used for the admin. This will be disabled automatically if the system detects a hack attempt.</span>';
$_['entry_encryption']             = 'Encryption Key:<br /><span class="help">Please provide a secret key that will be used to encrypt private information when processing orders.</span>';
$_['entry_compression']            = 'Output Compression Level:<br /><span class="help">GZIP for more efficient transfer to requesting clients. Compression level must be between 0 - 9</span>';
$_['entry_error_display']          = 'Display Errors:';
$_['entry_error_log']              = 'Log Errors:';
$_['entry_error_filename']         = 'Error Log Filename:';
$_['entry_google_analytics']       = 'Google Analytics Code:<br /><span class="help">Login to your <a href="http://www.google.com/analytics/" target="_blank"><u>Google Analytics</u></a> account and after creating your web site profile copy and paste the analytics code into this field.</span>';

// Error
$_['error_warning']                = 'Warning: Please check the form carefully for errors!';
$_['error_permission']             = 'Warning: You do not have permission to modify settings!';
$_['error_name']                   = 'Store Name must be between 3 and 32 characters!';
$_['error_owner']                  = 'Store Owner must be between 3 and 64 characters!';
$_['error_address']                = 'Store Address must be between 10 and 256 characters!';
$_['error_email']                  = 'E-Mail Address does not appear to be valid!';
$_['error_telephone']              = 'Telephone must be between 3 and 32 characters!';
$_['error_title']                  = 'Title must be between 3 and 32 characters!';
$_['error_limit']       	       = 'Limit required!';
$_['error_customer_group_display'] = 'You must include the default customer group if you are going to use this feature!';
$_['error_voucher_min']            = 'Minimum voucher amount required!';
$_['error_voucher_max']            = 'Maximum voucher amount required!';
$_['error_image_thumb']            = 'Product Image Thumb Size dimensions required!';
$_['error_image_popup']            = 'Product Image Popup Size dimensions required!';
$_['error_image_product']          = 'Product List Size dimensions required!';
$_['error_image_category']         = 'Category List Size dimensions required!';
$_['error_image_additional']       = 'Additional Product Image Size dimensions required!';
$_['error_image_related']          = 'Related Product Image Size dimensions required!';
$_['error_image_compare']          = 'Compare Image Size dimensions required!';
$_['error_image_wishlist']         = 'Wish List Image Size dimensions required!';
$_['error_image_cart']             = 'Cart Image Size dimensions required!';
$_['error_ftp_host']               = 'FTP Host required!';
$_['error_ftp_port']               = 'FTP Port required!';
$_['error_ftp_username']           = 'FTP Username required!';
$_['error_ftp_password']           = 'FTP Password required!';
$_['error_error_filename']         = 'Error Log Filename required!';
$_['error_encryption']             = 'Encryption must be between 3 and 32 characters!';


$_['tab_contact']					= 'Contact';
$_['entry_map']						= 'Enter Map Iframe';

?>
