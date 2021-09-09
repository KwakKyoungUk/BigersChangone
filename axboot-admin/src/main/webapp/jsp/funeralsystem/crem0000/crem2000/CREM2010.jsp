<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%

AdminLoginUser adminLoginUser = (AdminLoginUser)SecurityContextHolder.getContext().getAuthentication().getDetails();

String userNm = adminLoginUser.getUserNm();

request.setAttribute("regname", userNm);
%>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
            a.selectedTextBox:focus {
            	border: 2px solid #58ACFA !important;
            }
            input[type=checkbox]
			{
			  /* Double-sized Checkboxes */
			  -ms-transform: scale(2); /* IE */
			  -moz-transform: scale(2); /* FF */
			  -webkit-transform: scale(2); /* Safari and Chrome */
			  -o-transform: scale(2); /* Opera */
			  padding: 10px;
			  vertical-align: middle;
			}
			.border_top {
				border-top: 1px solid #959595;
			}
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-button-group">
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                        <button type="button" class="AXButton" id="ax-form-btn-clone"><i class="axi axi-plus-circle"></i> 복사</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-button-group">
                	<div class="left" style="width: 50%;">
		                <div class="ax-search" id="page-search-hwaCremation"></div>
                	</div>
                	<div class="right" style="width: 50%;">
		                <div class="ax-search" id="page-search-hwaBooking"></div>
                	</div>
                    <div class="ax-clear"></div>
                </div>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                    	<ax:custom customid="td">
                            <%-- %%%%%%%%%% 폼 (info) %%%%%%%%%% --%>
                            <ax:form id="form-info" name="form-info" method="get" >
                                <input type="hidden" id="info-bookDate" name="bookDate" value=""/>
                                <input type="hidden" id="info-bookChasu" name="bookChasu" value=""/>
                                <input type="hidden" id="info-bookChasuSeq" name="bookChasuSeq" value=""/>
                                <input type="hidden" id="info-cremDateString" name="cremDateString" value=""/>
                                <input type="hidden" id="info-cremSeq" name="cremSeq" value=""/>
                                <input type="hidden" id="info-applSeq" name="applSeq" value=""/>
                                <input type="hidden" id="info-sendYn" name="sendYn" value="N"/>

                                <input type="hidden" id="info-enshUseGb" name="enshUseGb" value=""/>
                                <input type="hidden" id="info-enshObjt" name="enshObjt" value=""/>
                                <input type="hidden" id="info-enshRemark" name="enshRemark" value=""/>
                                <input type="hidden" id="info-beforeEnsNo" name="beforeEnsNo" value=""/>

                                <input type="hidden" id="info-scaDate" name="scaDate" value=""/>
                                <input type="hidden" id="info-scaSeq" name="scaSeq" value=""/>

                                <input type="hidden" id="info-natDate" name="natDate" value=""/>
                                <input type="hidden" id="info-natSeq" name="natSeq" value=""/>
                                <input type="hidden" id="info-natSeq" name="natSeq" value=""/>
                                <input type="hidden" id="info-locCode" name="locCode" value=""/>
                                <input type="hidden" id="info-blockNum" name="blockNum" value=""/>
                                <input type="hidden" id="info-beforeNatNo" name="beforeNatNo" value=""/>
                                <input type="hidden" id="info-natuUseGb" name="natuUseGb" value=""/>
                                <input type="hidden" id="info-natuObjt" name="natuObjt" value=""/>
                                <input type="hidden" id="info-natuRemark" name="natuRemark" value=""/>
                                <input type="hidden" id="info-beforeNatNo" name="beforeNatNo" value=""/>

                                <input type="hidden" id="info-thedead-familyClanCode" name="familyClanCode" value=""/>
                                <input type="hidden" id="info-thedead-deadDocGubun" name="deadDocGubun" value=""/>
                                <input type="hidden" id="info-thedead-customerNo" name="customerNo" value=""/>
                                <input type="hidden" id="info-thedead-deadFaith" name="deadFaith" value=""/>
                                <input type="hidden" id="info-thedead-deadFaithNm" name="deadFaithNm" value=""/>

                                <input type="hidden" id="info-applicant-applEmail" name="applEmail" value=""/>
                                <input type="hidden" id="info-thedead-deadBirth" name="deadBirth" value="" />
                                <input type="hidden" id="info-thedead-deadDocnm" name="deadDocnm" value=""/>
		                        <input type="hidden" id="info-thedead-deadDocno" name="deadDocno" value=""/>
		                        <input type="hidden" id="info-thedead-sasansayu" name="sasansayu" value=""/>

		                        <input type="hidden" id="info-scatUseGb" name="scatUseGb" value="0" />
		                        <input type="hidden" id="info-extCnt" name="extCnt" value="0" />
		                        <input type="hidden" id="info-thedead-addrCode" name="addrCode" class="AXSelect W350"></input>
<%--                                 <ax:fields>
                                 	<ax:field label="고인번호" style="width:350px;">

                                    </ax:field>
                                </ax:fields> --%>
                                <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 사망자</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <input id="info-thedead-transferDate" type="hidden" name="transferDate" />
								<ax:fields style="border-top: 1px solid #959595;">
								    <ax:field label="사망자명*" style="width:360px;" >
								  	  <input type="text" id="info-thedead-deadId" name="deadId" class="AXInput W100" value=""  readonly="readonly" placeholder="고인번호"/>
                                      <b:input id="info-thedead-deadName" name="deadName" maxlength="100" clazz="W100" title="사망자명" placeholder="사망자명" value="" required="true"></b:input>
                                        <!-- <button id="btn-search-thedead" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button> -->
                                    </ax:field>
                                    <ax:field label="사망자 주민번호" style="width:360px;">
                                    	 <b:input id="info-thedead-deadJumin" name="deadJumin" maxlength="14" clazz="W100" title="사망자 주민번호" placeholder="사망자 주민번호" value="" pattern="custom" patternString="999999-9999999"></b:input>
                                    </ax:field>
                                    <ax:field label="사망자국적구분" style="width:360px;">
                                    	<select id="info-thedead-deadNationGb" name="deadNationGb" class="W100 AXSelect"></select>
                                    	<input  name="gbNm" list="deadNationGbNm" id="info-thedead-deadNationGbNm" class="W100 AXSelect"  placeholder="외국인 국적"/>
										<datalist id="deadNationGbNm">
                                    </ax:field>
								</ax:fields>
                                <ax:fields>
                                    <ax:field label="사망자성별" style="width:360px;">
                                    	<select id="info-thedead-deadSex" name="deadSex" class="W100 AXSelect"></select>
                                    </ax:field>
                                    <ax:field label="화장대상구분*" style="width:360px;">
                                    	<select id="info-objt" name="objt" class="W100 AXSelect"></select>
                                       	<input id="info-openGraveCnt" name="openGraveCnt" class="W50" title="" placeholder="" value="1">
                                    	<button class="AXButton" id="btn-save-ugol" style="display: none;" type="button">유골 등록</button>
                                    </ax:field>
                                    <ax:field label="감면구분*" style="width:360px;">
                                    	<select id="info-dcGubun" name="dcGubun" class="W150 AXSelect"></select>
                                    	<b:input id="info-yugongDetail" name="yugongDetail" maxlength="100" clazz="W100" title="유공자상세" placeholder="유공자상세" value=""></b:input>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                	<ax:field label="<span>사망일/사망시간</span>" style="width:360px;">
                        					<input id="info-thedead-deadDate" name="deadDate" type="date" max="9999-12-31" class="AXInput W140" title="사망일자"/>
                        					<input id="info-thedead-deadTime" name="deadTime" class="W60" title="사망시간"/>
											<input id="info-thedead-deadDocnm" type="hidden" name="deadDocnm" />
											<input id="info-thedead-deadDocno" type="hidden" name="deadDocno" />
                                    </ax:field>
                                    <ax:field label="사망장소" style="width:360px;">
                                    	<select id="info-thedead-deadPlace" name="deadPlace" class="W100 AXSelect"></select>
										<b:input id="info-thedead-deadPlaceNm" name="deadPlaceNm" value="" clazz="W100"/>
                                    </ax:field>
                                    <ax:field label="사망의종류" style="width:360px;">
                                    	<select id="info-thedead-deadReason" name="deadReason" class="W100 AXSelect"></select>
                                    	<input  name="nm" list="deadReasonNm" id="info-thedead-deadReasonNm" class="W100 AXSelect" />
										<datalist id="deadReasonNm">
										</datalist>

                                		<%-- <b:input id="info-thedead-deadReasonNm" name="deadReasonNm" clazz="W100"></b:input> --%>
                                    </ax:field>
<%--                                     <ax:field label="사산사유" style="width:360px;">
                                    	<b:input id="info-thedead-sasansayu" name="sasansayu" maxlength="100" clazz="W100" title="사산사유" placeholder="사산사유" value=""></b:input>
                                    </ax:field> --%>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="<span>장례식장/개장지</span>" style="width:360px;">
                                      	<b:input id="info-thedead-company" name="company" title="장례식장명" placeholder="장례식장명" clazz="W100" value="" ></b:input>
                                    </ax:field>
                                    <ax:field label="임신주수" style="width:360px;">
                                    	<b:input id="info-thedead-bunmanwol" name="bunmanwol" maxlength="2" clazz="W50" title="임신주수" placeholder="임신주수" value=""></b:input>
                                    </ax:field>
                                    <ax:field label="화장시간"  style="width:360px;">
                              		 <select id="info-burnNo" name="burnNo" class="AXSelect W100" style="display: none;"></select>
                              		 <input type="hidden" id="info-burnSeq" name="burnSeq" />
                              		 <select id="info-burnChasu" name="burnChasu" class="AXSelect W200"></select>
                              		</ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="사망자 주소">
                                    	<select id="info-thedead-deadAddrGubun" name="addrGubun" class="AXSelect W80"></select>
                                        <b:input id="info-thedead-deadPost" name="deadPost" clazz="W50" title="우편번호" placeholder="우편번호"  value="" ></b:input>
                                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
                                        <b:input id="info-thedead-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" style="width: 300px;"  clazz="W340" value="" required="true"  ></b:input>
                                        <b:input id="info-thedead-deadAddr2" name="deadAddr2" title="사망자 주소"  placeholder="상세주소" style="width: 288px;"  clazz="W340" value=""  ></b:input>
                                    </ax:field>

