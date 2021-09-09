<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE1070.jsp
 - 설      명	: 개별 전표 내역 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.30  1.0        KYM      신규작성
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
                    	partCode	= $("#"+fnObj.search.target.getItemId("partCode")).val();
                    	from			= $("#"+fnObj.search.target.getItemId("etDate")).val()

                       	params.push("partCode="+partCode);
                       	params.push("FROM="+from);
                   		console.log(params)
                		Common.report.go("/reports/changwon/fune/FUNE1071", "excel", params.join("&"));
                    });

                },
                eventFunc: {
                	goPdf : function(){
                    	var params = [];
                    	partCode	= $("#"+fnObj.search.target.getItemId("partCode")).val();
                    	from			= $("#"+fnObj.search.target.getItemId("etDate")).val()

                       	params.push("partCode="+partCode);
                   		params.push("FROM="+from);

                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE1071", "pdf", params.join("&"), "if-pdf");
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
									{label:"파트", labelWidth:"", type:"selectBox", width:"100", key:"partCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
										   type: "select", config: {
                                                reserveKeys: {
                                                      options: "list",
                                                      optionValue: "partCode",
                                                      optionText: "partName"
                                                   },
                                              ajaxUrl: "/FUNE1070/part",
                                              ajaxPars: null,
                                              setValue : "${param.partCode}",
                                              alwaysOnChange: true,
                                              onChange: function() {
                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
                                            	  //_this.submit();
                                              }
                                            }
										}
									},
									{label:"조회일자", labelWidth:"", type:"inputText", width:"100", key:"etDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
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