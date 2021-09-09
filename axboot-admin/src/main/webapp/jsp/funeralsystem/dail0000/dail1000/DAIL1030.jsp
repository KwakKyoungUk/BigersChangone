<%----------------------------------------------------------------------------------------
 - 파일이름	: DAIL1030.jsp
 - 설      명	: 장례시설 및 용품 매출집계 화면
 - 작 성 자		: JINHO
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2018.05.26  1.0       JINHO    신규작성
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
            var fnObj = {
            		CODES: {
                	},
                pageStart: function(){
                	this.search.bind();
                    this.bindEvent();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	from 						= Common.search.getValue(fnObj.search.target, "balinDateFrom").replace(/-/g, '');
                		to 							= Common.search.getValue(fnObj.search.target, "balinDateTo").replace(/-/g, '');
                		var check = null;
                		check = fnObj.checked;                		

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("printName=${LOGIN_USER_ID}");
                		
                		if(fnObj.checked) {Common.report.embedded("/reports/changwon/dail/DAIL1031", "pdf", params.join("&"), "if-pdf");}
                    	else Common.report.embedded("/reports/changwon/dail/DAIL1031_1", "pdf", params.join("&"), "if-pdf");
                    });

                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from 						= Common.search.getValue(fnObj.search.target, "balinDateFrom").replace(/-/g, '');
                		to 							= Common.search.getValue(fnObj.search.target, "balinDateTo").replace(/-/g, '');
                		var check = null;
                		check = fnObj.checked;

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		
                		if(fnObj.checked) {Common.report.go("/reports/changwon/dail/DAIL1031", "excel", params.join("&"));}
                    	else Common.report.go("/reports/changwon/dail/DAIL1031_1", "excel", params.join("&"));

                    });

                },
                eventFunc: {
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
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
													_this.submit();
												}
											}
										}
									},
									{label:"", labelWidth:"", type:"checkBox", width:"", key:"check", addClass:"", valueBoxStyle:"", value:"",
            							options:[{optionValue:"1", optionText:"염습비용 개정전 자료 출력시 체크해주세요 기준일자 : 2019-02-20", title:"체크박스"}],
            							onChange: function(selectedObject, value){
            								fnObj.checked = value;
            							}
               						},
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