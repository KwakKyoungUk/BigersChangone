<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("itemIndex", request.getParameter("itemIndex"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="반납대상" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 반납대상</h2>
                    </div>
                    <div class="right">

                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div id="div-grid-item"  style="min-height: 700px;"></div>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">확인</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid_old.js"></script>
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.gridItem.bind();
					this.gridItem.setPage();

					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

				},

				gridItem: {
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
                                {key:"itemGroupName", label:"품목분류명", width:"100", align:"left"},
                                {key:"itemName", label:"품목명", width:"200", align:"left"},
                                {key:"unit", label:"단위", width:"100", align:"center"},
                                {key:"saleQty", label:"판매수량", width:"80", align:"right"},
                                {key:"returnQty", label:"반납수량", width:"100", align:"right", editor:{
                                    type:"text",
                                    maxLength: 50,
                                    beforeUpdate: function(val){
                                    	return val.number();
                                    },
                                    afterUpdate: function(){
                                    	if(this.item.saleQty < this.item.returnQty){
                                    		this.item.returnQty = 0;
                                    		toast.push("판매수량보다 반납수량이 많을 수 없습니다.");
                                    	}
                                    	fnObj.gridItem.target.updateList(this.index, this.item);
                                    }
                                }},
                            ],
                            body : {
                                onclick: function(){
                                }
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
                            url: "/FUNE1013/return/item?partCode=${param.partCode}&customerNo=${param.customerNo}",
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		fnObj.gridItem.target.setData({list:res.list});

                            }
                        });
                    }
                },

				control: {
					save: function(){

						var items = [];
						$.each(fnObj.gridItem.target.list, function(i, o){
							if(o.returnQty && o.returnQty > 0){
								items.push(o);
							}
						});

						app.modal.save(window.callBackName, items);
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