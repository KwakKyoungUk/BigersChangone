<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>

<%
String imgPrefix = AppContextManager.getAppContext().getEnvironment().getProperty("funeralsystem.fileupload.item.path");
request.setAttribute("IMG_PREFIX", imgPrefix);
%>

<ax:layout name="base.jsp">
	<ax:set name="title" value="${PAGE_NAME}" />
	<ax:set name="page_desc" value="${PAGE_REMARK}" />
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
				<ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}"
					function2Auth="${FUNCTION_2_AUTH}"
					function3Auth="${FUNCTION_3_AUTH}"
					function4Auth="${FUNCTION_4_AUTH}"
					function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">
							<%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
							<div class="ax-button-group">
								<!--  <div class="left">
                                </div> -->
								<div class="right">
									<!-- <button type="button" class="AXButton" id="ax-form-btn-search"><i class="axi axi-search2"></i> 조회</button> -->
								</div>
								<div class="ax-clear"></div>
							</div>
							<div class="ax-search" id="page-search-box"></div>
							<div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
						</ax:custom>

						<ax:custom customid="td">
							<%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
							<div class="ax-button-group">
								<!--  <div class="left">
                                </div> -->
								<div class="right">
									<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
									<!-- <button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-plus-circle"></i> 저장</button>
									<button type="button" class="AXButton" id="ax-form-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button> -->
								</div>
								<div class="ax-clear"></div>
							</div>

							<%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>

							<!-- <div class="ax-search" id="right-search-box"></div> -->

							<form id="form-info" name="form-info" onsubmit="return false">

								<table cellpadding="0" cellspacing="0" class="AXGridTable">
				                    <colgroup>
				                        <col width="100px" />
				                        <col width="50%" />
				                        <col width="100px" />
				                        <col width="50%" />
				                    </colgroup>
				                    <thead>
