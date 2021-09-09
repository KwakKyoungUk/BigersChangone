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
                        <h2><i class="axi axi-list-alt"></i> 봉안층코드관리</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
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

            	locCode : "",
            	locName : "",
            	CODES: {
            		"locCode": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/ENSH3010/enslocSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
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
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });
                    $("#ax-grid-btn-add").bind("click", function(){
                        _this.grid.add();
                    });

                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.grid.del();
                        }, 500);
                    });


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
                         url: "/ENSH3020/saveEnsfloor",
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
                               // fnObj.search.submit();
                            },
                             rows:[
                                  {display:false, addClass:"", style:"", list:[
                                      {label:"구분", labelWidth:"100", type:"selectBox", width:"150", key:"locCode", addClass:"", valueBoxStyle:"", value:"",

                                          options:[],
                                          AXBind:{
                                              type:"select", config:{
                                            	  reserveKeys: {
                                                      options: "list",
                                                      optionValue: "locCode",
                                                      optionText: "locName"
                                                  },
                                                  method:"GET", ajaxUrl: "/ENSH3010/findEnsloc", ajaxPars: "",
                                                  isspace: false, isspaceTitle: "",
                                                  setValue:"",
                                                  alwaysOnChange: true,
                                            	  onchange:function(){
                                                      //console.log(this);
                                                       fnObj.locCode = this.value;
                                               		   fnObj.locName = this.text.dec();
                                                      //toast.push(Object.toJSON(this));
                                                     fnObj.search.submit();
                                                  }
                                              }
                                          }
                                      },
                                  ]}
                              ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam()||"locCode="+ fnObj.CODES.locCode[0].optionValue;
                        //var pars = "locCode="+ fnObj.CODES.locCode[0].optionValue;
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
                                {key:"floorCode", label:"층코드", width:"100", align:"left",
                                    editor:{
                                        type:"text",
                                        maxLength: 10,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){
                                            var hasCd = false, index = this.index;
                                            target.list.forEach(function(item, i){
                                                if(item.floorCode == val && i != index) {
                                                    hasCd = true;
                                                    return false;
                                                }
                                            });
                                            if(hasCd) target.list[index].__edting__ = true;
                                            return (hasCd) ? "" : val;
                                        },
                                        afterUpdate: function(){
                                            if(this.item.floorCode == "" && this.item.__edting__) toast.push("코드값이 중복됩니다. 입력이 취소 되었습니다.");
                                            delete target.list[this.index].__edting__;
                                        }
                                    }
                                },
                                {key:"charnClassName", label:"층명", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 20
                                    }
                                },
                                {key:"locCode", label:"구역코드", width:"150",
                                	formatter: function(val){
                                    	//	trace(this.value);
                                    	//	trace(this);
                                    		return Common.grid.codeFormatter("locCode", this.value);
                                  	}
                                    , editor: {
                                        type: "select",
                                        optionValue: "optionValue",
                                        optionText: "optionText",
                                        options: fnObj.CODES.locCode,
                                        setValue:"C1",
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
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
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
                    add:function(){
                    	var locCode = fnObj.CODES.locCode[0].optionValue;
                    	//alert(fnObj.locCode);
                        this.target.pushList({
                        	locCode :locCode

                        });
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                    	if(!confirm("선택한 층 정보를 삭제하시겠습니까?")){
                    		return;
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
                                dto_list.push(this.item); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/ENSH3020/deleteEnsfloor",
                                data: Object.toJSON(dto_list)
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

                         app.ajax({
                             type: "GET",
                             url: "/ENSH3020/findEnsfloor?"+(searchParams||fnObj.search.target.getParam()),
                             data: ""
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