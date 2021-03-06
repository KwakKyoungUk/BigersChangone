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
		                <div class="ax-search" id="page-search-enshrine"></div>
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
								<input type="hidden" id="info-ensDateString" name=ensDateString value=""/>
								<input type="hidden" id="info-ensSeq" name=ensSeq value=""/>
								<input type="hidden" id="info-bookDate" name="bookDate" value=""/>
								<input type="hidden" id="info-bookDate" name="bookDate" value=""/>
			                    <input type="hidden" id="info-bookChasu" name="bookChasu" value=""/>
			                    <input type="hidden" id="info-bookChasuSeq" name="bookChasuSeq" value=""/>
			                    <input type="hidden" id="info-cremDateString" name="cremDateString" value=""/>
			                    <input type="hidden" id="info-cremSeq" name="cremSeq" value=""/>
			                    <input type="hidden" id="info-feetypedivcd" name="feetypedivcd" value=""/>

			                    <ax:fields>
<%-- 				                        <ax:field label="봉안구역명" style="width:350px;">컬럼없음 --%>
<!-- 				                            <select id="info-" name="" class="AXSelect W100"></select> -->
<%-- 				                        </ax:field> --%>
			                        <ax:field label="봉안단구분*" style="width:500px;">
			                            <select id="info-ensType" name="ensType" class="AXSelect W160"></select>
			                        </ax:field>
			                        <ax:field label="봉안보관번호" style="width:500px;" >
				                        <input type="text" id="info-ensNo" name="ensNo" title="봉안보관번호" placeholder="봉안보관번호" maxlength="20" class="AXInput W100 av-required" value="" readonly="readonly" />
				                        <button id="btn-search-ensNo" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
			                        </ax:field>
			                    </ax:fields>

			                	<div style="text-align: right;">
			                		<button type="button" class="AXButton" id="btn-ensdead-new"><i class="axi axi-plus-circle"></i> 신규</button>
			                		<button type="button" class="AXButton" id="btn-ensdead-del"><i class="axi axi-minus-circle"></i> 삭제</button>
			                	</div>
			                    <div id="div-grid-ensdead" style="height: 100px;"></div>

								<ax:fields >
				                    <ax:field label="사망자명*" style="width: 194px;">
										<input type="hidden" id="info-deadId" name="deadId" class="AXInput W40" value="" readonly="readonly"/>
				                        <input type="text" id="info-deadName" name="deadName" title="사망자명" placeholder="사망자명" maxlength="20" class="AXInput W80" value=""  />
				                       <!-- 	<button id="btn-search-thedead" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button>  -->
				                    </ax:field>
				                    <ax:field label="주민등록번호" style="width: 194px;">
				                        <input type="text" id="info-deadJumin" name="deadJumin" title="주민등록번호" placeholder="주민등록번호" maxlength="100" class="AXInput W101" value=""  />
				                    </ax:field>
   									<ax:field label="관내외구분" style="width: 194px;">
										<select id="info-addrPart" name="addrPart" class="AXSelect W100"></select>
									</ax:field>
									<ax:field label="감면대상구분" style="width: 194px;">
										<select id="info-dcGubun" name="dcGubun" class="AXSelect W150"></select>
									</ax:field>
				           		</ax:fields>
				           		<ax:fields >
				                    <ax:field label="사망일자" style="width: 194px;">
				                        <input type="text" id="info-deadDateString" name="deadDateString" title="사망일자" placeholder="사망일자" class="AXInput W100" value="" />
				                    </ax:field>
				                    <ax:field label="사망시간" style="width: 194px;">
				                        <input type="text" id="info-deadTimeString" name="deadTimeString" title="사망시간" placeholder="사망시간" maxlength="5" class="AXInput W100" value=""  />
				                    </ax:field>
				                    <ax:field label="사용료*" style="width: 194px;">
										<input type="number" id="info-rentalfee" name="rentalfee" title="사용료" placeholder="사용료" maxlength="15" class="AXInput W100 av-required" value=""/>
										<button id="btn-search-rentalfee" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button>
									</ax:field>
									<ax:field label="감면금액" style="width: 194px;">
										<input type="number" id="info-dcAmt" name="dcAmt" title="감면금액" placeholder="감면금액" maxlength="15" class="AXInput W100" value=""/>
									</ax:field>
				           		</ax:fields>
				           		<ax:fields>
				                	<ax:field label="생년월일" style="width: 194px;">
				                        <input type="text" id="info-deadBirthString" name="deadBirthString" title="생년월일" placeholder="생년월일" maxlength="10" class="AXInput W100" value="" />
				                    </ax:field>
				                   	<ax:field label="사망자성별" style="width: 194px;">
				                        <select id="info-deadSex" name="deadSex" class="AXSelect W100"></select>
				                    </ax:field>
				                    <ax:field label="부과금액*" style="width: 194px;">
										<input type="number" id="info-charge" name="charge" title="부과금액" placeholder="부과금액" maxlength="15" class="AXInput W100 av-required" value=""/>
									</ax:field>
									<ax:field label="수납구분" style="width: 194px;">
										<select id="info-receiptGb" name="receiptGb" class="AXSelect W100"></select>
									</ax:field>
				           		</ax:fields>
				           		<ax:fields >
				                	<ax:field label="사망장소" style="width: 194px;">
				                        <select id="info-deadPlace" name="deadPlace" class="AXSelect W160"></select>
				                    </ax:field>
				                	<ax:field label="사망사유" style="width: 194px;">
				                        <select id="info-deadReason" name="deadReason" class="AXSelect W160"></select>
				                    </ax:field>
				                    <ax:field label="현금수납" style="width: 194px;">
										<input type="number" id="info-cashAmt" name="cashAmt" title="현금수납" placeholder="현금수납" maxlength="15" class="AXInput W100" value=""/>
									</ax:field>
									<ax:field label="카드수납" style="width: 194px;">
										<input type="number" id="info-cardAmt" name="cardAmt" title="카드수납" placeholder="카드수납" maxlength="15" class="AXInput W100" value=""/>
									</ax:field>
				               	</ax:fields>
				           		<ax:fields >
				                	<ax:field label="사망자국적구분" style="width: 194px;">
				                        <select id="info-deadNationGb" name="deadNationGb" class="AXSelect W100"></select>
				                    </ax:field>
				                    <ax:field label="주소구분" style="width: 194px;">
				                        <select id="info-deadAddrGubun" name="deadAddrGubun" class="AXSelect W50"></select>
			                       	</ax:field>
			                       	<ax:field label="주소지 코드" style="width: 194px;">
                                        <select id="info-addrCode" name="addrCode" class="AXSelect W180"></select>
                                    </ax:field>
		                       		<ax:field label="카드사" style="width: 194px;">
										<select id="info-cardCode" name="cardCode" class="AXSelect W50"></select>
									</ax:field>
				                </ax:fields>
				           		<ax:fields>
				                    <ax:field label="사망자 주소" style="width: 499px;">
				                        <input type="text" id="info-deadPost" name="deadPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
				                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
				                        <input type="text" id="info-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" class="AXInput av-required" style="width:340px;" value="" />
				               		</ax:field>
									<ax:field label="최초허가기간" style="width: 194px;">
										<input type="text" id="info-strDateString" name="strDateString" title="최초허가기간" placeholder="최초허가기간" maxlength="15" class="AXInput W70 av-required" value=""/>
										<input type="text" id="info-endDateString" name="endDateString" title="최초허가기간" placeholder="최초허가기간" maxlength="15" class="AXInput W70 av-required" value=""/>
									</ax:field>
									<ax:field label="연장횟수" style="width: 194px;">
										<input type="number" id="info-extCnt" name="extCnt" title="연장횟수" placeholder="연장횟수" maxlength="15" class="AXInput W100" value="" readonly="readonly"/>
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="상세주소" style="width: 499px;">
				                        <input type="text" id="info-deadAddr2" name="deadAddr2" title="사망자 주소" placeholder="상세주소" class="AXInput" value="" style="width:98%;"  />
									</ax:field>
									<ax:field label="현재허가기간" style="width: 194px;">
										<input type="text" id="info-extStrDateString" name="extStrDateString" title="현재허가기간" placeholder="현재허가기간" maxlength="15" class="AXInput W70" value="" />
										<input type="text" id="info-extEndDateString" name="extEndDateString" title="현재허가기간" placeholder="현재허가기간" maxlength="15" class="AXInput W70" value="" />
									</ax:field>
									<ax:field label="남은일수" style="width: 194px;">
										<input type="number" id="info-remain" name="remain" title="남은일수" placeholder="남은일수" maxlength="15" class="AXInput W100" value=""/>
									</ax:field>
								</ax:fields>
								<ax:fields >
                                    <ax:field label="봉안대상구분" style="width: 194px;">
                                        <select id="info-objt" name="objt" title="봉안대상구분" class="AXInput W150" value="" ></select>
                                    </ax:field>
                                    <ax:field label="종교" style="width: 194px;">
                                        <select id="info-deadFaith" name="deadFaith" class="AXSelect W100"></select>
                                    </ax:field>
									<ax:field label="특이사항">
										<input type="text" id="info-remark" name="remark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 400px;" value=""/>
									</ax:field>
								</ax:fields>

								<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
				                	<div class="right">
				                		<input type="text" name="x" class="AXInput W100" id="ax-input-switch" />
				                		<button type="button" class="AXButton" id="btn-report"><i class="axi axi-report"></i> 시설사용허가신청서</button>
				                		<button type="button" class="AXButton" id="btn-report2"><i class="axi axi-report"></i> 허가증</button>
				                		<button type="button" class="AXButton" id="btn-certificate"><i class="axi axi-certificate"></i> 봉안증명서</button>

				                		<button type="button" class="AXButton" id="btn-receipt"><i class="axi axi-receipt"></i> 영수증</button>
				                		<button type="button" class="AXButton" id="btn-report-photo"><i class="axi axi-picture-in-picture"></i>봉안관리대장(사진)</button>
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
		   							<%--  <ax:field label="신청자번호*" style="width:350px;">		                                      
		                                       <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
		                                    </ax:field> --%>
		                                    <ax:field label="신청자명*" style="width:350px;">
		                                        <input type="text" id="info-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="신청자 주민번호" style="width:350px;">
		                                        <input type="text" id="info-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W101" value="" />
		                                   		<button type="button" class="AXButton" id="btn-search-applJumin"><i class='axi axi-ion-android-search'></i>중복조회</button>
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
		                                        <input type="text" id="info-applAddr1" name="applAddr1" title="신청자 주소"  placeholder="" class="AXInput W300 av-required" value=""/>
		                                        <input type="text" id="info-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W300" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="사망자와의 관계*" style="width:350px;">
		                                        <select id="info-deadRelation" name="deadRelation" class="AXSelect W160"></select>
		                                        <input type="text" id="info-deadRelationNm" name="deadRelationNm" title="사망자와의 관계" maxlength="10" placeholder="사망자와의 관계" class="AXInput W100" value=""/>
		                                    </ax:field>
		                                    <ax:field label="휴대폰*" style="width:350px;">
		                                        <input type="text" id="info-applMobileno1" name="applMobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-applMobileno2" name="applMobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-applMobileno3" name="applMobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="email" style="width:350px;">
		                                        <input type="text" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value="" />@<input
		                                        type="text" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value="" />
		                                    </ax:field>
		                                    <ax:field label="전화번호" style="width:350px;">
		                                        <input type="text" id="info-applTelno1" name="applTelno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-applTelno2" name="applTelno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-applTelno3" name="applTelno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
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
	                        	<div id="div-tab-content-P">
	                        		<ax:form id="form-info-payer-applicant" name="form-info-payer-applicant" method="get">
		                        		<ax:fields>
		                        		  <input type="hidden" id="info-payer-applId" name="applId" title="납부자번호" placeholder="납부자번호"  maxlength="100" class="AXInput W100 av-required" value=""/>
		                                <%--     <ax:field label="납부자번호*" style="width:350px;">		                                      
		                                        <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
		                                    </ax:field> --%>
		                                    <ax:field label="납부자명*" style="width:350px;">
		                                        <input type="text" id="info-payer-applName" name="applName" title="납부자명" placeholder="납부자명" maxlength="100" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="납부자 주민번호" style="width:350px;">
		                                        <input type="text" id="info-payer-applJumin" name="applJumin" title="납부자 주민번호" placeholder="납부자 주민번호" maxlength="14" class="AXInput W100" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="납부자국적" style="width:350px;">
		                                        <select id="info-payer-applNationGb" name="applNationGb" class="AXSelect W100"></select>
		                                    </ax:field>
		                                    <ax:field label="납부자 주소*">
		                                        <select id="info-payer-applAddrGubun" name="applAddrGubun" class="AXSelect W50"></select>
		                                        <input type="text" id="info-payer-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
		                                        <button type="button" class="AXButton" id="btn-payerpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
		                                        <input type="text" id="info-payer-applAddr1" name="applAddr1" title="납부자 주소" placeholder="" class="AXInput W200 av-required" value=""/>
		                                        <input type="text" id="info-payer-applAddr2" name="applAddr2" title="납부자 주소" placeholder="상세주소" class="AXInput W400 av-required" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="휴대폰*" style="width:350px;">
		                                        <input type="text" id="info-payer-applMobileno1" name="applMobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-payer-applMobileno2" name="applMobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                        <input type="text" id="info-payer-applMobileno3" name="applMobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
		                                    </ax:field>
		                                </ax:fields>
		                                <ax:fields>
		                                    <ax:field label="email" style="width:350px;">
		                                        <input type="text" id="info-payer-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value="" />@<input
		                                        type="text" id="info-payer-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value="" />
		                                    </ax:field>
		                                    <ax:field label="전화번호" style="width:350px;">
		                                        <input type="text" id="info-payer-applTelno1" name="applTelno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-payer-applTelno2" name="applTelno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
		                                        <input type="text" id="info-payer-applTelno3" name="applTelno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
		                                    </ax:field>
		                                </ax:fields>
	                                </ax:form>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-list-payer-addrhst"><i class="axi axi-list"></i> 주소변경이력</button>
					                	</div>
				                    	<div class="ax-clear"></div>
				                	</div>
	                        	</div>
	                        	<div id="div-tab-content-E">
	                        		<div id="div-grid-ext" style="height: 200px;"></div>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-ensext"><i class="axi axi-save"></i> 사용연장등록</button>
					                	</div>
				                    	<div class="ax-clear"></div>
				                	</div>
	                        	</div>
	                        	<div id="div-tab-content-R">
	                        		<ax:form id="form-info-return" name="form-info-return" method="get">
                                        <input type="hidden" id="info-return-ensDateString" name="ensDateString"/>
                                        <input type="hidden" id="info-return-ensSeq" name="ensSeq"/>
		                        		<ax:fields>
		                                    <ax:field label="반환일자" style="width:200px;">
		                                        <input type="text" id="info-return-retDateString" name="retDateString" title="반환일자" maxlength="10" placeholder="반환일자" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="연번" style="width:200px;">
		                                        <input type="text" id="info-return-retSeq" name="retSeq" title="연번" maxlength="10" placeholder="연번" class="AXInput W100" value="" readonly="readonly" />
		                                    </ax:field>
		                                    <ax:field label="사용시작일" style="width:200px;">
		                                        <input type="text" id="info-return-strDateString" name="strDateString" title="사용시작일" maxlength="10" placeholder="사용시작일" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="사용종료일" style="width:200px;">
		                                        <input type="text" id="info-return-endDateString" name="endDateString" title="사용종료일" maxlength="10" placeholder="사용종료일" class="AXInput W100" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="수납액" style="width:200px;">
		                                        <input type="number" id="info-return-receiptAmt" name="receiptAmt" title="수납액" maxlength="15" placeholder="사용료" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환율" style="width:200px;">
		                                        <input type="number" id="info-return-retRate" name="retRate" title="반환율" maxlength="3" placeholder="반환율" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환금액" style="width:200px;">
		                                        <input type="number" id="info-return-retAmt" name="retAmt" title="반환금액" maxlength="15" placeholder="반환금액" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환방법" style="width:200px;">
		                                        <input type="text" id="info-return-retMethod" name="retMethod" title="반환방법" maxlength="10" placeholder="반환방법" class="AXInput W100" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="반환계좌" style="width:98%;">
		                                        <input type="text" id="info-return-retAccno" name="retAccno" title="반환계좌" maxlength="100" placeholder="반환계좌" class="AXInput av-required" style="width: 98%;" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="반환사유" style="width:98%;">
		                                        <input type="text" id="info-return-retReason" name="retReason" title="반환사유" maxlength="200" placeholder="반환사유" class="AXInput W100 av-required" value="" style="width:98%;" />
		                                    </ax:field>
		                        		</ax:fields>
	                        		</ax:form>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-return-new"><i class="axi axi-plus-circle"></i> 신규</button>
					                		<button type="button" class="AXButton" id="btn-return-delete"><i class="axi axi-minus-circle"></i> 삭제</button>
					                		<button type="button" class="AXButton" id="btn-return-save"><i class="axi axi-save"></i> 저장</button>
					                		<button type="button" class="AXButton" id="btn-return-report"><i class="axi axi-report"></i> 유골반환신청서</button>
					                	</div>
				                    	<div class="ax-clear"></div>
				                	</div>
	                        	</div>
	                        	<div id="div-tab-content-C">
	                        		<div id="div-grid-enssucced" style="height: 200px;"></div>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-enssucced"><i class="axi axi-save"></i> 승계처리</button>
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
        	var bookDate="${bookDate}";
        	var bookChasu="${bookChasu}";
        	var bookChasuSeq="${bookChasuSeq}";

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
                    "ensType": Common.getCode("TFM10"),
                    "firstTab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
                      					],
                    "tab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
	                      					{optionValue:"P", optionText:"납부자", closable:false},
	                      					{optionValue:"E", optionText:"사용연장"},
	                      					{optionValue:"R", optionText:"반환처리"},
	                      					{optionValue:"C", optionText:"사용승계"}
                      					],
   					"applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                    "applRelation": Common.getCode("TCM08"),
                    "deadNationGb": Common.getCode("TCM04"),
                    "cardCode": Common.getCode("TCM16"),
                    "receiptGb": Common.getCode("TMC15"),
                    "dcGubun": Common.getCode("TCM12"),
                    "addrPart": Common.getCode("TCM10"),
                    "deadSex": Common.getCode("TCM05"),
                    "deadPlace": Common.getCode("TCM09"),
                    "deadFaith": Common.getCode("TCM06"),
                    "deadReason": Common.getCode("TCM03"),
                    "objt": Common.getCode("TFM08"),
                    "addrCode": Common.addr.getAddrCode()
                },
                pageStart: function(){
                    this.bindEvent();
                    this.searchEnshrine.bind();
                    this.searchHwaCremation.bind();
                    this.form.bind();
                    this.formApplicant.bind();
                    this.formPayerApplicant.bind();
                    this.gridEnsdead.bind();
                    this.gridExt.bind();
                    this.gridEnssucced.bind();
					this.defaultSearch();
                },                
                defaultSearch: function(){
					var ensDate = "${param.ensDate}";
					var ensSeq = "${param.ensSeq}";
					if(ensDate.length == 0 || ensSeq.length == 0){
					}else{
						Common.search.setValue(fnObj.searchEnshrine.target, "ensDateString", ensDate);
						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", ensSeq);
						fnObj.searchEnshrine.submit();
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
                    $("#btn-search-ensNo").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1016.jsp?ensType="+$("#info-ensType").bindSelectGetValue().optionValue,
	                        pars:"callBack=fnObj.searchEnsNoModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                    $("#info-objt").bindSelect({
                        options:fnObj.CODES.objt
                    });
                    $("#info-deadFaith").bindSelect({
                        options:fnObj.CODES.deadFaith
                        ,isspace: true
                        ,setValue:""
                    });
                    $("#info-addrCode").bindSelect({
                        options:fnObj.CODES.addrCode
                    });
                    $("#info-deadAddr1").bind("change",function(){
                    	Common.addr.getAddrPart(this.value, "info-addrCode", "info-addrPart",true);
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
                    $("#info-deadNationGb").bindSelect({
        				options:fnObj.CODES.deadNationGb
        			});
                    $("#info-deadReason").bindSelect({
        				options:fnObj.CODES.deadReason
        				,isspace: true
                        ,setValue:""
        			});
                    $("#info-deadReason").bindSelectSetValue("TCM0300001"); //병사
                    $("#info-deadJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
					$("#info-deadJumin").bind("change",function(){ 						
 						
                    	if(Common.str.juminChk(this.value)){
                               parseInt(this.value.substring(7,8), 10) % 2 == 1 ? $("#info-deadSex").bindSelectSetValue("TCM0500001") : $("#info-deadSex").bindSelectSetValue("TCM0500002");
                               var year = parseInt(this.value.substring(0,1), 10)  == 0 ? "20" : "19";
                               var birthday = year+this.value.substring(0,2)+"-"+ this.value.substring(2,4) +"-"+this.value.substring(4,6);
                                console.log(birthday);
                                $("#info-deadBirthString").val(new Date(birthday).print("yyyy-mm-dd"));
                        }else{
                               //toast.push("잘못된 주민번호 입니다.")
                               //$("#info-deadJumin").val("");
                               $("#info-deadSex").bindSelectSetValue("TCM0500003");
                               $("#info-deadBirthString").val("");
                        }         
                    }); 
					// IE9 에서 bind, on chagne 다안먹혀서...
 					$("#info-deadJumin").keyup(function(){ 						
 						
                    	if(Common.str.juminChk(this.value)){
                               parseInt(this.value.substring(7,8), 10) % 2 == 1 ? $("#info-deadSex").bindSelectSetValue("TCM0500001") : $("#info-deadSex").bindSelectSetValue("TCM0500002");
                               var year = parseInt(this.value.substring(0,1), 10)  == 0 ? "20" : "19";
                               var birthday = year+this.value.substring(0,2)+"-"+ this.value.substring(2,4) +"-"+this.value.substring(4,6);
                                console.log(birthday);
                                $("#info-deadBirthString").val(new Date(birthday).print("yyyy-mm-dd"));
                        }else{
                               //toast.push("잘못된 주민번호 입니다.")
                               //$("#info-deadJumin").val("");
                               $("#info-deadSex").bindSelectSetValue("TCM0500003");
                               $("#info-deadBirthString").val("");
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
                    $("#info-deadPlace").bindSelectSetValue("TCM0900002");
                    $("#info-deadAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-deadPost", "info-deadAddr1", "info-deadAddr2");
                    });
                    $("#btn-ensdead-new").bind("click", function(){
                    	var listLimit;
                    	var ensTypeName;
                    	if($("#info-ensType").bindSelectGetValue().optionValue == fnObj.CODES.ensType[0].optionValue){//개인
                    		listLimit = 1;
                    		ensTypeName = fnObj.CODES.ensType[0].optionText;
                    	}else if($("#info-ensType").bindSelectGetValue().optionValue == fnObj.CODES.ensType[1].optionValue){//부부
                    		listLimit = 2;
                    		ensTypeName = fnObj.CODES.ensType[1].optionText;
                    	}else{
                    		listLimit = 999;
                    		ensTypeName = fnObj.CODES.ensType[2].optionText;
                    	}
                    	if(fnObj.gridEnsdead.target.list.length < listLimit){
	                    	fnObj.gridEnsdead.add();
                    	}else{
							toast.push(ensTypeName+"은 최대 "+listLimit+"명의 고인을 등록할 수 있습니다.");
                    	}
//                     	$("[id^='info-dead']").val("");
                    });
                    $("#btn-ensdead-del").bind("click", function(){
                    	if(fnObj.gridEnsdead.target.list.length <= 1){
                    		alert("1개 이하 고인데이터는 삭제할 수 없습니다.");
                    		return;
                    	}
                    	var item = fnObj.gridEnsdead.target.getSelectedItem().item;
                    	if(
                    		!item.ensDateString || item.ensDateString.length == 0
                    		|| !item.ensSeq || item.ensSeq.length == 0
                    		|| !item.deadSeq || item.deadSeq.length == 0
                    		){
                    		fnObj.gridEnsdead.target.removeListIndex([fnObj.gridEnsdead.target.getSelectedItem()]);
                            toast.push("삭제되었습니다.");
                    		return;
                    	}
                    	if(!confirm(item.deadName+"님의 봉안자료를 삭제하시겠습니까?")){
                    		return;
                    	}
                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensdead/"+item.ensDateString+"/"+item.ensSeq+"/"+item.deadSeq,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
        						Common.search.setValue(fnObj.searchEnshrine.target, "ensDateString", item.ensDateString);
        						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", item.ensSeq);
        						fnObj.searchEnshrine.submit();
                            }
                        });
                    });
                    $("#info-receiptGb").bindSelect({
        				options:fnObj.CODES.receiptGb
        			});
                    $("#info-receiptGb").bind("change", function(){
                    	//console.log(this.value);
                    	//var cash = $("#info-cashAmt").val();
                    	//var card = $("#info-cardAmt").val();
                    	//$("#info-cashAmt").val(card);
                    	//$("#info-cardAmt").val(cash);
                    	var charge= $("#info-charge").val();
                    	if(this.value == "TMC1500001"){
                    		$("#info-cardCode").bindSelectAddOptions([{optionValue:"", optionText:""}]);
                    		$("#info-cardCode").bindSelectSetValue("");
                    		$("#info-cashAmt").val(charge);
                        	$("#info-cardAmt").val(0);
                        	$("#info-cardCode").bindSelectDisabled(true);
                    	}else {
                    		$("#info-cardCode").bindSelectRemoveOptions([{optionValue:"", optionText:""}]); 
                    		//$("#info-cardCode").bindSelectSetValue("TCM1600001");
                    		$("#info-cashAmt").val(0);
                        	$("#info-cardAmt").val(charge);
                        	$("#info-cardCode").bindSelectDisabled(false);
                    	}
                    	
                    });
                    $("#info-ensType").bindSelect({
        				options:fnObj.CODES.ensType
        			});
                    $("#info-ensType").bind("change", function(e){
                    	var limits = [1,2,999];
                    	var listLimit = limits[
	                    	                       (function(){
	                    	                    	   var index;
	                    	                    	   fnObj.CODES.ensType.map(function(obj, idx){
	                    	                    		   if(obj.optionValue == $("#info-ensType").bindSelectGetValue().optionValue){
	                    	                    			   index = idx;
	                    	                    			   return;
	                    	                    		   }
	                    	                    	   })
	                    	                    	   return index;
	                    	                       }())
                    	                       ];

                    	if(fnObj.gridEnsdead.target.list.length > listLimit){
                    		toast.push($(this).bindSelectGetValue().optionText+"은 최대 "+listLimit+"명의 고인만 등록 가능합니다.");
                    		$(this).bindSelectSetValue($("#info-ensType").attr("oldValue"));
                    	}
                    	$("#info-ensType").attr("oldValue", $("#info-ensType").bindSelectGetValue().optionValue);
                    });
                    $("#info-cardCode").bindSelect({
        				options:fnObj.CODES.cardCode
        			});
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
                 /*    $("#form-info [id^='info-dead'], #info-objt, #info-addrCode").bind("blur",function(){
                    	var item = fnObj.gridEnsdead.target.getSelectedItem();
                    	if(item.error){
                    		return;
                    	}
                    	var name = this.getAttribute("name");
                    	item.item[name] = $(this).val();
                    	fnObj.gridEnsdead.target.updateList(item.index, item.item);
                    	
                    	
                    }); */
                    
                    $("#form-info [id^='info-dead'], #info-objt, #info-addrCode").bind("change",function(){
                    	var item = fnObj.gridEnsdead.target.getSelectedItem();
                    	if(item.error){
                    		return;
                    	}
						
                    	var name = this.getAttribute("name");
                    	item.item[name] = $(this).val();
                    	fnObj.gridEnsdead.target.updateList(item.index, item.item);
                    	
						
                    });
                    
                    $("#btn-search-hwaCremation").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem2000/CREM2021.jsp",
	                        pars:"callBack=fnObj.searchHwaCremationModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                                                           
                    $("#btn-search-thedead").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp",
	                        //pars:"callBack=fnObj.searchThedeadModalResult&deadId="+$("#info-deadId").val(),
	                        pars:"callBack=fnObj.searchThedeadModalResult&cremDate="+Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString")+"&deadId="+$("#info-deadId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                    $("#btn-search-rentalfee").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1017.jsp",
	                        pars:"callBack=fnObj.searchRentalfeeModalResult&jobGubun=E&priceGubun=U&objt="+$("#info-ensType").bindSelectGetValue().optionValue,
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
	               	$("#info-extEndDateString").bindPattern({pattern: "custom", max_length: 10, patternString:"9999-99-99"});
	               	$("#info-extStrDateString").bindPattern({pattern: "custom", max_length: 10, patternString:"9999-99-99"});
	               	$("#info-applJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                  	$("#info-applAddrGubun").bindSelect({
	       				options:fnObj.CODES.addrGubun
	       			});
	                $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applPost", "info-applAddr1", "info-applAddr2");
	                   });
	              
	                $("#btn-payerpost").bind("click", function(){
	                   	daumPopPostcode("info-payer-applPost", "info-payer-applAddr1", "info-payer-applAddr2");
	                   });
                   	$("#info-applNationGb").bindSelect({
	       				options:fnObj.CODES.applNationGb
	       			});
					$("#info-deadRelation").bindSelect({
						options:fnObj.CODES.applRelation
						,setValue : "TCM0800004"
					});
	                   $("#btn-search-applicant").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
	                        pars:"callBack=fnObj.searchApplicantModalResult&applId="+$("#info-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
	                   });
                	$("#info-payer-applJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                    $("#info-payer-applAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                    $("#btn-applpost",$("#div-tab-content-P")).bind("click", function(){
                    	daumPopPostcode("info-payer-applPost", "info-payer-applAddr1", "info-payer-applAddr2");
                    });
                    $("#info-payer-applNationGb").bindSelect({
        				options:fnObj.CODES.applNationGb
        			});
                    $("#info-payer-applRelation").bindSelect({
        				options:fnObj.CODES.applRelation
        			});
                    $("#btn-search-applicant",$("#div-tab-content-P")).bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
	                        pars:"callBack=fnObj.searchApplicantModalResult&applId="+$("#info-payer-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
//                     $("[id^='div-tab-content-']").css("display", "none");
//                    	$("#div-tab-content-A").css("display", "block");
					$("#div-content").append($("#div-tab-content-A"));
//                     setTimeout(function(){
//                     	$("#div-contents").empty();
//                     	$("#div-contents").append(fnObj.tabs["div-tab-content-A"].tab);
//                     	fnObj.tabs["div-tab-content-A"].bindEvent();
//                    	}, 500);
					$("#btn-save-applicant").bind("click",function(){
						fnObj.saveApplicant("A", false, fnObj.formApplicant);
					});
					$("#btn-save-applicant-addrhst").bind("click",function(){
						fnObj.saveApplicant("A", true, fnObj.formApplicant);
					});
					$("#btn-list-applicant-addrhst").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1013.jsp",
	                        pars:"callBack=fnObj.addrhstModalResult&applId="+$("#info-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#btn-save-payer").bind("click",function(){
						fnObj.saveApplicant("P", false, fnObj.formPayerApplicant);
					});
					$("#btn-save-payer-addrhst").bind("click",function(){
						fnObj.saveApplicant("P", true, fnObj.formPayerApplicant);
					});
					$("#btn-list-payer-addrhst").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1013.jsp",
	                        pars:"callBack=fnObj.addrhstModalResult&applId="+$("#info-payer-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#btn-ensext").bind("click",function(){
						app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1014.jsp",
	                        pars:"callBack=fnObj.addrhstModalResult&ensDate="+$("#info-ensDateString").val()+"&ensSeq="+$("#info-ensSeq").val()+"&ensType="+$("#info-ensType").val()+"&endDate="+$("#info-endDateString").val()+"&deadId="+$("#info-deadId").val(),
	                        width:1400, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#btn-return-new").bind("click",function(){
						var ensDate = $("#info-ensDateString").val();
						var ensSeq = $("#info-ensSeq").val();
						fnObj.formEnsret.clear();
						$("#info-return-ensDateString").val(ensDate);
						$("#info-return-ensSeq").val(ensSeq);
						$("#info-return-retDateString").bindDate();
						$("#info-return-retDateString").val(new Date().print());
						$("#info-return-receiptAmt").val($("#info-charge").val());
						$("#info-return-strDateString").val($("#info-extStrDateString").val());
						$("#info-return-endDateString").val($("#info-extEndDateString").val());
						app.ajax({
	                        type: "GET",
	                        url: "/ENSH1010/retlist/"+$("#info-return-strDateString").val().date().print("yyyymmdd"),
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.message);
	                    	}else{
	                    		if(res.map.retlistVTO == null){
	                    			toast.push("감면율이 등록되지 않았습니다.");
	                    			return;
	                    		}
	                    		$("#info-return-retRate").val(res.map.retlistVTO.retRate);
	                    		$("#info-return-retAmt").val(($("#info-return-receiptAmt").val() * res.map.retlistVTO.retRate / 100).toFixed(0));
	                        }
	                    });
					});
					$("#btn-return-delete").bind("click",function(){
						fnObj.formEnsret.del();
					});
					$("#btn-return-save").bind("click",function(){
						fnObj.formEnsret.save();
					});
					$("#info-return-strDateString").bindDate();
					$("#info-return-endDateString").bindDate();
					$("#btn-enssucced").bind("click", function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1015.jsp",
	                        pars:"callBack=fnObj.enssuccedModalResult&applId="+$("#info-applId").val()+"&ensDate="+$("#info-ensDateString").val()+"&ensSeq="+$("#info-ensSeq").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					});
					$("#info-deadTimeString").bindPattern({pattern: "custom", max_length: 5, patternString:"99:99"});
					$("#info-ensType, #info-addrPart, #info-dcGubun").bind("change", fnObj.calcPriceAndTerm);
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
					})
                    $('#ax-form-btn-new').click(function() {
                        fnObj.form.clear();
                        fnObj.formApplicant.clear();
                       	fnObj.formEnsret.clear();
                       	fnObj.formPayerApplicant.clear();
                       	$("#div-tab").updateTabs(fnObj.CODES.firstTab);
						$("#div-contents").append($("[id^='div-tab-content-']"));
						$("#div-content").append($("#div-tab-content-A"));
						Common.search.setValue(fnObj.searchEnshrine.target, "ensDateString", new Date().print());
						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", "");
                        fnObj.gridEnsdead.target.setData({list:[{}]});
                        fnObj.gridEnsdead.target.setFocus(0);
						fnObj.gridEnssucced.target.setData({list:[]});
						fnObj.gridExt.target.setData({list:[]});
						$("#info-ensType").change();
						 $("#info-deadPlace").bindSelectSetValue("TCM0900002");
						 $("#info-receiptGb").change();
						 $("#info-deadRelation").bindSelectSetValue("TCM0800004");
						 $("#info-deadReason").bindSelectSetValue("TCM0300001"); //병사
						 
                    });


                    $("#btn-report").bind("click", function(){
                    	var params = [];
                    	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	var deadId = $("#info-deadId").val();
                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                    	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    		return;
                    	}

                    	params.push("ensDate="+ensDate);
                		params.push("ensSeq="+ensSeq);
                		params.push("deadId="+deadId);
                		params.push("encYN="+encYN);

                    	Common.report.open("/reports/ensh/ENSH1012", "pdf", params.join("&"));

                    });
                    
                    $("#btn-report2").bind("click", function(){
                    	var params = [];
                    	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	var deadId = $("#info-deadId").val();
                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                    	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    		return;
                    	}

                    	params.push("ensDate="+ensDate);
                		params.push("ensSeq="+ensSeq);
                		params.push("deadId="+deadId);
                		params.push("encYN="+encYN);

                    	Common.report.open("/reports/ensh/ENSH1016", "pdf", params.join("&"));

                    });

                    $("#btn-report-photo").bind("click", function(){
                    	var params = [];
                    	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	var deadId = $("#info-deadId").val();
                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                    	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    		return;
                    	}

                    	params.push("ensDate="+ensDate);
                		params.push("ensSeq="+ensSeq);
                		params.push("deadId="+deadId);
                		params.push("encYN="+encYN);

                    	Common.report.open("/reports/ensh/ENSH1013", "pdf", params.join("&"));

                    });

                    $("#btn-certificate").bind("click", function(){
                    	var params = [];
                    	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	var deadId = $("#info-deadId").val();
                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                    	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    		return;
                    	}

                    	params.push("ensDate="+ensDate);
                		params.push("ensSeq="+ensSeq);
                		params.push("deadId="+deadId);
                		params.push("encYN="+encYN);

                    	Common.report.open("/reports/ensh/ENSH1014", "pdf", params.join("&"));

                    });

                    $("#btn-receipt").bind("click", function(){
                    	var params = [];
                    	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDateString"), "-", "");
                    	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                    	var deadId = $("#info-deadId").val();
                    	
                    	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                    		return;
                    	}

                    	params.push("ensDate="+ensDate);
                		params.push("ensSeq="+ensSeq);
                		params.push("deadId="+deadId);
                	

                    	Common.report.open("/reports/ensh/ENSH1015", "pdf", params.join("&"));

                    });


                    $("#btn-return-report").bind("click", function(){
                    	var params = [];
                    	var retDate = Common.str.replaceAll($("#info-return-retDateString").val(), "-", "");
                    	var retSeq = $("#info-return-retSeq").val();
                    	var deadId = $("#info-deadId").val();
                    	var encYN = $("#ax-input-switch").val() == "암호화 적용" ? "Y" : "N";
                    	
                    	if(retDate ==  "" || retSeq == ""  || deadId == ""){

                    		return;
                    	}
                    	

                    	params.push("retDate="+retDate);
                		params.push("retSeq="+retSeq);
                		params.push("deadId="+deadId);
                		params.push("encYN="+encYN);

                    	Common.report.open("/reports/ensh/ENSH2022", "pdf", params.join("&"));

                    });
                    
                    //신청자 중복체크
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

                },
                isNewApplicant: function(){
                	var applJumin = $("#info-applJumin").val();
                	if(!Common.str.juminChk(applJumin)){
                		alert("유효하지 않는 주민번호입니다. \n 다시 확인하시고 입력해 주세요");
                		$("#info-applJumin").focus();      
                		return false;
                	}
                	app.ajax({
                        type: "PUT",
                        url: "/ENSH1012/applicant/",
                        data: Object.toJSON({"applJumin" : applJumin})
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
                    	}else{
							
                    		if(res.map.isNew){
                    			if($("#info-applId").val() == ""){
                    				toast.push("중복된 신청자가 존재하지 않습니다.");	
                    				return; 
                    			}   							
								if($("#info-applId").val() !="" && confirm("신청자를 변경하시겠습니까? 신청자 정보가 초기화 됩니다.")){
									$("#form-info-applicant [id^='info-appl'][id!='info-applJumin']").val("");
									return;
								}									
							}else{
								var newApplId = res.map.applicantVTO.applId;								
								//if(($("#info-ensSeq").val() =="" || newApplId != $("#info-applId").val()) && !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
								if(($("#info-applId").val() =="" || newApplId != $("#info-applId").val()) && !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
			                		return;
			                	}								
               				 	
								 Common.form.fillForm('info-',res.map.applicantVTO);		
								 $("#info-applJumin").blur();	
							}	
                        }
                    });
                
                },
                isNew: function(){
                	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                	if(!ensSeq || ensSeq.length == 0){
                		return true;
                	}else{
                		return false;
                	}
                },
                calcPriceAndTerm: function(){
                	
                	app.ajax({
                        type: "GET",
                        url: "/ENSH1010/pricelist/"+$("#info-ensType").bindSelectGetValue().optionValue+"/"+$("#info-addrPart").bindSelectGetValue().optionValue+"/"+$("#info-dcGubun").bindSelectGetValue().optionValue,
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("사용료가 등록되지 않았습니다.");
                    			return;
                    		}
                    		
                    		$("#info-rentalfee").val(res.map.generalPricelist.charge);
                    		$("#info-dcAmt").val(res.map.dcAmt);
                    		$("#info-charge").val(res.map.pricelist.charge);                    		
                    		
					
                    		
                    		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                    		
                    		if(fnObj.isNew()){
                    			var now = new Date();
                        		$("#info-strDateString").val(now.print());
                        		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                        		now.setDate(now.getDate()-1);
                        		$("#info-endDateString").val(now.print());
                    			$("#info-cashAmt").val(res.map.pricelist.charge);      
                    		}
                    		$("#info-receiptGb").change();
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

                    var ensdeadList = fnObj.gridEnsdead.target.getList();
                    var info = fnObj.form.getJSON();
                    var list = [];
				/*  	for(i=0; i<ensdeadList.length; i++){                        
                       for(var key in info){
                             ensdeadList[i][key] = info[key];
                        }
                       
                    } */
					info.ensdeadList = ensdeadList;
                   
                    info.applId = $("#info-applId").val();
                    info.payerId = $("#info-payer-applId").val();
                    info.deadRelation = $("#info-deadRelation").bindSelectGetValue().optionValue;
                    info.deadRelationNm = $("#info-deadRelationNm").val();
                     var applicant = fnObj.formApplicant.getJSON();
                     for(var key in applicant){
                     	info[key] = applicant[key];
                     }
                     var payerApplicant = fnObj.formPayerApplicant.getJSON();
                     info.payerApplicant = payerApplicant;
                    app.ajax({
                        type: "PUT",
                        url: "/ENSH1010/enshrine",
                        data: Object.toJSON(info)
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
                    	}else if(res.map.error){
                            Common.message.validError(res.map.error);
                        }
                        else
                        {
                            toast.push("저장되었습니다.");
                            if(res.map.ensDateString){
                            	$("#ensDateString").val(res.map.ensDateString);
                            }
                            if(res.map.ensSeq){
                            	$("#ensSeq").val(res.map.ensSeq);
                            }
                            Common.search.setValue(fnObj.searchEnshrine.target, "ensDateString", res.map.ensDateString);
                            Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", res.map.ensSeq);
                            fnObj.searchEnshrine.submit();
//                             fnObj.form.clear();
                        }
                    });
                },
                del: function(){
                	app.ajax({
                        type: "DELETE",
                        url: "/ENSH1010/enshrine/"+$("#info-ensDateString").val().date().print("yyyymmdd")+"/"+$("#info-ensSeq").val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
                    	}else{
                            toast.push("삭제되었습니다.");
                            $("#ax-form-btn-new").click();
                        }
                    });
                },
                searchRentalfeeModalResult : function(item){

                	app.ajax({
                        type: "GET",
                        url: "/ENSH1010/pricelist/"+item.objt+"/"+item.addrPart+"/"+item.dcGubun,
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("사용료가 등록되지 않았습니다.");
                    			return;
                    		}
                    		$("#info-rentalfee").val(res.map.pricelist.charge);
                    		$("#info-dcAmt").val(res.map.dcAmt);
                    		$("#info-charge").val(res.map.pricelist.charge);
                    		$("#info-cashAmt").val(res.map.pricelist.charge);

                    		var now = new Date();
                    		$("#info-strDateString").val(now.print());
                    		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                    		now.setDate(now.getDate()-1);
                    		$("#info-endDateString").val(now.print());

                    		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                        }
                    });