<%--                                 	<ax:field label="생년월일" style="width:340px;">
                                    	<b:input id="info-thedead-deadBirth" name="deadBirth" clazz="W100" title="생년월일" value="" pattern="date"></b:input>
                                    </ax:field> --%>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="관내/외구분" style="width:360px;">
                                    	<select id="info-addrPart" name="addrPart" class="AXSelect W100"></select>
                                    </ax:field>
                              		 <ax:field label="관내외사유" style="width:360px;">
                              		 	<select id="info-dcCode" name="dcCode" class="AXSelect W150"></select>
                              		</ax:field>
                              		<ax:field label="유/분골" style="width:360px;">
                              			<select id="info-boneGb" name="boneGb" class="AXSelect W100"></select>
                                    </ax:field>
                                </ax:fields>
                                 <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i>장지</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <ax:fields style="border-top: 1px solid #959595;">
				                  <ax:field label="화장 후 장지" style="width:360px;">
                                		<select id="info-scatterPlace" name="scatterPlace" class="AXSelect W150"></select>
                                    </ax:field>
				                </ax:fields>
                                <ax:fields >
                                   <input type="hidden" id="info-applicant-beforeApplId" name="beforeApplId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
                                   <input type="hidden" id="info-applicant-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
                                   <input type="hidden" id="info-enshStrDate" name="enshStrDate" />
                                   <input type="hidden" id="info-enshEndDate" name="enshEndDate" />

                                    <ax:field label="봉안여부" style="width:360px;">
                                        <select  id="info-enshEnsType" name="ensType" class="AXSelect W100" ></select>
                                	</ax:field>
                                	<ax:field label="관내외사유" style="width:196px;">
                                		<select id="info-enshDcCode" name="enshDcCode" class="AXSelect W150"></select>
                                	</ax:field>
                                	<ax:field label="봉안관리번호">
                                		<input type="text" class="AXInput W100" id="info-ensDate" name="ensDate" value="" readonly="readonly"/>
		                                <input type="text" class="AXInput W50" id="info-ensSeq" name="ensSeq" value="" readonly="readonly"/>
                                        <button id="btn-goEnshrine" type="button" class="AXButton">봉안자료로이동</button>
                                        <button id="btn-searchEnshrine" type="button" class="AXButton" style="display: none;">배우자 봉안자료검색</button>
                                	</ax:field>
                                </ax:fields>

                                <%-- <ax:fields>
                                	<ax:field label="유택여부" style="width:360px;">
                                		<select id="info-scatUseGb" name="scatUseGb" class="AXSelect W100"></select>
                                    </ax:field>
                                </ax:fields> --%>
                                <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i>비용</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
                                <ax:fields style="border-top: 1px solid #959595;">
                                	<input id="info-natuRentalfee" type="hidden" name=""/>
                                	<input id="info-natuDcRentalfee" type="hidden" name=""/>
                                	<input id="info-natuCharge" type="hidden" name=""/>
                                    <ax:field label="화장료/감/부" style="width:360px;">
                              	        <b:input id="info-rentalfee" name="rentalfee"  clazz="W80" placeholder="사용료" maxlength="15" title="사용료" ></b:input>
                              	        <b:input id="info-dcAmt" name="dcAmt"  clazz="W80" placeholder="감면금액" maxlength="15" title="감면금액" ></b:input>
                              	        <b:input id="info-charge" name="charge"  clazz="W80" placeholder="부과금액" maxlength="15" readonly="readonly" title="부과금액" ></b:input>
                                    </ax:field>
                                    <ax:field label="봉안료/감/관/부" style="width:360px;">
                    	      	        <b:input id="info-enshRentalfee" name="enshRentalfee"  clazz="W60" placeholder="사용료" maxlength="15" title="사용료" ></b:input>
                    	      	        <b:input id="info-enshDcRentalfee" name="enshDcRentalfee"  clazz="W60" placeholder="사용료감면금액" maxlength="15" title="사용료감면금액" ></b:input>
                    	      	        <b:input id="info-enshMngAmt" name="enshMngAmt"  clazz="W60" placeholder="관리비" maxlength="15" title="관리비" ></b:input>
                              	        <b:input id="info-enshDcMngAmt" name="enshDcMngAmt"  clazz="W60" placeholder="관리비감면금액" maxlength="15" title="관리비감면금액" ></b:input>
                              	        <b:input id="info-enshCharge" name="enshCharge"  clazz="W60" placeholder="부과금액" maxlength="15" readonly="readonly" title="부과금액" ></b:input>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="부과금액 계" style="width:360px;">
                               			<select id="info-payGb" name="payGb" class="W100 AXSelect"></select>
                                		<b:input id="info-totCharge" name="totCharge"  clazz="W80" placeholder="" maxlength="15" title="부과금액 계" ></b:input>
                                		<button type="button" class="AXButton" id="btn-calcPrice" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 요금계산</button>
                                		<button type="button" class="AXButton" id="btn-receipt" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 정산처리</button>
                                		<span id="sp-receipt-msg" style="color: red; font-weight: bolder;"></span>
                                	</ax:field>
<%--                                 	<ax:field label="정산현금/카드/계" style="width:500px;"> --%>
                                		<input id="info-calcCashAmt" name="calcCashAmt" type="hidden"  class="W80" placeholder="현금" maxlength="15" readonly="readonly" title="현금" >
                                		<input id="info-calcCardAmt" name="calcCardAmt" type="hidden"  class="W80" placeholder="카드" maxlength="15" readonly="readonly" title="카드" >
                                		<input id="info-calcCharge" name="calcCharge" type="hidden"  class="W80" placeholder="계" maxlength="15" readonly="readonly" title="계" >
