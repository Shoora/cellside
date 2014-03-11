
	  				 <div id="my-tab-pageslayout" class="vtabs">
	  					<a href="#tab-pcategory" onclick="return false;"><?php echo $this->language->get('text_category_listing_page');?></a>
	  					<a href="#tab-pproduct" onclick="return false;"><?php echo $this->language->get('text_product_page');?></a>
	  					<a href="#tab-pcontact" onclick="return false;"><?php echo $this->language->get('text_contact_page');?></a>
	  				 </div> 
	  				 <div class="page-tabs-wrap">
			  			 <div class="clearfix" id="tab-pcategory">
			  			 	<div class="tab-inner">
			  			 		<table class="form">
			  			 			<tr>
			  			 				<td><?php echo $this->language->get('text_product_display_mode'); ?></td>
			  			 				<td>

			  			 					<select name="themecontrol[cateogry_display_mode]">
			  			 						<?php foreach( $cateogry_display_modes as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['cateogry_display_mode']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>	
			  			 			<tr>
			  			 				<td><?php echo $this->language->get('entry_listing_products_columns'); ?></td>
			  			 				<td>

			  			 					<select name="themecontrol[listing_products_columns]">
			  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['listing_products_columns']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>	
			  			 			 
			  			 			 <tr>
			  			 				<td><?php echo $this->language->get('entry_listing_products_columns_small'); ?></td>
			  			 				<td>

			  			 					<select name="themecontrol[listing_products_columns_small]">
			  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['listing_products_columns_small']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>	

			  			 			 <tr>
			  			 				<td><?php echo $this->language->get('entry_listing_products_columns_minismall'); ?></td>
			  			 				<td>

			  			 					<select name="themecontrol[listing_products_columns_minismall]">
			  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['listing_products_columns_minismall']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>

			  			 			<tr>
			  			 				<td><?php echo $this->language->get('text_show_product_zoom');?></td>
			  			 				<td>
			  			 					<select name="themecontrol[category_pzoom]">
			  			 						<?php foreach( $yesno  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['category_pzoom']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>	 
			  			 		</table>
			  			 	</div>
			  			 </div>
			  			  <div class="clearfix" id="tab-pproduct">
			  				<div class="tab-inner">
			  					<table class="form">
			  						<tr>
			  							<td><?php echo $this->language->get('text_enable_productzoom'); ?></td>
			  							<td>
			  								<select name="themecontrol[product_enablezoom]">
			  									<?php foreach( $yesno  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_enablezoom']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  								</select>
			  							</td>
			  						</tr>
			  						<tr>
			  							<td><?php echo $this->language->get('text_product_zoomgallery'); ?></td>
			  							<td>
			  								<select name="themecontrol[product_zoomgallery]">
			  									<?php foreach( $product_zoomgallery  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomgallery']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  								</select>
			  							</td>
			  						</tr>	
			  						<tr>
			  							<td><?php echo $this->language->get('text_product_zoommode'); ?></td>
			  							<td>
			  								<select name="themecontrol[product_zoommode]">
			  									<?php foreach( $product_zoom_modes  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoommode']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  								</select>
			  							</td>
			  						</tr>
			  						<tr>
			  							<td><?php echo $this->language->get('text_product_zoomlenssize'); ?></td>
			  							<td>
			  								<input value=<?php echo $module['product_zoomlenssize'];?> name="themecontrol[product_zoomlenssize]"/> 
			  							</td>
			  						</tr>
			  						<tr>
			  							<td><?php echo $this->language->get('text_product_zoomeasing'); ?></td>
			  							<td>
			  								<select name="themecontrol[product_zoomeasing]">
			  									<?php foreach( $yesno  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomeasing']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  								</select>
			  							</td>
			  						</tr>
			  						
			  						<tr>
			  							<td><?php echo $this->language->get('text_product_zoomlensshapes'); ?></td>
			  							<td>
			  								<select name="themecontrol[product_zoomlensshape]">
			  									<?php foreach( $product_zoomlensshapes  as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomlensshape']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  								</select>
			  							</td>
			  						</tr>

			  						<tr>
			  			 				<td><?php echo $this->language->get('text_product_related_column'); ?></td>
			  			 				<td>

			  			 					<select name="themecontrol[product_related_column]">
			  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['product_related_column']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>

			  			 			<tr>
			  			 				<td colspan="1"><h4><?php echo $this->language->get('text_add_product_tab');?></h4></td>
			  			 				<td>
			  			 					<select name="themecontrol[enable_product_customtab]">
			  			 						<?php foreach( $yesno as $k=>$v ) { ?>
			  			 					 		<option value="<?php echo $k;?>"  <?php if( $k==$module['enable_product_customtab']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
			  			 						<?php }  ?>	
			  			 					</select>
			  			 				</td>
			  			 			</tr>
			  			 			<tr>
			  			 				
			  			 				<td colspan="2">
			  			 					 
			  			 					<table class="form">
			  			 					<?php   foreach( $languages as $language ) {  

			  			 							 $customtab_name = isset($module['product_customtab_name'][$language['language_id']])
			  			 							 				?$module['product_customtab_name'][$language['language_id']] :"";
			  			 							 $customtab_content = isset($module['product_customtab_content'][$language['language_id']])?$module['product_customtab_content'][$language['language_id']]:"";				
			  			 					 ?>
			  			 						<tr>
			  			 						<td>  <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name'];?> 	</td>
			  			 						<td>
			  			 						 	<p>
			  			 							 <label> <?php echo $this->language->get('entry_customtab_name');?></label>	</p>

					  			 					 <p><input size="80" type="text"  name="themecontrol[product_customtab_name][<?php echo $language['language_id'];?>]" value="<?php echo $customtab_name;?>"/></p>
					  			 					 
					  			 					 <label> <?php echo $this->language->get('entry_customtab_content');?> 	
			  			 							<textarea id="customtab-content-<?php echo $language['language_id']; ?>"  style="width:90%; height:300px" name="themecontrol[product_customtab_content][<?php echo $language['language_id'];?>]"><?php echo $customtab_content;?></textarea>
			  			 						 	</td>
			  			 						</tr>
			  			 					<?php } ?>	
			  			 					</table>
			  			 				</td>
			  			 			</tr>

			  			 				
			  					</table>
			  				</div>
			  			 </div>

			  			 <div id="tab-pcontact">
			  			 	<div class="tab-inner">
			  			 		
			  			 		<table class="form">
			  			 			<tr>
			  			 				<td class="" colspan="2"><h4><?php echo $this->language->get('text_contact_html'); ?></h4></td>
			  			 			</tr>
			  			 			<?php foreach( $languages as $language ) {  ?>
			  			 			<tr>
			  			 				<td>
			  			 					<?php 
			  			 						$contact_customhtml = isset($module['contact_customhtml'][$language['language_id']])?
			  			 						$module['contact_customhtml'][$language['language_id']]:""; 
			  			 					 ?>
			  			 					 <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
			  			 					 <?php echo $language['name'];?> 
			  			 				</td>
			  			 				<td>
			  			 					<textarea style="width:90%; height:300px" id="contact_customhtml<?php echo $language['language_id'];?>" name="themecontrol[contact_customhtml][<?php echo $language['language_id'];?>]"><?php echo $contact_customhtml;?></textarea>
			  			 				</td>
			  			 			<tr>
			  			 			<?php } ?>	
			  			 		</table>	
			  			 	</div>	
			  			 </div>

			  			
			  			</div>  <div class="clear clearfix"></div>