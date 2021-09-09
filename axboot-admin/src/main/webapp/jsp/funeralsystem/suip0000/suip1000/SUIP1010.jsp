<%----------------------------------------------------------------------------------------
 - 파일이름	: SUIP1010.jsp
 - 설      명	: 수입 관리 > 현금 송금 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.14  1.0        KYM      신규작성
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

				<div class="ax-button-group">
                    <div class="left">
                        <b:button  text="송금처리" id="btn-send"></b:button>
                        <b:button  text="송금취소" id="btn-cancel"></b:button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-search" id="page-search-box"></div>

				<div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-85}
            ];
            var pb_data={
                	//조회값
                	srchInGubun		: "",
                	srchInDate			: "",
                	totExpectAmount : 0

            }
            var fnObj = {
            		CODES: {
                		inGubun: Common.getCode("401")
                	},
                pageStart: function(){
                	this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();

                    $("#"+fnObj.search.target.getItemId("inAmount")).attr("disabled", true);
                    $("#"+fnObj.search.target.getItemId("inAmount")).val(pb_data.totExpectAmount.money());
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#btn-send").bind("click", fnObj.eventFunc.sendProc);
                    $("#btn-cancel").bind("click", fnObj.eventFunc.cancelProc);
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from 		= Common.search.getValue(fnObj.search.target, "inDate").replace(/-/g, '');
                		inGubun	= Common.search.getValue(fnObj.search.target, "inGubun");
                		params.push("FROM="+from);
                		params.push("inGubun="+inGubun);
                		Common.report.go("/reports/changwon/suip/SUIP1011", "excel", params.join("&"));
                    });

                },
                eventFunc: {
                	//송금처리
                	sendProc: function(){
                		var _target 				= fnObj.grid.target;
                		var checkedListCopy 	= [];
                		var saleStmtList			= [];
                		var paymentList			= [];
                		//체크된 항목 취득
                		var checkedList 			= _target.getCheckedList(9);
                		//체크된 항목 복사 후 사용
                		checkedListCopy 			= $.extend(true, [], checkedList);
                		if(pb_data.srchInGubun  === "1"){
							alert("송금구분 미송금을 선택하세요.");
							return;
						}
                		if(checkedListCopy.length ===0){
							alert("송금처리 진행하려는 항목을 선택하세요.");
							return;
						}
                		//체크한 항목 중 개별판매 , 빈소 판배 구분하여 전달
                		$.each(checkedListCopy, function(i, o){
                			if(o.gubun === "1"){
                				var objSale = {};
                				objSale.customerNo 	= o.id;
                				objSale.partCode 		= o.partCode;
                				objSale.partCode 		= o.partCode;
                				objSale.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();

                				saleStmtList.push(objSale)
                			}else{
                				var objPay = {};
                				objPay.deadId 		= o.id;
                				objPay.tid	 		= o.partCode;
                				objPay.seq	 		= o.billNo;
                				objPay.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objPay.etDate         = o.balinDate;
                				paymentList.push(objPay)
                			}
                 		});

                		console.log("saleStmtList~", saleStmtList)
                		console.log("paymentList~", paymentList)

                		 var suipCash = {
                			saleStmtList	: saleStmtList,
                			paymentList	: paymentList
                    	}
                		 app.ajax({
                            type: "POST",
                            url: "/SUIP1010/suipCash",
                            data: Object.toJSON(suipCash)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//송금 처리 후 그리드 리로드
                        		fnObj.search.submit();
                            }
                        });

                	},
                	cancelProc: function(){
                		var _target 				= fnObj.grid.target;
                		var checkedListCopy 	= [];
                		var saleStmtList			= [];
                		var paymentList			= [];
                		//체크된 항목 취득
                		var checkedList 			= _target.getCheckedList(9);
                		//체크된 항목 복사 후 사용
                		checkedListCopy 			= $.extend(true, [], checkedList);
                		if(pb_data.srchInGubun  === "0"){
							alert("송금구분 송금을 선택하세요.");
							return;
						}
                		if(checkedListCopy.length ===0){
							alert("송금취소 진행하려는 항목을 선택하세요.");
							return;
						}
                		if (!confirm('정말 송금취소 작업을 진행 하시겠습니까?')) {
                		    return;
                		}
                		//체크한 항목 중 개별판매 , 빈소 판배 구분하여 전달
                		$.each(checkedListCopy, function(i, o){
                			if(o.gubun === "1"){
                				var objSale = {};
                				objSale.customerNo 	= o.id;
                				objSale.partCode 		= o.partCode;
                				objSale.partCode 		= o.partCode;
                				objSale.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();

                				saleStmtList.push(objSale)
                			}else{
                				var objPay = {};
                				objPay.deadId 		= o.id;
                				objPay.tid	 		= o.partCode;
                				objPay.seq	 		= o.billNo;
                				objPay.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objPay.etDate         = o.balinDate;
                				paymentList.push(objPay)
                			}
                 		});

                		console.log("saleStmtList~", saleStmtList)
                		console.log("paymentList~", paymentList)

                		 var suipCash = {
                			saleStmtList	: saleStmtList,
                			paymentList	: paymentList
                    	}

                		app.ajax({
                            type: "POST",
                            url: "/SUIP1010/suipCashCancel",
                            data: Object.toJSON(suipCash)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//송금 취소 후 그리드 리로드
                        		fnObj.search.submit();
                            }
                        });
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
                                	{label:"업무구분", labelWidth:"", type:"selectBox", width:"100", key:"cjob", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1010/basic-select-options",
	                                              ajaxPars:"basic_code=CJOB",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  _this.submit();
	                                              }
	                                            }
											}
									},
									{label:"송금구분", labelWidth:"", type:"selectBox", width:"100", key:"inGubun", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1010/basic-select-options",
	                                              ajaxPars:"basic_code=401",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
	                                            	  _this.submit();
	                                            	  var fn = {
		                                            	  "0": function(){
		                                            		  $("#btn-send").prop("disabled", false);
		                                            		  $("#btn-cancel").prop("disabled", true);
		                                            	  },
		                                            	  "1": function(){
		                                            		  $("#btn-send").prop("disabled", true);
		                                            		  $("#btn-cancel").prop("disabled", false);
		                                            	  }
	                                            	  }
	                                            	  fn[this.value]();
	                                              }
	                                            }
											}
									},
									{label:"송금일자", labelWidth:"", type:"inputText", width:"100", key:"inDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
	        										_this.submit();
	        									}
	        								}
	        							}
               						},
               						{label:"예상금액", labelWidth:"", type:"inputText", width:"150", key:"inAmount",addClass:"al-expect-amount", valueBoxStyle:"", value:""}
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
	                   	pb_data.srchInGubun 	= obj.inGubun;
	                   	pb_data.srchInDate		= obj.inDate;
	                   	if(obj.inGubun != undefined){
	                   		fnObj.grid.setPage(pars);
	                   	}
                        //검색 시 체크해제
                        fnObj.grid.target.checkedColSeq(9, false);
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
                                {key:"gubun"		, label:"코드"				, display :false},
                                {key:"id"				, label:"아이디"			, display :false},
                                {key:"partCode"	, label:"코드"				, display :false},
                                {key:"billNo"		, label:"코드"				, display :false},
                                {key:"balinDate"	, label:"발인날짜"		, width:"100"	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                            		}
                                },
                                {key:"partName"	, label:"파트명"			, width:"200" 	, align:"left"},
                                {key:"goin"			, label:"고인정보"		, width:"200" 	, align:"left"},
                                {key:"amount"		, label:"현금금액"		, width:"100" 	, align:"right" , formatter: "money"},
                                {key:"inDate"		, label:"송금일자"		, width:"100" 	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                            		}
                                },
                                {key:"index"		, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"}
                            ],
                            body : {
                            	 oncheck       : function(){
//                             		 if(pb_data.srchInGubun  !== "1"){
                            			var chked 					= this.checked;
     									var idx						= this.index;
     									var lngth					= this.list.length;
     									var item						= this.item;
     									var totExpectAmount	= pb_data.totExpectAmount;
     									var tamount 				= 0;
                                 		//전체체크
                                 		if(chked === true && idx === lngth){
                                 			$.each(this.list, function(i, o){
                                        			tamount+= +o.amount;
                                         	});
                                 			pb_data.totExpectAmount = tamount;
                                 		//전체체크해제
                                 		}else if(chked === false && idx === lngth){
                                 			pb_data.totExpectAmount = 0;
                                 		//개별체크
                                 		}else if(chked === true && idx !== lngth){
                                 			totExpectAmount = totExpectAmount + item.amount;
                                 			pb_data.totExpectAmount = totExpectAmount;
                                 		//개별체크 해제
                                 		}else if(chked === false && idx !== lngth){
                                 			totExpectAmount = totExpectAmount - item.amount;
                                 			pb_data.totExpectAmount = totExpectAmount;
                                 		}
                                 		$("#"+fnObj.search.target.getItemId("inAmount")).val(pb_data.totExpectAmount.money());
//              						}
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
                    clear: function(){
                        this.target.setList([]);
                    },
                    setPage: function(searchParams){
                        var _target = this.target;
                        searchParams = searchParams + "&display="

                        app.ajax({
                            type: "GET",
                            url: "/SUIP1010/cashSend?" + searchParams,
                            data:""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
                            	console.log("res~~Cash~",res);
                            	var obj 					= {};
                            	var detlist 				= [];
                            	for(var i=0;i<res.length;i++){
                            		//개별 : sale_stmt 											, 빈소 :payment
                            		var resDet 			= res[i];
                            		obj 					= {}
                            		obj.gubun	 		= resDet[0];//'1':개별판매 												,'2':빈소판매 임의의 구분값을 직접 부여
                            		obj.id			 		= resDet[1];//개별 : CUSTOMER_NO 									,빈소 : DEAD_ID
                            		obj.partCode 		= resDet[2];//개별 : PART_CODE 										,빈소 : TID
                            		obj.billNo 			= resDet[3];//개별 : BILL_NO 											,빈소 : SEQ
                            		obj.balinDate		= resDet[4];//개별 : CUSTOMER_NO 그대로 							,빈소 : FUNERAL.BALIN_DATE
                            		obj.partName		= resDet[5];//개별 : "창원시설관리공단" + PART.PART_NAME  	,빈소 : "창원시설관리공단" 직접 부여
                            		obj.goin				= resDet[6];//개별 : "개별판매" 직접부여  								,빈소 : BINSO.BINSO_NAME+故+THEDEAD.DEAD_NAME
                            		obj.amount			= resDet[7];//개별 : SUM(AMOUNT)									,빈소 : CASH_AMT
                            		obj.inDate			= resDet[8];//개별 & 빈소 : IN_DATE
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
        </script>
    </ax:div>
</ax:layout>