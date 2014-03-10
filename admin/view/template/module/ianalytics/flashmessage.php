
<?php if (!empty($this->session->data['success'])) { ?>
<div class="success autoSlideUp"><?php echo $this->session->data['success']; ?></div>
<script> $('.autoSlideUp').delay(3000).fadeOut(600, function(){ $(this).show().css({'visibility':'hidden'}); }).slideUp(600);</script>
<?php $this->session->data['success'] = null; } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
