<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4010.jsp
 - 설      명	: 생산 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.06  1.0        KYM      신규작성
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
                        <ax:custom customid="td">

                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i> 전표목록</h2>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>

                        </ax:custom>

                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
	                        	<b:button  text="생산전표등록" id="btn-new-production"></b:button>
	                        	<b:button  text="생산전표수정" id="btn-modify-production"></b:button>
	                        	<b:button  text="생산전표내역" id="btn-production-list"></b:button>
	                        	<b:button  text="빈소전표정리" id="btn-binso-stmt-liquidation"></b:button>
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
                {id:"page-grid-box", adjust:-85}
            ];
            var pb_data={
                	//그리드 선택 값
                	selectedProductionStmtPartCode		: "",
                	selectedProductionStmtEtDate		: "",
                	selectedProductionStmtBillNo			: "",
                	grid_selected 								: 0
            }
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
                    $("#btn-new-production").bind("click", fnObj.eventFunc.addProduction);
                    $("#btn-modify-production").bind("click", fnObj.eventFunc.modProduction);
                    $("#btn-production-list").bind("click", fnObj.eventFunc.listProduction);
                    $("#btn-binso-stmt-liquidation").bind("click", fnObj.eventFunc.arrange);
                },
                eventFunc: {
                	//생산 전표 등록
                	addProduction: function(){
						var part_code 	= encodeURI($("#"+fnObj.search.target.getItemId("partCode")).val());
						var et_date	 	= encodeURI($("#"+fnObj.search.target.getItemId("etDate")).val());
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune4000/FUNE4011.jsp",
                            pars:"callBack=&m=searchProductionStmtBd&execute=new"
								+ "&partCode="+part_code+"&etDate=" + et_date, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	//생산 전표 수정
                	modProduction: function(){
                		if(pb_data.selectedProductionStmtPartCode  === "" && pb_data.selectedProductionStmtEtDate === ""){
							alert("선택한 항목이 없습니다.");
							return;
						}
                		if(pb_data.selectedProductionStmtBillNo  === 0){
							alert("수정할 수 없는 항목 입니다.");
							return;
						}
                		app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune4000/FUNE4011.jsp",
                            pars:"callBack=&m=searchProductionStmtBd&execute=mod"
								+ "&partCode="+pb_data.selectedProductionStmtPartCode+"&etDate=" + pb_data.selectedProductionStmtEtDate
								+"&billNo=" + pb_data.selectedProductionStmtBillNo, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	//생산전표내역
                	listProduction : function(){
                		if(pb_data.selectedProductionStmtPartCode  === "" && pb_data.selectedProductionStmtEtDate === ""){
							alert("선택한 항목이 없습니다.");
							return;
						}
                		var str_url = "/jsp/funeralsystem/fune/fune4000/FUNE4030.jsp?partCode="+pb_data.selectedProductionStmtPartCode
                				+ "&etDate=" + pb_data.selectedProductionStmtEtDate
								+"&billNo=" + pb_data.selectedProductionStmtBillNo
								+"&grid_selected=" + pb_data.grid_selected
								;
                		window.location.href = str_url;
                	},
                	arrange: function(){
                		app.ajax({
                            type: "POST",
                            url: "/FUNE4010/arrange?"+fnObj.search.target.getParam(),
                            async: false,
                            data: ""
                        }, function(res){
                        	if(res.error){

                        	}else{
                        		toast.push("전표정리가 완료되었습니다.");
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
                                              ajaxUrl: "/FUNE4010/part",
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
									{label:"생산일자", labelWidth:"", type:"inputText", width:"100", key:"etDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                            colGroup : [
                                {key:"partCode"	, label:"코드"				, display :false},
                                {key:"etDate"		, label:"매입일자"		, display :false},
                                {key:"billNo"		, label:"전표번호"		, width:"100"	, align:"center"},
                                {key:"count"		, label:"생산건수"		, width:"120" 	, align:"right"},
                                {key:"kind"			, label:"구분"				, width:"150" 	, align:"center"},
                                {key:"remark"		, label:"생산품목/비고"	, width:"160" 	, align:"center"},
                                {key:"userNm"		, label:"수정자"			, width:"150" 	, align:"center"},
                                {key:"udttime"		, label:"수정일시"		, width:"150" 	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                            		}
                                }
                            ],
                            body : {
                                onclick: function(){
                                	pb_data.grid_selected = this.index;
                                	pb_data.selectedProductionStmtPartCode 	= this.item.partCode;
                                	pb_data.selectedProductionStmtEtDate	 	= this.item.etDate;
                                	pb_data.selectedProductionStmtBillNo	 		= this.item.billNo;
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
                    clear: function(){
                        this.target.setList([]);
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/FUNE4010/productionStmt",
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
                            		obj.partCode 		= resDet[0];
                            		obj.etDate		 	= resDet[1];
                            		obj.billNo 			= resDet[2];
                            		obj.count_origin	= resDet[3];
                            		obj.kind		 		= "생산" // resDet[4]; 고정값
                            		obj.remark	 		= resDet[5];
                            		obj.userNm 			= resDet[6];
                            		obj.udttime 		= resDet[7];
                            		obj.count 			= resDet[8];
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


            };
        </script>
    </ax:div>
</ax:layout>