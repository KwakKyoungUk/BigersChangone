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
                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 접속내역조회</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>
				<div id="grid-context-menu"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {                	
                	condition: [
						{optionValue:"all", optionText:"전체"}
           	          , {optionValue:"loginId", optionText:"ID"}
           	          , {optionValue:"loginIp", optionText:"IP"}
           	          , {optionValue:"loginName", optionText:"이름"}
           	          ]
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
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("HIST1021", fnObj.grid.target);                    	
                    });
                    $(document.body).bind("mouseover", function(event){
                    	pageX = event.pageX;
                    	pageY = event.pageY;
                    });

                    $("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	_this.search.submit();
                        }
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
                                	{label:"구분", labelWidth:"", type:"selectBox", width:"90", key:"condition", addClass:"", valueBoxStyle:"", value:"",
 										options:fnObj.CODES.condition,
        									onChange:function(){}
                					},
               						{label:"검색", labelWidth:"", type:"inputText", width:"100", key:"searchParam", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
               						{label:"조회일자", labelWidth:"100", type:"checkBox", width:"", key:"allCheck", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"all", optionText:"전기간", title:"전기간"}],
										onChange: function(selectedObject, value){
											//아래 3개의 값을 사용 하실 수 있습니다.
 											//toast.push(Object.toJSON(this));
 											//toast.push(Object.toJSON(selectedObject));
 											//toast.push(value);
										}
									},
               						{label:"", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                                ]},
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
                                {key:"loginSeq", label:"로그인관리번호", width:"110", align:"center", valign:"middle"},
                                {key:"loginId", label:"ID", width:"100", align:"center", valign:"middle"},
                                {key:"loginName", label:"이름", width:"100", align:"center"},
                                {key:"loginIp",label:"접속IP", width:"200", align:"center"},
                                {key:"loginDate",label:"접속일시", width:"250", align:"center"},
                                {key:"successYn", label:"성공여부", width:"100", align:"center"},
                                
                            ],
                            colHead: {
                                rows: [
                                    [
                                        {colSeq: 0, rowspan: 1},
                                        {colSeq: 1, rowspan: 1},
                                        {colSeq: 2, rowspan: 1},
                                        {colSeq: 3, rowspan: 1},
                                        {colSeq: 4, rowspan: 1},
                                        {colSeq: 5, rowspan: 1},
                                    ]                                    
                                ]
                            },
                            body : {
                                onclick: function(event){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //console.log(this.list);
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
                             url: "/HIST1020/loginHistory",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var gridData = {
                                     list: (function(){
                                    	return res.list;
                                     }()),
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