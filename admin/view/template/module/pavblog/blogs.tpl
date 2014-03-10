<?php  echo $header;  ?>
 <div id="content">
	  <div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	  </div>
	  <div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
	  <?php if ($error_warning) { ?>
	  <div class="warning"><?php echo $error_warning; ?></div>
	  <?php } ?>
		<div class="box">
			<div class="heading">
			  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
				<div class="buttons">
				  <a onclick="__submit('delete')" class="button action-delete"><?php echo $this->language->get("button_delete"); ?></a>
   				
				 <a onclick="__submit('published')" class="button"><?php echo $this->language->get("button_publish"); ?></a>
				 <a onclick="__submit('unpublished')" class="button"><?php echo $this->language->get("button_unpublish"); ?></a>
   				
				</div>  
			</div>
			
			<div class="content">
				<div class="box-columns">
					<form id="filter" method="post" action="<?php echo $action;?>">
						 <div class="filter-wrap clearfix">
							<div class="filter-title "><label><?php echo $this->language->get('text_filter_title');?></label>
								<input name="filter[title]" value="<?php echo $filter['title'];?>" size="50">
							</div>
							<div class="filter-category ">
							<label><?php echo $this->language->get('text_category');?></label>
							<?php echo $menus;?>
							
							</div>
							<button type="submit" name="submit"><?php echo $this->language->get('text_filter');?></button>
							<a href="<?php echo $action_reset;?>"><?php echo $this->language->get('text_reset');?></a>
						 </div>
					 </form>
					<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action;?>">
						
				
						<input type="hidden" name="do-action" value="" id="do-action">
						<table class="list">
							<thead>
								<tr>
									<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);"></td>
									<td class="left"><?php echo $this->language->get("entry_title");?></td>
									<td class="center" width="200"><?php echo $this->language->get('text_position');?> <a onclick="__submit('position')" class="button"><?php echo $this->language->get("save"); ?></a></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_status');?></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_created');?></td>
									<td class="right"  width="60"><?php echo $this->language->get('text_hits');?></td>
									<td class="right"  width="100"><?php echo $this->language->get('text_edit');?></td>
								</tr>
							</thead>
							
							<tbody>
								<?php foreach( $blogs as $blog ) {  // echo '<pre>'.print_r( $blog, 1 ); die;?>
								<tr>
									<td width="1" style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $blog['blog_id'];?>"></td>
									<td class="left"><?php echo $blog['title'];?></td>
									<td class="center"  ><input name="position[<?php echo $blog['blog_id'];?>]" value="<?php echo $blog['position'];?>" size="3"></td>
									<td class="right"><?php echo ($blog['status']?$this->language->get('text_enable'):$this->language->get('text_disable'));?></td>
									<td class="right"><?php echo $blog['created'];?></td>
									<td class="right"><?php echo $blog['hits'];?></td>
									<td class="right"><a href="<?php echo sprintf($edit_link, $blog['blog_id']) ?>"><?php echo $this->language->get('text_edit');?></a></td>
								</tr>
								<?php } ?>
							</tbody>
						</table>
					</form>
					<div class="pagination">
						<?php echo $pagination;?>
					</div>
				</div>
			</div>
		</div>	
		
		
 </div>
 
 <script type="text/javascript">
	$(".action-delete").click( function(){ return confirm('<?php echo $this->language->get('text_confirm_delete');?>') } );
	function __submit( val ){
		$("#do-action").val( val );
		$("#form").submit();
	}
	
	 
 </script>
<?php echo $footer; ?>