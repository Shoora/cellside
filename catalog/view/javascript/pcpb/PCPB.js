function PCPB(id, viewOnly){
	var THIS = this;
	if(id == null || id == '')
	{	
		console.log('error roi');
		return;
	}
	this._canvas = new fabric.Canvas(id);
	if(typeof(viewOnly) == 'undefined' || viewOnly != true){
		this._canvas.on('mouse:up', function(o) {
			if(o.target !== undefined){	
				THIS.selectedTarget();
			} 
			else{
				$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
			}
		});
	}
	this.selectedTarget = function(){
		var c = this._canvas;
		var t = c.getActiveObject();
		//if(t == null)
			$('#pcpb_edit_text,#pcpb_edit_image,#pcpb_edit_background').hide();
		if(t.type=='text'){
			//text
			$('#pcpb_text_content').val(t.getText());
			$('#pcpb_text_font').val(t.getFontFamily());
			$('#pcpb_text_fontsize').val(t.getFontSize());
			$('#pcpb_text_color').val(rgb2hex(t.getFill()));
			$('#pcpb_edit_image').hide();
			$('#pcpb_edit_text').show();
		}else if(t.type=='image'){
			//image
			$('#pcpb_edit_text').hide();
			$('#pcpb_edit_image').show();
			if(changeImageInit == false){
				changeImageInit = true;
				$('#pcpb_image_upload').ajaxUploadPrompt({
					type: 'POST',
					url: 'index.php?route=pcpb/upload',
					dataType: 'json',
					success: function(datas){
						if(typeof(datas) == 'string')
						{
							//fix for IE problem
							eval('datas = ' + datas);
						}
						if(datas.errorCode != 0)
							alert(datas.errorMessage);
						else{
							var imagePath = datas.imagePath;
							pcpb.setCurrentImagePath(imagePath,datas.size['0'],datas.size['1']);
						}
					}
				});
			}
		}
	};
	var flag1 = true;
	this.addText = function(content,width_img,height_img){	
		$('#selector-layout').show();
		//resize popup
		var width = 388 + width_img;
		if(width < 910)
			width = 910;
		var height = 140 + 150 + height_img;
		var changeBGInit = false;
		var changeImageInit = false;
		if(flag1 == true){
			parent.resizePopupPCPB(width, height);
			flag1 = false;
		}
		
		var c = this._canvas;
		var text = new fabric.Text(content, {
			top: 18,
			left: 50,
			fontSize: 25,
			cornerSize: 5,
			borderColor: 'red',
			cornerColor: 'green',
		});
		text.lockScalingX = text.lockScalingY = true;
		c.add(text);
		c.setActiveObject(text);
        c.setZIndex = 1;
		$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text') {
				$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
				index -= 1;
			}
			if(obj.type == 'image') {
				if(obj.getSrc() != c.backgroundImage.src) {
					$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
				}
				index -= 1;
			}
		});
		slider.reloadSlider();
		this.selectedTarget();
	};
	this.saveTextSetting = function(){
		var c = this._canvas;
		var textObject = c.getActiveObject();        
        if(c.getObjects().length > 0){
        if(textObject.type != 'text')
			return;
		textObject.setText($('#pcpb_text_content').val());
        var fonts = $('#pcpb_text_font').text();
        var re = /((\s*\S+)*)\s*/;
        fonts = fonts.replace(re, "$1");
		textObject.setFontFamily(fonts);
		textObject.setFontSize(parseInt($('#pcpb_text_fontsize').val()));
		var hex = $('#pcpb_text_color').val();
		if(checkHex(hex))
			textObject.setFill(hex);
		c.renderAll();
		
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('font-family',textObject.getFontFamily());
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('font-size','40px');
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().css('color',textObject.getFill());
		$('ul.bxslider').find('li.item_'+ c.getObjects().indexOf(textObject)).children().children().html(textObject.text);
		
		this.selectedTarget();
        }
	};
	this.flipHorizontalImage = function(){
		var c = this._canvas;
		var imgObject = c.getActiveObject();
		if(imgObject.type != 'image')
			return;
		var newFlipX = !imgObject.getFlipX();
		imgObject.setFlipX(newFlipX);
		c.renderAll();
	};
	this.flipVerticalImage = function(){
		var c = this._canvas;
		var imgObject = c.getActiveObject();
		if(imgObject.type != 'image')
			return;
		var newFlipY = !imgObject.getFlipY();
		imgObject.setFlipY(newFlipY);
		c.renderAll();
	};
	this.deleteActiveObject = function(){
		var c = this._canvas;
		var o = c.getActiveObject();
		c.remove(o);
		c.renderAll();
		$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text') {
				$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
				index -= 1;
			}
			if(obj.type == 'image') {
				if(obj.getSrc() != c.backgroundImage.src) {
					$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
				}
				index -= 1;
			}
		});
		slider.reloadSlider();
		//this.selectedTarget();
	};
	this.copyActiveObject = function(){
		var c = this._canvas;
		var no = fabric.util.object.clone(c.getActiveObject());
		no.set("top", no.height/2);
        no.set("left", no.width/2);
		c.add(no);
		$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text') {
				$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
				index -= 1;
			}
			if(obj.type == 'image') {
				if(obj.getSrc() != c.backgroundImage.src) {
					$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
				}
				index -= 1;
			}
		});
		slider.reloadSlider();
		this.selectedTarget();
	};
	this.addImage = function(url,width_img,height_img){	
		//resize popup
		var width = 388 + width_img;
		if(width < 910)
			width = 910;
		var height = 140 + 150 + height_img;
		var changeBGInit = false;
		var changeImageInit = false;
		if(flag1 == true){
			parent.resizePopupPCPB(width, height);
			flag1 = false;
		}
		
		var c = this._canvas;
		fabric.Image.fromURL(url, function(img) {
			img.set({
				top:img.height/2,
				left:img.width/2,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green'
			})
			c.add(img);
			c.setActiveObject(img);
			$('#selector-layout').show();
			$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
			c.forEachObject(function(obj){
				if(obj.type == 'text') {
					$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
					index -= 1;
				}
				if(obj.type == 'image') {
					if(obj.getSrc() != c.backgroundImage.src) {
						$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
					}
					index -= 1;
				}
			});
			slider.reloadSlider();
			THIS.selectedTarget();
		});
	};
	
	//button Move to Front
	this.movetoFront = function(){
		var c = this._canvas;
		if(c.getActiveObject() != null){
			c.getActiveObject().bringForward();
		}
		$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
			c.forEachObject(function(obj){
				if(obj.type == 'text') {
					$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
					index -= 1;
				}
				if(obj.type == 'image') {
					if(obj.getSrc() != c.backgroundImage.src) {
						$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
					}
					index -= 1;
				}
			});
			slider.reloadSlider();
	};
	var flag = true;
	//button Move to Back
	this.movetoBack = function(){
		var c = this._canvas;
		if(c.getActiveObject() != null){
			if(c.getObjects().indexOf(c.getActiveObject()) != 0) {
				c.getActiveObject().sendBackwards();
			}
			else {
				fabric.Image.fromURL(c.backgroundImage.src, function(img) {
					img.set({
						top:c.height/2,
						left:c.width/2,
						width: c.width,
						height: c.height,
						cornerSize: 5,
						borderColor: 'red',
						cornerColor: 'green',
						selectable: false						
					})
					if(flag==true) {
						c.add(img);
						c.setActiveObject(img);
						c.getActiveObject().sendToBack();
						c.setActiveObject(c.item(1));
						c.getActiveObject().sendToBack();
						flag=false;
					}
				});
				
				
			}
			$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
			c.forEachObject(function(obj){
				if(obj.type == 'text') {
					$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
					index -= 1;
				}
				if(obj.type == 'image') {
					if(obj.getSrc() != c.backgroundImage.src) {
						$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
					}
					index -= 1;
				}
			});
			slider.reloadSlider();
		}
	};
	
	//set active object
	this.setActive = function(index){
		var c = this._canvas;
		c.setActiveObject(c.item(index));
		this.selectedTarget();
	};
	
	this.setCurrentImagePath = function(path, width, height){
		
		var c = this._canvas;
		var oldImg = c.getActiveObject();
		if(oldImg.type != 'image')
			return;
		if(typeof(width) == 'undefined')
			var width = oldImg.getWidth();
		if(typeof(height) == 'undefined')
			var height = oldImg.getHeight();
		width=parseInt(width);
		height=parseInt(height);
		var top = oldImg.getTop();
		var left = oldImg.getLeft();

		var ratioWidth = width/c.width;
		var ratioHeight = height/c.height;
		var maxRatio = Math.max(ratioWidth, ratioHeight);
		if(maxRatio >= 1){
			var ratio = width/height;
			if(ratioWidth > ratioHeight){
				width = c.width*80/100;
				height = width/ratio;

			}
			else{
				height = c.height*80/100;
				width = height*ratio;
			}
			top = height/2+c.height*10/100;
			left = width/2+c.width*10/100;
		}

		fabric.Image.fromURL(path, function(img) {
			img.set({
				top:top,
				left:left,
				width: width,
				height: height,
				cornerSize: 5,
				borderColor: 'red',
				cornerColor: 'green'
			})
			c.remove(oldImg);
			c.add(img);
			c.setActiveObject(img);
			$('ul.bxslider li').remove();
		var index = c.getObjects().length - 1;
		c.forEachObject(function(obj){
			if(obj.type == 'text') {
				$('ul.bxslider').append('<li class="item_'+ index +'"><div style="width:100%;height:100%;text-align:center;display:table;"><span onclick="pcpb.setActive('+ index +')" style="display: table-cell;vertical-align: middle;cursor: pointer;font-family:'+ obj.getFontFamily() +';font-size:40px;color:'+ obj.getFill() +';">'+ obj.text +'</span></div></li>');
				index -= 1;
			}
			if(obj.type == 'image') {
				if(obj.getSrc() != c.backgroundImage.src) {
					$('ul.bxslider').append('<li class="item_'+ index +'"><img onclick="pcpb.setActive('+ index +')" style="cursor: pointer;width:100px;height:100px;" src="'+ obj.getSrc() +'" /></li>');					
				}
				index -= 1;
			}
		});
			slider.reloadSlider();
			THIS.selectedTarget();
		});
	};
	this.setWidth = function(width){
		this._canvas.setWidth(width);
	};
	this.setHeight = function(height){
		this._canvas.setHeight(height);
	};
	this.setBackgroundImage = function(url){
		var c = this._canvas;
		if(flag == false){
			c.forEachObject(function(obj){
				if(obj.type == 'image') {
					if(obj.getSrc() == c.backgroundImage.src) {
						c.remove(obj);
						flag = true;
					}
				}
			});
		}
		c.setBackgroundImage(url, function(){c.renderAll();});
	};
	this.loadFromJSON = function(json){
		this._canvas.loadFromJSON(json);
	};
	this.saveToImage = function(){
		var c = this._canvas;
		var o = c.getActiveObject();
		if(o != null){
			o.setActive(false);
			c.renderAll();
		}
		return this._canvas.toDataURL();
	};
}

function rgb2hex(rgb) {
	if (  rgb.search("rgb") == -1 ) {
		return rgb;
    }
    rgb = rgb.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+))?\)$/);
    function hex(x) {
        return ("0" + parseInt(x).toString(16)).slice(-2);
    }
    return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]);
}

function checkHex(hex){
	return /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(hex);
}
