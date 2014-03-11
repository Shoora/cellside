<?php
class ControllerCommonAdminCircloidWidgetEditor extends Controller {

	public function index() {
		$this->load->language('common/home');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['heading_widget_editor'] = $this->language->get('heading_widget_editor');

		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_close'] = $this->language->get('button_close');
		$this->data['button_save'] = $this->language->get('button_save');

		$this->data['text_widget_order_customer_statistic'] = $this->language->get('text_widget_order_customer_statistic');
		$this->data['text_widget_order_customer_statistic_day'] = $this->language->get('text_widget_order_customer_statistic_day');
		$this->data['text_widget_order_customer_statistic_week'] = $this->language->get('text_widget_order_customer_statistic_week');
		$this->data['text_widget_order_customer_statistic_month'] = $this->language->get('text_widget_order_customer_statistic_month');
		$this->data['text_widget_order_customer_statistic_year'] = $this->language->get('text_widget_order_customer_statistic_year');
		$this->data['text_widget_sales_value'] = $this->language->get('text_widget_sales_value');
		$this->data['text_widget_other_stats'] = $this->language->get('text_widget_other_stats');
		$this->data['text_widget_top_customers'] = $this->language->get('text_widget_top_customers');
		$this->data['text_widget_top_products'] = $this->language->get('text_widget_top_products');
		$this->data['text_widget_latest'] = $this->language->get('text_widget_latest');
		$this->data['text_layout_name'] = $this->language->get('text_layout_name');
		$this->data['text_layout_description'] = $this->language->get('text_layout_description');
		$this->data['text_disabled_widget_desc'] = $this->language->get('text_disabled_widget_desc');
		$this->data['text_enabled_widget_desc'] = $this->language->get('text_enabled_widget_desc');
		$this->data['text_screen_too_small'] = $this->language->get('text_screen_too_small');

		$this->data['title_enabled_widgets'] = $this->language->get('title_enabled_widgets');
		$this->data['title_disabled_widgets'] = $this->language->get('title_disabled_widgets');
		
		$this->data['button_preview_layout'] = $this->language->get('button_preview_layout');


		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
			);

		$this->data['token'] = $this->session->data['token'];

		$this->data['return_dashboard_editor'] = $this->url->link('common/admin_circloid_dashboard_editor', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['error_widget_editor'] = sprintf($this->language->get('error_widget_editor'), $this->data['return_dashboard_editor']);

		$this->load->model('common/admin_circloid_dashboard_editor');

		if(isset($this->request->get['layout_id'])){
			$this->data['user_created'] = $this->model_common_admin_circloid_dashboard_editor->checkLayoutCreator($this->request->get['layout_id']);
			if($this->data['user_created']){
				$this->data['widget_data'] = $this->model_common_admin_circloid_dashboard_editor->getWidget($this->request->get['layout_id']);
			}
		}else{
			$this->data['user_created'] = FALSE;
		}


		$this->template = 'admin_theme/base5builder_circloid/common/admin_circloid_widget_editor.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
			);

		$this->response->setOutput($this->render());
	}

	public function updateWidgetLayout(){

		$this->load->language('common/home');

		if (!$this->user->hasPermission('modify', 'common/admin_circloid_widget_editor')) {

			$data['error_layout_updated'] = $this->language->get('error_permission');

		}else{

			$layout['id'] = $this->request->get['layout_id'];
			$layout['layout_name'] = $this->request->get['layout_name'];
			$layout['description'] = $this->request->get['layout_description'];
			$layout['layout'] = htmlspecialchars_decode(urldecode($this->request->get['layout']));

			if(ctype_digit($layout['id']) || !empty($layout['id'])){

				if($this->alpha_dash_space_ampersand($layout['layout_name']) && !empty($layout['layout_name']) && (strlen($layout['layout_name']) >= 3 && strlen($layout['layout_name']) <= 35)){

					if($this->alpha_dash_space_ampersand($layout['description']) || !empty($layout['description']) || (strlen($layout['description']) >= 3 && strlen($layout['description']) <= 100)){

						// Call the settings model
						$this->load->model('common/admin_circloid_dashboard_editor');

						// Copy Widget Layout and return True/False
						$data['widget_layout_updated'] = $this->model_common_admin_circloid_dashboard_editor->updateWidgetLayout($layout['id'], $layout['layout_name'], $layout['description'], $layout['layout']);

						if($data['widget_layout_updated']){
							$data['success_layout_updated'] = $this->language->get('success_layout_updated');
						}else{
							$data['error_layout_updated'] = $this->language->get('error_layout_updated');
						}

					}else{

						// display error
						$data['error_layout_updated'] = $this->language->get('error_layout_updated');
						$data['error_layout_updated'] .= $this->language->get('error_layout_updated_description');

					}
				}else{

					// display error
					$data['error_layout_updated'] = $this->language->get('error_layout_updated');
					$data['error_layout_updated'] .= $this->language->get('error_layout_updated_name');
				}
			}else{

				// display error
				$data['error_layout_updated'] = $this->language->get('error_layout_updated');
				$data['error_layout_updated'] .= $this->language->get('error_layout_updated_id');
			}
		}

		$this->response->setOutput(json_encode($data));
	}

	private function alpha_dash_space_ampersand($value){
		if(isset($value) && $value != ""){
			if(!preg_match("/^([-a-z0-9& ])+.,$/i", $value)){
				return TRUE;
			}else{
				return FALSE;
			}
		}
	}
}

?>