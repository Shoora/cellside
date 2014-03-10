<?php 
class ControllerPcpbView extends Controller {
	private $error = array(); 
     
  	public function index() {
		$this->template = 'default/template/pcpb/index.tpl';
		$token = isset($this->request->get['token'])?$this->request->get['token']:null;
		if(!$token)
			die('error!');
			
		$this->load->model('pcpb/pcpb');
		$data = $this->model_pcpb_pcpb->getDataByToken($token);
		$this->data['image_link'] = $data['content'];
		$this->response->setOutput($this->render());
  	}
}
?>