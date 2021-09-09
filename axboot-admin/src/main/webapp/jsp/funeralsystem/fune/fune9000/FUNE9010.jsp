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
                        _this.grid.setPage();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                		Common.report.gridToExcel("FUNE9010", fnObj.grid.target);
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
                            height: "auto",
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

                         app.ajax({
                             type: "GET",
                             url: "/FUNE9010/sangjo",
                             data: (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {

                            	 var getColGroup = function(){
                            		 var title = {"1": "미사용", "0": "사용"};
                            		 var colGroup = [];
                            		 if(res.list[0]){
	                           			 for(var key in res.list[0]){
	                            			colGroup.push({
	                            				key: key
	                            				, label: key.split("=")[1] ? title[key.split("=")[1]] : key=="0name" ? "상조회명" : key
	                            			 	, width: key=="0name" ? "100" : "60"
	                            			 	, align: key=="0name" ? "left" : "center"
	                            			 	, sort: false
	                            			 });
	                           			 }
                            		 }
                           			 return colGroup;
                            	 }

                            	 var getColHead = function(){

                            		var row1 = [{key:"0name", label:"상조회명", rowspan:2}];
                            		var row2 = [];

                            		if(res.list[0]){
                            			var beforeKey = "0name";
	                           			for(var key in res.list[0]){
	                           				var head = key.split("=")[0]
	                           				if(head == "9total"){
	                           					head = "합계";
	                           				}
	                           				if(head == beforeKey){
	                           					continue;
	                           				}
	                           				row1.push({colspan:2, label: head, align:"center", valign:"middle"});
	                           				beforeKey = head;
	                           			}
	                           			for(var key in res.list[0]){
	                           				if(key == "0name"){
	                           					continue;
	                           				}
	                           				row2.push({key: key, align:"center", valign:"middle"});
	                           			}
                            		}

                            		return {rows:[
                            			row1, row2
                            		]}
                            	 }

                            	 _target.setConfig({
                            		 colHead: getColHead(),
                            		 colGroup : getColGroup()
                            	 })

                                 var gridData = {
                                     list: res.list,
                                 };
                                 _target.setData(gridData);
                             }
                         });
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>