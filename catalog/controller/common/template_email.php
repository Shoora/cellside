<?php   
class ControllerCommonTemplateEmail extends Controller {
	public function track() {
		if (function_exists("date_default_timezone_set") && function_exists("date_default_timezone_get")) {
			date_default_timezone_set(date_default_timezone_get());
		}

		if (!isset($this->request->get['act']) || $this->request->get['act'] != 'log') {
			return;
		}

		if (!isset($this->request->get['history_id']) || (!isset($this->request->get['code']) || strlen($this->request->get['code']) < 32) || !isset($this->request->get['order_id'])) {
			return;
		}

		$this->load->model('catalog/template_email');

		$result = $this->model_catalog_template_email->getTrackStatusEmail($this->request->get['history_id'], $this->request->get['code']);

		if ($result[0]) {
			$this->language->load('common/template_email');

			if ($result[1] != '----------' && $result[1] != '') {
				preg_match('/([0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2})/is', $result[1], $date);

				$message = sprintf($this->language->get('text_last_reading'), $date[1], date("d/m/Y H:i:s"), $this->getIp());
			} else {
				$message = sprintf($this->language->get('text_first_reading'), date("d/m/Y H:i:s"), $this->getIp());
			}

			$this->model_catalog_template_email->addTrackStatusEmail($this->request->get['history_id'], $message);
		}

		header('Content-Type: image/' . substr(strrchr($this->config->get('config_logo'), '.'), 1));
		readfile(DIR_IMAGE . $this->config->get('config_logo'));
	}

	public function croninvoice() {
		if ($this->config->get('template_email_send_invoice')) {
			$this->load->model('catalog/template_email');

			$max_loop = 8;
			$i = 0;

			$orders = $this->model_catalog_template_email->getOrdersByDate($this->config->get('template_email_send_invoice_from'), $this->config->get('template_email_send_invoice_to'));

			foreach ($orders as $order) {
				$result = $this->model_catalog_template_email->getTemplateEmail('cron.invoice');
			
				if ((sizeof($result['description']) > 0) && ($result['status'] == '0' || $result['status'] == '')) {
					$this->model_catalog_template_email->sendInvoiceTemplateEmail($order, $result, $this->invoice($order['order_id'], $order));

					sleep(2);
				}

				++$i;

				if ($i >= $max_loop)
					return;
			}
		}
	}

	private function getIp() {
		$ip = '';

		if (isset($_SERVER)) {
			if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
			elseif (isset($_SERVER['HTTP_CLIENT_IP']))   $ip = $_SERVER['HTTP_CLIENT_IP'];
			else                                         $ip = $_SERVER['REMOTE_ADDR'];
		} else {
			if (getenv('HTTP_X_FORWARDED_FOR')) $ip = getenv('HTTP_X_FORWARDED_FOR');
			elseif (getenv('HTTP_CLIENT_IP'))   $ip = getenv('HTTP_CLIENT_IP');
			else                                $ip = getenv('REMOTE_ADDR');
		}

		return $ip;
	}

	private function invoice($order_id, $order_info) {
		$this->load->model('localisation/language');

		$language_info = $this->model_localisation_language->getLanguage($order_info['language_id']);

		if ($language_info) {
			$language_filename = $language_info['filename'];
			$language_directory = $language_info['directory'];
		} else {
			$language_info = $this->model_localisation_language->getLanguage($this->config->get('config_language_id'));

			$language_filename = $language_info->row['filename'];
			$language_directory = $language_info->row['directory'];
		}

		$language = new Language($language_directory);
		$language->load($language_filename);
		$language->loadlanguage('sale/order');

		$this->data['title'] = $language->get('heading_title');

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}

		$v151 = (defined('VERSION') && strpos(VERSION, '1.5.1') === 0);
		$v1513 = (defined('VERSION') && strpos(VERSION, '1.5.1.3') === 0);
		$v152 = (defined('VERSION') && strpos(VERSION, '1.5.2') === 0);

		$this->data['direction'] = $language->get('direction');
		$this->data['language'] = $language->get('code');

		$this->data['text_invoice'] = $language->get('text_invoice');

		$this->data['text_order_id'] = $language->get('text_order_id');
		$this->data['text_invoice_no'] = $language->get('text_invoice_no');
		$this->data['text_invoice_date'] = $language->get('text_invoice_date');
		$this->data['text_date_added'] = $language->get('text_date_added');
		$this->data['text_telephone'] = $language->get('text_telephone');
		$this->data['text_fax'] = $language->get('text_fax');
		$this->data['text_to'] = $language->get('text_to');
		$this->data['text_company_id'] = (!$v151 && !$v152) ? $language->get('text_company_id') : '';
		$this->data['text_tax_id'] = (!$v151 && !$v152) ? $language->get('text_tax_id') : '';		
		$this->data['text_ship_to'] = $language->get('text_ship_to');
		$this->data['text_payment_method'] = (!$v151) ? $language->get('text_payment_method') : '';
		$this->data['text_shipping_method'] = (!$v151) ? $language->get('text_shipping_method') : '';

