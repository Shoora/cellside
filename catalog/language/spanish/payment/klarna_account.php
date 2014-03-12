<?php
// Text
$_['text_title']           = 'Cuenta de Klarna';
$_['text_pay_month']       = 'Cuenta de Klarna - Formulario de Pago %s/mes <span id="klarna_account_toc_link"></span><script text="javascript">$.getScript(\'http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js\', function(){ var terms = new Klarna.Terms.Account({ el: \'klarna_account_toc_link\', eid: \'%s\',   country: \'%s\'});})</script>';
$_['text_information']     = 'Información de la cuneta Klarna';
$_['text_additional']      = 'La cuenta de Klarna requiere información adicional antes de procesar tu pedido.';
$_['text_wait']            = 'Espere!';
$_['text_male']            = 'Hombre';
$_['text_female']          = 'Mujer';
$_['text_year']            = 'Año';
$_['text_month']           = 'Mes';
$_['text_day']             = 'Diay';
$_['text_payment_option']  = 'Opciones de Pago';
$_['text_single_payment']  = 'Pago simple';
$_['text_monthly_payment'] = '%s - %s pro mes';
$_['text_comment']         = "Klarna's Factura ID: %s\n%s/%s: %.4f";

// Entry
$_['entry_gender']         = 'Genero:';
$_['entry_pno']            = 'Número Personal:<br /><span class="help">Introduce tu número de seguridad social.</span>';
$_['entry_dob']            = 'Fecha de Nacimiento:';
$_['entry_phone_no']       = 'Número Telefonico:<br /><span class="help">Introduce el número telefonico.</span>';
$_['entry_street']         = 'Calle:<br /><span class="help">El envío solo puede ser realizada con la dirección registrada cuando se paga con klarna.</span>';
$_['entry_house_no']       = 'Número de la Casa:<br /><span class="help">Introduce el número de la casa.</span>';
$_['entry_house_ext']      = 'Extensión de la Cass:<br /><span class="help">Introduce la extensión de tu casa . E.g. A, B, C, Red, Blue ect.</span>';
$_['entry_company']        = 'Número de registro de tu compañia:<br /><span class="help">Tu número de registro de compañia</span>';

// Error
$_['error_deu_terms']      = 'Debes estar de acuerdo con con las politicas de Klarna\'s';
$_['error_address_match']  = 'Las direcciones de Facturación y Envío deben coincidir si quieres usar los pagos de  Klarna';
$_['error_network']        = 'Error de conexión. Trate de Nuevo.';
?>
