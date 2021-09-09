<%@page import="java.net.InetAddress"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags"%>
<%
String[] activeProfiles = AppContextManager.getAppContext().getEnvironment().getActiveProfiles();

if(activeProfiles.length > 0){
	String ap = activeProfiles[0];
	String area = null;

	if(ap.contains("changwon")){
		area = "sangbok";
	}
	if(ap.contains("masan")){
		area = "masan";
	}
	if(ap.contains("jinhae")){
		area = "jinhae";
	}

	String paramArea = request.getParameter("area");

	if(StringUtils.isEmpty(paramArea)){
		request.setAttribute("area", area);
	}else{
		request.setAttribute("area", paramArea);
	}


}

InetAddress inet = InetAddress.getLocalHost();
String server = inet.getHostAddress();
request.setAttribute("server", server);
%>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
            a.selectedTextBox:focus {
            	border: 2px solid #58ACFA !important;
            }
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-button-group">
                    <div class="right">
                    	<button id="btn-search-ensret" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i> 반환자료검색</button>
                    	<button id="btn-search-thedead" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i> 화장자료검색</button>
                    	<button id="btn-move-couple-data" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i> 배우자계약으로 데이터이동</button>
                        <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-button-group">
                	<div class="left" style="width: 50%;">
		                <div class="ax-search" id="page-search-enshrine"></div>
                	</div>
                	<div class="right" style="width: 50%;">
		                <div class="ax-search" id="page-search-hwaCremation"></div>
                	</div>
                    <div class="ax-clear"></div>
                </div>
				<ax:form id="form-info" name="form-info" method="get">
					<input type="hidden" id="info-enshrine-ensDate" name="ensDate" value=""/>
					<input type="hidden" id="info-enshrine-ensSeq" name="ensSeq" value=""/>
					<input type="hidden" id="info-bookDate" name="bookDate" value=""/>
					<input type="hidden" id="info-bookDate" name="bookDate" value=""/>
                    <input type="hidden" id="info-bookChasu" name="bookChasu" value=""/>
                    <input type="hidden" id="info-bookChasuSeq" name="bookChasuSeq" value=""/>
                    <input type="hidden" id="info-cremDate" name="cremDate" value=""/>
                    <input type="hidden" id="info-cremSeq" name="cremSeq" value=""/>
                    <input type="hidden" id="info-feetypedivcd" name="feetypedivcd" value=""/>
                    <input type="hidden" id="info-beforeEnsNo" name="beforeEnsNo" value=""/>
                    <input type="hidden" id="info-enshrine-docYear" name="docYear" value=""/>
                    <input type="hidden" id="info-enshrine-docSeq" name="docSeq" value=""/>
                    <input type="hidden" id="info-enshrine-sendYn" name="sendYn" value=""/>
                    <input type="hidden" id="info-ensdead-realDate" name="realDate" value=""/>
                    <input type="hidden" id="info-ensdead-deadSeq" name="deadSeq" value=""/>
                    <input type="hidden" id="info-enshrine-remark" name="remark" value=""/>
                    <input type="hidden" id="info-thedead-familyClan" name="familyClan" value=""/>
                    <input type="hidden" id="info-thedead-company" name="company" value=""/>
                    <input type="hidden" id="info-thedead-bunmanwol" name="bunmanwol" value=""/>
                    <input type="hidden" id="info-thedead-sasansayu" name="sasansayu" value=""/>
                    <input type="hidden" id="info-thedead-boneGb" name="boneGb" value=""/>
                    <input type="hidden" id="info-thedead-openNtyDate" name="openNtyDate" value=""/>
                    <input type="hidden" id="info-thedead-fixgravereason" name="fixgravereason" value=""/>
                    <input type="hidden" id="info-thedead-deadDocGubun" name="deadDocGubun" value=""/>
                    <input type="hidden" id="info-thedead-deadDocno" name="deadDocno" value=""/>
                    <input type="hidden" id="info-thedead-deadDocnm" name="deadDocnm" value=""/>
                    <input type="hidden" id="info-thedead-deadRemark" name="deadRemark" value=""/>
                    <input type="hidden" id="info-thedead-deadFaith" name="deadFaith" value=""/>
                    <input type="hidden" id="info-thedead-deadFaithNm" name="deadFaithNm" value=""/>
                    <input type="hidden" id="info-applicant-smsFlg" name="smsFlg" value=""/>
                    <input type="hidden" id="info-applicant-applRemark" name="applRemark" value=""/>
                    <input type="hidden" id="info-applicant-applEmail" name="applEmail" value=""/>
                    <input type="hidden" id="info-thedead-deadBirth" name="deadBirth" value=""/>
                    <input type="hidden" id="info-thedead-transferDate" name="transferDate"></input>

					<input  type="hidden" id="info-thedead-addrCode" name="addrCode" class="AXSelect W180"></input>
	                <ax:custom customid="table">
	                    <ax:custom customid="tr">
								<ax:custom customid="td">
			                    <ax:fields>
	<%-- 				                        <ax:field label="봉안구역명" style="width:350px;">컬럼없음 --%>
	<!-- 				                            <select id="info-" name="" class="AXSelect W100"></select> -->
	<%-- 				                        </ax:field> --%>
			                        <ax:field label="봉안단구분*" style="width:500px;">
			                            <select id="info-enshrine-ensType" name="ensType" class="AXSelect W160"></select>
			                        </ax:field>
			                        <ax:field label="안치번호" style="width:500px;" >
				                        <input type="text" id="info-enshrine-ensNo" name="ensNo" title="봉안보관번호" placeholder="봉안보관번호" maxlength="20" class="AXInput W200 av-required" value="" readonly="readonly" />
				                        <button id="btn-search-ensNo" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
			                        </ax:field>
			                    </ax:fields>

			                	<div style="text-align: right;">
			                		<button type="button" class="AXButton" id="btn-ensdead-new"><i class="axi axi-plus-circle"></i> 신규</button>
			                		<button type="button" class="AXButton" id="btn-ensdead-del"><i class="axi axi-minus-circle"></i> 삭제</button>
			                	</div>
			                    <div id="div-grid-ensdead" style="height: 100px;"></div>
								<ax:fields >
				                    <ax:field label="사망자명*" style="width: 304px;">
										<input type="text" id="info-thedead-deadId" name="deadId" class="AXInput W40" value="" readonly="readonly"/>
				                        <input type="text" id="info-thedead-deadName" name="deadName" title="사망자명" placeholder="사망자명" maxlength="20" class="AXInput W80" value=""  />
				                    </ax:field>
				                    <ax:field label="주민등록번호" style="width: 220px;">
				                        <input type="text" id="info-thedead-deadJumin" name="deadJumin" title="주민등록번호" placeholder="주민등록번호" maxlength="14" class="AXInput W101" value=""  />
				                    </ax:field>
				                    <ax:field label="사망자성별" style="width: 234px;">
				                        <select id="info-thedead-deadSex" name="deadSex" class="AXSelect W100"></select>
				                    </ax:field>
				           		</ax:fields>
				           		<ax:fields >
				          			<ax:field label="감면대상구분" style="width: 304px;">
										<select id="info-ensdead-dcGubun" name="dcGubun" class="AXSelect W150"></select>
									</ax:field>
				                    <ax:field label="봉안대상구분" style="width: 220px;">
	                                       <select id="info-ensdead-objt" name="objt" title="봉안대상구분" class="AXInput W150" value="" ></select>
	                                </ax:field>
									<ax:field label="사망자국적구분" style="width: 200px;">
				                        <select id="info-thedead-deadNationGb" name="deadNationGb" class="AXSelect W90"></select>
				                        <input  name="gbNm" list="deadNationGbNm" id="info-thedead-deadNationGbNm" class="W90 AXSelect"  placeholder="외국인 국적"/>
										<datalist id="deadNationGbNm">
				                    </ax:field>

<%-- 				                    <ax:field label="생년월일" style="width: 194px;">
				                        <b:input id="info-thedead-deadBirth" name="deadBirth" clazz="W100" title="생년월일" value="" pattern="date"></b:input>
				                    </ax:field> --%>
				           		</ax:fields>
				           		<ax:fields>
				           			<ax:field label="사망자 주소" style="width: 960px;">
				           				<select id="info-thedead-deadAddrGubun" name="deadAddrGubun" class="AXSelect W50"></select>
				                        <input type="text" id="info-thedead-deadPost" name="deadPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
				                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
				                        <input type="text" id="info-thedead-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" class="AXInput av-required" style="width:340px;" value="" />
				               		    <input type="text" id="info-thedead-deadAddr2" name="deadAddr2" title="사망자 주소" placeholder="상세주소" class="AXInput" value="" style="width:40%;"  />
				               		</ax:field>

				           		</ax:fields>
				           		<ax:fields>
									<ax:field label="사망일/개장일" style="width: 304px;">
				                        <b:input id="info-thedead-deadDate" name="deadDate" clazz="W80" title="사망일자" pattern="date"></b:input>
				                        <input type="text" id="info-thedead-deadTime" name="deadTime" title="사망시간" placeholder="사망시간" maxlength="5" class="AXInput W70" value=""  />
				                    </ax:field>
									<ax:field label="사망장소" style="width: 220px;">
				                        <select id="info-thedead-deadPlace" name="deadPlace" class="AXSelect W130"></select>
				                        <b:input id="info-thedead-deadPlaceNm" title="사망장소" name="deadPlaceNm" style="width: 75px;"></b:input>
				                    </ax:field>
				                    <ax:field label="사망의종류" style="width:304px;">
				                 		<select id="info-thedead-deadReason" name="deadReason" class="W100 AXSelect"></select>
                                    	<input  name="nm" list="deadReasonNm" id="info-thedead-deadReasonNm" class="W100 AXSelect" />
										<datalist id="deadReasonNm">
										</datalist>
                                    </ax:field>
				           		</ax:fields>
				           		<ax:fields >
                                   	<ax:field label="관내/외구분" style="width: 304px;">
										<select id="info-ensdead-addrPart" name="addrPart" class="AXSelect W100"></select>
									</ax:field>
				           			<ax:field label="관내외사유" style="width: 220px;">
										<select id="info-ensdead-dcCode" name="dcCode" class="AXSelect W150"></select>
									</ax:field>
				               	</ax:fields>
				           		<ax:fields >
				           			<ax:field label="부과금액*" style="width: 304px;">
				           				<select id="info-ensdead-payGb" name="payGb" class="W50 AXSelect"></select>
										<input type="number" id="info-ensdead-charge" name="charge" title="부과금액" placeholder="부과금액" maxlength="15" class="AXInput W100 av-required" value="" readonly="readonly"/>
										<button type="button" class="AXButton" id="btn-calcPrice" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 계산</button>
	                               		<button type="button" class="AXButton" id="btn-receipt" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 정산</button>
	                               		<span id="sp-receipt-msg" style="color: red; font-weight: bolder;"></span>
									</ax:field>
									<ax:field label="사용료/관리비*" style="width: 220px;">
										<input type="number" id="info-ensdead-rentalfee" name="rentalfee" title="사용료" placeholder="사용료" maxlength="15" class="AXInput W90 av-required" value=""/>
										<input type="number" id="info-ensdead-mngAmt" name="mngAmt" title="관리비" placeholder="관리비" maxlength="15" class="AXInput W90 av-required" value=""/>
										<%-- <button id="btn-search-rentalfee" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i></button> --%>
									</ax:field>
									<ax:field label="감면금액" style="width: 234px;">
										<input type="number" id="info-ensdead-dcAmt" name="dcAmt" title="사용료감면금액" placeholder="사용료감면금액" maxlength="15" class="AXInput W90" value=""/>
										<input type="number" id="info-ensdead-dcMngAmt" name="dcMngAmt" title="관리비감면금액" placeholder="관리비감면금액" maxlength="15" class="AXInput W90" value=""/>
									</ax:field>
