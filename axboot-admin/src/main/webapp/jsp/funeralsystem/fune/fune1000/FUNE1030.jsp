<%@page import="com.axisj.axboot.core.util.CommonUtils"%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("userNm", CommonUtils.getCurrentLoginUser().getUserNm());
%>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
<!--     	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/bigers/AXJ.min.new.css"/> -->
        <style type="text/css">
        	form .ax-rwd-table{
        		border: 0px;
        	}
        	.display_none{
        		display: none;
        	}
        	.display_block{
        		display: block;
        	}
        	.AXFormTable {
        		font-size: 15px;
        		background-color: #f0f0f0;
        	}
        	.AXFormTable td div, input, .AXGrid {
        		font-weight: bolder !important;
        		font-size: 15px !important;
        	}
        	.AXFormTable select {
        		font-weight: bolder !important;
        		font-size: 15px !important;
/*         		height: 25px; */
        	}
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-button-group">
                    <div class="left">
                    </div>
                    <div class="right">
                    	 <button type="button" class="AXButton" id="ax-form-btn-new" title="신규"><i class="axi axi-plus-circle"></i> 신규</button>
                    	 <button type="button" class="AXButton Red" id="ax-form-btn-report" title="염습료수정후"><i class="axi axi-report"></i> 임대차계약서</button>
						 <button type="button" class="AXButton" id="btn-reportFUNE1010_10">화장신청서</button>
						 <button type="button" class="AXButton" id="btn-reportFUNE1010_11">봉안신청서</button>
						 <button type="button" class="AXButton" id="btn-reportFUNE1010_12">정보동의서</button>
						 <button type="button" class="AXButton" id="btn-reportFUNE1010_13">장례신청서</button>
                    	 <%-- <button type="button" class="AXButton Red" id="ax-form-btn-report2" title="염습료수정전"><i class="axi axi-report2"></i> 이전임대차계약서</button> --%>
                    </div>
                    <div class="ax-clear"></div>
                </div>
               	<ax:form name="form-info" id="form-info">
               		<input type="hidden" id="info-thedead-deadDocGubun" name="deadDocGubun" value="1">
                    <input id="info-applicant-telno1" name="telno1" type="hidden"></input>
                    <input id="info-applicant-telno2" name="telno2" type="hidden"></input>
                    <input id="info-applicant-telno3" name="telno3" type="hidden"></input>
					<input id="info-funeral-transferCarDate" name="transferCarDate" type="hidden"></input>
                    <input id="info-funeral-transferCarTime" name="transferCarTime" type="hidden"></input>
                    <input id="info-funeral-addrPart" name="addrPart"  type="hidden"></input>
                    <input id="info-funeral-transferCarCompany" name="transferCarCompany" type="hidden"></input>
                    <input id="info-funeral-transferCarPrice" name="transferCarPrice" type="hidden"></input>
                    <input id="info-funeral-transferCarRemark" name="transferCarRemark" type="hidden"></input>
                    <input id="info-funeral-ibkwanInfo" name="ibkwanInfo" type="hidden"></input>
                    <input id="info-funeral-makeUp" name="makeUp" type="hidden" value="0">
                    <input id="info-funeral-transferDate" name="transferDate" type="hidden"></input>
					<input id="info-funeral-dcRemark" name="dcRemark" type="hidden"></input>
                    <input id="info-funeral-funeralCarDate" name="funeralCarDate" type="hidden"></input>
                    <input id="info-funeral-funeralCarTime" name="funeralCarTime" type="hidden"></input>
                    <input id="info-funeral-funeralCarCompany" name="funeralCarCompany" type="hidden"></input>
                    <input id="info-funeral-funeralCarPrice" name="funeralCarPrice" type="hidden"></input>
                    <input id="info-funeral-funeralCarReceiptGubun" name="funeralCarReceiptGubun" type="hidden"></input>
                    <input id="info-funeral-cadillacCompany" name="cadillacCompany" type="hidden"></input>
                    <input id="info-funeral-cadillacPrice" name="cadillacPrice" type="hidden"></input>
                    <input id="info-funeral-cadillacReceiptGubun" name="cadillacReceiptGubun" type="hidden"></input>
                    <input id="info-funeral-funeralCarRemark" name="funeralCarRemark" type="hidden"></input>
                    <input id="info-funeral-coffinOutDate" name="coffinOutDate"type="hidden"></input>
                    <input id="info-funeral-coffinOutTime" name="coffinOutTime" type="hidden"></input>
                    <input id="info-funeral-coffinOutPlace" name="coffinOutPlace" type="hidden"></input>
                    <input id="info-funeral-massDate" name="massDate" type="hidden"></input>
                    <input id="info-funeral-massTime" name="massTime" type="hidden"></input>
                    <input id="info-funeral-massPlace" name="massPlace" type="hidden"></input>
                    <input id="info-funeral-dcGubun" name="dcGubun" type="hidden" value="TCM1200001"></input>
                    <input id="info-applicant-nationGb" name="nationGb" type="hidden" value="TCM0400001"></input>
                    <input id="info-thedead-nationGb" name="nationGb" type="hidden" value="TCM0400001"></input>
                    <input id="info-thedead-sasansayu" name="sasansayu" type="hidden" class="W100" title="사산사유"/>
					<input id="info-thedead-bunmanwol" name="bunmanwol" type="hidden" maxlength="2" class="W50" title="임신주수"/>
					<ax:custom customid="table">
	                    <ax:custom customid="tr">
	                        <ax:custom customid="td" style="width: 45%;">
		                        <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 고인정보</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
                        		<table class='AXFormTable'>
                       				<colgroup>
                        				<col width="13%"/>
                        				<col width="32%"/>
                        				<col width="13%"/>
                        				<col width="42%"/>
                        			</colgroup>
                        			<tr>
                        				<th><div class='tdRel'>고인성명<br>/관내구분</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-thedead-deadName" name="deadName" title="고인성명" clazz="W100" required="true"></b:input>
                        					<input id="info-thedead-familyClan" name="familyClan" class="W50" title="본관" type="hidden">
                        					<select id="info-funeral-dcCode" name="dcCode" class="AXSelect W110"></select>
<%--                         					<b:inputSelector url="/FUNE1030/familyClan/code" id="info-thedead-familyClanCode" name="familyClanCode" clazz="W100" ></b:inputSelector> --%>
                       					</div></td>
                        				<th><div class='tdRel'>고인번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input readonly="readonly" id="info-thedead-deadId" name="deadId" clazz="W100" title="고인번호"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>주민등록번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-thedead-deadJumin" name="deadJumin" pattern="custom" patternString="999999-9999999" maxlength="14" clazz="W130" title="주민등록번호"></b:input>
                        					<input type="hidden" id="info-thedead-deadBirth" name="deadBirth"/>
                       					</div></td>
                        				<th><div class='tdRel'>고인성별<br>/나이</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-thedead-deadSex" name="deadSex" class="W100 AXSelect"></select>
                        					<b:input id="info-thedead-deadAge" name="deadAge" clazz="W50" title="나이"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망원인</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-thedead-deadReason" name="deadReason" class="W100 AXSelect"></select>
                        					<input type="hidden" id="info-thedead-deadReasonNm" name="deadReasonNm" class="W70" title="사망원인상세"/>
                       					</div></td>
                        				<th><div class='tdRel'>사망장소</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-thedead-deadPlace" name="deadPlace" class="W100 AXSelect"></select>
                        					<b:input id="info-thedead-deadPlaceNm" name="deadPlaceNm" clazz="W130" title="사망장소"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망일시</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<input id="info-thedead-deadDate" name="deadDate" type="date" max="9999-12-31" class="AXInput W140" title="사망일자"/>
                        					<input type="hidden" id="info-thedead-deadTime" name="deadTime" class="W60" title="사망시간"/>
											<input id="info-thedead-deadDocnm" type="hidden" name="deadDocnm" />
											<input id="info-thedead-deadDocno" type="hidden" name="deadDocno" />
                       					</div></td>
