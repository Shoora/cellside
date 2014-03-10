<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
<meta charset="UTF-8" />
<title>Live Customizing Theme</title>
<style type="text/css">

</style>
<link href="<?php echo $siteURL; ?>catalog/view/theme/<?php echo $themeName;?>/stylesheet/bootstrap.css" rel="stylesheet" />
<link href="<?php echo $adminURL; ?>view/stylesheet/customizetheme.css" rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="<?php echo $siteURL; ?>catalog/view/theme/<?php echo $themeName;?>/stylesheet/font-awesome.min.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $siteURL; ?>catalog/view/javascript/jquery/colorpicker/css/colorpicker.css" />

<script type="text/javascript" src="<?php echo $siteURL; ?>catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
 	
<script type="text/javascript" src="<?php echo $siteURL; ?>catalog/view/javascript/jquery/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo $siteURL; ?>catalog/view/javascript/jquery/colorpicker/js/colorpicker.js"></script>





<!--[if lt IE 9]>
<script src="catalog/view/javascript/html5.js"></script>
<![endif]-->

</head>

<body>
<div class="page-wrapper" id="content">
<form  enctype="multipart/form-data" action="<?php echo $action; ?>" id="form" method="post">
	<div class="pav-customize" id="pav-customize">
		<div class="btn-show"><?php echo $this->language->get('text_customize');?> <span class="icon-wrench"></span></div>

		<div class="wrapper">	
			<div id="customize-form">
		<p><span class="badge"><?php echo $this->language->get('text_theme');?>: <?php echo $themeName; ?></span>   <a  href="<?php echo $back_url;?>" class="label label-default pull-right"><?php echo $this->language->get('text_back');?></a> </p>	 	

		<div class="buttons-group">
			<input type="hidden" name="action-mode" id="action-mode" >	
			<a type="submit" href="#" class="btn btn-primary btn-xs" onclick="$('#action-mode').val('save-edit');$('#form').submit();"><?php echo $this->language->get('text_submit');?></a>
			<a type="submit" href="#" class="btn btn-danger btn-xs" onclick="$('#action-mode').val('save-delete');$('#form').submit();"><?php echo $this->language->get('text_delete');?></a>
		</div>

<hr>
					<div class="groups">

							<div class="form-group pull-left">
								<label><?php echo $this->language->get('text_css_profiles'); ?></label>	
								<select name="saved_file" id="saved-files">
									<option value=""> ------------- </option>
									<?php foreach( $files as $file ){ $file = str_replace( ".css","", $file); ?>
										<option value="<?php echo $file;?>"><?php echo $file; ?></option>
									<?php } ?>
								</select> 
							</div>

							<div class="form-group ">
								<label class="show-for-notexisted"><?php echo $this->language->get('text_named_this'); ?></label>
								<label class="show-for-existed"><?php echo $this->language->get('text_rename_this'); ?></label>
								<input type="text" name="newfile" />
								
							</div>	

					</div>

					
				<div class="clearfix" id="customize-body">
				<ul class="nav nav-tabs" id="myTab">
				<?php foreach( $xmlselectors as $for => $output ) { ?>
		          <li><a href="#tab-<?php echo $for ?>"><?php echo $this->language->get( 'text_'.$for );?></a></li>
		
		          <?php } ?>
		        </ul>
		        <div class="tab-content" > 
		             	<?php foreach( $xmlselectors as $for => $output ) { ?>
		            	<div class="tab-pane" id="tab-<?php echo $for; ?>">

		            	<?php if( !empty( $output ) ){?>
		            	<div class="accordion"  id="custom-accordion<?php echo $for; ?>">
		            	<?php $i=0; foreach ( $output as $group ) { ?>
		            	   <div class="accordion-group">
		                            <div class="accordion-heading">
		                              <a class="accordion-toggle" data-toggle="collapse" data-parent="#custom-accordion<?php echo $for; ?>" href="#collapse<?php echo $group['match'];?>">
		                               		<?php echo $group['header']; ?>	 
		                              </a>
		                            </div>

		                            <div id="collapse<?php echo $group['match'];?>" class="accordion-body collapse <?php if( $i++ ==0) { ?> in <?php } ?>">
		                              <div class="accordion-inner clearfix">
		                              	<?php foreach ($group['selector'] as $item ) { ?>
										 <?php  if (isset($item['type'])&&$item['type']=="image") { ?>
										  <div class="form-group background-images"> 
												<label><?php echo $item['label']?></label>
												<a class="clear-bg label label-success" href="#">Clear</a>
												<input value="" type="hidden" name="customize[<?php echo $group['match'];?>][]" data-match="<?php echo $group['match'];?>" type="text" class="input-setting" data-selector="<?php echo $item['selector']?>" data-attrs="background-image">

												<div class="clearfix"></div>
												 <p><em style="font-size:10px">Those Images in folder YOURTHEME/img/patterns/</em></p>
												<div class="bi-wrapper clearfix">
												<?php foreach ( $patterns as $pattern ){ ?>
												<div style="background:url('<?php echo $backgroundImageURL.$pattern;?>') no-repeat center center;" class="pull-left" data-image="<?php echo $backgroundImageURL.$pattern;?>" data-val="../../image/pattern/<?php echo $pattern; ?>">

												</div>
												<?php } ?>
		                                    </div>
		                                  </div>
		                                  <?php } elseif( $item['type'] == "fontsize" ) { ?>
		                                   <div class="form-group">
		                                   <label><?php echo $item['label']?></label>
		                                  	<select name="customize[<?php echo $group['match'];?>][]" data-match="<?php echo $group['match']?>" type="text" class="input-setting" data-selector="<?php echo $item['selector']?>" data-attrs="<?php echo $item['attrs']?>">
												<option value="">Inherit</option>
												<?php for( $i=9; $i<=16; $i++ ) { ?>
												<option value="<?php echo $i; ?>"><?php echo $i; ?></option>
												<?php } ?>
											</select>	<a href="#" class="clear-bg label label-success">Clear</a>
		                                  </div>
		                                  <?php } else { ?>
		                                  <div class="form-group">
											<label><?php echo $item['label']?></label>
											<input value="" size="10" name="customize[<?php echo $group['match']?>][]" data-match="<?php echo $group['match']?>" type="text" class="input-setting" data-selector="<?php echo $item['selector']?>" data-attrs="<?php echo $item['attrs']?>"><a href="#" class="clear-bg label label-success">Clear</a>
										  </div>
		                                  <?php } ?>


										<?php } ?>
		                              </div>
		                            </div>
		                    </div>          	
		            		<?php } ?>
		           		 </div>
		            	<?php } ?>
		            </div>
		            <?php } /* endforeach  */?>
		        </div>    	
		    </div>    

			 
			</div>
	 	</div>
