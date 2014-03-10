<?php 
class ControllerPcpbUpload extends Controller {
	private $error = array(); 
     
  	public function index() {
		$fileType = '';
		
		switch($this->request->files['uploads']['type'][0])
		{
			case 'image/jpeg':
				$fileType = 'jpg';
				break;
			case 'image/gif':
				$fileType = 'gif';
				break;
			case 'image/png':
				$fileType = 'png';
				break;
		}
		if($fileType == '')
		{	
			$res = array(
				'errorCode' => 1,
				'errorMessage' => 'wrong file type'
			);
			echo (json_encode($res));
			exit();
		}
		$max_size = $this->config->get('pcpb_max_size_upload') ? $this->config->get('pcpb_max_size_upload') : 1000;
		$file_size = $this->request->files['uploads']['size'][0];
		
		$kbytes = $file_size / 1024;
		if($kbytes > $max_size)
		{
			$res = array(
				'errorCode' => 1,
				'errorMessage' => 'wrong file size, limit is ' . $max_size . 'KB'
			);
			echo (json_encode($res));
			exit();
		}
		
		$tempDir = $this->config->get('pcpb_path_folder_save_temprarily');
		if(!$tempDir || $tempDir == '' || !is_writable(DIR_IMAGE . $tempDir))
			$tempDir = 'pcpb/temp/';
		//$tempDir = $tempDir;
		
		$rand = $this->genRndNum(3);
		$fileName = time() . $rand . '.' . $fileType;
		
		$target_path = DIR_IMAGE . $tempDir . $fileName; 
		
		if(move_uploaded_file($this->request->files['uploads']['tmp_name'][0], $target_path)) {
			$imagePath = HTTP_SERVER . 'image/' . $tempDir . $fileName;
			$size = getimagesize($target_path);
			$res = array(
				'errorCode' => 0,
				'imagePath' => $imagePath,
				'size' => $size
			);
			echo (json_encode($res));
			exit();
		} else{
			$res = array(
				'errorCode' => 1,
				'errorMessage' => 'upload fail'
			);
			echo (json_encode($res));
			exit();
		}
  	}

  	public function checkclean(){
  		$timeout = $this->config->get('pcpb_automatic_clean');
		if($timeout != 0){
			$now = time();
			$beforeClean = $this->config->get('pcpb_automatic_clean_before')
				? $this->config->get('pcpb_automatic_clean_before') 
				: $now;
			if($now != $beforeClean && ($now - $beforeClean) < $timeout*60*60)
				exit();
			$this->load->model('pcpb/pcpb');
			$this->model_pcpb_pcpb->setSetting('pcpb_automatic_clean_before', $now);
			$this->clean();
		}
  	}
	
	public function clean(){
		$tempDir = $this->config->get('pcpb_path_folder_save_temprarily');
		if(!$tempDir || $tempDir == '' || !is_writable(DIR_IMAGE . $tempDir))
			$tempDir = 'pcpb/temp/';
		$dir = DIR_IMAGE. $tempDir;
		$this->emptyDir($dir);
		$res = array(
			'errorCode' => 0
		);
		echo (json_encode($res));exit();
	}
	
	private function emptyDir($dir){
		if(!$dh = @opendir($dir)) return;
		while (false !== ($obj = readdir($dh))) {
			if($obj=='.' || $obj=='..') continue;
			if (!@unlink($dir.'/'.$obj)) $this->emptyDir($dir.'/'.$obj);
		}
	}
	
	private function genRndNum($iLength = 8)
	{
		$sPassword = '';
		$sChars = "12345678901234567890";
		srand((double)microtime()*1000000);
		for($i = 0; $i < $iLength; $i++) {
			$x = mt_rand(0, strlen($sChars) -1);
			$sPassword .= $sChars{$x};
		}
		return $sPassword;
	}
	
	function echoDbg( $what, $desc = '' )
	{
		if ( $desc )
			echo "<b>$desc:</b> ";
		echo "<pre>";
			print_r( $what );
		echo "</pre>\n";
	}
}

?>