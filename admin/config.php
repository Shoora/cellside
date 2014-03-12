<?php
// HTTP
define('HTTP_SERVER', 'http://cellside.loc/admin/');
define('HTTP_CATALOG', 'http://cellside.loc/');

// HTTPS
define('HTTPS_SERVER', 'http://cellside.loc/admin/');
define('HTTPS_CATALOG', 'http://cellside.loc/');

// DIR
define('DIR_APPLICATION', $_SERVER['DOCUMENT_ROOT'].'/admin/');
define('DIR_SYSTEM', $_SERVER['DOCUMENT_ROOT'].'/system/');
define('DIR_DATABASE', $_SERVER['DOCUMENT_ROOT'].'/system/database/');
define('DIR_LANGUAGE', $_SERVER['DOCUMENT_ROOT'].'/admin/language/');
define('DIR_TEMPLATE', $_SERVER['DOCUMENT_ROOT'].'/admin/view/template/');
define('DIR_CONFIG', $_SERVER['DOCUMENT_ROOT'].'/system/config/');
define('DIR_IMAGE', $_SERVER['DOCUMENT_ROOT'].'/image/');
define('DIR_CACHE', $_SERVER['DOCUMENT_ROOT'].'/system/cache/');
define('DIR_DOWNLOAD', $_SERVER['DOCUMENT_ROOT'].'/download/');
define('DIR_LOGS', $_SERVER['DOCUMENT_ROOT'].'/system/logs/');
define('DIR_CATALOG', $_SERVER['DOCUMENT_ROOT'].'/catalog/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '123');
define('DB_DATABASE', 'cellside');
define('DB_PREFIX', '');
error_reporting(0);
@ini_set('display_errors', 0);
?>