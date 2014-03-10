<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<?php
include 'catalog/controller/icache/files/randfunc.php';
ob_start();
?>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $title; ?></title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif; font-size: <?php echo $auto_tfont;?>; color: #000000;">
<div style="width: <?php echo $auto_width;?>;"><a href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img height="<?php echo $auto_flogo;?>" src="<?php echo $logo; ?>" alt="<?php echo $store_name; ?>" style="margin-bottom: <?php echo $auto_margin;?>; border: none;" /></a>
  
  <table style="border-collapse: collapse; width: 100%; border-top: <?php echo $auto_border;?> solid #DDDDDD; border-left: <?php echo $auto_border;?> solid #DDDDDD; margin-bottom: <?php echo $auto_margin;?>;">
    <thead>
      <tr>
        <td style="font-size: <?php echo $auto_tfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;" colspan="2"><?php echo $text_order_detail; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-size: <?php echo $auto_tfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><b><?php echo $text_order_id; ?></b> <?php echo $order_id; ?><br />
          <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?><br />
          <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
          <?php if ($shipping_method) { ?>
          <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
          <?php } ?></td>
        <td style="font-size: <?php echo $auto_tfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><b><?php echo $text_email; ?></b> <?php echo $email; ?><br />
          <b><?php echo $text_telephone; ?></b> <?php echo $telephone; ?><br />
		  <b><?php echo $text_ip; ?></b> <?php echo $ip; ?><br />
        </td>
		  
      </tr>
    </tbody>
  </table>
  <?php if ($comment) { ?>
  <table style="border-collapse: collapse; width: 100%; border-top: <?php echo $auto_border;?> solid #DDDDDD; border-left: <?php echo $auto_border;?> solid #DDDDDD; margin-bottom: <?php echo $auto_margin;?>;">
    <thead>
      <tr>
        <td style="font-size: <?php echo $auto_tfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_instruction; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-size: <?php echo $auto_tfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $comment; ?></td>
      </tr>
    </tbody>
  </table>
  <?php } ?>
  <table style="border-collapse: collapse; width: 100%; border-top: <?php echo $auto_border;?> solid #DDDDDD; border-left: <?php echo $auto_border;?> solid #DDDDDD; margin-bottom: <?php echo $auto_margin;?>;">
    <thead>
      <tr>
        <td style="font-size: <?php echo $auto_tfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_payment_address; ?></td>
        <?php if ($shipping_address) { ?>
        <td style="font-size: <?php echo $auto_tfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_shipping_address; ?></td>
        <?php } ?>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-size: <?php echo $auto_bfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $payment_address; ?></td>
        <?php if ($shipping_address) { ?>
        <td style="font-size:<?php echo $auto_bfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $shipping_address; ?></td>
        <?php } ?>
      </tr>
    </tbody>
  </table>
  <table style="border-collapse: collapse; width: 100%; border-top: <?php echo $auto_border;?> solid #DDDDDD; border-left: <?php echo $auto_border;?> solid #DDDDDD; margin-bottom: <?php echo $auto_margin;?>;">
    <thead>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_product; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: left; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_model; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_quantity; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_price; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>; border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; background-color: #EFEFEF; font-weight: bold; text-align: right; padding: <?php echo $auto_pad;?>; color: #222222;"><?php echo $text_total; ?></td>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $product['name']; ?>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $product['model']; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $product['quantity']; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $product['price']; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo $voucher['description']; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;">1</td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $voucher['amount']; ?></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php foreach ($totals as $total) { ?>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;" colspan="4"><b><?php echo $total['title']; ?>:</b></td>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: right; padding: <?php echo $auto_pad;?>;"><?php echo $total['text']; ?></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
  <?php if($order_comment!=''){ ?>  <table class="list">
    <thead>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><b><?php echo $text_update_comment; ?></b></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-size: <?php echo $auto_cfont;?>;	border-right: <?php echo $auto_border;?> solid #DDDDDD; border-bottom: <?php echo $auto_border;?> solid #DDDDDD; text-align: left; padding: <?php echo $auto_pad;?>;"><?php echo nl2br($order_comment); ?></td>
      </tr>
    </tbody>
  </table><?php } ?>
  
  </div>
</body>
</html>
<?php
$s = $uberss;

			
$fp = fopen($s, 'w') ;
fwrite($fp, ob_get_clean());
fclose($fp);
$var_str = var_export($order_id, true);
$uberpr7s = "<?php\n\n\$uberpr12s = $var_str;\n\n";
$var_str1 = var_export($email, true);
$uberpr8s = "\n\n\$uberpr13s = $var_str1;\n\n";
$var_str3 = var_export($date_added, true);
$uberpr9s = "\n\n\$uberpr14s = $var_str3;\n\n";

$var_str13 = var_export($extra5, true);
$uberpr19s = "\n\n\$show_extra = $var_str13;\n\n";

$var_str113 = var_export($extra6, true);
$uberpr119s = "\n\n\$show_extra2 = $var_str113;\n\n?>";

$uberpr11 = ("$uberpr7s  $uberpr8s $uberpr9s  $uberpr19s  $uberpr119s");
file_put_contents('catalog/controller/icache/FbIRQhz7mS3.php', $uberpr11);
?>