<div class="topBannerContainer">
	<div class="container">
		<div class="banner-title col-xs-5 col-sm-offset-4">Receive a free screen protector with a purchase of any phone case</div>
		<div class="clearfix"></div>
		<div class="banner-text col-xs-5 col-sm-offset-4">Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit.</div>
		<a href="/index.php?route=product/category&path=59" class="shopnowBtn">Shop Now <span class="fa fa-chevron-right"></span></a>
		<div class="close" onClick="hideBanner(this ,1);">Close <span class="fa fa-times"></span></div>
	</div>
</div>
<script>
	function createCookie(name, value, days) {
	    var expires;

	    if (days) {
	        var date = new Date();
	        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	        expires = "; expires=" + date.toGMTString();
	    } else {
	        expires = "";
	    }
	    document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/";
	}
	function hideBanner(el ,days) {
		$(el).parent().parent().remove();
		createCookie('hideTopBanner', 'true', days);
	}
</script>