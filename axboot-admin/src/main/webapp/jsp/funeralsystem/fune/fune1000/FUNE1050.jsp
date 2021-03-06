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

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
				{id:"page-grid-box", adjust:-85}                   
            ];

            var fnObj = {
                CODES: {
                    "deadRelation": Common.getCode("TCM08"),
                    "dcGubun": Common.getCode("TCM12"),
                    "addrPart": Common.getCode("TCM10"),
                    "deadSex": Common.getCode("TCM05"),
                    "deadPlace": Common.getCode("TCM09"),
                    "usedSangjo": Common.getCode("503"),
                    "funeralCarCompany": Common.getCode("507"),
                    "deadReason": Common.getCode("TCM03"),
                    "deadFaith": Common.getCode("TCM06"),
                    "deadReason": Common.getCode("TCM03"),
                    "embalmingGubun": Common.getCode("108"),
                    "funeralGubun": Common.getCode("107"),
                    "ibkwanFlg": Common.getCode("121"),
                    "transferCarCompany": Common.getCode("506"),
                    "addrCode": Common.addr.getAddrCode(),

      		         "deadReasonB": (function(){
      	            	var result;
      		            	app.ajax({
      		            			async: false,
      		                        type: "GET",
      		                        url: "/api/v1/basicCodes/deadReasonB",
      		                        data: ""
      		                    },
      		                    function(res){
      		                    	result = res.list;
      		                	}
      		                );
      		            	return result;
      		         }()),

                },
                pageStart: function(){
                	this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // ????????? ?????? ??? ?????? ?????? ???????????? (option)
                    //this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("FUNE1051", fnObj.grid.target);
                    });

                    $("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	_this.search.submit();
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
                                // ????????? ???????????? ???????????? submit ????????? ?????? ?????? ?????? ?????????.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
            						{label:"??????????????????", labelWidth:"100", type:"selectBox", width:"", key:"code", addClass:"", valueBoxStyle:"", value:"", options:[],
               							AXBind:{
            								type:"select", config:{
            									reserveKeys: {
                                                    options: "list",
                                                    optionValue: "code",
                                                    optionText: "name"
                                                },
            									ajaxUrl:"/FUNE1050/basiccode",
            									ajaxPars:null,
            									setValue:"",
            									onChange:function(){
            										//toast.push(Object.toJSON(this));

            									}
            								}
            							}
            						},
            						{label:"????????????", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){
               										//fnObj.grid.setPage();
               									}
               								}
               							}
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
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            //height : 650,
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                            	{key:"index", label:" ", width:"50", align:"center"
                            		, formatter:function(){
											return this.index+1;
                                	}
                            	},
                                //{key:"date", label:"??????(??????)??????", width:"100", align:"left"},

                                {key:"customerNo", label:"????????????", width:"100"},
                                {key:"balinDate", label:"????????????", width:"130" },
                                {key:"deadName", label:"?????????", width:"80" },
                                {key:"deadJumin", label:"??????????????????", width:"130"  , display:true},
                                {key:"binsoName", label:"?????????", width:"80"},
                                {key:"addBinso", label:"????????????", width:"80", display:false},
                                {key:"deadSex", label:"??????", width:"60" },
                                {key:"deadAge", label:"??????", width:"60" },
                                {key:"applName", label:"?????????", width:"80" },
                                {key:"anchiRoom", label:"?????????", width:"80" },
                                {key:"anchiDate", label:"????????????", width:"130" },
                                {key:"ibkwanDate", label:"????????????", width:"130" },
                                {key:"deadDate", label:"????????????", width:"100", align:"left", display:false},
                                {key:"jangji", label:"??????", width:"150" },
                                {key:"deadAddr", label:"????????????", width:"150" },
                                {key:"dcGubun", label:"??????", width:"150"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("dcGubun",this.value);
                                	}
                                },

                                {key:"deadPost", label:"??????????????????", width:"100"  , display:false},
                                {key:"deadFaithNm", label:"??????", width:"100"  , display:false},
                                {key:"applRelation", label:"?????????????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadRelation", this.value);
                                	}
                                },
                                {key:"applRelationNm", label:"????????????????????? ??????", width:"100"  , display:false},
                                {key:"familyClan", label:"??????", width:"80"  , display:false},
                                {key:"remark", label:"??????", width:"150"  , display:false},
                                {key:"deadReason", label:"????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadReason",this.value);
                                	}
                                },
                                {key:"deadReasonNm", label:"??????????????????", width:"150"  , display:false},
                                {key:"deadPlace", label:"????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadPlace", this.value);
                                	}
                                },
                                {key:"deadPlaceNm", label:"???????????? ??????", width:"100"  , display:false},
                                {key:"usedSangjo", label:"??????????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("usedSangjo", this.value);
                                	}
                                },
                                {key:"sangjoRemark", label:"????????????", width:"100"  , display:false},
                                {key:"applBirth", label:"??????????????????", width:"100"  , display:false},
                                {key:"telNo", label:"???????????????1", width:"150"  , display:false},
                                {key:"mobileNo", label:"???????????????2", width:"150"  , display:false},
                                {key:"applPost", label:"??????????????????", width:"100"  , display:false},
                                {key:"applAddr", label:"????????????", width:"300"  , display:false},
                                {key:"lastFlg", label:"??????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return this.value == 1 ? "??????" : "??????"
                                	}
                                },
                                {key:"embalmingGubun", label:"??????????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("embalmingGubun", this.value);
                                	}
                                },
                                {key:"ibkwanFlg", label:"????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("ibkwanFlg", this.value);
                                	}
                                },
                                {key:"transferCarCompany", label:"??????????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("transferCarCompany", this.value);
                                	}
                                },
                                {key:"ibkwanGubun", label:"????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("embalmingGubun", this.value);
                                	}
                                },
                                {key:"ibsilDate", label:"????????????", width:"100"  , display:false},
                                {key:"funeralGubun", label:"????????????", width:"100"  , display:true
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralGubun", this.value);
                                	}
                                },
                                {key:"funeralCarCompany", label:"??????????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralCarCompany", this.value);
                                	}
                                },
                                {key:"deadDocGubun", label:"?????????????????????", width:"100"  , display:false
                                },
                                {key:"deadDocno", label:"??????????????????????????????", width:"150"  , display:false },
                                {key:"deadDocnm", label:"??????????????????????????????", width:"150"  , display:false},
                                {key:"cadillacCompany", label:"???????????????", width:"150"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralCarCompany", this.value);
                                	}
                                },
                                {key:"dcCode", label:"???????????????", width:"100"  , display:false
                                	, formatter:function(val){
                                		if(this.value == "000"){
                                			return "??????";
                                		}else if(this.value =="001"){
                                			return "??????1?????????";
                                		}else{
                                			return "??????1?????????";
                                		}
                                	}
                                },
                                {key:"dcRemark", label:"????????????", width:"150"  , display:false
                                },

                                {key:"liveName01", label:"??????(?????????)1", width:"150"  , display:false
                                },
                                {key:"liveName02", label:"??????(?????????)2", width:"150"  , display:false
                                },
                            ],
                            /* body : {
                                onclick: function(){
                                	//return false;
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                }
                            }, */
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
                             url: "/FUNE1050/getFuneralDetail",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
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
                }
            };
        </script>
    </ax:div>
</ax:layout>