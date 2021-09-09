<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
    	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/bigers/AXJ.min.new.css"/>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 봉안접수현황조회</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	ensType: Common.getCode("TFM10"),
                	objt: Common.getCode("TFM08"),
                	condition: [
							 {optionValue:"all", optionText:"전체"}
                	          ,{optionValue:"ensDate", optionText:"봉안접수"}
                	          , {optionValue:"extDate", optionText:"봉안연장"}
                	          , {optionValue:"retDate", optionText:"봉안반환"}
                	          ]
            		,payGb: Common.getCode("TMC15")
                },
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
//                     $("#ax-page-btn-fn2").html("<i class=\"axi axi-file-excel-o\"></i> 전체 엑셀(일자형)");
//                     $("#ax-page-btn-fn2").bind("click", function(){
//                     	var params = [];
//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		params.push("from="+new Date(0).print("yyyymmdd"));
//                     		params.push("to="+new Date().print("yyyymmdd"));
//                     		params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType"));
//                     		params.push("docCode="+Common.search.getValue(fnObj.search.target, "docCode"));
//                     		params.push("roomCode="+Common.search.getValue(fnObj.search.target, "roomCode"));

//                     	}else{
//                     		params.push("from="+Common.search.getValue(fnObj.search.target, "from"));
//                     		params.push("to="+Common.search.getValue(fnObj.search.target, "to"));
//                     		params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType"));
//                     		params.push("docCode="+Common.search.getValue(fnObj.search.target, "docCode"));
//                     		params.push("roomCode="+Common.search.getValue(fnObj.search.target, "roomCode"));

