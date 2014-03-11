<?php echo $header; ?>
<div id="content" class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
				<?php } ?>
			</div>
			<?php if ($error_install) { ?>
			<div class="warning"><?php echo $error_install; ?></div>
			<?php } ?>
			<?php if ($error_image) { ?>
			<div class="warning"><?php echo $error_image; ?></div>
			<?php } ?>
			<?php if ($error_image_cache) { ?>
			<div class="warning"><?php echo $error_image_cache; ?></div>
			<?php } ?>
			<?php if ($error_cache) { ?>
			<div class="warning"><?php echo $error_cache; ?></div>
			<?php } ?>
			<?php if ($error_download) { ?>
			<div class="warning"><?php echo $error_download; ?></div>
			<?php } ?>
			<?php if ($error_logs) { ?>
			<div class="warning"><?php echo $error_logs; ?></div>
			<?php } ?>
		</div>
	</div>
	<div class="row-fluid">
		<div class="box span12">
			<?php if (isset($error_warning)) { ?>
			<div class="warning"><?php echo $error_warning; ?></div>
			<?php } ?>
			<?php if (isset($success)) { ?>
			<div class="success"><?php echo $success; ?></div>
			<?php } ?>
			<?php
			if(!isset($theme_not_installed)){
				?>
				<div class="row-fluid">
					<div class="heading span12">
						<h1 class="span6"><img src="view/image/admin_theme/base5builder_circloid/icon-dashboard.png" alt="Dashboard" width="32" height="32" /> <?php echo $heading_title; ?></h1>
						<?php if ($this->user->hasPermission('access', 'common/admin_circloid_dashboard_editor')) { ?>
						<div class="buttons span6">
							<a class="btn dashboard-edit" href="<?php echo $edit_dashboard; ?>"><?php echo $button_edit_dashboard; ?></a>
						</div>
						<?php } ?>
					</div>
				</div>
				<div class="row-fluid">
					<div class="content span12">
						<div id="dashboard-layout" class="span12">
							<!-- <div id="c-gridster-data" class="span2"></div> -->
							<!-- Do a foreach to go through the $widget_data variable, then within that use a "switch loop" with widget_name as "case" -->

							<?php
							foreach($widget_data as $list_item){
								if($list_item['enabled'] == "1"){
									$layout_data = unserialize($list_item['layout']);
									foreach($layout_data as $widget){

										// Get Colors For Charts
										$colors = $widget['colors'];
										// Declare $color variable to be populated below
										$color = "";
										// Place pointer at the end of $color array
										end($colors);

										// Fetch the key of the last array element
										$lastElementKey = key($colors);

										// Loop over the array
										foreach($colors as $key => $value) {
											if($key == $lastElementKey) {
											// Last element
												$color .= $value;
											}else{
											// Not Last Element
												$color .= $value . ',';
											}
										}

										// Display the appropriate Widget
										switch ($widget['name']) {
											case 'order_customer_statistic':

											if($widget['enabled'] == 1){

												?>
												<!-- Order/Customer Statistics - Large -->
												<div class="order-customer-statistic c-widget c-widget-large span12">
													<h2><?php echo $text_statistics; ?></h2>
													<div class="dashboard-content">
														<div class="range">
															<div class="range-label"><?php echo $entry_range; ?></div>
															<select id="range-order-customer">
																<option value="day"><?php echo $text_day; ?></option>
																<option value="week"><?php echo $text_week; ?></option>
																<option value="month"><?php echo $text_month; ?></option>
																<option value="year" selected="selected"><?php echo $text_year; ?></option>
															</select>
														</div>
														<div class="order-customer-legend clearfix">
															<div class="order-customer-legend-box stat-1">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_order, 0, -1); ?></div>
															</div>
															<div class="order-customer-legend-box stat-2">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_customer, 0, -1); ?></div>
															</div>
														</div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div id="report-order-customer-statistic">
															<div id="order-customer-chart"></div>
														</div>
													</div>
												</div>

												<?php
											}
											break;
											case 'order_customer_statistic_day':

											if($widget['enabled'] == 1){
												?>

												<!-- Order/Customer Statistics - Day -->
												<div class="order-customer-statistic-day c-widget c-widget-small span4">
													<h2><?php echo $text_statistics_day; ?></h2>
													<div class="dashboard-content">
														<div class="order-customer-legend clearfix">
															<div class="order-customer-legend-box stat-1">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_order, 0, -1); ?></div>
															</div>
															<div class="order-customer-legend-box stat-2">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_customer, 0, -1); ?></div>
															</div>
														</div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div id="report-order-customer-statistic-day">
															<div id="order-customer-chart-day"></div>
														</div>
													</div>
												</div>

												<?php
											}

											break;
											case 'order_customer_statistic_week':

											if($widget['enabled'] == 1){

												?>

												<!-- Order/Customer Statistics - Week -->
												<div class="order-customer-statistic-week c-widget c-widget-small span4">
													<h2><?php echo $text_statistics_week; ?></h2>
													<div class="dashboard-content">
														<div class="order-customer-legend clearfix">
															<div class="order-customer-legend-box stat-1">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_order, 0, -1); ?></div>
															</div>
															<div class="order-customer-legend-box stat-2">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_customer, 0, -1); ?></div>
															</div>
														</div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div id="report-order-customer-statistic-week">
															<div id="order-customer-chart-week"></div>
														</div>
													</div>
												</div>

												<?php
											}

											break;
											case 'order_customer_statistic_month':

											if($widget['enabled'] == 1){

												?>

												<!-- Order/Customer Statistics - Month -->
												<div class="order-customer-statistic-month c-widget c-widget-small span4">
													<h2><?php echo $text_statistics_month; ?></h2>
													<div class="dashboard-content">
														<div class="order-customer-legend clearfix">
															<div class="order-customer-legend-box stat-1">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_order, 0, -1); ?></div>
															</div>
															<div class="order-customer-legend-box stat-2">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_customer, 0, -1); ?></div>
															</div>
														</div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div id="report-order-customer-statistic-month">
															<div id="order-customer-chart-month"></div>
														</div>
													</div>
												</div>

												<?php
											}

											break;
											case 'order_customer_statistic_year':

											if($widget['enabled'] == 1){
												?>

												<!-- Order/Customer Statistics - Year -->
												<div class="order-customer-statistic-year c-widget c-widget-small span4">
													<h2><?php echo $text_statistics_year; ?></h2>
													<div class="dashboard-content">
														<div class="order-customer-legend clearfix">
															<div class="order-customer-legend-box stat-1">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_order, 0, -1); ?></div>
															</div>
															<div class="order-customer-legend-box stat-2">
																<div class="order-customer-legend-color">
																	<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																</div>
																<div class="order-customer-legend-text"><?php echo substr($text_total_customer, 0, -1); ?></div>
															</div>
														</div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div id="report-order-customer-statistic-year">
															<div id="order-customer-chart-year"></div>
														</div>
													</div>
												</div>

												<?php
											}

											break;
											case 'sales_value':

											if($widget['enabled'] == 1){
												?>

												<!-- Sales Value Stats -->
												<div class="sales-value c-widget c-widget-small span4">
													<h2><?php echo $text_statistics_sales; ?></h2>
													<div class="dashboard-content">
														<div class="dashboard-overview-outer clearfix">
															<div class="sales-value-chart">
																<input id="total_sale_raw" type="hidden" value="<?php echo substr($total_sale_raw, 0, -2); ?>" data-text-label="<?php echo $text_total_sale; ?>" data-currency-value="<?php echo $total_sale; ?>" />
																<input id="total_sale_year_raw" type="hidden" value="<?php echo substr($total_sale_year_raw, 0, -2); ?>" data-text-label="<?php echo $text_total_sale_year; ?>" data-currency-value="<?php echo $total_sale_year; ?>" />
																<input id="total_sales_previous_years_raw" type="hidden" value="<?php echo $total_sales_previous_years_raw; ?>" data-text-label="<?php echo $text_total_sales_previous_years; ?>" data-currency-value="<?php echo $total_sales_previous_years; ?>" />

																<div id="sales-value-chart"></div>
															</div>
															<div class="sales-value-legend">
																<div class="sales-this-year">
																	<div class="number-stat-legend-color">
																		<div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div>
																	</div>
																	<div class="number-stat-number"><?php echo $total_sale_year; ?></div>
																	<div class="number-stat-text"><?php echo substr($text_total_sale_year, 0, -1); ?></div>
																</div>
																<div class="sales-previous-years">
																	<div class="number-stat-legend-color">
																		<div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div>
																	</div>
																	<div class="number-stat-number"><?php echo $total_sales_previous_years; ?></div>
																	<div class="number-stat-text"><?php echo substr($text_total_sales_previous_years, 0, -1); ?></div>
																</div>
																<div class="sales-total">
																	<div class="number-stat-legend-color">
																		<div class="legend-color-box"></div>
																	</div>
																	<div class="number-stat-number"><?php echo $total_sale; ?></div>
																	<div class="number-stat-text"><?php echo substr($text_total_sale, 0, -1); ?></div>
																</div>
															</div>
															<div class="hidden colors"><?php echo $color; ?></div>
															<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
															<div class="sales-value-estimates">
																<div class="short-description"><?php echo $text_sales_value_short_description; ?></div>
																<div class="sales-value-estimates-figures">
																	<div class="estimates estimates-day clearfix">
																		<div class="sales-value-estimates-timeframe"><?php echo $text_sales_value_timeframe_day; ?></div>
																		<div class="sales-value-estimates-arrow">
																			<img src="view/image/admin_theme/base5builder_circloid/arrow-left-large.png" width="15" height="13" alt="" />
																		</div>
																		<div class="sales-value-estimates-amount">
																			<?php echo $average_sales_day; ?> <!-- Divide this by the number of days to date -->
																		</div>
																	</div>
																	<div class="estimates estimates-week clearfix">
																		<div class="sales-value-estimates-timeframe"><?php echo $text_sales_value_timeframe_week; ?></div>
																		<div class="sales-value-estimates-arrow">
																			<img src="view/image/admin_theme/base5builder_circloid/arrow-left-large.png" width="15" height="13" alt="" />
																		</div>
																		<div class="sales-value-estimates-amount">
																			<?php echo $average_sales_week; ?> <!-- Divide this by the number of weeks to date -->
																		</div>
																	</div>
																	<div class="estimates estimates-month clearfix">
																		<div class="sales-value-estimates-timeframe"><?php echo $text_sales_value_timeframe_month; ?></div>
																		<div class="sales-value-estimates-arrow">
																			<img src="view/image/admin_theme/base5builder_circloid/arrow-left-large.png" width="15" height="13" alt="" />
																		</div>
																		<div class="sales-value-estimates-amount">
																			<?php echo $average_sales_month; ?> <!-- Divide this by the number of months to date -->
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>

												<?php
											}

											break;
											case 'other_stats':

											if($widget['enabled'] == 1){
												?>

												<!-- Other Statistics -->
												<div class="other-stats c-widget c-widget-small span4">
													<h2><?php echo $text_other_stats; ?></h2>
													<div class="dashboard-content">
														<div class="other-stats-block stat-1">
															<div class="other-stats-block-number"><?php echo number_format($total_order); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_order'] ?>"><?php echo substr($text_total_order, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-2">
															<div class="other-stats-block-number"><?php echo number_format($total_customer); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_customer'] ?>"><?php echo substr($text_total_customer, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-3">
															<div class="other-stats-block-number"><?php echo number_format($total_newsletter_subscribers); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_newsletter_subscribers'] ?>"><?php echo substr($text_total_newsletter_subscribers, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-4">
															<div class="other-stats-block-number"><?php echo number_format($total_review); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_review'] ?>"><?php echo substr($text_total_review, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-5">
															<div class="other-stats-block-number"><?php echo number_format($total_customer_approval); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_customer_approval'] ?>"><?php echo substr($text_total_customer_approval, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-6">
															<div class="other-stats-block-number"><?php echo number_format($total_review_approval); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_review_approval'] ?>"><?php echo substr($text_total_review_approval, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-7">
															<div class="other-stats-block-number"><?php echo number_format($total_affiliate); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_affiliate'] ?>"><?php echo substr($text_total_affiliate, 0, -1); ?></a></div>
														</div>
														<div class="other-stats-block stat-8">
															<div class="other-stats-block-number"><?php echo number_format($total_affiliate_approval); ?></div>
															<div class="other-stats-block-text"><a href="<?php echo $other_stats_links['total_affiliate_approval'] ?>"><?php echo substr($text_total_affiliate_approval, 0, -1); ?></a></div>
														</div>
														<div class="clearfix"></div>
													</div>
												</div>

												<?php
											}

											break;
											case 'top_customers':

											if($widget['enabled'] == 1){

												?>

												<!-- Top 5 Customers -->
												<div class="top-customers c-widget c-widget-small span4">
													<h2><?php echo $text_top_customers; ?></h2>
													<div class="dashboard-content">
														<div class="short-description"><?php echo $text_top_customers_description; ?></div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_view"><?php echo $text_view; ?></div>
														<div class="hidden text_no_data"><?php echo $text_no_data; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div class="top-customers-chart-container">
															<div class="top-customers-details">
																<div class="range">
																	<div class="range-label"><?php echo $entry_range; ?></div>
																	<select id="range-top-customers">
																		<option value="day"><?php echo $text_day; ?></option>
																		<option value="week"><?php echo $text_week; ?></option>
																		<option value="month" selected="selected"><?php echo $text_month; ?></option>
																		<option value="year"><?php echo $text_year; ?></option>
																	</select>
																	<div class="clearfix"></div>
																</div>
															</div>
															<div class="top-customers-chart-outer">
																<div id="top-customers-chart"></div>
															</div>
															<div class="top-customers-list">
																<ul class="clearfix">
																	<li class="top-customers-1">
																		<div class="top-customer-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-customers-2">
																		<div class="top-customer-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-customers-3">
																		<div class="top-customer-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[2]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-customers-4">
																		<div class="top-customer-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[3]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-customers-5">
																		<div class="top-customer-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[4]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																</ul>
															</div>
															<div class="clearfix"></div>
														</div>
														<div class="clearfix"></div>
													</div>
												</div>

												<?php
											}

											break;
											case 'top_products':

											if($widget['enabled'] == 1){
												?>

												<!-- Top 5 Products -->
												<div class="top-products c-widget c-widget-small span4">
													<h2><?php echo $text_top_products; ?></h2>
													<div class="dashboard-content">
														<div class="short-description"><?php echo $text_top_products_description; ?></div>
														<div class="hidden colors"><?php echo $color; ?></div>
														<div class="hidden text_view"><?php echo $text_view; ?></div>
														<div class="hidden text_sold"><?php echo $text_sold; ?></div>
														<div class="hidden text_no_data"><?php echo $text_no_data; ?></div>
														<div class="hidden text_error_chart"><?php echo $text_error_chart; ?></div>
														<div class="top-products-chart-container">
															<div class="top-products-details">
																<div class="range">
																	<div class="range-label"><?php echo $entry_range; ?></div>
																	<select id="range-top-products">
																		<option value="day"><?php echo $text_day; ?></option>
																		<option value="week"><?php echo $text_week; ?></option>
																		<option value="month" selected="selected"><?php echo $text_month; ?></option>
																		<option value="year"><?php echo $text_year; ?></option>
																	</select>
																	<div class="clearfix"></div>
																</div>
															</div>
															<div class="top-products-chart-outer">
																<div id="top-products-chart"></div>
															</div>
															<div class="top-products-list">
																<ul class="clearfix">
																	<li class="top-products-1">
																		<div class="top-products-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[0]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-products-2">
																		<div class="top-products-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[1]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-products-3">
																		<div class="top-products-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[2]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-products-4">
																		<div class="top-products-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[3]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																	<li class="top-products-5">
																		<div class="top-products-legend-color"><div class="legend-color-box" style="background-color:<?php echo $colors[4]; ?>"></div></div>
																		<div class="list-name">--</div>
																	</li>
																</ul>
															</div>
															<div class="clearfix"></div>
														</div>
														<div class="clearfix"></div>
													</div>
												</div>

												<?php
											}

											break;
											case 'latest':

											if($widget['enabled'] == 1){
												?>

												<!-- Latest Orders -->
												<div class="latest c-widget c-widget-large span12">
													<h2><?php echo $text_latest_10_orders; ?></h2>
													<div class="dashboard-content">
														<table class="list">
															<thead>
																<tr>
																	<td class="right"><?php echo $column_order; ?></td>
																	<td class="left"><?php echo $column_customer; ?></td>
																	<td class="left"><?php echo $column_status; ?></td>
																	<td class="left"><?php echo $column_date_added; ?></td>
																	<td class="right"><?php echo $column_total; ?></td>
																	<td class="right"><?php echo $column_action; ?></td>
																</tr>
															</thead>
															<tbody>
																<?php if ($orders) { ?>
																<?php foreach ($orders as $order) { ?>
																<tr>
																	<td class="right"><?php echo $order['order_id']; ?></td>
																	<td class="left"><?php echo $order['customer']; ?></td>
																	<td class="left"><?php echo $order['status']; ?></td>
																	<td class="left"><?php echo $order['date_added']; ?></td>
																	<td class="right"><?php echo $order['total']; ?></td>
																	<td class="right"><?php foreach ($order['action'] as $action) { ?>
																		[ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
																		<?php } ?>
																	</td>
																</tr>
																<?php } ?>
																<?php } else { ?>
																<tr>
																	<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
																</tr>
																<?php } ?>
															</tbody>
														</table>
													</div>
													<div class="clearfix"></div>
												</div>

												<?php
											}

											break;
										}
									}
								}
							}
							?>
						</div>
					</div>
				</div>
				<?php }else{ ?>
				<div class="heading">
					<h1><img src="view/image/admin_theme/base5builder_circloid/icon-warning.png" alt="<?php echo $heading_almost_done; ?>" width="32" height="32" /> <?php echo $heading_almost_done; ?></h1>
				</div>
				<div class="content">
					<div class="dashboard-installation-outer">
						<div class="dashboard-installation-inner">
							<ul>
								<li class="text-success"><?php echo $text_install_step_1; ?></li>
								<?php //echo $menu_imported; ?>
								<?php if($menu_imported == FALSE){ ?>
								<li><?php echo $text_install_step_2; ?></li>
								<li><?php echo $text_install_step_3_before; ?></li>
								<?php }else{ ?>
								<li class="text-success"><?php echo $text_install_step_2_after; ?></li>
								<li><?php echo $text_install_step_3; ?></li>
								<?php } ?>
								<li><?php echo $text_install_step_4; ?></li>
							</ul>
						</div>
					</div>
				</div>
				<?php } ?>
			</div>
		</div> 
	</div> 
	<?php echo $footer; ?>
