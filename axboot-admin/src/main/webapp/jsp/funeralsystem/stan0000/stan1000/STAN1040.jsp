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
                            <h2><i class="axi axi-list-alt"></i> 서식기준정보관리</h2>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 서식기준정보 상세</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="문서코드">
                                        <input type="text" id="info-docCode" name="docCode" title="문서코드" maxlength="15"  placeholder="필수" class="AXInput W100 av-required" value=""/>
                                    </ax:field>

                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="문서명">
                                        <input type="text" id="info-docName1" name="docName1" title="문서명1" maxlength="100" placeholder="필수" class="AXInput W150 av-required" value=""/>
                                    </ax:field>
                                      <ax:field label="추가 문서명">
                                        <input type="text" id="info-docName2" name="docName2" title="문서명2" maxlength="100"  class="AXInput W150" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="내용1">
                                        <textarea type="text" id="info-line1" name="line1" title="내용1" maxlength="2000" class="AXTextarea" value=""  rows="3" cols="70"></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="구비서류1">
                                     	<textarea type="text" id="info-paper1" name="paper1" title="구비서류1" maxlength="200" class="AXTextarea" value="" rows="5" cols="70" ></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="내용2">
                                        <textarea type="text" id="info-line2" name="line2" title="내용2" maxlength="2000" class="AXTextarea" value="" rows="3" cols="70" ></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                        <ax:field label="구비서류2">
                                     	<textarea type="text" id="info-paper2" name="paper2" title="구비서류2" maxlength="200" class="AXTextarea" value="" rows="5" cols="70" ></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="내용3">
                                        <textarea type="text" id="info-line3" name="line3" title="내용" maxlength="2000" class="AXTextarea" value="" rows="3" cols="70" ></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                        <ax:field label="구비서류3">
                                     	<textarea type="text" id="info-paper3" name="paper3" title="구비서류3" maxlength="200" class="AXTextarea" value="" rows="5" cols="70" ></textarea>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="구비서류4">
                                        <input type="text" id="info-paper4" name="paper4" title="구비서류4" maxlength="200" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="구비서류5">
                                        <input type="text" id="info-paper5" name="paper5" title="구비서류5" maxlength="200" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="발행인">
                                        <input type="text" id="info-publisher" name="publisher" title="발행인" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="필드1">
                                        <input type="text" id="info-field1" name="field1" title="field1" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="필드2">
                                        <input type="text" id="info-field2" name="field2" title="field2" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="필드3">
                                        <input type="text" id="info-field3" name="field3" title="field3" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="필드4">
                                        <input type="text" id="info-field4" name="field4" title="field4" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="필드5">
                                        <input type="text" id="info-field5" name="field5" title="field5" maxlength="100" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비고">
                                        <textarea type="text" id="info-remark" name="remark" title="비고"  maxlength="200" class="AXTextarea" ></textarea>
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
                        url: "/STAN1040/saveDoc",
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
                	if(!confirm("선택한 문서정보를 삭제하시겠습니까?")){
                		return;
                	}
                	var info = fnObj.form.getJSON();

                	app.ajax({
                        type: "DELETE",
                        url: "/STAN1040/deleteDoc?docCode="+info.docCode,
                        data: null
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

                                	{label:"검색조건", labelWidth:"", type:"selectBox", width:"150", key:"condition", addClass:"", valueBoxStyle:"", value:"",
                                    	options:[
                                                 {optionValue:"docCode", optionText:"문서코드"},
                                                 {optionValue:"docName", optionText:"문서명"},
                                             ],
               							AXBind:{
               								type:"select", config:{
               									onchange:function(){

               									}
               								}
               							}
                                    },
                                    {label:"", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:"",
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
                                {key:"docCode", label:"문서코드", width:"100", align:"left"},
                                {key:"docName1", label:"문서명1", width:"150"},
                                {key:"docName2", label:"문서명2", width:"150"},
                                {key:"line1", label:"내용1", width:"150"},
                                {key:"line2", label:"내용2", width:"150"},
                                {key:"line3", label:"내용3", width:"150"},
                                {key:"paper1", label:"구비서류1", width:"150"},
                                {key:"paper2", label:"구비서류2", width:"150"},
                                {key:"paper3", label:"구비서류3", width:"150"},
                                {key:"paper4", label:"구비서류4", width:"150"},
                                {key:"paper5", label:"구비서류5", width:"150"},
                                {key:"publisher", label:"발행인", width:"150"},
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/STAN1040/findDoc",
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
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-docCode').attr("readonly", "readonly");

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
                        $('#info-docCode').removeAttr("readonly");
                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>