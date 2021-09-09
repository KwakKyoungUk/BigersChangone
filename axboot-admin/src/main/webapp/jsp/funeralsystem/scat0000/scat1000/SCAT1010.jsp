<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="styles">
        <style type="text/css">
            span.td {min-height: 100px important; }
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-button-group">
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-button-group">
                	<div class="left" style="width: 49%;">
		                <div class="ax-search" id="page-search-scatter"></div>
                	</div>
                	<div class="right" style="width: 49%;">
		                <div class="ax-search" id="page-search-hwaCremation"></div>
                	</div>
                    <div class="ax-clear"></div>
                </div>
                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
							<ax:form id="form-info" name="form-info" method="get">
								<input type="hidden" id="info-scaDate" name=scaDate value=""/>
								<input type="hidden" id="info-scaSeq" name=scaSeq value=""/>
			                    <input type="hidden" id="info-cremDateString" name="cremDateString" value=""/>
			                    <input type="hidden" id="info-cremSeq" name="cremSeq" value=""/>
   			                    <input type="hidden" id="info-feetypedivcd" name="feetypedivcd" value=""/>
   			                    <input type="hidden" id="info-deadTimeString" name="deadTimeString" />
   			                    <input type="hidden" id="info-rentalfee" name="rentalfee"/>
   			                    <input type="hidden" id="info-dcAmt" name="dcAmt"/>
   			                    <input type="hidden" id="info-charge" name="charge"/>
   			                    <input type="hidden" id="info-receiptGb" name="receiptGb"></input>
								<input type="hidden" id="info-cashAmt" name="cashAmt"/>
								<input type="hidden" id="info-cardAmt" name="cardAmt"/>
								<input type="hidden" id="info-cardCode" name="cardCode"></input>
								<input type="hidden" id="info-addrCode" name="addrCode"></input>
								<input type="hidden" id="info-deadBirthString" name="deadBirthString" />
				                <input type="hidden" id="info-deadNationGb" name="deadNationGb" ></input>

								<ax:fields >
				                    <ax:field label="사망자명*" style="width: 194px;">
				                    	<input type="hidden" id="info-deadId" name="deadId" class="AXInput W20" value="" />
				                        <input type="text" id="info-deadName" name="deadName" title="사망자명" placeholder="사망자명" maxlength="20" class="AXInput W80" value=""  />
				                      <!--  	<button id="btn-search-thedead" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>  -->
				                    </ax:field>
				                    <ax:field label="주민등록번호" style="width: 194px;">
				                        <input type="text" id="info-deadJumin" name="deadJumin" title="주민등록번호" placeholder="주민등록번호" maxlength="14" class="AXInput W101" value=""  />
				                    </ax:field>
				                   	<ax:field label="사망자성별" style="width: 194px;">
				                        <select id="info-deadSex" name="deadSex" class="AXSelect W100"></select>
				                    </ax:field>
				           		</ax:fields>
				           		<ax:fields >
				                    <ax:field label="사망일자" style="width: 194px;">
				                        <input type="text" id="info-deadDateString" name="deadDateString" title="사망일자" placeholder="사망일자" class="AXInput W100" value="" />
				                    </ax:field>
				                	<ax:field label="사망장소" style="width: 194px;">
				                        <select id="info-deadPlace" name="deadPlace" class="AXSelect W160"></select>
				                    </ax:field>
				                	<ax:field label="사망사유" style="width: 194px;">
				                        <select id="info-deadReason" name="deadReason" class="AXSelect W160"></select>
				                    </ax:field>
				           		</ax:fields>
				           		<ax:fields>
   									<ax:field label="관내외구분" style="width: 194px;">
										<select id="info-addrPart" name="addrPart" class="AXSelect W100"></select>
									</ax:field>
									<ax:field label="감면대상구분" style="width: 194px;">
										<select id="info-dcGubun" name="dcGubun" class="AXSelect W150"></select>
									</ax:field>
                                    <ax:field label="산골대상구분">
                                        <select id="info-objt" name="objt" class="AXSelect W100"></select>
                                    </ax:field>
				           		</ax:fields>
				           		<ax:fields>
				                    <ax:field label="사망자 주소" >
				                    	<select id="info-deadAddrGubun" name="deadAddrGubun" class="AXSelect W50"></select>
				                        <input type="text" id="info-deadPost" name="deadPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
				                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
				                        <input type="text" id="info-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" class="AXInput W350 av-required" value="" />
				                        <input type="text" id="info-deadAddr2" name="deadAddr2" title="사망자 주소" placeholder="상세주소" class="AXInput" value="" style="width:490px;"  />
				               		</ax:field>
								</ax:fields>
								<ax:fields >
									<ax:field label="특이사항">
										<input type="text" id="info-remark" name="remark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 600px;" value=""/>
									</ax:field>
								</ax:fields>
								<ax:fields >
									<ax:field label="상태">
										<select id="info-hsStatus" name="hsStatus" class="AXSelect"></select>
									</ax:field>
								</ax:fields>
								<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
				                	<div class="right">
				                		<!-- <input type="text" name="x" class="AXInput W100" id="ax-input-switch" /> -->
