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
  
<div id="content">
  <?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>
  <?php if ($profiles) { ?>

    <table class="list">
        <thead>
        <tr>
            <td class="left"><?php echo $column_profile_id; ?></td>
            <td class="left"><?php echo $column_created; ?></td>
            <td class="left"><?php echo $column_status; ?></td>
            <td class="left"><?php echo $column_product; ?></td>
            <td class="right"><?php echo $column_action; ?></td>
        </tr>
        </thead>
        <tbody>
        <?php if ($profiles) { ?>
        <?php foreach ($profiles as $profile) { ?>
        <tr>
            <td class="left">#<?php echo $profile['id']; ?></td>
            <td class="left"><?php echo $profile['created']; ?></td>
            <td class="left"><?php echo $status_types[$profile['status']]; ?></td>
            <td class="left"><?php echo $profile['name']; ?></td>
            <td class="right"><a href="<?php echo $profile['href']; ?>"><img src="catalog/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
            <td class="center" colspan="5"><?php echo $text_empty; ?></td>
        </tr>
        <?php } ?>
        </tbody>
    </table>

  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php } ?>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?>
</div>
</section>

<?php if( $SPAN[2] ): ?>
  <aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12"> 
    <?php echo $column_right; ?>
  </aside>
<?php endif; ?>
</div>

<?php echo $footer; ?>
