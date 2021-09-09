<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
    	<style>
    		.tase{
    			background-color: red;
    		}
    	</style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

                <div class="ax-button-group" ondblclick="if(event.ctrlKey) $('#btn-total-period').css('display','inline-block');")">
                    <div class="left">
                    </div>
                    <div class="right">
	                  	<button type="button" class="AXButton" id="btn-total-period" style="display: none;"><i class="axi axi-ion-calculator"></i> 기간실적 집계</button>
	                  	<button type="button" class="AXButton" id="btn-total"><i class="axi axi-ion-calculator"></i> 당일실적 집계</button>
	                  	<button type="button" class="AXButton" id="btn-daylog-report"><i class="axi axi-report"></i> 운영일지 출력</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 근무자현황</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <table style="width: 100%;">
                	<tr>
                		<td style="width: 45%; ">
                   <div class="ax-grid" id="page-grid-employee" style="height: 200px;"></div>
                		</td>
                		<td style="width: 9%;" valign="middle" align="center">
		                  	<button type="button" class="AXButton" id="btn-add-right"><i class="axi axi-angle-double-right"></i></button><br>
		                  	<button type="button" class="AXButton" id="btn-add-left"><i class="axi axi-angle-double-left"></i></button>
                		</td>
                		<td style="width: 45%;">
                   <div class="ax-grid" id="page-grid-daywork" style="height: 200px;"></div>
                		</td>
                	</tr>
                </table>

			</ax:col>
		</ax:row>
		<ax:row>
			<ax:col size="12">

	            <div class="ax-button-group">
	                <div class="left">
	                    <h2><i class="axi axi-list-alt"></i> 대기배출시설 및 방지시설 운영</h2>
	                </div>
	                <div class="right">
	                </div>
	                <div class="ax-clear"></div>
	            </div>
				<table cellpadding="0" cellspacing="0" class="AXGridTable">
				    <thead>
					    <tr>
					        <th>화장로(배출구) 번호</th>
					        <th>1호기</th>
					        <th>2호기</th>
					        <th>3호기</th>
					        <th>4호기</th>
					        <th>5호기</th>
					        <th>전력사용량누계(Kwh)</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<th>작동여부
				    		</th>
				    		<td><select id="info-opyn1" name="opyn1" class="AXSelect W100"></select>
				    		</td>
				    		<td><select id="info-opyn2" name="opyn2" class="AXSelect W100"></select>
				    		</td>
				    		<td><select id="info-opyn3" name="opyn3" class="AXSelect W100"></select>
				    		</td>
				    		<td><select id="info-opyn4" name="opyn4" class="AXSelect W100"></select>
				    		</td>
				    		<td><select id="info-opyn5" name="opyn5" class="AXSelect W100"></select>
				    		</td>
				    		<td rowspan="2"><input type="text" id="info-eleSum" name="eleSum" title="전력사용량누계(Kwh)" placeholder="전력사용량누계(Kwh)" maxlength="100" class="AXInput W100 av-required" value=""/>
				    		</td>
				    	</tr>
				    	<tr>
				    		<th>작동시간
				    		</th>
				    		<td colspan="5"><input type="text" id="info-opTime" name="opTime" title="작동시간" placeholder="작동시간" maxlength="100" class="AXInput av-required" style="width: 98%;" value="08:00~16:00(8시간)"/>
				    		</td>
				    	</tr>
				    	<tr>
				    		<th>운영사항
				    		</th>
				    		<td colspan="6"><input type="text" id="info-opRemark" name="opRemark" title="운영사항" placeholder="운영사항" maxlength="100" class="AXInput av-required" style="width: 98%;" value="방지시설 운전사항(처리오염물질 : 먼지,황산화물,진소산화물) -원심력집진시설,촉매반응시설,여과집진시설"/>
				    		</td>
				    	</tr>
				    	<tr>
				    		<th>자가측정사항(대행)
				    		</th>
				    		<td colspan="6"><input type="text" id="info-selfMsmt" name="selfMsmt" title="운영사항" placeholder="운영사항" maxlength="100" class="AXInput av-required" style="width: 98%;" value="측정 대행"/>
				    		</td>
				    	</tr>
				    </tbody>
				</table>
			</ax:col>
		</ax:row>
		<ax:row>
			<ax:col  size="8">

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 화장 잔류물 수거 현황</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<table cellpadding="0" cellspacing="0" class="AXGridTable" style="width: 100%;">
					<thead>
						<tr>
							<th>보철물
							</th>
							<th>못
							</th>
							<th>치금
							</th>
							<th>반출
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" id="info-prosthesis" name="prosthesis" title="보철물" placeholder="보철물" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
							<td><input type="text" id="info-peg" name="peg" title="못" placeholder="못" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
							<td><input type="text" id="info-ironTooth" name="ironTooth" title="치금" placeholder="치금" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
							<td><input type="text" id="info-retnResidue" name="retnResidue" title="반출" placeholder="반출" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
