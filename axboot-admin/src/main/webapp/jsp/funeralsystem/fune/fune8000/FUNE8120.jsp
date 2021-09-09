<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE8120.jsp
 - 설      명	: 빈소감면현황
 - 작 성 자		: KEH
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2018.01.09  1.0        KEH      신규작성
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

				<div class="ax-search" id="page-search-box"></div>

				<iframe id="if-pdf" width="100%" height="615" style="border: 0.5px solid lightgray;"></iframe>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
	    	var resize_elements = [
	            {id:"if-pdf", adjust:-57}
	        ];
            var fnObj = {
                pageStart: function(){
                	this.search.bind();
                    this.bindEvent();
                    //this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.eventFunc.goPdf();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from		= $("#"+fnObj.search.target.getItemId("from")).val();
                    	to			= $("#"+fnObj.search.target.getItemId("to")).val();

                       	params.push("FROM="+from);
                    	params.push("TO="+to);
                		params.push("printName=${LOGIN_USER_ID}");

                   		console.log(params)
                		Common.report.go("/reports/changwon/fune/FUNE8121", "excel", params.join("&"));
                    });

                },
                eventFunc: {
                	goPdf : function(){
                    	var params = [];
                    	from		= $("#"+fnObj.search.target.getItemId("from")).val();
                    	to			= $("#"+fnObj.search.target.getItemId("to")).val();

                       	params.push("FROM="+from);
                    	params.push("TO="+to);
                		params.push("printName=${LOGIN_USER_ID}");

                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE8121", "pdf", params.join("&"), "if-pdf");
                	}
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
									{label:"조회일자", labelWidth:"", type:"inputText", width:"100", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
									{label:"", labelWidth:"", type:"inputText", width:"100", key:"to", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"twinDate", config:{
	        									align:"right", valign:"top", startTargetID:"from", defaultDate:new Date().print(),
	        									onChange:function(){
	        										//_this.submit();
	        									}
	        								}
	        							}
               						}
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