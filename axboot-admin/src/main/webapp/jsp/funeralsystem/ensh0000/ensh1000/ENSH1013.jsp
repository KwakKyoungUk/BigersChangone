<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="주소변경이력" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 주소변경이력</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-grid" id="page-grid-box" style="min-height: 200px;"></div>

				<ax:form id="info-form" name="info-form">
					<ax:fields>
                        <ax:field label="신청자번호*" style="width:200px;">
                            <input type="number" id="info-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100 av-required" value=""/>
                        </ax:field>
                        <ax:field label="신청자명*" style="width:150px;">
                            <input type="text" id="info-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="신청자국적" style="width:150px;">
                            <select id="info-applNationGb" name="applNationGb" class="AXSelect W100"></select>
                        </ax:field>
                        <ax:field label="신청자 주민번호" style="width:150px;">
                            <input type="text" id="info-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="13" class="AXInput W100" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="휴대폰*" style="width:150px;">
                            <input type="text" id="info-applMobileno1" name="applMobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                            <input type="text" id="info-applMobileno2" name="applMobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                            <input type="text" id="info-applMobileno3" name="applMobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="전화번호" style="width:150px;">
                            <input type="text" id="info-applTelno1" name="applTelno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" readonly="readonly"/>
                            <input type="text" id="info-applTelno2" name="applTelno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" readonly="readonly"/>
                            <input type="text" id="info-applTelno3" name="applTelno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="email">
                            <input type="text" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value="" readonly="readonly" />@<input
                            type="text" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value=""  readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="신청자 주소*">
                            <select id="info-applAddrGubun" name="applAddrGubun" class="AXSelect W50"></select>
                            <input type="text" id="info-applPost" name="applPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" />
                            <input type="text" id="info-applAddr1" name="applAddr1" title="신청자 주소" readonly="readonly" placeholder="" class="AXInput W200 av-required" value="" />
                            <input type="text" id="info-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W400 av-required" value=""  readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="변경일자" style="width:150px;">
                            <input type="text" id="info-changeDateString" name="changeDateString" title="변경일자" placeholder="변경일자" readonly="readonly" class="AXInput W100" value=""/>
                        </ax:field>
                        <ax:field label="등록자" style="width:150px;">
                            <input type="text" id="info-regid" name="regid" title="등록자" readonly="readonly" class="AXInput W100" value=""/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="변경내용" style="width:1000px;">
                            <textarea id="info-remark" name="remark" title="변경내용" placeholder="변경내용" readonly="readonly" class="AXInput" style="width: 98%; height: 150px;"></textarea>
                        </ax:field>
                    </ax:fields>
				</ax:form>
                <div class="ax-button-group">
                    <div class="left">
                    </div>
                    <div class="right">
                    	<!-- <button type="button" class="AXButton" id="btn-report"><i class="axi axi-report"></i> 주소변경신고서</button> -->
                    </div>
                    <div class="ax-clear"></div>
                </div>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
<!-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button> -->
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">

			var fnObj = {
                CODES: {
                	"deadSex": Common.getCode("TCM05"),
                    "addrGubun": Common.getCode("TCM07"),
   					"applNationGb": Common.getCode("TCM11"),
                },

				pageStart: function(){
					this.grid.bind();
					this.bindEvent();
					this.grid.setPage();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
                  	$("#info-applAddrGubun").bindSelect({
	       				options:fnObj.CODES.addrGubun
	       			});
                   	$("#info-applNationGb").bindSelect({
	       				options:fnObj.CODES.applNationGb
	       			});
				},
				grid: {
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
                                {key:"applSeq", label:"순번", width:"35", align:"center" },
                                {key:"applName", label:"신청자명", width:"100", align:"center"},
                                {key:"applJumin", label:"주민번호", width:"100", align:"center"},
                                {key:"applMobileno", label:"휴대폰", width:"100", align:"center"},
                                {key:"applTelno", label:"전화번호", width:"100", align:"center"},
                                {key:"applEmail", label:"이메일", width:"100", align:"center"},
                                {key:"fullAddr", label:"주소", width:"100", align:"center"},
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){
                                	console.log(this);
									fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
//                                 , onchange: function(pageNo){
//                                     _this.setPage(pageNo);
//                                 }
                            }
                        });
                    },
                    setPage: function(){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1013/addrhst/${param.applId}",
                            data: ""
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
                form: {
                    target: $('#info-form'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "info-form"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

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
                    }
                },
				control: {
					save: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("고인을 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

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