<!-- 				                		<button type="button" class="AXButton" id="btn-report"><i class="axi axi-report"></i> 시설사용허가신청서</button> -->
				                		<!-- <button type="button" class="AXButton" id="btn-report2"><i class="axi axi-report"></i> 허가증</button> -->
				                		<!-- <button type="button" class="AXButton" id="btn-certificate"><i class="axi axi-certificate"></i> 산골증명서</button> -->
										<button type="button" class="AXButton" id="btn-reportSCAT1010_10">산골신청서</button>
										<button type="button" class="AXButton" id="btn-reportSCAT1010_11">산골확인서</button>
				                		<button type="button" class="AXButton" id="btn-receipt"><i class="axi axi-receipt"></i> 영수증</button>
				                	</div>
				                    <div class="ax-clear"></div>
				                </div>
							</ax:form>
                       	</ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                        	<div id="div-tab"></div>
                        	<div id="div-content"></div>
                        	<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000;">
	                        	<div id="div-tab-content-A">
	                        		<ax:form id="form-info-applicant" name="form-info-applicant" method="get">
										<ax:fields>
											    <input type="hidden" id="info-beforeApplId" name="beforeApplId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
		                                        <input type="hidden" id="info-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>

		                                  <%--   <ax:field label="신청자번호*" style="width:350px;">
	                                        <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
		                                    </ax:field> --%>
		                                    <ax:field label="신청자명*" style="width:350px;">
		                                        <input type="text" id="info-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="신청자 주민번호" style="width:400px;">
		                                    	<input type="text" name="x" class="AXInput W130" id="ax-input-segment" />
		                                        <input type="text" id="info-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W105 av-required" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="휴대폰*" style="width:350px;">
		                                        <input type="text" id="info-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="전화번호" style="width:350px;">
		                                        <input type="text" id="info-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
		                                    </ax:field>
		                                    <ax:field label="email" style="width:350px;">
		                                        <input type="text" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value=""  />@<input
		                                        type="text" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value=""  />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="신청자국적" style="width:350px;">
		                                        <select id="info-applNationGb" name="applNationGb" class="AXSelect W100"></select>
		                                    </ax:field>
		                                    <ax:field label="신청자 주소*">
		                                        <select id="info-applAddrGubun" name="applAddrGubun" class="AXSelect W50"></select>
		                                        <input type="text" id="info-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
		                                          <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
		                                        <input type="text" id="info-applAddr1" name="applAddr1" title="신청자 주소"  placeholder="" class="AXInput W300 av-required" value="" />
		                                        <input type="text" id="info-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W350 av-required" value=""  />
		                                    </ax:field>
		                                </ax:fields>
   		                                <ax:fields>
   		                                    <ax:field label="사망자와의 관계*" style="width:350px;">
		                                        <select id="info-deadRelation" name="deadRelation" class="AXSelect W160"></select>
		                                        <input type="text" id="info-deadRelationNm" name="deadRelationNm" title="사망자와의 관계" maxlength="10" placeholder="사망자와의 관계" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="특이사항" style="width:800px;">
		                                        <input type="text" id="info-applRemark" name="applRemark" title="특이사항" maxlength="200" placeholder="특이사항" class="AXInput" value="" style="width: 98%;" />
		                                    </ax:field>
		                                </ax:fields>
				                	</ax:form>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-list-applicant-addrhst"><i class="axi axi-list"></i> 주소변경이력</button>
					                	</div>
				                    	<div class="ax-clear"></div>
				                	</div>
	                        	</div>
                        	</div>
                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">

            var resize_elements = [
//                 {id:"div-content-A-grid", adjust:function(){
//                     	return -axf.clientHeight()/2;
//                 	}
//                 }
//                 , {id:"page-grid-box-hwaBooking", adjust:function(){
//     	                return -axf.clientHeight()/2;
// 	                }
//                 }
            ];
            var fnObj = {

                CODES: {
                    "firstTab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
                      					],
                    "tab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
                      					],
   					"applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                    "applRelation": Common.getCode("TMC08"),
                    "deadRelation": Common.getCode("TCM08"),
                    "deadNationGb": Common.getCode("TCM04"),
                    "cardCode": Common.getCode("TCM16"),
                    "receiptGb": Common.getCode("TMC15"),
                    "dcGubun": Common.getCode("TCM12"),
                    "addrPart": Common.getCode("TCM10"),
                    "deadSex": Common.getCode("TCM05"),
                    "deadPlace": Common.getCode("TCM09"),
                    "deadReason": Common.getCode("TCM03"),
                    "objt": Common.getCode("TFM27"),
                    "hsStatus": Common.getCode("HS_STATUS"),
                    "addrCode": Common.addr.getAddrCode()
                },
                pageStart: function(){
                    this.searchScatter.bind();
                    this.searchHwaCremation.bind();
                    this.form.bind();
                    this.formApplicant.bind();
                    this.bindEvent();
					this.defaultSearch();
                },
                defaultSearch: function(){
					var scaDate = "${param.scaDate}";
					var scaSeq = "${param.scaSeq}";

					 $("#info-deadPlace").bindSelectSetValue("TCM0900002");
					 $("#info-deadReason").bindSelectSetValue("TCM0300001"); //병사
					 $("#info-objt").bindSelectSetValue("TFM2700001");

					if(scaDate.length == 0 || scaSeq.length == 0){
						$("#info-receiptGb").change();
					}else{
						Common.search.setValue(fnObj.searchScatter.target, "scaDate", scaDate);
						Common.search.setValue(fnObj.searchScatter.target, "scaSeq", scaSeq);
						fnObj.searchScatter.submit();
					}
					var cremDate = "${param.cremDate}";
					var cremSeq = "${param.cremSeq}";
					if(cremDate.length == 0 || cremSeq.length == 0){

					}else{
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremDate", cremDate);
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremSeq", cremSeq);
						fnObj.searchHwaCremation.submit();
					}
                },
                tabs:{},

                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.del();
                        }, 500);
                    });
