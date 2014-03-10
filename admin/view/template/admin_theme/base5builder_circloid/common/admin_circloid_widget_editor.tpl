<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<div class="box">
		<div class="heading">
			<div class="loading">
				<img src="view/image/admin_theme/base5builder_circloid/loading.gif" width="32" height="32" alt="Loading" >
			</div>
			<h1><img src="view/image/admin_theme/base5builder_circloid/icon-dashboard.png" alt="Dashboard" width="32" height="32" /> <?php echo $heading_widget_editor; ?></h1>
			<?php if(isset($this->request->get['layout_id']) && $user_created){ ?>
			<div class="buttons">
				<button class="btn  btn-success save-layout" href=""><?php echo $button_save; ?></button>
				<a class="btn btn-danger" href="<?php echo $return_dashboard_editor; ?>"><?php echo $button_close; ?></a>
			</div>
			<?php } ?>
		</div>
		<div class="content">
			<div id="layout-editor-outer">
				<div id="layout-editor-inner">
					<?php
					if(!isset($this->request->get['layout_id'])){
							// 	display error message
							// check if the ID is for a widget created by user or theme
							// if theme, then show error message preventing editing it.
							// if user, then allow editing to continue normally
						?>
						<div class="warning"><?php echo $error_widget_editor; ?></div>
						<?php
					}else{
						if($user_created){
							?>
							<div class="layout-details">
								<form>
									<div class="form-item hidden">
										<input type="hidden" name="layout-id" id="layout-id" class="input-block-level" value="<?php echo $widget_data['id']; ?>" maxlength="35">
										<input type="hidden" name="layout-enabled" id="layout-enabled" class="input-block-level" value="<?php echo $widget_data['enabled']; ?>" maxlength="1">
									</div>
									<div class="form-item">
										<label for="layout-name"><?php echo $text_layout_name; ?> </label>
										<input type="text" name="layout-name" id="layout-name" class="input-block-level" placeholder="Layout Name (20 characters max.)" value="<?php echo $widget_data['layout_name']; ?>" maxlength="35">
									</div>
									<div class="form-item">
										<label for="description"><?php echo $text_layout_description; ?> </label>
										<input type="text" name="description" id="description" class="input-block-level" placeholder="Description (100 characters max.)" value="<?php echo $widget_data['description']; ?>" maxlength="100">
									</div>
								</form>
							</div>
							<div id="layout-editor-left" class="hidden-small-phone">
								<div class="disabled-widgets">
									<h2><?php echo $title_disabled_widgets ?></h2>
									<div class="short-description"><?php echo $text_disabled_widget_desc; ?></div>
									<ul id="sortable1" class="connectedSortable">
										<?php
										$widgets = unserialize($widget_data['layout']);
										$count = 1;
										foreach ($widgets as $widget) {
											if($widget['enabled'] == 0){

												?>
												<li class="disabled-widget" data-widget-name="<?php echo $widget['name']; ?>" data-widget-id="<?php echo $widget['widget_id']; ?>">
													<div class="widget-details">
														<div class="widget-details-number"><?php echo $count; ?></div>
														<div class="widget-details-name">
															<?php

															switch ($widget['name']) {
																case 'order_customer_statistic':
																echo $text_widget_order_customer_statistic;
																break;

																case 'order_customer_statistic_day':
																echo $text_widget_order_customer_statistic_day;
																break;

																case 'order_customer_statistic_week':
																echo $text_widget_order_customer_statistic_week;
																break;

																case 'order_customer_statistic_month':
																echo $text_widget_order_customer_statistic_month;
																break;

																case 'order_customer_statistic_year':
																echo $text_widget_order_customer_statistic_year;
																break;

																case 'sales_value':
																echo $text_widget_sales_value;
																break;

																case 'other_stats':
																echo $text_widget_other_stats;
																break;

																case 'top_customers':
																echo $text_widget_top_customers;
																break;

																case 'top_products':
																echo $text_widget_top_products;
																break;

																case 'latest':
																echo $text_widget_latest;
																break;
															}
															?>
														</div>
														<div class="widget-details-colors">
															<?php
															foreach($widget['colors'] as $key => $color){
																$key_id = $key + 1;
																?>
																<input type="hidden" name="<?php echo $widget['name']; ?>-color-<?php echo $key_id; ?>" id="<?php echo $widget['name']; ?>-color-<?php echo $key_id; ?>" value="<?php echo $color; ?>" maxlength="7" data-widget-name="<?php echo $widget['name']; ?>" data-widget-id="<?php echo $widget['widget_id']; ?>">
																<?php
															}
															?>
														</div>
													</div>
												</li>
												<?php
												$count += 1;
											}
										}
										?>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="enabled-widgets">
									<h2><?php echo $title_enabled_widgets ?></h2>
									<div class="short-description"><?php echo $text_enabled_widget_desc; ?></div>
									<ul id="sortable2" class="connectedSortable">
										<?php
										$widgets = unserialize($widget_data['layout']);
										$count = 1;
										foreach ($widgets as $widget) {
											if($widget['enabled'] == 1){

												?>
												<li class="enabled-widget" data-widget-name="<?php echo $widget['name']; ?>" data-widget-id="<?php echo $widget['widget_id']; ?>">
													<div class="widget-details">
														<div class="widget-details-number"><?php echo $count; ?></div>
														<div class="widget-details-name">
															<?php

															switch ($widget['name']) {
																case 'order_customer_statistic':
																echo $text_widget_order_customer_statistic;
																break;

																case 'order_customer_statistic_day':
																echo $text_widget_order_customer_statistic_day;
																break;

																case 'order_customer_statistic_week':
																echo $text_widget_order_customer_statistic_week;
																break;

																case 'order_customer_statistic_month':
																echo $text_widget_order_customer_statistic_month;
																break;

																case 'order_customer_statistic_year':
																echo $text_widget_order_customer_statistic_year;
																break;

																case 'sales_value':
																echo $text_widget_sales_value;
																break;

																case 'other_stats':
																echo $text_widget_other_stats;
																break;

																case 'top_customers':
																echo $text_widget_top_customers;
																break;

																case 'top_products':
																echo $text_widget_top_products;
																break;

																case 'latest':
																echo $text_widget_latest;
																break;
															}
															?>
														</div>
														<div class="widget-details-colors">
															<?php
															foreach($widget['colors'] as $key => $color){
																$key_id = $key + 1;
																?>
																<input type="hidden" name="<?php echo $widget['name']; ?>-color-<?php echo $key_id; ?>" id="<?php echo $widget['name']; ?>-color-<?php echo $key_id; ?>" value="<?php echo $color; ?>" maxlength="7" data-widget-name="<?php echo $widget['name']; ?>" data-widget-id="<?php echo $widget['widget_id']; ?>">
																<?php
															}
															?>
														</div>
													</div>
												</li>
												<?php
												$count += 1;
											}
										}
										?>
									</ul>
									<div class="clearfix"></div>
								</div>
							</div>
							<div id="layout-editor-right" class="hidden-small-phone">
								<div class="layout-editor-preview-outer">
									<div class="layout-editor-preview-inner">
										<div id="preview-box">
											<div class="preview-layout">
												<button class="btn preview-button" href=""><?php echo $button_preview_layout; ?></button>
											</div>
											<div class="preview-content-box row-fluid clearfix">
												<?php
												$widgets = unserialize($widget_data['layout']);
												$count = 1;
												foreach ($widgets as $widget) {
													if($widget['enabled'] == 1){
														switch ($widget['name']) {
															case 'order_customer_statistic':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span12">
																<?php echo $text_widget_order_customer_statistic; ?>
															</div>
															<?php
															break;

															case 'order_customer_statistic_day':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_order_customer_statistic_day; ?>
															</div>
															<?php
															break;

															case 'order_customer_statistic_week':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_order_customer_statistic_week; ?>
															</div>
															<?php
															break;

															case 'order_customer_statistic_month':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_order_customer_statistic_month; ?>
															</div>
															<?php
															break;

															case 'order_customer_statistic_year':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_order_customer_statistic_year; ?>
															</div>
															<?php
															break;

															case 'sales_value':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_sales_value; ?>
															</div>
															<?php
															break;

															case 'other_stats':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_other_stats; ?>
															</div>
															<?php
															break;

															case 'top_customers':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_top_customers; ?>
															</div>
															<?php
															break;

															case 'top_products':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span4">
																<?php echo $text_widget_top_products; ?>
															</div>
															<?php
															break;

															case 'latest':
															?>
															<div class="preview-box-widget preview-box-<?php echo $widget['name'];?> span12">
																<?php echo $text_widget_latest; ?>
															</div>
															<?php
															break;
														}
													}
												}
												?>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="screen-size-warning visible-small-phone">
								<?php echo $text_screen_too_small; ?>
							</div>
							<?php
						}else{
							?>
							<div class="warning"><?php echo $error_widget_editor; ?></div>
							<?php
						}
					}
					?>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
</div> 
<?php echo $footer; ?>