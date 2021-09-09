<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "판매전표등록");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="${title }"/>
	<ax:set name="page_desc" value=""/>
	<ax:div name="css">
		<style type="text/css">
			.binso_title, .bill_no {
				font-size: 20px;
				font-weight: bolder;
			}
			.AXTabs .AXTabsTray {
			    box-sizing: content-box !important;
			    border-right: solid 1px gray;
			}
			.large {
				font-size: 15px;
				font-weight: bolder;
			    height: 35px;
			}
		</style>
	</ax:div>
	<ax:div name="contents">

		<ax:row>
			<ax:col size="12" wrap="true">
				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">
							<div class="ax-button-group">
								<div class="left">
									<h1><i class="axi axi-web"></i> 판매전표등록</h1>
									<b:button text="이전전표" id="btn-preStmt"></b:button>
									<b:button text="다음전표" id="btn-nextStmt"></b:button>
								</div>
								<div class="right">
									<b:button text="전체품목삭제" id="btn-removeAllItem"></b:button>
									<b:button text="선택품목삭제" id="btn-removeSelectedItem"></b:button>
								</div>
								<div class="ax-clear"></div>
							</div>

							<div id="div-dead-info"></div>
							<div id="div-grid-saleStmtBd" style="min-height: 650px;"></div>
						</ax:custom>
						<ax:custom customid="td" style="width:48%">
							<div class="ax-button-group">
								<div class="left">
									<b:button text="반납대상" id="btn-returnItem"></b:button>
									<button type="button" class="AXButton large" id="btn-calculateCard">카드정산(F8)</button>
									<button type="button" class="AXButton large" id="btn-calculateCash">현금정산(+)</button>
								</div>
								<div class="right">
									<b:button text="전표저장" id="btn-save"></b:button>
									<b:button text="카드정산(수동)" id="btn-calculateCardManual"></b:button>
									<b:button text="전표삭제" id="btn-deleteStmt"></b:button>
									<b:button text="출력" id="btn-saveAndPrint"></b:button>
								</div>
								<div class="ax-clear"></div>
							</div>
							<div class="ax-search" id="page-search-box"></div>
							<table style="width: 100%;">
								<colgroup>
									<col width="100">
									<col>
								</colgroup>
								<tr>
									<td>
										<div id="div-grid-itemGroup" style="min-height: 700px;"></div>
									</td>
									<td>
										<div id="div-grid-item" style="min-height: 700px;"></div>
									</td>
								</tr>
							</table>
						</ax:custom>
					</ax:custom>
				</ax:custom>

			</ax:col>
		</ax:row>

	</ax:div>
