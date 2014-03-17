<?php echo $header; ?>

<section id="pav-slideshow" class="pav-slideshow hidden-xs">
    <div class="banner-repair">
        <div class="container">
            <div class="phones-warranty">
                <img src="/catalog/view/theme/lexus_happycook_v2/images/new/phones-warranty.png" alt=""/>
            </div>
            <div class="sub-nav">
                <ul>
                    <li><a href="#">Inquiries</a></li>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Corporate</a></li>
                    <li><a href="#">Computers</a></li>
                    <li><a href="#">Other Services</a></li>
                </ul>
            </div>
            <div class="counting">
                <div class="label-counting">
                    <div class="label1">Phones Repaired</div>
                    <div class="label2">and counting!</div>
                </div>
                <div class="clearfix">
                    <span>1</span>
                    <span>2</span>
                    <span>4</span>
                    <span>6</span>
                    <span>8</span>
                    <span>2</span>
                </div>
            </div>
        </div>
    </div>
</section>
<section id="" class="offcanvas-siderbars">
<section class="service-steps">
    <div class="container">
        <ul class="five-steps clearfix">
            <li class="passed-step">
                <div class="step-item label-device">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">1. Choose Device</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li class="current-step">
                <div class="step-item label-color">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">2. Choose Color</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li>
                <div class="step-item label-issue">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">3. Choose issue(s)</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li>
                <div class="step-item label-service">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">4. Choose Service</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li>
                <div class="step-item label-price">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">5. Price Info</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</section>
<section class="main-container">
    <div class="container">
        <section class="contain-header">
            <div class="row">
                <div class="col-sm-3 back-pagination">
                    <a class="btn-red btn-cellside btn-prev">
                        <div class="btn-cellside-label">
                            <i class="fa fa-arrow-circle-o-left"></i>
                            <span onclick="gotoStep(1);">Back</span>
                        </div>
                        <div class="btn-cellside-decor">
                            <div class="btn-cellside-decor-inner"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-6 service-header">
                    <h2 class="">Select the color of your device.</h2>
                    <p>Follow our easy 5 step process to find out a quick repair estimate on your device.</p>
                </div>
                <div class="col-sm-3 short-pagination">
                    <a class="btn-blue btn-cellside btn-next">
                        <div class="btn-cellside-label">
                            <span id="goto-step-3">Next</span>
                            <i class="fa fa-arrow-circle-o-right"></i>
                        </div>
                        <div class="btn-cellside-decor">
                            <div class="btn-cellside-decor-inner"></div>
                        </div>
                    </a>
                </div>
            </div>
        </section>
        <section class="list-colors">
            <div class="clearfix">
                <?php foreach ( $colors as $color ) { ?>
                <div id="color-item-<?= $color['category_id'] ?>" class="color-item pointer">
                    <div class="color-item-decor"></div>
                    <div class="color-item-inner" style="background-color:<?= $color['color'] ?>;">
                        <div class="color-item-label"><?= $color['name'] ?></div>
                    </div>
                </div>
                <?php } ?>
            </div>
        </section>
    </div>
</section>
<section class="recommend-list">
    <div class="container">
        <div class="recommend-list-header">
            <div class="recommend-list-title">You may be interested in</div>
            <div class="recommend-list-nav"></div>
        </div>
        <div class="recommend-product-list">
            <div class="jcarousel">
                <ul class="clearfix">
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="sale-tag">SALE</div>
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-1.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                                </h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-2.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5><a href="">HTC Double Dip Flip Case for One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="sale-tag">SALE</div>
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-3.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Cruzerlite Androidified A2 TPU Case for HTC One</a></h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-4.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Urban Armor Gear Composite Case w/ Screen Protector for HTC One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-5.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">HTC OEM Double Dip Case (Grey Red) (99H11110600) for HTC One</a></h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-6.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">OtterBox Realtree Xtra Camo Defender Series Case (Xtra Green: Black/Green) HTC One</a>
                                </h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="sale-tag">SALE</div>
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-1.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                                </h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-2.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5><a href="">HTC Double Dip Flip Case for One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-3.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                                </h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li class="recommend-item">
                        <div class="col-product-item">
                            <div class="product-item-thumb"><a href=""><img src="/catalog/view/theme/lexus_happycook_v2/images/new/product-row-4.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                    <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                                </h5></div>
                            <div class="product-item-ratings"><img src="/catalog/view/theme/lexus_happycook_v2/images/new/stars-3.png" alt=""/></div>
                            <div class="product-item-add-cart">
                                <a href="" class="btn-add-cart">
                                    <span>$ 89.00</span>
                                    <i class="fa fa-arrow-circle-o-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="carousel_control">
                <a href="#" class="jcarousel-control-prev inactive" data-jcarouselcontrol="true"><i class="fa fa-angle-left"></i></a>
                <a href="#" class="jcarousel-control-next" data-jcarouselcontrol="true"><i class="fa fa-angle-right"></i></a>
            </div>
        </div>
    </div>
</section>
</section>
<script type="text/javascript" src="/catalog/view/theme/lexus_happycook_v2/js/jquery.jcarousel.min.js"></script>
<script type="text/javascript" src="/catalog/view/theme/lexus_happycook_v2/js/jcarousel.skeleton.js"></script>
<script type="text/javascript" src="/catalog/view/theme/lexus_happycook_v2/js/repair.js"></script>

<?php echo $footer; ?>