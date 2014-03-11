<?php
class ModelCatalogTemplateEmail extends Model {
	public function getTemplateEmailByOrderStatusId($id) {
		$sql = "SELECT * FROM " . DB_PREFIX . "template_email WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' AND id = '" . $this->db->escape($id) . "'";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getTemplateEmail($id) {
		$email_data = array('description' => array(), 'status' => '', 'special' => '0', 'track' => '0');

		$sql = "SELECT * FROM " . DB_PREFIX . "template_email WHERE id = '" . $this->db->escape($id) . "'";
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$email_data['description'][$result['language_id']] = array(
				'name'             => $result['name'],
				'description'      => $result['description']
			);

			$email_data['status'] = $result['status'];
			$email_data['special'] = $result['special'];
			$email_data['track'] = $result['track'];
		}

		return $email_data;
	}
	
	public function getPromoText() {
		$promo_data = array();

		$query = $this->db->query("SELECT promo, language_id FROM " . DB_PREFIX . "template_email WHERE promo <> ''");

		foreach ($query->rows as $result) {
			$promo_data[$result['language_id']] = array(
				'description'      => $result['promo']
			);
		}

		return $promo_data;
	}

	public function getProductSpecial($customer_group_id, $limit = 5) {			
		$sql = "SELECT DISTINCT ps.product_id, ps.price AS special, p.price, pd.name, (SELECT AVG(rating) FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = ps.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating FROM " . DB_PREFIX . "product_special ps LEFT JOIN " . DB_PREFIX . "product p ON (ps.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) GROUP BY ps.product_id ORDER BY p.sort_order ASC LIMIT " . (int)$limit;

		$product_data = array();
		
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) { 		
			$product_data[] = array(
				'product_id' => $result['product_id'],
				'price'      => $result['price'],
				'special'    => $result['special'],
				'name'       => $result['name']
			);
		}

