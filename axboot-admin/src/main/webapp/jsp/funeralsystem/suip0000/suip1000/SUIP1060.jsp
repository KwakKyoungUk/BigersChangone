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
                    	<button type="button" class="AXButton" id="btn-newSuetc"><i class="axi axi-plus-circle"></i> 신규</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-grid-suetc"></div>
                <ax:form id="form-info" name="form-info">
                	<input type="hidden" id="info-id" name="id">
                	<input type="hidden" id="info-allocrId" name="allocrId">
                	<table class='AXFormTable'>
           				<colgroup>
            				<col width="100"/>
            				<col/>
            				<col width="100"/>
            				<col/>
            				<col width="100"/>
            				<col/>
            				<col width="100"/>
            				<col/>
            			</colgroup>
            			<tr>
            				<th><div class='tdRel'>징수결의일자</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:inputDate id="info-ekdate" name="ekdate" title="징수결의일자"></b:inputDate>
           					</div></td>
            				<th><div class='tdRel'>납입기한일</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:inputDate id="info-endate" name="endate" title="납입기한일"></b:inputDate>
           					</div></td>
            				<th><div class='tdRel'>납입자(회사)</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-enapip" name="enapip" title="납입자(회사)" placeholder="납입자(회사)"></b:input>
           					</div></td>
            				<th><div class='tdRel'>납입자(성명)</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-eowner" name="eowner" title="납입자(성명)" placeholder="납입자(성명)"></b:input>
           					</div></td>
            			</tr>
            			<tr>
            				<th><div class='tdRel'>구분</div>
            				</th>
            				<td><div class='tdRel'>
            					<select url="/SUIP1060/code/gubunCd" id="info-gubunCd" name="gubunCd" class="AXSelect"></select>
           					</div></td>
            				<th><div class='tdRel'>적요</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-ebigo" name="ebigo" title="적요" placeholder="적요"></b:input>
           					</div></td>
            				<th><div class='tdRel'>주민번호</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-eident" name="eident" title="주민번호" placeholder="주민번호" pattern="custom" patternString="999999-9999999" maxlength="14"></b:input>
           					</div></td>
            				<th><div class='tdRel'>휴대폰</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-hphone1" name="hphone1" title="휴대폰" placeholder="휴대폰" clazz="W50" maxlength="3"></b:input>
            					<b:input id="info-hphone2" name="hphone2" title="휴대폰" placeholder="휴대폰" clazz="W50" maxlength="4"></b:input>
            					<b:input id="info-hphone3" name="hphone3" title="휴대폰" placeholder="휴대폰" clazz="W50" maxlength="4"></b:input>
           					</div></td>
            			</tr>
            			<tr>
            				<th><div class='tdRel'>주소</div>
               				</th>
               				<td colspan="5"><div class='tdRel'>
                				<input type="text" id="info-epost" name="epost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
			                    <button type="button" class="AXButton" id="btn-searchPost"><i class="axi axi-local-post-office"></i> 우편번호</button>
			                    <input type="text" id="info-eaddr1" name="eaddr1" title="주소"  placeholder="" class="AXInput" style="width:340px;" value="" />
			                    <input type="text" id="info-eaddr2" name="eaddr2" title="상세주소"  placeholder="" class="AXInput" style="width:480px;" value="" />
               				</div></td>
            				<th><div class='tdRel'>전화번호</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-ephone1" name="ephone1" title="전화번호" placeholder="전화번호" clazz="W50" maxlength="3"></b:input>
            					<b:input id="info-ephone2" name="ephone2" title="전화번호" placeholder="전화번호" clazz="W50" maxlength="4"></b:input>
            					<b:input id="info-ephone3" name="ephone3" title="전화번호" placeholder="전화번호" clazz="W50" maxlength="4"></b:input>
           					</div></td>
            			</tr>
            			<tr>
            				<th><div class='tdRel'>공급가액</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-eamt" name="eamt" title="공급가액" placeholder="공급가액"></b:input>
           					</div></td>
            				<th><div class='tdRel'>부가가치세</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-evat" name="evat" title="부가가치세" placeholder="부가가치세"></b:input>
           					</div></td>
            				<th><div class='tdRel'>합계</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-eamount" name="eamount" title="합계" placeholder="합계"></b:input>
           					</div></td>
            				<th><div class='tdRel'>세외수입처리일자</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-edate" name="edate" title="세외수입처리일자" readonly="readonly"></b:input>
           					</div></td>
            			</tr>
            			<tr>
            				<th><div class='tdRel'>납입구분</div>
            				</th>
            				<td><div class='tdRel'>
            					<select basicCd="SYENAPGB" id="info-enapipGb" name="enapipGb" class="AXSelect"></select>
           					</div></td>
            				<th><div class='tdRel'>사업자등록번호</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-esano" name="esano" title="사업자등록번호" placeholder="사업자등록번호" pattern="custom" patternString="999-99-99999" maxlength="12"></b:input>
           					</div></td>
            				<th><div class='tdRel'>업태</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-euptae" name="euptae" title="업태" placeholder="업태"></b:input>
           					</div></td>
            				<th><div class='tdRel'>종목</div>
            				</th>
            				<td><div class='tdRel'>
            					<b:input id="info-ejongmok" name="ejongmok" title="종목" placeholder="종목"></b:input>
           					</div></td>
            			</tr>
                	</table>
                </ax:form>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                	gubunCd: Common.getCodeByUrl("/SUIP1060/code/gubunCd")
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                    this.defaultFn.excute();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#info-enapipGb").selectBox({
	                	basicCd: "SYENAPGB"
	                });
                    $("#info-gubunCd").selectBox({
	                	url: "/SUIP1060/code/gubunCd"
	                });
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
                			$("#ax-page-btn-save").attr("id", "btn-save");
                			$("#ax-page-btn-fn1").html("삭제");
                			$("#ax-page-btn-fn1").attr("id", "btn-deleteSuetc");
                			$("#ax-page-btn-fn2").html("징수결의서");
                			$("#ax-page-btn-fn2").attr("id", "btn-reportSUIP1061");
                			$("#ax-page-btn-fn3").html("인쇄");
                			$("#ax-page-btn-fn3").prop("disabled", true);
                			$("#ax-page-btn-fn3").attr("id", "btn-reportSUIP1062");
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
                	, save: function(){
                		fnObj.form.save();
                	}
                	, newSuetc: function(){
                		fnObj.form.clear();
                		$("#btn-reportSUIP1062").prop("disabled", true);
                	}
                	, searchPost: function(){
                		daumPopPostcode("info-epost", "info-eaddr1", "info-eaddr2");
                	}
                	, deleteSuetc: function(){
                		fnObj.form.del();
                	}
                   	, reportSUIP1061: function(){

                   		if(fnObj.grid.target.getSelectedItem().index >= 0){
                   			//$("#btn-reportSUIP1062").click();
                   			setTimeout(function() {
                   				var params = [];
                            	var id = fnObj.grid.target.getSelectedItem().item.id;
                            	var vat = fnObj.grid.target.getSelectedItem().item.evat > 0 ? 1 : 0;
                            	params.push("id="+id);
                            	params.push("printName=${LOGIN_USER_ID}");
                            	/*Common.report.open("/reports/changwon/suip/SUIP1061", "pdf",params.join("&")+"&vat=0");

                            	var vat = fnObj.grid.target.getSelectedItem().item.evat > 0 ? 1 : 0
                            	if(vat >  0){
                            		var windowFeatures = 'toolbar=0, status=0, menubar=0, scrollbars=no, height=700, width=800';
                        			var url = "/report?reportUnit=/reports/changwon/suip/SUIP1061&output=pdf&"+params.join("&")+"&vat=1";
                    	    		window.open(url, "reportPop2", windowFeatures);
                            	}*/

                            	if(vat > 0){
                            		var parameters = []
        							parameters.push({path: "/reports/changwon/suip/SUIP1061", parameter: params.join("&")+"&vat=1"})
        							parameters.push({path: "/reports/changwon/suip/SUIP1061", parameter: params.join("&")+"&vat=0"})
        							Common.report.mergePdfReport(parameters);
        						}else{
        							Common.report.open("/reports/changwon/suip/SUIP1061","pdf",params.join("&")+"&vat=1");
        						}

                            }, 500);
                   		}
                	}
                	, reportSUIP1062: function(){
                		app.ajax({
                            type: "PUT",
                            url: "/SUIP1060/allocr?id="+$("#info-id").val(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								// 고지서 출력부
								var allocrId = res.map.suetc.allocrId;

								app.ajax({
		                            type: "GET",
		                            url: "/SUIP1060/ocrband",
		                            data: "allocrId="+allocrId
		                        },
		                        function(res){
		                        	if(res.error){
		                        		alert(res.error.message);
		                        	}else{
										var ocrband = res.map.ocrband;
										Common.report.print("/reports/changwon/suip/SUIP1062", "pdf", "allocrId="+allocrId+"&ocrband="+ocrband);
		                        	}
		                        });
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
                                	{label:"조회구분", labelWidth:"", type:"selectBox", width:"150", key:"searchKind", addClass:"", valueBoxStyle:"", value:"",
                                        options:[
                                        	{optionValue: "0", optionText:"징수결의일자"}
                                        	, {optionValue: "1", optionText:"납입기한일자"}
                                        ],
                                        AXBind:{
                                            type:"select", config:{
                                                onchange:function(){
                                                }
                                            }
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
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	fnObj.grid.setPage();
                    }
                },
                grid: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-suetc",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"ekdate", label:"징수결의일", width:"100", align:"center"},
                                {key:"gubunCd", label:"구분", width:"150", align:"center", formatter: function(){
                                	if(this.value){
                                		return Common.grid.codeFormatter("gubunCd", this.value);
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"ebigo", label:"적요", width:"150", align:"center"},
                                {key:"enapip", label:"납입자", width:"100", align:"center"},
                                {key:"eamt", label:"공급가액", width:"100", align:"center", formatter: "money"},
                                {key:"evat", label:"부가가치세", width:"100", align:"center", formatter: "money"},
                                {key:"eamount", label:"계", width:"100", align:"center", formatter: "money"},
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.setJSON(this.item);
                                	$("#btn-reportSUIP1062").prop("disabled", false);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    setPage: function(searchParams){
//
                    	app.ajax({
                            type: "GET",
                            url: "/SUIP1060/suetc",
                            data: "sort=ekdate&ekdate.dir=desc&"+(searchParams||fnObj.search.target.getParam())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		fnObj.grid.target.setData({list: res.list});
                        		fnObj.form.clear();
                            }
                        });
                    }
                },
                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;
						this.clear();
                        var info = $.extend({}, item);

                        app.form.fillForm(_this.target, info, 'info-', true);
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    },
                    save: function(){
                    	if(!confirm("저장하시겠습니까?")){
                    		return;
                    	}
                    	var validateResult = fnObj.form.validate_target.validate();
                        if (!validateResult) {
                            var msg = fnObj.form.validate_target.getErrorMessage();
                            axf.alert(msg);
                            fnObj.form.validate_target.getErrorElement().focus();
                            return false;
                        }

                        app.ajax({
                            type: "PUT",
                            url: "/SUIP1060/suetc",
                            data: Object.toJSON(fnObj.form.getJSON())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                                toast.push("저장되었습니다.");
                                fnObj.form.clear();
                                fnObj.eventFn.search();
                            }
                        });
                    },
                    del: function(){
                    	if(!confirm("삭제하시겠습니까?")){
                			return;
                		}
                		app.ajax({
                            type: "DELETE",
                            url: "/SUIP1060/suetc",
                            data: Object.toJSON({id:$("#info-id").val()})
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		toast.push("삭제되었습니다.");
                        		fnObj.eventFn.search();
                            }
                        });
                    }
                },
                // form
            };
        </script>
    </ax:div>
</ax:layout>