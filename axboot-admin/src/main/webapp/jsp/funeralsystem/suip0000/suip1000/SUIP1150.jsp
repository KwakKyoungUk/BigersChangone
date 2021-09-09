<!----------------------------------------------------------------------------------------
* @program		:	appLayReg.jsp
* @description	:	전자결재 ( 봉안당  )
* @author		:	noo
* @create		:	2014.05.03
* @update		:	2014.06.24
* @version		:	0.1
* @descripiton	:	업데이트 내용 있음
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
	AppMngDataSrch	appMngDataSrchSearch = null;
	appMngDataSrchSearch = (AppMngDataSrch)request.getAttribute( "appMngDataSrch" );

	if( appMngDataSrchSearch == null ){
		appMngDataSrchSearch = new AppMngDataSrch();
	}


	//  ms sql server에 insert 후 max seq 가져오기
	AppMngDataSrch	appMngDataSrchSearchMaxSeq = null;
	appMngDataSrchSearchMaxSeq = (AppMngDataSrch)request.getAttribute( "appMngDataSrchSearch" );

	if( appMngDataSrchSearchMaxSeq == null ){
		appMngDataSrchSearchMaxSeq = new AppMngDataSrch();
	}


	// 로그인 아이디
	String id = CommonUtils.getCurrentLoginUserCd();
	request.setAttribute("id", id);

	System.out.println("id :" + id );


	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	String today = formatter.format(new java.util.Date());

	System.out.println("today :" + today );


	//최대값 : seq
	long sFirstSeq = (appMngDataSrchSearchMaxSeq.getSeq() != null) ?  appMngDataSrchSearchMaxSeq.getSeq(): 0;
	System.out.println("Max first Seq : " + sFirstSeq);


	// ----- 숫자에 3 자리 마다 컴마 찍기시작  -- //
	// --------------------------------- //

	// 봉안당 수입금 계 당일  건수
	int ccntSum011 =  appMngDataSrchSearch.getCcntSum011();
	DecimalFormat  df = new DecimalFormat("###,###");
	String dfccntSum011 = df.format(ccntSum011);

 // 봉안당 수입금 계  당일 금액
	long camtSum012 =  appMngDataSrchSearch.getCamtSum012();
	String dfcamtSum012 = df.format(camtSum012);

 // 봉안당  수입금 계 월계 건수
	int mcntSum013 =  appMngDataSrchSearch.getMcntSum013();
	String dfmcntSum013 = df.format(mcntSum013);

 // 봉안당 수입금 계 월계 금액
 long mamtSum014 =  appMngDataSrchSearch.getMamtSum014();
	String dfmamtSum014 = df.format(mamtSum014);

 // 봉안당 수입금 계  연계 건수
 int tcntSum015 =  appMngDataSrchSearch.getTcntSum015();
	String dftcntSum015 = df.format(tcntSum015);

 // 봉안당 수입금 계  연계 금액
 long tamtSum016 =  appMngDataSrchSearch.getTamtSum016();
	String dftamtSum016 = df.format(tamtSum016);


	// 소계 관내  당일  건수
	int ccntSum021 =  appMngDataSrchSearch.getCcntSum021();
	String dfccntSum021 = df.format(ccntSum021);
	 // 소계 관내  당일 금액
	long camtSum022 =  appMngDataSrchSearch.getCamtSum022();
	String dfcamtSum022 = df.format(camtSum022);

	// 소계 관내 월계 건수
	int mcntSum023 =  appMngDataSrchSearch.getMcntSum023();
	String dfmcntSum023 = df.format(mcntSum023);

	// 소계 관내 월계 금액
	long mamtSum024 =  appMngDataSrchSearch.getMamtSum024();
	String dfmamtSum024 = df.format(mamtSum024);

	// 소계 관내  연계 건수
	int tcntSum025 =  appMngDataSrchSearch.getTcntSum025();
	String dftcntSum025 = df.format(tcntSum025);

	// 소계 관내  연계 금액
	long tamtSum026 =  appMngDataSrchSearch.getTamtSum026();
	String dftamtSum026 = df.format(tamtSum026);



	// 소계 관외  당일  건수
	int ccntSum031 =  appMngDataSrchSearch.getCcntSum031();
	String dfccntSum031 = df.format(ccntSum031);

	// 소계 관외  당일 금액
	long camtSum032 =  appMngDataSrchSearch.getCamtSum032();
	String dfcamtSum032 = df.format(camtSum032);

	// 소계 관외 월계 건수
	int mcntSum033 =  appMngDataSrchSearch.getMcntSum033();
	String dfmcntSum033 = df.format(mcntSum033);

	// 소계 관외 월계 금액
	long mamtSum034 =  appMngDataSrchSearch.getMamtSum034();
	String dfmamtSum034 = df.format(mamtSum034);

	// 소계 관외  연계 건수
	int tcntSum035 =  appMngDataSrchSearch.getTcntSum035();
	String dftcntSum035 = df.format(tcntSum035);

	// 소계 관외  연계 금액
	long tamtSum036 =  appMngDataSrchSearch.getTamtSum036();
	String dftamtSum036 = df.format(tamtSum036);



	// 개인 관내  당일  건수
	int ccntSum041 =  appMngDataSrchSearch.getCcntSum041();
	String dfccntSum041 = df.format(ccntSum041);

	// 개인 관내  당일 금액
	long camtSum042 =  appMngDataSrchSearch.getCamtSum042();
	String dfcamtSum042 = df.format(camtSum042);

	// 개인 관내 월계 건수
	int mcntSum043 =  appMngDataSrchSearch.getMcntSum043();
	String dfmcntSum043 = df.format(mcntSum043);

	// 개인 관내 월계 금액
	long mamtSum044 =  appMngDataSrchSearch.getMamtSum044();
	String dfmamtSum044 = df.format(mamtSum044);

	// 개인 관내  연계 건수
	int tcntSum045 =  appMngDataSrchSearch.getTcntSum045();
	String dftcntSum045 = df.format(tcntSum045);

	// 개인 관내  연계 금액
	long tamtSum046 =  appMngDataSrchSearch.getTamtSum046();
	String dftamtSum046 = df.format(tamtSum046);



	// 개인 관외  당일  건수
	int ccntSum051 =  appMngDataSrchSearch.getCcntSum051();
	String dfccntSum051 = df.format(ccntSum051);

	// 개인 관외  당일 금액
	long camtSum052 =  appMngDataSrchSearch.getCamtSum052();
	String dfcamtSum052 = df.format(camtSum052);

	// 개인 관외 월계 건수
	int mcntSum053 =  appMngDataSrchSearch.getMcntSum053();
	String dfmcntSum053 = df.format(mcntSum053);

	// 개인 관외 월계 금액
	long mamtSum054 =  appMngDataSrchSearch.getMamtSum054();
	String dfmamtSum054 = df.format(mamtSum054);

	// 개인 관외  연계 건수
	int tcntSum055 =  appMngDataSrchSearch.getTcntSum055();
	String dftcntSum055 = df.format(tcntSum055);

	// 개인 관외  연계 금액
	long tamtSum056 =  appMngDataSrchSearch.getTamtSum056();
	String dftamtSum056 = df.format(tamtSum056);



	// 부부 관내  당일  건수
	int ccntSum061 =  appMngDataSrchSearch.getCcntSum061();
	String dfccntSum061 = df.format(ccntSum061);

	// 부부 관내  당일 금액
	long camtSum062 =  appMngDataSrchSearch.getCamtSum062();
	String dfcamtSum062 = df.format(camtSum062);

	// 부부 관내 월계 건수
	int mcntSum063 =  appMngDataSrchSearch.getMcntSum063();
	String dfmcntSum063 = df.format(mcntSum063);

	// 부부 관내 월계 금액
	long mamtSum064 =  appMngDataSrchSearch.getMamtSum064();
	String dfmamtSum064 = df.format(mamtSum064);

	// 부부 관내  연계 건수
	int tcntSum065 =  appMngDataSrchSearch.getTcntSum065();
	String dftcntSum065 = df.format(tcntSum065);

	// 부부 관내  연계 금액
	long tamtSum066 =  appMngDataSrchSearch.getTamtSum066();
	String dftamtSum066 = df.format(tamtSum066);



	// 부부 관외  당일  건수
	int ccntSum071 =  appMngDataSrchSearch.getCcntSum071();
	String dfccntSum071 = df.format(ccntSum071);

	// 부부 관외  당일 금액
	long camtSum072 =  appMngDataSrchSearch.getCamtSum072();
	String dfcamtSum072 = df.format(camtSum072);

	// 부부 관외 월계 건수
	int mcntSum073 =  appMngDataSrchSearch.getMcntSum073();
	String dfmcntSum073 = df.format(mcntSum073);

	// 부부 관외 월계 금액
	long mamtSum074 =  appMngDataSrchSearch.getMamtSum074();
	String dfmamtSum074 = df.format(mamtSum074);

	// 부부 관외  연계 건수
	int tcntSum075 =  appMngDataSrchSearch.getTcntSum075();
	String dftcntSum075 = df.format(tcntSum075);

	// 부부 관외  연계 금액
	long tamtSum076 =  appMngDataSrchSearch.getTamtSum076();
	String dftamtSum076 = df.format(tamtSum076);



	// 무연고 관내  당일  건수
	int ccntSum081 =  appMngDataSrchSearch.getCcntSum081();
	String dfccntSum081 = df.format(ccntSum081);

	// 무연고 관내  당일 금액
	long camtSum082 =  appMngDataSrchSearch.getCamtSum082();
	String dfcamtSum082 = df.format(camtSum082);

	// 무연고 관내 월계 건수
	int mcntSum083 =  appMngDataSrchSearch.getMcntSum083();
	String dfmcntSum083 = df.format(mcntSum083);

	// 무연고 관내 월계 금액
	long mamtSum084 =  appMngDataSrchSearch.getMamtSum084();
	String dfmamtSum084 = df.format(mamtSum084);

	// 무연고 관내  연계 건수
	int tcntSum085 =  appMngDataSrchSearch.getTcntSum085();
	String dftcntSum085 = df.format(tcntSum085);

	// 무연고 관내  연계 금액
	long tamtSum086 =  appMngDataSrchSearch.getTamtSum086();
	String dftamtSum086 = df.format(tamtSum086);



	// 무연고 관외  당일  건수
	int ccntSum091 =  appMngDataSrchSearch.getCcntSum091();
	String dfccntSum091 = df.format(ccntSum091);

	// 무연고 관외  당일 금액
	long camtSum092 =  appMngDataSrchSearch.getCamtSum092();
	String dfcamtSum092 = df.format(camtSum092);

	// 무연고 관외 월계 건수
	int mcntSum093 =  appMngDataSrchSearch.getMcntSum093();
	String dfmcntSum093 = df.format(mcntSum093);

	// 무연고 관외 월계 금액
	long mamtSum094 =  appMngDataSrchSearch.getMamtSum094();
	String dfmamtSum094 = df.format(mamtSum094);

	// 무연고 관외  연계 건수
	int tcntSum095 =  appMngDataSrchSearch.getTcntSum095();
	String dftcntSum095 = df.format(tcntSum095);

	// 무연고 관외  연계 금액
	long tamtSum096 =  appMngDataSrchSearch.getTamtSum096();
	String dftamtSum096 = df.format(tamtSum096);



	// 감면대상 100%  관내  당일  건수
	int ccntSum101 =  appMngDataSrchSearch.getCcntSum101();
	String dfccntSum101 = df.format(ccntSum101);

	// 감면대상 100% 관내  당일 금액
	long camtSum102 =  appMngDataSrchSearch.getCamtSum102();
	String dfcamtSum102 = df.format(camtSum102);

	// 감면대상 100%  관내 월계 건수
	int mcntSum103 =  appMngDataSrchSearch.getMcntSum103();
	String dfmcntSum103 = df.format(mcntSum103);

	// 감면대상 100% 관내 월계 금액
	long mamtSum104 =  appMngDataSrchSearch.getMamtSum104();
	String dfmamtSum104 = df.format(mamtSum104);

	// 감면대상 100%  관내  연계 건수
	int tcntSum105 =  appMngDataSrchSearch.getTcntSum105();
	String dftcntSum105 = df.format(tcntSum105);

	// 감면대상 100%  관내  연계 금액
	long tamtSum106 =  appMngDataSrchSearch.getTamtSum106();
	String dftamtSum106 = df.format(tamtSum106);



	// 감면대상 100% 관외  당일  건수
	int ccntSum111 =  appMngDataSrchSearch.getCcntSum111();
	String dfccntSum111 = df.format(ccntSum111);

	// 감면대상 100%  관외  당일 금액
	long camtSum112 =  appMngDataSrchSearch.getCamtSum112();
	String dfcamtSum112 = df.format(camtSum112);

	// 감면대상 100%  관외 월계 건수
	int mcntSum113 =  appMngDataSrchSearch.getMcntSum113();
	String dfmcntSum113 = df.format(mcntSum113);

	// 감면대상 100%  관외 월계 금액
	long mamtSum114 =  appMngDataSrchSearch.getMamtSum114();
	String dfmamtSum114 = df.format(mamtSum114);

	// 감면대상 100%  관외  연계 건수
	int tcntSum115 =  appMngDataSrchSearch.getTcntSum115();
	String dftcntSum115 = df.format(tcntSum115);

	// 감면대상 100% 관외  연계 금액
	long tamtSum116 =  appMngDataSrchSearch.getTamtSum116();
	String dftamtSum116 = df.format(tamtSum116);


	// 감면대상 50%  관내  당일  건수
	int ccntSum121 =  appMngDataSrchSearch.getCcntSum121();
	String dfccntSum121 = df.format(ccntSum121);

	// 감면대상 50% 관내  당일 금액
	long camtSum122 =  appMngDataSrchSearch.getCamtSum122();
	String dfcamtSum122 = df.format(camtSum122);

	// 감면대상 50%  관내 월계 건수
	int mcntSum123 =  appMngDataSrchSearch.getMcntSum123();
	String dfmcntSum123 = df.format(mcntSum123);

	// 감면대상 50% 관내 월계 금액
	long mamtSum124 =  appMngDataSrchSearch.getMamtSum124();
	String dfmamtSum124 = df.format(mamtSum124);

	// 감면대상 50%  관내  연계 건수
	int tcntSum125 =  appMngDataSrchSearch.getTcntSum125();
	String dftcntSum125 = df.format(tcntSum125);

	// 감면대상 50%  관내  연계 금액
	long tamtSum126 =  appMngDataSrchSearch.getTamtSum126();
	String dftamtSum126 = df.format(tamtSum126);



	// 감면대상 50% 관외  당일  건수
	int ccntSum131 =  appMngDataSrchSearch.getCcntSum131();
	String dfccntSum131 = df.format(ccntSum131);

	// 감면대상 50%  관외  당일 금액
	long camtSum132 =  appMngDataSrchSearch.getCamtSum132();
	String dfcamtSum132 = df.format(camtSum132);

	// 감면대상 50%  관외 월계 건수
	int mcntSum133 =  appMngDataSrchSearch.getMcntSum133();
	String dfmcntSum133 = df.format(mcntSum133);

	// 감면대상 50%  관외 월계 금액
	long mamtSum134 =  appMngDataSrchSearch.getMamtSum134();
	String dfmamtSum134 = df.format(mamtSum134);

	// 감면대상 50%  관외  연계 건수
	int tcntSum135 =  appMngDataSrchSearch.getTcntSum135();
	String dftcntSum135 = df.format(tcntSum135);

	// 감면대상 50% 관외  연계 금액
	long tamtSum136 =  appMngDataSrchSearch.getTamtSum136();
	String dftamtSum136 = df.format(tamtSum136);


	// 봉안연장  개인 당일  건수
	int ccntSum141 =  appMngDataSrchSearch.getCcntSum141();
	String dfccntSum141 = df.format(ccntSum141);

	// 봉안연장  개인  당일 금액
	long camtSum142 =  appMngDataSrchSearch.getCamtSum142();
	String dfcamtSum142 = df.format(camtSum142);

	// 봉안연장  개인 월계 건수
	int mcntSum143 =  appMngDataSrchSearch.getMcntSum143();
	String dfmcntSum143 = df.format(mcntSum143);

	// 봉안연장  개인 월계 금액
	long mamtSum144 =  appMngDataSrchSearch.getMamtSum144();
	String dfmamtSum144 = df.format(mamtSum144);

	// 봉안연장  개인  연계 건수
	int tcntSum145 =  appMngDataSrchSearch.getTcntSum145();
	String dftcntSum145 = df.format(tcntSum145);

	// 봉안연장  개인  연계 금액
	long tamtSum146 =  appMngDataSrchSearch.getTamtSum146();
	String dftamtSum146 = df.format(tamtSum146);



	// 봉안연장  부부 당일  건수
	int ccntSum151 =  appMngDataSrchSearch.getCcntSum151();
	String dfccntSum151 = df.format(ccntSum151);

	// 봉안연장  부부  당일 금액
	long camtSum152 =  appMngDataSrchSearch.getCamtSum152();
	String dfcamtSum152 = df.format(camtSum152);

	// 봉안연장  부부 월계 건수
	int mcntSum153 =  appMngDataSrchSearch.getMcntSum153();
	String dfmcntSum153 = df.format(mcntSum153);

	// 봉안연장  부부 월계 금액
	long mamtSum154 =  appMngDataSrchSearch.getMamtSum154();
	String dfmamtSum154 = df.format(mamtSum154);

	// 봉안연장  부부  연계 건수
	int tcntSum155 =  appMngDataSrchSearch.getTcntSum155();
	String dftcntSum155 = df.format(tcntSum155);

	// 봉안연장  부부  연계 금액
	long tamtSum156 =  appMngDataSrchSearch.getTamtSum156();
	String dftamtSum156 = df.format(tamtSum156);



 // ----- 숫자에 3 자리 마다 컴마 찍기 종료  --- //
	// ----------------------------------- //


	// 작업일자
	String workDate = ( String )request.getParameter("workDate");
 System.out.print("workDate  = " + workDate);
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

					//String daysssss = dateFormat.format(date);
					//dates = "월요일";
	           }


		} catch (Exception e)	{
				e.printStackTrace();
		}

		String frmID = "0000000ul";

		String data  = frmID + "|" + year + "|" + month + "|" + day + "|" + dates + "|" +
		totWorker + "|" + curWorker + "|" + actWorker + "|" + eduWorker + "|" + ymcWorker + "|" +
		outWorker + "|" +
		othWorker + "|" + acsWorker + "|" +
     dfccntSum011 + "|" +
     dfcamtSum012 + "|" +
     dfmcntSum013 + "|" +
     dfmamtSum014 + "|" +
     dftcntSum015 + "|" +
     dftamtSum016 + "|" +

     dfccntSum021 + "|" +
     dfcamtSum022 + "|" +
     dfmcntSum023 + "|" +
     dfmamtSum024 + "|" +
     dftcntSum025 + "|" +
     dftamtSum026 + "|" +

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

		dfccntSum071 + "|" +
		dfcamtSum072 + "|" +
		dfmcntSum073 + "|" +
		dfmamtSum074 + "|" +
		dftcntSum075 + "|" +
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
     insertOthers;

		request.setAttribute("data", data);
