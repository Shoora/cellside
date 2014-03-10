<?php  echo $header;  ?>
 <div id="content">
	  <div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	  </div>
	  <?php if ($error_warning) { ?>
	  <div class="warning"><?php echo $error_warning; ?></div>
	  <?php } ?>
		<div class="box">
			<div class="heading">
			  <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			
			</div>
			
			<div class="content">
				<div class="box-columns">
					
					<div class="column2">
						
						<div class="tool-icons clearfix" style="width:100%">
							<h4><?php echo $this->language->get('text_quickicons');?></h4>
							<ul>
																<li><a href="<?php echo $manage_category_link;?>"><span class="icon-category icon"></span><span><?php echo $this->language->get('databroad_categories')?></span></a></li>
								<li><a href="<?php echo $add_category_link;?>"><span class="icon-addcategory icon"></span><span><?php echo $this->language->get('databroad_add_category')?></span></a></li>
								<li><a href="<?php echo $manage_blog_link;?>"><span class="icon-blogs icon"></span><span><?php echo $this->language->get('databroad_blogs')?></span></a></li>
								<li><a href="<?php echo $add_blog_link;?>"><span class="icon-blog icon"></span><span><?php echo $this->language->get('databroad_add_blog')?></span></a></li>
								<li><a href="<?php echo $manage_comment_link;?>"><span class="icon-comment icon"></span><span><?php echo $this->language->get('databroad_comment')?></span></a></li>
								<li><a href="<?php echo $modules_setting_link;?>"><span class="icon-modules icon"></span><span><?php echo $this->language->get('databroad_modules_setting')?></span></a></li>
								<li><a href="<?php echo $frontend_modules_link;?>"><span class="icon-front-modules icon"></span><span><?php echo $this->language->get('menu_frontend_module_setting')?></span></a></li>
								
							</ul>
						</div>
						<div class="clearfix pav-toolbar" style="width:100%">
							<h4><?php echo $this->language->get('text_modules_setting');?></h4>
							<ul>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavblog/frontmodules','token='.$token.'#tab-module-pavblogcategory');?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_latest');?></span></a>
								</li>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavblog/frontmodules','token='.$token.'#tab-module-pavblogcomment');?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_comment');?></span></a>
								</li>
								<li>
									<a target="_blank" href="<?php echo $this->url->link('module/pavblog/frontmodules','token='.$token.'#tab-module-pavbloglatest');?>">
									<span class="icon-modules"></span><span><?php echo $this->language->get('module_category');?></span></a>
								</li>
							</ul>
							
							<div class="suggest-urls">
								<div>
									<h4><?php echo $this->language->get('text_modules_urls');?></h4>
									<ol>	
										<li>
											<div><b><?php echo $this->language->get('text_front_page');?></b></div>

											 <?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs";?><br>
											 <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG. $module_setting['keyword_listing_blogs_page']; ?>
										</li>

										<li>

											<div><b><?php echo $this->language->get('text_category_page'); ?></b></div>
										 
											<?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/category&id=";?>CATEGORY_ID <br>
											<?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG.'<b>Category - Keyword</b>';?>	
										</li>
										<li>
											<div><b><?php echo $this->language->get('text_item_page')?></b>: </div>
											<?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blog/id=";?>BLOG_ID<br>
											<?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG.'<b>Blog - Keyword</b>';?>	
										</li>
										
										<li>
											<div><b><?php echo $this->language->get('text_filter_blog');?></b></div>
											<?php echo $this->language->get('text_normal');?>: <?php echo HTTPS_CATALOG."index.php?route=pavblog/blogs&tag=";?><b>TAG_NAME</b><br>
											<?php echo $this->language->get('text_seo');?>: <?php echo $this->language->get('text_seo');?>: <?php echo HTTPS_CATALOG. $module_setting['keyword_listing_blogs_page']; ?>?tag=<b>TAG_NAME</b>
										</li>
									</ol>
								</div>
							</div>
							<div id="guide-links">
								<b><?php echo $this->language->get('text_guide_urls');?></b>: 
								<a href="http://www.pavothemes.com/guides/pavblog/#setup-seo"><?php echo $this->language->get('text_guide_seo');?></a> -
								<a href="http://www.pavothemes.com/guides/pavblog/#manage-category"><?php echo $this->language->get('text_guide_category');?></a> -
								<a href="http://www.pavothemes.com/guides/pavblog/#manage-blog"><?php echo $this->language->get('text_guide_blog');?></a> -
								<a href="http://www.pavothemes.com/guides/pavblog/#module-setting"><?php echo $this->language->get('text_guide_module_setting');?></a>
							</div>
						</div>
					</div>
					
					<div class="column2">
						
						<div  class="htabs">
							<a href="#panel-lastest"><?php echo $this->language->get('latest_blog');?></a>
							<a href="#panel-mostread"><?php echo $this->language->get('most_read');?></a>
							<a href="#panel-comments"><?php echo $this->language->get('latest_comment');?></a>	
						</div>
						<div id="panel-lastest">
							<ul>
							<?php foreach( $newest as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ul>
						</div>
						<div id="panel-mostread">
							<ul>
							<?php foreach( $mostread as $blog ) { ?>
								<li>
									<a href="<?php echo $this->url->link("module/pavblog/blog","id=".$blog['blog_id']."&token=".$token);?>"><?php echo $blog['title'];?></a>
								</li>
							<?php } ?>
							</ul>
						</div>
						<div id="panel-comments">
							<ul>
								<?php foreach( $comments as $comment ) { ?>
								<li><a href="<?php echo $this->url->link("module/pavblog/comment","id=".$comment['comment_id']."&token=".$token);?>"><?php echo utf8_substr($comment['comment'],0,100);?></a></li>
								<?php } ?>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>	
		
		
 </div>
 
 <script type="text/javascript">
	$('.htabs a').tabs();

	$("#guide-links a").click( function(){
	
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="'+$(this).attr('href')+'" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: 'Guide',
		close: function (event, ui) {},	
		bgiframe: false,
		width: 900,
		height: 550,
		resizable: false,
		modal: true
	});
		return false; 
	 });
 </script>
<?php echo $footer; ?>
