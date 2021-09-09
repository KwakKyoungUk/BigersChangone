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
                        <h2><i class="axi axi-list-alt"></i> 연화장 수입월보</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var vat = null;
                    	var printName = '${LOGIN_USER_ID}';
                    	var check = null;
                		check = fnObj.checked;
                    	
                    	from = Common.search.getValue(fnObj.search.target, "from");
                    	to = Common.search.getValue(fnObj.search.target, "to");
                    	vat = Common.search.getValue(fnObj.search.target, "vat");
                    	params.push("from="+from);
                    	params.push("to="+to);
                    	params.push("vat="+vat);
                    	params.push("printName="+printName);
                        
                        if(fnObj.checked) {Common.report.embedded("/reports/changwon/stat/STAT1021", "pdf", params.join("&"), "if-pdf");}
                    	else Common.report.embedded("/reports/changwon/stat/STAT1022", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var vat = null;
                    	var printName = '${LOGIN_USER_ID}';
                    	var check = null;
                		check = fnObj.checked;
                    	
                    	from = Common.search.getValue(fnObj.search.target, "from");
                    	to = Common.search.getValue(fnObj.search.target, "to");
                    	vat = Common.search.getValue(fnObj.search.target, "vat");
                    	params.push("from="+from);
                    	params.push("to="+to);
                    	params.push("vat="+vat);
                    	params.push("printName="+printName);
                        
                        if(fnObj.checked) {Common.report.go("/reports/changwon/stat/STAT1021", "excel", params.join("&"));}
                    	else Common.report.go("/reports/changwon/stat/STAT1022", "excel", params.join("&"));

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
								{label:"조회기간", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print("yyyy-mm"),
										onChange: function(){}
									},
									{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print("yyyy-mm"),
										AXBind:{
											type:"twinDate", config:{
												align:"right", valign:"top", startTargetID:"from", selectType: "m",
												onChange:function(){

												}
											}
										}
									},
									{label:"구분", labelWidth:"100", type:"selectBox", width:"", key:"vat", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"Y", optionText:"부가가치세포함"}, {optionValue:"N", optionText:"부가가치세제외"}],
										AXBind:{
											type:"select", config:{
												onChange:function(){
													//toast.push(Object.toJSON(this));
												}
											}
										}
									},
									{label:"", labelWidth:"", type:"checkBox", width:"", key:"check", addClass:"", valueBoxStyle:"", value:"",
            							options:[{optionValue:"1", optionText:"염습비용 개정전 자료 출력시 체크해주세요 기준일자 : 2019-02-20", title:"체크박스"}],
            							onChange: function(selectedObject, value){
            								fnObj.checked = value;
            							}
               						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){

                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>