<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="com.axisj.axboot.core.domain.code.BasicCode"%>
<%@page import="java.util.List"%>
<%@page import="com.axisj.axboot.core.domain.code.BasicCodeService"%>
<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
BasicCodeService service = AppContextManager.getBean("basicCodeService", BasicCodeService.class);
List<BasicCode> payGb = service.findByBasicCd("TMC15");

ObjectMapper objectMapper = new ObjectMapper();

String payBgJson = objectMapper.writeValueAsString(payGb);

request.setAttribute("payGb", payBgJson);
%>
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
                <form class="ax-search" id="page-search-box">
                	<table cellpadding="0" cellspacing="0" class="AXGridTable">
	                    <colgroup>
	                        <col width="50px" />
	                        <col width="100px" />
	                        <col width="50px" />
	                        <col width="40%" />
	                    </colgroup>
	                    <tr>
	                        <td align="right"><div class="tdRel gray">구분</div></td>
	                        <td><div class="tdRel">
	                        	<select id="payGb" name="payGb" class="AXSelect W50"></select>
	                        </div></td>
	                        <td align="right"><div class="tdRel gray">조회기간</div></td>
	                        <td><div class="tdRel">
	                        	<input id="from" name="from" class="AXInput W100">
	                        	<input id="to" name="to" class="AXInput W100">
	                        </div></td>
	                    </tr>
                    </table>
                </form>
				<iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                	payGb: ${payGb}
                },
                pageStart: function(){
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#payGb").bindSelect({
                    	options: fnObj.CODES.payGb,
                    	reserveKeys: {
                            options: "",
                            optionValue: "code",
                            optionText: "name"
                        }
                    })
                    $("#to").bindTwinDate({
	                    startTargetID: "from",
	                    handleLeft: 25,
	                    align: "right",
	                    valign: "bottom",
	                    separator: "-",
	                    buttonText: "선택",
	                    onChange: function () {
	                        //toast.push(Object.toJSON(this));
	                    },
	                });
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = $('#page-search-box').serialize()
                    	Common.report.embedded("/reports/changwon/suip/SUIP1160", "pdf", params, "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = $('#page-search-box').serialize()
                    	Common.report.embedded("/reports/changwon/suip/SUIP1160", "excel", params, "if-pdf");
                    });
                },

            };
        </script>
    </ax:div>
</ax:layout>