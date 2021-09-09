<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>

<ax:layout name="base.jsp">
	<ax:set name="title" value="${PAGE_NAME}" />
	<ax:set name="page_desc" value="${PAGE_REMARK}" />
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
				<ax:custom customid="page-button" pageId="${PAGE_ID}"
					searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}"
					excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}"
					function2Auth="${FUNCTION_2_AUTH}"
					function3Auth="${FUNCTION_3_AUTH}"
					function4Auth="${FUNCTION_4_AUTH}"
					function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-search" id="page-search-box"></div>
				<iframe id="if-pdf" width="100%" height="700"
					style="border: 0.5px solid lightgray;"></iframe>
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
                    	var partCode = null;
                    	var code = null; 
                    	var code2 = null;
                    	var partName = null;  
                    	var codeName = null;

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		partCode = Common.search.getValue(fnObj.search.target, "partCode");
                   		partName = $("#" + fnObj.search.target.getItemId("partCode") +" option:selected").text();
                   		code = Common.search.getValue(fnObj.search.target, "code");
                   		code2 = Common.search.getValue(fnObj.search.target, "code2");
                   		codeName = $("#" + fnObj.search.target.getItemId("code2") +" option:selected").text();
                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("partCode="+partCode);
                   		params.push("partName="+partName);
                   		params.push("code="+code);
                   		params.push("code2="+code2);
                   		params.push("codeName="+codeName);

//                         Common.report.open("/reports/stat/${PAGE_ID}", "pdf", params.join("&"));
                        Common.report.embedded("/reports/changwon/fune/FUNE2071", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var partCode = null;
                    	var code = null; 
                    	var code2 = null;
                    	var partName = null;  
                    	var codeName = null;

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		partCode = Common.search.getValue(fnObj.search.target, "partCode");
                   		partName = $("#" + fnObj.search.target.getItemId("partCode") +" option:selected").text();
                   		code = Common.search.getValue(fnObj.search.target, "code");
                   		code2 = Common.search.getValue(fnObj.search.target, "code2");
                   		codeName = $("#" + fnObj.search.target.getItemId("code2") +" option:selected").text();
                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("partCode="+partCode);
                   		params.push("partName="+partName);
                   		params.push("code="+code);
                   		params.push("code2="+code2);
                   		params.push("codeName="+codeName);

                        Common.report.go("/reports/changwon/fune/FUNE2071", "excel", params.join("&"));
                    });
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
/*              						{label:"조회일자구분", labelWidth:"100", type:"selectBox", width:"", key:"code", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/FUNE2070/basiccode",
            									ajaxPars:null,
            									setValue:"",
            									onChange:function(){
            										$("#"+fnObj.search.target.getItemId("from")).parent().siblings(".th").text(this.optionText);
            										//toast.push(Object.toJSON(this));
													
            									}
            								}
            							}
            						}, */
             						{label:"조회일자구분", labelWidth:"100", type:"selectBox", width:"", key:"code", addClass:"", valueBoxStyle:"", value:"",
            							options:[
											{optionValue:"0", optionText:"판매일자"},
											{optionValue:"1", optionText:"발인일자"}
            							],
										AXBind: {
											type: "select",
											config: {
												alwaysOnChange: true,
												onchange: function() {
													$("#"+fnObj.search.target.getItemId("from")).parent().siblings(".th").text(this.optionText);
												}
											}
										}
            						}, 
                                	{label:"판매일자", labelWidth:"", type:"inputText", width:"90", key:"from", addClass:"", valueBoxStyle:"", value:new Date().print(),

               						},
                                	{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"", valueBoxStyle:"", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){
               									}
               								}
               							}
               						},
                                ]},
                                {display:true, addClass:"", style:"", list:[
            						{label:"매출구분", labelWidth:"100", type:"selectBox", width:"66", key:"code2", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/FUNE2070/basiccode2",
            									ajaxPars:"",
            									setValue:"",
                                                isspace: true, isspaceTitle: ".",
            									onChange:function(){
            										//toast.push(Object.toJSON(this));

            									}
            								}
            							}
            						},
            						{label:"파트", labelWidth:"100", type:"selectBox", width:"", key:"partCode", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "partCode",
                                                    optionText: "partName"
                                                },
            									ajaxUrl:"/FUNE2070/part",
            									ajaxPars:"",
            									onChange:function(){
            										//toast.push(Object.toJSON(this));

            									}
            								}
            							}
            						}
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
                }  
            };
        </script>
	</ax:div>
</ax:layout>