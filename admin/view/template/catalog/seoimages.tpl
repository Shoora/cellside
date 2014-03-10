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
                <td class="left"><b>SEO Images Generator</b></td>
                <td class="left"><span class="help">SEO Images Generator automatically generates product's image names from relevant words in product(%p) names.<br><br>
				<b>Parameters</b><br>
				You can add keywords from product's model(%m), sku(%s), upc(%u) or brand(%b).<br>
				Available Parameters: %p, %c, %m, %s and %u. Use them withat spaces or any other characters.<br>
				<b>Example: %p%c%m%u</b> - will generate seo image names from product name, category name, model and product's upc.<br>				
				<i>Before generating seo image names, if you have modified parameters, don't forget to save them using Save Parameters button.</i>	 </span>
				<br>
					<span style="color:red">A database and image folder <b>backup is recommended</b> before generating image seo names!</span></td>
                <td class="left"><input type="text" name="seoimageparameters[keywords]" value="<?php echo $seoimageparameters['keywords'];?>" size="10"/></td>
                <td class="right">
					<?php if (file_exists(DIR_APPLICATION.'rename_files.php')) { ?>
					<a onclick="location = 'rename_files.php'" class="button">Generate</a>
					<?php } else { ?>
					<a onclick="alert('SEO Images Generator is not installed!\nYou can purchase SEO Images Generator from\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=5084\nor you can purchase the whole Opencart SEO Pack:\n http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4653');" class="button" style="background:lightgrey">Generate</a>
					<?php } ?>
				</td>
              </tr>
            </tbody>
			
            
          </table>
	</form>
	</div>
   </div>
</div>
<?php echo $footer; ?>