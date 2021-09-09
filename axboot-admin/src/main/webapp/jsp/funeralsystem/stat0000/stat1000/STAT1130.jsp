<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%

AdminLoginUser adminLoginUser = (AdminLoginUser)SecurityContextHolder.getContext().getAuthentication().getDetails();

String userNm = adminLoginUser.getUserNm();

request.setAttribute("regname", userNm);

 %>

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
				<iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	//ensType: Common.getCode("ENS_TYPE"),
                	//bookStatus: Common.getCode("BOOK_STATUS"),
                	//bookingType: Common.getCode("TMC04"),
                	//bookBurnObjt: Common.getCode("TMC02")
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    //this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                     	var reportName  = "STAT1131";
                     	//var objt = Common.search.getValue(fnObj.search.target, "objt");
                     	//if(objt =="2"){
                     	//	reportName = "STAT1121";
                     	//}else if (objt == "3"){
                     	//	reportName = "STAT1122";
                     	//}

                     	params.push("FROM="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("TO="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                		params.push("OBJT="+Common.search.getValue(fnObj.search.target, "objt"));
                		params.push("ADDR_PART="+Common.search.getValue(fnObj.search.target, "addr_part"));
                		params.push("printName=${LOGIN_USER_ID}");
                		                		
                		//params.push("facId="+Common.search.getValue(fnObj.search.target, "facId"));

//                          Common.report.open("/reports/stat/"+reportName, "pdf", params.join("&"));
                        Common.report.embedded("/reports/changwon/stat/"+reportName, "pdf", params.join("&"), "if-pdf");
                     });
                     $("#ax-page-btn-excel").bind("click", function(){
                    	 var params = [];
                      	var reportName  = "STAT1131";
                      	//var objt = Common.search.getValue(fnObj.search.target, "objt");
                      	//if(objt =="2"){
                      	//	reportName = "STAT1121";
                      	//}else if (objt == "3"){
                      	//	reportName = "STAT1122";
                      	//}

                      	params.push("FROM="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                 		params.push("TO="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                 		params.push("OBJT="+Common.search.getValue(fnObj.search.target, "objt"));
                 		params.push("ADDR_PART="+Common.search.getValue(fnObj.search.target, "addr_part"));
                 		params.push("printName=${LOGIN_USER_ID}");
                 		                		
                 		//params.push("facId="+Common.search.getValue(fnObj.search.target, "facId"));

//                           Common.report.open("/reports/stat/"+reportName, "pdf", params.join("&"));
                        Common.report.go("/reports/changwon/stat/"+reportName, "excel", params.join("&"));
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
								{label:"반환일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
									{label:"구분", labelWidth:"100", type:"selectBox", width:"", key:"objt", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"0", optionText:"전체"}, {optionValue:"1", optionText:"개인단"}, {optionValue:"2", optionText:"부부단"}, {optionValue:"3", optionText:"무연고"}],
										AXBind:{
											type:"select", config:{
												onChange:function(){
													//toast.push(Object.toJSON(this));
												}
											}
										}
									},
									{label:"관내구분", labelWidth:"100", type:"selectBox", width:"", key:"addr_part", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"0", optionText:"전체"}, {optionValue:"1", optionText:"관내"}, {optionValue:"2", optionText:"관외"}],
										AXBind:{
											type:"select", config:{
												onChange:function(){
													//toast.push(Object.toJSON(this));
												}
											}
										}
									},
               						//{label:"화장시설번호", labelWidth:"", type:"inputText", width:"90", key:"facId", addClass:"", valueBoxStyle:"", value:"L005",
       								//	onChange:function(){}
               						//},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        //fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },


            };
        </script>
    </ax:div>
</ax:layout>