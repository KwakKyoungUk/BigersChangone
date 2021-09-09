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
		   		<div id="page-search-box"></div>
				<div id="div-tab"></div>
			   	<div id="div-content">
			   		<div id="div-tab-content-A">						
						<iframe id="if-pdfA" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
				</div>
				<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; height:0px; overflow:hidden;">	
					<div id="div-tab-content-B">
						<iframe id="if-pdfB" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
					<div id="div-tab-content-C">
						<iframe id="if-pdfC" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
					<div id="div-tab-content-D">
						<iframe id="if-pdfD" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
					</div>
					<div id="div-tab-content-E">
						<iframe id="if-pdfE" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
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
					/* gubunCd: Common.getCodeByUrl("/SUIP1060/code/gubunCd")
					, deadSex: Common.getCode("TCM05")
					, addrPart: Common.getCode("TCM10")
					, dcGubun: Common.getCode("TCM05")
					, cremObjt: Common.getCode("TMC03")
					, enshObjt: Common.getCode("TFM08")
					, natuObjt: Common.getCode("TFM14")
					, relation: Common.getCode("TCM08") */
				},
				pageStart: function(){
					this.tab.bind();
					this.search.bind();
					this.bindEvent();
				},
				bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                    	var params = [];
                     	var reportName  = "STAT1071";
                     	var reportName2  = "STAT1072";
                     	var reportName3  = "STAT1073";
                     	var reportName4  = "STAT1074";
                     	var reportName5  = "STAT1075";
                     	
                     	params.push("FROM="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("TO="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                		params.push("DCOBJT="+Common.search.getValue(fnObj.search.target, "dcObjt"));
                		params.push("printName=${LOGIN_USER_ID}");
                		
                		Common.report.embedded("/reports/changwon/stat/"+reportName, "pdf", params.join("&"), "if-pdfA");
                		Common.report.embedded("/reports/changwon/stat/"+reportName2, "pdf", params.join("&"), "if-pdfB");
                		Common.report.embedded("/reports/changwon/stat/"+reportName3, "pdf", params.join("&"), "if-pdfC");
                		Common.report.embedded("/reports/changwon/stat/"+reportName4, "pdf", params.join("&"), "if-pdfD");
                		Common.report.embedded("/reports/changwon/stat/"+reportName5, "pdf", params.join("&"), "if-pdfE");   		
                		
                     });
                     $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                     	var reportName  = "STAT1071";
                     	var reportName2  = "STAT1072";
                     	var reportName3  = "STAT1073";
                     	var reportName4  = "STAT1074";
                     	var reportName5  = "STAT1075";
                     	
                     	params.push("FROM="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                		params.push("TO="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                		params.push("DCOBJT="+Common.search.getValue(fnObj.search.target, "dcObjt"));
                		params.push("printName=${LOGIN_USER_ID}");
                		
                		Common.report.embedded("/reports/changwon/stat/"+reportName, "pdf", params.join("&"), "if-pdfA");
                		Common.report.embedded("/reports/changwon/stat/"+reportName2, "pdf", params.join("&"), "if-pdfB");
                		Common.report.embedded("/reports/changwon/stat/"+reportName3, "pdf", params.join("&"), "if-pdfC");
                		Common.report.embedded("/reports/changwon/stat/"+reportName4, "pdf", params.join("&"), "if-pdfD");
                		Common.report.embedded("/reports/changwon/stat/"+reportName5, "pdf", params.join("&"), "if-pdfE");
                     });

                },
				tab: {
					target: $("#div-tab")
					, bind: function(){
						this.target.bindTab({
							theme : "AXTabs",
							value:"A",
							overflow:"scroll", /* "visible" */
							options:[
								{optionValue:"A", optionText:"화장", closable:false},
			  					{optionValue:"B", optionText:"봉안", closable:false},
			  					{optionValue:"C", optionText:"자연장"},
			  					{optionValue:"D", optionText:"화장+봉안"},
			  					{optionValue:"E", optionText:"화장+자연장"},
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
							targetID:"page-search-box",
							theme : "AXSearch",
							onsubmit: function(){
								fnObj.search.A.submit();
							},
							rows:[
								{display:true, addClass:"", style:"", list:[
									{label:"사용신청일", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
			   						{label:"구분", labelWidth:"100", type:"selectBox", width:"", key:"dcObjt", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"0", optionText:"전체감면"}, {optionValue:"1", optionText:"실제감면"}],
										AXBind:{
											type:"select", config:{
												onChange:function(){
													toast.push(Object.toJSON(this));
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
						//fnObj.grid.A.setPage();
					}
				}				
			};
		</script>
	</ax:div>
</ax:layout>