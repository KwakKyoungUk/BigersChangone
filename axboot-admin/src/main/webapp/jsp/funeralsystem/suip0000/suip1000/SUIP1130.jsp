<!----------------------------------------------------------------------------------------
* @program		:	appReg.jsp
* @description	:	전자결재 ( 장례식장  )
* @author		:	noo
* @create		:	2014.04.15
* @update		:	수정일 없음
* @version		:	0.1
* @descripiton	:	업데이트 내용 없음
------------------------------------------------------------------------------------------>
<%@page import="java.util.Optional"%>
<%@page import="com.axisj.axboot.core.util.CommonUtils"%>
<%@page import="net.bigers.funeralsystem.suip0000.domain.appmng.AppMngDataSrch"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.lang.String" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.DateFormat" %>
<%@ page import = "java.util.Calendar" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "org.springframework.beans.support.PagedListHolder" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<%

	// 검색조건:
	AppMngDataSrch	appMngDataSrchSearch = null;
	appMngDataSrchSearch = (AppMngDataSrch)request.getAttribute( "appMngDataSrch" );

	if( appMngDataSrchSearch == null ){
		appMngDataSrchSearch = new AppMngDataSrch();
		request.setAttribute("appMngDataSrch", appMngDataSrchSearch);
	}


	//  ms sql server에 insert 후 max seq 가져오기
	AppMngDataSrch	appMngDataSrchSearchMaxSeq = null;
	appMngDataSrchSearchMaxSeq = (AppMngDataSrch)request.getAttribute( "appMngDataSrchSearch" );

	if( appMngDataSrchSearchMaxSeq == null ){
		appMngDataSrchSearchMaxSeq = new AppMngDataSrch();
		request.setAttribute("appMngDataSrchSearch", appMngDataSrchSearchMaxSeq);
	}


	// 로그인 아이디
	String id = CommonUtils.getCurrentLoginUserCd();
	request.setAttribute("id", id);

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String today = formatter.format(new java.util.Date());
	request.setAttribute("today", today);


	//최대값 : seq
	long sFirstSeq = (appMngDataSrchSearchMaxSeq.getSeq() != null) ?  appMngDataSrchSearchMaxSeq.getSeq(): 0;
	System.out.println("Max first Seq : " + sFirstSeq);

	//두 번째 최대값 : seq
	long sSecondSeq = (appMngDataSrchSearchMaxSeq.getSecondseq() != null) ?  appMngDataSrchSearchMaxSeq.getSecondseq(): 0;
	System.out.println("Max second Seq : " + sSecondSeq);



	// ----- 숫자에 3 자리 마다 컴마 찍기시작  -- //
	// --------------------------------- //

	// 장례식장 수입금 계 (선결제 제외) 건수 당일
	int ccntSum011 =  appMngDataSrchSearch.getCcntSum011();
	DecimalFormat  df = new DecimalFormat("###,###");
	String dfccntSum011 = df.format(ccntSum011);

    // 장례식장 수입금 계 (선결제 제외) 건수 월계
	int mcntSum012 =  appMngDataSrchSearch.getMcntSum012();
	String dfmcntSum012 = df.format(mcntSum012);

    // 장례식장 수입금 계 (선결제 제외) 건수 연계
	int tcntSum013 =  appMngDataSrchSearch.getTcntSum013();
	String dftcntSum013 = df.format(tcntSum013);

    // 장례식장 수입금 계 (선결제 제외) 합계 당일
    long camtSum021 =  appMngDataSrchSearch.getCamtSum021();
	String dfcamtSum021 = df.format(camtSum021);

    // 장례식장 수입금 계 (선결제 제외) 합계 월계
    long mamtSum022 =  appMngDataSrchSearch.getMamtSum022();
	String dfmamtSum022 = df.format(mamtSum022);

    // 장례식장 수입금 계 (선결제 제외) 합계 연계
    long tamtSum023 =  appMngDataSrchSearch.getTamtSum023();
	String dftamtSum023 = df.format(tamtSum023);

	// 장례식장 사용료 계 건수 당일
	long ccntSum031 =  appMngDataSrchSearch.getCcntSum031();
	String dfccntSum031 = df.format(ccntSum031);

	// 장례식장 사용료 계 금액 당일
	long camtSum032 =  appMngDataSrchSearch.getCamtSum032();
	String dfcamtSum032 = df.format(camtSum032);

	// 장례식장 사용료 계 월계 건수
	long mcntSum033 =  appMngDataSrchSearch.getMcntSum033();
	String dfmcntSum033 = df.format(mcntSum033);

	// 장례식장 사용료 계 월계 금액
	long mamtSum034 =  appMngDataSrchSearch.getMamtSum034();
	String dfmamtSum034 = df.format(mamtSum034);

	// 장례식장 사용료 계  연계 건수
	long tcntSum035 =  appMngDataSrchSearch.getTcntSum035();
	String dftcntSum035 = df.format(tcntSum035);

	// 장례식장 사용료 계  연계  금액
	long tamtSum036 =  appMngDataSrchSearch.getTamtSum036();
	String dftamtSum036 = df.format(tamtSum036);

	// POS 사용용품 계 당일 건수
	long ccntSum041 =  appMngDataSrchSearch.getCcntSum041();
	String dfccntSum041 = df.format(ccntSum041);

	// POS 사용용품 계 당일 금액
	long camtSum042 =  appMngDataSrchSearch.getCamtSum042();
	String dfcamtSum042 = df.format(camtSum042);

	// POS 사용용품 계 월계 건수
	long mcntSum043 =  appMngDataSrchSearch.getMcntSum043();
	String dfmcntSum043 = df.format(mcntSum043);

	// POS 사용용품 계 월계 금액
	long mamtSum044 =  appMngDataSrchSearch.getMamtSum044();
	String dfmamtSum044 = df.format(mamtSum044);

	// POS 사용용품 계  연계 건수
	long tcntSum045 =  appMngDataSrchSearch.getTcntSum045();
	String dftcntSum045 = df.format(tcntSum045);

	// POS 사용용품 계  연계 금액
	long tamtSum046 =  appMngDataSrchSearch.getTamtSum046();
	String dftamtSum046 = df.format(tamtSum046);

	// 선결제 화장장 계 당일 건수
	long ccntSum051 =  appMngDataSrchSearch.getCcntSum051();
	String dfccntSum051 = df.format(ccntSum051);

	// 선결제 화장장 계 당일 금액
	long camtSum052 =  appMngDataSrchSearch.getCamtSum052();
	String dfcamtSum052 = df.format(camtSum052);

	// 선결제 화장장 계 월계 건수
	long mcntSum053 =  appMngDataSrchSearch.getMcntSum053();
	String dfmcntSum053 = df.format(mcntSum053);

	// 선결제 화장장 계 월계 금액
	long mamtSum054 =  appMngDataSrchSearch.getMamtSum054();
	String dfmamtSum054 = df.format(mamtSum054);

	// 선결제 화장장 계 연계 건수
	long tcntSum055 =  appMngDataSrchSearch.getTcntSum055();
	String dftcntSum055 = df.format(tcntSum055);

	// 선결제 화장장 계 연계 금액
	long tamtSum056 =  appMngDataSrchSearch.getTamtSum056();
	String dftamtSum056 = df.format(tamtSum056);

	// 선결제 봉안당 계 당일 건수
	long ccntSum061 =  appMngDataSrchSearch.getCcntSum061();
	String dfccntSum061 = df.format(ccntSum061);

	// 선결제 봉안당 계 당일 금액
	long camtSum062 =  appMngDataSrchSearch.getCamtSum062();
	String dfcamtSum062 = df.format(camtSum062);

	// 선결제 봉안당 계 월계 건수
	long mcntSum063 =  appMngDataSrchSearch.getMcntSum063();
	String dfmcntSum063 = df.format(mcntSum063);

	// 선결제 봉안당 계 월계 금액
	long mamtSum064 =  appMngDataSrchSearch.getMamtSum064();
	String dfmamtSum064 = df.format(mamtSum064);

	// 선결제 봉안당 계 연계 건수
	long tcntSum065 =  appMngDataSrchSearch.getTcntSum065();
	String dftcntSum065 = df.format(tcntSum065);

	// 선결제 봉안당 계 연계 금액
	long tamtSum066 =  appMngDataSrchSearch.getTamtSum066();
	String dftamtSum066 = df.format(tamtSum066);

	// 정산총액(선결제 포함) 당일 금액
	long camtSum072 =  appMngDataSrchSearch.getCamtSum072();
	String dfcamtSum072 = df.format(camtSum072);

	// 정산총액(선결제 포함) 월계 금액
	long mamtSum074 =  appMngDataSrchSearch.getMamtSum074();
	String dfmamtSum074 = df.format(mamtSum074);

	// 정산총액(선결제 포함) 연계 금액
	long tamtSum076 =  appMngDataSrchSearch.getTamtSum076();
	String dftamtSum076 = df.format(tamtSum076);

	// 시설사용료(선결제 포함) 총계 당일 건수
	long ccntSum081 =  appMngDataSrchSearch.getCcntSum081();
	String dfccntSum081 = df.format(ccntSum081);

	// 시설사용료(선결제 포함) 총계  당일 금액
	long camtSum082 =  appMngDataSrchSearch.getCamtSum082();
	String dfcamtSum082 = df.format(camtSum082);

	// 시설사용료(선결제 포함) 총계  월계 건수
	long mcntSum083 =  appMngDataSrchSearch.getMcntSum083();
	String dfmcntSum083 = df.format(mcntSum083);

	// 시설사용료(선결제 포함) 총계  월계 금액
	long mamtSum084 =  appMngDataSrchSearch.getMamtSum084();
	String dfmamtSum084 = df.format(mamtSum084);

	// 시설사용료(선결제 포함) 총계  연계 건수
	long tcntSum085 =  appMngDataSrchSearch.getTcntSum085();
	String dftcntSum085 = df.format(tcntSum085);

	// 시설사용료(선결제 포함) 총계  연계 금액
	long tamtSum086 =  appMngDataSrchSearch.getTamtSum086();
	String dftamtSum086 = df.format(tamtSum086);

	// 시설사용료 장례식장사용료 소계  당일 건수
	long ccntSum091 =  appMngDataSrchSearch.getCcntSum091();
	String dfccntSum091 = df.format(ccntSum091);

	// 시설사용료 장례식장사용료 소계  당일 금액
	long camtSum092 =  appMngDataSrchSearch.getCamtSum092();
	String dfcamtSum092 = df.format(camtSum092);

	// 시설사용료 장례식장사용료 소계  월계 건수
	long mcntSum093 =  appMngDataSrchSearch.getMcntSum093();
	String dfmcntSum093 = df.format(mcntSum093);

	// 시설사용료 장례식장사용료 소계  월계 금액
	long mamtSum094 =  appMngDataSrchSearch.getMamtSum094();
	String dfmamtSum094 = df.format(mamtSum094);

	// 시설사용료 장례식장사용료 소계  연계 건수
	long tcntSum095 =  appMngDataSrchSearch.getTcntSum095();
	String dftcntSum095 = df.format(tcntSum095);

	// 시설사용료 장례식장사용료 소계  연계 금액
	long tamtSum096 =  appMngDataSrchSearch.getTamtSum096();
	String dftamtSum096 = df.format(tamtSum096);


	// 시설사용료 빈소 관내  당일 건수
	long ccntSum101 =  appMngDataSrchSearch.getCcntSum101();
	String dfccntSum101 = df.format(ccntSum101);

	// 시설사용료 빈소 관내  당일 금액
	long camtSum102 =  appMngDataSrchSearch.getCamtSum102();
	String dfcamtSum102 = df.format(camtSum102);

	// 시설사용료 빈소 관내  월계 건수
	long mcntSum103 =  appMngDataSrchSearch.getMcntSum103();
	String dfmcntSum103 = df.format(mcntSum103);

	// 시설사용료 빈소 관내  월계 금액
	long mamtSum104 =  appMngDataSrchSearch.getMamtSum104();
	String dfmamtSum104 = df.format(mamtSum104);

	// 시설사용료 빈소 관내  연계 건수
	long tcntSum105 =  appMngDataSrchSearch.getTcntSum105();
	String dftcntSum105 = df.format(tcntSum105);

	// 시설사용료 빈소 관내  연계 금액
	long tamtSum106 =  appMngDataSrchSearch.getTamtSum106();
	String dftamtSum106 = df.format(tamtSum106);

	// 시설사용료 빈소 관외  당일 건수
	long ccntSum111 =  appMngDataSrchSearch.getCcntSum111();
	String dfccntSum111 = df.format(ccntSum111);

	// 시설사용료 빈소 관외  당일 금액
	long camtSum112 =  appMngDataSrchSearch.getCamtSum112();
	String dfcamtSum112 = df.format(camtSum112);

	// 시설사용료 빈소 관외  월계 건수
	long mcntSum113 =  appMngDataSrchSearch.getMcntSum113();
	String dfmcntSum113 = df.format(mcntSum113);

	// 시설사용료 빈소 관외  월계 금액
	long mamtSum114 =  appMngDataSrchSearch.getMamtSum114();
	String dfmamtSum114 = df.format(mamtSum114);

	// 시설사용료 빈소 관외  연계 건수
	long tcntSum115 =  appMngDataSrchSearch.getTcntSum115();
	String dftcntSum115 = df.format(tcntSum115);

	// 시설사용료 빈소 관외  연계 금액
	long tamtSum116 =  appMngDataSrchSearch.getTamtSum116();
	String dftamtSum116 = df.format(tamtSum116);

	// 시설사용료 접객실 관내  당일 건수
	long ccntSum121 =  appMngDataSrchSearch.getCcntSum121();
	String dfccntSum121 = df.format(ccntSum121);

	// 시설사용료 접객실 관내  당일 금액
	long camtSum122 =  appMngDataSrchSearch.getCamtSum122();
	String dfcamtSum122 = df.format(camtSum122);

	// 시설사용료 접객실 관내  월계 건수
	long mcntSum123 =  appMngDataSrchSearch.getMcntSum123();
	String dfmcntSum123 = df.format(mcntSum123);

	// 시설사용료 접객실 관내  월계 금액
	long mamtSum124 =  appMngDataSrchSearch.getMamtSum124();
	String dfmamtSum124 = df.format(mamtSum124);

	// 시설사용료 접객실 관내  연계 건수
	long tcntSum125 =  appMngDataSrchSearch.getTcntSum125();
	String dftcntSum125 = df.format(tcntSum125);

	// 시설사용료 접객실 관내  연계 금액
	long tamtSum126 =  appMngDataSrchSearch.getTamtSum126();
	String dftamtSum126 = df.format(tamtSum126);

	// 시설사용료 접객실 관외  당일 건수
	long ccntSum131 =  appMngDataSrchSearch.getCcntSum131();
	String dfccntSum131 = df.format(ccntSum131);

	// 시설사용료 접객실 관외  당일 금액
	long camtSum132 =  appMngDataSrchSearch.getCamtSum132();
	String dfcamtSum132 = df.format(camtSum132);

	// 시설사용료 접객실 관외  월계 건수
	long mcntSum133 =  appMngDataSrchSearch.getMcntSum133();
	String dfmcntSum133 = df.format(mcntSum133);

	// 시설사용료 접객실 관외  월계 금액
	long mamtSum134 =  appMngDataSrchSearch.getMamtSum134();
	String dfmamtSum134 = df.format(mamtSum134);

	// 시설사용료 접객실 관외  연계 건수
	long tcntSum135 =  appMngDataSrchSearch.getTcntSum135();
	String dftcntSum135 = df.format(tcntSum135);

	// 시설사용료 접객실 관외  연계 금액
	long tamtSum136 =  appMngDataSrchSearch.getTamtSum136();
	String dftamtSum136 = df.format(tamtSum136);

	// 시설사용료 추가접객실 관내  당일 건수
	long ccntSum141 =  appMngDataSrchSearch.getCcntSum141();
	String dfccntSum141 = df.format(ccntSum141);

	// 시설사용료 추가접객실 관내  당일 금액
	long camtSum142 =  appMngDataSrchSearch.getCamtSum142();
	String dfcamtSum142 = df.format(camtSum142);

	// 시설사용료 추가접객실 관내  월계 건수
	long mcntSum143 =  appMngDataSrchSearch.getMcntSum143();
	String dfmcntSum143 = df.format(mcntSum143);

	// 시설사용료 추가접객실 관내  월계 금액
	long mamtSum144 =  appMngDataSrchSearch.getMamtSum144();
	String dfmamtSum144 = df.format(mamtSum144);

	// 시설사용료 추가접객실 관내  연계 건수
	long tcntSum145 =  appMngDataSrchSearch.getTcntSum145();
	String dftcntSum145 = df.format(tcntSum145);

	// 시설사용료 추가접객실 관내  연계 금액
	long tamtSum146 =  appMngDataSrchSearch.getTamtSum146();
	String dftamtSum146 = df.format(tamtSum146);

	// 시설사용료 추가접객실 관외  당일 건수
	long ccntSum151 =  appMngDataSrchSearch.getCcntSum151();
	String dfccntSum151 = df.format(ccntSum151);

	// 시설사용료 추가접객실 관외  당일 금액
	long camtSum152 =  appMngDataSrchSearch.getCamtSum152();
	String dfcamtSum152 = df.format(camtSum152);

	// 시설사용료 추가접객실 관외  월계 건수
	long mcntSum153 =  appMngDataSrchSearch.getMcntSum153();
	String dfmcntSum153 = df.format(mcntSum153);

	// 시설사용료 추가접객실 관외  월계 금액
	long mamtSum154 =  appMngDataSrchSearch.getMamtSum154();
	String dfmamtSum154 = df.format(mamtSum154);

	// 시설사용료 추가접객실 관외  연계 건수
	long tcntSum155 =  appMngDataSrchSearch.getTcntSum155();
	String dftcntSum155 = df.format(tcntSum155);

	// 시설사용료 추가접객실 관외  연계 금액
	long tamtSum156 =  appMngDataSrchSearch.getTamtSum156();
	String dftamtSum156 = df.format(tamtSum156);

	// 시설사용료 안치실 관내  당일 건수
	long ccntSum161 =  appMngDataSrchSearch.getCcntSum161();
	String dfccntSum161 = df.format(ccntSum161);

	// 시설사용료 안치실 관내  당일 금액
	long camtSum162 =  appMngDataSrchSearch.getCamtSum162();
	String dfcamtSum162 = df.format(camtSum162);

	// 시설사용료 안치실 관내  월계 건수
	long mcntSum163 =  appMngDataSrchSearch.getMcntSum163();
	String dfmcntSum163 = df.format(mcntSum163);

	// 시설사용료 안치실 관내  월계 금액
	long mamtSum164 =  appMngDataSrchSearch.getMamtSum164();
	String dfmamtSum164 = df.format(mamtSum164);

	// 시설사용료 안치실 관내  연계 건수
	long tcntSum165 =  appMngDataSrchSearch.getTcntSum165();
	String dftcntSum165 = df.format(tcntSum165);

	// 시설사용료 안치실 관내  연계 금액
	long tamtSum166 =  appMngDataSrchSearch.getTamtSum166();
	String dftamtSum166 = df.format(tamtSum166);


	// 시설사용료 안치실 관외  당일 건수
	long ccntSum171 =  appMngDataSrchSearch.getCcntSum171();
	String dfccntSum171 = df.format(ccntSum171);

	// 시설사용료 안치실 관외  당일 금액
	long camtSum172 =  appMngDataSrchSearch.getCamtSum172();
	String dfcamtSum172 = df.format(camtSum172);

	// 시설사용료 안치실 관외  월계 건수
	long mcntSum173 =  appMngDataSrchSearch.getMcntSum173();
	String dfmcntSum173 = df.format(mcntSum173);

	// 시설사용료 안치실 관외  월계 금액
	long mamtSum174 =  appMngDataSrchSearch.getMamtSum174();
	String dfmamtSum174 = df.format(mamtSum174);

	// 시설사용료 안치실 관외  연계 건수
	long tcntSum175 =  appMngDataSrchSearch.getTcntSum175();
	String dftcntSum175 = df.format(tcntSum175);

	// 시설사용료 안치실 관외  연계 금액
	long tamtSum176 =  appMngDataSrchSearch.getTamtSum176();
	String dftamtSum176 = df.format(tamtSum176);

	// 시설사용료 염습실 관내  당일 건수
	long ccntSum181 =  appMngDataSrchSearch.getCcntSum181();
	String dfccntSum181 = df.format(ccntSum181);

	// 시설사용료 염습실 관내  당일 금액
	long camtSum182 =  appMngDataSrchSearch.getCamtSum182();
	String dfcamtSum182 = df.format(camtSum182);

	// 시설사용료 염습실 관내  월계 건수
	long mcntSum183 =  appMngDataSrchSearch.getMcntSum183();
	String dfmcntSum183 = df.format(mcntSum183);

	// 시설사용료 염습실 관내  월계 금액
	long mamtSum184 =  appMngDataSrchSearch.getMamtSum184();
	String dfmamtSum184 = df.format(mamtSum184);

	// 시설사용료 염습실 관내  연계 건수
	long tcntSum185 =  appMngDataSrchSearch.getTcntSum185();
	String dftcntSum185 = df.format(tcntSum185);

	// 시설사용료 염습실 관내  연계 금액
	long tamtSum186 =  appMngDataSrchSearch.getTamtSum186();
	String dftamtSum186 = df.format(tamtSum186);

	// 시설사용료 염습실 관외  당일 건수
	long ccntSum191 =  appMngDataSrchSearch.getCcntSum191();
	String dfccntSum191 = df.format(ccntSum191);

	// 시설사용료 염습실 관외  당일 금액
	long camtSum192 =  appMngDataSrchSearch.getCamtSum192();
	String dfcamtSum192 = df.format(camtSum192);

	// 시설사용료 염습실 관외  월계 건수
	long mcntSum193 =  appMngDataSrchSearch.getMcntSum193();
	String dfmcntSum193 = df.format(mcntSum193);

	// 시설사용료 염습실 관외  월계 금액
	long mamtSum194 =  appMngDataSrchSearch.getMamtSum194();
	String dfmamtSum194 = df.format(mamtSum194);

	// 시설사용료 염습실 관외  연계 건수
	long tcntSum195 =  appMngDataSrchSearch.getTcntSum195();
	String dftcntSum195 = df.format(tcntSum195);

	// 시설사용료 염습실 관외  연계 금액
	long tamtSum196 =  appMngDataSrchSearch.getTamtSum196();
	String dftamtSum196 = df.format(tamtSum196);

	// 시설사용료 염습료  당일 건수
	long ccntSum201 =  appMngDataSrchSearch.getCcntSum201();
	String dfccntSum201 = df.format(ccntSum201);

	// 시설사용료 염습료  당일 금액
	long camtSum202 =  appMngDataSrchSearch.getCamtSum202();
	String dfcamtSum202 = df.format(camtSum202);

	// 시설사용료 염습료  월계 건수
	long mcntSum203 =  appMngDataSrchSearch.getMcntSum203();
	String dfmcntSum203 = df.format(mcntSum203);

	// 시설사용료 염습료  월계 금액
	long mamtSum204 =  appMngDataSrchSearch.getMamtSum204();
	String dfmamtSum204 = df.format(mamtSum204);

	// 시설사용료 염습료  연계 건수
	long tcntSum205 =  appMngDataSrchSearch.getTcntSum205();
	String dftcntSum205 = df.format(tcntSum205);

	// 시설사용료 염습료  연계 금액
	long tamtSum206 =  appMngDataSrchSearch.getTamtSum206();
	String dftamtSum206 = df.format(tamtSum206);

	// 시설사용료 추가발생  당일 건수
	long ccntSum211 =  appMngDataSrchSearch.getCcntSum211();
	String dfccntSum211 = df.format(ccntSum211);

	// 시설사용료 추가발생  당일 금액
	long camtSum212 =  appMngDataSrchSearch.getCamtSum212();
	String dfcamtSum212 = df.format(camtSum212);

	// 시설사용료 추가발생  월계 건수
	long mcntSum213 =  appMngDataSrchSearch.getMcntSum213();
	String dfmcntSum213 = df.format(mcntSum213);

	// 시설사용료 추가발생  월계 금액
	long mamtSum214 =  appMngDataSrchSearch.getMamtSum214();
	String dfmamtSum214 = df.format(mamtSum214);

	// 시설사용료추가발생  연계 건수
	long tcntSum215 =  appMngDataSrchSearch.getTcntSum215();
	String dftcntSum215 = df.format(tcntSum215);

	// 시설사용료 추가발생  연계 금액
	long tamtSum216 =  appMngDataSrchSearch.getTamtSum216();
	String dftamtSum216 = df.format(tamtSum216);


    // ----- 숫자에 3 자리 마다 컴마 찍기 종료  --- //
	// ----------------------------------- //



	// 작업일자
	String workDate = ( String )request.getParameter("workDate");
	// 총원
	String totWorker = ( String )request.getParameter("totWorker");

	// 현원
	String curWorker = ( String )request.getParameter("curWorker");
	// 사고
	String actWorker = ( String )request.getParameter("actWorker");
	// 출장
	String outWorker = ( String )request.getParameter("outWorker");
	// 교육
	String eduWorker = ( String )request.getParameter("eduWorker");
	// 년월차
	String ymcWorker = ( String )request.getParameter("ymcWorker");
	// 기타
	String othWorker = ( String )request.getParameter("othWorker");
	// 사고자
	String acsWorker = ( String )request.getParameter("acsWorker");

	// 정산총액(선결제 포함)
	String StamtSum234 = ( String )request.getParameter("tamtSum234");
	System.out.println("정산총액(선결제 포함) :" + StamtSum234 );

	// 기타
	String Others = ( String )request.getParameter("others");
	//기타에서 Enter값을 없애고 br로 대체
	//Others = Others.replace("\r\n","<br>");

	//String insertOthers =  (Others != null)  ?  Others.replace("\r\n","<br>") :  Others;
	String insertOthers =  (Others != null)  ?  Others.replace("\r\n","") :  Others;
	// 2014. 07.03
	insertOthers = insertOthers + "\r\n" ;

    String year ="";
	String month ="";
	String day ="";
	String dates = "";
	String workdate = "";

	try {

	  // yyyy: year, MM:Month, dd: day, E:요일
	  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddE");
	  SimpleDateFormat dateParse = new SimpleDateFormat ("yyyyMMdd");

	  //현재날짜
	  DateFormat formatters = new SimpleDateFormat("yyyyMMdd");
	  String dateTime = formatters.format( Calendar.getInstance().getTime()) ;

	  System.out.println("dateTime :" + dateTime);

	  Date date = new Date();
	 // workDate = (workDate != null) ? workDate : dateTime;


	 if ( workDate != null) {
	  date = dateParse.parse(workDate);
	  workdate = dateFormat.format(date);
	  year = workdate.substring(0, 4);
      month = workdate.substring(4, 6);
      day = workdate.substring(6, 8);
      dates = workdate.substring(8, 9);
	 }

	} catch (Exception e)	{
		e.printStackTrace();
	}

	//String seconddata  = "";

	//업무ID:상복 장례식장 수입일보 : 0000000rt
		String frmId = "0000000rt";

	request.setAttribute("frmId", frmId);

		String data  = frmId + "|" + year + "|" + month + "|" + day + "|" + dates + "|" +
		totWorker + "|" + curWorker + "|" + actWorker + "|" + eduWorker + "|" + ymcWorker + "|" +
		outWorker + "|" +
		othWorker + "|" + acsWorker + "|" +
	    dfccntSum011 + "|" +
	    dfmcntSum012 + "|" +
	    dftcntSum013 + "|" +
	    dfcamtSum021 + "|" +
	    dfmamtSum022 + "|" +
	    dftamtSum023 + "|" +
	    dfccntSum031 + "|" +
	    dfcamtSum032 + "|" +
	    dfmcntSum033 + "|" +
	    dfmamtSum034 + "|" +
	    dftcntSum035 + "|" +
	    dftamtSum036 + "|" +
	    dfccntSum041 + "|" +
	    dfcamtSum042 + "|" +
	    dfmcntSum043 + "|" +
	    dfmamtSum044 + "|" +
	    dftcntSum045 + "|" +
	    dftamtSum046 + "|" +
	    dfccntSum051 + "|" +
	    dfcamtSum052 + "|" +
	    dfmcntSum053 + "|" +
	    dfmamtSum054 + "|" +
	    dftcntSum055 + "|" +
	    dftamtSum056 + "|" +
	    dfccntSum061 + "|" +
	    dfcamtSum062 + "|" +
	    dfmcntSum063 + "|" +
	    dfmamtSum064 + "|" +
	    dftcntSum065 + "|" +
	    dftamtSum066 + "|" +
	    "-" + "|" +
	    dfcamtSum072 + "|" +
	    "-" + "|" +
	    dfmamtSum074 + "|" +
	    "-" + "|" +
	    dftamtSum076 + "|" +
	    dfccntSum081 + "|" +
	    dfcamtSum082 + "|" +
	    dfmcntSum083 + "|" +
	    dfmamtSum084 + "|" +
	    dftcntSum085 + "|" +
	    dftamtSum086 + "|" +
	    dfccntSum091 + "|" +
	    dfcamtSum092 + "|" +
	    dfmcntSum093 + "|" +
	    dfmamtSum094 + "|" +
	    dftcntSum095 + "|" +
	    dftamtSum096 + "|" +
	    dfccntSum101 + "|" +
	    dfcamtSum102 + "|" +
	    dfmcntSum103 + "|" +
	    dfmamtSum104 + "|" +
	    dftcntSum105 + "|" +
	    dftamtSum106 + "|" +
	    dfccntSum111 + "|" +
	    dfcamtSum112 + "|" +
	    dfmcntSum113 + "|" +
	    dfmamtSum114 + "|" +
	    dftcntSum115 + "|" +
	    dftamtSum116 + "|" +
	    dfccntSum121 + "|" +
	    dfcamtSum122 + "|" +
	    dfmcntSum123 + "|" +
	    dfmamtSum124 + "|" +
	    dftcntSum125 + "|" +
	    dftamtSum126 + "|" +
	    dfccntSum131 + "|" +
	    dfcamtSum132 + "|" +
	    dfmcntSum133 + "|" +
	    dfmamtSum134 + "|" +
	    dftcntSum135 + "|" +
	    dftamtSum136 + "|" +
	    dfccntSum141 + "|" +
	    dfcamtSum142 + "|" +
	    dfmcntSum143 + "|" +
	    dfmamtSum144 + "|" +
	    dftcntSum145 + "|" +
	    dftamtSum146 + "|" +
	    dfccntSum151 + "|" +
	    dfcamtSum152 + "|" +
	    dfmcntSum153 + "|" +
	    dfmamtSum154 + "|" +
	    dftcntSum155 + "|" +
	    dftamtSum156 + "|" +
	    dfccntSum161 + "|" +
	    dfcamtSum162 + "|" +
	    dfmcntSum163 + "|" +
	    dfmamtSum164 + "|" +
	    dftcntSum165 + "|" +
	    dftamtSum166 + "|" +
	    dfccntSum171 + "|" +
	    dfcamtSum172 + "|" +
	    dfmcntSum173 + "|" +
	    dfmamtSum174 + "|" +
	    dftcntSum175 + "|" +
	    dftamtSum176 + "|" +
	    dfccntSum181 + "|" +
	    dfcamtSum182 + "|" +
	    dfmcntSum183 + "|" +
	    dfmamtSum184 + "|" +
	    dftcntSum185 + "|" +
	    dftamtSum186 + "|" +
	    dfccntSum191 + "|" +
	    dfcamtSum192 + "|" +
	    dfmcntSum193 + "|" +
	    dfmamtSum194 + "|" +
	    dftcntSum195 + "|" +
	    dftamtSum196 + "|" +
	    dfccntSum201 + "|" +
	    dfcamtSum202 + "|" +
	    dfmcntSum203 + "|" +
	    dfmamtSum204 + "|" +
	    dftcntSum205 + "|" +
	    dftamtSum206 + "|" +
	    dfccntSum211 + "|" +
	    dfcamtSum212 + "|" +
	    dfmcntSum213 + "|" +
	    dfmamtSum214 + "|" +
	    dftcntSum215 + "|" +
	    dftamtSum216 + "|" +
	    insertOthers;

		request.setAttribute("data", data);
