<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%

%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="${title }"/>
	<ax:set name="page_desc" value=""/>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">
							<div class="ax-button-group">
								<div class="left">
									<h1>
										<i class="axi axi-web"></i> 빈소이용정보
									</h1>
								</div>
								<div class="right"></div>
								<div class="ax-clear"></div>
							</div>

							<div id="div-dead-info"></div>
							<div id="div-grid-items"></div>
						</ax:custom>
						<ax:custom customid="td" style="width:50%">
							<div class="ax-button-group">
								<div class="left"></div>
								<div class="right">
									<b:button text="빈소이용일괄삭제" id="btn-del-binso-all"></b:button>
									<b:button text="초기화" id="btn-init-binso"></b:button>
								</div>
								<div class="ax-clear"></div>
							</div>
							<ax:form name="form-info" id="form-info">
								<input id="info-customerNo" type="hidden"
									value="${param.customerNo }">
								<table class='AXFormTable'>
									<colgroup>
										<col width="100" />
										<col />
										<col width="50" />
									</colgroup>
									<tr>
										<td colspan="2" align="right">
											<label><input id="info-typeCode-new" type="radio" name="typeCode" value="0"> 신규빈소</label>
											<label><input id="info-typeCode-add" type="radio" name="typeCode" value="1" disabled="disabled"> 추가빈소</label>
											<label style='display:none'><input id="info-typeCode-move" type="radio" name="typeCode" value="2" disabled="disabled"> 이동빈소</label>
										 </td>
										<td rowspan="5" valign="top"><div class='tdRel'>
												<b:button text="적용" id="btn-binso-save"></b:button>
												<b:button text="삭제" id="btn-binso-delete"></b:button>
												<b:button text="신규" id="btn-binso-new"></b:button>
											</div></td>
									</tr>
									<tr>
										<th><div class='tdRel'>빈소</div></th>
										<td><div class='tdRel'>
												<select id="info-binsoCode" name="binsoCode"
													class="AXSelect W100"></select>
											</div></td>
									</tr>
									<tr>
										<th><div class='tdRel'>입실일시</div></th>
										<td><div class='tdRel'>
<%-- 												<b:inputDateTime id="info-stDateTime" name="stDateTime" clazz="W120 av-required" title="입실일시"></b:inputDateTime> --%>
												<b:input id="info-stDate" name="stDate" clazz="W100 av-required" pattern="date" title="입실일시"></b:input>
                        						<b:input id="info-stTime" name="stTime" clazz="W50 av-required" pattern="time" title="입실일시"></b:input>
											</div></td>
									</tr>
									<tr>
										<th><div class='tdRel'>퇴실일시</div></th>
										<td><div class='tdRel'>
