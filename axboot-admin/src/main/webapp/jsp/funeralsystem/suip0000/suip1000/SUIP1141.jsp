<!----------------------------------------------------------------------------------------
* @program		:	appReg.jsp
* @description	:	마산 전자결재 ( 화장장, 봉안당   )
* @author		:	noo
* @create		:	2014.05.05
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

<%!
private static class StringUtil {

	public static String nvl(String str, String defaultValue){
		return str == null ? defaultValue : str;
	}
}
%>

<%

//검색조건:
	// 검색조건:
	AppMngDataSrch	appMngDataSrchSearch = null;
	AppMngDataSrch	appMngDataSrchSearch2 = null;
	appMngDataSrchSearch = (AppMngDataSrch)request.getAttribute( "appMngDataSrch" );
// 	appMngDataSrchSearch2 = (AppMngDataSrch)request.getAttribute( "appMngDataSrch2" );

	if( appMngDataSrchSearch == null ){
		appMngDataSrchSearch = new AppMngDataSrch();
	}
// 	if( appMngDataSrchSearch2 == null ){
// 		appMngDataSrchSearch2 = new AppMngDataSrch();
// 	}

	//  ms sql server에 insert 후 first max seq 가져오기
	AppMngDataSrch	appMngDataSrchSearchMaxSeq = null;
	appMngDataSrchSearchMaxSeq = (AppMngDataSrch)request.getAttribute( "appMngDataSrchSearch" );

	if( appMngDataSrchSearchMaxSeq == null ){
		appMngDataSrchSearchMaxSeq = new AppMngDataSrch();
	}
	//  ms sql server에 insert 후 second max seq 가져오기
	AppMngDataSrch	appMngDataSrchSecondMaxSeq = null;
	appMngDataSrchSecondMaxSeq = (AppMngDataSrch)request.getAttribute( "appMngDataSrchSearch" );

	if( appMngDataSrchSecondMaxSeq == null ){
		appMngDataSrchSecondMaxSeq = new AppMngDataSrch();
	}


	// 로그인 아이디
	String id = CommonUtils.getCurrentLoginUserCd();

	System.out.println("id :" + id );


	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String today = formatter.format(new java.util.Date());

	//첫 번째 최대값 : seq
	long sFirstSeq = (appMngDataSrchSearchMaxSeq.getSeq() != null) ?  appMngDataSrchSearchMaxSeq.getSeq(): 0;
	System.out.println("Max first Seq : " + sFirstSeq);

	//두 번째 최대값 : seq
	long sSecondSeq = (appMngDataSrchSecondMaxSeq.getSecondseq() != null) ?  appMngDataSrchSecondMaxSeq.getSecondseq(): 0;
	System.out.println("Max second Seq : " + sSecondSeq);

	// ----- 숫자에 3 자리 마다 컴마 찍기시작  -- //
	// --------------------------------- //

	// 화장장  수입금 계   당일 건수
	int ccntSum011 =  appMngDataSrchSearch.getCcntSum011();
	DecimalFormat  df = new DecimalFormat("###,###");
	String dfccntSum011 = df.format(ccntSum011);

	 // 화장장 수입금 계  당일 금액
 long camtSum012 =  appMngDataSrchSearch.getCamtSum012();
	String dfcamtSum012 = df.format(camtSum012);

 // 화장장 수입금 계   월계 건수
	int mcntSum013 =  appMngDataSrchSearch.getMcntSum013();
	String dfmcntSum013 = df.format(mcntSum013);


 // 화장장 수입금 계 월계  금액
 long mamtSum014 =  appMngDataSrchSearch.getMamtSum014();
	String dfmamtSum014 = df.format(mamtSum014);


 // 화장장 수입금 계   연계 건수
	int tcntSum015 =  appMngDataSrchSearch.getTcntSum015();
	String dftcntSum015 = df.format(tcntSum015);

	 // 화장장 수입금 계  연계 금액
 long tamtSum016 =  appMngDataSrchSearch.getTamtSum016();
	String dftamtSum016 = df.format(tamtSum016);


	int ccntSum021 =  appMngDataSrchSearch.getCcntSum021();
	String dfccntSum021 = df.format(ccntSum021);


 long camtSum022 =  appMngDataSrchSearch.getCamtSum022();
	String dfcamtSum022 = df.format(camtSum022);


	int mcntSum023 =  appMngDataSrchSearch.getMcntSum023();
	String dfmcntSum023 = df.format(mcntSum023);


 long mamtSum024 =  appMngDataSrchSearch.getMamtSum024();
	String dfmamtSum024 = df.format(mamtSum024);


	int tcntSum025 =  appMngDataSrchSearch.getTcntSum025();
	String dftcntSum025 = df.format(tcntSum025);

 long tamtSum026 =  appMngDataSrchSearch.getTamtSum026();
	String dftamtSum026 = df.format(tamtSum026);



	int ccntSum031 =  appMngDataSrchSearch.getCcntSum031();
	String dfccntSum031 = df.format(ccntSum031);


 long camtSum032 =  appMngDataSrchSearch.getCamtSum032();
	String dfcamtSum032 = df.format(camtSum032);


	int mcntSum033 =  appMngDataSrchSearch.getMcntSum033();
	String dfmcntSum033 = df.format(mcntSum033);


 long mamtSum034 =  appMngDataSrchSearch.getMamtSum034();
	String dfmamtSum034 = df.format(mamtSum034);


	int tcntSum035 =  appMngDataSrchSearch.getTcntSum035();
	String dftcntSum035 = df.format(tcntSum035);

 long tamtSum036 =  appMngDataSrchSearch.getTamtSum036();
	String dftamtSum036 = df.format(tamtSum036);


	int ccntSum041 =  appMngDataSrchSearch.getCcntSum041();
	String dfccntSum041 = df.format(ccntSum041);


 long camtSum042 =  appMngDataSrchSearch.getCamtSum042();
	String dfcamtSum042 = df.format(camtSum042);


	int mcntSum043 =  appMngDataSrchSearch.getMcntSum043();
	String dfmcntSum043 = df.format(mcntSum043);


 long mamtSum044 =  appMngDataSrchSearch.getMamtSum044();
	String dfmamtSum044 = df.format(mamtSum044);


	int tcntSum045 =  appMngDataSrchSearch.getTcntSum045();
	String dftcntSum045 = df.format(tcntSum045);

 long tamtSum046 =  appMngDataSrchSearch.getTamtSum046();
	String dftamtSum046 = df.format(tamtSum046);

	int ccntSum051 =  appMngDataSrchSearch.getCcntSum051();
	String dfccntSum051 = df.format(ccntSum051);


 long camtSum052 =  appMngDataSrchSearch.getCamtSum052();
	String dfcamtSum052 = df.format(camtSum052);


	int mcntSum053 =  appMngDataSrchSearch.getMcntSum053();
	String dfmcntSum053 = df.format(mcntSum053);


 long mamtSum054 =  appMngDataSrchSearch.getMamtSum054();
	String dfmamtSum054 = df.format(mamtSum054);


	int tcntSum055 =  appMngDataSrchSearch.getTcntSum055();
	String dftcntSum055 = df.format(tcntSum055);

 long tamtSum056 =  appMngDataSrchSearch.getTamtSum056();
	String dftamtSum056 = df.format(tamtSum056);


	int ccntSum061 =  appMngDataSrchSearch.getCcntSum061();
	String dfccntSum061 = df.format(ccntSum061);


 long camtSum062 =  appMngDataSrchSearch.getCamtSum062();
	String dfcamtSum062 = df.format(camtSum062);


	int mcntSum063 =  appMngDataSrchSearch.getMcntSum063();
	String dfmcntSum063 = df.format(mcntSum063);


 long mamtSum064 =  appMngDataSrchSearch.getMamtSum064();
	String dfmamtSum064 = df.format(mamtSum064);


	int tcntSum065 =  appMngDataSrchSearch.getTcntSum065();
	String dftcntSum065 = df.format(tcntSum065);

 long tamtSum066 =  appMngDataSrchSearch.getTamtSum066();
	String dftamtSum066 = df.format(tamtSum066);


	int ccntSum071 =  appMngDataSrchSearch.getCcntSum071();
	String dfccntSum071 = df.format(ccntSum071);


 long camtSum072 =  appMngDataSrchSearch.getCamtSum072();
	String dfcamtSum072 = df.format(camtSum072);


	int mcntSum073 =  appMngDataSrchSearch.getMcntSum073();
	String dfmcntSum073 = df.format(mcntSum073);


 long mamtSum074 =  appMngDataSrchSearch.getMamtSum074();
	String dfmamtSum074 = df.format(mamtSum074);


	int tcntSum075 =  appMngDataSrchSearch.getTcntSum075();
	String dftcntSum075 = df.format(tcntSum075);

 long tamtSum076 =  appMngDataSrchSearch.getTamtSum076();
	String dftamtSum076 = df.format(tamtSum076);


	int ccntSum081 =  appMngDataSrchSearch.getCcntSum081();
	String dfccntSum081 = df.format(ccntSum081);


 long camtSum082 =  appMngDataSrchSearch.getCamtSum082();
	String dfcamtSum082 = df.format(camtSum082);


	int mcntSum083 =  appMngDataSrchSearch.getMcntSum083();
	String dfmcntSum083 = df.format(mcntSum083);


 long mamtSum084 =  appMngDataSrchSearch.getMamtSum084();
	String dfmamtSum084 = df.format(mamtSum084);


	int tcntSum085 =  appMngDataSrchSearch.getTcntSum085();
	String dftcntSum085 = df.format(tcntSum085);

 long tamtSum086 =  appMngDataSrchSearch.getTamtSum086();
	String dftamtSum086 = df.format(tamtSum086);


	int ccntSum091 =  appMngDataSrchSearch.getCcntSum091();
	String dfccntSum091 = df.format(ccntSum091);


 long camtSum092 =  appMngDataSrchSearch.getCamtSum092();
	String dfcamtSum092 = df.format(camtSum092);


	int mcntSum093 =  appMngDataSrchSearch.getMcntSum093();
	String dfmcntSum093 = df.format(mcntSum093);


 long mamtSum094 =  appMngDataSrchSearch.getMamtSum094();
	String dfmamtSum094 = df.format(mamtSum094);


	int tcntSum095 =  appMngDataSrchSearch.getTcntSum095();
	String dftcntSum095 = df.format(tcntSum095);

 long tamtSum096 =  appMngDataSrchSearch.getTamtSum096();
	String dftamtSum096 = df.format(tamtSum096);


	int ccntSum101 =  appMngDataSrchSearch.getCcntSum101();
	String dfccntSum101 = df.format(ccntSum101);


 long camtSum102 =  appMngDataSrchSearch.getCamtSum102();
	String dfcamtSum102 = df.format(camtSum102);


	int mcntSum103 =  appMngDataSrchSearch.getMcntSum103();
	String dfmcntSum103 = df.format(mcntSum103);


 long mamtSum104 =  appMngDataSrchSearch.getMamtSum104();
	String dfmamtSum104 = df.format(mamtSum104);


	int tcntSum105 =  appMngDataSrchSearch.getTcntSum105();
	String dftcntSum105 = df.format(tcntSum105);

 long tamtSum106 =  appMngDataSrchSearch.getTamtSum106();
	String dftamtSum106 = df.format(tamtSum106);


	int ccntSum111 =  appMngDataSrchSearch.getCcntSum111();
	String dfccntSum111 = df.format(ccntSum111);


 long camtSum112 =  appMngDataSrchSearch.getCamtSum112();
	String dfcamtSum112 = df.format(camtSum112);


	int mcntSum113 =  appMngDataSrchSearch.getMcntSum113();
	String dfmcntSum113 = df.format(mcntSum113);


 long mamtSum114 =  appMngDataSrchSearch.getMamtSum114();
	String dfmamtSum114 = df.format(mamtSum114);


	int tcntSum115 =  appMngDataSrchSearch.getTcntSum115();
	String dftcntSum115 = df.format(tcntSum115);

 long tamtSum116 =  appMngDataSrchSearch.getTamtSum116();
	String dftamtSum116 = df.format(tamtSum116);


	int ccntSum121 =  appMngDataSrchSearch.getCcntSum121();
	String dfccntSum121 = df.format(ccntSum121);


 long camtSum122 =  appMngDataSrchSearch.getCamtSum122();
	String dfcamtSum122 = df.format(camtSum122);


	int mcntSum123 =  appMngDataSrchSearch.getMcntSum123();
	String dfmcntSum123 = df.format(mcntSum123);


 long mamtSum124 =  appMngDataSrchSearch.getMamtSum124();
	String dfmamtSum124 = df.format(mamtSum124);


	int tcntSum125 =  appMngDataSrchSearch.getTcntSum125();
	String dftcntSum125 = df.format(tcntSum125);

 long tamtSum126 =  appMngDataSrchSearch.getTamtSum126();
	String dftamtSum126 = df.format(tamtSum126);


	int ccntSum131 =  appMngDataSrchSearch.getCcntSum131();
	String dfccntSum131 = df.format(ccntSum131);


 long camtSum132 =  appMngDataSrchSearch.getCamtSum132();
	String dfcamtSum132 = df.format(camtSum132);


	int mcntSum133 =  appMngDataSrchSearch.getMcntSum133();
	String dfmcntSum133 = df.format(mcntSum133);


 long mamtSum134 =  appMngDataSrchSearch.getMamtSum134();
	String dfmamtSum134 = df.format(mamtSum134);


	int tcntSum135 =  appMngDataSrchSearch.getTcntSum135();
	String dftcntSum135 = df.format(tcntSum135);

 long tamtSum136 =  appMngDataSrchSearch.getTamtSum136();
	String dftamtSum136 = df.format(tamtSum136);



	int ccntSum141 =  appMngDataSrchSearch.getCcntSum141();
	String dfccntSum141 = df.format(ccntSum141);


 long camtSum142 =  appMngDataSrchSearch.getCamtSum142();
	String dfcamtSum142 = df.format(camtSum142);


	int mcntSum143 =  appMngDataSrchSearch.getMcntSum143();
	String dfmcntSum143 = df.format(mcntSum143);


 long mamtSum144 =  appMngDataSrchSearch.getMamtSum144();
	String dfmamtSum144 = df.format(mamtSum144);


	int tcntSum145 =  appMngDataSrchSearch.getTcntSum145();
	String dftcntSum145 = df.format(tcntSum145);

 long tamtSum146 =  appMngDataSrchSearch.getTamtSum146();
	String dftamtSum146 = df.format(tamtSum146);


	int ccntSum151 =  appMngDataSrchSearch.getCcntSum151();
	String dfccntSum151 = df.format(ccntSum151);


 long camtSum152 =  appMngDataSrchSearch.getCamtSum152();
	String dfcamtSum152 = df.format(camtSum152);


	int mcntSum153 =  appMngDataSrchSearch.getMcntSum153();
	String dfmcntSum153 = df.format(mcntSum153);


 long mamtSum154 =  appMngDataSrchSearch.getMamtSum154();
	String dfmamtSum154 = df.format(mamtSum154);


	int tcntSum155 =  appMngDataSrchSearch.getTcntSum155();
	String dftcntSum155 = df.format(tcntSum155);

 long tamtSum156 =  appMngDataSrchSearch.getTamtSum156();
	String dftamtSum156 = df.format(tamtSum156);



 //	봉안당   수입금 계   당일 건수
	int ccntSum161 =  appMngDataSrchSearch.getCcntSum161();
	String dfccntSum161 = df.format(ccntSum161);

	 // 봉안당 수입금 계  당일 금액
 long camtSum162 =  appMngDataSrchSearch.getCamtSum162();
	String dfcamtSum162 = df.format(camtSum162);

 // 봉안당 수입금 계   월계 건수
	int mcntSum163 =  appMngDataSrchSearch.getMcntSum163();
	String dfmcntSum163 = df.format(mcntSum163);


 // 봉안당 수입금 계 월계  금액
 long mamtSum164 =  appMngDataSrchSearch.getMamtSum164();
	String dfmamtSum164 = df.format(mamtSum164);


 // 봉안당 수입금 계   연계 건수
	int tcntSum165 =  appMngDataSrchSearch.getTcntSum165();
	String dftcntSum165 = df.format(tcntSum165);

	 // 봉안당 수입금 계  연계 금액
 long tamtSum166 =  appMngDataSrchSearch.getTamtSum166();
	String dftamtSum166 = df.format(tamtSum166);



	int ccntSum171 =  appMngDataSrchSearch.getCcntSum171();
	String dfccntSum171 = df.format(ccntSum171);


 long camtSum172 =  appMngDataSrchSearch.getCamtSum172();
	String dfcamtSum172 = df.format(camtSum172);


	int mcntSum173 =  appMngDataSrchSearch.getMcntSum173();
	String dfmcntSum173 = df.format(mcntSum173);


 long mamtSum174 =  appMngDataSrchSearch.getMamtSum174();
	String dfmamtSum174 = df.format(mamtSum174);


	int tcntSum175 =  appMngDataSrchSearch.getTcntSum175();
	String dftcntSum175 = df.format(tcntSum175);

 long tamtSum176 =  appMngDataSrchSearch.getTamtSum176();
	String dftamtSum176 = df.format(tamtSum176);


	int ccntSum181 =  appMngDataSrchSearch.getCcntSum181();
	String dfccntSum181 = df.format(ccntSum181);


 long camtSum182 =  appMngDataSrchSearch.getCamtSum182();
	String dfcamtSum182 = df.format(camtSum182);


	int mcntSum183 =  appMngDataSrchSearch.getMcntSum183();
	String dfmcntSum183 = df.format(mcntSum183);


 long mamtSum184 =  appMngDataSrchSearch.getMamtSum184();
	String dfmamtSum184 = df.format(mamtSum184);


	int tcntSum185 =  appMngDataSrchSearch.getTcntSum185();
	String dftcntSum185 = df.format(tcntSum185);

 long tamtSum186 =  appMngDataSrchSearch.getTamtSum186();
	String dftamtSum186 = df.format(tamtSum186);

	int ccntSum191 =  appMngDataSrchSearch.getCcntSum191();
	String dfccntSum191 = df.format(ccntSum191);


 long camtSum192 =  appMngDataSrchSearch.getCamtSum192();
	String dfcamtSum192 = df.format(camtSum192);


	int mcntSum193 =  appMngDataSrchSearch.getMcntSum193();
	String dfmcntSum193 = df.format(mcntSum193);


 long mamtSum194 =  appMngDataSrchSearch.getMamtSum194();
	String dfmamtSum194 = df.format(mamtSum194);


	int tcntSum195 =  appMngDataSrchSearch.getTcntSum195();
	String dftcntSum195 = df.format(tcntSum195);

 long tamtSum196 =  appMngDataSrchSearch.getTamtSum196();
	String dftamtSum196 = df.format(tamtSum196);


	int ccntSum201 =  appMngDataSrchSearch.getCcntSum201();
	String dfccntSum201 = df.format(ccntSum201);


 long camtSum202 =  appMngDataSrchSearch.getCamtSum202();
	String dfcamtSum202 = df.format(camtSum202);


	int mcntSum203 =  appMngDataSrchSearch.getMcntSum203();
	String dfmcntSum203 = df.format(mcntSum203);


 long mamtSum204 =  appMngDataSrchSearch.getMamtSum204();
	String dfmamtSum204 = df.format(mamtSum204);


	int tcntSum205 =  appMngDataSrchSearch.getTcntSum205();
	String dftcntSum205 = df.format(tcntSum205);

 long tamtSum206 =  appMngDataSrchSearch.getTamtSum206();
	String dftamtSum206 = df.format(tamtSum206);


	int ccntSum211 =  appMngDataSrchSearch.getCcntSum211();
	String dfccntSum211 = df.format(ccntSum211);


 long camtSum212 =  appMngDataSrchSearch.getCamtSum212();
	String dfcamtSum212 = df.format(camtSum212);


	int mcntSum213 =  appMngDataSrchSearch.getMcntSum213();
	String dfmcntSum213 = df.format(mcntSum213);


 long mamtSum214 =  appMngDataSrchSearch.getMamtSum214();
	String dfmamtSum214 = df.format(mamtSum214);


	int tcntSum215 =  appMngDataSrchSearch.getTcntSum215();
	String dftcntSum215 = df.format(tcntSum215);

 long tamtSum216 =  appMngDataSrchSearch.getTamtSum216();
	String dftamtSum216 = df.format(tamtSum216);

	int ccntSum221 =  appMngDataSrchSearch.getCcntSum221();
	String dfccntSum221 = df.format(ccntSum221);


 long camtSum222 =  appMngDataSrchSearch.getCamtSum222();
	String dfcamtSum222 = df.format(camtSum222);


	int mcntSum223 =  appMngDataSrchSearch.getMcntSum223();
	String dfmcntSum223 = df.format(mcntSum223);


 long mamtSum224 =  appMngDataSrchSearch.getMamtSum224();
	String dfmamtSum224 = df.format(mamtSum224);


	int tcntSum225 =  appMngDataSrchSearch.getTcntSum225();
	String dftcntSum225 = df.format(tcntSum225);

 long tamtSum226 =  appMngDataSrchSearch.getTamtSum226();
	String dftamtSum226 = df.format(tamtSum226);


	int ccntSum231 =  appMngDataSrchSearch.getCcntSum231();
	String dfccntSum231 = df.format(ccntSum231);


 long camtSum232 =  appMngDataSrchSearch.getCamtSum232();
	String dfcamtSum232 = df.format(camtSum232);


	int mcntSum233 =  appMngDataSrchSearch.getMcntSum233();
	String dfmcntSum233 = df.format(mcntSum233);


 long mamtSum234 =  appMngDataSrchSearch.getMamtSum234();
	String dfmamtSum234 = df.format(mamtSum234);


	int tcntSum235 =  appMngDataSrchSearch.getTcntSum235();
	String dftcntSum235 = df.format(tcntSum235);

 long tamtSum236 =  appMngDataSrchSearch.getTamtSum236();
	String dftamtSum236 = df.format(tamtSum236);


	int ccntSum241 =  appMngDataSrchSearch.getCcntSum241();
	String dfccntSum241 = df.format(ccntSum241);


 long camtSum242 =  appMngDataSrchSearch.getCamtSum242();
	String dfcamtSum242 = df.format(camtSum242);


	int mcntSum243 =  appMngDataSrchSearch.getMcntSum243();
	String dfmcntSum243 = df.format(mcntSum243);


 long mamtSum244 =  appMngDataSrchSearch.getMamtSum244();
	String dfmamtSum244 = df.format(mamtSum244);


	int tcntSum245 =  appMngDataSrchSearch.getTcntSum245();
	String dftcntSum245 = df.format(tcntSum245);

 long tamtSum246 =  appMngDataSrchSearch.getTamtSum246();
	String dftamtSum246 = df.format(tamtSum246);


	int ccntSum251 =  appMngDataSrchSearch.getCcntSum251();
	String dfccntSum251 = df.format(ccntSum251);


 long camtSum252 =  appMngDataSrchSearch.getCamtSum252();
	String dfcamtSum252 = df.format(camtSum252);


	int mcntSum253 =  appMngDataSrchSearch.getMcntSum253();
	String dfmcntSum253 = df.format(mcntSum253);


 long mamtSum254 =  appMngDataSrchSearch.getMamtSum254();
	String dfmamtSum254 = df.format(mamtSum254);


	int tcntSum255 =  appMngDataSrchSearch.getTcntSum255();
	String dftcntSum255 = df.format(tcntSum255);

 long tamtSum256 =  appMngDataSrchSearch.getTamtSum256();
	String dftamtSum256 = df.format(tamtSum256);


	int ccntSum261 =  appMngDataSrchSearch.getCcntSum261();
	String dfccntSum261 = df.format(ccntSum261);


 long camtSum262 =  appMngDataSrchSearch.getCamtSum262();
	String dfcamtSum262 = df.format(camtSum262);


	int mcntSum263 =  appMngDataSrchSearch.getMcntSum263();
	String dfmcntSum263 = df.format(mcntSum263);


 long mamtSum264 =  appMngDataSrchSearch.getMamtSum264();
	String dfmamtSum264 = df.format(mamtSum264);


	int tcntSum265 =  appMngDataSrchSearch.getTcntSum265();
	String dftcntSum265 = df.format(tcntSum265);

 long tamtSum266 =  appMngDataSrchSearch.getTamtSum266();
	String dftamtSum266 = df.format(tamtSum266);


	int ccntSum271 =  appMngDataSrchSearch.getCcntSum271();
	String dfccntSum271 = df.format(ccntSum271);


 long camtSum272 =  appMngDataSrchSearch.getCamtSum272();
	String dfcamtSum272 = df.format(camtSum272);


	int mcntSum273 =  appMngDataSrchSearch.getMcntSum273();
	String dfmcntSum273 = df.format(mcntSum273);


 long mamtSum274 =  appMngDataSrchSearch.getMamtSum274();
	String dfmamtSum274 = df.format(mamtSum274);


	int tcntSum275 =  appMngDataSrchSearch.getTcntSum275();
	String dftcntSum275 = df.format(tcntSum275);

 long tamtSum276 =  appMngDataSrchSearch.getTamtSum276();
	String dftamtSum276 = df.format(tamtSum276);


	int ccntSum281 =  appMngDataSrchSearch.getCcntSum281();
	String dfccntSum281 = df.format(ccntSum281);


 long camtSum282 =  appMngDataSrchSearch.getCamtSum282();
	String dfcamtSum282 = df.format(camtSum282);


	int mcntSum283 =  appMngDataSrchSearch.getMcntSum283();
	String dfmcntSum283 = df.format(mcntSum283);


 long mamtSum284 =  appMngDataSrchSearch.getMamtSum284();
	String dfmamtSum284 = df.format(mamtSum284);


	int tcntSum285 =  appMngDataSrchSearch.getTcntSum285();
	String dftcntSum285 = df.format(tcntSum285);

 long tamtSum286 =  appMngDataSrchSearch.getTamtSum286();
	String dftamtSum286 = df.format(tamtSum286);

	// 적출물
		int ccntSum291 =  appMngDataSrchSearch.getCcntSum291();
		String dfccntSum291 = df.format(ccntSum291);
	    long camtSum292 =  appMngDataSrchSearch.getCamtSum292();
		String dfcamtSum292 = df.format(camtSum292);
		int mcntSum293 =  appMngDataSrchSearch.getMcntSum293();
		String dfmcntSum293 = df.format(mcntSum293);
	    long mamtSum294 =  appMngDataSrchSearch.getMamtSum294();
		String dfmamtSum294 = df.format(mamtSum294);
		int tcntSum295 =  appMngDataSrchSearch.getTcntSum295();
		String dftcntSum295 = df.format(tcntSum295);
	    long tamtSum296 =  appMngDataSrchSearch.getTamtSum296();
		String dftamtSum296 = df.format(tamtSum296);
		int ccntSum301 =  appMngDataSrchSearch.getCcntSum301();
		String dfccntSum301 = df.format(ccntSum301);
	    long camtSum302 =  appMngDataSrchSearch.getCamtSum302();
		String dfcamtSum302 = df.format(camtSum302);
		int mcntSum303 =  appMngDataSrchSearch.getMcntSum303();
		String dfmcntSum303 = df.format(mcntSum303);
	    long mamtSum304 =  appMngDataSrchSearch.getMamtSum304();
		String dfmamtSum304 = df.format(mamtSum304);
		int tcntSum305 =  appMngDataSrchSearch.getTcntSum305();
		String dftcntSum305 = df.format(tcntSum305);
	    long tamtSum306 =  appMngDataSrchSearch.getTamtSum306();
		String dftamtSum306 = df.format(tamtSum306);
