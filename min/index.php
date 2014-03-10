<?php
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                         SETUP DEFAULT VALUES AND INCLUDE CONFIG                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$min_encodeImages           = false;
$min_encodeURL              = false;
$min_errorLogger            = false;
$min_allowDebugFlag         = false;
$min_serveOptions['maxAge'] = 8640000;
$min_documentRoot = '';
$min_cacheFileLocking = true;
$min_cachePath      = '../system/cache/min';

if (file_exists('min.config')) {
	include ('min.config');
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               DO NOT EDIT BELOW THIS LINE!                                              //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ($min_encodeImages) {
	$min_serveOptions['postprocessor'] = 'baseProcess';
}
$min_serveOptions['bubbleCssImports'] = false;
$min_serveOptions['minApp']['groupsOnly'] = false;
$min_serveOptions['minApp']['noMinPattern'] = null;
$min_symlinks = array();
$min_uploaderHoursBehind = 0;
$min_libPath = dirname(__FILE__) . '/min';
ini_set('zlib.output_compression', '0');

define('MINIFY_MIN_DIR', dirname(__FILE__));

// setup include path
set_include_path($min_libPath . PATH_SEPARATOR . get_include_path());

require 'Minify.php';

Minify::$uploaderHoursBehind = $min_uploaderHoursBehind;
Minify::setCache(isset($min_cachePath) ? $min_cachePath : '',$min_cacheFileLocking);

if ($min_documentRoot) {
    $_SERVER['DOCUMENT_ROOT'] = $min_documentRoot;
    Minify::$isDocRootSet = true;
}

$min_serveOptions['minifierOptions']['text/css']['symlinks'] = $min_symlinks;
// auto-add targets to allowDirs
foreach ($min_symlinks as $uri => $target) {
    $min_serveOptions['minApp']['allowDirs'][] = $target;
}

if ($min_allowDebugFlag) {
	$_GET['debug'] = '';
	require_once 'Minify/DebugDetector.php';
	$min_serveOptions['debug'] = Minify_DebugDetector::shouldDebugRequest($_COOKIE, $_GET, $_SERVER['REQUEST_URI']);
}

if ($min_errorLogger) {
    require_once 'Minify/Logger.php';
    if (true === $min_errorLogger) {
        require_once 'FirePHP.php';
        $min_errorLogger = FirePHP::getInstance(true);
    }
    Minify_Logger::setLogger($min_errorLogger);
}

// check for URI versioning
if (preg_match('/&\\d/', $_SERVER['QUERY_STRING'])) {
    $min_serveOptions['maxAge'] = 31536000;
}

// Base32 Decode URL Components
if ($min_encodeURL) {
	include('../system/library/base32.php');
	$base32_encode = new Base32;

	$parts = explode('/', str_replace($_SERVER['REQUEST_QUERY'], '', $_SERVER['REQUEST_URI']));

	$fbase = $base32_encode->toString($parts[count($parts) -2]);
	if (substr($fbase, 0,2) == 'f=') {
		$_GET['f'] = str_replace('f=','',$fbase);
	}
	
	$bbase = $base32_encode->toString($parts[count($parts) -3]);
	if (substr($bbase, 0,2) == 'b=') {
		$_GET['b'] = str_replace('b=','',$bbase);
	}
}

if (isset($_GET['f'])) {
    // SERVE CONTENT
    if (isset($_GET['b'])) {
		$_GET['b'] = trim($_GET['b'], '/');
    }
    
    if (! isset($min_serveController)) {
        require 'Minify/Controller/MinApp.php';
        $min_serveController = new Minify_Controller_MinApp();
    }
    Minify::serve($min_serveController, $min_serveOptions);
        
} else {
    header("Location: /");
    exit();
}


function baseProcess($content, $type) {
	global $min_encodeImageSize;
	if ($type == "text/css") {    
		$images_pattern = '~(?P<ref>background:.*?url\(\'?"?(?P<image>.*?)\'?"?\).*?;)~';
		$i = 0;
		preg_match_all($images_pattern, $content, $matches);
		//var_dump($matches);
		foreach ($matches['image'] as $image) {
			//echo realpath('..' . $image);
			if (file_exists(realpath('..' . $image)) && filesize(realpath('..' . $image)) <= $min_encodeImageSize) {
				$image_info = getimagesize(realpath('..' . $image));
				$rewritten = str_replace($image, 'data:' . $image_info['mime'] . ';base64,' . base64_encode(file_get_contents(realpath('..' . $image))), $matches['ref'][$i]);
				$content = str_replace($matches['ref'][$i], $rewritten . '*' . $matches['ref'][$i], $content);
			}
			$i++;
		}
	}
	return $content;
}
