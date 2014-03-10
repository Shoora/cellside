<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>

	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?> (<?php echo $SG_VER; ?>)</h1>
			<div class="pull-right" style="margin-top: 5px;">
			<a href="<?php echo $cancel; ?>" class="btn btn-small" type="button">Exit</a>
			</div>
		</div>

		<div class="content">
		
		<?php if ($success) { ?>
			<div class="success"><?php echo $success; ?></div>
		<?php } ?>
		<?php if ($error_warning) { ?>
			<div class="warning"><?php echo $error_warning; ?></div>
		<?php } ?>
		
			<div class="box-block" id="global_box">
				<div class="tabbable"> 
					<ul class="nav nav-tabs">
						<li class="active">
							<a href="#list_gallery" data-toggle="tab">
								<i class="icon-th-list"></i> <?php echo $text_gallery_list; ?>
							</a>
						</li>
						<li class="">
							<a href="#gallery_on_page" data-toggle="tab">
								<i class="icon-hand-down"></i> <?php echo $text_gallery_page; ?>
							</a>
						</li>
						<li>
							<a href="#glob_setting" data-toggle="tab">
								<i class="icon-globe"></i> <?php echo $text_global_setting; ?>
							</a>
						</li>
						<li>
							<a href="#exp_imp" data-toggle="tab">
								<i class="icon-retweet"></i> <?php echo $text_exp_imp; ?>
							</a>
						</li>
						<li>
							<a href="#info" data-toggle="tab">
								<i class="icon-info-sign"></i> <?php echo $text_info; ?>
							</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="list_gallery">
							<!-- GALLERY IN PAGE START-->
								<?php require_once 'main/list_gallery.tpl';?>
							<!-- GALLERY IN PAGE END-->	
						</div>
						
						<div class="tab-pane" id="gallery_on_page">
							<!-- GALLERY IN PAGE START-->
								<?php require_once 'main/gallery_on_page.tpl';?>
							<!-- GALLERY IN PAGE END-->	
						</div>
						
						<div class="tab-pane" id="glob_setting">
							<!-- GLOBAL SETTING START-->
								<?php require_once 'main/glob_setting.tpl';?>
							<!-- GLOBAL SETTING END-->		
						</div>
						
						<div class="tab-pane" id="exp_imp">
							<!-- IMPORT/EXPORT START-->
								<?php require_once 'main/exp_imp.tpl';?>
							<!-- IMPORT/EXPORT END-->	
						</div>
						
						<div class="tab-pane" id="info">
							<!-- INFO START-->
								<?php require_once 'main/info.tpl';?>
							<!-- INFO END-->	
						</div>
					</div>
				</div>
			</div>
			
			<div class="box-block" id="edit_box">
				<?php require_once 'edit/index.tpl';?>
			</div>
		</div>	

	</div>

</div>

<script type="text/javascript">
jQuery(document).ready(function() {
	$('.show_hide_help').click(function(){
		var $tips =$('.icon-question-sign');
		if($(this).hasClass('show')){
			$(this).removeClass('show').addClass('hide').text('<?php echo $button_help_show; ?>');
			$tips.hide();
		}else{
			$(this).addClass('show').removeClass('hide').text('<?php echo $button_help_hide; ?>');
			$tips.show();
		}
	}).click();
	
});


var SGS = {
	data : {
		layout : <?php echo json_encode($default_galleryOnPage['layouts']); ?>
	},
	text : {
		confirm_del_layer 		: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>Are you sure you want to remove this layer?</p>',
		confirm_del_sublayer	: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>Are you sure you want to remove this sublayer?</p>',
		alert_not_save			: '<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>You not have Layers, please add New Layer and then you will can save.</p>'
	},
	url: {
		action						: '<?php echo htmlspecialchars_decode($action); ?>',
		cancel						: '<?php echo htmlspecialchars_decode($cancel); ?>',
		save_gallery_url			: '<?php echo htmlspecialchars_decode($save_gallery_url); ?>',
		
		get_gallery_url				: '<?php echo htmlspecialchars_decode($get_gallery_url); ?>',
		remove_gallery_url			: '<?php echo htmlspecialchars_decode($remove_gallery_url); ?>',
		duplicate_gallery_url		: '<?php echo htmlspecialchars_decode($duplicate_gallery_url); ?>',
		
		remove_gallery_to_page_url	: '<?php echo htmlspecialchars_decode($remove_gallery_to_page_url); ?>',
		save_gallery_to_page_url	: '<?php echo htmlspecialchars_decode($save_gallery_to_page_url); ?>',
		
		save_glob_setting_url		: '<?php echo htmlspecialchars_decode($save_glob_setting_url); ?>',
		
		import_url					: '<?php echo htmlspecialchars_decode($import_url); ?>',
		
		support_getproducts_url		: '<?php echo htmlspecialchars_decode($support_getproducts_url); ?>'
		
	},
	token : '<?php echo $token; ?>',
	SG_VER_status : <?php echo $SG_VER_status; ?>,
	update_text	: '<?php echo $update_text; ?>'	
}

</script>

<?php echo $footer; ?>