<%--                         				<th><div class='tdRel'>진단서<br>발행처</div> --%>
<!--                         				</th> -->
<!--                         				<td><div class='tdRel'> -->
<%-- 											<b:input id="info-thedead-deadDocnm" name="deadDocnm" clazz="W120" title="진단서발행처"></b:input> --%>
<%-- 											<b:input id="info-thedead-deadDocno" name="deadDocno" clazz="W70" title="진단서번호"></b:input> --%>
<!--                        					</div></td> -->
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>종교<br>/본관</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-thedead-deadFaith" name="deadFaith" class="W100 AXSelect"></select>
                        					<b:input id="info-thedead-deadFaithNm" name="deadFaithNm" clazz="W200" title="직분"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>주소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
	                        				<input type="text" id="info-thedead-deadPost" name="deadPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
					                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i></button>
					                        <input type="text" id="info-thedead-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" class="AXInput av-required" style="width:380px;" value="" />
					                        <input type="text" id="info-thedead-deadAddr2" name="deadAddr2" title="사망자 주소 상세"  placeholder="" class="AXInput av-required" style="width:480px;" value="" />
                        				</div></td>
                        			</tr>
                        		</table>
                        		<div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 신청인정보</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <table class='AXFormTable'>
                                    <colgroup>
                        				<col width="13%"/>
                        				<col width="32%"/>
                        				<col width="13%"/>
                        				<col width="42%"/>
                        			 </colgroup>                        			<tr>
                        				<th><div class='tdRel'>신청인성명</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-applName" name="applName" title="상주성명" clazz="W100" required="true"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>신청인번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-applId" name="applId" clazz="W100" readonly="readonly"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망자와의<br>관계</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-funeral-applRelation" name="applRelation" class="W100 AXSelect"></select>
                        					<b:input id="info-funeral-applRelationNm" name="applRelationNm" clazz="W70" title="사망자와의관계"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>신청인주민번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<input type="hidden" id="info-applicant-applBirth" name="applBirth" class="W100" title="상주생년월일">
                        					<b:input id="info-applicant-applJumin" name="applJumin" clazz="W130" pattern="custom" patternString="999999-9999999" maxlength="14" title="주민등록번호"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>휴대폰</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-applicant-mobileno1" name="mobileno1" clazz="W50" pattern="custom" patternString="999" maxlength="3" title="통신사"></b:input>
                        					<b:input id="info-applicant-mobileno2" name="mobileno2" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="국번"></b:input>
                        					<b:input id="info-applicant-mobileno3" name="mobileno3" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="전화번호"></b:input>
                       					</div></td>
                        			</tr>
                       				<tr>
                        				<th><div class='tdRel'>주소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
	                        				<input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
					                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i></button>
					                        <button type="button" class="AXButton" id="btn-same"> 상동</button>
					                        <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="상주주소"  placeholder="" class="AXInput av-required" style="width:340px;" value="" />
					                        <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="상주주소 상세"  placeholder="" class="AXInput" style="width:480px;" value="" />
                        				</div></td>
                        			</tr>
                       			</table>
                       			<div class="ax-button-group">
				                    <div class="left">
				                    </div>
				                    <div class="right">
				                    	<b:buttonNew id="btn-newLive" text="신규"></b:buttonNew>
				                    	<b:buttonNew id="btn-insertLive" text="삽입"></b:buttonNew>
				                    	<b:buttonNew id="btn-deleteLive" text="삭제"></b:buttonNew>
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
                       			<div id="div-grid-live" style="height: 330px;"></div>
                       			<b:input id="info-funeral-liveName02" name="liveName02" style="width: 99%;"></b:input>

                       			<div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 빈소주문시스템 비밀번호</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <table class='AXFormTable'>
                                    <colgroup>
	                        			<col width="13%"/>
	                        			<col width="32%"/>
	                        			<col width="13%"/>
	                        			<col width="42%"/>
                        			</colgroup>
                        			<tr>
                        				<td colspan="4">
                        					<span>비밀번호는 숫자 4자리로 입력해 주세요.</span><br>
                        					<span id="bspkPw-msg" style="color: red;"></span>
                        				</td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>비밀번호 변경</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<input type="text" id="password_change" name="password_change" class="AXInput W60" value="사용" />
                        				</div></td>
                        			</tr>
                         			<tr>
                        				<th><div class='tdRel'>비밀번호</div>
                        				</th>
                        				<td><div class='tdRel'>
							                <input id="info-funeral-bspkPw" name="bspkPw" type="password" class="AXInput W100" placeholder="비밀번호" maxlength="4"></input>
                       					</div></td>
                        				<th><div class='tdRel'>비밀번호 확인</div>
                        				</th>
                        				<td><div class='tdRel'>
							                <input id="info-funeral-bspkPw2" name="bspkPw2" type="password" class="AXInput W100" placeholder="비밀번호" maxlength="4"></input>
                       					</div></td>
                        			</tr>
                       			</table>


	                        </ax:custom>
	                        <ax:custom customid="td">
		                        <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 상례정보</h2>
				                    </div>
				                    <div class="right">
				                    	<label><input id="info-funeral-cremUseGb" name="cremUseGb" type="checkbox" value="1"> 화장</label>
				                    	<label><input id="info-funeral-enshUseGb" name="enshUseGb" type="checkbox" value="1"> 봉안</label>
				                    	<label><input id="info-funeral-scatUseGb" name="scatUseGb" type="checkbox" value="1"> 유택동산</label>
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
                        		<table class='AXFormTable'>
                        			<colgroup>
                        				<col width="110"/>
                        				<col/>
                        				<col width="110"/>
                        				<col/>
                        			</colgroup>
                        			<tr>
                        				<th><div class='tdRel'>빈소</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-funeral-binsoCode" name="binsoCode" class="AXSelect W100"></select>
                        					<select id="info-funeral-sangjo" name="sangjo" class="W50 AXSelect"></select>
                        					<input type="text" id="info-funeral-sangjoRemark" name="sangjoRemark" class="AXInput W110" title="상조비고"/>
                       					</div></td>
                        				<th><div class='tdRel'>고객번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-funeral-customerNo" name="customerNo" clazz="W100" readonly="readonly"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>입실일시<br>/구분</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<input id="info-funeral-ibsilDate" name="ibsilDate" type="date" max="9999-12-31" class="AXInput W140"/>
                        					<b:input id="info-funeral-ibsilTime" name="ibsilTime" clazz="W50" pattern="time"></b:input>
                        			<!--  		<select id="info-funeral-ibsilFlg" name="ibsilFlg" class="W100 AXSelect"></select> -->
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>입관일시<br>/염습</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-funeral-yumFlg" name="yumFlg" class="W100 AXSelect"></select>
                        					<select id="info-funeral-ibkwanFlg" name="ibkwanFlg" class="W150 AXSelect"></select>
                        					<input id="info-funeral-ibkwanDate" name="ibkwanDate" type="date" max="9999-12-31" class="AXInput W140"/>
                        					<b:input id="info-funeral-ibkwanTime" name="ibkwanTime" clazz="W50" title="입관일시" pattern="time"></b:input>
                        					<input type="hidden" id="info-funeral-usedSangjo" name="usedSangjo" value="2"/>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>발인일시<br>/구분</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<input id="info-funeral-balinDate" name="balinDate" type="date" max="9999-12-31" class="AXInput W140"/>
                        					<b:input id="info-funeral-balinTime" name="balinTime" clazz="W50" pattern="time"></b:input>
                        					<select id="info-funeral-balinGubun" name="balinGubun" class="W100 AXSelect"></select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>안치일시<br>/안치실</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-funeral-anchiRoom" name="anchiRoom" class="W100 AXSelect"></select>
                        					<input id="info-funeral-anchiDate" name="anchiDate" type="date" max="9999-12-31" class="AXInput W140"/>
                        					<b:input id="info-funeral-anchiTime" name="anchiTime" clazz="W50" title="안치일시" pattern="time"></b:input>
                        					~
                        					<input id="info-funeral-anchiEndDate" name="anchiEndDate" type="date" max="9999-12-31" readonly class="AXInput W140"/>
                        					<b:input id="info-funeral-anchiEndTime" name="anchiEndTime" clazz="W50" title="안치일시" pattern="time" readonly="readonly"></b:input>
                        					<label style="color: red !important;"><input id="info-funeral-anchiEndDateFlg" type="checkbox" value="1" name="anchiEndDateFlg"> 안치종료일시와 발인일시가 다를 경우 선택</label>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장례구분<br>/ 장지</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-funeral-funeralGubun" name="funeralGubun" class="W100 AXSelect"></select>
                        					<b:input id="info-funeral-jangji" name="jangji" clazz="W200" title="장지명" maxlength="20"></b:input>
                       					</div></td>
                        			<!-- 	<th><div class='tdRel'>입관완료여부</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-funeral-ibkwanGubun" name="ibkwanGubun" class="W100 AXSelect"></select>
                       					</div></td> -->
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>약물처리여부</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-funeral-embalmingGubun" name="embalmingGubun" class="W100 AXSelect"></select>
                       					</div></td>
                        			<!--	<th><div class='tdRel'>검사지휘서제출</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-funeral-prosecutorCheckGubun" name="prosecutorCheckGubun" class="W100 AXSelect"></select>
                       					</div></td> -->
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>메모</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-remark" name="remark" maxlength="200" style="width: 95%;" title="전체메모"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>상담자</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<select id="info-funeral-counselor" name="counselor" class="W80 AXSelect"></select>
                       					</div></td>
                        			</tr>
                        		</table>
                       			<div id="div-dynamic-form">
	                       			<div id="div-crem-contents">
		                        		<div class="ax-button-group">
						                    <div class="left">
						                        <h2><i class="axi axi-list-alt"></i>화장정보</h2>
						                    </div>
						                    <div class="right">
						                    </div>
						                    <div class="ax-clear"></div>
						                </div>
						                <table class='AXFormTable'>
		                        			<colgroup>
		                        				<col width="110"/>
		                        				<col/>
		                        				<col width="110"/>
		                        				<col/>
		                        			</colgroup>
		                        			<tr>
		                        				<th><div class='tdRel'>주소지코드</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
		                        					<select id="info-thedead-addrCode" name="addrCode" class="AXSelect W150"></select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>화장대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-cremObjt" name="cremObjt" class="W100 AXSelect"></select>
		                       					</div></td>
		                        				<th><div class='tdRel'>유/분골</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-cremBoneGb" name="cremBoneGb" class="W100 AXSelect" ></select>
		                       					</div></td>
	                       					</tr>
	                       					<tr>
		                        				<th><div class='tdRel'>유골처리구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-cremScatterPlace" name="cremScatterPlace" class="W100 AXSelect"></select>
		                       					</div></td>
		                        				<th><div class='tdRel'>감면사유구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-cremDcGubun" name="cremDcGubun" class="AXSelect W150"></select>
		                        					<select id="info-funeral-cremDcCode" name="cremDcCode" class="AXSelect W150"></select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>비고</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
		                        					<b:input id="info-funeral-cremRemark" name="cremRemark" maxlength="50" style="width: 480px;"></b:input>
		                       					</div></td>
		                        			</tr>
		                       			</table>
	                       			</div>
	                       			<div id="div-ensh-contents">
		                        		<div class="ax-button-group">
						                    <div class="left">
						                        <h2><i class="axi axi-list-alt"></i>봉안정보</h2>
						                    </div>
						                    <div class="right">
						                    </div>
						                    <div class="ax-clear"></div>
						                </div>
						                <table class='AXFormTable'>
		                        			<colgroup>
		                        				<col width="110"/>
		                        				<col/>
		                        				<col width="110"/>
		                        				<col/>
		                        			</colgroup>
		                        			<tr>
		                        				<th><div class='tdRel'>봉안대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-enshObjt" name="enshObjt" class="W100 AXSelect"></select>
		                       					</div></td>
		                        				<th><div class='tdRel'>봉안단</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-enshEnsType" name="enshEnsType" class="W100 AXSelect"></select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>감면사유구분</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
		                        					<select id="info-funeral-enshDcGubun" name="enshDcGubun" class="AXSelect W150"></select>
		                        					<select id="info-funeral-enshDcCode" name="enshDcCode" class="AXSelect W150"></select>
		                       					</div></td>

		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>비고</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
		                        					<b:input id="info-funeral-enshRemark" name="enshRemark" maxlength="50" style="width: 480px;"></b:input>
		                       					</div></td>
		                        			</tr>
		                       			</table>
	                       			</div>
	                       			<div id="div-scat-contents">
		                        		<div class="ax-button-group">
						                    <div class="left">
						                        <h2><i class="axi axi-list-alt"></i>유택동산정보</h2>
						                    </div>
						                    <div class="right">
						                    </div>
						                    <div class="ax-clear"></div>
						                </div>
						                <table class='AXFormTable'>
		                        			<colgroup>
		                        				<col width="110"/>
		                        				<col/>
		                        				<col width="110"/>
		                        				<col/>
		                        			</colgroup>
		                        			<tr>
		                        				<th><div class='tdRel'>유택동산<br>대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-scatObjt" name="scatObjt" class="W100 AXSelect"></select>
		                       					</div></td>
		                        				<th><div class='tdRel'>감면대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-scatDcGubun" name="scatDcGubun" class="AXSelect W150"></select>
		                       					</div></td>
		                        			</tr>
		                       			</table>

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
    	<script src="/static/plugins/axisj/lib/AXGrid.js" type="text/javascript"></script>
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
                },
                pageStart: function(){
					this.bindEvent();
					this.form.bind();
					this.gridLive.bind();
					fnObj.form.clear(true);
					fnObj.defaultFunc.excute();

                },
				data: {
					funeral: null
					, isClose: false
				},
                defaultFunc: {
                	selectBinso: function(){
                		$("#info-funeral-binsoCode").val("${param.binsoCode}");
                	}
                	, searchFuneral: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE1030/funeral?customerNo=${param.customerNo}",
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.data.funeral = res.map.funeral;
                        		fnObj.data.isClose = res.map.isClose;
                        		fnObj.form.setJSON(res.map.funeral);
                            }
                        });
                	}
                	, excute: function(){
                		if("" == "${param.m}" || fnObj.defaultFunc["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFunc["${param.m}"]();
                	}


                },
                dynamicForm: {
                	form: {
	                	crem: null
	                	, ensh: null
	                	, scat: null
                	},
                	bindDynamicForm: function(){

    					fnObj.dynamicForm.form.crem = $("#div-crem-contents").remove();
    					fnObj.dynamicForm.form.ensh = $("#div-ensh-contents").remove();
    					fnObj.dynamicForm.form.scat = $("#div-scat-contents").remove();

                    	$("#info-funeral-cremUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.crem);
    			                $("#info-funeral-cremDcCode").selectBox({
    			                	url: "/FUNE1030/dcRate/code/option?jobGubun=C"
   			            			, method: "get"
   			            			, reserveKey: {
   			            				optionRoot: ""
   			            				, optionValue: "optionValue"
   			            				, optionText: "optionText"
   			            			}
    			                });
    			                $("#info-thedead-addrCode").selectBox({
    			                	url: "/CREM2010/addrCode"
   			            			, method: "get"
//    			            			, isspace: true
//    			            			, isspaceTitle: "-"
//    			            			, value: "3"
//    			            			, index: 5
   			            			, reserveKey: {
   			            				optionRoot: "list"
   			            				, optionValue: "optionValue"
   			            				, optionText: "optionText"
   			            			}
    			                });
    			                $("#info-thedead-deadAddr1").change();
    						}else{
    							$(fnObj.dynamicForm.form.crem).remove();
    						}
    					});
    					$("#info-funeral-enshUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.ensh);
    							$("#info-funeral-enshDcCode").selectBox({
    			                	url: "/FUNE1030/dcRate/code/option?jobGubun=E"
   			            			, method: "get"
   			            			, reserveKey: {
   			            				optionRoot: ""
   			            				, optionValue: "optionValue"
   			            				, optionText: "optionText"
   			            			}
    			                });
    							$("#info-funeral-scatUseGb").removeAttr("checked");
    							$("#info-funeral-scatUseGb").change();
    						}else{
    							$(fnObj.dynamicForm.form.ensh).remove();
    						}
    					});
    					$("#info-funeral-scatUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.scat);
    							$("#info-funeral-enshUseGb").removeAttr("checked");
    							$("#info-funeral-enshUseGb").change();
    						}else{
    							$(fnObj.dynamicForm.form.scat).remove();
    						}
    					});

                    }
                },
                bindEvent: function(){
                	var _this = this;
                	this.bindSelect();
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
                    $("#ax-page-btn-save").bind("click", function(){
                    	_this.save();
                    });
                    $("#ax-form-btn-new").bind("click", function(){
                    	fnObj.form.clear(true);
						$("#info-funeral-binsoCode").selectBox({
		                	url: "/FUNE1030/binso/assignable/code/option/ajax"
		            			, method: "get"
// 		            			, isspace: true
// 		            			, isspaceTitle: "-"
		            			, value: "${param.binsoCode}"
//		            			, index: 5
		            			, reserveKey: {
		            				optionRoot: "options"
		            				, optionValue: "optionValue"
		            				, optionText: "optionText"
		            			}
		                });
                    	fnObj.gridLive.target.setData({list: [{}, {}, {}, {}, {}, {}, {}]});
                    });
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-thedead-deadPost", "info-thedead-deadAddr1", "info-thedead-deadAddr2");
                    });
	                $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
                   	});
	                if("" != "${param.customerNo}"){
						$("#info-funeral-binsoCode").selectBox({
		                	url: "/FUNE1030/binso/assigned/code/option/ajax?customerNo=${param.customerNo}"
		            			, method: "get"
// 		            			, isspace: true
// 		            			, isspaceTitle: "-"
// 		            			, value: "${param.binsoCode}"
//		            			, index: 5
		            			, reserveKey: {
		            				optionRoot: "options"
		            				, optionValue: "optionValue"
		            				, optionText: "optionText"
		            			}
		                });
	                }else{
		                $("#info-funeral-binsoCode").selectBox({
		                	url: "/FUNE1030/binso/assignable/code/option/ajax"
		            			, method: "get"
// 		            			, isspace: true
// 		            			, isspaceTitle: "-"
		            			, value: "${param.binsoCode}"
//		            			, index: 5
		            			, reserveKey: {
		            				optionRoot: "options"
		            				, optionValue: "optionValue"
		            				, optionText: "optionText"
		            			}
		                });
	                }
	                $("#info-funeral-dcCode").selectBox({
	                	url: "/FUNE1030/dcRate/code/option/ajax?jobGubun=F"
	            			, method: "get"
	            			, reserveKey: {
	            				optionRoot: "options"
	            				, optionValue: "optionValue"
	            				, optionText: "optionText"
	            			}
	                });
	                $("#info-funeral-dcCode").bind("change", function(){
                		if($("#info-funeral-yumFlg").val() != "00"){
                			if($("#info-funeral-dcCode").val() == "004"){
    	                		$("#info-funeral-ibkwanFlg").val("06")
    	                	}else if($("#info-funeral-dcCode").val() == "000"){
    	                		$("#info-funeral-ibkwanFlg").val("07")
    	                	}else{
    	                		$("#info-funeral-ibkwanFlg").val("00")
    	                	}
                		}else{
	                		$("#info-funeral-ibkwanFlg").val("00")
	                	}
	                })

 	                fnObj.dynamicForm.bindDynamicForm();

					$("#btn-same").bind("click", function(){
						$("#info-applicant-applPost").val($("#info-thedead-deadPost").val());
						$("#info-applicant-applAddr1").val($("#info-thedead-deadAddr1").val());
						$("#info-applicant-applAddr2").val($("#info-thedead-deadAddr2").val());
					});

					$("#info-thedead-deadJumin").bind("change", function(){
						$("#info-thedead-deadBirth").val(Common.str.toBirth($("#info-thedead-deadJumin").val()).date().print());
						var deadDate = $("#info-thedead-deadDate").val();
						if(deadDate == ""){
							deadDate = new Date().print();
						}
						$("#info-thedead-deadAge").val(Common.str.getAge($("#info-thedead-deadJumin").val(), $("#info-thedead-deadDate").val().date()));
						$("#info-thedead-deadSex").val(Common.str.getGender($("#info-thedead-deadJumin").val()));
					});

					$("#info-thedead-deadDate").bind("change", function(){
						var deadJumin = $("#info-thedead-deadJumin").val();
						if(deadJumin != ""){
							$("#info-thedead-deadAge").val(Common.str.getAge($("#info-thedead-deadJumin").val(), $("#info-thedead-deadDate").val().date()));
						}
					});

					$("#btn-newLive").bind("click", function(){
						fnObj.gridLive.add();
					});
					$("#btn-insertLive").bind("click", function(){
						fnObj.gridLive.insert();
					});
					$("#btn-deleteLive").bind("click", function(){
						fnObj.gridLive.del();
					});

					$("#info-thedead-deadAddr1").bind("change",function(){
                    	Common.addr.getAddrPart(this.value, "info-thedead-addrCode", "info-funeral-addrPart",false,0);
                    });
					$("#info-applicant-applPost, #info-applicant-applAddr1, #info-applicant-applAddr2").bind("keyup", function(e){
						if(e.keyCode==36){
							$("#btn-same").click();
						}
					});
					$("#info-funeral-transferCarPrice").bindMoney()
					$("#info-funeral-funeralCarPrice").bindMoney()
					$("#info-funeral-cadillacPrice").bindMoney()
					$("#info-funeral-liveName02").bind("keydown", function(e){
						if(e.keyCode != 13){
							return;
						}

						var liveNames = fnObj.gridLive.target.list;
						var names = [];
						$.each(liveNames, function(i, o){
							for(var key in o){
								if(key != "0" && key != "_CUD"){
									if(o[key] && o[key] != ''){
										names.push(o[key]);
									}
								}
							}
						});
						$(this).val(names.join(","));
					});
