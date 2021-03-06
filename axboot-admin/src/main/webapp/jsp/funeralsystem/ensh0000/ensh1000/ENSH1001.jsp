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
	                            <span class="th" style="min-width:100px;">??????</span>
	                            <span class="td inputText" style="" title="">
	                                <input id="sch-cremDate" type="date" name="cremDate" value="${today }">
	                            </span>
	                        </div>
	                    </div>
	                    <div class="item-clear"></div>
	                    <div class="item">
	                        <div class="item-lable">
	                            <span class="th" style="min-width:100px;">??????</span>
	                            <span class="td inputText" style="" title="">
	                                <label class="AXInputLabel" >
	                                    <input type="checkbox" name="area" ${checkedSangbok} value="sangbok"> ????????????
	                                </label>
	                                <label class="AXInputLabel">
	                                    <input type="checkbox" name="area" ${checkedMasan} value="masan"> ??????????????????
	                                </label>
	                                <label class="AXInputLabel">
	                                    <input type="checkbox" name="area" ${checkedJinhae} value="jinhae"> ??????????????????
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
                        <h2><i class="axi axi-list-alt"></i> ??????/?????? ????????????</h2>
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
                    // ????????? ?????? ??? ?????? ?????? ???????????? (option)
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
                                // ????????? ???????????? ???????????? submit ????????? ?????? ?????? ?????? ?????????.
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
                                {key:"hwaAreaName", label:"??????", width:"100", align:"center"},
                                {key:"ensArea", label:"??????", width:"100", align:"center"},
                                {key:"bookInfo", label:"??????", width:"100", align:"center"},
                                {key:"deadName", label:"?????????", width:"100", align:"center"},
                                {key:"applName", label:"?????????", width:"100", align:"center"},
                                {key:"status", label:"????????????", width:"100", align:"center"},
                                {key:"cremMgmtNo", label:"??????????????????", width:"100", align:"center"},
                                {key:"burnStatusName", label:"????????????", width:"100", align:"center"},
                                {key:"burnStrTime", label:"??????????????????", width:"100", align:"center"},
                                {key:"burnEndTime", label:"??????????????????", width:"100", align:"center"},
                                {key:"scatterPlaceName", label:"????????????", width:"100", align:"center"},
                                {key:"useGubunName", label:"????????????", width:"100", align:"center"},
                                {key:"ensMgmtNo", label:"??????????????????", width:"100", align:"center"},
                                {key:"sangjo", label:"??????", width:"150", align:"center"},
                                {key:"weryeong", label:"?????????", width:"70", align:"center"},
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