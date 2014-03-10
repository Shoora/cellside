<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>

  	<div class="pav-header">
		<h1><?php echo $heading_title; ?></h1>
		<a class="rss-wrapper" href="<?php echo $latest_rss;?>"><span class="icon-rss">Rss</span></a>	
	</div>  
  
  <div class="pav-filter-blogs">

		<div class="pav-blogs">
			<?php
			$cols = $config->get('cat_columns_leading_blogs');
			if( count($leading_blogs) ) { ?>
				<div class="leading-blogs clearfix">
					<?php foreach( $leading_blogs as $key => $blog ) { $key = $key + 1;?>
					<div class="pavcol<?php echo $cols;?>">
					<?php require( '_item.tpl' ); ?>
					</div>
					<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
						<div class="clearfix"></div>
					<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>

			<?php
				$cols = $config->get('cat_columns_secondary_blogs');
				$cols = !empty($cols)?$cols:1;
				if ( count($secondary_blogs) ) { ?>
				<div class="secondary clearfix">
					
					<?php foreach( $secondary_blogs as $key => $blog ) {  $key = $key+1; ?>
					<div class="pavcol<?php echo $cols;?>">
					<?php require( '_item.tpl' ); ?>
					</div>
					<?php if( ( $key%$cols==0 || $cols == count($leading_blogs)) ){ ?>
						<div class="clearfix"></div>
					<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>
				
			<div class="pav-pagination pagination"><?php echo $pagination;?></div>
		</div>
  </div>
 

  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>