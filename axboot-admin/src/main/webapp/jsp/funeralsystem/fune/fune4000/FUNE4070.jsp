<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4070.jsp
 - 설      명	: 자재 소모 내역 관리 화면
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
				
				<ax:custom customid="table">
                	<ax:custom customid="tr">
                      	<ax:custom customid="td" style="width:30%">
                      		<div class="ax-button-group">
	                               <div class="right">														
										<b:button text="조회" id="btn-itemSearch"></b:button>																				
	                               </div>
                              </div>
                			<div class="ax-search" id="page-search-box"></div>
                			<div id="div-grid-item" style="min-height: 480px;"></div>
                      	</ax:custom>
                      	
                      	<ax:custom customid="td">
                      		<table cellpadding="0" cellspacing="0" class="AXGridTable" style="height: 45px;">												    
						    	<tbody>
						    		<tr>
						    			<th style='width:10%;font-size: 17px;'>소모일자
										</th>
						    			<th style="text-align:left;">
						    				<input type="text" name="etDateFrom" id="etDateFrom" class="AXInput W80"/><input type="text" name="etDateTo" id="etDateTo" class="AXInput W100"/>						    										    				
						    			</th>
						    			<th style='width:10%;font-size: 17px;'>생산제품
										</th>
						    			<th style="text-align:left;">						    				
						    				<select id="product-stmt-item" name="product-stmt-item" class="AXSelect W200"></select>						    				
						    			</th>
						    		</tr>
						    		<tr>								    		
						    			<th style="text-align:left;padding-left: 25px;" colspan="4">
						    				<span id="mod-info" style="font-size: 17px;"></span>
						    			</th>								    		
						    		</tr>
						    	</tbody>
								</table>
								<iframe id="if-pdf" width="100%" height="600" style="border: 0.5px solid lightgray;"></iframe>
                      	</ax:custom>
                      		
                    </ax:custom>
				</ax:custom>
				
				
								
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
           
            var pb_data={
            		partCode 	: "",
            		itemCode 	: "",
            		itemName 	: "",
            		unit 			: ""
                }
            var fnObj = {            	
                pageStart: function(){
                	this.search.bind();                    
                    this.bindEvent();
                    this.gridItem.bind();
                    //this.search.submit();
                    
                    $("#etDateTo").bindTwinDate({
                        startTargetID: "etDateFrom",                        
                        align: "right",
                        valign: "bottom",
                        defaultDate:new Date().print(),
                        type:"inputText",
                        addClass:"secondItem",
                        
                        onChange: function () {
                        },
                        onBeforeShowDay: function (date) {
                        }
                    });
                    
                    //기본 날짜는 해당월 1일 부터 금일까지
                    var today = new Date().print();
                    today = today.substring(0,7) + "-01"
					//생산집계에서 넘어온 데이타 세팅
                    if("${param.etDateFrom}" !== ""){
                    	$("#etDateFrom").val("${param.etDateFrom}")
                    }else{
                    	$("#etDateFrom").val(today)
                    }
                    if("${param.etDateTo}" !== ""){
                    	$("#etDateTo").val("${param.etDateTo}")
                    }else{
                    	$("#etDateTo").val(new Date().print())
                    }
                    
                    
                    
                    $("#mod-info").html("[ 자재 ]");
                },
                bindEvent: function(){
                    var _this = this;
                  //검색부분 품목코드 , 품목명 엔터 조회
                	$(".AXInput.searchInputTextItem").keydown(function (key) {
                        if(key.keyCode == 13){
                        	fnObj.eventFn.itemSearch();
                        }             
                    });
                	$("#btn-itemSearch").bind("click", function(){
                		fnObj.eventFn.itemSearch();
                	});                	
                    $("#ax-page-btn-search").bind("click", function(){
                    	if(pb_data.partCode === ""){
                    		alert("선택한 항목이 없습니다. 좌측 목록에서 선택 후 이용하세요!")
                    		return;
                    	}
                    	fnObj.eventFn.goPdf();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){                    	
                    	if(pb_data.partCode === ""){
                    		alert("선택한 항목이 없습니다. 좌측 목록에서 선택 후 이용하세요!")
                    		return;
                    	}
                    	var params = [];
                    	etDateFrom	= $("#etDateFrom").val();
                    	etDateTo	=  $("#etDateTo").val();     
                       	partCode	= pb_data.partCode;
                       	itemCode	= pb_data.itemCode;
                       	productCode	= $("#product-stmt-item").val();
                       	if(productCode !== ""){
                       		productName	= $("#product-stmt-item option:selected").text();	
                       	}else{
                       		productName	= "";
                       	}    
                       	
                              		                   		
                       	params.push("etDateFrom="+etDateFrom);
                   		params.push("etDateTo="+etDateTo);
                   		params.push("partCode="+partCode);
                   		params.push("itemCode="+itemCode);
                   		params.push("productCode="+productCode);
                   		params.push("productName="+productName);
                   		console.log(params)
                		Common.report.go("/reports/changwon/fune/FUNE4071", "excel", params.join("&"));
                    });
                    
                },
                eventFn: {
                	itemSearch : function(){
                		var pars = fnObj.search.target.getParam();
                		console.log("pars!!", pars);
                		fnObj.gridItem.setPage(pars);
                	},
                	goPdf : function(){
                		
						var params 	= [];
                       	etDateFrom		= $("#etDateFrom").val();
                    	etDateTo		=  $("#etDateTo").val();
                       	partCode		= pb_data.partCode;
                       	itemCode		= pb_data.itemCode;
                       	productCode	= $("#product-stmt-item").val();
                       	if(productCode !== ""){
                       		productName	= $("#product-stmt-item option:selected").text();	
                       	}else{
                       		productName	= "";
                       	}                       	
                              		                   		
                       	params.push("etDateFrom="+etDateFrom);
                   		params.push("etDateTo="+etDateTo);
                   		params.push("partCode="+partCode);
                   		params.push("itemCode="+itemCode);
                   		params.push("productCode="+productCode);
                   		//레포트 본문 쿼리에서 다이나믹 쿼리 오작동하고 리스트로 또 하나 만들지 않고 바로 텍스트 보냄.
                   		params.push("productName="+productName);
                   		
                   		
                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE4071", "pdf", params.join("&"), "if-pdf"); 
                		                		
                	}
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
                                //fnObj.search.submit();
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
									          ajaxUrl: "/FUNE4070/part",
									          ajaxPars: null,
									          ajaxAsync: true,
									          setValue:"${param.partCode}",
									          alwaysOnChange: true,
									          onChange: function() {
									        	  var partCodeVal = this.optionValue;
									        	  $("#" + _target.getItemId("groupCode")).bindSelect({
									        		  reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "groupCode",
	                                                      optionText: "groupName"
	                                                 }
									        		,  	method:"GET"
									        		,	ajaxUrl:"/FUNE4070/recipe/itemGroup"
													, 	ajaxPars: "partCode=" + partCodeVal
													,	ajaxAsync: true
													,	isspace: true
													, 	isspaceTitle: "선택하세요"													
													,	alwaysOnChange: true
													,	onchange: function(){
															//fnObj.eventFn.itemSearch();
														}
													});
									        	  
									        	  $("#product-stmt-item").bindSelect({
									        		  reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "optionValue",
	                                                      optionText: "optionText"
	                                                 }
									        		,  	method:"GET"
									        		,	ajaxUrl:"/FUNE4070/item"
													, 	ajaxPars: "partCode=" + partCodeVal
													,	ajaxAsync: true
													,	isspace: true
													, 	isspaceTitle: "선택하세요"
													,  	setValue: "${param.itemCode}"
													,	alwaysOnChange: true
													,	onchange: function(){
														}
													});
									        	  
									        	  
									          }
									        }
										}
									}									
                                ]},
                                {display:true, addClass:"", style:"", list:[
									{label: "제품분류", labelWidth: "100", type: "selectBox", width: "100", key:"groupCode" , addClass:"" , valueBoxStyle:"" , value:"" ,options:[]}              						
                               ]},
                                {display:true, addClass:"", style:"", list:[
               						{label:"제품코드", labelWidth:"", type:"inputText", width:"150", key:"itemCode", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						}              						
                                ]},
                                {display:true, addClass:"", style:"", list:[
               						{label:"제품명", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						}               						
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                                               
                    }
                },
                gridItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item",
                            theme : "AXGrid",
                            colHeadAlign:"center",                            
                            colGroup : [
                                {key:"partCode"		, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"itemCode"		, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"recipeCode"	, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"itemName"		, label:"제품명"	, width:"340"	, align:"center"},                                
                                {key:"unit"				, label:"단위"		, width:"80"		, align:"center"}
                            ],
                            body : {
                                onclick: function(){
                                	pb_data.partCode 	= this.item.partCode;
                                	pb_data.itemCode 	= this.item.itemCode;
                                	pb_data.itemName 	= this.item.itemName;
                                	pb_data.unit 			= this.item.unit;                                	
                                	
                                	var mod = "[ 자재 ]  " + "  " + this.item.itemCode + " | " + this.item.itemName + "  |  " + this.item.unit;
                            		$("#mod-info").html(mod);
                                	
                                	fnObj.eventFn.goPdf();
                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(searchParams){
                    	var _target = this.target;
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE4070/recipe/item?"+searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{                   
                        		console.log("4070~~",res)
                        		fnObj.gridItem.target.setData({list:res.list});
                            }
                        });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>