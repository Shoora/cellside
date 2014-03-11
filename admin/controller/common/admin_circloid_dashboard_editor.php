<?php
class ControllerCommonAdminCircloidDashboardEditor extends Controller {

	public function index(){
		$this->language->load('common/home');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['heading_title'] = $this->language->get('heading_title');


		$this->data['heading_dashboard_editor'] = $this->language->get('heading_dashboard_editor');
		$this->data['button_edit_close'] = $this->language->get('button_edit_close');
		$this->data['button_import_menu'] = $this->language->get('button_import_menu');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_enable'] = $this->language->get('text_enable');
		$this->data['text_disable'] = $this->language->get('text_disable');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_delete'] = $this->language->get('text_delete');

		$this->data['title_profile_name'] = $this->language->get('title_profile_name');
		$this->data['title_preset_name'] = $this->language->get('title_preset_name');
		$this->data['title_layout_name'] = $this->language->get('title_layout_name');
		$this->data['title_description'] = $this->language->get('title_description');
		$this->data['title_status'] = $this->language->get('title_status');
		$this->data['title_action'] = $this->language->get('title_action');

		$this->data['heading_widget_editor'] = $this->language->get('heading_widget_editor');
		$this->data['heading_color_profile'] = $this->language->get('heading_color_profile');
		$this->data['heading_import_menu'] = $this->language->get('heading_import_menu');

		$this->data['success_profile_enabled'] = $this->language->get('success_profile_enabled');
		$this->data['error_profile_enabled'] = $this->language->get('error_profile_enabled');

		$this->data['success_widget_layout'] = $this->language->get('success_widget_layout');
		$this->data['error_widget_layout'] = $this->language->get('error_widget_layout');

		$this->data['text_create_new_layout'] = $this->language->get('text_create_new_layout');
		$this->data['text_import_menu_intro'] = $this->language->get('text_import_menu_intro');

		$this->data['text_widget_editor_intro'] = $this->language->get('text_widget_editor_intro');

		$this->data['text_confirm'] = $this->language->get('text_confirm');

		$this->data['text_new_layout_copy_from'] = $this->language->get('text_new_layout_copy_from');
		$this->data['text_new_layout_name'] = $this->language->get('text_new_layout_name');
		$this->data['text_new_layout_description'] = $this->language->get('text_new_layout_description');

		$this->data['return_dashboard'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['edit_widget_layout'] = $this->url->link('common/admin_circloid_widget_editor', 'token=' . $this->session->data['token'] . '&layout_id=', 'SSL');


		$this->data['link_import_menu'] = $this->url->link('common/admin_circloid_dashboard_editor/importextensionmenu', 'token=' . $this->session->data['token'], 'SSL');


		// Call the model that checks the table for the enabled widgets
		$this->load->model('common/admin_circloid_dashboard_editor');

		// Get Widget Data
		$this->data['widget_data'] = $this->model_common_admin_circloid_dashboard_editor->getWidgets();

		// Get Colors Profiles for theme
		$this->data['color_profile'] = $this->model_common_admin_circloid_dashboard_editor->getColorProfile();

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
			);

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('common/admin_circloid_dashboard_editor');

		$this->template = 'admin_theme/base5builder_circloid/common/admin_circloid_dashboard_editor.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
			);

