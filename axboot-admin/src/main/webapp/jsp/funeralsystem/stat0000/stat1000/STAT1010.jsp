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
                <div class="ax-search" id="page-search-box">
                </div>
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
                    var checked = '';
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var printName = '${LOGIN_USER_ID}';
                    	var check = null;

                    	from = Common.search.getValue(fnObj.search.target, "from");
//                     	to = Common.search.getValue(fnObj.search.target, "to");
                    	params.push("from="+from);
//                     	params.push("to="+to);
                    	params.push("printName="+printName);
//                     	check = fnObj.checked;

                    	Common.report.embedded("/reports/changwon/stat/STAT1013", "pdf", params.join("&"), "if-pdf");
//                     	if(fnObj.checked) {Common.report.embedded("/reports/changwon/stat/STAT1012", "pdf", params.join("&"), "if-pdf");}
//                     	else Common.report.embedded("/reports/changwon/stat/STAT1011", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var printName = '${LOGIN_USER_ID}';
                    	var check = null;

                    	from = Common.search.getValue(fnObj.search.target, "from");
//                     	to = Common.search.getValue(fnObj.search.target, "to");
                    	params.push("from="+from);
//                     	params.push("to="+to);
                    	params.push("printName="+printName);
//                     	check = fnObj.checked;

                    	Common.report.embedded("/reports/changwon/stat/STAT1013", "excel", params.join("&"), "if-pdf");
//                     	if(fnObj.checked) {Common.report.go("/reports/changwon/stat/STAT1012", "excel", params.join("&"));}
//                     	else Common.report.go("/reports/changwon/stat/STAT1011", "excel", params.join("&"));

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

                                	{label:"조회일자", labelWidth:"", type:"inputText", width:"120", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){},
	                                	AXBind:{
		       								type:"date", config:{
		       									align:"right", valign:"top", startTargetID:"from",
		       									onChange:function(){

		       									}
		       								}
		       							}
               						},
//                						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
//                							AXBind:{
//                								type:"twinDate", config:{
//                									align:"right", valign:"top", startTargetID:"from",
//                									onChange:function(){

//                									}
//                								}
//                							}
//                						},
//                						{label:"", labelWidth:"", type:"checkBox", width:"", key:"check", addClass:"", valueBoxStyle:"", value:"",
//             							options:[{optionValue:"1", optionText:"이전자료출력", title:"체크박스"}],
//             							onChange: function(selectedObject, value){
//             								fnObj.checked = value;
//             							}
//                						},
               					//	{label:"특이사항", labelWidth:"", type:"inputText", width:"300", key:"remark", addClass:"", valueBoxStyle:"", value:"",
               					//		onChange: function(){}
               					//	}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
//                     	var params = [];
//                     	var from = null;
//                     	var to = null;
//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		from = new Date(0).print("yyyymmdd");
//                     		to = new Date().print("yyyymmdd");
//                     		params.push("from="+from);
//                     		params.push("to="+to);
//                     	}else{
//                     		from = Common.search.getValue(fnObj.search.target, "from");
//                     		to = Common.search.getValue(fnObj.search.target, "to");
//                     		params.push("FROM="+from);
//                     		params.push("TO="+to);
//                     	}
//                     	var firstDayOfWeek = to.date().setDate(to.date().getDate()-to.date().getDay()).date().print();
//                     	params.push("FIRST_DAY_OF_WEEK="+firstDayOfWeek);
//                     	Common.report.open("/reports/stat/STAT1010", "html", params.join("&"));
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>