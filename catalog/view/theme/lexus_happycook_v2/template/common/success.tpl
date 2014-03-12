<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>

<div id="group-content">
<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-sm-<?php echo $SPAN[0];?> col-xs-12">
	<?php echo $column_left; ?>
</aside>
<?php endif; ?>

<section class="col-lg-<?php echo $SPAN[1];?> col-sm-<?php echo $SPAN[1];?> col-xs-12">
<div class="container">  
    <div id="content">
        <?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>    
        <?php echo $text_message; ?>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
</section> 


<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div>

<?php echo $footer; ?>
