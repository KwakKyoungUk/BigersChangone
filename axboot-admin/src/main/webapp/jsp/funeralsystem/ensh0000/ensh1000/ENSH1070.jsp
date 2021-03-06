<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">

        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>


				<div class="ax-search" id="page-search-box"></div>

				<ax:custom customid="table">
                    <ax:custom customid="tr">
                    	<ax:custom customid="td">
							<div id="div-tab"></div>
							<div id="div-content"></div>
								<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; padding-right:10px;">
									<div id="div-tab-content-L1">
										<div class="ax-grid" id="page-grid1-box" style="min-height:200px; "></div>
									</div>
									<div id="div-tab-content-L2">
										<div class="ax-grid" id="page-grid2-box" style="min-height:200px; "></div>
									</div>
								</div>
						</ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
    	<script type="text/javascript">
    	  var resize_elements = [
    		  {id:"page-grid1-box", adjust:-130},
    		  {id:"page-grid2-box", adjust:-130}

            ];
            var fnObj = {

					selectedTab : "sch",
            		CODES: {

            			"firstTab": [
        					{optionValue:"L1", optionText:"???????????????", closable:false},
			   			 ],
				         "tab": [
			        				{optionValue:"L1", optionText:"???????????????", closable:false},
			        				{optionValue:"L2", optionText:"?????????", closable:false}
				        ],
				        "applRelation": Common.getCode("TCM08"),
				        "addrPart": Common.getCode("TCM10"),
                	},
                pageStart: function(){
                	this.search.bind();
                    this.grid1.bind();
                    this.grid2.bind();
                    this.bindEvent();
                    // ????????? ?????? ??? ?????? ?????? ???????????? (option)
                    this.search.submit();

                    $("#div-tab").updateTabs(fnObj.CODES.tab);
					$("#div-contents").append($("[id^='div-tab-content-']"));
					$("#div-content").append($("#div-tab-content-L1"));
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

                    $("#ax-page-btn-excel").html("<i class=\"axi axi-print\"></i> ?????????");
                    $("#ax-page-btn-excel").bind("click", function(){
                    	var params = [];
                    	var from 				= Common.search.getValue(fnObj.search.target, "from");
                		var to 					= Common.search.getValue(fnObj.search.target, "to");
                		var searchParam		= Common.search.getValue(fnObj.search.target, "searchParam");
						var key = [];
                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("condition="+fnObj.selectedTab);

                		if(fnObj.selectedTab =="sch"){
                			var list =fnObj.grid1.target.getList();
                			for (var i = 0; i < list.length; i++) {
                				key.push("'"+list[i].ensDate+list[i].ensSeq+"'")
							}
                			params.push("searchParam="+key.join(","));
                		}else{
                			var list =fnObj.grid2.target.getList();
                			for (var i = 0; i < list.length; i++) {
                				key.push("'"+list[i].ensDate+list[i].ensSeq+"'")
							}
                			params.push("searchParam="+key.join(","));
                		}


                		Common.report.open("/reports/changwon/ensh/ENSH1073", "pdf", params.join("&"));
                    });


                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-print\"></i> ?????????");
                    $("#ax-page-btn-fn1").bind("click", function(){
                    	var parameters = [];

                     	if(fnObj.selectedTab =="sch"){
                     		/* var list = fnObj.grid1.target.getList();

                  			$.each(list, function(i,o){
                  				console.log(o);
                  				parameters.push({path: "/reports/changwon/ensh/ENSH1071", parameter: "ensDate="+o.ensDate+"&ensSeq="+o.ensSeq+"&deadId="+o.deadId});
               				});
                  			Common.report.mergePdfReport(parameters); */ // ??????????????? ???????????? ??? ????????? ??????
                     		var extEndDate = prompt('??????????????? ???????????????', new Date().print());
                     		var list = fnObj.grid1.target.getList();
							if(extEndDate.length !=10){
								toast.push("??????????????? ??????????????????.");
								return false;
							}
                  			$.each(list, function(i,o){
                  				console.log(o);
                  				parameters.push({path: "/reports/changwon/ensh/ENSH1071", parameter: "ensDate="+o.ensDate+"&ensSeq="+o.ensSeq+"&deadId="+o.deadId+"&extEndDate="+extEndDate});
               				});
                  			Common.report.mergePdfReport(parameters);

                     	}else{

                     		var extEndDate = prompt('??????????????? ???????????????', new Date().print());
                     		var list = fnObj.grid2.target.getList();
							if(extEndDate.length !=10){
								toast.push("??????????????? ??????????????????.");
								return false;
							}
                  			$.each(list, function(i,o){
                  				console.log(o);
                  				parameters.push({path: "/reports/changwon/ensh/ENSH1072", parameter: "ensDate="+o.ensDate+"&ensSeq="+o.ensSeq+"&deadId="+o.deadId+"&extEndDate="+extEndDate});
               				});
                  			Common.report.mergePdfReport(parameters);

                     	}
                    });

                    $("#ax-page-btn-fn2").html("<i class=\"axi axi-file-excel-o\"></i> ??????");
                    $("#ax-page-btn-fn2").bind("click", function(){

                    	if(fnObj.selectedTab =="sch"){
                    		Common.report.gridToExcel("ENSH1071",  fnObj.grid1.target);
                    	}else{
                    		Common.report.gridToExcel("ENSH1072",  fnObj.grid2.target);
                    	}

                    });

                    $("#div-tab").bindTab({
        				theme : "AXTabs",
        				value:"L1",
        				overflow:"scroll", /* "visible" */
        				options:fnObj.CODES.firstTab,
        				onchange: function(selectedObject, value){
							$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-"+value));
							if(value =="L1"){

								Common.search.setValue(fnObj.search.target, "from", new Date(new Date().getFullYear(),new Date().getMonth(),1).print());
								Common.search.setValue(fnObj.search.target, "to", new Date(new Date().getFullYear(),new Date().getMonth()+1,0).print('yyyy-mm-dd'));
								fnObj.selectedTab = "sch";
							}else{

								Common.search.setValue(fnObj.search.target, "from", new Date(new Date().getFullYear(),new Date().getMonth(),1).print());
								Common.search.setValue(fnObj.search.target, "to", new Date().add(-1,'d').print('yyyy-mm-dd'));
								fnObj.selectedTab = "exp";
							}
        				},
        				onclose: function(selectedObject, value){
        					toast.push("onclose: "+Object.toJSON(value));
        				}
        			});

                    $("#div-tab").updateTabs(fnObj.CODES.tab);
                },
                tabs:{},
                eventFunc: {

                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // ????????? ???????????? ???????????? submit ????????? ?????? ?????? ?????? ?????????.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
               						{label:"??????(??????)???", labelWidth:"", type:"inputText", width:"70", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date(new Date().getFullYear(),new Date().getMonth(),1).print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date(new Date().getFullYear(),new Date().getMonth()+1,0).print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){
               										_this.submit();
               									}
               								}
               							}
               						},
               						{label:"????????????", labelWidth:"", type:"selectBox", width:"100", key:"searchParam", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"0", optionText:"???????????????"},{optionValue:"1", optionText:"???????????????"},{optionValue:"2", optionText:"????????????"},{optionValue:"3", optionText:"?????????"}],
										onChange: function(){
										}
									},
                                ]},
                                {display:true, addClass:"", style:"", list:[
                                		{label:"???????????????", labelWidth:"", type:"inputText", width:"250", key:"beforeApplAddr1",addClass:"", valueBoxStyle:"", value:""}
                                		,{label:"", labelWidth:"", type:"inputText", width:"250", key:"beforeApplAddr2",addClass:"", valueBoxStyle:"", value:""}
	              						,{label:"", labelWidth:"", type:"inputText", width:"100", key:"beforeApplPost",addClass:"", valueBoxStyle:"", value:""}

	                            	]
                                },
	                            {display:true, addClass:"", style:"", list:[
                            		{label:"???????????????", labelWidth:"", type:"inputText", width:"250", key:"applAddr1",addClass:"", valueBoxStyle:"", value:""}
                            		,{label:"", labelWidth:"", type:"inputText", width:"250", key:"applAddr2",addClass:"", valueBoxStyle:"", value:""}
              						,{label:"", labelWidth:"", type:"inputText", width:"100", key:"applPost",addClass:"", valueBoxStyle:"", value:""}
              						, {label:"", labelWidth:"", type:"button", width:"80", key:"btn-applpost", addClass:"", valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-local-post-office'></i>????????????",
            							onclick: function(){
            								daumPopPostcode("applPost", "applAddr1", "applAddr2",fnObj.search.target);
            							}
            						},
                            		]
                                },
                            ]
                        });
                    },
                    submit: function(){
                    	var pars = this.target.getParam();
                    	if(fnObj.selectedTab == "sch"){
                    		fnObj.grid1.setPage(pars);
                    	}else {
                    		fnObj.grid2.setPage(pars);
                    	}
                    }
                },
                grid1: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid1-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            height:"auto",
                            colGroup : [
								{key:"no"				, label:"no"			, width:"50"		, align:"right", formatter: function(){return this.index+1;}},
								{key:"endDate"	, label:"???????????????"	, width:"100" 	, align:"center" 	},
								{key:"ensNo"			, label:"????????????"	, width:"100"	, align:"center"},
								{key:"realDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"strDate"	, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"endDate"	, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"deadName"	, label:"?????????"		, width:"100"	, align:"center"},
								{key:"deadJumin"	, label:"????????????"	, width:"120"	, align:"center"},
								{key:"deadDate"		, label:"?????????"	, width:"100"	, align:"center"},
								{key:"addrPart"		, label:"????????????"	, width:"100"	, align:"center"
									, formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}
								},
								{key:"retDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"extDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"applName"		, label:"?????????"		, width:"100"	, align:"center"},
								{key:"applJumin"		, label:"????????????"	, width:"120"	, align:"center"},
								{key:"applAddr"		, label:"??????"		, width:"500"	, align:"left"
									, formatter: function(){
										return this.item.applAddr1 + " " + this.item.applAddr2;
									}
								},
								{key:"applPost"		, label:"????????????"	, width:"100"	, align:"center"},
								{key:"mobileno"		, label:"?????????"	, width:"100"	, align:"center"},
								{key:"telno"		, label:"????????????"	, width:"100"	, align:"center"},
								{key:"deadRelation"		, label:"??????"	, width:"100"	, align:"center"
									, formatter: function(){
										return Common.grid.codeFormatter("applRelation", this.value);
									}
								}

                            ],
                            body : {
                            	 onclick: function(){
                            		 console.log(this.item);
                            		Common.search.setValue(fnObj.search.target, "beforeApplAddr1", this.item.applAddr1);
                                 	Common.search.setValue(fnObj.search.target, "beforeApplAddr2", this.item.applAddr2);
                                 	Common.search.setValue(fnObj.search.target, "beforeApplPost", this.item.applPost);
                                 	Common.search.setValue(fnObj.search.target, "applAddr1", this.item.applAddr1);
                                 	Common.search.setValue(fnObj.search.target, "applAddr2", this.item.applAddr2);
                                 	Common.search.setValue(fnObj.search.target, "applPost", this.item.applPost);
                            	 }
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
                    setPage: function(param){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1070/extEndDate?"+param+"&condition=sch",
                            data:""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
								_target.setData({list:res.list});

                            }
                        });
                    },
                    save : function(){

                    	var item = fnObj.grid1.target.getSelectedItem().item;
                    	if(typeof item=== "undefined" ){
                			toast.push("????????? ????????? ???????????????.");
                			return false;
                		}
                    	var info = { applId : item.applId
                    					, applPost : Common.search.getValue(fnObj.search.target, "applPost")
                    					, applAddr1 : Common.search.getValue(fnObj.search.target, "applAddr1")
                    					, applAddr2 : Common.search.getValue(fnObj.search.target, "applAddr2")
                    	}
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1070/saveApplicant",
                            data:Object.toJSON(info)
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
                            	fnObj.search.submit();
                            }
                        });
                    }
                },
                grid2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid2-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            height :"auto",
                            colGroup : [
                            	{key:"no"				, label:"no"			, width:"50"		, align:"right", formatter: function(){return this.index+1;}},
								{key:"endDate"	, label:"?????????"	, width:"100" 	, align:"center" 	},
								{key:"ensNo"			, label:"????????????"	, width:"100"	, align:"center"},
								{key:"realDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"strDate"	, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"endDate"	, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"deadName"	, label:"?????????"		, width:"100"	, align:"center"},
								{key:"deadJumin"	, label:"????????????"	, width:"120"	, align:"center"},
								{key:"deadDate"		, label:"????????????"	, width:"100"	, align:"center"},
								{key:"addrPart"		, label:"????????????"	, width:"100"	, align:"center"
									, formatter: function(){
										return Common.grid.codeFormatter("addrPart", this.value);
									}
								},
								{key:"retDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"extDate"		, label:"???????????????"	, width:"100"	, align:"center"},
								{key:"applName"		, label:"?????????"		, width:"100"	, align:"center"},
								{key:"applJumin"		, label:"????????????"	, width:"120"	, align:"center"},
								{key:"applAddr"		, label:"??????"		, width:"500"	, align:"left"
									, formatter: function(){
										return this.item.applAddr1 + " " + this.item.applAddr2;
									}
								},
								{key:"applPost"		, label:"????????????"	, width:"100"	, align:"center"},
								{key:"mobileno"		, label:"?????????"	, width:"100"	, align:"center"},
								{key:"telno"		, label:"????????????"	, width:"100"	, align:"center"},
								{key:"deadRelation"		, label:"??????"	, width:"100"	, align:"center"
									, formatter: function(){
										return Common.grid.codeFormatter("applRelation", this.value);
									}
								}

                            ],
                            body : {
                            	 oncheck : function(){

                            	 }
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
                    clear: function(){
                        this.target.setList([]);
                    },
                    setPage: function(param){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1070/extEndDate?"+param+"&condition=exp",
                            data:""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
								_target.setData({list:res.list});

                            }
                        });
                    }
                },
                save : function(){
                	fnObj.grid1.save();
                }


            };
        </script>
    </ax:div>
</ax:layout>