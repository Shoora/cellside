<?php echo $header; ?>
<style type="text/css">
.content #sortable {
	display:block;
	height:40px;
	background: #ccc;
	padding-left:5px;
	padding-top:3px;
	border: 1px solid rgb(0, 0, 0);
}
.content #sortable li {
	display: block;
    height: 30px;
    margin: 0px;
    padding: 0px 5px 5px 5px;
    float: left;
    font: 13px/38px Arial,serif;
    text-decoration: none;
    text-shadow: 0px 1px 0px rgb(255, 255, 255);
    border: 1px solid rgb(223, 0, 0);
	border-radius: 5px;
    background: #ff5;
    cursor: pointer;
    list-style: none outside none;
	margin-right:5px;
}
</style>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_search_on_off; ?></td>
            <td><?php if ($d_ajax_search['search_on_off']) { ?>
              <input type="radio" name="d_ajax_search[search_on_off]" value="1" checked="checked" />
              <?php echo $text_on; ?>
              <input type="radio" name="d_ajax_search[search_on_off]" value="0" />
              <?php echo $text_off; ?>
              <?php } else { ?>
              <input type="radio" name="d_ajax_search[search_on_off]" value="1" />
              <?php echo $text_on; ?>
              <input type="radio" name="d_ajax_search[search_on_off]" value="0" checked="checked" />
              <?php echo $text_off; ?>
              <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_search_width; ?></td>
            <td><?php if ($d_ajax_search['search_width']) { ?>
              <input type="text" name="d_ajax_search[search_width]" value="<?php echo $d_ajax_search['search_width']; ?>"  />
              <?php } else { ?>
              <input type="text" name="d_ajax_search[search_width]" value="290px"  />
              <?php } ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_search_max_symbols; ?></td>
            <td><?php if (isset($d_ajax_search['search_max_symbols'])) { ?>
              <input type="text" name="d_ajax_search[search_max_symbols]" value="<?php echo $d_ajax_search['search_max_symbols']; ?>"  />
              <?php } else { ?>
              <input type="text" name="d_ajax_search[search_max_symbols]" value="0"  />
              <?php } ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_search_max_results; ?></td>
            <td><?php if (isset($d_ajax_search['search_max_results'])) { ?>
              <input type="text" name="d_ajax_search[search_max_results]" value="<?php echo $d_ajax_search['search_max_results']; ?>"  />
              <?php } else { ?>
              <input type="text" name="d_ajax_search[search_max_results]" value="15"  />
              <?php } ?></td>
          </tr>
		  <tr>
		  <td><?php echo $entry_search_first_sybmols; ?></td>
          <td><input type="checkbox" name="d_ajax_search[search_first_symbols]" <?php if (isset($d_ajax_search['search_first_symbols'])) echo 'checked="checked"'; ?>></td>
		  </tr>
		  <tr>
		  <td><?php echo $entry_search_priority; ?></td>
          <td>
		  <ul id="sortable" class="nav">
		  <?php if (isset($d_ajax_search['search_product_sort'])) { ?>
		  <?php for($i=0;$i<5;$i++) { ?>
          <?php if (isset($d_ajax_search['search_product_sort'])) {if ($d_ajax_search['search_product_sort']==$i) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_product_sort]" value="<?php echo $d_ajax_search['search_product_sort']; ?>"><input type="checkbox" name="d_ajax_search[search_product_on]" <?php if (isset($d_ajax_search['search_product_on'])) echo 'checked="checked"'; ?>><?php echo $text_product; ?></li><?php } } ?>
          <?php if (isset($d_ajax_search['search_category_sort'])) {if ($d_ajax_search['search_category_sort']==$i) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_category_sort]" value="<?php echo $d_ajax_search['search_category_sort']; ?>"><input type="checkbox" name="d_ajax_search[search_category_on]" <?php if (isset($d_ajax_search['search_category_on'])) echo 'checked="checked"'; ?>><?php echo $text_category; ?></li><?php } } ?>
          <?php if (isset($d_ajax_search['search_manufacturer_sort'])) {if ($d_ajax_search['search_manufacturer_sort']==$i) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_manufacturer_sort]" value="<?php echo $d_ajax_search['search_manufacturer_sort']; ?>"><input type="checkbox" name="d_ajax_search[search_manufacturer_on]" <?php if (isset($d_ajax_search['search_manufacturer_on'])) echo 'checked="checked"'; ?>><?php echo $text_manufacturer; ?></li><?php } } ?>
          <?php if ($is_blog==1) { ?><?php if (isset($d_ajax_search['search_blog_article_sort'])) {if ($d_ajax_search['search_blog_article_sort']==$i) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_blog_article_sort]" value="<?php echo $d_ajax_search['search_blog_article_sort']; ?>"><input type="checkbox" name="d_ajax_search[search_blog_aticle_on]" <?php if (isset($d_ajax_search['search_blog_aticle_on'])) echo 'checked="checked"'; ?>><?php echo $text_blog_article; ?></li><?php } } } ?>   
		  <?php if ($is_blog==1) { ?><?php if (isset($d_ajax_search['search_blog_category_sort'])) {if ($d_ajax_search['search_blog_category_sort']==$i) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_blog_category_sort]" value="<?php echo $d_ajax_search['search_blog_category_sort']; ?>"><input type="checkbox" name="d_ajax_search[search_blog_category_on]" <?php if (isset($d_ajax_search['search_blog_category_on'])) echo 'checked="checked"'; ?>><?php echo $text_blog_category; ?></li><?php } } } ?>  
		 <?php } ?>
		 <?php } else { ?>
		 <li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_product_sort]" value="0"><input type="checkbox" name="d_ajax_search[search_product_on]"><?php echo $text_product; ?></li>
		 <li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_category_sort]" value="1"><input type="checkbox" name="d_ajax_search[search_category_on]"><?php echo $text_category; ?></li>
		 <li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_manufacturer_sort]" value="2"><input type="checkbox" name="d_ajax_search[search_manufacturer_on]"><?php echo $text_manufacturer; ?></li>
		 <?php if ($is_blog==1) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_blog_article_sort]" value="3"><input type="checkbox" name="d_ajax_search[search_blog_aticle_on]"><?php echo $text_blog_article; ?></li><?php } ?>
		 <?php if ($is_blog==1) { ?><li class="route"><input type="hidden" class="sort" name="d_ajax_search[search_blog_category_sort]" value="4"><input type="checkbox" name="d_ajax_search[search_blog_category_on]"><?php echo $text_blog_category; ?></li><?php } ?>
		<?php } ?>
		 </ul>
		  </td>
		  </tr>
		  <tr>
		  <td><?php echo $entry_search_price; ?></td>
          <td><input type="checkbox" name="d_ajax_search[search_price]" <?php if (isset($d_ajax_search['search_price'])) echo 'checked="checked"'; ?>></td>
		  </tr>
		  <tr>
		  <td><?php echo $entry_search_special; ?></td>
          <td><input type="checkbox" name="d_ajax_search[search_special]" <?php if (isset($d_ajax_search['search_special'])) echo 'checked="checked"'; ?>></td>
		  </tr>
		  <tr>
		  <td><?php echo $entry_search_tax; ?></td>
          <td><input type="checkbox" name="d_ajax_search[search_tax]" <?php if (isset($d_ajax_search['search_tax'])) echo 'checked="checked"'; ?>></td>
		  </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
	$('ul#sortable').sortable({revert: false, distance: 5, start: function(event, ui){}, stop: function(event, ui) {sort_end(ui.item);}});
		
function sort_end(item) {
	item.parent().children("li.route").each(function( index ) {
	$(this).children(".sort").val(index);
	});
}
</script>
<?php echo $footer; ?>