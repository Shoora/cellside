<?php
class ModelCheckoutOrder extends Model {	
	public function addOrder($data) {
		$this->db->query("INSERT INTO `" . DB_PREFIX . "order` SET invoice_prefix = '" . $this->db->escape($data['invoice_prefix']) . "', store_id = '" . (int)$data['store_id'] . "', store_name = '" . $this->db->escape($data['store_name']) . "', store_url = '" . $this->db->escape($data['store_url']) . "', customer_id = '" . (int)$data['customer_id'] . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', payment_firstname = '" . $this->db->escape($data['payment_firstname']) . "', payment_lastname = '" . $this->db->escape($data['payment_lastname']) . "', payment_company = '" . $this->db->escape($data['payment_company']) . "', payment_company_id = '" . $this->db->escape($data['payment_company_id']) . "', payment_tax_id = '" . $this->db->escape($data['payment_tax_id']) . "', payment_address_1 = '" . $this->db->escape($data['payment_address_1']) . "', payment_address_2 = '" . $this->db->escape($data['payment_address_2']) . "', payment_city = '" . $this->db->escape($data['payment_city']) . "', payment_postcode = '" . $this->db->escape($data['payment_postcode']) . "', payment_country = '" . $this->db->escape($data['payment_country']) . "', payment_country_id = '" . (int)$data['payment_country_id'] . "', payment_zone = '" . $this->db->escape($data['payment_zone']) . "', payment_zone_id = '" . (int)$data['payment_zone_id'] . "', payment_address_format = '" . $this->db->escape($data['payment_address_format']) . "', payment_method = '" . $this->db->escape($data['payment_method']) . "', payment_code = '" . $this->db->escape($data['payment_code']) . "', shipping_firstname = '" . $this->db->escape($data['shipping_firstname']) . "', shipping_lastname = '" . $this->db->escape($data['shipping_lastname']) . "', shipping_company = '" . $this->db->escape($data['shipping_company']) . "', shipping_address_1 = '" . $this->db->escape($data['shipping_address_1']) . "', shipping_address_2 = '" . $this->db->escape($data['shipping_address_2']) . "', shipping_city = '" . $this->db->escape($data['shipping_city']) . "', shipping_postcode = '" . $this->db->escape($data['shipping_postcode']) . "', shipping_country = '" . $this->db->escape($data['shipping_country']) . "', shipping_country_id = '" . (int)$data['shipping_country_id'] . "', shipping_zone = '" . $this->db->escape($data['shipping_zone']) . "', shipping_zone_id = '" . (int)$data['shipping_zone_id'] . "', shipping_address_format = '" . $this->db->escape($data['shipping_address_format']) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "', shipping_code = '" . $this->db->escape($data['shipping_code']) . "', comment = '" . $this->db->escape($data['comment']) . "', total = '" . (float)$data['total'] . "', affiliate_id = '" . (int)$data['affiliate_id'] . "', commission = '" . (float)$data['commission'] . "', language_id = '" . (int)$data['language_id'] . "', currency_id = '" . (int)$data['currency_id'] . "', currency_code = '" . $this->db->escape($data['currency_code']) . "', currency_value = '" . (float)$data['currency_value'] . "', ip = '" . $this->db->escape($data['ip']) . "', forwarded_ip = '" .  $this->db->escape($data['forwarded_ip']) . "', user_agent = '" . $this->db->escape($data['user_agent']) . "', accept_language = '" . $this->db->escape($data['accept_language']) . "', date_added = NOW(), date_modified = NOW()");

		$order_id = $this->db->getLastId();

		foreach ($data['products'] as $product) { 
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '" . (float)$product['tax'] . "', reward = '" . (int)$product['reward'] . "'");
 
			$order_product_id = $this->db->getLastId();

			foreach ($product['option'] as $option) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
			}
				
			foreach ($product['download'] as $download) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_download SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', name = '" . $this->db->escape($download['name']) . "', filename = '" . $this->db->escape($download['filename']) . "', mask = '" . $this->db->escape($download['mask']) . "', remaining = '" . (int)($download['remaining'] * $product['quantity']) . "'");
			}	
		}
		
