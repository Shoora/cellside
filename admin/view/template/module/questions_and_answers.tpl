<?php echo $header; ?>
<div class="modal hide fade" id="legal_text">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h3><?php echo $text_terms; ?></h3>
	</div>
	<div class="modal-body">
	</div>
	<div class="modal-footer">
		<button type="button" class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $button_close; ?></button>
	</div>
</div>
<div class="modal hide fade" id="help_text">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h3><?php echo $text_help_request; ?></h3>
	</div>
	<div class="modal-body">
	</div>
	<div class="modal-footer">
		<button type="button" class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $button_close; ?></button>
	</div>
</div>
<div class="modal hide fade" id="bbCode_reference">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h3><?php echo $text_bbcode_tags_reference; ?></h3>
	</div>
	<div class="modal-body qap-container">
		<table class="table table-striped table-condensed">
			<thead>
				<tr>
					<th style="width:20%;"><?php echo $text_name; ?></th>
					<th style="width:15%;"><?php echo $text_tag; ?></th>
					<th><?php echo $text_syntax; ?></th>
				</tr>
			</thead>
			<tbody style="line-height:150%;">
				<tr>
					<td><strong>Bold</strong></td>
					<td>b</td>
					<td>[b]{text}[/b]</td>
				</tr>
				<tr>
					<td><strong>Italic</strong></td>
					<td>i</td>
					<td>[i]{text}[/i]</td>
				</tr>
				<tr>
					<td><strong>Underline</strong></td>
					<td>u</td>
					<td>[u]{text}[/u]</td>
				</tr>
				<tr>
					<td><strong>Striketrough</strong></td>
					<td>s</td>
					<td>[s]{text}[/s]</td>
				</tr>
				<tr>
					<td><strong>Quote</strong></td>
					<td>quote</td>
					<td>
						<span class="muted">Plain:</span> [quote]{text}[/quote]<br/>
						<span class="muted">Cited:</span> [quote={author}]{text}[/quote]
					</td>
				</tr>
				<tr>
					<td><strong>Code</strong></td>
					<td>code</td>
					<td>[code]{text}[/code]</td>
				</tr>
				<tr>
					<td><strong>List</strong></td>
					<td>list</td>
					<td>
						<span class="muted">Unordered list:</span> [list]{items}[/list]<br/>
						<span class="muted">Ordered list:</span> [list={option}]{items}[/list]<br/>
						<span class="muted">List item:</span> [li]{text}[/li]<br/>
						<span class="muted">List item:</span> [*]{text}\newline
					</td>
				</tr>
				<tr>
					<td><strong>Image</strong></td>
					<td>img</td>
					<td>[img]{url}[/img]</td>
				</tr>
				<tr>
					<td><strong>Link</strong></td>
					<td>url</td>
					<td>
						<span class="muted">Plain:</span> [url]{url}[/url]<br/>
						<span class="muted">Named:</span> [url={url}]{text}[/url]
					</td>
				</tr>
				<tr>
					<td><strong>Font size</strong></td>
					<td>size</td>
					<td>[size={number}]{text}[/size]</td>
				</tr>
				<tr>
					<td><strong>Font colour</strong></td>
					<td>color</td>
					<td>[color={color}]{text}[/color]</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="modal-footer">
		<button type="button" class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $button_close; ?></button>
	</div>
