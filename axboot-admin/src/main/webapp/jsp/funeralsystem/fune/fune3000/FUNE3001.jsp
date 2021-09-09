<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE3001.jsp
 - 설      명	: 매입목록관리 화면
 - 작 성 자		: HJ
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2021.01.26  1.0        HJ      신규작성
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
             .button_group.vertical button{
            	width:130px;
            	height: 50px;
            	margin: 5px;
            	margin-bottom: 15px;
            	font-size: 18px;
            }
            .button_group.vertical.fixed{
            	right: 30px;
            	width: 150px;
            	text-align: center;
            }
            .fixed{
            	position: fixed;
            }
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<div class="ax-search" id="page-search-box"></div>



				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width: 400px;"><!-- 좌측 영역 축소 inline style 삽입 KYM -->

                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i> 거래처목록</h2>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-grid" id="page-grid1-box" style="min-height: 300px;max-width: 400px;"></div><!-- 좌측 그리드 넓이 조정 inline style 삽입 KYM -->

                        </ax:custom>

                        <ax:custom customid="td">

                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i> 목록</h2>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-grid" id="page-grid2-box" style="min-height: 300px;"></div>

                        </ax:custom>

                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
	                        	<b:button  text="매입목록등록" id="btn-new-buy-list"></b:button>
	                        	<b:button  text="매입목록수정" id="btn-modify-buy-list"></b:button>
	                        	<b:button  text="매입목록출력" id="btn-buy-list-detail"></b:button>

	                        	<div class="spacer" style="width: 100px; height: 20px;"></div>