//             		$("#info-rentalfee").val(item.charge);
//             		$("#info-dcAmt").val(0);
//             		$("#info-charge").val(item.charge);
//             		$("#info-cashAmt").val(item.charge);

//             		var now = new Date();
//             		$("#info-strDateString").val(now.print());
//             		now.setFullYear(now.getFullYear()+item.useTerm);
//             		now.setDate(now.getDate()-1);
//             		$("#info-endDateString").val(now.print());

            		app.modal.close();
                },
                saveApplicant: function(applType, changeAddr, form){
                    var validateResult = form.validate_target.validate();
                    if (!validateResult) {
                        var msg = form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var info = form.getJSON();
                    app.ajax({
                        type: "PUT",
                        url: "/ENSH1010/applicant/"+applType+"/"+$("#info-ensDateString").val()+"/"+$("#info-ensSeq").val()+"/"+changeAddr+"/"+$("#info-beforeApplId").val(),
                        data: Object.toJSON(info)
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.message);
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
                searchHwaCremationModalResult : function(){
                	
                	
                },
                searchThedeadModalResult: function(thedead){
                	for(var key in thedead){
                		$("#info-"+key).val(thedead[key]);
                		$("#info-"+key).bindSelectSetValue(thedead[key]);
                		app.modal.close();
                		$("#form-info [id^='info-dead']").change();
                		$("#info-objt").change();
                		$("#form-info [id^='info-dead']").blur();
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
                searchEnsNoModalResult: function(ensNo){
                	$("#info-ensNo").val(ensNo);
                	app.modal.close();
                },
                searchEnshrine: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-enshrine",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.searchEnshrine.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"봉안관리번호", labelWidth:"", type:"inputText", width:"150", key:"ensDateString", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
//             										$("#info-ensDate").val(this.value);
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"ensSeq", addClass:"", valueBoxStyle:"", value:""
                                    	, onChange: function(changedValue){
            								//아래 2개의 값을 사용 하실 수 있습니다.
//             								toast.push(Object.toJSON(this));
//             								toast.push(changedValue);
//                                     		$("#info-ensSeq").val(changedValue);
            							}
                                    }
            						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
            							onclick: function(){
            								fnObj.searchEnshrine.submit();
            							}
            						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	var ensSeq = $("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val();
                    	if(!ensSeq || ensSeq == ''){
                    		toast.push("봉안번호를 입력해주세요.");
                    		return;
                    	}
                    	app.ajax({
                			async: false,
                            type: "GET",
                            url: "/ENSH1010/enshrine/"+$("#"+fnObj.searchEnshrine.target.getItemId("ensDateString")).val()+"/"+$("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.massage);
                        	}else{
                        		if(!res.map.enshrineVTO || res.map.enshrineVTO == null){
                        			toast.push("검색 결과가 존재하지 않습니다.");
                        			return;
                        		}
                        		if(res.map.enshrineVTO.applicantVTO){
	                        		$.each(res.map.enshrineVTO.applicantVTO, function(key, value){
	                       				res.map.enshrineVTO[key] = value;
	                        		});
                        		}
                        		if(res.map.enshrineVTO.payerApplicantVTO){
	                        		fnObj.formPayerApplicant.clear();
	                        		fnObj.formPayerApplicant.setJSON(res.map.enshrineVTO.payerApplicantVTO);
                        		}
                        		if(res.map.enshrineVTO.ensextVTOList){
	                                fnObj.gridExt.target.setData({list:res.map.enshrineVTO.ensextVTOList});
                        		}else{
	                                fnObj.gridExt.target.setData({list:[]});
                        		}
                        		if(res.map.enshrineVTO.ensretVTO){
	                        		fnObj.formEnsret.clear();
	                                fnObj.formEnsret.setJSON(res.map.enshrineVTO.ensretVTO);
                        		}
                        		if(res.map.enshrineVTO.enssuccedVTOList){
                        			fnObj.gridEnssucced.target.setData({list:res.map.enshrineVTO.enssuccedVTOList});
                        		}else{
	                                fnObj.gridEnssucced.target.setData({list:[]});
                        		}                        		
                        		fnObj.gridEnsdead.target.pushList([]);
                        		//fnObj.form.clear();
                        		fnObj.formApplicant.clear();
                        		//Common.form.fillForm("info-",res.map.enshrineVTO);
                        		fnObj.form.setJSON(res.map.enshrineVTO);
                        		fnObj.formApplicant.setJSON(res.map.enshrineVTO);
                        		$("#info-beforeApplId").val(res.map.enshrineVTO.applId);
                        		$("#div-tab").updateTabs(fnObj.CODES.tab);
    							$("#div-contents").append($("[id^='div-tab-content-']"));
    							$("#div-content").append($("#div-tab-content-A"));
    							$("input").blur();
                        		if(res.map.enshrineVTO.ensdeadVTOList){
                        			for(var i=0; i<res.map.enshrineVTO.ensdeadVTOList.length; i++){
                        				fnObj.gridEnsdead.target.setData({list:[]})
                        				if(res.map.enshrineVTO.ensdeadVTOList[i].thedeadVTO){
			                        		$.each(res.map.enshrineVTO.ensdeadVTOList[i].thedeadVTO, function(key, value){
			                        			res.map.enshrineVTO.ensdeadVTOList[i][key] = value;
			                        		});
                        				}
                        			}
	                        		fnObj.gridEnsdead.target.pushList(res.map.enshrineVTO.ensdeadVTOList);
                        			fnObj.gridEnsdead.target.setFocus(0);
                        			setTimeout(function(){$("#div-grid-ensdead .gridBodyTr.selected td").click()}, 500);
                        		}
                        		$("#info-receiptGb").change();
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
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"cremSeq", addClass:"", valueBoxStyle:"", value:""}
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
                        var url = "/CREM2010/hwaCremation/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val().date().print("yyyymmdd")+"/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val();
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
                        		alert(res.message);
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
	                       				res.map.hwaCremationVTO[key] = value;
	                        		});
                        		}
                        		fnObj.form.clear();
                        		fnObj.formApplicant.clear();
                        		fnObj.gridEnsdead.target.setData({list:[]})
                        		fnObj.gridEnsdead.add();
                        		fnObj.form.setJSON(res.map.hwaCremationVTO);
                        		console.log(res.map.hwaCremationVTO.applicantVTO);
                        		fnObj.formApplicant.setJSON(res.map.hwaCremationVTO.applicantVTO);
                        		$("#info-deadRelation").bindSelectSetValue(res.map.hwaCremationVTO.applRelation);
                        		$("#info-deadRelationNm").val(res.map.hwaCremationVTO.applRelationNm);
                        		 var objt = {"TMC0300001" : "TFM0800001"                    				
                    				 , "TMC0300003" : "TFM0800004"
                    				 , "TMC0300007" : "TFM0800005"
                    				 };
                         		$("#info-objt").bindSelectSetValue(objt[res.map.hwaCremationVTO.objt]);
                        		$("#form-info [id^='info-dead']").change();
                        		$("#info-objt").change();
                        		$("#info-receiptGb").change();
                        		$("#info-deadJumin").change();
                        		setTimeout(function(){$("#page-search-hwaCremation input").blur()}, 500);
                        		$("#ax-input-switch").setValueInput("암호화 적용");
                        	}
                    	});
                    }
                },

                gridEnsdead: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ensdead",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"deadName", label:"고인명", width:"150", align:"center"},
                                {key:"deadJumin", label:"주민번호", width:"200", align:"center"
                                	, formatter: function(val){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadDateString", label:"사망일자", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"deadSex", label:"성별", width:"100", align:"center"
                                	, formatter:function(val){
                                		for(var i=0; i<fnObj.CODES.deadSex.length; i++){
                                			if(this.value == fnObj.CODES.deadSex[i].optionValue){
                                				return fnObj.CODES.deadSex[i].optionText;
                                			}
                                		}
                                	}
                                },
                            ],
                            body : {
                                onclick: function(){
//                                 	app.form.fillForm(fnObj.form.target, this.item, 'info-dead');
									$("#form-info [id^='info-dead']").val("");
									for(var key in this.item){
										$("#form-info [name='"+key+"']").bindSelectSetValue(this.item[key]);
										$("#form-info [name='"+key+"']").val(this.item[key]);
										$("#form-info [name='"+key+"']").blur();
									}
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                        fnObj.gridEnsdead.target.setData({list:[{}]});
                        fnObj.gridEnsdead.target.setFocus(0);
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                        $("#form-info [id^='info-dead']").val("");
                        $("#form-info [id^='info-dead']").bindSelectSetValue("");
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },
                gridExt: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ext",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"extDateString", label:"연장일자", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.value.date().print();
                                	}
                                },
                                {key:"extSeq", label:"연번", width:"100", align:"center"},
                                {key:"extStrDateString", label:"시작일", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.value.date().print();
                                	}
                                },
                                {key:"extEndDateString", label:"종료일", width:"100", align:"center"
                                	, formatter: function(){
                                		return this.value.date().print();
                                	}
                                },
                                {key:"addrPart", label:"관내외구분", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("addrPart", this.value);
                                	}
                                },
                                {key:"dcGubun", label:"감면구분", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("dcGubun", this.value);
                                	}
                                },
                                {key:"receiptGb", label:"수납구분", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("receiptGb", this.value);
                                	}
                                },
                                {key:"rentalfee", label:"사용료", width:"100", align:"center"
                                	, formatter:"money"
                                },
                                {key:"dcAmt", label:"감면액", width:"100", align:"center"
                                	, formatter:"money"
                                        },
                                {key:"charge", label:"부과액", width:"100", align:"center"
                                	, formatter:"money"
                                        },
                                {key:"cardAmt", label:"카드액", width:"100", align:"center"
                                	, formatter:"money"
                                        },
                                {key:"cashAmt", label:"현금액", width:"100", align:"center"
                                	, formatter:"money"
                                        },
                            ],
                            body : {
                                onclick: function(){
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    setPage: function(){
                    }
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
                                {key:"succDateString", label:"승계일자", width:"100", align:"center"},
                                {key:"applName", label:"신청자", width:"100", align:"center"},
                                {key:"succName", label:"승계자", width:"100", align:"center"},
                                {key:"deadRelation", label:"사망자와의 관계", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("applRelation", this.item.deadRelation) + " " + Common.str.ifNull(this.item.deadRelationNm, "");
                                	}
                                },
                                {key:"applRelation", label:"피승계자와의 관계", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("applRelation", this.item.applRelation) + " " + Common.str.ifNull(this.item.applRelationNm, "");
                                	}
                                },
                                {key:"hstReson", label:"승계사유", width:"100", align:"center"
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("dcGubun", this.value);
                                	}
                                }
                            ],
                            body : {
                                onclick: function(){
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    setPage: function(){
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
                        $("#info-ensNo").css({border : "#F39A0D 3px solid"});
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                      
                        Common.form.fillForm( 'info-',item);
                        //var info = $.extend({}, item);
                        //app.form.fillForm(_this.target, info, 'info-');
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
                formPayerApplicant: {
                    target: $('#form-info-payer-applicant'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info-payer-applicant"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-payer-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-payer-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    }
                },
                formEnsret: {
                    target: $('#form-info-return'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info-return"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-return-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-return-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    },
                    save: function(){
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1010/ensret",
                            data: Object.toJSON(fnObj.formEnsret.getJSON())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.message);
                        	}else
                            {
                                toast.push("저장하였습니다.");
                                fnObj.searchEnshrine.submit();
                            }
                        });
                    },
                    del: function(){
                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensret/"+Common.str.replaceAll($("#info-return-retDateString").val(), "-", "")
                            		+"/"+Common.str.replaceAll($("#info-return-retSeq").val(), "-", ""),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
                                $("#btn-return-new").click();
                            }
                        });
                    }
                }
                // form

            };
        </script>

    </ax:div>
</ax:layout>