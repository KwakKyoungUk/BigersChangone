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
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> ${PAGE_NAME}</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>
              <!--   <iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe> -->
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
                	"deadSex": Common.getCode("TCM05"),
                	"deadReason": Common.getCode("TCM03"),
                	"deadPlace": Common.getCode("TCM09"),
                	"addrPart": Common.getCode("TCM10"),
                	"applRelation": Common.getCode("TCM08"),
                	"scatterPlace": Common.getCode("TMC06"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    this.grid.bind();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("STAT1061", fnObj.grid.target);
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
               						{label:"일자", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
                                ]},
                                {display:true, addClass:"", style:"", list:[
               						{label:"자료구분", labelWidth:"", type:"selectBox", width:"150", key:"objt", addClass:"secondItem", valueBoxStyle:"", value:"",
               							options:[
											{optionValue:"", optionText:"전체"},
											{optionValue:"0", optionText:"화장(대인)"},
											{optionValue:"1", optionText:"화장(소인)"},
											{optionValue:"2", optionText:"화장(사태)"},
											{optionValue:"3", optionText:"화장(개장)"},
											{optionValue:"4", optionText:"화장(대+소)"},
											{optionValue:"5", optionText:"봉안(대인)"},
											{optionValue:"6", optionText:"봉안(소인)"},
											{optionValue:"7", optionText:"봉안(개장)"},
											{optionValue:"8", optionText:"봉안(대+소)"},
											{optionValue:"9", optionText:"화봉(대인)"},
											{optionValue:"10", optionText:"화봉(소인)"},
											{optionValue:"11", optionText:"화봉(개장)"},
											{optionValue:"12", optionText:"화봉(대+소)"},
               							],
	               						AXBind:{
	               							type:"select", config:{

	               								onChange:function(){

	               								}
	               							}
	               						},
               							onChange: function(){}
               						},
               						{label:"감면구분", labelWidth:"", type:"selectBox", width:"100", key:"dcGubunNm", addClass:"", valueBoxStyle:"", value:"",
 										options:[{optionValue:"", optionText:"전체"},{optionValue:"일반", optionText:"일반"},{optionValue:"감면", optionText:"감면"}],
        									onChange:function(){}
                					},
                					{label:"", labelWidth:"", type:"selectBox", width:"100", key:"dcGubun", addClass:"", valueBoxStyle:"", value:"",
 										options:[{optionValue:"", optionText:""}
 										,{optionValue:"유공", optionText:"유공자"}
 										,{optionValue:"수급", optionText:"수급자"}
 										,{optionValue:"행려", optionText:"행려자"}
 										,{optionValue:"무연", optionText:"무연고"}
 										],
        									onChange:function(){}
                					},
               						{label:"국적구분", labelWidth:"", type:"selectBox", width:"100", key:"nationGb", addClass:"", valueBoxStyle:"", value:"", options:[],
               							onChange: function(){},
	               						AXBind:{
	               							type:"select", config:{
	               								reserveKeys:{
	               									options:"list",
	               									optionValue:"code",
	               									optionText:"name"
	               								},
	               								ajaxUrl:"/stat1060/location_gubun",
	               								ajaPars:"",
	               								isspace: true, isspaceTitle: "전체",
	               								onChange:function(){

	               								}
	               							}
	               						}
               						},
               						{label:"시도,구군", labelWidth:"", type:"inputText", width:"70", key:"sido", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
               						{label:"주민번호", labelWidth:"", type:"selectBox", width:"70", key:"jumin", addClass:"", valueBoxStyle:"", value:"",
               							options:[
											{optionValue:"0", optionText:"숨김"},
											{optionValue:"1", optionText:"열람"}
               							],
	               						AXBind:{
	               							type:"select", config:{

	               								onChange:function(){

	               								}
	               							}
	               						},
               							onChange: function(){},
               						}
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"cremDate", label:"접수연월일", width:"100", align:"center"},
                                {key:"cremTime", label:"시간", width:"60", align:"center"
                                },
                                {key:"cremNo", label:"접수번호", width:"100", align:"center"},
                                {key:"gubun", label:"구분", width:"60", align:"center"},
                                {key:"deadName", label:"사망자(부모)", width:"100", align:"center"},
                                {key:"deadJumin", label:"주민등록번호", width:"100", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadSex", label:"성별", width:"60", align:"center"
                                	, formatter: function(){
                                		return Common.grid.codeFormatter("deadSex",this.value);
                                	}
                                },
                                {key:"objtName", label:"대소", width:"60", align:"center"},
                                {key:"dcGubunNm", label:"감면여부", width:"80", align:"center"},
                                {key:"dcName", label:"감면구분", width:"80", align:"center"},
                                {key:"yugongDetail", label:"감면사유", width:"100", align:"left"},
                                {key:"deadReason", label:"사망의종류", width:"100", align:"center"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("deadReason",this.value);
                            		}
                                },
                                {key:"deadPlace", label:"사망장소", width:"100", align:"left"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("deadPlace",this.value);
                            		}
                                },
                                {key:"addrPart", label:"관내외", width:"60", align:"center"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("addrPart",this.value);
                            		}
                                },
                                {key:"transferDate", label:"주민등재일", width:"100", align:"center"},
                                {key:"company", label:"발인지", width:"150", align:"left"},
                                {key:"kind", label:"결제", width:"60", align:"left"},
                                {key:"etDate", label:"수납연월일", width:"100", align:"center"},
                                {key:"deadAddr", label:"사망자주소", width:"600", align:"left"},
                                {key:"deadDate", label:"사망연월일", width:"100", align:"center"},
                                {key:"anchDate", label:"화장봉안일", width:"100", align:"center"},
                                {key:"burnNo", label:"호기", width:"60", align:"right"},
                                {key:"burnChasu", label:"시간", width:"200", align:"left"},
                                {key:"ensNo", label:"안치호수", width:"100", align:"center"},
                                {key:"natNo", label:"자연장위치", width:"100", align:"center"},
                                {key:"strDate", label:"안치(부터-", width:"100", align:"center"},
                                {key:"endDate", label:"까지)", width:"100", align:"center"},
                                {key:"applName", label:"납부자", width:"100", align:"left"},
                                {key:"applJumin", label:"주민등록번호", width:"100", align:"left"},
                                {key:"applAddr", label:"주 소", width:"600", align:"left"},
                                {key:"applTelNo", label:"전화번호", width:"100", align:"left"},
                                {key:"applRelation", label:"관계", width:"100", align:"left"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("applRelation",this.value);
                            		}
                                },
                                {key:"hwaCharge", label:"화장사용료", width:"100", align:"right"
                                	, formatter: function(){
                            			return this.value.money();
                            		}
                                },
                                {key:"enshCharge", label:"봉안사용료", width:"100", align:"right"
                                	, formatter: function(){
                            			return this.value.money();
                            		}
                                },
                                {key:"mngCharge", label:"봉안관리비", width:"100", align:"right"
                                	, formatter: function(){
                            			return this.value.money();
                            		}
                                },
                                {key:"natuCharge", label:"자연장금액", width:"100", align:"right"
                                	, formatter: function(){
                            			return this.value.money();
                            		}
                                },
                                {key:"tot", label:"합계", width:"100", align:"right"
                                	, formatter: function(){
                        			return (this.item.hwaCharge+this.item.enshCharge+this.item.mngCharge+this.item.natuCharge).money();
                        			}
                                },
                                {key:"scatterPlace", label:"유골안치장소", width:"100", align:"left"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("scatterPlace",this.value);
                            		}
                                },
                                {key:"bunmanwol", label:"분만주수", width:"60", align:"right"},
                                {key:"sido", label:"시도", width:"100", align:"left"},
                                {key:"userNm", label:"입력자", width:"100", align:"left"},

                            ],
                            body : {

                            },
                            foot: {
                                rows: [
                                    [
                                        {
                                            colSeq: null, colspan : 31, formatter: function () {
                                            return "계";
                                       		}, align: "center", valign: "middle"
                                        },
                                        {
                                            colSeq: 32, formatter: function () {

                                            return this.list.length+"건";
                                        	}
                                        },
                                        {
                                            colSeq: 33, formatter: function () {
                                            	  var sum = 0;
                                            	  $.each(this.list, function(){
                                                      sum += this.hwaCharge;
                                                  });
                                                  return sum.money();
                                        	}, align:"right"
                                        },
                                        {
                                            colSeq: 34, formatter: function () {
                                            	  var sum = 0;
                                            	  $.each(this.list, function(){
                                                      sum += this.enshCharge;
                                                  });
                                                  return sum.money();
                                       		}, align:"right"
                                        },
                                        {
                                        	colSeq: 35, formatter: function () {
                                          	  var sum = 0;
                                          	  $.each(this.list, function(){
                                                    sum += this.mngCharge;
                                                });
                                                return sum.money();
                                     		}, align:"right"
                                        },
                                        {
                                        	colSeq: 36, formatter: function () {
                                          	  var sum = 0;
                                          	  $.each(this.list, function(){
                                                    sum += this.natuCharge;
                                                });
                                                return sum.money();
                                     		}, align:"right"
                                        },
                                        {
                                        	colSeq: 37, formatter: function () {
                                          	  var sum = 0;
                                          	  $.each(this.list, function(){
                                                    sum += this.hwaCharge+this.enshCharge+this.mngCharge+this.natuCharge;
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
                             url: "/stat1060/getList",
                             data:  (searchParams||fnObj.search.target.getParam())
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {

                            	 var gridData = {
                                         list: (function(){
                                        	return res.list;
                                         }()),
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