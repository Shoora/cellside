<?php 
class ControllerAccountAccount extends Controller { 

            private $_name = 'accountplus';
            
	public function index() {
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
	  
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	} 
	
		$this->language->load('account/account');

		$this->document->setTitle($this->language->get('heading_title'));

        		$this->language->load('module/accountplus');
        		
            	$this->data['heading_title_1'] = $this->language->get('heading_title_1');
            	$this->data['heading_title_2'] = $this->language->get('heading_title_2');
                
        		$this->data['text_logout'] = $this->language->get('text_logout');
        		$this->data['text_account'] = $this->language->get('text_account');
        		$this->data['text_edit'] = $this->language->get('text_edit');
        		$this->data['text_password'] = $this->language->get('text_password');
                $this->data['text_address'] = $this->language->get('text_address');
        		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
        		$this->data['text_order'] = $this->language->get('text_order');
        		$this->data['text_download'] = $this->language->get('text_download');
        		$this->data['text_return'] = $this->language->get('text_return');
        		$this->data['text_transaction'] = $this->language->get('text_transaction');
        		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
                $this->data['text_welcome'] = $this->language->get('text_welcome');
                $this->data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
                $this->data['text_my_orders'] = $this->language->get('text_my_orders');
                $this->data['text_my_account'] = $this->language->get('text_my_account');
                $this->data['text_reward'] = $this->language->get('text_reward');
$this->data['text_testimonial'] = $this->language->get('text_testimonial');
			$this->data['url_testimonial'] = $this->url->link('product/testimonial');
                $this->data['text_greeting_a'] = sprintf($this->language->get('text_logged'), $this->customer->getFirstName());
                                     
        		$this->data['logged'] = $this->customer->isLogged();
        		$this->data['logout'] = $this->url->link('account/logout', '', 'SSL');
                $this->data['address'] = $this->url->link('account/address', '', 'SSL');
        		$this->data['edit'] = $this->url->link('account/edit', '', 'SSL');
        		$this->data['password'] = $this->url->link('account/password', '', 'SSL');
        		$this->data['wishlist'] = $this->url->link('account/wishlist');
        		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
        		$this->data['download'] = $this->url->link('account/download', '', 'SSL');
        		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
        		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
        		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
                $this->data['reward'] = $this->url->link('account/reward', '', 'SSL');
                
                $this->data['title'] = $this->config->get($this->_name . '_title' . $this->config->get('config_language_id'));
        		$this->data['title_account'] = $this->config->get($this->_name . '_title_account' . $this->config->get('config_language_id'));
                $this->data['title_orders'] = $this->config->get($this->_name . '_title_orders' . $this->config->get('config_language_id'));
                $this->data['title_newsletter'] = $this->config->get($this->_name . '_title_newsletter' . $this->config->get('config_language_id'));
                $this->data['icon'] = $this->config->get($this->_name . '_icon');
                $this->data['email_icon'] = $this->config->get($this->_name . '_email_icon');
                $this->data['put_icon'] = $this->config->get($this->_name . '_put_icon');
                $this->data['welcome_a'] = $this->config->get($this->_name . '_welcome_a');
                $this->data['welcome_v'] = $this->config->get($this->_name . '_welcome_v');
                $this->data['tabs'] = $this->config->get($this->_name . '_tabs');
                $this->data['welcome_v'] = $this->config->get($this->_name . '_welcome_v');
                $this->data['bt_logout'] = $this->config->get($this->_name . '_bt_logout');
                $this->data['ico_logout'] = $this->config->get($this->_name . '_ico_logout');
                
                $this->data['account_link'] = $this->config->get($this->_name . '_account_link');
                $this->data['edit_link'] = $this->config->get($this->_name . '_edit_link');
                $this->data['password_link'] = $this->config->get($this->_name . '_password_link');
                $this->data['address_link'] = $this->config->get($this->_name . '_address_link');
                $this->data['wishlist_link'] = $this->config->get($this->_name . '_wishlist_link');
                $this->data['logout_link'] = $this->config->get($this->_name . '_logout_link');
                $this->data['order_link'] = $this->config->get($this->_name . '_order_link');
                $this->data['download_link'] = $this->config->get($this->_name . '_download_link');
                $this->data['reward_link'] = $this->config->get($this->_name . '_reward_link');
                $this->data['return_link'] = $this->config->get($this->_name . '_return_link');
                $this->data['transaction_link'] = $this->config->get($this->_name . '_transaction_link');
                $this->data['newsletter_link'] = $this->config->get($this->_name . '_newsletter_link');
                
