
<?php
    //$themeConfig = $this->config->get( 'themecontrol' );
    	$themeName =  $this->config->get('config_template');
    	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
    	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
    	$helper->setDirection( $direction );
    	/* Add scripts files */



?>


<?php echo $header; ?>

<div id="filters" class="filter_landing_body">
    <div class="filter_landing_margin">
    <?php foreach($this->data['category'] as $key =>$categoryMain){?>
        <div  target="button_menu" id="<?php echo strtolower($categoryMain['category_id']."_".$categoryMain['name']);?>"  class="filter_landing_block class_fllag_show">
            <span   class="filter_landing_button"><?php echo $categoryMain['name']?><b class="caret_landing" ></b></span>
            <?php if(count($categoryMain['children']) && !is_null($categoryMain['children'])){?>

                <div show="<?php echo strtolower($categoryMain['category_id']."_".$categoryMain['name']);?>" class="filter_sub_category_transparent"  >
                <br>
                <div class="filter_sub_category">
                <?php foreach($categoryMain['children'] as $key1 => $sub){?>

                        <div class="filter_magin_sub_item"><a href="<?php echo  $sub['link'];?>"><div  id="<?php echo $sub['category_id'] ?>"><i class="caret_landing_sub fa-caret-right"></i><? echo $sub['name'] ?></div></a></div>

                <?php }?>
                </div>
                </div>
            <?php }?>
        </div>
    <?php }?>
    </div>
</div>

<div class="product_landing_contener">
<div>

        <?php foreach($this->data['product'] as $key => $item){?>


            <div idProduct="<?php echo $item['product_id']?>" class="col-md-4 col-sm-6 col-xs-12 product_landing">
                <?php if(!is_null($item['percentage'])){?>
                    <div class="percentage_right">
                        <div class="percentage">
                            <span><?php echo $item['percentage']."%";?></span>
                            <br>
                            <span>Off</span>
                        </div>
                    </div>
                <?}?>
                <div style="text-align:center;">
                    <div class="col-md-4 col-sm-6 col-xs-12 product_landing_img">
                        <img  src="<?php echo $item['thumbsmall'];?>">
                    </div>
                </div>

                <div class="clearfix"></div>

                <div >



                    <h3 class="product_landing_name"><?php echo $item['name']." ".$item['model'];?></h3>


                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <?php if(!$item['special']){?>
                                    <span class="price_landing_green " ><?php echo $item['price_format']?></span>
                                    <span class="price_landing_red">&nbsp;</span>
                                <?}else{?>
                                 <span class="price_landing_green" ><?php echo $item['special_format']?></span>
                                                        <span class="price_landing_red"><strike><?php echo $item['price_format'] ?></strike></span>

                                <?}?>
                            </div>

                            <div class="col-md-4 col-sm-6 col-xs-12">
                                <span class="cart button_add_cart" >
                                                            <a class="btn btn-lg btn-success" onclick="addToCart('<?php echo $item['product_id']; ?>');" href="javascript:void(0);"><i class="fa fa-shopping-cart pull-right"></i><?php echo $add_item;?></a>
                                </span>
                            </div>
                            <div class="clearfix"></div>
                            <br>

                           <div class="col-md-4 col-sm-6 col-xs-12">
                             <?php if ($review_status) { ?>
                                                		  <span class="review">
                                                			<span class="review_landing">
                                                			    <img
                                                			         src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo  $item['rating']; ?>.png"
                                                			         alt="<?php echo $reviews; ?>"
                                                			    />

                                                			 </span>

                                                		   </span>
                                                <?php } ?>
                           </div>
                           <div class="col-md-4 col-sm-6 col-xs-12">
                             <span style="time_landing">
                                <span class="text_leding_black">Time Left:</span><span class="text_leding_black "><?php echo $item['time_left'];?></span>
                             </span>
                           </div>






                 </div>
            </div>
        <?}?>





</div>

</div>

<div>
 <div class="clearfix"></div>
<?php echo $footer; ?>
</div>

<script>

     function MenuLanding(){}

      MenuLanding.prototype = {
        init:function(){
            this.menu           = $("div[target=button_menu]");
            this.openMenu       = 0;
            this.selectMenu     = 0;
            this.old            = 0;
            var $this = this;




            $(this.menu).mouseenter(function(){
                if($this.selectMenu != $(this).attr("id")){
                    var oldSelect    = $this.selectMenu;
                    $this.old        = $this.selectMenu;
                    $(this).find("span.filter_landing_button").css("text-shadow","1px 1px 2px rgba(255,255,255,0.8)");

                    $this.selectMenu = $(this).attr("id");
                    $('div[show="'+$this.selectMenu+'"]').animate({opacity: '+=0.25',
                                                                   height: 'toggle'
                                                                  },500, function() {

                                                           });


                }




            });
            $(".class_fllag_show").mouseleave(function(){

               if($this.selectMenu == $(this).attr("id")){

                     $('div[show="'+$this.selectMenu+'"]').animate({opacity: '+=0.25',
                                                                                    height: 'toggle'
                                                                                    }, 100, function() {

                                                      });

                     $this.selectMenu = 0;
                    $("span.filter_landing_button").css("text-shadow","");


               }

            })



        },
      }


    $(document).ready(function(){
        //showHideMenu();
        var menu = new  MenuLanding();
        menu.init();
    });






</script>