<?php
/******************************************************
 * @package  : Pav Popular tags module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/
?>

<div class="box populartag">

	<div class="box-heading" style="border:none !important; margin:0px !important; padding:0px !important;"><span class="sidebar_category_text" style="margin:10px 0 0 0 !important;"><b><?php echo "Tags"; ?></b></span></div>
    	<div class="sidebar_prod_view_line"></div>
<div class="sidebar_arrow"></div>
	<div class="box-content">
		<?php if($data) { ?>
			<?php echo $data; ?>
		<?php } else { ?>
			<?php echo $text_notags; ?>
		<?php } ?>
	</div>
</div>
