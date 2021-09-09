<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
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
		   		<div id="div-search"></div>
				<div id="div-tab"></div>
			   	<div id="div-content">
			   		<div id="div-tab-content-A">
						<div id="div-gridA" style="min-height: 500px;"></div>
					</div>
			   	</div>
			   	<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; height:0px; overflow:hidden;">
					<div id="div-tab-content-B">
						<div id="div-gridB" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-C">
						<div id="div-gridC" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-D">
						<div id="div-gridD" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-E">
						<div id="div-gridE" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-F">
						<div id="div-gridF" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-G">
						<div id="div-gridG" style="min-height: 500px;"></div>
					</div>
					<div id="div-tab-content-H">
						<div id="div-gridH" style="min-height: 500px;"></div>
					</div>
			   	</div>

			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="scripts">
		<script type="text/javascript">
			var resize_elements = [
			];
			var fnObj = {
				CODES: {
					gubunCd: Common.getCodeByUrl("/SUIP1060/code/gubunCd")
					, deadSex: Common.getCode("TCM05")
					, addrPart: Common.getCode("TCM10")
					, dcGubun: Common.getCode("TCM05")
					, cremObjt: Common.getCode("TMC03")
					, enshObjt: Common.getCode("TFM08")
					, natuObjt: Common.getCode("TFM14")
					, relation: Common.getCode("TCM08")
					, ensType: Common.getCode("TFM10")
				},
				pageStart: function(){
					this.tab.bind();
					this.search.bind();
					this.grid.A.bind();
					this.grid.B.bind();
					this.grid.C.bind();
					this.grid.D.bind();
					this.grid.E.bind();
					this.grid.F.bind();
					this.grid.G.bind();
					this.grid.H.bind();
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
                			$("#ax-page-btn-search").attr("id", "btn-search");
							$("#ax-page-btn-fn2").html("출력");
							$("#ax-page-btn-fn2").attr("id", "btn-print");
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
					search: function(){
						fnObj.search.submit();
					}
					, calcSuip: function(){
						fnObj.search.submit();
					}
					, print : function(){
						var target = "fnObj.grid."+$("#div-content").children().first().attr("id").substring($("#div-content").children().first().attr("id").length-1)+".target";

						Common.report.gridToExcel("SUIP1101", eval(target));
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
								{optionValue:"A", optionText:"화장봉안자연장사용료", closable:false},
			  					{optionValue:"B", optionText:"장례식장사용료", closable:false},
			  					{optionValue:"C", optionText:"자동판매기임대료"},
			  					{optionValue:"D", optionText:"이통중계기임대료"},
			  					{optionValue:"E", optionText:"관리비"},
			  					{optionValue:"F", optionText:"공과금"},
			  					{optionValue:"G", optionText:"잡수입"},
			  					{optionValue:"H", optionText:"봉안관리비"},
			  					],
							onchange: function(selectedObject, value){
								$("#div-contents").append($("[id^='div-tab-content-']"));
								$("#div-content").append($("#div-tab-content-"+value));
								fnObj.search.submit = fnObj.grid[value].setPage;
							},
							onclose: function(selectedObject, value){
								toast.push("onclose: "+Object.toJSON(value));
							}
						});
					}
				},
				search: {
					target: new AXSearch(),
					bind: function(){
						var _this = this;
						this.target.setConfig({
							targetID:"div-search",
							theme : "AXSearch",
							onsubmit: function(){
								fnObj.search.A.submit();
							},
							rows:[
								{display:true, addClass:"", style:"", list:[
									{label:"세외수입처리일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
								]}
							]
						});
					},
					submit: function(){
						fnObj.grid.A.setPage();
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
								height: "auto",
								colHead: {
									rows: [
										[
											{colSeq: 0, rowspan: 2},
											{colSeq: 1, rowspan: 2},
											{colSeq: 2, rowspan: 2},
											{colSeq: null, colspan: 2, label: "소계", align: "center"},
											{colSeq: null, colspan: 3, label: "화장", align: "center"},
											{colSeq: null, colspan: 3, label: "봉안", align: "center"},
											{colSeq: null, colspan: 3, label: "자연장", align: "center"},
											{colSeq: 14, rowspan: 2},
											{colSeq: 15, rowspan: 2},
											{colSeq: 16, rowspan: 2},
											{colSeq: 17, rowspan: 2},
											{colSeq: 18, rowspan: 2},
											{colSeq: 19, rowspan: 2},
											{colSeq: 20, rowspan: 2},
										],
										[
											{colSeq: 3},
											{colSeq: 4},
											{colSeq: 5},
											{colSeq: 6},
											{colSeq: 7},
											{colSeq: 8},
											{colSeq: 9},
											{colSeq: 10},
											{colSeq: 11},
											{colSeq: 12},
											{colSeq: 13},
										]
									]
								},
								colGroup : [
									{key:"inDate", label:"수입일자", width:"100", align:"center"},
									{key:"job", label:"구분", width:"70", align:"center"},
									{key:"tot", label:"계", width:"80", align:"right", formatter: "money"},
									{key:"cashTot", label:"현금", width:"80", align:"right", formatter: "money"},
									{key:"cardTot", label:"카드", width:"80", align:"right", formatter: "money"},
									{key:"cremCash", label:"현금", width:"80", align:"right", formatter: "money"},
									{key:"cremCard", label:"카드", width:"80", align:"right", formatter: "money"},
									{key:"cremObjt", label:"대상구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("cremObjt", this.value);
									}},
									{key:"enshCash", label:"현금", width:"80", align:"right", formatter: "money"},
									{key:"enshCard", label:"카드", width:"80", align:"right", formatter: "money"},
									{key:"enshObjt", label:"대상구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("enshObjt", this.value);
									}},
									{key:"natuCash", label:"현금", width:"80", align:"right", formatter: "money"},
									{key:"natuCard", label:"카드", width:"80", align:"right", formatter: "money"},
									{key:"natuObjt", label:"대상구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("natuObjt", this.value);
									}},
									{key:"applName", label:"납부자", width:"80", align:"center"},
									{key:"relation", label:"관계", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("relation", this.value);
									}},
									{key:"mobileno1", label:"연락처", width:"120", align:"center"},
									{key:"deadName", label:"고인명", width:"80", align:"center"},
									{key:"addrPart", label:"관내구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}},
									{key:"dcGubun", label:"감면구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("dcGubun", this.value);
									}},
									{key:"deadSex", label:"성별", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("deadSex", this.value);
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
						setPage: function(){

							app.ajax({
	                            type: "GET",
	                            url: "/SUIP1100/paymentCalc/cen",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.A.target.setData({list: res});
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
								height: "auto",
								colHead: {
									rows: [
										[
											{colSeq: 0, rowspan: 3},
											{colSeq: 1, rowspan: 3},
											{colSeq: null, rowspan: 2, colspan: 4, label: "면세", align: "center"},
											{colSeq: null, colspan: 9, label: "과세", align: "center"},
										],
										[
											{colSeq: null, colspan: 3, label: "소계", align: "center"},
											{colSeq: null, colspan: 3, label: "매점수입", align: "center"},
											{colSeq: null, colspan: 3, label: "식당/제수실수입", align: "center"},
										],
										[
											{colSeq: 2},
											{colSeq: 3},
											{colSeq: 4},
											{colSeq: 5},
											{colSeq: 6},
											{colSeq: 7},
											{colSeq: 8},
											{colSeq: 9},
											{colSeq: 10},
											{colSeq: 11},
											{colSeq: 12},
											{colSeq: 13},
											{colSeq: 14},
										]
									]
								},
								colGroup : [
									{key:"inDate", label:"수입일자", width:"100", align:"center"},
									{key:"tot", label:"합계", width:"100", align:"right", formatter: "money"},
									{key:"noTaxTot", label:"소계", width:"100", align:"right", formatter: "money"},
									{key:"funeral", label:"빈소/안치실", width:"100", align:"right", formatter: "money"},
									{key:"funeralItem", label:"장례용품", width:"100", align:"right", formatter: "money"},
									{key:"flower", label:"화원수입", width:"100", align:"right", formatter: "money"},
									{key:"taxTot", label:"계", width:"100", align:"right", formatter: "money"},
									{key:"taxAmt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"taxVat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"storeAmt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"storeVat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"storeTot", label:"계", width:"100", align:"right", formatter: "money"},
									{key:"restAmt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"restVat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"restTot", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/paymentCalc/funeral",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.B.target.setData({list: res});
	                            }
	                        });
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
								height: "auto",
								colGroup : [
									{key:"idate", label:"수입일자", width:"100", align:"center"},
									{key:"gubunCd", label:"구분", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"적요", width:"300", align:"left"},
									{key:"enapip", label:"납입자", width:"200", align:"center"},
									{key:"eamt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/suetc/04",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.C.target.setData({list: res});
	                            }
	                        });
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
								height: "auto",
								colGroup : [
									{key:"idate", label:"수입일자", width:"100", align:"center"},
									{key:"gubunCd", label:"구분", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"적요", width:"300", align:"left"},
									{key:"enapip", label:"납입자", width:"200", align:"center"},
									{key:"eamt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/suetc/06",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.D.target.setData({list: res});
	                            }
	                        });
						}
					}
					, E: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridE",
								theme : "AXGrid",
								colHeadAlign:"center",
								height: "auto",
								colGroup : [
									{key:"idate", label:"수입일자", width:"100", align:"center"},
									{key:"gubunCd", label:"구분", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"적요", width:"300", align:"left"},
									{key:"enapip", label:"납입자", width:"200", align:"center"},
									{key:"eamt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/suetc/05",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.E.target.setData({list: res});
	                            }
	                        });
						}
					}
					, F: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridF",
								theme : "AXGrid",
								colHeadAlign:"center",
								height: "auto",
								colGroup : [
									{key:"idate", label:"수입일자", width:"100", align:"center"},
									{key:"gubunCd", label:"구분", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"적요", width:"300", align:"left"},
									{key:"enapip", label:"납입자", width:"200", align:"center"},
									{key:"eamt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/suetc/07",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.F.target.setData({list: res});
	                            }
	                        });
						}
					}
					, G: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridG",
								theme : "AXGrid",
								colHeadAlign:"center",
								height: "auto",
								colGroup : [
									{key:"idate", label:"수입일자", width:"100", align:"center"},
									{key:"gubunCd", label:"구분", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"적요", width:"300", align:"left"},
									{key:"enapip", label:"납입자", width:"200", align:"center"},
									{key:"eamt", label:"공급가액", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"부가가치세", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"계", width:"100", align:"right", formatter: "money"},
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
	                            url: "/SUIP1100/suetc/08",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.G.target.setData({list: res});
	                            }
	                        });
						}
					}
					, H: {
						target: new AXGrid(),
						bind: function(){
							var target = this.target, _this = this;
							target.setConfig({
								targetID : "div-gridH",
								theme : "AXGrid",
								colHeadAlign:"center",
								height: "auto",
								colGroup : [
									{key:"date", label:"수입일자", width:"100", align:"center"},
									{key:"amount", label:"봉안관리비", width:"100", align:"right", formatter: "money"},
									{key:"applName", label:"납부자", width:"100", align:"center"},
									{key:"relation", label:"관계", width:"100", align:"center", formatter: function(){
										return Common.grid.codeFormatter("relation", this.value);
									}},
									{key:"mobileno", label:"연락처", width:"100", align:"center"},
									{key:"deadName", label:"고인명", width:"100", align:"center"},
									{key:"addrPart", label:"관내구분", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}},
									{key:"ensType", label:"안치구분", width:"100", align:"center", formatter: function(){
										return Common.grid.codeFormatter("ensType", this.value);
									}},
									{key:"ensNo", label:"봉안번호", width:"100", align:"center"},
									{key:"stDate", label:"시작일자", width:"100", align:"center"},
									{key:"edDate", label:"종료일자", width:"100", align:"center"},
									{key:"deadDate", label:"사망일자", width:"100", align:"center"},
									{key:"cremDate", label:"화장일자", width:"100", align:"center"},
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
	                            url: "/SUIP1100/ensext",
	                            data: fnObj.search.target.getParam()
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }else{
									fnObj.grid.H.target.setData({list: res});
	                            }
	                        });
						}
					}
				}
			};
		</script>
	</ax:div>
</ax:layout>