%>

<c:set var="mainForm">

	<form name="mainform" >
<input type="hidden" name="actionTp">

<input name="frmName" type="hidden"  value="장사통합@SANG상복공원봉안당운영일지">
<input name="frmId" type="hidden"    value="0000000ul">
<input name="data" type="hidden"  value="<%=StringUtil.nvl( data, "" )%>">
<input name="id" type="hidden"  value="<%=StringUtil.nvl( id, "" )%>">
<input name="updtime" type="hidden"  value="<%=StringUtil.nvl( today, "" )%>">
<input name="tamtSum016" type="hidden"  value="<%= appMngDataSrchSearch.getTamtSum016() %>">
<input name="sFirstSeq" type="hidden"  value="<%= appMngDataSrchSearchMaxSeq.getSeq() %>">


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
                     <input id="workDate" class="AXInput W150" name="workDate" type="text" class="t_line_1" value="<%=StringUtil.nvl( workDate, new SimpleDateFormat("yyyyMMdd").format(new Date()) )%>"
                     numeric ondblclick="popUpCalendarNoDash(this);"  onclick=""
                      size="8"  maxLength="8" required numeric >&nbsp;&nbsp;&nbsp;&nbsp;


					<button class="AXButton" onclick="javascript:goList();">검색</button>&nbsp;&nbsp;

					<button class="AXButton" onclick="javascript:goMssqlInsert();">저장</button>&nbsp;&nbsp;

					<!-- <a href "http://112.1.160.254/ORADBTEST/jsjtot.asp?DBGbn=JSJ&sSeq=" & sFirstSeq" title="전자결재"> -->
					<input class="AXButton" type = "button" value = "전자결재" onclick="popupApp();">
					<!-- </a>  -->
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
					<input class="AXInput" name="totWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( totWorker , "" ) %>" >
					</td>

					<td>현원
					<input class="AXInput" name="curWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( curWorker , "" ) %>" >
					</td>

					<td>사고
					<input class="AXInput" name="actWorker" onKeyPress="checkNumber();" style="text-align:right;" type="text" size="5" value="<%=StringUtil.nvl( actWorker , "" ) %>" >
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

 <table border="1" width="691" cellpadding="0" cellspacing="0" class="AXGridTable">
    <tr>
        <td width="151" rowspan="2" colspan="3"  align="center">구분</td>
        <td width="157" colspan="2" align="center">당일</td>
        <td width="159" colspan="2" align="center">월계</td>
        <td width="196" colspan="2" align="center">연계</td>
    </tr>
    <tr>
        <td width="53" align="center">건수</td>
        <td width="98" align="center">금액</td>
        <td width="58" align="center">건수</td>
        <td width="95" align="center">금액</td>
        <td width="76" align="center">건수</td>
        <td width="114" align="center">금액</td>
    </tr>
    <tr>
        <td width="151" colspan="3" align="center">봉안당 수입금 계</td>
        <td width="53" align="right"><b><%= StringUtil.nvl( dfccntSum011 , "0" ) %></b></td>
        <td width="98" align="right"><b><%= StringUtil.nvl( dfcamtSum012 , "0" ) %></b></td>
        <td width="58" align="right"><b><%= StringUtil.nvl( dfmcntSum013 , "0" ) %></b></td>
        <td width="95" align="right"><b><%= StringUtil.nvl( dfmamtSum014 , "0" ) %></b></td>
        <td width="76" align="right"><b><%= StringUtil.nvl( dftcntSum015 , "0" ) %></b></td>
        <td width="114" align="right"><b><%= StringUtil.nvl( dftamtSum016 , "0" ) %></b></td>
    </tr>
    <tr>
        <td width="54" rowspan="2" align="center">소계</td>
        <td width="91" colspan="2" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum021%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum022%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum023%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum024%></b></td>
        <td width="76" align="right"><b><%= dftcntSum025%></b></td>
        <td width="114" align="right"><b><%= dftamtSum026%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum031%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum032%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum033%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum034%></b></td>
        <td width="76" align="right"><b><%= dftcntSum035%></b></td>
        <td width="114" align="right"><b><%= dftamtSum036%></b></td>
    </tr>
    <tr>
        <td width="54" rowspan="2" align="center">개인</td>
        <td width="91" colspan="2" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum041%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum042%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum043%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum044%></b></td>
        <td width="76" align="right"><b><%= dftcntSum045%></b></td>
        <td width="114" align="right"><b><%= dftamtSum046%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum051%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum052%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum053%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum054%></b></td>
        <td width="76" align="right"><b><%= dftcntSum055%></b></td>
        <td width="114" align="right"><b><%= dftamtSum056%></b></td>
    </tr>
    <tr>
        <td width="54" rowspan="2" align="center">부부</td>
        <td width="91" colspan="2" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum061%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum062%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum063%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum064%></b></td>
        <td width="76" align="right"><b><%= dftcntSum065%></b></td>
        <td width="114" align="right"><b><%= dftamtSum066%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum071%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum072%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum073%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum074%></b></td>
        <td width="76" align="right"><b><%= dftcntSum075%></b></td>
        <td width="114" align="right"><b><%= dftamtSum076%></b></td>
    </tr>
    <tr>
        <td width="54" rowspan="2" align="center">무연고</td>
        <td width="91" colspan="2" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum081%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum082%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum083%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum084%></b></td>
        <td width="76" align="right"><b><%= dftcntSum085%></b></td>
        <td width="114" align="right"><b><%= dftamtSum086%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum091%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum092%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum093%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum094%></b></td>
        <td width="76" align="right"><b><%= dftcntSum095%></b></td>
        <td width="114" align="right"><b><%= dftamtSum096%></b></td>
    </tr>
    <tr>
        <td width="54" rowspan="2" align="center">기간연장 <br>세부내역</td>
        <td width="91" colspan="2" align="center">개인</td>
        <td width="53" align="right"><b><%= dfccntSum141%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum142%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum143%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum144%></b></td>
        <td width="76" align="right"><b><%= dftcntSum145%></b></td>
        <td width="114" align="right"><b><%= dftamtSum146%></b></td>
    </tr>
    <tr>
        <td width="91" colspan="2" align="center">부부</td>
        <td width="53" align="right"><b><%= dfccntSum151%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum152%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum153%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum154%></b></td>
        <td width="76" align="right"><b><%= dftcntSum155%></b></td>
        <td width="114" align="right"><b><%= dftamtSum156%></b></td>
    </tr>

    <tr>
        <td width="54" rowspan="4" align="center">
            <p>감면</p>
            <p>&nbsp;</p>
            <p>대상</p>
        </td>
        <td width="42" rowspan="2" align="center">100%</td>
        <td width="43" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum101%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum102%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum103%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum104%></b></td>
        <td width="76" align="right"><b><%= dftcntSum105%></b></td>
        <td width="114" align="right"><b><%= dftamtSum106%></b></td>
    </tr>
    <tr>
        <td width="43" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum111%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum112%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum113%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum114%></b></td>
        <td width="76" align="right"><b><%= dftcntSum115%></b></td>
        <td width="114" align="right"><b><%= dftamtSum116%></b></td>
    </tr>
    <tr>
        <td width="42" rowspan="2" align="center">50%</td>
        <td width="43" align="center">관내</td>
        <td width="53" align="right"><b><%= dfccntSum121%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum122%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum123%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum124%></b></td>
        <td width="76" align="right"><b><%= dftcntSum125%></b></td>
        <td width="114" align="right"><b><%= dftamtSum126%></b></td>
    </tr>
    <tr>
        <td width="43" align="center">관외</td>
        <td width="53" align="right"><b><%= dfccntSum131%></b></td>
        <td width="98" align="right"><b><%= dfcamtSum132%></b></td>
        <td width="58" align="right"><b><%= dfmcntSum133%></b></td>
        <td width="95" align="right"><b><%= dfmamtSum134%></b></td>
        <td width="76" align="right"><b><%= dftcntSum135%></b></td>
        <td width="114" align="right"><b><%= dftamtSum136%></b></td>
    </tr>
    <tr>
        <td width="54" align="center">
            <p>기</p>
            <p>&nbsp;</p>
            <p>타</p>
            <p>&nbsp;</p>
        </td>

        <td width="560" height="28" align="center" rowspan="3" colspan="8">
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
         * @description :  보안당  수입일보 테이블(suip_ilbo_charn)에 insert 후 select 작업
         */
        	function goList(){

        		mainform.actionTp.value = "appMngDataSrchLayList";

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
        		mainform.action			= "/SUIP1150/appMngLay";

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

        		// 봉안당 수입금 연계 금액 값이 0보다 큰지 체크: 즉 검색을 했는지
        		if( mainform.tamtSum016.value == "0" || mainform.tamtSum016.value == null ) {
        		  alert("검색을 하시고 난 후에 저장하세요");
        		  return;
        		}

        		// 총원, 현원, 사고 숫자 유효성 체크 :  2014 06 02 noo start
        		if ( !beforeInsertCheck()) {
        			return;
        		}
        		// 2014 06 02 noo end

        	    mainform.actionTp.value = "appMngDataSrchLayInsert";

        		mainform.target			= "_self";
        		mainform.method			= "post";
        		mainform.action			= "/SUIP1150/appMngLay?actionTp=appMngDataSrchLayInsert";

        	    mainform.submit();
        	}



        	//숫자만 입력하는 함수 2014 05 03 noo
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

        	 var settings = 'toolbar=no,directories=no, status=no,menubar=no,scrollbars=auto,resizable=no,height=600,width=800,left=0,top=0';
        	 var url = 'http://112.1.160.254/ORADBTEST/ErpApproval.asp?DBGbn=JSJ&sSeq=' + sFirstSeq;


        	 if( mainform.workDate.value == "" || mainform.workDate.value == null ) {
        		  alert("날짜를 입력하세요");
        		  mainform.workDate.focus();
        		  return;
        	 }

        	// 봉안당 수입금 연계 금액 값이 0보다 큰지 체크: 즉 검색을 했는지
        	if( mainform.tamtSum016.value == "0" || mainform.tamtSum016.value == null ) {
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


        	// var winObject = window.open(url,"전자결재->봉안당",settings);
        	 window.open(url,'전자결재_봉안당',settings);

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
