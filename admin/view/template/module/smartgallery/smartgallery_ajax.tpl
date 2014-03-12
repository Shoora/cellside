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
					<?php echo $text_gallery_list; ?>
				</a>
			</li>
			<li class="">
				<a href="#gallery_on_page" data-toggle="tab">
					<?php echo $text_gallery_page; ?>
				</a>
			</li>
			<li>
				<a href="#glob_setting" data-toggle="tab">
					<?php echo $text_global_setting; ?>
				</a>
			</li>
			<li>
				<a href="#exp_imp" data-toggle="tab">
					<?php echo $text_exp_imp; ?>
				</a>
			</li>
			<li>
				<a href="#info" data-toggle="tab">
					<?php echo $text_info; ?>
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

