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
                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 화장접수현황조회</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>
				<div id="grid-context-menu"></div>
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
                	objt : Common.getCode("TMC03"),
                	scatterPlace : Common.getCode("TMC06"),
                	dcGubun : Common.getCode("TCM12"),
                	applRelation : Common.getCode("TCM08"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.contextMenu.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-fn2").html("<i class=\"axi axi-file-excel-o\"></i> 엑셀(일자형)");
                    $("#ax-page-btn-fn2").bind("click", function(){
                    	var params = [];

                    	var enshUseGb = Common.search.isChecked(fnObj.search.target, "enshUseGb") == true ? 1 : 0;
                    	var natuUseGb = Common.search.isChecked(fnObj.search.target, "natuUseGb") == true ? 1 : 0;
                    	var scatUseGb = Common.search.isChecked(fnObj.search.target, "scatUseGb") == true ? 1 : 0;

                    	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
                    		params.push("from="+new Date("1900-01-01").print("yyyymmdd"));
                    		params.push("to="+new Date().print("yyyymmdd"));
                    		params.push("deadName="+Common.search.getValue(fnObj.search.target, "deadName"));
                    		params.push("applName="+Common.search.getValue(fnObj.search.target, "applName"));
                    		params.push("enshUseGb="+enshUseGb);
                    		params.push("natuUseGb="+natuUseGb);
                    		params.push("scatUseGb="+scatUseGb);

                    	}else{
                    		params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                    		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                    		params.push("deadName="+Common.search.getValue(fnObj.search.target, "deadName"));
                    		params.push("applName="+Common.search.getValue(fnObj.search.target, "applName"));
                    		params.push("enshUseGb="+enshUseGb);
                    		params.push("natuUseGb="+natuUseGb);
                    		params.push("scatUseGb="+scatUseGb);

                    	}
                        Common.report.go("/reports/changwon/crem/CREM2022", "excel", params.join("&"));
                    });

                    $("#ax-page-btn-fn3").html("<i class='axi axi-send'></i> 접수자료전송");
                    $("#ax-page-btn-fn3").bind("click", function(){
                    	 app.ajax({
                             type: "GET",
                             url: "/CREM2020/sendData",
                             data: ""
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {

                             }
                         });
                    });

                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("CREM2021", fnObj.grid.target);
                    	/* var params = [];
                    	var enshUseGb = Common.search.isChecked(fnObj.search.target, "enshUseGb") == true ? 1 : 0;
                    	var natuUseGb = Common.search.isChecked(fnObj.search.target, "natuUseGb") == true ? 1 : 0;
                    	var scatUseGb = Common.search.isChecked(fnObj.search.target, "scatUseGb") == true ? 1 : 0;

                    	if(Common.search.isChecked(fnObj.search.target, "checkbox")){
                    		params.push("from="+new Date("1900-01-01").print("yyyymmdd"));
                    		params.push("to="+new Date().print("yyyymmdd"));
                    		params.push("deadName="+Common.search.getValue(fnObj.search.target, "deadName"));
                    		params.push("applName="+Common.search.getValue(fnObj.search.target, "applName"));
                    		params.push("enshUseGb="+enshUseGb);
                    		params.push("natuUseGb="+natuUseGb);
                    		params.push("scatUseGb="+scatUseGb);

                    	}else{
                    		params.push("from="+Common.search.getValue(fnObj.search.target, "from")).date().print("yyyymmdd");
                    		params.push("to="+Common.search.getValue(fnObj.search.target, "to")).date().print("yyyymmdd");
                    		params.push("deadName="+Common.search.getValue(fnObj.search.target, "deadName"));
                    		params.push("applName="+Common.search.getValue(fnObj.search.target, "applName"));
                    		params.push("enshUseGb="+enshUseGb);
                    		params.push("natuUseGb="+natuUseGb);
                    		params.push("scatUseGb="+scatUseGb);

                    	}
                        Common.report.go("/reports/changwon/crem/CREM2021", "excel", params.join("&")); */
                    });
                    $(document.body).bind("mouseover", function(event){
                    	pageX = event.pageX;
                    	pageY = event.pageY;
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
               						{label:"사망자", labelWidth:"", type:"inputText", width:"70", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
               							onChange: function(){}
               						},
               						{label:"신청자", labelWidth:"", type:"inputText", width:"90", key:"applName", addClass:"", valueBoxStyle:"", value:"",
       									onChange:function(){}
               						},
                                ]}
                                , {display:true, addClass:"", style:"", list:[
               						{label:"화장일자", labelWidth:"100", type:"checkBox", width:"", key:"checkbox", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"all", optionText:"전기간", title:"전기간"}],
										onChange: function(selectedObject, value){
											//아래 3개의 값을 사용 하실 수 있습니다.
// 											toast.push(Object.toJSON(this));
// 											toast.push(Object.toJSON(selectedObject));
// 											toast.push(value);
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
                                ]},
                                {display:true, addClass:"", style:"", list:[
                                	{label:"", labelWidth:"100", type:"checkBox", width:"", key:"enshUseGb", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"1", optionText:"봉안", title:"봉안"}],
										onChange: function(selectedObject, value){
										}
									},
                                	{label:"", labelWidth:"100", type:"checkBox", width:"", key:"scatUseGb", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"1", optionText:"유택동산", title:"유택동산"}],
										onChange: function(selectedObject, value){
										}
									},
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
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"id", label:"화장관리번호", width:"110", align:"left", valign:"middle"
                                	, formatter:function(){
                                    return this.item.cremDate+"-"+Common.str.lpad(this.item.cremSeq+"","0",2);
                                	}
                            	},
                                {key:"cremDate", label:"화장일자", width:"100", align:"center", valign:"middle"},
                                {key:"deadName", label:"이름", width:"80", align:"left"},
                                {key:"deadJumin",label:"주민번호", width:"130", align:"center"},
                                {key:"deadDate", label:"사망일자", width:"100", align:"center"},
                                {key:"objt", label:"대상구분", width:"100", align:"left"
                                	, formatter:function(){
                                    return Common.grid.codeFormatter("objt",this.value);
                            		}
                            	},
                                {key:"applName", label:"이름", width:"80", align:"left", formatter: function(){
                                	if(this.item.applName){
                                		return this.item.applName;
                                	}else{
                                		return "";
                                	}
                                }},
                                {key:"phone", label:"전화번호", width:"130", align:"center", formatter: function(){
                                	if(this.item.mobileno){
                                		return this.item.mobileno;
                                	}else{
                                		return this.item.telno;
                                	}
                                }},
                                {key:"applRelation", label:"고인과의관계", width:"100", align:"left", valign:"middle"
                                	, formatter:function(){
                                        return Common.grid.codeFormatter("applRelation",this.item.applRelation);
                                	}
                                },
                                {key:"scatterPlace", label:"화장 후 장지", width:"150", align:"left", valign:"middle"
                                	, formatter:function(){
                                        return Common.grid.codeFormatter("scatterPlace",this.item.scatterPlace);
                                	}
                                },
                                {key:"gubun", label:"결제구분", width:"80", align:"left"
                                	, formatter:function(){
                                		console.log(this);
                                		 var info = {gubun : "", color : "" , textColor : ""};
                                		 if(this.item.cremCardAmt || this.item.cremCashAmt){
                                			info.gubun = this.item.cremCardAmt > 0 ? "카드" : "현금";
                            				info.color = info.gubun == "카드" ? "#e8b643"  :"#00BFFF";
                            				info.textColor = info.gubun == "카드" ? "#000000" : "black";
                                		 }else{
                                			 return Common.grid.codeFormatter("dcGubun",this.item.dcGubun);
                                		 }
                                		 return "<div style='background-color:"+info.color+"; padding:2px; width:90%; height:90%;'>"+info.gubun+"</div>";
                                	}
                                },
                                {key:"cremCharge", label:"화장", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		amt = this.item.cremCardAmt + this.item.cremCashAmt;
                                		return amt.money();
                                	}
                                },
                                {key:"enshCharge", label:"봉안", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		amt = (this.item.enshCardAmt || 0) + (this.item.enshCashAmt || 0);
                                		return amt.money();
                                	}
                                },
                                {key:"enshMngCharge", label:"봉안관리비", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		amt = this.item.enshMngCardAmt + this.item.enshMngCashAmt;
                                		return amt.money();
                                	}
                                },
                                {key:"natuCharge", label:"자연장", width:"150", align:"right" , pattern : "money", display: false
                                	, formatter:function(){
                                		var amt = 0;
                                		amt = this.item.natuCardAmt + this.item.natuCashAmt;
                                		return amt.money();
                                	}
                                },
                                {key:"totCharge", label:"합계", width:"150", align:"right"
                                	, formatter:function(){
                                		var amt = 0;
                                		amt = this.item.cremCardAmt + this.item.cremCashAmt
                                			+this.item.enshCardAmt + this.item.enshCashAmt
                                			+this.item.enshMngCardAmt + this.item.enshMngCashAmt
                                			+this.item.natuCardAmt + this.item.natuCashAmt;
                                		return amt.money();
                                	}
                                }
                            ],
                            colHead: {
                                rows: [
                                    [
                                        {colSeq: 0, rowspan: 2},
                                        {colSeq: 1, rowspan: 2},
                                        {colSeq: null, colspan: 4, label: "사망자", align: "center"},
                                        {colSeq: null, colspan: 3, label: "신청자", align: "center"},
                                        {colSeq: 9, rowspan: 2},
                                        {colSeq: null, colspan: 6, label: "정산금액", align: "center"},
                                    ],
                                    [
                                        {colSeq: 2},
                                        {colSeq: 3},
                                        {colSeq: 4},
                                        {colSeq: 5},
                                        {colSeq: 6},
                                        {colSeq: 7},
                                        {colSeq: 8},
                                        {colSeq: 10},
                                        {colSeq: 11},
                                        {colSeq: 12},
                                        {colSeq: 13},
                                        {colSeq: 14},
                                        {colSeq: 15},


                                    ]
                                ]
                            },
                            body : {
                                onclick: function(event){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //console.log(this.list);
                                    //alert(this.list);
                                    //alert(this.page);

                                    var item = this.item;
                                	AXContextMenu.open({
                                	    id:"grid-context-menu"
                                	    , sendObj: item
                                	}, {left:pageX, top:pageY});
                                }
                            },
                            foot: {
                                rows: [
                                    [
                                        {
                                            colSeq: null, colspan : 10, formatter: function () {
                                            return "계";
                                       		}, align: "center", valign: "middle"
                                        },
                                        {
                                            colSeq: 11, formatter: function () {

                                            return this.list.length+"건";
                                        	}
                                        },
                                        {
                                            colSeq: 12, formatter: function () {
                                            var sum = 0;
                                            $.each(this.list, function () {
                                            	console.log(this);
                                                sum += this.cremCardAmt+this.cremCashAmt;
                                            });
                                            return sum.money();
                                        	}
                                        },
                                        {
                                            colSeq: 13, formatter: function () {
                                            var sum = 0;
                                            $.each(this.list, function () {
                                                sum += this.enshCardAmt + this.enshCashAmt
                                            });
                                            return sum.money();
                                       		}
                                        },
                                        {
                                            colSeq: 13, formatter: function () {
                                            var sum = 0;
                                            $.each(this.list, function () {
                                                sum += this.enshMngCardAmt + this.enshMngCashAmt
                                            });
                                            return sum.money();
                                       		}
                                        },
                                        {
                                            colSeq: 15, display: false, formatter: function () {
                                            var sum = 0;
                                            $.each(this.list, function () {
                                                sum += this.natuCardAmt + this.natuCashAmt;
                                            });
                                            return sum.money();
                                       		}
                                        },
                                        {
                                            colSeq: 16, formatter: function () {
                                            var sum = 0;
                                            $.each(this.list, function () {
                                                sum += this.cremCardAmt + this.cremCashAmt
                                    			+this.enshCardAmt + this.enshCashAmt
                                    			+this.enshMngCardAmt + this.enshMngCashAmt
                                    			+this.natuCardAmt + this.natuCashAmt;
                                            });
                                            return sum.money();
                                       		}, align: "right"
                                        },

                                    ],
                                ]
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
                        var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/CREM2020/hwaCremation",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
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
                },
                contextMenu: {
                	target: $("#grid-context-menu"),
                	bind: function(){
	                	AXContextMenu.bind({
	                        id:"grid-context-menu",
	                        theme:"AXContextMenu", // 선택항목
	                        width:"150", // 선택항목
	                        checkbox:"checkbox", // [checkbox|radio]
	                        sortbox:true,
	                        menu:[
	                            {label:'화장접수', checked:true, onclick:function(a){
	                            	window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?cremDate=" + this.sendObj.cremDate + "&cremSeq=" + this.sendObj.cremSeq, "CREM2010")
	                                return false;
	                            }},
	                            {label:'봉안접수', checked:true, onclick:function(a){
	                            	window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?ensDate="+ this.sendObj.ensDate + "&ensSeq=" + this.sendObj.ensSeq +"&cremDate=" + this.sendObj.cremDate + "&cremSeq=" + this.sendObj.cremSeq, "ENSH1010")
	                            	//window.open("/jsp/funeralsystem/ensh0000/ensh1000/ENSH1010.jsp?cremDate=" + this.sendObj.cremDate + "&cremSeq=" + this.sendObj.cremSeq, "_blank")
	                                return false;
	                            }},
	                            {label:'유택동산 접수', checked:true, onclick:function(a){
	                            	window.open("/jsp/funeralsystem/scat0000/scat1000/SCAT1010.jsp?cremDate=" + this.sendObj.cremDate + "&cremSeq=" + this.sendObj.cremSeq, "SCAT1010")
	                            	//window.open("/jsp/funeralsystem/natu0000/natu1000/NATU1010.jsp?cremDate=" + this.sendObj.cremDate + "&cremSeq=" + this.sendObj.cremSeq, "_blank")
	                                return false;
	                            }}
	                        ],
	                        onchange: function(){ // 체크박스 선택값이 변경 된 경우 호출 됩니다.
	                            trace(this.menu);
	                            // return true; 메뉴 창이 닫히지 않게 합니다.
	                        },
	                        onsort: function(){ // 정렬이 변경 된 경우 호출 됩니다.
	                            trace(this.sortMenu);
	                            // return true; 메뉴 창이 닫히지 않게 합니다.
	                        }
	                    });
                    	AXContextMenu.close({
                    	    id:"grid-context-menu"
                    	});
	                }
                },
                sendData : function(){
                	app.ajax({
                        type: "GET",
                        url: "/CREM2020/sendData",
                        data: ""
                    }, function(res){
                        if(res.error){
                           alert(res.error.message);
                        }
                        else
                        {

                        }
                    });
                }
            };
        </script>
    </ax:div>
</ax:layout>