                $this->data['text_edit_desc'] = $this->language->get('text_edit_desc');
                $this->data['text_password_desc'] = $this->language->get('text_password_desc');
                $this->data['text_address_desc'] = $this->language->get('text_address_desc');
                $this->data['text_wishlist_desc'] = $this->language->get('text_wishlist_desc');
                $this->data['text_order_desc'] = $this->language->get('text_order_desc');
                $this->data['text_download_desc'] = $this->language->get('text_download_desc');
                $this->data['text_reward_desc'] = $this->language->get('text_reward_desc');
                $this->data['text_return_desc'] = $this->language->get('text_return_desc');
                $this->data['text_transaction_desc'] = $this->language->get('text_transaction_desc');
                $this->data['text_newsletter_desc'] = $this->language->get('text_newsletter_desc');
                $this->data['text_logout_desc'] = $this->language->get('text_logout_desc');
                $this->data['text_logout'] = $this->language->get('text_logout');
                
                
                $this->data['style_a'] = $this->config->get($this->_name . '_style_a');
                 if (isset($this->request->post['style_a'])) {
        			$this->data['style_a'] = $this->request->post['style_a'];
        		} else {
        			$this->data['style_a'] = $this->config->get('style_a');
        		}   
                
                  $this->data['icotype_a'] = $this->config->get($this->_name . '_icotype_a');
                 if (isset($this->request->post['icotype_a'])) {
        			$this->data['icotype_a'] = $this->request->post['icotype_a'];
        		} else {
        			$this->data['icotype_a'] = $this->config->get('icotype_a');
        		}   
                
                   $this->data['head_ico'] = $this->config->get($this->_name . '_head_ico');
                 if (isset($this->request->post['head_ico'])) {
        			$this->data['head_ico'] = $this->request->post['head_ico'];
        		} else {
        			$this->data['head_ico'] = $this->config->get('head_ico');
        		}   
                    
        	   $this->load->model('localisation/language');
        		
        		$languages = $this->model_localisation_language->getLanguages();
        		
        		foreach ($languages as $language) {
        			if (isset($this->request->post[$this->_name . '_title_1' . $language['language_id']])) {
        				$this->data[$this->_name . '_title_1' . $language['language_id']] = $this->request->post[$this->_name . '_title_1' . $language['language_id']];
        			} else {
        				$this->data[$this->_name . '_title_1' . $language['language_id']] = $this->config->get($this->_name . '_title_1' . $language['language_id']);
        			}
                    
                    if (isset($this->request->post[$this->_name . '_title_2' . $language['language_id']])) {
        				$this->data[$this->_name . '_title_2' . $language['language_id']] = $this->request->post[$this->_name . '_title_2' . $language['language_id']];
        			} else {
        				$this->data[$this->_name . '_title_2' . $language['language_id']] = $this->config->get($this->_name . '_title_2' . $language['language_id']);
        			}
                   
        		}
            

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		if (isset($this->session->data['success'])) {
    		$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_my_account'] = $this->language->get('text_my_account');
		$this->data['text_my_orders'] = $this->language->get('text_my_orders');
		$this->data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
    	$this->data['text_edit'] = $this->language->get('text_edit');
    	$this->data['text_password'] = $this->language->get('text_password');
    	$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
    	$this->data['text_order'] = $this->language->get('text_order');
    	$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_reward'] = $this->language->get('text_reward');
$this->data['text_testimonial'] = $this->language->get('text_testimonial');
			$this->data['url_testimonial'] = $this->url->link('product/testimonial');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		$this->data['text_recurring'] = $this->language->get('text_recurring');

    	$this->data['edit'] = $this->url->link('account/edit', '', 'SSL');
    	$this->data['password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['address'] = $this->url->link('account/address', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist');
    	$this->data['order'] = $this->url->link('account/order', '', 'SSL');
    	$this->data['download'] = $this->url->link('account/download', '', 'SSL');
		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
		$this->data['recurring'] = $this->url->link('account/recurring', '', 'SSL');

		if ($this->config->get('reward_status')) {
			$this->data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$this->data['reward'] = '';
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/account.tpl';
		} else {
			$this->template = 'default/template/account/account.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'		
		);
				

				$this->data['ms_seller_created'] = $this->MsLoader->MsSeller->isCustomerSeller($this->customer->getId());
				$this->data = array_merge($this->data, $this->load->language('multiseller/multiseller'));
			
		$this->response->setOutput($this->render());
  	}
}
?>