// 					$("#info-funeral-transferDate").bind("change", function(){
// 						app.ajax({
// 	                        type: "GET",
// 	                        url: "/FUNE1030/dcCode",
// 	                        // String addrPart, String addr1, String dcGubun, Date transferDate
// 	                        data: "addrPart="+$("#info-funeral-addrPart").val()
// 	                        		+"&addr1="+$("#info-thedead-deadAddr1").val()
// 	                        		+"&dcGubun="+$("#info-funeral-dcGubun").val()
// 	                        		+"&transferDate="+$("#info-funeral-transferDate").val()
// 	                    },
// 	                    function(res){
// 	                    	if(res.error){
// 	                    		alert(res.error.message);
// 	                    	}else{
// 	                            var dcCode = res.map.dcCode;
// 	                            var funeDcCode = dcCode.funeDcCode;
// 	                            var cremDcCode = dcCode.funeDcCode;
// 	                            var enshDcCode = dcCode.funeDcCode;
// 	                            var natuDcCode = dcCode.funeDcCode;

// 	                            $("#info-funeral-dcCode").val(funeDcCode);
// 	                            $("#info-funeral-cremDcCode").val(cremDcCode);
// 	                            $("#info-funeral-enshDcCode").val(enshDcCode);
// 	                            $("#info-funeral-natuDcCode").val(natuDcCode);
// 	                        }
// 	                    });
// 					});


					$("#btn-reportFUNE1010_10").bind("click", function(){
                		var path = "/reports/changwon/fune/FUNE1010_10";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
                    });

					$("#btn-reportFUNE1010_11").bind("click", function(){
                		var path = "/reports/changwon/fune/FUNE1010_11";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
                    });

					$("#btn-reportFUNE1010_12").bind("click", function(){
                		var path = "/reports/changwon/fune/FUNE1010_12";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
                    });

					$("#btn-reportFUNE1010_13").bind("click", function(){
                		var path = "/reports/changwon/fune/FUNE1010_13";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
                    });

					$("#ax-form-btn-report").bind("click", function(){
						var path = "/reports/changwon/fune/FUNE8011_1";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
					})
					$("#ax-form-btn-report2").bind("click", function(){
						var path = "/reports/changwon/fune/FUNE8011";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
					})

					$("#info-funeral-balinDate").bind("keyup", function(){
						$("#info-funeral-anchiEndDate").val(this.value);
					});
					$("#info-funeral-balinTime").bind("keyup", function(){
						$("#info-funeral-anchiEndTime").val(this.value);
					});