		return $product_data;
	}

	public function getCustomer($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($email) . "'");
		
		return $query->row;
	}

	public function sendRegisterTemplateEmail($data, $template_email) {
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$this->config->get('config_customer_group_id'), $template_email['special']);
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{email}',
				'{password}',
				'{account_href}',
				'{activate_href}',
				'{special}'
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $this->config->get('config_name'),
				'email'          => $data['email'],
				'password'       => $data['password'],
				'account_href'   => $this->url->link('account/login', '', 'SSL'),
				'activate_href'  => ($data['confirm_code']) ? $this->url->link('account/activate', 'passkey=' . $data['confirm_code'], 'SSL') : '',
				'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	
		// Send to main admin email if new account email is enabled
		if ($this->config->get('config_account_mail')) {
			$mail->setTo($this->config->get('config_email'));
			$mail->send();

			$emails = explode(',', $this->config->get('config_alert_emails'));
			
			foreach ($emails as $email) {
				if (strlen($email) > 0 && preg_match('/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}
	}
	
	public function sendCustomerForgottenTemplateEmail($data, $template_email) {
		$customer_info = $this->getCustomer($data['email']);
		
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$customer_info['customer_group_id'], $template_email['special']);
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{email}',
				'{password}',
				'{account_href}',
				'{special}'
		);
		
		$replace = array(
				'firstname'      => $customer_info['firstname'],
				'lastname'       => $customer_info['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $this->config->get('config_name'),
				'email'          => $data['email'],
				'password'       => $data['password'],
				'account_href'   => $this->url->link('account/login', '', 'SSL'),
				'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}
	
	public function sendVoucherTemplateEmail($data, $template_email) {
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$this->config->get('config_customer_group_id'), $template_email['special']);
		}
		
		$find = array(
				'{recip_name}',
				'{recip_email}',
				'{date}',
				'{store_name}',
				'{name}',
				'{amount}',
				'{message}',
				'{store_href}',
				'{image}',
				'{code}',
				'{special}'
		);
		
		$replace = array(
				'recip_name'  => $data['recip_name'],
				'recip_email' => $data['recip_email'],
				'date'        => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'  => $data['store_name'],
				'name'        => $data['name'],
				'amount'      => $data['amount'],
				'message'     => $data['message'],
				'store_href'  => $data['store_href'],
				'image'       => (file_exists(DIR_IMAGE . $voucher['image'])) ? 'cid:' . md5(basename($data['image'])) : '',
				'code'        => $data['code'],
				'special'     => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['recip_email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($data['store_name']);
		$mail->setSubject($subject);
		$mail->setHTML($message);
		
		if (file_exists(DIR_IMAGE . $data['image'])) {
			$mail->addAttachment(DIR_IMAGE . $data['image'], md5(basename($data['image'])));
		}

		$mail->send();
	}
	
	public function sendAffiliateRegisterTemplateEmail($data, $template_email) {
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$this->config->get('config_customer_group_id'), $template_email['special']);
		}

		$code = $this->getAffilate($data['email']);

		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{email}',
				'{password}',
				'{affiliate_code}',
				'{account_href}',
				'{special}'
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $this->config->get('config_name'),
				'email'          => $data['email'],
				'password'       => $data['password'],
				'affiliate_code' => $code['code'],
				'account_href'   => $this->url->link('affiliate/login', '', 'SSL'),
				'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}
	
	public function sendAffiliateForgottenTemplateEmail($data, $template_email) {
		$affilate_info = $this->getAffilate($data['email']);
		
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$this->config->get('config_customer_group_id'), $template_email['special']);
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{password}',
				'{account_href}',
				'{special}'
		);
		
		$replace = array(
				'firstname'      => $affilate_info['firstname'],
				'lastname'       => $affilate_info['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $this->config->get('config_name'),
				'password'       => $data['password'],
				'account_href'   => $this->url->link('affiliate/login', '', 'SSL'),
				'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}

	public function sendAffiliateOrderTemplateEmail($data, $template_email) {
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$find = array(
				'{firstname}',
				'{lastname}',
				'{commission}',
				'{date}',
				'{store_name}',
				'{account_href}',
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'commission'     => $data['commission'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $data['config_name'],
				'account_href'   => $this->url->link('affiliate/login', '', 'SSL')
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}

	public function getProduct($product_id) {
		$query = $this->db->query("SELECT p.sku, p.upc, p.image, pd.name FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
				
		return $query->row;
	}
	
	public function sendUpdateOrderStatusTemplateEmail($order_info, $template_email, $data) {
		$order_status_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$data['order_status_id'] . "' AND language_id = '" . (int)$order_info['language_id'] . "'");

		if ($order_status_query->num_rows) {
			$order_status = $order_status_query->row['name'];	
		} else {
			$order_status = '';
		}

		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$order_info['customer_group_id'], $template_email['special']);
		}

		$template = $template_email['description'][$order_info['language_id']];
		preg_match('/{product:start}(.*){product:stop}/Uis', $template['description'], $template_product);

		$invoice_no = '';

		if (!$order_info['invoice_no'] && $order_info['order_status_id']) {
			if ($this->config->get('template_email_generate_invoice')) {
				$query = $this->db->query("SELECT MAX(invoice_no) AS invoice_no FROM `" . DB_PREFIX . "order` WHERE invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "'");

				if ($query->row['invoice_no']) {
					$invoice_no = (int)$query->row['invoice_no'] + 1;
				} else {
					$invoice_no = 1;
				}

				$this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_no = '" . (int)$invoice_no . "', invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "' WHERE order_id = '" . (int)$order_info['order_id'] . "'");
			} else if (!$this->config->get('template_email_generate_invoice') && $this->config->get('template_email_generate_invoice_status') == $data['order_status_id']) {
				$query = $this->db->query("SELECT MAX(invoice_no) AS invoice_no FROM `" . DB_PREFIX . "order` WHERE invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "'");

				if ($query->row['invoice_no']) {
					$invoice_no = (int)$query->row['invoice_no'] + 1;
				} else {
					$invoice_no = 1;
				}

				$this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_no = '" . (int)$invoice_no . "', invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "' WHERE order_id = '" . (int)$order_info['order_id'] . "'");
			}
		} else {
			$invoice_no = $order_info['invoice_no'];
		}

		$query_product = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_product` WHERE order_id = '" . (int)$order_info['order_id'] . "'");
		
		$products = array();
		$order_href = '';

		if ($order_info['customer_id'])
			$order_href = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_info['order_id'];

		$template_product_find = array(
				'{product_image}',
				'{product_name}',
				'{product_model}',
				'{product_quantity}',
				'{product_price}',
				'{product_price_gross}',
				'{product_attribute}',
				'{product_option}',
				'{product_sku}',
				'{product_upc}',
				'{product_tax}',
				'{product_total}',
				'{product_total_gross}'
		);

		if (sizeof($template_product) > 0) {
			$this->load->model('tool/image');

			$template['description'] = str_replace($template_product[1], '', $template['description']);

			foreach ($query_product->rows as $product) {
				$option_data = array();
				$attribute_data = array();

				$product_info = $this->getProduct($product['product_id']);

				if (stripos($template_product[1], '{product_option}') !== false) {
					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_info['order_id'] . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$option_data[] = '<i>' . $option['name'] . '</i>: ' . $option['value'];
						} else {
							$filename = substr($option['value'], 0, strrpos($option['value'], '.'));

							$option_data[] = '<i>' . $option['name'] . '</i>: ' . (strlen($filename) > 20 ? substr($filename, 0, 20) . '..' : $filename);
						}
					}
				}

				if (stripos($template_product[1], '{product_attribute}') !== false) {
					$product_attributes = $this->getProductAttributes($product['product_id'], $order_info['language_id']);

					foreach ($product_attributes as $attribute_group) {
						$attribute_sub_data = '';

						foreach ($attribute_group['attribute'] as $attribute) {
							$attribute_sub_data .= '<br />' . $attribute['name'] . ': ' . $attribute['text'];
						}

						$attribute_data[] = '<u>' . $attribute_group['name'] . '</u>' . $attribute_sub_data;
					}
				}

				if ($product_info['image']) {
					if ($this->config->get('template_email_product_thumbnail_width') && $this->config->get('template_email_product_thumbnail_height')) {
						$product_image = $this->model_tool_image->resize($product_info['image'], $this->config->get('template_email_product_thumbnail_width'), $this->config->get('template_email_product_thumbnail_height'));
					} else {
						$product_image = $this->model_tool_image->resize($product_info['image'], 80, 80);
					}
				} else {
					$product_image = '';
				}

				$template_product_replace = array(
					'product_image'       => $product_image,
					'product_name'        => $product['name'],
					'product_model'       => $product['model'],
					'product_quantity'    => $product['quantity'],
					'product_price'       => $this->currency->format($product['price'], $order_info['currency_code'], $order_info['currency_value']),
					'product_price_gross' => $this->currency->format(($product['price'] + $product['tax']), $order_info['currency_code'], $order_info['currency_value']),
					'product_attribute'   => implode('<br />', $attribute_data),
					'product_option'      => implode('<br />', $option_data),
					'product_sku'         => $product_info['sku'],
					'product_upc'         => $product_info['upc'],
					'product_tax'         => $this->currency->format($product['tax'], $order_info['currency_code'], $order_info['currency_value']),
					'product_total'       => $this->currency->format($product['total'], $order_info['currency_code'], $order_info['currency_value']),
					'product_total_gross' => $this->currency->format($product['total'] + ($product['tax'] * $product['quantity']), $order_info['currency_code'], $order_info['currency_value'])
				);

				$products[] = trim(str_replace($template_product_find, $template_product_replace, $template_product[1]));
			}
		}

		$address = '';
		$totals = array();
		$tax_amount = 0;

		if (strlen($order_info['shipping_firstname']) <> 0) {
			$address = $order_info['shipping_firstname'] . ' ' . $order_info['shipping_lastname'] . '<br />' . ((strlen($order_info['shipping_company']) <> 0) ? $order_info['shipping_company'] . '<br />' : '') . '' . $order_info['shipping_address_1'] . '<br />' . $order_info['shipping_city'] . ' ' . $order_info['shipping_postcode'] . '<br />' . $order_info['shipping_zone'] . ' ' . $order_info['shipping_country'];
		} else {
			$address = '';
		}

		if (strlen($order_info['payment_firstname']) <> 0) {
			$payment_address = $order_info['payment_firstname'] . ' ' . $order_info['payment_lastname'] . '<br />' . ((strlen($order_info['payment_company']) <> 0) ? $order_info['payment_company'] . '<br />' : '') . '' . $order_info['payment_address_1'] . '<br />' . $order_info['payment_city'] . ' ' . $order_info['payment_postcode'] . '<br />' . $order_info['payment_zone'] . ' ' . $order_info['payment_country'];
		} else {
			$payment_address = '';
		}
		
		$promo = $this->getPromoText();

		if ($promo)
			$promo = $promo[(int)$order_info['language_id']]['description'];
		else
			$promo = '';

		$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_info['order_id'] . "'");

		foreach ($order_total_query->rows as $total) {
			$totals[$total['code']][] = array(
				'title' => $total['title'],
				'text'  => $total['text'],
				'value' => $total['value']
			);

			if ($total['code'] == 'tax') {
				$tax_amount += $total['value'];
			}
		}

		preg_match('/{tax:start}(.*){tax:stop}/Uis', $template['description'], $template_tax);

		$taxes = array();

		$template_tax_find = array(
			'{tax_title}',
			'{tax_value}'
		);

		if (sizeof($template_tax) > 0) {
			$template['description'] = str_replace($template_tax[1], '', $template['description']);

			foreach ($totals['tax'] as $tax) {
				$template_tax_replace = array(
					'tax_title'     => $tax['title'],
					'tax_value'     => $tax['text']
				);

				$taxes[] = trim(str_replace($template_tax_find, $template_tax_replace, $template_total[1]));
			}
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{delivery_address}',
				'{shipping_address}',
				'{payment_address}',
				'{order_date}',
				'{product:start}',
				'{product:stop}',
				'{special}',
				'{date}',
				'{payment}',
				'{shipment}',
				'{order_id}',
				'{total}',
				'{invoice_number}',
				'{order_href}',
				'{store_url}',
				'{status_name}',
				'{store_name}',
				'{ip}',
				'{comment}',
				'{promo}',
				'{sub_total}',
				'{shipping_cost}',
				'{client_comment}',
				'{tax:start}',
				'{tax:stop}',
				'{tax_amount}',
				'{email}',
				'{telephone}',
				'{carrier}',
				'{tracking_number}',
				'{carrier_href}'
		);
		
		$replace = array(
				'firstname'       => $order_info['firstname'],
				'lastname'        => $order_info['lastname'],
				'delivery_address'=> $address,
				'shipping_address'=> $address,
				'payment_address' => $payment_address,
				'order_date'      => date($this->language->get('date_format_short'), strtotime($order_info['date_added'])),
				'product:start'   => implode("", $products),
				'product:stop'    => '',
				'special'         => (sizeof($special) <> 0) ? implode("<br />", $special) : '',
				'date'            => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'payment'         => $order_info['payment_method'],
				'shipment'        => $order_info['shipping_method'],
				'order_id'        => $order_info['order_id'],
				'total'           => $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value']),
				'invoice_number'  => $order_info['invoice_prefix'] . $invoice_no,
				'order_href'      => $order_href,
				'store_url'       => $order_info['store_url'],
				'status_name'     => $order_status,
				'store_name'      => $order_info['store_name'],
				'ip'              => $order_info['ip'],
				'comment'         => nl2br($data['comment']),
				'promo'           => $promo,
				'sub_total'       => $totals['sub_total'][0]['text'],
				'shipping_cost'   => (isset($totals['shipping'][0]['text'])) ? $totals['shipping'][0]['text'] : '',
				'client_comment'  => $order_info['comment'],
				'tax:start'       => implode("", $taxes),
				'tax:stop'        => '',
				'tax_amount'      => $this->currency->format($tax_amount, $order_info['currency_code'], $order_info['currency_value']),
				'email'           => $order_info['email'],
				'telephone'       => $order_info['telephone'],
				'carrier'         => '',
				'tracking_number' => '',
				'carrier_href'    => ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$template = str_replace($find, $replace, $template['description']);

		$str_track = false;

		if ($template_email['track']) {
			$str_track = '<img src="' . HTTP_SERVER . 'index.php?route=common/template_email/track&history_id=' . (int)$order_info['order_history_id'] . '&act=log&code=' . md5($order_info['order_history_id'] . (int)$order_info['order_id'] . (int)$order_info['order_status_id']) . '&order_id=' . (int)$order_info['order_id'] . '" border="0" height="1" width="1">';

			if (stripos($template, '</body>') !== false) {
				$template = str_replace('</body>', $str_track . '</body>', $template);
			} else {
				$template .= $str_track;
			}
		}

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
		$mail->setSubject($subject);
		$mail->setHTML($template);
		$mail->send();

		if ($this->config->get('template_email_statuses_to_admin')) {
			if ($template_email['track'] && $str_track) {
				$mail->setHTML(str_replace($str_track, '', $template));
			}

			$mail->setTo($this->config->get('config_email'));
			$mail->send();

			$emails = explode(',', $this->config->get('config_alert_emails'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}
	}

	public function getAffilate($email, $id = 0) {
		if ($email && $id == 0) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE email = '" . $this->db->escape($email) . "'");
		} else {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int)$id . "'");
		}
		
		return $query->row;
	}
	
	private function prepareProductSpecial($customer_group_id, $limit) {
		$special = array();
		$product_special = $this->getProductSpecial((int)$customer_group_id, $limit);

		if (sizeof($product_special) <> 0) {
			foreach ($product_special as $product) {
				$discount = round((($product['price'] - $product['special'])/$product['price'])*100, 0);

				$special[] = '<a href="' . $this->url->link('product/product', 'product_id=' . $product['product_id'], 'SSL') . '">' . $product['name'] . '</a> (<font color="red">-' . $discount . '%</font>)';
			}
		}

		return $special;
	}
	
	public function sendDefaultStatusTemplateEmail($order_info, $order_status_id, $template_email, $comment) {
		$order_status_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");

		if ($order_status_query->num_rows) {
			$order_status = $order_status_query->row['name'];	
		} else {
			$order_status = '';
		}

		if ($order_info['affiliate_id'] && $order_info['commission']) {
			$result = $this->getTemplateEmail('affiliate.order');
			
			if ((sizeof($result['description']) > 0) && ($result['status'] == '0' || $result['status'] == '')) {
				$affiliate_info = $this->getAffiliateById($order_info['affiliate_id']);

				$tpl_data = array();

				$tpl_data = array(
					'firstname'    => $affiliate_info['firstname'],
					'lastname'     => $affiliate_info['lastname'],
					'email'        => $affiliate_info['email'],
					'commission'   => $this->currency->format($order_info['commission'], $this->config->get('config_currency')),
					'store_name'   => $this->config->get('config_name')
				);

				$this->sendAffiliateOrderTemplateEmail($tpl_data, $result);
			}
		}

		$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_info['order_id'] . "'");
		$order_total_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_info['order_id'] . "' ORDER BY sort_order ASC");
		$order_download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_download WHERE order_id = '" . (int)$order_info['order_id'] . "'");

		$template = $template_email['description'][$order_info['language_id']];
		preg_match('/{product:start}(.*){product:stop}/Uis', $template['description'], $template_product);

		$special = array();

		if (sizeof($template_email['special']) <> 0) {
			$special = $this->prepareProductSpecial((int)$order_info['customer_group_id'], $template_email['special']);
		}

		$promo = $this->getPromoText();

		if ($promo)
			$promo = $promo[(int)$order_info['language_id']]['description'];
		else
			$promo = '';

		$products = array();
		$order_href = '';
		
		if ($order_info['customer_id'])
			$order_href = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . (int)$order_info['order_id'];

		$template_product_find = array(
			'{product_image}',
			'{product_name}',
			'{product_model}',
			'{product_quantity}',
			'{product_price}',
			'{product_price_gross}',
			'{product_attribute}',
			'{product_option}',
			'{product_sku}',
			'{product_upc}',
			'{product_tax}',
			'{product_total}',
			'{product_total_gross}'
		);

		if (sizeof($template_product) > 0) {
			$this->load->model('tool/image');

			$template['description'] = str_replace($template_product[1], '', $template['description']);

			foreach ($order_product_query->rows as $product) {
				$option_data = array();
				$attribute_data = array();

				$product_info = $this->getProduct($product['product_id']);

				if (stripos($template_product[1], '{product_option}') !== false) {
					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_info['order_id'] . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$option_data[] = '<i>' . $option['name'] . '</i>: ' . $option['value'];
						} else {
							$filename = substr($option['value'], 0, strrpos($option['value'], '.'));

							$option_data[] = '<i>' . $option['name'] . '</i>: ' . (strlen($filename) > 20 ? substr($filename, 0, 20) . '..' : $filename);
						}
					}
				}

				if (stripos($template_product[1], '{product_attribute}') !== false) {
					$product_attributes = $this->getProductAttributes($product['product_id'], $order_info['language_id']);

					foreach ($product_attributes as $attribute_group) {
						$attribute_sub_data = '';

						foreach ($attribute_group['attribute'] as $attribute) {
							$attribute_sub_data .= '<br />' . $attribute['name'] . ': ' . $attribute['text'];
						}

						$attribute_data[] = '<u>' . $attribute_group['name'] . '</u>' . $attribute_sub_data;
					}
				}

				if ($product_info['image']) {
					if ($this->config->get('template_email_product_thumbnail_width') && $this->config->get('template_email_product_thumbnail_height')) {
						$product_image = $this->model_tool_image->resize($product_info['image'], $this->config->get('template_email_product_thumbnail_width'), $this->config->get('template_email_product_thumbnail_height'));
					} else {
						$product_image = $this->model_tool_image->resize($product_info['image'], 80, 80);
					}
				} else {
					$product_image = '';
				}

				$template_product_replace = array(
					'product_image'       => $product_image,
					'product_name'        => $product['name'],
					'product_model'       => $product['model'],
					'product_quantity'    => $product['quantity'],
					'product_price'       => $this->currency->format($product['price'], $order_info['currency_code'], $order_info['currency_value']),
					'product_price_gross' => $this->currency->format(($product['price'] + $product['tax']), $order_info['currency_code'], $order_info['currency_value']),
					'product_attribute'   => implode('<br />', $attribute_data),
					'product_option'      => implode('<br />', $option_data),
					'product_sku'         => $product_info['sku'],
					'product_upc'         => $product_info['upc'],
					'product_tax'         => $this->currency->format($product['tax'], $order_info['currency_code'], $order_info['currency_value']),
					'product_total'       => $this->currency->format($product['total'], $order_info['currency_code'], $order_info['currency_value']),
					'product_total_gross' => $this->currency->format($product['total'] + ($product['tax'] * $product['quantity']), $order_info['currency_code'], $order_info['currency_value'])
				);

				$products[] = trim(str_replace($template_product_find, $template_product_replace, $template_product[1]));
			}
		}

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
		
		$shipping_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

		if ($order_info['payment_address_format']) {
			$format = $order_info['payment_address_format'];
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
			'firstname' => $order_info['payment_firstname'],
			'lastname'  => $order_info['payment_lastname'],
			'company'   => $order_info['payment_company'],
			'address_1' => $order_info['payment_address_1'],
			'address_2' => $order_info['payment_address_2'],
			'city'      => $order_info['payment_city'],
			'postcode'  => $order_info['payment_postcode'],
			'zone'      => $order_info['payment_zone'],
			'zone_code' => $order_info['payment_zone_code'],
			'country'   => $order_info['payment_country']  
		);
		
		$payment_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

		$tax_amount = 0;
		$taxes = array();
		$ex_totals = array();

		foreach ($order_total_query->rows as $total) {
			$ex_totals[$total['code']][] = array(
				'title' => $total['title'],
				'text'  => $total['text'],
				'value' => $total['value']
			);

			if ($total['code'] == 'tax') {
				$tax_amount += $total['value'];
			}
		}

		preg_match('/{tax:start}(.*){tax:stop}/Uis', $template['description'], $template_tax);

		$taxes = array();

		$template_tax_find = array(
			'{tax_title}',
			'{tax_value}'
		);

		if (sizeof($template_tax) > 0) {
			$template['description'] = str_replace($template_tax[1], '', $template['description']);

			foreach ($ex_totals['tax'] as $tax) {
				$template_tax_replace = array(
					'tax_title'     => $tax['title'],
					'tax_value'     => $tax['text']
				);

				$taxes[] = trim(str_replace($template_tax_find, $template_tax_replace, $template_tax[1]));
			}
		}

		preg_match('/{total:start}(.*){total:stop}/Uis', $template['description'], $template_total);

		$totals = array();

		$template_total_find = array(
			'{total_title}',
			'{total_value}'
		);

		if (sizeof($template_total) > 0) {
			$template['description'] = str_replace($template_total[1], '', $template['description']);

			foreach ($order_total_query->rows as $total) {
				$template_total_replace = array(
					'total_title'     => $total['title'],
					'total_value'     => $total['text']
				);

				$totals[] = trim(str_replace($template_total_find, $template_total_replace, $template_total[1]));
			}
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{payment_address}',
				'{shipping_address}',
				'{order_date}',
				'{product:start}',
				'{product:stop}',
				'{total:start}',
				'{total:stop}',
				'{special}',
				'{date}',
				'{payment}',
				'{shipment}',
				'{download}',
				'{order_id}',
				'{order_href}',
				'{comment}',
				'{status_name}',
				'{store_name}',
				'{ip}',
				'{email}',
				'{telephone}',
				'{store_url}',
				'{logo}',
				'{promo}',
				'{sub_total}',
				'{shipping_cost}',
				'{client_comment}',
				'{tax:start}',
				'{tax:stop}',
				'{tax_amount}',
				'{total}'
		);

		$replace = array(
				'firstname'        => $order_info['firstname'],
				'lastname'         => $order_info['lastname'],
				'payment_address'  => $payment_address,
				'shipping_address' => $shipping_address,
				'order_date'       => date($this->language->get('date_format_short'), strtotime($order_info['date_added'])),
				'product:start'    => implode("", $products),
				'product:stop'     => '',
				'total:start'      => implode("", $totals),
				'total:stop'       => '',
				'special'         => (sizeof($special) <> 0) ? implode("<br />", $special) : '',
				'date'            => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'payment'         => $order_info['payment_method'],
				'shipment'        => $order_info['shipping_method'],
				'download'        => ($order_download_query->num_rows) ? $order_info['store_url'] . 'index.php?route=account/download' : '',
				'order_id'        => $order_info['order_id'],
				'order_href'      => $order_href,
				'comment'         => nl2br($comment),
				'status_name'     => $order_status,
				'store_name'      => $order_info['store_name'],
				'ip'              => $order_info['ip'],
				'email'           => $order_info['email'],
				'telephone'       => $order_info['telephone'],
				'store_url'       => $order_info['store_url'],
				'logo'            => 'cid:' . md5(basename($this->config->get('config_logo'))),
				'promo'           => $promo,
				'sub_total'       => $ex_totals['sub_total'][0]['text'],
				'shipping_cost'   => (isset($ex_totals['shipping'][0]['text'])) ? $ex_totals['shipping'][0]['text'] : '',
				'client_comment'  => $order_info['comment'],
				'tax:start'       => implode("", $taxes),
				'tax:stop'        => '',
				'tax_amount'      => $this->currency->format($tax_amount, $order_info['currency_code'], $order_info['currency_value']),
				'total'           => $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'])
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$str_track = false;

		if ($template_email['track']) {
			$str_track = '<img src="' . HTTP_SERVER . 'index.php?route=common/template_email/track&history_id=' . (int)$order_info['order_history_id'] . '&act=log&code=' . md5($order_info['order_history_id'] . (int)$order_info['order_id'] . (int)$order_status_id) . '&order_id=' . (int)$order_info['order_id'] . '" border="0" height="1" width="1">';

			if (stripos($message, '</body>') !== false) {
				$message = str_replace('</body>', $str_track . '</body>', $message);
			} else {
				$message .= $str_track;
			}
		}

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
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->addAttachment(DIR_IMAGE . $this->config->get('config_logo'), md5(basename($this->config->get('config_logo'))));
		$mail->send();

		if ($this->config->get('template_email_statuses_to_admin')) {
			if ($template_email['track'] && $str_track) {
				$mail->setHTML(str_replace($str_track, '', $message));
			}

			$mail->setTo($this->config->get('config_email'));
			$mail->send();

			$emails = explode(',', $this->config->get('config_alert_emails'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}
	}

	public function sendReviewsNoticeTemplateEmail($data, $template_email) {
		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$find = array(
				'{author}',
				'{review}',
				'{date}',
				'{rating}',
				'{product}',
				'{special}'
		);
		
		$replace = array(
				'author'      => $data['author'],
				'review'      => $data['review'],
				'date'        => date($this->language->get('date_format_short'), time()),
				'rating'      => $data['rating'],
				'product'     => $data['product']
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

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
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}

	public function sendContactConfirmationTemplateEmail($data, $template_email) {
		$customer_info = $this->getCustomer($data['email']);

		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$customer_group_id = (isset($customer_info['customer_group_id'])) ? (int)$customer_info['customer_group_id'] : (int)$this->config->get('config_customer_group_id');

			$special = $this->prepareProductSpecial((int)$customer_group_id, $template_email['special']);
		}

		$find = array(
				'{firstname}',
				'{email}',
				'{date}',
				'{enquiry}',
				'{special}'
		);
		
		$replace = array(
				'firstname'   => $data['firstname'],
				'email'       => $data['email'],
				'date'        => date($this->language->get('date_format_short'), time()),
				'enquiry'     => $data['enquiry'],
				'special'     => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

		$mail = new Mail();
		$mail->protocol = $this->config->get('config_mail_protocol');
		$mail->parameter = $this->config->get('config_mail_parameter');
		$mail->hostname = $this->config->get('config_smtp_host');
		$mail->username = $this->config->get('config_smtp_username');
		$mail->password = $this->config->get('config_smtp_password');
		$mail->port = $this->config->get('config_smtp_port');
		$mail->timeout = $this->config->get('config_smtp_timeout');				
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);
		$mail->send();
	}

	public function sendInvoiceTemplateEmail($order_info, $template_email, $invoice_pdf) {
		$customer_info = $this->getCustomer($order_info['email']);

		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

		$special = array();

		if ($template_email['special'] > 0) {
			$customer_group_id = (isset($customer_info['customer_group_id'])) ? (int)$customer_info['customer_group_id'] : (int)$this->config->get('config_customer_group_id');

			$special = $this->prepareProductSpecial((int)$customer_group_id, $template_email['special']);
		}

		$find = array(
			'{firstname}',
			'{lastname}',
			'{order_date}',
			'{order_id}',
			'{invoice_number}',
			'{special}'
		);
		
		$replace = array(
			'firstname'      => $order_info['firstname'],
			'lastname'       => $order_info['lastname'],
			'order_date'     => date($this->language->get('date_format_short'), strtotime($order_info['date_added'])),
			'order_id'       => $order_info['order_id'],
			'invoice_number' => $order_info['invoice_prefix'] . $order_info['invoice_no'],
			'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_sent = '1' WHERE order_id = '" . (int)$order_info['order_id'] . "'");

		$subject = trim(str_replace($find, $replace, $template['name']));
		$message = str_replace($find, $replace, $template['description']);

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
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHTML($message);

		if ($invoice_pdf) {
			require_once(DIR_SYSTEM . 'library/dompdf/dompdf_config.inc.php');

			$pdf = new DOMPDF;
			$pdf->load_html($invoice_pdf);
			$pdf->render();
			file_put_contents(DIR_CACHE . 'order_invoice_catalog.pdf', $pdf->output());
			
			/*require_once(DIR_SYSTEM . 'library/mpdf/mpdf.php');
			
			$pdf = new mPDF();
			$pdf->SetDisplayMode('fullpage');
			$stylesheet = file_get_contents('/home/adikon/domains/adikon.eu/public_html/demo/admin/view/stylesheet/invoice.css');
			$pdf->WriteHTML($stylesheet, 1);
			$pdf->WriteHTML($invoice_pdf);
			$pdf->Output(DIR_CACHE . 'order_invoice_catalog.pdf', 'F');*/
			$mail->addAttachment(DIR_CACHE . 'order_invoice_catalog.pdf', md5(basename(DIR_CACHE . 'order_invoice_catalog.pdf')));
		}

		$mail->send();
	}

	private function getProductAttributes($product_id, $language_id) {
		$product_attribute_group_data = array();
		
		$product_attribute_group_query = $this->db->query("SELECT ag.attribute_group_id, agd.name FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_group ag ON (a.attribute_group_id = ag.attribute_group_id) LEFT JOIN " . DB_PREFIX . "attribute_group_description agd ON (ag.attribute_group_id = agd.attribute_group_id) WHERE pa.product_id = '" . (int)$product_id . "' AND agd.language_id = '" . (int)$language_id . "' GROUP BY ag.attribute_group_id ORDER BY ag.sort_order, agd.name");
		
		foreach ($product_attribute_group_query->rows as $product_attribute_group) {
			$product_attribute_data = array();
			
			$product_attribute_query = $this->db->query("SELECT a.attribute_id, ad.name, pa.text FROM " . DB_PREFIX . "product_attribute pa LEFT JOIN " . DB_PREFIX . "attribute a ON (pa.attribute_id = a.attribute_id) LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE pa.product_id = '" . (int)$product_id . "' AND a.attribute_group_id = '" . (int)$product_attribute_group['attribute_group_id'] . "' AND ad.language_id = '" . (int)$language_id . "' AND pa.language_id = '" . (int)$language_id . "' ORDER BY a.sort_order, ad.name");
			
			foreach ($product_attribute_query->rows as $product_attribute) {
				$product_attribute_data[] = array(
					'attribute_id' => $product_attribute['attribute_id'],
					'name'         => $product_attribute['name'],
					'text'         => $product_attribute['text']		 	
				);
			}
			
			$product_attribute_group_data[] = array(
				'attribute_group_id' => $product_attribute_group['attribute_group_id'],
				'name'               => $product_attribute_group['name'],
				'attribute'          => $product_attribute_data
			);			
		}
		
		return $product_attribute_group_data;
	}

	public function getTrackStatusEmail($history_id, $code) {
		$history_query = $this->db->query("SELECT email_track FROM " . DB_PREFIX . "order_history WHERE MD5(CONCAT_WS('', order_history_id, order_id, order_status_id)) = '" . $this->db->escape($code) . "' AND order_history_id = '" . (int)$history_id . "'");

		if ($history_query->rows) {
			return array('0' => true, '1' => $history_query->row['email_track']);
		} else {
			return array('0' => false);
		}
	}

	public function addTrackStatusEmail($history_id, $value) {
		$this->db->query("UPDATE `" . DB_PREFIX . "order_history` SET email_track = '" . $this->db->escape($value). "' WHERE order_history_id = '" . (int)$history_id . "'"); 
	}
	
	public function getOrdersByDate($from, $to) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "order` WHERE invoice_sent = '0' AND invoice_no > '0'";

		if (date('Y-m-d', strtotime($from)) == $from) {
			$sql .= " AND UNIX_TIMESTAMP(SUBSTR(date_added, 0, 10)) >= '" . strtotime($from) . "'";
		}

		if (date('Y-m-d', strtotime($to)) == $to) {
			$sql .= " AND UNIX_TIMESTAMP(SUBSTR(date_added, 0, 10)) <= '" . strtotime($to) . "'";
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getSetting($group, $store_id = 0) {
		$data = array(); 
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `group` = '" . $this->db->escape($group) . "'");
		
		foreach ($query->rows as $result) {
			if (!$result['serialized']) {
				$data[$result['key']] = $result['value'];
			} else {
				$data[$result['key']] = unserialize($result['value']);
			}
		}

		return $data;
	}

	public function getShippingZoneCode($shipping_zone_id) {
		$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$shipping_zone_id . "'");

		if ($zone_query->num_rows) {
			$shipping_zone_code = $zone_query->row['code'];
		} else {
			$shipping_zone_code = '';
		}

		return $shipping_zone_code;
	}

	public function getPaymentZoneCode($payment_zone_id) {
		$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$payment_zone_id . "'");

		if ($zone_query->num_rows) {
			$payment_zone_code = $zone_query->row['code'];
		} else {
			$payment_zone_code = '';
		}

		return $payment_zone_code;
	}
}
?>