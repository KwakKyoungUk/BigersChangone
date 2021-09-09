var topMenu = new AXTopDownMenu();
var mobileMenu = new AXMobileMenu();
var loginInfoModal = new AXMobileModal();
var loading_mask = new AXMask();
var AXGrid_instances = [];
var AXTree_instances = [];
var fcObj = {
	pageStart: function(){
		loading_mask.setConfig();
		loading_mask.setContent(
			{
				width:200, height:200,
				html: '<div class="loading" style="color:#ffffff;">' +
				'<i class="axi axi-data-usage animated bounceOutUp" style="font-size:100px;display:block;"></i>' +
				'<div style="font-family: consolas">Data is delivered</div>' +
				'</div>'
			}
		);
		fcObj.ax_aside = jQuery(".ax-aside");
		fcObj.ax_aside_box = jQuery(".ax-aside-box");
		fcObj.ax_aside_menu = axdom(".ax-aside-menu");
		fcObj.ax_content = jQuery(".ax-content");
		fcObj.cx_page_title = jQuery("#cx-page-title");

		// ax-header가 존재 하는 경우
		if(jQuery(".ax-header").get(0)) {
			fcObj.bindEvent();
			fcObj.bindTopMenu();
			fcObj.bindSideMenu();
		}

		if(window.fnObj && fnObj.pageStart) {
			setTimeout(function(){
				fnObj.pageStart();
				fcObj.resize_elements();
			}, 100);
		}

		//this.theme.init();
		app.modal.bind(); // app modal 초기화

		fcObj.ax_aside_box.data("status", (axf.getCookie("new-asidestatus") || "open"));
		fcObj.setAsideMenu("first");



		$(".td-layout:last-child").css({"padding-right":"0px"});
	},
	pageResize: function(){
		if(window.fnObj && fnObj.pageResize) fnObj.pageResize();
		this.resize_elements();
		fcObj.setAsideMenu();
	},

	setAsideMenu: function(first){
		if(axf.clientWidth() < 1160) {
			fcObj.ax_content.addClass("expand");
			fcObj.ax_aside.hide();
			fcObj.cx_page_title.css({"margin-left":"0px"});
		}else{
			if(fcObj.ax_aside) fcObj.ax_aside.show();

			if($(fcObj.ax_aside_box).data("status") == "open") {
				fcObj.ax_content.removeClass("expand");
				fcObj.cx_page_title.css({"margin-left": "0px"});
				//fcObj.ax_aside_menu.removeClass("on");
				//fcObj.ax_aside_box.show();
			}
			else
			if($(fcObj.ax_aside_box).data("status") == "close") {
				fcObj.ax_content.addClass("expand");
				fcObj.cx_page_title.css({"margin-left": "30px"});
				fcObj.ax_aside_menu.addClass("on");
				fcObj.ax_aside_box.hide();
			}
		}
	},
	resize_elements: function(){
		if(window.resize_elements && window.resize_elements.length > 0){
			for(var i= 0,l=resize_elements.length,adjust;i<l;i++){
				if(resize_elements[i].id){
					if(!resize_elements[i].dom) resize_elements[i].dom = $("#" + resize_elements[i].id);
					if(typeof resize_elements[i].adjust == "function"){
						adjust = (resize_elements[i].adjust()||0).number();
					}else{
						adjust = (resize_elements[i].adjust||0).number();
					}
					resize_elements[i].dom.css({height: axf.clientHeight() + adjust - 200});
					// AXPage 안에 AXBox의 높이가 적절히 표시되기 위한 조건
				}
			}

			if(AXGrid_instances.length > 0){
				for(var i= 0,l=AXGrid_instances.length;i<l;i++) {
					AXGrid_instances[i].resetHeight();
				}
			}
			if(AXTree_instances.length > 0){
				for(var i= 0,l=AXTree_instances.length;i<l;i++) {
					AXTree_instances[i].resetHeight();
				}
			}
			//AXGrid_instances
			//AXTree_instances
		}
	},
	bindEvent: function(){
		fcObj.ax_aside_menu.bind("click", function(){
			var elem = fcObj.ax_aside_box;


			if(elem.data("status") == "close"){
				elem.data("status", "open");
				axf.setCookie("new-asidestatus", "open", 10, {
					path  : "/",             // {String} [현재 페이지의 path]
					domain: window.location.host,
					secure: true
				});

				fcObj.ax_content.removeClass("expand");
				jQuery(this).removeClass("on");
				elem.show();
				fcObj.cx_page_title.css({"margin-left":"0px"});
			}else{
				elem.data("status", "close");
				axf.setCookie("new-asidestatus", "close", 10, {
					path  : "/",             // {String} [현재 페이지의 path]
					domain: window.location.host,
					secure: true
				});
				fcObj.ax_content.addClass("expand");
				jQuery(this).addClass("on");
				elem.hide();
				fcObj.cx_page_title.css({"margin-left":"30px"});
			}
			axdom(window).resize();
		});
	},
	bindTopMenu: function(){

		sideMenu_data = axf.copyObject(topMenu_data);

		$.each(topMenu_data, function() {
			this.label = this.label + ' <i class="axi axi-arrow-drop-down-circle"></i>';
		});


		topMenu.setConfig({
			targetID:"ax-top-menu",
			parentMenu:{
				className:"parentMenu"
			},
			childMenu:{
				className:"childMenu",
				hasChildClassName:"expand", // script 방식에서만 지원 됩니다.
				align:"center",
				valign:"top",
				margin:{top:0, left:0},
				arrowClassName:"varrow2",
				arrowMargin:{top:2, left:0}
			},
			childsMenu:{
				className:"childsMenu",
				hasChildClassName:"expand",
				align:"left",
				valign:"top",
				margin:{top:-4, left:0},
				arrowClassName:"harrow",
				arrowMargin:{top:13, left:2}
			},
			onComplete: function(){
				if(window.pageInfo) topMenu.setHighLightOriginID( window.pageInfo.id );
				$.each($("[data-axmenuid]"), function(i,o){
					// 대,중메뉴가 아닐경우
					var target = $(o).attr("data-axmenuid");
					if(target.substring(target.length-3) != '000' && !isNaN(+target.substring(target.length-3))){
						$(o).attr("target", target);
					}else{
						$(o).attr("target", "_self");
					}
				})
			}
		});
		topMenu.setTree(topMenu_data);

		axdom("#mx-top-menu-handle").bind("click", function(){
			mobileMenu.open();
		});

		mobileMenu.setConfig({
			reserveKeys:{
				primaryKey:"parent_srl",
				labelKey:"label",
				urlKey:"link",
				targetKey:"target",
				addClassKey:"ac",
				subMenuKey:"cn"
			},
			onclick: function(){ // 메뉴 클릭 이벤트
				mobileMenu.close();
				location.href = this.url;
			}
		});
		mobileMenu.setTree(topMenu_data);

		loginInfoModal.setConfig({
			width:300, height:160,
			head:{
				close:{
					onclick:function(){

					}
				}
			},
			onclose: function(){
				trace("close bind");
			}
		});
		axdom("#mx-loginfo-handle").bind("click", function(){
			var obj = loginInfoModal.open();
			obj.modalHead.html( '<div class="modal-log-info-title">Login Info</div>' );
			obj.modalBody.html( '<div class="modal-log-info-wrap"><ul class="ax-loginfo">' + axdom("#ax-loginfo").html() + '</ul><div style="clear:both;"></div></div>' );
		});

	},
	bindSideMenu: function(){
		var po = [], _target = axdom("#ax-aside-ul"), on_menu_id = (function() {
			if(window.pageInfo) return window.pageInfo.id;
			return "";
		})(), script_on_id;

		// 부모메뉴 클릭 이벤트
		fcObj.onclick_parent_menu = function(id){

			var jdom = $("#ax-menu-ul-"+id), pjdom = $("#ax-menu-"+id);
			//$("#ax-menu-ul-"+id).toggleClass("on");

			if(typeof fcObj.sidemenu_click_id !== "undefined"){
				if(id != fcObj.sidemenu_click_id) {
					var _jdom = $("#ax-menu-ul-" + fcObj.sidemenu_click_id), _pjdom = $("#ax-menu-" + fcObj.sidemenu_click_id);
					_jdom.slideUp({
						duration: 200, easing: "cubicInOut", complete: function () {
							_jdom.removeClass("on");
							_pjdom.removeClass("open");
						}
					});
				}
			}

			jdom.slideToggle({duration:200, easing:"cubicInOut", complete:function(){
				if(jdom.css("display") == "block"){
					jdom.addClass("on");
					pjdom.addClass("open");
					fcObj.sidemenu_click_id = id;

				}else{
					jdom.removeClass("on");
					pjdom.removeClass("open");
					delete fcObj.sidemenu_click_id;
				}
			}});

		};
		for(var mi=0;mi<sideMenu_data.length;mi++){
			var child_on = false;
			po.push('<li id="ax-menu-'+ sideMenu_data[mi]._id +'" class="parent'+(
				function(){
					if(sideMenu_data[mi]._id == on_menu_id){
						return ' on open"'
					}else{
						return '';
					}
				}
			)()+'">');
			if(sideMenu_data[mi].url == "" || sideMenu_data[mi].url == "#"){
				po.push('<a href="javascript:fcObj.onclick_parent_menu(\'' + sideMenu_data[mi]._id + '\')">');
			}
			else
			{
				po.push('<a href="' + sideMenu_data[mi].url + '" target="' + (sideMenu_data[mi].target||"_self") + '">');
			}

			po.push('<i class="axi axi-web"></i> ');
			po.push(sideMenu_data[mi].label);

			if( sideMenu_data[mi].cn && sideMenu_data[mi].cn.length > 0 ) {
				po.push('<div class="is-on"></div>');
			}

			po.push('</a>');
			// --- 2단계
			if( sideMenu_data[mi].cn && sideMenu_data[mi].cn.length > 0 ){
				po.push('<ul id="ax-menu-ul-'+ sideMenu_data[mi]._id +'" class="child'+(
					function(){
						if(sideMenu_data[mi]._id == on_menu_id){
							return ' on open'
						}else{
							return '';
						}
					}
				)()+'">');
				$.each(sideMenu_data[mi].cn, function(){
					var item = this;
					var _this_id = this._id;
					var sub_child_on = false;

					po.push('<li id="ax-menu-'+ _this_id +'" class="child'+(
						function(){
							if(_this_id == on_menu_id){
								child_on = true;
								return ' on'
							}else{
								return '';
							}
						}
					)()+'"><a href="'+ this.url +'" target="'+ (this.target||"_self") +'">');
					po.push(this.label);

					po.push('</a>');

					//--- 3단계

					if( item.cn && item.cn.length > 0 ){
						po.push('<ul id="ax-menu-ul-'+ item._id +'" class="child on sub_child'+(
							function(){
								if(item._id == on_menu_id){
									return ' open'
								}else{
									return '';
								}
							}
						)()+'">');
						$.each(item.cn, function(){
							var _this_id = this._id;
							po.push('<li id="ax-menu-'+ _this_id +'" class="child sub_child'+(
								function(){
									if(_this_id == on_menu_id){
										sub_child_on = true;
										return ' on'
									}else{
										return '';
									}
								}
							)()+'"><a href="'+ this.url +'" target="'+ (this.target||"_self") +'">', this.label, '</a></li>');

							//--- 4단계



							//--- 4단계
						});
						po.push('</ul>');
					}
					// -- 2단계
					if(sub_child_on){
						script_on_id = sideMenu_data[mi]._id;
					}
					//--- 3단계
					po.push('</li>');
				});
				po.push('</ul>');
			}
			// -- 2단계
			if(child_on){
				script_on_id = sideMenu_data[mi]._id;
			}
			po.push('</li>');
		}
		_target.empty();
		_target.append(po.join(''));

		if(script_on_id){
			_target.find("#ax-menu-" + script_on_id).addClass("on").addClass("open");
			_target.find("#ax-menu-ul-" + script_on_id).addClass("on");
			fcObj.sidemenu_click_id = script_on_id;
		}
	},
	theme: {
		sel: null,
		init: function(){
			return;
			var themes = [
				["taeyoung","cocker"],
				["cocker","cocker"],
				["cocker-dark","bulldog"],
				["cocker-dark-red","cocker"],
				["cacao","kakao"],
				["cacao-dark","kakao"]
			];
			var po = [];
			$.each(themes, function(){
				po.push('<option value="', this[0],'/', this[1],'">', this[0],'</option>');
			});
			fcObj.theme.sel = jQuery("#theme-select");
			fcObj.theme.sel.html( po.join('') );

			var _theme;
			if((_theme = axf.getCookie("axutheme"))){
				fcObj.theme.sel.val(_theme);
				fcObj.theme.change(_theme);
			}
			fcObj.theme.sel.bind("change", function(e) {
				fcObj.theme.change(e.target.value);
			});
		},
		change: function(theme){
			var t = theme.split("/");
			jQuery("#axu-theme-admin").attr("href", "ui/"+t[0]+"/admin.css");
			jQuery("#axu-theme-axisj").attr("href", "/plugins/axisj/ui/"+ t[1] +"/AXJ.min.css?v="+axf.timekey());
			axf.setCookie("axutheme", theme);
		}
	},
	open_user_info: function(){
		app.modal.open({
			url:"/jsp/modal/user-info-modal.jsp",
			pars:"callBack=fcObj.change_user_info",
			width: 400
		});
	},
	change_user_info: function(){
		toast.push("개인정보 변경완료.");
		app.modal.close();
	}
};
// app app.js 로 이사~~

