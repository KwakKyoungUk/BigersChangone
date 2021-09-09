<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4021.jsp
 - 설      명	: 생산 관리 > 식단관리 > 식단 작업 등록 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.08  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "식단작업등록");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="blank.jsp">
    <ax:div name="header">

    </ax:div>
    <ax:div name="css">
    	<style type="text/css">
            .customer_title, .bill_no {
            	font-size: 20px;
            	font-weight: bolder;
            }
    	</style>
    </ax:div>
    <ax:div name="contents">

        <div class="ax-body">
            <div class="ax-wrap">
                <div class="ax-layer cx-content-layer">
                    <div class="ax-col-12 ax-content expand">
                        <!-- s.CXPage -->
                        <div id="CXPage">

                            <ax:row>
                                <ax:col >

                   					<ax:custom customid="table">
					                    <ax:custom customid="tr">
					                        <ax:custom customid="td">

					                            <div class="ax-button-group">

					                                <div class="ax-clear"></div>
					                            </div>
												<table cellpadding="0" cellspacing="0" class="AXGridTable">
												    <tbody>
												    	<tr>
												    		<th style='width:20%;'>조리일자 / 구분
												    		</th>
												    		<td>
												    			<input type="text" id="cook-date" name="cook-date" title="조리일자" class="AXInput" style="text-align:center;" disabled/>
												    			&nbsp;
												    			<select id="info-meal-gubun" name="info-meal-gubun" class="AXSelect W100"></select>
												    		</td>
												    	</tr>
												    </tbody>
												</table>

					                            <iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>

					                        </ax:custom>

					                    </ax:custom>
					                </ax:custom>

                                </ax:col>
                            </ax:row>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ax:div>
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">
        var pb_data={
            	//입금구분
            	srchReceiptGubun	: "",
        }
        var fnObj = {
        		data: {
              		 partCode 			: ""
              		, itemCode			: ""
              		, recipeCode		: ""
              		, recipeDate		: ""
              		, recipeGubun		: ""
              		, printName		: ""
          		},
        		CODES: {
        			mealsGubun: Common.getCode("091")
            	},
            pageStart: function(){
            	this.data.partCode		= "${param.partCode}";
                this.data.itemCode		= "${param.itemCode}";
                this.data.recipeCode	= "${param.recipeCode}";
                this.data.printName		= "${param.printName}";

                this.data.recipeDate		= this.data.recipeCode.substring(0,4) + "-" + this.data.recipeCode.substring(4,6) + "-" +this.data.recipeCode.substring(6,8);

              	//조리일자
       		 	$("#cook-date").val(fnObj.data.recipeDate);
       			//조/중/석식 콤보
       		 	$("#info-meal-gubun").bindSelect({
                    options:fnObj.CODES.mealsGubun,
                    onchange: function(){
                       	 //로딩시 무조건 탄다. 결국 이 이벤트로 그리드 세팅.
                       	 fnObj.data.recipeCode = fnObj.data.recipeCode.substring(0,8) + this.value;
                       	 fnObj.eventFunc.submitSrch();

			         }
                });
       		 	fnObj.eventFunc.submitSrch();
            },
            bindEvent: function(){
            },
            eventFunc: {
            	submitSrch:function(){
            		if(fnObj.data.recipeCode.length !== 10){
            			fnObj.data.recipeCode = fnObj.data.recipeCode + "00";
            		}
                   	var params = [];
                   	partCode 		= fnObj.data.partCode;
                   	itemCode		= fnObj.data.itemCode;
                   	recipeCode		= fnObj.data.recipeCode;
                   	printName		= fnObj.data.printName;

               		params.push("partCode="+partCode);
               		params.push("itemCode="+itemCode);
               		params.push("recipeCode="+recipeCode);
               		params.push("printName="+printName);

               		console.log(params)

               		Common.report.embedded("/reports/changwon/fune/FUNE4024", "pdf", params.join("&"), "if-pdf");

            	}
            }
        };
        $(document.body).ready(function () {
            fnObj.pageStart();
        });

        </script>
    </ax:div>
</ax:layout>