//                     	}
//                   		//params.push("roomCode="+Common.search.getValue(fnObj.search.target, "roomCode")||"");
//                 		//params.push("ensNo="+Common.search.getValue(fnObj.search.target, "ensNo")||"");
//                 		//params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType") == "" ? null : Common.search.getValue(fnObj.search.target, "ensType"));
//                         Common.report.go("/reports/ensh/ENSH1024", "excel", params.join("&"));
//                     });
                    $("#ax-page-btn-excel").bind("click", function(){
//                     	var params = [];
//                     	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
//                     		params.push("from="+new Date(0).print("yyyymmdd"));
//                     		params.push("to="+new Date().print("yyyymmdd"));
//                     		params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType"));
//                     	}else{
//                     		params.push("from="+Common.search.getValue(fnObj.search.target, "from"));
//                     		params.push("to="+Common.search.getValue(fnObj.search.target, "to"));
//                     		params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType"));
//                     	}
//                     	//params.push("ensType="+Common.search.getValue(fnObj.search.target, "ensType") == "" ? null : Common.search.getValue(fnObj.search.target, "ensType"));
//                     	var docCode = Common.search.getValue(fnObj.search.target, "docCode")== "all" ? "ENSH1021" :  Common.search.getValue(fnObj.search.target, "docCode");
//                         Common.report.go("/reports/ensh/"+docCode, "excel", params.join("&"));
						Common.report.gridToExcel("ENSH1020", fnObj.grid.target);
                    });

                    $("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	_this.search.submit();
                        }
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
                                     /* {label: "봉안호실", labelWidth: "100", type: "selectBox", width: "100", key:"roomCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
                                         options:[],
                                         AXBind:{
                                             type:"select" , config:{
                                              reserveKeys: {
                                                     options: "list" ,
                                                     optionValue: "roomCode" ,
                                                     optionText: "roomName"
                                                 },
                                                 method:"GET" , ajaxUrl: "/ENSH3030/findEnsroom" , ajaxPars: "locCode=C1&floorCode=1" ,
                                                 isspace: true , isspaceTitle: "전체" ,
                                                 alwaysOnChange: true ,
                                              onchange:function (){

                                                 }
                                             }
                                         }
                                     }, */
                                     {label:"안치상태", labelWidth:"", type:"selectBox", width:"90", key:"condition", addClass:"", valueBoxStyle:"", value:"",
 										options:fnObj.CODES.condition,
        									onChange:function(){}
                					},
                                     {label:"구분", labelWidth:"", type:"selectBox", width:"90", key:"ensType", addClass:"", valueBoxStyle:"", value:"",
 										options:[{optionValue:"", optionText:"전체"}].concat(fnObj.CODES.ensType),
        									onChange:function(){}
                					},
               						{label:"봉안번호", labelWidth:"", type:"inputText", width:"150", key:"ensNo", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
                                ]}
                                , {display:true, addClass:"", style:"", list:[
               						{label:"봉안일자", labelWidth:"100", type:"checkBox", width:"", key:"checkbox", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"all", optionText:"전기간", title:"전기간"}],
										onChange: function(selectedObject, value){
											//아래 3개의 값을 사용 하실 수 있습니다.
// 											toast.push(Object.toJSON(this));
// 											toast.push(Object.toJSON(selectedObject));
// 											toast.push(value);

											//axdom("#"+fnObj.search.target.getItemId("checkbox")).attr("label")

										}
									},
               						{label:"", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){

               									}
               								}
               							}
               						},
               						{label:"사망자", labelWidth:"", type:"inputText", width:"90", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
       									onChange:function(){}
               						},
               						{label:"신청자", labelWidth:"", type:"inputText", width:"90", key:"applName", addClass:"", valueBoxStyle:"", value:"",
       									onChange:function(){}
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
                                 {key:"A1", label:"봉안관리번호", width:"100", align:"left", formatter: function(){
                               	   return this.item.ensDate.date().print("yyyymmdd")+"-"+Common.str.lpad(this.item.ensSeq+"","0",2);
                                  }},
                                {key:"realDate", label:"안치일자", width:"100", align:"center"
                                	/* , formatter: function(){
                                		return Common.grid.getDivRow(this.item.ensdeadVTOList, "ensdeadVTOList.realDateString", function(value){
                                			if(value){
	                                			return value.date().print();
                                			}else{

                                				return "&nbsp;";
                                			}
                                		});
                                	} */
                                },
                                {key:"ensNo", label:"봉안번호", width:"200", align:"center"},
                                {key:"ensType", label:"구분", width:"100", align:"center", formatter: function(){
                             	   return Common.grid.codeFormatter("ensType", this.value);
                                }},
                                {key:"deadName", label:"사망자명", width:"100", align:"center"
                                	//, formatter: function(){
                            		//	return Common.grid.getDivRow(this.item.ensdeadVTOList, "thedeadVTO.deadName");
                            		//}
                                },
                                {key:"deadJumin", label:"주민번호", width:"150", align:"center"
                                	//, formatter: function(){
                            		//	return Common.grid.getDivRow(this.item.ensdeadVTOList, "thedeadVTO.deadName");
                            		//}
                                },

                                {key:"deadDate", label:"사망일", width:"100", align:"center"
                                	/* , formatter: function(){
                                		return Common.grid.getDivRow(this.item.ensdeadVTOList, "thedeadVTO.deadDateString", function(value){
                                			if(value){
	                                			return value.date().print();
                                			}else{

                                				return "&nbsp;";
                                			}
                                		});
                                	} */
                                },
                                {key:"objt", label:"대상구분", width:"100", align:"center"
                                	, formatter:function(){
                                			return Common.grid.codeFormatter("objt",this.value);
                                	}
                            	},

                                {key:"applName", label:"신청자명", width:"100", align:"center", formatter:function(){
                             	   return this.item.applName;
                                }},
                                {key:"applPost", label:"신청자 우편번호", width:"120", align:"center", formatter:function(){
                              	   return this.item.applPost;
                                 }},
                                {key:"applAddr1", label:"신청자주소1", width:"100", align:"center", formatter:function(){
                              	   return this.item.applAddr1;
                                }},
                                {key:"applAddr2", label:"신청자주소2", width:"100", align:"center", formatter:function(){
                                   return this.item.applAddr2;
                                }},
                                {key:"phone", label:"신청자 전화번호", width:"120", align:"center", formatter:function(){
                             	   return this.item.mobileno ?  this.item.mobileno : this.item.telno;
                                	}
                                },
                                 {key:"return", label:"연장구분", width:"100", align:"center"
                                	, formatter:function(){
	                             	   if(this.item.extDate){
	                            		   return "연장"
	                            	   }else{
	                            		   return "&nbsp;";
	                            	   }
                              	 	}
                                },
                                {key:"extDate", label:"연장일자", width:"100", align:"center"
                                	, formatter:function(){
                                		if( this.item.extDate ){
                                   			return this.item.extDate.date().print("yyyy-mm-dd");
                                    	}else{
                                    		 return "&nbsp;";
                                    	}
                                	}
                            	 },
                                 {key:"return", label:"반환구분", width:"100", align:"center"
                                	, formatter:function(){
	                             	   if(this.item.useGubun=="R"){
	                            		   return "반환"
	                            	   }else{
	                            		   return "&nbsp;";
	                            	   }
                              	 	}
                                },
                                {key:"retDate", label:"반환일자", width:"100", align:"center"
                                	, formatter:function(){
                                		if(this.item.useGubun=="R"){
                                			return this.item.retDate ? this.item.retDate.date().print("yyyy-mm-dd") : "";
                                		}else{
                                    		 return "&nbsp;";
                                    	}
                                	}
                            	 }, {key:"payGb", label:"결제구분", width:"100", align:"center"
                                 	, formatter:function(){
                            			return Common.grid.codeFormatter("payGb",this.value);
                            		}
                                },
                                {key:"", label:"화장", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode.endsWith('70-001')){
                                      					amt = (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"", label:"봉안", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode.endsWith('80-001')){
                                      					amt = (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"", label:"봉안관리비", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode == '70-001=81-002' || this.item.paymentCalc[k].partCode == '80-001=81-002'){
                                      					amt = (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"", label:"합계", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode.startsWith('70-001')){
                                      					amt += (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                      				if(this.item.paymentCalc[k].partCode.startsWith('80-001')){
                                      					amt += (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"extPayGb", label:"결제구분", width:"100", align:"center"
                                	, formatter:function(){
                            			return Common.grid.codeFormatter("payGb",this.value);
                            		}
                                },
                                {key:"", label:"봉안(연장) 사용료", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode == '81-001=81-001'){
                                      					amt = (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"", label:"봉안(연장) 관리비", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode == '81-001=81-002'){
                                      					amt = (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                                {key:"", label:"합계", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		if(this.item.paymentCalc.length >0){
                                   			for(var k=0; k<this.item.paymentCalc.length; k++){
                                      				if(this.item.paymentCalc[k].partCode.startsWith('81-001')){
                                      					amt += (this.item.paymentCalc[k].cardAmt+this.item.paymentCalc[k].cashAmt);
                                      				}
                                       		}
                                		}
                                		return amt.money();
                                	}
                                },
                            ],
                            body : {
                            	ondblclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                    //location.href = "/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?ensDate=" + this.item.ensDateString + "&ensSeq=" + this.item.ensSeq;
                                    window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?ensDate=" + this.item.ensDate + "&ensSeq=" + this.item.ensSeq,"_blank");
                                },
                            },
                            foot: {
                                rows: [
                                    [
                                        {
                                            colSeq: null, colspan : 17, formatter: function () {
                                            return "계";
                                       		}, align: "center", valign: "middle"
                                        },
                                        {
                                            colSeq: 18, formatter: function () {

                                            return this.list.length+"건";
                                        	}
                                        },
                                        {
                                            colSeq: 19, formatter: function () {
                                            	  var sum = 0;
                                                  $.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
	                                               			for(var k=0; k<this.paymentCalc.length; k++){
	                                               				if(this.paymentCalc[k].partCode.endsWith('70-001')){
	                                               					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                               				}
	                                                   		}
	                                              		}
                                                  });
                                                  return sum.money();
                                        	}, align:"right"
                                        },
                                        {
                                            colSeq: 20, formatter: function () {
                                            	  var sum = 0;
                                                  $.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
	                                               			for(var k=0; k<this.paymentCalc.length; k++){
	                                                  				if(this.paymentCalc[k].partCode.endsWith('80-001')){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
	                                                   		}
	                                              		}
                                                  });
                                                  return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                            colSeq: 21, formatter: function () {
                                            	  var sum = 0;
                                                  $.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
	                                               			for(var k=0; k<this.paymentCalc.length; k++){
	                                                  				if(this.paymentCalc[k].partCode == '80-001=81-002' || this.paymentCalc[k].partCode == '70-001=81-002'){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
	                                                   		}
	                                              		}
                                                  });
                                                  return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                            colSeq: 22, formatter: function () {
                                            	var sum = 0;
                                            	$.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
                                                 			for(var k=0; k<this.paymentCalc.length; k++){
                                                    				if(this.paymentCalc[k].partCode.endsWith('70-001')){
                                                    					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
                                                    				}
                                                    				if(this.paymentCalc[k].partCode.endsWith('80-001')){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
                                                    				if(this.paymentCalc[k].partCode == '80-001=81-002' || this.paymentCalc[k].partCode == '70-001=81-002' ){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
                                                     		}
	                                              		}
                                                  });
                                            	 return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                            colSeq: 23, formatter: function () {

                                       		}
                                        },
                                        {
                                            colSeq: 24, formatter: function () {
                                            	  var sum = 0;
                                                  $.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
	                                               			for(var k=0; k<this.paymentCalc.length; k++){
	                                                  				if(this.paymentCalc[k].partCode == '81-001=81-001'){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
	                                                   		}
	                                              		}
                                                  });
                                                  return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                            colSeq: 25, formatter: function () {
                                            	  var sum = 0;
                                                  $.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
	                                               			for(var k=0; k<this.paymentCalc.length; k++){
	                                                  				if(this.paymentCalc[k].partCode == '81-001=81-002' ){
	                                                  					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
	                                                  				}
	                                                   		}
	                                              		}
                                                  });
                                                  return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                            colSeq: 26, formatter: function () {
                                            	var sum = 0;
                                            	$.each(this.list, function (i) {
	                                              		if(this.paymentCalc.length >0){
                                                 			for(var k=0; k<this.paymentCalc.length; k++){
                                                    				if(this.paymentCalc[k].partCode.startsWith('81-001') ){
                                                    					sum += (this.paymentCalc[k].cardAmt+this.paymentCalc[k].cashAmt);
                                                    				}
                                                     		}
	                                              		}
                                                  });
                                            	 return sum.money();
                                       		}, align:"right"
                                        },

                                    ],
                                ]
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
                             url: "/ENSH1020/enshrine",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())+"&sort=realDate&sort=ensDate&sort=ensSeq"
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
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
                                 _target.setDataSet({});
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>