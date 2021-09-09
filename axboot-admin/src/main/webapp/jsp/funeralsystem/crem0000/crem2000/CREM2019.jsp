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
							<th><div class='tdRel'>할부*</div>
							</th>
							<td><div class='tdRel'>
								<b:input id="info-halbu" pattern="custom" patternString="99" clazz="W100" value="00" title="할부"></b:input>
								<span style="color: red;">[0:일시불]</span>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>카드번호*</div>
							</th>
							<td><div class='tdRel'><b:input id="info-cardNo" clazz="W200" value="" required="true" title="카드번호"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>카드명*</div>
							</th>
							<td><div class='tdRel'><b:input id="info-cardName" clazz="W200" value="" required="true" title="카드명"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>승인번호*</div>
							</th>
							<td><div class='tdRel'><b:input id="info-appNo" clazz="W200" value="" required="true" title="승인번호"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>승인일시*</div>
							</th>
							<td><div class='tdRel'><b:input id="info-appDate" clazz="W200" value="" required="true" title="승인일시"></b:input>
							</div></td>
						</tr>
						<tr>
							<th><div class='tdRel'>수납할금액*</div>
							</th>
							<td><div class='tdRel'><b:input id="info-receiptAmt" clazz="W200" value="" required="true" title="수납할금액"></b:input>
							</div></td>
						</tr>
					</table>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button id="btn-calculate" type="button" class="AXButton" onclick="fnObj.control.calculate();">적용</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.form.bind();
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
                },
                /*******************************************************
                 * 상세 폼
                 */
                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetID : "form-info"
                            , targetFormName : "form-info"
                        });

                    },
                    setJSON: function(item) {
                    	var _this = this;
						this.clear(false);
                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function(isDefault) {
                        app.form.clearForm(this.target);
                    }
                },
                // form
				control: {
					calculate: function(){
						this.save();
					},
					save: function(){

						// 동작 안함.
// 						var validateResult = fnObj.form.validate_target.validate();
// 	                    if (!validateResult) {
// 	                        var msg = fnObj.form.validate_target.getErrorMessage();
// 	                        axf.alert(msg);
// 	                        fnObj.form.validate_target.getErrorElement().focus();
// 	                        return false;
// 	                    }

						var info = fnObj.form.getJSON();

						for(var key in info){
							if(info[key] == ""){
								var title = $("#info-"+key).attr("title");
								alert(title+"은 필수입력 사항 입니다.");
								$("#info-"+key).focus();
								return;
							}
						}
						var amount = +$("#info-receiptAmt").val();
						var payment = {
	            				partCode: "70-001"
	            				, tid: "MANUAL"
	            				, totAmt: amount
	            				, cardAmt: amount
	            				, cashAmt: 0
	            				, kind: "D1"
	            				, cardNo: info.cardNo
	            				, cardName: info.cardName
	            				, appNo: info.appNo
	            				, netAmt: 0
	            				, vatAmt: 0
	            				, noTaxAmt: amount
	            				, checkCardFlg: "0"
	            				, paymentCard: {
		                				partCode: "70-001"
	                					, tid: "MANUAL"
		                				, cardInfo: info.cardNo
		                				, appDate: info.appDate
		                				, halbu: info.halbu
		                				, aquirer: ""
		                				, cardCode: ""
		                				, cardName: ""
		                				, buyNo: ""
		                				, notice: "수동입력"
		        				}
	            		};

						app.modal.save(window.callBackName, payment);

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