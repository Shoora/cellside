<div class="row-fluid">
	<div class="span12">
        <div class="minification-tabbable-parent">

<div class="tabbable tabs-left"> 
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#opened-products" data-toggle="tab">Opened Products</a></li>
                    <li><a href="#compared-products" data-toggle="tab">Compared Products</a></li>
                  </ul>
                 <div class="tab-content">
                    <div id="opened-products" class="tab-pane active">
                        <div class="box-heading">
                            <h1 style="float:left;">Opened Products</h1>
                            <?php require('element_filter.php'); ?>
                        </div>
                        <div class="help">This table shows the products your visitors viewed starting from the most viewed.</div>
         				<table class="form">
                        <?php foreach($iAnalyticsMostOpenedProducts as $j => $k): ?>
                            <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td></tr>
                        <?php endforeach; ?>
                        </table>
                        <div class="clearfix"></div>
                    </div>
                    <div id="compared-products" class="tab-pane">
                            
                            <div class="box-heading">
                                <h1 style="float:left;">Compared Products</h1>
                                <?php require('element_filter.php'); ?>
                            </div>
                            <span class="help">This table shows the products your visitors compared starting from the most compared.</span>
                            <br />
                            <br />
                            <table class="form">
                            <?php foreach($iAnalyticsMostComparedProducts as $j => $k): ?>
                                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td></tr>
                            <?php endforeach; ?>
                            </table>
                            <div class="clearfix"></div>

                    </div>
                 </div>
               </div>
            </div>
	</div>
</div>