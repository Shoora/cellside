<div class="action_button pull-left">
	<form style="margin: 0 0 20px -120px;" class="form-horizontal">
		<fieldset>
		<div class="control-group">
			<label class="control-label" for="main-name">Name</label>
			<div class="controls">
				<input type="text" id="main-name" name="name" value="<?php echo $options['main']['name']; ?>" >
				<input type="hidden" id="main-id" name="id" value="<?php echo $options['main']['id']; ?>" >
			</div>
		</div>
		</fieldset>
	</form>
</div>
<div class="action_button pull-right">
	<div class="btn-group">
		<button id="btn-quick-style" class="btn dropdown-toggle" data-toggle="dropdown">
			<i title="" class="icon-asterisk" data-original-title="Here you can quick change style of Galleries"></i> Quick style <span class="caret"></span>
		</button>
		<ul class="dropdown-menu quick-style">
			<li data-type="setDefault" >Default Style</li>
			<li data-type="setDark" >Dark Style</li>
			<li data-type="setWhite" >White Style</li>
			<li data-type="setIphone" >IPhone Style</li>
			<li data-type="setGlamur" >Glamur Style</li>
		</ul>
	</div>
	<div class="btn-group">
		<button id="btn-quick-setting" class="btn dropdown-toggle" data-toggle="dropdown">
			<i title="" class="icon-asterisk" data-original-title="Here you can quick change mode of Galleries"></i> Quick setting <span class="caret"></span>
		</button>
		<ul class="dropdown-menu quick-setting">
			<li data-type="setForProdPage" >Product Page</li>
			<li data-type="setForCategPage" >Category Page</li>
			<li data-type="setForMainPage" >Main Page</li>
		</ul>
	</div>
	<button class="btn btn-primary saveGallery" type="button">Save</button>
	<button class="btn cancelGallery" type="button">Cancel</button>
</div>
<div class="clearfix"></div>
<div class="tabbable tabs-left"> 
	<ul class="nav nav-tabs">
		<li class="active">
			<a href="#main_setting" data-toggle="tab">
				<i class="icon-th-large"></i> <?php echo $text_main_setting; ?>
			</a>
		</li>
		<li>
			<a href="#view_setting" data-toggle="tab">
				<i class="icon-eye-open"></i> <?php echo $text_view_setting; ?>
			</a>
		</li>
		<li>
			<a href="#size_setting" data-toggle="tab">
				<i class="icon-resize-horizontal"></i> <?php echo $text_size_setting; ?>
			</a>
		</li>
		<li>
			<a href="#style_setting" data-toggle="tab">
				<i class="icon-tint"></i> <?php echo $text_style_setting; ?>
			</a>
		</li>
		<li>
			<a href="#control_setting" data-toggle="tab">
				<i class="icon-cog"></i> <?php echo $text_control_setting; ?>
			</a>
		</li>
		<li>
			<a href="#product_setting" data-toggle="tab">
				<i class="icon-briefcase"></i> <?php echo $text_product_setting; ?>
			</a>
		</li>
		<li>
			<a href="#animation_setting" data-toggle="tab">
				<i class="icon-film"></i> <?php echo $text_annimation_setting; ?>
			</a>
		</li>
		<li>
			<a href="#events" data-toggle="tab">
				<i class="icon-bell"></i> <?php echo $text_events; ?>
			</a>
		</li>
	</ul>
	
	<div class="tab-content">
		<div class="tab-pane active" id="main_setting">
			<!-- MODE SETTING START-->
			<?php require_once 'main_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="view_setting">
			<!-- MODE SETTING START-->
			<?php require_once 'view_setting.tpl';?>
		</div>

		<div class="tab-pane" id="size_setting">
			<!-- SIZE START-->
			<?php require_once 'size_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="style_setting">
			<!-- STYLE START-->
			<?php require_once 'style_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="control_setting">
			<!-- ANNIMATION START-->
			<?php require_once 'control_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="product_setting">
			<!-- ANNIMATION START-->
			<?php require_once 'product_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="animation_setting">
			<!-- ANNIMATION START-->
			<?php require_once 'animation_setting.tpl';?>
		</div>
		
		<div class="tab-pane" id="events">
			<!-- EVENTS-->
			<?php require_once 'events.tpl';?>
		</div>
	</div>
</div>

