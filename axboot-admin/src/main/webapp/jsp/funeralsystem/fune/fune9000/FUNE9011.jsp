<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE9010.jsp
 - 설      명	: 상조회건수현황
 - 작 성 자		: KEH
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2018.01.13  1.0        KEH      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">

        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<div class="ax-search" id="page-search-box"></div>

				<div id="div-grid"></div>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">

            var fnObj = {
                pageStart: function(){
                	this.search.bind();
                	this.grid.bind();
                    this.bindEvent();
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.eventFunc.goPdf();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	from		= $("#"+fnObj.search.target.getItemId("from")).val();
                    	to			= $("#"+fnObj.search.target.getItemId("to")).val();

                       	params.push("FROM="+from);
                    	params.push("TO="+to);
                   		console.log(params)
                		Common.report.go("/reports/changwon/fune/FUNE9011", "excel", params.join("&"));
                    });

                },
                eventFunc: {
                	goPdf : function(){
                    	var params = [];
                    	from		= $("#"+fnObj.search.target.getItemId("from")).val();
                    	to			= $("#"+fnObj.search.target.getItemId("to")).val();

                       	params.push("FROM="+from);
                    	params.push("TO="+to);

                   		console.log(params)
                   		Common.report.embedded("/reports/changwon/fune/FUNE9011", "pdf", params.join("&"), "if-pdf");
                	}
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"발인일자", labelWidth:"", type:"inputText", width:"100", key:"from", addClass:"", valueBoxStyle:"", value:new Date().print().substring(0,7),
               							onChange: function(){}
               						},
									{label:"", labelWidth:"", type:"inputText", width:"100", key:"to", addClass:"secondItem", valueBoxStyle:"", value:new Date().print().substring(0,7),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"twinDate", config:{
	        									align:"right", valign:"top", startTargetID:"from", selectType:"m",
	        									onChange:function(){
 	        										if(this.ST_value.substring(0,4) === this.ED_value.substring(0,4)){}
	        										else
	        											{
	        												toast.push("같은 년도만 조회할 수 있습니다.");
	        												_this.target.setItemValue("from", new Date().print().substring(0,7));
	        												_this.target.setItemValue("to", new Date().print().substring(0,7));
	        											}
	        											//_this.target.setItemValue("from", new Date().getFullYear()+"-"+new Date().getMonth() + 1);
	        											//trace($("#"+_this.target.getItemId("from")).val());

	        										//_this.submit();
	        									}
	        								}
	        							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        $("#"+fnObj.search.target.getItemId("from")).attr("readonly", "readonly");
                        $("#"+fnObj.search.target.getItemId("to")).attr("readonly", "readonly");
                    }
                },
                grid: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"name", label:"상조회명", width:"100", align:"center"},
                            ],
                            body : {
                                onclick: function(){
                                }
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

//                          app.ajax({
//                              type: "GET",
//                              url: "/FUNE1040/funeral",
//                              data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
//                          }, function(res){
//                              if(res.error){
//                                 alert(res.error.message);
//                              }
//                              else
//                              {
//                                  var gridData = {
//                                      list: res.list,
//                                      page:{
//                                          pageNo: res.page.currentPage.number()+1,
//                                          pageSize: res.page.pageSize,
//                                          pageCount: res.page.totalPages,
//                                          listCount: res.page.totalElements
//                                      }
//                                  };
//                                  _target.setData(gridData);
//                              }
//                          });
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>