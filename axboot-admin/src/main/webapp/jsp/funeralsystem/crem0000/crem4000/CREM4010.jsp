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
                        <h2><i class="axi axi-list-alt"></i> 화로 그룹</h2>
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
                        <h2><i class="axi axi-list-alt"></i> 화로 그룹 차수</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-grid2-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                        <button type="button" class="AXButton" id="ax-grid2-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                    </div>
                    <div class="right" style="margin-right: 5%;">
                    	<b><i class='axi axi-circle' style='color:green; font-size:20px;'></i> : 시체</b>,
                    	<b><i class='axi axi-circle' style='color:red; font-size:20px;'></i> : 개장유골</b>,
                    	<b><i class='axi axi-circle' style='color:yellow; font-size:20px;'></i> : 죽은태아</b>
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
                    "objt": [
                       		{CD:"100",NM:"시체"}
                      		, {CD:"011",NM:"개장유골/죽은태아"}
                      		, {CD:"001",NM:"죽은태아"}
                      		, {CD:"000",NM:"불가"}
                  		],
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
                            if (d._CUD && d.chasuSeq && d.grpGubun) {
                                var item = {
                                    "grpGubun": d.grpGubun||"",
                                    "chasuSeq": d.chasuSeq||"",
                                    "chasuName": d.chasuName||"",
                                    "endtimeString": d.endtimeString||"",
                                    "strttimeString": d.strttimeString||"",
                                    "ro01": d.ro01||"",
                                    "ro02": d.ro02||"",
                                    "ro03": d.ro03||"",
                                    "ro04": d.ro04||"",
                                    "ro05": d.ro05||"",
                                    "ro06": d.ro06||"",
                                    "ro07": d.ro07||"",
                                    "ro08": d.ro08||"",
                                    "ro09": d.ro09||"",
                                    "ro10": d.ro10||"",
                                    "ro11": d.ro11||"",
                                    "ro12": d.ro12||"",
                                    "ro13": d.ro13||"",
                                    "ro14": d.ro14||"",
                                    "ro15": d.ro15||"",
                                    "ro16": d.ro16||"",
                                    "ro17": d.ro17||"",
                                    "ro18": d.ro18||"",
                                    "ro19": d.ro19||"",
                                    "ro20": d.ro20||"",
                                   
                                };
                                dto_sub_list.push(item);
                            }
                        });

                        if(dto_sub_list.length > 0){
                            app.ajax({
                                type: "PUT",
                                url: "/OPER1020/saveRogrpchasuList",
                                data: Object.toJSON(dto_sub_list)
                            }, function(res){
                                if(res.error){
                                    alert(res.error.message);
                                }
                                else
                                {
                                    toast.push("화로 그룹 차수가 저장되었습니다.");
                                }
                                fnObj.grid1.setPage(1);
                                fnObj.grid2.setPage(1, "grpGubun=" + fnObj.grid2.parent.grpGubun);
                            });
                        }else{
                            fnObj.grid1.setPage(1);
                            fnObj.grid2.setPage(1, "grpGubun=" + fnObj.grid2.parent.grpGubun);
                        }
                    };

                    axf.each(items, function(i, d){
                        if(d._CUD && d.grpGubun){
                            var item = {
                                "grpGubun": d.grpGubun||"",
                                "applyDateString": d.applyDateString||"",
                                "grpName": d.grpName||"",
                                "remark": d.remark||"",
                                "totRocnt": d.totRocnt||""
                            };
                            dto_list.push(item);
                        }
                    });

                    if (dto_list.length > 0) {
                        //trace(dto_list);
                        app.ajax({
                            type: "PUT",
                            url: "/OPER1020/saveRogrpList",
                            data: Object.toJSON(dto_list)
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                toast.push("화로 그룹 데이터가 저장되었습니다.");
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
                                {key:"grpGubun", label:"그룹코드", width:"60", align:"center",
                                    editor:{
                                        type:"text",
                                        maxLength: 8,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){
                                            var hasCd = false, index = this.index;
                                            target.list.forEach(function(item, i){
                                                if(item.grpGubun == val && i != index) {
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
                                {key:"grpName", label:"그룹명", width:"100", align:"center",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"applyDateString", label:"적용시작일", width:"150", align:"center"
//                                 	, formatter:function(){
//                                 		return new Date(this.value).print("yyyy-mm-dd");
//                                 	}
                                    , editor:{
                                        type: "calendar",
                                        config: {
                                            separator: "-"
                                        },
                                        updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                    }
                                },
                                {key:"totRocnt", label:"총 화로수", width:"100", align:"center",
                                	editor:{
                                        type:"number",
                                        maxLength: 50
                                    }
                                },
                                {key:"remark", label:"비고", width:"100",
                                	editor:{
                                        type:"text",
                                        maxLength: 50
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
                    	if(!confirm("체크한 그룹을 삭제하시겠습니까?\n자료는 즉시 삭제되며 하위 자료까지 같이 삭제 됩니다.")){
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
                                dto_list.push({"grpGubun" : this.item.grpGubun}); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                        type: "DELETE",
                                        url: "/OPER1020/deleteRogrpList",
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
                            url: "/OPER1020/findRogrpList",
                            data: "dummy="+ axf.timekey()
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
                    formatter: function(){
                    	if(!this.value){
                    		return "";
                    	}
                		var res = [];
						var color = ["green", "red", "yellow"];
                		for(var i=0; i<this.value.toString().length; i++){
                			if(this.value.toString()[i]=="1"){
                				res.push("<i class='axi axi-circle' style='color:"+color[i]+"; font-size:20px;'></i>");
                			}else{
                				res.push("<i class='axi axi-circle' style='color:darkgray; font-size:20px;'></i>");
                			}
                		}

                		return res.join("");
                    },
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
                                {key:"grpGubun", label:"그룹코드", width:"60", align:"center"
//                                     , editor:{
//                                         type:"text",
//                                         maxLength: 8,
//                                         disabled: function(){
//                                             return this.item._CUD != "C";
//                                         },
//                                         beforeUpdate: function(val){
//                                             var hasCd = false, index = this.index, _this=this;
//                                             target.list.forEach(function(item, i){
//                                                 if(item.grpGubun == val && item.chasuSeq == _this.chasuSeq && i != index) {
//                                                     hasCd = true;
//                                                     return false;
//                                                 }
//                                             });
//                                             if(hasCd) target.list[index].__edting__ = true;
//                                             return (hasCd) ? "" : val;
//                                         },
//                                         afterUpdate: function(){
//                                             if(this.item.key == "" && this.item.__edting__) toast.push("코드값이 중복됩니다. 입력이 취소 되었습니다.");
//                                             delete target.list[this.index].__edting__;
//                                         }
//                                     }
                                }
                                ,{key:"chasuSeq", label:"차수", width:"40", align:"center",
                                    editor:{
                                        type:"text",
                                        maxLength: 2,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){
                                            var hasCd = false, index = this.index, _this=this;
                                            target.list.forEach(function(item, i){
                                                if(item.chasuSeq == val && i != index) {
                                                    hasCd = true;
                                                    return false;
                                                }
                                            });
                                            if(hasCd) target.list[index].__edting__ = true;
                                            return (hasCd) ? "" : Common.str.lpad(val, "0", 2);;
                                        },
                                        afterUpdate: function(){
                                            if(this.item.chasuSeq == "" && this.item.__edting__) toast.push("코드값이 중복됩니다. 입력이 취소 되었습니다.");
                                            delete target.list[this.index].__edting__;
                                        }
                                    }
                                }
                                , {key:"chasuName", label:"차수명", width:"60", align:"center",
                                	editor:{
                                		type:"text"
                                		, maxLength:50
                                	}
                                },
                                {key:"strttimeString", label:"시작 시간", width:"100", align:"center"
                                	, formatter : function(){
                                		if(this.value){
	                                		return Common.pattern.custom(this.value, "99:99");
                                		}else{
                                			return "";
                                		}
                                	}
                                	, editor:{
                                        type:"time",
                                        maxLength: 4
                                    }
                                },
                                {key:"endtimeString", label:"종료 시간", width:"80", align:"center"
                                	, formatter : function(){
                                		if(this.value){
	                                		return Common.pattern.custom(this.value, "99:99");
                                		}else{
                                			return "";
                                		}
                                	}
                                    , editor:{
                                        type:"time",
                                        maxLength: 4
                                    }
                                },
                                {key:"ro01", label:"1", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro02", label:"2", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro03", label:"3", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro04", label:"4", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro05", label:"5", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro06", label:"6", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro07", label:"7", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro08", label:"8", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro09", label:"9", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro10", label:"10", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro11", label:"11", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro12", label:"12", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro13", label:"13", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro14", label:"14", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro15", label:"15", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro16", label:"16", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro17", label:"17", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro18", label:"18", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro19", label:"19", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                {key:"ro20", label:"20", width:"80", align:"center"
                                	, formatter : fnObj.grid2.formatter
	                                , editor: {
	                                    type: "select",
	                                    optionValue: "CD",
	                                    optionText: "NM",
	                                    options: fnObj.CODES.objt,
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
                                },
                                
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
                        if(typeof this.parent.grpGubun == "undefined" || this.parent.grpGubun == "") {
                            alert("화로 그룹을 선택 하지 않았거나 선택된 정보에 코드값이 없습니다.");
                            return;
                        }
                        this.target.pushList({
                        	grpGubun: this.parent.grpGubun
                        	, ro01:fnObj.CODES.objt[0].CD
                        	, ro02:fnObj.CODES.objt[0].CD
                        	, ro03:fnObj.CODES.objt[0].CD
                        	, ro04:fnObj.CODES.objt[0].CD
                        	, ro05:fnObj.CODES.objt[0].CD
                        	, ro06:fnObj.CODES.objt[0].CD
                        });
                        this.target.setFocus(this.target.list.length-1);
                    },
                    setParent: function(item){
                        if(typeof item.grpGubun === "undefined" || item.grpGubun == "") {
                            this.clear();
                        }else{
                            this.parent = item;
                            this.setPage( 1, "grpGubun=" + item.grpGubun );
                        }
                    },
                    clear: function(){
                        this.parent = {};
                        this.target.setList([]);
                    },
                    del:function(){
                    	if(!confirm("체크한 차수 자료를 삭제하시겠습니까?\n자료는 즉시 삭제 됩니다.")){
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
                                dto_list.push({"grpGubun" : this.item.grpGubun, "chasuSeq": this.item.chasuSeq}); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                        type: "DELETE",
//                                         url: "/OPER1020/deleteRogrpchasuList?" + dto_list.join("&"),
                                        url: "/OPER1020/deleteRogrpchasuList",
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
                            url: "/OPER1020/findRogrpChasuList",
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