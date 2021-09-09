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
                        <h2><i class="axi axi-list-alt"></i> 문자결과조회</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <ax:custom customid="table">
					<ax:custom customid="tr">
							<ax:custom customid="td">
							<div id="div-tab"></div>
							<div id="div-content"></div>
								<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; padding-right:10px;">
									<div id="div-tab-content-sms">
										<div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>
									</div>
									<div id="div-tab-content-mms">
										<div class="ax-grid" id="page-grid-box2" style="min-height:300px;"></div>
										<div id="grid-context-menu"></div>
									</div>
								</div>
							</ax:custom>
					</ax:custom>
			</ax:custom>

				<div id="grid-context-menu"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97},
                {id:"page-grid-box2", adjust:-97}
            ];
            var fnObj = {
            	selectedTab : "sms",
                CODES: {
                	"firstTab": [
    					{optionValue:"sms", optionText:"sms", closable:false},
					 ],
			         "tab": [
			    				{optionValue:"sms", optionText:"sms", closable:false},
			    				{optionValue:"mms", optionText:"mms", closable:false}
			        ],
                	tplGb: Common.getCode("TPL_GB"),
                	trRsltstat: Common.getCode("TR_RSLTSTAT"),
                	rslt: Common.getCode("RSLT"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.grid2.bind();
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
                    	if(fnObj.selectedTab == "sms"){
                    		Common.report.gridToExcel("SMSM1030",  fnObj.grid.target);
                    	}else{
                    		Common.report.gridToExcel("SMSM1031",  fnObj.grid2.target);
                    	}
                    });

                    $("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	_this.search.submit();
                        }
                    });
                    $("#div-tab").bindTab({
        				theme : "AXTabs",
        				value:"sms",
        				overflow:"scroll", /* "visible" */
        				options:fnObj.CODES.firstTab,
        				onchange: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
//         					toast.push("onchange: "+Object.toJSON(value));

// 		                    $("#div-contents").empty();
//         					$("#div-contents").append(fnObj.tabs["div-tab-content-"+value].tab);
//         					fnObj.tabs["div-tab-content-"+value].bindEvent();
//         					$("[id^='div-tab-content-']").css("display", "none");
//         					$("#div-tab-content-"+value).css("display", "");
							$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-"+value));
							if(value =="sms"){								
								fnObj.selectedTab = "sms";
							}else{
								fnObj.selectedTab = "mms";
							}

        				},
        				onclose: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
        					toast.push("onclose: "+Object.toJSON(value));
        				}
        			});

                    $("#div-content").append($("#div-tab-content-sms"));
                    $("#div-tab").updateTabs(fnObj.CODES.tab);
					//$("#div-contents").append($("[id^='div-tab-content-']"));


                },
                tabs:{},
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
                 						{label:"발송일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                 						{label:"내용구분", labelWidth:"", type:"selectBox", width:"90", key:"tplGb", addClass:"", valueBoxStyle:"", value:"",
                 							options:[{optionValue:"", optionText:"전체"}].concat(fnObj.CODES.tplGb),
           									onChange:function(){}
                   						},

                                  ]}
                              ]
                          });

                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                        fnObj.grid2.setPage(fnObj.grid2.pageNo, pars);
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

                                {key:"trSenddate", label:"발송시간", width:"150", align:"center"},
                                {key:"trPhone", label:"수신번호", width:"150", align:"center"},
                                {key:"trRsltstat", label:"전송결과", width:"150", align:"center"
                                	 , formatter: function(){
                            				return Common.grid.codeFormatter("trRsltstat", this.value);
                                		 }
                                },
                                {key:"trCallback", label:"발송자", width:"150", align:"center" },
                                {key:"trEtc1", label:" 내용구분", width:"150", align:"center"
                           			 , formatter: function(){
                           				return Common.grid.codeFormatter("tplGb", this.value);
                               		 }
                           		},
                                {key:"trMsg", label:"내용", width:"400", align:"left"},
                            ],

                            body : {
                                onclick: function(event){

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
                             url: "/SMSM1030/getScLog",
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
                grid2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box2",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [

                                {key:"reqdate", label:"발송시간", width:"150", align:"center"},
                                {key:"phone", label:"수신번호", width:"150", align:"center"},
                                {key:"rslt", label:"전송결과", width:"150", align:"center"
                                	 , formatter: function(){
                                		 return Common.grid.codeFormatter("rslt", this.value);
                                		 }
                                },
                                {key:"callback", label:"발송자", width:"150", align:"center" },
                                {key:"Etc1", label:" 내용구분", width:"150", align:"center"
                           			 , formatter: function(){
                           				return Common.grid.codeFormatter("tplGb", this.value);
                               		 }
                           		},
                                {key:"msg", label:"내용", width:"5000", align:"left"},
                            ],

                            body : {
                                onclick: function(event){

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
                             url: "/SMSM1030/getMMSLog",
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