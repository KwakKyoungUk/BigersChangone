<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}">
<!--                 	<button type="button" class="AXButton Blue" id="ax-grid-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button> -->
                </ax:custom>
                <div class="ax-search" id="page-search-box"></div>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <h2><i class="axi axi-list-alt"></i> 운영환경</h2>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 운영환경 상세</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="작업일자">
                                        <input type="text" id="info-workDateString" name="msgId" title="작업일자" maxlength="8" class="AXInput W150" value="" placeholder="자동으로 부여됩니다." readonly="readonly"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="일련번호">
                                        <input type="text" id="info-seqNo" name="seqNo" title="일련번호" maxlength="8" class="AXInput W150" value="" placeholder="자동으로 부여됩니다." readonly="readonly"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="적용시작일">
                                        <input type="text" id="info-stdateString" name="stdate" title="적용시작일" maxlength="20" class="AXInput W150" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="운구시간">
                                        <input type="text" id="info-woonguTime" name="woonguTime" title="운구시간" maxlength="25" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="고별시간">
                                        <input type="text" id="info-byeTime" name="byeTime" title="고별시간" maxlength="25" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="화장시간">
                                        <input type="text" id="info-cremTime" name="cremTime" title="화장시간" maxlength="25" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="수골시간">
                                        <input type="text" id="info-sugolTime" name="sugolTime" title="수골시간" maxlength="25" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비고">
                                        <textarea type="text" id="info-remark" name="remark" title="비고" class="AXTextarea" value="" style="width: 200%; height: 50px;" ></textarea>
                                    </ax:field>
                                </ax:fields>
                            </ax:form>

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
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.form.bind();
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
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.del();
                        }, 500);
                    });
                },
                save: function(){
                    var validateResult = fnObj.form.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var info = fnObj.form.getJSON();
                    app.ajax({
                        type: "PUT",
                        url: "/STAN1060/saveEnvset",
                        data: Object.toJSON(info)
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
                            fnObj.form.clear();
                        }
                    });
                },
                del: function(){
                	if(!confirm("선택한 운영환경을 삭제하시겠습니까?")){
                		return;
                	}
                	var info = fnObj.form.getJSON();

                	app.ajax({
                        type: "DELETE",
                        url: "/STAN1060/deleteEnvset",
                        data: Object.toJSON(info)
                    },
                    function(res){
                        if(res.error){
                            console.log(res.error.message);
                            alert(res.error.message);
                        }
                        else
                        {
                            toast.push("삭제되었습니다.");
                            fnObj.search.submit();
                            fnObj.form.clear();
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
                                    {label:"작업 일자 :   from", labelWidth:"", type:"inputText", width:"150", key:"from", addClass:"", valueBoxStyle:"",
                                    	value:((function(){var d = new Date(); d.setFullYear(d.getFullYear()-1, 0, 1); return d;})()).print()
                                    	,
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        },
	                                    AXBind       : {
	                        				type: "date"
	                        			}
                                    }
                                    , {label:"to", labelWidth:"", type:"inputText", width:"150", key:"to", addClass:"", valueBoxStyle:"", value:(new Date()).print(),
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        },
	                                    AXBind       : {
	                        				type: "date"
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"workDateString", label:"작업일자", width:"100", align:"center"},
                                {key:"seqNo", label:"일련번호", width:"70", align:"center"},
                                {key:"stdateString", label:"적용시작일", width:"150", align:"center"},
                                {key:"woonguTime", label:"운구시간", width:"70", align:"center"},
                                {key:"byeTime", label:"고별시간", width:"70", align:"center"},
                                {key:"cremTime", label:"화장시간", width:"70", align:"center"},
                                {key:"sugolTime", label:"수골시간", width:"70", align:"center"},
                                {key:"remark", label:"비고", width:"150"}
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
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

                        app.ajax({
                            type: "GET",
                            url: "/STAN1060/findEnvset",
                            data: "dummy="+ axf.timekey() +"&" + (searchParams||fnObj.search.target.getParam())
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

                /*******************************************************
                 * 상세 폼
                 */
                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });

                        // form clear 처리 시
                        $('#ax-form-btn-new').click(function() {
                            fnObj.form.clear()
                        });

                        $('#info-stdateString').bindPattern({pattern: "datetime"});
                        $('#info-woonguTime').bindPattern({
                			pattern: "number",
                			allow_minus: false,
                			max_length: 3,
                			max_round: 0
                		});
                        $('#info-byeTime').bindPattern({
                			pattern: "number",
                			allow_minus: false,
                			max_length: 3,
                			max_round: 0
                		});
                        $('#info-cremTime').bindPattern({
                			pattern: "number",
                			allow_minus: false,
                			max_length: 3,
                			max_round: 0
                		});
                        $('#info-sugolTime').bindPattern({
                			pattern: "number",
                			allow_minus: false,
                			max_length: 3,
                			max_round: 0
                		});
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-workDateString').bindPattern({pattern: "date"});
                        $('#info-workDateString').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
//                         $('#info-workDateString').bindDate();
//                         $('#info-workDateString').removeAttr("readonly");
                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>