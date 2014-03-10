<p class="message">
		<i><?php echo $this->language->get('text_message_datasample_modules');?></i>
</p>
<h2>A. Backup data and setting</h2>
<p>
	
	<a href="<?php echo $this->url->link('module/themecontrol','backup=1&token='. $this->session->data['token'], 'SSL') ;?>" class="button  green">
		<?php echo $this->language->get('text_backup_data_now');?>
	</a>
</p>
<h2>B. Installtion</h2>
<h3>1. <?php echo $this->language->get('text_install_datasample_store');?></h3>
<div class="storeconfig">
	<p><i><?php echo $this->language->get('text_install_store_sample_explain'); ?></i></p>
<a rel="install" class="label badge  bgreen" href="<?php echo $this->url->link('module/themecontrol/storesample', 'theme='.$module['default_theme'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_install_store_sample');?></a>

</div>
<h3>2. <?php echo $this->language->get('text_install_datasample_modules');?></h3>

<table class="form">
<thead>
<tr>
	<td><b><?php echo $this->language->get('text_module_name');?></b></td>
	<td><b><?php echo $this->language->get('text_action'); ?></b></td>
</th>
</thead>
<tr><td colspan="2">
	<h4>- <?php echo $this->language->get('text_sample_module_query'); ?></h4>
	<p><i><?php echo $this->language->get('text_sample_module_query_explain'); ?></i></p>
</td></tr>
<?php foreach( $modulesQuery as  $qmodule => $text_mod ) { ?>
<tr>
	<td><a target="_blank" href="<?php echo $this->url->link('module/'.$qmodule, 'token=' . $this->session->data['token'], 'SSL');?>"><?php echo $text_mod;?></a></td>
	<td>
		<a rel="install" class="label badge bgreen"  href="<?php echo $this->url->link('module/themecontrol/installsample', 'type=query&theme='.$module['default_theme'].'&module='.$qmodule.'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_install_sample');?></a> [SQL Query]
	<td>
</tr>
<?php } ?>
<tr><td colspan="2">
	<h4>- <?php echo $this->language->get('text_sample_module_setting'); ?></h4>
	<p><i> <?php echo $this->language->get('text_sample_module_setting_explain'); ?></i></p>
</td></tr>
<?php 
foreach( $samples as $sample  ) { ?>
	<tr>
		<td>
		<?php if( isset($sample['existed']) && !$sample['existed'] ) { ?>
		<?php echo $this->language->get('text_module_not_uploaded');?>
		<?php } ?>
		<a target="_blank" href="<?php echo $this->url->link('module/'.$sample['module'], 'token=' . $this->session->data['token'], 'SSL');?>"><?php echo $sample['moduleName'];?></a>
		<?php if( isset($sample['extension_installed']) && !$sample['extension_installed'] ) { ?>
		<?php echo $this->language->get('text_module_not_installed');?>
		<?php } ?>
		</td>
		<td>	
			<?php if( isset($sample['extension_installed']) && !$sample['extension_installed'] && (isset($sample['existed']) && $sample['existed']) ) { ?>
			 <a  rel="install-extension" class="label badge bdanger" href="<?php echo $this->url->link('extension/module/install', 'extension='.$sample['module'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_install_now'); ?> </a> 
			<?php } ?>

			<?php if( $sample['installed'] ) { ?>
				<a rel="override" class="label badge bred" href="<?php echo $this->url->link('module/themecontrol/installsample', 'theme='.$module['default_theme'].'&module='.$sample['module'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_override_sample');?></a>
			<?php } else { ?>
				<a rel="install" class="label badge bgreen" href="<?php echo $this->url->link('module/themecontrol/installsample', 'theme='.$module['default_theme'].'&module='.$sample['module'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_install_sample');?></a>
			<?php } ?>
			
			<?php if( isset($backup_restore[$sample['module']]) ) { ?> | 
			<a rel="restore" class="label badge bgreen" href="<?php echo $this->url->link('module/themecontrol/restore', 'theme='.$module['default_theme'].'&module='.$sample['module'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_restore_setting');?></a>
			<?php } ?>
		</td>
	</tr>
<?php } ?>


</table>
<h3>3. <?php echo $this->language->get('disable_expected_module_in_home_page'); ?></h3>
<p class="message">
	<i><?php echo $this->language->get('text_message_disable_expected_module_in_home_page');?></i>
</p>
<table class="form">
	<?php foreach(  $unexpectedModules as $umodule )  { ?>
	<tr>
		<td>
			<a href="<?php echo $this->url->link('module/'.$umodule['code'], 'token=' . $this->session->data['token'], 'SSL');?>"><?php echo $umodule['title']; ?></a>
			

		</td>
		<td>
			<a  rel="install-extension" class="label badge bdanger" href="<?php echo $this->url->link('extension/module/uninstall', 'extension='.$umodule['code'].'&token=' . $this->session->data['token'], 'SSL');?>"><?php echo $this->language->get('text_uninstall_now'); ?> </a>
		</td>
	</tr>
	<?php } ?>
</table>
<script type="text/javascript">
$("#tab-datasample a").click( function(){
var flag = false; 
if( $(this).attr('rel') == 'override' ){
	var flag = confirm( '<?php echo $this->language->get('text_message_override_sample'); ?>' );
}else if( $(this).attr('rel') == 'install' ){
	var flag = confirm( '<?php echo $this->language->get('text_message_install_sample'); ?>' );
}else if( $(this).attr('rel') == 'restore' ){
	var flag = confirm( '<?php echo $this->language->get('text_message_restore_sample'); ?>' );
}else if(  $(this).attr('rel') == 'install-extension' ){
	flag = 1;
}else {
	return true; 
}
if( flag ){
	var $this = $( this );
	$this.html('processing');	
	$.post( $(this).attr('href'), function(data) {
		// $('.result').html(data);
		if( $this.attr("rel") == "install-extension" ){
			$this.remove();
		}else {
			$this.parent().html('done');
		}
	});
	return false;
}
return false; 
} );		
</script>
				