<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<% %>
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
				<div id="div-tab"></div>
			   	<div id="div-content">
			   		<div id="div-tab-content-A">
				   		<div class="ax-button-group">
							<div class="left">
							</div>
							<div class="right">
								<button type="button" class="AXButton" id="btn-searchAllocrA"><i class="axi axi-plus-circle"></i> 조회</button>
								<button type="button" class="AXButton" id="btn-calcSuip"><i class="axi axi-plus-circle"></i> 삭제</button>
								<button type="button" class="AXButton" id="btn-reportSUIP1091"><i class="axi axi-plus-circle"></i> 인쇄</button>
								<button type="button" class="AXButton" id="btn-reportSUIP1095"><i class="axi axi-plus-circle"></i> 엑셀</button>
							</div>
							<div class="ax-clear"></div>
						</div>
						<div id="div-searchA"></div>
						<div id="div-gridA"></div>
					</div>
			   	</div>
			   	<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; height: 0px; overflow: hidden;">
					<div id="div-tab-content-B">
						<div class="ax-button-group">
							<div class="left">
							</div>
							<div class="right">
								<button type="button" class="AXButton" id="btn-searchAllocrB"><i class="axi axi-plus-circle"></i> 조회</button>
								<button type="button" class="AXButton" id="btn-addFiles"><i class="axi axi-plus-circle"></i> 불러오기</button>
								<button type="button" class="AXButton" id="btn-compare"><i class="axi axi-plus-circle"></i> 대조</button>
								<button type="button" class="AXButton" id="btn-reciept"><i class="axi axi-plus-circle"></i> 수납정리</button>
								<button type="button" class="AXButton" id="btn-reportSUIP1094"><i class="axi axi-plus-circle"></i> 내역</button>
							</div>
							<div class="ax-clear"></div>
						</div>
						<div id="div-searchB"></div>
						<div class="ax-button-group">
							<div class="left">
								<h2><i class="axi axi-list-alt"></i> 은행 송신 자료</h2>
							</div>
							<div class="right">
							</div>
							<div class="ax-clear"></div>
						</div>
						<div id="div-gridB" style="height: 200px;"></div>
						<div class="ax-button-group">
							<div class="left">
								<h2><i class="axi axi-list-alt"></i> OCR 발행 내역</h2>
							</div>
							<div class="right">
							</div>
							<div class="ax-clear"></div>
						</div>
						<div id="div-gridBS" style="height: 200px;"></div>
					</div>
					<div id="div-tab-content-C">
						<div class="ax-button-group">
							<div class="left">
							</div>
							<div class="right">
								<button type="button" class="AXButton" id="btn-searchSuip"><i class="axi axi-plus-circle"></i> 조회</button>
								<button type="button" class="AXButton" id="btn-reportSUIP1092"><i class="axi axi-plus-circle"></i> 출력</button>
							</div>
							<div class="ax-clear"></div>
						</div>
						<div id="div-searchC"></div>
						<div id="div-gridC"></div>
					</div>
					<div id="div-tab-content-D">
						<div class="ax-button-group">
							<div class="left">
							</div>
							<div class="right">
								<button type="button" class="AXButton" id="btn-searchNotResultOcr"><i class="axi axi-plus-circle"></i> 조회</button>
								<button type="button" class="AXButton" id="btn-exportExcelD"><i class="axi axi-plus-circle"></i> 엑셀</button>
							</div>
							<div class="ax-clear"></div>
						</div>
