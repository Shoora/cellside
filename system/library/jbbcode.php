<?php

require_once(DIR_SYSTEM . 'library/jBBCode/Parser.php');

/**
 * Implements a [list] code definition that provides the following syntax:
 *
 * [list]
 *   [*] first item
 *   [*] second item
 *   [*] third item
 * [/list]
 *
 */
class ListCodeDefinition extends \JBBCode\CodeDefinition {

    public function __construct($useOption = false) {
        $this->parseContent = true;
        $this->useOption = $useOption;
        $this->setTagName('list');
        $this->nestLimit = -1;
    }

    public function asHtml(\JBBCode\ElementNode $el) {
        $bodyHtml = '';
        foreach ($el->getChildren() as $child) {
            $bodyHtml .= $child->getAsHTML();
        }

        $bodyHtml = str_ireplace(array('[li]', '[/li]'), array('[*]', ''), $bodyHtml);

        $listPieces = explode('[*]', $bodyHtml);
        unset($listPieces[0]);
        $listPieces = array_map(function($li) { return '<li>'.$li.'</li>' . "\n"; }, $listPieces);
        if ($this->usesOption()) {
            return '<ol>' . implode('', $listPieces) . '</ol>';
        } else {
            return '<ul>' . implode('', $listPieces) . '</ul>';
        }
    }

}

