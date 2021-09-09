<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4030.jsp
 - 설      명	: 생산 전표 내역 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.27  1.0        KYM      신규작성
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
				
				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        
                        <ax:custom customid="td" style="width:20%">                          
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>
                        
                        <ax:custom customid="td">
							
									<table cellpadding="0" cellspacing="0" class="AXGridTable" style="height: 45px;">												    
								    	<tbody>
								    		<tr>								    		
								    			<th style="text-align:left;padding-left: 20px;">
								    				<span id="mod-info" style="font-size: 17px;"></span>								    											    									    			
								    			</th>								    		
								    		</tr>
								    	</tbody>
									</table>
	                        
                        	<iframe id="if-pdf" width="100%" height="615" style="border: 0.5px solid lightgray;"></iframe>                        
                        </ax:custom>
                        
                    </ax:custom>
                </ax:custom>
				
								
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-85}
            ];
            var pb_data={            		
                	//그리드 선택 값
                	selectedProductionStmtPartCode		: "",
                	selectedProductionStmtEtDate		: "",
                	selectedProductionStmtBillNo			: "",
                	grid_selected								: ""
                }
            var fnObj = {            	
                pageStart: function(){
                	pb_data.selectedProductionStmtPartCode 	= "${param.partCode}";
                	pb_data.selectedProductionStmtEtDate	 	= "${param.etDate}";
                	pb_data.selectedProductionStmtBillNo	 		= "${param.billNo}";
                	pb_data.grid_selected	 							= "${param.grid_selected}";
                	                	
                	this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                                        
                    if(pb_data.selectedProductionStmtEtDate !== ""){
                    	$("#"+fnObj.search.target.getItemId("etDate")).val(pb_data.selectedProductionStmtEtDate);                        	
                    }
                                                            
                    this.search.submit();
                    
                    $("#mod-info").html("[수정정보]");
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){                    	
                		if(pb_data.selectedProductionStmtPartCode  === "" && pb_data.selectedProductionStmtEtDate === ""){
							alert("선택한 항목이 없습니다.");
							return;
						}
                    	
                    	var params = [];
                    	partCode	= pb_data.selectedProductionStmtPartCode;
                       	etDate		= pb_data.selectedProductionStmtEtDate;
                       	billNo			= pb_data.selectedProductionStmtBillNo;
                       	params.push("partCode="+partCode);
                   		params.push("etDate="+etDate);
                   		params.push("billNo="+billNo);
                   		console.log(params)
                		Common.report.go("/reports/changwon/fune/FUNE4031", "excel", params.join("&"));
                    });
                    
                },
                eventFunc: {
                	goPdf : function(){
                    	var params = [];
                       	partCode	= pb_data.selectedProductionStmtPartCode;
                       	etDate		= pb_data.selectedProductionStmtEtDate;
                       	billNo			= pb_data.selectedProductionStmtBillNo;
                   		                   		
                       	params.push("partCode="+partCode);
                   		params.push("etDate="+etDate);
                   		params.push("billNo="+billNo);                   		
                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE4031", "pdf", params.join("&"), "if-pdf");
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
                                              ajaxUrl: "/FUNE4030/part",
                                              ajaxPars: null,  
                                              setValue : "${param.partCode}",
                                              alwaysOnChange: true,
                                              onChange: function() {                                            	  
                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */ 
                                            	  _this.submit();                                            	 
                                              }
                                            }
										}
									},
									{label:"생산일자", labelWidth:"", type:"inputText", width:"100", key:"etDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
	        										_this.submit();
	        									}
	        								}
	        							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){                    	
                        var pars = this.target.getParam();
                        var pars_arr 		= pars.split('&')
                   	 	var obj 				= {};
                        //파라미터 객체화
	                   	for(var c=0; c < pars_arr.length; c++) {
	                    	var split 		= pars_arr[c].split('=', 2);
	                     	obj[split[0]] 	= split[1];
	                   	}
                        
                        if(obj.partCode != undefined){
                        	fnObj.grid.setPage(fnObj.grid.pageNo, pars);                        		
                        } 
                        
                    }
                },

                grid: {                	
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",                        
                            colGroup : [
                                {key:"partCode"	, label:"코드"				, display :false},                                                                                                
                                {key:"etDate"		, label:"매입일자"		, display :false},
                                {key:"billNo"		, label:"전표번호"		, width:"100"	, align:"center"},
                                {key:"remark"		, label:"생산품목/비고"	, width:"160" 	, align:"center"},                                
                                {key:"udttime"		, label:"수정일시"		, display :false,
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd hh:mm:ss");
                                		}else{
                                			return "";
                                		}
                            		}
                                }                                
                            ],
                            body : {
                                onclick: function(){
                                	pb_data.selectedProductionStmtPartCode 	= this.item.partCode;
                                	pb_data.selectedProductionStmtEtDate	 	= this.item.etDate;
                                	pb_data.selectedProductionStmtBillNo	 		= this.item.billNo;
                                	
                                	var partName = $("#" + fnObj.search.target.getItemId("partCode") +" option:selected").text();
                                	var mod = "[수정정보]  " + "  |  " + this.item.partCode + " " + partName + "  |  " + this.item.udttime.date().print("yyyy-mm-dd hh:mi");
                            		$("#mod-info").html(mod);
                            		fnObj.eventFunc.goPdf();
                                }
                            },
                            page: {
                                display: true,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/FUNE4030/productionStmt",
                            async: false,
                            data: "dummy="+ axf.timekey() +"&" + (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
                            	var obj = {};
                            	var detlist = [];
                            	// Object[]로 받아 오면서 값만 존재. key 직접 삽입
                            	for(var i=0;i<res.length;i++){
                            		var resDet = res[i];
                            		obj = {}                            		
                            		obj.partCode 		= resDet[0];                            		
                            		obj.etDate		 	= resDet[1];
                            		obj.billNo 			= resDet[2];
                            		obj.remark	 		= resDet[5];                            		
                            		obj.udttime 		= resDet[7];                            		
                            		detlist.push(obj);
                            	}
                                var gridData = {
                                    list: detlist
                                };
                                _target.setData(gridData);
                                
                                if(_target.list.length > 0 && pb_data.grid_selected){
                                	fnObj.grid.target.setFocus(pb_data.grid_selected);
                            		fnObj.grid.target.click(pb_data.grid_selected);
                                }
                            }
                        });
                    }
                },


            };
        </script>
    </ax:div>
</ax:layout>