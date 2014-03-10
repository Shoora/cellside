<?php
function invoice_pdf($data) {
	$pdf = new DOMPDF;
	$pdf->load_html($data);
	$pdf->render();
	$pdf->stream("invoice_order.pdf");
}
?>