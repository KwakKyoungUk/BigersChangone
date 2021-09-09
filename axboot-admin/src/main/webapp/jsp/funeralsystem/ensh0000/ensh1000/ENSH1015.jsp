<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="승계" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 사용승계관리</h2>
                    </div>
                    <div class="right">
                    	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-delete"><i class="axi axi-minus-circle"></i> 삭제</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-grid" id="div-grid-enssucced" style="min-height: 150px;"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 피승계자</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<ax:form id="info-form-applicant" name="info-form-applicant">
					<ax:fields>
                        <ax:field label="신청자번호*" style="width:170px;">
                            <input type="number" id="info-beforeApplicant-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100 av-required" value=""/>
                        </ax:field>
                        <ax:field label="신청자명*" style="width:170px;">
                            <input type="text" id="info-beforeApplicant-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="신청자 주민번호" style="width:170px;">
                            <input type="text" id="info-beforeApplicant-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="13" class="AXInput W100" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                    <ax:field label="휴대폰*" style="width:170px;">
                            <input type="text" id="info-beforeApplicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="전화번호" style="width:170px;">
                            <input type="text" id="info-beforeApplicant-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="신청자국적" style="width:170px;">
                            <select id="info-beforeApplicant-nationGb" name="nationGb" class="AXSelect W100"></select>
                        </ax:field>
                        <ax:field label="신청자 주소*">
                            <select id="info-beforeApplicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
                            <input type="text" id="info-beforeApplicant-applPost" name="applPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-applAddr1" name="applAddr1" title="신청자 주소" readonly="readonly" placeholder="" class="AXInput W250 av-required" value="" readonly="readonly"/>
                            <input type="text" id="info-beforeApplicant-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W250 av-required" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="사망자와의 관계*" style="width:310px;">
                            <select id="info-beforeApplicant-deadRelation" name="deadRelation" class="AXSelect W160"></select>
                            <input type="text" id="info-beforeApplicant-deadRelationNm" name="deadRelationNm" title="사망자와의 관계" maxlength="10" placeholder="사망자와의 관계" class="AXInput W100 av-required" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="특이사항" style="width:98%;">
                        	<input type="text" id="info-beforeApplicant-applRemark" name="applRemark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 98%;" value="" readonly="readonly"/>
                    	</ax:field>
                    </ax:fields>
				</ax:form>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 승계자</h2>
                    </div>
                    <div class="right">
                    	<button type="button" class="AXButton" id="btn-reportENSH1010_1"><i class="axi axi-report"></i> 사용승계신청서</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<ax:form id="info-form-enssucced" name="info-form-enssucced">
					<input id="info-applicant-applBirth" type="hidden" name="applBirth"/>
					<input id="info-applicant-applEmail" type="hidden" name="applEmail"/>
					<input id="info-applicant-smsFlag" type="hidden" name="smsFlag"/>
					<input id="info-applicant-applRemark" type="hidden" name="applRemark"/>
					<input id="info-beforeApplicant-applEmail" type="hidden" name="applRemark"/>
					<input type="hidden" id="info-enssucced-ensDate" name="ensDate" value="${param.ensDate}">
					<input type="hidden" id="info-enssucced-ensSeq" name="ensSeq" value="${param.ensSeq}">
                    <input type="hidden" id="info-applicant-applId" name="applId" value="${param.applId }"/>
					<ax:fields>
                        <ax:field label="승계일자*" style="width:170px;">
                            <input type="text" id="info-enssucced-succDate" name="succDate" title="승계일자" placeholder="승계일자" readonly="readonly" maxlength="100" class="AXInput W100 av-required" value=""/>
                        </ax:field>
                        <%-- <ax:field label="납부자 동일">
                        	<label>
                            	<input type="checkbox" id="info-enssucced-changePayer" name="changePayer" title="납부자 동일" placeholder="납부자 동일" class="AXInput W20" value="true"/>
                            	승계자와 납부자가 동일할경우 체크해주시기 바랍니다.  동일하지 않고 납부자 변경을 원하시면 납부자 탭을 이용해 주세요.
                            </label>
                        </ax:field> --%>
                    </ax:fields>
                    <ax:fields>
                    	 <input type="hidden" id="info-enssucced-succId" name="succId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
                        <%-- <ax:field label="신청자번호*" style="width:170px;">
                            <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button>
                        </ax:field> --%>
                        <ax:field label="신청자명*" style="width:170px;">
                            <input type="text" id="info-applicant-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" />
                        </ax:field>
                        <ax:field label="신청자 주민번호" >
                            <input type="text" id="info-applicant-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W100 av-required" value="" />
                      		<!-- <button type="button" class="AXButton" id="btn-search-applJumin"><i class='axi axi-ion-android-search'></i>중복조회</button> -->
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                    	<ax:field label="휴대폰*" style="width:170px;">
                            <input type="text" id="info-applicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
                            <input type="text" id="info-applicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
                            <input type="text" id="info-applicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
                        </ax:field>
                        <ax:field label="전화번호" style="width:170px;">
                            <input type="text" id="info-applicant-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
                            <input type="text" id="info-applicant-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
                            <input type="text" id="info-applicant-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="사망자와의 관계*" style="width:310px;">
                            <select id="info-enssucced-deadRelation" name="deadRelation" class="AXSelect W160"></select>
                            <input type="text" id="info-enssucced-deadRelationNm" name="deadRelationNm" title="사망자와의 관계" maxlength="10" placeholder="사망자와의 관계" class="AXInput W100" value="" />
                        </ax:field>
                        <ax:field label="피승계자와의 관계*" style="width:310px;">
                            <select id="info-enssucced-applRelation" name="applRelation" class="AXSelect W160"></select>
                            <input type="text" id="info-enssucced-applRelationNm" name="applRelationNm" title="피승계자와의 관계" maxlength="10" placeholder="피승계자와의 관계" class="AXInput W100" value=""/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="신청자국적" style="width:170px;">
                            <select id="info-applicant-nationGb" name="nationGb" class="AXSelect W100"></select>
                        </ax:field>
                        <ax:field label="신청자 주소*">
                            <select id="info-applicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
                            <input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
                            <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
                            <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="신청자 주소" placeholder="" class="AXInput W250 av-required" value="" />
                            <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W250" value=""  />
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
                        <ax:field label="승계사유" style="width:98%;">
                        	<input type="text" id="info-enssucced-hstReson" name="hstReson" title="승계사유" placeholder="승계사유" class="AXInput" style="width: 98%;" value=""/>
                    	</ax:field>
                   	</ax:fields>
                    <ax:fields>
                        <ax:field label="특이사항" style="width:98%;">
                        	<input type="text" id="info-enssucced-applRemark" name="applRemark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 98%;" value=""/>
                    	</ax:field>
                    </ax:fields>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
