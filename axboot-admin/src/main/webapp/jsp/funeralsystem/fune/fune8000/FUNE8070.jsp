<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE8070.jsp
 - 설      명	: 상조회통계현황 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.24  1.0        KYM      신규작성
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
      		.al-expect-amount{
      		text-align: right;
      		}
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

							<div class="ax-search" id="page-search-box"></div>

                            <iframe id="if-pdf" width="100%" height="600" style="border: 0.5px solid lightgray;"></iframe>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
        //    var pb_data={
                	//입금구분
        //        	srchReceiptGubun	: "",
        //    }
            var fnObj = {
            	//	CODES: {
                //	},
                pageStart: function(){
                	this.search.bind();
                    this.bindEvent();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	from 				= Common.search.getValue(fnObj.search.target, "balinDateFrom").replace(/-/g, '');
                		to 					= Common.search.getValue(fnObj.search.target, "balinDateTo").replace(/-/g, '');
                		from1 				= Common.search.getValue(fnObj.search.target, "balinDateFrom");
                		to1 				= Common.search.getValue(fnObj.search.target, "balinDateTo");
                		sangjoGubun			= Common.search.getValue(fnObj.search.target, "sangjoGubun");
                		sangjoUsedGubun		= Common.search.getValue(fnObj.search.target, "sangjoUsedGubun");
                		orderCode			= Common.search.getValue(fnObj.search.target, "orderCode");

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("FROM1="+from1);
                		params.push("TO1="+to1);
                		params.push("sangjoGubun="+sangjoGubun);
                		params.push("sangjoUsedGubun="+sangjoUsedGubun);
                		params.push("orderCode="+orderCode);
                		Common.report.embedded("/reports/changwon/fune/FUNE8071", "pdf", params.join("&"), "if-pdf");
                    });

                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from 				= Common.search.getValue(fnObj.search.target, "balinDateFrom").replace(/-/g, '');
                		to 					= Common.search.getValue(fnObj.search.target, "balinDateTo").replace(/-/g, '');
                		from1 				= Common.search.getValue(fnObj.search.target, "balinDateFrom");
                		to1 				= Common.search.getValue(fnObj.search.target, "balinDateTo");
                		sangjoGubun			= Common.search.getValue(fnObj.search.target, "sangjoGubun");
                		sangjoUsedGubun		= Common.search.getValue(fnObj.search.target, "sangjoUsedGubun");
                		orderCode			= Common.search.getValue(fnObj.search.target, "orderCode");

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("FROM1="+from1);
                		params.push("TO1="+to1);
                		params.push("sangjoGubun="+sangjoGubun);
                		params.push("sangjoUsedGubun="+sangjoUsedGubun);
                		params.push("orderCode="+orderCode);
                		Common.report.go("/reports/changwon/fune/FUNE8071", "excel", params.join("&"));

                    });

                },
            //    eventFunc: {
            //    },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;  // search 를 보관
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
								    {label:"발인일자", labelWidth:"", type:"inputText", width:"70", key:"balinDateFrom", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
										onChange: function(){}
									},
									{label:"", labelWidth:"", type:"inputText", width:"90", key:"balinDateTo", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
										AXBind:{
											type:"twinDate", config:{
												align:"right", valign:"top", startTargetID:"balinDateFrom",
												onChange:function(){
													_this.submit();  // fnObj.search.submit()
												}
											}
										}
									},
									{label:"상조회구분", labelWidth:"", type:"selectBox", width:"100", key:"sangjoGubun", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", 
											   config: {
	                                              reserveKeys: {
	                                              	options: "list",
	                                                optionValue: "code",
	                                                optionText: "name"
	                                              },
	                                              ajaxUrl: "/FUNE8070/basic-select-options",
	                                              ajaxPars:"basic_code=115",
	                                              isspace: true,
	                                              isspaceTitle: "전체",
	                                              setValue:"ALL",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                              }
	                                            }
										}
									},
									{label:"상조회사용여부", labelWidth:"", type:"selectBox", width:"100", key:"sangjoUsedGubun", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", 
											   config: {
	                                           	  reserveKeys: {
	                                               	options: "list",
	                                                optionValue: "code",
	                                                optionText: "name"
	                                              },

	                                              ajaxUrl: "/FUNE8070/basic-select-options",
	                                              ajaxPars:"basic_code=503",
	                                              isspace: true,
	                                              isspaceTitle: "전체",
	                                              setValue:"ALL",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                              }
	                                            }
											}
									},
									{label:"정렬순서", labelWidth:"", type:"selectBox", width:"100", key:"orderCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", 
											   config: {
										       	  reserveKeys: {
										             options: "list",
										             optionValue: "code",
										             optionText: "name"
										          },
												  method:"GET",
										          ajaxUrl: "/FUNE8070/order",
										          ajaxPars:"",
										          alwaysOnChange: false,
										          onChange: function() {
										          }
										       }
										} // AXBind  
									} // label
                                ]} // rows Object 
                            ] // rows Array
                        }); // setConfig
                    }, // bind function
                    submit: function(){
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>