<%-- 									<ax:field label="수납금액" style="width:194px;"> --%>
                                		<input id="info-ensdead-calcCharge" name="calcCharge" type="hidden"  class="W80" placeholder="" maxlength="15"  readonly="readonly" title="수납금액">
                                		<input id="info-ensdead-part" name="part" type="hidden"  class="W80" placeholder="정산위치" maxlength="15"  readonly="readonly"  title="정산위치">
<%--                                 	</ax:field> --%>
				                </ax:fields>
				           		<ax:fields>
									<ax:field label="최초안치기간" style="width: 304px;">
										<input type="text" id="info-enshrine-strDate" name="strDate" title="최초허가기간" placeholder="최초허가기간" maxlength="15" class="AXInput W70 av-required" value=""/>
										<input type="text" id="info-enshrine-endDate" name="endDate" title="최초허가기간" placeholder="최초허가기간" maxlength="15" class="AXInput W70 av-required" value=""/>
									</ax:field>
									<ax:field label="현재안치기간" style="width: 220px;">
										<input type="text" id="info-enshrine-extStrDate" name="extStrDate" title="현재허가기간" placeholder="현재허가기간" maxlength="15" class="AXInput W70" value="" />
										<input type="text" id="info-enshrine-extEndDate" name="extEndDate" title="현재허가기간" placeholder="현재허가기간" maxlength="15" class="AXInput W70" value="" />
									</ax:field>
								</ax:fields>
								<ax:fields>
									<ax:field label="연장횟수" style="width: 304px;">
										<input type="number" id="info-enshrine-extCnt" name="extCnt" title="연장횟수" placeholder="연장횟수" maxlength="15" class="AXInput W100" value="0" readonly="readonly"/>
									</ax:field>
									<ax:field label="남은일수" style="width: 220px;">
										<input type="number" id="info-remain" name="remain" title="남은일수" placeholder="남은일수" maxlength="15" class="AXInput W100" value="" readonly="readonly"/>
									</ax:field>
									<ax:field label="상태">
										<select class="AXSelect" id="info-enshrine-useGubun" name="useGubun"></select>
									</ax:field>
								</ax:fields>
								<ax:fields>
				           			<ax:field label="특이사항">
										<input type="text" id="info-ensdead-remark" name="remark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 700px;" value=""/>
									</ax:field>
								</ax:fields>
								<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
				                	<div class="right">

										<input type="checkbox" name="reportUnit" value="ENSH1010_10" >
										<button type="button" class="AXButton" id="btn-reportENSH1010_10">신청서</button>
										<input type="checkbox" name="reportUnit" value="ENSH1010_1" >
										<button type="button" class="AXButton" id="btn-reportENSH1010_1">신고증</button>
										<input type="checkbox" name="reportUnit" value="ENSH1010_3" >
										<button type="button" class="AXButton" id="btn-reportENSH1010_3">봉안증명서</button>
										<input type="checkbox" name="reportUnit" value="ENSH1010_2" >
										<button type="button" class="AXButton" id="btn-reportENSH1010_2">영수증</button>
										<button type="button" class="AXButton" id="btn-print"><i class="axi axi-print"></i>인쇄</button>

				                	</div>
				                    <div class="ax-clear"></div>
				                </div>
				                <div class="ax-button-group op" id="div-check-panel" style="opacity: 0">
<!-- 				                <form> -->
								<div class="right">
									<label><input type="checkbox" name="reportUnit" class="AXCheckbox" value="0">&nbsp;&nbsp;&nbsp;&nbsp;<i class="axi axi-report"></i> 시설사용허가신청서</label>
									<label><input type="checkbox" name="reportUnit" class="AXCheckbox" value="1">&nbsp;&nbsp;&nbsp;&nbsp;<i class="axi axi-receipt"></i> 허가증</label>
									<label><input type="checkbox" name="reportUnit" class="AXCheckbox" value="2" >&nbsp;&nbsp;&nbsp;&nbsp;<i class="axi axi-report"></i> 봉안증명서</label>
									<label><input type="checkbox" name="reportUnit" class="AXCheckbox" value="3" >&nbsp;&nbsp;&nbsp;&nbsp;<i class="axi axi-certificate"></i> 영수증</label>
								</div>
