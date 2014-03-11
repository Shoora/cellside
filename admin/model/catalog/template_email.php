<?php
class ModelCatalogTemplateEmail extends Model {
	public function getTemplateEmailByOrderStatusId($id) {
		$sql = "SELECT * FROM " . DB_PREFIX . "template_email WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' AND id = '" . $this->db->escape($id) . "'";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getTemplateEmailByReturnStatusId($id) {
		return $this->getTemplateEmailByOrderStatusId($id);
	}

	public function getTemplateEmailForMail() {
		$sql = "SELECT * FROM " . DB_PREFIX . "template_email WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' AND id LIKE 'mail_%'";
		$query = $this->db->query($sql);

		return $query->rows;
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
	
	public function deleteEmail($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "template_email WHERE id = '" . $this->db->escape($id) . "'");
	}

	public function editEmail($id, $data) {
		$promo = $this->getPromoText();
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "template_email WHERE id = '" . $this->db->escape($id) . "'");

		foreach ($data['email_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "template_email SET id = '" . $this->db->escape($id) . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape(trim(strip_tags(html_entity_decode($value['name'], ENT_QUOTES, 'UTF-8')))) . "', description = '" . $this->db->escape(html_entity_decode($value['description'])) . "', status = '" . (isset($data['email_status']) ? 1 : 0) . "', special = '" . (int)$data['email_special'] . "', track = '" . (isset($data['email_track']) ? 1 : 0) . "', promo = '" . (isset($promo[$language_id]) ? $this->db->escape($promo[$language_id]['description']) : '') . "'");
		}
	}

	public function addTextPromo($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "template_email SET promo = ''");

		foreach ($data as $language_id => $value) {
			$this->db->query("UPDATE " . DB_PREFIX . "template_email SET promo = '" . $this->db->escape(strip_tags($value['description'])) . "' WHERE language_id = '" . (int)$language_id . "'");
		}
	}
	
	public function getProduct($product_id) {
		$query = $this->db->query("SELECT sku, upc, image FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");
				
		return $query->row;
	}

	public function addOrderHistoryTemplateEmail($order_info, $template_email, $data, $invoice_pdf) {
		$order_status_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$data['order_status_id'] . "' AND language_id = '" . (int)$order_info['language_id'] . "'");

		if ($order_status_query->num_rows) {
			$order_status = $order_status_query->row['name'];	
		} else {
			$order_status = '';
		}

		$template = $template_email['description'][$order_info['language_id']];
		preg_match('/{product:start}(.*){product:stop}/Uis', $template['description'], $template_product);

		$special = array();

		if (sizeof($template_email['special']) <> 0) {
			$special = $this->prepareProductSpecial((int)$order_info['customer_group_id'], $template_email['special']);
		}

		$invoice_no = '';

