<div class="row-fluid">
  <div class="span4">
    <div class="box-heading">
      <h1><i class="icon-user"></i>Your License</h1>
    </div>
    <div class=""></div>
    <?php if (empty($data['iAnalytics']['LicensedOn'])): ?>
    <div class="licenseAlerts"></div>
    <div class="licenseDiv"></div>
    <table class="form notLicensedTable">
      <tr>
        <td colspan="2">
        <label>Please enter your product purchase license code <i class="icon-info-sign"></i></label>
			<input type="text" class="licenseCodeBox" placeholder="License Code e.g. XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX" style="width: 96%" name="Nitro[LicenseCode]" value="<?php echo !empty($data['iAnalytics']['LicenseCode']) ? $data['iAnalytics']['LicenseCode'] : ''?>" />
       		<button type="button" class="btn btn-large btnActivateLicense"><i class="icon-ok"></i> Activate License</button>
            &nbsp;&nbsp;<button type="button" class="btn btn-link" onclick="window.open('http://isenselabs.com/users/purchases/')" style="float:right; margin-top:7px;">Not having a code? Get it from here.</button>
        </td>
      </tr>
	</table>
    <?php 
		$hostname = (!empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : '' ;
		$hostname = (strstr($hostname,'http://') === false) ? 'http://'.$hostname: $hostname;
	?>
    <script type="text/javascript">
	var domain='<?php echo base64_encode($hostname); ?>';
	var domainraw='<?php echo $hostname; ?>';
	var timenow=<?php echo time(); ?>;
	var MID = 6931;
	</script>
    <script type="text/javascript" src="//isenselabs.com/external/validate/"></script>
    <?php endif; ?>
    <?php if (!empty($data['iAnalytics']['LicensedOn'])): ?>
    <input name="cHRpbWl6YXRpb24ef4fe" type="hidden" value="<?php echo base64_encode(json_encode($data['iAnalytics']['License'])); ?>" />
    <input name="OaXRyb1BhY2sgLSBDb21" type="hidden" value="<?php echo $data['iAnalytics']['LicensedOn']; ?>" />
    <table class="form licensedTable">
      <tr>
        <td>
			License Holder
        </td>
        <td>
			<?php echo $data['iAnalytics']['License']['customerName']; ?>
        </td>
      </tr>
      <tr>
        <td>
			Registered domains
        </td>
        <td>
        	<ul class="registeredDomains">
			<?php foreach ($data['iAnalytics']['License']['licenseDomainsUsed'] as $domain): ?>
            	<li><i class="icon-ok"></i> <?php echo $domain; ?></li>
            <?php endforeach; ?>
            </ul>
        </td>
      </tr>
      <tr>
        <td>
			License Expires on
        </td>
        <td>
			<?php echo date("F j, Y",strtotime($data['iAnalytics']['License']['licenseExpireDate'])); ?>
        </td>
      </tr>
      <tr>
      	<td colspan="2" style="text-align:center;background-color:#EAF7D9;">VALID LICENSE (<a href="http://isenselabs.com/users/purchases" target="_blank">manage</a>)</td>
      </tr>
	</table>
    <?php endif; ?>
  </div>
  <div class="span8">
    <div class="box-heading">
      <h1>Get Support</h1>
    </div>
    <div class="box-content">
    <div class="row-fluid">
        <ul class="thumbnails supportThumbs">
          <li class="span4">
            <div class="thumbnail">
              <img data-src="holder.js/300x200" alt="Community support" style="width: 300px;" src="view/image/ianalytics/community.png">
              <div class="caption" style="text-align:center;padding-top:0px;">
                <h3>Community</h3>
                <p>Ask the community about your issue on the iSenseLabs forum. </p>
                <p style="padding-top: 5px;"><a href="http://isenselabs.com/forum" target="_blank" class="btn btn-large">Browse forums</a></p>
              </div>
            </div>
          </li>
          <li class="span4">
            <div class="thumbnail">
              <img data-src="holder.js/300x200" alt="Ticket support" style="width: 300px;" src="view/image/ianalytics/tickets.png">
              <div class="caption" style="text-align:center;padding-top:0px;">
                <h3>Tickets</h3>
                <p>Want to comminicate one-to-one with our tech people? Then open a support ticket.</p>
                <p style="padding-top: 5px;"><a href="http://isenselabs.com/tickets/open/<?php echo base64_encode('Support Request').'/'.base64_encode('31').'/'. base64_encode($_SERVER['SERVER_NAME']); ?>" target="_blank" class="btn btn-large">Open a support ticket</a></p>
              </div>
            </div>
          </li>
          <li class="span4">
            <div class="thumbnail">
              <img data-src="holder.js/300x200" alt="Pre-sale support" style="width: 300px;" src="view/image/ianalytics/pre-sale.png">
              <div class="caption" style="text-align:center;padding-top:0px;">
                <h3>Pre-sale</h3>
                <p>Have a brilliant idea for your webstore? Our team of top-notch developers can make it real.</p>
                <p style="padding-top: 5px;"><a href="mailto:sales@isenselabs.com?subject=Pre-sale question" target="_blank" class="btn btn-large">Bump the sales</a></p>
              </div>
            </div>
          </li>
        </ul>
      </div>
	</div>



  </div>
</div>

<script type="text/javascript">
/*
var validationURL = 'index.php?route=tool/nitro/performvalidation&token=<?php echo $_GET['token']; ?>';
$('.btnActivateLicense').click(function() {
	$.post(validationURL, { 'l' : $('.licenseCodeBox').val() }, function(data,stat) {
		$('.licenseAlerts').html(data);
	});
});
*/
</script>