		$this->response->setOutput($this->render());
	}

	public function enableColorProfile(){

		$this->load->language('common/home');

		if (!$this->user->hasPermission('modify', 'common/admin_circloid_dashboard_editor')) {

			$data['error_profile_enabled'] = $this->language->get('error_permission');

		}else{

			// Get the id of the Color Profile
			$id = $this->request->get['enabled'];

			// Check if $id is a number
			if(ctype_digit($id)){

				// Call the settings model
				$this->load->model('common/admin_circloid_dashboard_editor');

				// Enable profile and return True/False
				$data['profile_enabled'] = $this->model_common_admin_circloid_dashboard_editor->enableColorProfile($id);

				if($data['profile_enabled']){
					$data['success_profile_enabled'] = $this->language->get('success_profile_enabled');
				}else{
					$data['error_profile_enabled'] = $this->language->get('error_profile_enabled');
				}
			}else{
				$data['profile_enabled'] = FALSE;
				$data['error_profile_enabled'] = $this->language->get('error_profile_enabled');
			}
		}

		$this->response->setOutput(json_encode($data));
	}

	public function enableWidgetLayout(){

		$this->load->language('common/home');
		
		if (!$this->user->hasPermission('modify', 'common/admin_circloid_dashboard_editor')) {

			$data['error_widget_layout'] = $this->language->get('error_permission');

		}else{

			// Get the id of the Widget Layout
			$id = $this->request->get['enabled'];

			// Check if $id is a number
			if(ctype_digit($id)){

				// Call the settings model
				$this->load->model('common/admin_circloid_dashboard_editor');

				// Enable Widget Layout and return True/False
				$data['widget_layout_enabled'] = $this->model_common_admin_circloid_dashboard_editor->enableWidgetLayout($id);

				if($data['widget_layout_enabled']){
					$data['success_widget_layout'] = $this->language->get('success_widget_layout');
				}else{
					$data['error_widget_layout'] = $this->language->get('error_widget_layout');
				}

			}else{
				$data['error_widget_layout'] = $this->language->get('error_widget_layout');
			}
		}

		$this->response->setOutput(json_encode($data));
	}

	public function copyWidgetLayout(){

		$this->load->language('common/home');
		
		if (!$this->user->hasPermission('modify', 'common/admin_circloid_dashboard_editor')) {

			$data['error_layout_copied'] = $this->language->get('error_permission');

		}else{

			// Get the id of the Color Profile
			$id = $this->request->get['copy'];
			$new_layout_name = $this->request->get['new_layout_name'];
			$new_description = $this->request->get['new_description'];

			if(ctype_digit($id) || !empty($id)){

				if($this->alpha_dash_space_ampersand($new_layout_name) && !empty($new_layout_name) && (strlen($new_layout_name) >= 3 && strlen($new_layout_name) <= 35)){

					if($this->alpha_dash_space_ampersand($new_description) || !empty($new_description) || (strlen($new_description) >= 3 && strlen($new_description) <= 100)){

						// Call the settings model
						$this->load->model('common/admin_circloid_dashboard_editor');

						// Copy Widget Layout and return True/False
						$data['widget_layout_copied'] = $this->model_common_admin_circloid_dashboard_editor->copyWidgetLayout($id, $new_layout_name, $new_description);

						if($data['widget_layout_copied']){
							$data['success_layout_copied'] = $this->language->get('success_layout_copied');
						}else{
							$data['error_layout_copied'] = $this->language->get('error_layout_copied');
						}

						$this->response->setOutput(json_encode($data));
					}else{

						// display error
						$data['error_layout_copied'] = $this->language->get('error_layout_copied');
						$data['error_layout_copied'] .= $this->language->get('error_layout_copied_description');

					}
				}else{

					// display error
					$data['error_layout_copied'] = $this->language->get('error_layout_copied');
					$data['error_layout_copied'] .= $this->language->get('error_layout_copied_name');
				}
			}else{

				// display error
				$data['error_layout_copied'] = $this->language->get('error_layout_copied');
				$data['error_layout_copied'] .= $this->language->get('error_layout_copied_id');
			}
		}
		
		$this->response->setOutput(json_encode($data));
	}

	public function deleteWidgetLayout(){

		$this->load->language('common/home');
		
		if (!$this->user->hasPermission('modify', 'common/admin_circloid_dashboard_editor')) {

			$data['error_widget_layout_deleted'] = $this->language->get('error_permission');

		}else{

			// Get the id of the Widget Layout
			$id = $this->request->get['delete'];

			// Check if $id is a number
			if(ctype_digit($id)){

				// Call the settings model
				$this->load->model('common/admin_circloid_dashboard_editor');

				// Delete Widget Layout and return True/False
				$data['widget_layout_deleted'] = $this->model_common_admin_circloid_dashboard_editor->deleteWidgetLayout($id);

				if($data['widget_layout_deleted']){
					$data['success_widget_layout_deleted'] = $this->language->get('success_widget_layout_deleted');
				}else{
					$data['error_widget_layout_deleted'] = $this->language->get('error_widget_layout_deleted');
				}

			}else{
				$data['error_widget_layout_deleted'] = $this->language->get('error_widget_layout_deleted');
			}
		}

		$this->response->setOutput(json_encode($data));
	}
	
	public function importExtensionMenu(){
		$this->language->load('common/home');

		$vqmod_path = substr_replace(DIR_SYSTEM, '/vqmod/xml/', -8);
		$output_file = $vqmod_path . "b5b_admintheme_circloid_menu_fix.xml";
		
		$files = glob($vqmod_path . '*.{xml}', GLOB_BRACE);

		$xml_rebuild = '<?xml version="1.0"?>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '<modification>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '	<id>Base5Builder - Admin Theme Circloid - Menu Fix</id>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '	<vqmver>2.0</vqmver>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '	<author>Base5Builder.com - support@base5builder.com</author>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '	<file name="admin/view/template/admin_theme/base5builder_circloid/common/header.tpl">';
		$xml_rebuild .= "\n";

		foreach($files as $filename) {

			$xml_file = simplexml_load_file($filename);
			foreach ($xml_file as $xml) {
				if($xml->attributes()->name == "admin/view/template/common/header.tpl"){

					foreach($xml->operation as $operation_block){
						$xml_rebuild .= '		<operation error="log">';
						$xml_rebuild .= "\n";

						$search_attributes = '';

						foreach ($xml->operation->search->attributes() as $key => $value) {
							$search_attributes .= " " . $key . '="' . $value . '"';
						}

						$xml_rebuild .= '			<search' . $search_attributes . '><![CDATA[';
						$xml_rebuild .= (string)$operation_block->search;
						$xml_rebuild .= ']]></search>';
						$xml_rebuild .= "\n";

						$xml_rebuild .= '			<add><![CDATA[';
						$xml_rebuild .= (string)$operation_block->add;
						$xml_rebuild .= ']]></add>';
						$xml_rebuild .= "\n";

						$xml_rebuild .= '		</operation>';
						$xml_rebuild .= "\n";
					}
				}
			}
		}

		$xml_rebuild .= '	</file>';
		$xml_rebuild .= "\n";
		$xml_rebuild .= '</modification>';
		file_put_contents($output_file, $xml_rebuild);
		// echo $output_file;
		$this->redirect($this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'));
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
