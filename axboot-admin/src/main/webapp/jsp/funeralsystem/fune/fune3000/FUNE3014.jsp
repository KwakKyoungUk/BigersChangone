<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE3014.jsp
 - 설      명	: 매입관리 > 실사 재고 등록 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.06  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "실사재고등록");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="modal.jsp">
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
			                        		<!-- 좌측 실사재고 요약 그리드 -->
			                        		<ax:custom customid="td" style="width:20%;">
			                                    <div class="ax-button-group">
			                                        <div class="left">
			                                            <h1><i class="axi axi-web"></i>실사재고등록</h1>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
												<div class="ax-search" id="page-search-box1"></div>
												<div id="div-grid-stock-real-summary"></div>
	    	    	                        </ax:custom>
			                        		<!-- 가운데 실사재고 그리드 -->
			                        		<ax:custom customid="td" style="width: 40%;">
			                                    <div class="ax-button-group">
			                                        <div class="right">
			                                        	<b:button text="저장" id="btn-save"></b:button>
														<b:button text="선택품목삭제" id="btn-removeSelectedItem"></b:button>
														<b:button text="초기화" id="btn-init"></b:button>
														<b:button text="출력" id="btn-print"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
												<div class="ax-search" id="page-search-box2"></div>
												<div id="div-grid-stock-real"></div>
	    	    	                        </ax:custom>
			                        		<!-- 우측 재고 그리드 -->
			                        		<ax:custom customid="td" style="width:40%">
			                        			<div class="ax-button-group">
			                                        <div class="right">
			                                        	<b:button text="선택품목추가" id="btn-addSelectedItem"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
			                                    <div class="ax-search" id="page-search-box3"></div>
												<div id="div-grid-stock"></div>
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

        	var bfStockReal = [];

            var fnObj = {
            	CODES: {
            	},
            	CONSTANTS: {
            	},
            	data: {
            		  partCode 		: null
            		, etDate			: null
            	},
                pageStart: function () {
					//받아온 param 세팅
                	this.data.partCode	= "${param.partCode}"
                	this.data.etDate		= "${param.etDate}"

                	this.gridStockRealSummary.bind();
                	this.gridStockReal.bind();
                	this.gridStock.bind();

                    this.search1.bind();
                	this.search2.bind();
                	this.search3.bind();

                    this.bindEvent();

                    this.search1.submit();

                    //작업 년월 달력 생성
                    $("[name='jobYm']").bindDate({separator: "-", selectType: "m"});
                    //앞에서 받아온 년월, 날짜 세팅
                    $("#"+fnObj.search1.target.getItemId("jobYm")).val(this.data.etDate.substring(0,7));
                    $("#"+fnObj.search2.target.getItemId("etDate")).val(this.data.etDate);
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
//                 		if(fnObj.gridStockReal.target.list.length == 0){
//                 			alert("저장할 항목이 없습니다!");
//                 			return;
//                 		}
                		//등록 할 작업 일자로 아이템 변경
                		$.each(fnObj.gridStockReal.target.list, function(i, o){
                			fnObj.gridStockReal.target.updateItem(0, 2, i, $("#"+fnObj.search2.target.getItemId("etDate")).val());
                    	});
                		if(bfStockReal.length >0){
                			$.each(bfStockReal, function(i, o){
                    			o.etDate = $("#"+fnObj.search2.target.getItemId("etDate")).val();
                        	});
                		}

                		// 클릭 후 바로 저장 클릭 시 값 변화 없음 ※※※※※※※※※※※※※※※※※※※※문제※※※※※※※※※※※※※※※※※※※※※※※
                		 var stockReal = {
                				stockRealList	: fnObj.gridStockReal.target.list
							,	bfStockReal		: bfStockReal
                    	}

                		app.ajax({
                            type: "POST",
                            url: "/FUNE3014/stockReal",
                            data: Object.toJSON(stockReal)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//console.log("save after = ",res.map.stockReal);
                        		//저장 내용 이전 자료로 복사
                        		bfStockReal = $.extend(true, [], res.map.stockReal);
                            }
                        });
                	}
                	//선택 추가
	                ,addSelectedItem:function(){
	                	var _target 					= fnObj.gridStock.target;;
                		var checkedList 				= _target.getCheckedListWithIndex(0);
                		var checkedListChange 	= [];
                		var add_target 				=	fnObj.gridStockReal.target;

                		if(checkedList.length == 0){
                			alert("선택된 목록이 없습니다.");
                			return;
                		}
                		//체크 목록 복사 후 처리
                		checkedListChange 		= $.extend(true, [], checkedList);

                		var arrNewExtendList 	= [];
                		//조회하여 불러오는 실사 재고  JSON 형태 맞추기
                		$.each(checkedListChange, function(i, o){
                			var obj = {};
                			obj.partCode 	= o.item.partCode;
                			obj.etDate		= $("#"+fnObj.search2.target.getItemId("etDate")).val();
                			obj.itemCode 	= o.item.itemCode;
                			obj.item			= {partCode:o.item.partCode, itemCode:o.item.itemCode , itemName:o.item.itemName, unit:o.item.unit};
                			obj.dataQty 	= o.item.qty;
                			obj.realQty 		= "0";
                			obj.gapQty	 	= o.item.qty;

            				arrNewExtendList.push(obj);
                    	});
                		//넘겨준 체크 해제
                		_target.checkedColSeq(0, false);
                		add_target.pushList(arrNewExtendList);
	                }
					//선택삭제
                	, removeSelectedItem: function(){
						var _target 		=	fnObj.gridStockReal.target;

                		var checkedList 	= _target.getCheckedListWithIndex(0);
                		 if(checkedList.length == 0){
                             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                             return;
                         }
                		_target.removeListIndex(checkedList);
                	}
					//초기화
                	,init:function(){
                		window.location.reload();
                	}
                	,print: function(){
                		Common.report.open("/reports/changwon/fune/FUNE3014", "pdf", "partCode=${param.partCode}&ET_DATE="+Common.search.getValue(fnObj.search2.target, "etDate"));
                	}
                },
                search1: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box1",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search1.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"작업년월", labelWidth:"", type:"inputText", width:"100", key:"jobYm", addClass:"secondItem", valueBoxStyle:"", value:new Date().print("yyyy-mm"),
											onChange: function(){
												_this.submit();
											}
										}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars1 			= this.target.getParam();
                       var split				= pars1.split('=', 2);
                       var changeDate 	= split[1]+ "-01";
                       changeDate = changeDate.date();
                       changeDate.setMonth(changeDate.getMonth()+1);
                       changeDate.setDate(changeDate.getDate()-1);
                       	//변경되면 작업일자 변경
                        $("#"+fnObj.search2.target.getItemId("etDate")).val(changeDate.print());
                        //좌측 요약 그리드 세팅
                        fnObj.gridStockRealSummary.setPage(pars1);
                        //제일 우측 그리드 세팅
                        fnObj.search3.submit();
                    }
                },
                search2: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box2",
                            theme : "AXSearch",
                            onsubmit: function(){
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"작업일자", labelWidth:"", type:"inputText", width:"100", key:"etDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
											onChange: function(){}
											, AXBind:{
											type:"date", config:{
												align:"right", valign:"top", defaultDate:new Date().print(),
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
                    }
                },
                search3: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box3",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search3.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                     {label: "품목분류", labelWidth: "100", type: "selectBox", width: "100", key:"groupCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
                                         options:[],
                                         AXBind:{
                                             type:"select" , config:{
                                            	 reserveKeys: {
                                                     options: "list",
                                                     optionValue: "groupCode",
                                                     optionText: "groupName"
                                                },
                                                method:"GET",
                                                ajaxUrl:"/FUNE3014/real/itemGroup",
            									ajaxPars:"partCode=${param.partCode}",
                                                alwaysOnChange: true,
                                                isspace: true,
                                                isspaceTitle: "전체",
                                                setValue:"ALL",
                                                onchange: function(){
                                                	fnObj.search3.submit();
                                                }
                                             }
                                         }
                                     }
                                ]},
                                {display:true, addClass:"", style:"", list:[
               						{label:"품목코드/명", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"button", width:"50", key:"ensType", addClass:"", valueBoxStyle:"", value:"조회",
               							onclick: function(){
               								fnObj.search3.submit();
               							}
               						}
               					]}
                            ]
                        });
                    },
                    submit: function(){
                    	var pars2 = this.target.getParam();
                    	fnObj.gridStock.setPage(pars2);
                    }
                },
                //좌측 요약 그리드
                gridStockRealSummary: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-stock-real-summary",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            height: 650,
                            colGroup : [
								{key:"partCode"	, label:"품목코드"	, width:"80"		, align:"center", display:false},
								{key:"etDate"		, label:"작업일자"	, width:"120"	, align:"center"},
								{key:"itemCode"	, label:"품목수"		, width:"80"		, align:"center"}
                            ],
                            body : {
                            	 onclick: function(){
                            		 var partCode = this.item.partCode;
                            		 var etDate 	= this.item.etDate;
                                 	setTimeout(function(){
                                 		var srchParam = "partCode="+partCode+"&etDate="+etDate;
                                 		//가운데 그리드 로딩
                                 		fnObj.gridStockReal.setPage(srchParam);
                                 		//선택하면 작업일자 변경
                                 		$("#"+fnObj.search2.target.getItemId("etDate")).val(etDate);
                                 		fnObj.search3.target.submit();
                                 	}, 500);
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
                            url: "/FUNE3014/stockRealSummary?partCode=${param.partCode}&"+searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var obj 				= {};
                            	var detlist 			= [];
                            	for(var i=0;i<res.length;i++){
                            		var resDet 		= res[i];
                            		obj 				= {}
                            		obj.partCode	= resDet[0];
                            		obj.etDate 		= resDet[1];
                            		obj.itemCode	= resDet[2];

                            		detlist.push(obj);
                            	}

                            	 var gridData = {
                                         list: detlist
                                     };
                                     _target.setData(gridData);
                            }
                        });
                    }
                },
                //가운데 실사재고 그리드
                gridStockReal: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-stock-real",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            height: 650,
                            colGroup : [
										{key:"index"		, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"},
										{key:"partCode"	, label:"품목코드"	, width:"80"		, align:"center", display:false},
										{key:"etDate"		, label:"품목코드"	, width:"80"		, align:"center", display:false},
										{key:"itemCode"	, label:"품목코드"	, width:"80"		, align:"left"},
										{key:"itemName"	, label:"품목명"		, width:"100"	, align:"left"
											, formatter: function(){
			                                	if(this.item.item){
				                               		return this.item.item.itemName;
			                                	}else{
			                                		return "";
			                                	}
		                                	}
										},
										{key:"unit"			, label:"단위"			, width:"50"		, align:"center"
											, formatter: function(){
			                                	if(this.item.item){
				                               		return this.item.item.unit;
			                                	}else{
			                                		return "";
			                                	}
		                                	}
										},
										{key:"dataQty"	, label:"전산재고"	, width:"100"	, align:"right"},
										{key:"realQty"		, label:"실사재고"	, width:"80"		, align:"right"		, formatter: "number", editor:{
			                                    type:"number",
			                                    "range": { // 숫자일 경우 숫자자릿수와 소수점 자릿수 지정
			                                        "val": "9,1"
			                                        ,msg : '' // 자릿수를 초과 했을대 보여줄 메시지.
			                                    },
			                                    maxLength: 50,
			                                    beforeUpdate: function(val){
//			                                    	return val < 0 || isNaN(Number(val)) ? 0 : val;
			                                    	return val;
			                                    },
			                                    afterUpdate: function(event){
			                                    	// 부동소수점 실수 계산시 오차 정정
			                                    	//참고 싸이트 http://kor-khkim.blogspot.kr/2014/06/blog-post.html
			                                    	var data_q 		= this.item.dataQty;
			                                    	var real_q  			= Number(this.item.realQty);
			                                    	var calc;
			                                    	//둘다 소수점이 없을때는 하단 부동소수점 오차 줄이는 방법은 뒤에 ".0" 이 붙는다. 이를 방지하기 위해 분기 2017-11-13 KYM
			                                    	if(Number.isInteger(data_q) && Number.isInteger(real_q)){
			                                    		calc = data_q - real_q;
			                                    	}else{
			                                    		calc = parseFloat(data_q - real_q).toFixed(4);
			                                    	}
			                                    	this.item.gapQty = calc;
			                                    	fnObj.gridStockReal.target.updateList(this.index, this.item);
			                                    }
			                                }
		                                },
										{key:"gapQty"		, label:"전산-실사"	, width:"100"	, align:"right"},
										{key:"remark"		, label:"비고"		, width:"100"	, align:"left",
											editor: {
												type: "text"
											}
										}
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
                    setPage: function(searchParams){
                    	var _target = this.target;

                    	app.ajax({
                            type: "GET",
                            url: "/FUNE3014/stockReal?"+searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//console.log("stockReal~res~",res)
                        		_target.setData({list: res.list});
                        		//이전자료로 복사
                        		bfStockReal 		= $.extend(true, [], res.list);
                            }
                        });
                    }
                },
                //우측 품목(Stock) 그리드
                gridStock: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-stock",
                            theme : "AXGrid",
                            height: 615,
                            colHeadAlign:"center",
                            colGroup : [
								{key:"index"		, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"},
								{key:"partCode"	, label:"품목코드"		, width:"80"		, align:"left", display:false},
								{key:"itemCode"	, label:"품목코드"		, width:"80"		, align:"left"},
                                {key:"itemName"	, label:"품목명"			, width:"100"		, align:"left"},
                                {key:"unit"			, label:"단위"			, width:"50"		, align:"center"},
                                {key:"preQty"		, label:"전월이월"		, width:"80"		, align:"right"},
                                {key:"inQty"		, label:"입고"			, width:"100"		, align:"right"},
                                {key:"outQty"		, label:"출고"			, width:"100"		, align:"right"},
                                {key:"qty"			, label:"전산재고"		, width:"100"		, align:"right"}
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
                    setPage: function(searchParams){
                    	var _target = this.target;
                    	//좌측 작업년월도 넘겨야 함
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE3014/stock?partCode=${param.partCode}&"+searchParams + "&etDate=" + $("#"+fnObj.search2.target.getItemId("etDate")).val(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                            	 var gridData = {
                                         list: res.stockVTOList
                                     };
                                     _target.setData(gridData);
                            }
                        });
                    }
                },

            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
        </script>
    </ax:div>
</ax:layout>