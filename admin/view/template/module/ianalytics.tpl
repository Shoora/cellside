<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php echo (empty($data['iAnalytics']['LicensedOn'])) ? base64_decode('PGRpdiBjbGFzcz0iYWxlcnQgYWxlcnQtZXJyb3IiPjxpIGNsYXNzPSJpY29uLWV4Y2xhbWF0aW9uLXNpZ24iPjwvaT4gWW91IGFyZSBydW5uaW5nIGFuIHVubGljZW5zZWQgdmVyc2lvbiBvZiB0aGlzIG1vZHVsZSEgPGEgaHJlZj0iamF2YXNjcmlwdDp2b2lkKDApIiBvbmNsaWNrPSIkKCdhW2hyZWY9I3N1cHBvcnRdJykudHJpZ2dlcignY2xpY2snKSI+Q2xpY2sgaGVyZSB0byBlbnRlciB5b3VyIGxpY2Vuc2UgY29kZTwvYT4gdG8gZW5zdXJlIHByb3BlciBmdW5jdGlvbmluZywgYWNjZXNzIHRvIHN1cHBvcnQgYW5kIHVwZGF0ZXMuPC9kaXY+') : '' ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-error"><i class="icon-exclamation-sign"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
    <?php if (!empty($this->session->data['success'])) { ?>
    <div class="alert alert-success autoSlideUp"><i class="icon-ok-sign"></i> <?php echo $this->session->data['success']; ?></div>
    <script> $('.autoSlideUp').delay(3000).fadeOut(600, function(){ $(this).show().css({'visibility':'hidden'}); }).slideUp(600);</script>
    <?php $this->session->data['success'] = null; } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-bar-chart"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content fadeInOnLoad">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="tabbable">
		  <div class="tab-navigation">        
          <ul class="nav nav-tabs mainMenuTabs">
            <li class="active"><a href="#dashboard1" data-toggle="tab">Dashboard</a></li>
            <li><a href="#searches" data-toggle="tab">Searches</a></li>
            <li><a href="#products" data-toggle="tab">Products</a></li>
            <li><a href="#controlpanel" data-toggle="tab">Settings</a></li>
            <li><a href="#support" data-toggle="tab">Support</a></li>        
          </ul>
          <div class="tab-buttons">
          	<div class="btn-group">	
     		<a href="javascript:void(0)" class="btn dropdown-toggle"  data-toggle="dropdown"><i class="icon-tasks"></i>&nbsp;&nbsp;Data&nbsp; <span class="caret"></span></a> 
              <ul class="dropdown-menu">
              <?php if ((!empty($iAnalyticsStatus['status']) && $iAnalyticsStatus['status'] == 'run') || empty($iAnalyticsStatus)){ ?>
              <li><a href="javascript:void(0)" onclick="document.location='index.php?route=module/ianalytics/pausegatheringdata&token=<?php echo $_GET['token']; ?>'"><i class="icon-pause"></i>&nbsp;Pause Gathering Data</a></li>
              <?php } else { ?>
              <li><a href="javascript:void(0)" onclick="document.location='index.php?route=module/ianalytics/resumegatheringdata&token=<?php echo $_GET['token']; ?>'"><i class="icon-play"></i>&nbsp;Resume Gathering Data</a></li>
              <?php } ?>
              <li class="divider"></li>
              <li><a  onclick="return confirm('Are you sure you wish to delete all analytics data?');" href="index.php?route=module/ianalytics/deleteanalyticsdata&token=<?php echo $this->session->data['token']; ?>"><i class="icon-trash"></i> Clear All Analytics Data</a></li>
              </ul>
            </div>
            <button type="submit" class="btn btn-primary save-changes"><i class="icon-ok"></i> Save changes</button>
            
          </div>
          </div>
         <div class="tab-content">
			<div id="dashboard1" class="tab-pane active">
              <?php require_once(DIR_APPLICATION.'view/template/module/ianalytics/tab_dashboard.php'); ?>                        
            </div>
			<div id="searches" class="tab-pane">
              <?php require_once(DIR_APPLICATION.'view/template/module/ianalytics/tab_searches.php'); ?>                        
            </div>
			<div id="products" class="tab-pane">
              <?php require_once(DIR_APPLICATION.'view/template/module/ianalytics/tab_products.php'); ?>                        
            </div>
			<div id="controlpanel" class="tab-pane">
              <?php require_once(DIR_APPLICATION.'view/template/module/ianalytics/tab_controlpanel.php'); ?>                        
            </div>
			<div id="support" class="tab-pane">
              <?php require_once(DIR_APPLICATION.'view/template/module/ianalytics/tab_support.php'); ?>                        
            </div>
          </div><!-- /.tab-content -->
        </div><!-- /.tabbable -->
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
	var iAnalyticsMinDate = '<?=$this->data['iAnalyticsMinDate'];?>';
</script>

<script>
if (window.localStorage && window.localStorage['currentTab']) {
	$('.mainMenuTabs a[href='+window.localStorage['currentTab']+']').trigger('click');  
}

if (window.localStorage && window.localStorage['currentSubTab']) {
	$('a[href='+window.localStorage['currentSubTab']+']').trigger('click');  
}

$('.fadeInOnLoad').css('visibility','visible');

$('.mainMenuTabs a[data-toggle="tab"]').click(function() {
	if (window.localStorage) {
		window.localStorage['currentTab'] = $(this).attr('href');
	}
});

$('a[data-toggle="tab"]:not(.mainMenuTabs a[data-toggle="tab"])').click(function() {
	if (window.localStorage) {
		window.localStorage['currentSubTab'] = $(this).attr('href');
	}
});
</script>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../admin/view/javascript/ianalytics.js"></script>

<?php echo $footer; ?>