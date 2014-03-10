<?php echo $header; ?>
<script>
    var selectItem = null;
    function selectDesign(id) {
        $('.artist_design_item.selected').removeClass('selected');
        $('#item_' + id).addClass('selected');
        selectedItem = id;
        $('#previewDesign').attr('src', $('#item_' + id).attr('rel')).show();
        $('.order_info.one').html($('#item_name_' + id).html());
        $('#designTitle').html($('#item_name_' + id).html());
        $('.order_info_price').html($('#item_price_' + id).html());
        $('#modelSelector').show();
    }

    function selectModel(maskFile, el) {
        $('.model_slideshow_item').removeClass('selected');
        $(el).addClass('selected');
        $('#previewModel').attr('src', maskFile).show();
        $('.order_info.two').html($(el).find('span').html());
        $('#modelTitle').html($(el).find('span').html());
        $('#purchase').show();
    }

    function addSelectedItem() {
        addToCart(selectedItem, $('#qty').val());
        $('html, body').animate({
            scrollTop: $("#cart-total").offset().top
        }, 2000);
        setTimeout(function(){
            $("#cart-total").click();
        }, 3000);
    }

</script>
<div class="artist_wrap">

    <div class="artist_slides_bg">
        <div class="artist_slides cf">
            <div class="prod_list_top_banner dark-gray">
                <div class="top_banner_title">NEW SKIN DESIGNS</div>
                <div class="top_banner_nav">
                    <a href="#" class="banner_nav_left"></a>
                    <a href="#" class="banner_nav_right"></a>
                </div>
                <a href="#" class="top_banner_img"><img src="/catalog/view/theme/lexus_happycook/img/demo/top_ban_img.png" width="150" height="135"></a>
                <div class="top_banner_info cf">
                    <a href="#" class="top_banner_header">Red Metal Skin</a>
                    <span class="top_banner_text">Your phone gets a design makeover with our tough cases and ultra-thin skins. </span>
                    <span class="top_banner_new_price">$ 59,99</span>
                    <span style='color:#5E5E5E;text-decoration:line-through' class="top_banner_old_price">$ 79,99</span>
                    <div class="top_banner_avail">Available in stock</div>

                </div>

            </div>

            <div class="prod_list_top_banner light-gray">
                <div class="top_banner_title">CASING DEALS</div>
                <div class="top_banner_nav">
                    <a href="#" class="banner_nav_left"></a>
                    <a href="#" class="banner_nav_right"></a>
                </div>
                <a href="#" class="top_banner_img"><img src="/catalog/view/theme/lexus_happycook/img/demo/top_ban_img.png" width="150" height="135"></a>
                <div class="top_banner_info cf">
                    <a href="#" class="top_banner_header">Red & Blue Cases</a>
                    <span class="top_banner_text">Your phone gets a design makeover with our tough cases and ultra-thin skins. </span>
                    <span class="top_banner_new_price">$ 39,90</span>
                    <span style='color:#5E5E5E;text-decoration:line-through' class="top_banner_old_price">$ 59,99</span>
                    <div class="top_banner_avail">Available in stock</div>

                </div>

            </div>
        </div>
    </div>
    <div class="artist_customize_bg">
        <div class="artist_customize cf">
            <div class="customize_block sign-up">

                <div class="bordered_white">
                    <div class="sample_phones"> </div>
                </div>
                <div class="bordered_black">
                    <div class="customize_block_title">Are you an artist?</div>
                    <div class="bordered_black_desc">Submit your artwork and to earn commission off every case!</div>

                    <a href="/register" class="button button-big">Sign Up</a> <span class="sign_up_desc">and start earning!</span>
                </div>

            </div>

            <div class="customize_block choose">
                <div class="customize_block_title">
                    Customize your device in 3 Easy Steps
                </div>
                <div class="customize_wrap">
                    <a href="#" class="custom_button one">1. Choose a design</a>
                    <a href="#" class="custom_button two">2. Choose your model</a>
                    <a href="#" class="custom_button three">3. Purchase</a>
                </div>
            </div>

        </div>

    </div>


    <div class="artist_step artist_design_bg">
        <div class="artist_design cf">
            <div class="ar_bg_arrow one"></div>
            <?php if(count($products) > 0) { ?>
            <div class="artist_design_sidebar">

                <div class="block_featured">
                    <a href="#" class="block_featured_image">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/artwork-demo-featured.png">
                        <span class="image-mask mask-featured"></span>
                    </a>
                    <div class="block_featured_desc">
                        <span>Art by:</span>
                        <a href="#" class="item_user">Cellside Collective</a>
                    </div>
                </div>

                <div class="block_wrap">
                    <div class="sidebar_category">
                        <span class="sidebar_category_text">SHOP BY CATEGORY</span>
                        <ul>
                            <?php foreach ($template_categories as $category) { ?>
                            <li>
                                <?php if ($category['category_id'] == $category_id) { ?>
                                <a href="<?php echo $category['href']; ?>" class="act"><?php echo $category['name']; ?></a>
                                <?php } else { ?>
                                <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                <?php } ?>
                            </li>
                            <?php } ?>
                        </ul>
                    </div>
                    <div class="div_line"></div>
                    <div class="sidebar_tags cf">
                        <span class="sidebar_category_text">Tags in this Collection</span>
                        <ul>
                            <li ><a href="#" >LOGO</a></li>
                            <li ><a href="#" >CHARITY    </a></li>
                            <li ><a href="#" >GRAPHIC</a></li>
                            <li ><a href="#" >BLUE    </a></li>
                            <li ><a href="#" >PINK    </a></li>
                            <li ><a href="#" >TYPE    </a></li>
                            <li ><a href="#" >PLAYGROUND    </a></li>
                            <li ><a href="#" >CARTOON    </a></li>
                            <li ><a href="#" >CHARACTER    </a></li>
                            <li ><a href="#" >MESSAGE</a></li>
                            <li ><a href="#" >LOGO</a></li>
                            <li ><a href="#" >CHARITY    </a></li>
                            <li ><a href="#" >GRAPHIC</a></li>
                            <li ><a href="#" >BLUE    </a></li>
                            <li ><a href="#" >PINK    </a></li>
                            <li ><a href="#" >TYPE    </a></li>
                            <li ><a href="#" >PLAYGROUND    </a></li>
                            <li ><a href="#" >CARTOON    </a></li>
                            <li ><a href="#" >CHARACTER    </a></li>
                            <li ><a href="#" >MESSAGE</a></li>
                        </ul>
                    </div>
                </div>


            </div>
            <?php } ?>
            <div class="artist_design_body cf">

                <div class="small_title">CHOOSE A DESIGN</div>

                <div class="artist_design_wrap cf">
                    <?php if(count($products) > 0) { ?>
                    <div class="artist_design_row">
                        <?php foreach($products as $i => $product) { ?>
                        <?php if($i > 0 && $i%5 == 0) { ?>
                    </div>
                    <div class="artist_design_row">
                        <?php } ?>
                        <div id="item_<?php echo $product['product_id'];?>" rel="<?php echo $product['big_thumb']?>" class="artist_design_item <?php if(($i+1) % 5 == 0) { echo 'last-in-row';} ?>">
                            <a href="javascript:void(0);" onclick="selectDesign( <?php echo $product['product_id']; ?> );" class="item_image">
                                <img src="<?php echo $product['thumb']?>" />
                                <span class="image-mask mask-default"></span>
                                <span class="image-mask mask-selection">
                                    <span class="mask-selection-text">SELECTED</span>
                                </span>
                            </a>
                            <div style="display:none;" id="item_name_<?php echo $product['product_id'];?>"><?php echo $product['name'];?></div>
                            <div style="display:none;" id="item_price_<?php echo $product['product_id'];?>"><?php echo $product['price'];?></div>
                            <div class="item_description">
                                <span>Art by:</span>
                                <a href="<?php echo $product['seller_href']?>" class="item_user"><?php echo $product['seller_nickname']?></a>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                    <?php } ?>
                </div>
                <?php if(count($products) > 0) { ?>
                <a href="javascript:void(0);" class="artist_design_load_more">
                    LOAD MORE DESIGNS <span>&darr;</span>
                </a>
                <?php } else { ?>
                <p class='warning'>Sorry, designs are not found.</p>
                <?php } ?>
            </div>
            <div class="ar_bg_arrow two"></div>
        </div>

    </div>
    <div class="artist_step artist_choose_bg" id="modelSelector" style="display:none;">
        <div class="artist_choose">
            <div class="small_title">CHOOSE YOUR MODEL</div>

            <div class="model_slideshow">

                <div class="model_slideshow_items">
                    <a href="javascript:void(0);" onclick="selectModel('/image/iphone5.png', this)" class="model_slideshow_item">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/model1.png">
                        <span>iPhone 5</span>
                    </a>
                    <a href="javascript:void(0);" onclick="selectModel('/image/iphone4.png', this)" class="model_slideshow_item">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/model2.png">
                        <span>iPhone 4/4S</span>
                    </a>
                    <a href="javascript:void(0);" onclick="selectModel('/image/galaxy2.png', this)" class="model_slideshow_item">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/model3.png">
                        <span>Samsung Galaxy 2</span>
                    </a>
                    <a href="javascript:void(0);" onclick="selectModel('/image/galaxy3.png', this)" class="model_slideshow_item">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/model3.png">
                        <span>Samsung Galaxy 3</span>
                    </a>
                    <a href="javascript:void(0);"  onclick="selectModel('/image/blackberry.png', this)" class="model_slideshow_item">
                        <img src="/catalog/view/theme/lexus_happycook/img/demo/model4.png">
                        <span>BlackBerry</span>
                    </a>
                </div>

                <!--a class="model_slideshow_button model_slideshow_prev"></a>
                <a class="model_slideshow_button model_slideshow_next"></a-->
            </div>


        </div>
    </div>

    <div class="artist_step artist_purchase_bg" id="purchase" style="display:none;">
        <div class="artist_purchase cf">
            <div class="ar_bg_arrow one"></div>
            <div class="small_title">PURCHASE</div>


            <div class="block_purchase_wrap cf">
                <div class="block_preview">
                    <img id="previewDesign" src="" style="display:none;" />
                    <img id="previewModel" src="" style="display:none;" />
                </div>
                <div class="block_purchase_info">
                    <div class="phone_title"><span id="modelTitle"></span> - <span id="designTitle"></span></div>
                    <div class="phone_descr">Your phone gets a design makeover with our tough cases and ultra-thin skins. Protect and personalize your precious cargo with wrap-around design. Add a free matching wallpaper, too!</div>
                    <div class="order_wrap cf">
                        <span class="order_info one">Choose the design</span>
                        <span class="order_info two">Choose the phone model</span>
                    </div>
                    <div class="order_summary_wrap cf">

                        <div class="wrap">
                            <div class="price">
                                <span class="order_info_price">-</span>
                            </div>
                            <span class="order_info_quantity">
                                Quantity
                                <input value="1" type="text" id="qty"/>
                            </span>
                            <a href="javascript:void(0);" onclick="addSelectedItem();" class="add_cart">Add to Cart</a>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

</div>
<?php echo $footer; ?>