<div class="answer_container">
<?php foreach ($answers as $answer) { ?>
<div class="media">
  <blockquote>
    <span class="answer clearfix"><i class="pull-right icon-<?php echo $answer['status'] ? 'ok icon-green' : 'ban-circle icon-red'; ?>" title="<?php echo $answer['status'] ? $text_enabled : $text_disabled; ?>" rel="tooltip" data-original-title="<?php echo $answer['status'] ? $text_enabled : $text_disabled; ?>"></i><?php if ($answer['language_id']) { echo $answer['answer']; } else { ?><em>[ <?php echo $text_no_answer_text; ?> ]</em><?php } ?></span>
    <small class="nowrap"><span class="author"><strong title="<?php echo $answer['email']; ?>"><?php echo $answer['author']; ?></strong>, <?php echo $answer['date_added']; ?></span><span class="pull-right likes-dislikes"><i class="icon-thumbs-up"></i> <span class="likes-count"><?php echo $answer['likes']; ?></span> <i class="icon-thumbs-down"></i> <span class="dislikes-count"><?php echo $answer['dislikes']; ?></span></small>
  </blockquote>
</div>
<?php } ?>
</div>
