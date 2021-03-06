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
					<div id="div-tab-content-C">
						<iframe id="if-pdfC" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
					<div id="div-tab-content-D">
						<iframe id="if-pdfD" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
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
                	tab: "A"
                },
                pageStart: function(){
                	this.tab.bind();
                    this.search.bind();
                    this.bindEvent();
                    // ????????? ?????? ??? ?????? ?????? ???????????? (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;

                    	from = Common.search.getValue(fnObj.search.target, "from");
                		to = Common.search.getValue(fnObj.search.target, "to");
                		params.push("FROM="+from);
   						params.push("TO="+to);
   						params.push("printName="+'${LOGIN_USER_ID}');

                		Common.report.embedded("/reports/changwon/stat/STAT4031", "pdf", params.join("&"), "if-pdfA");
                		Common.report.embedded("/reports/changwon/stat/STAT4032", "pdf", params.join("&"), "if-pdfB");
                		Common.report.embedded("/reports/changwon/stat/STAT4033", "pdf", params.join("&"), "if-pdfC");
                		Common.report.embedded("/reports/changwon/stat/STAT4034", "pdf", params.join("&"), "if-pdfD");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;

                    	from = Common.search.getValue(fnObj.search.target, "from");
                		to = Common.search.getValue(fnObj.search.target, "to");
                		params.push("FROM="+from);
   						params.push("TO="+to);
   						params.push("printName="+'${LOGIN_USER_ID}');

   						Common.report.embedded("/reports/changwon/stat/STAT4031", "excel", params.join("&"), "if-pdfA");
   						Common.report.embedded("/reports/changwon/stat/STAT4032", "excel", params.join("&"), "if-pdfB");
   						Common.report.embedded("/reports/changwon/stat/STAT4033", "excel", params.join("&"), "if-pdfC");
   						Common.report.embedded("/reports/changwon/stat/STAT4034", "excel", params.join("&"), "if-pdfD");

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
								{optionValue:"A", optionText:"?????????", closable:false},
			  					{optionValue:"B", optionText:"?????????", closable:false},
			  					{optionValue:"C", optionText:"?????????"},
			  					{optionValue:"D", optionText:"?????? 50%25 ?????? ????????????"}
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
                                // ????????? ???????????? ???????????? submit ????????? ?????? ?????? ?????? ?????????.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"????????????", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
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
                    	$("#ax-page-btn-search").click();
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>