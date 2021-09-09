<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE3011.jsp
 - 설      명	: 매입관리 > 매입 전표 등록 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.01  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "매입전표등록");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
    <ax:div name="header">

    </ax:div>
    <ax:div name="css">
    	<style type="text/css">
            .customer_title, .bill_no {
            	font-size: 20px;
            	font-weight: bolder;
            }
    	</style>
    </ax:div>
    <ax:div name="contents">

        <div class="ax-body">
            <div class="ax-wrap">
                <div class="ax-layer cx-content-layer">
                    <div class="ax-col-12 ax-content expand">
                        <!-- s.CXPage -->
                        <div id="CXPage" style="padding-top: 20px;">

                            <ax:row>
                                <ax:col >
                   					<ax:custom customid="table">
	                    				<ax:custom customid="tr">
			                        		<ax:custom customid="td" style="width: 580px;">
			                                    <div class="ax-button-group">
			                                        <div class="left">
			                                            <h1><i class="axi axi-web"></i> 매입전표등록</h1>
			                                        </div>
			                                        <div class="right">
														<b:button text="매입목록조회" id="btn-inquiryAllItem"></b:button>
														<b:button text="전체품목삭제" id="btn-removeAllItem"></b:button>
														<b:button text="선택품목삭제" id="btn-removeSelectedItem"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>

												<div id="div-buystmtbd-info" style="width: 70%;"></div>
												<div id="div-grid-buyStmtBd" style="min-height: 690px;"></div>
	    	    	                        </ax:custom>
			                        		<ax:custom customid="td" style="width:30%">
			                        			<div class="ax-button-group">
			                                        <div class="left">

			                                        </div>
			                                        <div class="right">
														<b:button text="전표저장" id="btn-save"></b:button>
														<b:button text="전표삭제" id="btn-deleteStmt"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
			                                    <div class="ax-search" id="page-search-box"></div>
			                                    <table style="width: 100%;">
													<colgroup>
														<col width="100">
														<col>
													</colgroup>
													<tr>
														<td>
															<div id="div-grid-itemGroup" style="min-height: 714px;"></div>
														</td>
														<td>
															<div id="div-grid-item" style="min-height: 714px;"></div>
														</td>
													</tr>
												</table>
	    	    	                        </ax:custom>
    	    	                        </ax:custom>
        	                        </ax:custom>

                                </ax:col>
                            </ax:row>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ax:div>
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">

        	var bfbuyStmt = [];

            var fnObj = {
            	CODES: {

            	},
            	CONSTANTS: {
            	},
            	data: {
            		  buyStmt 		: null
            		, buyStmtBd 	: null
            		, partCode 		: null
            		, custCode		: null
            		, etDate			: null
            		, billNo			: null
            		, totalAmount	: 0

            	},
            	condition: {
            		isAdd: function(){
            			return "${param.execute}" == "new";
            		}
            		, isMod: function(){
            			return "${param.execute}" == "mod";
            		}
            	},
                pageStart: function () {
					//받아온 param 세팅
                	this.data.partCode	= "${param.partCode}"
                	this.data.custCode	= "${param.custCode}"
                	this.data.etDate		= "${param.etDate}"
                	this.data.billNo		= "${param.billNo}"

               		app.modal.bind();
                    this.search.bind();
                    this.gridBuyStmtBd.bind();
                    this.gridItem.bind();
                    this.gridItemGroup.bind();
                    this.bindEvent();
                    this.defaultFn.excute();
                    this.gridItemGroup.setPage();
                },
                bindEvent: function () {
                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
                			$(o).bind("click", fn);
                		}
                	});
                    $("btn-inquiryAllItem").bind("click", fnObj.eventFn.inquiryAllItem);
                },
                eventFn: {
                	//2021.01.31 매입목록조회
                	inquiryAllItem: function(){
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune3000/FUNE3015.jsp",
                            pars:"callBack=fnObj.searchBuyListBdModalResult"
								+ "&partCode="+parent.pb_data.selectedCustomerPartCode+"&custCode=" + parent.pb_data.selectedCustomerCustCode
								+ "&etDate="+ parent.pb_data.selectedCustomerEtDate, // callBack 말고
							width: (window.innerWidth||900)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},	//2021.01.31 매입목록조회
                	save: function(){
                		if(fnObj.gridBuyStmtBd.target.list.length == 0){
                			alert("저장할 항목이 없습니다!")
                			fnObj.defaultFn.searchBuyStmtBd()
                			return;
                		}
                		// 클릭 후 바로 저장 클릭 시 값 변화 없음 ※※※※※※※※※※※※※※※※※※※※문제※※※※※※※※※※※※※※※※※※※※※※※
                		 var buyStmt = {
								buyStmtBdList	: fnObj.gridBuyStmtBd.target.list
							,	bfBuyStmtBd	: bfbuyStmt
                			,	partCode 		: fnObj.data.partCode
                			,	custCode 		: fnObj.data.custCode
                			,	etDate 			: fnObj.data.etDate
                			,   billNo				: fnObj.data.billNo
                			, 	count				: fnObj.gridBuyStmtBd.target.list.length
                			,   amount			: $("#div-buyStmtBd-totalAmount").html().number()
                    	}

                		app.ajax({
                            type: "POST",
                            url: "/FUNE3011/buyStmt",
                            data: Object.toJSON(buyStmt)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.data.billNo 		= res.map.buyStmt.billNo;
                        		fnObj.data.buyStmt 	= res.map.buyStmt;
                        		/* console.log("sava after**********************",fnObj.data.buyStmt) */

                        		bfbuyStmt = $.extend(true, [], fnObj.data.buyStmt.buyStmtBd);

                        		$("#div-buyStmtBd-billNo").html("#"+fnObj.data.billNo);

                        		// ▼▼▼▼▼▼▼▼▼▼▼부모창 그리드 변경 후 선택 좌측 로우 유지.
                        		parent.fnObj.search.submit();
                        		parent.fnObj.grid1.target.setFocus(parent.pb_data.grid1_selected);
                        		parent.fnObj.grid1.target.click(parent.pb_data.grid1_selected);
                        		var param = "${param.execute}";
                        		if(param === "mod"){
                        			// 수정화면이면 우측 그리드도 유지
                        			parent.fnObj.grid2.target.setFocus(parent.pb_data.grid2_selected);
                            		parent.fnObj.grid2.target.click(parent.pb_data.grid2_selected);
                        		}
                            }
                        });
                	}
                	, removeAllItem: function(){
                		fnObj.gridBuyStmtBd.target.setData({list:[]});
                		fnObj.gridBuyStmtBd.calc();
                	}
                	, removeSelectedItem: function(){

                		var checkedList = fnObj.gridBuyStmtBd.target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        fnObj.gridBuyStmtBd.target.removeListIndex(checkedList);
                		//Common.grid.removeSelectedItem(fnObj.gridBuyStmtBd.target);
                		fnObj.gridBuyStmtBd.calc();
                	}
                	, deleteStmt: function(){
                		if(fnObj.data.billNo == null){
                			return;
                		}
                		var confirmTxt = fnObj.data.etDate.date().print("yyyy년 mm월 dd일") + " #" +fnObj.data.billNo;
                		if(!confirm(confirmTxt + " 전표를 삭제 하시겠습니까?")){
							return;
						}
                		 var buyStmt = {
                 				partCode 		: fnObj.data.partCode
                 			,	custCode 		: fnObj.data.custCode
                 			,	etDate 			: fnObj.data.etDate
                 			,   billNo				: fnObj.data.billNo
                 			,	buyStmtBd		: bfbuyStmt
                     	}
                		 /* console.log("DELETE ",buyStmt); */

                		app.ajax({
                            type: "DELETE",
                            url: "/FUNE3011/buyStmt",
                            data: Object.toJSON(buyStmt)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								alert(fnObj.data.billNo + "번 전표가 삭제되었습니다.");
								parent.fnObj.search.submit();
								self.close();
                            }
                        });
                	}

                    //2021.02.09
                },searchBuyListBdModalResult : function(item){

                	$.each(item, function(i, o){
                		var buyStmtBdVal = {
                   			item: o.item
                   			, partCode	: fnObj.data.partCode
                   			, custCode	: fnObj.data.custCode
                   			, etDate		: fnObj.data.etDate
                   			, billNo		: fnObj.data.billNo
                   			, itemCode	: o.item.itemCode
                   			, defaultQty: o.item.itemPrice.last().defaultQty.number()
                   			//기준수량
                   			, qty			: o.qty
                   			//기준단가
                   			, price		: o.item.itemPrice.last().price
                   			//일반금액
                   			, amount		: o.item.itemPrice.last().price * o.qty
                   			//조정금액
                   			, samount	: 0
                   			//매입금액
                   			, tamount	: o.item.itemPrice.last().price
                   			, remark		: ""
                   		}

                		var idx = fnObj.gridBuyStmtBd.add(buyStmtBdVal);

                	});
                   	fnObj.gridBuyStmtBd.calc();


//                 	var gridData = {
//                             list: item,
//                         };
//                 	fnObj.gridBuyStmtBd.target.setData(gridData);
               		app.modal.close();
               	},
               //2021.02.09

                defaultFn: {
                	// 좌측상단 메인 정보 표기
                	 searchBuyStmtBd: function(){
                		app.ajax({
                            type: "GET",
                            url: "/FUNE3011/buyStmtBd?partCode="+ fnObj.data.partCode + "&custCode=" + fnObj.data.custCode+"&etDate="+fnObj.data.etDate+"&billNo="+fnObj.data.billNo,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		// 전표상세정보
                        		fnObj.data.buyStmtBd 	= $.extend({}, res.map.buyStmtBd);
                        		//console.log(fnObj.data.buyStmtBd);
                        		fnObj.draw.drawBuyStmtBdTop(res.map.buyStmtBd);
								fnObj.gridBuyStmtBd.target.setData({list:res.map.buyStmtBd.buyStmtBdList});

								bfbuyStmt = $.extend(true, [], fnObj.data.buyStmtBd.buyStmtBdList);
                        	}
                        });
                	}
                	, excute: function(){
                		//전화면에서 m 으로 실행할 함수를 전달해줌.
                		for(var key in this.fn){
                			this.fn[key]();
                		}
                		if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFn["${param.m}"]();
                	}
                	, fn: {
                		initButtons: function(){
                			if(fnObj.condition.isAdd()){
                				console.log("ADD")
                			}else if(fnObj.condition.isAdd()){
                				console.log("MOD")
                			}
                		}
                	}
                },
                template: {
                	keywords: [
                		"[custName]"
                		, "[etDate]"
                		, "[billNo]"
                		, "[totalCnt]"
                		, "[totalAmount]"
                	]
					, buyStmtDef: "<table class='AXFormTable'>"+
					            		"<tr>"+
						        			"<th rowspan='2'><div class='tdRel customer_title'>[custName]</div>"+
						        			"</th>"+
						        			"<th><div class='tdRel'>매입일자</div>"+
						        			"</th>"+
						        			"<td colspan='2' align='center'><div id='div-buyStmtBd-etDate' class='tdRel'>[etDate]</div>"+
						        			"</td>"+
						        			"<td rowspan='2' align='center'><div id='div-buyStmtBd-billNo' class='tdRel bill_no'>[billNo]</div>"+
						        			"</td>"+
						        		"</tr>"+
					            		"<tr>"+
						        			"<th><div class='tdRel'>매입금액</div>"+
						        			"</th>"+
						        			"<td align='right'><div id='div-buyStmtBd-totalCnt' class='tdRel'>[totalCnt]</div>"+
						        			"</td>"+
						        			"<td align='right'><div id='div-buyStmtBd-totalAmount' class='tdRel'>[totalAmount]</div>"+
						        			"</td>"+
						        		"</tr>"+
					        		"</table>"
	        		, deleteKeywords: function(str){
	        			return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
                },
                draw: {
                	//좌측 상단 내용 채우기
                	drawBuyStmtBdTop: function(BuyStmtBd){
                		var customer 	= BuyStmtBd.customer;
                		var html 		= fnObj.template.buyStmtDef;
						html 				= html.replace("[custName]", customer.custName);
						html 				= html.replace("[etDate]",BuyStmtBd.etDate.date().print("yyyy년 mm월 dd일"));
						if(BuyStmtBd.billNo !== undefined){
							html = html.replace("[billNo]", "#" + BuyStmtBd.billNo);
						}
						// 매입금액 합 구하기
						var tamount = 0;
                		$.each(BuyStmtBd.buyStmtBdList, function(i,o){
                			tamount += o.tamount;
                		});
                		fnObj.data.totalAmount = tamount;

						html = html.replace("[totalCnt]", BuyStmtBd.buyStmtBdList.length);
						html = html.replace("[totalAmount]", tamount.money());
						html = fnObj.template.deleteKeywords(html);
						$("#div-buystmtbd-info").html(html);
                	}
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"button", width:"50", key:"ensType", addClass:"", valueBoxStyle:"", value:"조회",
               							onclick: function(){
               								fnObj.search.submit();
               							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	var pars = fnObj.search.target.getParam();
                    	fnObj.gridItem.setPage(pars);
                    }
                },

                gridBuyStmtBd: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-buyStmtBd",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                {key:"index", label:"", width:"30", align:"center", formatter: "checkbox"},
                                {key:"idx", label:"순번", width:"40", align:"center", formatter: function(){
                                	return this.index+1;
                                }},
                                {key:"itemName", label:"품 목 명", width:"180", align:"left", formatter: function(){
	                                	if(this.item.item){
		                               		return this.item.item.itemName;
	                                	}else{
	                                		return "";
	                                	}
                                	}
                                },
                                {key:"defaultQty", label:"기준수량", width:"50", align:"right", display:false},
                                {key:"qty", label:"수량", width:"80", align:"right", formatter: "number", editor:{
                                    type:"number",
                                    "range": { // 숫자일 경우 숫자자릿수와 소수점 자릿수 지정
                                        "val": "9,1"
                                        ,msg : '' // 자릿수를 초과 했을대 보여줄 메시지.
                                    },
                                    maxLength: 50,
                                    beforeUpdate: function(val){
                                    	return isNaN(Number(val)) ? 0 : val;
                                    },
                                    afterUpdate: function(){
                                    	// 금액은 조정금액 계산 외에 일단 저장
                                    	this.item.amount 		= +(this.item.qty / this.item.defaultQty)*(this.item.price);
                                    	// 매입금액은 입력 수량 / 기준수량 * 기준단가
                                    	this.item.tamount 	= +(this.item.qty / this.item.defaultQty)*(this.item.price)+this.item.samount;

                                    	fnObj.gridBuyStmtBd.target.updateList(this.index, this.item);

                                    	fnObj.gridBuyStmtBd.calc();

                                    	setTimeout(function(){
											Common.search.focus(fnObj.search.target, "itemName");
										}, 100);
                                    }
                                }},
                                {key:"price", label:"단 가", width:"100", align:"right", display:false},
                                //위 price 가 기준단가. qty와 price 계산한 금액을 일단 amount에도 저장.
                                {key:"amount", label:"금    액", width:"100", align:"right", formatter: "money"},
                                {key:"samount", label:"조정금액", width:"100", align:"right", formatter: "money", editor:{
                                    type:"number",
                                    maxLength: 50,
                                    beforeUpdate: function(val){
                                    	return val;
                                    },
                                    afterUpdate: function(){
										// 매입금액은 금액 + 조정금액
                                        this.item.tamount = +this.item.amount+(+this.item.samount);
                                    	fnObj.gridBuyStmtBd.target.updateList(this.index, this.item);

                                    	fnObj.gridBuyStmtBd.calc();
                                    }
                                }},
                                {key:"tamount", label:"매입금액", width:"100", align:"right", formatter: "money"},
                                {key:"remark", label:"메모", width:"160", align:"center", editor:{
                                    type:"text",
                                    maxLength: 50
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
                    add: function(buyStmtBdVal){
                    	var idx = -1;
                		for(var i=0; i<this.target.list.length; i++){
                			if(this.target.list[i].partCode == buyStmtBdVal.partCode
	                			&& this.target.list[i].itemCode == buyStmtBdVal.itemCode
	                			&& this.target.list[i].custCode == buyStmtBdVal.custCode
	                			&& this.target.list[i].etDate == buyStmtBdVal.etDate
	                			){
                				idx = i;
                				this.target.list[i].qty = Number((this.target.list[i].qty||0)) + Number((buyStmtBdVal.qty||0));
                				this.target.list[i].amount = (this.target.list[i].amount||0)+(buyStmtBdVal.amount||0);
                				this.target.list[i].tamount = (this.target.list[i].tamount||0)+(buyStmtBdVal.tamount||0);
                				this.target.setData({list: this.target.list});
                			}
                		}
                		if(idx == -1){
	                    	this.target.pushList(buyStmtBdVal);
	                    	return this.target.list.length-1;
                		}else{
                			return idx;
                		}
                    },
                    setPage: function(pageNo, searchParams){
                    },
                    calc: function(){
                    	var cnt = this.target.list.length;
                    	var tamount = 0;
                   		$.each(this.target.list, function(i, o){
                   			tamount+= +o.tamount;
                    	});
                   		$("#div-buyStmtBd-totalCnt").html(cnt);

                   		var totalAmount = fnObj.data.totalAmount;

                   		//if(fnObj.data.billNo == null){
                   			totalAmount = tamount;
                   		//}
                   		$("#div-buyStmtBd-totalAmount").html(totalAmount.money());
                    }
                },
                //우측 품목 그리드
                gridItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                {key:"i", label:" ", width:"30", align:"center", formatter: function(){return this.index+1;}},
                                {key:"itemCode", label:"코드", width:"50", align:"center", display:false},
                                {key:"itemName", label:"품목명", width:"140", align:"left"},
                                {key:"unit", label:"단위", width:"50", align:"left"},
                                {key:"defaultQty", label:"기준수량", width:"60", align:"center", formatter: function(){
                                	return this.item.itemPrice.last().defaultQty.number();
                                }},
                                {key:"price", label:"기준단가", width:"80", align:"right", formatter: function(){
                                	return this.item.itemPrice.last().price.money();
                                }},
                            ],
                            body : {
                                onclick: function(){
                                	var buyStmtBdVal = {
                                			item: this.item
                                			, partCode	: fnObj.data.partCode
                                			, custCode	: fnObj.data.custCode
                                			, etDate		: fnObj.data.etDate
                                			, billNo		: fnObj.data.billNo
                                			, itemCode	: this.item.itemCode
                                			, defaultQty: this.item.itemPrice.last().defaultQty.number()
                                			//기준수량
                                			, qty			: this.item.itemPrice.last().defaultQty.number()
                                			//기준단가
                                			, price		: this.item.itemPrice.last().price
                                			//일반금액
                                			, amount		: this.item.itemPrice.last().price
                                			//조정금액
                                			, samount	: 0
                                			//매입금액
                                			, tamount	: this.item.itemPrice.last().price
                                			, remark		: ""
                                	}

                                	setTimeout(function(){
	                                	// 금액은 조정금액 계산 외에 일단 저장
//                                     	 buyStmtBdVal.amount = +(buyStmtBdVal.qty / buyStmtBdVal.defaultQty)*(buyStmtBdVal.price);
//                                     	// 매입금액은 입력 수량 / 기준수량 * 기준단가
//                                     	buyStmtBdVal.tamount 	= +(buyStmtBdVal.qty / buyStmtBdVal.defaultQty)*(buyStmtBdVal.price)+buyStmtBdVal.samount;

                                    	var idx = fnObj.gridBuyStmtBd.add(buyStmtBdVal);

                                    	console.log("우측 클릭===22====",bfbuyStmt)

                                    	fnObj.gridBuyStmtBd.calc();

	                                	Common.grid.revitalizeInlineEditor(fnObj.gridBuyStmtBd.target, idx, 4);
                                	}, 100);
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
                    setPage: function(searchParams){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE3011/buy/item?partCode=${param.partCode}&custCode=${param.custCode}&groupCode="+fnObj.gridItemGroup.target.getSelectedItem().item.groupCode+"&"+searchParams,
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
                gridItemGroup: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function(){
						var target = this.target, _this = this;
						target.setConfig({
							targetID : "div-grid-itemGroup",
							theme : "AXGrid",
							colHeadAlign:"center",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup : [
								{key:"groupName", label:"품목그룹", width:"100", align:"left"},
							],
							body : {
								onclick: function(){
									fnObj.search.submit();
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
					setPage: function(searchParams){

						app.ajax({
							type: "GET",
							url: "/FUNE3011/buy/itemGroup",
							data: "partCode=${param.partCode}&custCode=${param.custCode}"
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{

								if(res.list.length == 0){
		                            alert("해당 거래처는 취급 품목이 없습니다.");
		                            return;
		                        }
								fnObj.gridItemGroup.target.setData({list: res.list});
								fnObj.gridItemGroup.target.setFocus(0);
								fnObj.search.submit();
							}
						});
					}
				},

            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
            //새로고침 F5 키 detect
            $(document.body).on("keydown", this, function (event) {
                if (event.keyCode == 116 && fnObj.data.billNo  !==  null && fnObj.data.billNo  !==  "") {
                    var url = window.location.href;
		         	var separator = (url.indexOf('?') > -1) ? "&" : "?";
		         	var qs = "billNo=" + encodeURIComponent(fnObj.data.billNo);
		         	var str_url;
		         	if((url.indexOf('billNo') > -1)){
		         		str_url = url;
		         	}else{
		         		str_url = url + separator + qs;
		         	}
		         	window.location.href = str_url;
                }
            });
        </script>
    </ax:div>
</ax:layout>