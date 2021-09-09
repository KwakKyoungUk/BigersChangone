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
				<form id="page-search-box">
                     <div class="sbar">
                      <span class="sitem">
                             <span class="slabel">업무구분</span>
                              <select id="info-jobGubun" name="jobGubun" class="AXSelect W100" ></select>
                         </span>
                      <span class="sitem">
                             <span class="slabel">요금구분</span>
                             <select id="info-priceGubun" name="priceGubun" class="AXSelect W100" ></select>
                         </span>
                     </div>
                 </form>


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 반환정보 설정관리</h2>
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

                CODES: {
                	"jobGubun": [Common.getCode("JOB_GUBUN")[1]]
                	,"priceGubun": {
                	//	"1" : [Common.getCode("PRICE_GUBUN")[0]]
                		"E" : [Common.getCode("PRICE_GUBUN")[0],Common.getCode("PRICE_GUBUN")[1]]
                	//	,"3" : Common.getCode("PRICE_GUBUN")
                	//	,"4" : [Common.getCode("PRICE_GUBUN")[0]]
                	}
            		,"useTerm" : Common.getCode("ENS_USE_TERM")
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    this.grid.bind();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                   // this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                     $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#info-jobGubun").bindSelect({
                        options:fnObj.CODES.jobGubun

                        ,alwaysOnChange: true
                        ,onchange:function(){
                            trace(this);

                            $("#info-priceGubun").bindSelect({options:fnObj.CODES.priceGubun[this.value]})
                            fnObj.search.submit();
                        }
                    });
                    $("#info-priceGubun").change(function(){
                    	fnObj.search.submit();
                    })


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
                    var newItem = fnObj.grid.target.getList("C");
                    if (items.length == 0) {
                        alert("저장할 내용이 없습니다.");
                        return;
                    }

                    var dto_list = [];
                    $.each(items, function(i,d){
                    	if(d._CUD && d.jobGubun && d.priceGubun && d.useTerm ){
                            dto_list.push(this); // ajax put 요청 목록 수집
                        }
                    });


                     app.ajax({
                         type: "PUT",
                         url: "/STAN1030/saveRetList",
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

                             //mediaQuery: {
                            // mx:{min:"N", max:767}, dx:{min:767}
                             //},

                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.

                                fnObj.search.submit();
                            },

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
                                {key:"jobGubun", label:"업무구분", width:"80", align:"center",
                             	    formatter: function(){
                                 	     return $("#info-jobGubun option:selected" ).text();
                                    },
									/* editor:{
                                        type:"text",
                                        maxLength: 10,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
									} */
                                },
                                {key:"priceGubun", label:"요금구분", width:"100", align:"center",

                               	    formatter: function(val){
                              	      return $("#info-priceGubun option:selected" ).text();
                              	    },
                               		/*  editor:{
                                        type:"text",
                                        maxLength: 10,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
									} */
                                },
                                {key:"useTerm", label:"사용기간", width:"150", align:"center",
                                	formatter: function(val){

                                	//	trace(this.value);
                                	//	trace(this);
                                		return Common.grid.codeFormatter("useTerm", this.value);
                              	    },
                                    editor:{
                                        type:"select",
                                        optionValue: "optionValue",
                                        optionText: "optionText",
                                        options:fnObj.CODES.useTerm,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        //alwaysOnChange: true,
                                        beforeUpdate: function(val){ // 수정이 처리된 후
                                            // 수정이 된 후 액션.
                                            //console.log(val);
                                            return val.optionValue; //(val.optionValue == "true");
                                        }
                                    },
                                    updateWith: ["_CUD"]
                                },
                                {key:"retRate", label:"환급율", width:"150", align:"center",
                                	formatter: function(val){
                                	    return this.value > 0 ? this.value +"%" : 0
                              	    },
                                    editor:{
                                        type:"text",
                                        maxLength: 11
                                    }
                                },

                                {key:"remark", label:"비고", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 200
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
                    	var jobGubun = $( "#info-jobGubun option:selected" ).val();
                    	var priceGubun = $( "#info-priceGubun option:selected" ).val();


                        this.target.pushList({
                        	jobGubun:jobGubun
                        	,priceGubun : priceGubun
                        	,useTerm : fnObj.CODES.useTerm[0].optionValue
                        },this.target.list.length+1);
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                    	if(!confirm("선택한 시설정보를 삭제하시겠습니까?")){
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

                            	 var item = {
                                         jobGubun: (this.item.jobGubun),
                                         priceGubun: (this.item.priceGubun),
                                         useTerm: (this.item.useTerm),
                                     };
                                     dto_list.push(item);

                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/STAN1030/deleteRetList",
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
                             url: "/STAN1030/findRetList",
                             data: (searchParams||"")
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var gridData = {
                                     list: res.list
                                      , page:{
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