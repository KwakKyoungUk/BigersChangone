<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="화로 배정" />
	<ax:set name="page_desc" value="" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
                <div class="ax-button-group">
                	<div class="left">
                	</div>
                    <div class="ax-clear"></div>
                </div>

                <div class="ax-search" id="page-search"></div>
                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="3">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 화로 현황</h2>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <div class="ax-grid" id="page-grid-box-rogrpchasu" style="min-height: 150px;"></div>
                        </ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="3">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 대기실 현황</h2>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <div class="ax-grid" id="page-grid-box-waitRoom" style="min-height: 150px;"></div>
                        </ax:custom>
                    </ax:custom>
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 고별실 현황</h2>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <div class="ax-grid" id="page-grid-box-byeRoom" style="min-height: 150px;"></div>
                        </ax:custom>
                        <ax:custom customid="td">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 수골실 현황</h2>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <div class="ax-grid" id="page-grid-box-sugolRoom" style="min-height: 150px;"></div>
                        </ax:custom>
                        <ax:custom customid="td">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 배정내역</h2>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                    <ax:form id="form-assignment" name="form-assignment">
			                    	<ax:fields>
			                    		<ax:field label="차수">
			                    			<input type="text" id="info-burnChasu" name="burnChasu" title="차수" placeholder="차수" class="AXInput W100" value=""/>
			                    		</ax:field>
			                    		<ax:field label="화로">
			                    			<input type="text" id="info-burnNo" name="burnNo" title="화로" placeholder="화로" class="AXInput W100" value=""/>
			                    		</ax:field>
			                    		<ax:field label="유족대기실">
			                    			<input type="text" id="info-waitRoom" name="waitRoom" title="유족대기실" placeholder="유족대기실" class="AXInput W100" value=""/>
			                    		</ax:field>
			                    		<ax:field label="고별실">
			                    			<input type="text" id="info-byeRoom" name="byeRoom" title="고별실" placeholder="고별실" class="AXInput W100" value=""/>
			                    		</ax:field>
			                    		<ax:field label="수골실">
			                    			<input type="text" id="info-sugolRoom" name="sugolRoom" title="수골실" placeholder="수골실" class="AXInput W100" value=""/>
			                    		</ax:field>
			                    	</ax:fields>
			                    </ax:form>
			                </div>
                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
       	<ax:div name="buttons">
			<button type="button" class="AXButton" onclick="fnObj.autoAssinment();">자동배정</button>
			<button type="button" class="AXButton" onclick="fnObj.control.save();">확인</button>
			<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
		</ax:div>
    </ax:div>
    <ax:div name="scripts">
        <jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">

        	var chasu = '${chasu}';

            var resize_elements = [
//                 {id:"page-grid-box-rogrpchasu", adjust:function(){
//                     	return -axf.clientHeight()/2;
//                 	}
//                 }
//                 , {id:"page-grid-box-hwaBooking", adjust:function(){
//     	                return -axf.clientHeight()/2;
// 	                }
//                 }
            ];
            var fnObj = {

                CODES: {
                	"objt": Common.getCode("TMC02"),
                },
                pageStart: function(){
                	this.search.bind();
                	this.gridRogrpchasu.bind();
                	this.gridRogrpchasu.setPage(1);
                	this.gridWaitRoom.bind();
                	this.gridWaitRoom.setPage(1);
                	this.gridByeRoom.bind();
                	this.gridByeRoom.setPage(1);
                	this.gridSugolRoom.bind();
                	this.gridSugolRoom.setPage(1);
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
				pageResize: function(){
					parent.myModal.resize();
				},
                bindEvent: function(){
                },
                autoAssinment: function(){
					if(chasu == ''){
						chasu = '01';
					}
					$("#info-burnChasu").val(chasu);
					for(var i=0, chk=true; chk && i<fnObj.gridRogrpchasu.target.list.length; i++){
						if((+fnObj.gridRogrpchasu.target.list[i].chasuSeq)<(+chasu)){
							continue;
						}
						for(var key in fnObj.gridRogrpchasu.target.list[i]){
							if(!key.startsWith("ro")){
								continue;
							}
							if(fnObj.gridRogrpchasu.target.list[i][key] != "000"){
								$("#info-burnNo").val(key.substring(2));
								chk=false;
								break;
							}
						}
					}
					for(var i=0, chk=true; chk && i<fnObj.gridWaitRoom.target.list.length; i++){
						if((+fnObj.gridWaitRoom.target.list[i].chasuSeq)<(+chasu)){
							continue;
						}
						for(var key in fnObj.gridWaitRoom.target.list[i]){
							if(key=="chasuName" || key=="chasuSeq" || key=="endtimeString" || key=="strttimeString"){
								continue;
							}
							for(var j=0;chk;j++){
								if(fnObj.gridWaitRoom.target.list[i][key] == j){
									$("#info-waitRoom").val(key);
									chk=false;
									break;
								}
							}
							if(!chk){
								break;
							}
						}
					}
					for(var i=0, chk=true; chk && i<fnObj.gridByeRoom.target.list.length; i++){
						if((+fnObj.gridByeRoom.target.list[i].chasuSeq)<(+chasu)){
							continue;
						}
						for(var key in fnObj.gridByeRoom.target.list[i]){
							if(key=="chasuName" || key=="chasuSeq" || key=="endtimeString" || key=="strttimeString"){
								continue;
							}
							for(var j=0;chk;j++){
								if(fnObj.gridByeRoom.target.list[i][key] == j){
									$("#info-byeRoom").val(key);
									chk=false;
									break;
								}
							}
							if(!chk){
								break;
							}
						}
					}
					for(var i=0, chk=true; chk && i<fnObj.gridSugolRoom.target.list.length; i++){
						if((+fnObj.gridSugolRoom.target.list[i].chasuSeq)<(+chasu)){
							continue;
						}
						for(var key in fnObj.gridSugolRoom.target.list[i]){
							if(key=="chasuName" || key=="chasuSeq" || key=="endtimeString" || key=="strttimeString"){
								continue;
							}
							for(var j=0;chk;j++){
								if(fnObj.gridSugolRoom.target.list[i][key] == j){
									$("#info-sugolRoom").val(key);
									chk=false;
									break;
								}
							}
							if(!chk){
								break;
							}
						}
					}


                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search",
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
                                    {label:"화장대상구분", labelWidth:"", type:"selectBox", width:"80", key:"objt", addClass:"", valueBoxStyle:"", value:"",
                                    	options:fnObj.CODES.objt
                                    }
                                    , {label:"화장예약번호", labelWidth:"", type:"inputText", width:"100", key:"bookDate", addClass:"", valueBoxStyle:"", value:""}
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"bookChasu", addClass:"", valueBoxStyle:"", value:""}
                                    , {label:"", labelWidth:"", type:"inputText", width:"50", key:"bookChasuSeq", addClass:"", valueBoxStyle:"", value:""}
                                    , {label:"고인명", labelWidth:"", type:"inputText", width:"100", key:"deadName", addClass:"", valueBoxStyle:"", value:""}
                                    , {label:"신청자명", labelWidth:"", type:"inputText", width:"100", key:"applName", addClass:"", valueBoxStyle:"", value:""}
//             						, {label:"", labelWidth:"", type:"button", width:"50", key:"button", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
//             							onclick: function(){
//             								fnObj.searchHwaCremation.submit();
//             							}
//             						},
                                ]}
                            ]
                        });
                    },
                    submit: function(){
//                         var pars = this.target.getParam();
//                     	app.ajax({
//                 			async: false,
//                             type: "GET",
//                             url: "/CREM2010/hwaCremation/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremDate")).val()+"/"+$("#"+fnObj.searchHwaCremation.target.getItemId("cremSeq")).val(),
//                             data: ""
//                         },
//                         function(res){
//                         	if(res.error){
//                         		alert(res.massage);
//                         	}else{
//                         	}
//                     	});
                    }
                },
                gridRogrpchasu: {
                	roFormatter:function(val){

                		if(isNaN(+(this.value))){
                			return this.value;
                		}

                		if(this.value.toString() == "000"){
                			return "불가";
                		}

                		var res = [];

                		for(var i=0; i<this.value.toString().length; i++){
                			if(this.value.toString()[i]=="1"){
                				res.push("<i class='axi axi-circle' style='color:green; font-size:25px;'></i>");
                			}else{
                				res.push("<i class='axi axi-circle' style='color:darkgray; font-size:25px;'></i>");
                			}
                		}

                		return res.join("");
                	},
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-rogrpchasu",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"chasuSeq", label:"차수", width:"50", align:"center"},
                                {key:"strtimeString", label:"시작시간", width:"80", align:"center"},
                                {key:"endtimeString", label:"종료시간", width:"80", align:"center"},
                                {key:"ro01", label:"1", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                               	},
                                {key:"ro02", label:"2", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                              	},
                                {key:"ro03", label:"3", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro04", label:"4", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro05", label:"5", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro06", label:"6", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro07", label:"7", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                },
                                {key:"ro08", label:"8", width:"100", align:"center"
                                	, formatter:fnObj.gridRogrpchasu.roFormatter
                                }
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){
									$("#info-burnChasu").val(this.item.chasuSeq);
									if(this.c<3){
										return;
									}
									var burnNo = this.c-2
									if(burnNo < 10){
										burnNo = "0"+burnNo;
									}
									$("#info-burnNo").val(burnNo);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                            url: "/CREM1010/findRogrpchasu/"+new Date().print(),
                            data: ""
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
                            }
                        });
                    }
                },
                gridWaitRoom: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-waitRoom",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : (function(basicCd){
                        		var result;
                            	app.ajax({
                            			async: false,
                                        type: "GET",
                                        url: "/CREM2011/waitRoom/colGroup",
                                        data: ""
                                    },
                                    function(res){
                                    	result = res.list;
                                    	result=[
													{key:"chasuSeq", label:"차수", width:"50", align:"center"},
													{key:"strtimeString", label:"시작시간", width:"80", align:"center"},
													{key:"endtimeString", label:"종료시간", width:"80", align:"center"}
                                    	        ].concat(result);
                                	}
                                );
                            	return result;
                        	}()),
                            body : {
                                onclick: function(){
									$("#info-burnChasu").val(this.item.chasuSeq);
									if(this.c<3){
										return;
									}

									$("#info-waitRoom").val(fnObj.gridWaitRoom.target.config.colGroup[this.c].key);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                            url: "/CREM2011/waitRoom",
                            data: ""
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
                            }
                        });
                    }
                },
                gridByeRoom: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-byeRoom",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : (function(basicCd){
                        		var result;
                            	app.ajax({
                            			async: false,
                                        type: "GET",
                                        url: "/CREM2011/byeRoom/colGroup",
                                        data: ""
                                    },
                                    function(res){
                                    	result = res.list;
                                    	result=[
													{key:"chasuSeq", label:"차수", width:"50", align:"center"},
													{key:"strtimeString", label:"시작시간", width:"80", align:"center"},
													{key:"endtimeString", label:"종료시간", width:"80", align:"center"}
                                    	        ].concat(result);
                                	}
                                );
                            	return result;
                        	}()),
                            body : {
                                onclick: function(){
									$("#info-burnChasu").val(this.item.chasuSeq);
									if(this.c<3){
										return;
									}

									$("#info-byeRoom").val(fnObj.gridByeRoom.target.config.colGroup[this.c].key);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                            url: "/CREM2011/byeRoom",
                            data: ""
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
                            }
                        });
                    }
                },
                gridSugolRoom: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-sugolRoom",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : (function(basicCd){
                        		var result;
                            	app.ajax({
                            			async: false,
                                        type: "GET",
                                        url: "/CREM2011/sugolRoom/colGroup",
                                        data: ""
                                    },
                                    function(res){
                                    	result = res.list;
                                    	result=[
													{key:"chasuSeq", label:"차수", width:"50", align:"center"},
													{key:"strtimeString", label:"시작시간", width:"80", align:"center"},
													{key:"endtimeString", label:"종료시간", width:"80", align:"center"}
                                    	        ].concat(result);
                                	}
                                );
                            	return result;
                        	}()),
                            body : {
                                onclick: function(){
									$("#info-burnChasu").val(this.item.chasuSeq);
									if(this.c<3){
										return;
									}

									$("#info-sugolRoom").val(fnObj.gridSugolRoom.target.config.colGroup[this.c].key);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
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
                            url: "/CREM2011/sugolRoom",
                            data: ""
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
                            }
                        });
                    }
                },
                save: function(){
                },
				control: {
					save: function(){

                        var item = fnObj.form.getJSON();
						app.modal.save("${param.callBack}", item);

					},
					cancel: function(){
						app.modal.cancel();
					}
				},
                /*******************************************************
                 * 상세 폼
                 */
                form: {
                    target: $('#form-assignment'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-assignment"
                        });

                        $('#ax-form-btn-new').click(function() {
                            fnObj.form.clear();
                        });
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        $('#info-key').removeAttr("readonly");
                    }
                } // form

            };
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
        </script>

    </ax:div>
</ax:layout>