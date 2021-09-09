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
	<ax:set name="title" value="정산마감관리" />
	<ax:set name="page_desc" value="" />

	<ax:div name="css">
		<style type="text/css">
			.dead_info {
				border: 1px lightgray solid;
			}
		</style>
	</ax:div>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> ${title }</h2>
                    </div>
                    <div class="right">
						<button id="btn-openAllPart" type="button" class="AXButton">전체마감해제</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div id="div-deadInfo" class="dead_info"></div>
				<div id="div-grid-totalPart"></div>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">적용</button> --%>
<%-- 		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button> --%>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var callBackName = "${callBack}";

			var fnObj = {

				pageStart: function(){
					this.bindEvent();
					this.grid.bind();
					this.grid.setPage();
				},
				CODES: {
					partCode: (function(){
						var result;
			        	app.ajax({
			        			async: false,
			                    type: "GET",
			                    url: "/FUNE5011/part/option",
			                    data: ""
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
					$("#btn-openAllPart").bind("click", fnObj.eventFn.openAllPart);
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
                	openAllPart: function(){
                		if(!confirm("전체마감을 해제하시겠습니까?")){
                			return;
                		}
                		app.ajax({
                            type: "PUT",
                            url: "/FUNE5011/openAllPart/${param.customerNo}",
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.grid.setPage();
                        		parent.fnObj.drawBinsoList();
                            }
                        });
                	}
                	, openPart: function(customerNo, partCode){
                		app.ajax({
                            type: "PUT",
                            url: "/FUNE5011/openPart/"+customerNo+"/"+partCode,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.grid.setPage();
                        		parent.fnObj.drawBinsoList();
                            }
                        });
                	}
                	, closePart: function(customerNo, partCode){
                		app.ajax({
                            type: "PUT",
                            url: "/FUNE5011/closePart/"+customerNo+"/"+partCode,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		fnObj.grid.setPage();

                            }
                        });
                	}
                },
                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-totalPart",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"partCode", label:"파트", width:"130", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("partCode", this.value);
                                }},
                                {key:"amount", label:"마감금액", width:"100", align:"center", formatter: "money"},
                                {key:"jDcAmount", label:"할인대상금액", width:"100", align:"center", formatter: "money"},
                                {key:"jAmount", label:"수납금액", width:"100", align:"center", formatter: "money"},
                                {key:"dcAmount", label:"감면금액", width:"100", align:"center", formatter: "money"},
                                {key:"status", label:"마감상태", width:"80", align:"center", formatter: function(){
                                	if(this.value == "1"){
                                		return '<button type="button" class="AXButton" onclick="fnObj.eventFn.openPart(\''+this.item.customerNo+'\', \''+this.item.partCode+'\')">해제</button>'
                                	}else{
                                		return '<button type="button" class="AXButton" onclick="fnObj.eventFn.closePart(\''+this.item.customerNo+'\', \''+this.item.partCode+'\')">마감</button>'
                                	}
                                }},
                                {key:"remark", label:"메모", width:"100", align:"center"},
                                {key:"udtid", label:"마감자", width:"100", align:"center"},
                                {key:"udttime", label:"마감일시", width:"100", align:"center"},
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
                            url: "/FUNE5011/totalPart",
                            data: "customerNo=${param.customerNo}"
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		fnObj.grid.target.setData({list:res.list});

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
			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>