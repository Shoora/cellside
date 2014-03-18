<!DOCTYPE html>
<html>
<head>
    <title>Mail-in repair service report</title>
</head>
<body style="width: 600px;margin: 0 auto;">
<h1 style="border-bottom: 4px double #63acff;text-align: center;margin-bottom: 5px;">Mail-in repair service report</h1>
<table style="width: 100%;">
    <?php $row = 0; ?>
    <?php foreach( $report as $i ) { ?>
    <?php if ( $row == 0 ) { $row = 1; } else { $row = 0; } ?>
    <tr style="background: <?php if ( $row == 0 ) { ?>#f5f5f5<?php } else { ?>#E7F7F7<?php } ?>;">
        <td style="text-align: right;padding: 10px;width: 50%;"><b><?= $i['var'] ?></b></td>
        <td style="text-align: left;padding: 10px;"><?= $i['val'] ?></td>
    </tr>
    <?php } ?>
</table>
<div style="border-top: 4px double #63acff;margin-top: 5px;padding: 10px; text-align: center;">
    Generated at <?= date('Y/d/m  H:i:s'); ?>
</div>
</body>
</html>