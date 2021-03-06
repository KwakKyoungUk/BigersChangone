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
							$("#ax-page-btn-fn2").html("??????");
							$("#ax-page-btn-fn2").attr("id", "btn-print");
							$.each($("button[id^=btn-]"), function(i, o){
								var fn = fnObj.eventFn[o.id.substring("btn-".length)];
								if(!fn){
									console.log("button[id="+o.id+"] ??? ????????? ????????? ???????????? ????????????.");
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
								{optionValue:"A", optionText:"??????????????????????????????", closable:false},
			  					{optionValue:"B", optionText:"?????????????????????", closable:false},
			  					{optionValue:"C", optionText:"????????????????????????"},
			  					{optionValue:"D", optionText:"????????????????????????"},
			  					{optionValue:"E", optionText:"?????????"},
			  					{optionValue:"F", optionText:"?????????"},
			  					{optionValue:"G", optionText:"?????????"},
			  					{optionValue:"H", optionText:"???????????????"},
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
									{label:"????????????????????????", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
											{colSeq: null, colspan: 2, label: "??????", align: "center"},
											{colSeq: null, colspan: 3, label: "??????", align: "center"},
											{colSeq: null, colspan: 3, label: "??????", align: "center"},
											{colSeq: null, colspan: 3, label: "?????????", align: "center"},
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
									{key:"inDate", label:"????????????", width:"100", align:"center"},
									{key:"job", label:"??????", width:"70", align:"center"},
									{key:"tot", label:"???", width:"80", align:"right", formatter: "money"},
									{key:"cashTot", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"cardTot", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"cremCash", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"cremCard", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"cremObjt", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("cremObjt", this.value);
									}},
									{key:"enshCash", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"enshCard", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"enshObjt", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("enshObjt", this.value);
									}},
									{key:"natuCash", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"natuCard", label:"??????", width:"80", align:"right", formatter: "money"},
									{key:"natuObjt", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("natuObjt", this.value);
									}},
									{key:"applName", label:"?????????", width:"80", align:"center"},
									{key:"relation", label:"??????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("relation", this.value);
									}},
									{key:"mobileno1", label:"?????????", width:"120", align:"center"},
									{key:"deadName", label:"?????????", width:"80", align:"center"},
									{key:"addrPart", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}},
									{key:"dcGubun", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("dcGubun", this.value);
									}},
									{key:"deadSex", label:"??????", width:"80", align:"center", formatter: function(){
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
											{colSeq: null, rowspan: 2, colspan: 4, label: "??????", align: "center"},
											{colSeq: null, colspan: 9, label: "??????", align: "center"},
										],
										[
											{colSeq: null, colspan: 3, label: "??????", align: "center"},
											{colSeq: null, colspan: 3, label: "????????????", align: "center"},
											{colSeq: null, colspan: 3, label: "??????/???????????????", align: "center"},
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
									{key:"inDate", label:"????????????", width:"100", align:"center"},
									{key:"tot", label:"??????", width:"100", align:"right", formatter: "money"},
									{key:"noTaxTot", label:"??????", width:"100", align:"right", formatter: "money"},
									{key:"funeral", label:"??????/?????????", width:"100", align:"right", formatter: "money"},
									{key:"funeralItem", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"flower", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"taxTot", label:"???", width:"100", align:"right", formatter: "money"},
									{key:"taxAmt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"taxVat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"storeAmt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"storeVat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"storeTot", label:"???", width:"100", align:"right", formatter: "money"},
									{key:"restAmt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"restVat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"restTot", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"idate", label:"????????????", width:"100", align:"center"},
									{key:"gubunCd", label:"??????", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"??????", width:"300", align:"left"},
									{key:"enapip", label:"?????????", width:"200", align:"center"},
									{key:"eamt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"idate", label:"????????????", width:"100", align:"center"},
									{key:"gubunCd", label:"??????", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"??????", width:"300", align:"left"},
									{key:"enapip", label:"?????????", width:"200", align:"center"},
									{key:"eamt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"idate", label:"????????????", width:"100", align:"center"},
									{key:"gubunCd", label:"??????", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"??????", width:"300", align:"left"},
									{key:"enapip", label:"?????????", width:"200", align:"center"},
									{key:"eamt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"idate", label:"????????????", width:"100", align:"center"},
									{key:"gubunCd", label:"??????", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"??????", width:"300", align:"left"},
									{key:"enapip", label:"?????????", width:"200", align:"center"},
									{key:"eamt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"idate", label:"????????????", width:"100", align:"center"},
									{key:"gubunCd", label:"??????", width:"200", align:"center", formatter: function(){
										return Common.grid.codeFormatter("gubunCd", this.value);
									}},
									{key:"ebigo", label:"??????", width:"300", align:"left"},
									{key:"enapip", label:"?????????", width:"200", align:"center"},
									{key:"eamt", label:"????????????", width:"100", align:"right", formatter: "money"},
									{key:"evat", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"eamount", label:"???", width:"100", align:"right", formatter: "money"},
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
									{key:"date", label:"????????????", width:"100", align:"center"},
									{key:"amount", label:"???????????????", width:"100", align:"right", formatter: "money"},
									{key:"applName", label:"?????????", width:"100", align:"center"},
									{key:"relation", label:"??????", width:"100", align:"center", formatter: function(){
										return Common.grid.codeFormatter("relation", this.value);
									}},
									{key:"mobileno", label:"?????????", width:"100", align:"center"},
									{key:"deadName", label:"?????????", width:"100", align:"center"},
									{key:"addrPart", label:"????????????", width:"80", align:"center", formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}},
									{key:"ensType", label:"????????????", width:"100", align:"center", formatter: function(){
										return Common.grid.codeFormatter("ensType", this.value);
									}},
									{key:"ensNo", label:"????????????", width:"100", align:"center"},
									{key:"stDate", label:"????????????", width:"100", align:"center"},
									{key:"edDate", label:"????????????", width:"100", align:"center"},
									{key:"deadDate", label:"????????????", width:"100", align:"center"},
									{key:"cremDate", label:"????????????", width:"100", align:"center"},
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