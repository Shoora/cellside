<?php if ($error) { ?>
<div class="warning"><?php echo $error; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr>
<td width="20"></td>
      <td class="left"><b><?php echo $column_date_added; ?></b></td>
      <td class="left"><b><?php echo $column_comment; ?></b></td>
      <td class="left"><b><?php echo $column_status; ?></b></td>
      <td class="left"><b><?php echo $column_notify; ?></b></td>
<td class="left"><b><?php echo $column_track_email; ?></b></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($histories) { ?>
<?php $i = 0; ?>
    <?php foreach ($histories as $history) { ?>
<?php ++$i; ?>
    <tr id="h_<?php echo $i; ?>">
<td><a onclick="deleteHistoryById(<?php echo $i; ?>, <?php echo $history['history_id']; ?>);"><img src="view/image/delete.png" /></a></td>
      <td class="left"><?php echo $history['date_added']; ?></td>
      <td class="left"><?php echo $history['comment']; ?></td>
      <td class="left"><?php echo $history['status']; ?></td>
      <td class="left"><?php echo $history['notify']; ?></td>
<td class="left"><?php echo $history['track']; ?></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
<script type="text/javascript">
function deleteHistoryById(row, history_id) {
	$.ajax({
		type: 'POST',
		url: 'index.php?route=sale/order/removestatus&token=<?php echo $token; ?>&history_id=' + history_id,
		dataType: 'json',
		beforeSend: function() {
			$('#history').before('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');			
		},
		complete: function() {
			$('.loading').remove();
		},			
		success: function(json) {
			$('.success').remove();
			$('.warning').remove();
						
			if (json['error']) {
				 $('.breadcrumb').after('<div class="warning" style="display: none;">' + json['error'] + '</div>');
				
				$('.warning').fadeIn('slow');
			}
			
			if (json['success']) {
                 $('.breadcrumb').after('<div class="success" style="display: none;">' + json['success'] + '</div>');
				
				$('.success').fadeIn('slow');
				
				$('#h_' + row).remove();
			}
		}
	});
}
</script>