<!-- 								</form> -->
								</div>

                       	</ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                        	<div id="div-tab"></div>
                        	<div id="div-content"></div>
                        	<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000;">
	                        	<div id="div-tab-content-A">
									<ax:fields>
										  <input type="hidden" id="info-beforeApplId" name="beforeApplId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
	                                        <input type="hidden" id="info-applicant-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100" value=""/>
	   							<%--  <ax:field label="신청자번호*" style="width:350px;">
	                                       <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
	                                    </ax:field> --%>
	                                    <ax:field label="신청자명*" style="width:304px;">
	                                        <input type="text" id="info-applicant-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" />
	                                    </ax:field>
	                                    <ax:field label="신청자 주민번호" style="width:480px;">
	                                    <input type="text" name="x" class="AXInput W130" id="ax-input-segment" />
	                                        <input type="text" id="info-applicant-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W101" value="" />
	                                   		<%-- <button type="button" class="AXButton" id="btn-search-applJumin"><i class='axi axi-ion-android-search'></i>중복조회</button> --%>
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="신청자국적" style="width:304px;">
	                                        <select id="info-applicant-nationGb" name="nationGb" class="AXSelect W100"></select>
	                                    </ax:field>
	                                    <ax:field label="신청자 주소*">
	                                        <select id="info-applicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
	                                        <input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
	                                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
	                                        <button type="button" class="AXButton" id="btn-same"><i class="axi axi-local-post-office"></i> 상동</button>
	                                        <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="신청자 주소"  placeholder="" class="AXInput W300 av-required" value=""/>
	                                        <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W300" value="" />
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="휴대폰*" style="width:304px;">
	                                        <input type="text" id="info-applicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
	                                        <input type="text" id="info-applicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
	                                        <input type="text" id="info-applicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
	                                    </ax:field>
	                                     <ax:field label="전화번호" style="width:350px;">
	                                        <input type="text" id="info-applicant-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
	                                        <input type="text" id="info-applicant-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                                        <input type="text" id="info-applicant-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                	<ax:field label="사망자와의 관계*" style="width:304px;">
	                                        <select id="info-enshrine-deadRelation" name="deadRelation" class="AXSelect W160"></select>
	                                        <input type="text" id="info-enshrine-deadRelationNm" name="deadRelationNm" title="사망자와의 관계" maxlength="6" placeholder="사망자와의 관계" class="AXInput W100" value=""/>
	                                    </ax:field>
	                                </ax:fields>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-list-applicant-addrhst"><i class="axi axi-list"></i> 주소변경이력</button>
					                	</div>
				                    	<div class="ax-clear"></div>
				                	</div>
	                        	</div>
	                        	<div id="div-tab-content-P">
	                        		<ax:fields>
	                        		  <input type="hidden" id="info-payer-applId" name="applId" title="납부자번호" placeholder="납부자번호"  maxlength="100" class="AXInput W100 " value=""/>
	                                <%--     <ax:field label="납부자번호*" style="width:350px;">
	                                        <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
	                                    </ax:field> --%>
	                                    <ax:field label="납부자명*" style="width:350px;">
	                                        <input type="text" id="info-payer-applName" name="applName" title="납부자명" placeholder="납부자명" maxlength="100" class="AXInput W100 " value="" />
	                                    </ax:field>
	                                    <ax:field label="납부자 주민번호" style="width:350px;">
	                                        <input type="text" id="info-payer-applJumin" name="applJumin" title="납부자 주민번호" placeholder="납부자 주민번호" maxlength="14" class="AXInput W100" value="" />
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="납부자국적" style="width:350px;">
	                                        <select id="info-payer-nationGb" name="nationGb" class="AXSelect W100"></select>
	                                    </ax:field>
	                                    <ax:field label="납부자 주소*">
	                                        <select id="info-payer-addrGubun" name="addrGubun" class="AXSelect W50"></select>
	                                        <input type="text" id="info-payer-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
	                                        <button type="button" class="AXButton" id="btn-payerpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
	                                        <input type="text" id="info-payer-applAddr1" name="applAddr1" title="납부자 주소" placeholder="" class="AXInput W200 " value=""/>
	                                        <input type="text" id="info-payer-applAddr2" name="applAddr2" title="납부자 주소" placeholder="상세주소" class="AXInput W400 " value="" />
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="휴대폰*" style="width:350px;">
	                                        <input type="text" id="info-payer-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 " value="" />
	                                        <input type="text" id="info-payer-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 " value="" />
	                                        <input type="text" id="info-payer-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 " value="" />
	                                    </ax:field>
	                                    <ax:field label="전화번호" style="width:350px;">
	                                        <input type="text" id="info-payer-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
	                                        <input type="text" id="info-payer-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                                        <input type="text" id="info-payer-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                                    </ax:field>
	                                </ax:fields>
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
	                        		<div id="div-grid-ret" style="height: 200px;"></div>
									<div class="ax-button-group" style="display: inline-block; width: 98.3%;">
					                	<div class="right">
					                		<button type="button" class="AXButton" id="btn-ensret"><i class="axi axi-plus-circle"></i> 반환</button>
					                		<button type="button" class="AXButton" id="btn-feeret-report"><i class="axi axi-report"></i> 사용료반환신청서</button>
					                		<button type="button" class="AXButton" id="btn-leadret-report"><i class="axi axi-report"></i> 유골인도신청서</button>
					                		<button type="button" class="AXButton" id="btn-ensret-report"><i class="axi axi-report"></i> 유골반출확인서</button>
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
				</ax:form>
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
            	hwaCremation : "",
				tab : "A",
                CODES: {
                    "ensType": Common.getCode("TFM10"),
                    "firstTab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
                      					],
                    "tab": [
	                       					{optionValue:"A", optionText:"신청자", closable:false},
	                      					//{optionValue:"P", optionText:"납부자", closable:false},
	                      					{optionValue:"E", optionText:"사용연장"},
	                      					{optionValue:"R", optionText:"반환처리"},
	                      					{optionValue:"C", optionText:"사용승계"},

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
                    "addrCode": Common.addr.getAddrCode(),
                    "part": (function(){
    	            	var result;
    		            	app.ajax({
    		            			async: false,
    		                        type: "POST",
    		                        url: "/FUNE0020/part",
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
                },
                pageStart: function(){

                    this.searchEnshrine.bind();
                    this.searchHwaCremation.bind();
                    this.bindEvent();

                    this.form.bind();
                    this.gridEnsdead.bind();
                    this.gridEnsext.bind();
                    this.gridEnsret.bind();
                    this.gridEnssucced.bind();
					this.defaultSearch();
                },
                defaultSearch: function(){
					var ensDate = "${param.ensDate}";
					var ensSeq = "${param.ensSeq}";

					 $("#info-thedead-deadPlace").val("TCM0900002");
					 $("#info-thedead-deadReason").val("TCM0300001"); //병사
					 $("#info-ensdead-objt").val("TFM0800001");

					if(ensDate.length == 0 || ensSeq.length == 0 || ensDate == 'undefined' || ensSeq == 'undefined'){
						$("#ax-form-btn-new").click();
					}else{
						Common.search.setValue(fnObj.searchEnshrine.target, "ensDate", ensDate);
						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", ensSeq);
						fnObj.searchEnshrine.submit();
						return;
					}
					var area = "${area}";
					var cremDate = "${param.cremDate}";
					var cremSeq = "${param.cremSeq}";
					if(cremDate.length == 0 || cremSeq.length == 0){
						$("#ax-form-btn-new").click();
					}else{
						Common.search.setValue(fnObj.searchHwaCremation.target, "area", area);
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremDate", cremDate);
						Common.search.setValue(fnObj.searchHwaCremation.target, "cremSeq", cremSeq);
						fnObj.searchHwaCremation.submit();
						return;
					}
                },
                tabs:{},
                eventFn: {
                	calcPrice: function(){
						//if($("#info-ensdead-addrPart").bindSelectGetValue().optionValue == "TCM1000001" && $("#info-thedead-transferDate").val() == ""
						//		&& ("#info-ensdead-objt").bindSeletcGetValue().optionValue != 'TFM0800005'){
						//	toast.push("주민등록등재일을 입력하세요.");
						//	return;
						//}
//                     	if($("#info-ensdead-calcCharge").val() > 0){
//                     		return false;
//                     	}
                		$.ajax({
                	        type:"GET",
                	        url: "/ENSH1010/price",
                	        data: "ensType="+$("#info-enshrine-ensType").bindSelectGetValue().optionValue
		                			+"&transferDate="+$("#info-thedead-transferDate").val()
		              				+"&dcGubun="+$("#info-ensdead-dcGubun").val()
		              				+"&addrPart="+$("#info-ensdead-addrPart").val()
		              				+"&objt="+$("#info-ensdead-objt").val()
		              				+"&dcCode="+$("#info-ensdead-dcCode").val(),
		              		dataType: "json",
                	        success:function(res){
                	        	if(res.error){
                            		alert(res.error.message);
                            	}else
                                {

                            		var isDam = function(){
                            			var ensNo = $("#info-enshrine-ensNo").val();
                            			return ensNo.substring(0,1) == "D"
                            		}

                            		var price = res.map.price;

                            		if(isDam() == true){
                            			price = price.price;
                            		}

                            		var pricelist = price.pricelist;
                            		var dcRate = price.dcRate;
                            		var mngAmt = price.mngPrice.charge;

                            		var now = price.now;
                            		var rentalfee = pricelist.charge;
                            		var dcAmt = pricelist.charge * dcRate.dcPercent / 100;
                            		var dcMngAmt = mngAmt * dcRate.dcPercent / 100;
                            		var charge = rentalfee+mngAmt - Number(dcAmt) - Number(dcMngAmt);

                            		$("#info-ensdead-rentalfee").val(rentalfee);
                            		$("#info-ensdead-mngAmt").val(mngAmt);
                            		$("#info-ensdead-dcMngAmt").val(dcMngAmt);
                            		$("#info-ensdead-dcAmt").val(dcAmt);
                            		$("#info-ensdead-charge").val(charge);
                            		$("#info-ensdead-dcCode").val(dcRate.dcCode);
                            		$("#info-enshrine-strDate").val(now);
                            		now = now.date();
                            		now.setFullYear(now.getFullYear()+(+pricelist.useTerm));
                            		now.setDate(now.getDate()-1)
                            		$("#info-enshrine-endDate").val(now.print());
                            		$("input[id^='info-ensdead']").change();
                            		$("input[id^='info-thedead']").change();
                            		$("select[id^='info-ensdead']").change();
                            		$("select[id^='info-thedead']").change();

                                }
                	        },
//                 	        beforeSend:showRequest,
                	        error:function(e){
                	            alert(e.responseText);
                	        }
                	    });


//                 		app.ajax({
//                 			async: false,
//                             type: "GET",
//                             url: "/ENSH1010/price",
//                             data: "ensType="+$("#info-enshrine-ensType").bindSelectGetValue().optionValue
//                             			+"&transferDate="+$("#info-thedead-transferDate").val()
//                           				+"&dcGubun="+$("#info-ensdead-dcGubun").bindSelectGetValue().optionValue
//                           				+"&addrPart="+$("#info-ensdead-addrPart").bindSelectGetValue().optionValue
//                         },
//                         function(res){

//                         });
                	}
                	, receipt: function(){

                		var ensSeq = $("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val()
                    	if(ensSeq.length <= 0){
                    		alert("접수자료 저장 후 정산처리 해주세요.");
                    		return false;
                    	}

                		if(fnObj.hwaCremation.length > 0){

                			for(var i=0; i<fnObj.hwaCremation.length; i++){
                				if(fnObj.hwaCremation[i].deadId == fnObj.gridEnsdead.target.getSelectedItem().item.deadId){
									alert("정산한 자료(장례식장, 화장)에서만 정산이 가능합니다.");
                					return false;
                				}
                			}

                		}

                    	app.modal.open({
    	                    url:"ENSH1010_4.jsp",
    	                    pars:"callBack=&deadId="+fnObj.gridEnsdead.target.getSelectedItem().item.deadId
    	                    		+"&deadSeq="+fnObj.gridEnsdead.target.getSelectedItem().item.deadSeq
    	                    		+ "&ensDate=" + $("#"+fnObj.searchEnshrine.target.getItemId("ensDate")).val()
    	                    		+ "&ensSeq=" + $("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val()
    	                    ,
    	                    width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
    	                    //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
               		  	});
                	}
                	, reportENSH1010_1: function(){
                			var parameters = [];
                			var list = fnObj.gridEnsdead.target.getList();
                			var ensNo = $("#info-enshrine-ensNo").val();
                			var reportName = "ENSH1010_1";
//                 			if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == 'TFM1000003'){
//                 				reportName = "ENSH1010_7";
//                 			}
                  			$.each(list, function(i,o){
                  				parameters.push({path: "/reports/changwon/ensh/"+reportName, parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}' })
               				});
                  			Common.report.mergePdfReport(parameters);

                	}
                	, reportENSH1010_3: function(){
                			var parameters = [];
                			var list = fnObj.gridEnsdead.target.getList();
                  			$.each(list, function(i,o){
                  				parameters.push({path: "/reports/changwon/ensh/ENSH1010_3", parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}'})
               				});
                  			Common.report.mergePdfReport(parameters);

                	}
                	, reportENSH1010_10: function(){
            			var parameters = [];
            			var list = fnObj.gridEnsdead.target.getList();
              			$.each(list, function(i,o){
              				parameters.push({path: "/reports/changwon/ensh/ENSH1010_10", parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}'})
           				});
              			Common.report.mergePdfReport(parameters);

            	}

                	, reportENSH1010_2: function(){

                		var parameters = [];
            			var list = fnObj.gridEnsdead.target.getList();
              			$.each(list, function(i,o){
              				parameters.push({path: "/reports/changwon/ensh/ENSH1010_2", parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+o.thedead.deadId+"&printName="+'${LOGIN_USER_ID}'})
           				});
              			Common.report.mergePdfReport(parameters);
                	}
                	, print: function(){
                		var parameters = [];
                		var list = fnObj.gridEnsdead.target.getList();
                		var ensNo = $("#info-enshrine-ensNo").val();
                		var reportName = "ENSH1010_1";
              			$.each($("input[name=reportUnit]:checked"), function(i,o){

              				$.each(list, function(j,v){

              					if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == 'TFM1000003' && $(o).val() == "ENSH1010_1"){
              						reportName =  "ENSH1010_7";
              					}else{
              						reportName = $(o).val();
              					}
                  				parameters.push({path: "/reports/changwon/ensh/"+reportName, parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+v.thedead.deadId+"&printName="+'${LOGIN_USER_ID}' })
               				});
              				//parameters.push({path: "/reports/changwon/ensh/"+$(o).val(), parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+$("#info-thedead-deadId").val()+"&printName="+'${LOGIN_USER_ID}'})
           				});

              			Common.report.mergePdfReport(parameters);
                	}
                	, ensret: function(){
						app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1018.jsp",
	                        pars:"callBack=fnObj.ensretModalResult&ensDate="+$("#info-enshrine-ensDate").val()
	                        		+"&ensSeq="+$("#info-enshrine-ensSeq").val()
	                        		+"&strDate="+$("#info-enshrine-extStrDate").val()
	                        		+"&endDate="+$("#info-enshrine-extEndDate").val()
	                        		,
	                        width:1400, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					}
                	, ensext: function(){

                		if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == "TFM1000004"){

                			toast.push("무연고는 연장할수 없습니다");
                			return false;
                		}
						app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1014.jsp",
	                        pars:"callBack=fnObj.esnextModalResult&ensDate="+$("#info-enshrine-ensDate").val()
	                        		+"&ensSeq="+$("#info-enshrine-ensSeq").val()
	                        		+"&deadId="+$("#info-thedead-deadId").val()
	                        		+"&strDate="+$("#info-enshrine-strDate").val()
	                        		+"&endDate="+$("#info-enshrine-endDate").val()
	                        		+"&ensNo="+$("#info-enshrine-ensNo").val()
	                        		,
	                        width:1400, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
					}
                	, enssucced: function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1015.jsp",
	                        pars:"callBack=fnObj.enssuccedModalResult&applId="+$("#info-applicant-applId").val()+"&ensDate="+$("#info-enshrine-ensDate").val()+"&ensSeq="+$("#info-enshrine-ensSeq").val()+"&ensType="+$("#info-enshrine-ensType").bindSelectGetValue().optionValue,
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                	}
                },
                bindEvent: function(){
                    var _this = this;

                    $('body').on('keydown', 'input, a', function(e) {
            		    var self = $(this)
            		      , form = self.parents('form:eq(0)')
            		      , focusable
            		      , next
            		      ;
            		    if (e.keyCode == 13) {
            		        focusable = form.find('input,a').filter(':visible');
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
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});
                	Common.grid.changeValueToGrid("info-ensdead-", fnObj.gridEnsdead.target);
                	Common.grid.changeValueToGrid("info-thedead-", fnObj.gridEnsdead.target, "thedead");

                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.del();
                        }, 500);
                    });

                    $("#btn-search-thedead").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem2000/CREM2021.jsp",
	                        pars:"callBack=fnObj.searchHwaCremationThedeadModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#btn-search-ensret").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1017.jsp",
	                        pars:"callBack=fnObj.searchEnsretModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#btn-search-ensNo").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp?ensType="+$("#info-enshrine-ensType").bindSelectGetValue().optionValue,
	                        pars:"callBack=fnObj.searchEnsNoModalResult",
	                        width: (window.innerWidth||1400)*0.9
	                        //width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });

                    $("#info-ensdead-objt").selectBox({
	                	basicCd: "TFM08"
	               		,async : false
	                });
                    $("#info-enshrine-useGubun").selectBox({
	                	basicCd: "HE_STATUS"
	               		,async : false
	                });
                    $("#info-ensdead-payGb").selectBox({
	                	basicCd: "TMC15"
	               		,async : false
	                });
                    $("#info-thedead-deadReason").selectBox({
	                	basicCd: "TCM03"
	                	,async : false
	                });
                    $('#info-applicant-mobileno1').on('keyup', function() {
                        if(this.value.length == 3) {
                           $('#info-applicant-mobileno2').focus()
                        }
                    });
                    $('#info-applicant-mobileno2').on('keyup', function() {
                        if(this.value.length == 4) {
                           $('#info-applicant-mobileno3').focus()
                        }
                    });
                    $('#info-applicant-telno1').on('keyup', function() {
                        if(this.value.length == 3) {
                           $('#info-applicant-telno2').focus()
                        }
                    });
                    $('#info-applicant-telno2').on('keyup', function() {
                        if(this.value.length == 4) {
                           $('#info-applicant-telno3').focus()
                        }
                    });

                	$("#info-ensdead-objt").val("TFM0800001");

/*                     $("#info-thedead-deadFaith").bindSelect({
                        options:fnObj.CODES.deadFaith
                        ,isspace: true
                        ,setValue:""
                    }); */

        	        /* $("#info-thedead-addrCode").selectBox({
                  		url: "/CREM2010/addrCode/option"
                		, isspace: true
             			, isspaceTitle: ""
           				, reserveKey: {
               				 optionValue: "optionValue"
               				, optionText: "optionText"
               			}
                    	,async : false
	                }); */

                    $("#info-ensdead-objt").change(function(){
						var infoObjt = $("#info-ensdead-objt").val();
						var deadReason  = $("#info-thedead-deadReason").val();
						var deadPlace  = $("#info-thedead-deadPlace").val();
						if(typeof fnObj.gridEnsdead.target.getSelectedItem().item != 'undefined'){
							deadReason = fnObj.gridEnsdead.target.getSelectedItem().item.thedead.deadReason;
							deadPlace = fnObj.gridEnsdead.target.getSelectedItem().item.thedead.deadPlace;
						}
					    if(infoObjt == "TFM0800001" || infoObjt == "TFM0800002" || infoObjt == "TFM0800005" ){

					    	$("#info-thedead-deadReason").selectBox({
								url: "/api/v1/basicCodes/deadReason/option"
								,reserveKeys: {
									 optionValue: "optionValue"
				               		, optionText: "optionText"
                    			}
								,async : false
                			});

					    	$("#info-thedead-deadPlace").selectBox({
								url: "/api/v1/basicCodes/deadPlace/option"
								,reserveKeys: {
									 optionValue: "optionValue"
				               		, optionText: "optionText"
                    			}
								,async : false
                			});


					    	//$("#info-thedead-deadPlace").
						}else{
							//alert("gkgkkgk");
							$("#info-thedead-deadReason").selectBox({
								url: "/api/v1/basicCodes/deadReasonB/option"
								,reserveKeys: {
									 optionValue: "optionValue"
				               		, optionText: "optionText"
                    			}
								,async : false
                			});

							$("#info-thedead-deadPlace").selectBox({
								url: "/api/v1/basicCodes/deadPlaceB/option"
								,reserveKeys: {
									 optionValue: "optionValue"
				               		, optionText: "optionText"
                    			}
								,async : false
                			});
						}
					    if(deadReason != "" || deadPlace != ""){
					    	$("#info-thedead-deadReason").val(deadReason);
						    $("#info-thedead-deadPlace").val(deadPlace);
					    }
					});

                	$("#info-ensdead-objt").change();


                     for (var i = 0; i < fnObj.CODES.accidentReason.length; i++) {
                        $('#deadReasonNm').append("<option value='" + fnObj.CODES.accidentReason[i].name +"'>");
                    }

                     for (var i = 0; i < fnObj.CODES.deadNationGbNm.length; i++) {
                         $('#deadNationGbNm').append("<option value='" + fnObj.CODES.deadNationGbNm[i] +"'>");
                     }

                    $("#info-thedead-deadAddr1").bind("change",function(){
                    	var index = fnObj.gridEnsdead.target.getSelectedItem().index;
                    	Common.addr.getAddrPart(this.value, "info-thedead-addrCode", "info-ensdead-addrPart",true,index);
                    });


                    $("#info-ensdead-dcGubun").selectBox({
	                	basicCd: "TCM12"
	               		,async : false
	                });

                    $("#info-ensdead-addrPart").selectBox({
	                	basicCd: "TCM10"
	                	,async : false
	                });

                    $("#info-thedead-deadNationGb").selectBox({
	                	basicCd: "TCM04"
	                	,val : "TCM0400001"
	                	,async : false
	                });


                    //$("#info-thedead-deadJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                    $("#info-thedead-deadJumin").bind("change",function(){
                		if(this.value.length >= 8 ){

                			var female = "0,2,4,6,8";
                			var male = "1,3,5,7,9";

                				if(female.indexOf(this.value.substring(7,8)) != -1){
                					  $("#info-thedead-deadSex").val("TCM0500002");
                					  $("#info-thedead-deadSex").change();
                				}else if(male.indexOf(this.value.substring(7,8)) != -1){
                					$("#info-thedead-deadSex").val("TCM0500001");
                					$("#info-thedead-deadSex").change();
                				}

                        	    $("#info-thedead-deadBirth").val(Common.str.toBirth(this.value).date().print("yyyy-mm-dd"));
                        	    $("#info-thedead-deadBirth").blur();

                        }else{
                        	 $("#info-thedead-deadSex").val("TCM0500003");
                             $("#info-thedead-deadBirth").val("");
                             $("#info-thedead-deadSex").change();
                        }

               		 });

                     $("#info-thedead-deadJumin").keyup(function() {
                     	if(this.value.length >= 8 ){
                     		$(this).val(Common.str.replaceAll($("#info-thedead-deadJumin").val(), "-", "").substring(0,6)+"-"+Common.str.replaceAll($("#info-thedead-deadJumin").val(), "-", "").substring(6,13));
                     		//$("#info-thedead-deadJumin").change();
                     	}
 					});



                     $("#info-thedead-deadSex").selectBox({
 	                	basicCd: "TCM05"
 	               		,async : false
 	                });
                    //$("#info-thedead-deadDate").bindDate();
                    //$("#info-thedead-deadBirth").bindDate();
                   /*  $("#info-thedead-deadPlace").selectBox({
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

                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-thedead-deadPost", "info-thedead-deadAddr1", "info-thedead-deadAddr2");
                    });

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

                    $("#btn-ensdead-new").bind("click", function(){
                    	var listLimit;
                    	var ensTypeName;
                    	if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == fnObj.CODES.ensType[0].optionValue){//개인
                    		listLimit = 1;
                    		ensTypeName = fnObj.CODES.ensType[0].optionText;
                    	}else if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == fnObj.CODES.ensType[1].optionValue){//부부
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
	                   	$("#form-info input[id^='info-thedead']").val("");
						$("#form-info input[id^='info-ensdead']").val("");
						$("#form-info select[id^='info-ensdead']").find("option:eq(0)").prop("selected", true);
						$("#form-info select[id^='info-thedead']").find("option:eq(0)").prop("selected", true);
						$("#form-info input[id^='info-thedead']").change();
						$("#form-info input[id^='info-ensdead']").change();

                    });
                    $("#btn-ensdead-del").bind("click", function(){
                    	if(fnObj.gridEnsdead.target.list.length <= 1){
                    		alert("1개 이하 고인데이터는 삭제할 수 없습니다.");
                    		return;
                    	}

                    	var item = fnObj.gridEnsdead.target.getSelectedItem().item;
                    	if(
                    		!item.ensDate || item.ensDate.length == 0
                    		|| !item.ensSeq || item.ensSeq.length == 0
                    		|| !item.deadSeq || item.deadSeq.length == 0
                    		){
                    		fnObj.gridEnsdead.target.removeListIndex([fnObj.gridEnsdead.target.getSelectedItem()]);
                            toast.push("삭제되었습니다.");
                    		return;
                    	}
                    	if(!confirm(item.thedead.deadName+"님의 봉안자료를 삭제하시겠습니까?")){
                    		return;
                    	}
                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensdead/"+item.ensDate+"/"+item.ensSeq+"/"+item.deadSeq,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
        						Common.search.setValue(fnObj.searchEnshrine.target, "ensDate", item.ensDate);
        						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", item.ensSeq);
        						fnObj.searchEnshrine.submit();
                            }
                        });
                    });
                    $("#info-enshrine-ensType").bindSelect({
        				options:fnObj.CODES.ensType
        			});
                    $("#info-enshrine-ensType").bind("change", function(e){
                    	var limits = [1,2,999];
                    	var listLimit = limits[
	                    	                       (function(){
	                    	                    	   var index;
	                    	                    	   fnObj.CODES.ensType.map(function(obj, idx){
	                    	                    		   if(obj.optionValue == $("#info-enshrine-ensType").bindSelectGetValue().optionValue){
	                    	                    			   index = idx;
	                    	                    			   return;
	                    	                    		   }
	                    	                    	   })
	                    	                    	   return index;
	                    	                       }())
                    	                       ];

                    	if(fnObj.gridEnsdead.target.list.length > listLimit){
                    		toast.push($(this).bindSelectGetValue().optionText+"은 최대 "+listLimit+"명의 고인만 등록 가능합니다.");
                    		$(this).bindSelectSetValue($("#info-enshrine-ensType").attr("oldValue"));
                    	}
                    	$("#info-enshrine-ensType").attr("oldValue", $("#info-enshrine-ensType").bindSelectGetValue().optionValue);
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
                 /*    $("#form-info [id^='info-dead'], #info-ensdead-objt, #info-thedead-addrCode").bind("blur",function(){
                    	var item = fnObj.gridEnsdead.target.getSelectedItem();
                    	if(item.error){
                    		return;
                    	}
                    	var name = this.getAttribute("name");
                    	item.item[name] = $(this).val();
                    	fnObj.gridEnsdead.target.updateList(item.index, item.item);


                    }); */