//                    $("#info-addrCode").bindSelect({
//                        options:fnObj.CODES.addrCode
//                    });
                    $("#info-objt").bindSelect({
                        options:fnObj.CODES.objt
                    });

                    $("#info-objt").bindSelectSetValue("TFM2700010");

                    $("#info-objt").bind("change", function(){
						if($("#info-objt :selected").val() =="TFM2700010" && $("#info-scaSeq").val()  == ""){ //개장유골

                    		$("#info-deadDateString").val("");
							//$("#info-deadPlace").bindSelectAddOptions([{optionValue:"", optionText:""}]);
                    		$("#info-deadPlace").bindSelectSetValue("");
                    		//$("#info-deadReason").bindSelectAddOptions([{optionValue:"", optionText:""}]);
                    		$("#info-deadReason").bindSelectSetValue("");

						}
					});


                    $("#info-deadReason").bindSelect({
        				options:fnObj.CODES.deadReason
        				,isspace: true
                        ,setValue:""
        			});

                    $("#info-deadAddr1").change(function(){
                    	Common.addr.getAddrPart(this.value, "info-addrCode", "info-addrPart",true,0);
                    });

                    $("#info-dcGubun").bindSelect({
                        options:fnObj.CODES.dcGubun
                    });
                    $("#info-addrPart").bindSelect({
                        options:fnObj.CODES.addrPart
                    });
                    $("#info-boneGb").bindSelect({
        				options:fnObj.CODES.boneGb
        			});
					$("#info-deadRelation").bindSelect({
						options:fnObj.CODES.deadRelation
					});
					$("#info-hsStatus").bindSelect({
						options:fnObj.CODES.hsStatus
					});
//                    $("#info-deadNationGb").bindSelect({
//        				options:fnObj.CODES.deadNationGb
//        			});

                    $("#info-deadJumin").keyup(function(){
						var deadJumin = $(this).val().replace("-","");
						if(deadJumin.length == 13){
							$(this).val(deadJumin.substring(0,6) +"-"+ deadJumin.substring(6,13));
							$(this).change();
						}
					});

                    $("#info-deadJumin").bind("change",function(){
                		if(Common.str.juminChk(this.value)){
                			   var strJumin = this.value.replace("-", "");

                			   parseInt(strJumin.substring(6,7), 10) % 2 == 1 ? $("#info-deadSex").bindSelectSetValue("TCM0500001") : $("#info-deadSex").bindSelectSetValue("TCM0500002");
                         	   var year =strJumin.substring(6,7)  <= 2 ? "19" : "20";
                               var birthday = year+strJumin.substring(0,2)+"-"+ strJumin.substring(2,4) +"-"+strJumin.substring(4,6);

                               console.log(birthday);
                                $("#info-deadBirthString").val(new Date(birthday).print("yyyy-mm-dd"));
                                $("#info-deadBirthString").change();
                        }else{
                               $("#info-deadSex").bindSelectSetValue("TCM0500003");
                               $("#info-deadBirthString").val("").bindDate();
                        }
             	   });

                    $("#info-deadSex").bindSelect({
        				options:fnObj.CODES.deadSex
        			});
                    $("#info-deadDateString").bindDate();
                    $("#info-deadBirthString").bindDate();
                    $("#info-deadPlace").bindSelect({
        				options:fnObj.CODES.deadPlace
        				,isspace: true
                        ,setValue:""
        			});
                    $("#info-deadAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-deadPost", "info-deadAddr1", "info-deadAddr2");
                    });
