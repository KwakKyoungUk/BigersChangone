<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("itemIndex", request.getParameter("itemIndex"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="정보등록" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 정보등록</h2>
                    </div>
                    <div class="right">

                    </div>
                    <div class="ax-clear"></div>
                </div>

                <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                <ax:form id="form-info" name="form-info" method="get">
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
                </ax:form>


			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">확인</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var callBackName = "${callBack}";
			var itemIndex = "${itemIndex}";

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
					this.form.bind();

                    var item = parent.fnObj.grid.target.list[itemIndex];
                    fnObj.form.setJSON(item);

					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

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
                }, // form

				control: {
					save: function(){

                        var validateResult = fnObj.form.validate_target.validate();
                        if (!validateResult) {
                            var msg = fnObj.form.validate_target.getErrorMessage();
                            axf.alert(msg);
                            fnObj.form.validate_target.getErrorElement().focus();
                            return false;
                        }

                        var info = fnObj.form.getJSON();
						app.modal.save(window.callBackName, info, itemIndex);
					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>