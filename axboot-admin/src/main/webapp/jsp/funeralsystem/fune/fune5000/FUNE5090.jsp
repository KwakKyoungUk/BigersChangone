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
                <div class="ax-search" id="page-search-box"></div>
                <iframe id="if-pdf" width="100%" height="1000" style="border: 0.5px solid lightgray;"></iframe>
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
                	this.extendObject();
                    this.search.bind();
                    this.bindEvent();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	fnObj.search.submit();
                    });
                    
                    $("#ax-page-btn-excel").bind("click", function(){
                    	fnObj.search.submit2();
                    });
                    
                },

                extendObject: function(){

                	Date.prototype.getYearMonth = function() {

                		var result = "";

                		var year = this.getFullYear();
                		result += year;

                		result += "-";

	               		var month = this.getMonth() + 1;
	               		month = month < 10 ? '0' + month : '' + month; // ('' + month) for string result

	               		result += month;

	               		return result;
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
                                fnObj.search.submit2();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[

										{label:"조회일자구분", labelWidth:"", type:"selectBox", width:"150", key:"DATE_TYPE", addClass:"", valueBoxStyle:"", value:"close",
											options:[
												{optionValue:"0", optionText:"정산년월"},
												{optionValue:"1", optionText:"발인년월"}
											],
	            							AXBind:{
	            								type:"select", config:{
	    											alwaysOnChange: true,
	            									onChange:function(){
	            										$("#"+fnObj.search.target.getItemId("ST_YM")).parent().siblings(".th").text(this.optionText);
	            									}
	            								}
	            							}
										},

										{label:"발인일자", labelWidth:"", type:"inputText", width:"", key:"ST_YM", addClass:"secondItem", valueBoxStyle:"", value:new Date().getYearMonth(),
											onChange: function(){}
										},

										{label:"", labelWidth:"", type:"inputText", width:"", key:"ED_YM", addClass:"secondItem", valueBoxStyle:"", value:new Date().getYearMonth(),
	               							AXBind:{
	               								type:"twinDate", config:{
	               									align:"right", valign:"top", startTargetID:"ST_YM",selectType:"m",
	               									onChange:function(){
	            										//toast.push(fnObj.pageStart.datename);
	               									}
	               								}
	               							}
										},


	                            	]

	                            },


								{display:true, addClass:"", style:"", list:[
		                              	{label:"매출구분", labelWidth:"", type:"selectBox", width:"150", key:"MACHUL_TYPE", addClass:"", valueBoxStyle:"", value:"close", options:[],
			                               	AXBind: {
			                                	type: "select", config: {

				                                    reserveKeys: {
					                                    options: "list",
					                                    optionValue: "code",
					                                    optionText: "name"
													},

				                                    ajaxUrl: "/FUNE5090/machul-type",
				                                    ajaxPars: null,
				                                    setValue: "",
				                                    onChange: function() {
				                                   	}
												}
											}
										},

										{label:"정산구분", labelWidth:"", type:"selectBox", width:"150", key:"JUNGSAN_TYPE", addClass:"", valueBoxStyle:"", value:"close", options:[],
			                               	AXBind: {
			                                	type: "select", config: {

				                                    reserveKeys: {
					                                    options: "list",
					                                    optionValue: "code",
					                                    optionText: "name"
													},

				                                    ajaxUrl: "/FUNE5090/jungsan-type",
				                                    ajaxPars: null,
				                                    setValue: "",
				                                    onChange: function() {
				                                    	//alert(this.optionValue);
				                                   	}
												}
											}
										}
		                         	]
								}
                            ]
                        });
                    },
                    submit: function(){
                    	var params = fnObj.search.target.getParam();
                    	params += "&MACHUL_NAME="+$("#"+fnObj.search.target.getItemId("MACHUL_TYPE") + " option:selected").text();
                    	params += "&JUNGSAN_NAME="+$("#"+fnObj.search.target.getItemId("JUNGSAN_TYPE") + " option:selected").text();
                    	fnObj.report(params);
                    },
                    submit2: function(){
                    	var params = fnObj.search.target.getParam();
                    	params += "&MACHUL_NAME="+$("#"+fnObj.search.target.getItemId("MACHUL_TYPE") + " option:selected").text();
                    	params += "&JUNGSAN_NAME="+$("#"+fnObj.search.target.getItemId("JUNGSAN_TYPE") + " option:selected").text();
                    	fnObj.excel(params);
                    },
                },

                report: function(params){
                	var path = "/reports/changwon/fune/FUNE5091";
                	var output = "pdf";
                	var frameId = "if-pdf";
                	trace(params);
                	Common.report.embedded(path, output, params, frameId);
                	toast.push("로딩중입니다.");
                },
                
                excel: function(params){
                	var path = "/reports/changwon/fune/FUNE5091";
                	var output = "excel";
                	Common.report.go(path, output, params);
                	toast.push("로딩중입니다.");
                }
         };
        </script>
    </ax:div>
</ax:layout>