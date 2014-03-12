<table class="form">
  <tr>
    <td><span class="required">*</span> <?php echo $entry_code; ?></td>
    <td>
        <select name="iAnalytics[Enabled]" class="iAnalyticsEnabled">
            <option value="yes" <?php echo ($data['iAnalytics']['Enabled'] == 'yes') ? 'selected=selected' : ''?>>Enabled</option>
            <option value="no" <?php echo ($data['iAnalytics']['Enabled'] == 'no') ? 'selected=selected' : ''?>>Disabled</option>
        </select>
   </td>
  </tr>
  <tr class="iAnalyticsActiveTR">
    <td><span class="required">*</span> <?php echo $entry_layouts_active; ?></td>
    <td>
    <?php $i=0;?>
    <?php foreach ($layouts as $layout) { ?>
    <?php 
        foreach ($modules as $module) {
            if(!empty($module)) {
                if ($module['layout_id'] == $layout['layout_id']) {
                    $status = $module['status'];
                    if ((int)$status == 1) {
                        $checked = ' checked=checked';
                    } else { 
                        $checked = '';
                    }
                    
                }
            } 
          
          }
          if (!isset($status)) {
                $status = 1;
                $checked = ' checked=checked';
          }
    ?>
    <div class="iAnalyticsLayout">
        <input type="checkbox" value="<?php echo $layout['layout_id']; ?>" id="iAnalyticsActive<?php echo $i?>" <?php echo $checked?> /><label for="iAnalyticsActive<?php echo $i?>"><?php echo $layout['name']; ?></label>
        <input type="hidden" name="ianalytics_module[<?php echo $i?>][position]" value="content_bottom" />
        <input type="hidden" class="iAnalyticsItemLayoutIDField" name="ianalytics_module[<?php echo $i?>][layout_id]" value="<?php echo $layout['layout_id']; ?>" />
        <input type="hidden" class="iAnalyticsItemStatusField" name="ianalytics_module[<?php echo $i?>][status]" value="<?php echo $status ?>" />
        <input type="hidden" name="ianalytics_module[<?php echo $i?>][sort_order]" value="<?php echo $i+10?>" />
    </div>
    <?php $i++;} ?>
     </td>
  </tr>
  <tr>
    <td>Clear analytics data</td>
    <td>
    	<a class="btn" onclick="return confirm('Are you sure you wish to delete all analytics data?');" href="index.php?route=module/ianalytics/deleteanalyticsdata&token=<?php echo $this->session->data['token']; ?>"><i class="icon-trash"></i>&nbsp; Clear All Analytics Data</a>
    </td>
  </tr>
  <tr>
    <td>Blacklisted IP's<span class="help">These are the IP addresses whose analytics data will not be listed. Keep in mind that data from these IP addresses will still be logged in the database. Type in one IP address per line.</span></td>
    <td>
    	<textarea style="width: 400px; height: 100px;" name="iAnalytics[BlacklistedIPs]"><?php echo !empty($data['iAnalytics']['BlacklistedIPs']) ? $data['iAnalytics']['BlacklistedIPs'] : ''; ?></textarea>
    </td>
  </tr>
</table>
<script>
$('.iAnalyticsLayout input[type=checkbox]').change(function() {
    if ($(this).is(':checked')) { 
        $('.iAnalyticsItemStatusField', $(this).parent()).val(1);
    } else {
        $('.iAnalyticsItemStatusField', $(this).parent()).val(0);
    }
});

$('.iAnalyticsEnabled').change(function() {
    toggleiAnalyticsActive(true);
});

var toggleiAnalyticsActive = function(animated) {
    if ($('.iAnalyticsEnabled').val() == 'yes') {
        if (animated) 
            $('.iAnalyticsActiveTR').fadeIn();
        else 
            $('.iAnalyticsActiveTR').show();
    } else {
        if (animated) 
            $('.iAnalyticsActiveTR').fadeOut();
        else 
            $('.iAnalyticsActiveTR').hide();
    }
}

toggleiAnalyticsActive(false);
</script>
