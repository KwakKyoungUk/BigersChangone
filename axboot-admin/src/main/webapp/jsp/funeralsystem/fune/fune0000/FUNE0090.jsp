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
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="left">
                                </div>
                                <div class="right">
                                    <!-- <button type="button" class="AXButton" id="ax-form-btn-search"><i class="axi axi-seach2"></i> 조회</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                            <div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="left">
                                	<button type="button" class="AXButton" id="btn-modalAddRecipeItem">상세목록등록</button>
                                </div>
                                <div class="right">
                                	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                    <!-- <button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-plus-circle"></i> 저장</button>
                                    <button type="button" class="AXButton" id="ax-form-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="생산제품">
                                        <input type="text" id="info-itemCode" name="itemCode" title="생산제품22"  class="AXInput W100 av-required" value=""/>
                                        <input type="text" id="info-itemName" name="itemName" title="생산제품33"  class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="레시피코드">
                                        <input type="text" id="info-recipeCode" name="recipeCode" title="레시피코드"  class="AXInput W150 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>

                                <div style="height:10px;">&nbsp;</div>

                                <ax:fields>
                                    <ax:field label="레시피명">
                                        <input type="text" id="info-recipeName" name="recipeName" title="레시피명"  class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="자동생산옵션">
                                        <select id="info-autoCode" name="autoCode" class="AXInput" title="자동생산옵션"></select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="자동생산기간">
                                        <input type="text" id="info-autoStDate" name="autoStDate" title="자동생산시작" maxlength="25" class="AXInput W100" value="" />
                                        <input type="text" id="info-autoEdDate" name="autoEdDate" title="자동생산종료" maxlength="25" class="AXInput W100" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="메모">
                                        <input type="text" id="info-remark" name="remark" title="메모" class="AXInput " style="width:250px;" value="" />
                                    </ax:field>
                                </ax:fields>


                                <input type="hidden" name="basicCd" value="060" />
                                <input type="hidden" id="info-partCode" name="partCode" value="" />
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
                    this.selectFirstPartCode();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");

                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });

                    $("#ax-form-btn-save, #ax-page-btn-save").bind("click", function(){
                    	fnObj.save();
                    });

                    $("#ax-form-btn-del, #ax-page-btn-fn1").bind("click", function(){
                    	fnObj.del();
                    });

                    $("#ax-form-btn-search, #ax-page-btn-search").bind("click", function(){
                    	fnObj.search.submit();
                    });

                    $("#btn-modalAddRecipeItem").bind("click", function(){
                    	app.modal.open({
                            url:"FUNE0091.jsp",
                            pars:"callBack=&m=searchRecipeItem&partCode="+Common.search.getValue(fnObj.search.target, "partCode")
                            			+"&itemCode="+$("#info-itemCode").val()
                            			+"&itemName="+$("#info-itemName").val()
                            			+"&recipeCode="+$("#info-recipeCode").val()
                            			+"&recipeName="+$("#info-recipeName").val()
                            			, // callBack 말고
                            //width:500, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                    })
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
                        url: "/FUNE0090/recipe",
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

                del: function(){

                	var recipeCode = $("#info-recipeCode").val();

                	if(recipeCode == "" || recipeCode == null){
                		return;
                	}

                	if(!confirm("삭제하시겠습니까?")){
                		return;
                	}

                	var info = fnObj.form.getJSON();

                	app.ajax({
                		url:"/FUNE0090/recipe",
                		type:"delete",
                		data:Object.toJSON(info)
                	},function(res){
                		fnObj.form.clear();
                		toast.push("삭제되었습니다.");
                		fnObj.search.submit();


                	});

                },

                selectFirstPartCode: function(){
					setTimeout(function() {
						var partCode = $("#"+ fnObj.search.target.getItemId("partCode")).val();
						$("#info-partCode").val(partCode);
						fnObj.search.setItemSelectOptions(partCode);
					}, 1000);

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

									          ajaxUrl: "/FUNE0030/part",
									          ajaxPars: null,
									          setValue: "",
									          onChange: function() {
									        	 // trace(this);

									        	 fnObj.search.setItemSelectOptions(this.optionValue);
									        	 $("#info-partCode").val(this.optionValue);
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
									{label:"생산제품", labelWidth:"100", type:"selectBox", width:"", key:"itemCode", addClass:"", valueBoxStyle:"", value:"close",
										options:[],
										AXBind:{
											type:"select", config:{
												onchange:function(){
													//toast.push(Object.toJSON(this));
													_this.submit();
													fnObj.form.reflectItemCode();
												}
											}
										}
									}

		                        ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    },

                    setItemSelectOptions: function(partCode){

						/* 첫 번째 셀렉트박스 옵션 선택에 따른 두 번째 셀렉트박스 옵션 동적 변화 */

						$("#"+fnObj.search.target.getItemId("itemCode")).unbindSelect();
						setTimeout(function(){
							$("#"+fnObj.search.target.getItemId("itemCode")).bindSelect({
								reserveKeys: {
									options: "list",
									optionValue: "itemCode",
									optionText: "itemName"
								},
								ajaxUrl: "/FUNE0090/item?partCode="+partCode,
								//ajaxPars: "",
								onchange: function(){
									//trace("change : " + Object.toJSON(this));
									// 폼을 전송한다.
									setTimeout(function(){
										fnObj.form.reflectItemCode();
										fnObj.search.submit();
									}, 200);
								}
							})
						}, 200)
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
                                {key:"recipeCode", label:"레시피코드", width:"100", align:"center"},
                                {key:"recipeName", label:"레시피명", width:"100", align:"center"},
                                {key:"autoCodeText", label:"자동생산옵션", width:"100", align:"center"},
                                {key:"autoStDateText", label:"생산시작일", width:"100", align:"center"},
                                {key:"autoEdDateText", label:"생산종료일", width:"100", align:"center"},
                                {key:"remark", label:"메모", width:"100", align:"left"}
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
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
                            url: "/FUNE0090/recipe",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
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
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });

                        // form clear 처리 시
                        $('#ax-form-btn-new').click(function() {
                            fnObj.form.clear()
                        });

						$("#info-autoCode").bindSelect({
							reserveKeys: {
								options: "list",
								optionValue: "code",
								optionText: "name"
							},
							ajaxUrl: "/FUNE0090/auto-code-options",
							//ajaxPars: "",
							onchange: function(){
								//trace("change : " + Object.toJSON(this));
							}
						});

                       	$("#info-autoStDate").bindDate().val((new Date()).print());
                       	$("#info-autoEdDate").bindDate().val((new Date()).print());

                    },

                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-itemCode').attr("readonly", "readonly");
                        $('#info-recipeCode').attr("readonly", "readonly");
                        $("#info-itemName").attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );

                       	// $("#info-itemName");

                       	$("#info-autoStDate").val(item.autoStDateText);
                       	$("#info-autoEdDate").val(item.autoEdDateText);

                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        $('#info-recipeCode').removeAttr("readonly");
                        fnObj.form.reflectItemCode();
                    },

                    reflectItemCode: function(){
                    	var itemCode = $("#"+fnObj.search.target.getItemId("itemCode")).val();
                    	var itemName = $("#"+fnObj.search.target.getItemId("itemCode") + " option:selected").text();

                    	$("#info-itemCode").val(itemCode);
                        $("#info-itemName").val(itemName);

                    	var partCode = $("#"+fnObj.search.target.getItemId("partCode")).val();
                        $("#info-partCode").val(partCode);

                    	$('#info-itemCode').attr("readonly", "readonly");
                        $("#info-itemName").attr("readonly", "readonly");





                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>