// 					$("#info-thedead-deadPlaceNm").bind("change", function(){
// 						$("#info-thedead-deadDocnm").val(this.value);
// 					})
					$("#info-funeral-anchiEndDateFlg").bind("change", function(){
						if(this.checked){
							$("#info-funeral-anchiEndDate").removeAttr("readonly");
							$("#info-funeral-anchiEndTime").removeAttr("readonly");
						}else{
							$("#info-funeral-anchiEndDate").attr("readonly", "readonly");
							$("#info-funeral-anchiEndDate").val($("#info-funeral-balinDate").val());
							$("#info-funeral-anchiEndTime").attr("readonly", "readonly");
							$("#info-funeral-anchiEndTime").val($("#info-funeral-balinTime").val());
						}
					});
					$("#info-applicant-applAddr2").bind("keydown", function(e){
						if(e.keyCode == 13 || e.keyCode == 9){
							Common.grid.revitalizeInlineEditor(fnObj.gridLive.target, 0, 0);
						}
					});
					$("#info-funeral-liveName02").bind("keydown", function(e){
						if(e.keyCode == 13 || e.keyCode == 9){
							$("#info-funeral-binsoCode").focus();
							return false;
						}
					});
					$("#info-funeral-bspkPw, #info-funeral-bspkPw2").bindPattern({pattern: "9999"})
					$("#info-funeral-bspkPw2").change(function(){
						if($("#info-funeral-bspkPw").val() != $("#info-funeral-bspkPw2").val()){
							$("#bspkPw-msg").html("입력한 비밀번호가 서로 다릅니다.");
						}else{
							$("#bspkPw-msg").html("");
						}
					})
					$("#password_change").bindSwitch({on:"변경", off:"변경안함", onchange:function(){
                        if(this.value == "변경안함"){
                            $("#info-funeral-bspkPw").attr("disabled", "disabled");
                            $("#info-funeral-bspkPw2").attr("disabled", "disabled");
                        }else{
                            $("#info-funeral-bspkPw").removeAttr("disabled");
                            $("#info-funeral-bspkPw2").removeAttr("disabled");
                        }
                    }});
                },
                bindSelect: function(){
                	$("#info-thedead-deadReason").selectBox({
	                	basicCd: "TCM03"
	                });
                	//$("#info-thedead-deadPlace").selectBox({
	                //	basicCd: "TCM09"
	                //});
                	 $("#info-thedead-deadPlace").selectBox({
						url: "/api/v1/basicCodes/deadPlace/option"
						,reserveKeys: {
							 optionValue: "optionValue"
		               		, optionText: "optionText"
            			}
						,async : false
        			});
                	$("#info-thedead-deadPlace").bind("change", function(){
                		if($(this).val() == "TCM0900001"){
                			$("#info-thedead-deadDocnm").val("한병리과")
                		}
                	})
                	$("#info-thedead-deadFaith").selectBox({
	                	basicCd: "TCM06"
	                });
                	$("#info-funeral-applRelation").selectBox({
	                	basicCd: "TCM08"
	                });
                	$("#info-funeral-addrPart").selectBox({
	                	basicCd: "TCM10"
	                	, isspace: true
	                	, isspaceTitle: "."
	                });
                	$("#info-funeral-transferCarCompany").selectBox({
	                	basicCd: "506"
	                	, isspace: true
	                	, isspaceTitle: "."
	                });
                	$("#info-funeral-anchiRoom").selectBox({
	                	basicCd: "120"
	                });

                	// anchi_room 선택에 따라 anchi_date 변경 180713 김세현
                	$("#info-funeral-anchiRoom").change(function(){
                		var anchiRoom = $("#info-funeral-anchiRoom").val();
						if(anchiRoom != "00"){
                			//toast.push("00아님");
							$("#info-funeral-anchiDate").val(new Date().print("yyyy-mm-dd"));
							$("#info-funeral-anchiTime").val("00:00");
							$("#info-funeral-anchiEndDate").val($("#info-funeral-balinDate").val());
	                        $("#info-funeral-anchiEndTime").val($("#info-funeral-balinTime").val());
                		}else if(anchiRoom = "00"){
                			//toast.push("00임");
                			$("#info-funeral-anchiDate").val("");
							$("#info-funeral-anchiTime").val("");
							$("#info-funeral-anchiEndDate").val($("#info-funeral-balinDate").val());
							$("#info-funeral-anchiEndTime").val($("#info-funeral-balinTime").val());
                		}
					});

                	$("#info-funeral-ibsilFlg").selectBox({
	                	basicCd: "104"
	                	, value: "01"
	                });
                	$("#info-funeral-ibkwanFlg").selectBox({
	                	basicCd: "00"
	                	, value: "00"
	                });
                	$("#info-funeral-yumFlg").selectBox({
	                	basicCd: "04"
	                	, value: "01"
	                });
                	$("#info-funeral-yumFlg").bind("change", function(){
                		if($(this).val() != "00"){
                			if($("#info-funeral-dcCode").val() == "004"){
    	                		$("#info-funeral-ibkwanFlg").val("06")
    	                	}else if($("#info-funeral-dcCode").val() == "000"){
    	                		$("#info-funeral-ibkwanFlg").val("07")
    	                	}else{
    	                		$("#info-funeral-ibkwanFlg").val("00")
    	                	}
                		}else{
	                		$("#info-funeral-ibkwanFlg").val("00")
	                	}
	                })
                	$("#info-funeral-ibkwanInfo").selectBox({
	                	basicCd: "IBKWAN_INFO"
	               		, isspace: true
	                	, isspaceTitle: "-"
	                });
                	$("#info-funeral-balinGubun").selectBox({
	                	basicCd: "122"
	                	, value: "04"
	                });
                	$("#info-funeral-sangjo").selectBox({
	                	basicCd: "115"
	                });
                	$("#info-funeral-usedSangjo").selectBox({
	                	basicCd: "503"
	                });
                	$("#info-funeral-funeralGubun").selectBox({
	                	basicCd: "107"
	                	, value: "1"
	                });
                	$("#info-funeral-ibkwanGubun").selectBox({
	                	basicCd: "108"
	                });
                	$("#info-funeral-embalmingGubun").selectBox({
	                	basicCd: "108"
	                });
                	$("#info-funeral-prosecutorCheckGubun").selectBox({
	                	basicCd: "108"
	                });
                	$("#info-funeral-cremDcGubun").selectBox({
	                	basicCd: "TCM12"
	                });
                	$("#info-funeral-enshDcGubun").selectBox({
	                	basicCd: "TCM12"
	                });
                	$("#info-funeral-scatDcGubun").selectBox({
	                	basicCd: "TCM12"
	                });
                	$("#info-funeral-scatObjt").selectBox({
	                	basicCd: "TFM27"
	                });
                	$("#info-funeral-funeralCarCompany").selectBox({
	                	basicCd: "507"
                		, isspace: true
             			, isspaceTitle: "."
	                });
                  	$("#info-funeral-funeralCarReceiptGubun").selectBox({
	                	basicCd: "TMC15"
                		, isspace: true
             			, isspaceTitle: "미사용"
	                });
                  	$("#info-funeral-cadillacCompany").selectBox({
	                	basicCd: "507"
                		, isspace: true
             			, isspaceTitle: "."
	                });
                  	$("#info-funeral-cadillacReceiptGubun").selectBox({
	                	basicCd: "TMC15"
                		, isspace: true
             			, isspaceTitle: "미사용"
	                });
                  	$("#info-applicant-nationGb").selectBox({
	                	basicCd: "TCM04"
	                });
                  	$("#info-thedead-nationGb").selectBox({
	                	basicCd: "TCM04"
	                });
                  	$("#info-funeral-cremObjt").selectBox({
	                	basicCd: "TMC03"
	                });
                  	$("#info-funeral-cremObjt").selectBox({
	                	basicCd: "TMC03"
	                });
                  	$("#info-funeral-cremBoneGb").selectBox({
	                	basicCd: "TMC05"
	                });
                  	$("#info-funeral-cremScatterPlace").selectBox({
	                	basicCd: "TMC06"
	                });
                  	$("#info-funeral-enshObjt").selectBox({
	                	basicCd: "TFM08"
	                });
                  	$("#info-funeral-enshEnsType").selectBox({
	                	basicCd: "TFM10"
	                });
                  	$("#info-thedead-deadSex").selectBox({
	                	basicCd: "TCM05"
	                });
                  	$("#info-funeral-counselor").selectBox({
                  		url: "/FUNE1030/employee/options"
                		, isspace: true
             			, isspaceTitle: "."
           				, reserveKey: {
               				optionRoot: ""
               				, optionValue: "optionValue"
               				, optionText: "optionText"
               			}
	                });
                },
                report: {
                },
                save: function(){

                	if($("#password_change").val() == "변경"){
                		if($("#info-funeral-bspkPw").val() != $("#info-funeral-bspkPw2").val()){
                			alert("빈소주문시스템 비밀번호가 서로 다릅니다.")
                			$("#info-funeral-bspkPw").focus()
                			return
                		}
                	}
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

                    var data = fnObj.form.getJSON();
                    if(data.ibsilFlg == "1" && +data.binsoCode < 800){
                    	if(data.ibsilDate == ""){
                    		alert("입실일시를 입력해 주세요.");
                    		$("#info-funeral-ibsilDate").fucus();
                    		return;
                    	}
                    }

                    if((data.ibsilDate == null || data.ibsilDate == "") && (data.anchiDate == null || data.anchiDate == "")){
                        alert("안치일시 또는 입실일시를 확인해 주세요.");
                    	$("#info-funeral-anchiDate").fucus();
                    	return;
                    }

                    if(data.ibsilDate > data.balinDate){
                        alert("발인일시를 확인해 주세요.");
                    	$("#info-funeral-balinDate").fucus();
                    	return;
                    }

                    var liveNames = fnObj.gridLive.target.list;
					var names = [];
					$.each(liveNames, function(i, o){
						for(var key in o){
							if(key != "0" && key != "_CUD"){
								if(o[key] && o[key] != ''){
									names.push(o[key]);
								}
							}
						}
					});
					data.liveName02 = names.join(",");

                	app.ajax({
                        type: "PUT",
                        url: "/FUNE1030/funeral",
                        data: Object.toJSON(data)
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                            toast.push("저장되었습니다.");
                            window.open("/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo="+res.map.funeral.customerNo, "FUNE1030");
                        }
                    });
                },
                del: function(){
                	if(!confirm("장례정보를 삭제하시겠습니까?")){
                		return;
                	}
                	app.ajax({
                        type: "DELETE",
                        url: "/ENSH1010/enshrine/"+$("#info-ensDateString").val().date().print("yyyymmdd")+"/"+$("#info-ensSeq").val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                            toast.push("삭제되었습니다.");
                            $("#ax-form-btn-new").click();
                        }
                    });
                },
                gridLive: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-live",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            height: "auto",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"0", label:"관계", width:"68", align:"center", editor: "text", sort: false},
                                {key:"1", label:"1", width:"68", align:"center", editor: "text", sort: false},
                                {key:"2", label:"2", width:"68", align:"center", editor: "text", sort: false},
                                {key:"3", label:"3", width:"68", align:"center", editor: "text", sort: false},
                                {key:"4", label:"4", width:"68", align:"center", editor: "text", sort: false},
                                {key:"5", label:"5", width:"68", align:"center", editor: "text", sort: false},
                                {key:"6", label:"6", width:"68", align:"center", editor: "text", sort: false},
                                {key:"7", label:"7", width:"68", align:"center", editor: "text", sort: false},
                                {key:"8", label:"8", width:"68", align:"center", editor: "text", sort: false},
                                {key:"9", label:"9", width:"68", align:"center", editor: "text", sort: false},
                                {key:"10", label:"10", width:"68", align:"center", editor: "text", sort: false},
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

                        for(var i=0;i<7;i++){
                        	this.target.pushList({});
                        }
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    insert: function(){
                    	var idx = this.target.getSelectedItem().index;
                    	this.target.list.splice(idx, 0, {});
                    	this.target.setData({list: this.target.list});
                        this.target.setFocus(idx);
                    },
                    del: function(){
                    	fnObj.gridLive.target.removeListIndex([fnObj.gridLive.target.getSelectedItem()]);
                    },
                    setPage: function(item){
                    	if(item.liveName01){
                    		var live01 = item.liveName01.split(",");
                    		live01 = $.map(live01, function(o){
                    			var oArr = o.split(":");
                    			var res = {};
                    			$.each(oArr, function(i, o2){res[i]=o2});
                    			return res;
                    		});
                    		this.target.setData({list: live01});
                    	}
                    	if(item.liveName02){
                    		$("#info-liveName02").val(item.liveName02);
                    	}
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

                    },
                    disable: function(isClose){
                    	if(isClose == true){
	                    	$("#info-funeral-anchiRoom option").not(":selected").attr("disabled", true);
	                    	$("#info-funeral-ibsilFlg option").not(":selected").attr("disabled", true);
	                    	$("#info-funeral-ibkwanFlg option").not(":selected").attr("disabled", true);
	                    	$("#info-funeral-yumFlg option").not(":selected").attr("disabled", true);
	                    	$("#info-funeral-balinGubun option").not(":selected").attr("disabled", true);
							$("#info-funeral-anchiDate").attr("readonly", "readonly");
							$("#info-funeral-anchiTime").attr("readonly", "readonly");
							$("#info-funeral-ibsilDate").attr("readonly", "readonly");
							$("#info-funeral-ibsilTime").attr("readonly", "readonly");
							$("#info-funeral-ibkwanDate").attr("readonly", "readonly");
							$("#info-funeral-ibkwanTime").attr("readonly", "readonly");
							$("#info-funeral-balinDate").attr("readonly", "readonly");
							$("#info-funeral-balinTime").attr("readonly", "readonly");
                    	}else{
                    		$("#info-funeral-anchiRoom option").not(":selected").attr("disabled", false);
	                    	$("#info-funeral-ibsilFlg option").not(":selected").attr("disabled", false);
	                    	$("#info-funeral-ibkwanFlg option").not(":selected").attr("disabled", false);
	                    	$("#info-funeral-yumFlg option").not(":selected").attr("disabled", false);
	                    	$("#info-funeral-balinGubun option").not(":selected").attr("disabled", false);
							$("#info-funeral-anchiDate").removeAttr("readonly");
							$("#info-funeral-anchiTime").removeAttr("readonly");
							$("#info-funeral-ibsilDate").removeAttr("readonly");
							$("#info-funeral-ibsilTime").removeAttr("readonly");
							$("#info-funeral-ibkwanDate").removeAttr("readonly");
							$("#info-funeral-ibkwanTime").removeAttr("readonly");
							$("#info-funeral-balinDate").removeAttr("readonly");
							$("#info-funeral-balinTime").removeAttr("readonly");
                    	}
                    },
                    setJSON: function(item) {
                        var _this = this;
						this.clear(false);
                        var info = $.extend({}, item);
                        var checked = function(keys){
                        	$.each(keys, function(i, key){
	                        	if(info[key] == "1"){
		                        	$("#info-funeral-"+key).attr("checked", true);
		                        	$("#info-funeral-"+key).change();
	                        	}
	                        	info[key] = "1";	// axisj에서 만든 fillForm의 버그가 있어서 checkbox 기본값을 세팅해줘야함. getJSON 호출시 checked = true 인것만 값이 나오고 아니면 undefined로 나옴.
                        	})
                        }
                        checked(["cremUseGb", "enshUseGb", "anchiEndDateFlg", "scatUseGb"])

                        var toyyyyMMdd = function(date){
                        	if(date && date.length == 16){
                        		return date.split(" ")[0]
                        	}else{
                        		return "";
                        	}
                        }
                        var toHhmi = function(date){
                        	if(date && date.length == 16){
                        		return date.split(" ")[1]
                        	}else{
                        		return "";
                        	}
                        }
                        info.transferCarTime = toHhmi(info.transferCarDate);
						info.anchiTime = toHhmi(info.anchiDate);
						info.anchiEndTime = toHhmi(info.anchiEndDate);
                    	info.ibsilTime = toHhmi(info.ibsilDate);
                    	info.ibkwanTime = toHhmi(info.ibkwanDate);
                    	info.balinTime = toHhmi(info.balinDate);
                    	info.coffinOutTime = toHhmi(info.coffinOutDate);
                    	info.funeralCarTime = toHhmi(info.funeralCarDate);

                        info.transferCarDate = toyyyyMMdd(info.transferCarDate);
						info.anchiDate = toyyyyMMdd(info.anchiDate);
						info.anchiEndDate = toyyyyMMdd(info.anchiEndDate);
                    	info.ibsilDate = toyyyyMMdd(info.ibsilDate);
                    	info.ibkwanDate = toyyyyMMdd(info.ibkwanDate);
                    	info.balinDate = toyyyyMMdd(info.balinDate);
                    	info.coffinOutDate = toyyyyMMdd(info.coffinOutDate);
                    	info.funeralCarDate = toyyyyMMdd(info.funeralCarDate);

                        app.form.fillForm(_this.target, info, 'info-funeral-', true);
                        app.form.fillForm(_this.target, info.thedead, 'info-thedead-', true);
                        app.form.fillForm(_this.target, info.applicant, 'info-applicant-', true);


                        if(info.liveName01){
	                        var live = info.liveName01.split(",");
	                        live = $.map(live, function(o){
	                        	var item = {};
	                        	$.each(o.split(":"), function(i, o2){
									item[i] = o2;
	                        	});
	                        	return item;
	                        });
	                        fnObj.gridLive.target.setData({list: live});
                        }

                        fnObj.form.disable(fnObj.data.isClose);

                    },
                    getJSON: function() {
                    	var funeral = app.form.serializeObjectWithIds(this.target, 'info-funeral-');
                    	funeral.makeUp = "0";
                    	var thedead = app.form.serializeObjectWithIds(this.target, 'info-thedead-');
                    	var applicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-');
                    	funeral.deadId = thedead.deadId;
                    	funeral.applId = applicant.applId;
                    	funeral.thedead = thedead;
                    	funeral.applicant = applicant;

                    	var defaultTime = function(time){
                    		return !time || time == "" ? "00:00" : time;
                    	}

                    	if(funeral.transferCarDate != "" && funeral.transferCarTime != ""){
                        	funeral.transferCarDate = funeral.transferCarDate+" "+funeral.transferCarTime;
                    	}else{
                    		funeral.transferCarDate = null;
                    	}
                    	if(funeral.anchiDate != "" && funeral.anchiTime != ""){
                        	funeral.anchiDate = funeral.anchiDate+" "+funeral.anchiTime;
                    	}else{
                    		funeral.anchiDate = null;
                    	}
                    	if(funeral.anchiEndDate != "" && funeral.anchiEndTime != ""){
                        	funeral.anchiEndDate = funeral.anchiEndDate+" "+funeral.anchiEndTime;
                    	}else{
                    		funeral.anchiEndDate = null;
                    	}
                    	if(funeral.ibsilDate != "" && funeral.ibsilTime != ""){
                        	funeral.ibsilDate = funeral.ibsilDate+" "+funeral.ibsilTime;
                    	}else{
                    		funeral.ibsilDate = null;
                    	}
                    	if(funeral.ibkwanDate != "" && funeral.ibkwanTime != ""){
                        	funeral.ibkwanDate = funeral.ibkwanDate+" "+funeral.ibkwanTime;
                    	}else{
                    		funeral.ibkwanDate = null;
                    	}
                    	if(funeral.balinDate != "" && funeral.balinTime != ""){
                        	funeral.balinDate = funeral.balinDate+" "+funeral.balinTime;
                    	}else{
                    		funeral.balinDate = null;
                    	}
                    	if(funeral.coffinOutDate != "" && funeral.coffinOutTime != ""){
                        	funeral.coffinOutDate = funeral.balinDate+" "+funeral.coffinOutTime;
                    	}else{
                    		funeral.coffinOutDate = null;
                    	}
                    	if(funeral.funeralCarDate != "" && funeral.funeralCarTime != ""){
                        	funeral.funeralCarDate = funeral.balinDate+" "+funeral.funeralCarTime;
                    	}else{
                    		funeral.funeralCarDate = null;
                    	}
                    	if(funeral.massDate != "" && funeral.massTime != ""){
                        	funeral.massDate = funeral.balinDate+" "+funeral.massTime;
                    	}else{
                    		funeral.massDate = null;
                    	}
                    	funeral.transferCarPrice = Common.str.replaceAll(funeral.transferCarPrice, ",", "");
                    	funeral.funeralCarPrice = Common.str.replaceAll(funeral.funeralCarPrice, ",", "");
                    	funeral.cadillacPrice = Common.str.replaceAll(funeral.cadillacPrice, ",", "");

//                     	funeral.makeUp = funeral.makeUp == '1' ? 1 : 0;
                    	funeral.anchiEndDateFlg = funeral.anchiEndDateFlg == '1' ? 1 : 0;

//                     	var checked = function(val){
//                     		return "on" == val ? 1 : 0;
//                     	}
//                     	funeral.cremUseGb = checked(funeral.cremUseGb);
//                     	funeral.enshUseGb = checked(funeral.enshUseGb);

                    	var liveName01 = [];
                    	$.each(fnObj.gridLive.target.list, function(i, o){
                    		var item = [];
                    		for(var i=0; i<11; i++){
                    			item.push(o[i]);
                    		}
                    		liveName01.push(item.join(":"));
                    	});

                    	funeral.liveName01 = liveName01.join(",");

                        return funeral;
                    },
                    clear: function(isDefault) {
                        app.form.clearForm(this.target);
                        this.target.find("select").find("option:eq(0)").prop("selected", true);
                        if(isDefault == true){
// 	                        $("#info-funeral-ibsilDate").val(new Date().print("yyyy-mm-dd"));
// 	                        $("#info-funeral-ibsilTime").val("00:00");
	                        $("#info-funeral-ibsilTime").bind("focus", function(){
	                        	this.select();
	                        });
	                        $("#info-funeral-ibsilFlg").val("01");
// 	                        $("#info-funeral-ibkwanDate").val(new Date().print("yyyy-mm-dd"));
// 	                        $("#info-funeral-ibkwanTime").val("00:00");
	                        $("#info-funeral-ibkwanTime").bind("focus", function(){
	                        	this.select();
	                        });
// 	                        $("#info-funeral-balinDate").val(new Date().add(2).print("yyyy-mm-dd"));
// 	                        $("#info-funeral-balinTime").val("00:00");
	                        $("#info-funeral-balinTime").bind("focus", function(){
	                        	this.select();
	                        });
	                        //$("#info-funeral-anchiDate").val(new Date().print("yyyy-mm-dd"));
	                        //$("#info-funeral-anchiTime").val("00:00");
	                        $("#info-funeral-anchiDate").val("");
	                        $("#info-funeral-anchiTime").val("");
	                        $("#info-funeral-anchiEndDate").val("");
	                        $("#info-funeral-anchiEndTime").val("");
	                        $("#info-funeral-anchiTime").bind("focus", function(){
	                        	this.select();
	                        });
	                        //$("#info-funeral-anchiRoom").val("01");
	                        $("#info-funeral-anchiRoom").val("00");
	                        //$("#info-funeral-anchiEndDate").val(new Date().add(2).print("yyyy-mm-dd"));
	                        //$("#info-funeral-anchiEndTime").val("00:00");
	                        $("#info-funeral-anchiEndTime").bind("focus", function(){
	                        	this.select();
	                        });
// 	    					$("#info-funeral-ibkwanDate").val($("#info-funeral-ibkwanDate").val().date().add(1,'d').print('yyyy-mm-dd'));
	    					$("#info-funeral-ibkwanFlg").val("00");
	    					$("#info-funeral-yumFlg").val("01");
	    					$("#info-funeral-yumFlg").change();
	    					$("#info-funeral-funeralGubun").val("1");
	    					$("#info-funeral-balinGubun").val("01");

	    					$("#info-funeral-anchiRoom option").removeAttr("disabled");
	                    	$("#info-funeral-ibsilFlg option").removeAttr("disabled");
	                    	$("#info-funeral-ibkwanFlg option").removeAttr("disabled");
	                    	$("#info-funeral-yumFlg option").removeAttr("disabled");
	                    	$("#info-funeral-balinGubun option").removeAttr("disabled");
							$("#info-funeral-anchiDate").removeAttr("readonly");
							$("#info-funeral-anchiTime").removeAttr("readonly");
							$("#info-funeral-ibsilDate").removeAttr("readonly");
							$("#info-funeral-ibsilTime").removeAttr("readonly");
							$("#info-funeral-ibkwanDate").removeAttr("readonly");
							$("#info-funeral-ibkwanTime").removeAttr("readonly");
							$("#info-funeral-balinDate").removeAttr("readonly");
							$("#info-funeral-balinTime").removeAttr("readonly");
                        }
                    }
                },
                // form

            };
        </script>

    </ax:div>
</ax:layout>