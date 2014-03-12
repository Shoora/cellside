<?php
// Text
$_['text_title']          = 'Factura Klarna';
$_['text_fee']            = 'Factura Klarna - Pagar dentro de 14 días <span id="klarna_invoice_toc_link"></span> (+%s)<script text="javascript\">$.getScript(\'http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js\', function(){ var terms = new Klarna.Terms.Invoice({ el: \'klarna_invoice_toc_link\', eid: \'%s\', country: \'%s\', charge: %s});})</script>';
$_['text_no_fee']         = 'Factura Klarna Invoice - Pagar dentro de 14 días <span id="klarna_invoice_toc_link"></span><script text="javascript">$.getScript(\'http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js\', function(){ var terms = new Klarna.Terms.Invoice({ el: \'klarna_invoice_toc_link\', eid: \'%s\', country: \'%s\'});})</script>';
$_['text_additional']     = 'Factura Klarna requiere información adicional antes que ellos puedan procesar su orden.';
$_['text_wait']           = 'Por favor espere!';
$_['text_male']           = 'Hombre';
$_['text_female']         = 'Mujer';
$_['text_year']           = 'Año';
$_['text_month']          = 'Mes';
$_['text_day']            = 'Dia';
$_['text_comment']        = "Klarna's Factura ID: %s\n%s/%s: %.4f";

// Entry
$_['entry_gender']         = 'Genero:';
$_['entry_pno']            = 'Numero Personal:<br /><span class="help">Introducir Tu número de seguirdad social.</span>';
$_['entry_dob']            = 'Fecha de nacimiento:';
$_['entry_phone_no']       = 'Número Telefonico:<br /><span class="help">Introduce tu número telefonico.</span>';
$_['entry_street']         = 'Calle:<br /><span class="help">Notar las entregas solo pueden la dirección registrada cuando se paga con Klarna.</span>';
$_['entry_house_no']       = 'Número de Casa.:<br /><span class="help">Introduce tu Número de casa.</span>';
$_['entry_house_ext']      = 'Número de extensión de casa:<br /><span class="help">Introduce tu número de extensión de casa E.g. A, B, C, Red, Blue ect.</span>';
$_['entry_company']        = 'Número de registro de la compañia:<br /><span class="help">Introduce tu número de registro de tu compañia </span>';

// Error
$_['error_deu_terms']     = 'Debes estar de acuerdo con las politicas de Klarna\'s';
$_['error_address_match'] = 'La dirección de compra y envio deben conincidir si tu quieres usar Factura Klarna';
$_['error_network']       = 'Ocurrio un error mientras se conecta con Klarna. Trate de nuevo.';
?>
