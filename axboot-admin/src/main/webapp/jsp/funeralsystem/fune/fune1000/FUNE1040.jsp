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
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> ${PAGE_NAME}</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-grid"></div>
<!--                 <iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe> -->
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            	{id:"div-grid", adjust:-130}
            ];
            var fnObj = {
                CODES: {
                	deadSex: Common.getCode("TCM05")
                	, deadReason: Common.getCode("TCM03")
                	, deadPlace: Common.getCode("TCM09")
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    this.grid.bind();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
//                     	var params = [];
//                     	var from = null;
//                     	var to = null;
//                     	var customerNo = null;
//                     	var deadName = null;

//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		from = new Date(0).print("yyyymmdd");
//                     		to = new Date().print("yyyymmdd");
//                     		params.push("from="+from);
//                     		params.push("to="+to);
//                     		params.push("customerNo="+customerNo);
//                     		params.push("deadName="+deadName);
//                     	}else{
//                     		from = Common.search.getValue(fnObj.search.target, "from");
//                     		to = Common.search.getValue(fnObj.search.target, "to");
//                     		customerNo = Common.search.getValue(fnObj.search.target, "customerNo");
//                     		deadName = Common.search.getValue(fnObj.search.target, "deadName");
//                     		params.push("FROM="+from);
//                     		params.push("TO="+to);
//                     		params.push("customerNo="+customerNo);
//                     		params.push("deadName="+deadName);
//                     	}
// //                         Common.report.open("/reports/stat/${PAGE_ID}", "pdf", params.join("&"));
//                         Common.report.embedded("/reports/changwon/fune/FUNE1041", "pdf", params.join("&"), "if-pdf");
						fnObj.grid.setPage();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
//                     	var params = [];
//                     	var from = null;
//                     	var to = null;
//                     	var customerNo = null;
//                     	var deadName = null;
//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		from = new Date(0).print("yyyymmdd");
//                     		to = new Date().print("yyyymmdd");
//                     		params.push("from="+from);
//                     		params.push("to="+to);
//                     		params.push("customerNo="+customerNo);
//                     		params.push("deadName="+deadName);
//                     	}else{
//                     		from = Common.search.getValue(fnObj.search.target, "from");
//                     		to = Common.search.getValue(fnObj.search.target, "to");
//                     		customerNo = Common.search.getValue(fnObj.search.target, "customerNo");
//                     		deadName = Common.search.getValue(fnObj.search.target, "deadName");
//                     		params.push("FROM="+from);
//                     		params.push("TO="+to);
//                     		params.push("customerNo="+customerNo);
//                     		params.push("deadName="+deadName);
//                     	}
//                         Common.report.go("/reports/changwon/fune/FUNE1041", "excel", params.join("&"));
						Common.report.gridToExcel("FUNE1040", fnObj.grid.target);
                    });
                },
                eventFunc: {
                	isDisabled : function(val){
                		if(val == '1'){
							fnObj.eventFunc.disabled();
						}else{
							fnObj.eventFunc.unDisabled();
						}
                	},
                	unDisabled: function(){

//                 		$("#info-typeCode-move").prop("disabled", true);
                		$("#"+fnObj.search.target.getItemId("customerNo")).prop("disabled", false);
                		$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
                		$("#"+fnObj.search.target.getItemId("applName")).prop("disabled", false);
                		$("#"+fnObj.search.target.getItemId("balinDateFrom")).prop("disabled", false);
                		$("#"+fnObj.search.target.getItemId("balinDateTo")).prop("disabled", false);
                	},
                	disabled: function(){
                		$("#"+fnObj.search.target.getItemId("customerNo")).prop("disabled", true);
                		$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
                		$("#"+fnObj.search.target.getItemId("applName")).prop("disabled", true);
                		$("#"+fnObj.search.target.getItemId("balinDateFrom")).prop("disabled", true);
                		$("#"+fnObj.search.target.getItemId("balinDateTo")).prop("disabled", true);
//                 		$("#info-typeCode-new").prop("disabled", true);
//                 		$("#info-typeCode-add").prop("disabled", false);
//                 		$("#info-typeCode-move").prop("disabled", false);
                	},
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
                                	{label:"고객번호", labelWidth:"", type:"inputText", width:"80", key:"customerNo", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){
               								fnObj.grid.setPage();
               							}
               						},
                                	{label:"고인명", labelWidth:"", type:"inputText", width:"70", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){
               								fnObj.grid.setPage();
               							}
               						},
               						{label:"상제", labelWidth:"", type:"inputText", width:"70", key:"applName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){
               								fnObj.grid.setPage();
               							}
               						}
               					]},
                                {display:true, addClass:"", style:"", list:[
            						{label:"조회구분", labelWidth:"100", type:"selectBox", width:"", key:"searchGubun", addClass:"", valueBoxStyle:"", value:"", options:[],
            							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/FUNE1040/basiccode",
            									ajaxPars:null,
            									setValue:"1",
            									alwaysOnChange: true,
            									onChange:function(){
														fnObj.eventFunc.isDisabled(this.value);

            									}
            								}
            							}
            						},
                                	{label:"발인일자", labelWidth:"", type:"inputText", width:"70", key:"balinDateFrom", addClass:"", valueBoxStyle:"", value:'',
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"balinDateTo", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:'',
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"balinDateFrom",
               									onChange:function(){
               										fnObj.grid.setPage();
               									}
               								}
               							}
               						}
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
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"customerNo", label:"고객번호", width:"100", align:"center"},
                                {key:"xxx1", label:"빈소", width:"80", align:"left", formatter: function(){
                                	return this.item.binso.binsoName;
                                }},
                                {key:"xxx2", label:"고인명", width:"80", align:"center", formatter: function(){
                                	return this.item.thedead.deadName;
                                }},
                                {key:"xxx3", label:"성별", width:"80", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("deadSex", this.item.thedead.deadSex);
                                }},
                                {key:"xxx4", label:"나이", width:"50", align:"center", formatter: function(){
                                	return this.item.thedead.deadAge;
                                }},
                                {key:"t1", label:"본관", width:"80", align:"left", display: false, formatter: function(){
                                	return this.item.thedead.familyClan;
                                }},
                                {key:"t2", label:"고인주민번호", width:"80", align:"left", display: false, formatter: function(){
                                	return this.item.thedead.deadJumin;
                                }},
                                {key:"t3", label:"사망원인", width:"80", align:"left", display: false, formatter: function(){
                                	return Common.grid.codeFormatter("deadReason", this.item.thedead.deadReason) + " " + this.item.thedead.deadReasonNm;
                                }},
                                {key:"t4", label:"사망장소", width:"80", align:"left", display: false, formatter: function(){
                                	return Common.grid.codeFormatter("deadPlace", this.item.thedead.deadPlace) + " " + this.item.thedead.deadPlaceNm;
                                }},
                                {key:"t5", label:"사망일자", width:"80", align:"left", display: false, formatter: function(){
                                	return this.item.thedead.deadDate;
                                }},
                                {key:"xxx5", label:"상주명", width:"80", align:"center", formatter: function(){
                                	return this.item.applicant.applName;
                                }},
                                {key:"anchiDate", label:"안치일시", width:"150", align:"center"},
                                {key:"ibkwanDate", label:"입관일시", width:"150", align:"center"},
                                {key:"balinDate", label:"발인일시", width:"150", align:"center"},
                                {key:"jangji", label:"장지", width:"150", align:"left"},
                                {key:"xxx6", label:"연락처", width:"150", align:"center", formatter: function(){
                                	return this.item.applicant.mobileno1+"-"+this.item.applicant.mobileno2+"-"+this.item.applicant.mobileno3
                                }},
                                {key:"xxx7", label:"주소", width:"400", align:"left", formatter: function(){
                                	return this.item.thedead.deadAddr1+" "+this.item.thedead.deadAddr2;
                                }},
                                {key:"f1", label:"유가족", width:"400", align:"left", display: false, formatter: function(){
                                	return this.item.liveName02;
                                }},
                            ],
                            body : {
                                onclick: function(){
                                	var openwindow = window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+this.item.customerNo, "FUNE1030");
                                	openwindow.focus();
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
                             url: "/FUNE1040/funeral",
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
                },
            };
        </script>
    </ax:div>
</ax:layout>