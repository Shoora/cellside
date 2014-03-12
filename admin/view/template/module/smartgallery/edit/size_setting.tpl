<form class="form-horizontal"><table class="table table-condensed no-border"><tbody><!-- ***************Main************* -->	<tr><td colspan="2"><legend>Main</legend></td></tr>	<tr><!-- ******* Gallery Width -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="gallery-width">Gallery width</label>				<div class="controls">					<input class="span1" id="gallery-width" type="text" value="<?php echo $options['gallery']['width']; ?>" name="width"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Gallery width:</dt>				<dd>					The Gallery width in pixels or %. Here you can type pixels (for instance '300px'), and percentage. For responsive layout  leave it blank.				</dd>			</dl>		</td>	</tr>	<tr><!-- ******* Gallery Height -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="gallery-height">Gallery height</label>				<div class="controls">					<input class="span1" id="gallery-height" type="text" value="<?php echo $options['gallery']['height']; ?>" name="height"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Gallery height:</dt>				<dd>					The Gallery height in pixels or %. Here you can type pixels (for instance '300px'),  percentage (relative to the width of the slideshow, for instance '50%') or leave it blank for auto.				</dd>			</dl>		</td>	</tr>		<tr><!-- ******* Gallery Minimum Height -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="gallery-minHeight">Gallery minimum height</label>				<div class="controls">					<input class="span1" id="gallery-minHeight" type="text" value="<?php echo $options['gallery']['minHeight']; ?>" name="minHeight"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Gallery minimum height:</dt>				<dd>					The Gallery minimum height in pixels.You can also leave it blank.				</dd>			</dl>		</td>	</tr><!-- ***************Thumbnail************* -->	<tr><td colspan="2"><legend>Thumbnail</legend></td></tr>		<tr><!-- ******* Thumbnail Width -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="thumb-width">Thumbnail width</label>				<div class="controls">					<input class="span1" id="thumb-width" type="text" value="<?php echo $options['thumb']['width']; ?>" name="width"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Thumbnail width:</dt>				<dd>					The Thumbnail width in pixels. Here you can type pixels (for instance '60px')				</dd>			</dl>		</td>	</tr>	<tr><!-- ******* Thumbnail Height -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="thumb-height">Thumbnail height</label>				<div class="controls">					<input class="span1" id="thumb-height" type="text" value="<?php echo $options['thumb']['height']; ?>" name="height" />				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Thumbnail height:</dt>				<dd>					The Thumbnail height in pixels. Here you can type pixels (for instance '60px').				</dd>			</dl>		</td>	</tr>	<tr><!-- ******* Distance between thumbnails -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="thumb-distance">Distance between thumbnails</label>				<div class="controls">					<input class="span1" id="thumb-distance" type="text" value="<?php echo $options['thumb']['distance']; ?>" name="distance"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Distance between thumbnails:</dt>				<dd>					Here you can change distance between thumbnails in px. If your products has long names we recommend increase this value.<p class="info-warning">(!)This parameter work only if "View Setting"->"Display Mode"->"Slider mode" and turn ON "Show Product's name"</p>				</dd>			</dl>		</td>	</tr>		<!-- ***************Image************* -->	<tr><td colspan="2"><legend>Image</legend></td></tr>	<tr><!-- ******* Image Width -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="image-width">Image width</label>				<div class="controls">					<input class="span1" id="image-width" type="text" value="<?php echo $options['image']['width']; ?>" name="width"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Image width:</dt>				<dd>					Here you can type image width of product in pixels (for instance '600px').				</dd>			</dl>		</td>	</tr>		<tr><!-- ******* Image Height -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="image-height">Image height</label>				<div class="controls">					<input class="span1" id="image-height" type="text" value="<?php echo $options['image']['height']; ?>" name="height"/>				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Image height:</dt>				<dd>					Here you can type image height of product in pixels (for instance '600px').				</dd>			</dl>		</td>	</tr>		<tr><!-- ******* Image Cropped -->		<td>			<fieldset>			<div class="control-group">				<label class="control-label" for="gallery-croped">Image resize</label>				<div class="controls">					<input type="hidden" name="data[gallery][croped]" value="">					<input id="gallery-croped" type="checkbox" value="true" <?php if($options['gallery']['croped']) echo ' checked="checked" '; ?> name="croped" class="on_off" />				</div>			</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt>Image resize by Gallery size:</dt>				<dd>					Select ON and image size will be proportional to Gallery container				</dd>			</dl>		</td>	</tr>	<tbody></table></form>