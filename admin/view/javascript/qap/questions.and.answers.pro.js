/*
 * Questions & Answers PRO
 *
 */
(function( bull5i, $, undefined ) {
	var t
		, msg_bg_color
		, default_texts = {
			ajax_error_msg : "An AJAX error occured!"
		}
		, default_alert_classes = {
			success : "success",
			error   : "warning",
			warning : "attention",
			info    : "info"
		};

	bull5i.texts = typeof bull5i.texts !== 'undefined' ? $.extend(default_texts, bull5i.texts) : default_texts;

	bull5i.alert_classes = typeof bull5i.alert_classes !== 'undefined' ? $.extend(default_alert_classes, bull5i.alert_classes) : default_alert_classes;

	if (bull5i.show_message == undefined) {
		bull5i.show_message = function(msg, type, group, timeout) {
			var group = group || "bull5i"
			  , timeout = (timeout != undefined) ? timeout : 10000;

			if (!msg) return;

			if (t) clearTimeout(t);

			if (!(type in bull5i.alert_classes)) type = "error";

			$("div." + group + ":not(." + bull5i.alert_classes[type] + ")").slideUp("fast");

			alert_div = "div." + group + "." + bull5i.alert_classes[type];

			if ($(alert_div).length == 0) {
				var alert = $('<div/>').addClass(group).addClass(bull5i.alert_classes[type]).html(msg).hide();
				$("div.breadcrumb").after(alert);
				alert.slideDown('slow');
				msg_bg_color = alert.css("backgroundColor");
			} else {
				if ($(alert_div).is(":visible")) {
					msg_bg_color = $(alert_div).css("backgroundColor");
					$(alert_div).html(msg).animate({backgroundColor: "#ffffff"}, 150, "easeOutExpo", function() {
						$(this).animate({backgroundColor: msg_bg_color}, 850, "easeOutExpo", function() {
							$(this).css("backgroundColor", '');
						});
					});
				} else {
					$(alert_div).html(msg).slideDown('slow', function(){
						msg_bg_color = $(this).css("backgroundColor");
					});
				}
			}
			if (timeout) {
				t = setTimeout(function(){
					$(alert_div).slideUp("slow");
				}, timeout);
			}
		}
	}

	// Init
	$(function(){
		if (typeof $.fn.tooltip == "function")
			$('body').tooltip({
				selector: "[rel='tooltip']"
			});
		if (typeof $.fn.popover == "function")
			$("[rel='popover']").popover()
		if (typeof $.fn.clickover == "function")
			$("[rel='clickover']").clickover()
		if (typeof bull5i.filterResults == "function")
			$("#filterResults").on('click', function() {
				bull5i.filterResults();
			});
		if (typeof bull5i.clearFilter == "function")
			$("#clearFilter").on('click', function() {
				bull5i.clearFilter();
			});
		$(".btn-edit,#insertNew,#filterApproval,#cancel").on('click', function() {
			if ($(this).attr('data-href'))
				location = $(this).attr('data-href');
		});
		$("#deleteSelected").on('click', function() {
			if ($('input[name*=\'selected\']:checked').length)
				$("#form").submit();
		});
		$("#save").on('click', function() {
			$("#form").submit();
		});
		$("body").on('click', '#upgrade-extension', function(e) {
			e.preventDefault();
			$.ajax({
				type: 'POST',
				url: this.href,
				dataType: 'json',
				beforeSend: function() {
					$("#overlay").stop().fadeTo(300, 0.8)
				},
				success: function(data) {
					if (data && data.success) {
						window.location.reload(true);
						$("span.help-block.error").remove();
						$(".error").removeClass("error");
						bull5i.show_message(data.success, "success", "qap-alert");
					} else if (data && data.error) {
						$("span.help-block.error").remove();
						$(".error").removeClass("error");
						if (data.errors) {
							$.each(data.errors, function(k,v) {
								if (k == "warning") {
									bull5i.show_message(data.errors.warning, "error", "qap-alert", 0);
								} else {
									$el = $("[name=" + k + "]")
									$el.closest(".control-group").find('label').addClass("error")
									$el.closest(".controls").addClass("error").append($("<span/>", {"class":"help-block error"}).html(v))
								}
							});
						}
					}
				},
				error: function(xhr, status, error) {
					bull5i.show_message(bull5i.texts.ajax_error_msg, "error", "qap-alert", 0);
				},
				complete: function() {
					$("#overlay").stop().fadeOut(300)
				}
			});
		}).on('click', '#legal_notice,#help_notice', function(e) {
			e.preventDefault();
			$($(this).attr('data-modal')).modal({
				show:true,
				keyboard:true
			})
		}).on('click', '#BBCodes', function(e) {
			e.preventDefault();
			$("#bbCode_reference").modal({
				show:true,
				keyboard:true
			})
		}).on('click', '#addModule', function(e) {
			bull5i.add_module();
		}).on('click', 'button.remove-module', function(e) {
			$(this).closest("tr[id^='module-row']").remove();
		})

		$("#help_text .modal-body").load('view/static/bull5i_qap_pro_extension_help.htm');
		$("#legal_text .modal-body").load('view/static/bull5i_qap_pro_extension_terms.htm');
	});
}( window.bull5i = window.bull5i || {}, jQuery ));
