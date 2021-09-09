<%@page import="java.util.List"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
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
							<td><div class='tdRel'><b:input id="info-cardInfo" clazz="W200" readonly="readonly" value=""></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납할 금액</div>
							</th>
							<td><div class='tdRel'><b:input id="info-amount" pattern="custom" patternString="99" clazz="W100" readonly="readonly" value="${amount }"></b:input>
							</div></td>
						</tr>
					</table>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button id="btn-calculate" type="button" class="AXButton" onclick="fnObj.control.calculate();">정산</button>
		<button id="btn-save" type="button" class="AXButton" onclick="fnObj.control.save(true);" style="display: none;">승인결과저장</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
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

                		var callback = function(pdata){

                			var data = pdata.ezCard

            				if(data.SUC == "00"){

            					if(Ez.isSuccess(data)){
	            					fnObj.data.resData = data;
	            					$("#info-cardInfo").val(data.RQ04);
									$("#btn-calculate").css("display", "none");
    								$("#btn-save").css("display", "inline-block");
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
            				}
            			}

                		Pay.Appr.card("${amount}", 0, $("#info-halbu").val(), callback)
//             			Ez.reqCreditNoTax("${amount}", $("#info-halbu").val(), );
            		}
                },
				control: {
					calculate: function(){
						fnObj.eventFn.reqCard();
					},
					save: function(isPrinted){
						if(fnObj.data.resData == null){
							alert("카드정산이 완료되지 않았습니다.");
							return;
						}

						if(isPrinted){
							fnObj.data.resData.isPrinted = isPrinted
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