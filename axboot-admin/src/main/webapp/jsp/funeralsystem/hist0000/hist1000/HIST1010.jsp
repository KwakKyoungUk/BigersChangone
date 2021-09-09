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

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <h2><i class="axi axi-list-alt"></i> 작업내역</h2>
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 내역</h2>
                                </div>
                                <div class="right">
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="순번">
                                        <input type="text" id="info-id" name="id" title="순번" class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사용자">
                                        <input type="text" id="info-user" name="user" title="사용자" maxlength="8" class="AXInput W150 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="요청 URL" style="width: 100%;">
                                        <input type="text" id="info-requestUrl" name="requestUrl" title="요청 URL" class="AXInput" style="width: 98%;" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="작업내용" style="width: 100%;">
                                        <input type="text" id="info-workContents" name="workContents" title="작업내용" class="AXInput" style="width: 98%;" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="파라미터" style="width: 100%;">
                                        <textarea id="info-parameter" name="parameter" title="파라미터" style="width: 98%; height: 250px;"></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="작업시간">
                                        <input type="text" id="info-requestTime" name="requestTime" title="작업시간" class="AXInput W150" value="" />
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
                CODES: {
                },
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
                    $("#ax-page-btn-excel").bind("click", function(){
                        Common.report.gridToExcel("history", fnObj.grid.target);
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
                                    {label:"사용자", labelWidth:"", type:"inputText", width:"150", key:"user", addClass:"", valueBoxStyle:"", value:"",
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        }
                                    },
                                    {label:"기간", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                                    {label:"작업내용", labelWidth:"", type:"inputText", width:"70", key:"workContents", addClass:"secondItem", valueBoxStyle:"", value: "",
               							onChange: function(){}
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"id", label:"순번", width:"40", align:"left"},
                                {key:"user", label:"유저", width:"100"},
                                {key:"ip", label:"접속아이피", width:"100"},
                                {key:"method", label:"Method", width:"150"},
                                {key:"requestUrl", label:"요청 URL", width:"150"},
                                {key:"parameter", label:"파라미터", width:"150", align:"center",
                                    formatter: function(val){
                                        return this.value ? this.value.replace("\n", "<br/>") : "";
                                    }
                                },
                                {key:"workContents", label:"작업내용", width:"150", align:"center"},
                                {key:"requestTime", label:"요청시간", width:"150", align:"center"}
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/HIST1010/history",
                            data: "dummy="+ axf.timekey()+"&"+(searchParams||fnObj.search.target.getParam())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
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

                    },
                    setJSON: function(item) {
                        var _this = this;

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                    },
                } // form
            };
        </script>
    </ax:div>
</ax:layout>