</div>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
	<div class="warning qap-alert"><?php echo $error_warning; ?></div>
	<?php } else if ($success) { ?>
	<div class="success qap-alert"><?php echo $success; ?></div>
	<?php } ?>
	<?php if ($error_notice) { ?>
	<div class="attention qap-alert"><?php echo $error_notice; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="pull-right list-view-buttons">
				<div class="btn-group">
					<button class="btn btn-small" type="button" id="apply"><?php echo $button_apply; ?></button>
					<button class="btn btn-small btn-primary" type="button" id="save"><i class="icon-save icon-small"></i><?php echo $button_save; ?></button>
					<button class="btn btn-small btn-warning" type="button" id="cancel" data-href="<?php echo $cancel; ?>"><i class="icon-ban-circle icon-small"></i><?php echo $button_cancel; ?></button>
				</div>
			</div>
		</div>
		<div class="content qap-content">
			<div id="overlay" class="qap-overlay">
				<div class="tbl qap-max-h">
					<div class="tbl_cell"><i class="icon-refresh icon-spin icon-5x text-muted"></i></div>
				</div>
			</div>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
					<li><a href="#module" data-toggle="tab"><?php echo $tab_module; ?></a></li>
					<li><a href="#about" data-toggle="tab"><?php echo $tab_about; ?></a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="settings">
						<fieldset>
							<legend><span><?php echo $text_general; ?></span></legend>
							<div class="control-group">
								<label class="control-label" for="qap_status"><?php echo $entry_extension_status; ?></label>
								<div class="controls">
									<select name="qap_status" id="qap_status" class="input-medium">
										<option value="1"<?php echo ((int)$qap_status) ? ' selected' : ''; ?>><?php echo $text_enabled; ?></option>
										<option value="0"<?php echo (!(int)$qap_status) ? ' selected' : ''; ?>><?php echo $text_disabled; ?></option>
									</select>
									<input type="hidden" name="qap_installed" value="1" />
									<input type="hidden" name="qap_installed_version" value="<?php echo $qap_installed_version; ?>" />
									<input type="hidden" name="qap_multilingual" value="<?php echo $multilingual; ?>" />
									<input type="hidden" name="qap_list_questions" value="<?php echo $qap_list_questions; ?>" />
									<input type="hidden" name="qap_list_language" value="<?php echo $qap_list_language; ?>" />
									<input type="hidden" name="qap_min_name_length" value="<?php echo $qap_min_name_length; ?>" />
									<input type="hidden" name="qap_max_name_length" value="<?php echo $qap_max_name_length; ?>" />
									<input type="hidden" name="qap_min_answer_length" value="<?php echo $qap_min_answer_length; ?>" />
									<input type="hidden" name="qap_max_answer_length" value="<?php echo $qap_max_answer_length; ?>" />
									<input type="hidden" name="qap_min_question_length" value="<?php echo $qap_min_question_length; ?>" />
									<input type="hidden" name="qap_max_question_length" value="<?php echo $qap_max_question_length; ?>" />
									<input type="hidden" name="qap_max_details_length" value="<?php echo $qap_max_details_length; ?>" />
									<input type="hidden" name="qap_admin_url" value="<?php echo $qap_admin_url; ?>" />
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="qap_available_bbcode_tags"><?php echo $entry_available_bbcode_tags; ?></label>
								<div class="controls">
									<input type="text" name="qap_available_bbcode_tags" id="qap_available_bbcode_tags" value="<?php echo $qap_available_bbcode_tags; ?>" class="input-medium">
									<span class="help-inline info"><?php echo $help_available_bbcode_tags; ?></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_display_question_date; ?></label>
								<div class="controls">
									<label for="qap_display_question_date1" class="radio inline"><input type="radio" name="qap_display_question_date" value="1" id="qap_display_question_date1"<?php echo ((int)$qap_display_question_date) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_display_question_date0" class="radio inline"><input type="radio" name="qap_display_question_date" value="0" id="qap_display_question_date0"<?php echo (!(int)$qap_display_question_date) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_display_question_author; ?></label>
								<div class="controls">
									<label for="qap_display_question_author1" class="radio inline"><input type="radio" name="qap_display_question_author" value="1" id="qap_display_question_author1"<?php echo ((int)$qap_display_question_author) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_display_question_author0" class="radio inline"><input type="radio" name="qap_display_question_author" value="0" id="qap_display_question_author0"<?php echo (!(int)$qap_display_question_author) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_display_answer_date; ?></label>
								<div class="controls">
									<label for="qap_display_answer_date1" class="radio inline"><input type="radio" name="qap_display_answer_date" value="1" id="qap_display_answer_date1"<?php echo ((int)$qap_display_answer_date) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_display_answer_date0" class="radio inline"><input type="radio" name="qap_display_answer_date" value="0" id="qap_display_answer_date0"<?php echo (!(int)$qap_display_answer_date) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_display_answer_author; ?></label>
								<div class="controls">
									<label for="qap_display_answer_author1" class="radio inline"><input type="radio" name="qap_display_answer_author" value="1" id="qap_display_answer_author1"<?php echo ((int)$qap_display_answer_author) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_display_answer_author0" class="radio inline"><input type="radio" name="qap_display_answer_author" value="0" id="qap_display_answer_author0"<?php echo (!(int)$qap_display_answer_author) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_new_question_notification; ?></label>
								<div class="controls">
									<label for="qap_new_question_notification1" class="radio inline"><input type="radio" name="qap_new_question_notification" value="1" id="qap_new_question_notification1" data-linked="#qap_notification_emails"<?php echo ((int)$qap_new_question_notification) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_new_question_notification0" class="radio inline"><input type="radio" name="qap_new_question_notification" value="0" id="qap_new_question_notification0" data-linked="#qap_notification_emails"<?php echo (!(int)$qap_new_question_notification) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_new_question_notification; ?></span>
								</div>
							</div>
							<div id="qap_new_answer_notification"<?php echo (!(int)$qap_allow_customer_answers) ? ' style="display:none;"': ''; ?>>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_new_answer_notification; ?></label>
									<div class="controls">
										<label for="qap_new_answer_notification1" class="radio inline"><input type="radio" name="qap_new_answer_notification" value="1" id="qap_new_answer_notification1" data-linked="#qap_notification_emails"<?php echo ((int)$qap_new_answer_notification) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_new_answer_notification0" class="radio inline"><input type="radio" name="qap_new_answer_notification" value="0" id="qap_new_answer_notification0" data-linked="#qap_notification_emails"<?php echo (!(int)$qap_new_answer_notification) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_new_answer_notification; ?></span>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_show_answer_in_notification; ?></label>
								<div class="controls">
									<label for="qap_show_answer_in_customer_notification1" class="radio inline"><input type="radio" name="qap_show_answer_in_customer_notification" value="1" id="qap_show_answer_in_customer_notification1"<?php echo ((int)$qap_new_question_notification) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_show_answer_in_customer_notification0" class="radio inline"><input type="radio" name="qap_show_answer_in_customer_notification" value="0" id="qap_show_answer_in_customer_notification0"<?php echo (!(int)$qap_new_question_notification) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_show_answer_in_notification; ?></span>
								</div>
							</div>
							<div id="qap_notification_emails"<?php echo (!(int)$qap_new_question_notification && !(int)$qap_new_answer_notification) ? ' style="display:none;"': ''; ?>>
								<div class="control-group<?php echo ($error_qap_notification_emails) ? ' error': ''; ?>">
									<label class="control-label" for="qap_available_bbcode_tags1"><?php echo $entry_notification_emails; ?></label>
									<div class="controls">
										<input type="text" name="qap_notification_emails" id="qap_available_bbcode_tags1" value="<?php echo $qap_notification_emails; ?>" class="input-xlarge"/>
										<span class="help-inline info"><?php echo $help_notification_emails; ?></span>
										<?php if ($error_qap_notification_emails) { ?>
										<span class="help-block error"><?php echo $error_emails; ?></span>
										<?php } ?>
									</div>
								</div>
							</div>
							<div class="control-group<?php echo ($error_qap_questions_per_page) ? ' error': ''; ?>">
								<label class="control-label" for="qap_questions_per_page"><?php echo $entry_questions_per_page; ?></label>
								<div class="controls">
									<input type="text" name="qap_questions_per_page" id="qap_questions_per_page" value="<?php echo $qap_questions_per_page; ?>" class="input-mini"/>
									<?php if ($error_qap_questions_per_page) { ?>
									<span class="help-block error"><?php echo $error_per_page; ?></span>
									<?php } ?>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_display_all_languages; ?></label>
								<div class="controls">
									<label for="qap_display_all_languages1" class="radio inline"><input type="radio" name="qap_display_all_languages" value="1" id="qap_display_all_languages1"<?php echo ((int)$qap_display_all_languages) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_display_all_languages0" class="radio inline"><input type="radio" name="qap_display_all_languages" value="0" id="qap_display_all_languages0"<?php echo (!(int)$qap_display_all_languages) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_display_all_languages; ?></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="qap_lazy_load"><?php echo $entry_lazy_load; ?></label>
								<div class="controls">
									<label for="qap_lazy_load1" class="radio inline"><input type="radio" name="qap_lazy_load" value="1" id="qap_lazy_load1"<?php echo ((int)$qap_lazy_load) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_lazy_load0" class="radio inline"><input type="radio" name="qap_lazy_load" value="0" id="qap_lazy_load0"<?php echo (!(int)$qap_lazy_load) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_lazy_load; ?></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_remove_sql_changes; ?></label>
								<div class="controls">
									<label for="qap_remove_sql_changes1" class="radio inline"><input type="radio" name="qap_remove_sql_changes" value="1" id="qap_remove_sql_changes1"<?php echo ((int)$qap_remove_sql_changes) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_remove_sql_changes0" class="radio inline"><input type="radio" name="qap_remove_sql_changes" value="0" id="qap_remove_sql_changes0"<?php echo (!(int)$qap_remove_sql_changes) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_remove_sql_changes; ?></span>
								</div>
							</div>
						</fieldset>
						<fieldset>
							<legend><span><?php echo $text_questions; ?></span></legend>
							<div class="control-group">
								<label class="control-label" for="qap_enable_general_questions"><?php echo $entry_general_questions; ?></label>
								<div class="controls">
									<select name="qap_enable_general_questions" id="qap_enable_general_questions" data-linked="#qap_login_to_view_general_questions,#qap_login_to_view_general_question_answers,#qap_login_to_ask_general_questions,#qap_allow_customer_general_answers,#qap_login_to_answer_general_questions" class="input-medium">
										<option value="1"<?php echo ((int)$qap_enable_general_questions) ? ' selected' : ''; ?>><?php echo $text_enabled; ?></option>
										<option value="0"<?php echo (!(int)$qap_enable_general_questions) ? ' selected' : ''; ?>><?php echo $text_disabled; ?></option>
									</select>
									<span class="help-inline info"><?php echo $help_general_questions; ?></span>
								</div>
							</div>
							<div id="qap_login_to_view_general_questions"<?php echo (!(int)$qap_enable_general_questions) ? ' style="display:none;"': ''; ?>>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_login_to_view_general_questions; ?></label>
									<div class="controls">
										<label for="qap_login_to_view_general_questions1" class="radio inline"><input type="radio" name="qap_login_to_view_general_questions" value="1" id="qap_login_to_view_general_questions1" data-linked="#qap_login_to_view_general_question_answers"<?php echo ((int)$qap_login_to_view_general_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_login_to_view_general_questions0" class="radio inline"><input type="radio" name="qap_login_to_view_general_questions" value="0" id="qap_login_to_view_general_questions0" data-linked="#qap_login_to_view_general_question_answers"<?php echo (!(int)$qap_login_to_view_general_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_login_to_view_general_questions; ?></span>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_login_to_view_product_questions; ?></label>
								<div class="controls">
									<label for="qap_login_to_view_product_questions1" class="radio inline"><input type="radio" name="qap_login_to_view_product_questions" value="1" id="qap_login_to_view_product_questions1" data-linked="#qap_login_to_view_product_question_answers"<?php echo ((int)$qap_login_to_view_product_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_login_to_view_product_questions0" class="radio inline"><input type="radio" name="qap_login_to_view_product_questions" value="0" id="qap_login_to_view_product_questions0" data-linked="#qap_login_to_view_product_question_answers"<?php echo (!(int)$qap_login_to_view_product_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_login_to_view_product_questions; ?></span>
								</div>
							</div>
							<div id="qap_login_to_ask_general_questions"<?php echo (!(int)$qap_enable_general_questions) ? ' style="display:none;"': ''; ?>>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_login_to_ask_general; ?></label>
									<div class="controls">
										<label for="qap_login_to_ask_general_questions1" class="radio inline"><input type="radio" name="qap_login_to_ask_general_questions" value="1" id="qap_login_to_ask_general_questions1"<?php echo ((int)$qap_login_to_ask_general_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_login_to_ask_general_questions0" class="radio inline"><input type="radio" name="qap_login_to_ask_general_questions" value="0" id="qap_login_to_ask_general_questions0"<?php echo (!(int)$qap_login_to_ask_general_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_login_to_ask_general; ?></span>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_login_to_ask_product; ?></label>
								<div class="controls">
									<label for="qap_login_to_ask_product_questions1" class="radio inline"><input type="radio" name="qap_login_to_ask_product_questions" value="1" id="qap_login_to_ask_product_questions1"<?php echo ((int)$qap_login_to_ask_product_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_login_to_ask_product_questions0" class="radio inline"><input type="radio" name="qap_login_to_ask_product_questions" value="0" id="qap_login_to_ask_product_questions0"<?php echo (!(int)$qap_login_to_ask_product_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_login_to_ask_product; ?></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_moderate_new_questions; ?></label>
								<div class="controls">
									<label for="qap_moderate_new_questions1" class="radio inline"><input type="radio" name="qap_moderate_new_questions" value="1" id="qap_moderate_new_questions1"<?php echo ((int)$qap_moderate_new_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_moderate_new_questions0" class="radio inline"><input type="radio" name="qap_moderate_new_questions" value="0" id="qap_moderate_new_questions0"<?php echo (!(int)$qap_moderate_new_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_moderate_new_questions; ?></span>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_allow_bbcode_in_questions; ?></label>
								<div class="controls">
									<label for="qap_allow_bbcode_in_questions1" class="radio inline"><input type="radio" name="qap_allow_bbcode_in_questions" value="1" id="qap_allow_bbcode_in_questions1"<?php echo ((int)$qap_allow_bbcode_in_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_allow_bbcode_in_questions0" class="radio inline"><input type="radio" name="qap_allow_bbcode_in_questions" value="0" id="qap_allow_bbcode_in_questions0"<?php echo (!(int)$qap_allow_bbcode_in_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
								</div>
							</div>
						</fieldset>
						<fieldset>
							<legend><span><?php echo $text_answers; ?></span></legend>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_allow_customer_answers; ?></label>
								<div class="controls">
									<label for="qap_allow_customer_answers1" class="radio inline"><input type="radio" name="qap_allow_customer_answers" value="1" id="qap_allow_customer_answers1" data-linked="#customer_answers,#qap_new_answer_notification"<?php echo ((int)$qap_allow_customer_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_allow_customer_answers0" class="radio inline"><input type="radio" name="qap_allow_customer_answers" value="0" id="qap_allow_customer_answers0" data-linked="#customer_answers,#qap_new_answer_notification"<?php echo (!(int)$qap_allow_customer_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_allow_customer_answers; ?></span>
								</div>
							</div>
							<div id="customer_answers"<?php echo (!(int)$qap_allow_customer_answers) ? ' style="display:none;"': ''; ?>>
								<div id="qap_allow_customer_general_answers"<?php echo (!(int)$qap_enable_general_questions) ? ' style="display:none;"': ''; ?>>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_general_question_answers; ?></label>
										<div class="controls">
											<label for="qap_allow_customer_general_answers1" class="radio inline"><input type="radio" name="qap_allow_customer_general_answers" value="1" id="qap_allow_customer_general_answers1"<?php echo ((int)$qap_allow_customer_general_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
											<label for="qap_allow_customer_general_answers0" class="radio inline"><input type="radio" name="qap_allow_customer_general_answers" value="0" id="qap_allow_customer_general_answers0"<?php echo (!(int)$qap_allow_customer_general_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
											<span class="help-inline info"><?php echo $help_general_question_answers; ?></span>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_product_question_answers; ?></label>
									<div class="controls">
										<label for="qap_allow_customer_product_answers1" class="radio inline"><input type="radio" name="qap_allow_customer_product_answers" value="1" id="qap_allow_customer_product_answers1"<?php echo ((int)$qap_allow_customer_product_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_allow_customer_product_answers0" class="radio inline"><input type="radio" name="qap_allow_customer_product_answers" value="0" id="qap_allow_customer_product_answers0"<?php echo (!(int)$qap_allow_customer_product_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_product_question_answers; ?></span>
									</div>
								</div>
								<div id="qap_login_to_view_general_question_answers"<?php echo (!(int)$qap_enable_general_questions || (int)$qap_login_to_view_general_questions) ? ' style="display:none;"': ''; ?>>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_login_to_view_general_answers; ?></label>
										<div class="controls">
											<label for="qap_login_to_view_general_question_answers1" class="radio inline"><input type="radio" name="qap_login_to_view_general_question_answers" value="1" id="qap_login_to_view_general_question_answers1"<?php echo ((int)$qap_login_to_view_general_question_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
											<label for="qap_login_to_view_general_question_answers0" class="radio inline"><input type="radio" name="qap_login_to_view_general_question_answers" value="0" id="qap_login_to_view_general_question_answers0"<?php echo (!(int)$qap_login_to_view_general_question_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
											<span class="help-inline info"><?php echo $help_login_to_view_general_answers; ?></span>
										</div>
									</div>
								</div>
								<div id="qap_login_to_view_product_question_answers"<?php echo ((int)$qap_login_to_view_product_questions) ? ' style="display:none;"': ''; ?>>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_login_to_view_product_answers; ?></label>
										<div class="controls">
											<label for="qap_login_to_view_product_question_answers1" class="radio inline"><input type="radio" name="qap_login_to_view_product_question_answers" value="1" id="qap_login_to_view_product_question_answers1"<?php echo ((int)$qap_login_to_view_product_question_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
											<label for="qap_login_to_view_product_question_answers0" class="radio inline"><input type="radio" name="qap_login_to_view_product_question_answers" value="0" id="qap_login_to_view_product_question_answers0"<?php echo (!(int)$qap_login_to_view_product_question_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
											<span class="help-inline info"><?php echo $help_login_to_view_product_answers; ?></span>
										</div>
									</div>
								</div>
								<div id="qap_login_to_answer_general_questions"<?php echo (!(int)$qap_enable_general_questions) ? ' style="display:none;"': ''; ?>>
									<div class="control-group">
										<label class="control-label"><?php echo $entry_login_to_answer_general; ?></label>
										<div class="controls">
											<label for="qap_login_to_answer_general_questions1" class="radio inline"><input type="radio" name="qap_login_to_answer_general_questions" value="1" id="qap_login_to_answer_general_questions1"<?php echo ((int)$qap_login_to_answer_general_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
											<label for="qap_login_to_answer_general_questions0" class="radio inline"><input type="radio" name="qap_login_to_answer_general_questions" value="0" id="qap_login_to_answer_general_questions0"<?php echo (!(int)$qap_login_to_answer_general_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
											<span class="help-inline info"><?php echo $help_login_to_answer_general; ?></span>
										</div>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_login_to_answer_product; ?></label>
									<div class="controls">
										<label for="qap_login_to_answer_product_questions1" class="radio inline"><input type="radio" name="qap_login_to_answer_product_questions" value="1" id="qap_login_to_answer_product_questions1"<?php echo ((int)$qap_login_to_answer_product_questions) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_login_to_answer_product_questions0" class="radio inline"><input type="radio" name="qap_login_to_answer_product_questions" value="0" id="qap_login_to_answer_product_questions0"<?php echo (!(int)$qap_login_to_answer_product_questions) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_login_to_answer_product; ?></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_moderate_customer_answers; ?></label>
									<div class="controls">
										<label for="qap_moderate_customer_answers1" class="radio inline"><input type="radio" name="qap_moderate_customer_answers" value="1" id="qap_moderate_customer_answers1"<?php echo ((int)$qap_moderate_customer_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_moderate_customer_answers0" class="radio inline"><input type="radio" name="qap_moderate_customer_answers" value="0" id="qap_moderate_customer_answers0"<?php echo (!(int)$qap_moderate_customer_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
										<span class="help-inline info"><?php echo $help_moderate_customer_answers; ?></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $entry_allow_bbcode_in_answers; ?></label>
									<div class="controls">
										<label for="qap_allow_bbcode_in_answers1" class="radio inline"><input type="radio" name="qap_allow_bbcode_in_answers" value="1" id="qap_allow_bbcode_in_answers1"<?php echo ((int)$qap_allow_bbcode_in_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
										<label for="qap_allow_bbcode_in_answers0" class="radio inline"><input type="radio" name="qap_allow_bbcode_in_answers" value="0" id="qap_allow_bbcode_in_answers0"<?php echo (!(int)$qap_allow_bbcode_in_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									</div>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label"><?php echo $entry_allow_answer_voting; ?></label>
								<div class="controls">
									<label for="qap_allow_answer_voting1" class="radio inline"><input type="radio" name="qap_allow_answer_voting" value="1" id="qap_allow_answer_voting1"<?php echo ((int)$qap_allow_answer_voting) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
									<label for="qap_allow_answer_voting0" class="radio inline"><input type="radio" name="qap_allow_answer_voting" value="0" id="qap_allow_answer_voting0"<?php echo (!(int)$qap_allow_answer_voting) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
									<span class="help-inline info"><?php echo $help_allow_answer_voting; ?></span>
								</div>
							</div>
						</fieldset>
					</div>
					<div class="tab-pane" id="module">
						<table id="module" class="list">
							<thead>
								<tr>
									<td class="left" width="1%"><?php echo $entry_module; ?></td>
									<td class="left"><?php echo $entry_layout; ?></td>
									<td class="left"><?php echo $entry_position; ?></td>
									<td class="left"><?php echo $entry_status; ?></td>
									<td class="right"><?php echo $entry_sort_order; ?></td>
									<td width="1%"></td>
								</tr>
							</thead>
							<tbody>
							<?php $module_row = 0; ?>
							<?php foreach ($questions_and_answers_module as $idx => $module) { ?>
								<tr id="module-row<?php echo $module_row; ?>">
									<td class="left nowrap"><?php if ($idx) { ?><?php echo $text_general_questions; ?><?php } else { ?><?php echo $text_product_questions; ?><?php } ?></td>
									<td class="left">
										<?php if (!$idx) { ?>
										<select name="questions_and_answers_module[<?php echo $module_row; ?>][layout_id]" class="auto-width">
											<option value="<?php echo $module['layout_id']; ?>" selected><?php echo $layouts[$module['layout_id']]['name']; ?></option>
										</select>
										<?php } else { ?>
										<select name="questions_and_answers_module[<?php echo $module_row; ?>][layout_id]" class="auto-width">
											<?php foreach ($layouts as $layout) { ?>
											<option value="<?php echo $layout['layout_id']; ?>"<?php echo ($layout['layout_id'] == $module['layout_id']) ? ' selected' : ''; ?>><?php echo $layout['name']; ?></option>
											<?php } ?>
										</select>
										<?php } ?>
									</td>
									<td class="left">
										<select name="questions_and_answers_module[<?php echo $module_row; ?>][position]" class="auto-width">
											<?php if (!$idx) { ?><option value="content_tab"<?php echo ($module['position'] == 'content_tab') ? ' selected' : '' ; ?>><?php echo $text_content_tab; ?></option><?php } ?>
											<option value="content_top"<?php echo ($module['position'] == 'content_top') ? ' selected' : '' ; ?>><?php echo $text_content_top; ?></option>
											<option value="content_bottom"<?php echo ($module['position'] == 'content_bottom') ? ' selected' : '' ; ?>><?php echo $text_content_bottom; ?></option>
											<?php if ($idx) { ?><option value="column_left"<?php echo ($module['position'] == 'column_left') ? ' selected' : '' ; ?>><?php echo $text_column_left; ?></option><?php } ?>
											<?php if ($idx) { ?><option value="column_right"<?php echo ($module['position'] == 'column_right') ? ' selected' : '' ; ?>><?php echo $text_column_right; ?></option><?php } ?>
										</select>
									</td>
									<td class="left">
										<select name="questions_and_answers_module[<?php echo $module_row; ?>][status]" class="auto-width">
											<option value="1"<?php echo ((int)$module['status']) ? ' selected' : '' ; ?>><?php echo $text_enabled; ?></option>
											<option value="0"<?php echo (!(int)$module['status']) ? ' selected' : '' ; ?>><?php echo $text_disabled; ?></option>
										</select>
										<input type="hidden" name="questions_and_answers_module[<?php echo $module_row; ?>][type]" value="<?php echo (!$idx) ? 'product' : 'general'; ?>" />
										<input type="hidden" name="questions_and_answers_module[<?php echo $module_row; ?>][index]" value="<?php echo $idx; ?>" />
									</td>
									<td class="right"><input type="text" name="questions_and_answers_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="input-mini align-right" /></td>
									<td class="left"><?php if ($idx) { ?><button type="button" class="btn btn-small btn-warning remove-module"><i class="icon-minus icon-small"></i><?php echo $button_remove; ?></button><?php } ?></td>
								</tr>
							<?php $module_row++; ?>
							<?php } ?>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5"></td>
									<td class="left"><button type="button" class="btn btn-small btn-primary nowrap" id="addModule"><i class="icon-plus icon-small"></i><?php echo $button_add_module; ?></button></td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="tab-pane" id="about">
						<div class="row-fluid">
							<div class="pull-left">
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_name; ?></label>
									<div class="controls"><span class="no-input"><?php echo $ext_name; ?></span></div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_version; ?></label>
									<div class="controls"><span class="no-input"><strong><?php echo $qap_installed_version; ?></strong></span></div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_compat; ?></label>
									<div class="controls"><span class="no-input"><?php echo $ext_compatibility; ?></span></div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_url; ?></label>
									<div class="controls"><span class="no-input"><a href="<?php echo $ext_url; ?>" target="_blank"><?php echo htmlspecialchars($ext_url); ?></a></span></div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_support; ?></label>
									<div class="controls"><span class="no-input">
										<a href="mailto:<?php echo $ext_support; ?>?subject='<?php echo $ext_subject; ?>'"><?php echo $ext_support; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
										<a href="<?php echo $ext_support_forum; ?>"><?php echo $text_forum; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
										<a href="view/static/bull5i_qap_pro_extension_help.htm" id="help_notice" data-modal="#help_text"><?php echo $text_asking_help; ?></a>
									</span></div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_ext_legal; ?></label>
									<div class="controls"><span class="no-input">&copy; 2013 Romi Agar. <a href="view/static/bull5i_qap_pro_extension_terms.htm" id="legal_notice" data-modal="#legal_text"><?php echo $text_terms; ?></a></span></div>
								</div>
							</div>
							<div class="pull-right">
								<img src="view/image/qap-pro/extension_logo.png" />
							</div>
							<div class="span6 pull-left">
								<div class="alert alert-block alert-info">
									<p><?php echo $text_other_extensions; ?></p>
									<p><a href="<?php echo $other_extensions_url; ?>" target="_blank" class="btn btn-primary"><?php echo $button_other_extensions; ?></a></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
<script type="text/javascript"><!--
window.onload = function() {
	(function( bull5i, $, undefined ) {
		bull5i.texts = $.extend({}, bull5i.texts, {
			general_questions: '<?php echo addslashes($text_general_questions); ?>',
			content_top: '<?php echo addslashes($text_content_top); ?>',
			content_bottom: '<?php echo addslashes($text_content_bottom); ?>',
			column_left: '<?php echo addslashes($text_column_left); ?>',
			column_right: '<?php echo addslashes($text_column_right); ?>',
			enabled: '<?php echo addslashes($text_enabled); ?>',
			disabled: '<?php echo addslashes($text_disabled); ?>',
			button_remove: '<?php echo addslashes($button_remove); ?>',

			yes: '<?php echo addslashes($text_yes); ?>',
			no: '<?php echo addslashes($text_no); ?>',
			remove: '<?php echo addslashes($text_remove); ?>',
			autocomplete: '<?php echo addslashes($text_autocomplete); ?>',
			regular_tab: '<?php echo addslashes($text_regular_tab); ?>',
			reserved_tab: '<?php echo addslashes($text_reserved_tab); ?>',
			delete_tab: '<?php echo addslashes($text_delete_tab); ?>',
			all_products: '<?php echo addslashes($text_all_products); ?>',
			all_empty_products: '<?php echo addslashes($text_all_empty_products); ?>',
			all_category_products: '<?php echo addslashes($text_all_category_products); ?>',
			selected_products: '<?php echo addslashes($text_selected_products); ?>',
			help_tab_type: '<?php echo addslashes($help_tab_type); ?>',
			help_tab_key: '<?php echo addslashes($help_tab_key); ?>',
			help_overwrite: '<?php echo addslashes($help_overwrite); ?>',
			help_require_login: '<?php echo addslashes($help_require_login); ?>',
			error_ajax_request: '<?php echo addslashes($error_ajax_request); ?>'
		});

		var module_row = <?php echo $module_row; ?>;

		bull5i.add_module = function() {
			$('#module tbody').append(
				$("<tr/>", {"id":"module-row" + module_row}).append(
					$("<td/>", {"class":"left nowrap"}).html(bull5i.texts.general_questions),
					$("<td/>", {"class":"left"}).append(
						$("<select/>", {"name":"questions_and_answers_module[" + module_row + "][layout_id]", "class":"auto-width"}).append(
							<?php $i = 0; ?>
							<?php foreach ($layouts as $layout) { ?>
								$("<option/>", {"value":<?php echo $layout['layout_id']; ?>}).html('<?php echo addslashes($layout['name']); ?>')<?php echo (++$i < count($layouts)) ? ',': ''; ?>
							<?php } ?>
						)
					),
					$("<td/>", {"class":"left"}).append(
						$("<select/>", {"name":"questions_and_answers_module[" + module_row + "][position]", "class":"auto-width"}).append(
							$("<option/>", {"value":"content_top"}).html(bull5i.texts.content_top),
							$("<option/>", {"value":"content_bottom"}).html(bull5i.texts.content_bottom),
							$("<option/>", {"value":"column_left"}).html(bull5i.texts.column_left),
							$("<option/>", {"value":"column_right"}).html(bull5i.texts.column_right)
						)
					),
					$("<td/>", {"class":"left"}).append(
						$("<select/>", {"name":"questions_and_answers_module[" + module_row + "][status]", "class":"auto-width"}).append(
							$("<option/>", {"value":"1", "selected":true}).html(bull5i.texts.enabled),
							$("<option/>", {"value":"0"}).html(bull5i.texts.disabled)
						),
						$("<input/>", {"type":"hidden", "name":"questions_and_answers_module[" + module_row + "][type]", "value":"general"}),
						$("<input/>", {"type":"hidden", "name":"questions_and_answers_module[" + module_row + "][index]", "value":module_row})
					),
					$("<td/>", {"class":"right"}).append(
						$("<input/>", {"type":"text", "name":"questions_and_answers_module[" + module_row + "][sort_order]", "value":0, "class":"input-mini align-right"})
					),
					$("<td/>", {"class":"left"}).append(
						$("<button/>", {"type":"button", "class":"btn btn-small btn-warning remove-module"}).html(bull5i.texts.button_remove).prepend(
							$("<i/>", {"class":"icon-minus icon-small"})
						)
					)
				)
			);

			module_row++;
		}

		$("body").on('click', '#apply', function(e) {
			e.preventDefault();
			$.ajax({
				type: 'POST',
				url: $("#form").attr("action"),
				dataType: 'json',
				data: $("#form").serialize(),
				beforeSend: function() {
					$("#overlay").stop().fadeTo(300, 0.8)
				},
				success: function(data) {
					if (data && data.success) {
						$("span.help-block.error").remove();
						$(".error").removeClass("error");
						bull5i.show_message(data.success, "success", "qap-alert");
					} else if (data && data.error) {
						$("span.help-block.error").remove();
						$(".error").removeClass("error");

						if (data.errors) {
							$.each(data.errors, function(k, v) {
								if (k == "warning") {
									bull5i.show_message(data.errors.warning, "error", "qap-alert", 0);
								} else {
									if (k.indexOf("tabs") == 0) {
										var re = new RegExp(/tabs\[(\d+)\].*/)
											, m = re.exec(k);

										$("li>a[href='#tabs']").addClass("error");

										if (m != null) {
											$("#custom-tab-headers li a[data-tab-index='" + m[1] + "']").addClass("error")
										}
									}
									$el = $("[name='" + k + "']")
									$el.closest(".control-group").find('label').addClass("error")
									$el.closest(".controls").addClass("error").append($("<span/>", {"class":"help-block error"}).html(v))
								}
							});
						}
					}
				},
				error: function(xhr, status, error) {
					bull5i.show_message(bull5i.texts.ajax_error_msg, "error", "qap-alert", 0);
				},
				complete: function() {
					$("#overlay").stop().fadeOut(300)
				}
			});
		});

		$("input[name='qap_allow_customer_answers'], select[name='qap_enable_general_questions']").on('change', function (){
			if(parseInt(this.value)) {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideDown('slow');
				});
			} else {
				$.each($(this).data('linked').split(','), function(i, v){
					$(v).slideUp('slow', function() {
						$(this).css('display', 'none');
					});
				});
			}
		});
		$("input[name='qap_new_question_notification'], input[name='qap_new_answer_notification']").on('change', function (){
			if(parseInt(this.value)) {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideDown('slow');
				});
			} else if (!parseInt($("input[name='qap_new_question_notification']:checked").val()) && !parseInt($("input[name='qap_new_answer_notification']:checked").val())) {
				$.each($(this).data('linked').split(','), function(i, v){
					$(v).slideUp('slow', function() {
						$(this).css('display', 'none');
					});
				});
			}
		});
		$("input[name='qap_login_to_view_general_questions']").on('change', function (){
			if(parseInt(this.value)) {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideUp('slow', function() {
						$(this).css('display', 'none');
					});
				});
			} else if (!parseInt($("input[name='qap_enable_general_questions']:checked").val())) {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideDown('slow');
				});
			}
		});
		$("input[name='qap_login_to_view_product_questions']").on('change', function (){
			if(parseInt(this.value)) {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideUp('slow', function() {
						$(this).css('display', 'none');
					});
				});
			} else {
				$.each($(this).data('linked').split(','), function(i, v) {
					$(v).slideDown('slow');
				});
			}
		});
	}( window.bull5i = window.bull5i || {}, jQuery ));
}
//--></script>
<?php echo $footer; ?>