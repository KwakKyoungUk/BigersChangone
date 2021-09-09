<%----------------------------------------------------------------------------------------
 - 파일이름	: SUIP1050.jsp
 - 설      명	: 수입 관리 > 카드 입금 현황 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.23  1.0        KYM      신규작성
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
				
                       
                        <ax:custom customid="td">

							<div class="ax-search" id="page-search-box"></div>
							
                            <iframe id="if-pdf" width="100%" height="600" style="border: 0.5px solid lightgray;"></iframe>

                        </ax:custom>
                        

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
                    	from 			= Common.search.getValue(fnObj.search.target, "from").replace(/-/g, '');
                		to 				= Common.search.getValue(fnObj.search.target, "to").replace(/-/g, '');
                		from1 		= Common.search.getValue(fnObj.search.target, "from");
                		to1 			= Common.search.getValue(fnObj.search.target, "to");
                		srchGubun	= Common.search.getValue(fnObj.search.target, "srchGubun");
                		
                		
                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("FROM1="+from1);
                		params.push("TO1="+to1);
                		params.push("srchGubun="+srchGubun);
                		params.push("printName=${LOGIN_USER_ID}");
                		
                		Common.report.embedded("/reports/changwon/suip/SUIP1051", "pdf", params.join("&"), "if-pdf");
                    });
                    
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from 			= Common.search.getValue(fnObj.search.target, "from").replace(/-/g, '');
                		to 				= Common.search.getValue(fnObj.search.target, "to").replace(/-/g, '');
                		from1 		= Common.search.getValue(fnObj.search.target, "from");
                		to1 			= Common.search.getValue(fnObj.search.target, "to");
                		srchGubun	= Common.search.getValue(fnObj.search.target, "srchGubun");
                		
                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("FROM1="+from1);
                		params.push("TO1="+to1);
                		params.push("srchGubun="+srchGubun);  //0:정산일자 , 1: 발인일자
                		params.push("printName=${LOGIN_USER_ID}");
                		
                		Common.report.go("/reports/changwon/suip/SUIP1051", "excel", params.join("&"));
                    	
                    });
                    
                },
                eventFunc: {
                	//조회구분 변경 이벤트
                	changeSrchTxt : function(){
                		var gubun = Common.search.getValue(fnObj.search.target, "srchGubun");
                		if(gubun === "0"){
                			$(".searchItem.secondItem").find(".th").text("정산일자");
                		}else{
                			$(".searchItem.secondItem").find(".th").text("발인일자");
                		}                		
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
									{label:"조회일자구분", labelWidth:"", type:"selectBox", width:"100", key:"srchGubun", addClass:"", valueBoxStyle:"", value:"",										
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1030/basic-select-options",	                                              
	                                              ajaxPars:"basic_code=314",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            		//0:미수 1:입금
	                                            	  fnObj.eventFunc.changeSrchTxt();
													                                           	 
	                                              }
	                                            }
											}
									},									
									{label:"정산일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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