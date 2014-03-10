<?php 
$themeName = basename( dirname(dirname(dirname(dirname(__FILE__)))) );
$t = dirname(dirname(dirname(dirname(__FILE__))));
$output = array();
if( is_dir($t.'/image/pattern/') ) {
	$files = glob($t.'/image/pattern/*.png');
	foreach( $files as $dir ){
		$output[] = str_replace(".png","",basename( $dir ) );
	}			
}
$directories = glob( DIR_TEMPLATE.$this->config->get('config_template').'/skins/*', GLOB_ONLYDIR);
$this->load->model('setting/setting');
$current_custom = $this->model_setting_setting->getSetting('pavothemecustomize_custom');
$current_custom = (isset($current_custom['current_custom']) ? $current_custom['current_custom'] : array());
$themeCustomize = $this->model_setting_setting->getSetting('themecustomize_'.$current_custom);
$themeCustomize = (isset($themeCustomize[$current_custom]) && isset($themeCustomize[$current_custom]['themecustomize']) ? $themeCustomize[$current_custom]['themecustomize'] : array());

?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/themecustomize.css" />
<script type="text/javascript">
	var $pavColorImageFolder = "catalog/view/theme/<?php echo $themeName;?>/image/colorpicker/";
	var pavPathImg = "<?php echo $this->config->get('config_url');?>catalog/view/theme/<?php echo $themeName;?>/image/pattern/";
</script>
<script type="text/javascript" src="catalog/view/theme/<?php echo $themeName;?>/javascript/mColorPicker.js"></script>
<?php 
	$params = array(
		'body' => 'Body',
		'#header' => 'Header Wrapper',
		'#mainnav' => 'Main NAV Wrapper',
		'#slideshow' => 'Slideshow Wrapper',
		'#pav-promotion' => 'Promotion Wrapper',
		'#columns' => 'Columns Wrapper',
		'#footer' => 'Footer Wrapper'
	);
?>
<div id="pav-themecustomize" class="hidden-phone">
	<div class="pn-action pull-right"><i class="icon-cog"></i></div>
	<div class="panel-inner">
		<div>
			<h4>Theme Customize</h4>
			<form action="" method="post">
				<div id="pav-accordion">
					<?php foreach($params as $key=>$row){?>
					<h3><?php echo $row;?></h3>
					<div class="customize-group">
						<div class="row">
							<div class="col-lg-4">
								<label>Background Color</label>
								<input class="pavcolor" type="color" value="<?php echo (isset($themeCustomize[$key]) && isset($themeCustomize[$key]['background-color']) ? $themeCustomize[$key]['background-color'] : '');?>" name="themecustomize[<?php echo $key;?>][background-color]" size="8" data-text="hidden" data-hex="true" data-match-container="<?php echo $key;?>" data-css-key="background-color">
							</div>
							<div class="col-lg-4">
								<label>Text Color</label>
								<input class="pavcolor" type="color" value="<?php echo (isset($themeCustomize[$key]) && isset($themeCustomize[$key]['color']) ? $themeCustomize[$key]['color'] : '');?>" name="themecustomize[<?php echo $key;?>][color]" size="8" data-text="hidden" data-hex="true" data-match-container="<?php echo $key;?>" data-css-key="color"/>
							</div>
							<div class="col-lg-4">
								<label>Module Title Color</label>
								<input class="pavcolor" type="color" value="<?php echo (isset($themeCustomize[$key]) && isset($themeCustomize[$key]['mtitle_color']) ? $themeCustomize[$key]['mtitle_color'] : '');?>" name="themecustomize[<?php echo $key;?>][mtitle_color]" size="8" data-text="hidden" data-hex="true" data-match-container="<?php echo $key;?> h3.box-heading span" data-css-key="color"/>
							</div>
							<div class="col-lg-4">
								<label>Link Color</label>
								<input class="pavcolor" type="color" value="<?php echo (isset($themeCustomize[$key]) && isset($themeCustomize[$key]['link_color']) ? $themeCustomize[$key]['link_color'] : '');?>" name="themecustomize[<?php echo $key;?>][link_color]" size="8" data-text="hidden" data-hex="true" data-match-container="<?php echo $key;?> a" data-css-key="color"/>
							</div>
						</div>
						<div class="group-inputs">
							<label>Pattern</label>
							<div class="box-<?php echo ltrim($key,'#');?>-patterns boxs-patterns clearfix" data-match-container="<?php echo $key;?>" data-match-input="#themecustomize_<?php echo ltrim($key,'#');?>_pattern">	
								<?php foreach( $output as $pattern ) { ?>
								<div class="<?php echo $pattern;?>"></div>
								<?php } ?>
							</div>
							<input class="pattern" name="themecustomize[<?php echo $key;?>][pattern]" type="hidden" id="themecustomize_<?php echo ltrim($key,'#');?>_pattern" value="<?php echo (isset($themeCustomize[$key]) && isset($themeCustomize[$key]['pattern']) ? $themeCustomize[$key]['pattern'] : '');?>"/>
						</div>
					</div>
					<?php } ?>
					
				</div>
				<script>
					$(function() {
						$("#pav-accordion").accordion({ autoHeight: false, navigation: true });
					});
				</script>
				
				<div class="clearfix" style="margin-top:10px;"></div>
				<p>
					<button type="submit" name="btn-save" class="btn btn-small" value="Apply"/>Apply</button>
					<a href="<?php echo $this->url->link('common/home',"pavreset=?");?>" class="btn btn-small"><span>Reset</span></a>
				</p>
			</form>
		</div>
	</div>
</div>

<div class="pattern-top" data-match-container="header" data-value="">
	
</div>
<script type="text/javascript">
	var parentWindow = $( parent.document.body );  
	var pavtoken = parentWindow.find("#pavtoken").val();
	var token = "<?php echo $this->config->get('config_encryption');?>";
	if(typeof pavtoken == "undefined" || token != pavtoken){
		$('#pav-themecustomize').html('');
	}
	
	$("#pav-themecustomize .pn-action").click( function(){
		$(this).toggleClass("open");
		$("#pav-themecustomize").toggleClass('panel-open');
	} );
	
	//$().attr("data-match-container")
	
	$(document).ready(function () {
		 $(".customize-group").each( function(){
			var cgroup = this;
			
			$('input.pavcolor', this ).bind('change', function () { 
				var container = $(this).attr('data-match-container');
				var css_key = $(this).attr('data-css-key');
				$(container).css( css_key, $(this).val() );
			});
			
			$(".boxs-patterns > div", this).click( function(){
				var container = $(this).parent().attr('data-match-container');
				var input_container = $(this).parent().attr('data-match-input');
				$(input_container).val( $(this).attr('class') );
				$(".boxs-patterns > div", cgroup).removeClass('active');
				$(this).addClass('active');
				var _class = $( container ).attr('class')
				if( _class ) {
					_class = _class.replace(/pattern\d+/i,"");
				}
				$( container ).attr( "class", _class );
				$( container ).addClass(  $(this).attr("class") );
				
			} );
			$(".boxs-patterns > div", this).each(function(){
				var _class = $(this).attr('class');
				var input_container = $(this).parent().attr('data-match-input');
				if( _class == $(input_container).val() ){
					$(".boxs-patterns > div", cgroup).removeClass('active');
					$(this).addClass('active');
				}
			});
		} );

	});

</script>