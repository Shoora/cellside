<?php echo $header; ?>
<section id="about">
	<div class="about-top">
		<div class="container">
			<h2 class="top-title"><?php echo $top_title; ?></h2>
			<p class="top-description"><?php echo $top_description; ?></p>
			<div class="navigateButtons text-center">
				<a href="#learn"><?php echo $learn_button; ?></a>
				<a href="#contact"><?php echo $contact_button; ?></a>
				<a href="#location"><?php echo $location_button; ?></a>
			</div>
			<div class="about-banner text-center">
				<a href="index.php?route=common/home"><img src="catalog/view/theme/<?php echo $themeName;?>/image/about_banner.png" alt=""></a>
			</div>
		</div>
	</div>
	<div id="learn">
		<?php 
			$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
			$modules = $helper->getModulesByPosition( 'content_bottom' );
		?>
		<h1 class="learn-title text-center"><?php echo $learn_title; ?></h1>
		<div class="container">
			<p class="about-description"><?php echo $learn_description; ?></p>
			<div class="col-xs-12 col-sm-12 col-md-5 col-lg-5 text-right"><?php echo $modules[0]; ?></div>
			<div class="hidden-xs hidden-sm col-md-1 col-lg-1 text-center"><img src="catalog/view/theme/<?php echo $themeName;?>/image/separator.png" class="sep" alt=""></div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 text-left"><?php echo $modules[1]; ?></div>
			<div class="clearfix"></div>


			<h2 class="others-title text-center"><?php echo $others_title; ?></h2>
			<div class="others-say-block">
				<img src="/catalog/view/theme/lexus_happycook_v2/image/os.png" alt="" style="width: 100%;">
			</div>
		</div>
	</div>
	<div id="contact">
		<div class="container">
			<h2 class="contact-title text-center"><?php echo $contact_title; ?></h2>
			<div class="contact-description"><?php echo $contact_description; ?></div>
			<div class="contact-section row text-center">
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 icons">
					<div class="contact-icon addr"></div>
					<p>Adress: Street 123, Canada</p>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 icons">
					<div class="contact-icon phone"></div>
					<p>Phone: 123 45 67890</p>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 icons">
					<div class="contact-icon fax"></div>
					<p>Fax: 123 45 67890</p>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12 icons">
					<div class="contact-icon email"></div>
					<p>Email: info@cellside.ca</p>
				</div>
			</div>
			<div id="contactForm">
				<form action="#">
					<div class="col-md-4">
						<input class="firstname" type="text" name="firstname" placeholder="Name" required="">
						<input class="email" type="email" name="email" placeholder="E-mail" required="">
					</div>
					<div class="col-md-6">
						<textarea class="comment" name="comment" cols="30" rows="3" placeholder="Message"></textarea>
					</div>
					<div class="col-md-2">
						<button>
							<p>Send</p>
							<span class="plane-icon"></span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div id="location">
		<img src="/catalog/view/theme/lexus_happycook_v2/image/map.png" alt="" style="width: 100%;">
	</div>
</section>
<?php echo $footer; ?>
<script>
	$(document).ready(function() {
		scrollToElement($(window.location.hash), 30);
	});
</script>