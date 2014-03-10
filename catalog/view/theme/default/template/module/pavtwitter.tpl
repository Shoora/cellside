<?php $id = rand(); ?>

<?php ?>
<div class="box">
  
  <div class="box-heading"><?php echo $heading_title;?></div>
    <div class="box-content">
		<div id="pav-twitter<?php echo $id;?>" id="pav-twitter">
<a class="twitter-timeline" data-dnt="true" data-theme="<?php echo $theme; ?>" data-link-color="#<?php echo $link_color;?>" width="<?php echo $width; ?>" height="<?php echo $height; ?>" data-chrome="<?php echo $chrome; ?>" data-border-color="#<?php echo $border_color ?>" lang="EN" data-tweet-limit="<?php echo $count; ?>" data-show-replies="<?php echo $show_replies==1?'true':'false'; ?>" href="https://twitter.com/<?php echo $username; ?>"  data-widget-id="<?php echo $widget_id; ?>">Tweets by @<?php echo $username;?></a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

		</div>
  </div>
  
</div>

