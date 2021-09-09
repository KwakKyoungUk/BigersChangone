<%@page import="com.axisj.axboot.core.context.AppContextManager"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
request.setAttribute("today", today);

String[] activeProfiles = AppContextManager.getAppContext().getEnvironment().getActiveProfiles();

if(activeProfiles.length > 0){
	String ap = activeProfiles[0];
	String area = null;

	String checkedSangbok = "";
	if(ap.contains("changwon")){
		checkedSangbok = "checked";
		area = "sangbok";
	}
	String checkedMasan = "";
	if(ap.contains("masan")){
		checkedMasan = "checked";
		area = "masan";
	}
	String checkedJinhae = "";
	if(ap.contains("jinhae")){
		checkedJinhae = "checked";
		area = "jinhae";
	}
	request.setAttribute("checkedSangbok", checkedSangbok);
	request.setAttribute("checkedMasan", checkedMasan);
	request.setAttribute("checkedJinhae", checkedJinhae);
	request.setAttribute("area", area);

}

%>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
    	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/bigers/AXJ.min.new.css"/>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <form class="ax-rwd-table" id="page-search-box" onsubmit="fnObj.search.submit(); return false">
                	<input type="hidden" name="area" value="${area }">
                	<div class="item-group" style="">
	                    <div class="item">
	                        <div class="item-lable">
	                            <span class="th" style="min-width:100px;">일자</span>
	                            <span class="td inputText" style="" title="">
	                                <input id="sch-cremDate" type="date" name="cremDate" value="${today }">
	                            </span>
	                        </div>
	                    </div>
	                    <div class="item-clear"></div>
	                    <div class="item">
	                        <div class="item-lable">
	                            <span class="th" style="min-width:100px;">시설</span>
	                            <span class="td inputText" style="" title="">
	                                <label class="AXInputLabel" >
	                                    <input type="checkbox" name="area" ${checkedSangbok} value="sangbok"> 상복공원
	                                </label>
	                                <label class="AXInputLabel">
	                                    <input type="checkbox" name="area" ${checkedMasan} value="masan"> 마산장사시설
	                                </label>
	                                <label class="AXInputLabel">
	                                    <input type="checkbox" name="area" ${checkedJinhae} value="jinhae"> 진해장사시설
	                                </label>
	                            </span>
	                        </div>
	                    </div>
	                    <div class="item-clear"></div>
	                    <div class="group-clear"></div>
	                </div>
                </form>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 화장/봉안 상태현황</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });

                    $("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	_this.search.submit();
                        }
                    });
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                        });

                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },
                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"hwaAreaName", label:"화장", width:"100", align:"center"},
                                {key:"ensArea", label:"봉안", width:"100", align:"center"},
                                {key:"bookInfo", label:"예약", width:"100", align:"center"},
                                {key:"deadName", label:"고인명", width:"100", align:"center"},
                                {key:"applName", label:"신청자", width:"100", align:"center"},
                                {key:"status", label:"접수상태", width:"100", align:"center"},
                                {key:"cremMgmtNo", label:"화장일련번호", width:"100", align:"center"},
                                {key:"burnStatusName", label:"진행상태", width:"100", align:"center"},
                                {key:"burnStrTime", label:"화장시작시간", width:"100", align:"center"},
                                {key:"burnEndTime", label:"화장종료시간", width:"100", align:"center"},
                                {key:"scatterPlaceName", label:"유해처리", width:"100", align:"center"},
                                {key:"useGubunName", label:"처리상태", width:"100", align:"center"},
                                {key:"ensMgmtNo", label:"봉안일련번호", width:"100", align:"center"},
                                {key:"sangjo", label:"주관", width:"150", align:"center"},
                                {key:"weryeong", label:"위령제", width:"70", align:"center"},
                            ],
                            body : {
                            	ondblclick: function(){
                            		if("${area}" == this.item.hwaArea){
	                            		if(this.item.ensDate && this.item.ensSeq){
		                                    window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?ensDate=" + this.item.ensDate + "&ensSeq=" + this.item.ensSeq,"ENSH1010");
	                            		}
	                            		if(this.item.scaDate && this.item.scaSeq){
		                                    window.open("/jsp/funeralsystem/scat0000/scat1000/SCAT1010.jsp?scaDate=" + this.item.scaDate + "&scaSeq=" + this.item.scaSeq,"SCAT1010");
	                            		}
                            		}else{
                            			window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?area="+this.item.hwaArea+"&cremDate=" + this.item.cremDate + "&cremSeq=" + this.item.cremSeq,"ENSH1010");
                            		}
                                },
                            },
                            page: {
                                display: true,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/ENSH1001/cremEnsData",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                  var gridData = {
                                     list: res.list,
                                     page:{
                                         pageNo: res.page.currentPage.number()+1,
                                         pageSize: res.page.pageSize,
                                         pageCount: res.page.totalPages,
                                         listCount: res.page.totalElements
                                     }
                                 };
                                 _target.setData(gridData);
                                 _target.setDataSet({});
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>