jQuery(document.body).ready(function() {
	fcObj.pageStart()
	fcObj.ax_aside_menu.click();		// 좌측메뉴 기본 닫힘 상태로....
});
jQuery(window).resize(function() {
	fcObj.pageResize();
});

// 2014-12-26 AXU, admin.js add script
jQuery(document.body).ready(function() {
	//jQuery(document.body).append('<div class="ax-scroll-top"><a href="javascript:window.scroll(0, 0);"><i class="axi axi-ion-arrow-up-c"></i> TOP</a></div>');
	//window.scroll_top_handle = jQuery(".ax-scroll-top");
	window.common_buttons = jQuery(".cx-common-btns");
});

jQuery(window).bind("scroll", function() {
	if(jQuery(window).scrollTop() > 40){
		//window.scroll_top_handle.addClass("on");
		if(window.common_buttons) window.common_buttons.addClass("on");
	}else{
		//window.scroll_top_handle.removeClass("on");
		if(window.common_buttons) window.common_buttons.removeClass("on");
	}
});

Chart.defaults.global = {
	// Boolean - Whether to animate the chart
	animation: true,

	// Number - Number of animation steps
	animationSteps: 10,

	// String - Animation easing effect
	// Possible effects are:
	// [easeInOutQuart, linear, easeOutBounce, easeInBack, easeInOutQuad,
	//  easeOutQuart, easeOutQuad, easeInOutBounce, easeOutSine, easeInOutCubic,
	//  easeInExpo, easeInOutBack, easeInCirc, easeInOutElastic, easeOutBack,
	//  easeInQuad, easeInOutExpo, easeInQuart, easeOutQuint, easeInOutCirc,
	//  easeInSine, easeOutExpo, easeOutCirc, easeOutCubic, easeInQuint,
	//  easeInElastic, easeInOutSine, easeInOutQuint, easeInBounce,
	//  easeOutElastic, easeInCubic]
	animationEasing: "easeOutQuart",

	// Boolean - If we should show the scale at all
	showScale: true,

	// Boolean - If we want to override with a hard coded scale
	scaleOverride: false,

	// ** Required if scaleOverride is true **
	// Number - The number of steps in a hard coded scale
	scaleSteps: null,
	// Number - The value jump in the hard coded scale
	scaleStepWidth: null,
	// Number - The scale starting value
	scaleStartValue: null,

	// String - Colour of the scale line
	scaleLineColor: "rgba(0,0,0,.1)",

	// Number - Pixel width of the scale line
	scaleLineWidth: 1,

	// Boolean - Whether to show labels on the scale
	scaleShowLabels: true,

	// Interpolated JS string - can access value
	scaleLabel: "<%=value.money()%>",

	// Boolean - Whether the scale should stick to integers, not floats even if drawing space is there
	scaleIntegersOnly: true,

	// Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	scaleBeginAtZero: false,

	// String - Scale label font declaration for the scale label
	scaleFontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",

	// Number - Scale label font size in pixels
	scaleFontSize: 12,

	// String - Scale label font weight style
	scaleFontStyle: "normal",

	// String - Scale label font colour
	scaleFontColor: "#666",

	// Boolean - whether or not the chart should be responsive and resize when the browser does.
	responsive: true,

	// Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
	maintainAspectRatio: true,

	// Boolean - Determines whether to draw tooltips on the canvas or not
	showTooltips: true,

	// Function - Determines whether to execute the customTooltips function instead of drawing the built in tooltips (See [Advanced - External Tooltips](#advanced-usage-custom-tooltips))
	customTooltips: false,

	// Array - Array of string names to attach tooltip events
	tooltipEvents: ["mousemove", "touchstart", "touchmove"],

	// String - Tooltip background colour
	tooltipFillColor: "rgba(0,0,0,0.8)",

	// String - Tooltip label font declaration for the scale label
	tooltipFontFamily: "'Nanum Gothic', 'Helvetica', 'Arial', sans-serif",

	// Number - Tooltip label font size in pixels
	tooltipFontSize: 14,

	// String - Tooltip font weight style
	tooltipFontStyle: "normal",

	// String - Tooltip label font colour
	tooltipFontColor: "#fff",

	// String - Tooltip title font declaration for the scale label
	tooltipTitleFontFamily: "'Nanum Gothic', 'Helvetica', 'Arial', sans-serif",

	// Number - Tooltip title font size in pixels
	tooltipTitleFontSize: 14,

	// String - Tooltip title font weight style
	tooltipTitleFontStyle: "bold",

	// String - Tooltip title font colour
	tooltipTitleFontColor: "#fff",

	// Number - pixel width of padding around tooltip text
	tooltipYPadding: 6,

	// Number - pixel width of padding around tooltip text
	tooltipXPadding: 6,

	// Number - Size of the caret on the tooltip
	tooltipCaretSize: 8,

	// Number - Pixel radius of the tooltip border
	tooltipCornerRadius: 6,

	// Number - Pixel offset from point x to tooltip edge
	tooltipXOffset: 10,

	// String - Template string for single tooltips
	tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value.money() %> 천원",

	// String - Template string for multiple tooltips
	multiTooltipTemplate: "<%= value.money() %> 천원",

	// Function - Will fire on animation progression.
	onAnimationProgress: function(){},

	// Function - Will fire on animation completion.
	onAnimationComplete: function(){}
}