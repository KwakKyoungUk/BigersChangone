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
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
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
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
            						{label:"조회일자구분", labelWidth:"100", type:"selectBox", width:"", key:"code", addClass:"", valueBoxStyle:"", value:"", options:[],
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
            						{label:"조회기간", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"", valueBoxStyle:"", value:new Date().print(),
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
                                //{key:"date", label:"발인(안치)일자", width:"100", align:"left"},

                                {key:"customerNo", label:"고객번호", width:"100"},
                                {key:"balinDate", label:"발인일시", width:"130" },
                                {key:"deadName", label:"고인명", width:"80" },
                                {key:"deadJumin", label:"고인주민번호", width:"130"  , display:true},
                                {key:"binsoName", label:"빈소명", width:"80"},
                                {key:"addBinso", label:"추가빈소", width:"80", display:false},
                                {key:"deadSex", label:"성별", width:"60" },
                                {key:"deadAge", label:"나이", width:"60" },
                                {key:"applName", label:"상주명", width:"80" },
                                {key:"anchiRoom", label:"안치실", width:"80" },
                                {key:"anchiDate", label:"안치일시", width:"130" },
                                {key:"ibkwanDate", label:"입관일시", width:"130" },
                                {key:"deadDate", label:"사망일자", width:"100", align:"left", display:false},
                                {key:"jangji", label:"장지", width:"150" },
                                {key:"deadAddr", label:"고인주소", width:"150" },
                                {key:"dcGubun", label:"감면", width:"150"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("dcGubun",this.value);
                                	}
                                },

                                {key:"deadPost", label:"고인우편번호", width:"100"  , display:false},
                                {key:"deadFaithNm", label:"직위", width:"100"  , display:false},
                                {key:"applRelation", label:"사망자와의관계", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadRelation", this.value);
                                	}
                                },
                                {key:"applRelationNm", label:"사망자와의관계 메모", width:"100"  , display:false},
                                {key:"familyClan", label:"본관", width:"80"  , display:false},
                                {key:"remark", label:"비고", width:"150"  , display:false},
                                {key:"deadReason", label:"사망원인", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadReason",this.value);
                                	}
                                },
                                {key:"deadReasonNm", label:"사망원인상세", width:"150"  , display:false},
                                {key:"deadPlace", label:"사망장소", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("deadPlace", this.value);
                                	}
                                },
                                {key:"deadPlaceNm", label:"사망장소 메모", width:"100"  , display:false},
                                {key:"usedSangjo", label:"상조가입여부", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("usedSangjo", this.value);
                                	}
                                },
                                {key:"sangjoRemark", label:"상조회명", width:"100"  , display:false},
                                {key:"applBirth", label:"상주생년월일", width:"100"  , display:false},
                                {key:"telNo", label:"상주연락처1", width:"150"  , display:false},
                                {key:"mobileNo", label:"상주연락처2", width:"150"  , display:false},
                                {key:"applPost", label:"상주우편번호", width:"100"  , display:false},
                                {key:"applAddr", label:"상주주소", width:"300"  , display:false},
                                {key:"lastFlg", label:"상태", width:"100"  , display:false
                                	, formatter:function(val){
                                		return this.value == 1 ? "퇴실" : "사용"
                                	}
                                },
                                {key:"embalmingGubun", label:"약물처리여부", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("embalmingGubun", this.value);
                                	}
                                },
                                {key:"ibkwanFlg", label:"염습여부", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("ibkwanFlg", this.value);
                                	}
                                },
                                {key:"transferCarCompany", label:"이송차량업체", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("transferCarCompany", this.value);
                                	}
                                },
                                {key:"ibkwanGubun", label:"입관여부", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("embalmingGubun", this.value);
                                	}
                                },
                                {key:"ibsilDate", label:"입실일자", width:"100"  , display:false},
                                {key:"funeralGubun", label:"장례구분", width:"100"  , display:true
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralGubun", this.value);
                                	}
                                },
                                {key:"funeralCarCompany", label:"장의차량업체", width:"100"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralCarCompany", this.value);
                                	}
                                },
                                {key:"deadDocGubun", label:"진단서발행유무", width:"100"  , display:false
                                },
                                {key:"deadDocno", label:"사망증빙서류발급번호", width:"150"  , display:false },
                                {key:"deadDocnm", label:"사망증빙서류발급기관", width:"150"  , display:false},
                                {key:"cadillacCompany", label:"캐딜락업체", width:"150"  , display:false
                                	, formatter:function(val){
                                		return Common.grid.codeFormatter("funeralCarCompany", this.value);
                                	}
                                },
                                {key:"dcCode", label:"관내외사유", width:"100"  , display:false
                                	, formatter:function(val){
                                		if(this.value == "000"){
                                			return "관외";
                                		}else if(this.value =="001"){
                                			return "관내1년미만";
                                		}else{
                                			return "관내1년이상";
                                		}
                                	}
                                },
                                {key:"dcRemark", label:"할인메모", width:"150"  , display:false
                                },

                                {key:"liveName01", label:"상제(전광판)1", width:"150"  , display:false
                                },
                                {key:"liveName02", label:"상제(전광판)2", width:"150"  , display:false
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