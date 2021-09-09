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

                <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                <ax:form id="form-info" name="form-info" method="get">
                    <ax:fields>
                        <ax:field label="테마선택">
                            <select id="info-theme" name="theme" title="테마선택" class="AXSelect"></select>
                        </ax:field>
                    </ax:fields>
                </ax:form>

			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="scripts">
	    <script type="text/javascript">
        var resize_elements = [
            //{id:"page-grid-box", adjust:-97}
        ];
	    var fnObj = {
	        pageStart: function(){
                this.form.bind();
	            this.bindEvent();
	        },
	        bindEvent: function(){
	            var _this = this;
                $("#ax-page-btn-search").bind("click", function(){
                    _this.form.search();
                });
                $("#ax-page-btn-save").bind("click", function(){
                    setTimeout(function() {
                        _this.form.save();
                    }, 500);
                });
                $("#ax-page-btn-excel").bind("click", function(){
                    /*
                    app.modal.excel({
                        pars:"target=${className}"
                    });
                    */
                });
                $("#ax-grid-btn-add").bind("click", function(){
                    //_this.grid.add();
                });
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

                    $('#info-theme').bindSelect({
                        reserveKeys: {
                            optionValue: "CD", optionText: "NM"
                        },
                        options: [
                            {"CD":"ax-boot", NM:"ax-boot"},
                            {"CD":"bigers", NM:"bigers"}
                        ]
                    });

                    // form clear 처리 시
                    /*
                    $('#ax-form-btn-new').click(function() {
                        fnObj.form.clear()
                    });
                    */

                    this.search();
                },
                search: function() {
                    app.ajax({
                        type: "GET",
                        url:"/api/v1/asp/masters",
                        data:""
                    }, function(res){
                        trace(res);
                        $('#info-theme').bindSelectSetValue(res.list[0].theme);
                    });
                },
                save: function() {
                    var data = this.getJSON();
                    //console.log(data);
                    data.id = "AX-BOOT";
                    app.ajax({
                        type: "PUT",
                        url:"/api/v1/asp/masters",
                        data: Object.toJSON([data])
                    }, function(res){
                        toast.push("저장 되었습니다.");
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