// 		int ccntSum291 =  appMngDataSrchSearch2.getCcntSum291();
// 		String dfccntSum291 = df.format(ccntSum291);
// 	    long camtSum292 =  appMngDataSrchSearch2.getCamtSum292();
// 		String dfcamtSum292 = df.format(camtSum292);
// 		int mcntSum293 =  appMngDataSrchSearch2.getMcntSum293();
// 		String dfmcntSum293 = df.format(mcntSum293);
// 	    long mamtSum294 =  appMngDataSrchSearch2.getMamtSum294();
// 		String dfmamtSum294 = df.format(mamtSum294);
// 		int tcntSum295 =  appMngDataSrchSearch2.getTcntSum295();
// 		String dftcntSum295 = df.format(tcntSum295);
// 	    long tamtSum296 =  appMngDataSrchSearch2.getTamtSum296();
// 		String dftamtSum296 = df.format(tamtSum296);
// 		int ccntSum301 =  appMngDataSrchSearch2.getCcntSum301();
// 		String dfccntSum301 = df.format(ccntSum301);
// 	    long camtSum302 =  appMngDataSrchSearch2.getCamtSum302();
// 		String dfcamtSum302 = df.format(camtSum302);
// 		int mcntSum303 =  appMngDataSrchSearch2.getMcntSum303();
// 		String dfmcntSum303 = df.format(mcntSum303);
// 	    long mamtSum304 =  appMngDataSrchSearch2.getMamtSum304();
// 		String dfmamtSum304 = df.format(mamtSum304);
// 		int tcntSum305 =  appMngDataSrchSearch2.getTcntSum305();
// 		String dftcntSum305 = df.format(tcntSum305);
// 	    long tamtSum306 =  appMngDataSrchSearch2.getTamtSum306();
// 		String dftamtSum306 = df.format(tamtSum306);
		//봉안기간연장
		int ccntSum311 =  appMngDataSrchSearch.getCcntSum311();
		String dfccntSum311 = df.format(ccntSum311);
	    long camtSum312 =  appMngDataSrchSearch.getCamtSum312();
		String dfcamtSum312 = df.format(camtSum312);
		int mcntSum313 =  appMngDataSrchSearch.getMcntSum313();
		String dfmcntSum313 = df.format(mcntSum313);
	    long mamtSum314 =  appMngDataSrchSearch.getMamtSum314();
		String dfmamtSum314 = df.format(mamtSum314);
		int tcntSum315 =  appMngDataSrchSearch.getTcntSum315();
		String dftcntSum315 = df.format(tcntSum315);
	    long tamtSum316 =  appMngDataSrchSearch.getTamtSum316();
		String dftamtSum316 = df.format(tamtSum316);
		int ccntSum321 =  appMngDataSrchSearch.getCcntSum301();
		String dfccntSum321 = df.format(ccntSum321);
	    long camtSum322 =  appMngDataSrchSearch.getCamtSum322();
		String dfcamtSum322 = df.format(camtSum322);
		int mcntSum323 =  appMngDataSrchSearch.getMcntSum323();
		String dfmcntSum323 = df.format(mcntSum323);
	    long mamtSum324 =  appMngDataSrchSearch.getMamtSum324();
		String dfmamtSum324 = df.format(mamtSum324);
		int tcntSum325 =  appMngDataSrchSearch.getTcntSum325();
		String dftcntSum325 = df.format(tcntSum325);
	    long tamtSum326 =  appMngDataSrchSearch.getTamtSum326();
		String dftamtSum326 = df.format(tamtSum326);



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

		  Date date = new Date();
		 // workDate = (workDate != null) ? workDate : dateTime;

		 if ( workDate != null) {
	             date = dateParse.parse(workDate);
	             workdate = dateFormat.format(date);
	             year = workdate.substring(0, 4);
              month = workdate.substring(4, 6);
              day = workdate.substring(6, 8);

				////추가 2018-11-01 변경부분
              		dates = workdate.substring(8, workdate.length());
				if("Mon".equals(dates)){ dates="월"; }
				if("Tue".equals(dates)){ dates="화"; }
				if("Wed".equals(dates)){ dates="수"; }
				if("Thu".equals(dates)){ dates="목"; }
				if("Fri".equals(dates)){ dates="금"; }
				if("Sat".equals(dates)){ dates="토"; }
				if("Sun".equals(dates)){ dates="일"; }

	     }


		} catch (Exception e)	{
			e.printStackTrace();
		}

	//업무ID: 진해 화장장,봉안당 수입일보 : 0000000xf
	String seconddata  = "";
	String frmID = "0000000xf";

 String data  = frmID + "|" + year + "|" + month + "|" + day + "|" + dates + "|" +
	totWorker + "|" + curWorker + "|" + actWorker + "|" + eduWorker + "|" + ymcWorker + "|" +
 outWorker + "|" +
 othWorker + "|" + acsWorker + "|" +
 dfccntSum011 + "|" +	//화장장수입금계
 dfcamtSum012 + "|" +
 dfmcntSum013 + "|" +
 dfmamtSum014 + "|" +
 dftcntSum015 + "|" +
 dftamtSum016 + "|" +

	dfccntSum021 + "|" + 	//관내 소계
	dfcamtSum022 + "|" +
	dfmcntSum023 + "|" +
	dfmamtSum024 + "|" +
	dftcntSum025 + "|" +
	dftamtSum026 + "|" +

	dfccntSum031 + "|" +	//관외 소계
	dfcamtSum032 + "|" +
	dfmcntSum033 + "|" +
	dfmamtSum034 + "|" +
	dftcntSum035 + "|" +
	dftamtSum036 + "|" +

	dfccntSum041 + "|" +	//15세이상 관내
	dfcamtSum042 + "|" +
	dfmcntSum043 + "|" +
	dfmamtSum044 + "|" +
	dftcntSum045 + "|" +
	dftamtSum046 + "|" +

	dfccntSum051 + "|" + 	//관외
	dfcamtSum052 + "|" +
	dfmcntSum053 + "|" +
	dfmamtSum054 + "|" +
	dftcntSum055 + "|" +
	dftamtSum056 + "|" +

	dfccntSum061 + "|" + 	//14세이하 관내
	dfcamtSum062 + "|" +
	dfmcntSum063 + "|" +
	dfmamtSum064 + "|" +
	dftcntSum065 + "|" +
	dftamtSum066 + "|" +

	dfccntSum071 + "|" + 	//관외
	dfcamtSum072 + "|" +
	dfmcntSum073 + "|" +
	dfmamtSum074 + "|" +
	dftcntSum075 + "|" +
	dftamtSum076 + "|" +

	dfccntSum081 + "|" + 	//죽은태아 관내
	dfcamtSum082 + "|" +
	dfmcntSum083 + "|" +
	dfmamtSum084 + "|" +
	dftcntSum085 + "|" +
	dftamtSum086 + "|" +

	dfccntSum091 + "|" + 	//관외
	dfcamtSum092 + "|" +
	dfmcntSum093 + "|" +
	dfmamtSum094 + "|" +
	dftcntSum095 + "|" +
	dftamtSum096 + "|" +

	dfccntSum101 + "|" + 	//개장유골 관내
	dfcamtSum102 + "|" +
	dfmcntSum103 + "|" +
	dfmamtSum104 + "|" +
	dftcntSum105 + "|" +
	dftamtSum106 + "|" +

	dfccntSum111 + "|" + 	//관외
	dfcamtSum112 + "|" +
	dfmcntSum113 + "|" +
	dfmamtSum114 + "|" +
	dftcntSum115 + "|" +
	dftamtSum116 + "|" +

	dfccntSum121 + "|" + 	//감면대상 100% 관내
	dfcamtSum122 + "|" +
	dfmcntSum123 + "|" +
	dfmamtSum124 + "|" +
	dftcntSum125 + "|" +
	dftamtSum126 + "|" +

	dfccntSum131 + "|" + 	//관외
	dfcamtSum132 + "|" +
	dfmcntSum133 + "|" +
	dfmamtSum134 + "|" +
	dftcntSum135 + "|" +
	dftamtSum136 + "|" +

	dfccntSum141 + "|" + 	//감면대상 50% 관내
	dfcamtSum142 + "|" +
	dfmcntSum143 + "|" +
	dfmamtSum144 + "|" +
	dftcntSum145 + "|" +
	dftamtSum146 + "|" +

	dfccntSum151 + "|" + 	//관외
	dfcamtSum152 + "|" +
	dfmcntSum153 + "|" +
	dfmamtSum154 + "|" +
	dftcntSum155 + "|" +
