<?php

namespace JBBCode\validators;

require_once dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'InputValidator.php';

/**
 * An InputValidator for CSS font size values. This is a very rudimentary
 * validator.
 *
 * @author bull5i
 * @since Sep 2013
 */
class CssSizeValidator implements \JBBCode\InputValidator
{

    /**
     * Returns true if $input uses only valid CSS color value
     * characters.
     *
     * @param $input  the string to validate
     */
    public function validate($input)
    {
        return (bool) preg_match('/^(:?\d{1,3}\.?|\d{0,3}\.\d{1,2})$/', $input);
    }

}
