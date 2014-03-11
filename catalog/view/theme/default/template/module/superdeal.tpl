<?php

   $class="boxlist".$module;
   $css="boxlist";
   
    //echo "<pre>"; var_dump($products); echo "</pre>";
	if ($superdeal_showas == "slide"){
		?>
			<script type="text/javascript"><!--
			$(document).ready(function() {
				$('#slide<?php echo $module; ?>')
				.cycle({
					fx:			'<?php echo $superdeal_slideeffect;?>',
					pause:      true,
					pager:		'#nav',
					
				});
			});
			--></script>
		<?php
	}
?>
	  <div class="dealbox-heading"><?php echo $module_heading; ?></div>

<div class="superdealcontent" style="<?php echo $modulestyle;?>position:relative;">


<div id="<?php echo $superdeal_showas.$module;?>" class="<?php echo $superdeal_showas;?>" style="<?php echo $modulestyle.$fontsize;?> ">

<?php foreach ($products as $product) { 
    if ($product['timeleft']> 0){ 
?>
<div class="superdeal">

    <div class="<?php echo $css; ?>" style="<?php echo $boxheight;?>" >

      <div class="superdeal_content">

	  	<ul class="panel">
			<li>
				<div class="buynow <?php echo $superdeal_buttonsize; ?> <?php echo $superdeal_percentsavebutton; ?> save"><?php echo $product['percentsave']; ?><div class="off"><?php echo $percentsave;?></div></div>
			</li>
			
			  <?php if ($product['price']) { ?>
				  <li>
			          <div class="buynow <?php echo $superdeal_buttonsize; ?> <?php echo $superdeal_pricesavebutton; ?> fullprice">  
			              <div class="price">
			                    <div class="price-old"><?php echo $product['price']; ?></div> <div class="pricenew"><?php echo $product['special']; ?></div>   
			                    <div class="textprice"><?php echo $price;?></div>

			              </div>
			          </div>
				  </li>
				  <li>
			          <div class="buynow <?php echo $superdeal_buttonsize; ?> <?php echo $superdeal_yousavebutton; ?> yousave">
			                <div class="pricenew"><?php echo $product['yousave']; ?></div> <div class="yousavetext"><?php echo $yousave;?></div>
			          </div>
				  </li>
	          <?php } ?>
			
			<li>
				<div class="buynow <?php echo $superdeal_buttonsize; ?> <?php echo $superdeal_itemleftbutton; ?> quantity"><div class="pricenew"><?php echo $product['quantity']; ?></div><div class="off"><?php echo $itemleft;?></div></div>

			</li>
		</ul>
        
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
        
        </div>
        <?php } ?>
        <div class="description">
            <h1 class="name">
                <a href="<?php echo $product['href']; ?>"  style="font-size:<?php echo $superdeal_titlesize;?>px;"><?php echo $product['name']; ?></a>
            </h1>

        <?php echo htmlspecialchars_decode($product['description']);?>...
		<div class="buynowcontent">
						                    			
						                    			
						                    			
						                    			
	
			
			<!-- Countdown  start -->
	        <div id="defaultCountdown<?php echo $product['product_id'];?>" class="countdown_dashboard"></div>
	        <script type="text/javascript"><!--
	        $(document).ready(function() {
	                $('#defaultCountdown<?php echo $product["product_id"]; ?>').countdown({ 
	    				until: new Date(<?php echo $product['yleft'];?>, <?php echo $product['mleft'];?> - 1, <?php echo $product['dleft'];?>)
						}); 
	            });
	            
	        //-->
			</script>
			<div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="buynow <?php echo $superdeal_buttonsize; ?> <?php echo $superdeal_buynowbutton; ?>"><span><?php echo $buynow; ?></span></a></div>
		
		</div>

        </div>
      </div>
      
    </div>

</div>

<?php } //end timeleft?>
<?php } ?>


</div>
	<?php 
	 if ($superdeal_showas == "slide"){
	?>
		<div id="nav"></div>

	<?php }?>
</div>
<br style="clear:both;" />




