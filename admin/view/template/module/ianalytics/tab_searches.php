<?php 
$searchvar = 'search';
if (defined('VERSION') && (VERSION == '1.5.4' || VERSION == '1.5.4.1' || VERSION == '1.5.3' || VERSION == '1.5.3.1' || VERSION == '1.5.2' || VERSION == '1.5.2.1' || VERSION == '1.5.1' || VERSION == '1.5.1.3' || VERSION == '1.5.0')) {
	$searchvar = 'filter_name';
}
?>

<div class="row-fluid">
	<div class="span12">
        <div class="minification-tabbable-parent">
            <div class="tabbable tabs-left"> 
                  <ul class="nav nav-tabs">
                    <li class="active"><a href="#search-queries" data-toggle="tab">Search Queries</a></li>
                    <li><a href="#search-keywords" data-toggle="tab">Search Keywords</a></li>
                    <li><a href="#most-searched-products" data-toggle="tab">Most Searched Products</a></li>
                  </ul>
                 <div class="tab-content">
                    <div id="search-queries" class="tab-pane active">
                        <div class="box-heading">
                            <h1 style="float:left;">Search Queries Graph</h1>
                            <?php require('element_filter.php'); ?>
                        </div>
                        <div class="help">This graph depicts what part of your users' search queries has derived results</div>
                        <div class="iModuleFields">
                        <script type="text/javascript">
                            var monthlySearchesGraph = $.parseJSON('<?php echo json_encode($iAnalyticsMonthlySearchesGraph)?>'); 
                        </script>
                            <div id="searchedFound"></div>
                            <br /><br /><br />
                            <div class="box-heading">
                            	<h1>Search Queries in Numbers</h1>
                            </div>
                            <table class="form">
                            <?php foreach($iAnalyticsMonthlySearchesTable as $day): ?>
                                <tr><td><?php echo $day[0]?></td><td><?php echo $day[1]?></td><td><?php echo $day[2]?></td><td><?php echo $day[3]?></td></tr>
                            <?php endforeach; ?>
                            </table>
                            <div class="clearfix"></div>
                        </div>

                    </div>
                    <div id="search-keywords" class="tab-pane">
                        <div class="iModuleFields">
                            
                            <div class="box-heading">
                                <h1 style="float:left;">Keywords in Search - History</h1>
                                <?php require('element_filter.php'); ?>
                            </div>
                            <div class="help">This table shows the search queries of your website users starting from the most recent.</div><br />
   							 <br />
                            <table class="form">
                            <?php foreach($iAnalyticsKeywordSearchHistory as $index => $k): ?>
                                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td><td><?php echo $k[2]?></td><td><?php echo $k[3]?></td><td><?php echo $k[4]?></td><td><?php echo $k[5]?></td>
                                <td><?php if ($index > 0) : ?><a class="btn btn-small" onclick="return confirm('Are you sure you wish to delete the record?');" href="index.php?route=module/ianalytics/deletesearchkeyword&token=<?php echo $this->session->data['token']; ?>&searchValue=<?php echo $k[6]; ?>">Delete record</a>&nbsp;&nbsp;<a  class="btn btn-small" onclick="return confirm('Are you sure you wish to delete all of the searches of this keyword?');" href="index.php?route=module/ianalytics/deleteallsearchkeyword&token=<?php echo $this->session->data['token']; ?>&searchValue=<?php echo $k[0]; ?>">Delete keyword</a><?php endif; ?></td>
                                </tr>
                            <?php endforeach; ?>
                            </table>
                            <div class="clearfix"></div>
                        </div>

                    </div>
                    <div id="most-searched-products" class="tab-pane">
                        <div class="box-heading">
                            <h1 style="float:left;">Most Searched Keywords</h1>
                            <?php require('element_filter.php'); ?>
                        </div>
                        <span class="help">This indicates what your visitors search the most on your site using the OpenCart search engine</span>
                        <br />
                        <br />
                            <table class="form">
                            <?php foreach($iAnalyticsMostSearchedKeywords as $j => $k): ?>
                                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td><td align="right"><?php if ($j > 0) {  ?><div><a href="../index.php?route=product/search&<?php echo $searchvar; ?>=<?php echo $k[0]?>" target="_blank" class="btn btn-small"><i class="icon-eye-open"></i>&nbsp; Preview</a></div><?php } ?></td></tr>
                            <?php endforeach; ?>
                            </table>
                        <div class="iModuleFields">
                            <div class="clearfix"></div>
                        </div>

                     </div>
                 </div>
               </div>
            </div>
	</div>
</div>