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

RuntimeMXBean runtimeMxBean = ManagementFactory.getRuntimeMXBean();
List<String> arg = runtimeMxBean.getInputArguments();

for(String ar : arg){
	if(ar.startsWith("-Dspring.profiles.active=")){
		if(ar.contains("local")){
			request.setAttribute("amount", "1004");
		}
	}
}
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
							<td><div class='tdRel'><b:inputDate id="info-appDate" clazz="W200" value="" required="true" title="승인일시"></b:inputDate>
							</div></td>
						</tr>
					</table>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button id="btn-calculate" type="button" class="AXButton" onclick="fnObj.control.calculate();">적용</button>
		<button id="btn-noCardInfo" class="AXButton" onclick="fnObj.control.saveWithoutCardInfo()">카드정보없이 저장</button>
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
						enterEvent: function(){
							$('body').on('keydown', 'input, select, textarea', function(e) {
		            		    var self = $(this)
		            		      , form = self.parents('form:eq(0)')
		            		      , focusable
		            		      , next
		            		      ;
		            		    if (e.keyCode == 13) {
		            		        focusable = form.find('input,a,select,textarea').filter(':visible');
		            		        next = focusable.eq(focusable.index(this)+1);
		            		        if (next.length) {
		            		            next.focus();
		            		        } else {
		             		            fnObj.control.save();
		            		        }
		            		        return false;
		            		    }
		            		});
							$("#info-halbu").focus();
						}
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
					saveWithoutCardInfo: function(){
						$("#info-cardNo").val("0000000000000000")
						$("#info-cardName").val("수동자료")
						$("#info-appNo").val("000000000")
						$("#info-appDate").val(new Date().print())
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

						var saleStmtBd = $.map(parent.window.fnObj.gridSaleStmtBd.target.list, function(item){
							item.customerNo = info.appDate.replace("-", "").replace("-", "");
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
		                	$.each(parent.fnObj.gridSaleStmtBd.target.list, function(i, o){
		                		if(o.item.taxFreeSale == 0){
		                			vat += o.tamount/11;
		                		}
		                	});
		                	vat = Math.floor(vat);
	                	}
						var saleStmt = {
								saleStmtBd: saleStmtBd
								, customerNo: info.appDate.replace("-", "").replace("-", "")
								, partCode : "${param.partCode}"
								, etDate: info.appDate
								, amount: amount
								, jungsanKind: "D1"
								, cardNo: info.cardNo
								, cardName: info.cardName
								, cashKind: ""
								, appNo: info.appNo
								, natAmt: vat*10
								, vatAmt: vat
								, noTaxAmt: amount-vat*11
								, saleAmt: amount
								, saleStmtBdCard: {
									customerNo: info.appDate.replace("-", "").replace("-", "")
					   				, partCode: "${param.partCode}"
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