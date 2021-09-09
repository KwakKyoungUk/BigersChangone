<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE3012.jsp
 - 설      명	: 매입관리 > 매입거래명세서 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.01  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "매입거래명세서");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="${title }"/>
	<ax:set name="page_desc" value=""/>
    <ax:div name="css">
    	<style type="text/css">
    	</style>
    </ax:div>
    <ax:div name="contents">

        <div class="ax-body">
            <div class="ax-wrap">
                <div class="ax-layer cx-content-layer">
                    <div class="ax-col-12 ax-content expand">
                        <!-- s.CXPage -->
                        <div id="CXPage">

                            <ax:row>
                                <ax:col >
                   					<ax:custom customid="table">
	                    				<ax:custom customid="tr">
			                        		<ax:custom customid="td" style="width:30%">
			                                    <div class="ax-button-group">
			                                        <div class="left">
			                                            <h1><i class="axi axi-web"></i> ${title }</h1>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
												<div class="ax-button-group">
					                               <div class="right">
														<b:button text="조회" id="btn-itemSearch"></b:button>
					                               </div>
					                             </div>
					                			<div class="ax-search" id="page-search-box"></div>
					                			<div id="div-grid-box" style="min-height: 480px;"></div>



	    	    	                        </ax:custom>

			                        		<ax:custom customid="td">
			                        			<div class="ax-button-group">
					                            	<div class="right">
														<b:button text="인쇄" id="btn-print"></b:button>
					                            	</div>
					                            </div>
			                        			<table cellpadding="0" cellspacing="0" class="AXGridTable" style="height: 45px;">
											    	<tbody>
											    		<tr>
											    			<th style="text-align:left;padding-left: 25px;">
											    				<span id="mod-info" style="font-size: 17px;"></span>
											    			</th>
											    		</tr>
											    	</tbody>
													</table>
													<iframe id="if-pdf" width="100%" height="625" style="border: 0.5px solid lightgray;"></iframe>
	    	    	                        </ax:custom>
    	    	                        </ax:custom>
        	                        </ax:custom>

                                </ax:col>
                            </ax:row>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ax:div>
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">
        var pb_data={
            	//그리드 선택 값
            	selectedPartCode		: "${param.partCode}",
            	selectedCustCode		: "${param.custCode}",
            	selectedEtDate			: "${param.buyEtDate}",
            	selectedBillNo			: "${param.billNo}",
        	}

        	var fnObj = {
            	CODES: {

            	},
            	CONSTANTS: {
            	},
                pageStart: function () {
                    this.search.bind();
                    this.gridItem.bind();
                    this.bindEvent();
                    this.search.submit();

                    $("#mod-info").html("[ 매입정보 ]");
                    fnObj.eventFn.goPdf();
                },
                bindEvent: function () {
                	$("#btn-itemSearch").bind("click", function(){
                		fnObj.search.submit();
                	});
                	var iframe = document.getElementById("if-pdf");
                	iframe.onload = function(){
	                	var mediaQueryList = iframe.contentWindow.matchMedia('print');
                		mediaQueryList.addListener(function (mql) {
	                	    console.log('print event', mql);
	                	});
                	}

                	$("#btn-print").bind("click", function(){
                		var iframe = document.getElementById("if-pdf");
                		iframe.focus();
// 						iframe.contentWindow.onafterprint = function(){
// 							console.log("프린트 완료!!!!");
// 							parent.myModal.close();
// 						};
						iframe.contentWindow.print();
                	});
                },
                eventFn: {
                	goPdf : function(){
						var params 	= [];
						partCode		= pb_data.selectedPartCode;
						custCode		= pb_data.selectedCustCode;
						etDate			= pb_data.selectedEtDate;
						billNo				= pb_data.selectedBillNo;

						params.push("partCode="+partCode);
						params.push("custCode="+custCode);
						params.push("etDate="+etDate);
                   		params.push("billNo="+billNo);
                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE3013", "pdf", params.join("&"), "if-pdf");
                	}
                },
                defaultFn: {
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
                                     {label: "파트", labelWidth: "100", type: "selectBox", width: "100", key:"partCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
                                         options:[],
                                         AXBind:{
                                             type:"select" , config:{
                                            	 reserveKeys: {
									                  options: "list",
									                  optionValue: "partCode",
									                  optionText: "partName"
												},
												ajaxUrl: "/FUNE3012/part",
										        ajaxPars: null,
										        ajaxAsync: true,
										        setValue:"${param.partCode}",
                                                alwaysOnChange: true,
                                                onchange: function(){
                                                	var partCodeVal = this.optionValue;
                                                	var etDate = "${param.etDate}"

                                                	$("#" + _target.getItemId("custCode")).bindSelect({
  									        		  reserveKeys: {
	  	                                                    options: "list",
	  	                                                    optionValue: "optionValue",
		                                                    optionText: "optionText"
  	                                                 	}
  									        		,  	method:"GET"
  									        		,	ajaxUrl:"/FUNE3012/customer/list"
  													, 	ajaxPars: "partCode=" + partCodeVal + "&etDate=" + etDate
  													,	ajaxAsync: true
  													,	isspace: true
  													, 	isspaceTitle: "선택하세요"
  													,  	setValue: "${param.custCode}"
  													,	alwaysOnChange: true
  													,	onchange: function(){
  															fnObj.search.submit();
  														}
  													});
                                                }
                                             }
                                         }
                                     }
                                ]},
                                {display:true, addClass:"", style:"", list:[
                                	{label: "거래처", labelWidth: "100", type: "selectBox", width: "200", key:"custCode" , addClass:"" , valueBoxStyle:"" , value:"" ,options:[]}
								]},
								{display:true, addClass:"", style:"", list:[
									{label:"매입일자", labelWidth:"", type:"inputText", width:"70", key:"etDateFrom", addClass:"", valueBoxStyle:"", value: (function(){
										var date = new Date("${param.etDate}");
										date.setDate(1);
										return date.print();
									}()),
										onChange: function(){}
									},
									{label:"", labelWidth:"", type:"inputText", width:"90", key:"etDateTo", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date("${param.etDate}").print(),
									AXBind:{
										type:"twinDate", config:{
											align:"right", valign:"top", startTargetID:"etDateFrom",
											onChange:function(){

											}
										}
									}
									}
   								]},
                            ]
                        });
                    },
                    submit: function(){
                    	var pars = fnObj.search.target.getParam();
                    	fnObj.gridItem.setPage(pars);
                    }
                },
                //좌측 그리드
                gridItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
								{key:"partCode"	, label:"코드"			, width:"60"		, display :false},
								{key:"custCode"	, label:"코드"			, width:"60"		, display :false},
								{key:"etDate"		, label:"매입일자"	, width:"90"	, align:"center"},
								{key:"billNo"		, label:"전표번호"	, width:"60"		, align:"right"},
								{key:"count"		, label:"품목수"	, width:"60" 	, align:"right"},
								{key:"amount"		, label:"매입금액"	, width:"100" 	, align:"right"	, formatter: "money"}
                            ],
                            body : {
                                onclick: function(){
                                	pb_data.selectedPartCode 	= this.item.partCode;
                                	pb_data.selectedCustCode 	= this.item.custCode;
                                	pb_data.selectedEtDate	 	= this.item.etDate;
                                	pb_data.selectedBillNo 			= this.item.billNo;

                                	var custName = $("#" + fnObj.search.target.getItemId("custCode") +" option:selected").text();
                                	var mod = "[ 매입정보 ]  " + "  " + custName  + " | " + pb_data.selectedBillNo + "번전표";
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
                            url: "/FUNE3012/customer/bill_list?"+searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var obj 				= {};
                            	var detlist 			= [];
                            	// Object[]로 받아 오면서 값만 존재. key 직접 삽입
                            	for(var i=0;i<res.length;i++){
                            		var resDet 		= res[i];
                            		obj 				= {}
                            		obj.partCode 	= resDet[0];
                            		obj.custCode 	= resDet[1];
                            		obj.etDate		= resDet[2];
                            		obj.billNo 		= resDet[3];
                            		obj.count 		= resDet[4];
                            		obj.amount 		= resDet[5];
                            		detlist.push(obj);
                            	}
                                var gridData = {
                                    list: detlist
                                };
                                _target.setData(gridData);

                            }
                        });
                    }
                },

            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
        </script>
    </ax:div>
</ax:layout>