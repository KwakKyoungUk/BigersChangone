<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("itemIndex", request.getParameter("itemIndex"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="구분" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

				<div class="ax-search" id="page-search-box"></div>
				<!--
				<div class="ax-button-group">
					<div class="left">

					</div>
					<div class="right">
						<button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-search"></i> 이전</button>
						<button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-search"></i> 다음</button>
					</div>
					<div class="ax-clear"></div>
				</div>
				-->
				<div class="ax-grid" id="page-grid-box" style="height:300px;"></div>

			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">확인</button>
		<button type="button" class="AXButton" onclick="fnObj.control.clear();">선택안함</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var callBackName = "${callBack}";
			var itemIndex = "${itemIndex}";
		
			
			var fnObj = {
				CODES : {
							"C":Common.getCode("TMC03")
							,"E":Common.getCode("TFM10")
							,"N":Common.getCode("TFM10")
							,"T":Common.getCode("TFM10")
							,"F":Common.getCode("TFM10")
							,"S":Common.getCode("TFM27")
				},	
				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					console.log("${jobGubun}");
				},

				search: {
					target: new AXSearch(),
					get: function() { return this.target },
					bind: function() {
						var _this = this;
						var _target = this.target;
						this.target.setConfig({
							targetID: "page-search-box",
							theme : "AXSearch",
							/*
							 mediaQuery: {
							 mx:{min:0, max:767}, dx:{min:767}
							 },
							 */
							onsubmit: function(){
								// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
								_this.submit();
							},
							
						});
					},
					submit: function(){
						fnObj.grid.setPage()
					}
				}, // search

				grid: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function() {
						var _this = this;
						this.target.setConfig({
							targetID : "page-grid-box",
							theme : "AXGrid",
							colHeadAlign:"center",
							colGroup: [
								{key:"optionValue", label:"구분코드", width:"150"},
								{key:"optionText", label:"구분명", width:"*"}
							],
							body: {
								onclick: function() {
									//toast.push(Object.toJSON({index:this.index, item:this.item}));
									//fnObj.modal.open("gridView", this.item);
								}
							},
							page: {
								display: true,
								paging: false,
								onchange: function(pageNo){  // 체크
									_this.setPage(pageNo);
								}
							}
						});
						this.setPage(fnObj.grid.pageNo); // 체크
					},
					setPage: function(){ // 체크
						var _target = this.target;
	
						var jobGubun = "${param.jobGubun}";
						var gridDate = { list : fnObj.CODES[jobGubun]	}						
						_target.setData(gridDate);
							
					
					}
				}, // grid

				control: {
					save: function(){

						var result = fnObj.grid.target.getSelectedItem();
						if(result.error) {
							alert("목록을 선택해주세요");
							return false;
						}
						var item = [].concat(result.item);
						app.modal.save(window.callBackName, {
							optionText: item[0].optionText,
							optionValue: item[0].optionValue
						}, itemIndex);
					},
					clear: function(){
						app.modal.save(window.callBackName, {
							optionText: '',
							optionValue: ''
						}, itemIndex);
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