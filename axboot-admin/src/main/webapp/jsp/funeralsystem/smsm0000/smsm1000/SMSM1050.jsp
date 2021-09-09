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
                        <h2><i class="axi axi-list-alt"></i> 예약문자내역조회(MMS)</h2>
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
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	tplGb: Common.getCode("TPL_GB"),
                	trRsltstat: Common.getCode("TR_RSLTSTAT"),
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

                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.grid.del();
                        }, 500);
                    });

                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });

                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){

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
                 						{label:"발송일자", Width:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
                 							onChange: function(){}
                 						},
                 						{label:"", Width:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
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
								{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
								{key:"msgkey", label:"", width:"35", align:"center", display : false},
                                {key:"reqdate", label:"발송시간", width:"150", align:"center"
                                	,editor:{
                                        type:"text",
                                        maxLength: 20,
                                    }
								},
                                {key:"phone", label:"수신번호", width:"150", align:"center",
                                	editor:{
                                        type:"text",
                                        maxLength: 20,
                                    }
                                },
                                /* {key:"rslt", label:"전송결과", width:"100", align:"center",
                                	formatter: function(){
                           				return Common.grid.codeFormatter("rslt", this.value);
                               		},
                                }, */

                                {key:"callback", label:"발송자", width:"150", align:"center",
                                	editor:{
                                        type:"text",
                                        maxLength: 20,
                                    }
                                },
                                {key:"etc1", label:" 내용구분", width:"100", align:"center"
                           			, formatter: function(){
                           				return Common.grid.codeFormatter("tplGb", this.value);
                               		},
	                                editor: {
	                                    type: "select",
	                                    optionValue: "optionValue",
	                                    optionText: "optionText",
	                                    options: fnObj.CODES.tplGb,

	                                    beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
	                                        // console.log(val);
	                                        return val.optionValue; // return 이 반드시 있어야 함.
	                                    },
	                                    afterUpdate: function(val){ // 수정이 처리된 후
	                                        // 수정이 된 후 액션.
	                                        // console.log(this);
	                                    },
	                                    updateWith: ["_CUD"]
	                                }
                           		},
                                {key:"msg", label:"내용", width:"300", align:"center",
                           			editor:{
                                        type:"text",
                                        maxLength: 500,
                                    }
                           		},
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
                             url: "/SMSM1050/getMMSMsg",
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
                    },
                    del:function(){
                    	if(!confirm("선택한 문자를 삭제하시겠습니까?")){
                    		return false;
                    	}
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
                                dto_list.push("msgkey=" + this.item.msgkey); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/SMSM1050/deleteMMSMsg?" + dto_list.join("&"),
                                data: ""
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
                },
                save: function(){
                    var items = fnObj.grid.target.list;
                    if (items.length == 0) {
                        alert("저장할 내용이 없습니다.");
                        return;
                    }
                    var dto_list = [];
                    $.each(items, function(){
                        if(this._CUD){
                            dto_list.push(this); // ajax put 요청 목록 수집
                        }
                    });

                     app.ajax({
                         type: "PUT",
                         url: "/SMSM1050/saveMMSMsg",
                         data: Object.toJSON(dto_list)
                     },
                     function(res){
                         if(res.error){
                             console.log(res.error.message);
                             alert(res.error.message);
                         }
                         else
                         {
                            toast.push("저장되었습니다.");
                             fnObj.search.submit();
                         }
                     });
                },

            };
        </script>
    </ax:div>
</ax:layout>