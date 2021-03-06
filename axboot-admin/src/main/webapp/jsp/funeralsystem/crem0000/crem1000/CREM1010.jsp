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
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}">
                	<button type="button" class="AXButton Red" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                </ax:custom>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width: 350px;">
			                <div class="ax-search" id="page-search-box"></div>
                        </ax:custom>
                        <ax:custom customid="td">
<!--                             <h2><i class="axi axi-list-alt"></i> 화장예약 접수</h2> -->
							<div class="ax-button-group">
							    <div id="div-bookObjtColor" class="right" style="margin-right: 5%;">
			                    </div>
			                    <div class="right" style="margin-right: 5%;">
			                    	<b><i class='axi axi-circle' style='color:green; font-size:20px;'></i> : 시신</b>,
			                    	<b><i class='axi axi-circle' style='color:red; font-size:20px;'></i> : 개장유골</b>,
			                    	<b><i class='axi axi-circle' style='color:yellow; font-size:20px;'></i> : 사산아</b>
			                    </div>
		                    </div>
                        </ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="2">
                         	<div class="ax-grid" id="page-grid-box-rogrpchasu" style="min-height: 360px;"></div>
                        </ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="2">

                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="예약대상" style="width:200px;">
                                        <select id="info-bookBurnObjt" name="bookBurnObjt" class="AXSelect W100"></select>
                                    </ax:field>
                                    <ax:field label="사망자">
                                    	<input type="hidden" id="info-deadId" name="deadId" class="AXInput W30" value="" readonly="readonly"/>
                                        <input type="text" id="info-bookDeadName" name="bookDeadName" title="사망자" placeholder="사망자" maxlength="100" class="AXInput W100 av-required" value=""/>
                                     <!--    <button id="btn-search-thedead" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button> -->
                                    </ax:field>
                                    <ax:field label="주민번호">
                                        <input type="text" id="info-bookDeadJumin" name="bookDeadJumin" title="주민번호" placeholder="주민번호" maxlength="14" class="AXInput W100" value="" />
                                    </ax:field>
                                    <ax:field label="신청자*">
                                    	<input type="hidden" id="info-applId" name="applId" title="신청자번호" placeholder="" readonly="readonly" maxlength="100" class="AXInput W30" value=""/>
                                        <input type="text" id="info-bookApplName" name="bookApplName" title="신청자" placeholder="신청자" maxlength="14" class="AXInput W100 av-required" value="" />
                                        <!-- <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button> -->
                                    </ax:field>
                                    <ax:field label="신청자 주민번호">
                                        <input type="text" id="info-bookApplJumin" name="bookApplJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W100 av-required" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="예약번호" style="width:200px;">
                                        <input type="text" id="info-bookDate" name="bookDate" title="예약일" class="AXInput W80" readonly="readonly" value=""/>
                                        <select id="info-bookChasu" name="bookChasu" class="AXSelect W40"></select>
                                        <select id="info-bookChasuSeq" name="bookChasuSeq" class="AXSelect W40"></select>
                                    </ax:field>
                                    <ax:field label="사망일자">
                                        <input type="text" id="info-bookDeadDate" name="bookDeadDate" title="사망일자" placeholder="사망일자" class="AXInput W100" value=""  pattern="date"/>
                                    </ax:field>
                                    <ax:field label="사망시간">
                                        <input type="text" id="info-bookDeadTime" name="bookDeadTime" title="사망시간" placeholder="사망시간" class="AXInput W100" value="" />
                                    </ax:field>
                                    <ax:field label="휴대폰">
                                        <input type="text" id="info-bookMobileno1" name="bookMobileno1" title="휴대폰" placeholder="000" class="AXInput W40" value="" />
                                        <input type="text" id="info-bookMobileno2" name="bookMobileno2" title="휴대폰" placeholder="0000" class="AXInput W40" value="" />
                                        <input type="text" id="info-bookMobileno3" name="bookMobileno3" title="휴대폰" placeholder="0000" class="AXInput W40" value="" />
                                    </ax:field>
                                    <ax:field label="전화번호">
                                        <input type="text" id="info-bookTelno1" name="bookTelno1" title="전화번호" placeholder="000" class="AXInput W40" value="" />
                                        <input type="text" id="info-bookTelno2" name="bookTelno2" title="전화번호" placeholder="0000" class="AXInput W40" value="" />
                                        <input type="text" id="info-bookTelno3" name="bookTelno3" title="전화번호" placeholder="0000" class="AXInput W40" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="접수일시" style="width:200px;">
                                        <input type="text" id="info-receiveymd" name="receiveymd" title="접수일시" class="AXInput W80" readonly="readonly" value="" />
                                        <input type="text" id="info-receivetime" name="receivetime" title="접수시간" class="AXInput W70" readonly="readonly" value="" />
                                    </ax:field>
                                    <ax:field label="임신주수">
                                        <input type="text" id="info-bunmanwol" name="bunmanwol" title="임신주수" maxlength="2" class="AXInput W40" value=""  />
                                    </ax:field>
                                    <ax:field label="유/분골">
                                        <select id="info-bookBoneGb" name="bookBoneGb" class="AXSelect W100"></select>
                                    </ax:field>
                                    <ax:field label="사망자와의관계">
                                    <select id="info-bookRelation" name="bookRelation" class="AXSelect W100"></select>
                                    <input type="text" id="info-bookRelationNm" name="bookRelationNm" title="사망자와의관계" placeholder="사망자와의관계" class="AXInput W100" value=""  />

                                    </ax:field>
                                    <input type="hidden" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value=""  />
                                    <input type="hidden" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value=""  />
                                    <%-- <ax:field label="email">
                                        <input type="text" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value=""  />@<input
                                        type="text" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value=""  />
                                    </ax:field> --%>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="접수방법" style="width:200px;">
                                        <select id="info-bookingType" name="bookingType" class="AXSelect W100"></select>
                                    </ax:field>
