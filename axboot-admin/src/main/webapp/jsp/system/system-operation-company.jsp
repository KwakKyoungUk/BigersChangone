<%@ page contentType="text/html; charset=UTF-8"
		%><%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"
		%><%@ taglib prefix="ax" uri="http://axisj.com/axu4j"
		%><%
%>
<ax:layout name="base.jsp">
	<ax:set name="title" value="${PAGE_NAME}" />
	<ax:set name="page_desc" value="${PAGE_REMARK}" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
				<ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">
							<h2><i class="axi axi-list-alt"></i> 업체정보</h2>

							<%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
							<div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
						</ax:custom>

						<ax:custom customid="td">
							<%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
							<div class="ax-button-group">
								<div class="left">
									<h2><i class="axi axi-table"></i> 업체등록</h2>
								</div>
								<div class="right">
									<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
								</div>
								<div class="ax-clear"></div>
							</div>

							<%-- %%%%%%%%%% 폼 (업체등록) %%%%%%%%%% --%>
							<ax:form id="form-company" name="form-company" method="get">
								<ax:fields>
									<ax:field label="업체코드">
										<input type="text" id="company-compCd" maxlength="8" class="AXInput W100"
											   value=""/>
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="업체명">
										<input type="text" id="company-compNm" maxlength="25" class="AXInput W200" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="대표자명">
										<input type="text" id="company-compCeo" maxlength="15" class="AXInput W100" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="사업자등록번호">
										<input type="text" id="company-compRegno" class="AXInput W200" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="법인등록번호">
										<input type="text" id="company-compCono" class="AXInput W200" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="대표전화번호">
										<input type="text" id="company-telNo" maxlength="15" class="AXInput W200" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="주소(업체)">
										<label class="AXInputLabel">
											<input type="text" id="company-zipNo" class="AXInput W60" value="" readonly="readonly" />
											<button class="AXButton" onclick="fnObj.addressPopup.open();" type="button"><i class="axi axi-info"></i> 검색</button>
										</label>
										<label class="AXInputLabel fullWidth">
											<input type="text" id="company-addr1" class="AXInput" value="" placeholder="주소" readonly="readonly" />
										</label>
										<label class="AXInputLabel fullWidth">
											<input type="text" id="company-addr2" maxlength="50" class="AXInput" value="" placeholder="기타주소" />
										</label>
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="사용여부">
										<select class="AXSelect" id="company-useYn">
											<option value="Y" selected="selected">사용</option>
											<option value="N">사용안함</option>
										</select>
									</ax:field>
								</ax:fields>
							</ax:form>
						</ax:custom>
					</ax:custom>
				</ax:custom>
			</ax:col>
		</ax:row>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var resize_elements = [
				{id:"page-grid-box", adjust:-51}
			];
			var fnObj = {



				/*******************************************************
				 * pageStart
				 */
				pageStart: function() {
					this.grid.bind();
					this.detailForm.bind();
					this.bindEvent();
				}, // pageStart



				/*******************************************************
				 * bindEvent
				 */
				bindEvent: function() {
					var _this = this;
					$('#company-useYn').bindSelect();

					$("#ax-page-btn-search").bind("click", function(){
						fnObj.grid.loadPage(fnObj.grid.pageNo);
					});

					$("#ax-page-btn-save").bind("click", function() {
						if ( ! $('#company-compCd').val() ) {
							toast.push("업체코드 항목이 비어있습니다.");
							return;
						}

						if ( ! $('#company-compNm').val() ) {
							toast.push("업체명 항목이 비어있습니다.");
							return;
						}

						setTimeout(function(){
							fnObj.net.saveCompany(function(res) {
								toast.push("저장되었습니다.");
								// 저장 후 그리드 리로드
								fnObj.grid.loadPage(fnObj.grid.pageNo);
							});
						}, 500);
					});

					$("#ax-page-btn-excel").bind("click", function(){
						app.modal.excel({
							pars:"target=${className}"
						});
					});
				}, // bindEvent


				/*******************************************************
				 * Ajax 통신
				 */
				net: {

					getCompanies: function(pageNo, handler) {
						app.net.ajax({
							type: "GET",
							url: "/api/v1/companies",
							data: "pageNumber=" + pageNo + "&pageSize=100"
						}, function(res) {
							//console.log(res);
							handler(res);
						});
					},

					saveCompany: function(handler) {
						app.net.ajax({
							type: fnObj.detailForm.isCompanyCodeEmpty() ? "POST" : "PUT",
							url: "/api/v1/companies",
							data: Object.toJSON([fnObj.detailForm.getCompanyJSON()])
						}, function(res) {
							handler(res);
						});
					}

				}, // net



				/*******************************************************
				 * 상세 폼
				 */
				detailForm: {
					target: $('#form-company'),
					bind: function() {
						var _this = this;
						_this.initPattern();
						// form clear 처리 시
						$('#ax-form-btn-new').click(function() {
							app.form.clearForm(_this.target);
							$("#company-compCd").removeAttr("readonly"); // 업체코드 신규등록이면 활성화
							$('#company-useYn').bindSelectSetValue('Y');
						});
					},
					initPattern: function() {
						var _this = this;
						$("#company-compRegno").bindPattern({pattern: "bizno"}); // 사업자
						$("#company-compCono").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"}); // 법인
						$("#company-telNo").bindPattern({pattern: "phone"}); // 전화번호
						$("#company-zipNo").bindPattern({pattern: "custom", max_length: 7, patternString:"999-999"}); // 우편번호
					},
					isCompanyCodeEmpty: function() {
						var _this = this;
						return ! (_this.target.find('#company-compCd').val().trim());
					},
					fillFormWithCompanyJSON: function(srcCompany) {
						var _this = this;
						var company = $.extend({}, srcCompany);
						app.form.fillForm(_this.target, company, 'company-');
						$('#company-useYn').bindSelectSetValue( company.useYn );
					},
					getCompanyJSON: function() {
						var _this = this;
						var company = app.form.serializeObjectWithIds(this.target, 'company-');
						company.compCono = company.compCono.split('-').join('');
						company.compRegno = company.compRegno.split('-').join('');
						company.zipNo = company.zipNo.split('-').join('');
						return company;
					}
				}, // detailForm



				/*******************************************************
				 * 주소 검색 창
				 */
				addressPopup: {
					open: function() {
						window.open("/jsp/common/zipcode_modal.jsp?callBack=fnObj.addressPopup.handler", "address", "width=640, height=600");
					},

					handler: function(obj) {
						//trace(obj);
						if (obj != null) {
							var zip_no = obj.zip_no;
							var road_all_nm = obj.road_all_nm;
							$("#company-zipNo").val(zip_no.left(3) + "-" + zip_no.right(3));
							$("#company-addr1").val(road_all_nm.dec());
							$("#company-addr2").focus();
						}
					}
				}, // addressPopup



				/*******************************************************
				 * Grid 업체정보
				 */
				grid: {
					pageNo: 0,
					target: new AXGrid(),
					bind: function() {
						var _this = this;
						_this.target.setConfig({
							targetID : "page-grid-box",
							theme : "AXGrid",
							colGroup: [
								{key:"compCd", label:"업체코드", width:"100", align:"center"},
								{key:"compNm", label:"업체명", width:"100", align:"center"},
								{key:"compCeo", label:"대표자명", width:"100", align:"center"},
								{key:"compRegno", label:"사업자등록번호", width:"120", align:"center", formatter: function() {
									if(this.item.compRegno) {
										var arr = [];
										arr.push(this.item.compRegno.substring(0, 3));
										arr.push(this.item.compRegno.substring(3, 5));
										arr.push(this.item.compRegno.substring(5));
										return arr.join('-');
									}else{
										return "";
									}
								}}
							],
							body: {
								onclick: function() {
									fnObj.detailForm.fillFormWithCompanyJSON(this.item);
									$("#company-compCd").attr("readonly", "readonly");
								}
							},
							page: {
								display: true,
								paging: false
							}
						});
						this.loadPage(this.pageNo);
					},
					loadPage: function(pageNo) {
						var _this = this;
						_this.pageNo = pageNo;
						fnObj.net.getCompanies(pageNo, function(res) {
							var gridData = {
								list: res.list,
								page:{
									pageNo: res.page.currentPage+1,
									pageSize: res.page.pageSize,
									pageCount: res.page.totalPages,
									listCount: res.page.totalElements
								}
							};
							_this.target.setData(gridData);
						});
					}
				}, // grid



				__end: {}
			}; // fnObj
		</script>
	</ax:div>
</ax:layout>
