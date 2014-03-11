<?php 
	$d = array(
		'delivery_data_module' => '
		
			<div id="freeship">
				<div class="heading">
					<h4>Free delivery !</h4>
					<span>Lorem psum conubia.</span>
				</div>
			</div>
		',
		'demo_widget_contact_data'=>'
			<ul>
				<li class="members">We have 152 guests and 14 members online</li>
				<li class="phone">Phone: +01 888 (000) 1234</li>
				<li class="fax">Fax: +01 888 (000) 1234</li>
				<li class="email">Email: www.leotheme.com</li>
			</ul>
		',
		'username_twitter_module' => 'pavothemes'
	);
	$module = array_merge( $d, $module );

//	echo '<pre>'.print_r( $languages, 1 );die;
?>

<div class="inner-modules-wrap">
	<div class="vtabs mytabs" id="my-tab-innermodules">
		<a onclick="return false;" href="#tab-imodule-footer" class="selected"><?php echo $this->language->get('Footer');?></a>
	 </div>

	 <div class="page-tabs-wrap">
	 		<div id="tab-imodule-footer">
				<h4><?php echo $this->language->get( 'Footer Center' ) ; ?></h4>

				<div id="language-widget_contact_data" class="htabs mytabstyle">
		            <?php foreach ($languages as $language) { ?>
		            <a href="#tab-language-widget_contact_data-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
		            <?php } ?>
		          </div>

				<?php foreach ($languages as $language) {   ?>
		          <div id="tab-language-widget_contact_data-<?php echo $language['language_id']; ?>">
		           
		            <table class="form">
		            	<?php $text =  isset($module['widget_contact_data'][$language['language_id']]) ? $module['widget_contact_data'][$language['language_id']] : $module['demo_widget_contact_data'];  ?>

		              <tr>
		                <td><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $this->language->get('Contact Us Module');?>: </td>
		                <td><textarea name="themecontrol[widget_contact_data][<?php echo $language['language_id']; ?>]" id="widget_contact_data-<?php echo $language['language_id']; ?>" rows="5" cols="60"><?php echo $text; ?></textarea></td>
		              </tr>
		            </table>
		          </div>
		          <?php } ?>

				<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
				<script type="text/javascript"><!--
				$("#language-widget_contact_data a").tabs();
				<?php foreach( $languages as $language )  { ?>
				CKEDITOR.replace('widget_contact_data-<?php echo $language['language_id']; ?>', {
					filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
					filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
				});
				<?php } ?>
				//--></script> 
			</div>
	 </div>
	 <div class="clearfix clear"></div>	
</div>

