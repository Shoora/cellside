<?php echo $header; ?>
<script type="text/javascript">
				function clearseo(data, link){						
					if (!confirm('Are you sure you want to delete ALL ' + data + '?\n\nA database backup is recommended! \n\nThis action will delete ALL ' + data + '!!!')) 
						{
							return false;
						}
						else 
						{
							location = link;
						}
						
					}
				</script>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
	<div class="buttons"><a onclick="$('#form').submit();" class="button">Save Parameters</a></div>
	</div>
    <div class="content">
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		   <table class="list">
            <thead>
              <tr>
                <td class="left" width="200">Extension</td>
				<td class="left">About</td>
				<td class="left" width="50">Parameters</td>
				<td class="right" width="100">Action</td>
              </tr>
            </thead>
            
			<tbody>
              <tr>
                <td class="left"><b>Keywords Generator</b></td>
                <td class="left"><span class="help">Keywords Generator generates meta keywords from relevant words from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				You can add keywords from product's model(%m), sku(%s), upc(%u) or brand(%b).<br>
				Available parameters: %p, %c, %m, %s and %u. Use them withat spaces or any other characters.<br>
				<b>Example: %p%c%m%u</b> - will generate keywords from product name, category name, model and product's upc.<br>				
				<i>Before generating keywords, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	 </span></td>
                <td class="left"><input type="text" name="parameters[keywords]" value="<?php echo $parameters['keywords'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'keywords_generator.php')) { ?>
					<a onclick="location = 'keywords_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Keywords Generator is not installed!\nYou can purchase Keywords Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4281\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
            </tbody>
			
			<tbody>
              <tr>
                <td class="left"><b>Meta Description Generator</b></td>
                <td class="left"><span class="help"> Meta Description Generator generates meta description for products using a pattern which is set in Parameters.<br>
				The default pattern is '%p - %f' which means product's name, followed by ' - ', followed by the first sentence from product's description.<br>
				<b>Parameters</b><br>
				The are available the following parameters and they will be replaced by their actual value: <b>%p</b> - product's name, <b>%c</b> - category's name, <b>%m</b> - model, <b>%s</b> - product's sku, <b>%u</b> - product's upc, <b>%b</b> - product's brand, <b>%$</b> - product's price and <b>%f</b> - the first sentence from product's description.<br>
				<b>Example: %p (%m) - %f (by www.mysite.com)</b> - will generate the following meta description for a product called 'iPod' with model = 'iPod4': <b>iPod (iPod4) - The first sentence from iPod's description. (by www.mysite.com)</b>.<br>				
				<i>Before generating meta descriptions, if you have modified parameters, don't forget to save them using Save Parameters button.</i>
				</span></td>
                <td class="left"><input type="text" name="parameters[metas]" value="<?php echo $parameters['metas'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'meta_description_generator.php')) { ?>
					<a onclick="location = 'meta_description_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Meta Description Generator is not installed!\nYou can purchase Meta Description Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4283\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>				
              </tr>
            </tbody>
			
			<tbody>
              <tr>
                <td class="left"><b>Tags Generator</b></td>
                <td class="left"><span class="help">Tag Generator generates product tags from relevant keywords from product(%p) and category(%c) names.<br><br>
				<b>Parameters</b><br>
				You can add tags from product's model(%m), sku(%s) upc(%u) or brand(%b).<br>
				Available parameters: %p, %c, %m, %s and %u. Use them withat spaces or any other characters.<br>
				<b>Example: %p%c%m</b> - will generate tags from product name, category name and model.<br>				
				<i>Before generating tags, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	
				</span></td>
                <td class="left"><input type="text" name="parameters[tags]" value="<?php echo $parameters['tags'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'tag_generator.php')) { ?>
					<a onclick="location = 'tag_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Tags Generator is not installed!\nYou can purchase Tags Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4165\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
            </tbody>
			
			<tbody>
              <tr>
                <td class="left"><b>Related Products Generator</b></td>
                <td class="left"><span class="help"> Related Products Generator, based on a complex algorithm, is a powerful tool which generates up to 5 related product for each product.<br><br>
				<b>Parameters</b><br>
				You can change the default number (5) of related products in parameters field for Related Products Generator. <br>
				<i>Before generating related products, if you have modified parameters, don't forget to save them using Save Parameters button.</i>				
				</span></td>
				<td class="left"><input type="text" name="parameters[related]" value="<?php echo $parameters['related'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'rp_generator.php')) { ?>
					<a onclick="location = 'rp_generator.php?token=<?php echo $this->session->data['token']; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('Related Products Generator is not installed!\nYou can purchase Related Products Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4593\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
            </tbody>
			
			<tbody>
              <tr>
                <td class="left"><b>SEO Urls Generator</b></td>
                <td class="left"><span class="help"> SEO URLS Generator generates SEO URLS for products, categories, manufacturers and information. 
				<b>Parameters</b><br>
				You can change the default extension (.html) of generated urls. <br>
				<i>Before generating SEO URLs, if you have modified parameters, don't forget to save them using Save Parameters button.</i></span></td>
				<td class="left"><input type="text" name="parameters[ext]" value="<?php if (isset($parameters['ext'])) {echo $parameters['ext'];} ?>" size="10"/></td>
                <td class="right">
					<?php if ($seourls) { ?>
					<a onclick="location = '<?php echo $seourls; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('SEO Urls Generator is not installed!\nYou can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
            </tbody>
            
			<tbody>
              <tr>
                <td class="left"><b>SEO Friendly Urls Generator</b></td>
                <td class="left"><span class="help"> SEO Friendly URLs Generator transforms non-SEO friendly links like:<br>
				<i>yoursite.com/index.php?route=account/login</i><br>
				into SEO friendly links:<br>
				<i>yoursite.com/login</i></span></td>
                <td class="right" colspan="2">
					<?php if ($friendlyurls) { ?>
					<a onclick="location = '<?php echo $friendlyurls; ?>'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('SEO Friendly Urls Generator is not installed!\nYou can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>					
				</td>
              </tr>
            </tbody>
            
            <tbody>
              <tr>
                <td class="left"><b>Clear SEO</b></td>
                <td class="left">
					<span class="help"> With Clear SEO you can easily delete ALL:<br><br>
					- product tags<br>
					- meta descriptions<br>
					- meta keywords<br>
					- seo urls<br>
					- related products<br>
					<br>
					<span style="color:red">A database backup is recommended before using Clear SEO, because you may lose SEO data!</span><br>
					</span></td>
                <td class="right" colspan="2">
					<p><a onclick="clearseo('Products Keywords', '<?php echo $clearkeywords; ?>');" class="button" style="background:red">Clear Keywords</a></p>
					<p><a onclick="clearseo('Products Meta Descriptions', '<?php echo $clearmetas; ?>');" class="button" style="background:red">Clear Meta Description</a></p>
					<p><a onclick="clearseo('Products Tags', '<?php echo $cleartags; ?>');" class="button" style="background:red">Clear Tags</a></p>
					<p><a onclick="clearseo('SEO Urls', '<?php echo $clearurls; ?>');" class="button" style="background:red">Clear SEO Urls</a></p>
					<p><a onclick="clearseo('Related Products', '<?php echo $clearproducts; ?>');" class="button" style="background:red">Clear Related Products</a>
				</td>
              </tr>
            </tbody>
            
            
          </table>
	</form>
	</div>
   </div>
</div>
<?php echo $footer; ?>