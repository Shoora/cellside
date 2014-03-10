<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('form').attr('action', '<?php echo $save; ?>'); $('form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="center"><?php echo $column_image; ?></td>
			  <td class="left"><?php if ($sort == 'pd.name') { ?>
                <a href="<?php echo $sort_product; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_product; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_product; ?>"><?php echo $column_product; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'r.author') { ?>
                <a href="<?php echo $sort_author; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_author; ?>"><?php echo $column_author; ?></a>
                <?php } ?></td>
              <td class="left"><?php echo $column_rating; ?></td>
			  <td class="left"><?php if ($sort == 'rating_avg') { ?>
                <a href="<?php echo $sort_avg; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_avg; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_avg; ?>"><?php echo $column_avg; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'pros') { ?>
                <a href="<?php echo $sort_pros; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_pros; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_pros; ?>"><?php echo $column_pros; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'cons') { ?>
                <a href="<?php echo $sort_cons; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_cons; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_cons; ?>"><?php echo $column_cons; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'r.vote_yes') { ?>
                <a href="<?php echo $sort_vote_yes; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_vote_yes; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_vote_yes; ?>"><?php echo $column_vote_yes; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'r.vote_no') { ?>
                <a href="<?php echo $sort_vote_no; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_vote_no; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_vote_no; ?>"><?php echo $column_vote_no; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'r.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
			  <td class="left"><?php if ($sort == 'r.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($reviews) { ?>
            <?php foreach ($reviews as $review) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($review['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $review['review_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $review['review_id']; ?>" />
                <?php } ?></td>
			  <td class="center"><a href="<?php echo $review['popup']; ?>" target="_blank"><img src="<?php echo $review['image']; ?>" alt="<?php echo $review['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></a><?php if ($review['popup']) { ?><br /><img src="view/image/delete.png" id="button-delete-image" data-review-id="<?php echo $review['review_id']; ?>" alt="" style="cursor: pointer;" /><?php } ?></td>
              <td class="left"><?php echo $review['name']; ?></td>
              <td class="left"><?php echo $review['author']; ?></td>
              <td class="left" style="white-space: nowrap;"><?php if ($review['ratings']) { ?>
			    <?php foreach ($review['ratings'] as $rating) { ?>
				<div style="margin-bottom: 3px;"><img src="view/image/stars-<?php echo $rating['rating']; ?>.png" alt="" title="" style="vertical-align: middle;" /> <?php echo $rating['name']; ?></div>
				<?php } ?>
			    <?php } else { ?>
				<div style="margin-bottom: 3px;"><img src="view/image/stars-<?php echo $review['rating_avg']; ?>.png" alt="" title="" style="vertical-align: middle;" /></div>
				<?php } ?></td>
			  <td class="left"><?php if ($review['rating_avg'] <= 2) { ?>
                <span style="color: #FF0000;"><?php echo $review['rating_avg']; ?></span>
                <?php } elseif ($review['rating_avg'] <= 4) { ?>
                <span style="color: #FFA500;"><?php echo $review['rating_avg']; ?></span>
                <?php } else { ?>
                <span style="color: #008000;"><?php echo $review['rating_avg']; ?></span>
                <?php } ?></td>
			  <td class="left"><?php echo ($review['pros']) ? '<a href="' . $review['href_pros'] . '">' . $review['pros'] . '</a>' : 0; ?></td>
			  <td class="left"><?php echo ($review['cons']) ? '<a href="' . $review['href_cons'] . '">' . $review['cons'] . '</a>' : 0; ?></td>
			  <td class="left"><?php echo ($review['vote_yes']) ? $review['vote_yes'] . ' <a href="' . $review['href_vote_yes'] . '"><img src="view/image/delete.png" style="vertical-align: middle;" /></a>' : 0; ?></td>
			  <td class="left"><?php echo ($review['vote_no']) ? $review['vote_no'] . ' <a href="' . $review['href_vote_no'] . '"><img src="view/image/delete.png" style="vertical-align: middle;" /></a>' : 0; ?></td>
			  <td class="left"><?php echo $review['date_added']; ?></td>
              <td class="left" style="background: <?php echo (!$review['status']) ? '#FF0000' : '#008000'; ?>;"><select name="status[<?php echo $review['review_id']; ?>]">
			    <?php if ($review['status']) { ?>
				<option value="1" selected><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected><?php echo $text_disabled; ?></option>
				<?php } ?>
				</select></td>
              <td class="right"><?php foreach ($review['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="13"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#button-delete-image').live('click', function() {
	if (!confirm('<?php echo $text_delete; ?>')) {
		return false;
	}

	var box = $(this).parent();
	var copy = box.html();
	var review_id = $(this).attr('data-review-id');

	$.ajax({
		url: 'index.php?route=product_review/review/deleteimage&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
		data: 'review_id=' + encodeURIComponent(review_id),
		beforeSend: function() {
			box.html('<img src="view/image/loading.gif" />');
		},
		complete: function() {

		},
		success: function(data) {
			if (data['error']) {
				alert(data['error']);

				box.html(copy);
			}

			if (data['success']) {
				box.html(data['success']);
			}
		}
	});
});
//--></script>
<?php echo $footer; ?>