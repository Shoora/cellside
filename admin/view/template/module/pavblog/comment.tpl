<?php  echo $header;  ?>
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
		   
		   <div class="toolbar"><?php require( dirname(__FILE__).'/toolbar.tpl' ); ?></div>
		  
			<div class="heading">
			  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
				<div class="buttons">
				  <a onclick="$('#form').submit();" class="button"><?php echo $this->language->get("button_save"); ?></a>
				  <a onclick="__submit('save-edit')" class="button"><?php echo $this->language->get('button_save_edit'); ?></a>
				  <a onclick="__submit('save-new')" class="button"><?php echo $this->language->get('button_save_new'); ?></a>
			
					<a  href="<?php echo $action_delete;?>" class="button action-delete"><?php echo $this->language->get("button_delete"); ?></a>	
			
				</div>  
			</div>
			
			<div class="content">
				<div class="box-columns">
					
					 
					<form id="form" enctype="multipart/form-data" method="post" action="<?php echo $action;?>">
							<input type="hidden" name="action_mode" id="action_mode" value=""/>
							<input type="hidden" name="pavblog_comment[comment_id]"  value="<?php echo $comment['comment_id'];?>"/>
							 <table class="form">
								<tr>
									<td><?php echo $this->language->get('entry_created');?></td>
									<td><?php echo $comment['created'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_user');?></td>
									<td><?php echo $comment['user'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_email');?></td>
									<td><?php echo $comment['email'];?></td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_status');?></td>
									<td>
										<select name="pavblog_comment[status]">
											<?php foreach( $yesno as $k=>$v ) { ?>
											<option value="<?php echo $k;?>"<?php if( $k==$comment['status']) { ?>selected="selected"<?php } ?>><?php echo $v;?></option>
											<?php } ?>
										</select>
									</td>
								</tr>
								<tr>
									<td><?php echo $this->language->get('entry_comment');?></td>
									<td><textarea rows="6" cols="90" name="pavblog_comment[comment]"><?php echo $comment['comment'];?></textarea></td>
								</tr>
							 </table>
					</form>
				 
				</div>
				
				
			</div>
		</div>	
		
		
 </div>
  
 <script type="text/javascript">
	$(".action-delete").click( function(){ 
		return confirm( "<?php echo $this->language->get("text_confirm_delete");?>" );
	} );
	function __submit( val ){
		$("#action_mode").val( val );
		$("#form").submit();
	}
	
 </script>
<?php echo $footer; ?>