		$this->data['column_product'] = $language->get('column_product');
		$this->data['column_model'] = $language->get('column_model');
		$this->data['column_quantity'] = $language->get('column_quantity');
		$this->data['column_price'] = $language->get('column_price');
		$this->data['column_total'] = $language->get('column_total');
		$this->data['column_comment'] = $language->get('column_comment');

		$this->load->model('catalog/template_email');

		$this->data['orders'] = array();

		if ($order_info) {
			$store_info = $this->model_catalog_template_email->getSetting('config', $order_info['store_id']);
				
			if ($store_info) {
				$store_address = $store_info['config_address'];
				$store_email = $store_info['config_email'];
				$store_telephone = $store_info['config_telephone'];
				$store_fax = $store_info['config_fax'];
			} else {
				$store_address = $this->config->get('config_address');
				$store_email = $this->config->get('config_email');
				$store_telephone = $this->config->get('config_telephone');
				$store_fax = $this->config->get('config_fax');
			}

			$invoice_no = $order_info['invoice_prefix'] . $order_info['invoice_no'];

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
					'zone_code' => $this->model_catalog_template_email->getShippingZoneCode($order_info['shipping_zone_id']),
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
					'zone_code' => $this->model_catalog_template_email->getPaymentZoneCode($order_info['payment_zone_id']),
					'country'   => $order_info['payment_country']
			);

			$payment_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

			$product_data = array();

			$products = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_product` WHERE order_id = '" . (int)$order_id . "'");

			foreach ($products->rows as $product) {
				$option_data = array();

				$options = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

				foreach ($options->rows as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						if ($v151) {
							$value = substr($option['value'], 0, strrpos($option['value'], '.'));
						} else {
							$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
						}
					}
						
					$option_data[] = array(
						'name'  => $option['name'],
						'value' => $value
					);								
				}

				$product_data[] = array(
					'name'     => $product['name'],
					'model'    => $product['model'],
					'option'   => $option_data,
					'quantity' => $product['quantity'],
					'price'    => (!$v151 && !$v152) ? $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']) : $this->currency->format($product['price'], $order_info['currency_code'], $order_info['currency_value']),
					'total'    => (!$v151 && !$v152) ? $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']) : $this->currency->format($product['total'], $order_info['currency_code'], $order_info['currency_value'])
				);
			}
				
			$voucher_data = array();

			if (!$v151) {
				$vouchers = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");

				foreach ($vouchers->rows as $voucher) {
					$voucher_data[] = array(
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value'])			
					);
				}
			}

			$total_data = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order");

			$this->data['orders'][] = array(
				'order_id'	         => $order_id,
				'invoice_no'         => $invoice_no,
				'invoice_date'       => ($v151 && !$v1513) ? date($language->get('date_format_short'), strtotime('now')) : '',
				'date_added'         => date($language->get('date_format_short'), strtotime($order_info['date_added'])),
				'store_name'         => $order_info['store_name'],
				'store_url'          => rtrim($order_info['store_url'], '/'),
				'store_address'      => nl2br($store_address),
				'store_email'        => $store_email,
				'store_telephone'    => $store_telephone,
				'store_fax'          => $store_fax,
				'email'              => $order_info['email'],
				'telephone'          => $order_info['telephone'],
				'shipping_address'   => $shipping_address,
				'shipping_method'    => (!$v151) ? $order_info['shipping_method'] : '',
				'payment_address'    => $payment_address,
				'payment_company_id' => (!$v151 && !$v152) ? $order_info['payment_company_id'] : '',
				'payment_tax_id'     => (!$v151 && !$v152) ? $order_info['payment_tax_id'] : '',
				'payment_method'     => (!$v151) ? $order_info['payment_method'] : '',
				'product'            => $product_data,
				'voucher'            => $voucher_data,
				'total'              => $total_data->rows,
				'comment'            => nl2br($order_info['comment'])
			);
		}

		extract($this->data);

      	ob_start();
		header('Content-Type: text/html; charset=utf-8');

	  	require(str_replace(array('catalog', 'theme'), array('admin', 'template'), DIR_TEMPLATE) . 'sale/order_invoice.tpl');

	  	$output = str_replace('view/stylesheet/invoice.css', 'admin/view/stylesheet/invoice.css', ob_get_contents());

      	ob_end_clean();

		return $output;
	}
}
?>