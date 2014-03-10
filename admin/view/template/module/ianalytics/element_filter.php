<table cellpadding="0" cellspacing="0" class="iAnalyticsDateFilter">
    <tr>
    	<td>
            <select class="iAnalyticsSelectBox">
                <option value="custom"<?php if (!$this->data['iAnalyticsSelectData']['enable'][0]) echo (' disabled="disabled" class="optionDisabled"'); if ($this->data['iAnalyticsSelectData']['select'][0]) echo (' selected="selected"'); ?>>Custom</option>
                <option value="last-week"<?php if (!$this->data['iAnalyticsSelectData']['enable'][1]) echo (' disabled="disabled" class="optionDisabled"'); if ($this->data['iAnalyticsSelectData']['select'][1]) echo (' selected="selected"'); ?>>Last Week</option>
                <option value="last-month"<?php if (!$this->data['iAnalyticsSelectData']['enable'][2]) echo (' disabled="disabled" class="optionDisabled"'); if ($this->data['iAnalyticsSelectData']['select'][2]) echo (' selected="selected"'); ?>>Last Month</option>
                <option value="last-year"<?php if (!$this->data['iAnalyticsSelectData']['enable'][3]) echo (' disabled="disabled" class="optionDisabled"'); if ($this->data['iAnalyticsSelectData']['select'][3]) echo (' selected="selected"'); ?>>Last Year</option>
            </select>
   		</td>
        <td>
        <label>From:</label>
        <input value="<?php echo  $this->data['iAnalyticsFromDate'];?>" class="fromDate" type="text" maxlength="10" />
        </td>
        <td>
        <label>To:</label>
        <input value="<?php echo  $this->data['iAnalyticsToDate'];?>" class="toDate" type="text" maxlength="10" />
    	</td>
        <td>
        <button type="button" class="btn dateFilterButton"><i class="icon-filter"></i>&nbsp; Filter</button>
        </td>
    </tr>
</table>
<div class="clearfix"></div>