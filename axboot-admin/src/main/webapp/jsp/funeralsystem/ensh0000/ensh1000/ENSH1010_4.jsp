<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("etDate", DateUtils.formatToDateString("yyyy-MM-dd"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="수납처리" />
	<ax:set name="page_desc" value="" />

	<ax:div name="css">
		<style type="text/css">
			.info {
				border: 1px gray solid;
				padding: 5px;
				height: 80px;
				margin-top: 5px;
				margin-bottom: 5px;
				background-color: #eeeeee;
				display: inline-block;
				width: 98.5%;
				vertical-align: middle;
			}
			.info table{
				width: 100%;
				height: 100%;
			}
		</style>
	</ax:div>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> ${title }</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <ax:custom customid="table">
	                <ax:custom customid="tr">
		                <ax:custom customid="td">
			                <div class="ax-button-group">
			                    <div class="left">
			                        <h3><i class="axi axi-table"></i> 요금내역</h3>
			                    </div>
			                    <div class="right">
									<label id="lb-end"></label>
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>

							<div id="div-grid-saleStmt" style="height: 200px;"></div>
	                	</ax:custom>
	                </ax:custom>
	                <ax:custom customid="tr">
		                <ax:custom customid="td">
			                <div class="ax-button-group">
			                    <div class="left">
			                        <h3><i class="axi axi-table"></i> 결제내역</h3>
			                    </div>
			                    <div class="right">
									<b:button text="현금수납" id="btn-calculateCash"></b:button>
									<b:button text="카드수납" id="btn-calculateCard"></b:button>
									<b:button text="카드수납(수동)" id="btn-calculateCardManual"></b:button>
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>

							<div id="div-grid-payment" style="height: 200px;"></div>
	                	</ax:custom>
	                </ax:custom>
	                <ax:custom customid="tr">
		                <ax:custom customid="td">
		                	<div id="div-calcInfo" class="info">
		                	</div>
	                	</ax:custom>
                	</ax:custom>
                </ax:custom>

			</ax:col>
		</ax:row>

	<iframe name="ezr" width="0" height="0" src="/jsp/funeralsystem/common/ezcardreq.jsp"></iframe>
	</ax:div>
	<ax:div name="buttons">
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">적용</button> --%>
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button> --%>
	</ax:div>
	<ax:div name="scripts">
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript" src="/static/js/common/toss_payments.js"></script>
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.bindEvent();
					this.modal.bind();
					this.gridSaleStmt.bind();
					this.gridPayment.bind();
					this.gridSaleStmt.setPage();
					this.gridPayment.setPage();
					setTimeout(this.draw.drawCalcInfo, 500);
					this.defaultFn.excute();
				},
				CODES: {
					partCode: (function(){
						var result;
			        	app.ajax({
			        			async: false,
			                    type: "GET",
			                    url: "/FUNE5011/part/option",
			                    data: ""
			                },
			                function(res){
			                	result = res;
			            	}
			            );
			        	return result;
					}())
					, kind: Common.getCode("300")
					, jungsanKind: JSON.parse('<b:optionJson basicCd="300"></b:optionJson>')
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				template: {
					keywords: [
                		"[notCalculatedAmount]"
                		, "[msg]"
                	]
					, calcInfo: '<table>'+
					    			'<tr>'+
										'<td align="left" valign="middle">'+
						            		'<label>미정산금액 <input id="info-notCalculatedAmount" readonly="readonly" class="AXInput" value="[notCalculatedAmount]"></label>'+
										'</td>'+
										'<td align="right" valign="middle">[msg]'+
										'</td>'+
									'</tr>'+
								'</table>'
					, deleteKeywords: function(str){
						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
				},
				draw: {
					drawCalcInfo: function(){

						var data = {
								getMsg: function(){
									if(this.notCalculatedAmount > 0){
										return "미정산금액이 남아있습니다.";
									}else{
										return "정산완료";
									}
								}
						};

						var saleStmt =  fnObj.gridSaleStmt.target.list.first() || {amount:0, dcAmt:0};
						var payment =  fnObj.gridPayment.target.list.first() || {totAmt:0};

						var total = +saleStmt.amount-+saleStmt.dcAmt;
						var calc = +payment.totAmt;

						data.notCalculatedAmount = total - calc;

						var template = fnObj.template.calcInfo;

						template = template.replace("[notCalculatedAmount]", data.notCalculatedAmount);
						template = template.replace("[msg]", data.getMsg());

						$("#div-calcInfo").html(template);

						var card = 0;
						var cash = 0;

						$.each(fnObj.gridPayment.target.list, function(i,o){
							if(i==0){
								return;
							}
							if(o.kind[0] == "B"){
								cash+=+o.totAmt;
							}else{
								card+=+o.totAmt;
							}
						});
						$("#info-calcCharge", parent.window.document).val(calc);
						$("#info-calcCashAmt", parent.window.document).val(cash);
						$("#info-calcCardAmt", parent.window.document).val(card);
					}
				},
				bindEvent: function(){
					$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});
				},
				data: {
					resData: null
					, charge: 0
					, calculatedAmount: 0
					, pay: null
				},
				ezCard: {
                	getPaymentFromEzRes: function(data){
                		var isCard = function(){
                			return data.RQ01[0] == "D";
                		}

                		if(data.RQ01 == "B3"){
                			data.RQ01 = "B1";
                		}

                		if(data.RQ01[1] == "2" || data.RQ01[1] == "4"){
                			data.RQ07 = -data.RQ07;
                			data.RQ13 = -data.RQ13;
                		}

                		var dcAmt = +fnObj.gridSaleStmt.target.list[0].dcAmt;

                		var payment = {
                				deadId: ${param.deadId}
                				, tid: data.RQ02
                				, partCode: "80-001"
                				, etDate: "${etDate}"
                				, totAmt: +data.RQ07+dcAmt
                				, cardAmt: isCard() ? data.RQ07 : 0
                				, cashAmt: isCard() ? 0 : data.RQ07
           						, cashKind: data.RQ08
                   				, kind: data.RQ01
                   				, mkind: data.mkind
                   				, shopTid: data.RQ02
                   				, shopTs: data.RS08
                   				, cashKind: data.RQ08
                				, cardNo: data.RQ04
                				, cardName: data.RS12
                				, appNo: data.RS09
                				, netAmt: data.netAmt
                				, vatAmt: data.RQ13
                				, noTaxAmt: data.noTaxAmt
                				, checkCardFlg: data.RS10 == "Y*" ? "1" : "0"
                				, dcAmt: dcAmt
                		};
                		if(isCard()){
                			payment.paymentCard = {
                					deadId: ${param.deadId}
                					, tid: data.RQ02
            						, partCode: "80-001"
	                				, cardInfo: data.RQ04
	                				, appDate: data.RS07
	                				, halbu: data.RQ06
	                				, aquirer: data.RS13
	                				, cardCode: data.RS11
	                				, cardName: data.RS12
	                				, buyNo: data.RS06
	                				, notice: data.RS17
	        				};
                		}
                		return payment;
                	}
					, getPayment: function(amt){
	//						pay.amt, pay.vat
						var payment = {
	            				partCode: "80-001"
            					, tid: "AA"
            					, etDate: "${etDate}"
	            				, totAmt: amt
	            				, cardAmt: 0
	            				, cashAmt: amt
	            				, kind: +amt < 0 ? "B2" : "B1"
	            				, cardNo: null
	            				, cardName: null
	            				, appNo: null
	            				, netAmt: 0
	            				, vatAmt: 0
	            				, noTaxAmt: amt
	            				, checkCardFlg: "0"
	            		};
	            		return payment;
					}

                },
				defaultFn: {

					excute: function(){
                		for(var key in this.fn){
                			this.fn[key]();
                		}

                		if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFn["${param.m}"]();
                	}
                	, fn: {
                		getEnshrine: function(){
                			app.ajax({
	                            type: "GET",
	                            url: "/ENSH1010_4/enshrine",
	                            data: "ensDate=${param.ensDate}&ensSeq=${param.ensSeq}"
	                        },
	                        function(res){
								if(res.error){
									alert(res.error.message);
								}else{
									fnObj.data.enshrine = res.map.enshrine;
								}
	                        });
                		}
                	}
                },
                eventFn: {
                	calculateCash: function(){

                		fnObj.modal.setOnclose(this.closeCashModal);
                		app.modal.open({
                            url:"ENSH1010_6.jsp",
                            pars:"callBack=fnObj.eventFn.savePaymentCash&amount="+$("#info-notCalculatedAmount").val(), // callBack 말고
                            width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
	            	, closeCashModal: function(){
	            		var no = $("#info-appNo", window[myModal.winID].document).val();
	            		if("" != no){
	            			if(confirm("현금정산한 자료를 저장하지 않았습니다.  페이지를 닫으시겠습니까?")){
	            				return true;
	            			}else{
	            				return false;
	            			}
	            		}else{
	            			return true;
	            		}
	            	}
	            	, savePaymentCash: function(gubun, data){
	            		var payment = gubun == "G" ? fnObj.ezCard.getPayment(data) : fnObj.ezCard.getPaymentFromEzRes(data);

                		app.ajax({
                            type: "POST",
                            url: "/ENSH1010_4/payment?deadId=${param.deadId}&ensDate=${param.ensDate}&ensSeq=${param.ensSeq}",
                            data: Object.toJSON(payment)
                        },
                        function(res){
							if(res.error || res.status == "-500"){
								alert(res.error.message);
							}else{

								// print
		                		payment = res.map.payment
		                		var receiptWin = window.open(`/receipt/payment/crem?customerNo=${param.customerNo}&deadId=\${payment.deadId}&tid=\${payment.tid}&seq=\${payment.seq}&auto=Y`, "_blank", "width=310,height=600");

								toast.push("현금정산이 완료되었습니다.")
								fnObj.gridPayment.setPage();
		                		fnObj.modal.removeOnclose();
		                		fnObj.draw.drawCalcInfo();
		                		$("#info-calcCharge", parent.window.document).val(res.map.payment.cardAmt+res.map.payment.cashAmt);
								$("#info-calcCashAmt", parent.window.document).val(res.map.payment.cashAmt);
								$("#info-calcCardAmt", parent.window.document).val(res.map.payment.cardAmt);
		                		app.modal.close();
							}
                        });

	            	}
	            	, calculateCard: function(){

	            		fnObj.modal.setOnclose(this.closeCardModal);
                		app.modal.open({
                            url:"ENSH1010_5.jsp",
                            pars:"callBack=fnObj.eventFn.savePaymentCard&customerNo=${param.customerNo}&amount="+$("#info-notCalculatedAmount").val(), // callBack 말고
                            width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        });

	            	}
	            	, calculateCardManual: function(){

	            		fnObj.modal.setOnclose(this.closeCardModal);
                		app.modal.open({
                            url:"ENSH1010_7.jsp",
                            pars:"callBack=fnObj.eventFn.savePaymentCard&customerNo=${param.customerNo}&amount="+$("#info-notCalculatedAmount").val().number(), // callBack 말고
                            width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        });

	            	}
	            	, closeCardModal: function(){
	            		var no = $("#info-cardInfo", window[myModal.winID].document).val();
	            		if("" != no){
	            			if(confirm("카드정산한 자료를 저장하지 않았습니다.  페이지를 닫으시겠습니까?")){
	            				return true;
	            			}else{
	            				return false;
	            			}
	            		}else{
	            			return true;
	            		}
	            	}
	            	, savePaymentCard: function(data){

	            		var payment = data.RQ01 ? fnObj.ezCard.getPaymentFromEzRes(data) : data;

                		app.ajax({
                            type: "POST",
                            url: "/ENSH1010_4/payment?deadId=${param.deadId}&ensDate=${param.ensDate}&ensSeq=${param.ensSeq}",
                            data: Object.toJSON(payment)
                        },
                        function(res){
							if(res.error || res.status == "-500"){
								alert(res.error.message);
							}else{

								// print
		                		var payment = res.map.payment
		                		var receiptWin = window.open(`/receipt/payment/crem?customerNo=${param.customerNo}&deadId=\${payment.deadId}&tid=\${payment.tid}&seq=\${payment.seq}&auto=Y`, "_blank", "width=310,height=600");

								toast.push("카드정산이 완료되었습니다.")
								fnObj.gridPayment.setPage();
		                		fnObj.modal.removeOnclose();
		                		fnObj.draw.drawCalcInfo();
		                		$("#info-calcCharge", parent.window.document).val(res.map.payment.cardAmt+res.map.payment.cashAmt);
								$("#info-calcCashAmt", parent.window.document).val(res.map.payment.cashAmt);
								$("#info-calcCardAmt", parent.window.document).val(res.map.payment.cardAmt);
		                		app.modal.close();
							}
                        });
	            	}
	            	, reprint: function(itemIdx){

	            		// print
                		var payment = fnObj.gridPayment.target.list[itemIdx];
                		var receiptWin = window.open(`/receipt/payment/crem?customerNo=${param.customerNo}&deadId=\${payment.deadId}&tid=\${payment.tid}&seq=\${payment.seq}&auto=Y`, "_blank", "width=310,height=600");
	            	}

// 	            	, cancel: function(kind, etDate, appNo, amount, vat){
	            	, cancel: function(itemIdx){

	            		var item = fnObj.gridPayment.target.list[itemIdx];
	            		var kind = item.kind;
	            		var etDate = item.etDate;
	            		var appNo = item.appNo;
	            		var amount = item.totAmt-item.dcAmt
	            		var vat = item.vatAmt;
	            		var halbu;
	            		if(item.paymentCard){
	            			halbu = item.paymentCard.halbu;
	            		}

	            		if(!appNo || appNo == '' || appNo == 'undefined' || (item.paymentCard && item.paymentCard.notice == "수동입력")){

	            			var payment = $.extend({}, item);
	            			payment.kind = payment.kind[0]+"2";
	            			payment.totAmt = payment.totAmt*-1;
	            			payment.cardAmt = payment.cardAmt*-1;
	            			payment.cashAmt = payment.cashAmt*-1;
	            			payment.dcAmt = payment.dcAmt*-1;
	            			payment.enuriAmt = payment.enuriAmt*-1;
	            			payment.netAmt = payment.netAmt*-1;
	            			payment.vatAmt = payment.vatAmt*-1;
	            			payment.noTaxAmt = payment.noTaxAmt*-1;
	            			payment.cFlg = 1;

	            			app.ajax({
	                            type: "POST",
	                            url: "/ENSH1010_4/payment/cancel?deadId=${param.deadId}&ensDate=${param.ensDate}&ensSeq=${param.ensSeq}&deadId="+item.deadId+"&tid="+item.tid+"&seq="+item.seq,
	                            data: Object.toJSON(payment)
	                        },
	                        function(res){
								if(res.error || res.status == "-500"){
									alert(res.error.message);
								}else{
									// print
			                		var payment = res.map.payment
			                		var receiptWin = window.open(`/receipt/payment/crem?customerNo=${param.customerNo}&deadId=\${payment.deadId}&tid=\${payment.tid}&seq=\${payment.seq}&auto=Y`, "_blank", "width=310,height=600");
									var str = {"D": "카드", "B": "현금"};
									toast.push(str[payment.kind[0]] + "취소가 완료되었습니다.")
									fnObj.gridPayment.setPage();
			                		fnObj.modal.removeOnclose();
			                		fnObj.draw.drawCalcInfo();
			                		parent.fnObj.searchEnshrine.submit();
			                		app.modal.close();
								}
	                        });
	            			return;
	            		}

	            		var cashGubun = item.cashKind

	            		var callback = function(pdata){

	            			var data = pdata.ezCard
	            			data.netAmt = item.netAmt*-1	// 공급가액
							data.noTaxAmt = item.noTaxAmt*-1	// 면세금액
//                 			console.log(data);
							if(data.SUC == "00"){

	                			if(ezr.window.Ez.isSuccess(data)){

	                				var payment = fnObj.ezCard.getPaymentFromEzRes(data);

	                				app.ajax({
	                                    type: "POST",
	                                    url: "/ENSH1010_4/payment/cancel?deadId=${param.deadId}&ensDate=${param.ensDate}&ensSeq=${param.ensSeq}&deadId="+item.deadId+"&tid="+item.tid+"&seq="+item.seq,
	                                    data: Object.toJSON(payment)
	                                },
	                                function(res){
	        							if(res.error || res.status == "-500"){
	        								alert(res.error.message);
	        							}else{

	        								toast.push(Common.grid.codeFormatter("jungsanKind", kind) + "이 취소되었습니다.")
	        								fnObj.gridPayment.setPage();
	        		                		fnObj.draw.drawCalcInfo();
	        		                		app.modal.close();

	        		                		// print
	        		                		var payment = res.map.payment
	        		                		var receiptWin = window.open(`/receipt/payment/crem?customerNo=${param.customerNo}&deadId=\${payment.deadId}&tid=\${payment.tid}&seq=\${payment.seq}&auto=Y`, "_blank", "width=310,height=600");
	        							}
	                                });

	                			}else{
	                				alert(data.RS16);
	                			}
							}else{
								alert(data.MSG);
							}
                		}

	            		if(item.kind[0] == 'D'){
	            			Pay.Cancel.card(item.cardAmt, item.vatAmt, halbu, item.shopTs, item.etDate.date().print("yyyymmdd"), item.appNo, callback)
	            		}else{
	            			Pay.Cancel.cash(cashGubun, item.cashAmt, item.vatAmt, item.cardNo, item.shopTs, item.etDate.date().print("yyyymmdd"), item.appNo, callback)
	            		}

// 	            		ezr.window.requestReturnCancelTax(kind, amount, etDate.date().print("yyyymmdd").substring(2), appNo, 0, , halbu, cashGubun);
                	}
                },
                modal:{

                	bind: function(){
	                	app.modal.bind();
	                }
                	, setOnclose: function(onclose){
                		app.modal.target.setConfig({
            				onclose: onclose
            			});
                	}
                	, removeOnclose: function(){
                		delete app.modal.target.config.onclose;
                	}
                },
                gridSaleStmt: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-saleStmt",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"partCode", label:"파트", width:"130", align:"center", formatter: function(){
                                	if(this.value == "[ 합  계 ]"){
                                		return this.value;
                                	}
                                	return Common.grid.codeFormatter("partCode", this.value);
                                }},
                                {key:"amount", label:"사용료", width:"100", align:"right", formatter: "money"},
                                {key:"dcAmt", label:"감면액", width:"100", align:"right", formatter: "money"},
                                {key:"charge", label:"부과액", width:"100", align:"right", formatter: function(){
                                	return (this.item.amount - this.item.dcAmt).money();
                                }}
                            ],
                            body : {
                            	ondblclick: function(){
                                },
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
                    setPage: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/ENSH1010_4/saleStmt",
                            data: "ensDate=${param.ensDate}&ensSeq=${param.ensSeq}&deadSeq=${param.deadSeq}"
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								var total = {
										partCode: "[ 합  계 ]"
										, amount: 0
										, dcAmt: 0
										};
								if(res.list){
									$.each(res.list, function(i, ss){
										total.amount+=ss.amount||0
										total.dcAmt+=ss.dcAmt||0
									});
								}

                        		fnObj.gridSaleStmt.target.setData({list:[total].concat(res.list)});

                        		fnObj.data.charge = total.amount - total.dcAmt;
                        		var totAmt = 0;
                        		if(fnObj.gridPayment.target.list && fnObj.gridPayment.target.list[0]){
                        			totAmt = fnObj.gridPayment.target.list[0].totAmt;
                        		}
                        		fnObj.data.calculatedAmount = totAmt;
                        		fnObj.draw.drawCalcInfo();
                            }
                        });
                    }
                },
                gridPayment: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-payment",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"etDate", label:"결제일자", width:"100", align:"center"},
                                {key:"amount", label:"결제금액", width:"100", align:"right", formatter: function(){
                                	if(this.item.etDate == "[ 합  계 ]"){
                                		return this.item.totAmt.money();
                                	}
                                	return (this.item.cashAmt + this.item.cardAmt).money();
                                }},
                                {key:"kind", label:"결제구분", width:"80", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("kind", this.value);
                                }},
                                {key:"appNo", label:"승인번호", width:"100", align:"center"},
                                {key:"cardName", label:"카드사", width:"150", align:"center"},
                                {key:"reprint", label:"재출력", width:"60", align:"center", formatter: function(){
                                	if(this.item.etDate != "[ 합  계 ]"){
	                               		return '<button type="button" class="AXButton" onclick="fnObj.eventFn.reprint('+this.index+')">재출력</button>'
                                	}
                                	return "";
                                }},
                                {key:"kind", label:"취소", width:"50", align:"center", formatter: function(){
                                	if(this.item.cflg == 1){
                                		return "취소";
                                	}
                                	else if(this.value && this.value[1] == "1" && this.item.cflg != 1){
//                                 		return '<button type="button" class="AXButton" onclick="fnObj.eventFn.cancel(\''+this.item.kind+'\', \''+this.item.etDate+'\', \''+this.item.appNo+'\', \''+(this.item.totAmt-this.item.dcAmt)+'\', \''+this.item.vatAmt+'\')">취소</button>'
                                		return '<button type="button" class="AXButton" onclick="fnObj.eventFn.cancel('+this.index+')">취소</button>'
                                	}
                                	return "";
                                }},
                                {key:"notice", label:"notice", width:"100", align:"center", formatter: function(){
                                	if(this.item.paymentCard){
	                                	return this.item.paymentCard.notice;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"partCode", label:"결제", width:"100", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("partCode", this.value)+"결제";
                                }},
                            ],
                            body : {
                            	ondblclick: function(){
                                },
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
                    setPage: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/ENSH1010_4/payment",
                            data: "deadId=${param.deadId}&partCode=80-001"
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var total = {
                        				etDate: "[ 합  계 ]"
										, totAmt: 0
										};
                        		if(res.list){
									$.each(res.list, function(i, ss){
										total.totAmt+=ss.cashAmt + ss.cardAmt
									});
                        		}
                        		fnObj.gridPayment.target.setData({list:[total].concat(res.list)});
                        		fnObj.draw.drawCalcInfo();
                            }
                        });
                    }
                },
				control: {
					save: function(){
           				app.modal.save(window.callBackName, fnObj.data.resData);
					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>