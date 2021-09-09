<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
            .button_group.vertical button{
            	width:130px;
            	height: 50px;
            	margin: 5px;
            	margin-bottom: 15px;
            	font-size: 18px;
            }
            .button_group.vertical.fixed{
            	right: 30px;
            	width: 150px;
            	text-align: center;
            }
            .binso{
            	margin: 5px;
            }
            .binso.assigned{
            	opacity: 0.7;
            }
            .binso.not_assigned{
            	opacity: 0.2;
            }
            .binso.assigned table td{
            	color: black;
            	background-color: white;
            }
            .binso.not_assigned table td{
            	color: gray;
            	background-color: lightgray;
            }
            .part.assigned td{
            	color: black;
            	background-color: white;
            }
            .part.not_assigned td{
            	color: gray;
            	background-color: lightgray;
            }
            .binso_list .binso.on, .each_sale .binso.on{
            	border: 4px solid blue;
            	opacity: 1;
            }
            .binso_list .binso.off, .each_sale .binso.off{
            	border: 1px solid black;
            }
           	.binso_list .part.on.assigned td, .each_sale .part.on.assigned td{
            	background-color: lightgray;
            }
            .binso_list .part.off.assigned td, .each_sale .part.off.assigned td{
            	background-color: white;
            }
           	.binso_list .part.on.assigned, .each_sale .part.on.assigned{
            	border: 4px solid lightblue;
           	}
            .binso_list .part.off.assigned, .each_sale .part.off.assigned{
            	border: 1px solid black;
            }
            .binso_list .binso_title, .each_sale .binso_title{
            	font-size: 20px;
            	font-weight: bolder;
            }
            .money, .cnt{
            	text-align: right;
            }
            .absolute {
            	position: absolute;
            }
            .relative{
            	position: relative;
            }
            .fixed{
            	position: fixed;
            }
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
							<table style="width: 100%;">
								<tr>
									<td class="binso_list">
									</td>
									<td width="230" class="each_sale" valign="top">
									</td>
								</tr>
							</table>
						</ax:custom>
                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
	                        	<b:button disabled="disabled" text="고객신규등록" id="btn-new-dead"></b:button>
	                        	<b:button disabled="disabled" text="고객정보수정" id="btn-modify-dead"></b:button>
	                        	<b:button disabled="disabled" text="고객정보조회" id="btn-search-dead"></b:button>
	                        	<b:button disabled="disabled" text="빈소이용정보" id="btn-info-binso"></b:button>
	                        	<b:button disabled="disabled" text="판매전표등록" id="btn-new-stmt"></b:button>
	                        	<b:button disabled="disabled" text="판매전표내역" id="btn-bd-stmt"></b:button>
	                        	<b:button disabled="disabled" text="개별승인취소" id="btn-cancel-each"></b:button>
	                        	<b:button disabled="disabled" text="파트선택마감" id="btn-end-part"></b:button>
	                        	<b:button disabled="disabled" text="파트일괄마감" id="btn-endAll-part"></b:button>
                        	</div>
						</ax:custom>
					</ax:custom>
				</ax:custom>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/plugins/jquery/jquery.number.min.js"></script>
        <script type="text/javascript">
            var resize_elements = [
//                 {id:"div-content-A-grid", adjust:function(){
//                     	return -axf.clientHeight()/2;
//                 	}
//                 }
//                 , {id:"page-grid-box-hwaBooking", adjust:function(){
//     	                return -axf.clientHeight()/2;
// 	                }
//                 }
            ];
            var fnObj = {

                CODES: {

                },
                template: {
                	keywords: [
                		"[binsoName]"
                		, "[binsoCode]"
                		, "[deadName]"
                		, "[customerNo]"
                		, "[stDateTime]"
                		, "[edDateTime]"
                		, "[partlist]"
                		, "[part]"
                		, "[partName]"
                		, "[cnt]"
                		, "[amount]"
                		, "[assigned]"
                		, "[assigned]"
                	]
                	, binso:
                			"<div style='width: 230px; display: inline-block;' class='binso off [assigned]' onclick='fnObj.eventFunc.selectBinso(this, \"[binsoCode]\", \"[customerNo]\")'>"+
				               	"<table class='AXFormTable'>"+
				               		"<colgroup>"+
				               			"<col/>"+
				               			"<col width=50/>"+
				               			"<col/>"+
				               		"</colgroup>"+
				            		"<tr>"+
				            			"<th rowspan='2'><div class='tdRel binso_title'>[binsoName]</div>"+
				            			"</th>"+
				            			"<td colspan='2' align='center'><div class='tdRel'><b style='font-size: 20px;'>[deadName]</b></div>"+
				            			"</td>"+
				            		"</tr>"+
				            		"<tr>"+
				            			"<td colspan='2'><div class='tdRel'>[stDateTime], [edDateTime]</div>"+
				            			"</td>"+
				            		"</tr>"+
				            		"[partlist]"+
				            	"</table>"+
				        	"</div>"
					, binsoPart:
							"<tr onclick='fnObj.eventFunc.selectPart(this, \"[part]\")' ondblclick='fnObj.eventFunc.regSaleStmt()' class='part off [assigned]'>"+
					        	"<th><div class='tdRel'>[partName]</div>"+
					        	"</th>"+
					        	"<td><div class='tdRel cnt'>[cnt]</div></td>"+
					        	"<td><div class='tdRel money'>[amount]</div></td>"+
				        	"</tr>"
					, deleteKeywords: function(str){
						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
                },
                pageStart: function(){
					this.drawBinsoList();
					this.bindEvent();
                },
                data: {
                	EACH_SALE_CODE: 999
                	, PART_FUNERAL: "10-001"
                	, selectedBinso: ""
                	, selectedPart: ""
                	, selectedCustomer: ""
                },
                disabledGroup: {
                	all: [
                		"btn-new-dead"
                		, "btn-modify-dead"
                		, "btn-search-dead"
                		, "btn-info-binso"
                		, "btn-new-stmt"
                		, "btn-bd-stmt"
                		, "btn-cancel-each"
                		, "btn-end-part"
                		, "btn-endAll-part"
                	]
                	, eachSale: [
                		"btn-new-dead"
                		, "btn-modify-dead"
                		, "btn-search-dead"
                		, "btn-info-binso"
                	]
                	, assignedBinsoSale: [
                		"btn-new-dead"
                		, "btn-modify-dead"
                		, "btn-search-dead"
                		, "btn-info-binso"
                		, "btn-cancel-each"
                	]
                	, partFuneral: [
                		"btn-new-dead"
                		, "btn-cancel-each"
                	]
                	, notAssignedBinsoSale: [
                		"btn-modify-dead"
                		, "btn-search-dead"
                		, "btn-info-binso"
                		, "btn-new-stmt"
                		, "btn-bd-stmt"
                		, "btn-cancel-each"
                		, "btn-end-part"
                		, "btn-endAll-part"
                	]
                },
                drawBinsoList: function() {

                	app.ajax({
                        type: "GET",
                        url: "/FUNE1010/binso/part",
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{

                    		var binsoList = [];
                    		var eachSale;

                            $.each(res.list, function(i, o){
                            	var part = [];
                            	$.each(o.binsoInfo, function(i2, o2){
                            		var partItem = fnObj.template.binsoPart.replace("[part]", o2.part);
                            		partItem = partItem.replace("[partName]", o2.partName);
                            		partItem = partItem.replace("[cnt]", o2.cnt);
                            		partItem = partItem.replace("[amount]", o2.amount.money());

                            		if(o.binsoAssign){
                            			partItem = partItem.replace("[assigned]", "assigned");
                            		}else{
                            			if(fnObj.data.EACH_SALE_CODE == o.binsoCode){
                            				partItem = partItem.replace("[assigned]", "assigned");
    	                            	}else{
                            				partItem = partItem.replace("[assigned]", "not_assigned");
    	                            	}
                            		}
                            		part.push(partItem);
                            	});

                            	var binso = fnObj.template.binso.replace("[binsoName]", o.displayBinso);
                            	binso = binso.replace("[binsoCode]", o.binsoCode);

                            	if(o.funeral && o.funeral.customerNo != '' && o.funeral.customerNo.length == 9){
	                            	binso = binso.replace("[customerNo]", o.funeral.customerNo);
	                            	binso = binso.replace("[deadName]", o.funeral.thedead.deadName);
                            	}
                            	if(o.binsoCode == "999"){
                            		binso = binso.replace("[customerNo]", "${yyyyMMdd}");
                            	}
                            	if(o.binsoAssign && o.funeral.customerNo != '' && o.funeral.customerNo.length == 9){
                            		binso = binso.replace("[assigned]", "assigned");
                            		if(o.binsoAssign.stDateTime){
	                            		binso = binso.replace("[stDateTime]", o.binsoAssign.stDateTime.date().print("mm월dd일"));
                            		}
                            		if(o.binsoAssign.edDateTime){
		                            	binso = binso.replace("[edDateTime]", o.binsoAssign.edDateTime.date().print("mm월dd일"));
                            		}
                            	}else{
	                            	if(fnObj.data.EACH_SALE_CODE == o.binsoCode){
	                            		binso = binso.replace("[assigned]", "assigned");
	                            	}else{
	                            		binso = binso.replace("[assigned]", "not_assigned");
	                            	}
                            	}

                            	binso = binso.replace("[partlist]", part.join(""));


                            	binso = fnObj.template.deleteKeywords(binso);
								if(fnObj.data.EACH_SALE_CODE == o.binsoCode){
									eachSale = binso;
								}else{
// 	                            	binsoList.push(binso);
	                            	binsoList.push({binsoHtml: binso, row: o.rowPosition, col: o.colPosition});
								}
                            });

                            var resList = [];
                            for(var r=1; r<=6; r++){
                    			for(var c=1; c<=6; c++){
                    				$.each(binsoList, function(i,o){
                    					if(o.row == r && o.col == c){
                    						resList.push(o.binsoHtml);
                    					}
                    				});
                    			}
                    			resList.push("<br>");
                    		}

                            $(".binso_list").html(resList.join(""));
                            $(".each_sale").html(eachSale);
//                             $(".money").map(function(o){
//                             	if($(o).html()){
// 	                            	$(o).html($(o).html().money());
//                             	}
//                             })
                        }
                    });
                },
                bindEvent: function(){
                	$("#ax-page-btn-search").bind("click", fnObj.drawBinsoList);
					$("#btn-new-dead").bind("click", fnObj.eventFunc.newCustomer);
					$("#btn-modify-dead").bind("click", fnObj.eventFunc.modifyCustomer);
					$("#btn-search-dead").bind("click", fnObj.eventFunc.searchCustomer);
					$("#btn-end-part").bind("click", fnObj.eventFunc.closePart);
					$("#btn-endAll-part").bind("click", fnObj.eventFunc.closeAllPart);
					$("#btn-info-binso").bind("click", fnObj.eventFunc.binsoInfo);
					$("#btn-new-stmt").bind("click", fnObj.eventFunc.regSaleStmt);
					$("#btn-cancel-each").bind("click", fnObj.eventFunc.cancelEach);
					$("#btn-bd-stmt").bind("click", fnObj.eventFunc.bdStmt);
                },
                eventFunc: {
                	selectBinso: function(el, binsoCode, customerNo){
//                 		if($(el).hasClass("not_assigned")){
//                 			return;
//                 		}
                		$(".binso_list .binso.on, .each_sale .binso.on").removeClass("on").addClass("off");
                		$(el).removeClass("off");
                		$(el).addClass("on");
                		fnObj.data.selectedBinso = binsoCode;
                		fnObj.data.selectedCustomerNo = customerNo;
                		$.each(fnObj.disabledGroup.all, function(i, o){
            				$("#"+o).removeAttr("disabled");
            			});
                		var target = binsoCode == fnObj.data.EACH_SALE_CODE ? "eachSale" : "binsoSale";

                		if(target == "binsoSale"){
                			if($(el).hasClass("not_assigned")){
                				target = "notAssignedBinsoSale";
                			}else{
                				target = fnObj.data.selectedPart == fnObj.data.PART_FUNERAL ? "partFuneral" : "assignedBinsoSale";
                			}
                		}
               			$.each(fnObj.disabledGroup[target], function(i, o){
               				$("#"+o).attr("disabled", "disabled");
               			});
                	}
                	, selectPart: function(el, partCode){
                		if($(el).hasClass("not_assigned")){
                			return;
                		}
                		$(".binso_list .part.on, .each_sale .part.on").removeClass("on").addClass("off");
                		$(el).removeClass("off");
                		$(el).addClass("on");
                		fnObj.data.selectedPart = partCode;
                	}
                	, newCustomer: function(){
                		var openWindow = window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=selectBinso&binsoCode="+fnObj.data.selectedBinso, "FUNE1030");
                		openWindow.focus();
                	}
                	, modifyCustomer: function(){
                		var openWindow = window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+fnObj.data.selectedCustomerNo, "FUNE1030");
                		openWindow.focus();
                	}
                	, regSaleStmt: function(){

                		app.ajax({
	                        type: "GET",
	                        url: "/FUNE1010/binso/part/isclose/"+fnObj.data.selectedCustomerNo+"/"+fnObj.data.selectedPart,
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		var m = fnObj.data.selectedBinso == "999" ? "searchSaleStmt" : "searchFuneral";
	                    		app.modal.open({
	                                url:"/jsp/funeralsystem/fune/fune1000/FUNE1012.jsp",
	                                pars:"callBack=&m="+m+"&customerNo="
            								+fnObj.data.selectedCustomerNo
            								+"&partCode="
            								+fnObj.data.selectedPart
            								+"&binsoCode="
            								+fnObj.data.selectedBinso, // callBack 말고
       								width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                                //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                            })
	                    	}
	                    });


                	}
					, closePart: function(){
						if(!confirm("선택한 파트를 마감처리하시겠습니까?")){
							return;
						}
						app.ajax({
	                        type: "PUT",
	                        url: "/FUNE1010/binso/part/close/"+fnObj.data.selectedCustomerNo+"/"+fnObj.data.selectedPart,
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		toast.push("선택한 파트의 마감이 완료되었습니다.");
	                    		fnObj.drawBinsoList();
	                    	}
	                    });
					}
					, closeAllPart: function(){
						if(!confirm("전체 파트를 마감처리하시겠습니까?")){
							return;
						}
						app.ajax({
	                        type: "PUT",
	                        url: "/FUNE1010/binso/part/close/"+fnObj.data.selectedCustomerNo+"/all",
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		toast.push("전체 파트의 마감이 완료되었습니다.");
	                    		fnObj.drawBinsoList();
	                    	}
	                    });
					}
                	, binsoInfo: function(){
                		app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune1000/FUNE1011.jsp",
                            pars:"callBack=&?m=searchFuneral&binsoCode="+fnObj.data.selectedBinso+"&customerNo="+fnObj.data.selectedCustomerNo, // callBack 말고
                            width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
                	, cancelEach: function(){
                		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1100.jsp?m=", "FUNE1100");
                	}
                	, bdStmt: function(){
                		var pgId = null;
                		var params = [];
                		params.push("partCode="+fnObj.data.selectedPart);
                		if(fnObj.data.EACH_SALE_CODE == fnObj.data.selectedBinso){
                			pgId = "FUNE1070";
                		}else{
                			pgId = "FUNE1060";
                			params.push("binsoCode="+fnObj.data.selectedBinso);
                			params.push("customerNo="+fnObj.data.selectedCustomerNo);
                		}
                		window.open("/jsp/funeralsystem/fune/fune1000/"+pgId+".jsp?"+params.join("&"), pgId);
                	}
                	, searchCustomer: function(){
                		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1040.jsp", "FUNE1040");
                	}
                }
            };
        </script>

    </ax:div>
</ax:layout>