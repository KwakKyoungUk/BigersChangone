<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
    	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/bigers/AXJ.min.new.css"/>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> ${PAGE_NAME}</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-grid" style="min-height: 500px;"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
        <script type="text/javascript">
            var resize_elements = [
            	{id: "div-grid", adjust: -97}
            ];
            var fnObj = {
                CODES: {
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	fnObj.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
						Common.report.gridToExcel("FUNE8160", fnObj.grid.target);
                    });
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
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
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){

               									}
               								}
               							}
               						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	fnObj.grid.setPage();
                    }
                },
                grid: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            fixedColSeq: 0,
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                             height: "auto",
                             colHead : {
//              	                heights: [40,30],
                                 rows: [
                                     [
                                         {colSeq: 0, key:"inDate", rowspan: 4, valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 2, label:"계", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:6, rowspan: 1, label:"빈소료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:18, rowspan: 1, label:"안치료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:16, rowspan: 1, label:"기타", align:"center", valign:"middle"}
                                     ],
                                     [
                                         {colSeq: null, colspan:2, rowspan: 1, label:"소계", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:4, rowspan: 1, label:"빈소료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"소계", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:4, rowspan: 1, label:"안치실사용료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:4, rowspan: 1, label:"염습료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:4, rowspan: 1, label:"염습실사용료", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"시신메이크업", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"통합처리비", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"장례용품", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"납골함", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"매점", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"자판기(식권)", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"자판기(커피)", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"화원", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"식당", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"제수실", align:"center", valign:"middle"}
                                     ],
                                     [
                                         {colSeq: 1, key:"cnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 2, key:"amount", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 3, key:"binsoCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 4, key:"binsoAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관내", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관외", align:"center", valign:"middle"},
                                         {colSeq: 9, key:"anchiCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 10, key:"anchiAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관내", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관외", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관내", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관외", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관내", align:"center", valign:"middle"},
                                         {colSeq: null, colspan:2, rowspan: 1, label:"관외", align:"center", valign:"middle"},
                                         {colSeq: 23, key:"makeupCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 24, key:"makeupAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 25, key:"tonghabCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 26, key:"tonghabAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 27, key:"funeralItemCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 28, key:"funeralItemAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 29, key:"enshHamCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 30, key:"enshHamAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 31, key:"storeCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 32, key:"storeAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 33, key:"mealTicketCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 34, key:"mealTicketAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 35, key:"coffeeCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 36, key:"coffeeAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 37, key:"flowerCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 38, key:"flowerAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 39, key:"cafeteriaCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 40, key:"cafeteriaAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 41, key:"ancestralCnt", colspan:1, rowspan: 2, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 42, key:"ancestralAmt", colspan:1, rowspan: 2, label:"금액", align:"center", valign:"middle"}
                                     ],
                                     [
                                         {colSeq: 5, key:"binsoGwannaeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 6, key:"binsoGwannaeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 7, key:"binsoGwanwoeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 8, key:"binsoGwanwoeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 11, key:"anchiUseGwannaeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 12, key:"anchiUseGwannaeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 13, key:"anchiUseGwanwoeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 14, key:"anchiUseGwanwoeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 15, key:"yeomGwannaeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 16, key:"yeomGwannaeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 17, key:"yeomGwanwoeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 18, key:"yeomGwanwoeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 19, key:"yeomRoomGwannaeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 20, key:"yeomRoomGwannaeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"},
                                         {colSeq: 21, key:"yeomRoomGwanwoeCnt", colspan:1, rowspan: 1, label:"건수", align:"center", valign:"middle"},
                                         {colSeq: 22, key:"yeomRoomGwanwoeAmt", colspan:1, rowspan: 1, label:"금액", align:"center", valign:"middle"}
                                     ]
                                 ]
                             },
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"inDate", label:"일자", width:"100", align:"center"},
                                {key:"cnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"amount", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"binsoCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"binsoAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"binsoGwannaeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"binsoGwannaeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"binsoGwanwoeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"binsoGwanwoeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"anchiCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"anchiAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"anchiUseGwannaeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"anchiUseGwannaeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"anchiUseGwanwoeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"anchiUseGwanwoeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"yeomGwannaeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"yeomGwannaeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"yeomGwanwoeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"yeomGwanwoeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"yeomRoomGwannaeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"yeomRoomGwannaeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"yeomRoomGwanwoeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"yeomRoomGwanwoeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"makeupCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"makeupAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"tonghabCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"tonghabAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"funeralItemCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"funeralItemAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"enshHamCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"enshHamAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"storeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"storeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"mealTicketCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"mealTicketAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"coffeeCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"coffeeAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"flowerCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"flowerAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"cafeteriaCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"cafeteriaAmt", label:"금액", width:"100", align:"right", formatter: "money"},
                                {key:"ancestralCnt", label:"건수", width:"50", align:"right", formatter: "money"},
                                {key:"ancestralAmt", label:"금액", width:"100", align:"right", formatter: "money"}
                            ],
                            body : {
                            	marker: function () {

                                },
                                onclick: function(){
//                                 	var openwindow = window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+this.item.customerNo, "FUNE1030");
//                                 	openwindow.focus();
                                }
                            },
                            foot: {
                                rows: [
									[
                                        {
                                            colspan: 1, formatter: function () {
                                            	return "계";
                                        	}, align: "center", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.cnt||0;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.amount||0;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoGwannaeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoGwannaeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoGwanwoeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.binsoGwanwoeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiUseGwannaeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiUseGwannaeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiUseGwanwoeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.anchiUseGwanwoeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomGwannaeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomGwannaeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomGwanwoeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomGwanwoeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomRoomGwannaeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomRoomGwannaeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomRoomGwanwoeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.yeomRoomGwanwoeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.makeupCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.makeupAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.tonghabCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.tonghabAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.funeralItemCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.funeralItemAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.enshHamCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.enshHamAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.storeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.storeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.mealTicketCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.mealTicketAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.coffeeCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.coffeeAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.flowerCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.flowerAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.cafeteriaCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.cafeteriaAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.ancestralCnt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
                                        {
                                            formatter: function () {
                                            	var sum = 0;
	                                            $.each(this.list, function () {
	                                                sum += this.ancestralAmt;
	                                            });
	                                            return sum.money();
	                                        }, align: "right", valign: "middle"
                                        },
									]
                                ]
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
                    	var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/FUNE8160/deposit",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var gridData = {
                                     list: res.list,
                                     page:{
                                         pageNo: res.page.currentPage.number()+1,
                                         pageSize: res.page.pageSize,
                                         pageCount: res.page.totalPages,
                                         listCount: res.page.totalElements
                                     }
                                 };
                                 _target.setData(gridData);
                                 _target.setDataSet({});
                             }
                         });
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>