//                    $("#info-receiptGb").bindSelect({
//       				options:fnObj.CODES.receiptGb
//        			});
                    $("#info-receiptGb").bind("change", function(){
                    	//console.log(this.value);
                    	//var cash = $("#info-cashAmt").val();
                    	//var card = $("#info-cardAmt").val();
                    	//$("#info-cashAmt").val(card);
                    	//$("#info-cardAmt").val(cash);
                    	var rentalfee= $("#info-rentalfee").val();

                    	if(this.value == "TMC1500001"){
                    		$("#info-cardCode").bindSelectAddOptions([{optionValue:"", optionText:""}]);
                    		$("#info-cardCode").bindSelectSetValue("");
                    		$("#info-cashAmt").val(rentalfee);
                        	$("#info-cardAmt").val(0);
                        	$("#info-cardCode").bindSelectDisabled(true);
                    	}else {
                    		$("#info-cardCode").bindSelectRemoveOptions([{optionValue:"", optionText:""}]);
                    		//$("#info-cardCode").bindSelectSetValue("TCM1600001");
                    		$("#info-cashAmt").val(0);
                        	$("#info-cardAmt").val(rentalfee);
                        	$("#info-cardCode").bindSelectDisabled(false);
                    	}

                    });

//                    $("#info-cardCode").bindSelect({
//        				options:fnObj.CODES.cardCode
//        			});
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });
                    $("#div-tab").bindTab({
        				theme : "AXTabs",
        				value:"A",
        				overflow:"scroll", /* "visible" */
        				options:fnObj.CODES.firstTab,
        				onchange: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
//         					toast.push("onchange: "+Object.toJSON(value));

// 		                    $("#div-contents").empty();
//         					$("#div-contents").append(fnObj.tabs["div-tab-content-"+value].tab);
//         					fnObj.tabs["div-tab-content-"+value].bindEvent();
//         					$("[id^='div-tab-content-']").css("display", "none");
//         					$("#div-tab-content-"+value).css("display", "");
							$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-"+value));

        				},
        				onclose: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
        					toast.push("onclose: "+Object.toJSON(value));
        				}
        			});
                    $("#btn-search-thedead").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp",
	                        //pars:"callBack=fnObj.searchThedeadModalResult&deadId="+$("#info-deadId").val(),
	                        pars:"callBack=fnObj.searchThedeadModalResult&deadId="+$("#info-deadId").val()+"&deadDate="+$("#"+fnObj.searchScatter.target.getItemId("scaDate")).val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                    $("#info-endDateString").bindTwinDate({
                        startTargetID: "info-strDateString",
                        handleLeft: 25,
                        align: "right",
                        valign: "bottom",
                        separator: "-",
                        buttonText: "선택",
                        onChange: function () {
                            //toast.push(Object.toJSON(this));
                        },
                        onBeforeShowDay: function (date) {
//                             if (date.getDay() == 3) {
//                                 return { isEnable: false, title: "수요일 선택불가", className: "", style: "" };
//                             }
                        }
                    });
                    $("#info-extEndDateString").bindTwinDate({
                        startTargetID: "info-extStrDateString",
                        handleLeft: 25,
                        align: "right",
                        valign: "bottom",
                        separator: "-",
                        buttonText: "선택",
                        onChange: function () {
                            //toast.push(Object.toJSON(this));
                        },
                        onBeforeShowDay: function (date) {
//                             if (date.getDay() == 3) {
//                                 return { isEnable: false, title: "수요일 선택불가", className: "", style: "" };
//                             }
                        }
                    });
	               	//$("#info-applJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
	       			/* $("#info-applJumin").keyup(function(){
						var applJumin = $(this).val().replace("-","");
						if(applJumin.length == 13){
							$(this).val(applJumin.substring(0,6) +"-"+ applJumin.substring(6,13));
							$(this).change();
						}else if(applJumin.length <=10){
						//	$(this).val(applJumin.substring(0,3) +"-"+applJumin.substring(3,6)+"-"+applJumin.substring(6,10));
						//	$(this).change();
						}
					});  */
					$("#info-applJumin").change(function(key){

                    	var segment =  $("#ax-input-segment").val();
                    	if(segment == 0){

     						var applJumin = $("#info-applJumin").val().replace("-","");
     						if(applJumin.length == 13){
     							$("#info-applJumin").val(applJumin.substring(0,6) +"-"+ applJumin.substring(6,13));
     							//$("#info-applJumin").change();
     						}
       					}else{

       					var applJumin = $(this).val().replace("-","");
     						if(applJumin.length == 10){
     							$("#info-applJumin").val(applJumin.substring(0,3) +"-"+applJumin.substring(3,5) +"-" +  applJumin.substring(5,10));
     							//$("#info-applJumin").change();
     						}
       					}
                    });
	                   $("#info-applAddrGubun").bindSelect({
	       				options:fnObj.CODES.addrGubun
	       			});
	                   $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applPost", "info-applAddr1", "info-applAddr2");
	                   });
	                   $("#info-applNationGb").bindSelect({
	       				options:fnObj.CODES.applNationGb
	       			});
					$("#info-applRelation").bindSelect({
						options:fnObj.CODES.applRelation
					});
	                $("#btn-search-applicant").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
	                        pars:"callBack=fnObj.searchApplicantModalResult&applId="+$("#info-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
	                });
					$("#div-content").append($("#div-tab-content-A"));
					$("#btn-save-applicant").bind("click",function(){
						fnObj.saveApplicant("A", false, fnObj.formApplicant);
					});
					$("#btn-save-applicant-addrhst").bind("click",function(){
						fnObj.saveApplicant("A", true, fnObj.formApplicant);
					});
					$("#btn-list-applicant-addrhst").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1013.jsp",
	                        pars:"callBack=fnObj.addrhstModalResult&applId="+$("#info-applId", fnObj.formApplicant.target).val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#info-deadTimeString").bindPattern({
		                pattern: "custom", patternString:"99:99"
		            });
					$("#info-addrPart, #info-dcGubun").bind("change", fnObj.calcPriceAndTerm);
					$("#info-cashAmt, #info-cardAmt").bind("keyup", function(){
						var charge = $("#info-charge").val();
						var ids = ["info-cashAmt", "info-cardAmt"];
						var _this = this;
						ids.forEach(function(val){

							if(val == $(_this).attr("id")){
								$("#"+val).val(+$(_this).val());
							}else{
								$("#"+val).val(+charge-$(_this).val());
							}
						});
					});
					$("#btn-reportSCAT1010_10").bind("click", function(){
                    	var params = [];
                    	var scaDate = $("#info-scaDate").val().date().print("yyyymmdd");
                    	var scaSeq =  Common.search.getValue(fnObj.searchScatter.target, "scaSeq");
                    	var deadId =  $("#info-deadId").val();
                    	if(scaDate ==  "" || scaSeq == "" ){

                    		return;
                    	}
                    	params.push("scaDate="+scaDate);
                		params.push("scaSeq="+scaSeq);
                		params.push("deadId="+deadId);
                		Common.report.open("/reports/changwon/scat/SCAT1010_10", "pdf", params.join("&"));
                    });

					$("#btn-reportSCAT1010_11").bind("click", function(){
                    	var params = [];
                    	var scaDate = $("#info-scaDate").val().date().print("yyyymmdd");
                    	var scaSeq =  Common.search.getValue(fnObj.searchScatter.target, "scaSeq");
                    	var deadId =  $("#info-deadId").val();
                    	if(scaDate ==  "" || scaSeq == "" ){

                    		return;
                    	}
                    	params.push("scaDate="+scaDate);
                		params.push("scaSeq="+scaSeq);
                		params.push("deadId="+deadId);
                		Common.report.open("/reports/changwon/scat/SCAT1010_11", "pdf", params.join("&"));
                    });

					 $("#btn-report").bind("click", function(){
	                    	var params = [];
	                    	var scaDate = $("#info-scaDate").val().date().print("yyyymmdd");
	                    	var scaSeq =  Common.search.getValue(fnObj.searchScatter.target, "scaSeq");
	                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
	                    	if(scaDate ==  "" || scaSeq == "" ){

	                    		return;
	                    	}
	                    	params.push("scaDate="+scaDate);
	                		params.push("scaSeq="+scaSeq);
	                		params.push("encYN="+encYN);
	                		Common.report.open("/reports/changwon/scat/SCAT1011", "pdf", params.join("&"));
	                    });

					 	$("#btn-report2").bind("click", function(){
	                    	var params = [];
	                    	var scaDate = $("#info-scaDate").val().date().print("yyyymmdd");
	                    	var scaSeq =  Common.search.getValue(fnObj.searchScatter.target, "scaSeq");
	                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
	                    	if(scaDate ==  "" || scaSeq == "" ){

	                    		return;
	                    	}
	                    	params.push("scaDate="+scaDate);
	                		params.push("scaSeq="+scaSeq);
	                		params.push("encYN="+encYN);
	                		Common.report.open("/reports/changwon/scat/SCAT1013", "pdf", params.join("&"));
	                    });


						 $("#btn-search-applJumin").bind("click", function(){
	                      	fnObj.isNewApplicant();
	                    });

					      $("#ax-input-switch").bindSwitch({
		                		off:"암호화 미적용",
		                		on:"암호화 적용",
		                		onchange:function(){
		                			//toast.push(Object.toJSON(this));
		                		}
		                	});
		                    $("#ax-input-switch").setValueInput("암호화 적용");


		                    $("input[name='cremSeq']").keydown(function (key) {
		                        if(key.keyCode == 13){
		                        	var cremDate = Common.str.replaceAll($("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val(), "-", "");
		                        	var cremSeq = $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
		        					if(cremDate.length == 0 || cremSeq.length == 0){
		        						alert("순번을 입력해주세요.")
		        					}else{
		        						fnObj.searchHwaCremation.submit();
		        						return
		        					}
		                        }
		                    });

		                    $("input[name='scaSeq']").keydown(function (key) {
		                        if(key.keyCode == 13){
		                        	var ensDate = Common.str.replaceAll($("#"+fnObj.searchScatter.target.getItemId("scaDate")).val(), "-", "");
		                        	var ensSeq = $("#"+fnObj.searchScatter.target.getItemId("scaSeq")).val();
		        					if(ensDate.length == 0 || ensSeq.length == 0){
		        						alert("순번을 입력해주세요.")
		        					}else{
		        						fnObj.searchScatter.submit();
		        						return
		        					}
		                        }
		                    });

		                    $("#ax-input-segment").bindSegment({
		            			options:[
		            				{optionValue:0, optionText:"주민번호"},
		            				{optionValue:1, optionText:"사업자번호"},
		            			],
		            			setValue : 0,
		            			onchange:function(){
		            				//this.targetID, this.options, this.selectedIndex, this.selectedOption
		            				//console.log(this);
		            				if(this.selectedIndex == 0){
		            					 // $("#info-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});
		            					  $("#info-applJumin").attr("placeholder","주민번호");

		          						var applJumin = $("#info-applJumin").val().replace("-","");
		          						if(applJumin.length == 13){
		          							$("#info-applJumin").val(applJumin.substring(0,6) +"-"+ applJumin.substring(6,13));
		          							$("#info-applJumin").change();
		          						}
		            				}else{
		            					//$("#info-applJumin").bindPattern({pattern: "custom", max_length: 10, patternString:"999-99-99999"});
		            					$("#info-applJumin").attr("placeholder","사업자번호");

		            					var applJumin = $("#info-applJumin").val().replace("-","");
		          						if(applJumin.length == 10){
		          							$("#info-applJumin").val(applJumin.substring(0,3) +"-"+applJumin.substring(3,5) +"-" +  applJumin.substring(5,10));
		          							$("#info-applJumin").change();
		          						}
		            				}
		            			}
		            		});
		                    $("#ax-input-segment").setValueInput(0);
				},
				 isNewApplicant: function(){
					var applJumin = $("#info-applJumin").val();
					if($("#inputBasic_AX_ax-input-segment_AX_SegmentHandle_AX_0").hasClass("on") == true){

                		if(!Common.str.juminChk(applJumin)){
                    		alert("유효하지 않는 주민번호입니다. \n 다시 확인하시고 입력해 주세요");
                    		$("#info-applJumin").focus();
                    		return false;
                    	}

                	}
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
                    			if($("#info-applId").val() == ""){
                    				toast.push("중복된 신청자가 존재하지 않습니다.");
                    				return;
                    			}
								if($("#info-applId").val() !="" && confirm("신청자를 변경하시겠습니까? 신청자 정보가 초기화 됩니다.")){
									$("#form-info-applicant [id^='info-appl'][id!='info-applJumin']").val("");
									$("#info-applAddrGubun").bindSelectSetValue("TCM0700001");
									return;
								}
							}else{
								var newApplId = res.map.applicantVTO.applId;
								//if($("#info-scaSeq").val() =="" && ($("#info-applId").val() !="" || !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?"))){
								if(($("#info-applId").val() =="" || newApplId != $("#info-applId").val()) && !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
			                		return;
			                	}
								 Common.form.fillForm('info-',res.map.applicantVTO);
								 $("#info-applJumin").blur();
							}
                        }
                    });
                	return true;
                },
				isNew: function(){
                	var scaSeq = Common.search.getValue(fnObj.searchScatter.target, "scaSeq");
                	if(!scaSeq || scaSeq.length == 0){
                		return true;
                	}else{
                		return false;
                	}
                },
                calcPriceAndTerm: function(){
                	if(!fnObj.isNew()){
                 		return;
                	}
                	app.ajax({
                        type: "GET",
                        url: "/SCAT1010/pricelist/"+$("#info-addrPart").val()+"/"+$("#info-dcGubun").val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("사용료가 등록되지 않았습니다.");
                    			return;
                    		}
                    		$("#info-rentalfee").val(res.map.pricelist.charge);
                    		$("#info-dcAmt").val(res.map.dcAmt||0);
                    		$("#info-charge").val(res.map.pricelist.charge-(res.map.dcAmt||0));
                    		$("#info-cashAmt").val(res.map.pricelist.charge);
                    		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                    		$("#info-receiptGb").change();
                        }
                    });
                },
                del: function(){
                	if(!confirm("산골접수 자료를 삭제하시겠습니까?")){
                		return;
                	}
                	app.ajax({
            			async: false,
                        type: "DELETE",
                        url: "/SCAT1010/scatter/"+$("#"+fnObj.searchScatter.target.getItemId("scaDate")).val().date().print("yyyymmdd")+"/"+$("#"+fnObj.searchScatter.target.getItemId("scaSeq")).val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.massage);
                    	}else{
                    		toast.push("삭제하였습니다.");
                    		$('#ax-form-btn-new').click();
                    	}
                	});
                },
                save: function(){
                	if(!confirm("저장하시겠습니까?")){
                		return;
                	}

                    var validateResult = fnObj.form.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.form.validate_target.getErrorElement().focus();
                        return false;
                    }
                    validateResult = fnObj.formApplicant.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.formApplicant.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.formApplicant.validate_target.getErrorElement().focus();
                        return false;
                    }

                    //if(!fnObj.isNewApplicant()){
                    	//return false;
                    //}

                    var info = fnObj.form.getJSON();
                    info.applId = $("#info-applId").val();
                    info.deadRelation = $("#info-deadRelation").bindSelectGetValue().optionValue;
                    info.deadRelationNm = $("#info-deadRelationNm").val();
                    info.thedead = $.extend({}, info);
                    var applicant = fnObj.formApplicant.getJSON();
                    info.applicant = applicant;
                    app.ajax({
                        type: "PUT",
                        url: "/SCAT1010/scatter",
                        data: Object.toJSON(info)
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else if(res.map.error){
                            var errorLog = res.map.error.log;
                            var message = [];
                            for(var i=0; i<errorLog.length; i++){
	                            $('input[name="'+errorLog[i].field+'"], select[name="'+errorLog[i].field+'"]').css("background-color", "#FF0000");
	                            $('input[name="'+errorLog[i].field+'String"], select[name="'+errorLog[i].field+'String"]').css("background-color", "#FF0000");
	                            message.push(errorLog[i].message);
                            }
                            alert(message.join("\n"));
                        }
                        else
                        {
                            toast.push("저장되었습니다.");
                            Common.search.setValue(fnObj.searchScatter.target, "scaDate", res.map.scaDate);
                            Common.search.setValue(fnObj.searchScatter.target, "scaSeq", res.map.scaSeq);
                            fnObj.searchScatter.submit();
//                             fnObj.form.clear();
                        }
                    });
                },
                saveApplicant: function(applType, changeAddr, form){
                    var validateResult = form.validate_target.validate();
                    if (!validateResult) {
                        var msg = form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var beforeApplId = $("#info-beforeApplId").val();
                    var info = form.getJSON();
                    app.ajax({
                        type: "PUT",
                        url: "/SCAT1010/applicant/"+$("#info-scaDate").val().date().print("yyyymmdd")+"/"+$("#info-scaSeq").val()+"/"+applType+"/"+changeAddr+"/"+beforeApplId,
                        data: Object.toJSON(info)
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else if(res.map.error){
                            var errorLog = res.map.error.log;
                            var message = [];
                            for(var i=0; i<errorLog.length; i++){
	                            $('input[name="'+errorLog[i].field+'"], select[name="'+errorLog[i].field+'"]', form.target).css("background-color", "#FF0000");
	                            $('input[name="'+errorLog[i].field+'String"], select[name="'+errorLog[i].field+'String"]', form.target).css("background-color", "#FF0000");
	                            message.push(errorLog[i].message);
                            }
                            alert(message.join("\n"));
                        }
                        else
                        {
                            toast.push("저장되었습니다.");
//                             fnObj.form.clear();
                        }
                    });
                },
                searchRentalfeeModalResult : function(item){

                	app.ajax({
                        type: "GET",
                        url: "/SCAT1010/pricelist/"+item.addrPart+"/"+item.dcGubun,
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    		app.modal.close();
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("사용료가 등록되지 않았습니다.");
                    			return;
                    		}
                    		$("#info-rentalfee").val(res.map.pricelist.charge);
                    		$("#info-dcAmt").val(res.map.dcAmt);
                    		$("#info-charge").val(res.map.pricelist.charge-res.map.dcAmt);
                    		$("#info-cashAmt").val(res.map.pricelist.charge-res.map.dcAmt);

                    		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                    		app.modal.close();
                        }
                    });
                },
                searchThedeadModalResult: function(thedead){
                	for(var key in thedead){
                		$("#info-"+key).val(thedead[key]);
                		$("#info-"+key).bindSelectSetValue(thedead[key]);
                		app.modal.close();
                		$("[id^='info-dead']").change();
                		$("[id^='info-dead']").blur();
                	}
                },
                searchApplicantModalResult: function(applicant){
                	$("#info-beforeApplId").val($("#info-applId").val());
                	for(var key in applicant){
                		$("#info-"+key).val(applicant[key]);
                		$("#info-"+key).bindSelectSetValue(applicant[key]);
                	}
               		app.modal.close();
                },
                searchScatter: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-scatter",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.searchScatter.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"산골관리번호", labelWidth:"", type:"inputText", width:"150", key:"scaDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
