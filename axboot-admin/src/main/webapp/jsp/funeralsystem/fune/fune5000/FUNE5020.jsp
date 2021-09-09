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
                        	<ax:form name="form-search" id="form-search">
                        		<ax:fields>
                        			<ax:field label="고인명">
                        				<b:input id="deadName" name="deadName" title="고인명"></b:input>
                        			</ax:field>
                        			<ax:field label="발인일자">
                        				<b:inputDate id="balinDate" name="balinDate" title="발인일자"></b:inputDate>
                        			</ax:field>
                        		</ax:fields>
                        	</ax:form>
                        	<div id="div-grid"></div>
                        	<div style="display:none;">
		                        <div id="div-modalContent" style="padding:20px;">
		                            <select id="slt-partCode" class="AXSelect"></select>
		                            <input id="btn-saleGo" type="button" value="선택" class="AXButton" onclick="fnObj.eventFn.saleGo()"/>
		                        </div>
	                        </div>
						</ax:custom>
                        <ax:custom customid="td" style="width:150px;" >

                        	<div class="button_group vertical fixed">
	                        	<b:button  text="고객조회" id="btn-search"></b:button>
	                        	<b:button  text="고객정보수정" id="btn-modify"></b:button>
	                        	<b:button  text="빈소퇴실취소" id="btn-inBinso"></b:button>
	                        	<b:button  text="빈소판매조정" id="btn-sale"></b:button>
	                        	<b:button  text="수납처리" id="btn-receipt"></b:button>
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
                	deadSex: Common.getCode("TCM05"),
                },
                pageStart: function(){
					this.bindEvent();
					this.search.bind();
					this.grid.bind();
					this.defaultFn.excute();
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
                	$("#slt-partCode").selectBox({
	                	url: "/FUNE5020/part"
	                });
                },
                eventFn: {
                	receipt: function(){
                		app.modal.open({
                            url:"FUNE5012.jsp",
                            pars:"callBack=&customerNo="+fnObj.data.selectedCustomerNo, // callBack 말고
                            //width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
                	, inBinso: function(){
                		var item = fnObj.grid.target.getSelectedItem().item;
						if(!item){
							alert("고인을 선택해 주세요.");
							return;
						}
                		app.ajax({
	                        type: "POST",
	                        url: "/FUNE5020/binso/in/"+item.customerNo+"/"+item.binsoCode,
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		toast.push("퇴실취소처리 되었습니다.");
	                    		fnObj.search.submit();
	                    	}
	                    });

                	}
                	, search: function(){
                		app.ajax({
	                        type: "GET",
	                        url: "/FUNE5020/funeral",
	                        data: fnObj.search.target.getParam()
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		fnObj.grid.target.setData({list: res});
	                    	}
	                    });
                	}
                	, modify: function(){
                		var customerNo = fnObj.grid.target.getSelectedItem().item.customerNo;
                		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+customerNo, "FUNE1030");
                	}
                	, sale: function(){
                		var item = fnObj.grid.target.getSelectedItem().item;
                		if(!item){
                			alert("고인을 선택해 주세요");
                			return;
                		}

                		myModal.openDiv({
                            modalID: "modalDiv01",
                            targetID: "div-modalContent",
                            width: 300,
                            top: 100
                        });


                	}
                	, saleGo: function(){
                		var item = fnObj.grid.target.getSelectedItem().item;
                   		window.open("/jsp/funeralsystem/fune/fune1000/FUNE1012.jsp?m=searchFuneral&customerNo="
                   								+item.customerNo
                   								+"&partCode="
                   								+$("#slt-partCode").val()
                   								+"&binsoCode="
                   								+item.binsoCode
                   								, "FUNE1012");
                		myModal.close('modalDiv01');
                	}
                	, receipt: function(){
                		var item = fnObj.grid.target.getSelectedItem().item;
                		if(!item){
                			alert("고인을 선택해 주세요");
                			return;
                		}
                		app.modal.open({
                            url:"FUNE5012.jsp",
                            pars:"callBack=&customerNo="+item.customerNo, // callBack 말고
                            //width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
                },
                defaultFn:{
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
	            		init: function(){
	            			$("#balinDate").val(new Date().print());
	            		}
	            	}
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"form-search",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                        });
                    },
                    submit: function(){
                        fnObj.eventFn.search();
                    }
                },
                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"customerNo", label:"고객번호", width:"150", align:"center"},
                                {key:"xxx", label:"빈소", width:"100", align:"center", formatter: function(){
                                	return this.item.binso.binsoName;
                                }},
                                {key:"xxx", label:"고인명", width:"100", align:"center", formatter: function(){
                                	return this.item.thedead.deadName;
                                }},
                                {key:"xxx", label:"성별", width:"50", align:"center", formatter: function(){
                                	if(this.item.thedead.deadSex){
	                                	return Common.grid.codeFormatter("deadSex", this.item.thedead.deadSex);
                                	}
                                	return "";
                                }},
                                {key:"xxx", label:"생년월일", width:"100", align:"center", formatter: function(){
                                	return this.item.thedead.deadBirth;
                                }},
                                {key:"balinDate", label:"발인일시", width:"150", align:"center"},
                                {key:"jangji", label:"장지", width:"150", align:"center"},
                                {key:"xxx", label:"카드정산", width:"100", align:"right", formatter: function(){
                                	var res = 0;
                                	if(!this.item.payment){
                                		return res;
                                	}
                                	$.each(this.item.payment, function(i, o){
                                		res+=o.cardAmt;
                                	});
                                	return res.money();
                                }},
                                {key:"xxx", label:"현금정산", width:"100", align:"right", formatter: function(){
                                	var res = 0;
                                	if(!this.item.payment){
                                		return res;
                                	}
                                	$.each(this.item.payment, function(i, o){
                                		res+=o.cashAmt;
                                	});
                                	return res.money();
                                }},
                                {key:"xxx", label:"감면금액", width:"100", align:"right", formatter: function(){
                                	var res = 0;
                                	if(!this.item.payment){
                                		return res;
                                	}
                                	$.each(this.item.payment, function(i, o){
                                		res+=o.dcAmt;
                                	});
                                	return res.money();
                                }},
                                {key:"xxx", label:"합계금액", width:"100", align:"right", formatter: function(){
                                	var res = 0;
                                	if(!this.item.payment){
                                		return res;
                                	}
                                	$.each(this.item.payment, function(i, o){
                                		res+=o.totAmt;
                                	});
                                	return res.money();
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
                    },
                },
            };
        </script>

    </ax:div>
</ax:layout>