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
                <iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                       // _this.search.submit();
						var params = [];

						params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");

                        //Common.report.open("/reports/crem/CREM2030", "pdf", params.join("&"));
                		 Common.report.embedded("/reports/crem/${PAGE_ID}", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];

                    	params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");

                        Common.report.go("/reports/crem/CREM2030", "excel", params.join("&"));
                    });
                    $(document.body).bind("mouseover", function(event){
                    	pageX = event.pageX;
                    	pageY = event.pageY;
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

               						{label:"화장일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },
                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"id", label:"화장번호", width:"100", align:"center"},
                                {key:"cremDateString", label:"화장일자", width:"100", align:"center"
	                                	, formatter:function(){
	                                    return this.value.date().print("yyyy-mm-dd");
                                	}
                                },
                                {key:"deadName", label:"이름", width:"100", align:"center"},
                                {key:"deadDateString", label:"사망일자", width:"100", align:"center"
	                                	, formatter:function(){
	                                    return this.value.date().print("yyyy-mm-dd");
                                	}
                                },
                                {key:"applName", label:"이름", width:"100", align:"center"},
                                {key:"phone", label:"전화번호", width:"130", align:"center"},
                                {key:"fullAddr", label:"주소", width:"500", align:"center"},
                            ],
                            colHead: {
                                rows: [
                                    [
                                        {colSeq: 0, rowspan: 2},
                                        {colSeq: 1, rowspan: 2},
                                        {colSeq: null, colspan: 2, label: "사망자", align: "center"},
                                        {colSeq: null, colspan: 3, label: "신청자", align: "center"}
                                    ],
                                    [
                                        {colSeq: 2},
                                        {colSeq: 3},
                                        {colSeq: 4},
                                        {colSeq: 5},
                                        {colSeq: 6}
                                    ]
                                ]
                            },
                            body : {
                                onclick: function(event){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);

                                    var item = this.item;
                                	AXContextMenu.open({
                                	    id:"grid-context-menu"
                                	    , sendObj: item
                                	}, {left:pageX, top:pageY});
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                             url: "/CREM2020/hwaCremation",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var gridData = {
                                     list: (function(){
                                    	 for(var i=0; i<res.list.length; i++){
                                    		 for(var key in res.list[i].thedeadVTO){
                                    			 res.list[i][key]=res.list[i].thedeadVTO[key];
                                    		 }
                                    		 for(var key in res.list[i].applicantVTO){
                                    			 res.list[i][key]=res.list[i].applicantVTO[key];
                                    		 }
                                    	 }
                                    	 return res.list;
                                     }()),
                                     page:{
                                         pageNo: res.page.currentPage.number()+1,
                                         pageSize: res.page.pageSize,
                                         pageCount: res.page.totalPages,
                                         listCount: res.page.totalElements
                                     }
                                 };
                                 //_target.setData(gridData);
                             }
                         });
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>