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
	<ax:set name="title" value="카드수납" />
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
							<th><div class='tdRel'>할부</div>
							</th>
							<td><div class='tdRel'>
								<b:input id="info-halbu" pattern="custom" patternString="99" clazz="W100" value="00"></b:input>
								<span style="color: red;">[0:일시불]</span>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>카드번호</div>
							</th>
							<td><div class='tdRel'><b:input id="info-cardInfo" clazz="W250" readonly="readonly" value=""></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납대상 금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-amount" clazz="W150" readonly="readonly" value="${amount }"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>감면대상 금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-dcAmt" clazz="W150" readonly="readonly" value="${dcAmt }"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납할금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-receiptAmt" clazz="W150" value="${amount}" ></b:input>
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
                	reqCard: function(){

                		if(+$("#info-receiptAmt").val().number() > $("#info-amount").val().number()){
                			alert("수납대상금액보다 수납할 금액이 많습니다.\n 수납금액을 확인해주세요.");
                			return;
                		}

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
   								Pay.Appr.card(pay.amt, pay.vat, $("#info-halbu").val(), function(pdata){

   									var data = pdata.ezCard
   									data.netAmt = pay.netAmt	// 공급가액
   									data.noTaxAmt = pay.noTaxAmt	// 면세금액

                   					if(data.SUC == "00"){
                   						if(Ez.isSuccess(data)){
                    						$("#info-cardInfo").val(data.RQ04);
                    						fnObj.data.resData = data;
                    						$("#btn-calculate").css("display", "none");
                    						fnObj.control.save();
                   						}else{
                        					$("#info-cardInfo").val("");
                        					fnObj.data.resData = null;
                    						$("#btn-calculate").css("display", "inline-block");
                    						alert(data.RS16);
                   						}
                       				}else{
                       					$("#info-cardInfo").val("");
                       					fnObj.data.resData = null;
                   						$("#btn-calculate").css("display", "inline-block");
                   						if(data.RS17){
        									alert(data.RS17);
        								}
                       				}
                   				})
   							}
                        });

           			}

                },
				control: {
					calculate: function(){
						fnObj.eventFn.reqCard();
					},
					save: function(){
						if(fnObj.data.resData == null){
							alert("카드정산이 완료되지 않았습니다.");
							return;
						}
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