<?php 
 
 
 

?>


            <ul class="nav nav-tabs" id="myTab">
 
              <li><a href="#layout"><?php echo $this->language->get('text_layout');?></a></li>
              <li><a href="#elements"><?php echo $this->language->get('text_elements');?></a></li>
            </ul>

            <div class="tab-content" >
             
                  <div class="tab-pane" id="layout">

                        <div class="accordion"  id="pav-accordion1">

                         <div class="accordion-group">
                            <div class="accordion-heading">
                              <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion1" href="#collapseBody">
                              	<?php echo $this->language->get('text_body');?>
                              </a>
                            </div>
                            <div id="collapseBody" class="accordion-body collapse in">
                              <div class="accordion-inner clearfix">
                                  <div class="form-group">
                              		<label> <?php echo $this->language->get('text_background_color');?></label>
                              	 	<input value="" name="customize[body][]" data-match="body" type="text" class="color" data-selector="body #page-container" data-attrs="background-color">
                                  </div>

                                  <div class="form-group"> 
                              	 	<label><?php echo $this->language->get('text_text_color');?> </label>
                              	 	<input value="" name="customize[body][]" data-match="body"  type="text" class="color" data-selector="body #page-container" data-attrs="color">
                                  </div>

                                  <div class="form-group"> 
                              	 	<label><?php echo $this->language->get('text_link_color');?></label>
                              	 	<input value="" name="customize[body][]"  data-match="body"  type="text" class="color" data-selector="body #page-container a" data-attrs="color">
                                  </div>

                                  <div class="form-group clearfix"> 
                              	 	<label><?php echo $this->language->get('text_link_hover_color');?></label>
                                
                              	 	<input value="" type="text" name="customize[body][]" data-match="body"  class="color" data-selector="body #page-container a:hover" data-attrs="color">
                                  </div>


                                   <div class="form-group background-images"> 
                                   <label><?php echo $this->language->get('text_background_image');?></label>
                                     <a class="clear-bg label label-success" href="#">Clear</a>
                                     <input value="" type="hidden" name="customize[body][]" data-match="body"  class="color" data-selector="body #page-container" data-attrs="background-image">
                                    <div class="clearfix"></div>
                                    <div class="bi-wrapper clearfix">
                                      <?php foreach( $patterns as $pattern ) { ?>
                                      <div style="background:url('<?php echo $backgroundImageURL.$pattern;?>') no-repeat center center;" class="pull-left" data-image="<?php echo $backgroundImageURL.$pattern;?>" data-val="../../image/pattern/<?php echo $pattern;?>">

                                      </div>
                                      <?php } ?>
                                    </div>
                                  </div>


                              </div>
                            </div>
                          </div>



                          <div class="accordion-group">
                            <div class="accordion-heading">
                              <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion1" href="#collapseOne">
                              	 <?php echo $this->language->get('text_header');?>
                              </a>
                            </div>
                            <div id="collapseOne" class="accordion-body collapse">
                              <div class="accordion-inner clearfix">
                                  <div class="form-group">
                              		<label><?php echo $this->language->get('text_background_color');?></label>
                              	 	<input value="" type="text" name="customize[header][]" data-match="header"  class="color" data-selector="#header .container" data-attrs="background-color">
                                 </div>

                                  <div class="form-group">
                              	 	<label><?php echo $this->language->get('text_text_color');?> </label>
                              	 	<input value="" type="text" name="customize[header][]" data-match="header"  class="color" data-selector="#header " data-attrs="color">
                                  </div>

                                  <div class="form-group"> 
                              	 	<label><?php echo $this->language->get('text_link_color');?></label>
                              	 	<input value="" type="text" name="customize[header][]" data-match="header"  class="color" data-selector="#header a" data-attrs="color">
                                  </div>

                                  <div class="form-group background-images"> 
                                   <label><?php echo $this->language->get('text_background_image');?></label>
                                     <a class="clear-bg label label-success" href="#">Clear</a>
                                     <input value="" type="hidden" name="customize[header][]" data-match="header"  class="color" data-selector="#header .container" data-attrs="background-image">
                                    <div class="clearfix"></div>
                                    <div class="bi-wrapper clearfix">
                                      <?php foreach( $patterns as $pattern ) { ?>
                                      <div style="background:url('<?php echo $backgroundImageURL.$pattern;?>') no-repeat center center;" class="pull-left" data-image="<?php echo $backgroundImageURL.$pattern;?>" data-val="../../image/pattern/<?php echo $pattern;?>">

                                      </div>
                                      <?php } ?>
                                    </div>
                                  </div>

                              </div>
                            </div>
                          </div>

                          <div class="accordion-group">
                            <div class="accordion-heading">
                              <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion1" href="#collapseTwo">
                               <?php echo $this->language->get('text_mainnav');?>
                              </a>
                            </div>
                            <div id="collapseTwo" class="accordion-body collapse">
                              <div class="accordion-inner clearfix">
                            
                            <div class="form-group">      
                        		<label><?php echo $this->language->get('text_background_color');?></label>
                        		<input value="" type="text" name="customize[mainnav][]"  data-match="mainnav"  class="color" data-selector="#mainnav .mainnav-inner" data-attrs="background-color">
                            </div>

                            <div class="form-group">  
                        		<label><?php echo $this->language->get('text_link_color');?></label>
                        		<input value="" type="text" name="customize[mainnav][]"  data-match="mainnav"  class="color" data-selector="#mainnav a" data-attrs="color">
                            </div>

                            <div class="form-group">  
                        		<label><?php echo $this->language->get('text_link_color');?></label>
                        		<input value="" type="text" name="customize[mainnav][]" data-match="mainnav"   class="color" data-selector="#mainnav a:hover" data-attrs="color">
                            </div>

                              </div>
                            </div>
                          </div>
                          <div class="accordion-group">
                            <div class="accordion-heading">
                              <a class="accordion-toggle" data-toggle="collapse" data-match="body"  data-parent="#pav-accordion1" href="#collapseThree">
                              <?php echo $this->language->get('text_footer');?>
                              </a>
                            </div>
                            <div id="collapseThree" class="accordion-body collapse">

                                    <div class="accordion-inner clearfix">
                                    <div class="form-group">    
                                    <label><?php echo $this->language->get('text_background_color');?></label>
                                		<input value="" type="text" name="customize[footer][]" data-match="footer"  class="color" data-selector=".footer-center .container" data-attrs="background-color">
                                    </div>
                                    <div class="form-group">
                                		<label><?php echo $this->language->get('text_text_color');?></label>
                                		<input value="" type="text" name="customize[footer][]" data-match="footer"  class="color" data-selector=".footer-center div" data-attrs="color">
                                    </div>
                                    <div class="form-group">
                                		<label><?php echo $this->language->get('text_link_color');?></label>
                                		<input value="" type="text" name="customize[footer][]" data-match="footer"  class="color" data-selector=".footer-center a" data-attrs="color">
                                     </div>
                                    
                                    <div class="form-group">
                                		<label><?php echo $this->language->get('text_link_hover_color');?></label>
                                		<input value="" type="text" name="customize[footer][]" data-match="footer"  class="color" data-selector=".footer-center a:hover" data-attrs="color">
                                    </div>

                                    <div class="form-group background-images"> 
                                   <label><?php echo $this->language->get('text_background_image');?></label>
                                     <a class="clear-bg label label-success" href="#">Clear</a>
                                     <input value="" type="hidden" name="customize[footer][]" data-match="footer"  class="color" data-selector=".footer-center .container" data-attrs="background-image">
                                    <div class="clearfix"></div>
                                    <div class="bi-wrapper clearfix">
                                      <?php foreach( $patterns as $pattern ) { ?>
                                      <div style="background:url('<?php echo $backgroundImageURL.$pattern;?>') no-repeat center center;" class="pull-left" data-image="<?php echo $backgroundImageURL.$pattern;?>" data-val="../../image/pattern/<?php echo $pattern;?>">

                                      </div>
                                      <?php } ?>
                                    </div>
                                  </div>


                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="tab-pane" id="elements">
                          <div class="accordion" id="pav-accordion2">
                            <div class="accordion-group">
                                <div class="accordion-heading">
                                  <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion2" href="#collapseTwoFORM">
                                   <?php echo $this->language->get('text_button');?> 
                                  </a>
                                </div>
                                <div id="collapseTwoFORM" class="accordion-body collapse in">
                                  <div class="accordion-inner clearfix">
                                      <div class="form-group">
                                      <label> <?php echo $this->language->get('text_text_color');?> </label>
                                        <input value="" type="text" name="customize[form][]"  data-match="form"  class="color" data-selector="a.button, input.button" data-attrs="color">
                                     </div>
                                      <div class="form-group">
                                       <label><?php echo $this->language->get('text_background_color');?></label>
                                        <input value="" type="text" name="customize[form][]"  data-match="form"  class="color" data-selector="a.button, input.button" data-attrs="background-color">
                                       </div>
                                      
                                       
                                  </div>
                                </div>
                              </div>


                             <div class="accordion-group">
                                <div class="accordion-heading">
                                  <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion2" href="#collapseTwoHEAD">
                                <?php echo $this->language->get('text_heading');?>
                                  </a>
                                </div>
                                <div id="collapseTwoHEAD" class="accordion-body collapse">
                                  <div class="accordion-inner clearfix">
                                      <div class="form-group">
                                      <label><?php echo $this->language->get('text_heading_page');?></label>  
                                        <input value="" type="text" name="customize[heading][]"  data-match="heading"  class="color" data-selector="body h1" data-attrs="color">
                                      
                                       </div>
                                      <div class="form-group">
                                      <label><?php echo $this->language->get('text_heading_text');?></label>  
                                        <input value="" type="text" name="customize[heading][]"  data-match="heading"  class="color" data-selector="body h2,body h3,body h4" data-attrs="color">
                                      </div>  
                                  </div>
                                </div>
                              </div>


                               <div class="accordion-group">
                                <div class="accordion-heading">
                                  <a class="accordion-toggle" data-toggle="collapse" data-parent="#pav-accordion2" href="#collapseTwoPB">
                                  Product Block
                                  </a>
                                </div>
                                <div id="collapseTwoPB" class="accordion-body collapse">
                                  <div class="accordion-inner clearfix">
                                      
                                      <div class="form-group">
                                      <label><?php echo $this->language->get('Product Title')?></label>
                                      <input value="" type="text" name="customize[product_block][]"  data-match="product_block"  class="color" data-selector=".product-block .name a" data-attrs="color">
                                      </div>  
                                      <div class="form-group">
                                      <label><?php echo $this->language->get('Product Price')?> </label>
                                      <input value="" type="text" name="customize[product_block][]"  data-match="product_block"  class="color" data-selector=".product-block .price" data-attrs="color">
                                      </div>   
                                      <div class="form-group">
                                      <label><?php echo $this->language->get('Price Old')?></label>
                                      <input value="" type="text" name="customize[product_block][]"  data-match="product_block"  class="color" data-selector=".product-block .price-old" data-attrs="color">
                                      </div>  
                                  </div>
                                </div>
                              </div>
                           </div>     

                      </div>
            </div>