<%-- 												<b:inputDateTime id="info-edDateTime" name="edDateTime" clazz="W120 av-required" title="퇴실일시"></b:inputDateTime> --%>
												<b:input id="info-edDate" name="edDate" clazz="W100 av-required" pattern="date" title="퇴실일시"></b:input>
                        						<b:input id="info-edTime" name="edTime" clazz="W50 av-required" pattern="time" title="퇴실일시"></b:input>
											</div></td>
									</tr>
									<tr>
										<th><div class='tdRel'>비고</div></th>
										<td><div class='tdRel'>
												<b:input id="info-remark" name="remark" clazz="W200"></b:input>
											</div></td>
									</tr>
								</table>
								<div id="div-grid-binsoAssigns"></div>
							</ax:form>
						</ax:custom>
					</ax:custom>
				</ax:custom>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>
    <ax:div name="scripts">
        <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">
            var fnObj = {
            	CODES: {
            		binsoAssign: JSON.parse('<b:optionJson basicCd="123"></b:optionJson>')
            	},
            	CONSTANTS: {
            		TYPE_NEW: "0"
            		, TYPE_ADD: "1"
           			, TYPE_MOVE: "2"
            	},
            	data: {
            		funeral : null
            	},
            	condition: {
            		isAssignedBinso : function(binso){
            			var binsoDay = binso ? binso.binsoDay : fnObj.data.funeral.binso.binsoDay;
            			return binsoDay && binsoDay != "";
            		}
            	},
                pageStart: function () {
                    this.bindEvent();
                    this.gridItem.bind();
                    this.gridBinsoAssign.bind();
                    this.form.bind();
                    this.defaultFunc.excute();
                },
                bindEvent: function () {
                	$("#info-binsoCode").bindSelect({
	                    ajaxUrl: "/FUNE1030/binso/assignable/code/option/ajax",
	                    ajaxPars: "",
	                    isspace: false,
	                    isspaceTitle: "전체",
	                    setValue: "${param.binsoCode}"
	                });
                	$("input[name=typeCode]").bind("change", fnObj.eventFunc.isDisabled);
                	$("#btn-binso-new").bind("click", fnObj.eventFunc.newBinso);
                	$("#btn-binso-save").bind("click", fnObj.eventFunc.saveBinso);
                	$("#btn-binso-delete").bind("click", fnObj.eventFunc.deleteBinso);
                },
                eventFunc: {
                	isDisabled: function(){
                		var typeCode = $('input[name=typeCode]:checked', '#form-info').val();
                		if(fnObj.CONSTANTS.TYPE_NEW == typeCode){
                			fnObj.eventFunc.disabled();
                		}else{
                			fnObj.eventFunc.unDisabled();
                			$("#info-typeCode-new").prop("disabled", true);
                		}
                	},
                	unDisabled: function(){
                		$("[id^='info-']").bindSelectDisabled(false);
                		$("[id^='info-']").prop("disabled", false);
//                 		$("#info-typeCode-new").prop("disabled", false);
//                 		$("#info-typeCode-add").prop("disabled", true);
//                 		$("#info-typeCode-move").prop("disabled", true);
                	},
                	disabled: function(){
                		$("[id^='info-']").bindSelectDisabled(false);
                		$("[id^='info-']").prop("disabled", false);
                		$("#info-typeCode-new").prop("disabled", false);
                		$("#info-typeCode-add").prop("disabled", true);
                		$("#info-typeCode-move").prop("disabled", true);
                	},
                	newBinso: function(){
                		if(fnObj.condition.isAssignedBinso()){
                			alert("빈소가 이미 배정되었습니다.");
                			return;
                		}
                		fnObj.eventFunc.unDisabled();
                		$("#info-typeCode-new").prop("disabled", false);

                		var binsoAssigns = fnObj.gridBinsoAssign.target.list;

                		for(var i=0; i<binsoAssigns.length; i++){

                			if(binsoAssigns[i].binsoCode[0] == '9'){
	                			var stDateTime = binsoAssigns[i].stDateTime
	                			var stDate = stDateTime.date().print();
	                			var stTime = stDateTime.date().print("hh:mi");
	                			var edDateTime = binsoAssigns[i].edDateTime
	                			var edDate = edDateTime.date().print();
	                			var edTime = edDateTime.date().print("hh:mi");

	                			$("#info-stDate").val(stDate);
	                			$("#info-stTime").val(stTime);
	                			$("#info-edDate").val(edDate);
	                			$("#info-edTime").val(edTime);
	                			break;
                			}
                		}
                	},
                	saveBinso: function(){

                		var typeCode = $('input[name=typeCode]:checked', '#form-info').val();

                		if(!typeCode){
                			alert("신규/추가/이동빈소 중 한개를 선택해 주세요.");
                			return;
                		}

                		var validateResult = fnObj.form.validate_target.validate();
                        if (!validateResult) {
                            var msg = fnObj.form.validate_target.getErrorMessage();
                            axf.alert(msg);
                            fnObj.form.validate_target.getErrorElement().focus();
                            return false;
                        }

                		var data = fnObj.form.getJSON();
	                	var url = "/FUNE1011/binsoAssign";

	                	if(data.typeCode == fnObj.CONSTANTS.TYPE_MOVE){
	                		var binsoAssign = fnObj.gridBinsoAssign.target.getSelectedItem();
	                		if(binsoAssign.error){
	                			alert("빈소를 선택해 주세요.");
	                			return;
	                		}
		                	var params = [];
	                		params.push("customerNo="+binsoAssign.item.customerNo);
	                		params.push("no="+binsoAssign.item.no);
	                		url += "?"+params.join("&");
	                	}

                		app.ajax({
                            type: "PUT",
                            url: url,
                            data: Object.toJSON(data)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		toast.push("저장하였습니다.");
                        		parent.window.fnObj.drawBinsoList();
//                         		app.ajax({
//                                     type: "GET",
//                                     url: "/FUNE1011/binsoAssign/${param.customerNo}",
//                                     data: ""
//                                 },
//                                 function(res){
//                                 	var gridBinsoAssignData = {
//                                             list: res.list
//                                         };

//                             		fnObj.gridBinsoAssign.target.setData(gridBinsoAssignData);
//                                 });
                        		fnObj.defaultFunc.excute();
                        		$("#info-binsoCode").bindSelect({
            	                    ajaxUrl: "/FUNE1030/binso/assignable/code/option/ajax",
            	                    ajaxPars: "",
            	                    isspace: false,
            	                    isspaceTitle: "전체"
//             	                    setValue: "${param.binsoCode}"
            	                });

                        	}
                        });
                	}
                	, deleteBinso: function(){
                		var item = fnObj.gridBinsoAssign.target.getSelectedItem();
                		if(item.error){
                			return;
                		}

                		app.ajax({
		                     type: "DELETE",
		                     url: "/FUNE1011/binsoAssign/"+item.item.customerNo+"/"+item.item.no,
		                     data: ""
		                 },
		                 function(res){
		                	 if(res.error){

		                	 }else{
		                		 fnObj.defaultFunc.excute();
		                		 toast.push("삭제 되었습니다.");
		                		 parent.window.fnObj.drawBinsoList();
		                		 fnObj.eventFunc.isDisabled();
		                	 }
		                 });
                	}
                },
                defaultFunc: {
                	searchFuneral: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE1011/funeral?customerNo=${param.customerNo}",
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		fnObj.data.funeral = res.map.funeral;

                        		fnObj.draw.drawDeadInfo(res.map.funeral);

                        		var items = [];
                        		$.each(res.map.funeral.saleStmt, function(i, o){
                        			if(o.saleStmtBd){
                        				items=items.concat(o.saleStmtBd);
                        			}
                        		});

                        		var gridItemData = {
                                        list: items
                                    };

                        		fnObj.gridItem.target.setData(gridItemData);
                        		fnObj.gridItem.target.setDataSet({});

                        		var gridBinsoAssignData = {
                                        list: res.map.funeral.binsoAssign
                                    };

                        		fnObj.gridBinsoAssign.target.setData(gridBinsoAssignData);

                        		if(fnObj.condition.isAssignedBinso(res.map.funeral.binso)
                        				|| res.map.funeral.binsoAssign.length>1
                        				|| !res.map.funeral.binsoCode.startsWith("9")){
	                        		$("[id^='info-']").bindSelectDisabled(true);
	                        		$("[id^='info-']").prop("disabled", true);
	                        		$("#info-typeCode-add").prop("disabled", false);
	                        		$("#info-typeCode-move").prop("disabled", false);
                        		}
                            }
                        });
                	}
                	, excute: function(){
                		if("" == "${param.m}" || fnObj.defaultFunc["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFunc["${param.m}"]();
                	}
                },
                template: {
                	keywords: [
                		"[binsoName]"
                		, "[deadName]"
                		, "[ibsilDate]"
                		, "[applName]"
                		, "[balinDate]"
                		, "[cnt]"
                		, "[amount]"
                	]
                	, deadInfo: "<table class='AXFormTable'>"+
					            		"<tr>"+
					        			"<th rowspan='2'><div class='tdRel binso_title'>[binsoName]</div>"+
					        			"</th>"+
					        			"<th><div class='tdRel'>고인명</div>"+
					        			"</th>"+
					        			"<td><div class='tdRel'>[deadName]</div>"+
					        			"</td>"+
					        			"<th><div class='tdRel'>입실일시</div>"+
					        			"</th>"+
					        			"<td><div class='tdRel'>[ibsilDate]</div>"+
					        			"</td>"+
					        			"<th colspan='2'><div class='tdRel'>판매합계</div>"+
					        			"</th>"+
					        		"</tr>"+
					        		"<tr>"+
					        			"<th><div class='tdRel'>상주명</div>"+
					        			"</th>"+
					        			"<td><div class='tdRel'>[applName]</div>"+
					        			"</td>"+
					        			"<th><div class='tdRel'>발인일시</div>"+
					        			"</th>"+
					        			"<td><div class='tdRel'>[balinDate]</div>"+
					        			"</td>"+
					        			"<td><div class='tdRel'>[cnt]</div>"+
					        			"</td>"+
					        			"<td><div class='tdRel'>[amount]</div>"+
					        			"</td>"+
					        		"</tr>"+
					        	"</table>"
	        		, deleteKeywords: function(str){
	        			return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
                },
                draw: {
                	drawDeadInfo: function(funeral){
                		var thedead = funeral.thedead;
                		var applicant = funeral.applicant;
                		var binso = funeral.binsoAssign[0].binso;
                		var html = fnObj.template.deadInfo;

                		var cnt = 0;
                		var tamount = 0;
                		$.each(funeral.saleStmt, function(i,o){
                			if(o.saleStmtBd){
                				cnt += o.saleStmtBd.length;
                				$.each(o.saleStmtBd, function(i,o2){
                					tamount += o2.tamount;
                				});
                			}
                		});

						html = html.replace("[binsoName]", binso.binsoName);
						html = html.replace("[deadName]", thedead.deadName);
						html = html.replace("[ibsilDate]", funeral.ibsilDate || "");
						html = html.replace("[applName]", applicant.applName);
						html = html.replace("[balinDate]", funeral.balinDate);

						html = html.replace("[cnt]", cnt);
						html = html.replace("[amount]", tamount);

						html = fnObj.template.deleteKeywords(html);

						$("#div-dead-info").html(html);
                	}
                },
                gridItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-items",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"itemName", label:"품목명", width:"180", align:"left", formatter: function(){
                                	if(this.item.item){
	                               		return this.item.item.itemName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"qty", label:"수량", width:"70", align:"right", formatter: "number"},
                                {key:"tamount", label:"판매금액", width:"100", align:"right", formatter: "money"},
                                {key:"remark", label:"메모", width:"100", align:"left"},
                            ],
                            body : {
                            	ondblclick: function(){
                                },
                                marker: [
        							{
        								display: function () {
        									return this.item.subTotal1 ? true : false;
        									},
        								rows: [
        									[{
        										colSeq  : null, colspan: 2, formatter: function () {
        											return this.item.subTotal1.itemCode;
        										}, align: "center"
        									}, {
        										colSeq: 2, formatter: function () {
        											return this.item.subTotal1.tamount.money();
        										}
        									}, {
        										colSeq: 3, formatter: function () {
        											return "";
        										}
        									}]
        								]
        							},
        							{
        								display: function () { return this.item.subTotal2 ? true : false; },
        								rows: [
        									[{
        										colSeq  : null, colspan: 2, formatter: function () {
        											return this.item.subTotal2.itemCode;
        										}, align: "center"
        									}, {
        										colSeq: 2, formatter: function () {
        											if(this.item.subTotal2.dcAmt){
	        											return this.item.subTotal2.dcAmt.money();
        											}else{
        												return "0";
        											}
        										}
        									}, {
        										colSeq: 3, formatter: function () {
        											return "";
        										}
        									}]
        								]
        							}
       							]
                            },
                            foot: {
                                rows: [
                                    [
                                        {
                                            colSeq: null, colspan: 2, formatter: function () {
                                            	return "계";
                                        	}, align: "center", valign: "middle"
                                        },
                                        {
                                            colSeq: 2, formatter: function () {
	                                            var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.tamount-this.dcAmt;
	                                            });
	                                            return sum.money();
	                                        }
                                        },
                                        {colSeq: 3}
                                    ]
                                ]
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
                    setPage: function(pageNo, searchParams){
                    }
                },
                gridBinsoAssign: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-binsoAssigns",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"binsoName", label:"빈소명", width:"80", align:"center", formatter: function(){
                                	if(this.item.binso){
	                               		return this.item.binso.binsoName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"typeCode", label:"종류", width:"80", align:"center"
                                	, formatter: function (val) {
                                        return Common.grid.codeFormatter("binsoAssign", this.value);
                                    },
                                },
                                {key:"stDateTime", label:"입실일시", width:"130", align:"center"},
                                {key:"edDateTime", label:"퇴실빈소", width:"130", align:"center"},
                                {key:"hour", label:"시간", width:"100", align:"center", formatter: function(){
                                	if(this.item.binsoUseTime){
                                		var hour = 0;
                                		$.each(this.item.binsoUseTime, function(i, o){
                                			hour+=o.hour;
                                		});
                                		return hour;
                                	}
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
                    setPage: function(pageNo, searchParams){
                    }
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
                            targetFormName : "form-info"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;
						this.clear();
                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                    	var data = app.form.serializeObjectWithIds(this.target, 'info-');
                    	data.typeCode = $('input[name=typeCode]:checked', '#form-info').val();

                    	if(data.edDate != ""){
                    		data.edDate = data.edDate+" "+data.edTime;
                    		data.edDateTime = data.edDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(data.stDate != ""){
                    		data.stDate = data.stDate+" "+data.stTime;
                    		data.stDateTime = data.stDate.date().print("yyyy-mm-dd hh:mi");
                    	}

                        return data;
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    }
                },
                // form
                control: {
					cancel: function(){
						app.modal.cancel();
					}
				}
            };
            axdom(document.body).ready(function () {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
        </script>
    </ax:div>
</ax:layout>