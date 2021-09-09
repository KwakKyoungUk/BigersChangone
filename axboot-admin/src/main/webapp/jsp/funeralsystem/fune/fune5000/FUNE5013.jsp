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

// 	RuntimeMXBean runtimeMxBean = ManagementFactory.getRuntimeMXBean();
// 	List<String> arg = runtimeMxBean.getInputArguments();

// 	for(String ar : arg){
// 		if(ar.startsWith("-Dspring.profiles.active=")){
// 			if(ar.contains("local")){
// 				request.setAttribute("amount", "1004");
// 			}
// 		}
// 	}

%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="현금수납" />
	<ax:set name="page_desc" value="" />
	<ax:div name="css">
		<style type="text/css">
			input[id^='info-'] {
				font-size: 20px;
				font-weight: bolder;
				height: 25px;
			}
			button[id^='btn-'] {
				font-size: 20px;
				font-weight: bolder;
				height: 30px;
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
								<label><input name="c" type="radio" value="G"> 일반영수</label>
								<label><input name="c" type="radio" value="D" checked="checked"> 소득공제</label>
								<label><input name="c" type="radio" value="S"> 자진발급</label>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>발행구분</div>
							</th>
							<td><div class='tdRel'>
								<label><input name="p" type="radio" value="1" checked="checked"> 개인</label>
								<label><input name="p" type="radio" value="2"> 사업자</label>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>고유번호</div>
							</th>
							<td><div class='tdRel'><b:input id="info-appNo" clazz="W150" readonly="readonly"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납대상금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-amount" clazz="W150" readonly="readonly" value="${amount}"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>감면대상금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-dcAmt" clazz="W150" readonly="readonly" value="${dcAmt }"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납할금액</div>
							</th>
							<td><div class='tdRel'>
								<b:input id="info-receiptAmt" clazz="W150" value="${amount}" ></b:input>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input id="info-accountFlag" type="checkbox" class="AXInput" value="Y" name="accountFlag" style="width: 25px; height: 25px;">
								<label for="info-accountFlag">계좌이체</label>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납잔액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-dcAmt" clazz="W150" readonly="readonly" value="${dcAmt }"></b:input>
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
		<button id="btn-cancel" type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript" src="/static/js/common/toss_payments.js"></script>
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					$("#info-amount").bindMoney();
					$("#info-dcAmt").bindMoney();
					$("#info-receiptAmt").bindMoney();
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

                	}
                },
                eventFn: {
                	reqCash: function(){

                		if($("#info-receiptAmt").val().number() > $("#info-amount").val().number()){
                			alert("수납대상금액보다 수납할 금액이 많습니다.\n 수납금액을 확인해주세요.");
                			return;
                		}

                		var o = {
                			G: function(){
                				app.ajax({
                                    type: "GET",
                                    url: "/FUNE5013/pay",
                                    data: "customerNo=${param.customerNo}&receiptAmt="+$("#info-receiptAmt").val().number()
                                },
                                function(res){
        							if(res.error){
        								alert(res.error.message);
        							}else{
        								fnObj.data.resData = res.map.pay;
        								fnObj.control.save()
        							}
                                });
                			}
                			, D: function(){

                				var _this = this;

                				app.ajax({
                                    type: "GET",
                                    url: "/FUNE5013/pay",
                                    data: "customerNo=${param.customerNo}&receiptAmt="+$("#info-receiptAmt").val().number()
                                },
                                function(res){
        							if(res.error){
        								alert(res.error.message);
        							}else{
										var pay = res.map.pay;

										var callback = function(pdata){

											var data = pdata.ezCard
											data.netAmt = pay.netAmt	// 공급가액
		   									data.noTaxAmt = pay.noTaxAmt	// 면세금액

                        					if(data.SUC == "00"){
                        						if(Ez.isSuccess(data)){
	                        						$("#info-appNo").val(data.RQ04);
	                        						fnObj.data.resData = data;
	                        						$("#btn-calculate").css("display", "none");
	                        						fnObj.control.save()
                        						}else{
	                            					$("#info-appNo").val("");
	                            					fnObj.data.resData = null;
	                        						$("#btn-calculate").css("display", "inline-block");
	                        						alert(data.RS16);
                        						}
                            				}else{
                            					$("#info-appNo").val("");
                            					fnObj.data.resData = null;
                        						$("#btn-calculate").css("display", "inline-block");
                            				}
                        				}
										Pay.Appr.cash($("[name=p]:checked").val(), pay.amt, pay.vat, "", callback)
//         								Ez[_this[$("[name=p]:checked").val()]](pay.amt, pay.vat, );
        							}
                                });


                			}
                			, S: function(){

                				var _this = this;

                				app.ajax({
                                    type: "GET",
                                    url: "/FUNE5013/pay",
                                    data: "customerNo=${param.customerNo}&receiptAmt="+$("#info-receiptAmt").val().number()
                                },
                                function(res){
        							if(res.error){
        								alert(res.error.message);
        							}else{
										var pay = res.map.pay;

										var callback = function(pdata){

											var data = pdata.ezCard
											data.netAmt = pay.netAmt	// 공급가액
		   									data.noTaxAmt = pay.noTaxAmt	// 면세금액

                        					if(data.SUC == "00"){
                        						if(Ez.isSuccess(data)){
	                        						$("#info-appNo").val(data.RQ04);
	                        						fnObj.data.resData = data;
	                        						$("#btn-calculate").css("display", "none");
	                        						fnObj.control.save()
                        						}else{
	                            					$("#info-appNo").val("");
	                            					fnObj.data.resData = null;
	                        						$("#btn-calculate").css("display", "inline-block");
	                        						alert(data.RS16);
                        						}
                            				}else{
                            					$("#info-appNo").val("");
                            					fnObj.data.resData = null;
                        						$("#btn-calculate").css("display", "inline-block");
                            				}
                        				}

										Pay.Appr.cash($("[name=p]:checked").val(), pay.amt, pay.vat, "0100001234", callback)

//         								Ez.reqCashJajinTax(pay.amt, pay.vat, );
        							}
                                });


                			}
                		}

                		o[$("[name=c]:checked").val()]();

            		}
                },
				control: {
					calculate: function(){
						fnObj.eventFn.reqCash();
					},
					save: function(){
						if(fnObj.data.resData == null){
							alert("현금정산이 완료되지 않았습니다.");
							return;
						}
						fnObj.data.resData.accountFlag = $("#info-accountFlag:checked").val() || "N"
           				app.modal.save(window.callBackName, $("[name=c]:checked").val(), fnObj.data.resData);

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