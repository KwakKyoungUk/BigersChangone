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
							<div id="div-content"></div>
								<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000;">
									<div id="div-tab-content-L"><iframe id="if-pdf1" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe></div>
									<div id="div-tab-content-S"><iframe id="if-pdf2" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe></div>
								</div>


            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
            		CODES: {
                    	"firstTab": [
                    					{optionValue:"L", optionText:"현황", closable:false},
               			 ],
    			         "tab": [
                    				{optionValue:"L", optionText:"현황", closable:false},
                    				{optionValue:"S", optionText:"통계", closable:false}
    			        ],
                    },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    //this.search.submit();

                },
                bindEvent: function(){
                    var _this = this;

                    $("#ax-page-btn-fn1").html("<i></i> 미입금카드열람");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.gridHwaBooking.del();
                        }, 500);
                    });

                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];


                     	params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");

//                          Common.report.open("/reports/stat/"+reportName, "pdf", params.join("&"));
                        Common.report.embedded("/reports/changwon/stat/STAT1201", "pdf", params.join("&"), "if-pdf1");
                        Common.report.embedded("/reports/changwon/stat/STAT1202", "pdf", params.join("&"), "if-pdf2");
                     });
                     $("#ax-page-btn-excel").bind("click", function(){
                     	var params = [];

                     	params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");

                         Common.report.go("/reports/changwon/stat/STAT1201", "excel", params.join("&"));
                         Common.report.go("/reports/changwon/stat/STAT1202", "excel", params.join("&"));
                     });

                     $("#div-tab").bindTab({
         				theme : "AXTabs",
         				value:"L",
         				overflow:"scroll", /* "visible" */
         				options:fnObj.CODES.firstTab,
         				onchange: function(selectedObject, value){
         					console.log(Object.toJSON(this));
         					//toast.push(Object.toJSON(selectedObject));
//          					toast.push("onchange: "+Object.toJSON(value));

//  		                    $("#div-contents").empty();
//          					$("#div-contents").append(fnObj.tabs["div-tab-content-"+value].tab);
//          					fnObj.tabs["div-tab-content-"+value].bindEvent();
//          					$("[id^='div-tab-content-']").css("display", "none");
//          					$("#div-tab-content-"+value).css("display", "");
 							$("#div-contents").append($("[id^='div-tab-content-']"));
 							$("#div-content").append($("#div-tab-content-"+value));

         				},
         				onclose: function(selectedObject, value){
         					//toast.push(Object.toJSON(this));
         					//toast.push(Object.toJSON(selectedObject));
         					toast.push("onclose: "+Object.toJSON(value));
         				}
         			});
                     //$("#div-tab").setValueTab(tabValue);
                     $("#div-content").append($("#div-tab-content-L"));
                     $("#div-tab").updateTabs(fnObj.CODES.tab);
 					//$("#div-contents").append($("[id^='div-tab-content-']"));

                },
                tabs:{},
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
								{label:"카드수입일", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                        var pars = this.target.getParam();
                        //fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },


            };
        </script>
    </ax:div>
</ax:layout>