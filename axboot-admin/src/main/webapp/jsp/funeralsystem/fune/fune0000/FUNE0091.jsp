<%@page import="java.util.List"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="레시피등록관리" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true" >

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> ${title }</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td" style="width: 40%;">
							<div class="ax-button-group">
			                    <div class="left">
			                    </div>
			                    <div class="right">
			                    	<b:button text="조회" id="btn-searchItems"></b:button>
			                    	<b:button text="선택자재추가" id="btn-addItems"></b:button>
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <ax:form id="form-item" name="form-item">
								<table class='AXFormTable'>
	                   				<colgroup>
	                    				<col width="100"/>
	                    				<col/>
	                    			</colgroup>
	                    			<tr>
	                    				<th><div class='tdRel'>파트</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<select id="info-partCode" name="partCode" ></select>
	                   					</div></td>
	                    			</tr>
	                    			<tr>
	                    				<th><div class='tdRel'>자재분류</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<select id="info-groupCode" name="groupCode"></select>
	                   					</div></td>
	                    			</tr>
	                    			<tr>
	                    				<th><div class='tdRel'>자재코드</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-itemCode" name="itemCode"></b:input>
	                   					</div></td>
	                    			</tr>
	                    			<tr>
	                    				<th><div class='tdRel'>자재명</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-itemName" name="itemName"></b:input>
	                   					</div></td>
	                    			</tr>
								</table>
							</ax:form>
							<div id="div-grid-item"></div>
						</ax:custom>
						<ax:custom customid="td">
							<div class="ax-button-group">
			                    <div class="left">
			                    	<b:button text="위로이동" id="btn-moveUp"></b:button>
			                    	<b:button text="아래로이동" id="btn-moveDown"></b:button>
			                    	<b:button text="선택자재삭제" id="btn-deleteRecipeItem"></b:button>
			                    </div>
			                    <div class="right">
			                    	<b:button text="저장" id="btn-saveRecipeItem"></b:button>
			                    	<b:button text="엑셀" id="btn-excelRecipeItem"></b:button>
			                    	<b:button text="초기화" id="btn-refreshRecipeItem"></b:button>
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
							<table class='AXFormTable'>
								<colgroup>
                       				<col width="100"/>
                       				<col/>
                       			</colgroup>
                    			<tr>
                    				<th><div class='tdRel'>생산제품</div>
                    				</th>
                    				<td><div class='tdRel'>
                    					<b:input id="info-recipeItem-itemCode" readonly="readonly" value="${param.itemCode }"></b:input>
                    					<b:input id="info-recipeItem-itemName" readonly="readonly" value="${param.itemName }"></b:input>
                   					</div></td>
                    			</tr>
                    			<tr>
                    				<th><div class='tdRel'>레시피</div>
                    				</th>
                    				<td><div class='tdRel'>
                    					<b:input id="info-recipeItem-recipeCode" readonly="readonly" value="${param.recipeCode }"></b:input>
                    					<b:input id="info-recipeItem-recipeName" readonly="readonly" value="${param.recipeName }"></b:input>
                   					</div></td>
                    			</tr>
							</table>
							<div id="div-grid-recipeItem" style="height: 482px;"></div>
						</ax:custom>
					</ax:custom>
				</ax:custom>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.bindEvent();
					this.search.bind();
					this.gridItems.bind();
					this.gridRecipeItems.bind();
					this.defaultFn.excute();
				},
				CODES: {
					partCode: (function(){
						var result;
			        	app.ajax({
			        			async: false,
			                    type: "GET",
			                    url: "/FUNE0091/part",
			                    data: "partCode=${param.partCode}"
			                },
			                function(res){
			                	result = res;
			            	}
			            );
			        	return result;
					}())
					, groupCode: (function(){
						var result;
			        	app.ajax({
			        			async: false,
			                    type: "GET",
			                    url: "/FUNE0091/groupCode",
			                    data: "partCode=${param.partCode}"
			                },
			                function(res){
			                	result = res;
			            	}
			            );
			        	return result;
					}())
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});
					$("#info-partCode").bindSelect({
						options: fnObj.CODES.partCode
					})
					$("#info-groupCode").bindSelect({
						options: fnObj.CODES.groupCode
					})
				},
				eventFn: {
					searchItems: function(){
						fnObj.search.submit();
					}
					, addItems: function(){
						var checkedList = fnObj.gridItems.target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 추가하시려는 목록을 체크하세요");
                            return;
                        }

						var recipeItem = {
								partCode: "${param.partCode}"
								, itemCode: "${param.itemCode}"
								, recipeCode: "${param.recipeCode}"
								, mateCode: null
								, qty: 1
						}

						var addItems = [];
						$.each(checkedList, function(i, o){
							var ri = $.extend({}, recipeItem);
							ri.mateCode = o.item.itemCode;
							ri.item = o.item
							addItems.push(ri);
						});

						var containsGet = function(mateCode){
							var list = fnObj.gridRecipeItems.target.list;
							for(var i=0; i<list.length; i++){
								if(list[i].mateCode == mateCode){
									return {contains: true, index: i, item: list[i]};
								}
							}
							return {contains: false};
						}
						$.each(addItems, function(i, o){
							var contains = containsGet(o.mateCode);
							if(!contains.contains){
								fnObj.gridRecipeItems.target.pushList(o);
							}
						})
					}
					, moveUp: function(){
						var item = fnObj.gridRecipeItems.target.getSelectedItem();
						if(item.error){
							toast.push(item.description);
							return;
						}

						if(Array.isArray(item.index) || item.index-1 < 0){
							return;
						}

						var list = fnObj.gridRecipeItems.target.list;
						list.splice(item.index-1, 0, item.item);
						list.splice(item.index+1, 1);
						fnObj.gridRecipeItems.target.setData({list: list})

						fnObj.gridRecipeItems.target.setFocus(item.index-1);
					}
					, moveDown: function(){
						var item = fnObj.gridRecipeItems.target.getSelectedItem();
						if(item.error){
							toast.push(item.description);
							return;
						}

						var list = fnObj.gridRecipeItems.target.list;

						if(Array.isArray(item.index) || item.index+1 >= list.length){
							return;
						}

						list.splice(item.index, 1);
						list.splice(item.index+1, 0, item.item);
						fnObj.gridRecipeItems.target.setData({list: list})

						fnObj.gridRecipeItems.target.setFocus(item.index+1);
					}
					, deleteRecipeItem: function(){

						var _target = fnObj.gridRecipeItems.target,
                        nextFn = function() {
                            _target.removeListIndex(checkedList);
                        };

	                    var checkedList = _target.getCheckedListWithIndex(0);// colSeq
	                    if(checkedList.length == 0){
	                        alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
	                        return;
	                    }

	                    nextFn();
					}
					, refreshRecipeItem: function(){
						fnObj.gridRecipeItems.setPage();
					}
					, saveRecipeItem: function(){
						app.ajax({
                            type: "PUT",
                            url: "/FUNE0091/recipe-item/${param.partCode}/${param.itemCode}/${param.recipeCode}",
                            data: Object.toJSON(fnObj.gridRecipeItems.target.list)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		toast.push("저장되었습니다.");

                            }
                        });
					}
					, excelRecipeItem: function(){
						Common.report.gridToExcel("recipe-"+$("#info-recipeItem-recipeCode").val(), fnObj.gridRecipeItems.target);
					}
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
                	, searchRecipeItem: function(){
                		fnObj.gridRecipeItems.setPage();
                	}
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"form-item",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                        });
                    },
                    submit: function(){
                    	fnObj.gridItems.setPage();
                    }
                },
                gridItems: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                            	{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"itemCode", label:"자재코드", width:"80", align:"center"},
                                {key:"itemName", label:"자재명", width:"100", align:"center"},
                                {key:"unit", label:"단위", width:"80", align:"center"},
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
                    setPage: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE0091/item",
                            data: fnObj.search.target.getParam()
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		fnObj.gridItems.target.setData({list:res.list});

                            }
                        });
                    }
                },
                gridRecipeItems: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-recipeItem",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                            	{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"mateCode", label:"자재코드", width:"80", align:"center"},
                                {key:"xxx", label:"자재명", width:"100", align:"center", formatter: function(){
                                	return this.item.item.itemName;
                                }},
                                {key:"xxx", label:"단위", width:"100", align:"center", formatter: function(){
                                	return this.item.item.prodUnit;
                                }},
                                {key:"qty", label:"수량", width:"100", align:"center",
                                    editor:{
                                        type:"number",
                                    }
                                },
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
                    setPage: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE0091/recipe-item",
                            data: "partCode=${param.partCode}&itemCode=${param.itemCode}&recipeCode=${param.recipeCode}"
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.gridRecipeItems.target.setData({list:res.list});
                            }
                        });
                    }
                },
				control: {
					save: function(){
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
// 			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>