//                     $("#form-info [id^='info-dead'], #info-ensdead-objt, #info-thedead-addrCode").bind("change",function(){
//                     	var item = fnObj.gridEnsdead.target.getSelectedItem();
//                     	if(item.error){
//                     		return;
//                     	}

//                     	var name = this.getAttribute("name");
//                     	item.item[name] = $(this).val();
//                     	item.item['objt'] = $("#info-ensdead-objt").bindSelectGetValue().optionValue;
//                     	fnObj.gridEnsdead.target.updateList(item.index, item.item);


//                     });


                    $("#btn-search-thedead").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1011.jsp",
	                        //pars:"callBack=fnObj.searchThedeadModalResult&deadId="+$("#info-thedead-deadId").val(),
	                        pars:"callBack=fnObj.searchThedeadModalResult&cremDate="+Common.search.getValue(fnObj.searchEnshrine.target, "ensDate")+"&deadId="+$("#info-thedead-deadId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                    $("#btn-search-rentalfee").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1017.jsp",
	                        pars:"callBack=fnObj.searchRentalfeeModalResult&jobGubun=E&priceGubun=U&objt="+$("#info-enshrine-ensType").bindSelectGetValue().optionValue,
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
 /*                    $("#info-enshrine-endDate").bindTwinDate({
                        startTargetID: "info-enshrine-strDate",
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
                    }); */
	              	$("#info-enshrine-extEndDate").bindPattern({pattern: "custom", max_length: 10, patternString:"9999-99-99"});
	               	$("#info-enshrine-extStrDate").bindPattern({pattern: "custom", max_length: 10, patternString:"9999-99-99"});


                  	$("#info-applicant-addrGubun").selectBox({
	                	basicCd: "TCM07"
	                	,async : false
	                });

	                $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
	                   });

	                $("#btn-payerpost").bind("click", function(){
	                   	daumPopPostcode("info-payer-applPost", "info-payer-applAddr1", "info-payer-applAddr2");
	                   });
	                $("#info-applicant-nationGb").selectBox({
	                	basicCd: "TCM11"
	                	,val : "TCM1100001"
	               		,async : false
	                });

	                $("#info-enshrine-deadRelation").selectBox({
	                	basicCd: "TCM08"
	                	,val : "TCM0800004"
	               		,async : false
	                });

	                   $("#btn-search-applicant").bind("click", function(){

	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1012.jsp",
	                        pars:"callBack=fnObj.searchApplicantModalResult&applId="+$("#info-applicant-applId").val(),
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
	                   });
                	//$("#info-payer-applJumin").bindPattern({pattern: "custom", max_length: 14, patternString:"999999-9999999"});
                    $("#info-payer-addrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                    $("#btn-applpost",$("#div-tab-content-P")).bind("click", function(){
                    	daumPopPostcode("info-payer-applPost", "info-payer-applAddr1", "info-payer-applAddr2");
                    });
                    $("#info-payer-nationGb").bindSelect({
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
					$("#btn-list-applicant-addrhst").bind("click",function(){
	                    app.modal.open({
	                        url:"/jsp/funeralsystem/ensh0000/ensh1000/ENSH1013.jsp",
	                        pars:"callBack=fnObj.addrhstModalResult&applId="+$("#info-applicant-applId").val(),
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


					$("#info-thedead-deadTime").bindPattern({pattern: "custom", max_length: 5, patternString:"99:99:99"});

					$("#info-ensdead-rentalfee, #info-ensdead-mngAmt, #info-ensdead-dcAmt, #info-ensdead-dcMngAmt").bind("keyup", function(){
						$("#info-ensdead-charge").val((Number(Common.str.replaceAll($("#info-ensdead-rentalfee").val(), ",", ""))
								+Number(Common.str.replaceAll($("#info-ensdead-mngAmt").val(), ",", ""))
								-Number(Common.str.replaceAll($("#info-ensdead-dcAmt").val(), ",", ""))
								-Number(Common.str.replaceAll($("#info-ensdead-dcMngAmt").val(), ",", ""))
								));
						$("#info-ensdead-charge").change();
					});

					/* $("#info-cashAmt, #info-cardAmt").bind("keyup", function(){
						var charge = $("#info-ensdead-charge").val();
						var ids = ["info-cashAmt", "info-cardAmt"];
						var _this = this;
						ids.forEach(function(val){

							if(val == $(_this).attr("id")){
								$("#"+val).val(+$(_this).val());
							}else{
								$("#"+val).val(+charge-$(_this).val());
							}
						});
					}) */
                    $('#ax-form-btn-new').click(function() {
                    	fnObj.gridEnsdead.target.setData({list:[{thedead:{}}]});
                        fnObj.gridEnsdead.target.setFocus(0);
                    	fnObj.form.clear();
                        fnObj.formApplicant.clear();
                       	$("#div-tab").updateTabs(fnObj.CODES.firstTab);
						$("#div-contents").append($("[id^='div-tab-content-']"));
						$("#div-content").append($("#div-tab-content-A"));
						Common.search.setValue(fnObj.searchEnshrine.target, "ensDate", new Date().print());
						Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", "");

						fnObj.gridEnssucced.target.setData({list:[]});
						fnObj.gridEnsext.target.setData({list:[]});
						fnObj.gridEnsret.target.setData({list:[]});
						$("#info-enshrine-ensType").change();
						$("#info-thedead-deadPlace").val("TCM0900002");
						$("#info-enshrine-deadRelation").val("TCM0800004");
						$("#info-thedead-deadReason").val("TCM0300001"); //병사
						$("#info-thedead-transferDate").val("");

                    });

                    $("#btn-ensret-report").bind("click", function(){
                    	var parameters = [];
            			var list = fnObj.gridEnsret.target.getList();
              			$.each(list, function(i,o){
              				//parameters.push({path: "/reports/changwon/ensh/ENSH1010_8", parameter: fnObj.searchEnshrine.target.getParam()+"&deadId="+o.deadId+"&printName="+'${LOGIN_USER_ID}'});
              				parameters.push({path: "/reports/changwon/ensh/ENSH1015_2", parameter: "retDate="+o.retDate+"&retSeq="+o.retSeq+"&deadId="+o.deadId+"&printName="+'${LOGIN_USER_ID}'});
           				});
              			Common.report.mergePdfReport(parameters);

						//if($("#info-enshrine-ensType").bindSelectGetValue().optionValue == "TFM1000004"){
						//	Common.report.open("/reports/changwon/ensh/ENSH1015_2", "pdf", params.join("&"));
						//}else{
						//	Common.report.open("/reports/changwon/ensh/ENSH1015_2", "pdf", params.join("&"));
						//}

                    });

                    $("#btn-feeret-report").bind("click", function(){
                    	var parameters = [];
            			var list = fnObj.gridEnsret.target.getList();
              			$.each(list, function(i,o){
              				parameters.push({path: "/reports/changwon/ensh/ENSH1015_5", parameter: "retDate="+o.retDate+"&retSeq="+o.retSeq+"&deadId="+o.deadId+"&printName="+'${LOGIN_USER_ID}'});
           				});
              			Common.report.mergePdfReport(parameters);
                    });

                    $("#btn-leadret-report").bind("click", function(){
                    	var parameters = [];
            			var list = fnObj.gridEnsret.target.getList();
              			$.each(list, function(i,o){
              				parameters.push({path: "/reports/changwon/ensh/ENSH1015_4", parameter: "retDate="+o.retDate+"&retSeq="+o.retSeq+"&deadId="+o.deadId+"&printName="+'${LOGIN_USER_ID}'});
           				});
              			Common.report.mergePdfReport(parameters);
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

                    $("input[name='ensSeq']").keydown(function (key) {
                        if(key.keyCode == 13){
                        	var ensDate = Common.str.replaceAll($("#"+fnObj.searchEnshrine.target.getItemId("ensDate")).val(), "-", "");
                        	var ensSeq = $("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val();
        					if(ensDate.length == 0 || ensSeq.length == 0){
        						alert("순번을 입력해주세요.")
        					}else{
        						fnObj.searchEnshrine.submit();
        						return
        					}
                        }
                    });

                    $("#ax-input-segment").bindSegment({
            			options:[
            				{optionValue:0, optionText:"주민번호"},
            				{optionValue:1, optionText:"사업자번호"},
            			],
            			onchange:function(){
            				//this.targetID, this.options, this.selectedIndex, this.selectedOption
            				//console.log(this);
            				if(this.selectedIndex == 0){
            					 $("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});


            				}else{
            					$("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 10, patternString:"999-99-99999"});

            				}
            				$("#info-applicant-applJumin").change();

            			}
            		});
                    $("#ax-input-segment").setValueInput(0);

        			 $("#info-ensdead-dcCode").selectBox({
		                	url: "/ENSH1010/dcCode"
	                		, isspace: true
							, isspaceTitle: ""
	            			, method: "get"
	            			, reserveKey: {
	            				optionRoot: ""
	            				, optionValue: "optionValue"
	            				, optionText: "optionText"
	            			}
        			 		,async : false
		                });

        			$("#info-enshrine-extStrDate").bind("change",function(){
        				$("#info-remain").val($("#info-enshrine-extStrDate").val().date().diff($("#info-enshrine-extEndDate").val().date())+0);
                    });

        			//$("#info-ensdead-dcCode").change(function(){
						//fnObj.eventFn.calcPrice();
        			//});
        			if("${area}" == "sangbok"){
	        			$("#info-enshrine-ensNo").bind("dblclick", function(){
	        				app.ajax({
	                            type: "GET",
	                            url: "/ENSH1010/ens-no",
	                            data: "ensType="+$("#info-enshrine-ensType").val()
	                        },
	                        function(res){
	                        	if(res.error){
	                        		alert(res.error.message);
	                        	}else{
	                        		$("#info-enshrine-ensNo").val(res.map.ensNo)
	                        	}
	                        })
	        			})
        			}

        			$("#btn-move-couple-data").bind("click", function(){

        				app.modal.open({
	                        url:"/jsp/funeralsystem/crem0000/crem2000/CREM2010_2.jsp",
	                        pars:"callBack=fnObj.moveCoupleModalResult",
	                        width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
        			})
                },

                getEnsKeyParameter: function(){
                 	var params = [];
                	var ensDate = Common.str.replaceAll(Common.search.getValue(fnObj.searchEnshrine.target, "ensDate"), "-", "");
                	var ensSeq = Common.search.getValue(fnObj.searchEnshrine.target, "ensSeq");
                	var deadId = $("#info-thedead-deadId").val();

                	if(ensDate ==  "" || ensSeq == ""  || deadId == ""){

                		return;
                	}

                	params.push("ensDate="+ensDate);
            		params.push("ensSeq="+ensSeq);
            		params.push("deadId="+deadId);

               		return params;
               	},
                report: {
                	"/reports/ensh/ENSH1012": function(){
                   		return fnObj.getEnsKeyParameter();
                   	}
                	, "/reports/ensh/ENSH1014": function(){
                   		return fnObj.getEnsKeyParameter();
                   	}
                	, "/reports/ensh/ENSH1015": function(){
                   		return fnObj.getEnsKeyParameter();
                   	}
                	, "/reports/ensh/ENSH1016_2": function(){
                   		return fnObj.getEnsKeyParameter();
                   	}
                	, getParam: function(reportUnit){
                		var params = this[reportUnit]();
                		return params.join("&");
                	}
                	, getReportUnits: function(){
//                 		reportParams.push({path:"/reports/crem/CREM2012", parameter: params.join("&")});
//                     	if($("#info-ensdead-objt :selected").val() == 'TMC0300003'){
//                     		reportParams.push({path:"/reports/crem/CREM2011_2", parameter: params.join("&")});
//                     	}else{
//                     		reportParams.push({path:"/reports/crem/CREM2011_1", parameter: params.join("&")});
//                     	}

                    	var reports = [];
                    	$("input[name='reportUnit']:checked").each(function(i, p){reports.push(p.value)});

                    	var reportUnits = [];
                    	reports.forEach(function(o, i){
	                    	switch (+o) {
							case 0:
								reportUnits.push("/reports/crem/CREM2014");
								break;
							case 1:
								reportUnits.push("/reports/crem/CREM2013");
								break;
							case 2:
								if($("#info-ensdead-objt :selected").val() == 'TMC0300003'){
									reportUnits.push("/reports/crem/CREM2011_2");
		                    	}else{
		                    		reportUnits.push("/reports/crem/CREM2011_1");
		                    	}
								break;
							case 3:
								reportUnits.push("/reports/crem/CREM2012");
								break;

							default:
								break;
							}
                   		});
                    	return reportUnits;
                	}
                	, mergePdf: function(reportUnits){
                		if(!reportUnits){
                			reportUnits = this.getReportUnits();
                		}
               			var reportParams = [];
               			var _this = this;
                		reportUnits.forEach(function(o, i){
                        	reportParams.push({path:o, parameter: _this[o]().join("&")});
                		});
                       	Common.report.mergePdfReport(reportParams);
                	}
                },
                isNewApplicant: function(){
                	var applJumin = $("#info-applicant-applJumin").val();
					if($("#inputBasic_AX_ax-input-segment_AX_SegmentHandle_AX_0").hasClass("on") == true){

                		if(!Common.str.juminChk(applJumin)){
                    		alert("유효하지 않는 주민번호입니다. \n 다시 확인하시고 입력해 주세요");
                    		$("#info-applicant-applJumin").focus();
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
                    			if($("#info-applicant-applId").val() == ""){
                    				toast.push("중복된 신청자가 존재하지 않습니다.");
                    				return;
                    			}
								if($("#info-applicant-applId").val() !="" && confirm("신청자를 변경하시겠습니까? 신청자 정보가 초기화 됩니다.")){
									$("#form-info-applicant [id^='info-appl'][id!='info-applicant-applJumin']").val("");
									$("#info-applicant-addrGubun").val("TCM0700001");
									return;
								}
							}else{
								var newApplId = res.map.applicantVTO.applId;
								//if(($("#info-enshrine-ensSeq").val() =="" || newApplId != $("#info-applicant-applId").val()) && !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
								if(($("#info-applicant-applId").val() =="" || newApplId != $("#info-applicant-applId").val()) && !confirm("중복된 신청자가 존재합니다. 등록된 신청자를 불러오시겠습니까?")){
			                		return;
			                	}

								 Common.form.fillForm('info-applicant-', res.map.applicantVTO, true);
								 $("#info-applicant-applJumin").blur();
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
                	if(fnObj.gridEnsdead.target.getSelectedItem().index > 0){
                		return false;
                	}
                	app.ajax({
                        type: "GET",
                        url: "/ENSH1010/pricelist/"+$("#info-enshrine-ensType").bindSelectGetValue().optionValue+"/"+$("#info-ensdead-addrPart").val()+"/"+$("#info-ensdead-dcGubun").val(),
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

                    		if(fnObj.isNew()){
                    	   		$("#info-ensdead-rentalfee").val(res.map.generalPricelist.charge);
                        		$("#info-ensdead-dcAmt").val(res.map.dcAmt);
                        		$("#info-ensdead-charge").val(res.map.pricelist.charge);
                        		$("#info-cashAmt").val(res.map.pricelist.charge);

                        		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                    			var now = new Date();
                        		$("#info-enshrine-strDate").val(now.print());
                        		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                        		now.setDate(now.getDate()-1);
                        		$("#info-enshrine-endDate").val(now.print());
                        	}
                        }
                    });
                },
                save: function(){
                	if($("#info-enshrine-useGubun").val() == "R"){
                		alert("반환된 자료는 수정이 불가능 합니다.");

 						return;
 					}
                	if($("#info-enshrine-ensSeq").val() != "" &&  !confirm("저장하시겠습니까?")){

 						return;
 					}
                	var validateResult = fnObj.form.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    app.ajax({
                        type: "PUT",
                        url: "/ENSH1010/enshrine",
                        data: Object.toJSON(fnObj.form.getJSON())
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else if(res.map.error){
                            Common.message.validError(res.map.error);
                        }
                        else
                        {
                            toast.push("저장되었습니다.");
                            var prarms = "";
                            if(res.map.ensDate){
                            	$("#info-enshrine-ensDate").val(res.map.ensDate);
                            	 Common.search.setValue(fnObj.searchEnshrine.target, "ensDate", res.map.ensDate);
                            	 prarms=  "?ensDate="+res.map.ensDate;
                            }
                            if(res.map.ensSeq){
                            	$("#info-enshrine-ensSeq").val(res.map.ensSeq);
                            	 Common.search.setValue(fnObj.searchEnshrine.target, "ensSeq", res.map.ensSeq);
                            	 prarms+= "&ensSeq="+res.map.ensSeq;

                            }
                            if(location.href.indexOf("?") != -1){
                    			location.href=location.href.substring(0,location.href.indexOf("?"))+prarms;
                    		}else{
                    			location.href=location.href+prarms;
                    		}


                            //fnObj.searchEnshrine.submit();
//                             fnObj.form.clear();
                        }
                    });
                },
                del: function(){
                	if(!confirm("봉안접수 자료를 삭제하시겠습니까?")){
                		return;
                	}
                	var list = fnObj.gridEnsdead.target.getList();

                	app.ajax({
                        type: "DELETE",
                        url: "/ENSH1010/enshrine/"+$("#info-enshrine-ensDate").val()+"/"+$("#info-enshrine-ensSeq").val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                            toast.push("삭제되었습니다.");
                            if(location.href.indexOf("?") != -1){
                    			location.href=location.href.substring(0,location.href.indexOf("?"));
                    		}
                            //$("#ax-form-btn-new").click();
                        }
                    });
                },
                moveCoupleModalResult: function(enshrine){

                	var fromDeadName = $("#info-thedead-deadName").val();
                	var toDeadName = enshrine.deadName;

                	if(!confirm(fromDeadName + " 고인과 " + toDeadName + " 고인의 자료를 합치겠습니까?")){
                		return;
                	}

                	var fromEnsDate = $("#info-enshrine-ensDate").val();
                	var fromEnsSeq = $("#info-enshrine-ensSeq").val();

                	var toEnsDate = enshrine.ensDate;
                	var toEnsSeq = enshrine.ensSeq;

                	app.ajax({
                        type: "POST",
                        url: "/ENSH1010/move/couple/data",
                        data: JSON.stringify({fromEnsDate: fromEnsDate, fromEnsSeq: fromEnsSeq, toEnsDate: toEnsDate, toEnsSeq: toEnsSeq})
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                    		if(location.href.indexOf("?") != -1){
                    			location.href=location.href.substring(0,location.href.indexOf("?"))+"?ensDate="+toEnsDate+"&ensSeq="+toEnsSeq;
                    		}else{
                    			location.href=location.href+"?ensDate="+toEnsDate+"&ensSeq="+toEnsSeq;
                    		}
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
                    		alert(res.error.message);
                    	}else{
                    		if(res.map.pricelist == null){
                    			toast.push("사용료가 등록되지 않았습니다.");
                    			return;
                    		}
                    		$("#info-ensdead-rentalfee").val(res.map.pricelist.charge);
                    		$("#info-ensdead-dcAmt").val(res.map.dcAmt);
                    		$("#info-ensdead-charge").val(res.map.pricelist.charge);
                    		$("#info-cashAmt").val(res.map.pricelist.charge);

                    		if(fnObj.isNew()){
                    			var now = new Date();
                        		$("#info-enshrine-strDate").val(now.print());
                        		now.setFullYear(now.getFullYear()+res.map.pricelist.useTerm);
                        		now.setDate(now.getDate()-1);
                        		$("#info-enshrine-endDate").val(now.print());
                    		}


                    		$("#info-feetypedivcd").val(res.map.pricelist.feetypedivcd);
                        }
                    });


//             		$("#info-ensdead-rentalfee").val(item.charge);
//             		$("#info-ensdead-dcAmt").val(0);
//             		$("#info-ensdead-charge").val(item.charge);
//             		$("#info-cashAmt").val(item.charge);

//             		var now = new Date();
//             		$("#info-enshrine-strDate").val(now.print());
//             		now.setFullYear(now.getFullYear()+item.useTerm);
//             		now.setDate(now.getDate()-1);
//             		$("#info-enshrine-endDate").val(now.print());

            		app.modal.close();
                },
                searchHwaCremationThedeadModalResult : function(hwaCremation){
                	var size = fnObj.gridEnsdead.target.getList().length;

                	 var objt = {"TMC0300001" : "TFM0800001"
        				 , "TMC0300003" : "TFM0800004"
        				 , "TMC0300007" : "TFM0800005"
        				 };
                	 $("#info-ensdead-objt").val(objt[hwaCremation.objt]);
                	 $("#info-ensdead-dcGubun").val(hwaCremation.dcGubun);

                	// 화장자료를 검색하여 고인자료를 불러오는경우 신규로 본다.
               		delete hwaCremation.thedead.deadId;

                	Common.form.fillForm("info-ensdead-", hwaCremation.thedead);
                	Common.form.fillForm("info-thedead-", hwaCremation.thedead);

                	setTimeout(function(){
                		if(size == 2){
                    		if(!confirm("신청자와 납부자정보를 2번째 고인의 화장자료 신청자로 변경하시겠습니까?")){
         						return false;
         					}
                    	}
                    	for(var key in hwaCremation.applicant){
                    		$("#info-applicant-"+key).val(hwaCremation.applicant[key]);
                    		$("#info-applicant-"+key).val(hwaCremation.applicant[key]);
                    		$("#info-payer-"+key).val(hwaCremation.applicant[key]);
                    		$("#info-payer-"+key).val(hwaCremation.applicant[key]);
                    		$("#form-info [id^='info-applicant']").change();
                    		$("#form-info [id^='info-applicant']").blur();
                    	}
                    	$("#info-enshrine-deadRelationNm").val(hwaCremation.applRelationNm);
                    	$("#info-enshrine-deadRelation").val(hwaCremation.applRelation);
                	},600)



                	app.modal.close();
                },
                searchThedeadModalResult: function(thedead){
                	for(var key in thedead){
                		$("#info-"+key).val(thedead[key]);
                		$("#info-"+key).bindSelectSetValue(thedead[key]);
                		app.modal.close();
                		$("#form-info [id^='info-dead']").change();
                		$("#info-ensdead-objt").change();
                		$("#form-info [id^='info-dead']").blur();
                	}
                },
                searchApplicantModalResult: function(applicant){
                	$("#info-beforeApplId").val($("#info-applicant-applId").val());
                	for(var key in applicant){
                		$("#info-"+key).val(applicant[key]);
                		$("#info-"+key).bindSelectSetValue(applicant[key]);
                	}
               		app.modal.close();
                },
                searchEnsNoModalResult: function(ensNo){
                	$("#info-enshrine-ensNo").val(ensNo);
                	app.modal.close();
                },
                searchEnsretModalResult : function(item){

                	app.modal.cancel();

                	var deadRelation = $("#info-enshrine-deadRelation").val();
                	var deadRelatiNm = $("#info-enshrine-deadRelationNm").val();

                	item.deadId = "";

                	Common.form.fillForm("info-ensdead-",item);
                	Common.form.fillForm("info-thedead-",item);

                	setTimeout(function(){

                		if($("#info-applicant-applName").val().length > 0){
                    		if(confirm("신청자정보를 "+ item.deadName +"고인의 신청자정보로 수정하시겠습니까?")){
                    			fnObj.formApplicant.clear();
                    			$("#info-payer-applId").val(item.applId);
                    			$("#info-enshrine-deadRelation").val(item.deadRelation);
         						$("#info-enshrine-deadRelationNm").val(item.deadRelationNm);
         					}else{
         						$("#info-enshrine-deadRelation").val(deadRelation);
         						$("#info-enshrine-deadRelationNm").val(deadRelation);
         					}
                    	}else{
                    		Common.form.fillForm("info-applicant-",item);
                    	}
                	}, 300);

                	$("#info-thedead-deadId").val("");
                	$("#info-payer-applId").val(item.applId);



                },
                ensretModalResult : function(item){
                	fnObj.tab = item;
                	fnObj.searchEnshrine.submit();
                },
                esnextModalResult :  function(item){
                	fnObj.tab = item;
                	fnObj.searchEnshrine.submit();
                },
                enssuccedModalResult : function(item){
                	fnObj.tab = item;
                	fnObj.searchEnshrine.submit();
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
                                    {label:"봉안관리번호", labelWidth:"", type:"inputText", width:"150", key:"ensDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
//             										$("#info-enshrine-ensDate").val(this.value);
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"ensSeq", addClass:"", valueBoxStyle:"", value:""
                                    	, onChange: function(changedValue){
            								//아래 2개의 값을 사용 하실 수 있습니다.
//             								toast.push(Object.toJSON(this));
//             								toast.push(changedValue);
//                                     		$("#info-enshrine-ensSeq").val(changedValue);
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
                            url: "/ENSH1010/enshrine/"+$("#"+fnObj.searchEnshrine.target.getItemId("ensDate")).val()+"/"+$("#"+fnObj.searchEnshrine.target.getItemId("ensSeq")).val(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.massage);
                        	}else{
                        		if(!res.map.enshrine || res.map.enshrine == null){
                        			toast.push("검색 결과가 존재하지 않습니다.");
                        			return;
                        		}
                        		if(res.map.hwaCremation || res.map.hwaCremation != null){
                        			fnObj.hwaCremation = res.map.hwaCremation;
                        		}


                        		fnObj.form.clear();
                        		fnObj.form.setJSON(res.map.enshrine);
                        		$("#info-beforeApplId").val(res.map.enshrine.applId);
                        		$("#div-tab").updateTabs(fnObj.CODES.tab);
    							$("#div-contents").append($("[id^='div-tab-content-']"));
    							$("#div-content").append($("#div-tab-content-A"));
    							//$("input").blur();
                        		$("#info-beforeEnsNo").val(res.map.enshrine.ensNo);
                        		if(res.map.enshrine.extEndDate){
	                        		$("#info-remain").val(new Date().diff(res.map.enshrine.extEndDate.date())+0);
                        		}
                        		$("#info-enshrine-extCnt").val(0);
                        		if(res.map.enshrine.ensext.length > 0){
                        			$("#info-enshrine-extCnt").val(res.map.enshrine.ensext[res.map.enshrine.ensext.length-1].extCnt);
                        		}
                        		$("#div-tab").setValueTab(fnObj.tab);
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
                                    {label:"화장관리번호", labelWidth:"", type:"selectBox", width:"100", key:"area", addClass:"", valueBoxStyle:"", value: "${area}",
                                    	options:[
            								{optionValue:"sangbok", optionText:"상복공원"},
            								{optionValue:"masan", optionText:"마산화장장"},
            								{optionValue:"jinhae", optionText:"진해화장장"},
            							]
                                    },
                                    {label:"", labelWidth:"", type:"inputText", width:"150", key:"cremDate", addClass:"", valueBoxStyle:"", value: "${param.cremDate}",
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
            										toast.push(Object.toJSON(this));
            									}
            								}
            							}
                                    }
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"cremSeq", addClass:"", valueBoxStyle:"", value: "${param.cremSeq}"}
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
                        var url = "/ENSH1010/hwaCremation";
                        if(url.match("$/")){
                        	toast.push("화장관리번호를 입력해 주세요.");
                        	return;
                        }
                    	app.ajax({
                			async: false,
                            type: "GET",
                            url: url,
                            data: pars
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		if(!res.map.hwaCremationVTO || res.map.hwaCremationVTO == null){
                        			toast.push("검색 결과가 존재하지 않습니다.");
                        			return;
                        		}
                        		if(res.map.hwaCremationVTO.applicant){
	                        		$.each(res.map.hwaCremationVTO.applicant, function(key, value){
	                        			if(key == "applJumin" && value.length == 12){
	                        				$("#ax-input-segment").setValueInput(1);
	                        			}
	                        		});
                        		}
                        		var enshrine = res.map.hwaCremationVTO;
                        		enshrine.ensdead = [enshrine.thedead];
                        		enshrine.ensdead[0].thedead = $.extend({}, enshrine.thedead);
                        		delete enshrine.ensdead[0].thedead.thedead;
                        		enshrine.applicant = enshrine.applicant;
                        		fnObj.form.clear();
                        		fnObj.form.setJSON(enshrine);

                        		$("#info-enshrine-deadRelation").val(res.map.hwaCremationVTO.applRelation);
                        		$("#info-enshrine-deadRelationNm").val(res.map.hwaCremationVTO.applRelationNm);
                        		 var objt = {"TMC0300001" : "TFM0800001"
                    				 , "TMC0300003" : "TFM0800004"
                    				 , "TMC0300007" : "TFM0800005"
                    				 };
                         		$("#info-ensdead-objt").val(objt[res.map.hwaCremationVTO.objt]);
                         		$("#info-ensdead-addrPart").val(res.map.hwaCremationVTO.addrPart);
                         		$("#info-ensdead-dcGubun").val(res.map.hwaCremationVTO.dcGubun);
                        		//$("#form-info [id^='info-thedead'']").change();
                        		//$("#info-ensdead-objt").change();
                        		setTimeout(function(){$("#page-search-hwaCremation input").blur()}, 500);
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
                                {key:"deadName", label:"고인명", width:"150", align:"center", formatter: function(){
                                	if(this.item.thedead){
                                		return this.item.thedead.deadName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"deadJumin", label:"주민번호", width:"200", align:"center"
                                	, formatter: function(val){
                                		if(this.item.thedead){
	                                		return this.item.thedead.deadJumin;
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"deadDate", label:"사망일자", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.item.thedead){
	                                		return this.item.thedead.deadDate;
                                		}else{
                                			return "";
                                		}
                                	}
                                 },
                                {key:"deadSex", label:"성별", width:"100", align:"center"
                                	, formatter:function(val){
                                		if(this.item.thedead){
	                                		for(var i=0; i<fnObj.CODES.deadSex.length; i++){
	                                			if(this.item.thedead.deadSex == fnObj.CODES.deadSex[i].optionValue){
	                                				return fnObj.CODES.deadSex[i].optionText;
	                                			}
	                                		}
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"addrPart", label:"관내구분", width:"100", align:"center" , display : false

                                },
								{key:"objt", label:"대상구분", width:"100", align:"center" , display : false

                                },
                                {key:"dcGubun", label:"감면구분", width:"100", align:"center" , display : false

                                },
                                {key:"dcCode", label:"관내외구분", width:"100", align:"center" , display : false

                                },
                                {key:"", label:"정산위치", width:"100", align:"center"
                                	, formatter:function(val){
                                		if(this.item.payment && this.item.payment.length > 0){
                                			for(var i=0; i<this.item.payment.length; i++){
                                				for(var j=0; j<this.item.payment[i].paymentCalc.length; j++){
                                					var calc = this.item.payment[i].paymentCalc[j]
                                					if(calc.partCode == '80-001' && this.item.payment[i].cFlag != 1){
                                						var payLoc = this.item.payment[i].partCode
                                						for(var k=0; k<fnObj.CODES.part.length; k++){
                                                   			if(payLoc == fnObj.CODES.part[k].partCode){
                                                   				return fnObj.CODES.part[k].partName;
                                                   			}
                                                		}
                                					}
                                				}
                                			}

                                		}
                                	}
                                },
                                {key:"calcCharge", label:"정산금액", width:"100", align:"center" , display : false

                                }

                            ],
                            body : {
                                onclick: function(){
									console.log(this)
									$("#form-info input[id^='info-thedead']").val("");
									$("#form-info input[id^='info-ensdead']").val("");
									//$("#form-info select[id^='info-ensdead']").find("option:eq(0)").prop("selected", true);
									//$("#form-info select[id^='info-thedead']").find("option:eq(0)").prop("selected", true);


									app.form.fillForm(fnObj.form.target, this.item, 'info-ensdead-', true);
                                	app.form.fillForm(fnObj.form.target, this.item.thedead, 'info-thedead-', true);

                                	$("input[id^='info-ensdead']").change();
                            		$("input[id^='info-thedead']").change();
                            		$("select[id^='info-ensdead']").change();
                            		$("select[id^='info-thedead']").change();

                                	for(var j=0; j<fnObj.CODES.part.length; j++){

                                		if(this.item.payment && this.item.payment.length > 0){
                                			if(this.item.payment[this.item.payment.length-1].partCode == fnObj.CODES.part[j].partCode && (this.item.payment[this.item.payment.length-1].kind == "B1" || this.item.payment[this.item.payment.length-1].kind == "D1")){
                                				$("#info-ensdead-part").val(fnObj.CODES.part[j].partName);
                                			}
                                		}

                            		}
									if(this.item.payment.length > 0){
										for(var i=0; i<this.item.payment.length; i++){

	                                		for(var k=0; k<this.item.payment[i].paymentCalc.length; k++){

	                               				if((
	                               						(this.item.payment[i].partCode =="70-001" || this.item.payment[i].partCode =="10-001")
	                               						&& (this.item.payment[i].paymentCalc[k].partCode == '80-001'))){
	                               					$("#btn-receipt").hide();
	                               					if(this.item.payment[i].partCode == "10-001"){
	                               						$("#sp-receipt-msg").html("정산완료(장례식장)")
	                               						break;
	                               					}
	                               					if(this.item.payment[i].partCode == "70-001"){
	                               						$("#sp-receipt-msg").html("정산완료(화장)")
	                               						break;
	                               					}
	                                			}else{
	                                				$("#btn-receipt").show();
                               						$("#sp-receipt-msg").html("")
	                                			}
	                                		}
	                        			}
									}else{
										$("#btn-receipt").show();
                  						$("#sp-receipt-msg").html("")
									}

                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                        fnObj.gridEnsdead.target.setData({list:[fnObj.gridEnsdead.getInitData()]});
                        fnObj.gridEnsdead.target.setFocus(0);
                    },
                    add:function(){
                        this.target.pushList(fnObj.gridEnsdead.getInitData());
                        this.target.setFocus(this.target.list.length-1);
                    },
                    getInitData: function(){
                    	var res = {thedead: {}};
                    	$("#form-info select[id^='info-ensdead-']").each(function(i,o){
                    		res[$(o).attr("id").replace("info-ensdead-", "")] = $("option", o).val();
                   		})
                    	$("#form-info select[id^='info-thedead-']").each(function(i,o){
                    		res.thedead[$(o).attr("id").replace("info-thedead-", "")] = $("option", o).val();
                   		})
                   		res.useGubun = "Y";
                   		res.deadPlace = "TCM0900002";
                   		res.deadReason = "TCM0300001";
                   		res.objt = "TFM0800001";
                   		return res;
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },
                gridEnsext: {
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
                                {key:"extDate", label:"연장일자", width:"100", align:"center"},
                                {key:"extSeq", label:"연번", width:"100", align:"center"},
                                {key:"extStrDate", label:"시작일", width:"100", align:"center"},
                                {key:"extEndDate", label:"종료일", width:"100", align:"center"},
                                {key:"rentalfee", label:"사용료", width:"100", align:"center", formatter:"money"},
                                {key:"extmngAmt", label:"관리비", width:"100", align:"center", formatter:"money"},
                                {key:"charge", label:"부과액", width:"100", align:"center", formatter:"money"},
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
                gridEnsret: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ret",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"retDate", label:"반환일자", width:"100", align:"center"},
                                {key:"retSeq", label:"연번", width:"100", align:"center"},
                                {key:"strDate", label:"시작일", width:"100", align:"center"},
                                {key:"endDate", label:"종료일", width:"100", align:"center"},
                                {key:"receiptAmt", label:"수납액", width:"100", align:"right", formatter:"money"},
                                {key:"retRate", label:"반환율", width:"100", align:"center"
                                	,formatter: function(val){
                                	    return this.value > 0 ? this.value +"%" : 0 +"%"
                              	    },
                                },
                                {key:"retuseAmt", label:"반환사용료", width:"100", align:"right", formatter:"money"},
                                {key:"retmngAmt", label:"반환관리비", width:"100", align:"right", formatter:"money"},
                                {key:"retAmt", label:"반환금액", width:"100", align:"right", formatter:"money"},
                                {key:"retMethod", label:"반환방법", width:"150", align:"center"},
                                {key:"retReason", label:"반환사유", width:"250", align:"center"},
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
                                {key:"succDate", label:"승계일자", width:"100", align:"center"},
                                {key:"applName", label:"신청자", width:"100", align:"center", formatter: function(){
                                	if(this.item.applicantVTO){
                                		return this.item.applicantVTO.applName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"succName", label:"승계자", width:"100", align:"center", formatter: function(){
                                	if(this.item.succApplicantVTO){
                                		return this.item.succApplicantVTO.applName;
                                	}else{
                                		return "";
                                	}
                                }},
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
                                {key:"hstReson", label:"승계사유", width:"100", align:"center"}
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

                        $("#info-enshrine-ensNo").css({border : "#F39A0D 3px solid"});
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");


//                         Common.form.fillForm( 'info-',item);
                        //var info = $.extend({}, item);
                        //app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );

						var info = $.extend({}, item);
						app.form.fillForm(fnObj.form.target, info, 'info-enshrine-', true);
						app.form.fillForm(fnObj.form.target, info.applicant, 'info-applicant-', true);
						app.form.fillForm(fnObj.form.target, info.payer, 'info-payer-', true);
						fnObj.gridEnsret.target.setData({list:{}});
						fnObj.gridEnsext.target.setData({list: {}});
						fnObj.gridEnssucced.target.setData({list: {}});
						if(info.ensret && info.ensret.length > 0 && info.ensret != null){
							for(var i=0; i<info.ensret.length; i++){
                       			if(info.ensret[i].deadSeq == info.ensdead[i].deadSeq ){
                       				info.ensret[i].deadId = info.ensdead[i].deadId;
                       			}
							}

							fnObj.gridEnsret.target.setData({list: info.ensret});
                		}
						if(info.enssucced){
							fnObj.gridEnssucced.target.setData({list: info.enssucced});

						}

						if(info.ensext){
							fnObj.gridEnsext.target.setData({list: info.ensext});
						}

						fnObj.gridEnsdead.target.setData({list: info.ensdead});
						Common.grid.setFocus(fnObj.gridEnsdead.target, 0);


                    },
                    getJSON: function() {
                    	var enshrine = app.form.serializeObjectWithIds(this.target, 'info-enshrine-');
                        enshrine.ensDate = Common.search.getValue(fnObj.searchEnshrine.target, "ensDate");
                        var applicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-');
                        var payer = app.form.serializeObjectWithIds(this.target, 'info-payer-');
                        var ensdead = fnObj.gridEnsdead.target.list;
//                         ensdead = $.map(ensdead, function(o){
//                         	delete o.thedead.thedead;
//                         	o.thedead = $.extend({}, o);
//                         	return o;
//                         });

                        enshrine.ensdead = ensdead;
                        enshrine.applicant = applicant;
                        enshrine.payer = payer;

                        return enshrine;
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        this.target.find("select").find("option:eq(0)").prop("selected", true);
                        $('#info-key').removeAttr("readonly");
                        $("#info-thedead-transferDate").val("");
                        $("#info-thedead-deadDate").val("");
                        $("#info-thedead-deadBirth").val("");
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
                /* formEnsret: {
                	target: $("#form-info"),
                    setJSON: function(item) {
                        var _this = this;
                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-ensret-', true);
                        $("#info-ensret-retDate").attr("readonly", "readonly");
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-ensret-');
                    },
                    clear: function() {
                        app.form.clearFormWithPrefix(this.target, 'info-ensret-');
                    },
                    save: function(){

                    	if(!confirm("반환자료를 저장하시겠습니까?")){
     						return;
     					}
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1010/ensret",
                            data: Object.toJSON(fnObj.formEnsret.getJSON())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("저장하였습니다.");
                               	fnObj.searchEnshrine.submit();
                                loading_mask.close();
                            }
                        });
                    },
                    del: function(){
                    	if(!confirm("반환자료를 삭제하시겠습니까?")){
                    		return;
                    	}
                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensret/"+Common.str.replaceAll($("#info-ensret-retDate").val(), "-", "")
                            		+"/"+Common.str.replaceAll($("#info-ensret-retSeq").val(), "-", ""),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
                                $("#btn-ensret-new").click();
                            }
                        });
                    }
                } */
                // form

            };
        </script>

    </ax:div>
</ax:layout>