<%--                                     <ax:field label="발급기관/번호" style="width: 431px;"> --%>
                                        <input type="hidden" id="info-deadDocnm" name="deadDocnm" title="발급기관" placeholder="발급기관" class="AXInput W100" value=""  />
                                        <input type="hidden" id="info-deadDocno" name="deadDocno" title="발급번호" placeholder="발급번호" class="AXInput W100" value=""  />
<%--                                     </ax:field> --%>
<%--                                     <ax:field label="SMS"> --%>
                                        <input type="hidden" id="info-bookSmsFlag" name="bookSmsFlag" title="SMS" placeholder="SMS" class="AXInput W100" value=""  />
<!--                                         <select id="info-bookSmsFlag" name="bookSmsFlag" class="AXSelect W100"> -->
<!--                                         	<option value="1">예</option> -->
<!--                                         	<option value="0">아니오</option> -->
<!--                                         </select> -->
<%--                                     </ax:field> --%>
                                    <ax:field label="관내구분">
                                        <select id="info-bookAddrPart" name="bookAddrPart" class="AXSelect W100"></select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사망자 주소" style="width: 1013px;">
                                        <select id="info-deadAddrGubun" name="deadAddrGubun" class="AXSelect W50"></select>
                                        <input type="text" id="info-bookDeadPost" name="bookDeadPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" />
                                         <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
					                    <input type="text" id="info-bookDeadAddr1" name="bookDeadAddr1" title="사망자 주소" readonly="readonly" placeholder="클릭해 주세요." class="AXInput W300" value="" />
                                        <input type="text" id="info-bookDeadAddr2" name="bookDeadAddr2" title="사망자 주소" placeholder="상세주소" class="AXInput W300" value=""  />
                                    </ax:field>
                                    <ax:field label="국적구분">
                                        <select id="info-deadNationGb" name="deadNationGb" class="AXSelect W100"></select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="신청자 주소" style="width: 1013px;">
                                        <select id="info-applAddrGubun" name="applAddrGubun" class="AXSelect W50"></select>
                                        <input type="text" id="info-bookApplPost" name="bookApplPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" />
                                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
                                        <button type="button" class="AXButton" id="btn-same"><i class="axi axi-local-post-office"></i> 상동</button>
                                        <input type="text" id="info-bookApplAddr1" name="bookApplAddr1" title="신청자 주소" readonly="readonly" placeholder="클릭해 주세요." class="AXInput W300" value="" />
                                        <input type="text" id="info-bookApplAddr2" name="bookApplAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W300" value=""  />
                                    </ax:field>
                                    <ax:field label="국적구분">
                                        <select id="info-applNationGb" name="applNationGb" class="AXSelect W100"></select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="특이사항" style="width: 742px;">
                                        <input type="text" id="info-bookRemark" name="bookRemark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 99%;" value="" />
                                    </ax:field>

                                    	<!-- <input type="hidden" id="info-addrCode" name="addrCode" class="AXSelect W150" value="" /> -->

                                    <ax:field label="장례식장명">
                                        <input type="text" id="info-company" name="company" title="장례식장명" placeholder="장례식장명" class="AXInput W100" value=""  />
                                    </ax:field>
                                    <ax:field label="접수담당자">
                                        <input type="text" id="info-receiveperson" name="receiveperson" title="접수담당자" placeholder="접수담당자" class="AXInput W100" value="" />
                                    </ax:field>

                                </ax:fields>
                            </ax:form>

                        </ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="2">
							<div class="ax-button-group">
								<div class="left">
									<select id="sl-condition" name="condition" class="AXSelect">
										<option value="all">전체</option>
										<option value="ad">고인+신청자</option>
										<option value="d">고인</option>
										<option value="a">신청자</option>
									</select>
                                    <input type="text" id="ip-keyword" name="keyword" title="검색" placeholder="검색" class="AXInput W100" value="" />
									<button id="btn-hwaBooking-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 예약자료검색</button>
								</div>
								<div class="right">
								    <button id="btn-funeral-search" type="button" class="AXButton"><i class="axi axi-ion-android-search"></i> 장례식장자료로 접수</button>
									<button id="btn-cremation-receipt" type="button" class="AXButton" ><i class="axi axi-receipt"></i> 화장접수</button>
								</div>
								<div class="ax-clear"></div>
							</div>
                            <div class="ax-grid" id="page-grid-box-hwaBooking" style="min-height: 200px;"></div>
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
                {id:"page-grid-box-rogrpchasu", adjust:function(){
                    	return -axf.clientHeight()/1.9;
                	}
                }
                , {id:"page-grid-box-hwaBooking", adjust:function(){
    	                return -axf.clientHeight()/1.8;
	                }
                }
            ];
            var fnObj = {
                CODES: {
                    "chasu": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM1010/chasuSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "chasuSeq": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM1010/roSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "bookBurnObjt": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TMC02",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
//                     "emailProvider": (function(){
//                     	var result;
//                     	app.ajax({
//                     			async: false,
// 	                            type: "GET",
// 	                            url: "/api/v1/basicCodes/groupSelect?basicCd=EMAIL_PROVIDER",
// 	                            data: ""
// 	                        },
// 	                        function(res){
// 	                        	result = res;
//                         	}
//                         );
//                     	return result;
//                     }()),
                    "bookBoneGb": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TMC05",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "bookingType": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TMC04",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "bookAddrPart": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TCM10",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "addrGubun": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TCM07",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "deadNationGb": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TCM04",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "applNationGb": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=TCM11",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "bookStatus": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/basicCodes/groupSelect?basicCd=BOOK_STATUS",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "addrCode": Common.addr.getAddrCode(),
                    "color": Common.getCode("BOOK_OBJT_COLOR"),
                    "bookRelation" : Common.getCode("TCM08"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.gridRogrpchasu.bind();
                    this.gridHwaBooking.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                    this.setDivBookObjtColor();
                },
                setDivBookObjtColor: function(){
                	var result = [];
                	for(var i=0; i<fnObj.CODES.color.length; i++){
                		result.push(
                				"<b><i class='axi axi-stop3' style='color:"
                				+fnObj.CODES.color[i].optionText
                				+"; font-size:20px;'></i> : "
                				+fnObj.CODES.color[i].optionName.replace("화장 예약 대상 ", "")+"</b>");
                	}
                	$("#div-bookObjtColor").html(result.join(", "));
                },
                exchangeModalResult: function(info){

                    app.ajax({
                        type: "PUT",
                        url: "/CREM1011/hwaBooking",
                        data: Object.toJSON(info)
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }else{
		                	toast.push("변경되었습니다.");
		                	app.modal.close();
		                	$("#btn-hwaBooking-search").click();
		                	$("#ax-page-btn-search").click();
		                	$('#ax-form-btn-new').click();
                        }
                    });

                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.gridHwaBooking.del();
                        }, 500);
                    });
                    $("#btn-search-thedead").bind("click", function(){
                    	var deadDate = $("#"+fnObj.search.target.getItemId("searchParams")).val();
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp",
	                        //pars:"callBack=fnObj.searchThedeadModalResult&deadId="+$("#info-deadId").val(),
	                        pars:"callBack=fnObj.searchThedeadModalResult&deadDate="+deadDate+"&deadId="+$("#info-deadId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
//                     $("#info-bookBurnObjt").bindSelector({
//         				appendable:true,
//         				options:fnObj.CODES.bookBurnObjt
//         			});
                    $("#info-bookBurnObjt").bindSelect({
                        options:fnObj.CODES.bookBurnObjt
                    });
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-bookDeadPost", "info-bookDeadAddr1", "info-bookDeadAddr2");
                    });
                    $("#btn-applpost").bind("click", function(){
                    	daumPopPostcode("info-bookApplPost", "info-bookApplAddr1", "info-bookApplAddr2");
                    });
                    $("#info-bookDeadJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                    $("#info-bookApplJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                    $("#info-bookDeadDate").bindPattern({pattern: "date"});
                    //$("#info-bookDeadDate").bindDate();
                    $("#info-bookDate").bindDate();
                    $("#info-bookDate").val(new Date().print());
                    $("#info-bookDeadTime").bindPattern({pattern: "time"});
                    $("#info-bookTelno1").bindPattern({pattern: "custom", max_length: 3, patternString:"999"});
                    $("#info-bookTelno2").bindPattern({pattern: "custom", max_length: 4, patternString:"9999"});
                    $("#info-bookTelno3").bindPattern({pattern: "custom", max_length: 4, patternString:"9999"});
                    $("#info-bookMobileno1").bindPattern({pattern: "custom", max_length: 3, patternString:"999"});
                    $("#info-bookMobileno2").bindPattern({pattern: "custom", max_length: 4, patternString:"9999"});
                    $("#info-bookMobileno3").bindPattern({pattern: "custom", max_length: 4, patternString:"9999"});
                    $("#info-receiveymd").bindPattern({pattern: "date"});
                    $("#info-receivetime").bindPattern({pattern: "time"});
//         			$("#info-bunmanwol").bindNumber(
//         					{
//         						min:1,
//         						max:99,
//         						onChange : function(){
// //         							trace(this);
//         						}
//         					}
//         				);
                    $("#info-bookChasu").bindSelect({
        				options:fnObj.CODES.chasu
        			});
                    $("#info-bookChasuSeq").bindSelect({
        				options:fnObj.CODES.chasuSeq
        			});
//                     $("#info-emailProvider").bindSelector({
//         				appendable:true,
//         				options:fnObj.CODES.emailProvider
//         			});
                    $("#info-bookBoneGb").bindSelect({
        				options:fnObj.CODES.bookBoneGb
        			});
//                     $("#info-bookBoneGb").bindSelectDisabled(true);
                   	setTimeout(function(){
                   		$("#info-bookBoneGb").setValueInput(fnObj.CODES.bookBoneGb[0].optionValue);
                   	}, 500);
                    $("#info-bookingType").bindSelect({
        				options:fnObj.CODES.bookingType
        			});
                   	setTimeout(function(){
                   		$("#info-bookingType").setValueInput(fnObj.CODES.bookingType[0].optionValue);
                   	}, 500);
                    $("#info-bookAddrPart").bindSelect({
        				options:fnObj.CODES.bookAddrPart
        			});
                   	setTimeout(function(){
                   		$("#info-bookAddrPart").val(fnObj.CODES.bookAddrPart[0].optionValue);
                   	}, 500);
                    $("#info-deadAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                   	setTimeout(function(){
                   		$("#info-deadAddrGubun").val(fnObj.CODES.addrGubun[0].optionValue);
                   	}, 500);
                    $("#info-applAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                   	setTimeout(function(){
                   		$("#info-applAddrGubun").val(fnObj.CODES.addrGubun[0].optionValue);
                   	}, 500);
                    $("#info-deadNationGb").bindSelect({
        				options:fnObj.CODES.deadNationGb
        			});
                   	setTimeout(function(){
                   		$("#info-deadNationGb").val(fnObj.CODES.deadNationGb[0].optionValue);
                   	}, 500);
                    $("#info-applNationGb").bindSelect({
        				options:fnObj.CODES.applNationGb
        			});
                    //$("#info-addrCode").bindSelect({
                     //   //options:fnObj.CODES.addrCode
                    //});
                   // $("#info-bookDeadAddr1").change(function(){
                   // 	Common.addr.getAddrPart(this.value, "info-addrCode", "info-bookAddrPart");
                   // });



                   	setTimeout(function(){
                   		$("#info-applNationGb").val(fnObj.CODES.applNationGb[0].optionValue);
                   	}, 500);
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
                    $("#btn-hwaBooking-search").bind("click", function(){
                    	fnObj.gridHwaBooking.setPage();
                    });
                    $("#btn-book-exchange").bind("click", function(){
                    	var selectedItem =fnObj.gridHwaBooking.target.getSelectedItem();
                        if(!selectedItem || selectedItem==null){
                            alert("선택된 목록이 없습니다. 예약자료를 선택하세요.");
                            return;
                        }
                        var time;
                        $(fnObj.gridRogrpchasu.target.getList()).each(function(i){
                        	if(this.chasuSeq == selectedItem.item.bookChasuSeq){
                        		time = this.strttimeString + "-" + this.endtimeString;
                        	}
                       	});

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem1000/CREM1011.jsp",
	                        pars:"callBack=fnObj.exchangeModalResult&bookDate="+selectedItem.item.bookDate+"&bookChasu="+selectedItem.item.bookChasu+"&bookChasuSeq="+selectedItem.item.bookChasuSeq+"&time="+time,
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#btn-cremation-receipt").bind("click", function(){
                    	var selectedItem =fnObj.gridHwaBooking.target.getSelectedItem();
                        if(!selectedItem || selectedItem==null){
                            alert("선택된 목록이 없습니다. 예약자료를 선택하세요.");
                            return;
                        }
                        if(selectedItem.item.bookStatus != '미접수'){
                    		toast.push("미접수자료가 아닙니다.");
                    		return;
                    	}
						window.location.href = "/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?bookDate="+selectedItem.item.bookDate+"&bookChasu="+selectedItem.item.bookChasu+"&bookChasuSeq="+selectedItem.item.bookChasuSeq;
                    });
					$("#btn-search-applicant").bind("click", function(){

						app.modal.open({
						    url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
						    pars:"callBack=fnObj.searchApplicantModalResult&applId="+$("#info-applId").val(),
						    width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
						    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
						});
				 	});

					$("#ip-keyword").keydown(function (key) {
                        if(key.keyCode == 13){
                        	fnObj.gridHwaBooking.setPage();
                        }
                    });

					$("#btn-funeral-search").bind("click", function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem1000/CREM1012.jsp",
	                        pars:"callBack=fnObj.searchFuneralModalResult",
	                        width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#btn-same").bind("click", function(){
						$("#info-bookApplPost").val($("#info-bookDeadPost").val());
						$("#info-bookApplAddr1").val($("#info-bookDeadAddr1").val());
						$("#info-bookApplAddr2").val($("#info-bookDeadAddr2").val());
					});
					$("#info-bookApplPost, #info-bookApplAddr1, #info-bookApplAddr2").bind("keyup", function(e){
						if(e.keyCode==36){
							$("#btn-same").click();
						}
					});

					$("#info-bookRelation").bindSelect({
        				options:fnObj.CODES.bookRelation
        			});
                },
                searchFuneralModalResult : function(funeral){
                	var item = fnObj.gridHwaBooking.target.getSelectedItem();
                	var bookParams = ""
                	if(!item.error){
                		bookParams += "&bookDate="+item.item.bookDate;
                		bookParams += "&bookChasu="+item.item.bookChasu;
                		bookParams += "&bookChasuSeq="+item.item.bookChasuSeq;
                	}else{
                		alert("화장자료를 선택해 주세요")
                		return;
                	}

                	window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?customerNo="+funeral.item.customerNo+bookParams, "CREM2010")
                },
                searchThedeadModalResult: function(thedead){
                	for(var key in thedead){
                		$("#info-"+key).val(thedead[key]);
                		$("#info-"+key).bindSelectSetValue(thedead[key]);
                		$("#info-book"+key[0].toUpperCase()+key.substring(1)).val(thedead[key]);
                		$("#info-book"+key[0].toUpperCase()+key.substring(1)).bindSelectSetValue(thedead[key]);
                		app.modal.close();
                	}
                	$("#info-bookDeadDate").val(thedead["deadDate"].date().print());
                	$("#info-bookDeadTime").val(thedead["deadTime"].date().print("hhmm"));
                },
                searchApplicantModalResult: function(applicant){
                	$("#info-beforeApplId").val($("#info-applId").val());
                	for(var key in applicant){
                		$("#info-"+key).val(applicant[key]);
                		$("#info-"+key).bindSelectSetValue(applicant[key]);
                		$("#info-book"+key[0].toUpperCase()+key.substring(1)).val(applicant[key]);
                		$("#info-book"+key[0].toUpperCase()+key.substring(1)).bindSelectSetValue(applicant[key]);
                		$("#info-"+key).blur();
                		$("#info-book"+key[0].toUpperCase()+key.substring(1)).blur();
                	}
                	$("#info-bookMobileno1").val(applicant["applMobileno1"]);
                	$("#info-bookMobileno2").val(applicant["applMobileno2"]);
                	$("#info-bookMobileno3").val(applicant["applMobileno3"]);
                	$("#info-bookTelno1").val(applicant["applTelno1"]);
                	$("#info-bookTelno2").val(applicant["applTelno2"]);
                	$("#info-bookTelno3").val(applicant["applTelno3"]);
               		app.modal.close();
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
                        url: "/CREM1010/hwaBooking",
                        data: Object.toJSON(info)
                    },
                    function(res){
                        if(res.error){
                            console.log(res.error.message);
                            var errorLog = JSON.parse(res.error.message);
                            var message = [];
                            for(var i=0; i<errorLog.length; i++){
	                            $('input[name="'+errorLog[i].field+'"], select[name="'+errorLog[i].field+'"]').css("background-color", "#FF0000");
	                            message.push(errorLog[i].message);
                            }
                            alert(message.join("\n"));
                        }
                        else
                        {
                            toast.push("저장되었습니다.");
                            fnObj.search.submit();
//                             fnObj.form.clear();
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
										{label:"예약 일자", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
											onclick: function(){
        											var date = Common.search.getValue(fnObj.search.target, "searchParams").date();
        											date.setDate(date.getDate()-1);
         											Common.search.setValue(fnObj.search.target, "searchParams", date.print());
        											$("#ax-page-btn-search").click();
        										}
        									},
                                       		{label:"", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:new Date().print(),
	                                           	AXBind:{
	                   								type:"date", config:{
	                   									align:"right", valign:"top", defaultDate:new Date(),
	                   									onChange:function(){
	                   										setTimeout(function(){$("#ax-page-btn-search").click();}, 100);
	                   									}
	                   								}
	                   							}
                                          	},
	       									{label:"", labelWidth:"", type:"button", width:"30", key:"rightDate", addClass:"", valueBoxStyle:"", value:">",
	       										onclick: function(){
	       											var date = Common.search.getValue(fnObj.search.target, "searchParams").date();
	       											date.setDate(date.getDate()+1);
        											Common.search.setValue(fnObj.search.target, "searchParams", date.print());
	       											$("#ax-page-btn-search").click();
	       										}
       										}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.gridRogrpchasu.setPage(fnObj.gridRogrpchasu.pageNo, pars);
                        $("#btn-hwaBooking-search").click()
                    }
                },

                gridRogrpchasu: {
                	getColor: function(addrPart, objt){
//                 		this.color  = {
//                 				// 시체
//                 				"TCM1000001TMC0200001" : "#3DFF92"		//관내
//                 				, "TCM1000002TMC0200001" : "#55EE94"		//인접/준관내
//                 				, "TCM1000003TMC0200001" : "#66CDAA"		//관외
//                 				, "TCM1000004TMC0200001" : "#AAEBAA"		//도내(광역)
//                 				, "TCM1000005TMC0200001" : "#80E12A"		//인접

//                 				// 개장유골
//                 				, "TCM1000001TMC0200002" : "#FFB6C1"		//관내
//                 				, "TCM1000002TMC0200002" : "#FFAAAF"		//인접/준관내
//                 				, "TCM1000003TMC0200002" : "#FF9E9B"		//관외
//                 				, "TCM1000004TMC0200002" : "#FF7A85"		//도내(광역)
//                 				, "TCM1000005TMC0200002" : "#FF5675"		//인접

//                 				// 죽은태아
//                 				, "TCM1000001TMC0200003" : "#FAEB78"		//관내
//                 				, "TCM1000002TMC0200003" : "#FFDC3C"		//인접/준관내
//                 				, "TCM1000003TMC0200003" : "#FFC81E"		//관외
//                 				, "TCM1000004TMC0200003" : "#FFB400"		//도내(광역)
//                 				, "TCM1000005TMC0200003" : "#FDCD8C"		//인접
//                 		}
						for(var i=0; i<fnObj.CODES.color.length; i++){
							if(fnObj.CODES.color[i].optionValue == addrPart+objt){
								return fnObj.CODES.color[i].optionText;
							}
						}
                	},
                	roFormatter:function(val){

                		if(isNaN(+(this.value))){
							if(!this.value){
								return "";
							}
							var color = fnObj.gridRogrpchasu.getColor(this.item[this.key+"booking"].bookAddrPart, this.item[this.key+"booking"].bookBurnObjt);
                			return "<div style='background-color:"+color+"; padding:2px; width:90%; height:90%;'>"+this.value+"</div>";
                			//return "<div style='background-color:#00FF7F; padding:2px; width:90%; height:90%;'>"+this.value+"</div>";
                		}

                		if(this.value.toString() == "000"){
                			return "불가";
                		}

                		var res = [];
						var color = ["green", "red", "yellow"];
                		for(var i=0; i<this.value.toString().length; i++){
                			if(this.value.toString()[i]=="1"){
                				res.push("<i class='axi axi-circle' style='color:"+color[i]+"; font-size:20px;'></i>");
                			}else{
                				res.push("<i class='axi axi-circle' style='color:darkgray; font-size:20px;'></i>");
                			}
                		}

                		return res.join("");
                	},
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-rogrpchasu",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"chasuSeq", label:"차수", width:"50", align:"center", sort: false, colHeadTool: false},
                                {key:"strttimeString", label:"시작시간", width:"60", align:"center", sort: false, colHeadTool: false
                                	, formatter : function(){
                                		if(this.value){
	                                		return Common.pattern.custom(this.value, "99:99");
                                		}else{
                                			return "";
                                		}
                                	}},
                                {key:"endtimeString", label:"종료시간", width:"60", align:"center", sort: false, colHeadTool: false
                                	, formatter : function(){
                                		if(this.value){
	                                		return Common.pattern.custom(this.value, "99:99");
                                		}else{
                                			return "";
                                		}
                                	}},
                                {key:"ro01", label:"1", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                               	},
                                {key:"ro02", label:"2", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                              	},
                                {key:"ro03", label:"3", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro04", label:"4", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro05", label:"5", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro06", label:"6", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro07", label:"7", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro08", label:"8", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro09", label:"9", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro10", label:"10", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro11", label:"11", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro12", label:"12", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro13", label:"13", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro14", label:"14", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro15", label:"15", width:"80", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro16", label:"16", width:"100", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro17", label:"17", width:"100", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro18", label:"18", width:"100", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro19", label:"19", width:"100", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro20", label:"20", width:"100", align:"center", sort: false, colHeadTool: false
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){

									if(this.c<3){
										return;
									}
									var chasu = this.item.chasuSeq;
									var seq = Common.grid.getColLabel(fnObj.gridRogrpchasu.target, this.c);

									var hwaBookingList = fnObj.gridHwaBooking.target.list;
									for(var i=0; i<hwaBookingList.length; i++){
										if(hwaBookingList[i].bookChasu == chasu && +hwaBookingList[i].bookChasuSeq == seq){
											Common.grid.setFocus(fnObj.gridHwaBooking.target, i);
										}
									}
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/CREM1010/findRogrpchasu/"+$("#"+fnObj.search.target.getItemId("searchParams")).val(),
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list,
                                    page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    }
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },
                gridHwaBooking: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-hwaBooking",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"bookChasu", label:"차수", width:"80", align:"center"},
                                {key:"bookChasuSeq", label:"순번", width:"80", align:"center"},
                                {key:"bookBurnObjt", label:"대상구분", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.bookBurnObjt.length; i++){
                                    		if(fnObj.CODES.bookBurnObjt[i].optionValue == this.value){
                                    			return fnObj.CODES.bookBurnObjt[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                                },
                                {key:"bookDeadName", label:"고인명", width:"150", align:"center"},
                                {key:"company", label:"장례식장명", width:"150", align:"center"},
                                {key:"bookApplName", label:"신청자명", width:"150", align:"center"},
                                {key:"bookApplJumin", label:"신청자주민번호", width:"150", align:"center"},
                                {key:"bookMobileString", label:"휴대전화", width:"150", align:"center"},
                                {key:"receiveymd", label:"접수일자", width:"150", align:"center"
                                	, formatter:function(val){
                                		var res = [];
                                		for(var i=0; i<this.value.length; i++){
                                			res.push(this.value[i]);
                                			if(i==3 || i==5){
                                				res.push("-");
                                			}
                                		}
                                		return res.join("");
                                	}
                               	},
                                {key:"bookingType", label:"접수경로", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.bookingType.length; i++){
                                    		if(fnObj.CODES.bookingType[i].optionValue == this.value){
                                    			return fnObj.CODES.bookingType[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                               	},
                                {key:"bookStatus", label:"상태", width:"150", align:"center"
                                	//, formatter: function(val){
                                	//	for(var i=0; i<fnObj.CODES.bookStatus.length; i++){
                                	//		if(fnObj.CODES.bookStatus[i].optionValue == val){
	                                //			return fnObj.CODES.bookStatus[i].optionText;
                                	//		}
                                	//	}
                                	//}
                                }
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target;
                        var item = _target.getSelectedItem();
                        if(item.error){
                        	alert("하단 예약 목록 검색 후, 예약자료를 선택해 주세요.");
                        	return;
                        }
						app.ajax({
						    type: "DELETE",
						    url: "/CREM1010/hwaBooking",
						    data: Object.toJSON([item.item])
						},
						function(res) {
						    if (res.error) {
						        alert(res.error.message);
						    } else {
						        $("#btn-hwaBooking-search").click();
						    }
						});

                    },
                    setPage: function(){
                        var _target = this.target;
                        app.ajax({
                            type: "GET",
                            //url: "/CREM1010/hwaBooking/"+$("#sl-condition").val()+"/"+$("#"+fnObj.search.target.getItemId("searchParams")).val()+"/"+$("#ip-keyword").val(),
                            url: "/CREM1020/hwaBookingList",
                            data: "condition="+$("#sl-condition").val()+"&bookDate="+Common.str.replaceAll($("#"+fnObj.search.target.getItemId("searchParams")).val(),"-","")+"&keyword="+$("#ip-keyword").val()
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res
                                };
                                _target.setData(gridData);
                                 fnObj.form.clear();
                                if(res.length > 0){
                                	Common.grid.setFocus(fnObj.gridHwaBooking.target, 0);
                                }



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
                } // form

            };
        </script>

    </ax:div>
</ax:layout>