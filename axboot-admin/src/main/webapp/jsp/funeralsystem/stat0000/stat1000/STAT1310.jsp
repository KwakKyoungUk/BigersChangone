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
                    // ????????? ?????? ??? ?????? ?????? ???????????? (option)
//                     this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("STAT1311", fnObj.grid.target);
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
                                // ????????? ???????????? ???????????? submit ????????? ?????? ?????? ?????? ?????????.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"??????", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
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
               						{label:"????????????", labelWidth:"", type:"selectBox", width:"70", key:"jumin", addClass:"", valueBoxStyle:"", value:"",
               							options:[
											{optionValue:"0", optionText:"??????"},
											{optionValue:"1", optionText:"??????"}
               							],
	               						AXBind:{
	               							type:"select", config:{

	               								onChange:function(){

	               								}
	               							}
	               						},
               							onChange: function(){},
               						},
                                ]},                                
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
                                //{key:"index", label:"??????", width:"35", align:"center", formatter:"checkbox"},
                                {key:"cremDate", label:"???????????????", width:"100", align:"center"},
                                {key:"gubun", label:"??????", width:"60", align:"center"},
                                {key:"deadName", label:"?????????", width:"100", align:"center"},
                                {key:"deadJumin", label:"??????????????????", width:"100", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadSex", label:"??????", width:"60", align:"center"                                	 
                                },
                                {key:"objtName", label:"??????", width:"60", align:"center"},
                                {key:"dcGubunNm", label:"????????????", width:"80", align:"center"},
                                {key:"dcName", label:"????????????", width:"80", align:"center"},
                                {key:"yugongDetail", label:"????????????", width:"100", align:"left"},
                                {key:"addrPart", label:"?????????", width:"60", align:"center"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("addrPart",this.value);
                            		}
                                },
                                {key:"deadAddr", label:"???????????????", width:"600", align:"left"},
                                {key:"deadDate", label:"???????????????", width:"100", align:"center"},
                                {key:"burnNo", label:"??????", width:"60", align:"right"},
                                {key:"cremTime", label:"??????", width:"60", align:"center"},
                                {key:"cremNo", label:"????????????", width:"100", align:"center"},
                                {key:"applName", label:"?????????", width:"100", align:"left"},
                                {key:"applAddr", label:"??? ???", width:"600", align:"left"},
                                {key:"applTelNo", label:"????????????", width:"100", align:"left"},
                                {key:"applRelation", label:"??????", width:"100", align:"left"
                                	, formatter: function(){
                            			return Common.grid.codeFormatter("applRelation",this.value);
                            		}
                                },
                                {key:"hwaCharge", label:"???????????????", width:"100", align:"right"
                                	, formatter: function(){
                            			return this.value.money();
                            		}
                                },
                                {key:"kind", label:"??????", width:"60", align:"left"},
                            ],
                            body : {

                            },
                            foot: {
                                rows: [
                                    [
                                        {
                                            colSeq: null, colspan : 31, formatter: function () {
                                            return "???";
                                       		}, align: "center", valign: "middle"
                                        },
                                        {
                                            colSeq: 32, formatter: function () {

                                            return this.list.length+"???";
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
                             url: "/stat1310/getList",
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