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


                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width:500px;">
                        	<div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
							<iframe id="reportDisplay" src="" style="width:99%; min-height:800px; border:none;"></iframe>


                        </ax:custom>
                    </ax:custom>
                </ax:custom>

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
                    "etc3": [
                        {CD:'1', NM:"코드"},
                        {CD:'2', NM:"CODE"},
                        {CD:'4', NM:"VA"}
                    ],
                    "_etc3": {"1":"코드", "2":"CODE", "4":"VA"}
            		, deadAge: Common.getCode("TCM05")
                },
                pageStart: function(){
                	this.dateFormat();
                    this.search.bind();
                    this.grid.bind();
                    //this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    setTimeout(function(){
                   		fnObj.search.submit();
                    }, 500);
                    fnObj.defaultFn.excute();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	 var params = "CUSTOMER_NO=" + fnObj.grid.target.getSelectedItem().item.customerNo;
                        fnObj.excel(params);
                    });
                },
                defaultFn: {
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
                		search: function(){
                			var customerNo = "${param.customerNo}";
                			if(customerNo == ''){
                				return;
                			}
                			var params = "CUSTOMER_NO=" + customerNo;
                            fnObj.report(params);
                		}
                	}
                },
                dateFormat: function(){
               		Date.prototype.yyyymmdd = function() {
               		  var mm = this.getMonth() + 1; // getMonth() is zero-based
               		  var dd = this.getDate();

               		  var result = [this.getFullYear(),
               		          (mm>9 ? '' : '0') + mm,
               		          (dd>9 ? '' : '0') + dd
               		         ].join('-');

               		  return result;
               		};
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
                                    	{label:"조회구분", labelWidth:"", type:"selectBox", width:"150", key:"searchKind", addClass:"", valueBoxStyle:"", value:"close", options:[],


	                                    	AXBind: {
	                                            type: "select", config: {

	                                                reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },

	                                              ajaxUrl: "/FUNE5040/search-kind-options",
	                                              ajaxPars: null,
	                                              setValue: "",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  switch (this.value) {
														case '1':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
															break;
														case '2':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
															break;

														default:
															break;
														}
														fnObj.grid.target.setData({list: []});
	                                              }
	                                            }
	                                        }
										},
                               		]
                                },

                                {display:true, addClass:"", style:"", list:[
										{label:"고인명", labelWidth:"", type:"inputText", width:"100", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
										    onChange: function(changedValue){
										    	trace("2");
										    	_this.submit();
										    }
										}
	                            	]
	                            },

 	                            {display:true, addClass:"", style:"", list:[
									{label:"발인일자", labelWidth:"", type:"inputText", width:"110", key:"balinDate", addClass:"", valueBoxStyle:"", value:"",
										onChange:function(){
											_this.submit();
										},
										AXBind:{
											type:"date", config:{
												align:"center", valign:"top",
												onChange:function(){
													_this.submit();
												}
											}
										}
									  }

	                               ]
								}
                            ]
                        });

                        setTimeout(function(){
                        	$("#"+fnObj.search.target.getItemId("balinDate")).val("");
                       		$("#"+fnObj.search.target.getItemId("deadName")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});
                       		$("#"+fnObj.search.target.getItemId("balinDate")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});

                        }, 300);


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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"customerNo", label:"고객번호", width:"100", align:"left"},
                                {key:"deadName", label:"고인명", width:"100"},
                                {key:"deadSex", label:"성별", width:"80", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("deadAge", this.value);
                                }},
                                {key:"deadAge", label:"나이", width:"80", align: "center"},
                                {key:"binsoName", label:"빈소", width:"100", align:"left"}
                            ],
                            body : {
                                onclick: function(){
                                    // fnObj.form.setJSON(this.item);

                                    var params = "CUSTOMER_NO=" + this.item.customerNo;
                                    fnObj.report(params);
                                }
                            }
                            /* page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/api/v1/samples/parent",
                                data: dto_list.join("&")
                            },
                            function(res) {
                                if (res.error) {
                                    alert(res.error.message);
                                } else {
                                    nextFn(); // 스크립트로 목록 제거
                                }
                            });
                        }
                    },
                    setPage: function(pageNo, searchParams){
                    	var _target = this.target;
                        this.pageNo = pageNo;

                        var searchKind = Common.search.getValue(fnObj.search.target, "searchKind");

                        if(searchKind == '2'
                    			&& $("#"+fnObj.search.target.getItemId("deadName")).val() == ''
								&& $("#"+fnObj.search.target.getItemId("balinDate")).val() == ''){
                    		alert("고인명 또는 발인일자를 입력해 주세요.");
                    		return;
                    	}

                        var url = "/FUNE5040/dead";
                        if(searchKind == '1'){
                        	url = "/FUNE5040/assignedDead";
                        }

                        app.ajax({
                            type: "GET",
                            url: url,
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
                                };

                                _target.setData(gridData);
                            }
                        });
                    }
                },

                report: function(params){
                	var path = "/reports/changwon/fune/FUNE5041";
                	var output = "pdf";
                	var frameId = "reportDisplay";
                	Common.report.embedded(path, output, params, frameId);
                	toast.push("로딩중입니다.");
                },

                excel: function(params){
                	var path = "/reports/changwon/fune/FUNE5041";
                	var output = "excel";
                	Common.report.go(path, output, params);
                	toast.push("로딩중입니다.");
                }
            };
        </script>
    </ax:div>
</ax:layout>