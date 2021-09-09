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
                        <h2><i class="axi axi-list-alt"></i> 정보리스트</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="btn-report"><i class="axi axi-report"></i> 테스트버튼</button>
                        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                        <button type="button" class="AXButton" id="ax-grid-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
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
                    "etc3": [
                        {CD:'1', NM:"코드"},
                        {CD:'2', NM:"CODE"},
                        {CD:'4', NM:"VA"}
                    ],
                    "_etc3": {"1":"코드", "2":"CODE", "4":"VA"}
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
                    $("#ax-grid-btn-del").bind("click", function(){
                        _this.grid.del();
                    });
                    
                    $("#btn-report").bind("click", function(){
                    	var params = [];
                    	//var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	//var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	//var deadId = $("#info-deadId").val();
                    //var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                   // 	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    //		return;
                    //	}

                    	params.push("ensDate="+"20170123");
                		params.push("ensSeq="+"4");
                		params.push("encYN=");

                    	Common.report.open("/reports/ensh/ENSH1016_2", "pdf", params.join("&"));

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
                         url: "/api/v1/samples/parent",
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
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"검색", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        }
                                    }
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
                                {key:"key", label:"코드", width:"100", align:"left",
                                    editor:{
                                        type:"text",
                                        maxLength: 8,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){
                                            var hasCd = false, index = this.index;
                                            target.list.forEach(function(item, i){
                                                if(item.key == val && i != index) {
                                                    hasCd = true;
                                                    return false;
                                                }
                                            });
                                            if(hasCd) target.list[index].__edting__ = true;
                                            return (hasCd) ? "" : val;
                                        },
                                        afterUpdate: function(){
                                            if(this.item.key == "" && this.item.__edting__) toast.push("코드값이 중복됩니다. 입력이 취소 되었습니다.");
                                            delete target.list[this.index].__edting__;
                                        }
                                    }
                                },
                                {key:"value", label:"이름", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc1", label:"컬럼1", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc2", label:"날짜", width:"150",
                                    editor:{
                                        type: "calendar",
                                        config: {
                                            separator: "-"
                                        },
                                        updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                    }
                                },
                                {key:"etc3", label:"선택타입", width:"150", align:"center",
                                    formatter: function(val){
                                        return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
                                        // return (Object.isObject(this.value)) ? this.value.NM : this.value;
                                        // ajax 로 값을 받으면 문자열, inline-editor에서 값을 받으면 {CD:'', NM:''} 이 되므로 예외 처리 되게 합니다.
                                        // ajax 에서도 Object로 값을 전달 해도 좋습니다.
                                    },
                                    editor: {
                                        type: "select",
                                        optionValue: "CD",
                                        optionText: "NM",
                                        options: fnObj.CODES.etc3,
                                        beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
                                            // console.log(val);
                                            return val.CD; // return 이 반드시 있어야 함.
                                        },
                                        afterUpdate: function(val){ // 수정이 처리된 후
                                            // 수정이 된 후 액션.
                                            // console.log(this);
                                        },
                                        updateWith: ["_CUD"]
                                    }
                                }
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
                                url: "/api/v1/samples/parent?" + dto_list.join("&"),
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/api/v1/samples/parent",
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