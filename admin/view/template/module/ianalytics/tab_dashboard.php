<?php 
$searchvar = 'search';
if (defined('VERSION') && (VERSION == '1.5.4' || VERSION == '1.5.4.1' || VERSION == '1.5.3' || VERSION == '1.5.3.1' || VERSION == '1.5.2' || VERSION == '1.5.2.1' || VERSION == '1.5.1' || VERSION == '1.5.1.3' || VERSION == '1.5.0')) {
	$searchvar = 'filter_name';
}
?>
<table class="form">
  <tr>
  	<td colspan="2"><h3>Dashboard</h3></td>
    <td colspan="2"><?php require('element_filter.php'); ?></td>
  </tr>
  <tr>
    <td style="width:25%;padding-left:50px;">Most Searched Keywords</td>
    <td style="width:25%;padding-left:50px;">Most Found Products</td>
    <td style="width:25%;padding-left:50px;">Most Opened Products</td>
    <td style="width:25%;padding-left:50px;">Most Compared Products</td>
  </tr>
  <tr>
    <td style="width:25%;border-bottom:none;"><div class="openRateChart pieable" data-num="<?php echo $iAnalyticsMostSearchedKeywordsPie?>" style="position: relative; "></div></td>
    <td style="width:25%;border-bottom:none;"><div class="openRateChart pieable" data-num="<?php echo $iAnalyticsMostFoundKeywordsPie?>" style="position: relative; "></div></td>
    <td style="width:25%;border-bottom:none;"><div class="openRateChart pieable" data-num="<?php echo $iAnalyticsMostOpenedProductsPie?>" style="position: relative; "></div></td>
    <td style="width:25%;border-bottom:none;"><div class="openRateChart pieable" data-num="<?php echo $iAnalyticsMostComparedProductsPie?>" style="position: relative; "></div></td>
  </tr>
  <tr>
    <td valign="top">
    	<table class="iSimpleTable">
			<?php foreach($iAnalyticsMostSearchedKeywords as $j => $k): if ($j>20) break; ?>
                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td><td><?php if ($j > 0) {  ?><div class="bt"><a href="../index.php?route=product/search&<?php echo $searchvar; ?>=<?php echo $k[0]; ?>" target="_blank" class="btn btn-small">Preview</a></div><?php } ?></td></tr>
            <?php endforeach; ?>
        </table>  
    </td>
  	<td valign="top">
    	<table class="iSimpleTable">
			<?php foreach($iAnalyticsMostFoundKeywords as $j => $k): if ($j>20) break; ?>
                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td><td><?php if ($j > 0) {  ?><div class="bt"><a href="../index.php?route=product/search&<?php echo $searchvar; ?>=<?php echo $k[0]; ?>" target="_blank" class="btn btn-small">Preview</a></div><?php } ?></td></tr>
            <?php endforeach; ?>
        </table>  
    </td>
  	<td valign="top">
    	<table class="iSimpleTable">
			<?php foreach($iAnalyticsMostOpenedProducts as $j => $k): if ($j>20) break; ?>
                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td></tr>
            <?php endforeach; ?>
        </table>  
    </td>
  	<td valign="top">
    	<table class="iSimpleTable">
			<?php foreach($iAnalyticsMostComparedProducts as $j => $k): if ($j>20) break; ?>
                <tr><td><?php echo $k[0]?></td><td><?php echo $k[1]?></td></tr>
            <?php endforeach; ?>
        </table>  
    </td>
  </tr>

</table>


<script>


</script>