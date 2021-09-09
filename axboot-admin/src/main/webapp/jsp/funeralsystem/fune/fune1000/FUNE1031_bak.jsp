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
                    	 <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    	 <button type="button" class="AXButton Red" id="ax-form-btn-report"><i class="axi axi-report"></i> 임대차계약서</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
               	<ax:form name="form-info" id="form-info">
               		<input type="hidden" id="info-thedead-deadDocGubun" name="deadDocGubun" value="1">
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
                        				<col width="100"/>
                        				<col/>
                        				<col width="100"/>
                        				<col/>
                        			</colgroup>
                        			<tr>
                        				<th><div class='tdRel'>고인번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input readonly="readonly" id="info-thedead-deadId" name="deadId" clazz="W100" title="고인번호"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>고인성명<br>/본관</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-thedead-deadName" name="deadName" title="고인성명" clazz="W100" required="true"></b:input>
                        					<b:input id="info-thedead-familyClan" name="familyClan" clazz="W50" title="본관"></b:input>
<%--                         					<b:inputSelector url="/FUNE1030/familyClan/code" id="info-thedead-familyClanCode" name="familyClanCode" clazz="W100" ></b:inputSelector> --%>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>주민등록번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-thedead-deadJumin" name="deadJumin" pattern="custom" patternString="999999-9999999" maxlength="14" clazz="W130"></b:input>
                        					<input type="hidden" id="info-thedead-deadBirth" name="deadBirth"/>
                       					</div></td>
                        				<th><div class='tdRel'>고인성별<br>/나이</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="TCM05" id="info-thedead-deadSex" name="deadSex" clazz="W100"></b:select>
                        					<b:input id="info-thedead-deadAge" name="deadAge" clazz="W50"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망원인</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="TCM03" id="info-thedead-deadReason" name="deadReason" clazz="W100"></b:select>
                        					<b:input id="info-thedead-deadReasonNm" name="deadReasonNm" clazz="W70" title="사망원인상세"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>사망장소</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="TCM09" id="info-thedead-deadPlace" name="deadPlace" clazz="W130"></b:select>
                        					<b:input id="info-thedead-deadPlaceNm" name="deadPlaceNm" clazz="W70"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망일시</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-thedead-deadDate" name="deadDate" clazz="W100" title="사망일자" pattern="date"></b:input>
                        					<b:input id="info-thedead-deadTime" name="deadTime" pattern="time" clazz="W60" title="사망시간"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>진단서<br>발행처</div>
                        				</th>
                        				<td><div class='tdRel'>
											<b:input id="info-thedead-deadDocnm" name="deadDocnm" clazz="W100" title="진단서발행처"></b:input>
