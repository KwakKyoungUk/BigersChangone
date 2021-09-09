<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

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
                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-clear"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 매출내역(식권발매기 DB) <span style="font-size: 70%;">* 저장시 통합시스템-개별판매(식당)의 해당일자 식권(발매기) 전표가 삭제되고, 조회된 데이터로 저장됩니다.</span></h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<div id="page-grid-box"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
        		CODES: {
        			partCode: Common.getCode("508"),
        			jungsanKind : Common.getCode("300"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    this.grid.bind();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	fnObj.search.submit();
                    });
                    $("#ax-page-btn-save").bind("click", function(){
                    	fnObj.save();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("FUNE1130", fnObj.grid.target);
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
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                	{label:"조회일자", labelWidth:"", type:"inputText", width:"120", key:"workDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							AXBind:{
               								type:"date", config:{
               									align:"right", valign:"top",
               									onChange:function(){

               									}
               								}
               							}
               						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },
				save: function(){
					 if(!confirm("조회된 데이터를 저장하시겠습니까?")){
						 return;
					 }

					app.ajax({
                        type: "POST",
                        url: "/FUNE1130/kiosk",
                        data: JSON.stringify(fnObj.grid.target.list)
                   	}, function(res){
                        if(res.error){
                           alert(res.error.message);
                        }
                        else
                        {
                        	toast.push("저장하였습니다.")
                        }
                    });
				},
                getData : function(){
                	app.ajax({
                        type: "GET",
                        url: "/FUNE1130/kiosk/data",
                        data: "dummy="+ axf.timekey() +"&" + (fnObj.search.target.getParam())
                    }, function(res){
                        if(res.error){
                           alert(res.error.message);
                        }
                        else
                        {
                        	fnObj.search.submit();
                        }
                    });
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
                                    {key:"billNo"	, label:"전표번호"			, width:"60"		, display :true},
                                    {key:"jungsanKind"	, label:"정산구분"	, width:"60" , align:"center"	, display :true
                                    	, formatter:function(){
                                            return Common.grid.codeFormatter("jungsanKind",this.value).replace("정산","");
                                    	}
                                    },
                                    {key:"qty"		, label:"수량"			, width:"60"		, display :true, align:"center", formatter: "money"},
                                    {key:"price"		, label:"단가"			, width:"60"		, display :true, align:"right", formatter: "money"},
                                    {key:"amount"	, label:"합계금액"	, width:"100"	, align:"right", formatter: "money"},
                                    {key:"vatAmt"	, label:"부가세"	, width:"100"	, align:"right", formatter: "money"},
                                    {key:"appNo"		, label:"승인번호"	, width:"120"		, align:"center"},
                                    {key:"jungsanKind"		, label:"현금승인구분"	, width:"120" 	, align:"center"
                                    	, formatter:function(){
                                            return this.value == "B1" ? "현금(소득공제)" : "";
                                    	}
                                    },
                                    {key:"cardName"		, label:"카드명"			, width:"120"		, display :true},
                                    {key:"halbu"		, label:"할부"			, width:"60"		, display :true, align:"center", formatter: function(){
                                    	return this.item.jungsanKind[0] == 'D' ? this.item.saleStmtBdCard.halbu || '' : ''
                                    }},
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                             url: "/FUNE1130/kiosk",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {

                            	 for(var i=0; i<res.list.length; i++){

                      				if(res.list[i].saleStmtBd){
                                   		var qty = 0
                                   		var price = 0
                                   		res.list[i].saleStmtBd.forEach(function(bd){
                                   			qty += bd.qty
                                   			price = bd.price
                                   		})
                                   		res.list[i].qty = qty
                                   		res.list[i].price = price
                                   	}else{
                                   		res.list[i].qty = '0'
                                   		res.list[i].price = '0'
                                   	}
                            	 }

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
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>