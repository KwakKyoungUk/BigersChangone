<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j"%>
<%
String appName = AppContextManager.getAppContext().getEnvironment().getProperty("spring.application.name");
request.setAttribute("APP_NAME", appName);
%>
<ax:layout name="base.jsp">
	<ax:set name="title" value="${APP_NAME }" />
	<ax:div name="css">
		<style type="text/css">
</style>
	</ax:div>
	<ax:div name="header">
		<h1 id="cx-page-title" style="margin-left: 0px;">
			<i class="axi axi-dvr"></i> ${APP_NAME }
		</h1>
		<p class="desc"></p>
	</ax:div>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">

				<ax:custom customid="table">
					<ax:custom customid="tr">
						<ax:custom customid="td">

							<div class="ax-button-group">
								<div class="left">
									<h2>
										<i class="axi axi-notifications"></i> 공지사항
									</h2>
								</div>
								<div class="right">
									<!--
                                    <button type="button" class="AXButton Classic" id="notice-refresh" onclick="fnObj.grid.reload();"><i class="axi axi-ion-refresh"></i> 새로고침</button>
                                    <button type="button" class="AXButton Classic" id="notice-more" onclick="app.link_to('/jsp/system/system-operation-notice.jsp');">목록가기</button>
                                    -->
								</div>
								<div class="ax-clear"></div>
							</div>

							<div class="ax-grid" id="grid-notice" style="height: 230px;"></div>

						</ax:custom>
					</ax:custom>
					<ax:custom customid="tr">
						<ax:custom customid="td" style="width:40%;">

							<div class="ax-button-group">
								<div class="left">
									<h2>
										<i class="axi axi-phone"></i> 서비스 담당자
									</h2>
								</div>
								<div class="ax-clear"></div>
							</div>

							<table cellpadding="0" cellspacing="0" class="AXGridTable">
								<colgroup>
									<col width="60" />
									<col width="110" />
									<col />
								</colgroup>
								<thead>
									<tr align="center">
										<td>
											<div class="tdRel">구분</div>
										</td>
										<td>
											<div class="tdRel">적용시간대</div>
										</td>
										<td>
											<div class="tdRel">전화번호</div>
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="center" rowspan="3">비거스넷</td>
										<td align="center">평일 영업시간<br /> (10시 ~ 18시)
										</td>
										<td align="center" rowspan="3">032-527-5702</td>
									</tr>
									<tr>
										<td align="center">평일 영업시간 외</td>
									</tr>
									<tr>
										<td align="center">주말 / 공휴일</td>
									</tr>

								</tbody>
							</table>

						</ax:custom>
					</ax:custom>
					<ax:custom customid="tr">
						<ax:custom customid="td" style="width:40%;">
							<div class="ax-button-group">
								<div class="left">
									<h2>
										<i class="axi axi-phone"></i> 매뉴얼
									</h2>
								</div>
								<div class="right">
								</div>
								<div class="ax-clear"></div>
							</div>
							<table cellpadding="0" cellspacing="0" class="AXGridTable">
								<colgroup>
									<col width="350" />
									<col width="500" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<td align="center">구분
										</td>
										<td align="center">링크
										</td>
										<td align="center">비고
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td align="center">전체
										</td>
										<td align="center"><a href="/static/doc/매뉴얼.zip">매뉴얼.zip</a>
										</td>
										<td align="center">
										</td>
									</tr>
									<tr>
										<td align="center">운영자지침서
										</td>
										<td align="center"><a href="/static/doc/05.10.운영자지침서(통합운영시스템).doc" target="_blank">운영자지침서(통합운영시스템).pdf</a>
										</td>
										<td align="center">
										</td>
									</tr>
									<tr>
										<td align="center">장례식장
										</td>
										<td align="center"><a href="/static/doc/05.20.01.통합운영시스템_사용자매뉴얼(장례식장).doc" target="_blank">통합운영시스템_사용자매뉴얼(장례식장).pdf</a>
										</td>
										<td align="center">
										</td>
									</tr>
									<tr>
										<td align="center">화장봉안
										</td>
										<td align="center"><a href="/static/doc/05.20.02.통합운영시스템_사용자매뉴얼(화장봉안).doc" target="_blank">통합운영시스템_사용자매뉴얼(화장/봉안).pdf</a>
										</td>
										<td align="center">
										</td>
									</tr>
									<tr>
										<td align="center">공통
										</td>
										<td align="center"><a href="/static/doc/05.20.03.통합운영시스템_사용자매뉴얼(공통).doc" target="_blank">통합운영시스템_사용자매뉴얼(공통).pdf</a>
										</td>
										<td align="center">
										</td>
									</tr>
								</tbody>
							</table>
						</ax:custom>
					</ax:custom>
					<ax:custom customid="tr">
						<ax:custom customid="td" style="width:40%;">

							<div class="ax-button-group">
								<div class="left">
									<h2>
										<i class="axi axi-phone"></i> 다운로드
									</h2>
								</div>
								<div class="right">
								</div>
								<div class="ax-clear"></div>
							</div>

							<table cellpadding="0" cellspacing="0" class="AXGridTable">
								<colgroup>
									<col width="150" />
									<col width="400" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<td align="center">구분
										</td>
										<td align="center">링크
										</td>
										<td align="center">비고
										</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="tdRel" align="center">원격 프로그램
										</td>
										<td><a href="https://www.teamviewer.com/ko/download/previous-versions/" target="_blank">TeamViewer11 Download</a>
										</td>
										<td rowspan="2">
										</td>
									</tr>
									<tr>
										<td class="tdRel" align="center">TossPGPOS 설치 프로그램
										</td>
										<td>
											<a href="/static/downloads/TossPGPOSInstall(1.0.1.0)_20200825.exe">TossPGPOSInstall(1.0.1.0)_20200825.exe</a><br>
										</td>
									</tr>
								</tbody>
							</table>
						</ax:custom>
					</ax:custom>
				</ax:custom>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="scripts">
		<script>
			// location.href = "${pageContext.request.contextPath}/jsp/resv/RESV1010.jsp"
			// 기타매출 컬럼 정보
			/*
			etcColumns =
			[
			    {"key":"etc1Amt","label":"기타결제 A","width":"80", "align":"right"},
			    {"key":"etc2Amt","label":"상품권","width":"80", "align":"right"},
			    {"key":"etc3Amt","label":"기타결제 3","width":"80", "align":"right"}
			];
			 */
		</script>
		<script type="text/javascript"
			src="<c:url value='/static/js/view/main.js' />"></script>
	</ax:div>
</ax:layout>
