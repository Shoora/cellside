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
        <?php if ($qap_multilingual) { ?>
        <select id="selectLanguage" rel="tooltip" data-original-title="<?php echo $text_show_languages; ?>">
          <option value="*"<?php echo ($qap_list_language == '*') ? ' selected="selected"' : ''; ?>><?php echo $text_all_languages; ?></option>
          <?php foreach ($languages as $code => $lang) { ?>
          <option value="<?php echo $lang['language_id']; ?>"<?php echo ($qap_list_language == $lang['language_id']) ? ' selected="selected"' : ''; ?>><?php echo $lang['name']; ?></option>
          <?php } ?>
        </select>
        <?php } ?>
        <div class="btn-group">
          <button class="btn btn-small<?php echo ($filters['approval']) ? ' active' : ''; ?>" type="button" id="filterApproval" data-href="<?php echo $approval; ?>" data-toggle="button" data-container="body" rel="tooltip" data-original-title="<?php echo $text_requires_approval; ?>"><?php echo $button_approval; ?></button>
        </div>
        <div class="btn-group list_questions" data-toggle="buttons-radio">
          <button class="btn btn-small<?php echo ($qap_list_questions == "general") ? ' active' : ''; ?>" type="button" data-value="general" data-container="body" rel="tooltip" data-original-title="<?php echo $text_general_questions; ?>"><?php echo $button_general; ?></button>
          <button class="btn btn-small<?php echo ($qap_list_questions == "product") ? ' active' : ''; ?>" type="button" data-value="product" data-container="body" rel="tooltip" data-original-title="<?php echo $text_product_questions; ?>"><?php echo $button_product; ?></button>
          <button class="btn btn-small<?php echo ($qap_list_questions == "all") ? ' active' : ''; ?>" type="button" data-value="all" data-container="body" rel="tooltip" data-original-title="<?php echo $text_all_questions; ?>"><?php echo $button_all; ?></button>
        </div>
        <div class="btn-group">
          <button class="btn btn-small btn-primary" type="button" id="insertNew" data-href="<?php echo $insert; ?>"><i class="icon-plus icon-small"></i><?php echo $button_insert; ?></button>
          <button class="btn btn-small btn-warning" type="button" id="deleteSelected"><i class="icon-trash icon-small"></i><?php echo $button_delete; ?></button>
        </div>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked).trigger('change');" /></td>
              <?php foreach($column_order as $col) { ?>
                <?php if (!empty($column_info[$col]['sort'])) { ?>
              <td class="<?php echo $column_info[$col]['align']; ?>"><a href="<?php echo $sorts[$col]; ?>"<?php echo ($sort == $column_info[$col]['sort']) ? ' class="' . strtolower($order) . '"' : ''; ?>><?php echo $columns[$col]; ?></a></td>
                <?php } else { ?>
              <td class="<?php echo $column_info[$col]['align']; ?>"><?php echo $columns[$col]; ?></td>
                <?php } ?>
              <?php } ?>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
              <?php foreach($column_order as $col) {
                switch ($col) {
                    case 'status': ?>
              <td class="<?php echo $column_info[$col]['align']; ?>" width="1">
                <select name="filter_<?php echo $col; ?>" class="filter <?php echo $col; ?>">
                  <option value="*"></option>
                  <option value="1"<?php echo ($filters[$col]) ? ' selected="selected"' : ''; ?>><?php echo $text_enabled; ?></option>
                  <option value="0"<?php echo (!is_null($filters[$col]) && !$filters[$col]) ? ' selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
                </select>
              </td>
                        <?php break;
                    case 'store': ?>
              <td class="<?php echo $column_info[$col]['align']; ?>" width="1">
                <select name="filter_<?php echo $col; ?>" class="filter <?php echo $col; ?>">
                  <option value=""></option>
                  <option value="*"<?php echo (!is_null($filters[$col]) && $filters[$col] == '*') ? ' selected="selected"' : ''; ?>><?php echo $text_none; ?></option>
                  <?php foreach ($stores as $store_id => $s) { ?>
                  <option value="<?php echo $store_id; ?>"<?php echo (!is_null($filters[$col]) && (string)$store_id == $filters[$col]) ? ' selected="selected"' : ''; ?>><?php echo $s['name']; ?></option>
                  <?php } ?>
                </select>
              </td>
                        <?php break;
                    case 'action': ?>
              <td width="1" class="<?php echo $column_info[$col]['align']; ?> nowrap">
                <div class="btn-group">
                  <button class="btn btn-small btn-success btn-icon" type="button" id="filterResults" data-container="body" rel="tooltip" data-original-title="<?php echo $text_filter_results; ?>"><i class="icon-filter icon-small"></i></button>
                  <button class="btn btn-small btn-warning btn-icon" type="button" id="clearFilter" data-container="body" rel="tooltip" data-original-title="<?php echo $text_clear_filter; ?>"><i class="icon-remove icon-small"></i></button>
                </div>
              </td>
                        <?php break;
                    case 'id':
                    case 'product':
                    case 'author':
                    case 'email': ?>
              <td width="1" class="<?php echo $column_info[$col]['align']; ?>"><input type="text" name="filter_<?php echo $col; ?>" value="<?php echo $filters[$col]; ?>" class="filter <?php echo $col; ?>"<?php echo ($column_info[$col]['filter']['autocomplete']) ? ' placeholder="' . $text_autocomplete . '"' : ''; ?> /></td>
                        <?php break;
                    case 'answers':
                    case 'date_added': ?>
              <td width="1" class="<?php echo $column_info[$col]['align']; ?> nowrap"><input type="text" name="filter_<?php echo $col; ?>" value="<?php echo $filters[$col]; ?>" class="filter <?php echo $col; ?>"<?php echo ($column_info[$col]['filter']['autocomplete']) ? ' placeholder="' . $text_autocomplete . '"' : ''; ?> /></td>
                        <?php break;
                    default: ?>
                    <?php if ($column_info[$col]['filter']['show']) { ?>
              <td class="<?php echo $column_info[$col]['align']; ?>"><input type="text" name="filter_<?php echo $col; ?>" value="<?php echo $filters[$col]; ?>" class="filter <?php echo $col; ?>"<?php echo ($column_info[$col]['filter']['autocomplete']) ? ' placeholder="' . $text_autocomplete . '"' : ''; ?> /></td>
                    <?php } else { ?>
              <td></td>
                    <?php } ?>
                        <?php break;
                }
              } ?>
            </tr>
            <?php if ($questions) { ?>
            <?php foreach ($questions as $question) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($question['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $question['question_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $question['question_id']; ?>" />
                <?php } ?></td>
              <?php foreach($column_order as $col) {
                switch ($col) {
                    case 'action': ?>
              <td class="<?php echo $column_info[$col]['align']; ?> action">
                <div class="act-cont">
                <div class="btn-group">
                <?php foreach ($question['action'] as $action) { ?>
                <?php if (!$action['hide']) { ?>
                <button type="button" <?php echo (isset($action['href'])) ? ' data-href="' . $action['href'] . '"' : ''; ?> id="<?php echo $action['name'] . "-" . $question['question_id']; ?>" class="btn btn-small btn-edit<?php echo ($action['btn']['class']) ? ' ' . $action['btn']['class']: ''; ?>"<?php echo ($action['ref']) ? ' data-ref="' . $action['ref'] . '-' . $question['question_id'] . '"' : ''; ?>><?php if ($action['btn']['icon']) {?><i class="<?php echo $action['btn']['icon']; ?>"></i><?php } ?><?php echo $action['text']; ?></button>
                <?php } ?>
                <?php } ?>
                </div>
                </div>
              </td>
                        <?php break;
                    case 'answers': ?>
              <td class="<?php echo $column_info[$col]['align']; ?> nowrap" id="<?php echo $col . "-" . $question['question_id']; ?>"><?php if ($question['answer_count']) { ?><button type="button" class="btn btn-mini btn-icon btn-view-answers pull-left" rel="clickover" data-html="true" data-placement="left" data-trigger="click" data-title="<?php echo $text_answers; ?>" data-content="<?php echo $question['answer_texts']; ?>" data-toggle="button"><i class="icon-comments-alt"></i></button><?php } ?><?php if ($question['disabled_answers']) { ?><i class="icon-warning-sign icon-small icon-danger" rel="tooltip" data-original-title="<?php echo $question['disabled_answers']; ?>"></i> <?php } ?><?php echo $question[$col]; ?></td>
                        <?php break;
                    case 'question': ?>
              <td class="<?php echo $column_info[$col]['align']; ?>" id="<?php echo $col . "-" . $question['question_id']; ?>"><?php if ($question['question_details']) { ?><button type="button" class="btn btn-mini btn-icon btn-view-question pull-right" rel="clickover" data-html="true" data-trigger="click" data-title="<?php echo $question['question_title']; ?>" data-content="<?php echo $question['question_details']; ?>" data-toggle="button"><i class="icon-eye-open"></i></button><?php } ?><?php if ($question['language_id']) { echo $question[$col]; } else { ?><em>[ <?php echo $text_no_question_text; ?> ]</em><?php } ?></td>
                        <?php break;
                    case 'product':
                    case 'store': ?>
              <td class="<?php echo $column_info[$col]['align']; ?>" id="<?php echo $col . "-" . $question['question_id']; ?>"<?php if (!empty($question["{$col}_all"])) { ?>><div rel="popover" data-html="true" data-trigger="hover" data-content="<?php echo $question["{$col}_all"]; ?>"<?php } ?>><?php echo $question[$col]; ?><?php if (!empty($question["{$col}_all"])) { ?></div><?php } ?></td>
                        <?php break;
                    default: ?>
              <td class="<?php echo $column_info[$col]['align']; ?>" id="<?php echo $col . "-" . $question['question_id']; ?>"><?php echo $question[$col]; ?></td>
                        <?php break;
                }
              } ?>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="<?php echo count($column_order) + 1; ?>"><?php echo $text_no_results; ?></td>
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
(function( bull5i, $, undefined ) {
  var xhr = null
    , t = null;
  bull5i.filterResults = function() {
    url = 'index.php?route=catalog/questions_and_answers&token=<?php echo $token; ?>&sort=<?php echo $sort; ?>&order=<?php echo $order; ?>';

  <?php foreach($column_info as $column => $val) {
      if ($val['filter']['show']) {
          if ($val['filter']['type'] == 0) { ?>
      var filter_<?php echo $column; ?> = $('input[name=\'filter_<?php echo $column; ?>\']').attr('value');

      if (filter_<?php echo $column; ?>) {
          url += '&filter_<?php echo $column; ?>=' + encodeURIComponent(filter_<?php echo $column; ?>);
      }

  <?php } else if ($val['filter']['type'] == 1) { ?>
      var filter_<?php echo $column; ?> = $('select[name=\'filter_<?php echo $column; ?>\']').attr('value');
  <?php if (in_array($column, array('store'))) { ?>
      if (filter_<?php echo $column; ?>) {
  <?php } else { ?>
      if (filter_<?php echo $column; ?> && filter_<?php echo $column; ?> != '*') {
  <?php } ?>
          url += '&filter_<?php echo $column; ?>=' + encodeURIComponent(filter_<?php echo $column; ?>);
      }

  <?php }
      }
  } ?>
    <?php if ($filters['approval']) { ?>
      url += '&filter_approval=1';
    <?php } ?>
    location = url;
  }

  bull5i.clearFilter = function() {
    location = 'index.php?route=catalog/questions_and_answers&token=<?php echo $token; ?>&sort=<?php echo $sort; ?>&order=<?php echo $order; ?>';
  }

  $('#form input, #form select').keyup(function(e) {
  	if (e.keyCode == 13) {
      clearTimeout(t);
      t = setTimeout(function(){
        bull5i.filterResults();
      }, 100);
  	}
  });

  (function($) {
    $('input.filter.date_added').datepicker({dateFormat: 'yy-mm-dd', constrainInput: false});
  })(jQuery);
  <?php foreach($column_info as $column => $val) {
    if ($val['filter']['autocomplete']) {?>
  $("input[name=\'filter_<?php echo $column; ?>\']").typeahead({
    source: function(query, process) {
      if (xhr) xhr.abort();
      xhr = $.ajax({
        url: '<?php echo $autocomplete; ?>',
        type: 'post',
        data: {query: query, field: '<?php echo $column; ?>'},
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
    /*onselect: function (data) {
      $("#form input[name=customer_id]").val(data.customer_id);
      $("#form input[name=email]").val(data.email);
      select_value = data.email;
    },*/
    updater: function(item) {
      return item.<?php echo $val['filter']['autocomplete']['select']; ?>
    },
    matcher: function(item) {
      return true;
    },
    property: "<?php echo isset($val['filter']['autocomplete']['show']) ? $val['filter']['autocomplete']['show'] : 'name'; ?>",
    items:10
  })
    <?php } ?>
  <?php } ?>
  $(".list_questions button").on('click', function() {
    $("<form/>", {"method":"post"}).append($("<input/>", {"type":"hidden", "name":"list_questions", "value":$(this).attr("data-value")})).submit()
  });
  $("#selectLanguage").on('change', function() {
    $("<form/>", {"method":"post"}).append($("<input/>", {"type":"hidden", "name":"list_language", "value":$(this).val()})).submit()
  });
}( window.bull5i = window.bull5i || {}, jQuery ));
//--></script>
<?php echo $footer; ?>