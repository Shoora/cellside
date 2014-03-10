<?php
class ControllerModuleAccountPlus extends Controller {
	private $error = array();
    private $_name = 'accountplus';
	
	public function index() {   
		$this->language->load('module/accountplus');

		$this->document->setTitle($this->language->get('heading_title'));
		 
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('accountplus', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		
		
		$this->data['text_general_display'] = $this->language->get('text_general_display');
        $this->data['text_links_display'] = $this->language->get('text_links_display');
        $this->data['entry_links_display'] = $this->language->get('entry_links_display');
        
        
        $this->data['entry_logout_link'] = $this->language->get('entry_logout_link');
        $this->data['entry_edit_link'] = $this->language->get('entry_edit_link');
        $this->data['entry_password_link'] = $this->language->get('entry_password_link');
        $this->data['entry_address_link'] = $this->language->get('entry_address_link');
        $this->data['entry_wishlist_link'] = $this->language->get('entry_wishlist_link');
        $this->data['entry_order_link'] = $this->language->get('entry_order_link');
        $this->data['entry_download_link'] = $this->language->get('entry_download_link');
        $this->data['entry_return_link'] = $this->language->get('entry_return_link');
        $this->data['entry_transaction_link'] = $this->language->get('entry_transaction_link');
        $this->data['entry_reward_link'] = $this->language->get('entry_reward_link');
        $this->data['entry_newsletter_link'] = $this->language->get('entry_newsletter_link');
        
		$this->data['text_tab_account'] = $this->language->get('text_tab_account');
        $this->data['text_tab_affiliate'] = $this->language->get('text_tab_affiliate');
        
        $this->data['text_account_link'] = $this->language->get('text_account_link');
		$this->data['text_order_link'] = $this->language->get('text_order_link');
		$this->data['text_newsletter_link'] = $this->language->get('text_newsletter_link');


        $this->data['entry_edit_link_a'] = $this->language->get('entry_edit_link_a');
        $this->data['entry_password_link_a'] = $this->language->get('entry_password_link_a');
        $this->data['entry_payment_link_a'] = $this->language->get('entry_payment_link_a');
        $this->data['entry_tracking_link_a'] = $this->language->get('entry_tracking_link_a');
        $this->data['entry_transaction_link_a'] = $this->language->get('entry_transaction_link_a');
        $this->data['entry_logout_link_a'] = $this->language->get('entry_logout_link_a');



        $this->data['text_account_link_a'] = $this->language->get('text_account_link_a');
		$this->data['text_tracking_link_a'] = $this->language->get('text_tracking_link_a');
		$this->data['text_transaction_link_a'] = $this->language->get('text_transaction_link_a');



        $this->data['text_custom_title'] = $this->language->get('text_custom_title');
        $this->data['text_styles'] = $this->language->get('text_styles');
        $this->data['text_display'] = $this->language->get('text_display');
        $this->data['text_modules'] = $this->language->get('text_modules');
        
        $this->data['entry_tabs'] = $this->language->get('entry_tabs'); 
        $this->data['entry_tabs_a'] = $this->language->get('entry_tabs_a');
		$this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_title_account'] = $this->language->get('entry_title_account');
        $this->data['entry_title_orders'] = $this->language->get('entry_title_orders');
        $this->data['entry_title_newsletter'] = $this->language->get('entry_title_newsletter');

		$this->data['entry_title_a'] = $this->language->get('entry_title_a');
        $this->data['entry_title_account_a'] = $this->language->get('entry_title_account_a');
        $this->data['entry_title_tracking_a'] = $this->language->get('entry_title_tracking_a');
        $this->data['entry_title_transaction_a'] = $this->language->get('entry_title_transaction_a');
        $this->data['tab_account'] = $this->language->get('tab_account');
        $this->data['tab_affiliate'] = $this->language->get('tab_affiliate');

		$this->data['entry_icon'] = $this->language->get('entry_icon');
        $this->data['entry_icons'] = $this->language->get('entry_icons');
        
        $this->data['entry_welcome_a'] = $this->language->get('entry_welcome_a');
        $this->data['entry_welcome_af'] = $this->language->get('entry_welcome_af');
        
        
        
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
 		$this->data['entry_yes'] = $this->language->get('entry_yes');
        $this->data['entry_no'] = $this->language->get('entry_no');
        $this->data['entry_style'] = $this->language->get('entry_style');
        $this->data['entry_icotype'] = $this->language->get('entry_icotype');
        
               
        $this->load->model('localisation/language');
		
		$languages = $this->model_localisation_language->getLanguages();
		
		foreach ($languages as $language) {
		    if (isset($this->request->post[$this->_name . '_title' . $language['language_id']])) {
			$this->data[$this->_name . '_title' . $language['language_id']] = $this->request->post[$this->_name . '_title' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title' . $language['language_id']] = $this->config->get($this->_name . '_title' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_account' . $language['language_id']])) {
			$this->data[$this->_name . '_title_account' . $language['language_id']] = $this->request->post[$this->_name . '_title_account' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_account' . $language['language_id']] = $this->config->get($this->_name . '_title_account' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_orders' . $language['language_id']])) {
			$this->data[$this->_name . '_title_orders' . $language['language_id']] = $this->request->post[$this->_name . '_title_orders' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_orders' . $language['language_id']] = $this->config->get($this->_name . '_title_orders' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_newsletter' . $language['language_id']])) {
			$this->data[$this->_name . '_title_newsletter' . $language['language_id']] = $this->request->post[$this->_name . '_title_newsletter' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_newsletter' . $language['language_id']] = $this->config->get($this->_name . '_title_newsletter' . $language['language_id']);
            }
               
		        
		    if (isset($this->request->post[$this->_name . '_title_a' . $language['language_id']])) {
			$this->data[$this->_name . '_title_a' . $language['language_id']] = $this->request->post[$this->_name . '_title_a' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_a' . $language['language_id']] = $this->config->get($this->_name . '_title_a' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_account_a' . $language['language_id']])) {
			$this->data[$this->_name . '_title_account_a' . $language['language_id']] = $this->request->post[$this->_name . '_title_account_a' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_account_a' . $language['language_id']] = $this->config->get($this->_name . '_title_account_a' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_tracking_a' . $language['language_id']])) {
			$this->data[$this->_name . '_title_tracking_a' . $language['language_id']] = $this->request->post[$this->_name . '_title_tracking_a' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_tracking_a' . $language['language_id']] = $this->config->get($this->_name . '_title_tracking_a' . $language['language_id']);
            }
            
            if (isset($this->request->post[$this->_name . '_title_transaction_a' . $language['language_id']])) {
			$this->data[$this->_name . '_title_transaction_a' . $language['language_id']] = $this->request->post[$this->_name . '_title_transaction_a' . $language['language_id']];
            } else {
			$this->data[$this->_name . '_title_transaction_a' . $language['language_id']] = $this->config->get($this->_name . '_title_transaction_a' . $language['language_id']);
            }
        
        }
		
		$this->data['languages'] = $languages;
	
        if (isset($this->request->post[$this->_name . '_tabs'])) { 
			$this->data[$this->_name . '_tabs'] = $this->request->post[$this->_name . '_tabs']; 
		} else { 
			$this->data[$this->_name . '_tabs'] = $this->config->get($this->_name . '_tabs' ); 
		} 

        if (isset($this->request->post[$this->_name . '_tabs_a'])) { 
			$this->data[$this->_name . '_tabs_a'] = $this->request->post[$this->_name . '_tabs_a']; 
		} else { 
			$this->data[$this->_name . '_tabs_a'] = $this->config->get($this->_name . '_tabs_a' ); 
		} 

        if (isset($this->request->post[$this->_name . '_welcome_a'])) { 
			$this->data[$this->_name . '_welcome_a'] = $this->request->post[$this->_name . '_welcome_a']; 
		} else { 
			$this->data[$this->_name . '_welcome_a'] = $this->config->get($this->_name . '_welcome_a' ); 
		} 

        if (isset($this->request->post[$this->_name . '_welcome_af'])) { 
			$this->data[$this->_name . '_welcome_af'] = $this->request->post[$this->_name . '_welcome_af']; 
		} else { 
			$this->data[$this->_name . '_welcome_af'] = $this->config->get($this->_name . '_welcome_af' ); 
		} 

        if (isset($this->request->post[$this->_name . '_logout_link'])) { 
			$this->data[$this->_name . '_logout_link'] = $this->request->post[$this->_name . '_logout_link']; 
		} else { 
			$this->data[$this->_name . '_logout_link'] = $this->config->get($this->_name . '_logout_link' ); 
		} 
        
        if (isset($this->request->post[$this->_name . '_logout_link_a'])) { 
			$this->data[$this->_name . '_logout_link_a'] = $this->request->post[$this->_name . '_logout_link_a']; 
		} else { 
			$this->data[$this->_name . '_logout_link_a'] = $this->config->get($this->_name . '_logout_link_a' ); 
		} 
        
        if (isset($this->request->post[$this->_name . '_password_link'])) { 
			$this->data[$this->_name . '_password_link'] = $this->request->post[$this->_name . '_password_link']; 
		} else { 
			$this->data[$this->_name . '_password_link'] = $this->config->get($this->_name . '_password_link' ); 
		}  
        
        if (isset($this->request->post[$this->_name . '_password_link_a'])) { 
			$this->data[$this->_name . '_password_link_a'] = $this->request->post[$this->_name . '_password_link_a']; 
		} else { 
			$this->data[$this->_name . '_password_link_a'] = $this->config->get($this->_name . '_password_link_a' ); 
		}  
        
        if (isset($this->request->post[$this->_name . '_edit_link'])) { 
			$this->data[$this->_name . '_edit_link'] = $this->request->post[$this->_name . '_edit_link']; 
		} else { 
			$this->data[$this->_name . '_edit_link'] = $this->config->get($this->_name . '_edit_link' ); 
		} 

        if (isset($this->request->post[$this->_name . '_edit_link_a'])) { 
			$this->data[$this->_name . '_edit_link_a'] = $this->request->post[$this->_name . '_edit_link_a']; 
		} else { 
			$this->data[$this->_name . '_edit_link_a'] = $this->config->get($this->_name . '_edit_link_a' ); 
		} 

        if (isset($this->request->post[$this->_name . '_address_link'])) { 
			$this->data[$this->_name . '_address_link'] = $this->request->post[$this->_name . '_address_link']; 
		} else { 
			$this->data[$this->_name . '_address_link'] = $this->config->get($this->_name . '_address_link' ); 
		} 
        
        if (isset($this->request->post[$this->_name . '_payment_link_a'])) { 
			$this->data[$this->_name . '_payment_link_a'] = $this->request->post[$this->_name . '_payment_link_a']; 
		} else { 
			$this->data[$this->_name . '_payment_link_a'] = $this->config->get($this->_name . '_payment_link_a' ); 
		} 

        if (isset($this->request->post[$this->_name . '_wishlist_link'])) { 
			$this->data[$this->_name . '_wishlist_link'] = $this->request->post[$this->_name . '_wishlist_link']; 
		} else { 
			$this->data[$this->_name . '_wishlist_link'] = $this->config->get($this->_name . '_wishlist_link' ); 
		} 
        
        if (isset($this->request->post[$this->_name . '_tracking_link_a'])) { 
			$this->data[$this->_name . '_tracking_link_a'] = $this->request->post[$this->_name . '_tracking_link_a']; 
		} else { 
			$this->data[$this->_name . '_tracking_link_a'] = $this->config->get($this->_name . '_tracking_link_a' ); 
		} 

        if (isset($this->request->post[$this->_name . '_transaction_link_a'])) { 
			$this->data[$this->_name . '_transaction_link_a'] = $this->request->post[$this->_name . '_transaction_link_a']; 
		} else { 
			$this->data[$this->_name . '_transaction_link_a'] = $this->config->get($this->_name . '_transaction_link_a' ); 
		} 
        
        if (isset($this->request->post[$this->_name . '_order_link'])) { 
			$this->data[$this->_name . '_order_link'] = $this->request->post[$this->_name . '_order_link']; 
		} else { 
			$this->data[$this->_name . '_order_link'] = $this->config->get($this->_name . '_order_link' ); 
		} 
        
        
        if (isset($this->request->post[$this->_name . '_download_link'])) { 
			$this->data[$this->_name . '_download_link'] = $this->request->post[$this->_name . '_download_link']; 
		} else { 
			$this->data[$this->_name . '_download_link'] = $this->config->get($this->_name . '_download_link' ); 
		} 
        
        
        if (isset($this->request->post[$this->_name . '_return_link'])) { 
			$this->data[$this->_name . '_return_link'] = $this->request->post[$this->_name . '_return_link']; 
		} else { 
			$this->data[$this->_name . '_return_link'] = $this->config->get($this->_name . '_return_link' ); 
		} 
        
        
        if (isset($this->request->post[$this->_name . '_transaction_link'])) { 
			$this->data[$this->_name . '_transaction_link'] = $this->request->post[$this->_name . '_transaction_link']; 
		} else { 
			$this->data[$this->_name . '_transaction_link'] = $this->config->get($this->_name . '_transaction_link' ); 
		} 
        
        
        if (isset($this->request->post[$this->_name . '_newsletter_link'])) { 
			$this->data[$this->_name . '_newsletter_link'] = $this->request->post[$this->_name . '_newsletter_link']; 
		} else { 
			$this->data[$this->_name . '_newsletter_link'] = $this->config->get($this->_name . '_newsletter_link' ); 
		} 
        
        
        if (isset($this->request->post[$this->_name . '_reward_link'])) { 
			$this->data[$this->_name . '_reward_link'] = $this->request->post[$this->_name . '_reward_link']; 
		} else { 
			$this->data[$this->_name . '_reward_link'] = $this->config->get($this->_name . '_reward_link' ); 
		} 

        
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
        
        $this->data['style_af'] = $this->config->get($this->_name . '_style_af');
        if (isset($this->request->post['style_af'])) {
			$this->data['style_af'] = $this->request->post['style_af'];
		} else {
			$this->data['style_af'] = $this->config->get('style_af');
		}   
        
        $this->data['icotype_af'] = $this->config->get($this->_name . '_icotype_af');
        if (isset($this->request->post['icotype_af'])) {
			$this->data['icotype_af'] = $this->request->post['icotype_af'];
		} else {
			$this->data['icotype_af'] = $this->config->get('icotype_af');
		}   

        
        if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

          $this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/accountplus', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/accountplus', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['modules'] = array();
		
		if (isset($this->request->post['accountplus_module'])) {
			$this->data['modules'] = $this->request->post['accountplus_module'];
		} elseif ($this->config->get('accountplus_module')) { 
			$this->data['modules'] = $this->config->get('accountplus_module');
		}	
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
						
		$this->template = 'module/accountplus.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/accountplus')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>