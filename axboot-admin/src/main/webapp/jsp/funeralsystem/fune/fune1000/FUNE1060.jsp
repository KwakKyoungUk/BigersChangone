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

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width:500px;">
                            <div class="ax-button-group">
                            <div class="right">
                            <button type="button" class="AXButton" id="ax-btn-search"><i class="axi axi-search"></i>조회</button>
                            </div>
                            </div>
                        	<div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <div class="ax-button-group">
                            <div class="right">
                            	<button type="button" class="AXButton" id="ax-btn-excel"><i class="axi axi-file-excel-o"></i> 엑셀</button>
                            	<button type="button" class="AXButton" id="btn-print"><i class="axi axi-print"></i> 전표출력</button>
                            </div>
                            </div>
                        	<!-- <div class="ax-search" id="page-search2-box"></div> -->
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="파트" style="height:10px">
                                         <select id="partCode" class="AXInput"></select>
                                         <span id="deadInfo"></span>
                                    </ax:field>
                                </ax:fields>
                            </ax:form>
							<iframe id="reportDisplay" src="" style="width:99%; min-height:800px; border:none;"></iframe>


                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	deadSex: Common.getCode("TCM05")
                },
                pageStart: function(){
                	var params;
                	this.dateFormat();
                    this.search.bind();
                    this.grid.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    setTimeout(function(){
                   		fnObj.search.submit();
                    }, 500);
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
                    $("#ax-page-btn-excel").bind("click", function(){
						fnObj.excel(fnObj.pageStart.params);
                    });
                    $("#ax-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-btn-excel").bind("click", function(){
						fnObj.excel(fnObj.pageStart.params);
                    });
                    $("#btn-print").bind("click", function(){
						fnObj.print();
                    });
                },

                dateFormat: function(){
               		Date.prototype.yyyymmdd = function() {
               		  var mm = this.getMonth() + 1; // getMonth() is zero-based
               		  var dd = this.getDate();

               		  var result = [this.getFullYear(),
               		          (mm>9 ? '' : '0') + mm,
               		          (dd>9 ? '' : '0') + dd
               		         ].join('-');

               		  return result;
               		};
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
                                    	{label:"조회구분", labelWidth:"", type:"selectBox", width:"150", key:"searchKind", addClass:"", valueBoxStyle:"", value:"close", options:[],


	                                    	AXBind: {
	                                            type: "select", config: {

	                                                reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },

	                                              ajaxUrl: "/FUNE1060/search-kind-options",
	                                              ajaxPars: null,
	                                              setValue: "",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  switch (this.value) {
														case '1':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
															break;
														case '2':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
															break;

														default:
															break;
														}
														fnObj.grid.target.setData({list: []});
	                                              }
	                                            }
	                                        }
										},
                               		]
                                },

                                {display:true, addClass:"", style:"", list:[
										{label:"고인명", labelWidth:"", type:"inputText", width:"100", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
										    onChange: function(changedValue){
// 										    	_this.submit();
										    }
										}
	                            	]
	                            },

	                            {display:true, addClass:"", style:"", list:[

									{label:"발인일자", labelWidth:"", type:"inputText", width:"110", key:"balinDate", addClass:"", valueBoxStyle:"", value:"",
										AXBind:{
											type:"date", config:{
												align:"center", valign:"top",
												onChange:function(){
// 													_this.submit();
												}
											}
										}
									}

	                                ]

	                            }



                            	]
                        	});

                        setTimeout(function(){
                        	$("#"+fnObj.search.target.getItemId("balinDate")).val("");
                       		$("#"+fnObj.search.target.getItemId("deadName")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});
                       		$("#"+fnObj.search.target.getItemId("balinDate")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});

                        }, 300);


                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },

                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    params:null,
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"customerNo", label:"고객번호", width:"100", align:"left"},
                                {key:"deadName", label:"고인명", width:"100"},
                                {key:"deadSex", label:"성별", width:"80", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("deadSex", this.value);
                                }},
                                {key:"deadAge", label:"나이", width:"80", align:"center"},
                                {key:"binsoName", label:"빈소", width:"100", align:"left"}
                            ],
                            body : {//test
                                onclick: function(){
                                    // fnObj.form.setJSON(this.item);
                                    var info;

                                    info = "| 고인정보 | "+ this.item.customerNo + " | " + this.item.deadName + " | " + this.item.binsoName + " | " + $("#"+fnObj.search.target.getItemId("balinDate")).val();
                                    $("#deadInfo").html(info);

                                    var partCode = $("#partCode").val();
                                    var partName = $("#partCode option:selected").text();
                                    var params = "customerNo="+this.item.customerNo+"&partCode="+partCode+"&partName="+partName;
                                    fnObj.grid.params = "customerNo="+this.item.customerNo;
                                    fnObj.pageStart.params = "customerNo="+this.item.customerNo+"&partCode="+partCode+"&partName="+partName;
                                    fnObj.report(params);
                                }
                            }
                            /* page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/api/v1/samples/parent",
                                data: dto_list.join("&")
                            },
                            function(res) {
                                if (res.error) {
                                    alert(res.error.message);
                                } else {
                                    nextFn(); // 스크립트로 목록 제거
                                }
                            });
                        }
                    },
                    setPage: function(pageNo, searchParams){

                    	var _target = this.target;
                        this.pageNo = pageNo;

                        var searchKind = Common.search.getValue(fnObj.search.target, "searchKind");

                        if(searchKind == '2'
                    			&& $("#"+fnObj.search.target.getItemId("deadName")).val() == ''
								&& $("#"+fnObj.search.target.getItemId("balinDate")).val() == ''){
                    		alert("고인명 또는 발인일자를 입력해 주세요.");
                    		return;
                    	}

                        var url = "/FUNE1060/dead";
                        if(searchKind == '1'){
                        	url = "/FUNE1060/assignedDead";
                        }

                        app.ajax({
                            type: "GET",
                            url: url,
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
                                };
                                _target.setData(gridData);
                                var customerNo = "${param.customerNo}";
                                for(var i=0; i<_target.list.length; i++){
                                	if(_target.list[i].customerNo == customerNo){
                                		Common.grid.setFocus(_target, i);
                                	}
                                }
                            }
                        });
                    }
                },
                draw: {
                	template: {
                		deleteKeywords: function(str){
							return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
						}
                		, stmt: function(){
							var s = Ez.s;
							var str = [];
							str.push(s.start+s.align.left+s.font.size("21")+"[binsoName]		"+s.font.size("01")+"([partName])"+s.br);
							str.push("고 인 명 : [deadName]");
							str.push("상 주 명 : [applName]");
							str.push("거래일자 : "+new Date().print("yyyy년mm월dd일"));
							str.push("----------------------------------------------");
							str.push("순  번 품            목 수량 단   가 금     액");
							str.push("----------------------------------------------");
							str.push("[saleStmtBd]");
							str.push("----------------------------------------------");
							str.push(s.align.right+"합  계 : [amount]");
							str.push("누  계 : [totalAmount]");
							str.push(s.align.left);
							str.push(s.font.size("21")+"배 달 자 :");
							str.push(s.font.size("01"));
							str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
							str.push(s.br);
							str.push(s.cutting+s.br);

							return str.join(s.br);
						}
						, stmt2: function(){

							var s = Ez.s;
							var str = [];

							str.push(s.start+s.align.left+s.font.size("21")+"[binsoName]		"+s.font.size("01")+"([partName])"+s.br);
							str.push("고 인 명 : [deadName]");
							str.push("상 주 명 : [applName]");
							str.push("거래일자 : "+new Date().print("yyyy년mm월dd일"));
							str.push("----------------------------------------------");
							str.push("순  번 품            목 수량 단   가 금     액");
							str.push("----------------------------------------------");
							str.push("[saleStmtBd]");
							str.push("----------------------------------------------");
							str.push(s.align.right+"합  계 : [amount]");
							str.push("누  계 : [totalAmount]");
							str.push(s.align.left);
							str.push(s.font.size("21")+"상주확인 :"+s.br);
							str.push("배 달 자 :");
							str.push(s.font.size("01"));
							str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
							str.push(s.br);
							str.push(s.cutting+s.br);

							return str.join(s.br);
						}
                	}
                	, drawStmt: function(funeral, saleStmt){

						var template = fnObj.draw.template.stmt();

						var list = saleStmt.saleStmtBd;
						var s = Ez.s;
						var str = [];

						$.each(list, function(i, o){
							var idx = (i+1);
							if(i==0){
								idx = s.lpad((saleStmt.billNo || ""), "0", 3) + "/" + s.lpad(idx+"", "0", 2)
							}else{
								idx = s.lpad(idx+"", "0", 2);
							}
							str.push(
									s.lpad(idx, " ", 6)
									+s.rpad(" "+o.item.itemName, " ", 17)
									+s.lpad(o.qty+"", " ", 5)
									+s.lpad(o.price.money()+"", " ", 8)
									+s.lpad(o.tamount.money()+"", " ", 9)
									);
						});

						var totalAmount = 0;
						$.each(saleStmt.all, function(i, o){
							totalAmount+=+o.tamount;
						})

						for(var i=0; i<2; i++){
							template = template.replace("[partName]", $("#partCode").bindSelectGetValue().optionText);
							template = template.replace("[binsoName]", funeral.binso.binsoName);
							template = template.replace("[deadName]", funeral.thedead.deadName);
							template = template.replace("[applName]", funeral.applicant.applName);
							template = template.replace("[saleStmtBd]", str.join(s.br));

							template = template.replace("[amount]", (saleStmt.amount||0).money()+" ");
							template = template.replace("[totalAmount]", (totalAmount||0).money()+" ");
						}

						template = fnObj.draw.template.deleteKeywords(template);

						return template;
					}
					, drawStmt2: function(funeral, saleStmt){

						var template = fnObj.draw.template.stmt2();

						var list = saleStmt.saleStmtBd;
						var s = Ez.s;
						var str = [];

						$.each(list, function(i, o){
							var idx = (i+1);
							if(i==0){
								idx = s.lpad((saleStmt.billNo || ""), "0", 3) + "/" + s.lpad(idx+"", "0", 2)
							}else{
								idx = s.lpad(idx+"", "0", 2);
							}
							str.push(
									s.lpad(idx, " ", 6)
									+s.rpad(" "+o.item.itemName, " ", 17)
									+s.lpad(o.qty+"", " ", 5)
									+s.lpad(o.price.money()+"", " ", 8)
									+s.lpad(o.tamount.money()+"", " ", 9)
									);
						});

						var totalAmount = 0;
						$.each(saleStmt.all, function(i, o){
							totalAmount+=+o.tamount;
						})

						for(var i=0; i<2; i++){
							template = template.replace("[partName]", $("#partCode").bindSelectGetValue().optionText);
							template = template.replace("[binsoName]", funeral.binso.binsoName);
							template = template.replace("[deadName]", funeral.thedead.deadName);
							template = template.replace("[applName]", funeral.applicant.applName);
							template = template.replace("[saleStmtBd]", str.join(s.br));

							template = template.replace("[amount]", (saleStmt.amount||0).money()+" ");
							template = template.replace("[totalAmount]", (totalAmount||0).money()+" ");
						}

						template = fnObj.draw.template.deleteKeywords(template);

						return template;
					}
                },
                print: function(){

                	var item = fnObj.grid.target.getSelectedItem();

					if(item.error){
						alert("고인을 선택해 주세요.");
						return;
					}

					var customerNo = item.item.customerNo
					var partCode = $("#partCode").bindSelectGetValue().optionValue
					var partName = $("#partCode").bindSelectGetValue().optionText
					// print
					var receiptWin = window.open(`/receipt/saleStmt/all?customerNo=\${customerNo}&partCode=\${partCode}&partName=\${partName}&auto=Y`, "_blank", "width=310,height=600");

				},

                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });
                        app.ajax({
                        	url:"/FUNE1060/part",
                        	type:"POST"

                        }, function(res){
                        	$("#partCode").bindSelect({
                        		options: res.list
                        		, reserveKeys: {
                                    options: "list",
                                    optionValue: "partCode",
                                    optionText: "partName"
                                }
                                , onChange: function(){
                                	var partCode = $("#partCode").bindSelectGetValue()
                                	var item = fnObj.grid.target.getSelectedItem().item;
                                    var params = "customerNo="+item.customerNo+"&partCode="+partCode.optionValue+"&partName="+partCode.optionText;
                                    fnObj.report(params);
                                }
                            	, setValue: "${param.partCode}"
                            });

                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-key').attr("readonly", "readonly");

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
                }, // form

                report: function(params){
                	var path = "/reports/changwon/fune/FUNE1061";
                	var output = "pdf";
                	var frameId = "reportDisplay";
                	Common.report.embedded(path, output, params, frameId);
                },

                excel: function(params){
                	var path = "/reports/changwon/fune/FUNE1061";
                	var output = "excel";
                	Common.report.go(path, output, params);
                }


            };
        </script>
    </ax:div>
</ax:layout>