<%--                                 	</ax:field> --%>
                                  </ax:fields>
                                <ax:fields>
                                	<ax:field label="특이사항">
                                		<b:input id="info-cremRemark" name="cremRemark" maxlength="50" style="width: 350px;"></b:input>
                                	</ax:field>
                                	<div style="vertical-align: middle; text-align:right;">
                                		<input type="checkbox" name="reportUnit" value="CREM2011_1"  id="CREM2011_1">
										<button type="button" class="AXButton" id="btn-reportCREM2011_1">화장허가증	</button>
										&nbsp;
										&nbsp;
										<input type="checkbox" name="reportUnit" value="CREM2014" id="CREM2014">
										<button type="button" class="AXButton" id="btn-reportCREM2014">반환신고서</button>
										&nbsp;
										&nbsp;
										<input type="checkbox" name="reportUnit" value="CREM2013"  id="CREM2013">
										<button type="button" class="AXButton" id="btn-reportCREM2013">영수증</button>
										&nbsp;&nbsp;
										<input type="checkbox" name="reportUnit" value="CREM2012"  id="CREM2012">
										<button type="button" class="AXButton" id="btn-reportCREM2012">화장증명서</button>
										&nbsp;&nbsp;
										<button type="button" class="AXButton" id="btn-print"><i class="axi axi-print"></i>인쇄</button>
                                	</div>
                                </ax:fields>
                                <ax:fields>
                                </ax:fields>
	                        	<div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i>신청자</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <input id="info-applicant-smsFlag" type="hidden" name="smsFlag" />
                               	<input id="info-applicant-ApplTransferDate" type="hidden" name="ApplTransferDate" />
	                        	    <ax:fields style="border-top: 1px solid #959595;">
	                                    <ax:field label="신청자국적" style="width:360px;">
	                                  		 <select id="info-applicant-nationGb" name="nationGb" class="W100 AXSelect"></select>
	                                    </ax:field>
	                                    <ax:field label="신청자명*" style="width:360px;">
	                                    	<b:input id="info-applicant-applName" name="applName" title="신청자" placeholder="신청자" clazz="W100" value=""  required="true"></b:input>
	                                    </ax:field>
	                                    <ax:field label="신청자 주민번호" style="width:360px;">
	                                        <b:input id="info-applicant-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" clazz="W100" value="" required="true" maxlength="14" pattern="custom" patternString="999999-9999999"></b:input>
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="신청자 주소*">
	                                    	<select id="info-applicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
	                                        <b:input id="info-applicant-applPost" name="applPost" clazz="W50" title="우편번호" readonly="readonly" placeholder="우편번호"  value="" ></b:input>
	                                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
	                                        <button type="button" class="AXButton" id="btn-same"><i class="axi axi-local-post-office"></i> 상동</button>
						                    <b:input id="info-applicant-applAddr1" name="applAddr1" title="신청자 주소" placeholder="" style="width: 340px;"  clazz="W354" value=""  required="true" ></b:input>
	                                        <b:input id="info-applicant-applAddr2" name="applAddr2" title="신청자 주소"  placeholder="상세주소" style="width: 326px;"  clazz="W326" value=""  ></b:input>
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="사망자와의 관계*" style="width:360px;">
	                                    	<select id="info-applRelation" name="applRelation" class="AXSelect W160"></select>
	                                        <b:input id="info-applRelationNm" name="applRelationNm" title="사망자와의 관계" maxlength="6" placeholder="사망자와의 관계" clazz="W100" value=""  ></b:input>
	                                    </ax:field>
	                                    <ax:field label="휴대폰*" style="width:360px;">
	                                        <b:input id="info-applicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" clazz="W40" value="" required="true" ></b:input>
	                                        <b:input id="info-applicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" clazz="W100" value="" required="true"  ></b:input>
	                                        <b:input id="info-applicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" clazz="W100" value=""  required="true" ></b:input>
	                                    </ax:field>
	                                     <ax:field label="전화번호" style="width:340px;">
	                                    	<b:input id="info-applicant-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" clazz="W40" value=""></b:input>
	                                        <b:input id="info-applicant-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" clazz="W100" value=""></b:input>
	                                        <b:input id="info-applicant-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" clazz="W100" value=""></b:input>
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
        <jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">
        	var bookDate="${bookDate}";
        	var bookChasu="${bookChasu}";
        	var bookChasuSeq="${bookChasuSeq}";

            var resize_elements = [
//                 {id:"page-grid-box-rogrpchasu", adjust:function(){
//                     	return -axf.clientHeight()/2;
//                 	}
//                 }
//                 , {id:"page-grid-box-hwaBooking", adjust:function(){
//     	                return -axf.clientHeight()/2;
// 	                }
//                 }
            ];
            var fnObj = {
				enshType : "",
				natuType : "",
				ensCnt  : 0,
                CODES: {
                	"natType": Common.getCode("TFM16"),
                	"ensType": Common.getCode("TFM10"),
                	"scatterPlace": Common.getCode("TMC06"),
                    "addrCode": Common.addr.getAddrCode(),
                    "dcRate": (function(){
    	            	var result;
    		            	app.ajax({
    		            			async: false,
    		                        type: "GET",
    		                        url: "/CREM2010/dcRate/",
    		                        data: ""
    		                    },
    		                    function(res){
    		                    	result = res.list;
    		                	}
    		                );
    		            	return result;
    		         }()),
    		         "accidentReason": (function(){
     	            	var result;
     		            	app.ajax({
     		            			async: false,
     		                        type: "GET",
     		                        url: "/api/v1/basicCodes/group?basicCd=127",
     		                        data: ""
     		                    },
     		                    function(res){
     		                    	result = res.list;
     		                	}
     		                );
     		            	return result;
     		         }()),
     		         "deadReason": (function(){
     	            	var result;
     		            	app.ajax({
     		            			async: false,
     		                        type: "GET",
     		                        url: "/api/v1/basicCodes/deadReason",
     		                        data: ""
     		                    },
     		                    function(res){
     		                    	result = res.list;
     		                	}
     		                );
     		            	return result;
     		         }()),
     		         "deadReasonB": (function(){
     	            	var result;
     		            	app.ajax({
     		            			async: false,
     		                        type: "GET",
     		                        url: "/api/v1/basicCodes/deadReasonB",
     		                        data: ""
     		                    },
     		                    function(res){
     		                    	result = res.list;
     		                	}
     		                );
     		            	return result;
     		         }()),
     		        "deadNationGbNm": (function(){
     	            	var result;
     		            	app.ajax({
     		            			async: false,
     		                        type: "GET",
     		                        url: "/api/v1/basicCodes/deadNationGbNm/option",
     		                        data: ""
     		                    },
     		                    function(res){
     		                    	result = res.list;
     		                	}
     		                );
     		            	return result;
     		         }()),

    		      	enshObjt : {"TMC0300001" : "TFM0800001"
        				 , "TMC0300003" : "TFM0800004"
        				 , "TMC0300007" : "TFM0800005"
        			},
        			natuObjt : {"TMC0300001" : "TFM1400001"
        				 , "TMC0300003" : "TFM1400004"
        				 , "TMC0300007" : "TFM1400005"
        			},
                    "firstTab": [
       					{optionValue:"A", optionText:"신청자", closable:false},
  					],
					"tab": [
        				{optionValue:"A", optionText:"신청자", closable:false},
      					//{optionValue:"P", optionText:"납부자", closable:false},
      					//{optionValue:"E", optionText:"사용연장"},
      					//{optionValue:"R", optionT xt:"반환처리"},
      					//{optionValue:"C", optionText:"사용승계"},

  					]

                },
                pageStart: function(){
                	this.bindEvent();
                	this.form.bind();
                	this.searchHwaCremation.bind();
                    this.searchHwaBooking.bind();
					this.defaultSearch();
					$(".selectedText").attr("tabindex", -1);
                },

                defaultSearch: function(){
					var cremDate = "${param.cremDate}";
					var cremSeq = "${param.cremSeq}";

					if(cremDate.length == 0 || cremSeq.length == 0){
						//$("#info-receiptGb").change();
					}else{
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremDate", cremDate);
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremSeq", cremSeq);
						fnObj.searchHwaCremation.submit();
						return
					}
					var customerNo = "${param.customerNo}";
					if(customerNo.length == 0){

					}else{
						fnObj.getFuneralData(customerNo)
						return;
					}
					var bookDate = "${param.bookDate}";
					var bookChasu = "${param.bookChasu}";
					var bookChasuSeq = "${param.bookChasuSeq}";
					if(bookDate.length == 0 || bookChasu.length == 0 || bookChasuSeq.length == 0){
						return;
					}else{
						Common.search.setValue(fnObj.searchHwaBooking.target, "bookDate", bookDate.date().print());
						Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasu", bookChasu);
						Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasuSeq", bookChasuSeq);
						fnObj.searchHwaBooking.submit();
						return;
					}

                },
                getCremKeyParameter: function(){
               		var params = [];
                   	var cremDate = Common.str.replaceAll($("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val(), "-", "");
                   	var cremSeq = $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
                   	if(cremDate ==  "" || cremSeq == "" ){

                   		return;
                   	}
                   	params.push("cremDate="+cremDate);
               		params.push("cremSeq="+cremSeq);
               		return params;
               	},
               	getFuneralData: function(customerNo){
               		app.ajax({
                        type: "GET",
                        url: "/CREM2010/funeral",
                        data: "customerNo="+customerNo
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
							var funeral = res.map.funeral;
							funeral.bookDate = "${param.bookDate}";
							funeral.bookChasu = "${param.bookChasu}";
							funeral.burnChasu = "${param.bookChasu}";
							funeral.bookChasuSeq = "${param.bookChasuSeq}";
							fnObj.searchFuneralModalResult({item: funeral});
                    	}
                    });
               	},
               	eventFn: {
              		reportCREM2011_1: function(){
              			if($("#info-objt").val() == "TMC0300003"){
              				Common.report.open("/reports/changwon/crem/CREM2011_3", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+"${LOGIN_USER_ID}");
              			}else if($("#info-objt").val() == "TMC0300007"){
              			Common.report.open("/reports/changwon/crem/CREM2011_4", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+"${LOGIN_USER_ID}");
              			}else{
              			Common.report.open("/reports/changwon/crem/CREM2011_1", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+"${LOGIN_USER_ID}");
              			}
              		}
              		, reportCREM2013: function(){
              			Common.report.open("/reports/changwon/crem/CREM2013", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}');
              		}
              		, reportCREM2012: function(){
              			Common.report.open("/reports/changwon/crem/CREM2012", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}');
              		}
              		, reportCREM2012x2: function(){
              			var parameters = [];

              			Common.report.open("/reports/changwon/crem/CREM2012", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}');
              			parameters.push({path:"/reports/changwon/crem/CREM2012", parameter: fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
              			parameters.push({path:"/reports/changwon/crem/CREM2012", parameter: fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
       					Common.report.mergePdfReport(parameters);
              		}
              		, reportCREM2011_2: function(){
              			Common.report.open("/reports/changwon/crem/CREM2011_2", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}');
              		}
              		, reportCREM2014: function(){
              			Common.report.open("/reports/changwon/crem/CREM2014", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}');
              		}
              		, reportCREM2015: function(){
              			var ensNo = $("#info-ensNo").val();
                       	var locKind = ensNo.substring(0,1);
              			if($("#info-boneGb").val() == "TMC0500001"){
							Common.report.open("/reports/changwon/crem/CREM2015", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}'+"&deadName="+$("#info-thedead-deadName").val()+"&locKind="+locKind);
						}else{
							Common.report.open("/reports/changwon/crem/CREM2015_2", "pdf", fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}'+"&deadName="+$("#info-thedead-deadName").val()+"&locKind="+locKind);
						}

              		}, reportENSH1010_1: function(){

              			var params = [];
                       	var ensDate = $("#info-ensDate").val();
                       	var ensSeq = $("#info-ensSeq").val();
                       	var deadId = $("#info-thedead-deadId").val();
                       	var ensNo = $("#info-ensNo").val();
                       	var locKind = ensNo.substring(0,1);
                       	if(ensDate ==  "" || ensSeq == "" ){
                       		return;
                       	}
                       	params.push("ensDate="+ensDate);
                   		params.push("ensSeq="+ensSeq);
                   		params.push("deadId="+deadId);
                   		params.push("printName="+'${LOGIN_USER_ID}');
                   		params.push("locKind="+locKind);
            			var reportName = "ENSH1010_1";
            			if($("#info-enshEnsType").val() == 'TFM1000003'){
            				reportName = "ENSH1010_7";
            			}
            			Common.report.open("/reports/changwon/ensh/"+reportName, "pdf", params.join("&"));
	            	}
	            	, reportENSH1010_3: function(){
	            		var params = [];
                       	var ensDate = $("#info-ensDate").val();
                       	var ensSeq = $("#info-ensSeq").val();
                       	var deadId = $("#info-thedead-deadId").val();
                       	if(ensDate ==  "" || ensSeq == "" ){
                       		return;
                       	}
                    	params.push("ensDate="+ensDate);
                   		params.push("ensSeq="+ensSeq);
                   		params.push("deadId="+deadId);
                   		params.push("printName="+'${LOGIN_USER_ID}');

            			Common.report.open("/reports/changwon/ensh/ENSH1010_3", "pdf", params.join("&"));

	            	}
	            	, reportNATU1011: function(){
	            		var params = [];
                       	var natDate = $("#info-natDate").val();
                       	var natSeq = $("#info-natSeq").val();
                       	if(natDate ==  "" || natSeq == "" ){
                       		return;
                       	}
                    	params.push("natDate="+natDate);
                   		params.push("natSeq="+natSeq);
                   		params.push("printName="+'${LOGIN_USER_ID}');
                		Common.report.open("/reports/changwon/natu/NATU1011", "pdf", params.join("&"));
                	}
                	, reportNATU1012: function(){
                		var params = [];
                       	var natDate = $("#info-natDate").val();
                       	var natSeq = $("#info-natSeq").val();
                       	if(natDate ==  "" || natSeq == "" ){
                       		return;
                       	}
                    	params.push("natDate="+natDate);
                   		params.push("natSeq="+natSeq);
                   		params.push("printName="+'${LOGIN_USER_ID}');
                		Common.report.open("/reports/changwon/natu/NATU1012", "pdf", params.join("&"));
                	}
                	, reportNATU1013: function(){
                		var params = [];
                       	var natDate = $("#info-natDate").val();
                       	var natSeq = $("#info-natSeq").val();
                       	if(natDate ==  "" || natSeq == "" ){
                       		return;
                       	}
                    	params.push("natDate="+natDate);
                   		params.push("natSeq="+natSeq);
                   		params.push("printName="+'${LOGIN_USER_ID}');
                		Common.report.open("/reports/changwon/natu/NATU1013", "pdf", params.join("&"));
                	}
              		, print: function(){
              			var parameters = [];
              			var params = "";
						var url = "";
						var reportName = "";

              			$.each($("input[name=reportUnit]:checked"), function(i,o){

							console.log("o = " + o + "   " + $(o).attr("id") + "   " + $(o).val().indexOf("CREM"));

          					params = fnObj.searchHwaCremation.target.getParam()+"&printName="+'${LOGIN_USER_ID}'+"&deadName="+$("#info-thedead-deadName").val().enc();
          					url =  "/reports/changwon/crem/";
          					reportName = $(o).attr("id");
          					//console.log(reportName);
							if(reportName == "CREM2015"){
								if($("#info-boneGb").val() != "TMC0500001"){
									reportName = "CREM2015_2";
								}
							}

              				parameters.push({path:url+reportName, parameter: params});
           				});

              			Common.report.mergePdfReport(parameters);
              		}
              		, goEnshrine: function(){
              			if($("#info-ensDate").val() != '' && $("#info-ensSeq").val() != ''){
	              			window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?ensDate="+$("#info-ensDate").val()+"&ensSeq="+$("#info-ensSeq").val(), "ENSH1010");
              			}else{
              				alert("봉안접수자료가 없습니다.")
              			}
              		}
              		, searchEnshrine: function(){
              			app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem2000/CREM2010_2.jsp",
	                        pars:"callBack=fnObj.enshrine.searchEnshrineModalResult",
	                        width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
              		}
              		, clearEnshrine: function(){
              			$("#info-ensDate").val("")
              			$("#info-ensSeq").val("")
              		}
               	},
               	bindMoney: {
               		ids: [
               			"#info-rentalfee"
               			, "#info-dcAmt"
               			, "#info-charge"

               			, "#info-enshRentalfee"
               			, "#info-enshMngAmt"
               			, "#info-enshDcMngAmt"
               			, "#info-enshDcRentalfee"
               			, "#info-enshCharge"

               			, "#info-natuRentalfee"
               			, "#info-natuDcRentalfee"
               			, "#info-natuCharge"

               			, "#info-totCharge"
               			, "#info-calcCharge"
               			, "#info-calcCashAmt"
               			, "#info-calcCardAmt"
               		],
               		bind: function(){
	               		$(this.ids.join(",")).bindMoney();
               		},
               		getValue: function(){
               			var res = {};
               			$.each(this.ids, function(i, o){
               				res[o.split("-")[1]] = +Common.str.replaceAll($(o).val(), ",", "");
               			});
               			return res;
               		}
               	},
                bindEvent: function(){
                    var _this = this;

                    $('body').on('keydown', 'input, select, textarea', function(e) {
            		    var self = $(this)
            		      , form = self.parents('form:eq(0)')
            		      , focusable
            		      , next
            		      ;
            		    if (e.keyCode == 13) {
            		        focusable = form.find('input,a,select,textarea').filter(':visible');
            		        next = focusable.eq(focusable.index(this)+1);
            		        if (next.length) {
            		            next.focus();
            		        } else {
//             		            form.submit();
            		        }
            		        return false;
            		    }
            		});

                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
//                 			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});

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

                    $("input[name='bookChasu'],input[name='bookChasuSeq']").keydown(function (key) {
                        if(key.keyCode == 13){
                        	var bookDate = Common.str.replaceAll($("#"+fnObj.searchHwaBooking.target.getItemId("bookDate")).val(), "-", "");
        					var bookChasu = $("#"+fnObj.searchHwaBooking.target.getItemId("bookChasu")).val();
        					var bookChasuSeq = $("#"+fnObj.searchHwaBooking.target.getItemId("bookChasuSeq")).val();
        					if(bookDate.length == 0 || bookChasu.length == 0 || bookChasuSeq.length == 0){
        						return alert("차수와 순번을 입력해주세요.");
        					}else{
        						fnObj.searchHwaBooking.submit();
        					}
                        }
                    });

                    $("#ax-page-btn-search").html("<i class=\"axi axi-ion-android-search\"></i> 장례식장자료");
                    $("#ax-page-btn-search").bind("click", function(){
                    	 app.modal.open({
 	                        url:"/jsp/funeralsystem/crem0000/crem1000/CREM1012.jsp",
 	                        pars:"callBack=fnObj.searchFuneralModalResult",
 	                        width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
 	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
 	                    });
                    });
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.del();
                        }, 500);
                    });

                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });

                    $("#ax-form-btn-clone").bind("click", function(){
						$("#info-bookDate").val("");
						$("#info-bookChasu").val("");
						$("#info-bookChasuSeq").val("");
						$("#info-cremSeq").val("");
						$("#info-thedead-deadId").val("");

						toast.push("정보가 복사 되었습니다.");

                    });

                    $("#info-applicant-nationGb").selectBox({
	                	basicCd: "TCM11"
	                	,val : "TCM1100001"
	               		,async : false
	                });
                  	$("#info-thedead-deadNationGb").selectBox({
	                	basicCd: "TCM04"
	                	,val : "TCM0400001"
	                	,async : false
	                });

                  	$("#info-thedead-deadSex").selectBox({
	                	basicCd: "TCM05"
	               		,async : false
	                });
                	$("#info-objt").selectBox({
	                	basicCd: "TMC03"
	                	,async : false
	                });

                	$("#info-dcGubun").selectBox({
	                	basicCd: "TCM12"
	               		,async : false
	                });

                	$("#info-payGb").selectBox({
	                	basicCd: "TMC15"
	               		,async : false
	                });

                	/* $("#info-thedead-deadPlace").selectBox({
	                	basicCd: "TCM09"
	               		,async : false
	                }); */
	                $("#info-thedead-deadPlace").selectBox({
						url: "/api/v1/basicCodes/deadPlace/option"
						,reserveKeys: {
							 optionValue: "optionValue"
		               		, optionText: "optionText"
            			}
						,async : false
        			});

                	$("#info-thedead-deadAddrGubun").selectBox({
	                	basicCd: "TCM07"
	                	,async : false
	                });
                	$("#info-applicant-addrGubun").selectBox({
	                	basicCd: "TCM07"
	                	,async : false
	                });

                	$("#info-addrPart").selectBox({
	                	basicCd: "TCM10"
	                	,async : false
	                });

                	$("#info-boneGb").selectBox({
	                	basicCd: "TMC05"
	                	,async : false
	                });

                	$("#info-applRelation").selectBox({
	                	basicCd: "TCM08"
	                	,async : false
	                });

                	$("#info-applicant-smsFlag").selectBox({
	                	basicCd: "SMS_FLAG"
	                	,async : false
	                });

                	$("#info-thedead-deadReason").selectBox({
	                	basicCd: "TCM03"
	                	,async : false
	                });



                	/* $("#info-thedead-deadReason").bindSelect({
                		url: "/api/v1/basicCodes/deadReason"
                    		, isspace: true
                 			, isspaceTitle: "."
               				, reserveKey: {
                   				optionRoot: "options"
                   				, optionValue: "optionValue"
                   				, optionText: "optionText"
                   			}
        			}); */


                    $("#btn-search-ensNo").bind("click",function(){
                    	if($("#info-enshEnsType").val() == ""){
                    		toast.push("봉안단을 선택하세요");
                    		return false;
                    	}
                    	if(fnObj.ensCnt == 2){
                    		alert("부부단 합장이 완료되었을 경우 봉안번호 변경은 할 수 없습니다.");
                    		return false;
                    	}
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp?ensType="+$("#info-enshEnsType").val(),
	                        pars:"callBack=fnObj.enshrine.searchEnsNoModalResult",
	                        width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#btn-search-natNo").bind("click",function(){
                    	if($("#info-natuNatType").val() == "" ||  $("#info-natuNatKind").val() == ""){
                    		toast.push("자연장을 선택하세요");
                    		return false;
                    	}
	                    app.modal.open({

	                    	url:"/jsp/funeralsystem/natu0000/natu1000/NATU1016.jsp?natGubun="+$("#info-natuNatType").val()+"&natKind="+$("#info-natuNatKind").val()+"&locCode=A",
	                        pars:"callBack=fnObj.nature.searchNatNoModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#btn-calcPrice").bind("click", function(){
                    	//fnObj.calcPriceAndTerm(jobGubun, priceGubun, objt, addrPart, dcCode)

                    	var info =  fnObj.form.getJSON();
                    	var enshrine = info.enshrine;
                    	var nature = info.nature;

                    	if($("#info-calcCharge").val() > 0){
                     		//return;
                    	}



						if($("#info-dcCode").val() ==""){
							toast.push("관내외사유는 필수입력 사항입니다.");
							return false;
						}

                    	fnObj.calcPriceAndTerm("C", "U", info.objt, info.addrPart, info.dcCode+"");
                    	if(info.enshEnsType != "" && info.enshDcCode != ""){
                   			fnObj.calcPriceAndTerm("E", "U", info.enshEnsType, info.addrPart, info.enshDcCode+"");
                    	}
                    	if(info.natuNatType == "TFM1600003" && info.natuDcCode != ""){
                    		fnObj.calcPriceAndTerm("N", "U", info.natuNatKind,  info.addrPart, info.natuDcCode+"");
                    	}

                    });


 					$("#info-thedead-transferDate, #info-dcGubun, #info-thedead-addrCode, #info-addrPart").change(function(){

 							$("#info-dcCode").val(fnObj.getDcCode("C"));

 					});


					$("#info-dcCode").selectBox({
						url: "/FUNE1030/dcRate/code/option?jobGubun=C"
							, isspace: true
								, isspaceTitle: ""
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
						,async : false
					});

					$("#info-enshDcCode").selectBox({
						url: "/FUNE1030/dcRate/code/option?jobGubun=E"
							, isspace: true
								, isspaceTitle: ""
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
						,async : false
					});

					$("#info-scatterPlace").selectBox({
	                	basicCd: "TMC06",
	                	isspace: true,
	   	                isspaceTitle: ""
	   	                ,async : false
	                });

					$("#info-scatterPlace").bind("change", function(){
						if(this.value == "TMC0600004"){
							$("#info-scatUseGb").val("1");
							//$("#NATU1011").prop("checked",false);
                			//$("#NATU1013").prop("checked",false);
                			//$("#ENSH1010_1").prop("checked",false);
                			//$("#ENSH1010_3").prop("checked",false);

						}else{
							$("#info-scatUseGb").val("0");
						}
					});

                    $("#info-enshEnsType").selectBox({
                    	url: "/api/v1/basicCodes/groupSelect?basicCd=TFM10"
							, isspace: true
								, isspaceTitle: "사용안함"
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
                	    ,async : false
					});

					$("#info-enshEnsType").bind("change", function(){
						if(this.value != ""){

							if(this.value != fnObj.enshType){
	                			$("#info-ensNo").val("");
 	                			$("#info-enshStrDate").val("");
 	                			$("#info-enshEndDate").val("");
	                		}
							$("[id^='info-natu']").val("");
							$("#info-natNo").val("");
	                		$("#info-scatUseGb").val("0");
                			$("#info-enshUseGb").val(1);
	                		//$("#ENSH1010_1").prop("checked",true);
                			//$("#ENSH1010_3").prop("checked",true);
                			//$("#NATU1011").prop("checked",false);
                			//$("#NATU1013").prop("checked",false);
	                		$("#info-enshObjt").val(fnObj.CODES.enshObjt[$("#info-objt").val()]);
	                		$("#info-enshDcCode").val(fnObj.getDcCode("E"));
	                		$("#info-applicant-smsFlag").val(1);


                		}else if(this.value == ""){
                			$("[id^='info-ensh']").val("");
                			$("#info-ensNo").val("");
                			$("#info-enshUseGb").val(0);
                			//$("#ENSH1010_1").prop("checked",false);
                			//$("#ENSH1010_3").prop("checked",false);
                			$("#info-applicant-smsFlag").val(0);
                		}

						if(this.value == "TFM1000003"){
							$("#btn-searchEnshrine").show()
						}else{
							$("#btn-searchEnshrine").hide()
						}
					})

					$("#info-natuDcCode").selectBox({
						url: "/FUNE1030/dcRate/code/option?jobGubun=N"
							, isspace: true
								, isspaceTitle: ""
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
						,async : false
					});

					$("#info-natuNatType").selectBox({
						url: "/api/v1/basicCodes/groupSelect?basicCd=TFM16"
							, isspace: true
								, isspaceTitle: "사용안함"
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
						,async : false
					});

					$("#info-natuNatType").bind("change", function(){
						if(this.value != ""){

                			//$("#NATU1011").prop("checked",true);
                			//$("#NATU1013").prop("checked",true);
                			//$("#ENSH1010_1").prop("checked",false);
                			//$("#ENSH1010_3").prop("checked",false);
                			$("[id^='info-ensh']").val("");
                			$("#info-ensNo").val("");
                			$("#info-enshUseGb").val(0);
                			$("#info-scatUseGb").val("0");
                			$("#info-natuObjt").val(fnObj.CODES.natuObjt[$("#info-objt").val()]);
                			$("#info-natuNatKind").val("TFM1000001");
                			$("#info-natuUseGb").val(1);
                			$("#info-natuDcCode").val(fnObj.getDcCode("N"));
                			$("#info-applicant-smsFlag").val(1);

                		}else if(this.value == ""){
                			$("[id^='info-natu']").val("");
                			$("#info-natNo").val("");
	                		$("#info-natuUseGb").val(0);
                   			//$("#NATU1011").prop("checked",false);
                   			//$("#NATU1013").prop("checked",false);
                   			$("#info-applicant-smsFlag").val(0);
                		}
					});

					$("#info-natuNatKind").selectBox({
						url: "/api/v1/basicCodes/groupSelect?basicCd=TFM10"
							, isspace: true
								, isspaceTitle: ""
								, reserveKey: {
									 optionValue: "optionValue"
									, optionText: "optionText"
								}
							,async : false
					});

					$("select[id='info-natuNatKind'] option[value='TFM1000003']").remove();
            		$("select[id='info-natuNatKind'] option[value='TFM1000004']").remove();

                    $("#info-burnNo").selectBox({
	                	url: "/CREM2010/rogrpchasu/ro/option"
                		, isspace: true
             			, isspaceTitle: ""
           				, reserveKey: {
               				 optionValue: "optionValue"
               				, optionText: "optionText"
               			}
                    	,async : false
	                });

                    $("#info-burnChasu").selectBox({
	                	url: "/CREM2010/rogrpchasu/chasuTime/option"
                		, isspace: true
             			, isspaceTitle: ""
           				, reserveKey: {
               				 optionValue: "optionValue"
               				, optionText: "optionText"
               			}
                    	,async : false
	                });

                    //$("#info-thedead-deadJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});

					$("#info-thedead-deadDate, #info-thedead-deadTime").bind("change",function(){
						if($("#info-thedead-deadDate").val().length > 6 && $("#info-thedead-deadTime").val().length > 0){

							var deadDate = $("#info-thedead-deadDate").val();
							var deadTime = $("#info-thedead-deadTime").val();
							var year = deadDate.substring(0,4);
							var month = deadDate.substring(5,7);
							var day = deadDate.substring(8,10);
							var hour = this.value.substring(0,2);
							var minute = this.value.substring(3,5);

							var now = new Date();
							var diff = new Date(deadDate.substring(0,4)+"/"+deadDate.substring(5,7)+"/"+deadDate.substring(8,10)
														+" "+deadTime.substring(0,2)+":"+deadTime.substring(3,5)+":"+"00");
							var diffTime = (now.getTime()-diff.getTime()) / 60000 / 60;
							if(diffTime < 24){
								alert("사망시간이 24시간이 경과하지 않은 고인 입니다.");
							}
						}
					});

                    $("#info-thedead-deadJumin").bind("change",function(){
                    		if(this.value.length >= 8 ){

                    			var female = "0,2,4,6,8";
                    			var male = "1,3,5,7,9";

                    				if(female.indexOf(this.value.substring(7,8)) != -1){
                    					  $("#info-thedead-deadSex").val("TCM0500002");
                    				}else if(male.indexOf(this.value.substring(7,8)) != -1){
                    					$("#info-thedead-deadSex").val("TCM0500001");
                    				}

	                        	    $("#info-thedead-deadBirth").val(Common.str.toBirth(this.value).date().print("yyyy-mm-dd"));
	                        	    $("#info-thedead-deadBirth").blur();
	                        }else{
	                        	 $("#info-thedead-deadSex").val("TCM0500003");
	                             $("#info-thedead-deadBirth").val("");
	                        }
                    });

                    //$("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});


                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-thedead-deadPost", "info-thedead-deadAddr1", "info-thedead-deadAddr2");
                    	//Common.addr.getAddrPart(this.value, "info-thedead-addrCode", "info-addrPart",false,0);
                    });

                    $("#btn-applpost").bind("click", function(){
                    	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
                    });

                   /*  $("#info-thedead-addrCode").selectBox({
                  		url: "/CREM2010/addrCode/option"
                		, isspace: true
             			, isspaceTitle: ""
           				, reserveKey: {
               				 optionValue: "optionValue"
               				, optionText: "optionText"
               			}
                    	,async : false
	                }); */

                    for (var i = 0; i < fnObj.CODES.accidentReason.length; i++) {
                        $('#deadReasonNm').append("<option value='" + fnObj.CODES.accidentReason[i].name +"'>");
                    }

	                for (var i = 0; i < fnObj.CODES.deadNationGbNm.length; i++) {
                        $('#deadNationGbNm').append("<option value='" + fnObj.CODES.deadNationGbNm[i] +"'>");
                    }


                    //사고원인 시작
					/*  $("#info-thedead-deadReasonNm").bindSelector({
						appendable:true,
						options:fnObj.CODES.accidentReason,
						reserveKeys: {
                            optionValue: "code",
                            optionText: "name"
                        },
	                }); */
                    //사고원인 끝

                    $("#info-thedead-deadAddr1").change(function(){
                    	Common.addr.getAddrPart(this.value, "info-thedead-addrCode", "info-addrPart",false,0);
                    });

                    $("#info-addrPart").change(function(){
                    	 if(this.value == "TCM1000003"){
                    		$("#info-thedead-transferDate").val("");
                    	 }
                    });

                    $("#div-tab").bindTab({
        				theme : "AXTabs",
        				value:"A",
        				overflow:"scroll", /* "visible" */
        				options:fnObj.CODES.firstTab,
        				onchange: function(selectedObject, value){
							//$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-"+value));
        				}
        			});

                    $("#div-content").append($("#div-tab-content-A"));


                    $("#info-objt").change(function(){
							var infoObjt = $("#info-objt").val();
						    if(infoObjt == "TMC0300001" || infoObjt == "TMC0300002" || infoObjt == "TMC0300007"){
								$("#info-thedead-bunmanwol").attr("readonly", true);
// 								$("#info-thedead-deadReason").selectBox({
// 									url: "/api/v1/basicCodes/deadReason/option"
// 									,reserveKeys: {
// 										 optionValue: "optionValue"
// 					               		, optionText: "optionText"
//                         			}
// 									,async : false
// 	                			});

// 								$("#info-thedead-deadPlace").selectBox({
// 									url: "/api/v1/basicCodes/deadPlace/option"
// 									,reserveKeys: {
// 										 optionValue: "optionValue"
// 					               		, optionText: "optionText"
//                         			}
// 									,async : false
// 	                			});
							}else{
								$("#info-thedead-bunmanwol").attr("readonly", false);
// 								$("#info-thedead-deadReason").selectBox({
// 									url: "/api/v1/basicCodes/deadReasonB/option"
// 									,reserveKeys: {
// 										 optionValue: "optionValue"
// 					               		, optionText: "optionText"
//                         			}
// 									,async : false
// 	                			});

// 								$("#info-thedead-deadPlace").selectBox({
// 									url: "/api/v1/basicCodes/deadPlaceB/option"
// 									,reserveKeys: {
// 										 optionValue: "optionValue"
// 					               		, optionText: "optionText"
//                         			}
// 									,async : false
// 	                			});
							}

							if($("#info-objt").val() == "TMC0300007" && $("#info-cremSeq").val() == "" && $("#info-bookDate").val() == ""){
								//$("#info-deadDateString").val("");
								//$("#info-deadPlace").bindSelectAddOptions([{optionValue:"", optionText:""}]);
		                		//$("#info-deadPlace").bindSelectSetValue("");
		                		//$("#info-deadReason").bindSelectAddOptions([{optionValue:"", optionText:""}]);
		                		//$("#info-deadReason").bindSelectSetValue("");
		                	    //$("#info-deadSex").bindSelectSetValue("TCM0500003");
		                	    $("#info-thedead-deadJumin").change();

							}

							if("TMC0300007" == $("#info-objt").val()){
								$("#btn-save-ugol").css("display", "inline-block");
								$("#info-openGraveCnt").css("display", "inline-block");
							}else{
								$("#btn-save-ugol").css("display", "none");
								$("#info-openGraveCnt").css("display", "none");
							}
					});

                    $("#btn-save-ugol").bind("click", function(){
                    	app.modal.open({
    	                    url:"/jsp/funeralsystem/crem0000/crem2000/CREM2010_1.jsp",
    	                    pars:"callBack="
    	                    		+ "&cremDate=" + $("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val()
    	                    		+ "&cremSeq=" + $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val()
    	                    ,
    	                    width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
    	                    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
               		  	});
                   	})

                    $("#info-objt").change();

					$("#info-rentalfee, #info-dcAmt").bind("keyup", function(){
						$("#info-charge").val((Common.str.replaceAll($("#info-rentalfee").val(), ",", "")-Common.str.replaceAll($("#info-dcAmt").val(), ",", "")).money());
						$("#info-charge").change();
					});

					$("#info-enshRentalfee, #info-enshMngAmt, #info-enshDcMngAmt, #info-enshDcRentalfee").bind("keyup", function(){
						$("#info-enshCharge").val((Number(Common.str.replaceAll($("#info-enshRentalfee").val(), ",", ""))+Number(Common.str.replaceAll($("#info-enshMngAmt").val(), ",", ""))
								-Common.str.replaceAll($("#info-enshDcRentalfee").val(), ",", "")-Number(Common.str.replaceAll($("#info-enshDcMngAmt").val(), ",", ""))).money());
						$("#info-enshCharge").change();
					});

					$("#info-natuRentalfee, #info-natuDcRentalfee").bind("keyup", function(){
						$("#info-natuCharge").val((Common.str.replaceAll($("#info-natuRentalfee").val(), ",", "")-Common.str.replaceAll($("#info-natuDcRentalfee").val(), ",", "")).money());
						$("#info-natuCharge").change();
					});


					//$("#info-rentalfee, #info-dcAmt, #info-charge,#info-enshRentalfee,  #info-enshDcRentalfee, #info-enshCharge, #info-natuCharge").bind("change", function(){
					$("#info-charge, #info-enshCharge, #info-natuCharge").bind("change", function(){
						Common.calc.sum($("#info-totCharge"), [$("#info-charge"),$("#info-enshCharge"),$("#info-natuCharge")]);
						$("#info-totCharge").val($("#info-totCharge").val().money());
                    });

                    $("#ax-input-switch").bindSwitch({
                		off:"암호화 미적용",
                		on:"암호화 적용",
                		onchange:function(){
                			//toast.push(Object.toJSON(this));
                		}
                	});
                    $("#ax-input-switch").setValueInput("암호화 적용");

                    $("#btn-receipt").bind("click", fnObj.openReceiptModal);
					this.bindMoney.bind();
					$("#btn-same").bind("click", function(){
						$("#info-applicant-applPost").val($("#info-thedead-deadPost").val());
						$("#info-applicant-applAddr1").val($("#info-thedead-deadAddr1").val());
						$("#info-applicant-applAddr2").val($("#info-thedead-deadAddr2").val());
					});
					$("#info-applicant-applPost, #info-applicant-applAddr1, #info-applicant-applAddr2").bind("keyup", function(e){
						if(e.keyCode==36){
							$("#btn-same").click();
						}
					});
					$("#info-calcCharge").bind("change", function(){

					});

                },
                isDisabled: function(){

                	var info = fnObj.form.getJSON();
                	if(info.calcCharge > 0){

        				if(info.enshEnsType != ""){

        					$("#info-enshEnsType").val(fnObj.enshType)
        					$("#info-enshEnsType option").not(":selected").attr("disabled", true);
							$("#info-enshDcCode option").not(":selected").attr("disabled", true);
        					$("[id^='info-natu']").val("");
                			$("#info-natNo").val("");
        					$("#info-natuNatType").val("");
        					$("#info-natuNatType option").not(":selected").attr("disabled", true);
        					$("#info-natuNatKind").val("");
        					$("#info-natuNatKind option").not(":selected").attr("disabled", true);
        					$("#info-natuDcCode").val("");
        					$("#info-natuDcCode option").not(":selected").attr("disabled", true);
        				    $("#info-scatUseGb").val("0");



        				}else if(info.natuNatType != ""){

        					$("[id^='info-ensh']").val("");
                			$("#info-ensNo").val("");
        					$("#info-enshEnsType").val("");
        					$("#info-enshEnsType option").not(":selected").attr("disabled", true);
        					$("#info-enshDcCode").val("")
							$("#info-enshDcCode option").not(":selected").attr("disabled", true);
        					$("#info-natuNatType").val(fnObj.natuType)
        					$("#info-natuNatType option").not(":selected").attr("disabled", true);
        					$("#info-natuNatKind option").not(":selected").attr("disabled", true);
        					$("#info-scatUseGb").val("0");

        				}else{

        					$("[id^='info-natu']").val("");
                			$("#info-natNo").val("");
                			$("[id^='info-ensh']").val("");
                			$("#info-ensNo").val("");

        					$("#info-enshEnsType").val("");
        					$("#info-enshEnsType option").not(":selected").attr("disabled", true);
        					$("#info-enshDcCode").val("")
							$("#info-enshDcCode option").not(":selected").attr("disabled", true);

        					$("#info-natuNatType").val("");
        					$("#info-natuNatType option").not(":selected").attr("disabled", true);

        					$("#info-natuNatKind").val("");
        					$("#info-natuNatKind option").not(":selected").attr("disabled", true);
        				}

                	}else{

                		$("#info-enshEnsType option").not(":selected").attr("disabled", false);
                		$("#info-enshDcCode option").not(":selected").attr("disabled", false);
                		$("#info-natuNatType option").not(":selected").attr("disabled", false);
                		$("#info-natuNatKind option").not(":selected").attr("disabled", false);

                	}
                },
                getDcCode: function(jobGubun){
	                	var cremSeq = $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
                		if(cremSeq > 0){
                			return false;
                		}
                    	var addrDcCode = [1100,1089,1093]
 						var transferDate=  $("#info-thedead-transferDate").val();
                    	var calcDate = $("#info-thedead-transferDate").val().date().diff($("#info-thedead-deadDate").val());
 						var addrCode =  $("#info-thedead-addrCode").val();
 						var addrPart =  $("#info-addrPart").val();
 						var objt =  $("#info-objt").val();
 						var dcGubun =  $("#info-dcGubun").val();

 						var dong = ["신갈동","영덕동","보정동","상현동","성복동"]
 						/*  var enshObjt = {"TMC0300001" : "TFM0800001"
            				 , "TMC0300003" : "TFM0800004"
            				 , "TMC0300007" : "TFM0800005"
            				 }; */
            			var result = "";

 						var dcCode = {
 								"C" :  {

 									"TCM1000001"	: function(){

 			 							if(dcGubun != "TCM1200001"){
 			 								result = "001";
 			 	                    	}else{
 			 	                    		result = "000";
 			 	                    	}
 			 							return result;
 									},
 									"TCM1000003" : function(){

 										if(dcGubun != "TCM1200001"){
 			 								result = "011";
 			 	                    	}else{
 			 	                    		result = "010";
 			 	                    	}
 			 							return result;
 									}
 								},
 								"E" : {
 									"TCM1000001"	: function(){

 										if(dcGubun != "TCM1200001"){
 			 								result = "001";
 			 	                    	}else{
 			 	                    		result = "000";
 			 	                    	}
 			 							return result;
 									},
 									"TCM1000003" : function(){
 										if(dcGubun != "TCM1200001"){
 			 								result = "011";
 			 	                    	}else{
 			 	                    		result = "010";
 			 	                    	}
 										return result;
 									}
 								}

 						}

            				 //console.log(dcCode[jobGubun][addrPart]());
            		    return dcCode[jobGubun][addrPart]();
				},
                setHwaBooking : function(hwaBooking){
                	fnObj.form.clear();

                	var deadJumin = "";
                	if(hwaBooking.bookDeadJumin){
                		deadJumin = hwaBooking.bookDeadJumin;
                	}else{
                		deadJumin = hwaBooking.thedead.deadJumin;
                	}
                	hwaBooking.thedead.deadJumin = deadJumin;
            		var bs = Common.str.getBirthFromJuminNoAndSex(deadJumin);
            		hwaBooking.thedead.deadBirthString = bs.birth;
            		hwaBooking.thedead.deadSex = bs.sex;
            		hwaBooking.burnChasu =hwaBooking.bookChasu;
            		hwaBooking.enshrine = {};
            		hwaBooking.nature = {};


            		var objt = {"TMC0200001" : "TMC0300001", "TMC0200002" : "TMC0300007", "TMC0200003" : "TMC0300003"};
               		var age = Common.str.getAge(deadJumin);
                   	if(objt[hwaBooking.bookBurnObjt]=="TMC0300001" && age < 15){
                   		hwaBooking.objt = "TMC0300002";
                   	}else{
                   		hwaBooking.objt = objt[hwaBooking.bookBurnObjt];
                   	}

                   	if(hwaBooking.funeral){
            			 hwaBooking.transferDate = hwaBooking.funeral.transferDate;
            			 if(hwaBooking.funeral && confirm("예약자의 장례식장 접수자료가 존재합니다. 장례식장 접수자료를 사용하시겠습니까?")){

            				 $("input[id^='info-thedead']").val();
            				 $("input[id^='info-applicnat']").val();
            				 $.each(hwaBooking.funeral, function(key, value){
                     			if(key.startsWith("crem")){
                     				var idx = "crem".length;
              					hwaBooking[key[idx].toLowerCase() + key.substring(idx+1)] = value;
                     			}
                     			if(key.startsWith("ensh")){
                     				var idx = "ensh".length;
                     				hwaBooking.enshrine["ensh"+key[idx] + key.substring(idx+1)] = value;
                     			}
                     			if(key.startsWith("natu")){
                     				var idx = "natu".length;
              					hwaBooking.nature["natu"+key[idx] + key.substring(idx+1)] = value;
                     			}
                         	});

            				//fnObj.form.setJSON(hwaBooking.funeral);
            				//Common.form.fillForm("info-applicant-",hwaBooking.funeral.applicant);
            				//Common.form.fillForm("info-thedead-",hwaBooking.funeral.thedead);
     					}
            		 }

                   	if(hwaBooking.objt == "TMC0300007"){
                   		hwaBooking.openGraveCnt = 1
                   	}

                	fnObj.form.setJSON(hwaBooking);
					$("#info-objt").change();
        			 if(!hwaBooking.applicant){
              			if(hwaBooking){
                  			/* $.each(hwaBooking, function(key, value){
                      			if(key.startsWith("book")){
                      				var idx = "book".length;
                  					hwaBooking[key[idx].toLowerCase() + key.substring(idx+1)] = value;
                  					//hwaBooking[key[idx].toLowerCase() + key.substring(idx+1)] = value;
                      				hwaBooking["appl"+key[idx] + key.substring(idx+1)] = value;
                      				//hwaBooking[key[idx].toLowerCase() + key.substring(idx+1) + "String"] = value;
                      			}
                      		})
                      		Common.form.fillForm("info-applicant-",hwaBooking);
                      		//Common.form.fillForm("info-",hwaBooking);
                  			$("#info-applicant-applJumin").blur();    */
                    		$("#info-applicant-applName").val(hwaBooking.bookApplName);
                    		$("#info-applicant-applJumin").val(hwaBooking.bookApplJumin);
                    		$("#info-applicant-applJumin").blur();
               				$("#info-applRelation").val(hwaBooking.bookRelation);
       						$("#info-applRelationNm").val(hwaBooking.bookRelationNm);
       						if(hwaBooking.bookBurnObjt != "TMC0200002"){
           						$("#info-applicant-telno1").val(hwaBooking.bookTelno1);
           						$("#info-applicant-telno2").val(hwaBooking.bookTelno2);
           						$("#info-applicant-telno3").val(hwaBooking.bookTelno3);
           						$("#info-applicant-mobileno1").val(hwaBooking.bookMobileno1);
           						$("#info-applicant-mobileno2").val(hwaBooking.bookMobileno2);
           						$("#info-applicant-mobileno3").val(hwaBooking.bookMobileno3);
       						}

       						$("#info-applicant-applEmail").val(hwaBooking.emailId+"@"+hwaBooking.emailProvider);
       						$("#info-applicant-nationGb").val(hwaBooking.applNationGb);
       						$("#info-applicant-addrGubun").val(hwaBooking.applAddrGubun);
       						$("#info-applicant-applPost").val(hwaBooking.bookApplPost);
       						$("#info-applicant-applAddr1").val(hwaBooking.bookApplAddr1);
       						$("#info-applicant-applAddr2").val(hwaBooking.bookApplAddr2);
       						$("#info-applicant-smsFlag").val(0);

       						$("#info-thedead-deadDocno").val(hwaBooking.deadDocno);
       						$("#info-thedead-deadDocnm").val(hwaBooking.deadDocnm);

                    		$("#info-bookDate").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookDate")).val());
                    		$("#info-bookChasu").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookChasu")).val());
                    		$("#info-bookChasuSeq").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookChasuSeq")).val());

                    		$("#info-burnChasu").val(hwaBooking.bookChasu);
                    		$("#info-burnNo").val(hwaBooking.bookChasuSeq);

                    		$("#info-thedead-deadAddr1").change();
                    		$("#info-thedead-transferDate").change();

              			}
             		}


        			 $("#info-applicant-smsFlag").val(0);
           			 //$("#info-bunmanwol").val(hwaBooking.bunmanwol);
           			 $("#info-thedead-deadJumin").change();
           			 //console.log(hwaBooking);

                },
                enshrine : {
                	isNew : function(){
                		var ensSeq = $("#info-ensSeq").val();
                    	if(!ensSeq || ensSeq.length == 0){
                    		return true;
                    	}else{
                    		return false;
                    	}
                	},

                	searchEnsNoModalResult: function(ensNo){
                    	$("#info-ensNo").val(ensNo);
                    	//$("#info-ensDate").val(item.ensDate);
                    	//$("#info-ensSeq").val(item.ensSeq);
                    	$("#btn-calcPrice").click();
                    	app.modal.close();
                    },
                	searchEnshrineModalResult: function(enshrine){
                    	$("#info-ensDate").val(enshrine.ensDate);
                    	$("#info-ensSeq").val(enshrine.ensSeq);
                    	app.modal.close();
                    },
                    getJSON : function(){
                    	 var info = fnObj.form.getJSON().enshrine;
                    	 $.each(info, function(key, value){

                  			if(key.startsWith("ensh")){
                  				var idx = "ensh".length;
                  				info[key[idx] + key.substring(idx+1)] = value;
                  			}
                      	});
                    	return info;
                    },
                },
                nature : {
                	searchNatNoModalResult:function(map){
                    	$("#info-natNo").val(map.natNo);
                    	$("#info-locCode").val(map.locCode);
                    	$("#info-blockNum").val(map.blockNum);
                    	$("#info-natuNatKind").val(map.natKind);
                    	$("#btn-calcPrice").click();
                    	app.modal.close();
                    },
                    isNew: function(){
                    	var natSeq = Common.search.getValue(fnObj.searchNature.target, "natSeq");
                    	if(!natSeq || natSeq.length == 0){
                    		return true;
                    	}else{
                    		return false;
                    	}
                    },
                },
                openReceiptModal: function(){
                	var cremSeq = $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
                	if(cremSeq.length <= 0){
                		alert("접수자료 저장 후 정산처리 해주세요.");
                		return false;
                	}

                	app.modal.open({
	                    url:"/jsp/funeralsystem/crem0000/crem2000/CREM2016.jsp",
	                    pars:"callBack=fnObj.searchFuneralModalResult&deadId="+$("#info-thedead-deadId").val()
	                    		+ "&cremDate=" + $("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val()
	                    		+ "&cremSeq=" + $("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val()
	                    ,
	                    width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
           		  	});
                },
                searchFuneralModalResult: function(item){

                	fnObj.form.clear();

                	// payGb
                	for(var i=0; i<item.item.payment.length; i++){

                		var paymentCalc = item.item.payment[i].paymentCalc;
                		for(var j=0; j<paymentCalc.length; j++){
                			if(paymentCalc[j].partCode == '70-001'){
		                		if(item.item.payment[i].kind[0] == 'B'){
		                			item.item.payGb = 'TMC1500001';
		                			break;
		                		}else{
		                			item.item.payGb = 'TMC1500002';
		                			break;
		                		}
                			}
                		}
                	}

					fnObj.form.setJSON(item.item);
                	$("#info-scatterPlace").val(item.item.cremScatterPlace);
                	$("#info-thedead-transferDate").change();

                	if(item.item.cremUseGb == "1"){
                		$("#info-objt").val(item.item.cremObjt)
                		$("#info-boneGb").val(item.item.cremBoneGb)
                		$("#info-scatterPlace").val(item.item.cremScatterPlace)
                		$("#info-dcCode").val(item.item.cremDcCode)
                		$("#info-remark").val(item.item.cremRemark)
                		var hwaSs = item.item.saleStmt.filter(function(ss){
                			// 화장
                			return ss.partCode == "70-001"
                		})[0]

						if(hwaSs){
							$("#info-rentalfee").val((hwaSs.amount||0))
							$("#info-dcAmt").val((hwaSs.dcAmt||0))
							$("#info-charge").val((hwaSs.amount||0) - (hwaSs.dcAmt||0))
						}
                	}

                	if(item.item.natuUseGb == 1){
                		$("#info-natuDcCode").val(fnObj.getDcCode("N"));
                	}
                	if(item.item.enshUseGb == "1"){
                		$("#info-enshDcCode").val(fnObj.getDcCode("E"));
                		$("#info-enshObjt").val(item.item.enshObjt)
                		$("#info-enshEnsType").val(item.item.enshEnsType)
                		$("#info-enshDcCode").val(item.item.enshDcCode)
                		var enshSs = item.item.saleStmt.filter(function(ss){
                			// 봉안
                			return ss.partCode == "80-001"
                		})[0]
                		var enshMngSs = item.item.saleStmt.filter(function(ss){
                			// 봉안관리비
                			return ss.partCode == "81-002"
                		})[0]

						if(enshSs || enshMngSs){
							enshSs = enshSs||{}
							enshMngSs = enshMngSs||{}
							$("#info-enshRentalfee").val(enshSs.amount||0)
							$("#info-enshDcRentalfee").val(enshSs.dcAmt||0)
							$("#info-enshMngAmt").val(enshMngSs.amount||0)
							$("#info-enshDcMngAmt").val(enshMngSs.dcAmt||0)
							$("#info-enshCharge").val((enshSs.amount||0) - (enshSs.dcAmt||0) + (enshMngSs.amount||0) - (enshMngSs.dcAmt||0))
						}

                	}

                	// 총 부과액
                	$("#info-totCharge").val((+$("#info-charge").val())+(+$("#info-enshCharge").val()))

                	if(item.item.payment.length > 0){
						for(var i=0; i<item.item.payment.length; i++){

              				if((item.item.payment[i].partCode =="10-001" && (item.item.payment[i].kind =="B1" || item.item.payment[i].kind =="D1"))){
               					$("#btn-receipt").hide();
               					if(item.item.payment[i].partCode == "10-001"){
               						$("#sp-receipt-msg").html("정산완료(장례식장)")
	                    		}
                   			}else{
                   				$("#btn-receipt").show();
           						$("#sp-receipt-msg").html("")
                   			}
            			}
					}else{
						$("#btn-receipt").show();
  						$("#sp-receipt-msg").html("")
					}

                	app.modal.close();
                },
                searchHwaBookingModalResult : function(item){
                	fnObj.setHwaBooking(item.item);

                	bookDate = item.item.bookDate.date().print();
                	bookChasu = item.item.bookChasu;
                	bookChasuSeq = item.item.bookChasuSeq;
                	Common.search.setValue(fnObj.searchHwaBooking.target, "bookDate", item.item.bookDate.date().print());
					Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasu", item.item.bookChasu);
					Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasuSeq", item.item.bookChasuSeq);

                	app.modal.close();
                },

                isNew: function(){
                	var cremSeq = Common.search.getValue(fnObj.searchHwaCremation.target, "cremSeq");
                	if(!cremSeq || cremSeq.length == 0){
                		return true;
                	}else{
                		return false;
                	}
                },
                calcSum: function(){
                	$("#info-rentalfee, #info-charge, #info-dcAmt,  #info-enshCharge, #info-enshDcRentalfee, #info-natuCharge, #info-natuDcRentalfee").change();
                },
                calcPriceAndTerm: function(jobGubun,priceGubun,objt,addrPart,dcCode){
                	if(!fnObj.isNew()){
//                 		return;
                	}
                	app.ajax({
                        type: "GET",
                        url: "/CREM2010/pricelist/"+jobGubun+"/"+priceGubun+"/"+objt+"/"+addrPart+"/"+dcCode,
                       // url: "/CREM2010/pricelist/C/U/"+$("#info-objt").bindSelectGetValue().optionValue+"/"+$("#info-addrPart").bindSelectGetValue().optionValue+"/"+$("#info-dcCode").bindSelectGetValue().optionValue,
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("기본 사용료가 등록되지 않았습니다.");
                    			return;
                    		}

                    		//$("#info-cashAmt").val(res.map.pricelist.charge);
                    		var dcAmt = 0;
                    		var mngDcAmt = 0;
                    		//if(fnObj.isNew()){

                    			dcAmt =(res.map.pricelist.charge*res.map.dcRate/100).toFixed(0);

                    			var now = new Date();


                    			switch(jobGubun) {
                    			case  "C"  :
                    				if($("#info-objt").val() == "TMC0300007"){
                    					var cnt = +$("#info-openGraveCnt").val()
	                   					$("#info-rentalfee").val(res.map.pricelist.charge*cnt);
	                           			$("#info-dcAmt").val(dcAmt*cnt);
	                           			$("#info-charge").val((res.map.pricelist.charge-dcAmt)*cnt);
                    				}else{
	                   					$("#info-rentalfee").val(res.map.pricelist.charge);
	                           			$("#info-dcAmt").val(dcAmt);
	                           			$("#info-charge").val(res.map.pricelist.charge-dcAmt);
                    				}
                        			break;
                    			case  "E"  :	 $("#info-enshRentalfee").val(res.map.pricelist.charge);
                    				mngDcAmt =(res.map.mngAmt.charge*res.map.dcRate/100).toFixed(0);
                    				$("#info-enshMngAmt").val(res.map.mngAmt.charge);
                    				$("#info-enshDcMngAmt").val(mngDcAmt);
                        			$("#info-enshDcRentalfee").val(dcAmt);
                        			$("#info-enshCharge").val(Number(res.map.pricelist.charge)+Number(res.map.mngAmt.charge)-Number(dcAmt)-Number(mngDcAmt));
                        			$("#info-enshStrDate").val(now.print());
                            		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                            		now.setDate(now.getDate()-1);
                            		$("#info-enshEndDate").val(now.print());
    								break;
                    			case  "N"  : $("#info-natuRentalfee").val(res.map.pricelist.charge);
                    				$("#info-natuDcRentalfee").val(dcAmt);
                    				$("#info-natuCharge").val(res.map.pricelist.charge-dcAmt);
                    				$("#info-natuStrDate").val(now.print());
                            		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                            		now.setDate(now.getDate()-1);
                            		$("#info-natuEndDate").val(now.print());
									break;
                    			}
                    		//}



                    		//$("#info-receiptGb").change();
                        }
                    		fnObj.calcSum();
                    });
                },
                del: function(){
                	if(!confirm("화장접수 자료를 삭제하시겠습니까?")){
                		return false;
                	}
//                    	if(Common.str.replaceAll($("#info-calcCharge").val(), ",", "") > 0){
//                 		alert("정산취소 후 삭제가 가능합니다.");
//                 		return false;
//                 	}

                	app.ajax({
            			async: false,
                        type: "DELETE",
                        url: "/CREM2010/hwaCremation/"
                        			+Common.str.replaceAll($("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val(), "-", "")
                        			+"/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.massage);
                    	}else{
                    		toast.push("삭제완료하였습니다.");
                    		if(location.href.indexOf("?") != -1){
                    			location.href=location.href.substring(0,location.href.indexOf("?"));
                    		}else{
                    			$('#ax-form-btn-new').click();
                    		}

                    	}
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

              	 	 if($("#info-cremSeq").val() != "" &&  !confirm("저장하시겠습니까?")){

						return;
					}

              	 	 if($("#info-natuNatType").val() != "" && $("#info-natuStrDate").val() == ""){
              	 		toast.push("안장기간을 입력해주세요.");
              	 		return;
              	 	 }

              	 	 if($("#info-cremSeq").val() != ""){
              	 		 if(typeof fnObj.enshType != "undefined" && $("#info-natuNatType").val() !=""
                   	 		|| (typeof fnObj.natuType != "undefined" && $("#info-enshEnsType").val() !="")
                   	 		|| (typeof fnObj.enshType != "undefined" && fnObj.enshType != $("#info-enshEnsType").val())
                   	 		|| (typeof fnObj.natuType != "undefined" && fnObj.natuType != $("#info-natuNatType").val())
                   	 	){

                   	 		 if(!confirm("봉안, 자연장 사용여부 변경시 기존자료 삭제 후 저장 됩니다. 계속하시겠습니까?")){

                       	 		return false;
                       	 	}else{
//                        	 		if(Common.str.replaceAll($("#info-calcCharge").val(), ",", "") > 0){
//                              		alert("정산취소 후 삭제가 가능합니다.");
//                              		return false;
//                              	}
                       	 	}
                   	 	 }
              	 	 }




                    //if(!fnObj.isNewApplicant()){
                   		//return false;
                    //}
                    var info = fnObj.form.getJSON();
                    info.cremDate = Common.search.getValue(fnObj.searchHwaCremation.target, "cremDate");

                    app.ajax({
                        type: "PUT",
                        url: "/CREM2010/hwaCremation",
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

//                             if(res.map.hwaCremationVTO.thedeadVTO){
// 	                            $.each(res.map.hwaCremationVTO.thedeadVTO, function(key, value){
// 	                            	res.map.hwaCremationVTO[key] = value;
// 	                            });
//                             }
//                             if(res.map.hwaCremationVTO.applicantVTO){
// 	                            $.each(res.map.hwaCremationVTO.applicantVTO, function(key, value){
// 	                            	res.map.hwaCremationVTO[key] = value;
// 	                            });
//                             }
//                             fnObj.form.setJSON(res.map.hwaCremationVTO);
//                             fnObj.search.submit();
//                             fnObj.form.clear();
							Common.search.setValue(fnObj.searchHwaCremation.target, "cremDate", res.map.cremDate.date().print());
							Common.search.setValue(fnObj.searchHwaCremation.target, "cremSeq", res.map.cremSeq);

                            var prarms = "";
                            	 prarms=  "?cremDate="+res.map.cremDate.date().print();
                            	 prarms+= "&cremSeq="+res.map.cremSeq;

                            if(location.href.indexOf("?") != -1){
                    			location.href=location.href.substring(0,location.href.indexOf("?"))+prarms;
                    		}else{
                    			location.href=location.href+prarms;
                    		}
                           // fnObj.searchHwaCremation.submit();
                        }
                    });
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
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"cremSeq", addClass:"", valueBoxStyle:"", value:""}
            						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
            							onclick: function(){
            								fnObj.searchHwaCremation.submit();
            								//fnObj.calcPriceAndTerm();
            							}
            						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                    	app.ajax({
                			async: false,
                            type: "GET",
                            url: "/CREM2010/hwaCremation/"
                            			+$("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val()
                            			+"/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val(),
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
	                        		$.each(res.map.hwaCremationVTO.thedead, function(key, value){
	                        			res.map.hwaCremationVTO[key] = value;
	                        		});
                        		}
                        		if(res.map.hwaCremationVTO.applicantVTO){
	                        		$.each(res.map.hwaCremationVTO.applicantVTO, function(key, value){
	                        				res.map.hwaCremationVTO[key] = value;
	                        		});
                        		}
                        		if(res.map.enshrine){

                        			delete res.map.enshrine.charge;
                        			delete res.map.enshrine.rentalfee;
                        			delete res.map.enshrine.dcAmt;
	                        		$.each(res.map.enshrine, function(key, value){
											res.map.hwaCremationVTO[key] = value;
	                        		});
	                        		res.map.hwaCremationVTO.enshStrDate  = res.map.enshrine.strDate;
	                        		res.map.hwaCremationVTO.enshEndDate  = res.map.enshrine.endDate;
	                        		res.map.hwaCremationVTO.beforeEnsNo  = res.map.enshrine.ensNo;
	                        		fnObj.ensCnt = res.map.enshrine.ensdead.length;
                        		}

                        		if(res.map.nature){
	                        		$.each(res.map.nature, function(key, value){
	                        				res.map.hwaCremationVTO[key] = value;
	                        		});
	                        		res.map.hwaCremationVTO.natuStrDate  = res.map.nature.strDate;
	                        		res.map.hwaCremationVTO.natuEndDate  = res.map.nature.endDate;
	                        		res.map.hwaCremationVTO.beforeNatNo  = res.map.nature.natNo;
                        		}

                        		fnObj.form.clear();
                        		fnObj.enshType = res.map.hwaCremationVTO.enshEnsType;
                        		fnObj.natuType = res.map.hwaCremationVTO.natuNatType;
                        		fnObj.form.setJSON(res.map.hwaCremationVTO);

                        		$("#info-dcCode").val(res.map.hwaCremationVTO.dcCode);
                        		$("#info-objt").change()

                        		//Common.form.fillForm('info-',res.map.hwaCremationVTO);

                        		//$("#info-receiptGb").change();
                        		//$("#info-applicant-applJumin").blur();
                        		if(res.map.hwaCremationVTO.payment.length > 0){
            						for(var i=0; i<res.map.hwaCremationVTO.payment.length; i++){

                          				if((res.map.hwaCremationVTO.payment[i].partCode =="10-001" && (res.map.hwaCremationVTO.payment[i].kind =="B1" || res.map.hwaCremationVTO.payment[i].kind =="D1"))){
                           					$("#btn-receipt").hide();
                           					if(res.map.hwaCremationVTO.payment[i].partCode == "10-001"){
                           						$("#sp-receipt-msg").html("정산완료(장례식장)")
            	                    		}
                               			}else{
                               				$("#btn-receipt").show();
                       						$("#sp-receipt-msg").html("")
                               			}
                        			}
            					}else{
            						$("#btn-receipt").show();
              						$("#sp-receipt-msg").html("")
            					}
                        	}
                    	});
                    }
                },
                searchHwaBooking: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-hwaBooking",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.searchHwaBooking.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"화장예약번호", labelWidth:"", type:"inputText", width:"150", key:"bookDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
            										//toast.push(Object.toJSON(this));
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"bookChasu", addClass:"", valueBoxStyle:"", value:"" ,placeholder : "차수"}
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"bookChasuSeq", addClass:"", valueBoxStyle:"", value:"",placeholder : "순번"}
            						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
            							onclick: function(){
            							var bookDate =	Common.search.getValue(fnObj.searchHwaBooking.target, "bookDate");
            							var bookChasu = Common.search.getValue(fnObj.searchHwaBooking.target, "bookChasu");
            							var bookChasuSeq =Common.search.getValue(fnObj.searchHwaBooking.target, "bookChasuSeq");

	            							if(bookDate != "" && bookChasu != "" &&  bookChasuSeq != "" ){
	            								fnObj.searchHwaBooking.submit();
	            							}else{
	            								 app.modal.open({
	         			 	                        url:"/jsp/funeralsystem/crem0000/crem2000/CREM2012.jsp",
	         			 	                        pars:"callBack=fnObj.searchHwaBookingModalResult",
	         			 	                        width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	         			 	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	         			 	               		  });
	            							}
            							}
            						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){

                        var pars = this.target.getParam();
                        var url = "/CREM2010/hwaBooking/"+$("#"+fnObj.searchHwaBooking.target.getItemId("bookDate")).val()
				            			+"/"+$("#"+fnObj.searchHwaBooking.target.getItemId("bookChasu")).val()
				            			+"/"+$("#"+fnObj.searchHwaBooking.target.getItemId("bookChasuSeq")).val();
                        if(url.match("$//") || url.match("$/")){
                        	toast.push("화장예약일자/차수/순번을 입력 후 조회버튼을 눌러주세요.");
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
	                       		if(!res.map.hwaBooking || res.map.hwaBooking == null){
                        			toast.push("검색결과가 존재하지 않습니다.");
                        			return;
                        		}


	                       		fnObj.setHwaBooking(res.map.hwaBooking);



                        	//	$("#info-bookDate").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookDate")).val());
                        	//	$("#info-bookChasu").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookChasu")).val());
                        	//	$("#info-bookChasuSeq").val($("#"+fnObj.searchHwaBooking.target.getItemId("bookChasuSeq")).val());
                        		//$("#info-deadAddr1").change();
                        		//$("#info-deadJumin").blur();
                        	//	$("#info-deadJumin").change();
                        	//	$("#info-receiptGb").change();
	                       		//$("#info-enshEnsType").change();
	                       		//$("#iinfo-natuNatType").change();
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
                            Common.search.setValue(fnObj.searchHwaCremation.target, "cremSeq", "");
                           // Common.search.setValue(fnObj.searchHwaBooking.target, "bookDate", "");
                            Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasu", "");
                            Common.search.setValue(fnObj.searchHwaBooking.target, "bookChasuSeq", "");
                            $("#info-regname").val("${regname}");
                            //$("#info-deadPlace").bindSelectSetValue("TCM0900002"); // 의료기관
                            //$("#info-scatterPlace").bindSelectSetValue("TMC0600002");// 공설외봉안
                            //$("#info-applRelation").bindSelectSetValue("TCM0800004"); // 자녀
                            //$("#info-receiptGb").change();
                            $("#info-thedead-transferDate").change();
                            $("#info-enshDcCode").change();
                            $("#info-objt").change()
                    		fnObj.enshType = "";
    						fnObj.natuType = "";
    						fnObj.ensCnt = 0;
//                             fnObj.isDisabled();
            				//$("#form-info select[id^='info-']").find("option:eq(0)").prop("selected", true);
    						//$("#form-info select[id^='info-']").unbindSelect();
    						//$("#form-info select[id^='info-']").bindSelect();

                            //fnObj.bindEvent();

                        });
                    },
                    setJSON: function(item) {
                    	var _this = this;
                    	this.clear(false)
						//this.clear();
                        var info = $.extend({}, item);

                        app.form.fillForm(_this.target, info, 'info-', true);
                        app.form.fillForm(_this.target, info.thedead, 'info-thedead-', true);
                        app.form.fillForm(_this.target, info.applicant, 'info-applicant-', true);
                        app.form.fillForm(_this.target, info.enshrine, 'info-enshrine-', true);
                        app.form.fillForm(_this.target, info.nature, 'info-nature-', true);
//                         fnObj.isDisabled();
                    },
                    getJSON: function() {
                        //return app.form.serializeObjectWithIds(this.target, 'info-');
                    	var crem = app.form.serializeObjectWithIds(this.target, 'info-', true);
                    	var thedead = app.form.serializeObjectWithIds(this.target, 'info-thedead-' ,true);
                    	var applicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-' ,true);
                    	var enshrine = app.form.serializeObjectWithIds(this.target, 'info-enshrine-', true);
                    	var nature = app.form.serializeObjectWithIds(this.target, 'info-nature-', true);

                    	crem.deadId = thedead.deadId;
                    	crem.applId = applicant.applId;
                    	crem.thedead =thedead;
                    	crem.applicant = applicant;
                    	crem.enshrine = enshrine;
                    	crem.nature = nature;

                    	return $.extend(crem, fnObj.bindMoney.getValue());
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        this.target.find("select").find("option:eq(0)").prop("selected", true);
                        $("#info-thedead-transferDate").val("");
                        $("#info-thedead-transferDate").change();
                        $("#info-sendYn").val("N");
                    },
                } // form

            };
        </script>

    </ax:div>
</ax:layout>