<!-- 				                    <tr> -->
<!-- 				                        <td><div class="tdRel">tag</div></td> -->
<!-- 				                        <td><div class="tdRel">attributes</div></td> -->
<!-- 				                    </tr> -->
				                    </thead>
				                    <tbody>
				                    <tr>
				                        <td class="gray" align="center">품목코드</td>
				                        <td><input type="text" id="info-itemCode" name="itemCode" title="품목코드" class="AXInput W100 av-required" value="" />
			                        	</td>
			                        	<td colspan="2" rowspan="7">
			                        		<input id="info-imgPath" type="hidden">
			                        		<button id="btn-upload-img" class="AXButton">사진 업로드</button><br>
			                        		<img height="150" onerror="this.src = ''">
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">품목명</td>
				                        <td><input type="text" id="info-itemName" name="itemName" title="품목명" class="AXInput W200 av-required" value="" />
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">바코드번호</td>
				                        <td><input type="text" id="info-barCode" name="barCode" title="바코드" class="AXInput W200" value="" />
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">단위</td>
				                        <td><input type="text" id="info-unit" name="unit" title="단위" class="AXInput W100 av-required" value="" />
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center"><div class="tdRel">거래업체</div></td>
				                        <td>
				                        	<select name="custCode" id="info-custCode" class="AXSelect"></select>
											<input type="checkbox" id="info-taxFreeSale" name="taxFreeSale" value="1"/>
											<label for="info-taxFreeSale">면세판매</label>
											<input type="checkbox" id="info-taxFreeBuy" name="taxFreeBuy"   value="1"/>
											<label for="info-taxFreeBuy">면세매입</label>
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">품목분류</td>
				                        <td>
				                        	<select name="groupCode" id="info-groupCode" class="AXSelect"></select>
											<input type="checkbox" id="info-prodBatchFlg" name="prodBatchFlg" value="1"/>
											<label for="info-prodBatchFlg">일괄소모등록대상품목(생산관리)</label>
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">품목구분</td>
				                        <td>
				                        	<select name="itemKindCode" id="info-itemKindCode" class="AXSelect"></select>
											<input type="checkbox" id="info-stockFlg" name="stockFlg" value="1"/>
											<label for="info-stockFlg">판매시제고체크여부</label>
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">재고대표코드</td>
				                        <td>
				                        	<input type="text" class="AXInput W100 " id="info-itemGroupCode" name="itemGroupCode" />
			                        	</td>
				                        <td class="gray" align="center">재고환산수량</td>
				                        <td>
				                        	<input type="text" class="AXInput W100 " id="info-itemCvtQty" name="itemCvtQty" />
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">생산단위</td>
				                        <td>
				                        	<input type="text" class="AXInput W100 " id="info-prodUnit" name="prodUnit" />
			                        	</td>
				                        <td class="gray" align="center">생산환산수량</td>
				                        <td>
				                        	<input type="text" class="AXInput W100" id="info-prodCvtQty" name="prodCvtQty" />
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">순서</td>
				                        <td>
				                        	<input type="text" id="info-sortNo" name="sortNo" title="순서" maxlength="25" class="AXInput W100" value="" />
			                        	</td>
			                        	<td class="gray" align="center">사용여부</td>
				                        <td>
				                        	<select id="info-useFlg" class="AXSelect W100" name="useFlg" title="사용여부"></select>
			                        	</td>
		                        	</tr>
				                    <tr>
				                        <td class="gray" align="center">메모</td>
				                        <td>
				                        	<input type="text" id="info-remark" name="remark" title="메모" maxlength="50" class="AXInput" value="" style="width: 300px;" />
			                        	</td>
				                        <td class="gray" align="center">빈소주문물품</td>
				                        <td>
				                        	<select id="info-bspkFlg" class="AXSelect W100" name="bspkFlg" title="빈소주문물품"></select>
			                        	</td>
		                        	</tr>
                        			</tbody>
                       			</table>

								<input type="hidden" id="info-partCode" name="partCode" value="" />
							</form>


							<div class="AXTabs">
								<div class="AXTabsTray">
									<a data-href="#sale-price-tab" class="AXTab on" data-kind="0">판매단가변경</a>
									<a data-href="#buy-price-tab" class="AXTab" data-kind="1">매입단가변경</a>
									<div class="ax-clear"></div>
								</div>
							</div>
							<div class="H40"></div>
							<div id="tab-holder" style="">

								<div id="sale-price-tab">

									<ax:custom customid="table">
										<ax:custom customid="tr">
											<ax:custom customid="td">
												<div class="ax-button-group">
													<div class="left">
														<button type="button" class="AXButton" id="sale-price-last-remove"><i class="axi axi-minus-circle"></i> 판매최종단가 삭제</button>
													</div>
													<div class="ax-clear"></div>
												</div>

												<div id="salePrice-grid-box-holder">
													<div class="ax-grid " id="salePrice-grid-box" style="height: 220px;">test</div>
												</div>


											</ax:custom>
											<ax:custom customid="td">

												<ax:form id="sale-price-form-info"
													name="sale-price-form-info" style="padding:1px;">

													<div class="ax-button-group">
														<div class="right">
															<button type="button" class="AXButton" id="sale-price-add"> <i class="axi axi-plus-circle"></i> 추가 </button>
														</div>
														<div class="ax-clear"></div>
													</div>

													<ax:fields>
														<ax:field label="적용일자">
															<input type="text" id="info-stDate-sale" name="stDate" title="적용일자" maxlength="10" class="AXInput W100 av-required" value="" />
														</ax:field>
													</ax:fields>
													<ax:fields>
														<ax:field label="기준수량">
															<input type="text" id="info-defaultQty-sale" name="defaultQty" title="기준수량" class="AXInput W100 av-required" value="" />
														</ax:field>
													</ax:fields>
													<ax:fields>
														<ax:field label="기준단가">
															<input type="text" id="info-price-sale" name="price" title="기준단가" class="AXInput W100 av-required" value="" />
														</ax:field>
													</ax:fields>
													<ax:fields>
														<ax:field label="판매수량">
															<input type="text" id="info-qty-sale" name="qty" title="판매수량" class="AXInput W100 av-required" value="" />
														</ax:field>
													</ax:fields>

												</ax:form>


											</ax:custom>
										</ax:custom>
									</ax:custom>
								</div>

							</div>

						</ax:custom>
					</ax:custom>
				</ax:custom>

			</ax:col>
		</ax:row>


		<div id="hidden-tab" style="width:0px; height:0px; overflow:hidden;">

			<div id="buy-price-tab">
				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">

							<div class="ax-button-group">
								<div class="left">
									<button type="button" class="AXButton" id="buy-price-last-remove"> <i class="axi axi-minus-circle"></i> 구매최종단가 삭제 </button>
								</div>
								<div class="ax-clear"></div>
							</div>

							<div id="buyPrice-grid-box-holder">
								<div class="ax-grid" id="buyPrice-grid-box" style="height: 300px;"></div>
							</div>
						</ax:custom>
						<ax:custom customid="td">
							<ax:form id="buy-price-form-info" name="buy-price-form-info" style="padding:1px;">
								<div class="ax-button-group">
									<div class="right">
										<button type="button" class="AXButton" id="buy-price-add"><i class="axi axi-plus-circle"></i> 추가</button>
									</div>
									<div class="ax-clear"></div>
								</div>
								<ax:fields>
									<ax:field label="적용일자">
										<input type="text" id="info-stDate-buy" name="stDate"title="적용일자" class="AXInput W100 av-required" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="기준수량">
										<input type="text" id="info-defaultQty-buy" name="defaultQty" title="기준수량" class="AXInput W100 av-required" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="기준단가">
										<input type="text" id="info-price-buy" name="price" title="기준단가" class="AXInput W100 av-required" value="" />
									</ax:field>
								</ax:fields>
							</ax:form>
						</ax:custom>
					</ax:custom>
				</ax:custom>
			</div>

		</div>

	</ax:div>




	<ax:div name="scripts">
		<script type="text/javascript">
			var resize_elements = [
				{
					id: "page-grid-box",
					adjust: -97
				}
			];
			var fnObj = {
				CODES: {
					"etc3": [
						{CD: '1', NM: "코드"},
						{CD: '2', NM: "CODE"},
						{CD: '4', NM: "VA"}
					],
					"_etc3": { "1": "코드", "2": "CODE", "4": "VA"}
				},
				pageStart: function() {
					fnObj.priceTab.init();
					this.search.bind();
					this.grid.bind();
					this.form.bind();
					this.bindEvent();
					// 페이지 로딩 후 바로 검색 처리하기 (option)
					this.selectFirstPartCode();
					//this.search.submit();
				},
				bindEvent: function() {
					var _this = this;

				//	$("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");

					$("#ax-page-btn-search").bind("click", function() {
						_this.search.submit();
					});
					/* $("#ax-page-btn-save").bind("click", function() {
						setTimeout(function() {
							_this.save();
						}, 500);
					}); */
					$("#ax-page-btn-excel").bind("click", function() {
						app.modal.excel({
							pars : "target=${className}"
						});
					});

					$("#btn-upload-img").bind("click", function(){
                    	app.modal.open({
	                        url:"/jsp/funeralsystem/common/fileUpload.jsp",
	                        pars:"callBack=fnObj.uploadImgModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

				},

				uploadImgModalResult: function(files){

					if(files.length == 0){
						return;
					}

            		var imgPath = files[0].uploadedPath+"/"+files[0].saveName;

					$("#info-imgPath").val(imgPath);
					$("#info-imgPath").parent().find("img").attr("src", imgPath);

					app.modal.close();
				},

				selectFirstPartCode: function() {
					setTimeout(function() {

						var partCode = $("#"+ fnObj.search.target.getItemId("partCode")).val();
						fnObj.search.setItemGroupSelectOptions(partCode);
					}, 1000);
				},

				save: function() {
					var validateResult = fnObj.form.validate_target.validate();
					if (!validateResult) {
						var msg = fnObj.form.validate_target.getErrorMessage();
						axf.alert(msg);
						fnObj.form.validate_target.getErrorElement().focus();
						return false;
					}

					var info = fnObj.form.getJSON();
					app.ajax({
						type: "PUT",
						url: "/api/v1/samples/parent",
						data: Object.toJSON([ info ])
					}, function(res) {
						if (res.error) {
							console.log(res.error.message);
							alert(res.error.message);
						} else {
							toast.push("저장되었습니다.");
							fnObj.search.submit();

							setTimeout(function(){
								fnObj.clearWholeFields();
							}, 100);
						}
					});
				},

				clearWholeFields: function(){

					fnObj.grid.target.selectClear();
					fnObj.form.clear();
					fnObj.salePriceGrid.clear();
					fnObj.buyPriceGrid.clear();
					fnObj.salePriceForm.clear();
					fnObj.buyPriceForm.clear();

					var groupCode = $("#"+fnObj.search.target.getItemId("groupCode")).val();
					if(groupCode && groupCode != ''){
						$("#info-groupCode").val(groupCode);
					}
				},

				search: {
					target: new AXSearch(),
					// search.target.getParam()에 파트코드가 안들어와서 이것을 따로 받음.
					bind: function() {
						var _this = this;
						this.target.setConfig({
							targetID: "page-search-box",
							theme: "AXSearch",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							onsubmit: function() {
								// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
								fnObj.search.submit();
							},
							rows: [
								{display: true, addClass: "", style: "", list: [
									{label: "파트", labelWidth: "", type: "selectBox", width: "150", key: "partCode", addClass: "",valueBoxStyle: "", value: "close", options: [],

										AXBind: {
											type: "select",
											config: {

											reserveKeys: {
												options: "list",
												optionValue: "partCode",
												optionText: "partName"
											},

											ajaxUrl: "/FUNE0040/part",
											ajaxPars: null,
											setValue: "",
											alwaysOnChange: true,
											onChange: function() {
												_this.setItemGroupSelectOptions(this.optionValue);
												$("#info-groupCode").bindSelect({
													reserveKeys: {
														options: "list",
														optionValue: "groupCode",
														optionText: "groupName"
													},
													ajaxUrl: "/FUNE0040/itemGroup-select-options?partCode="+this.optionValue,
													//ajaxPars: "",
													onchange: function(){
														// trace(this);
													}
												});
												$("#info-custCode").bindSelect({
													reserveKeys: {
														options: "list",
														optionValue: "custCode",
														optionText: "custName"
													},

													ajaxUrl: "/FUNE0040/customer-select-options?partCode="+this.optionValue,
													isspace: true, isspaceTitle: "선택하세요",
													//ajaxPars: "",
													onchange: function(){
														//trace("change : " + Object.toJSON(this));
													}
												});
											}
										}
									}

									},
									{label: "품목분류", labelWidth: "", type: "inputText", width: "150", key: "groupCode", addClass: "", valueBoxStyle: "", value: "", type: "selectBox", options: [],
										AXBind: {
											type: "select",
											config: {
												onchange: function() {
													//toast.push(Object.toJSON(this));
													_this.submit();
												}
											}
										}
									}
									]
								},

								{display: true, addClass: "", style: "", list: [
									{label: "품목코드", labelWidth: "", type: "inputText", width: "140", key: "itemCode", addClass: "", valueBoxStyle: "", value: "",
										onChange: function(changedValue) {
											//아래 2개의 값을 사용 하실 수 있습니다.
											//toast.push(Object.toJSON(this));
											//dialog.push(changedValue);
											_this.submit();
										}
									},
									{label: "품목명", labelWidth: "", type: "inputText", width: "150", key: "itemName", addClass: "", valueBoxStyle: "", value: "",
										onChange : function(changedValue) {
											//아래 2개의 값을 사용 하실 수 있습니다.
											//toast.push(Object.toJSON(this));
											//dialog.push(changedValue);
											_this.submit();
										}
									}]
								}
							]
						});
					},

					setItemGroupSelectOptions: function(partCode) {
						/* 첫 번째 셀렉트박스 옵션 선택에 따른 두 번째 셀렉트박스 옵션 동적 변화 */

						// 선택된 아이템의 키를 통해 AJAX 요청을 한다.
						app.ajax({
							url: "/FUNE0040/itemGroup",
							type: "get",
							data: "partCode=" + partCode
						},
						function(res) {

							// AJAX 요청으로 반환받은 리스트를 준비한다.
							var list = res.list;
							//var optionList = [];


							// 리스트 요소마다 optionValue와 optionText를 설정해준다.
							for (var i=0; i<list.length; i++) {
								list[i].optionValue = list[i].groupCode;
								list[i].optionText = list[i].groupName;
								/* optionList.push({
									optionValue:list[i].groupCode,
									optionText:list[i].groupName
								}); */
							}
							list =[{optionText : "전체",optionValue :""}].concat(list);
							//trace(optionList);

							$("#"+fnObj.search.target.getItemId("groupCode")).bindSelect({
								options: list
							});

							// 폼을 전송한다.
							setTimeout(function(){
								fnObj.search.submit();
							}, 200);

						});

					},

					submit: function() {

						var pars = this.target.getParam();

						/* if(pars.indexOf("partCode") == -1){
							var partCode = $("#"+fnObj.search.target.getItemId("partCode")).val();
							pars += "&partCode=" + partCode;
						} */

						fnObj.grid.setPage(fnObj.grid.pageNo, pars);
					}
				},

				grid: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function() {
						var target = this.target, _this = this;
						target.setConfig({
							targetID: "page-grid-box",
							theme: "AXGrid",
							colHeadAlign: "center",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup: [
						//	    {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
								{key: "itemCode", label: "코드", width: "80", align: "left"},
								{key: "itemName", label: "품목명",width: "150",align: "left"},
								{key: "unit", label: "단위", width: "50", align: "left"},
								{key: "saleSinglePrice", label: "판매단가", width: "80", align: "right", formatter: "money"},
								{key: "buySinglePrice", label: "매입단가", width: "80", align: "right", formatter: "money"},
								{key: "custName", label: "거래처", width: "100", align: "left"},
								{key: "groupName", label: "품목분류", width: "100", align: "left"},
								{key: "basicCodeName", label: "품목구분", width: "100", align: "left"},
								{key: "taxFreeSale", label: "면세</br>판매", width: "40", align: "center",
	                                editor:{
	                                    type:"checkbox",
	                                    beforeUpdate: function(val){
	                                        return (val == true) ? 1 : 0;
	                                    }
	                                }

								},

								{key: "taxFreeBuy", label: "면세</br>매입", width: "40", align: "center",
	                                editor:{
	                                    type:"checkbox",
	                                    beforeUpdate: function(val){
	                                        return (val == true) ? 1 : 0;
	                                    }
	                                }

								},

								{key: "prodBatchFlg", label: "일괄</br>소모", width: "40", align: "center",
	                                editor:{
	                                    type:"checkbox",
	                                    beforeUpdate: function(val){
	                                        return (val == true) ? 1 : 0;
	                                    }
	                                }

								},

								{key: "stockFlg", label: "재고</br>체크", width: "40", align: "center",
	                                editor:{
	                                    type:"checkbox",
	                                    beforeUpdate: function(val){
	                                        return (val == true) ? 1 : 0;
	                                    }
	                                }

								},

								{key: "itemGroupCode", label: "재고대표코드", width: "100", align: "left"},
								{key: "itemCvtQty", label: "재고환산수량", width: "100", align: "right"},
								{key: "prodUnit", label: "생산단위", width: "60", align: "left"},
								{key: "prodCvtQty", label: "생산환산수량", width: "100", align: "right"},
								{key: "sortNo", label: "순서", width: "50", align: "right"},
								{key: "useFlg", label: "사용", width: "50", align: "center"},

								{key: "remark", label: "메모", width: "100", align: "left"}
							],
							body: {
								onclick: function() {
									fnObj.form.setJSON(this.item);
									//fnObj.priceTab.openPriceTabContent();
								}
							}
						});
					},
					add: function() {
						this.target.pushList({});
						this.target.setFocus(this.target.list.length - 1);
					},
				//	del: function() {
				//		var _target = this.target, nextFn = function() {
				//			_target.removeListIndex(checkedList);
				//			toast.push("삭제 되었습니다.");
				//		};

				//		var checkedList = _target.getCheckedListWithIndex(0);// colSeq
				//		if (checkedList.length == 0) {
				//			alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
				//			return;
				//		}
				//		var dto_list = [];
				//		$.each(checkedList, function() {
				//			if (this.item._CUD != "C") {
				//				dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
				//			}
				//		});

				//		if (dto_list.length == 0) {
				//			nextFn(); // 스크립트로 목록 제거
				//		} else {
				//			app.ajax({
				//				type: "DELETE",
				//				url: "/api/v1/samples/parent",
				//				data: dto_list.join("&")
				//			}, function(res) {
				//				if (res.error) {
				//					alert(res.error.message);
				//				} else {
				//					nextFn(); // 스크립트로 목록 제거
				//				}
				//			});
				//		}
				//	},
					setPage: function(pageNo, searchParams) {
						var _target = this.target;
						this.pageNo = pageNo;

						app.ajax({
							type: "GET",
							url: "/FUNE0040/item",
							data: "dummy="+ axf.timekey()+ "&pageNumber=" + (pageNo - 1) + "&pageSize=50&" + (searchParams || fnObj.search.target.getParam())
						}, function(res) {
							if (res.error) {
								alert(res.error.message);
							} else {
								var gridData = {
									list : res.list
								};
								_target.setData(gridData);
							}
						});
					}
				},

				/*******************************************************
				 * 상세 폼
				 */
				form: {
					target: $('#form-info'),
					validate_target: new AXValidator(),
					selectedGridData: null,
					bind: function() {
						var _this = this;

						this.validate_target.setConfig({
							targetFormName : "form-info"
						});

						/* $("#info-custCode").change(function() {
							var value = $("#info-custCode option:selected").attr("data-partCode");
							$("hidden-customerPartCode").val(value);
						}); */

						/* $("#info-groupCode").change(function() {
							var value = $("#info-groupCode option:selected").attr("data-partCode");
							$("hidden-itemGroupPartCode").val(value);
						}); */

						$("#info-sortNo").bindNumber();

						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
							fnObj.clearWholeFields();
						});

						$("#info-itemCvtQty").bindNumber();

						$("#info-prodCvtQty").bindNumber();

						$("#info-itemKindCode").bindSelect({
							reserveKeys: {
								options: "list",
								optionValue: "code",
								optionText: "name"
							},
							ajaxUrl: "/FUNE0040/basic-select-options",
							//ajaxPars: "",
							onchange: function(){
								//trace("change : " + Object.toJSON(this));
							}
						});

	                    $("#info-useFlg").bindSelect({
	                   		options:[
	          					{optionValue:"Y", optionText:"사용"},
	          					{optionValue:"N", optionText:"중지"},

	             			],
	                        onChange: function(){
	                            //toast.push(Object.toJSON(this));

	                        }
	                    });
	                    $("#info-bspkFlg").bindSelect({
	                   		options:[
	          					{optionValue:"Y", optionText:"사용"},
	          					{optionValue:"N", optionText:"중지"},
	             			],
	                        onChange: function(){
	                            //toast.push(Object.toJSON(this));

	                        }
	                    });



						$("#ax-form-btn-save, #ax-page-btn-save").click(function(){
							fnObj.form.save();
						});

			//			$("#ax-form-btn-del, #ax-page-btn-fn1").click(function(){
			//				fnObj.form.del();
			//			});

						$("#ax-form-btn-search, ax-page-btn-search").click(function(){
							fnObj.search.submit();
						});

					},
					setJSON: function(item) {
						var _this = this;

						// 수정시 입력 방지 처리 필드 처리
						$('#info-itemCode').attr("readonly", "readonly");

						var info = $.extend({}, item);
						app.form.fillForm(_this.target, info, 'info-');
						// 추가적인 값 수정이 필요한 경우 처리
						// $('#info-useYn').bindSelectSetValue( info.useYn );

						$("#info-custCode").bindSelectSetValue(item.custCode);
						$("#info-groupCode").bindSelectSetValue(item.groupCode);

						$("#info-taxFreeSale").prop("checked", item.taxFreeSale == 1);
						$("#info-taxFreeBuy").prop("checked", item.taxFreeBuy == 1);
						$("#info-prodBatchFlg").prop("checked", item.taxFreeBuy == 1);
						$("#info-stockFlg").prop("checked", item.stockFlg == 1);

						$("#info-imgPath").parent().find("img").attr("src", "${IMG_PREFIX}/" + item.imgPath);

						//$("#info-basicCd option[value='"+item.basicCd+"'][data-code='"+item.code+"']").prop("selected", true);
						//$("#info-basicCd").change();

						fnObj.form.selectedGridData = item;
						fnObj.priceTab.updatePriceTabGridDisplay();
					},
					getJSON: function() {
						var item = app.form.serializeObjectWithIds(this.target, 'info-');
						$("[id^='info-']").each(function(i,o){
                    		if($(o).attr("type") == "checkbox"){
                    			if(o.checked){
	                    			item[$(o).attr("id").substring('info-'.length)] = 1
                    			}else{
                    				item[$(o).attr("id").substring('info-'.length)] = 0;
                    			}
                    		}
                   		});
						return item;
					},
					clear: function() {
						app.form.clearForm(this.target);
						$('#info-itemCode').removeAttr("readonly");
					},save: function(){

	                    var validateResult = fnObj.form.validate_target.validate();
	                    if (!validateResult) {
	                        var msg = fnObj.form.validate_target.getErrorMessage();
	                        axf.alert(msg);
	                        fnObj.form.validate_target.getErrorElement().focus();
	                        return false;
	                    }

	                    var info = fnObj.form.getJSON();

	                    if(info.partCode == "" || info.partCode == null){
	                    	var partCode = $("#"+fnObj.search.target.getItemId("partCode")).val();
	                    	info.partCode = partCode;
	                    }

	                    app.ajax({
	                        type: "PUT",
	                        url: "/FUNE0040/item",
	                        data: Object.toJSON([info])
	                    }, function(res){
	                        if(res.error){
	                            console.log(res.error.message);
	                            alert(res.error.message);
	                        }
	                        else
	                        {
	                            toast.push("저장되었습니다.");
	                            fnObj.clearWholeFields();
	                            fnObj.search.submit();
	                        }
	                    });
					},

					del: function(){


						var info = fnObj.form.getJSON();
						if(info.itemCode == null || info.itemCode == ""){
							return;
						}

                    	if(!confirm("정말로 삭제하시겠습니까?")){
                    		return;
                    	}

                    	app.ajax({
                    		url:"/FUNE0040/item",
                    		type:"DELETE",
                    		data:Object.toJSON(info)
                    	}, function(res){
                    		//trace("success");
                    		fnObj.clearWholeFields();
                    		fnObj.search.submit();
                    		toast.push("삭제하였습니다.");
                    	});
					}

				}, // form

				priceTab: {
					formSalePrice : null,
					formBuyPrice : null,
					gridSalePrice: null,
					gridBuyPrice: null,
					behavior: null,
					init: function() {

						/*
							두 그리드를 생성하고 바인드 한 다음에 하나는 숨겨진 영역에, 하나는 보이는 영역에 넣는다.
							그리고 탭 이동시 영역에 있던 두 탭의 위치를 바꾼다.
						*/

						// 두 폼의 컴포넌트들을 바인드한다,
						fnObj.priceTab.salePriceTabBind();
						fnObj.priceTab.buyPriceTabBind();

						// 두 그리드를 바인드한다.
						fnObj.salePriceGrid.bind();
						fnObj.buyPriceGrid.bind();

						// 앞에서 bind동작은 비동기로 진행되므로 로딩을 위해 2초간 스레드를 지연시킨다.
						setTimeout(function(){},2000);

						// 폼 정보를 저장한다.
						//fnObj.priceTab.formSalePrice = $("#buy-price-tab");
						//fnObj.priceTab.formBuyPrice = $("#sale-price-tab");

						// 탭을 선택할 때..
						$(".AXTabs .AXTab").click(function() {

							// on 클래스를 설정한다.
							$(".AXTabs .AXTab").each(function() {
								$(this).removeClass("on");
							});
							$(this).addClass("on");

							// 보여지는 영역에 모든 클래스를 분리시켜 저장한다.
							fnObj.priceTab.formBuyPrice = $("#buy-price-tab").remove();
							fnObj.priceTab.formSalePrice = $("#sale-price-tab").remove();

							// 탭이 선택한 옵션에 따라..
							var tabId = $(".AXTabs .AXTab.on").attr("data-href");
							if (tabId == "#sale-price-tab") {
								// 만약 탭이 판매단가변경 탭을 선택하면..

								// 보여지지 않는 영역에 매입단가탭이 배치되게 한다.
								$("#hidden-tab").append(fnObj.priceTab.formBuyPrice);

								// 보여지는 영역에 판매단가탭이 배치되게 한다.
								$("#tab-holder").append(fnObj.priceTab.formSalePrice);

								// 폼 컴포넌트들을 바인드한다. 이 작업을 하지 않으면 두 번째 탭 내용이 반응이 없다.
								fnObj.priceTab.salePriceTabBind();

							}else if(tabId == "#buy-price-tab"){
								// 만약 탭이 매입단가변경 탭을 선택하면..

								// 보여지지 않는 영역에 판매단가탭이 배치되게 한다.
								$("#hidden-tab").append(fnObj.priceTab.formSalePrice);

								// 보여지는 영역에 매입단가탭이 배치되게 한다.
								$("#tab-holder").append(fnObj.priceTab.formBuyPrice);

								// 폼 컴포넌트들을 바인드한다. 이 작업을 하지 않으면 두 번째 탭 내용이 반응이 없다.
								fnObj.priceTab.buyPriceTabBind();
							}

							// 탭 화면을 업데이트한다.
							// 요청사항에서는 이 작업을 건너뛰라고 하였는데
							// 새로운 그리드 아이템을 선택한 상태에서 다른 탭을 누르면
							// 다른 탱의 그리드 데이터가 반영이 되지 않으므로 추가하였다.
							fnObj.priceTab.updatePriceTabGridDisplay();
						});
					},

					salePriceTabBind: function() {

						fnObj.salePriceForm.validate_target.setConfig({
							targetFormName : "sale-price-form-info"
						});

						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
							fnObj.form.clear()
						});


						$("#info-stDate-sale").bindDate().val((new Date()).print());

						$("#info-defaultQty-sale").bindNumber();

						$("#info-qty-sale").bindNumber();

						$("#sale-price-add").click(function(){

							var partCode = $("#info-partCode").val();
							var itemCode = $("#info-itemCode").val();

							if(partCode == "" || partCode == null || itemCode == "" || itemCode == null){
								alert("품목저장후 추가해주세요.")
								return;
							}

							var params = {
								partCode: partCode,
								itemCode: itemCode,
								kind:0,
								stDate: $("#info-stDate-sale").val(),
								defaultQty:$("#info-defaultQty-sale").val(),
								price:$("#info-price-sale").val(),
								qty:$("#info-qty-sale").val()
							};

							app.ajax({
								url:"/FUNE0040/price",
								type:"put",
								data: Object.toJSON(params)
							}, function(res){
								//fnObj.priceTab.addItemToGrid(params);
								// 아이템을 그리드에 추가하는 것으로 끝낼 수도 있지만
								// 특정 날짜에서 여러 번 추가하면 데이터가 여러 번 추가되는 것이 아닌
								// 한 번 추가되고 나머지 추가되는 부분들은 업데이트로 처리되므로
								// 그리드에서도 한 건만 추가되고 수정만 이루어지게 해야된다.
								// 이러한 부분을 구현하는 것보다 차라리 서버에서 목록을 업데이트 받아오는 것이
								// 더 좋을것이라 판단하여 ajax로 처리하였다.
								fnObj.priceTab.updatePriceTabGridDisplay();
								fnObj.search.submit();
								toast.push("추가하였습니다.");
							});

						});

						$("#sale-price-last-remove").click(function(){

							var list = fnObj.salePriceGrid.target.list;
							if(list.length == 0){
								return;
							}

							var lastItem = list[0];

							app.ajax({
								url:"/FUNE0040/price-last",
								type:"delete",
								data:Object.toJSON(lastItem)
							}, function(res){
								//nObj.priceTab.updatePriceTabGridDisplay();
								fnObj.priceTab.removeLastItem();
								fnObj.search.submit();
								fnObj.salePriceForm.clear();
								toast.push("삭제하였습니다.");
							});

						});
					},

					buyPriceTabBind: function() {

						fnObj.buyPriceForm.validate_target.setConfig({
							targetFormName: "buy-price-form-info"
						});

						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
							fnObj.form.clear()
						});

						$("#buy-price-last-remove").click(function() {

							var list = fnObj.buyPriceGrid.target.list;
							if(list.length == 0){
								return;
							}

							var lastItem = list[0];

							app.ajax({
								url:"/FUNE0040/price-last",
								type:"delete",
								data:Object.toJSON(lastItem)
							}, function(res){
								//fnObj.priceTab.updatePriceTabGridDisplay();
								fnObj.priceTab.removeLastItem();
								fnObj.search.submit();
								fnObj.buyPriceForm.clear();
								toast.push("삭제하였습니다.");
							});
						});

						$("#info-stDate-buy").bindDate().val((new Date()).print());

						$("#info-defaultQty-buy").bindNumber();

						$("#buy-price-add").click(function(){

							var partCode = $("#info-partCode").val();
							var itemCode = $("#info-itemCode").val();

							if(partCode == "" || partCode == null || itemCode == "" || itemCode == null){
								alert("품목저장후 추가해주세요.")
								return;
							}

							var params = {
								partCode: partCode,
								itemCode: itemCode,
								kind:1,
								stDate: $("#info-stDate-buy").val(),
								defaultQty:$("#info-defaultQty-buy").val(),
								price:$("#info-price-buy").val(),
							};

							app.ajax({
								url:"/FUNE0040/price",
								type:"put",
								data: Object.toJSON(params)
							}, function(res){
								// 아이템을 그리드에 추가하는 것으로 끝낼 수도 있지만
								// 특정 날짜에서 여러 번 추가하면 데이터가 여러 번 추가되는 것이 아닌
								// 한 번 추가되고 나머지 추가되는 부분들은 업데이트로 처리되므로
								// 그리드에서도 한 건만 추가되고 수정만 이루어지게 해야된다.
								// 이러한 부분을 구현하는 것보다 차라리 서버에서 목록을 업데이트 받아오는 것이
								// 더 좋을것이라 판단하여 ajax로 처리하였다.
								fnObj.priceTab.updatePriceTabGridDisplay();
								fnObj.search.submit();
								toast.push("추가하였습니다.");
							});

						});

					},

					updatePriceTabGridDisplay: function(){

						var item = fnObj.form.selectedGridData;

						if(item == null){
							return;
						}

						var kind = $(".AXTabs .AXTab.on").attr("data-kind");
						var params = "partCode=" + item.partCode + "&itemCode=" + item.itemCode + "&kind=" + kind;
						if (kind == 0) {
							// 판매단가
							fnObj.salePriceGrid.setPage(fnObj.salePriceGrid.pageNo, params);
						} else {
							// 매입단가
							fnObj.buyPriceGrid.setPage(fnObj.salePriceGrid.pageNo, params);

						}
					},

					removeLastItem: function(){
						var displayId = $(".AXTabs .AXTab.on").attr("data-href");

						if(displayId == "#sale-price-tab"){
							var list = fnObj.salePriceGrid.target.getList();
							list.splice(list.length-1, 1);
							fnObj.salePriceGrid.target.setList(list);

						}else if(displayId == "#buy-price-tab"){
							var list = fnObj.buyPriceGrid.target.getList();
							list.splice(list.length-1, 1);
							fnObj.buyPriceGrid.target.setList(list);
						}

					}

				},

				salePriceGrid: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function() {
						var target = this.target, _this = this;
						target.setConfig({
							targetID: "salePrice-grid-box",
							theme: "AXGrid",
							colHeadAlign: "center",
							colGroup: [
								//{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
								{key: "stDate", label: "적용일자", width: "100", align: "center"},
								{key: "defaultQty", label: "기준수량", width: "80", align: "center"},
								{key: "price", label: "기준단가", width: "80", align: "right", formatter : "money"},
								{key: "qty", label: "판매수량", width: "80", align: "center"}
							],
							body : {
								onclick : function() {
                                    $("#info-useFlg").prop("checked", this.item.useFlg == 'Y');

								}
							}
						});
					},
					add: function() {
						this.target.pushList({});
						this.target.setFocus(this.target.list.length - 1);
					},
					del: function() {
						var _target = this.target, nextFn = function() {
							_target.removeListIndex(checkedList);
							toast.push("삭제 되었습니다.");
						};

						var checkedList = _target.getCheckedListWithIndex(0);// colSeq
						if (checkedList.length == 0) {
							alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
							return;
						}
						var dto_list = [];
						$.each(checkedList, function() {
							if (this.item._CUD != "C") {
								dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
							}
						});

						if (dto_list.length == 0) {
							nextFn(); // 스크립트로 목록 제거
						} else {
							app.ajax({
								type: "DELETE",
								url: "/api/v1/samples/parent",
								data: dto_list.join("&")
							}, function(res) {
								if (res.error) {
									alert(res.error.message);
								} else {
									nextFn(); // 스크립트로 목록 제거
								}
							});
						}
					},
					setPage: function(pageNo, searchParams) {
						var _target = this.target;
						this.pageNo = pageNo;

						app.ajax({
							type: "GET",
							url: "/FUNE0040/price-grid",
							data: "dummy=" + axf.timekey() + "&pageNumber=" + (pageNo - 1) + "&pageSize=50&" + (searchParams || fnObj.search.target.getParam())
						}, function(res) {
							if (res.error) {
								alert(res.error.message);
							} else {
								var gridData = {
									list : res.list
								};

								_target.setData(gridData);
							}
						});
					},

					clear: function(){
						fnObj.salePriceGrid.target.setList([]);
					}
				},

				salePriceForm: {
					target: $('#sale-price-form-info'),
					validate_target: new AXValidator(),
					selectedPartCode: null,
					bind: function() {
						var _this = this;

						/* this.validate_target.setConfig({
						    targetFormName : "sale-price-form-info"
						});

						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
						    fnObj.form.clear()
						});

						$("#sale-price-add").click(function(){
							fnObj.salePriceForm.clear();
						});

						$("#sale-price-last-remove").click(function(){

						});

						$("#info-stDate-sale").bindDate().val( (new Date()).print() );

						$("#info-defaultQty-sale").bindNumber();

						$("#info-qty-sale").bindNumber(); */
					},
					setJSON: function(item) {
						var _this = this;

						// 수정시 입력 방지 처리 필드 처리
						$('#info-stDate').attr("readonly", "readonly");

						var info = $.extend({}, item);
						app.form.fillForm(_this.target, info, 'info-');
						// 추가적인 값 수정이 필요한 경우 처리
						// $('#info-useYn').bindSelectSetValue( info.useYn );
					},
					getJSON: function() {
						return app.form.serializeObjectWithIds(this.target, 'info-');
					},
					clear: function() {
						app.form.clearForm(this.target);
						$('#info-stDate').removeAttr("readonly");
					}
				}, // form

				buyPriceGrid: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function() {
						var target = this.target, _this = this;
						target.setConfig({
							targetID: "buyPrice-grid-box",
							theme: "AXGrid",
							colHeadAlign : "center",
							colGroup: [
							//{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
								{key: "stDate", label : "적용일자", width : "100", align : "center"},
								{key: "defaultQty", label : "기준수량", width : "80", align : "center"},
								{key: "price", label : "기준단가", width : "80", align : "right", formatter:"money"}
							],
							body: {
								onclick: function() {

								}
							}
						});
					},
					add: function() {
						this.target.pushList({});
						this.target.setFocus(this.target.list.length - 1);
					},
					del: function() {
						var _target = this.target, nextFn = function() {
							_target.removeListIndex(checkedList);
							toast.push("삭제 되었습니다.");
						};

						var checkedList = _target.getCheckedListWithIndex(0);// colSeq
						if (checkedList.length == 0) {
							alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
							return;
						}
						var dto_list = [];
						$.each(checkedList, function() {
							if (this.item._CUD != "C") {
								dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
							}
						});

						if (dto_list.length == 0) {
							nextFn(); // 스크립트로 목록 제거
						} else {
							app.ajax({
								type: "DELETE",
								url: "/api/v1/samples/parent",
								data: dto_list.join("&")
							}, function(res) {
								if (res.error) {
									alert(res.error.message);
								} else {
									nextFn(); // 스크립트로 목록 제거
								}
							});
						}
					},
					setPage: function(pageNo, searchParams) {
						var _target = this.target;
						this.pageNo = pageNo;

						app.ajax({
							type: "GET",
							url: "/FUNE0040/price-grid",
							data: "dummy=" + axf.timekey() + "&pageNumber=" + (pageNo - 1) + "&pageSize=50&" + (searchParams || fnObj.search.target.getParam())
						}, function(res) {
							if (res.error) {
								alert(res.error.message);
							} else {

								var gridData = {
									list : res.list
								};

								_target.setData(gridData);
							}
						});
					},

					clear: function(){
						fnObj.buyPriceGrid.target.setList([]);
					}
				},

				buyPriceForm: {
					target: $('#buy-price-form-info'),
					validate_target: new AXValidator(),
					selectedPartCode: null,
					bind: function() {
						var _this = this;

						/* this.validate_target.setConfig({
						    targetFormName : "buy-price-form-info"
						});

						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
						    fnObj.form.clear()
						});

						$("#buy-price-add").click(function(){
							fnObj.salePriceForm.clear();
						});

						$("#buy-price-last-remove").click(function(){

						});

						$("#info-stDate-buy").bindDate().val( (new Date()).print() );

						$("#info-defaultQty-buy").bindNumber(); */

					},
					setJSON: function(item) {
						var _this = this;

						// 수정시 입력 방지 처리 필드 처리
						$('#info-stDate-buy').attr("readonly", "readonly");

						var info = $.extend({}, item);
						app.form.fillForm(_this.target, info, 'info-');
						// 추가적인 값 수정이 필요한 경우 처리
						// $('#info-useYn').bindSelectSetValue( info.useYn );
					},
					getJSON: function() {
						return app.form.serializeObjectWithIds(this.target, 'info-');
					},
					clear: function() {
						app.form.clearForm(this.target);
						$('#info-stDate-buy').removeAttr("readonly");
					}
				}, // form

			};
		</script>
	</ax:div>
</ax:layout>