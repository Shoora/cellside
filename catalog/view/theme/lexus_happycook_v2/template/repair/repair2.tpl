<?php echo $header; ?>

<section class="service-steps">
    <div class="container">
        <ul class="four-steps clearfix">
            <li class="passed-step">
                <div class="step-item label-device">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">1. Select Device</div>
                            <div class="step-item-decor">
                                <div class="step-item-decor-inner"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li class="current-step">
                <div class="step-item label-issue">
                    <div class="step-item-inner">
                        <div class="step-item-container">
                            <div class="step-item-label">2. Select issue(s)</div>
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
                            <div class="step-item-label">3. Select Service</div>
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
                            <div class="step-item-label">4. Price Info</div>
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
<section class="main-container computer-service">
    <div class="container">
        <section class="contain-header">
            <div class="row">
                <div class="col-sm-3 back-pagination">
                    <a class="btn-red btn-cellside btn-prev">
                        <div class="btn-cellside-label">
                            <i class="fa fa-arrow-circle-o-left"></i>
                            <span>Back</span>
                        </div>
                        <div class="btn-cellside-decor">
                            <div class="btn-cellside-decor-inner"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-6 service-header">
                    <h2 class="">Select the issue(s) of your device.</h2>
                    <p>Follow our easy 4 step process to find out a quick repair estimate on your device.</p>
                </div>
                <div class="col-sm-3 short-pagination">
                    <a class="btn-blue btn-cellside btn-next">
                        <div class="btn-cellside-label">
                            <span>Next</span>
                            <i class="fa fa-arrow-circle-o-right"></i>
                        </div>
                        <div class="btn-cellside-decor">
                            <div class="btn-cellside-decor-inner"></div>
                        </div>
                    </a>
                </div>
            </div>
        </section>
        <section class="list-devices">
            <ul class="clearfix cellside-selection">
                <li>
                    <input type="checkbox" id="Laptop"/><label for="Laptop"><span>Laptop <br/>screen replacement</span></label>
                </li>
                <li>
                    <input type="checkbox" id="VirusRemoval"/><label for="VirusRemoval"><span>Virus Removal</span></label>
                </li>
                <li>
                    <input type="checkbox" id="SlowComputer" checked="checked"/><label for="SlowComputer"><span>Slow computer</span></label>
                </li>
                <li>
                    <input type="checkbox" id="RepairUpgrades"/><label for="RepairUpgrades"><span>Repair & Upgrades</span></label>
                </li>
                <li>
                    <input type="checkbox" id="DataTransfers"/><label for="DataTransfers"><span>Data Transfers</span></label>
                </li>
            </ul>
            <ul class="clearfix cellside-selection">
                <li>
                    <input type="checkbox" id="DataRecovery"/><label for="DataRecovery"><span>Data Recovery</span></label>
                </li>
                <li>
                    <input type="checkbox" id="NetworkingWireless"/><label for="NetworkingWireless"><span>Networking
                    <br/>& Wireless</span></label>
                </li>
                <li>
                    <input type="checkbox" id="PrintingScanning"/><label for="PrintingScanning"><span>Printing
                    <br/>&amp; Scanning</span></label>
                </li>
                <li>
                    <input type="checkbox" id="Backup" checked="checked"/><label for="Backup"><span>Backup</span></label>
                </li>
                <li>
                    <input type="checkbox" id="SpecialTraining"/><label for="SpecialTraining"><span>Special Training</span></label>
                </li>
            </ul>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-1.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                            </h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-2.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5><a href="">HTC Double Dip Flip Case for One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-3.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Cruzerlite Androidified A2 TPU Case for HTC One</a></h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-4.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Urban Armor Gear Composite Case w/ Screen Protector for HTC One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-5.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">HTC OEM Double Dip Case (Grey Red) (99H11110600) for HTC One</a></h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-6.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">OtterBox Realtree Xtra Camo Defender Series Case (Xtra Green: Black/Green) HTC One</a>
                            </h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-1.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                            </h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-2.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5><a href="">HTC Double Dip Flip Case for One</a></h5>
                            </div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-3.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                            </h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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
                            <div class="product-item-thumb"><a href=""><img src="catalog/view/theme/<?php echo $themeName;?>/image/product-row-4.png" alt=""/></a>
                            </div>
                            <div class="product-item-name"><h5>
                                <a href="">Premium Line 10ft Micro-USB Charge & Data Sync Cable (Blue) for HTC One</a>
                            </h5></div>
                            <div class="product-item-ratings"><img src="catalog/view/theme/<?php echo $themeName;?>/image/stars-3.png" alt=""/></div>
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

<?php echo $footer; ?>