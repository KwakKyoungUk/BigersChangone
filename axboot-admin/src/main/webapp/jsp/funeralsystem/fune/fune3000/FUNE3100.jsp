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
                    var checked = '';
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var partCode = null;
                    	var partName = null;
                    	var groupCode = null;
                    	var groupName = null;
                    	var check = null;
                    	//var DATE = null;

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		partCode = Common.search.getValue(fnObj.search.target, "partCode");
                   		partName = $("#" + fnObj.search.target.getItemId("partCode") +" option:selected").text();
                   		groupCode = Common.search.getValue(fnObj.search.target, "groupCode");
                   		groupName = $("#" + fnObj.search.target.getItemId("groupCode") +" option:selected").text();
                   		check = fnObj.checked;
                   		//DATE = Common.search.getValue(fnObj.search.target, "DATE");

                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("partCode="+partCode);
                   		params.push("partName="+partName);
                   		params.push("groupCode="+groupCode);
                   		params.push("groupName="+groupName);
                   		params.push("check="+check);
                   		//params.push("DATE="+DATE);
						//trace(check);
						
						if(fnObj.checked) {Common.report.embedded("/reports/changwon/fune/FUNE3102", "pdf", params.join("&"), "if-pdf");}
						else Common.report.embedded("/reports/changwon/fune/FUNE3101", "pdf", params.join("&"), "if-pdf");
//                       //  Common.report.open("/reports/stat/${PAGE_ID}", "pdf", params.join("&"));
                        //Common.report.embedded("/reports/changwon/fune/FUNE3101", "pdf", params.join("&"), "if-pdf");
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from = null;
                    	var to = null;
                    	var partCode = null;
                    	var partName = null;
                    	var groupCode = null;
                    	var groupName = null;
                    	var check = null;
                    	//var DATE = null;

                   		from = Common.search.getValue(fnObj.search.target, "from");
                   		to = Common.search.getValue(fnObj.search.target, "to");
                   		partCode = Common.search.getValue(fnObj.search.target, "partCode");
                   		partName = $("#" + fnObj.search.target.getItemId("partCode") +" option:selected").text();
                   		groupCode = Common.search.getValue(fnObj.search.target, "groupCode");
                   		groupName = $("#" + fnObj.search.target.getItemId("groupCode") +" option:selected").text();
                   		check = fnObj.checked;
                   		//DATE = Common.search.getValue(fnObj.search.target, "DATE");

                   		params.push("FROM="+from);
                   		params.push("TO="+to);
                   		params.push("partCode="+partCode);
                   		params.push("partName="+partName);
                   		params.push("groupCode="+groupCode);
                   		params.push("groupName="+groupName);
                   		params.push("check="+check);
                   		//params.push("DATE="+DATE);
						//trace(check);
						
						if(fnObj.checked) {Common.report.go("/reports/changwon/fune/FUNE3102", "excel", params.join("&"));}
						else Common.report.go("/reports/changwon/fune/FUNE3101", "excel", params.join("&"));
                    });
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        var _target = this.target;
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
            						{label:"", labelWidth:"", type:"button", width:"100", key:"button", addClass:"", valueBoxStyle:"", value:"품목별수불내역",
            							onclick: function(){
            				    			var url = "/jsp/funeralsystem/fune/fune3000/FUNE3110.jsp";
            					    		 window.open(url, 'FUNE3110');

            							}
            						}
                            	]},
                                {display:true, addClass:"", style:"", list:[
                                	{label:"조회일자", labelWidth:"", type:"inputText", width:"", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
       									onChange:function(){
       										//toast.push(Object.toJSON(this));
       									}
                                	},
                                	{label:"", labelWidth:"", type:"inputText", width:"", key:"to", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){
               										//toast.push(Object.toJSON(this));
               									}
               								}
               							}
               						},
                                	{label:"", labelWidth:"", type:"checkBox", width:"", key:"check", addClass:"", valueBoxStyle:"", value:"",
            							options:[{optionValue:"1", optionText:"조정수량 출고에 합산", title:"체크박스"}],
            							onChange: function(selectedObject, value){
            								fnObj.checked = value;
            							}
               						},
            						/* {label:"재고적용일자구분", labelWidth:"100", type:"selectBox", width:"", key:"DATE", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/FUNE3100/basiccode",
            									ajaxPars:null,
            									setValue:"",
            									onChange:function(){
            										//toast.push(Object.toJSON(this));

            									}
            								}
            							}
            						} */
                                ]},
                            	{display:true, addClass:"", style:"", list:[
            						{label:"파트", labelWidth:"100", type:"selectBox", width:"108", key:"partCode", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "partCode",
                                                    optionText: "partName"
                                                },
            									ajaxUrl:"/FUNE3100/part",
            									ajaxPars:null,
            									setValue:"",
            									alwaysOnChange:true,
            									onChange:function(){
  									        	  var partCodeVal = this.optionValue;
									        	  $("#" + _target.getItemId("groupCode")).bindSelect({
									        		  reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "groupCode",
	                                                      optionText: "groupName"
	                                                 }
									        		,  	method:"GET"
									        		,	ajaxUrl:"/FUNE3100/itemgroup"
													, 	ajaxPars: "partCode=" + partCodeVal
													,	ajaxAsync: true
													,	isspace: true
													, 	isspaceTitle: "."
													,	setValue: "${param.custCode}"
													,	alwaysOnChange: true
													,	onchange: function(){

														}
													});

            									}
            								}
            							}
            						},
            						{label:"품목분류", labelWidth:"100", type:"selectBox", width:"150", key:"groupCode", addClass:"", valueBoxStyle:"", value:"", options:[],
            						}
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
                }
            };
        </script>
    </ax:div>
</ax:layout>