//             										$("#info-ensDate").val(this.value);
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"150", key:"scaSeq", addClass:"", valueBoxStyle:"", value:""
                                    	, onChange: function(changedValue){
            								//아래 2개의 값을 사용 하실 수 있습니다.
//             								toast.push(Object.toJSON(this));
//             								toast.push(changedValue);
//                                     		$("#info-ensSeq").val(changedValue);
            							}
                                    }
            						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
            							onclick: function(){
            								fnObj.searchScatter.submit();
            							}
            						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	app.ajax({
                			async: false,
                            type: "GET",
                            url: "/SCAT1010/scatter/"+$("#"+fnObj.searchScatter.target.getItemId("scaDate")).val().date().print("yyyymmdd")+"/"+$("#"+fnObj.searchScatter.target.getItemId("scaSeq")).val(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.massage);
                        	}else{
                        		if(!res.map.scatterVTO || res.map.scatterVTO == null){
                        			toast.push("검색 결과가 존재하지 않습니다.");
                        			return;
                        		}
                        		if(res.map.scatterVTO.thedeadVTO){
	                        		$.each(res.map.scatterVTO.thedeadVTO, function(key, value){
	                       				res.map.scatterVTO[key] = value;
	                        		});
                        		}
                        		if(res.map.scatterVTO.applicantVTO){
	                        		$.each(res.map.scatterVTO.applicantVTO, function(key, value){
	                        			if(key == "applJumin" && value.length == 12){
	                        				$("#ax-input-segment").setValueInput(1);

	                        			}
	                        			res.map.scatterVTO[key] = value;
	                        		});
                        		}
                        		fnObj.form.clear();
                        		fnObj.formApplicant.clear();
                        		fnObj.form.setJSON(res.map.scatterVTO);
                        		fnObj.formApplicant.setJSON(res.map.scatterVTO);
                        		$("#info-beforeApplId").val(res.map.scatterVTO.applId);
                        		$("#div-tab").updateTabs(fnObj.CODES.tab);
    							$("#div-contents").append($("[id^='div-tab-content-']"));
    							$("#div-content").append($("#div-tab-content-A"));
    							$("#info-receiptGb").change();
    							$("#ax-input-switch").setValueInput("암호화 적용");
    							$("#info-applJumin").blur();
                        	}
                    	});
                    }
                },
                searchHwaCremation: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-hwaCremation",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.searchHwaCremation.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"화장관리번호", labelWidth:"", type:"inputText", width:"150", key:"cremDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
            										toast.push(Object.toJSON(this));
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"150", key:"cremSeq", addClass:"", valueBoxStyle:"", value:""}
            						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
            							onclick: function(){
            								fnObj.searchHwaCremation.submit();
            							}
            						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	$('#ax-form-btn-new').click();
                        var pars = this.target.getParam();
                        var url = "/CREM2010/hwaCremation/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val()+"/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
                        if(url.match("$/")){
                        	toast.push("화장관리번호를 입력해 주세요.");
                        	return;
                        }
                    	app.ajax({
                			async: false,
                            type: "GET",
                            url: url,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		if(!res.map.hwaCremationVTO || res.map.hwaCremationVTO == null){
                        			toast.push("검색 결과가 존재하지 않습니다.");
                        			return;
                        		}
                        		if(res.map.hwaCremationVTO.thedeadVTO){
	                        		$.each(res.map.hwaCremationVTO.thedeadVTO, function(key, value){
	                       				res.map.hwaCremationVTO[key] = value;
	                        		});
                        		}
                        		if(res.map.hwaCremationVTO.applicantVTO){
	                        		$.each(res.map.hwaCremationVTO.applicantVTO, function(key, value){
	                        			if(key == "applJumin" && value.length == 12){
	                        				$("#ax-input-segment").setValueInput(1);
	                        			}
	                        			res.map.hwaCremationVTO[key] = value;
	                        		});
                        		}
                        		fnObj.form.clear();
                        		fnObj.formApplicant.clear();
                        		fnObj.form.setJSON(res.map.hwaCremationVTO.thedead);
                        		fnObj.formApplicant.setJSON(res.map.hwaCremationVTO.applicant);
                        		$("[id^='info-dead']").change();
                        		//$("#info-receiptGb").bindSelectSetValue(res.map.hwaCremationVTO.receiptGb);

                        		$("#info-deadRelation").bindSelectSetValue(res.map.hwaCremationVTO.applRelation);
                        		$("#info-deadRelationNm").val(res.map.hwaCremationVTO.applRelationNm);
                        		 var objt = {"TMC0300001" : "TFM2700001"
                    				 , "TMC0300003" : "TFM2700005"
                    				 , "TMC0300007" : "TFM2700010"
                    				 };
                         		$("#info-objt").bindSelectSetValue(objt[res.map.hwaCremationVTO.objt]);
                         		$("#ax-input-switch").setValueInput("암호화 적용");
                         		$("#info-receiptGb").change();
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

                        $("#info-receiptGb").change();

                        $('#ax-form-btn-new').click(function() {
                            fnObj.form.clear();
                            fnObj.formApplicant.clear();
                           	$("#div-tab").updateTabs(fnObj.CODES.firstTab);
							$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-A"));
							Common.search.setValue(fnObj.searchScatter.target, "scaDate", new Date().print());
							Common.search.setValue(fnObj.searchScatter.target, "scaSeq", "");
							 $("#info-deadPlace").bindSelectSetValue("TCM0900002");
							 $("#info-deadReason").bindSelectSetValue("TCM0300001");
							 $("#info-receiptGb").change();
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
                        $('#info-key').removeAttr("readonly");
                    }
                },
                formApplicant: {
                    target: $('#form-info-applicant'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info-applicant"
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
                // form

            };
        </script>

    </ax:div>
</ax:layout>