<!-- 							<td><input type="text" id="info-residueRemark" name="residueRemark" title="비고" placeholder="비고" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/> -->
							</td>
						</tr>
					</tbody>
				</table>
			</ax:col>
			<ax:col  size="4">

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> LPG 사용량</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<table cellpadding="0" cellspacing="0" class="AXGridTable" style="width: 100%;">
					<thead>
						<tr>
							<th>LPG 사용량
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" id="info-lpgqty" name="lpgqty" title="LPG 사용량" placeholder="LPG 사용량" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
						</tr>
					</tbody>
				</table>

			</ax:col>
		</ax:row>
		<ax:row>
			<ax:col wrap="true">

				<div class="ax-button-group">
			       <div class="left">
			           <h2><i class="axi axi-list-alt"></i> 기타</h2>
			       </div>
			       <div class="right">
			       </div>
			       <div class="ax-clear"></div>
			   	</div>
				<table cellpadding="0" cellspacing="0" class="AXGridTable" style="width: 100%;">
					<tbody>
						<tr>
							<th width="150" bgcolor="#e7e7e7">
								금일 추진사항
							</th>
							<td><input type="text" id="info-propulsion" name="propulsion" title="금일 추진사항" placeholder="금일 추진사항" maxlength="100" class="AXInput av-required" style="width: 98%;" value="시설 정리 정돈 및 청소 등"/>
							</td>
						</tr>
						<tr>
							<th bgcolor="#e7e7e7">
								특이사항
							</th>
							<td><input type="text" id="info-unusual" name="unusual" title="특이사항" placeholder="특이사항" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
						</tr>
						<tr>
							<th bgcolor="#e7e7e7">
								붙임
							</th>
							<td><input type="text" id="info-remark" name="remark" title="붙임" placeholder="붙임" maxlength="100" class="AXInput av-required" style="width: 98%;" value=""/>
							</td>
						</tr>
					</tbody>
				</table>

        	</ax:col>
       	</ax:row>
		<ax:row>
			<ax:col wrap="true">

				<div class="ax-button-group">
			       <div class="left">
			           <h2><i class="axi axi-list-alt"></i> 문서</h2>
			       </div>
			       <div class="right">
			           <button type="button" class="AXButton" id="btn-add-files"><i class="axi axi-plus-circle"></i> 추가</button>
			           <button type="button" class="AXButton" id="btn-del-files"><i class="axi axi-minus-circle"></i> 삭제</button>
			       </div>
			       <div class="ax-clear"></div>
			   	</div>
				<div class="ax-grid" id="page-grid-daydoc" style="height: 200px;"></div>

        	</ax:col>
       	</ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                	empGubun: Common.getCode("EMP_GUBUN"),
                	opyn: Common.getCode("OPYN")
                },
                pageStart: function(){
                    this.bindEvent();
					this.search.bind();
					this.gridEmployee.bind();
					this.gridDaywork.bind();
					this.gridDaydoc.bind();
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });
                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.del();
                        }, 500);
                    });
					$("#btn-add-right").bind("click", function(){
						var checkedEmployeeList = fnObj.gridEmployee.target.getCheckedListWithIndex(0);
						fnObj.gridEmployee.target.removeListIndex(checkedEmployeeList);
						fnObj.gridDaywork.target.pushList(function(){
							return $.map(checkedEmployeeList, function(item){return item.item;});
						}());
					});
					$("#btn-add-left").bind("click", function(){
						var checkedList = fnObj.gridDaywork.target.getCheckedListWithIndex(0);
						fnObj.gridDaywork.target.removeListIndex(checkedList);
						fnObj.gridEmployee.target.pushList(function(){
							return $.map(checkedList, function(item){return item.item;});
						}());
					});
					$("#btn-total-period").bind("click",function(){
						var from = prompt("from");
						var to = prompt("to");
						app.ajax({
	                        type: "POST",
	                        url: "/DAIL1010/daysum/"+from.date().print("yyyymmdd")+"/"+to.date().print("yyyymmdd"),
	                        data: ""
	                    }, function(res){
	                        if(res.error){
	                            alert(res.error.message);
	                        }else{
	                        	toast.push(from+"~"+to+" 자료 집계가 완료되었습니다.");
	                        }
	                    });
					});
                    $("#info-opyn1").bindSelect({
                        options:fnObj.CODES.opyn
                    });
                    $("#info-opyn2").bindSelect({
                        options:fnObj.CODES.opyn
                    });
                    $("#info-opyn3").bindSelect({
                        options:fnObj.CODES.opyn
                    });
                    $("#info-opyn4").bindSelect({
                        options:fnObj.CODES.opyn
                    });
                    $("#info-opyn5").bindSelect({
                        options:fnObj.CODES.opyn
                    });
                    $("#btn-add-files").bind("click", function(){
                    	app.modal.open({
	                        url:"/jsp/funeralsystem/common/fileUpload.jsp",
	                        pars:"callBack=fnObj.daydocModalResult",
	                        width:1200, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                    $("#btn-del-files").bind("click", function(){
                    	fnObj.gridDaydoc.del();
                    });
                    $("#btn-total").bind("click", function(){
                    	fnObj.calcTotal();
                    });
                    $("#btn-daylog-report").bind("click", function(){
                    	Common.report.open("/reports/dail/DAIL1010r1", "pdf"
                    			, "workDate="+Common.search.getValue(fnObj.search.target, "workDate").date().print("yyyymmdd"));
                    });
                },
                calcTotal: function(){
                	if(!confirm(Common.search.getValue(fnObj.search.target, "workDate").date().print() + " 자료를 집계하시겠습니까?")){
                		return;
                	}
                	app.ajax({
                        type: "POST",
                        url: "/DAIL1010/daysum/"+Common.search.getValue(fnObj.search.target, "workDate").date().print("yyyymmdd"),
                        data: ""
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }else{
                        	toast.push(Common.search.getValue(fnObj.search.target, "workDate").date().print()+" 자료 집계가 완료되었습니다.");
                        }
                    });
                },
                daydocModalResult: function(files){

                	var list = [];
                	for(var i=0; i<files.length; i++){
                		var item = {};
                		item._CUD = "C";
                		item.docName = files[i].name;
                		item.docPath = files[i].uploadedPath+"/"+files[i].saveName;
                		item.thumbPath = files[i].thumbPath;
                		list.push(item);
                	}
                	fnObj.gridDaydoc.target.pushList(list);
                	app.modal.close();
                },
                save: function(){

                	var daylogVTO = Common.json.getJsonWithId("info-");
                	var dayworkVTOList = fnObj.gridDaywork.target.list;
                	var daydocVTOList = Common.grid.getSaveList(fnObj.gridDaydoc.target);

                	daylogVTO.workDateString = Common.search.getValue(fnObj.search.target, "workDate").date().print("yyyymmdd");
                	daylogVTO.dayworkVTOList = dayworkVTOList;
                	daylogVTO.daydocVTOList = daydocVTOList;

                	app.ajax({
                        type: "POST",
                        url: "/DAIL1010/daylog",
                        data: Object.toJSON(daylogVTO)
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }else{
                        	$("#ax-page-btn-search").click();
                        }
                    });
                },
                del: function(){
                	app.ajax({
                        type: "DELETE",
                        url: "/DAIL1010/daylog/" + Common.search.getValue(fnObj.search.target, "workDate").date().print("yyyymmdd"),
                        data: ""
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }else{
                        	Common.search.setValue(fnObj.search.target, "workDate", new Date().print());
                        	$("[id^='info-']").val("");
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
               						{label:"운영일자", labelWidth:"", type:"inputText", width:"100", key:"workDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
// 	        										toast.push(Object.toJSON(this));
	        									}
	        								}
	        							},
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
//                         var pars = this.target.getParam();
						var workDate = Common.search.getValue(fnObj.search.target, "workDate").date().print("yyyymmdd");
						app.ajax({
                            type: "GET",
                            url: "/DAIL1010/employee/"+workDate,
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                                var gridData = {
                                    list: res.list,
                                };
                                fnObj.gridEmployee.target.setData(gridData);
                            }
                        });
						app.ajax({
                            type: "GET",
                            url: "/DAIL1010/daywork/"+workDate,
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                                var gridData = {
                                    list: function(){
                                    		for(var i=0; i<res.list.length; i++){
                                    			res.list[i].empName = res.list[i].employeeVTO.empName;
                                    		}
                                    		return res.list;
                                    	}(),
                                };
                                fnObj.gridDaywork.target.setData(gridData);
                            }
                        });
						app.ajax({
                            type: "GET",
                            url: "/DAIL1010/daylog/"+workDate.date().print("yyyymmdd"),
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                            	for(var key in res.map.DaylogVTO){
                            	
                            		$("#info-"+key).val(res.map.DaylogVTO[key]);                            		
                            		$("#info-"+key).bindSelectSetValue(res.map.DaylogVTO[key]);
                            	}
                            }
                        });
						app.ajax({
                            type: "GET",
                            url: "/DAIL1010/daydoc/"+workDate,
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                                var gridData = {
                                    list: res.list,
                                };
                                fnObj.gridDaydoc.target.setData(gridData);
                            }
                        });
                    }
                },

                gridEmployee: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-employee",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"empGubun", label:"직군", width:"60", align:"center"
                                	, formatter: function(){
                                		return Common.grid.codeFormatter("empGubun", this.value);
                                	}
                               	},
                                {key:"empName", label:"성명", width:"100", align:"center"},
                            ],
                            body : {
                                onclick: function(){
                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },

                gridDaywork: {
                    parent: {},
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-daywork",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                        {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                        {key:"empGubun", label:"직군", width:"60", align:"center"
                                        	, formatter: function(){
                                        		return Common.grid.codeFormatter("empGubun", this.value);
                                        	}
                                        },
                                        {key:"empName", label:"성명", width:"100", align:"center"},
                            ],
                            body : {
                                onclick: function(){

                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },
                gridDaydoc: {
                    parent: {},
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-daydoc",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                        {key:"index", label:"", width:"35", align:"center", formatter:"checkbox"},
                                        {key:"seq", label:"문서번호", width:"80", align:"center"
                                        	, formatter: function(){
                                        		if(this.item._CUD && this.item._CUD == 'C'){
                                        			return "신규";
                                        		}else{
                                        			return this.value;
                                        		}
                                        	}
                                        },
                                        {key:"docName", label:"문서명", width:"200", align:"center"
                                        	, editor:{
                                                type:"text",
                                                maxLength: 200,
//                                                 disabled: function(){
//                                                     return this.item._CUD != "C";
//                                                 },
//                                                 beforeUpdate: function(val){
//                                                 },
//                                                 afterUpdate: function(){
//                                                 }
                                            }
                                        },
                                        {key:"docPath", label:"저장파일명", width:"400", align:"center"
                                        	, formatter: function(){
                                        		return "<img width='15' height='15' src='"+this.item.thumbPath+"'/><a href='"+this.item.docPath+"' target='_blank'>"+this.item.docPath+"</a>";
                                        	}
                                        },
                                        {key:"remark", label:"비고", width:"100", align:"center"},
                            ],
                            body : {
                                onclick: function(){

                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    del: function(){
                    	var _this = this;
                    	var checkedList = this.target.getCheckedListWithIndex(0);
                    	var deleteItems = [];
                    	var deleteNewItems = [];
                    	for(var i=0; i<checkedList.length; i++){
                    		var docPath = checkedList[i].item.docPath;
                    		var saveName = docPath.substr(docPath.lastIndexOf("/")+1);
                    		var uploadedPath = docPath.substr(0, docPath.lastIndexOf("/"));
                    		var item = {};
                    		item.saveName = saveName;
                    		item.uploadedPath = uploadedPath;
                    		item.thumbPath = checkedList[i].item.thumbPath;
                    		item.checkedItem = checkedList[i].item;
                    		if(checkedList[i].item._CUD && checkedList[i].item._CUD == 'C'	){
                    			deleteNewItems.push(item);
                    		}else{
	                    		deleteItems.push(checkedList[i].item);
                    		}
                    	}

                    	$.each(deleteNewItems, function(index, item){
                            app.ajax({
                                type: "POST",
                                url: "/fileDelete?"+$.param(item),
                                data: ""
                            }, function(res){
                                if(res.error){
                                    alert(res.error.message);
                                }
                                else
                                {
                                	_this.target.removeList([item.checkedItem]);
                                }
                            });
                    	});
                    	if(deleteItems.length>0){

	                        app.ajax({
	                            type: "DELETE",
	                            url: "/DAIL1010/daydoc",
	                            data: Object.toJSON(deleteItems)
	                        }, function(res){
	                            if(res.error){
	                                alert(res.error.message);
	                            }
	                            else
	                            {
	                                toast.push("파일이 삭제되었습니다.");
			                    	_this.target.removeList(deleteItems);
	                            }
	                        });
                    	}

//                     	this.target.removeListIndex(checkedList);
                    },
                    setPage: function(pageNo, searchParams){
                    }
                },


            };
        </script>
    </ax:div>
</ax:layout>