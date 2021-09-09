<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
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
            .binso.assigned table td{
            	color: black;
            	background-color: white;
            }
            .binso.not_assigned table td{
            	color: gray;
            	background-color: lightgray;
            }
            .binso.assigned{
            	opacity: 0.7;
            }
            .binso.not_assigned{
            	opacity: 0.2;
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
	                        	<b:button  text="파트일괄마감" id="btn-closeAllPart"></b:button>
	                        	<b:button  text="정산마감관리" id="btn-closeMng"></b:button>
	                        	<b:button  text="장례비용집계" id="btn-calculateFuneral"></b:button>
	                        	<b:button  text="장례비용내역" id="btn-costFuneral"></b:button>
	                        	<b:button  text="수납처리" id="btn-receipt"></b:button>
	                        	<b:button  text="빈소퇴실처리" id="btn-outBinso"></b:button>
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
                			"<div style='width: 230px; display: inline-block;' class='binso off [assigned]' onclick='fnObj.eventFn.selectBinso(this, \"[binsoCode]\", \"[binsoName]\", \"[customerNo]\")'>"+
				               	"<table class='AXFormTable'>"+
				               		"<colgroup>"+
				               			"<col/>"+
				               			"<col width=50/>"+
				               			"<col/>"+
				               		"</colgroup>"+
				            		"<tr>"+
				            			"<th rowspan='2'><div class='tdRel binso_title'>[binsoName]</div>"+
				            			"</th>"+
				            			"<td colspan='2'><div class='tdRel'>[deadName]</div>"+
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
							"<tr onclick='fnObj.eventFn.selectPart(this, \"[part]\")' class='part off [assigned]'>"+
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
                	, selectedBinso: ""
                	, selectedPart: ""
                	, selectedCustomer: ""
                },
                drawBinsoList: function() {

                	app.ajax({
                        type: "GET",
                        url: "/FUNE5010/binso/part",
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{

                    		var binsoList = [];

                            $.each(res.list, function(i, o){
                            	var part = [];
                            	$.each(o.binsoInfo, function(i2, o2){
                            		var partItem = fnObj.template.binsoPart.replace("[part]", o2.part);
                            		partItem = partItem.replace("[partName]", o2.partName);
                            		partItem = partItem.replace("[cnt]", o2.cnt);
                            		partItem = partItem.replace("[amount]", o2.amount);

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
                            	binso = binso.replace("[binsoName]", o.displayBinso);
                            	binso = binso.replace("[binsoCode]", o.binsoCode);

                            	if(o.funeral){
	                            	binso = binso.replace("[customerNo]", o.funeral.customerNo);
	                            	binso = binso.replace("[deadName]", o.funeral.thedead.deadName);
                            	}
                            	if(o.binsoAssign){
                            		binso = binso.replace("[assigned]", "assigned");
                            		binso = binso.replace("[stDateTime]", o.binsoAssign.stDateTime.date().print("mm월dd일"));
	                            	binso = binso.replace("[edDateTime]", o.binsoAssign.edDateTime.date().print("mm월dd일"));
                            	}else{
	                            	if(fnObj.data.EACH_SALE_CODE == o.binsoCode){
	                            		binso = binso.replace("[assigned]", "assigned");
	                            	}else{
	                            		binso = binso.replace("[assigned]", "not_assigned");
	                            	}
                            	}

                            	binso = binso.replace("[partlist]", part.join(""));


                            	binso = fnObj.template.deleteKeywords(binso);
								if(fnObj.data.EACH_SALE_CODE != o.binsoCode){
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
                            $(".money").number(true, 0);
                        }
                    });
                },
                bindEvent: function(){
                	$("#ax-page-btn-search").attr("id", "btn-drawBinso");

                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});
                },
                eventFn: {
                	drawBinso: function(){
                		fnObj.drawBinsoList();
                	}
                	, selectBinso: function(el, binsoCode, binsoName, customerNo){
                		if($(el).hasClass("not_assigned")){
                			return;
                		}
                		$(".binso_list .binso.on, .each_sale .binso.on").removeClass("on").addClass("off");
                		$(el).removeClass("off");
                		$(el).addClass("on");
                		fnObj.data.selectedBinso = binsoCode;
                		fnObj.data.selectedBinsoName = binsoName;
                		fnObj.data.selectedCustomerNo = customerNo;
                	}
                	, selectPart: function(el, partCode){
//                 		if($(el).hasClass("not_assigned")){
//                 			return;
//                 		}
//                 		$(".binso_list .part.on, .each_sale .part.on").removeClass("on").addClass("off");
//                 		$(el).removeClass("off");
//                 		$(el).addClass("on");
//                 		fnObj.data.selectedPart = partCode;
                	}
                	, newCustomer: function(){
                		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=selectBinso&binsoCode="+fnObj.data.selectedBinso);
                	}
                	, modifyCustomer: function(){
                		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+fnObj.data.selectedCustomerNo);
                	}
                	, closeAllPart: function(){
                		if(!fnObj.data.selectedCustomerNo || fnObj.data.selectedCustomerNo == null){
                			alert("빈소를 선택해 주세요.");
                			return;
                		}
						if(!confirm("선택한 빈소의 전체 파트를 마감처리하시겠습니까?")){
							return;
						}
						app.ajax({
	                        type: "PUT",
	                        url: "/FUNE5010/binso/close/"+fnObj.data.selectedCustomerNo,
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		toast.push("선택한 빈소의 전체 파트 마감이 완료되었습니다.");
	                    		fnObj.drawBinsoList();
	                    	}
	                    });
					}
                	, closeMng: function(){
                		app.modal.open({
                            url:"FUNE5011.jsp",
                            pars:"callBack=&customerNo="+fnObj.data.selectedCustomerNo, // callBack 말고
                            //width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
                	, receipt: function(){
                		if(!fnObj.data.selectedBinso || fnObj.data.selectedBinso == null){
                			alert("빈소를 선택해 주세요");
                			return;
                		}
                		app.ajax({
	                        type: "GET",
	                        url: "/FUNE5010/isClose",
	                        data: "customerNo="+fnObj.data.selectedCustomerNo
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{

	                    		if(res.map.isClose === true){

		                    		app.modal.open({
		                                url:"FUNE5012.jsp",
		                                pars:"callBack=&customerNo="+fnObj.data.selectedCustomerNo+"&binsoName="+fnObj.data.selectedBinsoName, // callBack 말고
		                                //width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
		                                //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
		                            })
	                    		}else{
	                    			alert("아직 마감되지 않은 파트가 존재합니다.");
	                    		}
	                    	}
	                    });

                	}
                	, outBinso: function(){
                		app.ajax({
	                        type: "POST",
	                        url: "/FUNE5010/binso/out/"+fnObj.data.selectedCustomerNo+"/"+fnObj.data.selectedBinso,
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		toast.push("퇴실처리되었습니다.");
	                    		fnObj.drawBinsoList();
	                    	}
	                    });

                	}
                	, calculateFuneral: function(){
                		if(fnObj.data.selectedCustomerNo == null){
                			return;
                		}
                		window.open("/jsp/funeralsystem/fune/fune5000/FUNE5040.jsp?customerNo="+fnObj.data.selectedCustomerNo, "FUNE5040");
                	}
                	, costFuneral: function(){
                		if(fnObj.data.selectedCustomerNo == null){
                			return;
                		}
                		window.open("/jsp/funeralsystem/fune/fune5000/FUNE5050.jsp?customerNo="+fnObj.data.selectedCustomerNo, "FUNE5050");
                	}
                }
            };
        </script>

    </ax:div>
</ax:layout>