//	dftamtSum156;
	dftamtSum156 + "|" + insertOthers;

 //두 번째 봉안내역 데이터
	//seconddata  =  /* dfccntSum161 + "|" +		//봉안당 수입금 계
	 /*
	//dfccntSum161 + "|" +
	dfcamtSum162 + "|" +
	dfmcntSum163 + "|" +
	dfmamtSum164 + "|" +
	dftcntSum165 + "|" +
	dftamtSum166 + "|" +

	dfccntSum171 + "|" + 	//소계 관내
	dfcamtSum172 + "|" +
	dfmcntSum173 + "|" +
	dfmamtSum174 + "|" +
	dftcntSum175 + "|" +
	dftamtSum176 + "|" +

	dfccntSum181 + "|" + 	//관외
	dfcamtSum182 + "|" +
	dfmcntSum183 + "|" +
	dfmamtSum184 + "|" +
	dftcntSum185 + "|" +
	dftamtSum186 + "|" +

	dfccntSum191 + "|" + 	//개인 관내
	dfcamtSum192 + "|" +
	dfmcntSum193 + "|" +
	dfmamtSum194 + "|" +
	dftcntSum195 + "|" +
	dftamtSum196 + "|" +

	dfccntSum201 + "|" + 	//관외
	dfcamtSum202 + "|" +
	dfmcntSum203 + "|" +
	dfmamtSum204 + "|" +
	dftcntSum205 + "|" +
	dftamtSum206 + "|" +

	dfccntSum211 + "|" + 	//부부 관내
	dfcamtSum212 + "|" +
	dfmcntSum213 + "|" +
	dfmamtSum214 + "|" +
	dftcntSum215 + "|" +
	dftamtSum216 + "|" +

	dfccntSum221 + "|" + 	//관외
	dfcamtSum222 + "|" +
	dfmcntSum223 + "|" +
	dfmamtSum224 + "|" +
	dftcntSum225 + "|" +
	dftamtSum226 + "|" +

	dfccntSum231 + "|" + 	//무연고 관내
	dfcamtSum232 + "|" +
	dfmcntSum233 + "|" +
	dfmamtSum234 + "|" +
	dftcntSum235 + "|" +
	dftamtSum236 + "|" +

	dfccntSum241 + "|" + 	//관외
	dfcamtSum242 + "|" +
	dfmcntSum243 + "|" +
	dfmamtSum244 + "|" +
	dftcntSum245 + "|" +
	dftamtSum246 + "|" +

	dfccntSum311 + "|" +	//기간연장 세부내역 개인
	dfcamtSum312 + "|" +
	dfmcntSum313 + "|" +
	dfmamtSum314 + "|" +
	dftcntSum315 + "|" +
	dftamtSum316 + "|" +

	dfccntSum321 + "|" + 	//부부
	dfcamtSum322 + "|" +
	dfmcntSum323 + "|" +
	dfmamtSum324 + "|" +
	dftcntSum325 + "|" +
	dftamtSum326 + "|" +

	dfccntSum251 + "|" + 	//감면대상 100% 관내
	dfcamtSum252 + "|" +
	dfmcntSum253 + "|" +
	dfmamtSum254 + "|" +
	dftcntSum255 + "|" +
	dftamtSum256 + "|" +

	dfccntSum261 + "|" + 	//관외
	dfcamtSum262 + "|" +
	dfmcntSum263 + "|" +
	dfmamtSum264 + "|" +
	dftcntSum265 + "|" +
	dftamtSum266 + "|" +

	dfccntSum271 + "|" + 	//감면대상 50% 관내
	dfcamtSum272 + "|" +
	dfmcntSum273 + "|" +
	dfmamtSum274 + "|" +
	dftcntSum275 + "|" +
	dftamtSum276 + "|" +

	dfccntSum281 + "|" + 	//관외
	dfcamtSum282 + "|" +
	dfmcntSum283 + "|" +
	dfmamtSum284 + "|" +
	dftcntSum285 + "|" +
	dftamtSum286 + "|" +	*/

		request.setAttribute("data", data);
