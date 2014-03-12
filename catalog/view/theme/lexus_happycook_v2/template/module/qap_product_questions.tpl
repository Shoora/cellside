<?php if (!$pr) { ?>
<div class="modal fade qap-modal" id="qap-question-modal" role="dialog" tabindex="-1" aria-hidden="true" aria-labelledby="qap-question-modal-title" data-keyboad="true" data-remote="<?php echo $question_form_link; ?>">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="qap-question-modal-title"><?php echo $heading_title_ask_a_question; ?></h4>
			</div>
			<div class="modal-body">
				<div class="qap-container qap-empty-container">
					<div class="qap-overlay in">
						<div class="qap-tbl">
							<div class="qap-tbl-cell"><i class="icon-refresh icon-spin icon-5x text-muted"></i></div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_cancel; ?></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php if ($show_answer_button) { ?>
<div class="modal fade qap-modal" id="qap-answer-modal" role="dialog" tabindex="-1" aria-hidden="true" aria-labelledby="qap-answer-modal-title" data-keyboad="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="qap-answer-modal-title"><?php echo $heading_title_add_an_answer; ?></h4>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_cancel; ?></button>
				<button type="button" class="btn btn-primary"><?php echo $button_submit; ?></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<?php } ?>
<?php } ?>
<?php if ($lazy_load && !$pr) { ?>
<div class="qap-content qap-ov">
	<div class="qap-overlay in">
		<div class="qap-tbl qap-max-h">
			<div class="qap-tbl-cell"><i class="icon-refresh icon-spin icon-5x text-muted"></i></div>
		</div>
	</div>
	<div class="qap-empty-container" id="qap-lazy-load" data-update-link="<?php echo $update_link; ?>"></div>
</div>
<?php } else if (!empty($questions) || $search) { ?>
<div class="qap-content qap-ov">
	<div id="qap">
		<div class="qap-notice">
			<?php if ($success) { ?>
			<div class="alert alert-success"><?php echo $success; ?></div>
			<?php } else if ($error_warning) { ?>
			<div class="alert alert-error"><?php echo $error_warning; ?></div>
			<?php } ?>
		</div>
		<?php if (!$login_to_view_questions) { ?>
		<nav class="navbar navbar-default qap-ov" role="navigation">
			<div class="navbar-header">
				<form action="<?php echo $search_link; ?>" method="post" enctype="multipart/form-data" id="qap-search-form" class="navbar-form" role="search">
					<input type="hidden" name="redirect" value="1">
					<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<div class="input-group">
									<input type="text" name="qsearch" id="qap-search" class="form-control qap-search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search_questions; ?>" title="<?php echo $text_search_questions; ?>">
									<span class="input-group-btn">
										<button type="submit" class="btn btn-default" id="qap-search-btn" rel="tooltip" data-original-title="<?php echo $text_search; ?>" data-container="body"><i class="icon-search"></i></button>
										<button type="button" class="btn btn-default" id="qap-clear-btn" rel="tooltip" data-original-title="<?php echo $text_clear_search; ?>" data-container="body"><i class="icon-remove"></i></button>
									</span>
								</div>
							</div>
						</div>
						<div class="col-sm-6 text-right">
							<div class="form-group">
								<select name="qsort" class="form-control" id="qap-sort-btn" rel="tooltip" data-original-title="<?php echo $text_sort; ?>" data-container="body" title="<?php echo $text_sort; ?>">
								<?php foreach ($sorts as $s => $t) { ?>
									<option value="<?php echo $s; ?>"<?php echo ($s == $sort) ? ' selected' : ''; ?>><?php echo $t; ?></option>
								<?php } ?>
								</select>
							</div>
						</div>
					</div>
				</form>
			</div>
		</nav>
		<?php } ?>
		<div class="qap-container">
			<div class="qap-overlay">
				<div class="qap-tbl qap-max-h">
					<div class="qap-tbl-cell"><i class="icon-refresh icon-spin icon-5x text-muted"></i></div>
				</div>
			</div>
			<div class="qap-qa qap-ll"><?php echo $questions_answers; ?></div>
		</div>
	</div>
</div>
<?php } else { ?>
<div class="qap-content">
	<div class="qap-questions" data-update-link="<?php echo $update_link; ?>">
		<div class="panel-body">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-8">
					<p class="lead qap-no-questions"><?php echo $text_no_questions; ?></p>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-4 text-right">
					<?php if ($show_ask_button) { ?>
					<input type="button" class="button qap-ask-product" value="<?php echo addslashes($button_ask); ?>" />
					<?php } else { ?>
					<a href="<?php echo $login_link; ?>" class="button"><?php echo $button_login_ask; ?></a>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>
</div>
<?php } ?>
<?php if (!$pr) { ?>
<script type="text/javascript"><!--
(function( bull5i, $, undefined ) {
	bull5i.texts = $.extend({}, bull5i.texts, {text_expand_all: '<?php echo addslashes($text_expand_all); ?>', text_collapse_all: '<?php echo addslashes($text_collapse_all); ?>', ajax_error_msg: '<?php echo addslashes($error_ajax_request); ?>'});
	bull5i.qap_update_history = true;
	bull5i.qap_lazy_loading = <?php echo ($lazy_load) ? 'true' : 'false'; ?>;
	$("#qap-question-modal,#qap-answer-modal").appendTo($("body"));
	if($(window).height()<650){$('body').addClass('no-overflow-scroll').on('show.bs.modal shown.bs.modal',function(e){var top=$(window).scrollTop();$(e.target).css('padding-top',top);$(window).scrollTop(top)});}
}( window.bull5i = window.bull5i || {}, jQuery ));
//--></script>
<?php } ?>