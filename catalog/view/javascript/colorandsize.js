$(function() {
    $('.hoverimage').click(
        function() {
			var newsrc = $(this).attr('rel');
			var arr = newsrc.split('!');
				$('#image').attr({src : ''+arr[0]+''});
				$('.image .colorbox').attr({href : ''+arr[1]+''});
				
        }
    );
});

$(function() {
    $('.categoryimage').live("click", function(){
			var newsrc = $(this).attr('rel');
			var arr = newsrc.split('!');
			$('.thumb-' + arr[1]).attr({src : ''+arr[0]+''});
        }
    );
});

$(function() {
   $("select.colorOp").uniform();
});

$(function(){
	$(".colorOp").parent('.selector').hide();
	$(".op li").click(function(){
		var value = $(this).attr("id");
		var title = $(this).find("a").attr("title");
		$(".option").find("option[value='"+value+"']").attr("selected","selected");
	});						
	$("ul.color li").click(function(){
			$("ul.color li").css('opacity',0.5).removeClass("active");
			$(this).css('opacity',1).addClass("active");
	});	
	$("ul.size li").click(function(){		
		$("ul.size li").removeClass("active");
		$(this).addClass("active");
			$("ul.size li").css('opacity',0.5);
			$(this).css('opacity', 1)
	});	
});