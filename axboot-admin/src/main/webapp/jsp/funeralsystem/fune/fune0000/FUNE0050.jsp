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


                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <!-- <h2><i class="axi axi-list-alt"></i> 정보리스트</h2> -->
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="right">
                                    <!-- <button type="button" class="AXButton" id="ax-form-btn-search"><i class="axi axi-search2"></i> 조회</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                            <div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
                            <div class="ax-button-group">

                                <!-- <div class="left">
                                    <h2><i class="axi axi-table"></i> 정보등록</h2>
                                </div> -->
                                <div class="right">
                                	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                    <!-- <button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button>
                                    <button type="button" class="AXButton" id="ax-form-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="세트코드">
                                        <input type="text" id="info-setCode" name="setCode" title="코드"  class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="세트명">
                                        <input type="text" id="info-setName" name="setName" title="이름"  class="AXInput W150 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="순서">
                                        <input type="text" id="info-sortNo" name="sortNo" title="컬럼1" class="AXInput W100" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="메모">
                                        <input type="text" id="info-remark" name="remark" title="날짜" class="AXInput W300" value="" />
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
                    //this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;

                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");

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

                    $("#info-sortNo").bindNumber();


                    $("#ax-form-btn-search").on("click", function(){
                    	_this.search.submit();
                    });

                    $("#ax-form-btn-new").on("click", function(){
                    	_this.form.clear();
                    	$("#info-setCode").focus();
                    });

					$("#ax-form-btn-save").on("click", function(){
					    _this.save();
                    });

					$("#ax-form-btn-del, #ax-page-btn-fn1").on("click", function(){
						_this.form.del();
					});





                },
                save: function(){

                	var partCode = fnObj.form.selectedPartCode;
                    if(partCode == "" || partCode == null){
                    	alert("파트를 선택해주세요.");
                    	return;
                    }

                    var validateResult = fnObj.form.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var info = fnObj.form.getJSON();
                    info.partCode = partCode;

                    app.ajax({
                        type: "PUT",
                        url: "/FUNE0050/setGroup",
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
                                    {label:"파트", labelWidth:"", type:"selectBox", width:"150", key:"partCode", addClass:"", valueBoxStyle:"", value:"close", options:[],


                                    	AXBind: {
                                            type: "select", config: {

                                                reserveKeys: {
                                                      options: "list",
                                                      optionValue: "partCode",
                                                      optionText: "partName"
                                                   },

                                              ajaxUrl: "/FUNE0050/part",
                                              ajaxPars: null,
                                              setValue: "",
                                              alwaysOnChange: true,
                                              onChange: function() {
                                            	 // trace(this);
                                            	 _this.submit();
                                            	 fnObj.form.selectedPartCode = this.optionValue;

                                              }
                                            }
                                        }

										/* options:[
			                                {optionValue:"all", optionText:"전체 보기"},
			                                {optionValue:'5001', optionText:'강서 사무소'},
			                                {optionValue:"open", optionText:"공개"},
			                                {optionValue:"close", optionText:"비공개"}
			                            ], */
									}
                                ]},
                                {display:true, addClass:"", style:"", list:[
					                 {label:"세트코드", labelWidth:"", type:"inputText", width:"150", key:"setCode", addClass:"", valueBoxStyle:"", value:"",
					                     onChange: function(changedValue){
					                         //아래 2개의 값을 사용 하실 수 있습니다.
					                         //toast.push(Object.toJSON(this));
					                         //dialog.push(changedValue);
					                    	 _this.submit();
					                     }
					                 }
					             ]},

					             {display:true, addClass:"", style:"", list:[
	                                 {label:"세트명", labelWidth:"", type:"inputText", width:"300", key:"setName", addClass:"", valueBoxStyle:"", value:"",
	                                     onChange: function(changedValue){
	                                         //아래 2개의 값을 사용 하실 수 있습니다.
	                                         //toast.push(Object.toJSON(this));
	                                         //dialog.push(changedValue);
	                                    	 _this.submit();
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
                                {key:"setCode", label:"코드", width:"100", align:"center"},
                                {key:"setName", label:"세트명", width:"150", align:"left"},
                                {key:"sortNo", label:"순서", width:"150", align:"center"},
                                {key:"remark", label:"메모", width:"150", align:"left"}
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                    fnObj.form.selectedCell = this.item;
                                    $("#info-setCode").prop("readonly", true);
                                }
                            }
                           /*  page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
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
                            url: "/FUNE0050/setGroup",
                            data: searchParams
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
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
                    selectedCel : null,
                    selectedPartCode: null,
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
                        $('#info-setCode').attr("readonly", "readonly");

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
                        $('#info-setCode').removeAttr("readonly");
                        this.selectedCell = null;
                    },

                    del: function(){
                    	if(this.selectedCell == null){
                    		alert("삭제할 품목분류코드를 선택하세요.");
                    		return;
                    	}

                    	if(!confirm("정말로 삭제하시겠습니까?")){
                    		return;
                    	}

                    	var info = this.selectedCell;

                    	app.ajax({
                    		url:"/FUNE0050/setGroup",
                    		type:"DELETE",
                    		data:Object.toJSON(info)
                    	}, function(res){
                    		toast.push("삭제하였습니다.");
                    		fnObj.search.submit();
                    	});

                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>