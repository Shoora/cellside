<?php
class ControllerModuleColorandsize extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/colorandsize');

		$this->document->setTitle($this->language->get('text_heading'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->request->post['colorandsize_colours'] = array();
			
			$colours = explode(",", $this->request->post['colorandsize_colour']);
			
			foreach ($colours as $colour) {
				$this->request->post['colorandsize_colours'][] = trim($colour);
			}
			
			$this->request->post['colorandsize_sizes'] = array();
			
			$sizes = explode(",", $this->request->post['colorandsize_size']);
			
			foreach ($sizes as $size) {
				$this->request->post['colorandsize_sizes'][] = trim($size);
			}
			
			unset($this->request->post['colorandsize_colour']);
			unset($this->request->post['colorandsize_size']);
			
			$this->model_setting_setting->editSetting('colorandsize', $this->request->post);
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('text_heading');
		
		$this->data['entry_colorandsize'] = $this->language->get('entry_colorandsize');
		$this->data['entry_colorandsize_plus'] = $this->language->get('entry_colorandsize_plus');
		$this->data['entry_colour'] = $this->language->get('entry_colour');
		$this->data['entry_size'] = $this->language->get('entry_size');
		
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_install'] = $this->language->get('text_install');
		$this->data['text_uninstall'] = $this->language->get('text_uninstall');
		
		$this->data['button_back'] = $this->language->get('button_back');
		$this->data['button_save'] = $this->language->get('button_save');

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
       		'text'      => $this->language->get('text_heading'),
			'href'      => $this->url->link('module/colorandsize', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/colorandsize', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['back'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cp'] = $this->cp();
		$this->data['cpp'] = $this->cpp();
		
		if (isset($this->request->post['colorandsize_colour'])) {
			$this->data['colour'] = $this->request->post['colorandsize_colour'];
		} elseif ($this->config->get('colorandsize_colours')) {
			$colours = '';
			
			foreach ($this->config->get('colorandsize_colours') as $colour) {
				$colours .= $colour . ', ';
			}
			
			$this->data['colour'] = substr($colours, 0, -2);
		} else {
			$this->data['colour'] = 'colour, color';
		}
		
		if (isset($this->request->post['colorandsize_size'])) {
			$this->data['size'] = $this->request->post['colorandsize_size'];
		} elseif ($this->config->get('colorandsize_sizes')) {
			$sizes = '';
			
			foreach ($this->config->get('colorandsize_sizes') as $size) {
				$sizes .= $size . ', ';
			}
			
			$this->data['size'] = substr($sizes, 0, -2);
		} else {
			$this->data['size'] = 'size';
		}
		
		if ($this->data['cp']) {
			$this->data['cp_action'] = $this->url->link('module/colorandsize/cp_uninstall', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['cp_action'] = $this->url->link('module/colorandsize/cp_install', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		if ($this->data['cpp']) {
			$this->data['cpp_action'] = $this->url->link('module/colorandsize/cpp_uninstall', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$this->data['cpp_action'] = $this->url->link('module/colorandsize/cpp_install', 'token=' . $this->session->data['token'], 'SSL');
		}
						
		$this->template = 'module/colorandsize.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function cpp() {
		$path = substr_replace(DIR_SYSTEM, '', -7);

		if (file_exists($path . 'vqmod/xml/colorandsizeplus.xml') || is_file($path . 'vqmod/xml/colorandsizeplus.xml')) {
			return true;
		} else {
			return false;
		}
	}
	
	private function cp() {
		$path = substr_replace(DIR_SYSTEM, '', -7);

		if (file_exists($path . 'vqmod/xml/colorandsize.xml') || is_file($path . 'vqmod/xml/colorandsize.xml')) {
			return true;
		} else {
			return false;
		}
	}
	
	public function cpp_install() {
		$this->load->language('module/colorandsize');

		if (!$this->user->hasPermission('modify', 'module/colorandsize')) {
			$this->session->data['error'] = $this->language->get('error_permission');
		} else {
			$path = substr_replace(DIR_SYSTEM, '', -7);

			if (file_exists($path . 'vqmod/xml/colorandsizeplus.xml_') || is_file($path . 'vqmod/xml/colorandsizeplus.xml_')) {
				rename($path . 'vqmod/xml/colorandsizeplus.xml_', $path . 'vqmod/xml/colorandsizeplus.xml');
				
				$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_option_value");
				$exists = false;
				
				foreach ($query->rows as $result) {
					if ($result['Field'] == 'option_image') {
						$exists = true;
						break;
					}
				}
				
				if (!$exists) {		
					$this->db->query("ALTER TABLE " . DB_PREFIX . "product_option_value ADD option_image varchar(255) NOT NULL AFTER quantity");
				}
				
				$this->session->data['success'] = $this->language->get('text_success');
				
				if ($this->cp()) {
					$this->cp_uninstall();
				}
			} else {
				$this->session->data['error'] = $this->language->get('error_install');
			}
		}

		$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	public function cpp_uninstall() {
		$this->load->language('module/colorandsize');

		if (!$this->user->hasPermission('modify', 'module/colorandsize')) {
			$this->session->data['error'] = $this->language->get('error_permission');
		} else {
			$path = substr_replace(DIR_SYSTEM, '', -7);

			if (file_exists($path . 'vqmod/xml/colorandsizeplus.xml') || is_file($path . 'vqmod/xml/colorandsizeplus.xml')) {
				rename($path . 'vqmod/xml/colorandsizeplus.xml', $path . 'vqmod/xml/colorandsizeplus.xml_');
				
				$query = $this->db->query("SHOW COLUMNS FROM " . DB_PREFIX . "product_option_value");
				$exists = false;
				
				foreach ($query->rows as $result) {
					if ($result['Field'] == 'option_image') {
						$exists = true;
						break;
					}
				}
				
				if ($exists) {
					$this->db->query("ALTER TABLE " . DB_PREFIX . "product_option_value DROP option_image");
				}
				
				$this->session->data['success'] = $this->language->get('text_success');
			} else {
				$this->session->data['error'] = $this->language->get('error_uninstall');
			}
		}

		$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	public function cp_install() {
		$this->load->language('module/colorandsize');

		if (!$this->user->hasPermission('modify', 'module/colorandsize')) {
			$this->session->data['error'] = $this->language->get('error_permission');
		} else {
			$path = substr_replace(DIR_SYSTEM, '', -7);

			if (file_exists($path . 'vqmod/xml/colorandsize.xml_') || is_file($path . 'vqmod/xml/colorandsize.xml_')) {
				rename($path . 'vqmod/xml/colorandsize.xml_', $path . 'vqmod/xml/colorandsize.xml');
				
				$this->session->data['success'] = $this->language->get('text_success');
				
				if ($this->cpp()) {
					$this->cpp_uninstall();
				}
			} else {
				$this->session->data['error'] = $this->language->get('error_install');
			}
		}

		$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	public function cp_uninstall() {
		$this->load->language('module/colorandsize');

		if (!$this->user->hasPermission('modify', 'module/colorandsize')) {
			$this->session->data['error'] = $this->language->get('error_permission');
		} else {
			$path = substr_replace(DIR_SYSTEM, '', -7);

			if (file_exists($path . 'vqmod/xml/colorandsize.xml') || is_file($path . 'vqmod/xml/colorandsize.xml')) {
				rename($path . 'vqmod/xml/colorandsize.xml', $path . 'vqmod/xml/colorandsize.xml_');
				
				$this->session->data['success'] = $this->language->get('text_success');
			} else {
				$this->session->data['error'] = $this->language->get('error_install');
			}
		}

		$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	public function install() {
		$this->load->model('setting/setting');
		
		$colours = array('colour', 'color');
		$sizes = array('size');
		
		$values = array('colorandsize_colours' => $colours, 'colorandsize_sizes' => $sizes);
	
		$this->model_setting_setting->editSetting('colorandsize', $values);
	}
	
	public function uninstall() {
		$path = substr_replace(DIR_SYSTEM, '', -7);

		if (file_exists($path . 'vqmod/xml/colorandsize.xml') || is_file($path . 'vqmod/xml/colorandsize.xml')) {
			rename($path . 'vqmod/xml/colorandsize.xml', $path . 'vqmod/xml/colorandsize.xml_');
		}
		
		if (file_exists($path . 'vqmod/xml/colorandsizeplus.xml') || is_file($path . 'vqmod/xml/colorandsizeplus.xml')) {
			rename($path . 'vqmod/xml/colorandsizeplus.xml', $path . 'vqmod/xml/colorandsizeplus.xml_');
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/colorandsize')) {
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