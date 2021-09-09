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
								<label><input name="c" type="radio" value="N"> 발행안함</label>
								<label><input name="c" type="radio" value="G"> 일반영수</label>
								<label><input name="c" type="radio" value="D"> 소득공제</label>
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
		<button id="btn-save" type="button" class="AXButton" onclick="fnObj.control.save();" style="display:none;">승인결과저장</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript" src="/static/js/common/toss_payments.js?V=4"></script>
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
					$("form").bind("submit", function(){return false;});
					$("#info-no").focus();
					$("body").bind("keyup", function(e){
						switch (e.keyCode) {
						// 정산
						case 13:
							$("#btn-calculate").click();
							break;

						default:
							break;
						}
					});
					if('${param.partCode}' == "41-001"){
						$("input[name='c'][value='D']").prop("checked", true);
					}
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
                			// 발행안함
                			N: function(){
            					fnObj.control.save();
                			}
                			// 일반영수
                			, G: function(){
            					fnObj.control.save();
                			}
                			// 소득공제
                			, D: function(){debugger

                				var callback = function(pData){

                					var data = pData.ezCard

                					if(data.SUC == "00"){
                						if(Ez.isSuccess(data)){
	                						$("#info-no").val(data.RQ04);
	                						fnObj.data.resData = data;
	                						$("#btn-calculate").css("display", "none");
	    									$("#btn-save").css("display", "inline-block");
		                					fnObj.control.save();
                						}else{
	                    					$("#info-no").val("010-000-1234");
	    									$("#btn-calculate").css("display", "inline-block");
	                    					fnObj.data.resData = null;
	                    					alert(data.RS16);
                						}
                    				}else{
                    					$("#info-no").val("010-000-1234");
                    					$("#btn-calculate").css("display", "inline-block");
                    					fnObj.data.resData = null;
                    					alert(data.RS17);
                    				}
                				};

                				var vat = fnObj.getVat();
                				Pay.Appr.cash($("[name=p]:checked").val(), "${amount}", vat, "", callback)

                			}
                			// 자진발급
                			, S: function(){

                				var callback = function(pData){

                					var data = pData.ezCard

                					if(data.SUC == "00"){
                						if(Ez.isSuccess(data)){
	                						$("#info-no").val(data.RQ04);
	                						fnObj.data.resData = data;
	                						$("#btn-calculate").css("display", "none");
	    									$("#btn-save").css("display", "inline-block");
		                					fnObj.control.save();
                						}else{
	                    					$("#info-no").val("010-000-1234");
	                    					$("#btn-calculate").css("display", "inline-block");
	                    					fnObj.data.resData = null;
	                    					alert(data.RS16);
                						}
                    				}else{
                    					$("#info-no").val("010-000-1234");
                    					$("#btn-calculate").css("display", "inline-block");
                    					fnObj.data.resData = null;
                    					alert(data.RS17);
                    				}
                				};

                				var vat = fnObj.getVat();
                				Pay.Appr.cash($("[name=p]:checked").val(), "${amount}", vat, "0100001234", callback)

                			}
                		}

                		o[$("[name=c]:checked").val()]();

            		}
                },
                getVat: function(){
//                 	var vat = 0;
//                 	$.each(parent.window.fnObj.gridSaleStmtBd.target.list, function(i, o){
//                 		if(o.item.taxFreeSale == 0){
//                 			vat += o.tamount/11;
//                 		}
//                 	});
//                 	return Math.floor(vat);
                	var vat = 0;
                	$.each(parent.window.fnObj.gridSaleStmtBd.target.list, function(i, o){
                		if(o.item.taxFreeSale == 0){
                			vat += Math.round((o.tamount/11) / 10) * 10;
                		}
                	});
                	return vat;
                },
				control: {
					calculate: function(){
						fnObj.eventFn.reqCash();
					},
					save: function(){
// 						if($("[name=c]:checked").val() == "D" && fnObj.data.resData == null){
// 							alert("현금정산이 완료되지 않았습니다.");
// 							return;
// 						}
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