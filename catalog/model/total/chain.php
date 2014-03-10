<?php
/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/

class ModelTotalChain extends Model {
	
	public function getTotal(&$total_data, &$total, &$taxes) {
		
		if (version_compare(VERSION, '1.5.5', '>='))
			{
				$this->language->load('total/chain');
			}
		else 
			{
				$this->load->language('total/chain');
			}
	 
		$discount_total = $this->_get_discount();
		$total -= $discount_total;
		
		if ($this->config->get('chain_chane_totals_color')) {
			$style 	= '<style>.combination_discount_sys { color: '.$this->config->get('chain_totals_color').' }</style>';
			$text 	= '<span class="combination_discount combination_discount_sys">- '.$this->currency->format($discount_total) . '</span>';
		} else {
			$style 	= '';
			$text 	= '- '. $this->currency->format($discount_total);
		}
		
		if ($discount_total > 0) 
			{
				$total_data[] = array(
					'code'       => 'chain',
					'title'      => $this->language->get('combination_discount'),
					'text'       => $style . $text,
					'value'      => 0 - $discount_total,
					'sort_order' => $this->config->get('chain_sort_order')
				);
			}
		
	}
	
	private function _get_discount() {
		
		if (!isset($this->session->data['chain']) or count($this->session->data['chain']) == 0 
				or (isset($this->request->post['chain_last_product']) and $this->request->post['chain_last_product'] != 1)
				or !isset($this->session->data['cart'])) {
			return 0;
		}
		
		$save = 0;
		
		$cart = array();
		
		foreach ($this->session->data['cart'] as $key => $quantity) {
				$product = explode(':', $key);
				if (!isset($cart[$product[0]] )) {
					$cart[$product[0]] = $quantity;
				} else {
					$cart[$product[0]] += $quantity;
				}
		}
		
		foreach ($this->session->data['chain'] as $key => $chain) {
			
			if (!isset($chain['quantity']) || !is_array($chain['quantity'])) {
				$chain['quantity'] = array();
			}
				
			foreach ($chain['products'] as $product_id) {
			
				if (isset($chain['quantity'][$product_id]) && is_numeric($chain['quantity'][$product_id])) {
					$product_quantity = $chain['quantity'][$product_id];
				} else {
					$product_quantity = 1;
				}
				
				if (array_key_exists($product_id, $cart) && $cart[$product_id] - $product_quantity >= 0) {
					$cart[$product_id] = $cart[$product_id] - $product_quantity;
				} else {
				
					unset($this->session->data['chain'][$key]);
					return $this->_get_discount();
				}
			}
			
			$save += $chain['save'];
		}
		
		return $save;
	}
}