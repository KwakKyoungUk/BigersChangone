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
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var KWAN_GUBUN = null;
                    	var DC_GUBUN = null;
                    	var KWAN_NAME = null;
                    	var DC_NAME = null;
                    	var DC_PERCENT = null;
                    	var PART = null;
                    	var APPEND_DC_GUBUN = null;
                     	var reportName  = "STAT1081";
                     	var reportName2  = "STAT1082";
                     	var reportName3  = "STAT1083";
                     	var reportName4  = "STAT1084";

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		KWAN_GUBUN = $("#" + fnObj.search.target.getItemId("KWAN_GUBUN") +" option:selected").val();
                   		DC_GUBUN = $("#" + fnObj.search.target.getItemId("DC_GUBUN") +" option:selected").val();
                   		KWAN_NAME = $("#" + fnObj.search.target.getItemId("KWAN_GUBUN") +" option:selected").text();
                   		DC_NAME = $("#" + fnObj.search.target.getItemId("DC_GUBUN") +" option:selected").text();
                   		DC_PERCENT = $("#" + fnObj.search.target.getItemId("DC_PERCENT") +" option:selected").val();
                   		APPEND_DC_GUBUN = $("#" + fnObj.search.target.getItemId("APPEND_DC_GUBUN") +" option:selected").val();
                   		PART = fnObj.CODES.tab;

                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("KWAN_GUBUN="+KWAN_GUBUN);
                   		params.push("DC_GUBUN="+DC_GUBUN);
                   		params.push("KWAN_NAME="+KWAN_NAME);
                   		params.push("DC_NAME="+DC_NAME);
                   		params.push("DC_PERCENT="+DC_PERCENT);
                   		params.push("APPEND_DC_GUBUN="+APPEND_DC_GUBUN);
                   		params.push("printName="+'${LOGIN_USER_ID}');


                   		trace(params);
//                         Common.report.open("/reports/stat/${PAGE_ID}", "pdf", params.join("&"));
                		Common.report.embedded("/reports/changwon/stat/"+reportName, "pdf", params.join("&"), "if-pdfA");
                		Common.report.embedded("/reports/changwon/stat/"+reportName2, "pdf", params.join("&"), "if-pdfB");
                		Common.report.embedded("/reports/changwon/stat/"+reportName4, "pdf", params.join("&"), "if-pdfD");
                		Common.report.embedded("/reports/changwon/stat/"+reportName3, "pdf", params.join("&"), "if-pdfC");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var KWAN_GUBUN = null;
                    	var DC_GUBUN = null;
                    	var KWAN_NAME = null;
                    	var DC_NAME = null;
                    	var DC_PERCENT = null;
                    	var PART = null;
                    	var APPEND_DC_GUBUN = null;
                     	var reportName  = "STAT1081";
                     	var reportName2  = "STAT1082";
                     	var reportName3  = "STAT1083";
                     	var reportName4  = "STAT1084";

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		KWAN_GUBUN = $("#" + fnObj.search.target.getItemId("KWAN_GUBUN") +" option:selected").val();
                   		DC_GUBUN = $("#" + fnObj.search.target.getItemId("DC_GUBUN") +" option:selected").val();
                   		KWAN_NAME = $("#" + fnObj.search.target.getItemId("KWAN_GUBUN") +" option:selected").text();
                   		DC_NAME = $("#" + fnObj.search.target.getItemId("DC_GUBUN") +" option:selected").text();
                   		DC_PERCENT = $("#" + fnObj.search.target.getItemId("DC_PERCENT") +" option:selected").val();
                   		APPEND_DC_GUBUN = $("#" + fnObj.search.target.getItemId("APPEND_DC_GUBUN") +" option:selected").val();
                   		PART = fnObj.CODES.tab;

                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("KWAN_GUBUN="+KWAN_GUBUN);
                   		params.push("DC_GUBUN="+DC_GUBUN);
                   		params.push("KWAN_NAME="+KWAN_NAME);
                   		params.push("DC_NAME="+DC_NAME);
                   		params.push("DC_PERCENT="+DC_PERCENT);
                   		params.push("APPEND_DC_GUBUN="+APPEND_DC_GUBUN);
                   		params.push("printName="+'${LOGIN_USER_ID}');

                   		trace(params);
