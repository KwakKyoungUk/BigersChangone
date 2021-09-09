<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4060.jsp
 - 설      명	: 재자별 소모 집계 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.28  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
           
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				
				<b:button  text="자재소모내역" id="btn-production-list"></b:button>
				
				<div class="ax-search" id="page-search-box"></div>
				
				<iframe id="if-pdf" width="100%" height="600" style="border: 0.5px solid lightgray;"></iframe>
								
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
           
            var pb_data={            		
                
                }
            var fnObj = {            	
                pageStart: function(){
                	this.search.bind();                    
                    this.bindEvent();
                    //this.search.submit();                                        
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                       	
                    	etDateFrom	= Common.search.getValue(fnObj.search.target, "etDateFrom");
                    	etDateTo	= Common.search.getValue(fnObj.search.target, "etDateTo");     
                       	partCode	= Common.search.getValue(fnObj.search.target, "partCode");
                       	itemCode	= Common.search.getValue(fnObj.search.target, "itemCode");
                       	                   		                   		
                       	params.push("etDateFrom="+etDateFrom);
                   		params.push("etDateTo="+etDateTo);
                   		params.push("partCode="+partCode);
                   		params.push("itemCode="+itemCode);
                   		console.log(params);
                   		Common.report.embedded("/reports/changwon/fune/FUNE4061", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){                    	
                		                    	
                    	var params = [];
                    	etDateFrom	= Common.search.getValue(fnObj.search.target, "etDateFrom");
                    	etDateTo	= Common.search.getValue(fnObj.search.target, "etDateTo");
                       	partCode	= Common.search.getValue(fnObj.search.target, "partCode");
                       	itemCode	= Common.search.getValue(fnObj.search.target, "itemCode");
                       	                       	                   		                   		
                       	params.push("etDateFrom="+etDateFrom);
                   		params.push("etDateTo="+etDateTo);
                   		params.push("partCode="+partCode);
                   		params.push("itemCode="+itemCode);
                   		console.log(params);
                		Common.report.go("/reports/changwon/fune/FUNE4061", "excel", params.join("&"));
                    });
                    //자재소모내역으로 이동
                    $("#btn-production-list").bind("click", function(){
                    	etDateFrom	= Common.search.getValue(fnObj.search.target, "etDateFrom");
                    	etDateTo	= Common.search.getValue(fnObj.search.target, "etDateTo");
                       	partCode	= Common.search.getValue(fnObj.search.target, "partCode");
                       	itemCode	= Common.search.getValue(fnObj.search.target, "itemCode");
                    	
                    	var str_url = "/jsp/funeralsystem/fune/fune4000/FUNE4070.jsp?partCode="+partCode
        				+ "&etDateFrom=" + etDateFrom
        				+ "&etDateTo=" + etDateTo
						+"&itemCode=" + itemCode
						;
        				// window.location.href = str_url;
                    	window.open(str_url, 'FUNE4071');
                    });                    
                    
                },
                eventFunc: {                	
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        var _target = this.target;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",                        
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"조회일자", labelWidth:"", type:"inputText", width:"70", key:"etDateFrom", addClass:"", valueBoxStyle:"", value:new Date().print(),
											onChange: function(){}
									},
									{label:"", labelWidth:"", type:"inputText", width:"90", key:"etDateTo", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
										AXBind:{
											type:"twinDate", config:{
												align:"right", valign:"top", startTargetID:"etDateFrom",
												onChange:function(){
													
												}
											}
										}
									}								
                                ]},
                                {display:true, addClass:"", style:"", list:[
									{label:"파트", labelWidth:"", type:"selectBox", width:"100", key:"partCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
										   type: "select", config: {
									            reserveKeys: {
									                  options: "list",
									                  optionValue: "partCode",
									                  optionText: "partName"
									               },
									          ajaxUrl: "/FUNE4060/part",
									          ajaxPars: null,
									          ajaxAsync: true,
									          alwaysOnChange: true,
									          onChange: function() {
									        	  var partCodeVal = this.optionValue;
									        	  $("#" + _target.getItemId("itemCode")).bindSelect({
									        		  reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "optionValue",
	                                                      optionText: "optionText"
	                                                 }
									        		,  	method:"GET"
									        		,	ajaxUrl:"/FUNE4060/item"
													, 	ajaxPars: "partCode=" + partCodeVal
													,	ajaxAsync: true
													,	isspace: true
													, 	isspaceTitle: "선택하세요"
														//setValue: selectbox_0_value,
													,	alwaysOnChange: true
													,	onchange: function(){
														}
													});
									          }
									        }
										}
									},
									{label: "", labelWidth: "100", type: "selectBox", width: "200", key:"itemCode" , addClass:"" , valueBoxStyle:"" , value:"" ,options:[]}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                                               
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>