%>

<c:set var="mainForm">

	<form name="mainform" >
		<input type="hidden" name="actionTp">

		<input name="frmName" type="hidden"  value="장사통합@SANG장례식장운영일지">
		<input name="frmId" type="hidden"    value="${frmId }">
		<input name="data" type="hidden"  value="${data }">

		<input name="id" type="hidden"  value="${id }">
		<input name="updtime" type="hidden"  value="${today }">

<%-- 		<input name="tamtSum234" type="hidden"  value="${appMngDataSrch.tamtSum234 }"> --%>
		<input name="tamtSum234" type="hidden"  value="${appMngDataSrch.tamtSum076 }">
		<input name="sFirstSeq" type="hidden"  value="<%=sFirstSeq%>">

		<table width="960" border="0" cellspacing="0" cellpadding="0" height="60" align="center">
			<tr>  <td class="main_bg_top"></td> </tr>
		  	<tr>
		    <td class="main_bg_line">
			<!--컨텐츠삽입부분시작-->
			<table width="940" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td align="center" valign="top">

				<!--오른쪽 부분 시작 -->
					<table border="0" cellspacing="0" cellpadding="5" width="95%">
				  <tr><td colspan="2" class="bg_001"></td>  </tr>
				  <tr>
				    <td colspan="2" class="bg_w">
					  <!-- 프로그램 시작 -->
					  <table width="98%" border="0" cellspacing="0" cellpadding="3" >

						  <tr>

						    <td width="20" align="left"  ><span style="white-space:nowrap">
							 <strong>&nbsp;작업일자</strong>
		                     <input id="workDate" name="workDate" type="text" class="AXInput W150" value="${param.workDate }"
		                     numeric ondblclick="popUpCalendarNoDash(this);" onclick=""
		                     size="8"  maxLength="8" required numeric>&nbsp;&nbsp;&nbsp;&nbsp;


							<button class="AXButton" onclick="javascript:goList();">검색</button>


							<button class="AXButton" onclick="javascript:goMssqlInsert();">저장</button>


							<input type = "button" class="AXButton" value = "전자결재" onclick="popupApp();">

							</span>

							</td>

						  </tr>


							<tr> <td height="10"></td></tr>
							<tr> <td class="bar_02"></td> </tr>
							<tr> <td height="10"></td> </tr>
							<tr>
							<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >

					    <tr>
							<td>&nbsp;총원
							<input  name="totWorker" class="AXInput" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="${param.totWorker eq '' ? '0' : param.totWorker }" >
							</td>

							<td>현원
							<input class="AXInput" name="curWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="${param.curWorker eq '' ? '0' : param.curWorker }" >
							</td>

							<td>사고
							<input class="AXInput" name="actWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="${param.actWorker eq '' ? '0' : param.actWorker }" >
							</td>

							<td>교육
							<input class="AXInput" name="eduWorker"  style="text-align:leftt;" type="text" size="5" value="${param.eduWorker}" >
							</td>

							<td>연월차
							<input class="AXInput" name="ymcWorker"  style="text-align:leftt;" type="text" size="5" value="${param.ymcWorker}" >
							</td>

							<td>관외출장
							<input class="AXInput" name="outWorker"  style="text-align:leftt;" type="text" size="5" value="${param.outWorker}" >
							</td>

							<td>기타
							<input class="AXInput" name="othWorker"  style="text-align:left;" type="text" size="5" value="${param.othWorker}" >
							</td>

							<td>사고자
							<input class="AXInput" name="acsWorker" type="text" size="40" value="${param.acsWorker}" >
							</td>
					   </tr>

							<tr> <td height="10"></td> 	</tr>

							<tr> <td height="10"></td> </tr>

							<tr> <td height="10"></td> </tr>

							</table>


							</td>
							</tr>

							<tr>
							<td align="center">
		 <div>

		 <table width="692" height="580" border="1" cellpadding="0" cellspacing="0" class="AXGridTable">

		    <tr>
		        <td width="170" height="60" align="center" rowspan="3" colspan="4">
		            <p>장례식장 수입금 계</p>
		            <p>&nbsp;</p>
		            <p>(선결제 제외)</p>
		        </td>
		        <td width="51" height="20" align="center">구분</td>
		        <td width="139" colspan="2" height="20" align="center">당일</td>
		        <td width="106" colspan="2" height="20" align="center">월계</td>
		        <td width="117" colspan="2" height="20" align="center">연계</td>
		    </tr>
		    <tr>

		        <td width="51" height="23" align="center">건수</td>
		        <td width="139" colspan="2" height="20" align="right"><b><%= Optional.ofNullable( dfccntSum011 ).orElse( "0" ) %></b></td>
		        <td width="106" colspan="2" height="20" align="right"><b><%= Optional.ofNullable( dfmcntSum012 ).orElse( "0" ) %></b></td>
		        <td width="117" colspan="2" height="20" align="right"><b><%= Optional.ofNullable( dftcntSum013 ).orElse( "0" ) %></b></td>
		    </tr>
		    <tr>
		        <td width="51" height="20" align="center">합계</td>
		        <td width="139" colspan="2" height="20" align="right"><b><%= dfcamtSum021 %></b></td>
		        <td width="106" colspan="2" height="20" align="right"><b><%= dfmamtSum022 %></b></td>
		        <td width="117" colspan="2" height="20" align="right"><b><%= dftamtSum023 %></b></td>
		    </tr>
		    <tr>
		        <td width="299" height="20" align="center" colspan="5">
		            <p>구분</p>
		        </td>
		        <td width="68" height="20" align="center">건수</td>
		        <td width="64" height="20" align="center">금액</td>
		        <td width="35" height="20" align="center">건수</td>
		        <td width="64" height="20" align="center">금액</td>
		        <td width="37" height="20" align="center">건수</td>
		        <td width="73" height="20" align="center">금액</td>
		    </tr>
		    <tr>
		        <td width="299" height="20" align="center" colspan="5">
		            <p>장례식장 사용료 계</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum031 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum032 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum033 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum034 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum035 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum036 %></td>
		    </tr>
		    <tr>
		        <td width="299" height="20" align="center" colspan="5">
		            <p>POS 사용용품 계</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum041 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum042 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum043 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum044 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum045 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum046 %></td>
		    </tr>
		    <tr>
		        <td width="74" height="47" align="center" rowspan="2">선결제</td>
		        <td width="218" height="20" align="center" colspan="4">화장장 계</td>
		        <td width="68" height="20" align="right"><%= dfccntSum051 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum052 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum053 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum054 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum055 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum056 %></td>
		    </tr>
		    <tr>
		        <td width="218" height="20" align="center" colspan="4">봉안당 계</td>
		        <td width="68" height="20" align="right"><%= dfccntSum061 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum062 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum063 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum064 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum065 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum066 %></td>
		    </tr>
		    <tr>

		        <td width="299" height="20" align="center" colspan="5">
		            <p>정산총액(선결제 포함)</p>
		        </td>
		       <!--  <td width="68" height="20" align="right"><%= appMngDataSrchSearch.getCcntSum071()%></td> -->
		        <td width="68" height="20" align="center">-</td>
		        <td width="64" height="20" align="right"><%= dfcamtSum072 %></td>
		        <!-- <td width="35" height="20" align="right"><%= appMngDataSrchSearch.getMcntSum073()%></td> -->
		        <td width="35" height="20" align="center">-</td>
		        <td width="64" height="20" align="right"><%= dfmamtSum074 %></td>
		       <!--  <td width="37" height="20" align="right"><%= appMngDataSrchSearch.getTcntSum075()%></td> -->
		        <td width="37" height="20" align="center">-</td>
		        <td width="73" height="20" align="right"><%= dftamtSum076 %></td>
		    </tr>
		    <tr>
		        <td width="299" height="20" align="center" colspan="5">
		            <p>구분</p>
		        </td>
		        <td width="68" height="20" align="center">건수</td>
		        <td width="64" height="20" align="center">금액</td>
		        <td width="35" height="20" align="center">건수</td>
		        <td width="64" height="20" align="center">금액</td>
		        <td width="37" height="20" align="center">건수</td>
		        <td width="73" height="20" align="center">금액</td>
		    </tr>
		    <tr>

		        <td width="299" height="20" align="center" colspan="5">
		            <p>시설사용료(선결제 포함) 총계</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum081 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum082 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum083 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum084 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum085 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum086 %></td>
		    </tr>
		    <tr>
		        <td width="80" height="260" align="center" rowspan="13" colspan="2">
		            <p>&nbsp;</p>
		            <p>시</p>
		            <p>&nbsp;</p>
		            <p>설</p>
		            <p>&nbsp;</p>
		            <p>사</p>
		            <p>&nbsp;</p>
		            <p>용</p>
		            <p>&nbsp;</p>
		            <p>료</p>
		        </td>
		        <td width="212" height="20" colspan="3" align="center">
		            <p>장례식장사용료 소계</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum091 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum092 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum093 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum094 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum095 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum096 %></td>
		    </tr>
		    <tr>
		        <td width="109" height="40" rowspan="2" align="center">
		            <p>빈소</p>
		        </td>
		        <td width="96" height="20" colspan="2" align="center">관내</td>
		        <td width="68" height="20" align="right"><%= dfccntSum101 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum102 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum103 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum104 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum105 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum106 %></td>
		    </tr>
		    <tr>
		        <td width="96" height="20" colspan="2" align="center">관외</td>
		        <td width="68" height="20" align="right"><%= dfccntSum111 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum112 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum113 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum114 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum115 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum116 %></td>
		    </tr>
		    <tr>
		        <td width="109" height="40" rowspan="2" align="center">
		           <p>접객실</p>
		        </td>
		        <td width="96" height="20" colspan="2" align="center">관내</td>
		        <td width="68" height="20" align="right"><%= dfccntSum121 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum122 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum123 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum124 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum125 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum126 %></td>
		    </tr>
		    <tr>
		        <td width="96" height="20" colspan="2" align="center">관외</td>
		        <td width="68" height="20" align="right"><%= dfccntSum131 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum132 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum133 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum134 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum135 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum136 %></td>
		    </tr>
		    <tr>
		        <td width="109" height="40" rowspan="2" align="center">
		           <p>추가접객실</p>
		        </td>
		        <td width="96" height="20" colspan="2" align="center">관내</td>
		        <td width="68" height="20" align="right"><%= dfccntSum141 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum142 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum143 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum144 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum145 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum146 %></td>
		    </tr>
		    <tr>
		        <td width="96" height="20" colspan="2" align="center">관외</td>
		        <td width="68" height="20" align="right"><%= dfccntSum151 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum152 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum153 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum154 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum155 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum156 %></td>
		    </tr>
		    <tr>
		        <td width="109" height="40" rowspan="2" align="center">
		            <p>안치실</p>
		        </td>
		        <td width="96" height="20" colspan="2" align="center">관내</td>
		        <td width="68" height="20" align="right"><%= dfccntSum161 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum162 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum163 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum164 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum165 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum166 %></td>
		    </tr>
		    <tr>
		        <td width="96" height="20" colspan="2" align="center">관외</td>
		        <td width="68" height="20" align="right"><%= dfccntSum171 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum172 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum173 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum174 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum175 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum176 %></td>
		    </tr>
		    <tr>
		        <td width="109" height="40" rowspan="2" align="center">
		           <p>염습실</p>
		        </td>
		        <td width="96" height="20" colspan="2" align="center">관내</td>
		        <td width="68" height="20" align="right"><%= dfccntSum181 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum182 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum183 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum184 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum185 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum186 %></td>
		    </tr>
		    <tr>
		        <td width="96" height="20" colspan="2" align="center">관외</td>
		        <td width="68" height="20" align="right"><%= dfccntSum191 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum192 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum193 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum194 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum195 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum196 %></td>
		    </tr>
		    <tr>
		        <td width="212" height="20" colspan="3" align="center">
		            <p>염습료</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum201 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum202 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum203 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum204 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum205 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum206 %></td>
		    </tr>
		    <tr>
		        <td width="212" height="20" colspan="3" align="center">
		            <p>추가발생</p>
		        </td>
		        <td width="68" height="20" align="right"><%= dfccntSum211 %></td>
		        <td width="64" height="20" align="right"><%= dfcamtSum212 %></td>
		        <td width="35" height="20" align="right"><%= dfmcntSum213 %></td>
		        <td width="64" height="20" align="right"><%= dfmamtSum214 %></td>
		        <td width="37" height="20" align="right"><%= dftcntSum215 %></td>
		        <td width="73" height="20" align="right"><%= dftamtSum216 %></td>
		    </tr>
		    <tr>
		        <td width="80" height="28" align="center" rowspan="3" colspan="2">
		            <p>&nbsp;</p>
		            <p>기</p>
		            <p>&nbsp;</p>
		            <p>타</p>
		        </td>

		        <td width="800" height="28" align="center" rowspan="3" colspan="9">
		         <textarea rows="5" cols="100" name="others" wrap="soft" ><%= Optional.ofNullable( Others ).orElse( "" )%></textarea>
		        </td>
		    </tr>

		   </table>

		  </div>
						</td>
						</tr>
						<tr>
						<Td>

						</td>
					</tr>
				 <!-- 프로그램 끝 -->
					</table>
				<!--오른쪽 부분 끝 -->
				</td>
			  </tr>
			</table>
			<!--컨텐츠삽입부분끝-->
			</td>
		  </tr>
		  <tr>
		    <td class="main_bg_bottom"></td>
		  </tr>
		</table>



	</form>

