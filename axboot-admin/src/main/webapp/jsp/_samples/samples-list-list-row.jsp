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
                        <h2><i class="axi axi-list-alt"></i> 정보리스트</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-grid1-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                        <button type="button" class="AXButton" id="ax-grid1-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

                <div class="ax-grid" id="page-grid1-box" style="min-height: 300px;"></div>

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 자식리스트</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-grid2-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                        <button type="button" class="AXButton" id="ax-grid2-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

                <div class="ax-grid" id="page-grid2-box" style="min-height: 300px;"></div>


            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid1-box", adjust: function(){
                    return -axf.clientHeight()/2;
                }},
                {id:"page-grid2-box", adjust: function(){
                    return -axf.clientHeight()/2;
                }}
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
                    this.grid1.bind();
                    this.grid2.bind();
                    this.bindEvent();

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

                    $("#ax-grid1-btn-add").bind("click", function(){
                        _this.grid1.add();
                    });
                    $("#ax-grid1-btn-del").bind("click", function(){
                        _this.grid1.del();
                    });

                    $("#ax-grid2-btn-add").bind("click", function(){
                        _this.grid2.add();
                    });
                    $("#ax-grid2-btn-del").bind("click", function(){
                        _this.grid2.del();
                    });
                },
                save: function(){
                    var items = fnObj.grid1.target.list;
                    var dto_list = [];
                    var dto_sub_list = [];
                    var next_fn, errors = [];
                    next_fn = function(){

                        items = fnObj.grid2.target.list;
                        axf.each(items, function (i, d) {
                            if (d._CUD && d.key && d.parentKey) {
                                var item = {
                                    "parentKey": d.parentKey||"",
                                    "key": d.key||"",
                                    "value": d.value||"",
                                    "etc1": d.etc1||"",
                                    "etc2": d.etc2||"",
                                    "etc3": d.etc3||""
                                };
                                dto_sub_list.push(item);
                            }
                        });

                        if(dto_sub_list.length > 0){
                            app.ajax({
                                type: "PUT",
                                url: "/api/v1/samples/child",
                                data: Object.toJSON(dto_sub_list)
                            }, function(res){
                                if(res.error){
                                    alert(res.error.message);
                                }
                                else
                                {
                                    toast.push("자식 리스트가 저장되었습니다.");
                                }
                                fnObj.grid1.setPage(1);
                                fnObj.grid2.setPage(1, "parentKey=" + fnObj.grid2.parent.key);
                            });
                        }else{
                            fnObj.grid1.setPage(1);
                            fnObj.grid2.setPage(1, "parentKey=" + fnObj.grid2.parent.key);
                        }
                    };

                    axf.each(items, function(i, d){
                        if(d._CUD && d.key){
                            var item = {
                                "key": d.key||"",
                                "value": d.value||"",
                                "etc1": d.etc1||"",
                                "etc2": d.etc2||"",
                                "etc3": d.etc3||""
                            };
                            dto_list.push(item);
                        }
                    });

                    if (dto_list.length > 0) {
                        //trace(dto_list);
                        app.ajax({
                            type: "PUT",
                            url: "/api/v1/samples/parent",
                            data: Object.toJSON(dto_list)
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                toast.push("정보 리스트가 저장되었습니다.");
                                next_fn();
                            }
                        });
                    }else{
                        next_fn();
                    }
                },

                search: {
                    submit: function(){
                        fnObj.grid1.setPage(fnObj.grid1.pageNo);
                    }
                },


                // 메인그리드
                grid1: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid1-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"key", label:"코드", width:"60", align:"left",
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
                                {key:"value", label:"이름", width:"100",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc1", label:"컬럼1", width:"80",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc2", label:"날짜", width:"100",
                                    editor:{
                                        type: "calendar",
                                        config: {
                                            separator: "-"
                                        },
                                        updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                    }
                                },
                                {key:"etc3", label:"선택타입", width:"80", align:"center",
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
                                    fnObj.grid2.setParent(this.item);
                                }
                            },
                            page: {
                                display: true,
                                paging: false,
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
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=500000&" + (searchParams||"")
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


                // 자식그리드
                grid2: {
                    parent: {},
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid2-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"key", label:"코드", width:"60", align:"left",
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
                                {key:"value", label:"이름", width:"100",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc1", label:"컬럼1", width:"80",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc2", label:"날짜", width:"100",
                                    editor:{
                                        type: "calendar",
                                        config: {
                                            separator: "-"
                                        },
                                        updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                    }
                                },
                                {key:"etc3", label:"선택타입", width:"80", align:"center",
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

                                }
                            },
                            page: {
                                display: true,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    add:function(){
                        if(typeof this.parent.key == "undefined" || this.parent.key == "") {
                            alert("정보리스트를 선택 하지 않았거나 선택된 정보에 코드값이 없습니다.");
                            return;
                        }
                        this.target.pushList({
                            parentKey: this.parent.key
                        });
                        this.target.setFocus(this.target.list.length-1);
                    },
                    setParent: function(item){
                        if(typeof item.key === "undefined" || item.key == "" || typeof item.value === "undefined" || item.value == "") {
                            this.clear();
                        }else{
                            this.parent = item;
                            this.setPage( 1, "parentKey=" + item.key );
                        }
                    },
                    clear: function(){
                        this.parent = {};
                        this.target.setList([]);
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
                                        url: "/api/v1/samples/child?" + dto_list.join("&"),
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
                            url: "/api/v1/samples/child",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=500000&" + (searchParams||"")
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