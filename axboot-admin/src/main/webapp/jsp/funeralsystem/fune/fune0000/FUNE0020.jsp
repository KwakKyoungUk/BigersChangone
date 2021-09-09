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

                            <div class="ax-button-group">
                            	<div class="right">
                                	<!-- <button type="button" class="AXButton" id="ax-form-btn-new2"><i class="axi axi-search2"></i> 조회</button> -->
                            	</div>
                            </div>

							<div class="ax-search" id="page-search-box"></div>
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
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
                                    <ax:field label="거래처코드">
                                        <input type="text" id="info-custCode" name="custCode" title="거래처코드"  class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="거래처명">
                                        <input type="text" id="info-custName" name="custName" title="거래처명"  class="AXInput av-required" value="" style="width:200px;"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사업자등록번호">
                                        <input type="text" id="info-registNo" name="registNo" title="사업자등록번호"  class="AXInput W100" value="" style="width:200px;"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="대표자명">
                                        <input type="text" id="info-personName" name="personName" title="대표자명"  class="AXInput W100" value="" style="width:200px;"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="주민등록번호">
                                        <input type="text" id="info-personNo" name="key" title="주민등록번호"  class="AXInput W100" value="" style="width:200px;"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사업장소재지">
                                        <input type="text" id="info-addr" name="addr" title="사업장소재지"  class="AXInput W100" value="" style="width:200px;"/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="주소">
                                    	<!-- <input type="text" id="info-what1" name="what1" title="주소"  class="AXInput W100 av-required" value=""/> -->
                                    	<input type="text" id="info-post" class="AXInput W60" readonly>
			        					<input class="AXButton" type="button" onclick="fnObj.popPostcode()" value="우편번호 찾기" >
                                        <input type="text" id="info-addr1" name="addr1" title="주소"  class="AXInput W400" value="" readonly/>
                                        <br/><span style="margin-right: 150px;">&nbsp;</span>
                                        <input type="text" id="info-addr2" name="addr2" title="상세주소"  class="AXInput" value="" style="width:400px;" />
                                    </ax:field>
                                </ax:fields>
                                 <ax:fields>
                                    <ax:field label="업태">
                                        <input type="text" id="info-job01" name="job01" title="업태"  class="AXInput W200" value=""/>
                                    </ax:field>
                                    <ax:field label="종목">
                                        <input type="text" id="info-job02" name="job02" title="종목"  class="AXInput W200" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="전화번호">
                                        <input type="text" id="info-telNo" name="telNo" title="전화번호"  class="AXInput W200" value=""/>
                                    </ax:field>
                                    <ax:field label="팩스번호">
                                        <input type="text" id="info-faxNo" name="faxNo" title="팩스번호"  class="AXInput W200" value=""/>
                                    </ax:field>
                                </ax:fields>

                                <ax:fields>
                                    <ax:field label="정렬순서">
                                        <input type="text" id="info-sortNo" name="sortNo" title="정렬순서"  class="AXInput W200" value=""/>
                                    </ax:field>
                                    <ax:field label="계약금액">
                                        <input type="text" id="info-contAmt" name="contAmt" title="계약금액"  class="AXInput W200" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="면세구분">
                                        <select id="info-custKindCode" class="AXInput W200" name="custKindCode" title="면세구분"></select>
                                        <input type="checkbox" id="info-vatFlg" name="vatFlg" title="부가세포함여부" class="AXInput" value="1" />
                                        <label for="info-vatFlg">부가세포함여부</label>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="메모">
                                        <input type="text" id="info-remark" name="remark" title="메모"  class="AXInput W400" value=""/>
                                    </ax:field>

                                    <ax:field label="사용여부">
                                        <select id="info-useFlg" class="AXInput W100" name="useFlg" title="사용여부"></select>
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
    	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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

                    $("#ax-form-btn-new").bind("click", function(){
                    	_this.form.clear();
                    });

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

                    $("#info-custKindCode").bindSelect({
                   		options:[
          					{optionValue:"00", optionText:"과세업체"},
          					{optionValue:"01", optionText:"면세업체"},

             			],
                        onChange: function(){
                            //toast.push(Object.toJSON(this));

                        }
                    });

                    $("#info-useFlg").bindSelect({
                   		options:[
          					{optionValue:"Y", optionText:"사용"},
          					{optionValue:"N", optionText:"중지"},

             			],
                        onChange: function(){
                            //toast.push(Object.toJSON(this));

                        }
                    });


                    $("#info-sortNo").bindNumber();

					$("#ax-page-btn-fn1").on("click", function(){
						fnObj.grid.del();
					});

					$("#ax-form-btn-save").on("click", function(){
						fnObj.save();
					});

                    $("#ax-form-btn-del, ax-page-btn-fn1").on("click", function(){
                    	fnObj.form.del();
                    });

                },
                save: function(){

					var partCode         = fnObj.form.selectedPartCode;
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
                    //trace(Object.toJSON([info]));
                    app.ajax({
                        type: "PUT",
                        url: "/FUNE0020/customer",
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
                                    {label:"파트", labelWidth:"60", type:"selectBox", width:"120", key:"partCode", addClass:"", valueBoxStyle:"", value:"close", options:[],


                                    	AXBind: {
                                            type: "select", config: {
                                                reserveKeys: {
                                                      options: "list",
                                                      optionValue: "partCode",
                                                      optionText: "partName"
                                                   },
                                              ajaxUrl: "/FUNE0020/part",
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
									},

                                    {label:"거래처코드", labelWidth:"", type:"inputText", width:"80", key:"custCode", addClass:"", valueBoxStyle:"", value:"",
                                        onChange: function(changedValue){
                                            //아래 2개의 값을 사용 하실 수 있습니다.
                                            //toast.push(Object.toJSON(this));
                                            //dialog.push(changedValue);
                                        	_this.submit();
                                        }
                                    },
                                   {label:"거래처명", labelWidth:"", type:"inputText", width:"180", key:"custName", addClass:"", valueBoxStyle:"", value:"",
                                       onChange: function(changedValue){
                                           //아래 2개의 값을 사용 하실 수 있습니다.
                                           //toast.push(Object.toJSON(this));
                                           //dialog.push(changedValue);
                                    	   _this.submit();
                                 	}
                                 }
                               ]}
                            ],

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
                                {key:"custCode", label:"코드", width:"100", align:"left"},
                                {key:"custName", label:"거래처명", width:"150", align:"left"},
                                {key:"registNo", label:"사업자등록번호", width:"150", align:"center"},
                                {key:"personName", label:"대표자", width:"150", align:"left"},
                                {key:"job01", label:"업태", width:"150", align:"left"},
                                {key:"job02", label:"종목", width:"150", align:"left"}
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                    fnObj.form.selectedCell = this.item;
                                    $("#info-vatFlg").prop("checked", this.item.vatFlg == 1);
                                    $("#info-useFlg").prop("checked", this.item.useFlg == 'Y');
                                    $("#info-custCode").prop("readonly", true);
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
                	    if(!confirm("선택한 거래처를 삭제하시겠습니까?")){
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
                              dto_list.push(this.item); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                          nextFn(); // 스크립트로 목록 제거
                        } else {
                           app.ajax({
                           type: "DELETE",
                           url: "/FUNE0020/customer",
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
                            url: "/FUNE0020/customer",
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
                    selectedCell: null,
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
                            fnObj.form.clear();
                            $("#info-custCode").focus();
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');

                        $("#info-vatFlg").val(1);

                        $("#info-vatFlg").prop("checked", item.vatFlg == 1);

                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                    	var item = app.form.serializeObjectWithIds(this.target, 'info-');
                    	$("[id^='info-']").each(function(i,o){
                    		if($(o).attr("type") == "checkbox"){
                    			if(o.checked){
	                    			item[$(o).attr("id").substring('info-'.length)] = 1
                    			}else{
                    				item[$(o).attr("id").substring('info-'.length)] = 0;
                    			}
                    		}
                   		});
                    	return item;
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        $('#info-custCode').removeAttr("readonly");

                    },

                 //   del: function(){

                 //   	var info = this.selectedCell;

                 //   	if(info == null){
                 //   		return;
                 //   	}


                 //   	if(!confirm("정말로 삭제하시겠습니까?")){
                 //   		return;
                 //   	}

                  //  	app.ajax({
                 //   		url:"/FUNE0020/deleteCust",
                 //   		type:"DELETE",
                 //   		data:Object.toJSON(info)
                 //   	}, function(res){
                 //   		//trace("success");
                 //   		toast.push("삭제하였습니다.");
                 //   		fnObj.search.submit();
                 //   	});


                  //  } */

                }, // form

                popPostcode : function(){

                	new daum.Postcode({
	                    oncomplete: function(data) {

	                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                        var fullAddr = ''; // 최종 주소 변수
	                        var extraAddr = ''; // 조합형 주소 변수

	                        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                            fullAddr = data.roadAddress;

	                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                            fullAddr = data.jibunAddress;
	                        }

	                        // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                        if(data.userSelectedType === 'R'){
	                            //법정동명이 있을 경우 추가한다.
	                            if(data.bname !== ''){
	                                extraAddr += data.bname;
	                            }
	                            // 건물명이 있을 경우 추가한다.
	                            if(data.buildingName !== ''){
	                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                            }
	                            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                        }

	                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                        $('#info-post').val(data.zonecode); //5자리 새우편번호 사용
	                        $('#info-addr1').val(fullAddr);

	                        // 커서를 상세주소 필드로 이동한다.
	                        $('#info-addr2').focus();

	                        $('#data').val(Object.toJSON(data));
	                    }
//                 		, theme: {
//                 	        searchBgColor: "#0B65C8", //검색창 배경색
//                 	        queryTextColor: "#FFFFFF" //검색창 글자색
//                 	    }

	                }).open();
                },


            };
        </script>
    </ax:div>
</ax:layout>