<!-- 						<div id="div-searchD"></div> -->
						<div id="div-gridD"></div>
					</div>
			   	</div>

			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="scripts">
		<script type="text/javascript">
        var resize_elements = [
         {id:"div-gridA", adjust:function(){
             	return -axf.clientHeight()/6;
         	}
         }
         , {id:"div-gridB", adjust:function(){
	                return -axf.clientHeight()/1.9;
             }
         }
         , {id:"div-gridBS", adjust:function(){
	                return -axf.clientHeight()/1.9;
             }
         }
         , {id:"div-gridC", adjust:function(){
	                return -axf.clientHeight()/6;
             }
         }
         , {id:"div-gridD", adjust:function(){
	                return -axf.clientHeight()/6;
             }
         }
     ];
			var fnObj = {
				CODES: {
					gubunCd: Common.getCodeByUrl("/SUIP1060/code/gubunCd")
				},
				pageStart: function(){
					this.tab.bind();
					for(var key in this.search){
						this.search[key].bind();
					}
					for(var key in this.grid){
						this.grid[key].bind();
					}
					this.bindEvent();
					this.defaultFn.excute();
				},
				bindEvent: function(){
					var _this = this;
				},
				defaultFn: {
					excute: function(){
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
							$("#ax-page-btn-save").attr("id", "btn-save");
							$.each($("button[id^=btn-]"), function(i, o){
								var fn = fnObj.eventFn[o.id.substring("btn-".length)];
								if(!fn){
									console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
								}else{
									$(o).bind("click", fn);
								}
							});
						}
					}
				},
				eventFn: {
					searchAllocrA: function(){
						fnObj.search.A.submit();
					}
					, searchAllocrB: function(){
						fnObj.search.B.submit();
					}
					, reportSUIP1091 : function(){
// 					  Common.report.gridToExcel("SUIP1091", fnObj.grid.A.target);
						// 고지서 출력부
						app.ajax({
                            type: "GET",
                            url: "/SUIP1070/ocrband",
                            data: "allocrId="+fnObj.grid.A.target.getSelectedItem().item.id
                        },
                        function(res2){
                        	if(res2.error){
                        		alert(res2.message);
                        	}else{
								var ocrband = res2.map.ocrband;

								Common.report.printMergePdfReport([{path: "/reports/changwon/suip/SUIP1062", parameter: "allocrId="+fnObj.grid.A.target.getSelectedItem().item.id+"&ocrband="+ocrband}]);

                        	}
                        });
					}
					, reportSUIP1092 : function(){

						var item = fnObj.grid.C.target.getList();
						if(item.lengtrh == 0){
							return;
						}
						var gubunCd = [];
						var ocrPart = [];
						var parameters = [];
						var inDate =[];

						var cremAmt = 0;
						var enshAmt = 0;
						var funeralAmt = 0;
						var natuAmt = 0;

						//연화장 사용료관리비
						for (var i = 1; i < item.length; i++) {
							inDate.push(item[i].date);
							cremAmt += item[i].suipsumDay.cremTot;
							natuAmt += item[i].suipsumDay.natTot;
							enshAmt += item[i].suipsumDay.enshTot + item[i].suipsumDay.enshextTot;
							funeralAmt += item[i].suipsumDay.funeTot + item[i].suipsumDay.funevTot ;
							if( cremAmt > 0 || natuAmt > 0 ||  enshAmt>0  || funeralAmt >0 ){
								ocrPart.push("00");
							}
							//if(item[i].suipsumDay.ensmTot > 0 ){
							//	ocrPart.push("03");
							//}
							if(item[i].suipsumDay.vdTot > 0){
								gubunCd.push("04");
							}
							if(item[i].suipsumDay.mngTot > 0){
								gubunCd.push("05");
							}
							if(item[i].suipsumDay.mrptTot > 0){
								gubunCd.push("06");
							}
							if(item[i].suipsumDay.duesTot > 0){
								gubunCd.push("07");
							}
							if(item[i].suipsumDay.japTot > 0){
								gubunCd.push("08");
							}
							if(item[i].suipsumDay.fgTot > 0){
								gubunCd.push("09");
							}
						}
						var suipSumDay = [];
						$.each(ocrPart, function(key, value){
							if($.inArray(value, suipSumDay) === -1) suipSumDay.push(value);
						});

						$.each(suipSumDay, function(i,o){
							console.log(o);
              				//parameters.push({path: "/reports/changwon/suip/SUIP1092", parameter: fnObj.search.C.target.getParam()+"&ocrPart="+o+"&printName="+'${LOGIN_USER_ID}'})
              				parameters.push({path: "/reports/changwon/suip/SUIP1092_1", parameter: fnObj.search.C.target.getParam()+"&ocrPart="+o+"&printName="+'${LOGIN_USER_ID}'})
           				});

						var suetc = [];
						$.each(gubunCd, function(key, value){
							if($.inArray(value, suetc) === -1) suetc.push(value);
						});

              			$.each(suetc, function(i,o){
              				parameters.push({path: "/reports/changwon/suip/SUIP1092_2", parameter: fnObj.search.C.target.getParam()+"&gubunCd="+o+"&printName="+'${LOGIN_USER_ID}'});
           				});

              			//수입일계표
              			parameters.push({path: "/reports/changwon/suip/SUIP1093", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});


              			$.each(suipSumDay, function(i,o){
              				if(o == "00"){
              					parameters.push({path: "/reports/changwon/suip/SUIP1096", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
              				
              					parameters.push({path: "/reports/changwon/suip/SUIP1097", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
              				}
              			});
              			if(funeralAmt > 0){
              				parameters.push({path: "/reports/changwon/suip/SUIP1098", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
              				parameters.push({path: "/reports/changwon/suip/SUIP1099", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});
              			}

              			var indate_card = [];
              			for (var i = 1; i < item.length; i++) {
              				if(item[i].suipsumDay.sdate != Common.search.getValue(fnObj.search.C.target, "aprdate")){
              					indate_card.push(item[i].suipsumDay.sdate);
                  			//	parameters.push({path:"/reports/changwon/suip/SUIP1032", parameter: "inDate="+item[i].suipsumDay.sdate+"&partCode=70-001&printName=${printName}"});
    						}
              			}
						console.log("indate_card = "+ indate_card);
						console.log("indate_card = "+ Object.toJSON(indate_card));

						app.ajax({
							type: "POST",
							url: "/SUIP1090/getPayment",
 							data: Object.toJSON(indate_card)
						}, function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								var param= res.map.list[0].split("&");
								
								
								parameters.push({path:"/reports/changwon/suip/SUIP1033", parameter: "inDate="+param[0]+"&printName=${LOGIN_USER_ID}"});
								
								

								/* for (var i = 0; i < res.map.list.length; i++) {
									var param= res.map.list[i].split("&");
									parameters.push({path:"/reports/changwon/suip/SUIP1033", parameter: "inDate="+param[0]+"&printName=${LOGIN_USER_ID}"}); 
									 /* if(param[1] =='70-001' ){
										 parameters.push({path:"/reports/changwon/suip/SUIP1032", parameter: "inDate="+param[0]+"&partCode=70-001&printName=${LOGIN_USER_ID}"});
									 }
									 if(param[1] =='80-001' || param[1] =='81-001' ){
										 parameters.push({path:"/reports/changwon/suip/SUIP1032", parameter: "inDate="+param[0]+"&partCode=80-001&printName=${LOGIN_USER_ID}"});
									 }
									 if(param[1] =='90-001' ){
										 parameters.push({path:"/reports/changwon/suip/SUIP1032", parameter: "inDate="+param[0]+"&partCode=90-001&printName=${LOGIN_USER_ID}"});
									 } 
									  

								} */
								

								$.each(suetc, function(i,o){
									//기타수입내역
									parameters.push({path: "/reports/changwon/suip/SUIP1105", parameter: fnObj.search.C.target.getParam()+"&ocrPart="+o+"&printName="+'${LOGIN_USER_ID}'});

		           				});

								parameters.push({path: "/reports/changwon/suip/SUIP1094", parameter: fnObj.search.C.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});


		              			Common.report.mergePdfReport(parameters);
							}
						});




					}
					, reportSUIP1094 : function(){
	               		Common.report.open("/reports/changwon/suip/SUIP1094", "pdf", fnObj.search.B.target.getParam());
					}
					, reportSUIP1095 : function(){
						Common.report.go("/reports/changwon/suip/SUIP1095", "excel", fnObj.search.A.target.getParam());
					}



					, addFiles: function(){
						app.modal.open({
							url:"/jsp/funeralsystem/common/fileUpload.jsp",
							pars:"callBack=fnObj.eventFn.ocrlistModalResult",
							width:600, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
							//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
						});
					}
					, ocrlistModalResult: function(files){
						var list = [];
						for(var i=0; i<files.length; i++){
							var item = {};
							item.docName = files[i].name;
							item.docPath = files[i].uploadedPath+"/"+files[i].saveName;
							item.thumbPath = files[i].thumbPath;
							list.push(item);
						}
						fnObj.eventFn.ocrlFileUpload(list);
						app.modal.close();
					}
					, ocrlFileUpload : function(list){
						app.ajax({
							type: "POST",
							url: "/SUIP1090/fileupload",
							data: Object.toJSON(list)
						}, function(res){
							if(res.error){
								alert(res.error.message);
							}else{

							}
						});
					}
					, compare: function(){
						var targetM = fnObj.grid.B.target;
						var targetD = fnObj.grid.BS.target;

						$.each(targetM.list, function(i, o){

							$.each(targetD.list, function(i2, o2){
								if(
										o.adepcode == o2.adepcode
										&& o.ayear == o2.ayear
										&& o.ahgubun == o2.ahgubun
										&& o.asemok == o2.asemok
										&& o.aseq == o2.aseq
										){
									o.___checked = {"0":true};
									fnObj.grid.BS.target.updateList(i, o);
								}

							});
						});
					}
					, reciept: function(){
						var checkedList = fnObj.grid.BS.target.getCheckedListWithIndex(0);
						checkedList = $.map(checkedList, function(o){
							return o.item;
						});
						app.ajax({
							type: "POST",
							url: "/SUIP1090/allocr/receipt",
							data: Object.toJSON(checkedList)
						}, function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								toast.push("수납정리가 완료되었습니다.");
								$("#btn-searchAllocrB").click();
							}
						});
					}
					, searchSuip: function(){
						app.ajax({
							type: "GET",
							url: "/SUIP1090/suip",
							data: fnObj.search.C.target.getParam()
						}, function(res){
							if(res.error){
								alert(res.error.message);
							}else{

								var total = {date:"[총 계]", suipsumDay:{}};

								$.each(res, function(i, o){
									for(var key in o.suipsumDay){
										var val = +o.suipsumDay[key];
										if(!isNaN(val)){
											if(!total.suipsumDay[key]){
												total.suipsumDay[key] = 0;
											}
											total.suipsumDay[key] += o.suipsumDay[key];
										}
									}
								});

								fnObj.grid.C.target.setData({list: [total].concat(res)});
							}
						});
					}
					, searchNotResultOcr: function(){
						app.ajax({
							type: "GET",
							url: "/SUIP1090/allocr/not",
// 							data: fnObj.search.D.target.getParam()
							data: ""
						}, function(res){
							if(res.error){
								alert(res.error.message);
							}else{
								fnObj.grid.D.target.setData({list: res.list});
							}
						});
					}
					, exportExcelD: function(){
						Common.report.gridToExcel("미송신발행자료", fnObj.grid.D.target);
					}
				},
				tab: {
					target: $("#div-tab")
					, bind: function(){
						this.target.bindTab({
							theme : "AXTabs",
							value:"A",
							overflow:"scroll", /* "visible" */
							options:[
								{optionValue:"A", optionText:"발행내역", closable:false},
			  					{optionValue:"B", optionText:"수납처리", closable:false},
			  					{optionValue:"C", optionText:"수입결의"},
			  					{optionValue:"D", optionText:"미송신발행자료"}
			  					],
							onchange: function(selectedObject, value){
								$("#div-contents").append($("[id^='div-tab-content-']"));
								$("#div-content").append($("#div-tab-content-"+value));
							},
							onclose: function(selectedObject, value){
								toast.push("onclose: "+Object.toJSON(value));
							}
						});
					}
				},
				search: {
					A: {
						target: new AXSearch(),
						bind: function(){
							var _this = this;
							this.target.setConfig({
								targetID:"div-searchA",
								theme : "AXSearch",
								onsubmit: function(){
									fnObj.search.A.submit();
								},
								rows:[
									{display:true, addClass:"", style:"", list:[
										{label:"발행일자", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
											onclick: function(){
													var date = Common.search.getValue(fnObj.search.A.target, "abdate").date();
													date.setDate(date.getDate()-1);
													Common.search.setValue(fnObj.search.A.target, "abdate", date.print());
													fnObj.search.A.submit();
												}
											},
									   		{label:"", labelWidth:"", type:"inputText", width:"150", key:"abdate", addClass:"", valueBoxStyle:"", value:new Date().print(),
											   	AXBind:{
					   								type:"date", config:{
					   									align:"right", valign:"top", defaultDate:new Date(),
					   									onChange:function(){
					   										fnObj.search.A.submit();
					   									}
					   								}
					   							}
										  	},
		   									{label:"", labelWidth:"", type:"button", width:"30", key:"rightDate", addClass:"", valueBoxStyle:"", value:">",
		   										onclick: function(){
		   											var date = Common.search.getValue(fnObj.search.A.target, "abdate").date();
		   											date.setDate(date.getDate()+1);
													Common.search.setValue(fnObj.search.A.target, "abdate", date.print());
													fnObj.search.A.submit();
		   										}
	   										},
									]}
								]
							});
						},
						submit: function(){
//						 	pageNumber=1&pageSize=9999999
							fnObj.grid.A.setPage();
						}
					}
					, B: {
						target: new AXSearch(),
						bind: function(){
							var _this = this;
							this.target.setConfig({
								targetID:"div-searchB",
								theme : "AXSearch",
								onsubmit: function(){
									fnObj.search.B.submit();
								},
								rows:[
									{display:true, addClass:"", style:"", list:[
									   		{label:"처리일자", labelWidth:"", type:"inputText", width:"150", key:"aprdate", addClass:"", valueBoxStyle:"", value:new Date().print(),
											   	AXBind:{
					   								type:"date", config:{
					   									align:"right", valign:"top", defaultDate:new Date(),
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
							fnObj.grid.B.setPage();
							fnObj.grid.BS.setPage();
						}
					}
					, C: {
						target: new AXSearch(),
						bind: function(){
							var _this = this;
							this.target.setConfig({
								targetID:"div-searchC",
								theme : "AXSearch",
								onsubmit: function(){
									fnObj.search.C.submit();
								},
								rows:[
									{display:true, addClass:"", style:"", list:[
									   		{label:"세외수납처리일자", labelWidth:"", type:"inputText", width:"150", key:"aprdate", addClass:"", valueBoxStyle:"", value:new Date().print(),
											   	AXBind:{
					   								type:"date", config:{
					   									align:"right", valign:"top", defaultDate:new Date(),
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
							fnObj.grid.C.setPage();
						}
					}
				}
				, grid: {
					A: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridA",
								theme : "AXGrid",
								colHeadAlign:"center",
								colHead: {
									rows: [
										[
											{colSeq: 0, rowspan: 2},
											{colSeq: 1, rowspan: 2},
											{colSeq: 2, rowspan: 2},
											{colSeq: 3, rowspan: 2},
											{colSeq: 4, rowspan: 2},
											{colSeq: 5, rowspan: 2},
											{colSeq: 6, rowspan: 2},
											{colSeq: 7, rowspan: 2},
											{colSeq: 8, rowspan: 2},
											{colSeq: 9, rowspan: 2},
											{colSeq: null, colspan: 3, label: "고지금액", align: "center"},
											{colSeq: null, colspan: 3, label: "부과금액", align: "center"},
											{colSeq: 16, rowspan: 2},
											{colSeq: 17, rowspan: 2},
											{colSeq: 18, rowspan: 2},
											{colSeq: 19, rowspan: 2},
											{colSeq: 20, rowspan: 2},
											{colSeq: 21, rowspan: 2},
										],
										[
											{colSeq: 10},
											{colSeq: 11},
											{colSeq: 12},
											{colSeq: 13},
											{colSeq: 14},
											{colSeq: 15},
										]
									]
								},
								colGroup : [
									{key:"adepcode", label:"부서코드", width:"100", align:"center"},
									{key:"ayear", label:"년도", width:"60", align:"center"},
									{key:"ahgubun", label:"회계", width:"50", align:"center"},
									{key:"asemok", label:"세목", width:"90", align:"center"},
									{key:"aseq", label:"고지NO", width:"90", align:"center"},
									{key:"atong", label:"통", width:"50", align:"center"},
									{key:"agongcode", label:"공사코드", width:"60", align:"center"},
									{key:"aname", label:"납부자", width:"120", align:"center"},
									{key:"amname", label:"물건명", width:"120", align:"center"},
									{key:"abdate", label:"부과일자", width:"100", align:"center"},
									{key:"asamount", label:"최초본세", width:"100", align:"center", formatter: "money"},
									{key:"aeadd", label:"가산금", width:"100", align:"center", formatter: "money"},
									{key:"aeamount", label:"최종본세", width:"100", align:"center", formatter: "money"},
									{key:"aamt", label:"공급가액", width:"100", align:"center", formatter: "money"},
									{key:"avat", label:"부가가치세", width:"100", align:"center", formatter: "money"},
									{key:"atot", label:"합계", width:"100", align:"center", formatter: "money"},
									{key:"asndate", label:"최초납기", width:"100", align:"center"},
									{key:"aendate", label:"최종납기", width:"100", align:"center"},
									{key:"aident", label:"주민등록번호", width:"100", align:"center"},
									{key:"apost", label:"우편번호", width:"100", align:"center"},
									{key:"anphone", label:"전화번호", width:"100", align:"center"},
									{key:"anhphone", label:"휴대전화번호", width:"100", align:"center"},
								],
								body : {
									onclick: function(){
									}
								},
								page: {
									display: false,
									paging: false
								}
							});
						},
						setPage: function(pageNo, searchParams){
							app.ajax({
								type: "GET",
								url: "/SUIP1090/allocr",
								data: fnObj.search.A.target.getParam()
							},
							function(res){
								if(res.error){
									alert(res.error.message);
								}else{
									fnObj.grid.A.target.setData({list: res.list});
								}
							});
						}
					}
					, B: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridB",
								theme : "AXGrid",
								colHeadAlign:"center",
								colHead: {
									rows: [
										[
											{colSeq: 0, rowspan: 2},
											{colSeq: null, colspan: 5, label: "납세번호", align: "center"},
											{colSeq: null, colspan: 3, label: "수납액", align: "center"},
											{colSeq: 9, rowspan: 2},
											{colSeq: 10, rowspan: 2},
										],
										[
											{colSeq: 1},
											{colSeq: 2},
											{colSeq: 3},
											{colSeq: 4},
											{colSeq: 5},
											{colSeq: 6},
											{colSeq: 7},
											{colSeq: 8}
										]
									]
								},
								colGroup : [
									{key:"adepcode", label:"부서코드", width:"120", align:"center"},
									{key:"ayear", label:"년도", width:"60", align:"center"},
									{key:"ahgubun", label:"회계", width:"50", align:"center"},
									{key:"asemok", label:"세목", width:"80", align:"center"},
									{key:"aseq", label:"고지NO", width:"80", align:"center"},
									{key:"aamt", label:"공급가액", width:"100", align:"center", formatter: "money"},
									{key:"avat", label:"부가가치세", width:"100", align:"center", formatter: "money"},
									{key:"atot", label:"합계", width:"100", align:"center", formatter: "money"},
									{key:"result", label:"처리", width:"50", align:"center", formatter: function(){
										if(this.value && this.value == '1'){
											return "○";
										}else{
											return "×";
										}
									}},
									{key:"apdate", label:"수납연월일", width:"100", align:"center"},
								],
								body : {
									onclick: function(){
									}
								},
								page: {
									display: false,
									paging: false
								}
							});
						},
						setPage: function(pageNo, searchParams){
							app.ajax({
								type: "GET",
								url: "/SUIP1090/ocrlist",
								data: fnObj.search.B.target.getParam()
							},
							function(res){
								if(res.error){
									alert(res.error.message);
								}else{
									fnObj.grid.B.target.setData({list: res.ocrlistList});
									var bslist = $.map(res.ocrlistList, function(o){
										return o.allocr;
									});
									fnObj.grid.BS.target.setData({list: bslist});
								}
							});
						}
					}
					, BS: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridBS",
								theme : "AXGrid",
								colHeadAlign:"center",
								colGroup : [
									{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox", disabled: function(){
										return (this.item.suChk == "1");
									}},
									{key:"adepcode", label:"부서코드", width:"100", align:"center"},
									{key:"ayear", label:"년도", width:"60", align:"center"},
									{key:"ahgubun", label:"회계", width:"50", align:"center"},
									{key:"asemok", label:"세목", width:"90", align:"center"},
									{key:"aseq", label:"고지NO", width:"90", align:"center"},
									{key:"amname", label:"적요", width:"150", align:"center"},
									{key:"aamt", label:"공급가액", width:"150", align:"center", formatter: "money"},
									{key:"avat", label:"부가가치세", width:"150", align:"center", formatter: "money"},
									{key:"atot", label:"합계", width:"150", align:"center", formatter: "money"},
									{key:"suChk", label:"처리", width:"150", align:"center", formatter: function(){
										if(this.value && this.value == '1'){
											return "○";
										}else{
											return "×";
										}
									}},
									{key:"aname", label:"납부자", width:"150", align:"center"},
								],
								body : {
									onclick: function(){
									}
								},
								page: {
									display: false,
									paging: false
								}
							});
						},
						setPage: function(){
						}
					}
					, C: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridC",
								theme : "AXGrid",
								colHeadAlign:"center",
								colGroup : [
									{key:"date", label:"수입일자", width:"100", align:"center", formatter: function(){
										return Common.grid.getDivRowValues([this.value, "현금", "카드"]);
									}},
									{key:"xxx", label:"계", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.sumTot || 0;
											card = this.item.suipsumDay.sumcdTot || 0;
											cash = this.item.suipsumDay.sumcashTot || 0;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"화장사용료", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.cremTot;
											card = this.item.suipsumDay.cremcd;
											cash = this.item.suipsumDay.cremcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"봉안사용료(신규)", width:"150", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.enshTot;
											card = this.item.suipsumDay.enshcd;
											cash = this.item.suipsumDay.enshcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"봉안사용료(재연장)", width:"150", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.enshextTot;
											card = this.item.suipsumDay.enshextcd;
											cash = this.item.suipsumDay.enshextcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"자연장사용료", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.natTot;
											card = this.item.suipsumDay.natcd;
											cash = this.item.suipsumDay.natcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"장례식장", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot =  this.item.suipsumDay.funeTot+this.item.suipsumDay.funevTot;
											card = this.item.suipsumDay.funecd+this.item.suipsumDay.funevcd;
											cash = this.item.suipsumDay.funecash+this.item.suipsumDay.funevcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"자동판매기임대료", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.vdTot;
								   			cash+=this.item.suipsumDay.vdcash;
								   			card+=this.item.suipsumDay.vdcd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"관리비", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.mngTot;
								   			cash+=this.item.suipsumDay.mngcash;
								   			card+=this.item.suipsumDay.mngcd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"이통중계기설치임대료", width:"150", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.mrptTot;
								   			cash+=this.item.suipsumDay.mrptcash;
								   			card+=this.item.suipsumDay.mrptcd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"공과금", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.duesTot;
								   			cash+=this.item.suipsumDay.duescash;
								   			card+=this.item.suipsumDay.duescd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"잡수입", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.japTot;
								   			cash+=this.item.suipsumDay.japcash;
								   			card+=this.item.suipsumDay.japcd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"장례식장화원임대료", width:"150", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
								   			tot+=this.item.suipsumDay.fgTot;
								   			cash+=this.item.suipsumDay.fgcash;
								   			card+=this.item.suipsumDay.fgcd;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
									{key:"xxx", label:"봉안관리비", width:"100", align:"right", formatter: function(){

										var tot = 0;
										var card = 0;
										var cash = 0;

										if(this.item.suipsumDay){
											tot = this.item.suipsumDay.ensmTot;
											card = this.item.suipsumDay.ensmcd;
											cash = this.item.suipsumDay.ensmcash;
										}

										return Common.grid.getDivRowValues([tot, cash, card], function(val){
											return val ? val.money() : 0;
										})
									}},
								],
								body : {
									onclick: function(){
									}
								},
								page: {
									display: false,
									paging: false
								}
							});
						},
						setPage: function(pageNo, searchParams){
						}
					}
					, D: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridD",
								theme : "AXGrid",
								colHeadAlign:"center",
								colGroup : [
									{key:"abdate", label:"발행일자", width:"100", align:"center"},
									{key:"adepcode", label:"부서코드", width:"100", align:"center"},
									{key:"ayear", label:"년도", width:"60", align:"center"},
									{key:"ahgubun", label:"회계", width:"50", align:"center"},
									{key:"asemok", label:"세목", width:"90", align:"center"},
									{key:"aseq", label:"고지NO", width:"90", align:"center"},
									{key:"aname", label:"납부자", width:"150", align:"center"},
									{key:"amname", label:"물건명", width:"150", align:"center"},
									{key:"aamt", label:"공급가액", width:"150", align:"center", formatter: "money"},
									{key:"avat", label:"부가가치세", width:"150", align:"center", formatter: "money"},
									{key:"atot", label:"합계", width:"150", align:"center", formatter: "money"},
									{key:"suChk", label:"처리", width:"150", align:"center", formatter: function(){
										if(this.value && this.value == '1'){
											return "○";
										}else{
											return "×";
										}
									}},
									{key:"aendate", label:"납기일자", width:"150", align:"center"},
									{key:"anphone", label:"전화번호", width:"150", align:"center"},
									{key:"anhphone", label:"휴대전화번호", width:"150", align:"center"},
								],
								body : {
									onclick: function(){
									}
								},
								page: {
									display: false,
									paging: false
								}
							});
						},
						setPage: function(){
						}
					}
				}
			};
		</script>
	</ax:div>
</ax:layout>