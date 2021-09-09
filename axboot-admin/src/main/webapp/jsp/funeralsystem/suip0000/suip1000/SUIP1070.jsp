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
                    	<button type="button" class="AXButton" id="btn-calcSuip"><i class="axi axi-plus-circle"></i> 집계</button>
                    	<%-- <button type="button" class="AXButton" id="btn-reportSUIP1092"><i class="axi axi-plus-circle"></i> 인쇄</button> --%>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div id="div-grid-suipsum"></div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
	        var resize_elements = [
	        	{id:"div-grid-suipsum", adjust:-130}
	        ];
            var fnObj = {
                CODES: {
                	gubunCd: Common.getCodeByUrl("/SUIP1060/code/gubunCd")
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
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
                			$("#ax-page-btn-search").bind("click", fnObj.eventFn.search);
                			$("#ax-page-btn-save").attr("id", "btn-save");
                			$("#btn-save").prop("disabled", true);
                			$("#ax-page-btn-fn2").html("고지서");
//                 			$("#ax-page-btn-fn2").prop("disabled", true);
                			$("#ax-page-btn-fn2").attr("id", "btn-reportSUIP1071");

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
                		app.ajax({
                            type: "GET",
                            url: "/SUIP1070/suipsum",
                            data: fnObj.search.target.getParam()
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var totalRow = {};

                        		$.each(res.map.suipsumDay, function(i, o){
                        			for(var key in o){
                        				if(isNaN(+o[key])){
                        					continue;
                        				}
                        				if(!totalRow[key]){
                        					totalRow[key] = 0;
                        				}
                        				totalRow[key] += o[key];
                        			}
                        		});
                        		totalRow.sumdate = " ";
                        		totalRow.sdate = "총계";

                        		fnObj.grid.target.setData({list: [totalRow].concat(res.map.suipsumDay)});
                        		$("#btn-save").prop("disabled", true);
                        	}
                        });
                	}
                	, save: function(){
                		fnObj.save();
                	}
                	, calcSuip: function(){
                		fnObj.search.submit();
                	}
                	, reportSUIP1071: function(){
                		app.ajax({
                            type: "GET",
                            url: "/SUIP1070/allocr?"+fnObj.search.target.getParam(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								// 고지서 출력부
								var parameters = [];

								$.each(res.list, function(i, o){
									app.ajax({
			                            type: "GET",
			                            url: "/SUIP1070/ocrband",
			                            data: "allocrId="+o
			                        },
			                        function(res2){
			                        	if(res2.error){
			                        		alert(res2.message);
			                        	}else{
											var ocrband = res2.map.ocrband;

											parameters.push({path: "/reports/changwon/suip/SUIP1062", parameter: "allocrId="+o+"&ocrband="+ocrband})

											if(res.list.length == parameters.length){
// 												Common.report.mergePdfReport(parameters);
												Common.report.printMergePdfReport(parameters);
											}

			                        	}
			                        });
								})

                            }
                        });
                	}
                	, reportSUIP1092 : function(){

                		app.ajax({
                            type: "GET",
                            url: "/SUIP1070/suipsum?"+fnObj.search.target.getParam(),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{

                        		var suipsumOcrPart = res.map.suipsumOcrPart;
                        		var suetc = res.suetc;
                        		var ocrPart = [];
        						var gubunCd = [];
        						var parameters = [];
                        		var suipSumDay = [];

                        		for(var i=0; i<suipsumOcrPart.length; i++){
    								if(suipsumOcrPart[i].ocrPart == "03"){
    									ocrPart.push("03");
    								}else{
    									ocrPart.push("00");
    								}
    							}

        						$.each(ocrPart, function(key, value){
        							if($.inArray(value, suipSumDay) === -1) {
        								suipSumDay.push(value);
        							}
        						});

        						$.each(suipSumDay, function(i,o){
                      				parameters.push({path: "/reports/changwon/suip/SUIP1092", parameter: fnObj.search.target.getParam()+"&ocrPart="+o+"&printName="+'${LOGIN_USER_ID}'})
                   				});

		              			parameters.push({path: "/reports/changwon/suip/SUIP1093", parameter: fnObj.search.target.getParam()+"&printName="+'${LOGIN_USER_ID}'});

		              			Common.report.mergePdfReport(parameters);
                        	}
                        });


					}
                },
                save: function(){
                	if(!confirm("집계자료를 저장하시겠습니까?")){
                		return;
                	}
                	app.ajax({
                        type: "PUT",
                        url: "/SUIP1070/calc",
                        data: Object.toJSON(fnObj.grid.target.list.slice(1))
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                    		toast.push("저장되었습니다.");
                    		$("#btn-reportSUIP1071").prop("disabled", false);
                    		$("#btn-save").prop("disabled", true);
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
               						{label:"집계일자", labelWidth:"", type:"inputText", width:"90", key:"sumdate", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							onChange: function(val){
               								var from;
       										var to = val.date().add(-1).print();
       										if(val.date().getDay() == 1){
       											from = val.date().add(-3).print();
       										}else{
       											from = val.date().add(-1).print();
       										}
       										$("#"+_this.target.getItemId("sfrom")).val(from);
       										$("#"+_this.target.getItemId("sto")).val(to);
               							},
               							AXBind:{
               								type:"date", config:{
               									align:"right", valign:"top",
               									alwaysOnChange: true,
               									onChange:function(){
               									}
               								}
               							}
               						},
               						{label:"수입일자", labelWidth:"", type:"inputText", width:"70", key:"sfrom", addClass:"secondItem", valueBoxStyle:"", value:new Date().add(-1).print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"sto", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().add(-1).print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"sfrom",
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
                            targetID : "div-grid-suipsum",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"sdate", label:"수입일자", width:"120", align:"center", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.value
                                		, "현금"
                                		, "카드"
                                		]);
                                }},
                                {key:"tot", label:"계", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		(this.item.cremTot||0)
                                			+(this.item.enshTot||0)
                                			+(this.item.enshextTot||0)
                                			+(this.item.natTot||0)
                                			+(this.item.funeTot||0)
                                			+(this.item.funevTot||0)
                                			+(this.item.ensmTot||0)
                                			+(this.item.vdTot||0)
                                			+(this.item.mngTot||0)
                                			+(this.item.mrptTot||0)
                                			+(this.item.duesTot||0)
                                			+(this.item.japTot||0)
                                			+(this.item.fgTot||0)
                                		, (this.item.cremcash||0)
	                                		+(this.item.enshcash||0)
	                            			+(this.item.enshextcash||0)
	                            			+(this.item.natcash||0)
	                            			+(this.item.funecash||0)
	                            			+(this.item.funevcash||0)
	                            			+(this.item.ensmcash||0)
	                            			+(this.item.vdcash||0)
	                            			+(this.item.mngcash||0)
	                            			+(this.item.mrptcash||0)
	                            			+(this.item.duescash||0)
	                            			+(this.item.japcash||0)
	                            			+(this.item.fgcash||0)
                                		, (this.item.cremcd||0)
                                			+(this.item.enshcd||0)
                                			+(this.item.enshextcd||0)
                                			+(this.item.natcd||0)
                                			+(this.item.funecd||0)
                                			+(this.item.funevcd||0)
                                			+(this.item.ensmcd||0)
                                			+(this.item.vdcd||0)
                                			+(this.item.mngcd||0)
                                			+(this.item.mrptcd||0)
                                			+(this.item.duescd||0)
                                			+(this.item.japcd||0)
                                			+(this.item.fgcd||0)
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"crem", label:"화장사용료", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.cremTot
                                		, this.item.cremcash
                                		, this.item.cremcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"ensh", label:"봉안사용료(신규)", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.enshTot
                                		, this.item.enshcash
                                		, this.item.enshcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"enshext", label:"봉안사용료(재연장)", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.enshextTot
                                		, this.item.enshextcash
                                		, this.item.enshextcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"nat", label:"자연장사용료", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.natTot
                                		, this.item.natcash
                                		, this.item.natcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"funev", label:"장례식장", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.funeTot+this.item.funevTot
                                		, this.item.funecash+this.item.funevcash
                                		, this.item.funecd+this.item.funevcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"vd", label:"자동판매기임대료", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.vdTot
                                		, this.item.vdcash
                                		, this.item.vdcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"mng", label:"관리비", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.mngTot
                                		, this.item.mngcash
                                		, this.item.mngcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"mrpt", label:"이통중계기<br/>설치임대료", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.mrptTot
                                		, this.item.mrptcash
                                		, this.item.mrptcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"dues", label:"공과금", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.duesTot
                                		, this.item.duescash
                                		, this.item.duescd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"jap", label:"잡수입", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.japTot
                                		, this.item.japcash
                                		, this.item.japcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"fg", label:"장례식장<br/>화원임대료", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.fgTot
                                		, this.item.fgcash
                                		, this.item.fgcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                                {key:"ensm", label:"봉안관리비", width:"120", align:"right", formatter: function(){
                                	return Common.grid.getDivRowValues([
                                		this.item.ensmTot
                                		, this.item.ensmcash
                                		, this.item.ensmcd
                                		], function(value){
                                		return value ? value.money() : 0;
                                	});
                                }},
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.setJSON(this.item);
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
                            url: "/SUIP1070/calc",
                            data: searchParams||fnObj.search.target.getParam()
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var list = $.map(res.list, function(item){
                        			if(!item.sumdate){
                        				item.sumdate = Common.search.getValue(fnObj.search.target, "sumdate");
                        			}
                        			return item;
                        		})
                        		var totalRow = {};

                        		$.each(list, function(i, o){
                        			for(var key in o){
                        				if(isNaN(+o[key])){
                        					continue;
                        				}
                        				if(!totalRow[key]){
                        					totalRow[key] = 0;
                        				}
                        				totalRow[key] += o[key];
                        			}
                        		});
                        		totalRow.sumdate = " ";
                        		totalRow.sdate = "총계";

                        		fnObj.grid.target.setData({list: [totalRow].concat(list)});
                        		$("#btn-save").prop("disabled", false);
                            }
                        });
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>