<div class="row qap-btm-margin">
	<div class="col-sm-6 qap-stat">
		<?php if (!$login_to_view_questions) { ?>
		<span class="text-muted"><?php echo $text_total_questions; ?><span class="badge"><?php echo $total_questions; ?></span></span>
		<span class="text-muted"><?php echo $text_total_answers; ?><span class="badge"><?php echo $total_answers; ?></span></span>
		<span class="text-muted">|</span>
		<span><a href="#" id="qap-expand-collapse" class="qap-exp"><?php echo $text_expand_all; ?></a></span>
		<?php } ?>
	</div>
	<div class="col-sm-6 text-right">
		<?php if ($show_ask_button) { ?>
		<input type="button" class="button qap-ask-<?php echo $type; ?>" value="<?php echo addslashes($button_ask); ?>" />
		<?php } else { ?>
		<a href="<?php echo $login_link; ?>" class="button"><?php echo $button_login_ask; ?></a>
		<?php } ?>
	</div>
</div>
<div class="qap-questions" data-update-link="<?php echo $update_link; ?>">
	<?php if ($login_to_view_questions) { ?>
	<div class="row">
		<div class="col-xs-12">
			<p class="text-center qap-no-btm-margin"><?php echo $text_login_to_view_questions; ?></p>
		</div>
	</div>
	<?php } else if (!empty($questions)) { ?>
	<div class="panel-group qap-q-list">
		<?php foreach ($questions as $q) { ?>
		<div class="panel panel-default qap-q">
			<div class="panel-heading">
				<a href="#question<?php echo $q['question_id']; ?>" data-toggle="collapse" class="qap-q-hdr<?php echo ($question_id == $q['question_id']) ? '' : ' collapsed'; ?>">
					<div class="row">
						<div class="col-sm-12">
							<i class="icon-question icon-2x qap-q-mark"></i>
							<span class="qap-q-h"><?php echo $q['question']; ?></span>
							<span class="text-muted pull-right qap-a-cnt"><?php echo $text_total_answers; ?><span class="badge"><?php echo count($q['answers']); ?></span></span>
						</div>
					</div>
				</a>
			</div>
			<div class="panel-collapse collapse<?php echo ($question_id == $q['question_id']) ? ' in' : ''; ?> qap-q-data" id="question<?php echo $q['question_id']; ?>">
				<div class="panel-body">
					<div class="well well-sm qap-q-full">
						<div class="qap-q-main"><?php echo $q['question']; ?></div>
						<div class="qap-q-details"><?php echo $q['details']; ?></div>
						<div class="qap-q-origin"><?php if ($display_question_author) { ?><span class="qap-author"><i class="icon-user text-muted"></i> <?php echo $q['author']; ?></span><?php } ?><?php if ($display_question_date) { ?><span class="qap-date">[ <?php echo $q['date_added']; ?> ]</span><?php } ?></div>
					</div>
					<?php if ($login_to_view_question_answers) { ?>
					<div class="text-center"><?php echo $text_login_to_view_answers; ?></div>
					<?php } else { ?>
					<?php if (count($q['answers'])) { ?>
					<ul class="qap-answers media-list">
						<?php foreach ($q['answers'] as $a) { ?>
						<li class="media qap-a">
							<span class="pull-left media-object"><i class="icon-comment qap-a-mark"></i></span>
							<div class="media-body">
									<?php echo $a['answer']; ?>
									<div class="qap-a-origin"><?php if ($display_answer_author) { ?><span class="qap-author"><i class="icon-user text-muted"></i> <?php echo $a['author']; ?></span><?php } ?><?php if ($display_answer_date) { ?><span class="qap-date">[ <?php echo $a['date_added']; ?> ]</span><?php } ?></div>
									<?php if ($allow_answer_voting) { ?>
									<div class="qap-a-ld text-right">
										<small class="qap-a-helpful"><?php echo $text_was_helpful; ?></small><span class="qap-a-rating"><a class="qap-helpful"<?php if ($logged) { ?> href="<?php echo $vote_helpful . $a['answer_id'] . (($a['my_vote'] && $a['my_vote'] > 0) ? '&remove=1' : ''); ?>"<?php } ?>><i class="icon-thumbs-up<?php echo ($a['my_vote'] && $a['my_vote'] > 0) ? ' qap-selected' : ''; ?>" rel="tooltip" data-original-title="<?php echo ($logged) ? $text_helpful_answer : $text_login_to_vote; ?>" data-container="body"></i></a><span class="qap-rating"><?php echo (int)$a['likes'] * 1 + (int)$a['dislikes'] * -1; ?></span><a class="qap-unhelpful"<?php if ($logged) { ?> href="<?php echo $vote_unhelpful . $a['answer_id'] . (($a['my_vote'] && $a['my_vote'] < 0) ? '&remove=1' : ''); ?>"<?php } ?>><i class="icon-thumbs-down<?php echo ($a['my_vote'] && $a['my_vote'] < 0) ? ' qap-selected' : ''; ?>" rel="tooltip" data-original-title="<?php echo ($logged) ? $text_unhelpful_answer : $text_login_to_vote; ?>" data-container="body"></i></a></span>
									</div>
									<?php } ?>
							</div>
						</li>
						<?php } ?>
					</ul>
					<?php } ?>
					<?php } ?>
				</div>
				<?php if ((int)$q['allow_answers'] && $show_answer_button) { ?>
				<div class="panel-footer text-right">
					<input type="button" class="button qap-answer-<?php echo $type; ?>" data-href="<?php echo $answer_form_link . $q['question_id']; ?>" value="<?php echo addslashes($button_answer); ?>" />
				</div>
				<?php } else if ((int)$q['allow_answers'] && $login_required_to_answer) { ?>
				<div class="panel-footer text-right">
					<a href="<?php echo $login_link; ?>" class="button"><?php echo $button_login_answer; ?></a>
				</div>
				<?php } ?>
			</div>
		</div>
		<?php } ?>
	</div>
	<?php } else { ?>
	<div class="row">
		<div class="col-xs-12">
			<p class="text-center qap-no-btm-margin"><?php echo $text_no_questions; ?></p>
		</div>
	</div>
	<?php } ?>
</div>
<?php if (!empty($questions) && !$login_to_view_questions) { ?>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } ?>