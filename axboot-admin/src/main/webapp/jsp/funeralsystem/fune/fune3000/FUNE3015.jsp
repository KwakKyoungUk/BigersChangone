<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE3015.jsp
 - 설      명	: 매입관리 > 매입 목록 조회 팝업 화면
 - 작 성 자		: HJ
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2021.02.02   1.0        HJ       신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
    <ax:div name="header">

    </ax:div>
    <ax:div name="css">
    	<style type="text/css">
            .customer_title, .list_no {
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
                        <div id="CXPage" style="padding-top: 20px;">
                            <ax:row>
                                <ax:col >
                   					<ax:custom customid="table">
	                    				<ax:custom customid="tr">
			                        		<ax:custom customid="td" style="width: 400px;">
			                                    <div class="ax-button-group">
			                                        <div class="left">
			                                            <h1><i class="axi axi-web"></i> 매입목록등록</h1>
			                                        </div>
			                                        <div class="right">
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
			                                    <div class="ax-search" id="page-search-box"></div>
												<div id="page-grid1-box" style="min-height: 300px;"></div>
	    	    	                        </ax:custom>
			                        		<ax:custom customid="td" style="width:70%">
			                                    <table style="width: 100%;">
													<colgroup>
														<col width="100">
														<col>
													</colgroup>
													<tr>
														<td>
															<div id="div-buylistbd-info" style="width: 300px;"></div>
															<div id="page-grid2-box" style="min-height: 300px;"></div>
														</td>
													</tr>
												</table>
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
    <ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.select();">선택</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">

        	var bfbuyList = [];

            var fnObj = {
            	pb_data: {
			          		buyList 		: "",
			          		buyListBd 		: "",
                    		//좌측 그리드 선택 값
                        	selectedCustomerPartCode		: "",
                        	selectedCustomerCustCode	: "",
                        	selectedCustomerregDate		: "",
                        	selectedCustomerlistNo 	: "",
                        	selectedCustomerCount 	: "",
                        	selectedCustomerCustName 	: "",
                        	//우측 그리드 선택 값
                        	selectedBuyListPartCode		: "",
                        	selectedBuyListCustCode		: "",
                        	selectedBuyListregDate			: "",
                        	selectedBuyListlistNo			: "",
                        	grid1_selected 					: 0,
                        	grid2_selected 					: 0
            	},

            	pageStart: function () {
					//받아온 param 세팅
                	fnObj.pb_data.selectedCustomerPartCode	= "${param.partCode}"
                	fnObj.pb_data.selectedCustomerCustCode	= "${param.custCode}"
                	fnObj.pb_data.selectedCustomerregDate		= "${param.etDate}"

                    this.search.bind();
                	this.grid1.bind();
                    this.grid2.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#btn-cancle").bind("click", fnObj.eventFn.cancle);
                },
                eventFn: {
                	 save: function(){
                		if(fnObj.grid2.target.list.length == 0){
                			alert("저장할 항목이 없습니다!")
                			return;
                		}
                		// 클릭 후 바로 저장 클릭 시 값 변화 없음 ※※※※※※※※※※※※※※※※※※※※문제※※※※※※※※※※※※※※※※※※※※※※※
                		 var buyList = {
								buyListBdList	: fnObj.grid2.target.list
							,	bfBuyListBd	: bfbuyList
                			,	partCode 		: fnObj.pd_data.partCode
                			,	custCode 		: fnObj.pd_data.custCode
                			,	regDate 			: fnObj.pd_data.regDate
                			,   listNo				: fnObj.pd_data.listNo
                			, 	count				: fnObj.grid2.target.list.length
                    	}

                		app.ajax({
                            type: "POST",
                            url: "/FUNE3015/buyList",
                            data: Object.toJSON(buyList)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.pd_data.listNo 		= res.map.buyList.listNo;
                        		fnObj.pd_data.buyList 	= res.map.buyList;
                        		/* console.log("sava after**********************",fnObj.pd_data.buyList) */

                        		bfbuyList = $.extend(true, [], fnObj.pd_data.buyList.buyListBd);

                        		$("#div-buyListBd-listNo").html("#"+fnObj.pd_data.listNo);

                        		// ▼▼▼▼▼▼▼▼▼▼▼부모창 그리드 변경 후 선택 좌측 로우 유지.
                        		parent.fnObj.search.submit();
                        		parent.fnObj.grid1.target.setFocus(parent.pb_data.grid1_selected);
                        		parent.fnObj.grid1.target.click(parent.pb_data.grid1_selected);
                        		var param = "${param.execute}";
                        		if(param === "mod"){
                        			// 수정화면이면 우측 그리드도 유지
                        			parent.fnObj.grid2.target.setFocus(parent.pb_data.grid2_selected);
                            		parent.fnObj.grid2.target.click(parent.pb_data.grid2_selected);
                        		}
                            }
                        });
                	}
                },
                template: {
                	keywords: [
                		  "[custName]"
                		, "[regDate]"
                		, "[listNo]"
                		, "[totalCnt]"
                		, "[totalAmount]"
                	]
					, buyListDef: "<table class='AXFormTable'>"+
					            		"<tr>"+
						        			"<th rowspan='2'><div class='tdRel customer_title'>[custName]</div>"+
						        			"</th>"+
						        			"<th><div class='tdRel'>등록일자</div>"+
						        			"</th>"+
						        			"<td colspan='2' align='center'><div id='div-buyListBd-regDate' class='tdRel'>[regDate]</div>"+
						        			"</td>"+
						        			"<td rowspan='2' align='center'><div id='div-buyListBd-listNo' class='tdRel list_no'>[listNo]</div>"+
						        			"</td>"+
						        		"</tr>"+
					            		"<tr>"+
						        			"<th><div class='tdRel'>등록건수</div>"+
						        			"</th>"+
						        			"<td colspan='2' align='center'><div id='div-buyListBd-totalCnt' class='tdRel'>[totalCnt]</div>"+
						        			"</td>"+
						        		"</tr>"+
					        		"</table>"
	        		, deleteKeywords: function(str){
	        			return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
                },
                draw: {
                	//좌측 상단 내용 채우기
                	drawBuyListBdTop: function(item){
                		var regDate = item.regDate;
                		var listNo = item.listNo;
                		var totalCnt = item.count;
                		var CustName = item.custName;
                		var html 		= fnObj.template.buyListDef;

						html 				= html.replace("[custName]", CustName);
						html 				= html.replace("[regDate]",regDate.date().print("yyyy년 mm월 dd일"));
						html = html.replace("[listNo]", "#" + listNo);


						html = html.replace("[totalCnt]", totalCnt);
						html = fnObj.template.deleteKeywords(html);
						$("#div-buylistbd-info").html(html);
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
                            	{display: true, addClass:"", style:"", list:[
                                	{label:"", labelWidth:"", type:"inputText", width:"80", key:"regDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
	        									}
	        								}
	        							}
               						},

               						{label:"", labelWidth:"", type:"button", width:"50", key:"ensType", addClass:"", valueBoxStyle:"", value:"조회",
               							onclick: function(){
               								fnObj.search.submit();
               							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid1.setPage(fnObj.grid1.pageNo, pars);
                    }
                },

             // 좌측 거래처 그리드
                grid1: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid1-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"regDate"		, label:"등록일자"			, width:"150"	, align:"center"},
                                {key:"listNo"	, label:"번호"	, width:"120"	, align:"center"},
                                {key:"count"		, label:"품목수량"	, width:"120" 	, align:"center"},
                            ],
                            body : {
                                onclick: function(i){
									var gridData = {
	                                    list: this.item.buyListBd
	                                };
	                                fnObj.grid2.target.setData(gridData);
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

                        app.ajax({
                            type: "GET",
                            url: "/FUNE3015/customer/bill_list",
                            async: false,
                            data: "dummy="+ axf.timekey() +"&partCode=${param.partCode}&custCode=${param.custCode}&" + (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },

                grid2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid2-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                {key:"seqNo", label:"순번", width:"40", align:"center"},
                                {key:"itemName", label:"품 목 명", width:"180", align:"left", formatter: function(){
                                	if(this.item.item){
	                                	return this.item.item.itemName
                                	}else{
                                		return ""
                                	}
                                }},
                                {key:"qty", label:"수량", width:"160", align:"center"},
                                {key:"remark", label:"메모", width:"160", align:"left", formatter: function(){
                                	if(this.item.item){
	                                	return this.item.item.remark
                                	}else{
                                		return ""
                                	}
                                }},
                            ],
                            body : {
                                onclick: function(){

                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },

                control: {
					select: function(){
						var result = fnObj.grid1.target.getSelectedItem();
                        if(result.error){
                        	toast.push("매입목록을 선택해주세요.");
                        	return;
                        }
                        var item = {
                        	item: fnObj.grid2.target.list
                        }
						app.modal.save("${callBack}",item.item);
					},
					cancel: function(){

						app.modal.cancel();
					}
				}
            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
            //새로고침 F5 키 detect
            $(document.body).on("keydown", this, function (event) {
                if (event.keyCode == 116 && fnObj.pd_data.listNo  !==  null && fnObj.pd_data.listNo  !==  "") {
                    var url = window.location.href;
		         	var separator = (url.indexOf('?') > -1) ? "&" : "?";
		         	var qs = "listNo=" + encodeURIComponent(fnObj.pd_data.listNo);
		         	var str_url;
		         	if((url.indexOf('listNo') > -1)){
		         		str_url = url;
		         	}else{
		         		str_url = url + separator + qs;
		         	}
		         	window.location.href = str_url;
                }
            });
        </script>
    </ax:div>
</ax:layout>