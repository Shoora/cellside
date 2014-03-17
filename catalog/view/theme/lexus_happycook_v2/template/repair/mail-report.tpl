<!DOCTYPE html>
<html>
<head>
    <title>Mail-in repair service report</title>
</head>
<body>
<h1>Mail-in repair service report</h1>
<table>
    <?php foreach( $report as $i ) { ?>
    <tr>
        <td><b><?= $i['var'] ?></b></td>
        <td><?= $i['value'] ?></td>
    </tr>
    <?php } ?>
</table>
</body>
</html>