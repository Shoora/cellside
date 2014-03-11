<?php echo $header; ?>
<div id="content" class="login">
	<div id="logo">
		<a href="./">
			<img src="view/image/admin_theme/base5builder_circloid/logo-default.png" alt="Logo" >
		</a>
	</div>
	<form class="form-signin" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
		<div class="form-signin-heading">
			<div class="login-header-image">
				<img src="view/image/admin_theme/base5builder_circloid/icon-login.png" alt="Login" width="32" height="32" />
			</div>
			<h2><?php echo $text_login; ?></h2>
			<div class="clearfix"></div>
		</div>
		<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
		<?php } ?>
		<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
		<?php } ?>
		<div class="form-signin-body clearfix">
			<div class="form-signin-fields">
				<div class="form-item">
					<label for="username"><?php echo $entry_username; ?></label>
					<input type="text" name="username" id="username" class="input-block-level" placeholder="<?php echo substr($entry_username, 0, -1); ?>" value="<?php echo $username; ?>">
					<div class="clearfix"></div>
				</div>
				<div class="form-item">
					<label for="password"><?php echo $entry_password; ?></label>
					<input type="password" id="password" name="password" class="input-block-level" placeholder="<?php echo substr($entry_password, 0, -1); ?>" value="<?php echo $password; ?>">
					<div class="clearfix"></div>
				</div>
				<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
				<?php if ($redirect) { ?>
				<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
				<?php } ?>
			</div>
			<div class="form-signin-buttons">
				<input class="btn btn-success" value="<?php echo $button_login; ?>" type="button">
			</div>
		</div>
	</form>
</div>
<?php echo $footer; ?>