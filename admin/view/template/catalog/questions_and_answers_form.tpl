<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning qap-alert"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success qap-alert"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/qap-pro/qa.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="pull-right list-view-buttons">
        <div class="btn-group">
          <?php if ($question_id) { ?><button class="btn btn-small" type="button" id="apply"><?php echo $button_apply; ?></button><?php } ?>
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
          <li class="active"><a href="#question" data-toggle="tab" id="question-tab-header"><?php echo $tab_question; ?></a></li>
          <li><a href="#answers" data-toggle="tab" id="answers-tab-header"><?php echo $tab_answers; ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="question">
            <fieldset>
              <div class="row-fluid">
                <div class="span6">
                  <div class="control-group">
                    <label class="control-label" for="status"><?php echo $entry_status; ?></label>
                    <div class="controls">
                      <select name="status" id="status" class="input-medium">
                        <option value="1"<?php echo ((int)$status) ? ' selected' : ''; ?>><?php echo $text_enabled; ?></option>
                        <option value="0"<?php echo (!(int)$status) ? ' selected' : ''; ?>><?php echo $text_disabled; ?></option>
                      </select>
                      <input type="hidden" name="customer_language_id" value="<?php echo $customer_language_id; ?>">
                      <input type="hidden" name="product_id" value="<?php echo $product_id; ?>">
                      <input type="hidden" name="store_id" value="<?php echo $store_id; ?>">
                      <input type="hidden" name="activate_next_notification" value="<?php echo $activate_next_notification; ?>">
                      <?php if (!(int)$this->config->get('qap_allow_customer_answers')) { ?><input type="hidden" name="allow_answers" value="0"><?php } ?>
                    </div>
                  </div>
                </div>
                <div class="span6">
                  <?php if ($question_id) { ?>
                  <div class="control-group">
                    <label class="control-label"><?php echo $entry_date_added; ?></label>
                    <div class="controls">
                      <span class="no-input"><?php echo $date_added_formatted; ?></span>
                      <input type="hidden" name="date_added" value="<?php echo $date_added; ?>">
                    </div>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <div class="row-fluid">
                <div class="span6">
                  <div class="control-group">
                    <label class="control-label" for="author"><?php echo $entry_author; ?></label>
                    <div class="controls">
                      <input type="text" name="author" id="author" value="<?php echo $author; ?>" class="input-large" placeholder="<?php echo $text_autocomplete; ?>" autocomplete="off">
                      <input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>">
                    </div>
                  </div>
                </div>
                <div class="span6">
                  <?php if ($question_id) { ?>
                  <div class="control-group">
                    <label class="control-label"><?php echo $entry_date_modified; ?></label>
                    <div class="controls">
                      <span class="no-input"><?php echo $date_modified_formatted; ?></span>
                      <input type="hidden" name="date_modified" value="<?php echo $date_modified; ?>">
                    </div>
                  </div>
                  <?php } ?>
                </div>
              </div>
              <div class="control-group<?php echo ($error_email) ? ' error': ''; ?>">
                <label class="control-label" for="email"><?php echo $entry_email; ?></label>
                <div class="controls">
                  <input type="text" name="email" id="email" value="<?php echo $email; ?>" class="input-large">
                  <?php if ($error_email) { ?>
                  <span class="help-block error"><?php echo $error_email; ?></span>
                  <?php } ?>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_notify; ?></label>
                <div class="controls">
                  <label for="notify_author1" class="radio inline"><input type="radio" name="notify_author" value="1" id="notify_author1"<?php echo ((int)$notify_author) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
                  <label for="notify_author0" class="radio inline"><input type="radio" name="notify_author" value="0" id="notify_author0"<?php echo (!(int)$notify_author) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
                  <span class="help-inline info"><?php echo $help_notify_author; ?></span>
                </div>
              </div>
              <?php if ((int)$this->config->get('qap_allow_customer_answers')) { ?>
              <div class="control-group">
                <label class="control-label"><?php echo $entry_allow_answers; ?></label>
                <div class="controls">
                  <label for="allow_answers1" class="radio inline"><input type="radio" name="allow_answers" value="1" id="allow_answers1"<?php echo ((int)$allow_answers) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
                  <label for="allow_answers0" class="radio inline"><input type="radio" name="allow_answers" value="0" id="allow_answers0"<?php echo (!(int)$allow_answers) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
                </div>
              </div>
              <?php } ?>
              <hr>
              <div class="controls">
                <ul class="nav nav-pills">
                  <?php foreach ($languages as $language) { ?>
                  <li<?php echo ($lang == $language['code']) ? ' class="active"' : ''; ?>><a href="#lang-<?php echo $language['language_id']; ?>" data-toggle="pill"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                  <?php } ?>
                </ul>
              </div>
              <div class="tab-content">
                <?php foreach ($languages as $language) { ?>
                <div class="tab-pane<?php echo ($lang == $language['code']) ? ' active' : ''; ?>" id="lang-<?php echo $language['language_id']; ?>">
                  <div class="control-group<?php echo (isset($error_question[$language['language_id']]['question'])) ? ' error': ''; ?>">
                    <label class="control-label" for="input<?php echo $language['language_id']; ?>Question"><?php echo $entry_question; ?></label>
                    <div class="controls">
                      <input type="text" name="question_text[<?php echo $language['language_id']; ?>][question]" id="input<?php echo $language['language_id']; ?>Question" value="<?php echo isset($question_text[$language['language_id']]['question']) ? $question_text[$language['language_id']]['question'] : ''; ?>" class="input-xxlarge">
                      <?php if (isset($error_question[$language['language_id']]['question'])) { ?>
                      <span class="help-block error"><?php echo $error_question[$language['language_id']]['question']; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="control-group<?php echo (isset($error_question[$language['language_id']]['details'])) ? ' error': ''; ?>">
                    <label class="control-label" for="textarea<?php echo $language['language_id']; ?>Details"><?php echo $entry_details; ?></label>
                    <div class="controls">
                      <textarea name="question_text[<?php echo $language['language_id']; ?>][details]" id="textarea<?php echo $language['language_id']; ?>Details" class="input-xxlarge" rows="5"><?php echo isset($question_text[$language['language_id']]['details']) ? $question_text[$language['language_id']]['details'] : ''; ?></textarea>
                      <?php if (isset($error_question[$language['language_id']]['details'])) { ?>
                      <span class="help-block error"><?php echo $error_question[$language['language_id']]['details']; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                </div>
                <?php } ?>
              </div>
              <hr>
              <div class="control-group<?php echo ($error_related_products) ? ' error': ''; ?>">
                <label class="control-label" for="products"><?php echo $entry_products; ?></label>
                <div class="controls multi-input">
                  <input type="text" id="products" class="input-large" placeholder="<?php echo $text_autocomplete; ?>" autocomplete="off">
                </div>
                <div class="controls multi-input">
                  <div class="scroll_box input-xlarge" id="related_products">
                    <?php foreach ($related_products as $product) { ?>
                    <div id="related-product<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?>
                      <button type="button" class="btn btn-link btn-mini pull-right remove" rel="tooltip" data-original-title="<?php echo $text_remove; ?>"><i class="icon-ban-circle icon-red"></i></button>
                      <input type="hidden" name="related_products[]" value="<?php echo $product['product_id']; ?>" />
                    </div>
                    <?php } ?>
                  </div>
                  <?php if (!empty($error_related_products)) { ?>
                  <span class="help-block error"><?php echo $error_related_products; ?></span>
                  <?php } ?>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label" for="stores"><?php echo $entry_stores; ?></label>
                <div class="controls">
                  <select name="stores[]" id="stores" class="input-xlarge" multiple="multiple" rows="4">
                    <?php foreach ($stores as $id => $store) { ?>
                    <option value="<?php echo $id; ?>"<?php echo (in_array($id, $question_stores)) ? ' selected' : ''; ?>><?php echo $store['name']; ?></option>
                    <?php } ?>
                  </select>
                  <span class="help-inline info"><?php echo $help_stores; ?></span>
                  <?php if (!empty($error_stores)) { ?>
                  <span class="help-block error"><?php echo $error_stores; ?></span>
                  <?php } ?>
                </div>
              </div>
            </fieldset>
          </div>
          <div class="tab-pane" id="answers">
            <div class="row-fluid">
              <div class="control-group">
                <div class="controls">
                  <button class="btn btn-small btn-success" id="add-answer" type="button" rel="tooltip" data-container="body" data-original-title="<?php echo $text_add_answer; ?>"><i class="icon-plus icon-small"></i><?php echo $button_answer; ?></button>
                </div>
              </div>
            </div>
            <div class="accordion" id="answer-accordion">
              <?php $count = 0; ?>
              <?php foreach ($answers as $idx => $answer) { ?>
              <div class="accordion-group">
                <div class="accordion-heading">
                  <a class="accordion-toggle<?php echo (!$answer['status']) ? ' alert-error' : ''; ?>" data-toggle="collapse" data-parent="#answer-accordion" href="#answer<?php echo $idx; ?>">
                    <span class="answer-author"><?php echo $answer['author']; ?></span><span class="answer-excerpt"><?php if ($answer['excerpt']) { ?>: <?php echo $answer['excerpt']; ?><?php } ?></span>
                    <span class="meta pull-right"><span class="likes-dislikes"><i class="icon-thumbs-up icon-green"></i><span class="likes-count"><?php echo $answer['likes']; ?></span><i class="icon-thumbs-down icon-red"></i><span class="dislikes-count"><?php echo $answer['dislikes']; ?></span></span></span>
                    <span class="meta pull-right answer-date"><?php echo $answer['date_added_formatted']; ?></span>
                  </a>
                </div>
                <div id="answer<?php echo $idx; ?>" class="accordion-body collapse<?php echo ($idx == 0) ? ' in' : ''; ?>">
                  <div class="accordion-inner">
                    <fieldset>
                      <div class="row-fluid">
                        <div class="span6">
                          <div class="control-group">
                            <label class="control-label" for="answer<?php echo $idx; ?>status"><?php echo $entry_status; ?></label>
                            <div class="controls">
                              <select name="answers[<?php echo $idx; ?>][status]" id="answer<?php echo $idx; ?>status" class="input-medium answer-status">
                                <option value="1"<?php echo ((int)$answer['status']) ? ' selected' : ''; ?>><?php echo $text_enabled; ?></option>
                                <option value="0"<?php echo (!(int)$answer['status']) ? ' selected' : ''; ?>><?php echo $text_disabled; ?></option>
                              </select>
                              <?php if (isset($answer['answer_id'])) { ?><input type="hidden" name="answers[<?php echo $idx; ?>][answer_id]" value="<?php echo $answer['answer_id']; ?>"><?php } ?>
                              <input type="hidden" name="answers[<?php echo $idx; ?>][excerpt]" value="<?php echo $answer['excerpt']; ?>">
                              <input type="hidden" name="answers[<?php echo $idx; ?>][likes]" value="<?php echo $answer['likes']; ?>">
                              <input type="hidden" name="answers[<?php echo $idx; ?>][dislikes]" value="<?php echo $answer['dislikes']; ?>">
                            </div>
                          </div>
                        </div>
                        <div class="span6">
                          <div class="control-group">
                            <label class="control-label"><?php echo $entry_date_added; ?></label>
                            <div class="controls">
                              <span class="no-input"><?php echo $answer['date_added_formatted']; ?></span>
                              <input type="hidden" name="answers[<?php echo $idx; ?>][date_added]" value="<?php echo $answer['date_added']; ?>">
                              <button class="btn btn-small btn-danger delete-answer pull-right" type="button" rel="tooltip" data-container="body" data-original-title="<?php echo $text_delete_answer; ?>"><i class="icon-trash icon-small"></i><?php echo $button_delete; ?></button>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="row-fluid">
                        <div class="span6">
                          <div class="control-group">
                            <label class="control-label" for="answer<?php echo $idx; ?>author"><?php echo $entry_author; ?></label>
                            <div class="controls">
                              <input type="text" name="answers[<?php echo $idx; ?>][author]" id="answer<?php echo $idx; ?>author" value="<?php echo $answer['author']; ?>" class="input-large answer_author" data-idx="<?php echo $idx; ?>" placeholder="<?php echo $text_autocomplete; ?>" autocomplete="off">
                              <input type="hidden" name="answers[<?php echo $idx; ?>][customer_id]" value="<?php echo $answer['customer_id']; ?>">
                            </div>
                          </div>
                        </div>
                        <div class="span6">
                          <div class="control-group">
                            <label class="control-label"><?php echo $entry_date_modified; ?></label>
                            <div class="controls">
                              <span class="no-input"><?php echo $answer['date_modified_formatted']; ?></span>
                              <input type="hidden" name="answers[<?php echo $idx; ?>][date_modified]" value="<?php echo $answer['date_modified']; ?>">
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="control-group<?php echo (isset($error_answer[$idx]['email'])) ? ' error': ''; ?>">
                        <label class="control-label" for="answer<?php echo $idx; ?>email"><?php echo $entry_email; ?></label>
                        <div class="controls">
                          <input type="text" name="answers[<?php echo $idx; ?>][email]" id="answer<?php echo $idx; ?>email" value="<?php echo $answer['email']; ?>" class="input-large answer_author_email" data-idx="<?php echo $idx; ?>">
                          <?php if (isset($error_answer[$idx]['email'])) { ?>
                          <span class="help-block error"><?php echo $error_answer[$idx]['email']; ?></span>
                          <?php } ?>
                        </div>
                      </div>
                      <div class="control-group">
                        <label class="control-label"><?php echo $entry_notify; ?></label>
                        <div class="controls">
                          <label for="answer<?php echo $idx; ?>notify1" class="radio inline"><input type="radio" name="answers[<?php echo $idx; ?>][notify]" value="1" id="answer<?php echo $idx; ?>notify1"<?php echo ((int)$answer['notify']) ? ' checked': ''; ?>/><?php echo $text_yes; ?></label>
                          <label for="answer<?php echo $idx; ?>notify0" class="radio inline"><input type="radio" name="answers[<?php echo $idx; ?>][notify]" value="0" id="answer<?php echo $idx; ?>notify0"<?php echo (!(int)$answer['notify']) ? ' checked': ''; ?>/><?php echo $text_no; ?></label>
                          <span class="help-inline info"><?php echo $help_notify; ?></span>
                        </div>
                      </div>
                      <hr>
                      <div class="controls">
                        <ul class="nav nav-pills">
                          <?php foreach ($languages as $language) { ?>
                          <li<?php echo ($lang == $language['code']) ? ' class="active"' : ''; ?>><a href="#answer-<?php echo $idx; ?>-lang-<?php echo $language['language_id']; ?>" data-toggle="pill"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                          <?php } ?>
                        </ul>
                      </div>
                      <div class="tab-content">
                        <?php foreach ($languages as $language) { ?>
                        <div class="tab-pane<?php echo ($lang == $language['code']) ? ' active' : ''; ?>" id="answer-<?php echo $idx; ?>-lang-<?php echo $language['language_id']; ?>">
                          <div class="control-group">
                            <label class="control-label" for="answer<?php echo $idx; ?>Lang<?php echo $language['language_id']; ?>"><?php echo $entry_answer; ?></label>
                            <div class="controls">
                              <textarea name="answers[<?php echo $idx; ?>][answer_text][<?php echo $language['language_id']; ?>]" id="answer<?php echo $idx; ?>Lang<?php echo $language['language_id']; ?>" class="input-xxlarge<?php echo ($lang == $language['code']) ? ' answer_text' : ''; ?>" rows="5"><?php echo isset($answer['answer_text'][$language['language_id']]) ? $answer['answer_text'][$language['language_id']] : ''; ?></textarea>
                            </div>
                          </div>
                        </div>
                        <?php } ?>
                      </div>
                    </fieldset>
                  </div>
                </div>
              </div>
              <?php $count = $idx + 1; } ?>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
(function( bull5i, $, undefined ) {
  var xhr = null
    , select_value = null
    , answer_author_emails = {}
    , answer_count = <?php echo $count; ?>
    , ta_opts = {
    source: function(query, process) {
      if (xhr) xhr.abort();
      xhr = $.ajax({
        url: '<?php echo $autocomplete; ?>',
        type: 'post',
        data: {query: query, field: 'customer'},
        dataType: 'json',
        success: function(data, status, xhr) {
          if (data.items) {
            process(data.items)
          }
        },
        complete: function() {
          xhr = null;
        }
      });
    },
    onselect: function (data) {
      $el = $(this.$element)
      idx = $el.attr('data-idx');
      if (idx) {
        $("#form input[name='answers[" + idx + "][customer_id]']").val(data.customer_id);
        $("#form input[name='answers[" + idx + "][email]']").val(data.email);
      }
      answer_author_emails[idx] = data.email
    },
    updater: function(item) {
      return item.name
    },
    matcher: function(item) {
      return true;
    },
    property: 'ext_name',
    items:10
  };

  $("#author").typeahead({
    source: function(query, process) {
      if (xhr) xhr.abort();
      xhr = $.ajax({
        url: '<?php echo $autocomplete; ?>',
        type: 'post',
        data: {query: query, field: 'customer'},
        dataType: 'json',
        success: function(data, status, xhr) {
          if (data.items) {
            process(data.items)
          }
        },
        complete: function() {
          xhr = null;
        }
      });
    },
    onselect: function (data) {
      $("#form input[name=customer_id]").val(data.customer_id);
      $("#form input[name=email]").val(data.email);
      select_value = data.email;
    },
    updater: function(item) {
      return item.name
    },
    matcher: function(item) {
      return true;
    },
    property: 'ext_name',
    items:10
  })

  $(".answer_author").typeahead(ta_opts)

  $("#products").typeahead({
    source: function(query, process) {
      if (xhr) xhr.abort();
      xhr = $.ajax({
        url: '<?php echo $autocomplete; ?>',
        type: 'post',
        data: {query: query, field: 'product'},
        dataType: 'json',
        success: function(data, status, xhr) {
          if (data.items) {
            process(data.items)
          }
        },
        complete: function() {
          xhr = null;
        }
      });
    },
    onselect: function (data) {
      $('#related-product' + data.product_id).remove();
      $("#related_products").append(
        $("<div/>", {"id": 'related-product' + data.product_id}).html(data.name).append(
          $("<button/>", {"type":"button", "class":"btn btn-link btn-mini pull-right remove", "rel":"tooltip", "data-original-title":'<?php echo addslashes($text_remove); ?>'}).append(
            $("<i/>", {"class":"icon-ban-circle icon-red"})
          ),
          $("<input/>", {"type":"hidden", "name":"related_products[]", "value": data.product_id})
        )
      );
    },
    updater: function(item) {
      return item.name
    },
    matcher: function(item) {
      return true;
    },
    property: 'ext_name',
    items:10
  })

  $('#apply').on('click', function(e) {
    // Iterate through CKEDITOR values
    if (typeof CKEDITOR != "undefined") {
      for (inst in CKEDITOR.instances) {
        CKEDITOR.instances["" + inst].element.setValue(CKEDITOR.instances["" + inst].getData())
      }
    }
    $.ajax({
      type: 'POST',
      url: $("#form").attr("action"),
      dataType: 'json',
      data: $("#form").serialize(),
      beforeSend: function() {
        $("#overlay").stop().fadeTo(300, 0.8)
      },
      success: function(data) {
        $("span.help-block.error").remove();
        $("div.control-group.error").removeClass("error");
        $("#question-tab-header,#answers-tab-header").removeClass("error");
        if (data && data.success) {
          bull5i.show_message(data.success, "success", "qap-alert");
        } else if (data && data.error) {
          if (data.errors) {
            $.each(data.errors, function(k,v) {
              if (k == "warning") {
                bull5i.show_message(data.errors.warning, "error", "qap-alert", 0);
              } else {
                if (k == "answer") {
                  $("#answers-tab-header").addClass("error");
                  $.each(v, function(idx, v) {
                    $.each(v, function(key, e) {
                      $el = $("#form [name='answers[" + idx + "][" + key + "]']")
                      $el.closest(".control-group").addClass("error")
                      $el.parent().append($("<span/>", {"class":"help-block error"}).html(e))
                    });
                  })
                } else {
                  $("#question-tab-header").addClass("error");
                  $el = $("#" + k)
                  $el.closest(".control-group").addClass("error")
                  $el.parent().append($("<span/>", {"class":"help-block error"}).html(v))
                }
              }
            });
          }
        }
      },
      complete: function() {
        $("#overlay").stop().fadeOut(300)
      }
    });
  });

  $(function(){
    if (typeof CKEDITOR != "undefined") {
      <?php foreach ($languages as $language) { ?>
      CKEDITOR.replace('textarea<?php echo $language['language_id']; ?>Details', {
        enterMode: CKEDITOR.ENTER_BR,
        filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
      });
      <?php } ?>
      <?php foreach ($answers as $idx => $answer) { ?>
      <?php foreach ($languages as $language) { ?>
      CKEDITOR.replace('answer<?php echo $idx; ?>Lang<?php echo $language['language_id']; ?>', {
        enterMode: CKEDITOR.ENTER_BR,
        filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
        filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
      });
      <?php } ?>
      <?php } ?>
    }
    $("#email").change(function() {
      if (select_value && select_value != $(this).val()) {
        $("#form input[name=customer_id]").val("");
      }
    });
    $(document).on('change', '.answer_author_email', function() {
      idx = $(this).attr('data-idx');
      if (idx && answer_author_emails[idx] && answer_author_emails[idx] != $(this).val()) {
        $("#form input[name='answers[" + idx + "][customer_id]']").val("");
      }
    });
    $(document).on('change', '.answer_author', function() {
      $(this).closest('.accordion-group').find(".accordion-heading span.answer-author").html($(this).val() ? $(this).val() : "<em>[ <?php echo addslashes($text_anonymous); ?> ]</em>")
    });
    $(document).on("click", "#related_products button.remove", function() {
      $(this).parent().remove();
    });
    $(document).on("click", ".delete-answer", function() {
      $(this).tooltip('destroy').closest('.accordion-group').remove();
    });
    $(document).on("click", "#add-answer", function() {
      $("#answer-accordion").prepend(
        $("<div/>", {"class":"accordion-group"}).append(
          $("<div/>", {"class":"accordion-heading"}).append(
            $("<a/>", {"class":"accordion-toggle alert-error", "data-toggle":"collapse", "data-parent":"#answer-accordion", "href":"#answer" + answer_count}).append(
              $("<span/>", {"class":"answer-author"}).html("<em>[ <?php echo addslashes($text_anonymous); ?> ]</em>"),
              $("<span/>", {"class":"answer-excerpt"}).html(": <em>[ <?php echo addslashes($text_no_answer_text); ?> ]</em>"),
              $("<span/>", {"class":"meta pull-right"}).append(
                $("<span/>", {"class":"likes-dislikes"}).append(
                  $("<i/>", {"class":"icon-thumbs-up icon-green"}),
                  $("<span/>", {"class":"likes-count"}).html("0"),
                  $("<i/>", {"class":"icon-thumbs-down icon-red"}),
                  $("<span/>", {"class":"dislikes-count"}).html("0")
                )
              ),
              $("<span/>", {"class":"meta pull-right answer-date"}).html("")
            )
          ),
          $("<div/>", {"id":"answer" + answer_count, "class":"accordion-body collapse in"}).append(
            $("<div/>", {"class":"accordion-inner"}).append(
              $("<fieldset/>").append(
                $("<div/>", {"class":"row-fluid"}).append(
                  $("<div/>", {"class":"span6"}).append(
                    $("<div/>", {"class":"control-group"}).append(
                      $("<label/>", {"class":"control-label", "for":"answer" + answer_count + "status"}).html("<?php echo addslashes($entry_status); ?>"),
                      $("<div/>", {"class":"controls"}).append(
                        $("<select/>", {"name":"answers[" + answer_count + "][status]", "id":"answer" + answer_count + "status", "class":"input-medium answer-status"}).append(
                          $("<option/>", {"value":1}).html("<?php echo addslashes($text_enabled); ?>"),
                          $("<option/>", {"value":0, "selected":true}).html("<?php echo addslashes($text_disabled); ?>")
                        ),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][excerpt]", "value":"<em>[ <?php echo addslashes($text_no_answer_text); ?> ]</em>"}),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][likes]", "value":"0"}),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][dislikes]", "value":"0"})
                      )
                    )
                  ),
                  $("<div/>", {"class":"span6"}).append(
                    $("<div/>", {"class":"control-group"}).append(
                      $("<label/>", {"class":"control-label"}).html("<?php echo addslashes($entry_date_added); ?>"),
                      $("<div/>", {"class":"controls"}).append(
                        $("<span/>", {"class":"no-input"}).html(""),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][date_added]", "value":"0000-00-00 00:00:00"}),
                        $("<button/>", {"class":"btn btn-small btn-danger delete-answer pull-right", "type":"button", "rel":"tooltip", "data-container":"body", "data-original-title":"<?php echo addslashes($text_delete_answer); ?>"}).html("<?php echo addslashes($button_delete); ?>").prepend(
                          $("<i/>", {"class":"icon-trash icon-small"})
                        )
                      )
                    )
                  )
                ),
                $("<div/>", {"class":"row-fluid"}).append(
                  $("<div/>", {"class":"span6"}).append(
                    $("<div/>", {"class":"control-group"}).append(
                      $("<label/>", {"class":"control-label", "for":"answer" + answer_count + "author"}).html("<?php echo addslashes($entry_author); ?>"),
                      $("<div/>", {"class":"controls"}).append(
                        $("<input/>", {"type":"text", "name":"answers[" + answer_count + "][author]", "id":"answer" + answer_count + "author", "value":"", "class":"input-large answer_author", "data-idx":answer_count, "placeholder":"<?php echo addslashes($text_autocomplete); ?>", "autocomplete":"off"}),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][customer_id]", "value":""})
                      )
                    )
                  ),
                  $("<div/>", {"class":"span6"}).append(
                    $("<div/>", {"class":"control-group"}).append(
                      $("<label/>", {"class":"control-label"}).html("<?php echo addslashes($entry_date_modified); ?>"),
                      $("<div/>", {"class":"controls"}).append(
                        $("<span/>", {"class":"no-input"}).html(""),
                        $("<input/>", {"type":"hidden", "name":"answers[" + answer_count + "][date_modified]", "value":"0000-00-00 00:00:00"})
                      )
                    )
                  )
                ),
                $("<div/>", {"class":"control-group"}).append(
                  $("<label/>", {"class":"control-label", "for":"answer" + answer_count + "email"}).html("<?php echo addslashes($entry_email); ?>"),
                  $("<div/>", {"class":"controls"}).append(
                    $("<input/>", {"type":"text", "name":"answers[" + answer_count + "][email]", "id":"answer" + answer_count + "email", "value":"", "class":"input-large answer_author_email", "data-idx":answer_count})
                  )
                ),
                $("<div/>", {"class":"control-group"}).append(
                  $("<label/>", {"class":"control-label"}).html("<?php echo addslashes($entry_notify); ?>"),
                  $("<div/>", {"class":"controls"}).append(
                    $("<label/>", {"for":"answer" + answer_count + "notify1", "class":"radio inline"}).html("<?php echo addslashes($text_yes); ?>").prepend(
                      $("<input/>", {"type":"radio", "name":"answers[" + answer_count + "][notify]", "value":1, "id":"answer" + answer_count + "notify1"<?php echo ((int)$notify_author) ? ', "checked":true': ''; ?>})
                    ),
                    $("<label/>", {"for":"answer" + answer_count + "notify0", "class":"radio inline"}).html("<?php echo addslashes($text_no); ?>").prepend(
                      $("<input/>", {"type":"radio", "name":"answers[" + answer_count + "][notify]", "value":0, "id":"answer" + answer_count + "notify0"<?php echo (!(int)$notify_author) ? ', "checked":true': ''; ?>})
                    ),
                    $("<span/>", {"class":"help-inline info"}).html("<?php echo addslashes($help_notify); ?>")
                  )
                ),
                $("<hr/>"),
                $("<div/>", {"class":"controls"}).append(
                  $("<ul/>", {"class":"nav nav-pills"}).append(
                    <?php $i = 0; ?>
                    <?php foreach ($languages as $language) { ?>
                    $("<li/>"<?php echo ($lang == $language['code']) ? ', {"class":"active"}' : ''; ?>).append(
                      $("<a/>", {"href":"#answer-" + answer_count + "-lang-<?php echo $language['language_id']; ?>", "data-toggle":"pill"}).html(" <?php echo addslashes($language['name']); ?>").prepend(
                        $("<img/>", {"src":"view/image/flags/<?php echo $language['image']; ?>", "title":"<?php echo addslashes($language['name']); ?>"})
                      )
                    )
                    <?php echo (++$i < count($languages)) ? "," : ""; } ?>
                  )
                ),
                $("<div/>", {"class":"tab-content"}).append(
                  <?php $i = 0; ?>
                  <?php foreach ($languages as $language) { ?>
                  $("<div/>", {"class":"tab-pane<?php echo ($lang == $language['code']) ? ' active' : ''; ?>", "id":"answer-" + answer_count + "-lang-<?php echo $language['language_id']; ?>"}).append(
                    $("<div/>", {"class":"control-group"}).append(
                      $("<label/>", {"class":"control-label", "for":"answer" + answer_count + "Lang<?php echo $language['language_id']; ?>"}).html("<?php echo addslashes($entry_answer); ?>"),
                      $("<div/>", {"class":"controls"}).append(
                        $("<textarea/>", {"name":"answers[" + answer_count + "][answer_text][<?php echo $language['language_id']; ?>]", "id":"answer" + answer_count + "Lang<?php echo $language['language_id']; ?>", "class":"input-xxlarge<?php echo ($lang == $language['code']) ? ' answer_text' : ''; ?>", "rows":"5"}).html("")
                      )
                    )
                  )
                  <?php echo (++$i < count($languages)) ? "," : ""; } ?>
                )
              )
            )
          )
        )
      );
      if (typeof CKEDITOR != "undefined") {
        <?php foreach ($languages as $language) { ?>
        CKEDITOR.replace('answer' + answer_count + 'Lang<?php echo $language['language_id']; ?>', {
          enterMode: CKEDITOR.ENTER_BR,
          filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
        });
        <?php } ?>
      }
      $("#answer" + answer_count + " .answer_author").typeahead(ta_opts)
      answer_count++;
    });
    $(document).on("change", ".answer-status", function() {
      if (parseInt(this.value)) {
        $(this).closest('.accordion-group').find('a.accordion-toggle').removeClass('alert-error');
      } else {
        $(this).closest('.accordion-group').find('a.accordion-toggle').addClass('alert-error');
      }
    });
  })
}( window.bull5i = window.bull5i || {}, jQuery ));
//--></script>
<?php echo $footer; ?>