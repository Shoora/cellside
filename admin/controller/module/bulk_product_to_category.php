<?php
class ControllerModuleBulkProductToCategory extends Controller {
	private $error = array();

	public function index() {

		// Compatibility for tokens
		if(empty($this->session->data['token'])) $this->session->data['token'] = '';

		// Load language and set title
		$this->data = array_merge($this->data, $this->language->load('module/bulk_product_to_category'));
		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('view/javascript/jquery/module/bulk_product_to_category.js');

		// Load Models
		$this->load->model('setting/setting');
		$this->load->model('tool/image');
		$this->load->model('module/bulk_product_to_category');
		$this->load->model('catalog/manufacturer');

		// Error check
		$this->data['error_warning'] = empty($this->error['warning']) ? '' : $this->error['warning'];

		// Add breadcrumbs
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
			'href'      => $this->url->link('module/bulk_product_to_category', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

		// Cancel button URL
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		// Load category list
		$this->data['categories'] = $this->model_module_bulk_product_to_category->getCategories();
		
		// Load manufacturers list
		$this->data['manufacturers'] = $this->model_catalog_manufacturer->getManufacturers();

		// Load product list
		$products = $this->model_module_bulk_product_to_category->getProducts();
		$productCategories = $this->model_module_bulk_product_to_category->getProductCategories();
		
		foreach($products as &$product) {
			if(empty($product['image'])) $product['image'] = 'no_image.jpg';
			$product['thumb'] = $this->model_tool_image->resize($product['image'], 120, 120);
			$product['categories'] = empty($productCategories[$product['product_id']]) ? '' : $productCategories[$product['product_id']];
		}
		$this->data['products'] = $products;

		// Load template
		$this->template = 'module/bulk_product_to_category.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
	}

	public function getProductsByCategory() {
		$category_id = empty($this->request->get['category_id']) ? 0 : (int)$this->request->get['category_id'];
		$output = array();

		if($category_id) {
			$this->load->model('module/bulk_product_to_category');
			$products = $this->model_module_bulk_product_to_category->getProductsByCategory($category_id);
			if($products) {
				foreach($products as $product) {
					$output[] = $product['product_id'];
				}
			}
		}

		$this->outputJSON($output);
	}

	public function SaveProductsToCategory() {
		$this->language->load('module/bulk_product_to_category');
		if(!$this->validate()) die($this->language->get('text_not_saved'));
		$category_id = empty($this->request->get['category_id']) ? 0 : (int)$this->request->get['category_id'];
		$products = empty($this->request->post['products']) ? array() : $this->request->post['products'];

		if($category_id) {
			$this->load->model('module/bulk_product_to_category');
			$this->model_module_bulk_product_to_category->saveProductsToCategory($category_id, $products);
			$this->cache->delete('product');
			$this->cache->delete('category');
			echo $this->language->get('text_saved');
		} else {
			echo $this->language->get('text_not_saved');

		}

	}

	private function outputJSON($data) {
		if(file_exists(DIR_SYSTEM . 'library/json.php')){
			$this->load->library('json');
			echo JSON::encode($data);
		} else {
			echo json_encode($data);
		}
		die();
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/bulk_product_to_category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return (!$this->error);
	}

}

?>