<!-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button> -->
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
		<script type="text/javascript">

			var fnObj = {
                CODES: {
                    "addrPart": Common.getCode("TCM10"),
                    "applRelation": Common.getCode("TCM08"),
   					"nationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                },

				pageStart: function(){
					this.gridEnssucced.bind();
					this.gridEnssucced.setPage();
					this.formApplicant.bind();
					this.formEnssucced.bind();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

					var _this = this;
                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});

					$('input[type=checkbox]').bindChecked();
					$("#ax-form-btn-save").css("display", "none");
					$("#btn-search-applicant").bind("click", function(){
						app.modal.open({
						    url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
						    pars:"callBack=fnObj.searchApplicantModalResult",
						    width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
						    top:axdom(window).scrollTop() + 60 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
						});
				 	});
                    $("#btn-applpost").bind("click", function(){
                    	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
                    });
					$("#info-beforeApplicant-deadRelation, #info-enssucced-applRelation, #info-enssucced-deadRelation").bindSelect({
						options:fnObj.CODES.applRelation
					});
					$("#info-beforeApplicant-nationGb, #info-applicant-nationGb").bindSelect({
						options:fnObj.CODES.nationGb
					});
					$("#info-beforeApplicant-addrGubun, #info-applicant-addrGubun").bindSelect({
						options:fnObj.CODES.addrGubun
					});
					$("#ax-form-btn-new").bind("click", function(){
						fnObj.formEnssucced.clear();
						$("#info-enssucced-ensDate").val("${param.ensDate}");
						$("#info-enssucced-ensSeq").val("${param.ensSeq}");
						$("#info-enssucced-applId").val("${param.applId}");
						$("#info-enssucced-succDate").val(new Date().print());
						if(Common.grid.containsNewItem(fnObj.gridEnssucced.target)){
							return;
						}
						if(fnObj.gridEnssucced.target.list.length>0){
// 							var lastItem = fnObj.gridEnssucced.target.list[fnObj.gridEnssucced.target.list.length-1];
// 							$("#info-enssucced-applId").val(lastItem.succId);
// 							fnObj.gridEnssucced.target.pushList({applicant:fnObj.gridEnssucced.target.getSelectedItem().item.succApplicant});
							var list = fnObj.gridEnssucced.target.list;
							list = list.sort(function(a,b){
								return b.succDate.date().getTime()-a.succDate.date().getTime();
							});
							var succApplicant = list.first().succApplicant;
							$("#info-enssucced-applId").val(succApplicant.succId);
							succApplicant.applId = succApplicant.succId;
							fnObj.gridEnssucced.target.pushList({applicant:succApplicant});
						}else{
							fnObj.gridEnssucced.target.pushList({applicant:fnObj.formApplicant.getJSON(), applName:fnObj.formApplicant.getJSON().applName});
						}
						fnObj.gridEnssucced.target.setFocus(fnObj.gridEnssucced.target.list.length-1);
						fnObj.formApplicant.setJSON(fnObj.gridEnssucced.target.getSelectedItem().item.applicant);
						$("[id^='info-enssucced-']").change();
						$("#ax-form-btn-save").css("display", "inline-block");
					});
					$("#info-enssucced-succDate").bindDate();
					$("#ax-form-btn-save").bind("click", function(){
						fnObj.save();
					});
					$("#ax-form-btn-delete").bind("click", function(){
						fnObj.del();
					});
					 $("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});

					//신청자 중복체크
                    $("#btn-search-applJumin").bind("click", function(){
                    	var applJumin = $("#info-applicant-applJumin").val();
                    	if(!Common.str.juminChk(applJumin)){
                    		$("#info-applicant-applJumin").focus();
                    		return;
                    	}
                      	fnObj.isNewApplicant(applJumin);
                    });

				},
				eventFn: {
					reportENSH1010_1: function() {
						var parameters = [];
            			var list = parent.fnObj.gridEnsdead.target.getList();
            			var reportName = "ENSH1010_1";
            			if("${param.ensType}" == 'TFM1000003'){
            				reportName = "ENSH1010_7";
            			}
              			$.each(list, function(i,o){
              				parameters.push({path: "/reports/changwon/ensh/"+reportName, parameter: parent.fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}'})
              				parameters.push({path: "/reports/changwon/ensh/ENSH1015_1", parameter: parent.fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}'})
           				});
              			Common.report.mergePdfReport(parameters);
					}
				},
                searchApplicantModalResult: function(applicant){
                	var applId = $("#info-enssucced-applId").val();
                	for(var key in applicant){
                		$("#info-enssucced-"+key).val(applicant[key]);
                		$("#info-enssucced-"+key).bindSelectSetValue(applicant[key]);
                	}
                	var succId = $("#info-enssucced-applId").val();
                	$("#info-enssucced-applId").val(applId);
                	$("#info-enssucced-succId").val(succId);

               		app.modal.target.close();
                },
				gridEnssucced: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-enssucced",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"succDate", label:"승계일자", width:"100", align:"center"},
                                {key:"applName", label:"신청자", width:"100", align:"center", formatter: function(){
                                	if(this.item.applicant){
                                		return this.item.applicant.applName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"succName", label:"승계자", width:"100", align:"center", formatter: function(){
                                	if(this.item.succApplicant){
                                		return this.item.succApplicant.applName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"hstReson", label:"승계사유", width:"100", align:"center"},
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.formApplicant.setJSON(this.item.applicant);
                                	fnObj.formEnssucced.setJSON(this.item);
                                	if(this.item._CUD == "C"){
                                		$("#ax-form-btn-save").css("display", "inline-block");
                                	}else{
                                		$("#ax-form-btn-save").css("display", "none");
                                	}
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    setPage: function(){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1015/enssucced/${param.ensDate}/${param.ensSeq}",
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
                                if(_target.list.length == 0){

                                	app.ajax({
                                        type: "GET",
                                        url: "/ENSH1015/enshrine/${param.ensDate}/${param.ensSeq}",
                                        data: ""
                                    }, function(res){
                                        if(res.error){
                                            alert(res.error.message);
                                        }
                                        else
                                        {
                                        	res.map.enshrine.applicant.deadRelation = res.map.enshrine.deadRelation;
                                        	res.map.enshrine.applicant.deadRelationNm = res.map.enshrine.deadRelationNm;
			                                fnObj.formApplicant.setJSON(res.map.enshrine.applicant);
			                                fnObj.formEnssucced.clear();
			        						$("#info-enssucced-ensDate").val("${param.ensDate}");
			        						$("#info-enssucced-ensSeq").val("${param.ensSeq}");
                                        }
                                    });
                                }else{

                                	_target.setFocus(_target.list.length-1);

	                                var applicant = _target.getSelectedItem().item.applicant;
	                                if(_target.getSelectedItem().item.beforedeadRelation.length == 0){
		                                applicant.deadRelation = _target.getSelectedItem().item.deadRelation;
		                                applicant.deadRelationNm = _target.getSelectedItem().item.deadRelationNm;
		                                fnObj.formApplicant.setJSON(_target.getSelectedItem().item.applicant);
	                                }else{
		                                applicant.deadRelation = _target.getSelectedItem().item.beforedeadRelation;
		                                applicant.deadRelationNm = _target.getSelectedItem().item.beforedeadRelationNm;
		                                fnObj.formApplicant.setJSON(_target.getSelectedItem().item.applicant);
	                                }

	                                var succApplicant = _target.getSelectedItem().item.succApplicant;
	                                succApplicant.deadRelation = _target.getSelectedItem().item.deadRelation;
	                                succApplicant.deadRelationNm = _target.getSelectedItem().item.deadRelationNm;
	                                succApplicant.applRelation = _target.getSelectedItem().item.applRelation;
	                                succApplicant.applRelationNm = _target.getSelectedItem().item.applRelationNm;
	                                succApplicant.succId = _target.getSelectedItem().item.succApplicant.applId;
	                                succApplicant.applId = _target.getSelectedItem().item.applicant.applId;
	                                succApplicant.ensDate = _target.getSelectedItem().item.ensDate;
	                                succApplicant.ensSeq = _target.getSelectedItem().item.ensSeq;
	                                fnObj.formEnssucced.setJSON(succApplicant);
                                }
                            }
                        });
                    }
                },
				isNewApplicant: function(applJumin){

                	app.ajax({
                        type: "PUT",
                        url: "/ENSH1012/applicant/",
                        data: Object.toJSON({"applJumin" : applJumin})
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{

                    		if(res.map.isNew){
								toast.push("중복된 신청자가 존재하지 않습니다.");
								//if($("#info-applId").val()>0){
								//	$("#info-form-enssucced [id^='info-enssucced-appl']").val("");
								//}
							}else{
								if(!confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
									//$('#info-enssucced-applId').val(res.map.applicant.applId);
									$("#info-form-enssucced [id^='info-enssucced-appl']").val("");
			                		return;
			                	}
								var applId = $("#info-enssucced-applId").val();
								 Common.form.fillForm('info-enssucced-',res.map.applicant);
								 applId = $("#info-enssucced-applId").val(applId);
							}
                        }
                    });
                },
                save: function(){
                	if(!confirm("저장하시겠습니까?")){
                		return;
                	}
                	var validateResult = fnObj.formEnssucced.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.formEnssucced.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.formEnssucced.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var enssucced = fnObj.formEnssucced.getJSON();

                    app.ajax({
                        type: "PUT",
                        url: "/ENSH1015/enssucced/"+$("[name='changePayer']").is(":checked").toString(),
                        data: Object.toJSON(enssucced)
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                        	toast.push("저장하였습니다.");
                        	fnObj.gridEnssucced.setPage();
                        	$("#ax-form-btn-save").css("display", "none");
                        	app.modal.save("${callBack}", "C");
                        }
                    });
                },
                del: function(){
                	if(!confirm("삭제하시겠습니까?")){
                		return;
                	}
                	var item = fnObj.gridEnssucced.target.getSelectedItem();
                	if(item.item._CUD == 'C'){
                		fnObj.gridEnssucced.target.removeListIndex([item]);
                       	$("#ax-form-btn-save").css("display", "none");
                		return;
                	}
                	app.ajax({
                        type: "DELETE",
                        url: "/ENSH1015/enssucced/"+item.item.ensDate
                        		+"/"+item.item.ensSeq
                        		+"/"+item.item.succDate,
                        data: ""
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                        	toast.push("삭제하였습니다.");
                        	fnObj.gridEnssucced.setPage();
                        	app.modal.save("${callBack}", "C");
                        }
                    });
                },
                formApplicant: {
                    target: $('#info-form-applicant'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "info-form-applicant"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-beforeApplicant-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-beforeApplicant-');
                    },
                    clear: function() {
                        app.form.clearForm(fnObj.formApplicant.target);
                    }
                },
                formEnssucced: {
                    target: $('#info-form-enssucced'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "info-form-enssucced"
                        });

                         //Common.grid.changeValueToGrid("info-enssucced-", fnObj.gridEnssucced.target);


                        $("[id^='info-enssucced-']").bind("change",function(){
                        	var item = fnObj.gridEnssucced.target.getSelectedItem();
                        	if(!item || !item.item || item.error){
                        		return;
                        	}
                        	var name = this.getAttribute("name");
                        	if(!item.item.succApplicant){
                        		item.item.succApplicant = {};
                        	}
                        	item.item.succApplicant[name] = $(this).val();
                        	fnObj.gridEnssucced.target.updateList(item.index, item.item);
                        });
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-enssucced-', true);
                        app.form.fillForm(_this.target, info.succApplicant, 'info-applicant-', true);
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                    	var enssucced = app.form.serializeObjectWithIds(this.target, 'info-enssucced-');
                    	var succApplicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-');
                    	var applicant = app.form.serializeObjectWithIds(fnObj.formApplicant.target, 'info-beforeApplicant-');
                    	enssucced.applicant = applicant;
                    	enssucced.succApplicant = succApplicant;
                        return enssucced;
                    },
                    clear: function() {
                        app.form.clearForm(fnObj.formEnssucced.target);
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