//                         Common.report.open("/reports/stat/${PAGE_ID}", "pdf", params.join("&"));

                   		if(fnObj.CODES.tab == "A"){
                   			Common.report.embedded("/reports/changwon/stat/"+reportName, "excel", params.join("&"), "if-pdfA");
                    	}else if(fnObj.CODES.tab == "B"){
                    		Common.report.embedded("/reports/changwon/stat/"+reportName2, "excel", params.join("&"), "if-pdfB");
                    	}else if(fnObj.CODES.tab == "D"){
                    		Common.report.embedded("/reports/changwon/stat/"+reportName4, "excel", params.join("&"), "if-pdfD");
                    	}else if(fnObj.CODES.tab == "C"){
                    		Common.report.embedded("/reports/changwon/stat/"+reportName3, "excel", params.join("&"), "if-pdfC");
                    	}
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
								{optionValue:"A", optionText:"화장", closable:false},
			  					{optionValue:"B", optionText:"봉안", closable:false},
			  					{optionValue:"D", optionText:"봉안담", closable:false},
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
               						{label:"접수일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
               						{label:"자료구분", labelWidth:"", type:"selectBox", width:"150", key:"DC_GUBUN", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/stat1080/dc_gubun",
            									ajaxPars:"",
            									isspace: true,
            									isspaceTitle: "전체",
            									onChange:function(){
            										//toast.push(Object.toJSON(this));

            									}
            								}
               							},
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"selectBox", width:"150", key:"KWAN_GUBUN", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/stat1080/kwan_gubun",
            									ajaxPars:"",
            									isspace: true,
            									isspaceTitle: "전체",
            									onChange:function(res){
            										trace(res);
            										//toast.push(Object.toJSON(this));

            									}
            								}
               							},
               							onChange: function(){}
               						},
               						{label:"감면율", labelWidth:"", type:"selectBox", width:"150", key:"DC_PERCENT", addClass:"", valueBoxStyle:"", value:"",
               							options:[{optionValue:"", optionText:"전체"}
               							,{optionValue:"100", optionText:"100%"}
               							,{optionValue:"50", optionText:"50%"}
               							],
										onChange: function(selectedObject, value){

										}
               						},
               						{label:"구분", labelWidth:"", type:"selectBox", width:"150", key:"APPEND_DC_GUBUN", addClass:"", valueBoxStyle:"", value:"",
               							options:[{optionValue:"0", optionText:"전체"}
//                							,{optionValue:"1", optionText:"화성"}
//                							,{optionValue:"2", optionText:"오산"}
//                							,{optionValue:"3", optionText:"용인"}
               							],
										onChange: function(selectedObject, value){

										}
               						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
//                     	var params = [];
//                     	var from = null;
//                     	var to = null;
//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		from = new Date(0).print("yyyymmdd");
//                     		to = new Date().print("yyyymmdd");
//                     		params.push("from="+from);
//                     		params.push("to="+to);
//                     	}else{
//                     		from = Common.search.getValue(fnObj.search.target, "from");
//                     		to = Common.search.getValue(fnObj.search.target, "to");
//                     		params.push("FROM="+from);
//                     		params.push("TO="+to);
//                     	}
//                     	var firstDayOfWeek = to.date().setDate(to.date().getDate()-to.date().getDay()).date().print();
//                     	params.push("FIRST_DAY_OF_WEEK="+firstDayOfWeek);
//                     	Common.report.open("/reports/stat/STAT1010", "html", params.join("&"));
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>