<%-- 	                        	<b:button  text="재고자료정리" id="btn-stock-data-arrange"></b:button> --%>
	                        	<%-- <b:button  text="입력마감처리" id="btn-end-new"></b:button> --%>
                        	</div>
						</ax:custom>


                    </ax:custom>
                </ax:custom>


            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var resize_elements = [
                {id:"page-grid1-box", adjust:-65},
                {id:"page-grid2-box", adjust:-65}
            ];
            var pb_data={
            		//좌측 그리드 선택 값
                	selectedCustomerPartCode		: "",
                	selectedCustomerCustCode	: "",
                	selectedCustomerregDate		: "",
                	selectedCustomerCustName 	: "",
                	//우측 그리드 선택 값
                	selectedBuyListPartCode		: "",
                	selectedBuyListCustCode		: "",
                	selectedBuyListregDate			: "",
                	selectedBuyListlistNo			: "",
                	grid1_selected 					: 0,
                	grid2_selected 					: 0

            }
            var fnObj = {
                pageStart: function(){
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
                    $("#btn-new-buy-list").bind("click", fnObj.eventFunc.addBuyList);
                    $("#btn-modify-buy-list").bind("click", fnObj.eventFunc.modBuyList);
                    $("#btn-new-list").bind("click", fnObj.eventFunc.addStock);
                    $("#btn-buy-list-detail").bind("click", fnObj.eventFunc.detailBuyList);
                    $("#btn-stock-data-arrange").bind("click", fnObj.eventFunc.stockDataArrange);

                },
                eventFunc: {
                	//매입 목록 등록
                	addBuyList: function(){
						if(pb_data.selectedCustomerPartCode  === "" && pb_data.selectedCustomerCustCode === ""){
							return;
						}
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune3000/FUNE3002.jsp",
                            pars:"callBack=&m=searchBuyListBd&execute=new"
								+ "&partCode="+pb_data.selectedCustomerPartCode+"&custCode=" + pb_data.selectedCustomerCustCode
								+ "&regDate="+ pb_data.selectedCustomerregDate, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	//매입 전표 수정
                	modBuyList: function(){
                		console.log("grid2~~~~", pb_data.selectedBuyListPartCode);
						if(pb_data.selectedBuyListPartCode  === "" && pb_data.selectedBuyListCustCode === ""){
							return;
						}
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune3000/FUNE3002.jsp",
                            pars:"callBack=&m=searchBuyListBd&execute=mod"
								+"&partCode="+pb_data.selectedBuyListPartCode+"&custCode=" + pb_data.selectedBuyListCustCode
								+"&regDate="+pb_data.selectedBuyListregDate+"&listNo=" + pb_data.selectedBuyListlistNo, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	}
                	//실사 재고 등록
                	,addStock: function(){
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune3000/FUNE3014.jsp"+ "?partCode="+Common.search.getValue(fnObj.search.target, "partCode")+"&regDate="+ Common.search.getValue(fnObj.search.target, "regDate"),
                            pars:"callBack=&"
								, // callBack 말고
                            width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	//매입거래명세서
                	detailBuyList: function(){
                		if(pb_data.selectedCustomerPartCode  === "" && pb_data.selectedCustomerCustCode === ""){
							return;
						}
                		app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune3000/FUNE3012.jsp",
                            pars:"callBack="
								+ "&partCode="+pb_data.selectedCustomerPartCode+"&custCode=" + pb_data.selectedCustomerCustCode
								+ "&regDate="+ pb_data.selectedCustomerregDate
								+ "&buyregDate="+ pb_data.selectedBuyListregDate
								+ "&listNo="+ pb_data.selectedBuyListlistNo
								, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	stockDataArrange: function(){
                		app.ajax({
                            type: "GET",
                            url: "/FUNE3001/stock/arrange",
                            data: "workDate="+Common.search.getValue(fnObj.search.target, "regDate")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                            	toast.push("재고자료가 정리되었습니다.")
                            }
                        });
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
									{label:"파트", labelWidth:"", type:"selectBox", width:"100", key:"partCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
										   type: "select", config: {
                                                reserveKeys: {
                                                      options: "list",
                                                      optionValue: "partCode",
                                                      optionText: "partName"
                                                   },
                                              ajaxUrl: "/FUNE3001/part",
                                              ajaxPars: null,
                                              //setValue: "",
                                              alwaysOnChange: true,
                                              onChange: function() {
                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
                                            	  _this.submit();
                                              }
                                            }
										}
									},
									{label:"등록일자", labelWidth:"", type:"inputText", width:"100", key:"regDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
	        										_this.submit();
	        									}
	        								}
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
                                {key:"partCode"	, label:"코드"			, width:"60"		, display :false},
                                {key:"custCode"	, label:"코드"			, width:"60"		, display :false},
                                {key:"custName"	, label:"거래처명"	, width:"200"	, align:"left"},
                                {key:"listNo"		, label:"등록건수"	, width:"160"		, align:"right"},
                                {key:"regDate"		, label:"코드"			, width:"60"		, display :false},
                            ],
                            body : {
                                onclick: function(i){
                                	// 목록 선택 로우 인덱스 저장
                                	pb_data.grid1_selected = this.index;
                                	//목록 선택 값 저장
                                	pb_data.selectedCustomerPartCode = this.item.partCode;
                                	pb_data.selectedCustomerregDate    = encodeURI($("#"+fnObj.search.target.getItemId("regDate")).val());
                                	//거래처코드
                                	pb_data.selectedCustomerCustCode = this.item.custCode;
                                	pb_data.selectedCustomerCustName = this.item.custName;
                                    fnObj.grid2.setParent(this.item);

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
                            url: "/FUNE3001/customer/list",
                            async: false,
                            data: "dummy="+ axf.timekey() +"&" + (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                            	var obj = {};
                            	var detlist = [];
                            	// Object[]로 받아 오면서 값만 존재. key 직접 삽입
                            	for(var i=0;i<res.length;i++){
                            		var resDet = res[i];
                            		obj = {}
                            		obj.partCode 	= resDet[0];
                            		obj.custCode 	= resDet[1];
                            		obj.custName 	= resDet[2];
                            		obj.listNo 		= resDet[3];
                            		obj.regDate 		= resDet[4];
                            		detlist.push(obj);
                            	}
                                var gridData = {
                                    list: detlist
                                };
                                _target.setData(gridData);
                                //좌측 그리드 로딩시 선택 값 초기화 우측 그리드 초기화
                                pb_data.selectedCustomerPartCode		= "";
                                pb_data.selectedCustomerCustCode	= "";
                                pb_data.selectedCustomerregDate		= "";
                                pb_data.selectedCustomerCustName	= "";
                                pb_data.selectedBuyListPartCode		= "";
                                pb_data.selectedBuyListCustCode		= "";
                                pb_data.selectedBuyListregDate			= "";
                                pb_data.selectedBuyListlistNo			= "";
                                fnObj.grid2.clear();
                            }
                        });
                    }
                },

             // 우측 전표 그리드
                grid2: {
                	parent: {},
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid2-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
                                {key:"partCode"	, label:"코드"			, width:"60"		, display :false},
                                {key:"custCode"	, label:"코드"			, width:"60"		, display :false},
                                {key:"regDate"		, label:"등록일자"	, width:"100"	, align:"center"},
                                {key:"listNo"		, label:"번호"	, width:"80"		, align:"right"},
                                {key:"count"		, label:"품목수량"	, width:"100" 	, align:"right"},
                                {key:"buyStatus"		, label:"매입여부"	, width:"100" 	, align:"right"	},
                                {key:"userNm"		, label:"수정자"		, width:"100" 	, align:"center"},
                                {key:"udttime"		, label:"수정일시"	, width:"100" 	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                            		}
                                },
                                {key:"remark"		, label:"메모"			, width:"100" 	, align:"center",
                                	formatter : function(){
                            			if(this.value){
                            				//디비함수 group_concat 으로 가져올때 빈값이 존재하면 콤마로 연결된 상태로 빈것들이 들어온다. 다시 배열화해서 빈값 제거 후 보여줌
                            				var str = this.value
                            				var temp = new Array();
                            				temp = str.split(",");
                            				var newArray = $.map( temp, function(v){
                            					  return v === "" ? null : v;
                            					});
	                                		return newArray.join(",");
                                		}else{
                                			return "";
                                		}
                            		}
                                }
                            ],
                            body : {
                                onclick: function(){
                                	pb_data.grid2_selected = this.index;
                                	pb_data.selectedBuyListPartCode 	= this.item.partCode;
                                	pb_data.selectedBuyListCustCode 	= this.item.custCode;
                                	pb_data.selectedBuyListregDate	 	= this.item.regDate;
                                	pb_data.selectedBuyListlistNo 		= this.item.listNo;
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
                    setParent: function(item){
                        if(typeof item.partCode === "undefined" || item.partCode == "" || typeof item.custCode === "undefined" || item.custCode == "") {
                            this.clear();
                        }else{
                            this.parent = item;
                            var parmDet = "partCode="+item.partCode +"&custCode="+item.custCode+"&regDate="+pb_data.selectedCustomerregDate;
                            this.setPage( 1, parmDet);
                        }
                    },
                    clear: function(){
                        this.parent = {};
                        this.target.setList([]);
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/FUNE3001/customer/bill_list",
                            async: false,
                            data: "dummy="+ axf.timekey() +"&" + (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res
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