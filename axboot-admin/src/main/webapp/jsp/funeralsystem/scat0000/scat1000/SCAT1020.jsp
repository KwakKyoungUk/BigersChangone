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
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 산골접수현황조회</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>

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
                	"objt": Common.getCode("TFM27")
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
//                    $("#ax-page-btn-fn2").html("<i class=\"axi axi-file-excel-o\"></i> 엑셀(일자형)");
//                    $("#ax-page-btn-fn2").bind("click", function(){
//                    	var params = [];
//                    	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                    		params.push("from="+new Date(0).print("yyyymmdd"));
//                    		params.push("to="+new Date().print("yyyymmdd"));
//                    	}else{
//                    		params.push("from="+Common.search.getValue(fnObj.search.target, "from"));
//                    		params.push("to="+Common.search.getValue(fnObj.search.target, "to"));
//                    	}
//                        Common.report.go("/reports/scat/SCAT1022", "excel", params.join("&"));
//                    });
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
//                    	var params = [];
//                    	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                    		params.push("from="+new Date(0).print("yyyymmdd"));
//                    		params.push("to="+new Date().print("yyyymmdd"));
//                    	}else{
//                    		params.push("from="+Common.search.getValue(fnObj.search.target, "from"));
//                    		params.push("to="+Common.search.getValue(fnObj.search.target, "to"));
//                    	}
//                        Common.report.go("/reports/scat/SCAT1021", "excel", params.join("&"));
                        Common.report.gridToExcel("SCAT1020", fnObj.grid.target);
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
               						{label:"산골일자", labelWidth:"100", type:"checkBox", width:"", key:"checkbox", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"all", optionText:"전기간", title:"전기간"}],
										onChange: function(selectedObject, value){
											//아래 3개의 값을 사용 하실 수 있습니다.
// 											toast.push(Object.toJSON(this));
// 											toast.push(Object.toJSON(selectedObject));
// 											toast.push(value);
										}
									},
               						{label:"", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value: new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value: new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){

               									}
               								}
               							}
               						},
               						{label:"사망자", labelWidth:"", type:"inputText", width:"90", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
       									onChange:function(){}
               						},
               						{label:"신청자", labelWidth:"", type:"inputText", width:"90", key:"applName", addClass:"", valueBoxStyle:"", value:"",
       									onChange:function(){}
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
                                {key:"scaDate", label:"산골일자", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.value.date().print();
                                	}
                                },
                                {key:"deadName", label:"이름", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.item.thedeadVTO.deadName;
                                	}
                                },
                                {key:"deadDateString", label:"사망일", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.item.thedeadVTO.deadDateString.date().print();
                                	}
                                },
                                {key:"objt", label:"대상구분", width:"100", align:"center"
                                	, formatter:function(){
                                    return Common.grid.codeFormatter("objt",this.value);
                                	}
                            	},
                                {key:"applName", label:"이름", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.item.applicantVTO.applName;
                                	}
                                },
                                {key:"phone", label:"전화번호", width:"130", align:"center"
                                	, formatter: function(){
                                		return this.item.applicantVTO.phone;
                                	}
                               	},
                            ],
                            colHead: {
                                rows: [
                                    [
                                        {colSeq: 0, rowspan: 2},
                                        {colSeq: null, colspan: 3, label: "사망자", align: "center"},
                                        {colSeq: null, colspan: 2, label: "신청자", align: "center"},
                                    ],
                                    [
                                        {colSeq: 1},
                                        {colSeq: 2},
                                        {colSeq: 3},
                                        {colSeq: 4},
                                        {colSeq: 5}
                                    ]
                                ]
                            },
                            body : {
                            	ondblclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                    window.open("/jsp/funeralsystem/scat0000/scat1000/SCAT1010.jsp?scaDate=" + this.item.scaDate + "&scaSeq=" + this.item.scaSeq, 'SCAT1010');
                                },
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
                             url: "/SCAT1020/scatter",
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
                                 _target.setData(gridData);
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>