</c:set>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> ${PAGE_NAME}</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                ${mainForm }
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/plugins/axisj/lib/AXInput.js"></script>
        <script>

			/**
			 * @param
			 * @return
			 * @description :  장례식장 수입일보 테이블(suip_ilbo_new)에 insert 후 select 작업
			 */
				function goList(){

					mainform.actionTp.value = "appMngDataSrchList";

					if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
					  alert("날짜를 입력하세요");
					  mainform.workDate.focus();
					  return;
					}

					// 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
					if ( !beforeInsertCheck()) {
						return;
					}

					mainform.target			= "_self";
					mainform.method			= "post";
					mainform.action			= "/SUIP1130/appMng?actionTp=appMngDataSrchList";

					mainform.submit();

				}


				/**
			    * @param
			    * @return
			    * @description :  ms sql server에 dbo.TB_PAYMENT 테이블에 insert  작업( insert 후 select도 하고 max seq도 순차적으로 한다.)
			    */

				function goMssqlInsert(){

			    	//alert (mainform.secondData.value);
					if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
					  alert("날짜를 입력하세요");
					  mainform.workDate.focus();
					  return;
					}

					// 정산총액(선결제 포함) 값이 0보다 큰지 체크 즉 검색을 했는지
					if( mainform.tamtSum234.value == "0" || mainform.tamtSum234.value == null ) {
					  alert("검색을 하시고 난 후에 저장하세요");
					  return;
					}

					// 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
					if ( !beforeInsertCheck()) {
						return;
					}
					// 2014 06 02 noo end
					//alert (mainform.secondData.value);

				    mainform.actionTp.value = "appMngDataSrchInsert";

					mainform.target			= "_self";
					mainform.method			= "post";
					mainform.action			= "/SUIP1130/appMng?actionTp=appMngDataSrchInsert";

				    mainform.submit();
				}



				//숫자만 입력하는 함수 2014 04 17 noo
				function checkNumber(){

				 if( (event.keyCode < 48) || (event.keyCode > 57) ){
				  event.returnValue = false;
				  alert("숫자만 입력하십시오");

				}
			   }


				/**
				    * @param
				    * @return
				    * @description :  ms sql server에 dbo.TB_PAYMENT 테이블에 insert  하기 전에  총원, 현원,사고 숫자 체크 2014 06 02 noo start
			    */
			    function beforeInsertCheck() {

				  // 총원
				  var  totWorker =   mainform.totWorker.value;
				  totWorker = parseInt(totWorker);

				  // 현원
				  var  curWorker =   mainform.curWorker.value;
				  curWorker = parseInt(curWorker);

				  // 사고
				  var  actWorker =   mainform.actWorker.value;
				  actWorker = parseInt(actWorker);

				  // 현원 더하기 사고
				  var curWorkeractWorker = curWorker + actWorker;
				  curWorkeractWorker = parseInt(curWorkeractWorker);

				  // 사고자들
				  var  acsWorker =   mainform.acsWorker.value;

				  if ( totWorker < 1 ) {
					  alert ("총원은 1 이상 이어야 합니다.");
					  return false;
				  }
				  if ( curWorker < 1 ) {
					  alert ("현원은 1 이상 이어야 합니다.");
					  return false;
				  }
				  if ( totWorker < curWorker ) {
					  alert ("현원은 총원보다 크면 안 됩니다.");
					  return false;
				  }
				  if ( totWorker < actWorker ) {
					  alert ("사고는 총원보다 크면 안 됩니다.");
					  return false;
				  }
				  if ( totWorker < curWorkeractWorker ) {
					  alert ("현원과 사고를 더한 숫자가 총원보다 큽니다.");
					  return false;
				  }
				  if ( totWorker > curWorkeractWorker ) {
					  alert ("현원과 사고를 더한 숫자가 총원보다 작습니다.");
					  return false;
				  }
				  if (  (actWorker >= 1) && (acsWorker == null) || (actWorker >= 1) && (acsWorker == "")  ) {
					  alert ("사고가 1 이상 이므로 사고자 내역을 입력하십시오.");
					  return false;
				  }

				  return true;
				}


				// 전자결재 popup
				function popupApp(){
				 var sFirstSeq =  mainform.sFirstSeq.value;

				 var settings = 'toolbar=no,directories=no, status=no,menubar=no,scrollbars=auto,resizable=no,height=600,width=800,left=0,top=0';
				 var url = 'http://112.1.160.254/ORADBTEST/ErpApproval.asp?DBGbn=JSJ&sSeq=' + sFirstSeq;


				 if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
					  alert("날짜를 입력하세요");
					  mainform.workDate.focus();
					  return;
				 }

				 // 정산총액(선결제 포함) 값이 0보다 큰지 체크 즉 검색을 했는지
				 if( mainform.tamtSum234.value == "0" || mainform.tamtSum234.value == null ) {
				    alert("검색을 하시고 난 후에 저장하세요");
				    return;
				 }

				 // 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
				if ( !beforeInsertCheck()) {
					return;
				}

				if ( sFirstSeq == null || sFirstSeq == "" || sFirstSeq == "null" ) {
					 alert("저장을 하시고 난 후에 전자결재를 하세요");
					 return;
				 }


				 //var winObject = window.open(url,"전자결재->장례식장",settings);
				 window.open(url,'전자결재_장례식장',settings);

				}

				var msg = '${msg}';

				$(document).ready(function(){
					$("#workDate").bindDate({separator: ""})
					if(msg != ''){
						alert(msg);
					}
				})
			</script>
    </ax:div>
</ax:layout>
