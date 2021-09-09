<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width: 400px;">

                            <div class="ax-button-group">
                                <div class="left">
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="btn-searchSaleStmt"><i class="axi axi-plus-circle"></i> 조회</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

							<div class="ax-search" id="div-searchStmt"></div>
                            <div class="ax-grid" id="div-gridSaleStmt" style="min-height: 300px;"></div>

                        </ax:custom>

                        <ax:custom customid="td">

                            <div class="ax-button-group">
                                <div class="left">
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="btn-cancelStmt"><i class="axi axi-plus-circle"></i> 승인취소</button>
                                    <button type="button" class="AXButton" id="btn-printSaleStmtBd"><i class="axi axi-plus-circle"></i> 내역출력</button>
                                    <button type="button" class="AXButton" id="btn-reprint"><i class="axi axi-plus-circle"></i> 재출력</button>
                                    <button type="button" class="AXButton" id="btn-remove"><i class="axi axi-plus-circle"></i> 승인자료삭제</button>
                                    <button type="button" class="AXButton" id="btn-init" onclick="location.reload()"><i class="axi axi-minus-circle"></i> 초기화</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
							<div class="ax-button-group" id="div-saleInfo"></div>
                            <div class="ax-grid" id="div-gridSaleStmtBd" style="min-height: 300px;"></div>
							<iframe name="ezr" width="0" height="0" src="/jsp/funeralsystem/common/ezcardreq.jsp" hidden="hidden"></iframe>
                        </ax:custom>
                    </ax:custom>
                </ax:custom>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript" src="/static/js/common/toss_payments.js"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"div-gridSaleStmt", adjust:-150},
                {id:"div-gridSaleStmtBd", adjust:-75}
            ];
            var fnObj = {
                CODES: {
                	jungsanKind: Common.getCode("300")
                	, groupCode: Common.getCodeByUrl("/FUNE1100/itemGroup/option")
                },
                pageStart: function(){
                    this.gridSaleStmt.bind();
                    this.gridSaleStmtBd.bind();
                    this.bindEvent();

                    this.searchStmt.bind();
                    this.gridSaleStmt.setPage("partCode=${param.partCode}&etDate="+new Date().print());
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });
                    $.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});
                },
                template: {
                	saleInfo: "<span> | 판매정보 | [jungsanKind]전표([appNo])</span>"
               		, deleteKeywords: function(str){
   						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
   					}
                },
                draw: {
                	drawSaleInfo: function(item){
                		var template = fnObj.template.saleInfo;
                    	template = template.replace("[jungsanKind]", Common.grid.codeFormatter("jungsanKind", item.jungsanKind));
                    	template = template.replace("[appNo]", item.appNo);
                    	$("#div-saleInfo").html(template);
                	}
                },
                ezCard: {
                	getSaleStmtFromEzRes: function(customerNo, data){
                		var saleStmtBd = $.map(fnObj.gridSaleStmtBd.target.list, function(item){
                			var i = $.extend({}, item);
                			i.customerNo = customerNo;
                			i.qty = item.qty*(-1);
                			i.amount = item.amount*(-1);
                			i.samount = item.samount*(-1);
                			i.tamount = item.tamount*(-1);
                			return i;
                		});
                		var saleStmt = {
                				saleStmtBd: saleStmtBd
                				, customerNo: customerNo
                				, partCode : $("#"+fnObj.searchStmt.target.getItemId("partCode")).bindSelectGetValue().optionValue
                				, amount: data.RQ07
                				, jungsanKind: data.RQ01
                				, cardNo: data.RQ04.split("=")[0]
                				, cardName: data.RS12
                				, cashKind: data.RQ08
                				, appNo: data.RS09
                				, natAmt: -1*(data.RQ07-data.RQ13)
                				, vatAmt: -1*(data.RQ13)
                				, noTaxAmt: 0.0
                				, saleAmt: -1*(data.RQ07)
                				, shopTid: data.RQ02
                		};
                		if(data.RQ01[0] == "D"){
                			saleStmt.saleStmtBdCard = {
                					customerNo: customerNo
                       				, partCode: "${param.partCode}"
                       				, cardInfo: data.RQ04
                       				, appDate: data.RS07
                       				, halbu: data.RQ06
                       				, aquirer: data.RS13
                       				, cardCode: data.RS11
                       				, cardName: data.RS12
                       				, buyNo: data.RS03
                       				, notice: data.RS17
                				}
                		}
                		return saleStmt;
                	}
                },
                searchStmt: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"div-searchStmt",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.searchStmt.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                     {label: "파트", labelWidth: "100", type: "selectBox", width: "100", key:"partCode" , addClass:"" , valueBoxStyle:"" , value:"${param.partCode}" ,
                                         options:[
//                                           	 {optionValue:"10", optionText:"장례음식"}
//                                           	 , {optionValue:"75", optionText:"식권"}
                                         ],
                                         AXBind:{
                                             type:"select" , config:{
                                            	 reserveKeys: {
                                                     options: "list",
                                                     optionValue: "partCode",
                                                     optionText: "partName"
                                                },
                                                method:"GET",
                                                ajaxUrl:"/FUNE1100/part/all",
            									ajaxPars:"",
                                                alwaysOnChange: true,
                                                setValue: "${param.partCode}",
                                                onchange: function(){
//                                                 	fnObj.searchStmt.submit();
                                                }
                                             }
                                         }
                                     },
                                ]},
                              	{display:true, addClass:"", style:"", list:[
               						{label:"조회구분", labelWidth:"", type:"selectBox", width:"150", key:"jungsanKind", addClass:"", valueBoxStyle:"", value:"",
                                    	 options:[
//                                       	 {optionValue:"10", optionText:"장례음식"}
//                                       	 , {optionValue:"75", optionText:"식권"}
	                                     ],
	                                     AXBind:{
	                                         type:"select" , config:{
	                                        	 reserveKeys: {
	                                                 options: "list",
	                                                 optionValue: "code",
	                                                 optionText: "name"
	                                            },
	                                            method:"GET",
	                                            ajaxUrl:"/api/v1/basicCodes/group",
	        									ajaxPars:"basicCd=300",
	        									isspace: true,
	        									isspaceTitle: ".",
	                                            alwaysOnChange: true,
	                                            onchange: function(){
// 	                                            	fnObj.searchStmt.submit();
	                                            }
	                                         }
	                                     }
               						},
                               	]},
                              	{display:true, addClass:"", style:"", list:[
               						{label:"판매일자", labelWidth:"", type:"inputText", width:"100", key:"etDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
               							AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate: new Date().print(),
            									onChange:function(){
            										toast.push(Object.toJSON(this));
            									}
            								}
            							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        fnObj.gridSaleStmt.setPage(fnObj.searchStmt.target.getParam());
                        fnObj.gridSaleStmtBd.target.setData({list:[]});
                    }
                },


                // 메인그리드
                gridSaleStmt: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-gridSaleStmt",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"billNo", label:"전표번호", width:"60", align:"center"},
                                {key:"count", label:"품목수", width:"100", align:"center"},
                                {key:"amount", label:"금액", width:"100", align:"center", formatter: "money"},
                                {key:"jungsanKind", label:"정산구분", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.item.cflg == 1){
                                			return "<div style='color: red;'>"+Common.grid.codeFormatter("jungsanKind", this.value)+"</div>";
                                		}
                                        return Common.grid.codeFormatter("jungsanKind", this.value);
                                    }
                                },
                            ],
                            body : {
                                onclick: function(){
									var _this = this;
                                	fnObj.draw.drawSaleInfo(this.item);
                                	var saleStmtBd = $.map(this.item.saleStmtBd, function(o){
                                		o.regtime = "주문 " + _this.item.regtime;
                                		return o;
                                	});
                                    fnObj.gridSaleStmtBd.target.setData({list:saleStmtBd});
                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                }
                            }
                        });
                    },
                    setPage: function(searchParams){
                        var _target = this.target;
                        app.ajax({
                            type: "GET",
                            url: "/FUNE1100/saleStmt",
                            data: (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list,
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },

                // 자식그리드
                gridSaleStmtBd: {
                    parent: {},
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-gridSaleStmtBd",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"seqNo", label:"순번", width:"35", align:"center"},
                                {key:"itemCode", label:"품목코드", width:"80", align:"center"},
                                {key:"itemName", label:"품목명", width:"100", align:"center", formatter: function(){
                                	return this.item.item.itemName;
                                }},
                                {key:"groupCode", label:"분류", width:"80", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("groupCode", this.item.item.groupCode);
                                }},
                                {key:"unit", label:"단위", width:"60", align:"center", formatter: function(){
                                	return this.item.item.unit;
                                }},
                                {key:"price", label:"단가", width:"80", align:"center", formatter: "money"},
                                {key:"qty", label:"수량", width:"60", align:"center"},
                                {key:"tamount", label:"금액", width:"100", align:"center", formatter: "money"},
                                {key:"regtime", label:"접수정보", width:"150", align:"center"},
                                {key:"remark", label:"비고", width:"150", align:"center"},
                            ],
                            body : {
                                onclick: function(){

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
                },
                eventFn: {
                	searchSaleStmt: function(){
                		fnObj.searchStmt.submit();
                	}
                	, cancelStmt: function(){

                		var item = fnObj.gridSaleStmt.target.getSelectedItem();
                		if(item.error){
                			alert(item.error.description);
                			return;
                		}
                		item = item.item;

                		if(!item.shopTs){
                			return;
                		}

                		var kind = item.jungsanKind;

                		if(kind[1] == '2'){
                			return;
                		}

                		var callback = function(pdata){

                			var data = pdata.ezCard
//                 			console.log(data);
							if(data.SUC == "00"){

	                			if(ezr.window.Ez.isSuccess(data)){
	                				var saleStmt = fnObj.ezCard.getSaleStmtFromEzRes(item.customerNo, data);
	                				app.ajax({
	                                    type: "POST",
	                                    url: "/FUNE1100/saleStmt",
	                                    data: Object.toJSON({ori: item, cancel: saleStmt})
	                                },
	                                function(res){
	        							if(res.error){
	        								alert(res.error.message);
	        							}else{
	        								// print
											var stmt = res.map.saleStmt
        									var receiptWin = window.open(`/receipt/saleStmt?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");

	        								toast.push(Common.grid.codeFormatter("jungsanKind", stmt.jungsanKind) + "이 취소되었습니다.")
	        								fnObj.searchStmt.submit();
	        							}
	                                });
	                			}else{
	                				alert(data.RS16);
	                			}
							}else{
								alert(data.RS16);
							}
                		}

                		if(kind[0] == 'D'){
	                		Pay.Cancel.card(item.amount, item.vatAmt, item.saleStmtBdCard.halbu, item.shopTs, item.etDate.replace(/-/gi, ''), item.appNo, callback)
                		}else{
                			Pay.Cancel.cash(item.cashKind, item.amount, item.vatAmt, item.cardNo, item.shopTs, item.etDate.replace(/-/gi, ''), item.appNo, callback)
                		}


//////////////////////////////////////////////////////////////
//                 		var item = fnObj.gridSaleStmt.target.getSelectedItem();
//                 		if(item.error){
//                 			alert(item.error.description);
//                 			return;
//                 		}
//                 		item = item.item;

//                 		if(!item.appNo || item.appNo == '' || item.appNo == null){
//                 			return;
//                 		}

//                 		var halbu;
// 	            		if(item.paymentCard){
// 	            			halbu = item.paymentCard.halbu;
// 	            		}

// 	            		var kind = item.jungsanKind;
// 	            		// 현재 시스템에서 B1 조건을 사용하는 부분이 많아서 이후 레포트들을 정리 후 자진발급이 정상적인 kind로 들어갈수 있도록 해야함.
// 	            		if(item.cardName == '현금(자진발급)'){
// 	            			kind = 'B3';
// 	            		}

// 	            		var cashGubun;
// 	            		if(kind[0] == "B" && item.cardName && item.cardName == '현금(지출증빙)'){
// 	            			cashGubun = "01";
// 	            		} else if(kind[0] == "B") {
// 	            			cashGubun = "00"
// 	            		}

//                 		ezr.window.requestReturnCancelTax(kind, item.amount, item.etDate.date().print("yyyymmdd").substring(2), item.appNo, item.vatAmt, function(data){
// //                 			console.log(data);
// 							if(data.SUC == "00"){

// 	                			if(ezr.window.Ez.isSuccess(data)){
// 	                				var saleStmt = fnObj.ezCard.getSaleStmtFromEzRes(item.customerNo, data);
// 	                				app.ajax({
// 	                                    type: "POST",
// 	                                    url: "/FUNE1100/saleStmt",
// 	                                    data: Object.toJSON({ori: item, cancel: saleStmt})
// 	                                },
// 	                                function(res){
// 	        							if(res.error){
// 	        								alert(res.error.message);
// 	        							}else{
// 	        								// print
// 	        								var template;

// 	        								if(item.jungsanKind[0] == "B"){
// 	        									template = fnObj.draw.drawCashStmt(res.map.saleStmt, "cashStmt");
// 	        								}else{
// 	        									template = fnObj.draw.drawCardStmt(res.map.saleStmt);
// 	        								}

// 		        							Ez.print(template, function(data){
// 		        								console.log(data);
// 		        							});
// 	        								toast.push(Common.grid.codeFormatter("jungsanKind", item.jungsanKind) + "이 취소되었습니다.")
// 	        								fnObj.searchStmt.submit();
// 	        							}
// 	                                });
// 	                			}else{
// 	                				alert(data.RS16);
// 	                			}
// 							}else{
// 								alert(data.MSG);
// 							}
//                 		}, halbu, cashGubun);
                	}
                	, reprint: function(){
                		var item = fnObj.gridSaleStmt.target.getSelectedItem();
                		if(item.error){
                			return;
                		}

                		var stmt = item.item
						// print
						var receiptWin = window.open(`/receipt/saleStmt?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");

//                 		var template;
//                 		if(item.item.jungsanKind.charAt(0) == 'B'){
//                 			template = fnObj.draw.drawCashStmt(item.item, "cashStmt");
//                 		}else{
//                 			template = fnObj.draw.drawCardStmt(item.item);
//                 		}

// 						Ez.print(template, function(data){
// 							console.log(data);
// 						});
                	}
                	, remove: function(){
                		var item = fnObj.gridSaleStmt.target.getSelectedItem();
                		if(item.error){
                			return;
                		}
                		if(!confirm("승인자료를 삭제하시면 복구할 수 없습니다.  삭제하시겠습니까?")){
                			return;
                		}
                		app.ajax({
                            type: "DELETE",
                            url: "/FUNE1100/saleStmt?customerNo="+item.item.customerNo+"&partCode="+item.item.partCode+"&billNo="+item.item.billNo,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
								$("#btn-searchSaleStmt").click();
                            }
                        });
                	}
                	, printSaleStmtBd: function(){
                		var params = [];
                		var partCode	= $("#"+fnObj.searchStmt.target.getItemId("partCode")).val();
                		var from			= $("#"+fnObj.searchStmt.target.getItemId("etDate")).val()

                       	params.push("partCode="+partCode);
                   		params.push("FROM="+from);

                   		console.log(params)
                   		Common.report.open("/reports/changwon/fune/FUNE1071", "pdf", params.join("&"));
                	}
                }

            };
        </script>
    </ax:div>
</ax:layout>