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
                        <h2><i class="axi axi-list-alt"></i> 시설정보설정관리</h2>
                    </div>
                </div>
                <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="시설ID">
                                        <input type="text" id="info-facId" name="facId" title="시설ID" maxlength="10"  placeholder="필수" class="AXInput W100 av-required" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="시설명">
                                        <input type="text" id="info-facName" name="facName" title="시설명칭" maxlength="100" class="AXInput W150" value=""/>
                                    </ax:field>
                                </ax:fields>
                                 <ax:fields>
                                     <ax:field label="서식대표명">
                                        <input type="text" id="info-repName" name="repName" title="서식대표명" maxlength="100"  class="AXInput W150" value=""/>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="시설명칭">
                                        <input type="text" id="info-prName" name="prName" title="시설명칭" maxlength="100" class="AXInput W150" value=""  />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사업자등록번호">
                                        <input type="text" id="info-regNum" name="regNum" title="사업자등록번호" maxlength="100" class="AXInput W150" value=""  />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="대표전화">
                                     	<input type="text" id="info-telNo" name="telNo" title="대표전화" maxlength="50" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="대표팩스">
                                        <input type="text" id="info-faxNo" name="faxNo" title="대표팩스" maxlength="50" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="장례식장전화">
                                     	<input type="text" id="info-telNoFune" name="telNoFune" title="장례식장전화" maxlength="50" class="AXInput W150" value="" />
                                    </ax:field>
                                    <ax:field label="화장전화">
                                     	<input type="text" id="info-telNoCrem" name="telNoCrem" title="화장전화" maxlength="50" class="AXInput W150" value="" />
                                    </ax:field>
                                    <ax:field label="봉안전화">
                                     	<input type="text" id="info-telNoEnsh" name="telNoEnsh" title="봉안전화" maxlength="50" class="AXInput W150" value="" />
                              	  	</ax:field>
                           	     	<ax:field label="자연장전화">
                                    	<input type="text" id="info-telNoNatu" name="telNoNatu" title="자연장전화" maxlength="50" class="AXInput W150" value="" />
                              	  	</ax:field>

                                </ax:fields>

                                <ax:fields>
                                    <ax:field label="우편번호">
                                     	<input type="text" id="info-postNo" name="postNo" title="우편번호" maxlength="6" class="AXInput W150" value="" />
                                     	<button type="button" class="AXButton" id="btn-post"><i class="axi axi-local-post-office"></i> 우편번호</button>
 						           </ax:field>
                                </ax:fields>
                                 <ax:fields>
                                 	<ax:field label="주소">
                                     	<input type="text" id="info-addr1" name="addr1" title="주소1" maxlength="200" class="AXInput W300" value="" />
 						              	<input type="text" id="info-addr2" name="addr2" title="주소2" maxlength="200" class="AXInput W300" value="" />
  						           </ax:field>
                                 </ax:fields>
                                <ax:fields>
                                        <ax:field label="ocr 시작 번호">
			                            <input type="text" id="info-ocrSeq" name="ocrSeq" title="주소2" maxlength="200" class="AXInput W300" value="" />
			                        </ax:field>
                                </ax:fields>
                                <ax:fields>
                                        <ax:field label="합장요금계산방법">
			                            <select class="AXSelect" id="info-addCalc"></select>
			                        </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="화로수">
                                        <input type="number" id="info-roCnt" name="roCnt" title="화로수" maxlength="2" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="화로운영담당자">
                                        <input type="text" id="info-roDamdang" name="roDamdang" title="화로운영담당자" maxlength="20" class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="개인단수">
                                        <input type="number" id="info-single" name="single" title="개인단수"  class="AXInput W150" value="" />
                                    </ax:field>
                                    <ax:field label="부부단수">
                                        <input type="number" id="info-couple" name="couple" title="부부단수"  class="AXInput W150" value="" />
                                    </ax:field>
                                    <ax:field label="무연단수">
                                        <input type="number" id="info-unRel" name="unRel" title="무연단수"  class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="잔디장 개인단수">
                                        <input type="number" id="info-grassSingle" name="grassSingle" title="잔디장 개인단수" class="AXInput W150" value="" />
                                    </ax:field>
                                     <ax:field label="잔디장 부부단수">
                                        <input type="number" id="info-grassCouple" name="grassCouple" title="잔디장 부부단수" class="AXInput W150" value="" />
                                    </ax:field>
                                    <ax:field label="수목장수">
                                        <input type="number" id="info-tree" name="tree" title="수목장수"  class="AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                <ax:field label="비고">
                                        <input type="text" id="info-remark" name="remark" title="비고"  maxlength="200" class="AXInput W300" />
                                    </ax:field>
                                </ax:fields>
                            </ax:form>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {

                CODES: {
                    "addCalc": [
                        {CD:'1', NM:"첫번째고인만 적용"},
                        {CD:'2', NM:"각각적용"},
                    ],
                    "_addCalc": {"1":"첫번째고인만 적용", "2":"각각적용"}
                },
                pageStart: function(){
                    this.search.bind();
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

                    $("#btn-post").bind("click", function(){
                    	daumPopPostcode("info-postNo", "info-addr1", "info-addr2");
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
                         url: "/STAN1010/saveFac",
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
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.setPage(1, pars);
                    }
                },
                del : function (){
                	if(!confirm("시설정보를 삭제하시겠습니까?")){
                		return;
                	}

                	app.ajax({
                        type: "DELETE",
                        url: "/STAN1010/deleteFac",
                    }, function(res){
                        if(res.error){
                           alert(res.error.message);
                        }
                        else
                        {
                            toast.push("삭제 되었습니다.");
                            fnObj.search.submit();
                        }
                    });
                },
                setPage: function(){
                    var _target = this.target;
                    app.ajax({
                         type: "GET",
                         url: "/STAN1010/findFac",
                     }, function(res){
                         if(res.error){
                            alert(res.error.message);
                         }
                         else
                         {
                             fnObj.form.setJSON(res.list[0]);
                         }
                     });
                },
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
                            fnObj.form.clear();
                        });

                        $('#info-addCalc').bindSelect({
                            reserveKeys: {
                                optionValue: "CD", optionText: "NM"
                            },
                            options: fnObj.CODES.addCalc
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-facId').attr("readonly", "readonly");

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
                        $('#info-facId').removeAttr("readonly");
                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>