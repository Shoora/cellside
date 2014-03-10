<?php 
$_['quickcheckout_settings'] = array('general' => array(
									'enable' => 1,
									'min_order' => array('value' => 0, 'text' => array(1 => 'You must have a sum more then %s to make an order ')),
									'main_checkout' => 1,
									'column_width' => array(1 => '50', 2 => '50', 3 => '0'),
									//'default_email' => $this->config->get('config_email'),
									'default_option' => 'guest',
									'custom_style' => '',
									'theme' => 'classic',
									'block_style' => 'row',
									'login_style' => 'popup',
									'debug' => 0,
									'store_id' => 0,
									'settings' => array('value' => 0, 'bulk' => ''),
									'trigger' => '#confirm_payment .button, #confirm_payment .btn, #confirm_payment .button_oc, #confirm_payment input[type=submit]'
								),
								'step' => array(
										'login' => array(
											'sort_order' => 1,
											'column' => 0,
											'row' => 0,
											'width' => '50',
											'option' => array('register' => array('title' => 'text_register',
																			 	  'description' => 'text_register_account',
																				  'display' => 1
															 				),
															   'guest' => array('title' => 'text_guest',
																			 	'description' => 'step_option_guest_desciption',
																				 'display' => 1
															 				),
															   'login' => array('display' => 1
															 				)
											)
											
										),
										'payment_address' => array(
												'sort_order' => '2',
												'column' => 1,
												'row' => 1,  
												'width' => '50',
												'fields' => array(
													'firstname' => array(
															'id' => 'firstname',
															'title' => 'entry_firstname', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 32, 
																						 'text' => 'error_firstname')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 1,
															'class' => ''
													),
													'lastname' => array(
															'id' => 'lastname',
															 'title' => 'entry_lastname', 
															 'tooltip' => '',
															 'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 32, 
																						 'text' => 'error_lastname')),
															 'type' => 'text',
															 'refresh' => '0',
															 'custom' => 0,
															 'display' => 0,
															 'require' => 0,
															 'sort_order' => 2,
															 'class' => ''
													),
													'email' => array(
															'id' => 'email',
															'title' => 'entry_email', 
															'tooltip' => '',
															
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 3,
															'class' => ''
													),
													'telephone' => array(
															'id' => 'telephone',
															'title' => 'entry_telephone', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 32, 
																						 'text' => 'error_telephone')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,

															'display' => 0,
															'require' => 0,
															'sort_order' => 4,
															'class' => ''
													),
													'fax' => array(
															'id' => 'fax',
															'title' => 'entry_fax',
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 32, 
																						 'text' => 'error_telephone')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 5,
															'class' => ''
													),
													'password' => array(
															'id' => 'password',
															'title' => 'entry_password', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 20, 
																						 'text' => 'error_password')),
															'type' => 'password',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 6,
															'class' => ''
													),
													'confirm' => array(
															'id' => 'confirm',
															'title' => 'entry_confirm',
															'tooltip' => '',
															'error' => array(0 => array('compare_to' => 'payment_address[password]',
																						 'text' => 'error_confirm'),
																			 1 => array('min_length' => '1',
																						 'text' => 'error_confirm')),
															'type' => 'password',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 7,
															'class' => ''
													),
													'heading' => array(
															'id' => 'heading',
															'title' => 'text_your_address', 
															'type' => 'heading',
															'display' => 0,
															'sort_order' => 8,
															'class' => ''
													),
													'company' => array(
															'id' => 'company',
															'title' => 'entry_company',
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 34, 
																						 'text' => 'error_step_payment_address_fields_company')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 9,
															'class' => ''
													),
													'company_id' => array(
															'id' => 'company_id',
															'title' => 'entry_company_id', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 34, 
																						 'text' => 'error_company_id')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 10,
															'class' => ''
													),
													'tax_id' => array(
															'id' => 'tax_id',
															'title' => 'entry_tax_id', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 34, 
																						 'text' => 'error_vat')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 11,
															'class' => ''
													),
													'customer_group_id' => array(
															'id' => 'customer_group_id',
															'title' => 'entry_customer_group', 
															'tooltip' => '',
															'type' => 'radio',
															'refresh' => '1',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 12,
															'class' => ''
													),
													'address_1' => array(
															'id' => 'address_1',
															'title' => 'entry_address_1', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 128, 
																						 'text' => 'error_address_1')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 13,
															'class' => ''
													),
													'address_2' => array(
															'id' => 'address_2',
															'title' => 'entry_address_2', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 128, 
																						 'text' => 'error_address_1')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 14,
															'class' => ''
													 ),
													'city' => array(
															'id' => 'city',
															'title' => 'entry_city', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 128, 
																						 'text' => 'error_city')),
															'type' => 'text',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 15,
															'class' => ''
													),
													'postcode' => array(
															'id' => 'postcode',
															'title' => 'entry_postcode', 
															'tooltip' => '',
															'error' => array(0 => array('min_length' => 2, 
																						 'max_length' => 10, 
																						 'text' => 'error_postcode')),
															'type' => 'text',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 16,
															'class' => ''
													),
													'country_id' => array(
															'id' => 'country_id',
															'title' => 'entry_country', 
															'tooltip' => '',
															'error' => array(0 => array('not_empty' => true,																		
																						 'text' => 'error_country')),
															'type' => 'select',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 17,
															'class' => ''
													),
													'zone_id' => array(
															'id' => 'zone_id',
															'title' => 'entry_zone', 
															'tooltip' => '',
															'error' => array(0 => array('not_empty' => true,																		 																		 'text' => 'error_zone')),
															'type' => 'select',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 18,
															'class' => ''
													),
													'newsletter' => array(
															'id' => 'newsletter',
															'title' => 'entry_newsletter',
															'tooltip' => '',
															'error' => array(0 => array('checked' => true,
																						 'text' => array(1 => 'You must subsribe to our newsletter to make the order'))),
															'type' => 'checkbox',
															'custom' => 0,
															'class' => '',
															'refresh' => '0',
															'display' => 0,
															'require' => 0,
															'sort_order' => 19,
															'value' => '1'
													),
													'shipping' => array(
															'id' => 'shipping',
															'title' => 'entry_shipping',
															'tooltip' => '',
															'error' => array(0 => array('checked' => true,
																						 'text' => 'error_step_payment_address_fields_shipping')),
															'type' => 'checkbox',
															'refresh' => '3',
															'custom' => 0,
															'display' => 0,
															'sort_order' => 20,
															'class' => '',
															'value' =>1,
													),
													'agree' => array(
															'id' => 'agree',
															'title' => 'text_agree', 
															//'information_id' => $this->config->get('config_account_id'),
															'tooltip' => '',
															'error' => array(0 => array('checked' => true,
																						 'text' => 'error_agree',
																		 				//'information_id' => $this->config->get('config_account_id')
																						)),
															'type' => 'checkbox',
															'refresh' => '0',
															'custom' => 0,
															'display' => 0,
															'require' => 0,
															'sort_order' => 21,
															'class' => ''
													)
													
												)
										),
										'shipping_address' => array(
												'sort_order' => '3',
												'column' => 1,
												'row' => 1,
												'width' => '30', 
												'fields' => array(
													'firstname' => array(
														'id' => 'firstname',
														'title' => 'entry_firstname', 
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 32, 
																					 'text' => 'error_firstname')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 1,
														'class' => ''
													),
													'lastname' => array(
														'id' => 'lastname',
														'title' => 'entry_lastname', 
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 32, 
																					 'text' => 'error_lastname')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 2,
														'class' => ''
													),
													'company' => array(
														'id' => 'company',
														'title' => 'entry_company',  
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 32, 
																					 'text' => 'error_step_shipping_address_fields_company')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 3,
														'class' => ''
													),
													'address_1' => array(
														'id' => 'address_1',
														'title' => 'entry_address_1', 
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 128, 
																					 'text' => 'error_address_1')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 4,
														'class' => ''
													),
													'address_2' => array(
														'id' => 'address_2',
														'title' => 'entry_address_2', 
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 128, 
																					 'text' => 'error_address_1')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 5,
														'class' => ''
													),
													'city' => array(
														'id' => 'city',
														'title' => 'entry_city',
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 3, 
																					 'max_length' => 128, 
																					 'text' => 'error_city')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 6,
														'class' => ''
													),
													'postcode' => array(
														'id' => 'postcode',
														'title' => 'entry_postcode',
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 2, 
																					'max_length' => 10, 
																					'text' => 'error_postcode')),
														'type' => 'text',
														'refresh' => '0',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 7,
														'class' => ''
													),
													'country_id' => array(
														'id' => 'country_id',
														'title' => 'entry_country', 
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 1,
																					 'text' => 'error_country')),
														'type' => 'select',
														'refresh' => '4',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 8,
														'class' => ''
													),
													'zone_id' => array(
														'id' => 'zone_id',
														'title' => 'entry_zone',
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 1,
																				 'text' => 'error_zone')),
														'type' => 'select',
														'refresh' => '4',
														'custom' => 0,
														'display' => 0,
														'require' => 0,
														'sort_order' => 9,
														'class' => ''
													)
												)
										),
										'shipping_method' => array(
											'sort_order' => 4,
											'column' => 2,
											'row' => 1,
											'display' => 1,
										    'input_style' => 'radio',
										    'display_title' => 1,
									  	    'display_desciption' => 1,
									        'display_options' => 1,
											'width' => '30'
											
										),
										'payment_method' =>array(
											'sort_order' => 5,
											'column' => 2,
											'row' => 1,
											'display' => 1,
										    'display_options' => 1,
											'display_images' => 1,
										    'input_style' => 'radio',
										    'display_logos' => 1,
											'width' => '30'
											
										),
										'cart' => array(
											'sort_order' => 6,
											'column' => 2,
											'row' => 2,
											'width' => '50',											
											'option' => array(
														'voucher' => array(
																	'id' => 'voucher',
																	'title' => array(1 => 'voucher'),
																	'tooltip' => array(1 => 'voucher'),
																	'type' => 'text',
																	'refresh' => '3',
																	'custom' => 0,
																	'class' => ''
														),
														'coupon' => array(
																	'id' => 'coupon',
																	'title' => array(1 => 'coupon'),
																	'tooltip' => array(1 => 'coupon'),
																	'type' => 'text',
																	'refresh' => '3',
																	'custom' => 0,
																	'class' => ''
														),
														'reward' => array(
																	'id' => 'reward',
																	'title' => array(1 => 'reward'),
																	'tooltip' => array(1 => 'reward'),
																	'type' => 'text',
																	'refresh' => '3',
																	'custom' => 0,
																	'class' => ''
														)
											),
										),
										'confirm' => array(
											'sort_order' => 7,
											'column' => 2,
											'row' => 2,
											'width' => '50',
											'fields' => array(
												'comment' => array(
														'id' => 'comment',
														'title' => 'text_comments',
														'tooltip' => '',
														'error' => array(0 => array('min_length' => 1,
																				 'text' => 'error_step_confirm_fields_comment')),
														'type' => 'textarea',
														'refresh' => '6',
														'custom' => 0,
														'class' => ''
												),
												'agree' => array(
														'id' => 'agree',
														'title' => 'text_agree',
														//'information_id' => $this->config->get('config_checkout_id'),
														'tooltip' => '',
														'error' => array(0 => array('checked' => true,
																				 'text' => 'error_agree',
																		 		  //'information_id' => $this->config->get('config_checkout_id')
																				  )),
														'type' => 'checkbox',
														'refresh' => '0',
														'value' => 0, 
														'custom' => 0,
														'class' => ''
												)
												
												
											)
										)
								),
								'option' => array(
									'register' => array(
										'display' => 1,
										'login' => array(),
										'payment_address' => array(
											'display' => 1,
											'title' => 'text_your_details',
											'description' => 'option_register_payment_address_description',
											'fields' => array(
												'firstname' => array('display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 1, 
																	 'require' => 1														
																	 ), 
												'email' => array(	 'display' => 1, 
																	 'require' => 1,
																	 'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 96, 
																						 'text' => array(1 => 'Sorry, but you need to have the length of the text more then 3 and less then 96 ')),
																			  1 => array('regex' => '/^[^\@]+@.*\.[a-z]{2,6}$/i', 
																						 'text' => 'error_email'),
																			  2 => array('email_exists' => true, 
																						 'text' => 'error_exists'),
																			  3 => array('not_empty' => true, 
																						 'text' => 'error_email')),
																	 ),
												'heading' => array(
																	 'display' => 1,														
																	 ),
												'telephone' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'fax' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'password' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'confirm' => array(
																     'display' => 1, 
																	 'require' => 1
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'company_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'customer_group_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'tax_id' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'newsletter' => array( 
																	 'display' => 1, 
																	 'require' => 0,
																	 'value' => '0'
																	 ),
												'shipping' => array( 
																	 'display' => 1,
																	 'value' => '0'
																	 ),
												'agree' => array( 
																	 'display' => 1, 
																	 'require' => 0,
																	 'value' => '0'
																	 )
												
											)
										),
										'shipping_address' => array(
											'display' => 1,
											'title' => 'option_register_shipping_address_title',
											'description' => 'option_register_shipping_address_description',
											'fields' => array(
												'firstname' => array( 
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array( 
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 )
												)
										),
										'shipping_method' => array(
												  'title' => 'option_register_shipping_method_title',
												  'description' => 'text_shipping_method',												  
												  ),
										'payment_method' =>array(
												  'title' => 'option_register_payment_method_title',
												  'description' => 'text_payment_method',
												  ),
										'cart' => array(
												  'display' => 1,
												  'option' => array(
														'voucher' => array(
																	'display' => 1
														),
														'coupon' => array(
																	'display' => 1
														),
														'reward' => array(
																	'display' => 1
														)
													),
												  'columns' => array(
														 'image' => 1,
														 'name' => 1,
														 'model' => 0,
														 'quantity' => 1,
														 'price' => 1,
														 'total' => 1
															)
										),										
										'confirm' => array(
												  'display' => 1,
												  'fields' => array(
												  		'comment' => array( 
															 'display' => 1, 
															 'require' => 0
														 ),
														'agree' => array( 
															 'display' => 1, 
															 'require' => 1
														 )
												  )	   
										)
									),
									'guest' => array(
										'display' => 1,
										'login' => array(),
										'payment_address' => array(
											'title' => 'text_your_details',
											'description' => 'option_guest_payment_address_description',
											'display' => 1,
											'fields' => array(
												'firstname' => array('display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 1, 
																	 'require' => 1														
																	 ), 
												'email' => array(	 'display' => 1, 
																	 'require' => 1,
																	 'error' => array(0 => array('min_length' => 3, 
																						 'max_length' => 96, 
																						 'text' => array(1 => 'Sorry, but you need to have the length of the text more then 3 and less then 96 ')),
																			  1 => array('regex' => '/^[^\@]+@.*\.[a-z]{2,6}$/i', 
																						 'text' => 'error_email'),
																			  2 => array('not_empty' => true, 
																						 'text' => 'error_email')),
																	 ),
												'heading' => array(
																	 'display' => 1														
																	 ),
												'telephone' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'fax' => array(
																	 'display' => 1, 
																	 'require' => 0	
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'company_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'customer_group_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'tax_id' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'shipping' => array( 
																	 'display' => 1,
																	 'value' => '0'
																	 ),
												'agree' => array( 
																	 'display' => 1, 
																	 'require' => 0,
																	 'value' => '0'
																	 )
											)
										),
										'shipping_address' => array(
											'display' => 1,
											'title' => 'option_guest_shipping_address_title',
											'description' => 'option_guest_shipping_address_description',
											'fields' => array(
												'firstname' => array( 
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array( 
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 )
												)
										),
										'shipping_method' =>array(
												  'title' => 'option_guest_shipping_method_title',
												  'description' => 'text_shipping_method',
												  
												  
										),
										'payment_method' =>array(
												  'title' => 'option_guest_payment_method_title',
												  'description' => 'text_payment_method',
										),
										'cart' => array(
												  'display' => 1,
												  'option' => array(
														'voucher' => array(
																	'display' => 1
														),
														'coupon' => array(
																	'display' => 1
														),
														'reward' => array(
																	'display' => 1
														)
													),
												  'columns' => array(
														 'image' => 1,
														 'name' => 1,
														 'model' => 0,
														 'quantity' => 1,
														 'price' => 1,
														 'total' => 1
															)
										),										
										'confirm' => array(
												  'display' => 1,
												  'fields' => array(
												  		'comment' => array( 
															 'display' => 1, 
															 'require' => 0
														 ),
														'agree' => array( 
															 'display' => 1, 
															 'require' => 1
														 )
												  )	   
										)
									),
									'logged'=> array(
										'login' => array(),
										'payment_address' => array(
											'display' => 1,
											'title' => 'option_logged_payment_address_title',
											'description' => 'option_logged_payment_address_description',
											'fields' => array(
												'firstname' => array('display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 1, 
																	 'require' => 1															
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'company_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'customer_group_id' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'tax_id' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_id' => array()
											)
										),
										'shipping_address' => array(
											'display' => 1,
											'title' => 'option_logged_shipping_address_title',
											'description' => 'option_logged_shipping_address_description',
											'fields' => array(
												'firstname' => array( 
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'lastname' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'company' => array(
																	 'display' => 1, 
																	 'require' => 0
																	 ),
												'address_1' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'address_2' => array(
																	 'display' => 0, 
																	 'require' => 0
																	 ),
												'city' => array( 
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'postcode' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'country_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 ),
												'zone_id' => array(
																	 'display' => 1, 
																	 'require' => 1
																	 )
												)
										),
										'shipping_method' =>array(
												  'title' => 'option_logged_shipping_method_title',
												  'description' => 'text_shipping_method',
										),
										'payment_method' =>array(
												  'title' => 'option_logged_payment_method_title',
												  'description' => 'text_payment_method',
										),
										'cart' => array(
												  'display' => 1,
												  'option' => array(
														'voucher' => array(
																	'display' => 1
														),
														'coupon' => array(
																	'display' => 1
														),
														'reward' => array(
																	'display' => 1
														)
													),
												  'columns' => array(
														 'image' => 1,
														 'name' => 1,
														 'model' => 0,
														 'quantity' => 1,
														 'price' => 1,
														 'total' => 1
															)
										),										
										'confirm' => array(
												  'display' => 1,
												  'fields' => array(
												  		'comment' => array( 
															 'display' => 1, 
															 'require' => 0
														 ),
														'agree' => array( 
															 'display' => 1, 
															 'require' => 1
														 )
												  )	   
										)
									)
								)
							);
$cfg = $_;
?>