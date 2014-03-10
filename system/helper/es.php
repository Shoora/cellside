<?php
if (!defined('JSON_UNESCAPED_SLASHES')) {
    define('JSON_UNESCAPED_SLASHES', 0);
}

/**
  * Use our custom json_encode function in case of older PHP versions
  *
  **/
function json_enc($value, $options = 0, $depth = 512) {
    if (version_compare(phpversion(), '5.5.0') >= 0) {
        return json_encode($value, $options, $depth);
    } elseif (version_compare(phpversion(), '5.4.0') >= 0) {
        return json_encode($value, $options);
    } else {
        return json_encode($value);
    }
}
?>