%>

<c:set var="mainForm">

	<form name="mainform" >
<input type="hidden" name="actionTp">

<input name="frmName" type="hidden"  value="장사통합@MS마산화장장운영일지">
<input name="frmId" type="hidden"    value="0000000xf">

<input name="data" type="hidden"  value="<%=StringUtil.nvl( data, "" )%>">
<input name="seconddata" type="hidden"  value="<%=StringUtil.nvl( seconddata, "" )%>">
<input name="id" type="hidden"  value="<%=StringUtil.nvl( id, "" )%>">
<input name="updtime" type="hidden"  value="<%=StringUtil.nvl( today, "" )%>">

<input name="updtime" type="hidden"  value="<%=StringUtil.nvl( today, "" )%>">
<input name="tamtSum016" type="hidden"  value="<%= appMngDataSrchSearch.getTamtSum016() %>">
<input name="sFirstSeq" type="hidden"  value="<%= appMngDataSrchSearchMaxSeq.getSeq() %>">
<input name="sSecondSeq" type="hidden"  value="<%= appMngDataSrchSecondMaxSeq.getSecondseq() %>">
<input name="dftcntSum165" type="hidden"  value="<%= appMngDataSrchSearch.getTcntSum165() %>">

<input name="SerchChk" type="hidden" value="0">

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
			  <table width="98%" border="0" cellspacing="0" cellpadding="0" >
				  <tr>
				    <td width="20" align="left"  ><span style="white-space:nowrap">
					 <strong>&nbsp;작업일자</strong>
                     <input id="workDate" class="AXInput W150" name="workDate" type="text" class="t_line_1" value="<%=StringUtil.nvl( workDate, "" )%>"
                     numeric ondblclick="popUpCalendarNoDash(this);"  onclick=""
                      size="8"  maxLength="8" required numeric >&nbsp;&nbsp;&nbsp;&nbsp;

					<button class="AXButton" onclick="javascript:goList();" >검색</button>

					<button class="AXButton" onclick="javascript:goMssqlInsert();" >저장</button>


					<input class="AXButton" type = "button" value = "전자결재" onclick="popupApp();">

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
					<input class="AXInput"  name="totWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( totWorker , "0" ) %>" >
					</td>

					<td>현원
					<input class="AXInput" name="curWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( curWorker , "0" ) %>" >
					</td>

					<td>사고
					<input class="AXInput" name="actWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( actWorker , "0" ) %>" >
					</td>


					<td>교육
					<input class="AXInput" name="eduWorker"  style="text-align:leftt;" type="text" size="5" value="<%=StringUtil.nvl( eduWorker , "" ) %>" >
					</td>

					<td>연월차
					<input class="AXInput" name="ymcWorker"  style="text-align:leftt;" type="text" size="5" value="<%=StringUtil.nvl( ymcWorker , "" ) %>" >
					</td>


					<td>관외출장
					<input class="AXInput" name="outWorker"  style="text-align:leftt;" type="text" size="5" value="<%=StringUtil.nvl( outWorker , "" ) %>" >
					</td>


					<td>기타
					<input class="AXInput" name="othWorker"  style="text-align:left;" type="text" size="5" value="<%=StringUtil.nvl( othWorker , "" ) %>" >
					</td>

					<td>사고자
					<input class="AXInput" name="acsWorker" type="text" size="40" value="<%=StringUtil.nvl( acsWorker , "" ) %>" >
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
 <div style="overflow:auto; width:700px; height:800px;">

 <table border="1" width="692" cellpadding="0" cellspacing="0" class="AXGridTable">
  <!-- 화장내역  -->
    <tr>
        <td width="150" rowspan="2" colspan="3" align="center">화장 내역</td>
        <td width="169" colspan="2" align="center">당일</td>
        <td width="164" colspan="2" align="center">월계</td>
        <td width="181" colspan="2" align="center">연계</td>
    </tr>
    <tr>
        <td width="67" align="center">건수 </td>
        <td width="96" align="center">금액</td>
        <td width="63" align="center">건수</td>
        <td width="95" align="center">금액</td>
        <td width="65" align="center">건수</td>
        <td width="110" align="center">금액</td>
    </tr>
    <tr>
        <td width="150" colspan="3" align="center">화장장 수입금 계</td>
        <td width="67" align="right"><b><%= dfccntSum011  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum012  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum013  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum014  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum015  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum016 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">소계</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum021  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum022  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum023  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum024  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum025  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum026 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum031  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum032  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum033  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum034  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum035  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum036 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">
            <p>만15세</p>
            <p>&nbsp;</p>
            <p>이상</p>
        </td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum041  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum042  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum043  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum044  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum045  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum046 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum051  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum052  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum053  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum054  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum055  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum056 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">
            <p>만14세</p>
            <p>&nbsp;</p>
            <p>이하</p>
        </td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum061  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum062  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum063  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum064  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum065  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum066 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum071  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum072  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum073  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum074  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum075  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum076 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">죽은<br> 태아</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum081  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum082  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum083  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum084  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum085  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum086 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum091  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum092  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum093  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum094  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum095  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum096 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">
            <p>개장</p>
            <p>&nbsp;</p>
            <p>유골</p>
        </td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum101  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum102  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum103  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum104  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum105  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum106 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum111  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum112  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum113  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum114  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum115  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum116 %></b></td>
    </tr>
      <!-- tr>
        <td width="51" rowspan="2" align="center">
            <p>적출물</p>
        </td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum291  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum292  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum293  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum294  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum295  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum296 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum301  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum302  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum303  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum304  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum305  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum306 %></b></td>
    </tr -->
    <tr>
        <td width="51" rowspan="4" align="center">
            <p>감면</p>
            <p>&nbsp;</p>
            <p>대상</p>
        </td>
        <td width="46" rowspan="2" align="center">100%</td>
        <td width="41" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum121  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum122  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum123  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum124  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum125  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum126 %></b></td>
    </tr>
    <tr>
        <td width="41" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum131  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum132  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum133  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum134  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum135  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum136 %></b></td>
    </tr>
    <tr>
        <td width="46" rowspan="2" align="center">50%</td>
        <td width="41" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum141  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum142  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum143  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum144  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum145  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum146 %></b></td>
    </tr>
    <tr>
        <td width="41" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum151  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum152  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum153  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum154  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum155  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum156 %></b></td>
    </tr>

    <!-- 봉안내역
    <tr>
        <td width="150" rowspan="2" colspan="3" align="center">봉안 내역</td>
        <td width="169" colspan="2" align="center">당일</td>
        <td width="164" colspan="2" align="center">월계</td>
        <td width="181" colspan="2" align="center">연계</td>
    </tr>
    <tr>
        <td width="67" align="center">건수</td>
        <td width="96" align="center">금액</td>
        <td width="63" align="center">건수</td>
        <td width="95" align="center">금액</td>
        <td width="65" align="center">건수</td>
        <td width="110" align="center">금액</td>
    </tr>
    <tr>
        <td width="150" colspan="3" align="center">봉안당 수입금 계</td>
        <td width="67" align="right"><b><%= dfccntSum161  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum162  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum163  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum164  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum165  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum166 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">소계</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum171  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum172  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum173  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum174  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum175  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum176 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum181  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum182  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum183  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum184  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum185  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum186 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">개인</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum191  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum192  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum193  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum194  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum195  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum196 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum201  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum202  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum203  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum204  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum205  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum206 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">부부</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum211  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum212  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum213  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum214  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum215  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum216 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum221  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum222  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum223  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum224  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum225  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum226 %></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="2" align="center">무연고</td>
        <td width="93" colspan="2" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum231  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum232  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum233  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum234  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum235  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum236 %></b></td>
    </tr>
    <tr>
        <td width="93" colspan="2" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum241  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum242  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum243  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum244  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum245  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum246 %></b></td>
    </tr>
     <tr>
        <td width="54" rowspan="2" align="center">기간연장 <br>세부내역</td>
        <td width="91" colspan="2" align="center">개인</td>
        <td width="53" align="right"><b><%= dfccntSum311%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum312%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum313%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum314%></b></td>
        <td width="76" align="right"><b><%= dftcntSum315%></b></td>
        <td width="114" align="right"><b><%= dftamtSum316%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">부부</td>
        <td width="53" align="right"><b><%= dfccntSum321%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum322%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum323%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum324%></b></td>
        <td width="76" align="right"><b><%= dftcntSum325%></b></td>
        <td width="114" align="right"><b><%= dftamtSum326%></b></td>
    </tr>
    <tr>
        <td width="51" rowspan="4" align="center">
            <p>감면</p>
            <p>&nbsp;</p>
            <p>대상</p>
        </td>
        <td width="46" rowspan="2" align="center">100%</td>
        <td width="41" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum251  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum252  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum253  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum254  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum255  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum256 %></b></td>
    </tr>
    <tr>
        <td width="41" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum261  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum262  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum263  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum264  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum265  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum266 %></b></td>
    </tr>
    <tr>
        <td width="46" rowspan="2" align="center">50%</td>
        <td width="41" align="center">관내</td>
        <td width="67" align="right"><b><%= dfccntSum271  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum272  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum273  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum274  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum275  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum276 %></b></td>
    </tr>
    <tr>
        <td width="41" align="center">관외</td>
        <td width="67" align="right"><b><%= dfccntSum281  %></b></td>
        <td width="96" align="right"><b><%= dfcamtSum282  %></b></td>
        <td width="63" align="right"><b><%= dfmcntSum283  %></b></td>
        <td width="95" align="right"><b><%= dfmamtSum284  %></b></td>
        <td width="65" align="right"><b><%= dftcntSum285  %></b></td>
        <td width="110" align="right"><b><%= dftamtSum286 %></b></td>
    </tr> -->
    <tr>
        <td width="51" align="center" height="50">
            <p>기</p>
            <p>&nbsp;</p>
            <p>타</p>
        </td>
        <td width="625" colspan="8">
        <textarea rows="5" cols="103" name="others" wrap="soft" ><%=StringUtil.nvl( Others, "" )%></textarea>
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
         * @description :  화장,봉안  수입일보 테이블(suip_ilbo1)에 insert 후 select 작업
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
        		mainform.action			= "/SUIP1141/appMngListHwa?actionTp=appMngDataSrchList";

        		mainform.submit();

        	}


        	/**
            * @param
            * @return
            * @description :  ms sql server에 dbo.TB_PAYMENT 테이블에 insert  작업( insert 후 select도 하고 max seq도 순차적으로 한다.)
            */

        	function goMssqlInsert(){



        		if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
        		  alert("날짜를 입력하세요");
        		  mainform.workDate.focus();
        		  return;
        		}

        		/*// 진해는 화장장 사용 X ( 봉안 년건수 값이 0보다 큰지 체크 즉 검색을 했는지)
        		if(mainform.dftcntSum165.value == "0" || mainform.dftcntSum165.value == null) {

        			alert("검색을 하시고 난 후에 저장하세요");


        			  return;
        		}		*/

        		// 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
        		if ( !beforeInsertCheck() ) {
        			return;
        		}
        		// 2014 06 02 noo end


        	    mainform.actionTp.value = "appMngDataSrchInsert_one";

        		mainform.target			= "_self";
        		mainform.method			= "post";
        		mainform.action			= "/SUIP1141/appMngListHwa?actionTp=appMngDataSrchInsert_one";

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



        //전자결재 popup
        function popupApp(){
         var sFirstSeq =  mainform.sFirstSeq.value;

         var sSecondSeq =  mainform.sSecondSeq.value;

         var settings = 'toolbar=no,directories=no, status=no,menubar=no,scrollbars=auto,resizable=no,height=600,width=800,left=0,top=0';
         //var url = 'http://112.1.160.254/ORADBTEST/jsjtot.asp?DBGbn=JSJ&sSeq=' + sFirstSeq + "&sSecondSeq=" + sSecondSeq ;

         var url = 'http://112.1.160.254/ORADBTEST/ErpApproval.asp?DBGbn=JSJ&sSeq=' + sFirstSeq ;


         if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
        	  alert("날짜를 입력하세요");
        	  mainform.workDate.focus();
        	  return;
         }

        //화장장  값이 0보다 큰지 체크 즉 검색을 했는지
        /*
        if( mainform.dftcntSum165.value == "0" || mainform.dftcntSum165.value == null ) {
        	alert("검색을 하시고 난 후에 저장하세요");
        	 return;
         }	*/

         // 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
        if ( !beforeInsertCheck()) {
        	return;
        }

        if ( sFirstSeq == null || sFirstSeq == "" || sFirstSeq == "null" ) {
        	 alert("저장을 하시고 난 후에 전자결재를 하세요");
        	 return;
         }


         window.open(url,'전자결재',settings);

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