<%--    	<ax:div name="buttons"> --%>
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button> --%>
<%-- 	</ax:div> --%>
	<ax:div name="scripts">
		<script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid_old.js"></script>
		<script type="text/javascript" src="/static/js/common/common.js?v=2"></script>
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript" src="/static/js/common/toss_payments.js"></script>
		<script type="text/javascript">
			var fnObj = {
				CODES: {
//			 		binsoAssign: JSON.parse('<b:optionJson basicCd="123"></b:optionJson>')
					"tab": [
       					{optionValue:"A", optionText:"신청자", closable:false},
      					{optionValue:"P", optionText:"납부자", closable:false},
      					{optionValue:"E", optionText:"사용연장"},
      					{optionValue:"R", optionText:"반환처리"},
      					{optionValue:"C", optionText:"사용승계"},

  					],
				},
				CONSTANTS: {
				},
				data: {
					funeral : null
					, billNo: null
					, billIndex: null
					, part: null
					, totalAmount: 0
					, canSave: true
				},
				condition: {
					isSaleStmt: function(saleStmt){
						return saleStmt.partCode == "${param.partCode}" && saleStmt.billNo == "${param.billNo}";
					}
					, isEachSale: function(){
						return "${param.binsoCode}" == "999";
					}
					, isPartFuneral: function(){
						return "10-001" == "${param.partCode}";
					}
				},
				pageStart: function () {
					this.bindEvent();
					this.search.bind();
					this.gridSaleStmtBd.bind();
					this.gridItem.bind();
					this.gridItemGroup.bind();
					this.gridItemGroup.setPage();
					this.modal.bind();
					this.defaultFn.excute();
				},
				bindEvent: function () {
					$.each($("button[id^=btn-]"), function(i, o){
						var fn = fnObj.eventFn[o.id.substring("btn-".length)];
						if(!fn){
							console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
						}else{
							$(o).bind("click", fn);
						}
					});

					$("body").bind("keyup", function(e){
						switch (e.keyCode) {
						// F8 카드정산
						case 119:
							$("#btn-calculateCard").click();
							break;
						// + 현금정산
						case 107:
							$("#btn-calculateCash").click();
							break;

						default:
							break;
						}
					});

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
				ezCard: {
					getSaleStmtFromEzRes: function(data){
						var saleStmtBd = $.map(fnObj.gridSaleStmtBd.target.list, function(item){
							item.customerNo = "${yyyyMMdd}";
							return item;
						});

						var amount = data.RQ07;
						var vat = data.RQ13;

						var noTaxAmt = 0;
	                	var natAmt = 0;
	                	if(vat == 0){
	                		noTaxAmt = amount;
	                	}else{
	                		natAmt = amount-vat;
	                	}

						var saleStmt = {
								saleStmtBd: saleStmtBd
								, customerNo: "${yyyyMMdd}"
								, etDate: "${etDate}"
								, partCode : "${param.partCode}"
								, amount: data.RQ07
								, jungsanKind: data.RQ01
								, mkind: data.mkind
								, cardNo: data.RQ04
								, cardName: data.RS12
								, cashKind: data.RQ08
								, appNo: data.RS09
								, natAmt: natAmt
								, vatAmt: data.RQ13
								, noTaxAmt: noTaxAmt
								, saleAmt: data.RQ07
								, shopVanCode: "00"
								, shopTid: data.RQ02
								, shopTs: data.RS08
								, cflg: 0
						};
						if(data.RQ01[0] == "D"){
							saleStmt.saleStmtBdCard = {
									customerNo: "${yyyyMMdd}"
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
					, getSaleStmt: function(){
						var saleStmtBd = $.map(fnObj.gridSaleStmtBd.target.list, function(item){
							item.customerNo = "${yyyyMMdd}";
							return item;
						});
						var amount = 0;
						$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
							amount += (o.tamount || 0)
						});
	                	var vat = 0;
	                	if("30-001" == "${param.partCode}" || "31-001" == "${param.partCode}" || "31-002" == "${param.partCode}"){
		                	$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
		                		if(o.item.taxFreeSale == 0){
		                			vat += Math.round((o.tamount/11) / 10) * 10;
		                		}
		                	});
		                	vat = Math.floor(vat);
	                	}
	                	var noTaxAmt = 0;
	                	var natAmt = 0;
	                	if(vat == 0){
	                		noTaxAmt = amount;
	                	}else{
	                		natAmt = amount-vat;
	                	}
						var saleStmt = {
								saleStmtBd: saleStmtBd
								, customerNo: "${yyyyMMdd}"
								, etDate: "${etDate}"
								, partCode : "${param.partCode}"
								, amount: amount
								, jungsanKind: "B1"
								, cardNo: ""
								, cardName: ""
								, cashKind: ""
								, appNo: ""
								, natAmt: natAmt
								, vatAmt: vat
								, noTaxAmt: noTaxAmt
								, saleAmt: amount
						};
						return saleStmt;
					}
				},
				eventFn: {
					searchItem: function(){

			   			app.ajax({
							   type: "GET",
							   url: "/FUNE1012/item",
							   data: "partCode=${param.partCode}&itemCode="+Common.search.getValue(fnObj.search.target, "itemName")
						   },
						   function(res){
						   		if(res.error){
						   			alert(res.error.message);
						   		}else{

						   			if(res.mapResponse.map.item){

						   				var salePrice = res.mapResponse.map.item.salePrice;
										if(!salePrice){
											salePrice = {
													defaultQty: 1
													, price: 0
													, qty: 1
											}
										}
										var buyPrice = res.mapResponse.map.item.buyPrice;
										if(!buyPrice){
											buyPrice = {
													defaultQty: 1
													, price: 0
													, qty: 1
											}
										}
										fnObj.gridSaleStmtBd.add({
											item: res.mapResponse.map.item
											, customerNo: "${param.customerNo}"
											, partCode: "${param.partCode}"
											, itemCode: res.mapResponse.map.item.itemCode
											, defaultQty: Number(salePrice.defaultQty)
											, price: salePrice.price
											, qty: salePrice.defaultQty
											, amount: salePrice.defaultQty*salePrice.price
											, samount: 0
											, tamount: salePrice.defaultQty*salePrice.price
											, costPrice: Math.floor(buyPrice.price/buyPrice.defaultQty)
											, costAmt: Math.floor(salePrice.defaultQty*buyPrice.price/buyPrice.defaultQty)
										});

							   			// 수량 inline editor 활성화
// 							   			fnObj.gridSaleStmtBd.target.editCell("0","1",fnObj.gridSaleStmtBd.target.list.length-1);
							   			if(res.mapResponse.map.isBarCode){
							   				Common.search.setValue(fnObj.search.target, "itemName", "");
											setTimeout(function(){
												Common.search.focus(fnObj.search.target, "itemName");
											}, 100);
											fnObj.gridSaleStmtBd.calc();
							   			}else{
								   			Common.grid.revitalizeInlineEditor(fnObj.gridSaleStmtBd.target, fnObj.gridSaleStmtBd.target.list.length-1, 2);
							   			}

						   			}else{
										var pars = fnObj.search.target.getParam();
										fnObj.gridItem.setPage(pars);
						   			}

							   }
						});
					}
					, save: function(){
						if(fnObj.gridSaleStmtBd.target.list.length == 0){
							return;
						}

						var fnSale = function(){
							var data = fnObj.data;
							var saleStmt;
							if(data.billIndex == null){
								saleStmt = {
										saleStmtBd: fnObj.gridSaleStmtBd.target.list
										, customerNo: data.funeral.customerNo
										, partCode: data.part.partCode
										, count: fnObj.gridSaleStmtBd.target.list.length
										, amount: $("#div-deadInfo-amount").html().number()
										, saleAmt: $("#div-deadInfo-amount").html().number()
								}
							}else{
								saleStmt = data.funeral.saleStmt[data.billIndex];
								if(data.funeral.saleStmt.length-1 != data.billIndex) {
									alert("마지막전표만 수정 가능합니다.")
									return;
								}else{
									saleStmt.saleStmtBd = fnObj.gridSaleStmtBd.target.list
									saleStmt.count = fnObj.gridSaleStmtBd.target.list.length
									saleStmt.amount = $("#div-deadInfo-amount").html().number()
									saleStmt.saleAmt = $("#div-deadInfo-amount").html().number()
								}
							}

							app.ajax({
								type: "POST",
								url: "/FUNE1012/saleStmt",
								data: Object.toJSON(saleStmt)
							},
							function(res){
								if(res.error){
									alert(res.error.message);
								}else{

									fnObj.data.billNo = res.map.saleStmt.billNo;
									fnObj.data.funeral.saleStmt.push(res.map.saleStmt);
									fnObj.data.billIndex = fnObj.data.funeral.saleStmt.length - 1;

									$("#div-deadInfo-billNo").html("#"+fnObj.data.billNo);

								}
							});
						}

						// 매입 시작 후 재고 체크하도록 변경
						fnSale();

// 						app.ajax({
// 							type: "POST",
// 							url: "/FUNE1012/is-sell",
// 							data: Object.toJSON(fnObj.gridSaleStmtBd.target.list)
// 						},
// 						function(res){
// 							if(res.error){
// 								alert(res.error.message);
// 							}else{

// 								if(res.isSale == true){
// 									fnSale();
// 								}else{

// //  									res.result
// 									alert("재고가 부족합니다.");
// 								}

// 							}
// 						});

					}
					, saveAndPrint: function(){

						if(fnObj.gridSaleStmtBd.target.list.length == 0){
							return;
						}

						var fnSale = function(){
							var data = fnObj.data;
							var saleStmt;
							if(data.billIndex == null){
								saleStmt = {
										saleStmtBd: fnObj.gridSaleStmtBd.target.list
										, customerNo: data.funeral.customerNo
										, partCode: data.part.partCode
										, count: fnObj.gridSaleStmtBd.target.list.length
										, amount: $("#div-deadInfo-amount").html().number()
										, saleAmt: $("#div-deadInfo-amount").html().number()
								}
							}else{
								saleStmt = data.funeral.saleStmt[data.billIndex];
								saleStmt.saleStmtBd = fnObj.gridSaleStmtBd.target.list
							}

							app.ajax({
								type: "POST",
								url: "/FUNE1012/saleStmt",
								data: JSON.stringify(saleStmt)
							},
							function(res){
								if(res.error){
									alert(res.error.message);
								}else{

	//						 		fnObj.data.billNo = res.map.saleStmt.billNo;
	//						 		fnObj.data.funeral.saleStmt.push(res.map.saleStmt);
	//						 		fnObj.data.billIndex = fnObj.data.funeral.saleStmt.length - 1;

	//						 		$("#div-deadInfo-billNo").html("#"+fnObj.data.billNo);
									if(parent && parent.fnObj && parent.fnObj.drawBinsoList){
										parent.fnObj.drawBinsoList();
									}

									if("${param.partCode}" == "20-001" || "${param.partCode}" == "21-001"){
										var item = res.map.saleStmt;
										Common.report.print("/reports/changwon/fune/FUNE1016", "pdf", "customerNo="+item.customerNo+"&billNo="+item.billNo+"&etDate="+item.etDate+"&partCode="+"${param.partCode}");
										fnObj.defaultFn.searchFuneral();
										return;
									}

									var stmt = res.map.saleStmt
									// print
									var receiptWin = window.open(`/receipt/saleStmt/one?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");


								}
							});
						};

						// 매입 시작 후 재고 체크하도록 변경
// 						fnSale();
						setTimeout(fnSale, 200);

// 						app.ajax({
// 							type: "POST",
// 							url: "/FUNE1012/is-sell",
// 							data: Object.toJSON(fnObj.gridSaleStmtBd.target.list)
// 						},
// 						function(res){
// 							if(res.error){
// 								alert(res.error.message);
// 							}else{

// 								if(res.isSale == true){
// 									fnSale();
// 								}else{

// //  									res.result
// 									alert("재고가 부족합니다.");
// 								}

// 							}
// 						});

					}
					, removeAllItem: function(){
						if(fnObj.data.canSave){
							fnObj.gridSaleStmtBd.target.setData({list:[]});
							fnObj.gridSaleStmtBd.calc();
						}
					}
					, removeSelectedItem: function(){
						if(fnObj.data.canSave){
							Common.grid.removeSelectedItem(fnObj.gridSaleStmtBd.target);
							fnObj.gridSaleStmtBd.calc();
						}
					}
					, disableButtunsEachSale: function(){
						// 개별판매의 경우 이전전표 삭제 불가 및 재정산 불가
			   			if("${param.binsoCode}" == "999"){
			   				if(fnObj.data.billIndex == null){
			   					$("#btn-calculateCard").prop("disabled", false);
			   					$("#btn-calculateCardManual").prop("disabled", false);
			   					$("#btn-calculateCash").prop("disabled", false);
			   					$("#btn-deleteStmt").prop("disabled", false);
			   				}else{
			   					$("#btn-calculateCard").prop("disabled", true);
			   					$("#btn-calculateCardManual").prop("disabled", true);
			   					$("#btn-calculateCash").prop("disabled", true);
			   					$("#btn-deleteStmt").prop("disabled", true);
			   				}
			   			}
					}
					, preStmt: function(){
						if(fnObj.data.billIndex == 0 || fnObj.data.funeral.saleStmt.length == 0){
							return;
						}

						var beforeIndex;

						if(fnObj.data.billIndex == null){
							beforeIndex = fnObj.data.funeral.saleStmt.length-1;
						}else{
							beforeIndex = fnObj.data.billIndex-1;
						}
			   			var saleStmt = fnObj.data.funeral.saleStmt[beforeIndex];
			   			fnObj.data.billNo = saleStmt.billNo;
			   			fnObj.data.billIndex = beforeIndex;
			   			$("#div-deadInfo-billNo").html("#"+fnObj.data.billNo);
			   			fnObj.gridSaleStmtBd.target.setData({list:saleStmt.saleStmtBd});
			   			fnObj.gridSaleStmtBd.calc();

			   			if(fnObj.data.billNo && fnObj.data.billNo < fnObj.data.funeral.saleStmt.length){
							fnObj.data.canSave = false;
						}else{
							fnObj.data.canSave = true;
						}

			   			fnObj.eventFn.disableButtunsEachSale();
					}
					, nextStmt: function(){

						var initGrid = function(){
							$("#div-deadInfo-billNo").html("");
							fnObj.gridSaleStmtBd.target.setData({list:[]});
							fnObj.data.billIndex = null;
							fnObj.data.billNo = null;
						}

						if(fnObj.data.billIndex != null){
							var next = fnObj.data.funeral.saleStmt[fnObj.data.billIndex+1];
							if(!next){
								initGrid();
							}else{
								fnObj.data.billIndex = fnObj.data.billIndex+1;
								fnObj.data.billNo = next.billNo;
								$("#div-deadInfo-billNo").html("#"+fnObj.data.billNo);
								fnObj.gridSaleStmtBd.target.setData({list:next.saleStmtBd});
							}
						}
						fnObj.gridSaleStmtBd.calc();

						if(fnObj.data.billNo && fnObj.data.billIndex < fnObj.data.funeral.saleStmt.length-1){
							fnObj.data.canSave = false;
						}else{
							fnObj.data.canSave = true;
						}

						fnObj.eventFn.disableButtunsEachSale();
					}
					, deleteStmt: function(){
						if(fnObj.data.billNo == null){
							return;
						}
						if(!fnObj.data.canSave){
							return;
						}
						app.ajax({
							type: "DELETE",
							url: "/FUNE1012/saleStmt",
							data: Object.toJSON(fnObj.data.funeral.saleStmt[fnObj.data.billIndex])
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								toast.push(fnObj.data.billNo + "번 전표가 삭제되었습니다.");
								$("#div-deadInfo-billNo").html("");
								fnObj.gridSaleStmtBd.target.setData({list:[]});
								fnObj.data.billIndex = null;
								fnObj.data.billNo = null;
								if("${param.binsoCode}" == "999"){
									fnObj.defaultFn.searchSaleStmt();
								}else{
									fnObj.defaultFn.searchFuneral();
								}
							}
						});
					}
					, returnItem: function(){
						app.modal.open({
							url:"FUNE1013.jsp",
							pars:"callBack=fnObj.eventFn.addReturnItem&customerNo=${param.customerNo}&partCode=${param.partCode}", // callBack 말고
							//width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
							top:0 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
						})
					}
					, addReturnItem: function(items){

						var saleStmtBd = fnObj.gridSaleStmtBd.target.list;

						$.each(items, function(i, o){

							var salePrice = o.item.salePrice;
							if(!salePrice){
								salePrice = {
										defaultQty: 1
										, price: 0
										, qty: 1
								}
							}
							saleStmtBd.push({
									item: this.item
									, customerNo: "${param.customerNo}"
									, partCode: "${param.partCode}"
									, itemCode: o.item.itemCode
									, defaultQty: salePrice.defaultQty.number()
									, price: salePrice.price
									, qty: o.returnQty*-1
									, amount: (o.returnQty*-1) * salePrice.price
									, samount: 0
									, tamount: (o.returnQty*-1) * salePrice.price
							});
						});

						fnObj.gridSaleStmtBd.target.setData({list: saleStmtBd});

						fnObj.gridSaleStmtBd.calc();

						app.modal.close();
					}
					, calculateCard: function(){

						if(!fnObj.gridSaleStmtBd.target.list || fnObj.gridSaleStmtBd.target.list.length == 0){
							alert("추가된 품목이 없습니다.");
							return;
						}

						setTimeout(function(){
							var amount = 0;

							$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
								amount+=o.tamount;
							});

							fnObj.modal.setOnclose(fnObj.eventFn.closeCardModal);

							app.modal.open({
								url:"FUNE1014.jsp",
								pars:"callBack=fnObj.eventFn.saveSaleStmtBdCard&customerNo=${yyyyMMdd}&partCode=${param.partCode}&amount="+amount, // callBack 말고
								//width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
								//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
							})

						}, 200);

					}
					, calculateCardManual: function(){

						if(!fnObj.gridSaleStmtBd.target.list || fnObj.gridSaleStmtBd.target.list.length == 0){
							alert("추가된 품목이 없습니다.");
							return;
						}
						setTimeout(function(){

							var amount = 0;

							$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
								amount+=o.tamount;
							});

							fnObj.modal.setOnclose(fnObj.eventFn.closeCardModal);

							app.modal.open({
								url:"FUNE1017.jsp",
								pars:"callBack=fnObj.eventFn.saveManualSaleStmtBdCard&customerNo=${yyyyMMdd}&partCode=${param.partCode}&amount="+amount, // callBack 말고
								//width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
								//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
							})
						}, 200);

					}
					, saveSaleStmtBdCard: function(data){

						var saleStmt = fnObj.ezCard.getSaleStmtFromEzRes(data);
						var seed = data.RS20;

						app.ajax({
							type: "POST",
							url: "/FUNE1012/saleStmt",
							data: Object.toJSON(saleStmt)
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								fnObj.modal.removeOnclose();
								app.modal.close();

								var stmt = res.map.stmt

								// print
								var receiptWin = window.open(`/receipt/saleStmt?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");

								toast.push("카드정산이 완료되었습니다.")
								fnObj.defaultFn.searchSaleStmt();
							}
						});

					}
					, saveManualSaleStmtBdCard: function(saleStmt){

						app.ajax({
							type: "POST",
							url: "/FUNE1012/saleStmt",
							data: Object.toJSON(saleStmt)
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								// print
								if(!(saleStmt.saleStmtBdCard && saleStmt.saleStmtBdCard.notice == "수동입력")){
									var stmt = res.map.stmt
									// print
									var receiptWin = window.open(`/receipt/saleStmt?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");
								}
								toast.push("카드정산이 완료되었습니다.")
								fnObj.defaultFn.searchSaleStmt();
							}
						});

						fnObj.modal.removeOnclose();
						app.modal.close();
					}
					, calculateCash: function(){

						if(!fnObj.gridSaleStmtBd.target.list || fnObj.gridSaleStmtBd.target.list.length == 0){
							alert("추가된 품목이 없습니다.");
							return;
						}

						setTimeout(function(){
							var amount = 0;

							$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
								amount+=o.tamount;
							});

							if(amount == 0){
								return;
							}

							fnObj.modal.setOnclose(this.closeCashModal);

								app.modal.open({
									url:"FUNE1015.jsp",
									pars:"callBack=fnObj.eventFn.saveSaleStmtBdCash&customerNo=${yyyyMMdd}&partCode=${param.partCode}&amount="+amount, // callBack 말고
									//width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
									//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
								})

						}, 200)

					}
					, saveSaleStmtBdCash: function(gubun, data){

						var saleStmt = gubun == "D" || gubun == "S" ? fnObj.ezCard.getSaleStmtFromEzRes(data) : fnObj.ezCard.getSaleStmt(data);

						app.ajax({
							type: "POST",
							url: "/FUNE1012/saleStmt",
							data: Object.toJSON(saleStmt)
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								fnObj.modal.removeOnclose();
								app.modal.close();

								if(gubun != "N"){
									// print
//										eachStmt,,,,,,,
									var stmt = res.map.stmt
									// print
									var receiptWin = window.open(`/receipt/saleStmt?customerNo=\${stmt.customerNo}&partCode=\${stmt.partCode}&billNo=\${stmt.billNo}&auto=Y`, "_blank", "width=310,height=600");
								}
								toast.push("현금정산이 완료되었습니다.")
								fnObj.defaultFn.searchSaleStmt();
								parent.fnObj.drawBinsoList();
							}
						});



					}
					, saveManualSaleStmtBdCash: function(saleStmt){

						app.ajax({
							type: "POST",
							url: "/FUNE1012/saleStmt",
							data: Object.toJSON(saleStmt)
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								toast.push("현금정산이 완료되었습니다.")
								fnObj.defaultFn.searchSaleStmt();
								parent.fnObj.drawBinsoList();
							}
						});


						fnObj.modal.removeOnclose();
						app.modal.close();
					}
					, closeCardModal: function(){
						var cardInfo = $("#info-cardInfo", window[myModal.winID].document).val();
						if("" != cardInfo){
							if(confirm("카드정산한 자료를 저장하지 않았습니다.  페이지를 닫으시겠습니까?")){
								return true;
							}else{
								return false;
							}
						}else{
							return true;
						}
					}
					, closeCashModal: function(){
						var no = $("#info-no", window[myModal.winID].document).val();
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
				},
				defaultFn: {
					searchFuneral: function(){
						app.ajax({
							type: "GET",
							url: "/FUNE1012/funeral?customerNo=${param.customerNo}",
							data: ""
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{

								fnObj.data.funeral = res.map.funeral;
								var saleStmt = [];
								$.each(fnObj.data.funeral.saleStmt, function(i, o){
									if("${param.partCode}" == o.partCode){
										saleStmt.push(o);
									}
								});
								fnObj.data.funeral.saleStmt = saleStmt;
								fnObj.data.billNo = null;
								fnObj.data.billIndex = null;
								fnObj.draw.drawDeadInfo(res.map.funeral);
								fnObj.gridSaleStmtBd.target.setData({list:[]});
							}
						});
						fnObj.search.submit();

					}
					, searchSaleStmt: function(){
						app.ajax({
							type: "GET",
							url: "/FUNE1012/eachSale/funeral?customerNo=${param.customerNo}&partCode=${param.partCode}",
							data: ""
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{

								fnObj.data.funeral = res.map.funeral;
								var saleStmt = fnObj.data.funeral.saleStmt;
								fnObj.data.funeral.saleStmt = saleStmt;
								fnObj.data.billNo = null;
								fnObj.data.billIndex = null;
								fnObj.draw.drawEachSale(res.map.funeral);
								fnObj.gridSaleStmtBd.target.setData({list:[]});
							}
						});
					}
					, excute: function(){
						for(var key in this.fn){
							this.fn[key]();
						}

						if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
							return;
						}
						fnObj.defaultFn["${param.m}"]();
					}
					, fn: {
						initButtons: function(){
							if(fnObj.condition.isEachSale()){
								$("#btn-calculateCash").css("display", "inline-block");
								$("#btn-calculateCard").css("display", "inline-block");
								$("#btn-saveAndPrint").css("display", "none");
								$("#btn-save").css("display", "none");
								$("#btn-returnItem").css("display", "none");
							}else if(fnObj.condition.isPartFuneral()){
								$("#btn-returnItem").css("display", "none");
								$("#btn-calculateCash").css("display", "none");
								$("#btn-calculateCard").css("display", "none");
								$("#btn-saveAndPrint").css("display", "none");
								$("#btn-save").css("display", "inline-block");
								$("#btn-calculateCardManual").css("display", "none");
							}else{
								$("#btn-returnItem").css("display", "inline-block");
								$("#btn-calculateCash").css("display", "none");
								$("#btn-calculateCard").css("display", "none");
								$("#btn-saveAndPrint").css("display", "inline-block");
								$("#btn-save").css("display", "inline-block");
								$("#btn-calculateCardManual").css("display", "none");
							}
						}
						, getPart: function(){
							app.ajax({
								type: "GET",
								url: "/FUNE1012/part?partCode=${param.partCode}",
								data: ""
							},
							function(res){
								if(res.error){
									alert(res.error.message);
								}else{

									fnObj.data.part = res.map.part;

								}
							});
						}
					}
				},
				template: {
					keywords: [
						"[binsoName]"
						, "[deadName]"
						, "[balinDate]"
						, "[tamount]"
						, "[applName]"
						, "[jangji]"
						, "[cnt]"
						, "[amount]"
						, "[billNo]"
						, "[partName]"
						, "[totalAmount]"
						, "[saleStmtBd]"
						, "[saleDate]"
						, "[jungsanKind]"
						, "[noTaxAmt]"
						, "[netAmt]"
						, "[vatAmt]"
						, "[totAmt]"
						, "[cardNo]"
						, "[appNo]"
					]
					, deadInfo: "<table class='AXFormTable'>"+
										"<colgroup>"+
											"<col width='100'/>"+
											"<col width='70'/>"+
											"<col/>"+
											"<col width='70'/>"+
											"<col width='120'/>"+
											"<col width='70'/>"+
											"<col width='40'/>"+
											"<col/>"+
											"<col/>"+
										"</colgroup>"+
										"<tr>"+
										"<th rowspan='2'><div class='tdRel binso_title'>[binsoName]</div>"+
										"</th>"+
										"<th><div class='tdRel'>고인명</div>"+
										"</th>"+
										"<td><div class='tdRel'>[deadName]</div>"+
										"</td>"+
										"<th><div class='tdRel'>발인일시</div>"+
										"</th>"+
										"<td><div class='tdRel'>[balinDate]</div>"+
										"</td>"+
										"<th><div class='tdRel'>누계</div>"+
										"</th>"+
										"<td colspan='2' align='right'><div id='div-deadInfo-totalAmount' class='tdRel'>[tamount]</div>"+
										"</td>"+
										"<td rowspan='2' align='center'><div id='div-deadInfo-billNo' class='tdRel bill_no'>[billNo]</div>"+
										"</td>"+
									"</tr>"+
									"<tr>"+
										"<th><div class='tdRel'>상주명</div>"+
										"</th>"+
										"<td><div class='tdRel'>[applName]</div>"+
										"</td>"+
										"<th><div class='tdRel'>장지명</div>"+
										"</th>"+
										"<td><div class='tdRel'>[jangji]</div>"+
										"</td>"+
										"<th><div class='tdRel'>합계</div>"+
										"</th>"+
										"<td><div id='div-deadInfo-count' class='tdRel' align='right'>[cnt]</div>"+
										"</td>"+
										"<td><div id='div-deadInfo-amount' class='tdRel' align='right'>[amount]</div>"+
										"</td>"+
									"</tr>"+
								"</table>"
					, eachSale: "<table class='AXFormTable'>"+
										"<tr>"+
											"<th rowspan='2'><div class='tdRel binso_title'>[binsoName]</div>"+
											"</th>"+
											"<th><div class='tdRel'>판매일자</div>"+
											"</th>"+
											"<td><div class='tdRel'>[saleDate]</div>"+
											"</td>"+
											"<th><div class='tdRel'>누계</div>"+
											"</th>"+
											"<td colspan='2' align='right'><div id='div-deadInfo-totalAmount' class='tdRel'>[tamount]</div>"+
											"</td>"+
											"<td rowspan='2' align='center'><div id='div-deadInfo-billNo' class='tdRel bill_no'>[billNo]</div>"+
											"</td>"+
										"</tr>"+
										"<tr>"+
											"<th><div class='tdRel'>정산방법</div>"+
											"</th>"+
											"<td align='center'><div id='div-deadInfo-jungsanKind' class='tdRel'>[jungsanKind]</div>"+
											"</td>"+
											"<th><div class='tdRel'>합계</div>"+
											"</th>"+
											"<td align='right'><div id='div-deadInfo-count' class='tdRel'>[cnt]</div>"+
											"</td>"+
											"<td align='right'><div id='div-deadInfo-amount' class='tdRel'>[amount]</div>"+
											"</td>"+
										"</tr>"+
									"</table>"
					, deleteKeywords: function(str){
						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
				},
				draw: {
					drawDeadInfo: function(funeral){
						var binso = funeral.binso;
						var thedead = funeral.thedead;
						var applicant = funeral.applicant;
						var saleStmt = funeral.saleStmt;

						var tamount = 0;
						$.each(funeral.saleStmt, function(i,o){
							if(o.saleStmtBd){
								$.each(o.saleStmtBd, function(i,o2){
									tamount += o2.tamount;
								});
							}
						});

						fnObj.data.totalAmount = tamount;

						var html = fnObj.template.deadInfo;

						html = html.replace("[binsoName]", binso.binsoName);
						html = html.replace("[deadName]", thedead.deadName);
						html = html.replace("[applName]", applicant.applName);
						html = html.replace("[balinDate]", funeral.balinDate);
						html = html.replace("[jangji]", funeral.jangji);
						html = html.replace("[tamount]", tamount.money());

						html = html.replace("[cnt]", 0);
						html = html.replace("[amount]", 0);

						html = fnObj.template.deleteKeywords(html);

						$("#div-dead-info").html(html);
					}
					, drawEachSale: function(funeral){

						var binso = funeral.binso;

						var tamount = 0;
						$.each(funeral.saleStmt, function(i,o){
							if(o.saleStmtBd){
								$.each(o.saleStmtBd, function(i,o2){
									tamount += o2.tamount;
								});
							}
						});

						fnObj.data.totalAmount = tamount;

						var html = fnObj.template.eachSale;

						html = html.replace("[binsoName]", binso.binsoName);
						html = html.replace("[saleDate]", funeral.customerNo.date().print("yyyy년mm월dd일"));

						html = html.replace("[tamount]", tamount.money());

						html = html.replace("[cnt]", 0);
						html = html.replace("[amount]", 0);

						html = fnObj.template.deleteKeywords(html);

						$("#div-dead-info").html(html);
					}
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
			   						{label:"", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
			   							onChange: function(){}
			   						},
			   						{label:"", labelWidth:"", type:"button", width:"50", key:"ensType", addClass:"", valueBoxStyle:"", value:"조회",
			   							onclick: function(){
			   								fnObj.search.submit();
			   							}
			   						}
								]}
							]
						});
					},
					submit: function(){
						fnObj.eventFn.searchItem();
					}
				},
				gridSaleStmtBd: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function(){
						var target = this.target, _this = this;
						target.setConfig({
							targetID : "div-grid-saleStmtBd",
							theme : "AXGrid",
							colHeadAlign:"center",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup : [
								{key:"index", label:" ", width:"30", align:"center", formatter: function(){
							   		return +this.index+1;
								}},
								{key:"itemName", label:"품목명", width:"200", align:"left", formatter: function(){
									if(this.item.item){
								   		return this.item.item.itemName;
									}else{
										return "";
									}
								}},
								{key:"qty", label:"수량", width:"60", align:"right", formatter: "number", editor:{
									type:"text",
									maxLength: 50,
									beforeUpdate: function(val){
										if(!fnObj.data.canSave){
											target.list[this.index].__val__ = this.item.qty;
											return this.item.qty;
										}
										return +val.replace(/[^0-9\-.]/g,"");
									},
									afterUpdate: function(){

										if(!fnObj.data.canSave){
											this.item.qty = target.list[this.index].__val__;
											delete target.list[this.index].__val__;
											return;
										}

										this.item.tamount = +this.item.qty * (+this.item.price)+this.item.samount;
										this.item.amount = this.item.tamount;
										this.item.costAmt = +this.item.qty * (+this.item.costPrice)
										fnObj.gridSaleStmtBd.target.updateList(this.index, this.item);
										Common.search.setValue(fnObj.search.target, "itemName", "");
										if("20-001" == "${param.partCode}"){
											setTimeout(function(){
												Common.search.focus(fnObj.search.target, "itemName");
											}, 100);
										}
										fnObj.gridSaleStmtBd.calc();
									}
								}},

								{key:"price", label:"단가", width:"80", align:"right", formatter: "money"},
                                {key:"amount", label:"금    액", width:"80", align:"right", formatter: "money", display:false},

								{key:"samount", label:"조정금액", width:"80", align:"right", formatter: "money", editor:{
									type:"text",
									maxLength: 50,
									beforeUpdate: function(val){
										if(!fnObj.data.canSave){
											target.list[this.index].__val__ = this.item.samount;
											return this.item.samount;
										}
										return val.number();
									},
									afterUpdate: function(){

										if(!fnObj.data.canSave){
											this.item.qty = target.list[this.index].__val__;
											delete target.list[this.index].__val__;
											return;
										}

										this.item.tamount = +this.item.qty*(+this.item.price)+(+this.item.samount);
										fnObj.gridSaleStmtBd.target.updateList(this.index, this.item);
										Common.search.setValue(fnObj.search.target, "itemName", "");
										setTimeout(function(){
											Common.search.focus(fnObj.search.target, "itemName");
										}, 100);
										fnObj.gridSaleStmtBd.calc();
									}
								}},
								{key:"tamount", label:"판매금액", width:"80", align:"right", formatter: "money"},
								{key:"status", label:"상태", width:"60", align:"center",
									formatter: function(){
										return this.item.status == "1" ? "인계완료" : "준비중";
									},
									editor: {
									    type: "select",
									    optionValue: "optionValue",
									    optionText: "optionText",
									    options: [
									    	{optionValue: "0", optionText: "준비중"},
									    	{optionValue: "1", optionText: "인계완료"},
									    ],
									    disabled: function(){
									          return !fnObj.data.canSave;
									    },
									    beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
									        // console.log(val);

									       if(!fnObj.data.canSave){
												target.list[this.index].__val__ = this.item.status;
												return this.item.status;
											}
									       return val.optionValue;
									    },
									    afterUpdate: function(val){ // 수정이 처리된 후
									        // 수정이 된 후 액션.
									        // console.log(this);
									    	if(!fnObj.data.canSave){
												this.item.status = target.list[this.index].__val__;
												delete target.list[this.index].__val__;
												return;
											}
									    },
									    updateWith: ["_CUD"]
									}
								},
								{key:"remark", label:"메모", width:"100", align:"left", editor:{
									type:"text",
									beforeUpdate: function(val){
										if(!fnObj.data.canSave){
											target.list[this.index].__val__ = this.item.remark;
											return this.item.remark;
										}
										return val;
									},
									afterUpdate: function(){

										if(!fnObj.data.canSave){
											this.item.qty = target.list[this.index].__val__;
											delete target.list[this.index].__val__;
											return;
										}
									},
									maxLength: 50
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
					add: function(saleStmtBd){
						if(!fnObj.data.canSave){
							return -1;
						}
// 						this.target.editCellClear();	// 에디터가 활성화 되어 있을경우 추가 안됨.
						if(fnObj.gridSaleStmtBd.target.inline_edit != null){
// 							$(fnObj.gridSaleStmtBd.target.inline_edit.editor).find("input").trigger($.Event("keydown", {keyCode:13}));
							var ids = fnObj.gridSaleStmtBd.target.inline_edit.editor.get(0).id.split(/_AX_/g);
			                var r, c, ii;
			                r = ids[ids.length - 3], c = ids[ids.length - 2], ii = ids[ids.length - 1];
			                fnObj.gridSaleStmtBd.target.updateItem(r, c, ii, fnObj.gridSaleStmtBd.target.inline_edit.editor.find("input").val());
						}



						var idx = -1;
						if(!("20-001" == "${param.partCode}" || "21-001" == "${param.partCode}" || "41-001" == "${param.partCode}")) {
							for(var i=0; i<this.target.list.length; i++){
								if(this.target.list[i].customerNo == saleStmtBd.customerNo
									&& this.target.list[i].partCode == saleStmtBd.partCode
									&& this.target.list[i].itemCode == saleStmtBd.itemCode){
									idx = i;
									this.target.list[i].qty = Number((this.target.list[i].qty||0))+Number((saleStmtBd.qty||0));
									this.target.list[i].amount = (this.target.list[i].amount||0)+(saleStmtBd.amount||0);
									this.target.list[i].samount = (this.target.list[i].samount||0)+(saleStmtBd.samount||0);
									this.target.list[i].tamount = (this.target.list[i].tamount||0)+(saleStmtBd.tamount||0);
									this.target.setData({list: this.target.list});
								}
							}
						}
						if(idx == -1){
							this.target.pushList(saleStmtBd);
							fnObj.gridSaleStmtBd.calc();
							return this.target.list.length-1;
						}else{
							fnObj.gridSaleStmtBd.calc();
							return idx;
						}
					},
					setPage: function(pageNo, searchParams){
					},
					calc: function(){
						var cnt = this.target.list.length;
						var tamount = 0;
				   		$.each(this.target.list, function(i, o){
				   			tamount+= +o.tamount;
						});
				   		$("#div-deadInfo-count").html(cnt);
				   		$("#div-deadInfo-amount").html(tamount.money());

				   		var totalAmount = 0;

				   		var max = fnObj.data.billIndex != null ? fnObj.data.billIndex+1 : fnObj.data.funeral.saleStmt.length;

			   			for(var i=0; i<max; i++){
			   				if(fnObj.data.billIndex == i){
			   					continue;
			   				}
			   				totalAmount+=fnObj.data.funeral.saleStmt[i].amount;
			   			}

		   				totalAmount+=tamount;

				   		$("#div-deadInfo-totalAmount").html(totalAmount.money());
						if(fnObj.data.billIndex != null){
							var jungsanKind = fnObj.data.funeral.saleStmt[fnObj.data.billIndex].jungsanKind;
							if(jungsanKind && jungsanKind[0]){
								var str = {"D": "카드정산", "B": "현금정산"};
								$("#div-deadInfo-jungsanKind").html(str[jungsanKind[0]]);
							}
						}
// 				   		div-deadInfo-totalAmount
// 				   		div-deadInfo-totalAmount
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
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup : [
								{key:"i", label:" ", width:"30", align:"center", formatter: function(){return this.index+1;}},
								{key:"itemCode", label:"코드", width:"80", align:"center", formatter: function(){
									if(this.item.setItem){
										return this.item.setCode;
									}else{
										return this.value;
									}
								}},
								{key:"itemName", label:"품목명", width:"200", align:"left", formatter: function(){
									if(this.item.setItem){
										return this.item.setName;
									}else{
										return this.value;
									}
								}},
								{key:"unit", label:"단위", width:"60", align:"center"},
								{key:"defaultQty", label:"기준수량", width:"80", align:"center", formatter: function(){
									if(this.item.setItem){
										return 0;
									}else{
										return this.item.salePrice ? this.item.salePrice.defaultQty : 0;
									}
								}},
								{key:"price", label:"기준단가", width:"100", align:"right", formatter: function(){
									if(this.item.setItem){
										return 0;
									}else{
										return this.item.salePrice ? this.item.salePrice.price.money() : 0;
									}
								}},
							],
							body : {
								onclick: function(){
									var _this = this;

									if(_this.item.setItem){
										$.each(_this.item.setItem, function(i, o){
											var salePrice = o.item.salePrice;
											if(!salePrice){
												salePrice = {
														defaultQty: 1
														, price: 0
														, qty: 1
												}
											}
											var buyPrice = o.item.buyPrice;
											if(!buyPrice){
												buyPrice = {
														defaultQty: 1
														, price: 0
														, qty: 1
												}
											}
											fnObj.gridSaleStmtBd.add({
												item: o.item
												, customerNo: "${param.customerNo}"
												, partCode: "${param.partCode}"
												, itemCode: o.item.itemCode
												, defaultQty: Number(salePrice.defaultQty)
												, price: Math.floor(salePrice.price/salePrice.defaultQty)
												, qty: o.qty
												, amount: Math.floor(o.qty*salePrice.price/salePrice.defaultQty)
												, samount: 0
												, tamount: Math.floor(o.qty*salePrice.price/salePrice.defaultQty/10)*10
												, costPrice: Math.floor(buyPrice.price/buyPrice.defaultQty)
												, costAmt: Math.floor(o.qty*buyPrice.price/buyPrice.defaultQty)
											});
										});

									}else{
										var salePrice = _this.item.salePrice;
										if(!salePrice){
											salePrice = {
													defaultQty: 1
													, price: 0
													, qty: 1
											}
										}
										var buyPrice = _this.item.buyPrice;
										if(!buyPrice){
											buyPrice = {
													defaultQty: 1
													, price: 0
													, qty: 1
											}
										}
										var saleStmtBd = {
												item: _this.item
												, customerNo: "${param.customerNo}"
												, partCode: "${param.partCode}"
												, itemCode: _this.item.itemCode
												, defaultQty: salePrice.defaultQty
												, price: Math.floor(salePrice.price/salePrice.defaultQty)
												, qty: salePrice.qty
												, amount: Math.floor(salePrice.qty*salePrice.price/salePrice.defaultQty)
												, samount: 0
												, tamount: Math.floor(salePrice.qty*salePrice.price/salePrice.defaultQty/10)*10
												, costPrice: Math.floor(buyPrice.price/buyPrice.defaultQty)
												, costAmt: Math.floor(salePrice.qty*buyPrice.price/buyPrice.defaultQty)
										}
										setTimeout(function(){
											var idx = fnObj.gridSaleStmtBd.add(saleStmtBd);
											Common.grid.revitalizeInlineEditor(fnObj.gridSaleStmtBd.target, idx, 2);
										}, 100);
									}


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

						var item = fnObj.gridItemGroup.target.getSelectedItem();
						if(item.error){
							return;
						}

						var groupCode = item.item.optionValue;
						var url = "/FUNE1012/sale/item";
						if(groupCode == "set"){
							url = "/FUNE1012/sale/set-group";
						}

						app.ajax({
							type: "GET",
							url: url+"?partCode=${param.partCode}&groupCode="+groupCode+"&"+searchParams,
							data: ""
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								for(var i=0; "${param.binsoCode}" == "999" && i<res.list.length; i++){
									if(res.list[i].partCode == "60-001" && res.list[i].itemCode == "20-0010"){
										res.list.splice(i, 1);
										i--;
									}
								}
								fnObj.gridItem.target.setData({list:res.list});
								Common.search.setValue(fnObj.search.target, "itemName", "");
								setTimeout(function(){
									Common.search.focus(fnObj.search.target, "itemName");
								}, 100);
							}
						});
					}
				},
				gridItemGroup: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function(){
						var target = this.target, _this = this;
						target.setConfig({
							targetID : "div-grid-itemGroup",
							theme : "AXGrid",
							colHeadAlign:"center",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup : [
								{key:"optionText", label:"품목그룹", width:"100", align:"left"},
							],
							body : {
								onclick: function(){
									fnObj.search.submit();
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

						app.ajax({
							type: "GET",
							url: "/FUNE1012/sale/itemGroup",
							data: "partCode=${param.partCode}"
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								fnObj.gridItemGroup.target.setData({list: res.list});
								fnObj.gridItemGroup.target.setFocus(0);
								fnObj.search.submit();
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