		if (!$order_info['invoice_no'] && $data['order_status_id']) {
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

		$v151 = (defined('VERSION') && strpos(VERSION, '1.5.1') === 0);
				
		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$data['order_status_id'] . "', date_modified = NOW() WHERE order_id = '" . (int)$order_info['order_id'] . "'");

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
							if ($v151) {
								$filename = substr($option['value'], 0, strrpos($option['value'], '.'));

								$option_data[] = '<i>' . $option['name'] . '</i>: ' . (strlen($filename) > 20 ? substr($filename, 0, 20) . '..' : $filename);
							} else {
								$filename = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));

								$option_data[] = '<i>' . $option['name'] . '</i>: ' . (utf8_strlen($filename) > 20 ? utf8_substr($filename, 0, 20) . '..' : $filename);
							}
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

			if (isset($totals['tax'])) {
				foreach ($totals['tax'] as $tax) {
					$template_tax_replace = array(
						'tax_title'     => $tax['title'],
						'tax_value'     => $tax['text']
					);

					$taxes[] = trim(str_replace($template_tax_find, $template_tax_replace, $template_tax[1]));
				}
			}
		}

		preg_match('/{total:start}(.*){total:stop}/Uis', $template['description'], $template_total);

		$tmp_totals = array();

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

				$tmp_totals[] = trim(str_replace($template_total_find, $template_total_replace, $template_total[1]));
			}
		}

		$trackers = array();

		if (isset($data['tracker_id']) && isset($data['tracking_numbers'])) {
			$trackers_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "trackers WHERE tracker_id = '" . (int)$data['tracker_id'] . "'");

			$trackers = $trackers_query->row;
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
				'{total:start}',
				'{total:stop}',
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
				'total:start'     => implode("", $tmp_totals),
				'total:stop'      => '',
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
				'carrier'         => (isset($trackers['tracker_carrier_name'])) ? $trackers['tracker_carrier_name'] : '',
				'tracking_number' => ($trackers && $data['tracking_numbers']) ? htmlspecialchars($data['tracking_numbers']) : '',
				'carrier_href'    => (isset($trackers['tracker_carrier_link'])) ? sprintf($trackers['tracker_carrier_link'], trim($data['tracking_numbers'])) : ''
		);

		$subject = trim(str_replace($find, $replace, $template['name']));
		$template = str_replace($find, $replace, $template['description']);

		$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_info['order_id'] . "', order_status_id = '" . (int)$data['order_status_id'] . "', notify = '" . (isset($data['notify']) ? (int)$data['notify'] : 0) . "', comment = '" . $this->db->escape($subject) . "<br /><br />" . $this->db->escape(nl2br($data['comment'])) . "', date_added = NOW()");

		if ($trackers) {
			$this->db->query("UPDATE " . DB_PREFIX . "order_history SET tracker_id = '" . (int)$data['tracker_id'] . "', tracking_numbers = '" . $this->db->escape(strip_tags($data['tracking_numbers'])) . "' WHERE order_history_id = '" . $this->db->getLastId() . "' AND order_id = '" . (int)$order_info['order_id'] . "'");
		}

		$str_track = false;

		if ($template_email['track']) {
			$history_id = $this->db->getLastId();
			$str_track = '<img src="' . str_replace('admin/', '', HTTPS_SERVER) . 'index.php?route=common/template_email/track&history_id=' . $history_id . '&act=log&code=' . md5($history_id . (int)$order_info['order_id'] . (int)$data['order_status_id']) . '&order_id=' . (int)$order_info['order_id'] . '" border="0" height="1" width="1">';

			if (stripos($template, '</body>') !== false) {
				$template = str_replace('</body>', $str_track . '</body>', $template);
			} else {
				$template .= $str_track;
			}
		}

		// Send out any gift voucher mails
		if ($this->config->get('config_complete_status_id') == $data['order_status_id']) {
			$this->load->model('sale/voucher');

			if ($v151)
				$results = $this->model_sale_voucher->getVouchersByOrderId($order_info['order_id']);
			else {
				$this->load->model('sale/order');

				$results = $this->model_sale_order->getOrderVouchers($order_info['order_id']);
			}

			foreach ($results as $result) {
				$this->model_sale_voucher->sendVoucher($result['voucher_id']);
			}
		}

      	if ($data['notify']) {
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

			if ($invoice_pdf) {
				require_once(DIR_SYSTEM . 'library/dompdf/dompdf_config.inc.php');

				$pdf = new DOMPDF;
				$pdf->load_html($invoice_pdf);
				$pdf->render();
				file_put_contents(DIR_CACHE . 'order_invoice.pdf', $pdf->output());
				$mail->addAttachment(DIR_CACHE . 'order_invoice.pdf', md5(basename(DIR_CACHE . 'order_invoice.pdf')));
			}

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
	
	public function sendCustomerApproveTemplateEmail($data, $template_email) {
		$special = array();

		if ($template_email['special'] > 0) {
			$special = $this->prepareProductSpecial((int)$data['customer_group_id'], $template_email['special']);
		}

		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{email}',
				'{account_href}',
				'{special}'
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $data['store_name'],
				'email'          => $data['email'],
				'account_href'   => $data['account_href'],
				'special'        => (sizeof($special) <> 0) ? implode("<br />", $special) : ''
		);

		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

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

	public function sendAffiliateApproveTemplateEmail($data, $template_email) {
		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{email}',
				'{account_href}'
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $data['store_name'],
				'email'          => $data['email'],
				'account_href'   => $data['account_href']
		);

		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

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

	public function sendAffiliateAddTransactionTemplateEmail($data, $template_email) {
		$find = array(
				'{firstname}',
				'{lastname}',
				'{date}',
				'{store_name}',
				'{description}',
				'{order_id}',
				'{amount}',
				'{total}',
				'{account_href}'
		);
		
		$replace = array(
				'firstname'      => $data['firstname'],
				'lastname'       => $data['lastname'],
				'date'           => date($this->language->get('date_format_short'), strtotime(date("Y-m-d H:i:s"))),
				'store_name'     => $data['store_name'],
				'description'    => nl2br($data['description']),
				'order_id'       => $data['order_id'],
				'amount'         => $data['amount'],
				'total'          => $data['total'],
				'account_href'   => $data['account_href']
		);

		$template = $template_email['description'][(int)$this->config->get('config_language_id')];

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

	private function prepareProductSpecial($customer_group_id, $limit) {
		$special = array();
		$product_special = $this->getProductSpecial((int)$customer_group_id, $limit);

		if (sizeof($product_special) > 0) {
			foreach ($product_special as $product) {
				$discount = round((($product['price'] - $product['special'])/$product['price'])*100, 0);

				$special[] = '<a href="' . str_replace('admin/', '', $this->rewriteSeoURL($this->url->link('product/product', 'product_id=' . $product['product_id'], 'SSL'))) . '">' . $product['name'] . '</a> (<font color="red">-' . $discount . '%</font>)';
			}
		}

		return $special;
	}

	public function rewriteSeoURL($link) {
		if ($this->config->get('config_seo_url')) {
			$url_data = parse_url(str_replace('&amp;', '&', $link));
		
			$url = ''; 
			
			$data = array();
			
			parse_str($url_data['query'], $data);
			
			foreach ($data as $key => $value) {
				if (isset($data['route'])) {
					if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/product' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
							
							unset($data[$key]);
						}					
					} elseif ($key == 'path') {
						$categories = explode('_', $value);
						
						foreach ($categories as $category) {
							$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");
					
							if ($query->num_rows) {
								$url .= '/' . $query->row['keyword'];
							}							
						}
						
						unset($data[$key]);
					}
				}
			}
		
			if ($url) {
				unset($data['route']);
			
				$query = '';
			
				if ($data) {
					foreach ($data as $key => $value) {
						$query .= '&' . $key . '=' . $value;
					}
					
					if ($query) {
						$query = '?' . trim($query, '&');
					}
				}

				return $url_data['scheme'] . '://' . $url_data['host'] . (isset($url_data['port']) ? ':' . $url_data['port'] : '') . str_replace('/index.php', '', $url_data['path']) . $url . $query;
			} else {
				return $link;
			}
		} else {
			return $link;
		}		
	}

	public function getTotalOrdersByDate($from, $to) {
		if ($this->config->get('template_email_send_invoice')) {
			$sql = "SELECT order_id FROM `" . DB_PREFIX . "order` WHERE invoice_sent = '0' AND invoice_no > '0'";

			if (date('Y-m-d', strtotime($from)) == $from) {
				$sql .= " AND UNIX_TIMESTAMP(SUBSTR(date_added, 0, 10)) >= '" . strtotime($from) . "'";
			}

			if (date('Y-m-d', strtotime($to)) == $to) {
				$sql .= " AND UNIX_TIMESTAMP(SUBSTR(date_added, 0, 10)) <= '" . strtotime($to) . "'";
			}

			$query = $this->db->query($sql);

			return $query->num_rows;
		} else {
			return 0;
		}
	}
}
?>