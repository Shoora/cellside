<?php if ($status) { ?>
<?php if ($position == "column_left" || $position == "column_right") { ?>
<form method="post" action="<?php echo $action; ?>" class="form-horizontal" role="form" id="qap-module-question-form<?php echo $idx; ?>">
	<fieldset>
		<input type="hidden" name="index" value="<?php echo $idx; ?>" />
		<?php if ($product_id) { ?>
		<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
		<?php } ?>
		<div class="qap-container container">
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
			<div class="form-group<?php echo ($error_question) ? ' has-error' : ''; ?>">
				<label for="qap_question<?php echo $idx; ?>" class="sr-only"><span class="qap-required"></span><?php echo $entry_question; ?></label>
				<input type="text" id="qap_question<?php echo $idx; ?>" name="question" maxlength="<?php echo $max_question_len; ?>" value="<?php echo $question; ?>" placeholder="* <?php echo $text_question; ?>" class="form-control" />
				<?php if ($error_question) { ?>
				<span class="help-block"><?php echo $error_question; ?></span>
				<?php } ?>
			</div>
			<div class="form-group<?php echo ($error_details) ? ' has-error' : ''; ?>">
				<label for="qap_details<?php echo $idx; ?>" class="sr-only"><?php echo $entry_details; ?></label>
				<textarea id="qap_details<?php echo $idx; ?>" name="details" maxlength="<?php echo $max_details_len; ?>" placeholder="<?php echo $text_details; ?>" class="form-control" rows="5" data-min-height="50"><?php echo $details; ?></textarea>
				<?php if ($error_details) { ?>
				<span class="help-block"><?php echo $error_details; ?></span>
				<?php } ?>
			</div>
			<div class="form-group<?php echo ($error_name) ? ' has-error' : ''; ?>">
				<label for="qap_name<?php echo $idx; ?>" class="sr-only"><span class="qap-required"></span><?php echo $entry_name; ?></label>
				<input type="text" id="qap_name<?php echo $idx; ?>" name="name" maxlength="<?php echo $max_name_len; ?>" value="<?php echo $name; ?>" placeholder="* <?php echo $text_name; ?>" class="form-control" />
				<?php if ($error_name) { ?>
				<span class="help-block"><?php echo $error_name; ?></span>
				<?php } ?>
			</div>
			<div class="form-group<?php echo ($error_email) ? ' has-error' : ''; ?>">
				<label for="qap_email<?php echo $idx; ?>" class="sr-only"><?php echo $entry_email; ?></label>
				<input type="email" id="qap_email<?php echo $idx; ?>" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $text_email; ?>" class="form-control" />
				<?php if ($error_email) { ?>
				<span class="help-block"><?php echo $error_email; ?></span>
				<?php } ?>
				<div class="checkbox">
					<label for="qap_notify<?php echo $idx; ?>">
						<input type="checkbox" id="qap_notify<?php echo $idx; ?>" name="notify" value="1"<?php echo ((int)$notify) ? ' checked': ''; ?> />
						<?php echo $text_notify; ?>
					</label>
				</div>
			</div>
			<?php if (!$logged) { ?>
			<div class="form-group qap-extra-margin<?php echo ($error_captcha) ? ' has-error' : ''; ?>">
				<label for="qap_captcha<?php echo $idx; ?>" class="sr-only"><span class="qap-required"></span><?php echo $entry_captcha; ?></label>
				<input type="text" id="qap_captcha<?php echo $idx; ?>" name="captcha" value="<?php echo $captcha; ?>" placeholder="* <?php echo $text_captcha; ?>" class="form-control" />
				<?php if ($error_captcha) { ?>
				<span class="help-block"><?php echo $error_captcha; ?></span>
				<?php } ?>
				<div class="text-center qap-margin">
					<img src="<?php echo $captcha_img; ?>" height="35" />
				</div>
			</div>
			<?php } ?>
			<div class="form-group">
				<div class="text-center">
					<input type="button" value="<?php echo $button_submit; ?>" class="button qap-submit" data-form="#qap-module-question-form<?php echo $idx; ?>" />
				</div>
			</div>
			<?php if ($display_faq_link) { ?>
			<p class="text-center"><a href="<?php echo $view_faq; ?>"><?php echo $text_view_faq; ?></a></p>
			<?php } ?>
		</div>
	</fieldset>
</form>
<?php } else if ($position == "content_modal") { ?>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="qap-question-modal-title"><?php echo $heading; ?></h4>
		</div>
		<div class="modal-body">
			<form method="post" action="<?php echo $action; ?>" class="form-horizontal" role="form" id="qap-modal-question-form<?php echo $idx; ?>">
				<fieldset>
					<input type="hidden" name="index" value="<?php echo $idx; ?>" />
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
						<div class="form-group<?php echo ($error_question) ? ' has-error' : ''; ?>">
							<label for="qap_question<?php echo $idx; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_question; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="text" id="qap_question<?php echo $idx; ?>" name="question" maxlength="<?php echo $max_question_len; ?>" value="<?php echo $question; ?>" placeholder="" class="form-control" />
								<?php if ($error_question) { ?>
								<span class="help-block"><?php echo $error_question; ?></span>
								<?php } ?>
							</div>
						</div>
						<div class="form-group<?php echo ($error_details) ? ' has-error' : ''; ?>">
							<label for="qap_details<?php echo $idx; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><?php echo $entry_details; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<textarea id="qap_details<?php echo $idx; ?>" name="details" maxlength="<?php echo $max_details_len; ?>" placeholder="<?php echo $text_details; ?>" class="form-control" rows="5"><?php echo $details; ?></textarea>
								<?php if ($error_details) { ?>
								<span class="help-block"><?php echo $error_details; ?></span>
								<?php } ?>
								<?php if ($bbcode) { ?>
								<small><a href="<?php echo $bbcode_tags; ?>" class="qap-bbcode-tags" target="_blank"><?php echo $text_bbcode; ?></a></small>
								<?php } ?>
							</div>
						</div>
						<div class="form-group qap-extra-margin<?php echo ($error_name) ? ' has-error' : ''; ?>">
							<label for="qap_name<?php echo $idx; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_name; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="text" id="qap_name<?php echo $idx; ?>" name="name" maxlength="<?php echo $max_name_len; ?>" value="<?php echo $name; ?>" placeholder="" class="form-control" />
								<?php if ($error_name) { ?>
								<span class="help-block"><?php echo $error_name; ?></span>
								<?php } ?>
							</div>
						</div>
						<div class="form-group<?php echo ($error_email) ? ' has-error' : ''; ?>">
							<label for="qap_email<?php echo $idx; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><?php echo $entry_email; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="email" id="qap_email<?php echo $idx; ?>" name="email" value="<?php echo $email; ?>" placeholder="" class="form-control" />
								<?php if ($error_email) { ?>
								<span class="help-block"><?php echo $error_email; ?></span>
								<?php } ?>
								<div class="checkbox">
									<label for="qap_notify<?php echo $idx; ?>">
										<input type="checkbox" id="qap_notify<?php echo $idx; ?>" name="notify" value="1"<?php echo ((int)$notify) ? ' checked': ''; ?> />
										<?php echo $text_notify; ?>
									</label>
								</div>
							</div>
						</div>
						<?php if (!$logged) { ?>
						<div class="form-group qap-double-margin<?php echo ($error_captcha) ? ' has-error' : ''; ?>">
							<label for="qap_captcha<?php echo $idx; ?>" class="col-sm-4 col-md-4 col-lg-4 control-label"><span class="qap-required"></span><?php echo $entry_captcha; ?></label>
							<div class="col-sm-8 col-md-8 col-lg-8 qap-input">
								<input type="text" id="qap_captcha<?php echo $idx; ?>" name="captcha" value="<?php echo $captcha; ?>" placeholder="" class="form-control" />
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
			<?php if ($display_faq_link) { ?>
			<a href="<?php echo $view_faq; ?>" class="btn btn-link pull-left"><?php echo $text_view_faq; ?></a>
			<?php } ?>
			<button type="button" class="btn btn-default qap-cancel" data-dismiss="modal"><?php echo $button_cancel; ?></button>
			<button type="button" class="btn btn-primary qap-submit" data-form="#qap-modal-question-form<?php echo $idx; ?>"><?php echo $button_submit; ?></button>
		</div>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<?php } else { ?>
<form method="post" action="<?php echo $action; ?>" class="form-horizontal" role="form" id="qap-module-question-form<?php echo $idx; ?>">
	<fieldset>
		<input type="hidden" name="index" value="<?php echo $idx; ?>" />
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
			<div class="form-group<?php echo ($error_question) ? ' has-error' : ''; ?>">
				<label for="qap_question<?php echo $idx; ?>" class="col-sm-3 col-md-3 col-lg-3 control-label"><span class="qap-required"></span><?php echo $entry_question; ?></label>
				<div class="col-sm-7 col-md-7 col-lg-7 qap-input">
					<input type="text" id="qap_question<?php echo $idx; ?>" name="question" maxlength="<?php echo $max_question_len; ?>" value="<?php echo $question; ?>" placeholder="" class="form-control" />
					<?php if ($error_question) { ?>
					<span class="help-block"><?php echo $error_question; ?></span>
					<?php } ?>
				</div>
			</div>
			<div class="form-group<?php echo ($error_details) ? ' has-error' : ''; ?>">
				<label for="qap_details<?php echo $idx; ?>" class="col-sm-3 col-md-3 col-lg-3 control-label"><?php echo $entry_details; ?></label>
				<div class="col-sm-7 col-md-7 col-lg-7 qap-input">
					<textarea id="qap_details<?php echo $idx; ?>" name="details" maxlength="<?php echo $max_details_len; ?>" placeholder="<?php echo $text_details; ?>" class="form-control" rows="5"><?php echo $details; ?></textarea>
					<?php if ($error_details) { ?>
					<span class="help-block"><?php echo $error_details; ?></span>
					<?php } ?>
					<?php if ($bbcode) { ?>
					<small><a href="<?php echo $bbcode_tags; ?>" class="qap-bbcode-tags" target="_blank"><?php echo $text_bbcode; ?></a></small>
					<?php } ?>
				</div>
			</div>
			<div class="form-group qap-extra-margin<?php echo ($error_name) ? ' has-error' : ''; ?>">
				<label for="qap_name<?php echo $idx; ?>" class="col-sm-3 col-md-3 col-lg-3 control-label"><span class="qap-required"></span><?php echo $entry_name; ?></label>
				<div class="col-sm-4 col-md-4 col-lg-4 qap-input">
					<input type="text" id="qap_name<?php echo $idx; ?>" name="name" maxlength="<?php echo $max_name_len; ?>" value="<?php echo $name; ?>" placeholder="" class="form-control" />
					<?php if ($error_name) { ?>
					<span class="help-block"><?php echo $error_name; ?></span>
					<?php } ?>
				</div>
			</div>
			<div class="form-group<?php echo ($error_email) ? ' has-error' : ''; ?>">
				<label for="qap_email<?php echo $idx; ?>" class="col-sm-3 col-md-3 col-lg-3 control-label"><?php echo $entry_email; ?></label>
				<div class="col-sm-4 col-md-4 col-lg-4 qap-input">
					<input type="email" id="qap_email<?php echo $idx; ?>" name="email" value="<?php echo $email; ?>" placeholder="" class="form-control" />
					<?php if ($error_email) { ?>
					<span class="help-block"><?php echo $error_email; ?></span>
					<?php } ?>
				</div>
				<div class="col-sm-7 col-sm-offset-3 col-md-7 col-md-offset-3 col-lg-7 col-lg-offset-3 qap-input">
					<div class="checkbox">
						<label for="qap_notify<?php echo $idx; ?>">
							<input type="checkbox" id="qap_notify<?php echo $idx; ?>" name="notify" value="1"<?php echo ((int)$notify) ? ' checked': ''; ?> />
							<?php echo $text_notify; ?>
						</label>
					</div>
				</div>
			</div>
			<?php if (!$logged) { ?>
			<div class="form-group qap-double-margin<?php echo ($error_captcha) ? ' has-error' : ''; ?>">
				<label for="qap_captcha<?php echo $idx; ?>" class="col-sm-3 col-md-3 col-lg-3 control-label"><span class="qap-required"></span><?php echo $entry_captcha; ?></label>
				<div class="col-sm-7 col-md-7 col-lg-7 qap-input">
					<input type="text" id="qap_captcha<?php echo $idx; ?>" name="captcha" value="<?php echo $captcha; ?>" placeholder="" class="form-control" />
					<?php if ($error_captcha) { ?>
					<span class="help-block"><?php echo $error_captcha; ?></span>
					<?php } ?>
				</div>
				<div class="col-sm-7 col-sm-offset-3 col-md-7 col-md-offset-3 col-lg-7 col-lg-offset-3 qap-margin">
					<img src="<?php echo $captcha_img; ?>" height="35" />
				</div>
			</div>
			<?php } ?>
			<div class="form-group">
				<div class="col-sm-7 col-sm-offset-3 col-md-7 col-md-offset-3 col-lg-7 col-lg-offset-3 qap-input">
					<input type="button" value="<?php echo $button_submit; ?>" class="button qap-submit" data-form="#qap-module-question-form<?php echo $idx; ?>" />
				</div>
			</div>
			<?php if ($display_faq_link) { ?>
			<div class="form-group">
				<div class="col-sm-7 col-sm-offset-3 col-md-7 col-md-offset-3 col-lg-7 col-lg-offset-3 qap-input">
					<p><a href="<?php echo $view_faq; ?>"><?php echo $text_view_faq; ?></a></p>
				</div>
			</div>
			<?php } ?>
		</div>
	</fieldset>
</form>
<?php } ?>
<?php } ?>