</div>	
 
 
</form>

<div id="main-preview">
	<iframe src="<?php echo $store;?>index.php?pavtoken=<?php echo $this->config->get('config_encryption');?>" ></iframe> 
</div>

</div>

<script type="text/javascript">
$("#custom-accordion .accordion-group:first .accordion-body").addClass('in');

/**
 * BACKGROUND-IMAGE SELECTION
 */
$(".background-images").each( function(){
	var $parent = this;
	var $input  = $(".input-setting", $parent ); 



	$(".bi-wrapper > div",this).click( function(){

		 $input.val( $(this).data('val') ); 
		 $('.bi-wrapper > div', $parent).removeClass('active');
		 $(this).addClass('active');

		 if( $input.data('selector') ){  
			$($input.data('selector'),$("#main-preview iframe").contents()).css( $input.data('attrs'),'url('+ $(this).data('image') +')' );
		 }
	} );
} ); 

$(".clear-bg").click( function(){

	var $parent = $(this).parent();
	var $input  = $(".input-setting", $parent ); 
	
	if( $input.val('') ) {
		if( $parent.hasClass("background-images") ) {
			$('.bi-wrapper > div',$parent).removeClass('active');	
			$($input.data('selector'),$("#main-preview iframe").contents()).css( $input.data('attrs'),'none' );
		}else {
			$input.attr( 'style','' )	
		}
		$($input.data('selector'),$("#main-preview iframe").contents()).css( $input.data('attrs'),'inherit' );

	}	
	$input.val('');

} );
	
/**
 *  FORM SUBMIT
 */
 $( "#form" ).submit( function(){ 
	$('.input-setting').each( function(){
		if( $(this).data("match") ) {
			var val = $(this).data('selector')+"|"+$(this).data('attrs');
			$(this).parent().append('<input type="hidden" name="customize_match['+$(this).data("match")+'][]" value="'+val+'"/>');
		}	 
	} );
	return true; 
} );
$("#main-preview iframe").ready(function(){  
	 $('.accordion-group input.input-setting').each( function(){
	 	 var input = this;
	 	 $(input).attr('readonly','readonly');
	 	 $(input).ColorPicker({
	 	 	onChange:function (hsb, hex, rgb) {
	 	 		$(input).css('backgroundColor', '#' + hex);
	 	 		$(input).val( hex );
	 	 		if( $(input).data('selector') ){   
					$("#main-preview iframe").contents().find($(input).data('selector')).css( $(input).data('attrs'),"#"+$(input).val() )
				}
	 	 	}
	 	 });
 	} );
	 $('.accordion-group select.input-setting').change( function(){
		var input = this; 
			if( $(input).data('selector') ){  
			var ex = $(input).data('attrs')=='font-size'?'px':"";	
			$("#main-preview iframe").contents().find($(input).data('selector')).css( $(input).data('attrs'), $(input).val() + ex);
		}
	 } );
})
 
$('#myTab a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
	
$('#myTab a:first').tab('show'); 

 $('#myCollapsible').collapse({
  toggle: false
})

$("#pav-customize .btn-show").click( function(){

	$("body").toggleClass("off-customize");
} );
 
$(".show-for-existed").hide();
$("#saved-files").change( function() {

	if( $(this).val() ){  
		$(".show-for-notexisted").hide();
		$(".show-for-existed").show();
	}else {
		$(".show-for-notexisted").show();
		$(".show-for-existed").hide();
	}

	var url  = '<?php echo $customizeFolderURL; ?>'+$(this).val()+".json?rand"+Math.random();

	$.getJSON( url, function(data) {
		var items = data;
			if( items ){
				$('#customize-body .accordion-group').each( function(){
					var i = 0;
					$("input, select", this).each( function(){
						if( $(this).data('match') ){ 
							if( items[$(this).data('match')] && items[$(this).data('match')][i] ){ 
								var el = items[$(this).data('match')][i];
							 	$(this).val( el.val );
							 	if( el.val== '') {
							 		$(this).css('background',"inherit");
							 	}
							 	else { 
							 		$(this).css('background',"#"+el.val);
							 	}
							 	$(this).ColorPickerSetColor(el.val );
							}
							i++;
						}
					} );
					 
				});
			}
		});

	$("#main-preview iframe").contents().find("#customize-theme").remove();
	if( $(this).val() ){
		var _link = $('<link rel="stylesheet" href="" id="customize-theme">');
		_link.attr('href', '<?php echo $customizeFolderURL?>'+$(this).val()+".css?rand="+Math.random() );
		$("#main-preview iframe").contents().find("head").append( _link );
	}
});
</script>
</body>





</html>

