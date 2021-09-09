<%----------------------------------------------------------------------------------------
 - 파일이름	: SUIP1040.jsp
 - 설      명	: 수입 관리 > 카드 입금 관리(기간) 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.1
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.22  1.0        KYM      신규작성
 - 2018.01.25  1.1        KEH      송금구분에 따라 송금일자 ReadOnly 변경 수정
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
<%-- 				
				<ax:custom customid="table">
                    <ax:custom customid="tr">                        
                        <ax:custom customid="td"> --%>

							<div class="ax-search" id="page-search-box"></div>
							
                            <iframe id="if-pdf" width="100%" height="600" style="border: 0.5px solid lightgray;"></iframe>

<%--                         </ax:custom>
                        
                    </ax:custom>
                </ax:custom> --%>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">    	  
            var pb_data={            		
                	//입금구분
                	srchReceiptGubun	: "",
            }
            var fnObj = {
            		CODES: {
            			cardComGubun: Common.getCode("301"),
            			flagGubun: Common.getCode("108")
                	},
                pageStart: function(){
                	this.search.bind();                    
                    this.bindEvent();                    
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	from 				= Common.search.getValue(fnObj.search.target, "inDateFrom").replace(/-/g, '');
                		to 					= Common.search.getValue(fnObj.search.target, "inDateTo").replace(/-/g, '');
                		receiptGubun	= Common.search.getValue(fnObj.search.target, "receiptGubun");
                		cardCode		= Common.search.getValue(fnObj.search.target, "cardCode");                		
                		csungno			= Common.search.getValue(fnObj.search.target, "csungno");
                		
                		
                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("receiptGubun="+receiptGubun);
                		params.push("cardCode="+cardCode);
                		params.push("csungno="+csungno);
                		Common.report.embedded("/reports/changwon/suip/SUIP1041", "pdf", params.join("&"), "if-pdf");
                    });
                    
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from 				= Common.search.getValue(fnObj.search.target, "inDateFrom").replace(/-/g, '');
                		to 					= Common.search.getValue(fnObj.search.target, "inDateTo").replace(/-/g, '');
                		receiptGubun	= Common.search.getValue(fnObj.search.target, "receiptGubun");
                		cardCode		= Common.search.getValue(fnObj.search.target, "cardCode");
                		csungno			= Common.search.getValue(fnObj.search.target, "csungno");
                		
                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("receiptGubun="+receiptGubun);
                		params.push("cardCode="+cardCode);
                		params.push("csungno="+csungno);
                		Common.report.go("/reports/changwon/suip/SUIP1041", "excel", params.join("&"));
                    	
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
									{label:"입금구분", labelWidth:"", type:"selectBox", width:"100", key:"receiptGubun", addClass:"", valueBoxStyle:"", value:"close",										
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1030/basic-select-options",	                                              
	                                              ajaxPars:"basic_code=402",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            		//0:미수 1:입금
	                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */ 
	                                            	   switch (this.value) {
														case '0':
															$("#"+fnObj.search.target.getItemId("inDateFrom")).prop("disabled", true);
															$("#"+fnObj.search.target.getItemId("inDateTo")).prop("disabled", true);
															break;
														case '1':
															$("#"+fnObj.search.target.getItemId("inDateFrom")).prop("disabled", false);
															$("#"+fnObj.search.target.getItemId("inDateTo")).prop("disabled", false);
															break;

														default:
															break;
														}
	                                            		trace(this.value);
	                                            	  _this.submit();                                            	 
	                                              }
	                                            }
											}
									},									
									{label:"입금일자", labelWidth:"", type:"inputText", width:"70", key:"inDateFrom", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"inDateTo", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"inDateFrom",
               									onChange:function(){
               										_this.submit();
               									}
               								}
               							}
               						}
									
                                ]},
                                {display:true, addClass:"", style:"", list:[
										{label:"매입사", labelWidth:"", type:"selectBox", width:"100", key:"cardCode", addClass:"", valueBoxStyle:"", value:"",										
										options:[],
										AXBind:{
											   type: "select", config: {
										            reserveKeys: {
										            	options: "list",
										                  optionValue: "code",
										                  optionText: "name"
										               },
										          ajaxUrl: "/SUIP1030/basic-select-options",
										          ajaxPars:"basic_code=301",
										          alwaysOnChange: true,
										          isspace: true, 
	                                              isspaceTitle: "전체",
	                                              setValue:"ALL",
										          onChange: function() {
										        		//0:미수 1:입금
										        	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */ 
										        	  _this.submit();                                            	 
										          }
										        }
											}
										},
	              						{label:"승인번호", labelWidth:"", type:"inputText", width:"150", key:"csungno",addClass:"", valueBoxStyle:"", value:""}
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