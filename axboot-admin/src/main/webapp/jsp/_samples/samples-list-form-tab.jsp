<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style>
            .cx-tab-content{
                margin-top: 5px;
                display: none;
            }
        </style>
    </ax:div>
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

                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>


                <%-- %%%%%%%%%% 탭 %%%%%%%%%% --%>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 정보등록</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div id="cx-tab-01"></div>


                <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                <form id="form-info" name="form-info" method="get" onsubmit="return false;">

                    <%-- %%%%%%%%%% 탭아이템 01 (기본정보) %%%%%%%%%% --%>
                    <div id="tab-content-01" class="cx-tab-content">
                        <div class="ax-rwd-table">
                            <ax:fields>
                                <ax:field label="코드">
                                    <input type="text" id="info-key" name="key" title="코드" maxlength="8" class="AXInput W100 av-required" value=""/>
                                </ax:field>
                            </ax:fields>
                            <ax:fields>
                                <ax:field label="이름">
                                    <input type="text" id="info-value" name="value" title="이름" maxlength="8" class="AXInput W150 av-required" value=""/>
                                </ax:field>
                            </ax:fields>
                        </div>
                    </div>

                    <%-- %%%%%%%%%% 탭아이템 02 (상세정보) %%%%%%%%%% --%>
                    <div id="tab-content-02" class="cx-tab-content">
                        <div class="ax-rwd-table">
                            <ax:fields>
                                <ax:field label="컬럼1">
                                    <input type="text" id="info-etc1" name="etc1" title="컬럼1" maxlength="25" class="AXInput W150" value="" />
                                </ax:field>
                            </ax:fields>
                            <ax:fields>
                                <ax:field label="날짜">
                                    <input type="text" id="info-etc2" name="etc2" title="날짜" maxlength="10" class="AXInput W100" value="" />
                                </ax:field>
                            </ax:fields>
                            <ax:fields>
                                <ax:field label="선택타입">
                                    <select id="info-etc3" name="etc3" title="선택타입" class="AXSelect"></select>
                                </ax:field>
                            </ax:fields>
                        </div>
                    </div>

                </form>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:function(){
                    return -axf.clientHeight()/3;
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
                    this.search.bind();
                    this.grid.bind();
                    this.tab.bind();
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
                                url: "/api/v1/samples/parent",
                                data: Object.toJSON([info])
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"key", label:"코드", width:"100", align:"left"},
                                {key:"value", label:"이름", width:"150"},
                                {key:"etc1", label:"컬럼1", width:"150"},
                                {key:"etc2", label:"날짜", width:"150"},
                                {key:"etc3", label:"선택타입", width:"150", align:"center",
                                    formatter: function(val){
                                        return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
                                    }
                                }
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
                },


                tab: {
                    select_id:"tab-content-01",
                    bind: function(){
                        var _this = this;
                        $("#cx-tab-01").bindTab({
                            theme : "AXTabs",
                            value:"",
                            options:[
                                {optionValue:"tab-content-01", optionText:"기본정보"},
                                {optionValue:"tab-content-02", optionText:"상세정보"}
                            ],
                            onchange: function(selectedObject, value) {
                                $("#"+_this.select_id).hide();
                                _this.select_id = value;
                                $("#"+_this.select_id).show();
                                $(window).resize(); // axisj 각요소의 정렬을 위해 resize 이벤트 강제 발생
                            }
                        });
                        $("#cx-tab-01").setValueTab(this.select_id);
                    }
                }, // tab


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

                        $('#info-etc2').bindDate().val( (new Date()).print() );

                        $('#info-etc3').bindSelect({
                            reserveKeys: {
                                optionValue: "CD", optionText: "NM"
                            },
                            options: fnObj.CODES.etc3
                        });

                        // form clear 처리 시
                        $('#ax-form-btn-new').click(function() {
                            fnObj.form.clear()
                        });
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-key').attr("readonly", "readonly");

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
                        $('#info-key').removeAttr("readonly");
                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>