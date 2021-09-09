<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> ${PAGE_NAME}</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-tab"></div>
			   	<div id="div-content">
			   		<div id="div-tab-content-A">
						<iframe id="if-pdfA" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
				</div>
				<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; height:0px; overflow:hidden;">
					<div id="div-tab-content-B">
						<iframe id="if-pdfB" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
			   	</div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                },
                pageStart: function(){
                	this.tab.bind();
                    this.search.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var openYear = null;
                    	var baseDate = null;
                    	openYear = Common.search.getValue(fnObj.search.target, "openYear");
                    	baseDate = Common.search.getValue(fnObj.search.target, "baseDate");
                    	params.push("openYear="+openYear);
                    	params.push("baseDate="+baseDate);
                    	params.push("printName="+"${LOGIN_USER_ID}");

                        Common.report.embedded("/reports/changwon/stat/STAT1111", "pdf", params.join("&"), "if-pdfA");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	openYear = Common.search.getValue(fnObj.search.target, "openYear");
                    	baseDate = Common.search.getValue(fnObj.search.target, "baseDate");
                    	params.push("openYear="+openYear);
                    	params.push("baseDate="+baseDate);
                    	params.push("printName="+"${LOGIN_USER_ID}");
                        Common.report.go("/reports/changwon/stat/STAT1111", "excel", params.join("&"));
                    });
                },

				tab: {
					target: $("#div-tab")
					, bind: function(){
						this.target.bindTab({
							theme : "AXTabs",
							value:"A",
							overflow:"scroll", /* "visible" */
							options:[
								{optionValue:"A", optionText:"통계열람", closable:false},
			  					//{optionValue:"B", optionText:"상세열람", closable:false},
			  					],
							onchange: function(selectedObject, value){
								$("#div-contents").append($("[id^='div-tab-content-']"));
								$("#div-content").append($("#div-tab-content-"+value));
								fnObj.CODES.tab = value;
								$('#ax-page-btn-search').trigger('click');

							},
							onclose: function(selectedObject, value){
							}
						});
					}
				},

                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"열람연도", labelWidth:"", type:"inputText", width:"70", key:"openYear", addClass:"secondItem", valueBoxStyle:"", value:new Date().getFullYear(),
               							onChange: function(){}
               						},
               						{label:"기준연월일", labelWidth:"", type:"inputText", width:"90", key:"baseDate", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"date", config:{
               									align:"right", valign:"top",
               									onChange:function(){

               									}
               								}
               							}
               						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>