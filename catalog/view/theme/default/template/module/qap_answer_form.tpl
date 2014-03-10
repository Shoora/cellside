<?php if ($status) { ?>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="qap-answer-modal-title"><?php echo $heading; ?></h4>
		</div>
		<div class="modal-body">
			<form method="post" action="<?php echo $action; ?>" class="form-horizontal" role="form" id="qap-modal-answer-form<?php echo $question_id; ?>">
				<fieldset>
					<input type="hidden" name="question_id" value="<?php echo $question_id; ?>" />
					<?php if ($product_id) { ?>
					<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
					<?php } ?>
					<div class="qap-container">
						<div class="qap-overlay">
							<div class="qap-tbl">
								<div class="qap-tbl-cell"><i class="icon-refresh icon-spin icon-5x text-muted"></i></div>
							</div>
						</div>
						<div class="qap-notice">
							<?php if ($success) { ?>
							<div class="alert alert-success"><?php echo $success; ?></div>
							<?php } else if ($error_warning) { ?>
							<div class="alert alert-error"><?php echo $error_warning; ?></div>
							<?php } ?>
						</div>
						<div class="form-group">
							<label class="col-sm-4 col-md-4 col-lg-4 control-label"><?php echo $entry_question; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8">
                <div class="qap-q-main"><?php echo $question; ?></div>
                <div class="qap-q-details"><?php echo $details; ?></div>
							</div>
						</div>
						<div class="form-group<?php echo ($error_answer) ? ' has-error' : ''; ?>">
							<label for="qap_question<?php echo $question_id; ?>_answer" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_answer; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<textarea id="qap_question<?php echo $question_id; ?>_answer" name="answer" maxlength="<?php echo $max_answer_len; ?>" placeholder="<?php echo $text_answer; ?>" class="form-control" rows="5"><?php echo $answer; ?></textarea>
								<?php if ($error_answer) { ?>
								<span class="help-block"><?php echo $error_answer; ?></span>
								<?php } ?>
								<?php if ($bbcode) { ?>
								<small><a href="<?php echo $bbcode_tags; ?>" class="qap-bbcode-tags" target="_blank"><?php echo $text_bbcode; ?></a></small>
								<?php } ?>
							</div>
						</div>
						<div class="form-group qap-extra-margin<?php echo ($error_name) ? ' has-error' : ''; ?>">
							<label for="qap_answer_name<?php echo $question_id; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_name; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="text" id="qap_answer_name<?php echo $question_id; ?>" name="name" maxlength="<?php echo $max_name_len; ?>" value="<?php echo $name; ?>" placeholder="" class="form-control" />
								<?php if ($error_name) { ?>
								<span class="help-block"><?php echo $error_name; ?></span>
								<?php } ?>
							</div>
						</div>
						<div class="form-group<?php echo ($error_email) ? ' has-error' : ''; ?>">
							<label for="qap_answer_email<?php echo $question_id; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><?php echo $entry_email; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="email" id="qap_answer_email<?php echo $question_id; ?>" name="email" value="<?php echo $email; ?>" placeholder="" class="form-control" />
								<?php if ($error_email) { ?>
								<span class="help-block"><?php echo $error_email; ?></span>
								<?php } ?>
							</div>
						</div>
						<?php if (!$logged) { ?>
						<div class="form-group qap-double-margin<?php echo ($error_captcha) ? ' has-error' : ''; ?>">
							<label for="qap_answer_captcha<?php echo $question_id; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_captcha; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="text" id="qap_answer_captcha<?php echo $question_id; ?>" name="captcha" value="<?php echo $captcha; ?>" placeholder="" class="form-control" />
								<?php if ($error_captcha) { ?>
								<span class="help-block"><?php echo $error_captcha; ?></span>
								<?php } ?>
							</div>
							<div class="col-sm-8 col-sm-offset-4 col-md-8 col-md-offset-4 col-lg-8 col-lg-offset-4 qap-margin">
								<img src="<?php echo $captcha_img; ?>" height="35" />
							</div>
						</div>
						<?php } ?>
					</div>
				</fieldset>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default qap-cancel" data-dismiss="modal"><?php echo $button_cancel; ?></button>
			<button type="button" class="btn btn-primary qap-submit" data-form="#qap-modal-answer-form<?php echo $question_id; ?>"><?php echo $button_submit; ?></button>
		</div>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<?php } ?>