		foreach ($data['vouchers'] as $voucher) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");
		}
			
		foreach ($data['totals'] as $total) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = '" . $this->db->escape($total['code']) . "', title = '" . $this->db->escape($total['title']) . "', text = '" . $this->db->escape($total['text']) . "', `value` = '" . (float)$total['value'] . "', sort_order = '" . (int)$total['sort_order'] . "'");
		}	

		return $order_id;
	}

	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT *, (SELECT os.name FROM `" . DB_PREFIX . "order_status` os WHERE os.order_status_id = o.order_status_id AND os.language_id = o.language_id) AS order_status FROM `" . DB_PREFIX . "order` o WHERE o.order_id = '" . (int)$order_id . "'");
			
		if ($order_query->num_rows) {
			$country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$order_query->row['payment_country_id'] . "'");
			
			if ($country_query->num_rows) {
				$payment_iso_code_2 = $country_query->row['iso_code_2'];
				$payment_iso_code_3 = $country_query->row['iso_code_3'];
			} else {
				$payment_iso_code_2 = '';
				$payment_iso_code_3 = '';				
			}
			
			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['payment_zone_id'] . "'");
			
			if ($zone_query->num_rows) {
				$payment_zone_code = $zone_query->row['code'];
			} else {
				$payment_zone_code = '';
			}			
			
			$country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$order_query->row['shipping_country_id'] . "'");
			
			if ($country_query->num_rows) {
				$shipping_iso_code_2 = $country_query->row['iso_code_2'];
				$shipping_iso_code_3 = $country_query->row['iso_code_3'];
			} else {
				$shipping_iso_code_2 = '';
				$shipping_iso_code_3 = '';				
			}
			
			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['shipping_zone_id'] . "'");
			
			if ($zone_query->num_rows) {
				$shipping_zone_code = $zone_query->row['code'];
			} else {
				$shipping_zone_code = '';
			}
			
			$this->load->model('localisation/language');
			
			$language_info = $this->model_localisation_language->getLanguage($order_query->row['language_id']);
			
			if ($language_info) {
				$language_code = $language_info['code'];
				$language_filename = $language_info['filename'];
				$language_directory = $language_info['directory'];
			} else {
				$language_code = '';
				$language_filename = '';
				$language_directory = '';
			}
		 			
			return array(
				'order_id'                => $order_query->row['order_id'],
				'invoice_no'              => $order_query->row['invoice_no'],
				'invoice_prefix'          => $order_query->row['invoice_prefix'],
				'store_id'                => $order_query->row['store_id'],
'store_address'           => nl2br($this->config->get('config_address')),

				'store_telephone'         => $this->config->get('config_telephone'),

				'store_fax'               => $this->config->get('config_fax'),

                'store_email'             => $this->config->get('config_email'),

				'store_logo'              => $this->config->get('config_logo'),
				
				'store_name'              => $order_query->row['store_name'],
				'store_url'               => $order_query->row['store_url'],				
				'customer_id'             => $order_query->row['customer_id'],
				'firstname'               => $order_query->row['firstname'],
				'lastname'                => $order_query->row['lastname'],
				'telephone'               => $order_query->row['telephone'],
				'fax'                     => $order_query->row['fax'],
				'email'                   => $order_query->row['email'],
				'payment_firstname'       => $order_query->row['payment_firstname'],
				'payment_lastname'        => $order_query->row['payment_lastname'],				
				'payment_company'         => $order_query->row['payment_company'],
				'payment_company_id'      => $order_query->row['payment_company_id'],
				'payment_tax_id'          => $order_query->row['payment_tax_id'],
				'payment_address_1'       => $order_query->row['payment_address_1'],
				'payment_address_2'       => $order_query->row['payment_address_2'],
				'payment_postcode'        => $order_query->row['payment_postcode'],
				'payment_city'            => $order_query->row['payment_city'],
				'payment_zone_id'         => $order_query->row['payment_zone_id'],
				'payment_zone'            => $order_query->row['payment_zone'],
				'payment_zone_code'       => $payment_zone_code,
				'payment_country_id'      => $order_query->row['payment_country_id'],
				'payment_country'         => $order_query->row['payment_country'],	
				'payment_iso_code_2'      => $payment_iso_code_2,
				'payment_iso_code_3'      => $payment_iso_code_3,
				'payment_address_format'  => $order_query->row['payment_address_format'],
				'payment_method'          => $order_query->row['payment_method'],
				'payment_code'            => $order_query->row['payment_code'],
				'shipping_firstname'      => $order_query->row['shipping_firstname'],
				'shipping_lastname'       => $order_query->row['shipping_lastname'],				
				'shipping_company'        => $order_query->row['shipping_company'],
				'shipping_address_1'      => $order_query->row['shipping_address_1'],
				'shipping_address_2'      => $order_query->row['shipping_address_2'],
				'shipping_postcode'       => $order_query->row['shipping_postcode'],
				'shipping_city'           => $order_query->row['shipping_city'],
				'shipping_zone_id'        => $order_query->row['shipping_zone_id'],
				'shipping_zone'           => $order_query->row['shipping_zone'],
				'shipping_zone_code'      => $shipping_zone_code,
				'shipping_country_id'     => $order_query->row['shipping_country_id'],
				'shipping_country'        => $order_query->row['shipping_country'],	
				'shipping_iso_code_2'     => $shipping_iso_code_2,
				'shipping_iso_code_3'     => $shipping_iso_code_3,
				'shipping_address_format' => $order_query->row['shipping_address_format'],
				'shipping_method'         => $order_query->row['shipping_method'],
				'shipping_code'           => $order_query->row['shipping_code'],
				'comment'                 => $order_query->row['comment'],
				'total'                   => $order_query->row['total'],
				'order_status_id'         => $order_query->row['order_status_id'],
				'order_status'            => $order_query->row['order_status'],
				'language_id'             => $order_query->row['language_id'],
				'language_code'           => $language_code,
				'language_filename'       => $language_filename,
				'language_directory'      => $language_directory,
				'currency_id'             => $order_query->row['currency_id'],
				'currency_code'           => $order_query->row['currency_code'],
				'currency_value'          => $order_query->row['currency_value'],
// template email - start
			'customer_group_id'              => $order_query->row['customer_group_id'],
			'affiliate_id'                   => $order_query->row['affiliate_id'],
			'commission'                     => $order_query->row['commission'],
			// template email - stop
				'ip'                      => $order_query->row['ip'],
				'forwarded_ip'            => $order_query->row['forwarded_ip'], 
				'user_agent'              => $order_query->row['user_agent'],	
				'accept_language'         => $order_query->row['accept_language'],				
				'date_modified'           => $order_query->row['date_modified'],
				'date_added'              => $order_query->row['date_added']
			);
		} else {
			return false;	
		}
	}	

	public function confirm($order_id, $order_status_id, $comment = '', $notify = false) {
		$order_info = $this->getOrder($order_id);
		 
		if ($order_info && !$order_info['order_status_id']) {
			// Fraud Detection
			if ($this->config->get('config_fraud_detection')) {
				$this->load->model('checkout/fraud');
				
				$risk_score = $this->model_checkout_fraud->getFraudScore($order_info);
				
				if ($risk_score > $this->config->get('config_fraud_score')) {
					$order_status_id = $this->config->get('config_fraud_status_id');
				}
			}

			// Ban IP
			$status = false;
			
			$this->load->model('account/customer');
			
			if ($order_info['customer_id']) {
				$results = $this->model_account_customer->getIps($order_info['customer_id']);
				
				foreach ($results as $result) {
					if ($this->model_account_customer->isBanIp($result['ip'])) {
						$status = true;
						
						break;
					}
				}
			} else {
				$status = $this->model_account_customer->isBanIp($order_info['ip']);
			}
			
			if ($status) {
				$order_status_id = $this->config->get('config_order_status_id');
			}		
				
			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$order_status_id . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

				$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

				$this->language->load('multiseller/multiseller');
				if (in_array($order_status_id, $this->config->get('msconf_credit_order_statuses'))) {
					$sendmail = false;
					foreach ($order_product_query->rows as $order_product) {
						$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
						if (!$seller_id) continue;
						
						// check adaptive payments
						$payment = $this->MsLoader->MsPayment->getPayments(array(
							'order_id' => $order_id,
							'seller_id' => $seller_id,
							'payment_type' => array(MsPayment::TYPE_SALE),
							'payment_status' => array(MsPayment::STATUS_PAID),
							'single' => 1
						));
						
						if ($payment) {
							$sendmail = true;
							continue;
						}
						
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
						
						if (!$balance_entry) {
							// don't calculate fees for free products
							if ($order_product['total'] > 0) {
								$commissions = $this->MsLoader->MsCommission->calculateCommission(array('seller_id' => $seller_id));
								$store_commission_flat = $commissions[MsCommission::RATE_SALE]['flat'];
								$store_commission_pct = $order_product['total'] * $commissions[MsCommission::RATE_SALE]['percent'] / 100;
								$seller_net_amt = $order_product['total'] - ($store_commission_flat + $store_commission_pct);
							} else {
								$store_commission_flat = $store_commission_pct = $seller_net_amt = 0;
							}
							
							$this->MsLoader->MsOrderData->addOrderProductData(
								$order_product['order_id'],
								$order_product['product_id'],								
								array(
									'seller_id' => $seller_id,
				             		'store_commission_flat' => $store_commission_flat,
				             		'store_commission_pct' => $store_commission_pct,
				             		'seller_net_amt' => $seller_net_amt									
								)
							);
							
							$this->MsLoader->MsBalance->addBalanceEntry(
								$seller_id,
								array(
									'order_id' => $order_product['order_id'],
									'product_id' => $order_product['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE,
									'amount' => $seller_net_amt,
									'description' => sprintf($this->language->get('ms_transaction_sale'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'], $this->currency->format($store_commission_flat + $store_commission_pct, $this->config->get('config_currency')))
								)
							);
							$sendmail = true;
						} else {
							// send order status change mails
						}
					}
					if ($sendmail) $this->MsLoader->MsMail->sendOrderMails($order_id);
				} else if (in_array($order_status_id, $this->config->get('msconf_debit_order_statuses'))) {
				$sendmail = false;
				foreach ($order_product_query->rows as $order_product) {
					$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
					if (!$seller_id) continue;				
					$refund_balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
						array(
							'seller_id' => $seller_id,
							'product_id' => $order_product['product_id'],
							'order_id' => $order_id,
							'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND
						)
					);
					
					if (!$refund_balance_entry) {
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
				
						if ($balance_entry) {
							$this->MsLoader->MsBalance->addBalanceEntry(
								$balance_entry['seller_id'],
								array(
									'order_id' => $balance_entry['order_id'],
									'product_id' => $balance_entry['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND,
									'amount' => -1 * $balance_entry['amount'],
									'description' => sprintf($this->language->get('ms_transaction_refund'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'])
								)
							);
							
							// todo send refund mails
							// $this->MsLoader->MsMail->sendOrderMails($order_id);
						} else {
							// send order status change mails
						}
						
					}
				}
				}
			
			

			$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', notify = '1', comment = '" . $this->db->escape(($comment && $notify) ? $comment : '') . "', date_added = NOW()");
// template email - start
			$order_info['order_history_id'] = $this->db->getLastId();
			// template email - stop

			$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

				$this->language->load('multiseller/multiseller');
				if (in_array($order_status_id, $this->config->get('msconf_credit_order_statuses'))) {
					$sendmail = false;
					foreach ($order_product_query->rows as $order_product) {
						$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
						if (!$seller_id) continue;
						
						// check adaptive payments
						$payment = $this->MsLoader->MsPayment->getPayments(array(
							'order_id' => $order_id,
							'seller_id' => $seller_id,
							'payment_type' => array(MsPayment::TYPE_SALE),
							'payment_status' => array(MsPayment::STATUS_PAID),
							'single' => 1
						));
						
						if ($payment) {
							$sendmail = true;
							continue;
						}
						
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
						
						if (!$balance_entry) {
							// don't calculate fees for free products
							if ($order_product['total'] > 0) {
								$commissions = $this->MsLoader->MsCommission->calculateCommission(array('seller_id' => $seller_id));
								$store_commission_flat = $commissions[MsCommission::RATE_SALE]['flat'];
								$store_commission_pct = $order_product['total'] * $commissions[MsCommission::RATE_SALE]['percent'] / 100;
								$seller_net_amt = $order_product['total'] - ($store_commission_flat + $store_commission_pct);
							} else {
								$store_commission_flat = $store_commission_pct = $seller_net_amt = 0;
							}
							
							$this->MsLoader->MsOrderData->addOrderProductData(
								$order_product['order_id'],
								$order_product['product_id'],								
								array(
									'seller_id' => $seller_id,
				             		'store_commission_flat' => $store_commission_flat,
				             		'store_commission_pct' => $store_commission_pct,
				             		'seller_net_amt' => $seller_net_amt									
								)
							);
							
							$this->MsLoader->MsBalance->addBalanceEntry(
								$seller_id,
								array(
									'order_id' => $order_product['order_id'],
									'product_id' => $order_product['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE,
									'amount' => $seller_net_amt,
									'description' => sprintf($this->language->get('ms_transaction_sale'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'], $this->currency->format($store_commission_flat + $store_commission_pct, $this->config->get('config_currency')))
								)
							);
							$sendmail = true;
						} else {
							// send order status change mails
						}
					}
					if ($sendmail) $this->MsLoader->MsMail->sendOrderMails($order_id);
				} else if (in_array($order_status_id, $this->config->get('msconf_debit_order_statuses'))) {
				$sendmail = false;
				foreach ($order_product_query->rows as $order_product) {
					$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
					if (!$seller_id) continue;				
					$refund_balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
						array(
							'seller_id' => $seller_id,
							'product_id' => $order_product['product_id'],
							'order_id' => $order_id,
							'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND
						)
					);
					
					if (!$refund_balance_entry) {
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
				
						if ($balance_entry) {
							$this->MsLoader->MsBalance->addBalanceEntry(
								$balance_entry['seller_id'],
								array(
									'order_id' => $balance_entry['order_id'],
									'product_id' => $balance_entry['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND,
									'amount' => -1 * $balance_entry['amount'],
									'description' => sprintf($this->language->get('ms_transaction_refund'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'])
								)
							);
							
							// todo send refund mails
							// $this->MsLoader->MsMail->sendOrderMails($order_id);
						} else {
							// send order status change mails
						}
						
					}
				}
				}
			
			
			foreach ($order_product_query->rows as $order_product) {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_id = '" . (int)$order_product['product_id'] . "' AND subtract = '1'");

				if ($this->config->get('msconf_disable_product_after_quantity_depleted')) {
					$res = $this->db->query("SELECT quantity FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$order_product['product_id'] . "'");
					if ((int)$res->row['quantity'] <= 0) {
						$this->MsLoader->MsProduct->changeStatus((int)$order_product['product_id'], MsProduct::STATUS_DISABLED);
						$this->MsLoader->MsProduct->disapprove((int)$order_product['product_id']);
					}
				}
			

				$this->db->query("UPDATE " . DB_PREFIX . "ms_product SET number_sold  = (number_sold + " . (int)$order_product['quantity'] . ") WHERE product_id = '" . (int)$order_product['product_id'] . "'");
			
				
				$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product['order_product_id'] . "'");
			
				
				if (!isset($this->session->data['pcpb']))
					$this->session->data['pcpb'] = array();
				$option_custome_id = 0;		
				if (isset($this->session->data['pcpb'][$order_product['product_id']]))
				{
					$this->load->model('pcpb/pcpb');
					$optionPCPB = $this->model_pcpb_pcpb->getProductOptions($order_product['product_id']);

					$optionNameID = $this->config->get('pcpb_option_save_url');
					foreach($optionPCPB as $option){
						if($option['option_id'] == $optionNameID){
							$option_custome_id = $option['product_option_id'];
							break;
						}
					}
					
				}
				foreach ($order_option_query->rows as $option) {
					if ($option_custome_id == $option['product_option_id'])
					{
						$token = $this->session->data['pcpb'][$order_product['product_id']]['token'];
						// lay oldPath tu db len
						$data = $this->model_pcpb_pcpb->getDataByToken($token);
						$content = $data['content'];
						$path_parts = pathinfo($content);
						$fileName = $path_parts['filename'];
						$ext = $path_parts['extension'];
						//move file
						$saveDir = $this->config->get('pcpb_path_folder_save_permanently');
						if(!$saveDir || $saveDir == '' || !is_writable(DIR_IMAGE . $saveDir))
							$saveDir = 'pcpb/view/';

						$tempDir = $this->config->get('pcpb_path_folder_save_temprarily');
						if(!$tempDir || $tempDir == '' || !is_writable(DIR_IMAGE . $tempDir))
							$tempDir = 'pcpb/temp/';
						
						$newPath = DIR_IMAGE . $saveDir . $fileName . '.' . $ext; 
						$oldPath =  DIR_IMAGE . $tempDir . $fileName . '.' . $ext; 
												
						rename($oldPath, $newPath);

						$newPath = HTTP_SERVER . 'image/' . $saveDir . $fileName . '.' . $ext; 

						//insert xuong db
						$this->model_pcpb_pcpb->updateImage($token, $newPath);
					}
			
					$this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_option_value_id = '" . (int)$option['product_option_value_id'] . "' AND subtract = '1'");
				}
			}

            if(!isset($passArray) || empty($passArray)){ $passArray = null; }
            $this->openbay->orderNew((int)$order_id);
			
			$this->cache->delete('product');

				if (isset($this->session->data['pcpb']))
					unset($this->session->data['pcpb']);
			
			
			// Downloads
			$order_download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_download WHERE order_id = '" . (int)$order_id . "'");
			
			// Gift Voucher
			$this->load->model('checkout/voucher');
			
			$order_voucher_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");
			
			foreach ($order_voucher_query->rows as $order_voucher) {
				$voucher_id = $this->model_checkout_voucher->addVoucher($order_id, $order_voucher);
				
				$this->db->query("UPDATE " . DB_PREFIX . "order_voucher SET voucher_id = '" . (int)$voucher_id . "' WHERE order_voucher_id = '" . (int)$order_voucher['order_voucher_id'] . "'");
			}			
			
			// Send out any gift voucher mails
			if ($this->config->get('config_complete_status_id') == $order_status_id) {
				$this->model_checkout_voucher->confirm($order_id);
			}
					
			// Order Totals			
			$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");
			
			foreach ($order_total_query->rows as $order_total) {
				$this->load->model('total/' . $order_total['code']);
				
				if (method_exists($this->{'model_total_' . $order_total['code']}, 'confirm')) {
					$this->{'model_total_' . $order_total['code']}->confirm($order_info, $order_total);
				}
			}
			
			// Send out order confirmation mail
			$language = new Language($order_info['language_directory']);
			$language->load($order_info['language_filename']);
			$language->load('mail/order');
		 
			$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
			
			if ($order_status_query->num_rows) {
				$order_status = $order_status_query->row['name'];	
			} else {
				$order_status = '';
			}
// template email - start
			$this->load->model('catalog/template_email');

			$result = $this->model_catalog_template_email->getTemplateEmail($order_status_id);
			
			if ((sizeof($result['description']) > 0) && ($result['status'] == '0' || $result['status'] == '')) {
				$this->model_catalog_template_email->sendDefaultStatusTemplateEmail($order_info, $order_status_id, $result, $comment);
			} else {
			// template email - stop
			
			$subject = sprintf($language->get('text_new_subject'), $order_info['store_name'], $order_id);
		
			// HTML Mail
			$template = new Template();
$this->load->model('tool/image');
			
			$template->data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);
			
			$template->data['text_greeting'] = sprintf($language->get('text_new_greeting'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'));
			$template->data['text_link'] = $language->get('text_new_link');
			$template->data['text_download'] = $language->get('text_new_download');
			$template->data['text_order_detail'] = $language->get('text_new_order_detail');
			$template->data['text_instruction'] = $language->get('text_new_instruction');
			$template->data['text_order_id'] = $language->get('text_new_order_id');
			$template->data['text_date_added'] = $language->get('text_new_date_added');
			$template->data['text_payment_method'] = $language->get('text_new_payment_method');	
			$template->data['text_shipping_method'] = $language->get('text_new_shipping_method');
			$template->data['text_email'] = $language->get('text_new_email');
			$template->data['text_telephone'] = $language->get('text_new_telephone');
			$template->data['text_ip'] = $language->get('text_new_ip');
			$template->data['text_payment_address'] = $language->get('text_new_payment_address');
			$template->data['text_shipping_address'] = $language->get('text_new_shipping_address');
			$template->data['text_product'] = $language->get('text_new_product');
			$template->data['text_model'] = $language->get('text_new_model');
			$template->data['text_quantity'] = $language->get('text_new_quantity');
			$template->data['text_price'] = $language->get('text_new_price');
			$template->data['text_total'] = $language->get('text_new_total');
$template->data['text_update_comment'] = $language->get('text_update_comment');
			$template->data['text_footer'] = $language->get('text_new_footer');
			$template->data['text_powered'] = $language->get('text_new_powered');
			
			$template->data['logo'] = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');		
			$template->data['store_name'] = $order_info['store_name'];
			$template->data['store_url'] = $order_info['store_url'];
			$template->data['customer_id'] = $order_info['customer_id'];
			$template->data['link'] = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id;
			
			if ($order_download_query->num_rows) {
				$template->data['download'] = $order_info['store_url'] . 'index.php?route=account/download';
			} else {
				$template->data['download'] = '';
			}
			
			$template->data['order_id'] = $order_id;
			$template->data['date_added'] = date($language->get('date_format_short'), strtotime($order_info['date_added']));    	
$template->data['store_address'] = $order_info['store_address'];

			$template->data['store_telephone'] = $order_info['store_telephone'];

			$template->data['store_logo'] = $order_info['store_logo'];

			$template->data['store_email'] = $order_info['store_email'];

			$template->data['store_fax'] = $order_info['store_fax'];

			$template->data['text_invoice_no'] = $language->get('text_invoice_no');

			$template->data['text_fax'] = $language->get('text_fax');

			$template->data['text_invoice'] = $language->get('text_invoice');

			$template->data['text_company_id'] = $language->get('text_company_id');

			$template->data['text_tax_id'] = $language->get('text_tax_id');

			$template->data['order_comment'] = $order_info['comment'];

			$template->data['orderlogo'] = $this->config->get('config_url') . 'image/data/' . 'order.png';

			$template->data['stocklogo'] = $this->config->get('config_url') . 'image/data/' . 'stock.png';

			$template->data['zerostock'] = $this->config->get('zerostock');

			$template->data['zeroostock'] = $this->config->get('zeroostock');

			$confirm_email = $this->config->get('confirm_email');

			$confirm_email2 = $this->config->get('confirm_email2');

			$confirm_email3 = $this->config->get('confirm_email3');

			$confirm_email4 = $this->config->get('confirm_email4');
			
			$enablestockz = $this->config->get('enablestockz');
			
			$invnameav2 = $this->config->get('invnameav2');
			$template->data['invnameav2'] = $this->config->get('invnameav2');
			$template->data['invname2c2'] = $this->config->get('invname2c2');
			$template->data['custfoot221'] = $this->config->get('custfoot221');
			$template->data['custfoot2'] = $this->config->get('custfoot2');
			$template->data['invpicav2'] = $this->config->get('invpicav2');
			$template->data['inv_skuca2'] = $this->config->get('inv_skuca2');
			
			$template->data['logo2'] = DIR_IMAGE . $this->config->get('config_logo');
			
			
            $template->data['dirimage'] = DIR_IMAGE ; 
			

			$template->data['text_update_comment'] = $language->get('text_update_comment');
			$template->data['payment_method'] = $order_info['payment_method'];
			$template->data['shipping_method'] = $order_info['shipping_method'];
			$template->data['email'] = $order_info['email'];
			$template->data['telephone'] = $order_info['telephone'];
			$template->data['ip'] = $order_info['ip'];

$template->data['autotime'] = $this->config->get('autotime');
$template->data['auto_width'] = $this->config->get('auto_width');
$template->data['auto_tfont'] = $this->config->get('auto_tfont');
$template->data['auto_bfont'] = $this->config->get('auto_bfont');
$template->data['auto_cfont'] = $this->config->get('auto_cfont');
$template->data['auto_margin'] = $this->config->get('auto_margin');
$template->data['auto_flogo'] = $this->config->get('auto_flogo');
$template->data['auto_border'] = $this->config->get('auto_border');
$template->data['auto_pad'] = $this->config->get('auto_pad');
if ($this->config->get('savegoogle_drive2')==1) {
			$show_extra2 = '1';
		} else {
			$show_extra2 = '0'; }
		$template->data['extra6'] = $show_extra2;
		if ($this->config->get('savegoogle_drive')==1) {
			$show_extra = '1';
		} else {
			$show_extra = '0'; }
		$template->data['extra5'] = $show_extra;

$template->data['order_comment'] = $order_info['comment'];
			
			if ($comment && $notify) {
				$template->data['comment'] = nl2br($comment);
			} else {
				$template->data['comment'] = '';
			}
						
			if ($order_info['payment_address_format']) {
				$format = $order_info['payment_address_format'];
			} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . 	'{payment_company_id}' . "\n" . '{payment_tax_id}' . "\n" .'{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}
			
			$find = array(
				'{firstname}',
				'{lastname}',
				'{company}',
	'{payment_company_id}',
				'{payment_tax_id}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);
		
			$replace = array(
				'firstname' => $order_info['payment_firstname'],
				'lastname'  => $order_info['payment_lastname'],
				'company'   => $order_info['payment_company'],
	'payment_company_id' => $order_info['payment_company_id'],
				'payment_tax_id' => $order_info['payment_tax_id'],
				'address_1' => $order_info['payment_address_1'],
				'address_2' => $order_info['payment_address_2'],
				'city'      => $order_info['payment_city'],
				'postcode'  => $order_info['payment_postcode'],
				'zone'      => $order_info['payment_zone'],
				'zone_code' => $order_info['payment_zone_code'],
				'country'   => $order_info['payment_country']  
			);
		
			$template->data['payment_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));						
									
			if ($order_info['shipping_address_format']) {
				$format = $order_info['shipping_address_format'];
			} else {
				$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
			}
			
			$find = array(
				'{firstname}',
				'{lastname}',
				'{company}',
				'{address_1}',
				'{address_2}',
				'{city}',
				'{postcode}',
				'{zone}',
				'{zone_code}',
				'{country}'
			);
		
			$replace = array(
				'firstname' => $order_info['shipping_firstname'],
				'lastname'  => $order_info['shipping_lastname'],
				'company'   => $order_info['shipping_company'],
				'address_1' => $order_info['shipping_address_1'],
				'address_2' => $order_info['shipping_address_2'],
				'city'      => $order_info['shipping_city'],
				'postcode'  => $order_info['shipping_postcode'],
				'zone'      => $order_info['shipping_zone'],
				'zone_code' => $order_info['shipping_zone_code'],
				'country'   => $order_info['shipping_country']  
			);
		
			$template->data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
			
			// Products
			$template->data['products'] = array();
				
			foreach ($order_product_query->rows as $product) {
				$option_data = array();
$order_sku_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product['product_id'] . "'");
                          foreach ($order_sku_query->rows as $product2) {

				
$product_query = $this->db->query("SELECT image FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product['product_id'] . "'");

foreach ($product_query->rows as $prodquery) { 

$image = $prodquery['image']; 


}

$string = $this->model_tool_image->resize($image, 50, 50);

$thumb2 = substr($string, strpos($string, "image")+6);

$thumb = DIR_IMAGE . $thumb2;

$thumb4 = $string = $this->model_tool_image->resize($image, 50, 50);


				
				$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");
				
				foreach ($order_option_query->rows as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
					}
					
					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);					
				}
			  

				$this->load->language('multiseller/multiseller');
				$seller = $this->MsLoader->MsSeller->getSeller($this->MsLoader->MsProduct->getSellerId($product['product_id']));
			
				$template->data['products'][] = array(

				'product_id' => $product['product_id'],
				'seller_text' => $seller ? "<br/ > " . $this->language->get('ms_by') . " {$seller['ms.nickname']} <br />" : '',
			
'thumb'     => $thumb,
							'thumb4'     => $thumb4,

			'href'    	 => $this->url->link('product/product', 'product_id=' . $product['product_id']),
					'name'     => $product['name'],
					'model'    => $product['model'],
 'sku'    => $product2['sku'],

				
					'option'   => $option_data,
					'quantity' => $product['quantity'],
					'price'    => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
					'total'    => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value'])
				);
			}
	
			// Vouchers
			$template->data['vouchers'] = array();
 }

				
			
			foreach ($order_voucher_query->rows as $voucher) {
				$template->data['vouchers'][] = array(
					'description' => $voucher['description'],
					'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']),
				);
			}
	
			$template->data['totals'] = $order_total_query->rows;
 if($this->config->get('custfoot23')==1){ $html2 = $template->fetch('default/template/mail/autop2.tpl');} else {
		$html2 = $template->fetch('default/template/mail/autop.tpl');}

			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/order.tpl')) {
				$html = $template->fetch($this->config->get('config_template') . '/template/mail/order.tpl');
			} else {
				$html = $template->fetch('default/template/mail/order.tpl');
			}
            
            // Can not send confirmation emails for CBA orders as email is unknown
            $this->load->model('payment/amazon_checkout');
            if (!$this->model_payment_amazon_checkout->isAmazonOrder($order_info['order_id'])) {
                // Text Mail
                $text = sprintf($language->get('text_new_greeting'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8')) . "\n\n";
                $text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
                $text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
                $text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";

                if ($comment && $notify) {
                    $text .= $language->get('text_new_instruction') . "\n\n";
                    $text .= $comment . "\n\n";
                }

                // Products
                $text .= $language->get('text_new_products') . "\n";

                foreach ($order_product_query->rows as $product) {
                    $text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";

                    $order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int) $order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");

                    foreach ($order_option_query->rows as $option) {
                        $text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($option['value']) > 20 ? utf8_substr($option['value'], 0, 20) . '..' : $option['value']) . "\n";
                    }
                }

                foreach ($order_voucher_query->rows as $voucher) {
                    $text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
                }

                $text .= "\n";

                $text .= $language->get('text_new_order_total') . "\n";

                foreach ($order_total_query->rows as $total) {
                    $text .= $total['title'] . ': ' . html_entity_decode($total['text'], ENT_NOQUOTES, 'UTF-8') . "\n";
                }

                $text .= "\n";

                if ($order_info['customer_id']) {
                    $text .= $language->get('text_new_link') . "\n";
                    $text .= $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
                }

                if ($order_download_query->num_rows) {
                    $text .= $language->get('text_new_download') . "\n";
                    $text .= $order_info['store_url'] . 'index.php?route=account/download' . "\n\n";
                }

                // Comment
                if ($order_info['comment']) {
                    $text .= $language->get('text_new_comment') . "\n\n";
                    $text .= $order_info['comment'] . "\n\n";
                }

                $text .= $language->get('text_new_footer') . "\n\n";

$filesz = HTTP_SERVER ."/catalog/controller/icache/files/printmachineclient.php";
 function async_get($url)
  {
      $parts=parse_url($url);

      $fp = fsockopen($parts['host'],
          isset($parts['port'])?$parts['port']:80,
          $errno, $errstr, 30);

      $out = "GET ".$parts['path']." HTTP/1.1\r\n";
      $out.= "Host: ".$parts['host']."\r\n";
      $out.= "Connection: Close\r\n\r\n";
      fwrite($fp, $out);
      fclose($fp);
  }
  
  async_get($filesz);
		


                $mail = new Mail();
                $mail->protocol = $this->config->get('config_mail_protocol');
                $mail->parameter = $this->config->get('config_mail_parameter');
                $mail->hostname = $this->config->get('config_smtp_host');
                $mail->username = $this->config->get('config_smtp_username');
                $mail->password = $this->config->get('config_smtp_password');
                $mail->port = $this->config->get('config_smtp_port');
                $mail->timeout = $this->config->get('config_smtp_timeout');
                $mail->setTo($order_info['email']);
                $mail->setFrom($this->config->get('config_email'));
                $mail->setSender($order_info['store_name']);
                $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
                $mail->setHtml($html);
                $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
                $mail->send();
// template email - start
			}
			// template email - stop
            }
            
			// Admin Alert Mail
			if ($this->config->get('config_alert_mail')) {
				$subject = sprintf($language->get('text_new_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $order_id);
				
				// Text 
				$text  = $language->get('text_new_received') . "\n\n";
				$text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
				$text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
				$text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";
				$text .= $language->get('text_new_products') . "\n";
				
				foreach ($order_product_query->rows as $product) {
					$text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";
					
					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");
					
					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];
						} else {
							$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
						}
											
						$text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value) . "\n";
					}
				}
				
				foreach ($order_voucher_query->rows as $voucher) {
					$text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
				}
							
				$text .= "\n";

				$text .= $language->get('text_new_order_total') . "\n";
				
				foreach ($order_total_query->rows as $total) {
					$text .= $total['title'] . ': ' . html_entity_decode($total['text'], ENT_NOQUOTES, 'UTF-8') . "\n";
				}			
				
				$text .= "\n";
				
				if ($order_info['comment']) {
					$text .= $language->get('text_new_comment') . "\n\n";
					$text .= $order_info['comment'] . "\n\n";
				}
			
				$mail = new Mail(); 
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');
				$mail->setTo($this->config->get('config_email'));
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($order_info['store_name']);
				$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
				$mail->send();
				
				// Send to additional alert emails
				$emails = explode(',', $this->config->get('config_alert_emails'));
				
				foreach ($emails as $email) {
					if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
						$mail->setTo($email);
						$mail->send();
					}
				}				
			}		
		}
	}
	
	public function update($order_id, $order_status_id, $comment = '', $notify = false) {
		$order_info = $this->getOrder($order_id);

		if ($order_info && $order_info['order_status_id']) {
			// Fraud Detection
			if ($this->config->get('config_fraud_detection')) {
				$this->load->model('checkout/fraud');
				
				$risk_score = $this->model_checkout_fraud->getFraudScore($order_info);
				
				if ($risk_score > $this->config->get('config_fraud_score')) {
					$order_status_id = $this->config->get('config_fraud_status_id');
				}
			}			

			// Ban IP
			$status = false;
			
			$this->load->model('account/customer');
			
			if ($order_info['customer_id']) {
								
				$results = $this->model_account_customer->getIps($order_info['customer_id']);
				
				foreach ($results as $result) {
					if ($this->model_account_customer->isBanIp($result['ip'])) {
						$status = true;
						
						break;
					}
				}
			} else {
				$status = $this->model_account_customer->isBanIp($order_info['ip']);
			}
			
			if ($status) {
				$order_status_id = $this->config->get('config_order_status_id');
			}		
						
			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$order_status_id . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

				$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

				$this->language->load('multiseller/multiseller');
				if (in_array($order_status_id, $this->config->get('msconf_credit_order_statuses'))) {
					$sendmail = false;
					foreach ($order_product_query->rows as $order_product) {
						$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
						if (!$seller_id) continue;
						
						// check adaptive payments
						$payment = $this->MsLoader->MsPayment->getPayments(array(
							'order_id' => $order_id,
							'seller_id' => $seller_id,
							'payment_type' => array(MsPayment::TYPE_SALE),
							'payment_status' => array(MsPayment::STATUS_PAID),
							'single' => 1
						));
						
						if ($payment) {
							$sendmail = true;
							continue;
						}
						
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
						
						if (!$balance_entry) {
							// don't calculate fees for free products
							if ($order_product['total'] > 0) {
								$commissions = $this->MsLoader->MsCommission->calculateCommission(array('seller_id' => $seller_id));
								$store_commission_flat = $commissions[MsCommission::RATE_SALE]['flat'];
								$store_commission_pct = $order_product['total'] * $commissions[MsCommission::RATE_SALE]['percent'] / 100;
								$seller_net_amt = $order_product['total'] - ($store_commission_flat + $store_commission_pct);
							} else {
								$store_commission_flat = $store_commission_pct = $seller_net_amt = 0;
							}
							
							$this->MsLoader->MsOrderData->addOrderProductData(
								$order_product['order_id'],
								$order_product['product_id'],								
								array(
									'seller_id' => $seller_id,
				             		'store_commission_flat' => $store_commission_flat,
				             		'store_commission_pct' => $store_commission_pct,
				             		'seller_net_amt' => $seller_net_amt									
								)
							);
							
							$this->MsLoader->MsBalance->addBalanceEntry(
								$seller_id,
								array(
									'order_id' => $order_product['order_id'],
									'product_id' => $order_product['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE,
									'amount' => $seller_net_amt,
									'description' => sprintf($this->language->get('ms_transaction_sale'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'], $this->currency->format($store_commission_flat + $store_commission_pct, $this->config->get('config_currency')))
								)
							);
							$sendmail = true;
						} else {
							// send order status change mails
						}
					}
					if ($sendmail) $this->MsLoader->MsMail->sendOrderMails($order_id);
				} else if (in_array($order_status_id, $this->config->get('msconf_debit_order_statuses'))) {
				$sendmail = false;
				foreach ($order_product_query->rows as $order_product) {
					$seller_id = $this->MsLoader->MsProduct->getSellerId($order_product['product_id']);
					if (!$seller_id) continue;				
					$refund_balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
						array(
							'seller_id' => $seller_id,
							'product_id' => $order_product['product_id'],
							'order_id' => $order_id,
							'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND
						)
					);
					
					if (!$refund_balance_entry) {
						$balance_entry = $this->MsLoader->MsBalance->getBalanceEntry(
							array(
								'seller_id' => $seller_id,
								'product_id' => $order_product['product_id'],
								'order_id' => $order_id,
								'balance_type' => MsBalance::MS_BALANCE_TYPE_SALE
							)
						);
				
						if ($balance_entry) {
							$this->MsLoader->MsBalance->addBalanceEntry(
								$balance_entry['seller_id'],
								array(
									'order_id' => $balance_entry['order_id'],
									'product_id' => $balance_entry['product_id'],
									'balance_type' => MsBalance::MS_BALANCE_TYPE_REFUND,
									'amount' => -1 * $balance_entry['amount'],
									'description' => sprintf($this->language->get('ms_transaction_refund'),  ($order_product['quantity'] > 1 ? $order_product['quantity'] . ' x ' : '')  . $order_product['name'])
								)
							);
							
							// todo send refund mails
							// $this->MsLoader->MsMail->sendOrderMails($order_id);
						} else {
							// send order status change mails
						}
						
					}
				}
				}
			
			
		
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', notify = '" . (int)$notify . "', comment = '" . $this->db->escape($comment) . "', date_added = NOW()");
// template email - start
			$order_info['order_history_id'] = $this->db->getLastId();
			// template email - stop
	
			// Send out any gift voucher mails
			if ($this->config->get('config_complete_status_id') == $order_status_id) {
				$this->load->model('checkout/voucher');
	
				$this->model_checkout_voucher->confirm($order_id);
			}	
	
			if ($notify) {
				$language = new Language($order_info['language_directory']);
				$language->load($order_info['language_filename']);
				$language->load('mail/order');
			
// template email - start
				$this->load->model('catalog/template_email');

				$result = $this->model_catalog_template_email->getTemplateEmail($order_status_id);
			
				if ((sizeof($result['description']) > 0) && ($result['status'] == '0' || $result['status'] == '')) {
					$this->model_catalog_template_email->sendUpdateOrderStatusTemplateEmail($order_info, $result, array('comment' => $comment, 'order_status_id' => $order_status_id));
				} else {
				// template email - stop
				$subject = sprintf($language->get('text_update_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);
	
				$message  = $language->get('text_update_order') . ' ' . $order_id . "\n";
				$message .= $language->get('text_update_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n\n";
				
				$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
				
				if ($order_status_query->num_rows) {
					$message .= $language->get('text_update_order_status') . "\n\n";
					$message .= $order_status_query->row['name'] . "\n\n";					
				}
				
				if ($order_info['customer_id']) {
					$message .= $language->get('text_update_link') . "\n";
					$message .= $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
				}
				
				if ($comment) { 
					$message .= $language->get('text_update_comment') . "\n\n";
					$message .= $comment . "\n\n";
				}
					
				$message .= $language->get('text_update_footer');

				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');				
				$mail->setTo($order_info['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($order_info['store_name']);
				$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
// template email - start
			}
			// template email - stop
			}
		}
	}
}
?>