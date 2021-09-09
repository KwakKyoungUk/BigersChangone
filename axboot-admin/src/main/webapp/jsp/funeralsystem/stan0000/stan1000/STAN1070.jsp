<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}">
<!--                 	<button type="button" class="AXButton Blue" id="ax-grid-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button> -->
                </ax:custom>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <h2><i class="axi axi-list-alt"></i> ${title }</h2>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px; max-height: 400px;"></div>
                        </ax:custom>
					</ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 정보등록</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                            	<table class='AXFormTable'>
	                   				<colgroup>
	                    				<col width="100"/>
	                    				<col/>
	                    				<col width="100"/>
	                    				<col/>
	                    				<col width="100"/>
	                    				<col/>
	                    				<col width="100"/>
	                    				<col/>
	                    			</colgroup>
	                    			<tr>
	                    				<th><div class='tdRel'>세목구분코드</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:select id="info-gubunCd" name="gubunCd" basicCd="SYEGB"></b:select>
	                   					</div></td>
	                    				<th><div class='tdRel'>구분명</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-gubunNm" name="gubunNm" title="구분명"></b:input>
	                   					</div></td>
	                    				<th><div class='tdRel'>세목코드</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-semokCd" name="semokCd" title="세목코드"></b:input>
	                   					</div></td>
	                    				<th><div class='tdRel'>회계구분</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-ahgubun" name="ahgubun" title="회계구분"></b:input>
	                   					</div></td>
	                    			</tr>
	                    			<tr>
	                    				<th><div class='tdRel'>관</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-gwan" name="gwan" title="관"></b:input>
	                   					</div></td>
	                    				<th><div class='tdRel'>항</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-hang" name="hang" title="항"></b:input>
	                   					</div></td>
	                    				<th><div class='tdRel'>목</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:input id="info-mok" name="mok" title="목"></b:input>
	                   					</div></td>
	                    				<th><div class='tdRel'>사용시작일자</div>
	                    				</th>
	                    				<td><div class='tdRel'>
	                    					<b:inputDate id="info-useStrdate" name="useStrdate" title="사용시작일자"></b:inputDate>
	                   					</div></td>
	                    			</tr>
	                    			<tr>
	                    				<th><div class='tdRel'>비고</div>
	                    				</th>
	                    				<td colspan="7"><div class='tdRel'>
	                    					<b:input id="info-remark" name="remark" title="비고" style="width: 99%;"></b:input>
	                   					</div></td>
                   					</tr>
                    			</table>
                            </ax:form>

                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
//             var resize_elements = [
//                 {id:"page-grid-box", adjust:-37}
//             ];
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
                    this.grid.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.grid.setPage();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.grid.setPage();
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
                        url: "/STAN1070/susemok-cd",
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
                            fnObj.grid.setPage();
                            fnObj.form.clear();
                        }
                    });
                },
                del: function(){
                	if(!confirm("선택한 자료를 삭제하시겠습니까?")){
                		return;
                	}
                	var checkedList = fnObj.grid.target.getCheckedListWithIndex(0);// colSeq

                	app.ajax({
                        type: "DELETE",
                        url: "/STAN1070/susemok-cd",
                        data: Object.toJSON($.map(checkedList, function(o){
                        	return o.item;
                        }))
                    },
                    function(res){
                        if(res.error){
                            console.log(res.error.message);
                            alert(res.error.message);
                        }
                        else
                        {
                            toast.push("삭제되었습니다.");
                            fnObj.grid.setPage();
                            fnObj.form.clear();
                        }
                    });
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
                                {key:"gubunCd", label:"세목구분코드", width:"100", align:"left"},
                                {key:"gubunNm", label:"구분명", width:"100", align:"left"},
                                {key:"semokCd", label:"세목코드", width:"150"},
                                {key:"ahgubun", label:"회계구분", width:"150"},
                                {key:"gwan", label:"관", width:"150"},
                                {key:"hang", label:"항", width:"150"},
                                {key:"mok", label:"목", width:"150"},
                                {key:"useStrdate", label:"사용시작일자", width:"150"},
                                {key:"remark", label:"비고", width:"150"}
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: false,
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
                                dto_list.push(this.item); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/STAN1070/susemok-cd",
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
                            url: "/STAN1070/susemok-cd",
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list,
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
                        $('#info-msgId').attr("readonly", "readonly");

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
                        $('#info-msgId').removeAttr("readonly");
                    }
                } // form
            };
        </script>
    </ax:div>
</ax:layout>