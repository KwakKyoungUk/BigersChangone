<%@page import="java.util.List"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
<%@page import="org.springframework.core.env.Environment"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("amount", request.getParameter("amount"));

%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="현금수납" />
	<ax:set name="page_desc" value="" />

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

				<ax:form name="form-info" id="form-info">
					<table class="AXFormTable">
						<colgroup>
							<col width="100" />
							<col/>
						</colgroup>
						<tr>
							<th><div class='tdRel'>현금영수증</div>
							</th>
							<td><div class='tdRel'>
								<label><input name="c" type="radio" value="N"> 발행안함</label>
								<label><input name="c" type="radio" value="G"> 일반영수</label>
								<label><input name="c" type="radio" value="D" checked="checked"> 소득공제</label>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>발행구분</div>
							</th>
							<td><div class='tdRel'>
								<label><input name="p" type="radio" value="00" checked="checked"> 개인</label>
								<label><input name="p" type="radio" value="01"> 사업자</label>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>고유번호</div>
							</th>
							<td><div class='tdRel'><b:input id="info-no" clazz="W100" value="0100001234"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>승인일자</div>
							</th>
							<td><div class='tdRel'><b:inputDate id="info-appDate" clazz="W100" value=""></b:inputDate>
							</div></td>
						</tr>
					</table>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button id="btn-calculate" type="button" class="AXButton" onclick="fnObj.control.calculate();">정산</button>
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">적용</button> --%>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.bindEvent();
					this.defaultFn.excute();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
				},
				data: {
					resData: null
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
						initAppDate: function(){
							$("#info-appDate").val(new Date().print());
						}
                	}
                },
                eventFn: {
                	reqCash: function(){


            		}
                },
				control: {
					calculate: function(){
						this.save();
					},
					save: function(){

						var c = $("[name=c]:checked").val();

						if(c == "D"){
							if($("#info-no").val() == ""){
								alert("소득공제일 경우 고유번호는 필수 입력사항 입니다.");
								return;
							}
						}

						var saleStmtBd = $.map(parent.window.fnObj.gridSaleStmtBd.target.list, function(item){
							item.customerNo = $("#info-appDate").val().replace("-", "").replace("-", "");
							return item;
						});
						var amount = 0;
						$.each(parent.window.fnObj.gridSaleStmtBd.target.list, function(i, o){
							amount += (o.tamount || 0)
						});
// 						var vat = amount/11;
// 						vat = vat.toFixed(0);
						var vat = 0;
	                	if("30-001" == "${param.partCode}"){
		                	$.each(fnObj.gridSaleStmtBd.target.list, function(i, o){
		                		if(o.item.taxFreeSale == 0){
		                			vat += o.tamount/11;
		                		}
		                	});
		                	vat = Math.floor(vat);
	                	}
						var saleStmt = {
								saleStmtBd: saleStmtBd
								, customerNo: $("#info-appDate").val().replace("-", "").replace("-", "")
								, partCode : "${param.partCode}"
								, etDate: $("#info-appDate").val()
								, amount: amount
								, jungsanKind: "B1"
								, cardNo: c == "D" ? $("#info-no").val() : ""
								, cardName: ""
								, cashKind: $("[name=p]:checked").val()
								, appNo: ""
								, shopVanCode: "00"
								, shopTid: parent.window.fnObj.data.part.showTid
								, natAmt: vat*10
								, vatAmt: vat
								, noTaxAmt: amount-vat*11
								, saleAmt: amount
						};

           				app.modal.save(window.callBackName, saleStmt);

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