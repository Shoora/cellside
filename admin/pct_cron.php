<?php
// Version
define('VERSION', '1.5.2.1');

// Configuration
require_once('config.php');

// Install 
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

//VirtualQMOD
require_once('../vqmod/vqmod.php');
$vqmod = new VQMod();

// VQMODDED Startup
require_once($vqmod->modCheck(DIR_SYSTEM . 'startup.php'));

// Application Classes
require_once($vqmod->modCheck(DIR_SYSTEM . 'library/currency.php'));
require_once($vqmod->modCheck(DIR_SYSTEM . 'library/user.php'));
require_once($vqmod->modCheck(DIR_SYSTEM . 'library/weight.php'));
require_once($vqmod->modCheck(DIR_SYSTEM . 'library/length.php'));

$registry = new Registry();

$loader = new Loader($registry);
$registry->set('load', $loader);

$config = new Config();
$registry->set('config', $config);

$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);
		
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");
 
foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], unserialize($setting['value']));
	}
}

$url = new Url(HTTP_SERVER, $config->get('config_use_ssl') ? HTTPS_SERVER : HTTP_SERVER);	
$registry->set('url', $url);
		
$log = new Log($config->get('config_error_filename'));
$registry->set('log', $log);

function error_handler($errno, $errstr, $errfile, $errline) {
	global $log, $config;
	
	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}
		
	if ($config->get('config_error_display')) {
		echo '<b>' . $error . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
	}
	
	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	}

	return true;
}

set_error_handler('error_handler');
$request = new Request();
$registry->set('request', $request);
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response); 
$cache = new Cache();
$registry->set('cache', $cache); 
$session = new Session();
$registry->set('session', $session); 
$languages = array();

$query = $db->query("SELECT * FROM " . DB_PREFIX . "language"); 

foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}

$config->set('config_language_id', $languages[$config->get('config_admin_language')]['language_id']);

// Language	
$language = new Language($languages[$config->get('config_admin_language')]['directory']);
$language->load($languages[$config->get('config_admin_language')]['filename']);	
$registry->set('language', $language); 		

$registry->set('document', new Document()); 		
$registry->set('currency', new Currency($registry));		
$registry->set('weight', new Weight($registry));
$registry->set('length', new Length($registry));
$registry->set('user', new User($registry));
$controller = new Front($registry);

$action = new Action('catalog/testimonial/cronreminders');
$controller->dispatch($action, new Action('error/not_found'));
$response->output();
?>