<%-- 											<b:input id="info-thedead-deadDocno" name="deadDocno" clazz="W70" title="진단서번호"></b:input> --%>
											<input id="info-thedead-deadDocno" type="hidden" name="deadDocno" />
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>고인종교<br>/직분</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:select basicCd="TCM06" id="info-thedead-deadFaith" name="deadFaith" clazz="W100"></b:select>
                        					<b:input id="info-thedead-deadFaithNm" name="deadFaithNm" clazz="W70" title="직분"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>주소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
	                        				<input type="text" id="info-thedead-deadPost" name="deadPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
					                        <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
					                        <input type="text" id="info-thedead-deadAddr1" name="deadAddr1" title="사망자 주소"  placeholder="" class="AXInput av-required" style="width:300px;" value="" />
					                        <input type="text" id="info-thedead-deadAddr2" name="deadAddr2" title="사망자 주소"  placeholder="" class="AXInput av-required" style="width:450px;" value="" />
                        				</div></td>
                        			</tr>
                        		</table>
                        		<div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 상주정보</h2>
				                    </div>
				                    <div class="right">
				                    </div>
				                    <div class="ax-clear"></div>
				                </div>
				                <table class='AXFormTable'>
                        			<colgroup>
                        				<col width="100"/>
                        				<col/>
                        				<col width="100"/>
                        				<col/>
                        			</colgroup>
                        			<tr>
                        				<th><div class='tdRel'>상주번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-applId" name="applId" clazz="W100" readonly="readonly"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>상주성명</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-applName" name="applName" title="상주성명" clazz="W100" required="true"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>사망자와의<br>관계</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="TCM08" id="info-funeral-applRelation" name="applRelation" clazz="W100"></b:select>
                        					<b:input id="info-applicant-applRelationNm" name="applRelationNm" clazz="W70" title="사망자와의관계"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>상주생년월일</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-applBirth" name="applBirth" clazz="W100" title="상주생년월일" pattern="date"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>휴대폰</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-mobileno1" name="mobileno1" clazz="W50" pattern="custom" patternString="999" maxlength="3" title="통신사"></b:input>
                        					<b:input id="info-applicant-mobileno2" name="mobileno2" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="국번"></b:input>
                        					<b:input id="info-applicant-mobileno3" name="mobileno3" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="전화번호"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>전화번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-applicant-telno1" name="telno1" clazz="W50" pattern="custom" patternString="999" maxlength="3" title="지역번호"></b:input>
                        					<b:input id="info-applicant-telno2" name="telno2" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="국번"></b:input>
                        					<b:input id="info-applicant-telno3" name="telno3" clazz="W50" pattern="custom" patternString="9999" maxlength="4" title="전화번호"></b:input>
                       					</div></td>
                        			</tr>
                       				<tr>
                        				<th><div class='tdRel'>주소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
	                        				<input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
					                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
					                        <button type="button" class="AXButton" id="btn-same"><i class="axi axi-local-post-office"></i> 상동</button>
					                        <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="상주 주소"  placeholder="" class="AXInput av-required" style="width:255px;" value="" />
					                        <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="상주 주소"  placeholder="" class="AXInput" style="width:450px;" value="" />
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
                       			<div id="div-grid-live" style="height: 200px;"></div>
                       			<b:input id="info-funeral-liveName02" name="liveName02" style="width: 99%;"></b:input>
	                        </ax:custom>
	                        <ax:custom customid="td">
		                        <div class="ax-button-group">
				                    <div class="left">
				                        <h2><i class="axi axi-list-alt"></i> 상례정보</h2>
				                    </div>
				                    <div class="right">
				                    	<label><input id="info-funeral-cremUseGb" name="cremUseGb" type="checkbox" value="1"> 화장</label>
				                    	<label><input id="info-funeral-enshUseGb" name="enshUseGb" type="checkbox" value="1"> 봉안</label>
				                    	<label><input id="info-funeral-natuUseGb" name="natuUseGb" type="checkbox" value="1"> 자연장</label>
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
                        				<th><div class='tdRel'>고객번호</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-funeral-customerNo" name="customerNo" clazz="W100" readonly="readonly"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>빈소</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<select id="info-funeral-binsoCode" name="binsoCode" class="AXSelect W100"></select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>배차일시</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-funeral-transferCarDate" name="transferCarDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-transferCarTime" name="transferCarTime" clazz="W50" pattern="time"></b:input>
                        					<b:select basicCd="TCM10" id="info-funeral-addrPart" name="addrPart" clazz="W100" isspace="true" isspaceTitle="."></b:select>
                       					</div></td>
                        				<th><div class='tdRel'>이송차량업체<br>/금액</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="506" id="info-funeral-transferCarCompany" name="transferCarCompany" clazz="W100" isspace="true"></b:select>
                        					<b:input id="info-funeral-transferCarPrice" name="transferCarPrice"  clazz="W100" title="금액"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>이송차량메모</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-transferCarRemark" name="transferCarRemark" clazz="W400" title="이송차량메모"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>안치일시<br>/안치실</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-anchiDate" name="anchiDate" clazz="W100" title="안치일시" pattern="date"></b:input>
                        					<b:input id="info-funeral-anchiTime" name="anchiTime" clazz="W50" title="안치일시" pattern="time"></b:input>
                        					<b:select basicCd="120" id="info-funeral-anchiRoom" name="anchiRoom" clazz="W100"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>입실일시<br>/구분</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-ibsilDate" name="ibsilDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-ibsilTime" name="ibsilTime" clazz="W50" pattern="time"></b:input>
                        					<b:select basicCd="USE_GB_01" id="info-funeral-ibsilFlg" name="ibsilFlg" clazz="W100"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>입관일시<br>/염습</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-ibkwanDate" name="ibkwanDate" clazz="W100" title="입관일시" pattern="date"></b:input>
                        					<b:input id="info-funeral-ibkwanTime" name="ibkwanTime" clazz="W50" title="입관일시" pattern="time"></b:input>
                        					<b:select basicCd="00" id="info-funeral-ibkwanFlg" name="ibkwanFlg" clazz="W100"></b:select>
                        					<label><input id="info-funeral-makeUp" type="checkbox" name="makeUp" title="시신 Make-Up" value="1"> 시신Make-Up</label>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>발인일시<br>/구분</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-balinDate" name="balinDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-balinTime" name="balinTime" clazz="W50" pattern="time"></b:input>
                        					<b:select basicCd="122" id="info-funeral-balinGubun" name="balinGubun" clazz="W100"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>상조회정보</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="115" id="info-funeral-sangjo" name="sangjo" clazz="W80"></b:select>
                        					<b:input id="info-funeral-sangjoRemark" name="sangjoRemark" clazz="W80" title="상조비고"></b:input>
                        					<b:select basicCd="503" id="info-funeral-usedSangjo" name="usedSangjo" clazz="W80"></b:select>
                       					</div></td>
                        				<th><div class='tdRel'>장지명</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-funeral-jangji" name="jangji" clazz="W200" title="장지명" maxlength="20"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장례구분</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="107" id="info-funeral-funeralGubun" name="funeralGubun" clazz="W100"></b:select>
                       					</div></td>
                        				<th><div class='tdRel'>입관완료여부</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="108" id="info-funeral-ibkwanGubun" name="ibkwanGubun" clazz="W100"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>약물처리여부</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="108" id="info-funeral-embalmingGubun" name="embalmingGubun" clazz="W100"></b:select>
                       					</div></td>
                        				<th><div class='tdRel'>검사지휘서제출</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="108" id="info-funeral-prosecutorCheckGubun" name="prosecutorCheckGubun" clazz="W100"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>전입일자</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:input id="info-funeral-transferDate" name="transferDate" clazz="W100" pattern="date"></b:input>
                       					</div></td>
                        				<th><div class='tdRel'>감면구분</div>
                        				</th>
                        				<td><div class='tdRel'>
                        					<b:select basicCd="TCM12" id="info-funeral-dcGubun" name="dcGubun" clazz="W170"></b:select>
                        					<select id="info-funeral-dcCode" name="dcCode" class="AXSelect W150"></select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>감면메모</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-dcRemark" name="dcRemark" maxlength="50" clazz="W200" style="width:330px"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장의차량일시</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-funeralCarDate" name="funeralCarDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-funeralCarTime" name="funeralCarTime" clazz="W50" pattern="time"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장의차량업체<br>/금액</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:select basicCd="507" id="info-funeral-funeralCarCompany" name="funeralCarCompany" clazz="W80" isspace="true"></b:select>
                        					<b:input id="info-funeral-funeralCarPrice" name="funeralCarPrice"  clazz="W80" title="금액"></b:input>
                        					<b:select basicCd="TMC15" id="info-funeral-funeralCarReceiptGubun" name="funeralCarReceiptGubun" clazz="W80" isspace="true" isspaceTitle="미사용"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>캐딜락업체<br>/금액</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:select basicCd="507" id="info-funeral-cadillacCompany" name="cadillacCompany" clazz="W80" isspace="true"></b:select>
                        					<b:input id="info-funeral-cadillacPrice" name="cadillacPrice"  clazz="W80" title="금액"></b:input>
                        					<b:select basicCd="TMC15" id="info-funeral-cadillacReceiptGubun" name="cadillacReceiptGubun" clazz="W80" isspace="true" isspaceTitle="미사용"></b:select>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장의차량메모</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-funeralCarRemark" name="funeralCarRemark" maxlength="100" style="width: 480px;" title="장의차량메모"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>출관예절<br>/장소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-coffinOutDate" name="coffinOutDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-coffinOutTime" name="coffinOutTime" clazz="W50" pattern="time"></b:input>
                        					<b:input id="info-funeral-coffinOutPlace" name="coffinOutPlace" clazz="80" maxlength="20" title="장소"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>장례미사<br>/장소</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-massDate" name="massDate" clazz="W100" pattern="date"></b:input>
                        					<b:input id="info-funeral-massTime" name="massTime" clazz="W50" pattern="time"></b:input>
                        					<b:input id="info-funeral-massPlace" name="massPlace" clazz="80" maxlength="20"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>메모</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:input id="info-funeral-remark" name="remark" maxlength="200" style="width: 480px;" title="전체메모"></b:input>
                       					</div></td>
                        			</tr>
                        			<tr>
                        				<th><div class='tdRel'>상담자</div>
                        				</th>
                        				<td colspan="3"><div class='tdRel'>
                        					<b:select url="/FUNE1030/employee/options" id="info-funeral-counselor" name="counselor" clazz="W80" isspace="true" isspaceTitle="-"></b:select>
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
		                        				<th><div class='tdRel'>신청자<br>주민등록번호</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:input id="info-applicant-applJumin" name="applJumin" clazz="W130" pattern="custom" patternString="999999-9999999" maxlength="14" title="주민등록번호"></b:input>
		                       					</div></td>
		                        				<th><div class='tdRel'>국적</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TCM04" id="info-applicant-nationGb" name="nationGb" clazz="W100"></b:select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>주소지코드</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-thedead-addrCode" name="addrCode" class="AXSelect W150"></select>
		                       					</div></td>
		                        				<th><div class='tdRel'>사망자국적구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TCM04" id="info-thedead-nationGb" name="nationGb" clazz="W100"></b:select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
			                        			<th><div class='tdRel'>사산사유<br>/임신주수</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
													<b:input id="info-thedead-sasansayu" name="sasansayu" clazz="W100" title="사산사유"></b:input>
													<b:input id="info-thedead-bunmanwol" name="bunmanwol" maxlength="2" clazz="W50" title="임신주수"></b:input>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>화장대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TMC03" id="info-funeral-cremObjt" name="cremObjt" clazz="W100"></b:select>
		                       					</div></td>
		                        				<th><div class='tdRel'>유/분골</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TMC05" id="info-funeral-cremBoneGb" name="cremBoneGb" clazz="W100" ></b:select>
		                       					</div></td>
	                       					</tr>
	                       					<tr>
		                        				<th><div class='tdRel'>유골처리구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TMC06" id="info-funeral-cremScatterPlace" name="cremScatterPlace" clazz="W100"></b:select>
		                       					</div></td>
		                        				<th><div class='tdRel'>감면사유구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
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
		                        					<b:select basicCd="TFM08" id="info-funeral-enshObjt" name="enshObjt" clazz="W100"></b:select>
		                       					</div></td>
		                        				<th><div class='tdRel'>봉안단</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TFM10" id="info-funeral-enshEnsType" name="enshEnsType" clazz="W100"></b:select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>감면사유구분</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
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
	                       			<div id="div-natu-contents">
		                        		<div class="ax-button-group">
						                    <div class="left">
						                        <h2><i class="axi axi-list-alt"></i>자연장정보</h2>
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
		                        				<th><div class='tdRel'>자연장대상구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TFM14" id="info-funeral-natuObjt" name="natuObjt" clazz="W100"></b:select>
		                       					</div></td>
		                        				<th><div class='tdRel'>안치구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TFM10" id="info-funeral-natuNatKind" name="natuNatKind" clazz="W100"></b:select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>자연장구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<b:select basicCd="TFM16" id="info-funeral-natuNatType" name="natuNatType" clazz="W100"></b:select>
		                       					</div></td>
		                        				<th><div class='tdRel'>감면사유구분</div>
		                        				</th>
		                        				<td><div class='tdRel'>
		                        					<select id="info-funeral-natuDcCode" name="natuDcCode" class="AXSelect W150"></select>
		                       					</div></td>
		                        			</tr>
		                        			<tr>
		                        				<th><div class='tdRel'>비고</div>
		                        				</th>
		                        				<td colspan="3"><div class='tdRel'>
		                        					<b:input id="info-funeral-natuRemark" name="natuRemark" maxlength="50" style="width: 480px;"></b:input>
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

                defaultFunc: {
                	selectBinso: function(){
                		$("#info-funeral-binsoCode").bindSelectSetValue("${param.binsoCode}");
                	}
                	, searchFuneral: function(){
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE1030/funeral?customerNo=${param.customerNo}",
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.message);
                        	}else{
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
	                	, natu: null
                	},
                	bindDynamicForm: function(){
                    	$("#info-funeral-cremUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.crem);
//     			                $("#info-funeral-cremDcCode").bindSelect({
//     			                	options: JSON.parse('<b:optionJson url="/FUNE1030/dcRate/code/option" jobGubun="C"></b:optionJson>'),
//     			                    isspace: true,
//     			                    isspaceTitle: "-"
// //    		 	                    setValue: "3"
//     			                });
    			                $("#info-funeral-cremDcCode").selectBox({
    			                	url: "/FUNE1030/dcRate/code/option?jobGubun=C"
   			            			, method: "get"
   			            			, isspace: true
   			            			, isspaceTitle: "-"
   			            			, value: "3"
//    			            			, index: 5
   			            			, reserveKey: {
   			            				optionRoot: ""
   			            				, optionValue: "optionValue"
   			            				, optionText: "optionText"
   			            			}
    			                });
    			                $("#info-thedead-addrCode").bindSelect({
    		                		options:Common.addr.getAddrCode()
    		                	});
    			                $("#info-thedead-deadAddr1").change();
    						}else{
    							$(fnObj.dynamicForm.form.crem).remove();
    						}
    					});
    					$("#info-funeral-enshUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.ensh);
    							$("#info-funeral-enshDcCode").bindSelect({
    			                    options: JSON.parse('<b:optionJson url="/FUNE1030/dcRate/code/option" jobGubun="E"></b:optionJson>'),
    			                    isspace: true,
    			                    isspaceTitle: "-"
//    		 	                    setValue: "3"
    			                });
    							$("#info-funeral-natuUseGb").removeAttr("checked");
    							$("#info-funeral-natuUseGb").change();
    						}else{
    							$(fnObj.dynamicForm.form.ensh).remove();
    						}
    					});
    					$("#info-funeral-natuUseGb").bind("change", function(){
    						if(this.checked){
    							$("#div-dynamic-form").append(fnObj.dynamicForm.form.natu);
    							$("#info-funeral-natuDcCode").bindSelect({
    			                	options: JSON.parse('<b:optionJson url="/FUNE1030/dcRate/code/option" jobGubun="N"></b:optionJson>'),
    			                    isspace: true,
    			                    isspaceTitle: "-"
//    		 	                    setValue: "3"
    			                });
    							$("#info-funeral-enshUseGb").removeAttr("checked");
    							$("#info-funeral-enshUseGb").change();
    						}else{
    							$(fnObj.dynamicForm.form.natu).remove();
    						}
    					});

    					fnObj.dynamicForm.form.crem = $("#div-crem-contents").remove();
    					fnObj.dynamicForm.form.ensh = $("#div-ensh-contents").remove();
    					fnObj.dynamicForm.form.natu = $("#div-natu-contents").remove();

                    }
                },
                bindEvent: function(){
                	var _this = this;
                    $("#ax-page-btn-save").bind("click", function(){
                    	_this.save();
                    });
                    $("#ax-form-btn-new").bind("click", function(){
                    	fnObj.form.clear(true);
                    	$("#info-funeral-binsoCode").bindSelect({
		                    ajaxUrl: "/FUNE1030/binso/assignable/code/option/ajax",
		                    ajaxPars: "",
		                    isspace: false,
		                    setValue: "${param.binsoCode}"
		                });
                    	fnObj.gridLive.target.setData({list: [{}, {}, {}, {}, {}, {}]});
                    });
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-thedead-deadPost", "info-thedead-deadAddr1", "info-thedead-deadAddr2");
                    });
	                $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
                   	});
	                if("" != "${param.customerNo}"){
	                	$("#info-funeral-binsoCode").bindSelect({
		                    ajaxUrl: "/FUNE1030/binso/assigned/code/option/ajax",
		                    ajaxPars: "customerNo=${param.customerNo}",
		                    isspace: false,
		                });
	                }else{
		                $("#info-funeral-binsoCode").bindSelect({
		                    ajaxUrl: "/FUNE1030/binso/assignable/code/option/ajax",
		                    ajaxPars: "",
		                    isspace: false,
		                    setValue: "${param.binsoCode}"
		                });
	                }
	                $("#info-funeral-dcCode").bindSelect({
	                    ajaxUrl: "/FUNE1030/dcRate/code/option/ajax",
	                    ajaxPars: "jobGubun=F",
	                    isspace: true,
	                    isspaceTitle: "-"
// 	                    setValue: "3"
	                });

 	                fnObj.dynamicForm.bindDynamicForm();

					$("#info-funeral-returnGubun").bindSelectDisabled(true);
					$("#info-funeral-returnPrice, #info-funeral-returnRemark").prop("disabled", true);
					$("#info-funeral-returnCheck").bind("change", function(){
						$("#info-funeral-returnGubun").bindSelectDisabled(!this.checked);
						$("#info-funeral-returnPrice, #info-funeral-returnRemark").prop("disabled", !this.checked);
					});

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
						$("#info-thedead-deadSex").bindSelectSetValue(Common.str.getGender($("#info-thedead-deadJumin").val()));
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
					$("#info-funeral-sangjoRemark").bind("focus", function(){
						if($(this).val() == ""){
							var sangjo = $("#info-funeral-sangjo").bindSelectGetValue().optionText;
							$(this).val(sangjo);
						}
					})
					$("#info-applicant-applPost, #info-applicant-applAddr1, #info-applicant-applAddr2").bind("keyup", function(e){
						if(e.keyCode==36){
							$("#btn-same").click();
						}
					});
					$("#info-funeral-transferCarPrice").bindMoney()
					$("#info-funeral-funeralCarPrice").bindMoney()
					$("#info-funeral-cadillacPrice").bindMoney()
					$("#info-funeral-liveName02").bind("keyup", function(e){
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
					$("#info-funeral-transferDate").bind("change", function(){
						app.ajax({
	                        type: "GET",
	                        url: "/FUNE1030/dcCode",
	                        // String addrPart, String addr1, String dcGubun, Date transferDate
	                        data: "addrPart="+$("#info-funeral-addrPart").bindSelectGetValue().optionValue
	                        		+"&addr1="+$("#info-thedead-deadAddr1").val()
	                        		+"&dcGubun="+$("#info-funeral-dcGubun").bindSelectGetValue().optionValue
	                        		+"&transferDate="+$("#info-funeral-transferDate").val()
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.message);
	                    	}else{
	                            var dcCode = res.map.dcCode;
	                            var funeDcCode = dcCode.funeDcCode;
	                            var cremDcCode = dcCode.funeDcCode;
	                            var enshDcCode = dcCode.funeDcCode;
	                            var natuDcCode = dcCode.funeDcCode;

	                            $("#info-funeral-dcCode").bindSelectSetValue(funeDcCode);
	                            $("#info-funeral-cremDcCode").bindSelectSetValue(cremDcCode);
	                            $("#info-funeral-enshDcCode").bindSelectSetValue(enshDcCode);
	                            $("#info-funeral-natuDcCode").bindSelectSetValue(natuDcCode);
	                        }
	                    });
					});
					$("#ax-form-btn-report").bind("click", function(){
						var path = "/reports/changwon/fune/FUNE8011";
	                	var output = "pdf";
	                	var frameId = "reportDisplay";
	                	var params = "CUSTOMER_NO="+$("#info-funeral-customerNo").val();
	                	Common.report.open(path, output, params, frameId);
					})

                },
                report: {
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

                    var data = fnObj.form.getJSON();
                    if(data.ibsilFlg == "1" && +data.binsoCode < 800){
                    	if(data.ibsilDate == ""){
                    		alert("입실일시를 입력해 주세요.");
                    		$("#info-funeral-ibsilDate").fucus();
                    		return;
                    	}
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
                    		alert(res.message);
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
                    		alert(res.message);
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
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"0", label:"관계", width:"70", align:"center", editor: "text", sort: false},
                                {key:"1", label:"1", width:"70", align:"center", editor: "text", sort: false},
                                {key:"2", label:"2", width:"70", align:"center", editor: "text", sort: false},
                                {key:"3", label:"3", width:"70", align:"center", editor: "text", sort: false},
                                {key:"4", label:"4", width:"70", align:"center", editor: "text", sort: false},
                                {key:"5", label:"5", width:"70", align:"center", editor: "text", sort: false},
                                {key:"6", label:"6", width:"70", align:"center", editor: "text", sort: false},
                                {key:"7", label:"7", width:"70", align:"center", editor: "text", sort: false},
                                {key:"8", label:"8", width:"70", align:"center", editor: "text", sort: false},
                                {key:"9", label:"9", width:"70", align:"center", editor: "text", sort: false},
                                {key:"10", label:"10", width:"70", align:"center", editor: "text", sort: false},
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

                        for(var i=0;i<6;i++){
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
                    setJSON: function(item) {
                        var _this = this;
						this.clear(false);
                        var info = $.extend({}, item);
                        var checked = function(val){
                        	return val == "1";
                        }
                        if(checked(info.cremUseGb)){
                        	$("#info-funeral-cremUseGb").attr("checked", true);
                        	$("#info-funeral-cremUseGb").change();
                        }
                        if(checked(info.enshUseGb)){
                        	$("#info-funeral-enshUseGb").attr("checked", true);
                        	$("#info-funeral-enshUseGb").change();
                        }
                        if(checked(info.natuUseGb)){
                        	$("#info-funeral-natuUseGb").attr("checked", true);
                        	$("#info-funeral-natuUseGb").change();
                        }
                        if(checked(info.makeUp)){
                        	$("#info-funeral-makeUp").attr("checked", true);
                        }

                        var toHhmi = function(date){
                        	if(date){
                        		return date.date().print("hh:mi");
                        	}else{
                        		return "";
                        	}
                        }
                        info.transferCarTime = toHhmi(info.transferCarDate);
						info.anchiTime = toHhmi(info.anchiDate);
                    	info.ibsilTime = toHhmi(info.ibsilDate);
                    	info.ibkwanTime = toHhmi(info.ibkwanDate);
                    	info.balinTime = toHhmi(info.balinDate);
                    	info.coffinOutTime = toHhmi(info.coffinOutDate);
                    	info.funeralCarTime = toHhmi(info.funeralCarDate);

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

                    },
                    getJSON: function() {
                    	var funeral = app.form.serializeObjectWithIds(this.target, 'info-funeral-');
                    	var thedead = app.form.serializeObjectWithIds(this.target, 'info-thedead-');
                    	var applicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-');
                    	funeral.deadId = thedead.deadId;
                    	funeral.applId = applicant.applId;
                    	funeral.thedead =thedead;
                    	funeral.applicant = applicant;

                    	var defaultTime = function(time){
                    		return !time || time == "" ? "00:00" : time;
                    	}

                    	if(funeral.transferCarDate != ""){
	                    	funeral.transferCarDate = funeral.transferCarDate+" "+funeral.transferCarTime;
	                    	funeral.transferCarDate = funeral.transferCarDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.anchiDate != ""){
	                    	funeral.anchiDate = funeral.anchiDate+" "+funeral.anchiTime;
	                    	funeral.anchiDate = funeral.anchiDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.ibsilDate != ""){
	                    	funeral.ibsilDate = funeral.ibsilDate+" "+funeral.ibsilTime;
	                    	funeral.ibsilDate = funeral.ibsilDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.ibkwanDate != ""){
	                    	funeral.ibkwanDate = funeral.ibkwanDate+" "+funeral.ibkwanTime;
	                    	funeral.ibkwanDate = funeral.ibkwanDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.balinDate != ""){
	                    	funeral.balinDate = funeral.balinDate+" "+funeral.balinTime;
	                    	funeral.balinDate = funeral.balinDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.coffinOutDate != ""){
	                    	funeral.coffinOutDate = funeral.coffinOutDate+" "+funeral.coffinOutTime;
	                    	funeral.coffinOutDate = funeral.coffinOutDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.funeralCarDate != ""){
	                    	funeral.funeralCarDate = funeral.funeralCarDate+" "+funeral.funeralCarTime;
	                    	funeral.funeralCarDate = funeral.funeralCarDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	if(funeral.massDate != ""){
	                    	funeral.massDate = funeral.massDate+" "+funeral.massTime;
	                    	funeral.massDate = funeral.massDate.date().print("yyyy-mm-dd hh:mi");
                    	}
                    	funeral.transferCarPrice = Common.str.replaceAll(funeral.transferCarPrice, ",", "");
                    	funeral.funeralCarPrice = Common.str.replaceAll(funeral.funeralCarPrice, ",", "");
                    	funeral.cadillacPrice = Common.str.replaceAll(funeral.cadillacPrice, ",", "");

                    	funeral.makeUp = funeral.makeUp == '1' ? 1 : 0;

//                     	var checked = function(val){
//                     		return "on" == val ? 1 : 0;
//                     	}
//                     	funeral.cremUseGb = checked(funeral.cremUseGb);
//                     	funeral.enshUseGb = checked(funeral.enshUseGb);
//                     	funeral.natuUseGb = checked(funeral.natuUseGb);

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
                        if(isDefault == true){
	                        $("#info-funeral-balinDate").val(new Date().add(2).print("yyyy-mm-dd"));
	    					$("#info-funeral-ibkwanDate").val($("#info-funeral-ibkwanDate").val().date().add(1,'d').print('yyyy-mm-dd'));
	    					$("#info-funeral-ibkwanFlg").bindSelectSetValue("01");
	    					$("#info-funeral-funeralGubun").bindSelectSetValue("1");
                        }
                    }
                },
                // form

            };
        </script>

    </ax:div>
</ax:layout>