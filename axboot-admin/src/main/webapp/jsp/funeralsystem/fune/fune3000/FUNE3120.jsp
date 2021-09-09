<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-grid-stock"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            	{id:"div-grid-stock", adjust:-97}
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
                    })
                    $("#ax-page-btn-excel").bind("click", function(){
						Common.report.gridToExcel("재고", fnObj.grid.target);
                    })
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        var _target = this.target;
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
                            		{label:"파트", labelWidth:"100", type:"selectBox", width:"120", key:"partCode", addClass:"", valueBoxStyle:"", value:"", options:[],
            							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "partCode",
                                                    optionText: "partName"
                                                },
                                                isspace: true,
                                                isspaceTitle: "전체",
            									ajaxUrl:"/FUNE3120/part",
            									ajaxPars:null,
            									setValue:"",
            									alwaysOnChange: true,
            									onChange:function(){
            									}
            								}
            							}
            						},
                                	{label:"조회년월", labelWidth:"", type:"inputText", width:"", key:"jobYm", addClass:"", valueBoxStyle:"", value:new Date().print("yyyy-mm"),
               							AXBind:{
               								type:"date", config:{
               									align:"right", valign:"top", selectType:"m",
               									onChange:function(){
               										//toast.push(Object.toJSON(this));
               									}
               								}
               							}
               						},
            						{label:"", labelWidth:"", type:"button", width:"100", key:"button", addClass:"", valueBoxStyle:"", value:"재고월마감",
            							onclick: function(){
            								app.ajax({
           		                             type: "POST",
           		                             url: "/FUNE3120/arrangeStock?"+fnObj.search.target.getParam(),
           		                             data: ""
           		                         }, function(res){
           		                             if(res.error){
           		                                alert(res.error.message);
           		                             }
           		                             else
           		                             {
           		                                 fnObj.search.submit();
           		                             }
           		                         });
            							}
            						},
            						{label:"", labelWidth:"", type:"button", width:"100", key:"button", addClass:"", valueBoxStyle:"", value:"이월",
            							onclick: function(){
            								app.ajax({
            		                             type: "POST",
            		                             url: "/FUNE3120/stock/sendNextMonth?"+fnObj.search.target.getParam(),
            		                             data: ""
            		                         }, function(res){
            		                             if(res.error){
            		                                alert(res.error.message);
            		                             }
            		                             else
            		                             {
            		                                 Common.search.setValue(fnObj.search.target, "jobYm", res.map.nextYm);
            		                                 fnObj.search.submit();
            		                             }
            		                         });
            							}
            						}
                            	]},
                            ]
                        });
                    },
                    submit: function(){
                    	fnObj.grid.setPage();
                    }
                },
                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-stock",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"partCode", label:"파트코드", width:"35", align:"center", display: false},
                                {key:"itemCode", label:"품목코드", width:"80", align:"left"},
                                {key:"itemName", label:"품목명", width:"250", align:"left"},
                                {key:"groupName", label:"품목분류", width:"100", align:"center"},
                                {key:"unit", label:"단위", width:"80", align:"center"},
                                {key:"preQty", label:"전월이월수량", width:"120", align:"right"},
                                {key:"preAmount", label:"전월이월금액", width:"120", align:"right", formatter: "money"},
                                {key:"inQty", label:"입고수량", width:"120", align:"right"},
                                {key:"inAmount", label:"입고금액", width:"120", align:"right", formatter: "money"},
                                {key:"outQty", label:"출고수량", width:"120", align:"right"},
                                {key:"outAmount", label:"출고금액", width:"120", align:"right", formatter: "money"},
                                {key:"adjQty", label:"조정수량", width:"120", align:"right"},
                                {key:"adjAmount", label:"조정금액", width:"120", align:"right", formatter: "money"},
                                {key:"qty", label:"재고수량", width:"120", align:"right"},
                                {key:"amount", label:"재고금액", width:"120", align:"right", formatter: "money"},
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/FUNE3120/stock",
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
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>