<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4011.jsp
 - 설      명	: 생산 관리 > 생산 전표 등록 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.07  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "생산전표등록");
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
                                <ax:col ><div style="height: 30px;"></div>
                   					<ax:custom customid="table">
	                    				<ax:custom customid="tr">
			                        		<ax:custom customid="td" style="width: 770px;">
			                                    <div class="ax-button-group">
			                                        <div class="left">
			                                            <h1><i class="axi axi-web"></i> 생산전표등록</h1>
			                                        </div>
			                                        <div class="right">
														<b:button text="전체품목삭제" id="btn-removeAllItem"></b:button>
														<b:button text="선택품목삭제" id="btn-removeSelectedItem"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>

												<div id="div-productionstmtbd-info"></div>
												<div id="div-grid-productionStmtBd" style="min-height: 635px;"></div>
	    	    	                        </ax:custom>
			                        		<ax:custom customid="td" style="width:30%">
			                        			<div class="ax-button-group">
			                                        <div class="left">

			                                        </div>
			                                        <div class="right">
														<b:button text="전표저장" id="btn-save"></b:button>
														<b:button text="전표삭제" id="btn-deleteStmt"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
			                                    <div class="ax-search" id="page-search-box"></div>
			                                    <table style="width: 100%;">
													<colgroup>
														<col width="100">
														<col>
													</colgroup>
													<tr>
														<td>
															<div id="div-grid-itemGroup" style="min-height: 650px;"></div>
														</td>
														<td>
															<div id="div-grid-item" style="min-height: 650px;"></div>
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
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">

        	var bfProductionStmt = [];

            var fnObj = {
            	CODES: {
            	},
            	CONSTANTS: {
            	},
            	data: {
            		  productionStmt 		: null
            		, productionStmtBd 	: null
            		, partCode		 		: null
            		, etDate					: null
            		, billNo					: null
            		, remark					: null
            	},
            	condition: {
            		isAdd: function(){
            			return "${param.execute}" == "new";
            		}
            		, isMod: function(){
            			return "${param.execute}" == "mod";
            		}
            	},
                pageStart: function () {
					//받아온 param 세팅
                	this.data.partCode	= "${param.partCode}"
                	this.data.etDate		= "${param.etDate}"
                	this.data.billNo		= "${param.billNo}"

                    this.search.bind();
                    this.gridProductionStmtBd.bind();
                    this.gridItemGroup.bind();
                    this.gridItemGroup.setPage();
                    this.gridItem.bind();
                    this.bindEvent();
                    this.defaultFn.excute();
                    this.search.submit();

                },
                bindEvent: function () {
                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
                			$(o).bind("click", fn);
                		}
                	});
                },
                eventFn: {
                	 save: function(){
                		if(fnObj.gridProductionStmtBd.target.list.length == 0){
                			alert("저장할 항목이 없습니다!")
                			fnObj.defaultFn.searchProductionStmtBd()
                			return;
                		}
                		// 클릭 후 바로 저장 클릭 시 값 변화 없음 ※※※※※※※※※※※※※※※※※※※※문제※※※※※※※※※※※※※※※※※※※※※※※
                		 var productionStmt = {
                				productionStmtBdList	: fnObj.gridProductionStmtBd.target.list
							,	bfProductionStmtBd		: bfProductionStmt
                			,	partCode			 		: fnObj.data.partCode
                			,	etDate 						: fnObj.data.etDate
                			,   billNo							: fnObj.data.billNo
                			, 	count							: fnObj.gridProductionStmtBd.target.list.length
                			,	remark						: fnObj.data.remark
                    	}
                		 //console.log("sava before*********",JSON.stringify(productionStmt));

                		app.ajax({
                            type: "POST",
                            url: "/FUNE4011/productionStmt",
                            data: Object.toJSON(productionStmt)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.data.billNo 					= res.map.productionStmt.billNo;
                        		fnObj.data.productionStmt 	= res.map.productionStmt;
                        		//console.log("sava after**********,fnObj.data.productionStmt)

                        		bfProductionStmt 				= $.extend(true, [], fnObj.data.productionStmt.productionStmtBd);

                        		$("#div-productionStmtBd-billNo").html("#"+fnObj.data.billNo);

                        		// ▼▼▼▼▼▼▼▼▼▼▼부모창 그리드 변경 후 선택 좌측 로우 유지.
                        		parent.fnObj.search.submit();
                        		parent.fnObj.grid.target.setFocus(parent.pb_data.grid_selected);
                        		parent.fnObj.grid.target.click(parent.pb_data.grid_selected);
                            }
                        });
                	}

                	, removeAllItem: function(){
                		fnObj.gridProductionStmtBd.target.setData({list:[]});
                		fnObj.gridProductionStmtBd.calc();
                	}
                	, removeSelectedItem: function(){
                		Common.grid.removeSelectedItem(fnObj.gridProductionStmtBd.target);
                		fnObj.gridProductionStmtBd.calc();
                	}
                	, deleteStmt: function(){
                		if(fnObj.data.billNo == null){
                			return;
                		}
                		var confirmTxt = fnObj.data.etDate.date().print("yyyy년 mm월 dd일") + " #" +fnObj.data.billNo;
                		if(!confirm(confirmTxt + " 전표를 삭제 하시겠습니까?")){
							return;
						}
                		 var productionStmt = {
                 				partCode 				: fnObj.data.partCode
                 			,	etDate 					: fnObj.data.etDate
                 			,   billNo						: fnObj.data.billNo
                 			,	productionStmtBd		: bfProductionStmt
                     	}
                		 /* console.log("DELETE ",buyStmt); */

                		app.ajax({
                            type: "DELETE",
                            url: "/FUNE4011/productionStmt",
                            data: Object.toJSON(productionStmt)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								alert(fnObj.data.billNo + "번 전표가 삭제되었습니다.");
								parent.fnObj.search.submit();
								self.close();
                            }
                        });
                	}
                },
                defaultFn: {
                	// 좌측상단 메인 정보 표기
                	 searchProductionStmtBd: function(){
                		app.ajax({
                            type: "GET",
                            url: "/FUNE4011/productionStmtBd?partCode="+ fnObj.data.partCode + "&etDate="+fnObj.data.etDate+"&billNo="+fnObj.data.billNo,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		// 전표 정보
                        		fnObj.data.productionStmtBd 	= $.extend({}, res.map.productionStmtBd);
                        		//좌측 상단 그리기
                        		fnObj.draw.drawProductionStmtBdTop(res.map.productionStmtBd);
                        		//그리드 세팅
								fnObj.gridProductionStmtBd.target.setData({list:fnObj.data.productionStmtBd.productionStmtBdList});
								fnObj.gridProductionStmtBd.strConcat();
								console.log("좌측 상단 메인 정보 취득=====",fnObj.data.productionStmtBd);
								//이전 데이타 복사
								bfProductionStmt = $.extend(true, [], fnObj.data.productionStmtBd.productionStmtBdList);
                        	}
                        });
                	}
                	, excute: function(){
                		//전화면에서 m 으로 실행할 함수를 전달해줌.
                		for(var key in this.fn){
                			this.fn[key]();
                		}
                		if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFn["${param.m}"]();
                	}
                	, fn: {
                		initButtons: function(){
                			if(fnObj.condition.isAdd()){
                				console.log("ADD")
                			}else if(fnObj.condition.isAdd()){
                				console.log("MOD")
                			}
                		}
                	}
                },
                template: {
                	keywords: [
                		 "[etDate]"
                		, "[billNo]"
                		, "[totalCnt]"
                		, "[remark]"
                	]
					, productionStmtDef: "<table class='AXFormTable'>"+
					            		"<tr>"+
						        			"<th style='width: 10%;'><div class='tdRel'>일자</div>"+
						        			"</th>"+
						        			"<td colspan='3' align='center' style='width: 30%;'><div id='div-productionStmtBd-etDate' class='tdRel'>[etDate]</div>"+
						        			"</td>"+
						        			"<th rowspan='2' align='center' style='width: 10%;'><div class='tdRel'>생산품목</div>"+
						        			"</th>"+
						        			"<td rowspan='2' align='center'><div id='div-productionStmtBd-remark' class='tdRel'>[remark]</div>"+
						        			"</td>"+
						        		"</tr>"+
					            		"<tr>"+
						        			"<th><div class='tdRel'>건수</div>"+
						        			"</th>"+
						        			"<td align='center'><div id='div-productionStmtBd-totalCnt' class='tdRel'>[totalCnt]</div>"+
						        			"</td>"+
						        			"<th><div class='tdRel'>번호</div>"+
						        			"</th>"+
						        			"<td align='center'><div id='div-productionStmtBd-billNo' class='tdRel'>[billNo]</div>"+
						        			"</td>"+
						        		"</tr>"+
					        		"</table>"
	        		, deleteKeywords: function(str){
	        			return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
                },
                draw: {
                	//좌측 상단 내용 채우기
                	drawProductionStmtBdTop: function(ProductionStmtBd){
                		var html 		= fnObj.template.productionStmtDef;
						html 				= html.replace("[etDate]",ProductionStmtBd.etDate.date().print("yyyy년 mm월 dd일"));

						if(ProductionStmtBd.billNo !== undefined){
							html = html.replace("[billNo]", "#" + ProductionStmtBd.billNo);
						}

						html = html.replace("[totalCnt]", ProductionStmtBd.productionStmtBdList.length);

						html = fnObj.template.deleteKeywords(html);
						$("#div-productionstmtbd-info").html(html);
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
               						{label:"", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
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
                    	var pars = fnObj.search.target.getParam();
                    	pars = pars + "&etDate="+fnObj.data.etDate;
                    	var itemGroup = fnObj.gridItemGroup.target.getSelectedItem().item;
                    	if(itemGroup){
                    		pars = pars + "&groupCode="+itemGroup.groupCode;
                    	}

                    	var pars_arr 		= pars.split('&')
                    	var obj 				= {};
                        //파라미터 객체화
 	                   	for(var c=0; c < pars_arr.length; c++) {
 	                    	var split 		= pars_arr[c].split('=', 2);
 	                     	obj[split[0]] 	= split[1];
 	                   	}
 	                   if(obj.groupCode != undefined){
 	                	  fnObj.gridItem.setPage(pars);
 	                   }
                    }
                },

                gridProductionStmtBd: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-productionStmtBd",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                 {key:"itemName", label:"제품명", width:"100", align:"center", formatter: function(){
    	                                	if(this.item.item){
    		                               		return this.item.item.itemName;
    	                                	}else{
    	                                		return "";
    	                                	}
                                    	}
                                    },
                                {key:"recipeName", label:"생산제품명/레시피명", width:"250", align:"center", formatter: function(){
	                                	if(this.item.recipe){
		                               		return this.item.recipe.recipeName;
	                                	}else{
	                                		return "";
	                                	}
                                	}
                                },
                                {key:"qty", label:"수량", width:"100", align:"center", formatter: "number", editor:{
	                                    type:"number",
	                                    "range": { // 숫자일 경우 숫자자릿수와 소수점 자릿수 지정
	                                        "val": "9,1"
	                                        ,msg : '' // 자릿수를 초과 했을대 보여줄 메시지.
	                                    },
	                                    maxLength: 50,
	                                    beforeUpdate: function(val){
	                                    	return val < 0 || isNaN(Number(val)) ? 0 : val;
	                                    },
	                                    afterUpdate: function(){

	                                    	// 금액은 조정금액 계산 외에 일단 저장
	                                    	//this.item.amount 		= +(this.item.qty / this.item.defaultQty)*(this.item.price);
	                                    	// 매입금액은 입력 수량 / 기준수량 * 기준단가
	                                    	//this.item.tamount 	= +(this.item.qty / this.item.defaultQty)*(this.item.price)+this.item.samount;

	                                    	fnObj.gridProductionStmtBd.target.updateList(this.index, this.item);
	                                    	//생상 품목 문자열 붙이기
	                                    	fnObj.gridProductionStmtBd.strConcat();
	                                    }
	                                }
                                },
                                {key:"remark", label:"메모", width:"200", align:"center", editor:{
                                    type:"text",
                                    maxLength: 20
                              	}},
                            ],
                            body : {
                            	ondblclick: function(){
                                },
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
                    add: function(buyStmtBdVal){
                    	fnObj.gridProductionStmtBd.target.pushList(buyStmtBdVal);
                    },
                    setPage: function(pageNo, searchParams){
                    },
                    calc: function(){
                    	var cnt = this.target.list.length;
                   		$("#div-productionStmtBd-totalCnt").html(cnt);
                    },
                    strConcat: function(){
                    	var targetList = this.target.list;
                    	var concatList = [];
                    	$.each(targetList, function(idx,val) {
                    		  var str = val.item.itemName + "("+val.qty+")"
                    		  concatList.push(str);
                    	});

                    	fnObj.data.remark = concatList.join(" ");
                   		$("#div-productionStmtBd-remark").html(concatList.join(" "));
                    }
                },
                //우측 품목 그리드
                gridItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                {key:"i"					, label:" "		, width:"50"		, align:"center", formatter: function(){return this.index+1;}},
                                {key:"partCode"		, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"itemCode"		, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"recipeCode"	, label:"코드"		, width:"0"		, align:"center", display:false},
                                {key:"recipeName"	, label:"품목명"	, width:"340"	, align:"center"},
                                {key:"menuPlanQty"	, label:"수량"		, width:"0"		, align:"center", display:false},
                                {key:"itemName"		, label:"수량"		, width:"0"		, align:"center", display:false}
                            ],
                            body : {
                                onclick: function(){
                                	this.item.remark="";
                                	var productionStmtBdVal = {
                                			recipe			: this.item
                                			, item				: this.item
                                			, partCode		: this.item.partCode
                                			, etDate			: fnObj.data.etDate
                                			, billNo			: fnObj.data.billNo
                                			, itemCode		: this.item.itemCode
                                			, recipeCode	: this.item.recipeCode
                                			, recipeName	: this.item.recipeName
                                			, qty				: this.item.menuPlanQty ? this.item.menuPlanQty.number() : 0
                                			, remark			: ""
                                			, itemName 		: this.item.itemName
                                	}

                                	setTimeout(function(){
                                    	fnObj.gridProductionStmtBd.add(productionStmtBdVal);
                                    	fnObj.gridProductionStmtBd.calc();
                                    	fnObj.gridProductionStmtBd.strConcat();
                                	}, 100);
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
                    setPage: function(searchParams){
                    	var _target = this.target;
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE4011/recipe/item?partCode=${param.partCode}&"+searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var obj = {};
                            	var recipelist = [];
                            	// Object[]로 받아 오면서 값만 존재. key 직접 삽입
                            	for(var i=0;i<res.length;i++){
                            		var resDet = res[i];
                            		obj = {}
                            		obj.partCode 		= resDet[0];
                            		obj.itemCode 		= resDet[1];
                            		obj.recipeCode 	= resDet[2];
                            		obj.recipeName 	= resDet[3];
                            		obj.menuPlanQty	= resDet[4];
                            		obj.itemName		= resDet[5];
                            		recipelist.push(obj);
                            	}
                                var gridData = {
                                    list: recipelist
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },
                gridItemGroup: {
					pageNo: 1,
					target: new AXGrid(),
					bind: function(){
						var target = this.target, _this = this;
						target.setConfig({
							targetID : "div-grid-itemGroup",
							theme : "AXGrid",
							colHeadAlign:"center",
							/*
							 mediaQuery: {
							 mx:{min:"N", max:767}, dx:{min:767}
							 },
							 */
							colGroup : [
								{key:"groupName", label:"품목그룹", width:"100", align:"left"},
							],
							body : {
								onclick: function(){
									fnObj.search.submit();
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
					setPage: function(searchParams){

						app.ajax({
							type: "GET",
							url: "/FUNE4011/recipe/itemGroup",
							data: "partCode=${param.partCode}"
						},
						function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								fnObj.gridItemGroup.target.setData({list: res.list});
								fnObj.gridItemGroup.target.setFocus(0);
								fnObj.search.submit();
							}
						});
					}
				},

            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
            //새로고침 F5 키 detect
            $(document.body).on("keydown", this, function (event) {
                if (event.keyCode == 116 && fnObj.data.billNo  !==  null && fnObj.data.billNo  !==  "") {
                    var url = window.location.href;
		         	var separator = (url.indexOf('?') > -1) ? "&" : "?";
		         	var qs = "billNo=" + encodeURIComponent(fnObj.data.billNo);
		         	var str_url;
		         	if((url.indexOf('billNo') > -1)){
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