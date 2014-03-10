<?php echo $header; ?>
<section id="content-section" class="unlocking-page">
	<div id="sub-menu-u">
		<h2>UNLOCK 100% GUARANTEED</h2>
		<div class="container">
			<div class="row sub-menu-container">
				<div class="col-md-3 col-sm-3 col-xs-12 text-center"><a class="submenu-btn col-xs-12" href="#">How to Unlock?</a></div>
				<div class="col-md-3 col-sm-3 col-xs-12 text-center"><a class="submenu-btn col-xs-12" href="#">FAQ's</a></div>
				<div class="col-md-3 col-sm-3 col-xs-12 text-center"><a class="submenu-btn col-xs-12" href="#">Support</a></div>
				<div class="col-md-3 col-sm-3 col-xs-12 text-center"><a class="submenu-btn col-xs-12" href="#">Unlocking Specials</a></div>
			</div>
		</div>
	</div>
	<div class="phones">
		<div class="container">
			<div class="row sponsors-container">
				<div class="col-md-4 col-sm-4 col-xs-12"><a href="#"><img class="sp" src="catalog/view/theme/<?php echo $themeName;?>/image/phones.png" alt=""></a></div>
				<div class="col-md-8 col-sm-8 hidden-xs">
					<div class="row">
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/t-mobile.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/allet.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/cricket.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/at.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/boost.png" alt=""></a>
					</div>
					<div class="row">
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/virgin.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/h2o.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/verizon.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/net10.png" alt=""></a>
						<a href="#"><img src="catalog/view/theme/<?php echo $themeName;?>/image/sponsors/simple-mobile.png" alt=""></a>
					</div>
				</div>
			</div>
	</div>
	</div>
	<div id="unlock-feed">
		<div class="left col-md-3"><span>Unlock</span> Feed</div>
		<div class="content col-md-9">
			<span class="white-triangle hidden-sm hidden-xs"></span>
			<div class="row">
				<div class="col-md-2">
					<div class="name">John Doe</div>
					<div class="message">just received an unlock code for a 9330 Curve.</div>
					<div class="time"><span class="fa fa-clock-o"></span> 1 hr 18 mins ago</div>      
				</div>
				<div class="col-md-2">
					<div class="name">John Doe</div>
					<div class="message">just received an unlock code for a 9330 Curve.</div>
					<div class="time"><span class="fa fa-clock-o"></span> 1 hr 18 mins ago</div>      
				</div>
				<div class="col-md-2">
					<div class="name">John Doe</div>
					<div class="message">just received an unlock code for a 9330 Curve.</div>
					<div class="time"><span class="fa fa-clock-o"></span> 1 hr 18 mins ago</div>      
				</div>
				<div class="col-md-2">
					<div class="name">John Doe</div>
					<div class="message">just received an unlock code for a 9330 Curve.</div>
					<div class="time"><span class="fa fa-clock-o"></span> 1 hr 18 mins ago</div>      
				</div>
				<div class="col-md-2">
					<div class="name">John Doe</div>
					<div class="message">just received an unlock code for a 9330 Curve.</div>
					<div class="time"><span class="fa fa-clock-o"></span> 1 hr 18 mins ago</div>      
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>
</section>
<section id="unlock">
	<img src="catalog/view/theme/<?php echo $themeName;?>/image/unlock-form.png" alt="">
	<p class="start-now"><button class="my-btn red" onClick="scrollToElement($('#row'),0);">Start Now</button></p>
	<form action="#">
		<div class="container">
			<div class="row" id="row">
				<div class="col-xs-12 col-sm-6 col-md-3">
					<p>Select Brand</p>
					<select name="brand">
						<option value="iPhone">iPhone</option>
						<option value="Samsung">Samsung</option>
					</select>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-3">
					<p>Type Phone Model</p>
					<input type="text">
				</div>
				<div class="col-xs-12 col-sm-6 col-md-3">
					<p>Select Country</p>
					<select name="brand">
						<option value="Canada">Canada</option>
						<option value="Canada">Canada</option>
					</select>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-3">
					<p>Select Carrier</p>
					<select name="brand">
						<option value="At&t">At&t</option>
						<option value="At&t">At&t</option>
					</select>
				</div>
			</div>
		</div>
		<input type="submit" class="my-btn green unlock-now" value="Unlock Now">
	</form>
</section>
<div class="clearfix"></div>
<?php echo $footer; ?>