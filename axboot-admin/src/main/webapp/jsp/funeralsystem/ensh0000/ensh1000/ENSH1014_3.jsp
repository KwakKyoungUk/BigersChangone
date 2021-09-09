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
								<label><input name="c" type="radio" value="S" checked="checked"> 자진발급</label>
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
							<td><div class='tdRel'><b:input id="info-no" clazz="W100" readonly="readonly" value="010-000-1234"></b:input>
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
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
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
                	reqCash: function(){

                		var o = {
                			G: function(){
                				fnObj.data.resData = "${amount}";
                				fnObj.control.save();
                			}
                			, D: function(){



								var callback = function(pdata){

									var data = pdata.ezCard
									data.netAmt = 0	// 공급가액
									data.noTaxAmt = +"${amount}"	// 면세금액

                					if(data.SUC == "00"){
                						if(Ez.isSuccess(data)){
	                						$("#info-no").val(data.RQ04);
	                						fnObj.data.resData = data;
	                						$("#btn-calculate").css("display", "none");
	                						$("#btn-save").css("display", "inline-block");
	                						fnObj.control.save()
                						}else{
	                    					$("#info-no").val("");
	                    					fnObj.data.resData = null;
	                    					$("#btn-calculate").css("display", "inline-block");
	                    					alert(data.RS16);
                						}
                    				}else{
                    					$("#info-no").val("");
                    					fnObj.data.resData = null;
                    					$("#btn-calculate").css("display", "inline-block");
                    				}
                				}
								Pay.Appr.cash($("[name=p]:checked").val(), +"${amount}", 0, "", callback)
//                 				Ez[this[$("[name=p]:checked").val()]]("${amount}", );
                			}
                			, S: function(){

                				var callback = function(pdata){

                					var data = pdata.ezCard
									data.netAmt = 0	// 공급가액
   									data.noTaxAmt = +"${amount}"	// 면세금액

                					if(data.SUC == "00"){
                						if(Ez.isSuccess(data)){
	                						$("#info-no").val(data.RQ04);
	                						fnObj.data.resData = data;
	                						$("#btn-calculate").css("display", "none");
	                						$("#btn-save").css("display", "inline-block");
	                						fnObj.control.save();
                						}else{
	                    					$("#info-no").val("");
	                    					fnObj.data.resData = null;
	                    					$("#btn-calculate").css("display", "inline-block");
	                    					alert(data.RS16);
                						}
                    				}else{
                    					$("#info-no").val("");
                    					fnObj.data.resData = null;
                    					$("#btn-calculate").css("display", "inline-block");
                    				}
                				}
                				Pay.Appr.cash($("[name=p]:checked").val(), +"${amount}", 0, "0100001234", callback)
//                 				Ez.reqCashJajinNoTax("${amount}", );
                			}
                		}

                		o[$("[name=c]:checked").val()]();

            		}
                },
				control: {
					calculate: function(){
						fnObj.eventFn.reqCash();
					},
					save: function(isPrinted){
						if(fnObj.data.resData == null){
							alert("현금정산이 완료되지 않았습니다.");
							return;
						}

						if(isPrinted){
							fnObj.data.resData.isPrinted = isPrinted
						}

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