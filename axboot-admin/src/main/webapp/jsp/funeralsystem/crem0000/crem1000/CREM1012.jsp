<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="장례식장자료조회" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

			<div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 장례식장자료조회</h2>
                    </div>
                    <div class="right">
                    	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>
                    </div>
		       </div>
		       <div class="ax-search" id="page-search-box"></div>
			   <div class="ax-grid" id="page-grid-box" style="min-height: 220px;"></div>
			</ax:col>
		</ax:row>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			vdeadId = "";
			var fnObj = {
                CODES: {
                	 "binso": (function(){
                     	var result;
                     	app.ajax({
                     			async: false,
 	                            type: "GET",
 	                            url: "/CREM1012/binso",
 	                            data: ""
 	                        },
 	                        function(res){
 	                        	result = res;
                         	}
                         );
                     	return result;
                     }()),
                     "objt": Common.getCode("TMC03"),
                },
				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.bindEvent();
					this.search.submit();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					// click----------------------------------
					$("#btn-search").bind("click", function(){
						fnObj.search.submit();
					});
					// click----------------------------------

					$("input").keydown(function (key) {
                        if(key.keyCode == 13){
                        	fnObj.search.submit();
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
                 						{label:"신청자", labelWidth:"", type:"inputText", width:"70", key:"applName", addClass:"", valueBoxStyle:"", value:"",
                 							onChange: function(){}
                 						},

                 						/*  {label:" ", labelWidth:"400", type:"button", width:"70", key:"button", addClass:"right", align : "right" , valueBoxStyle:"padding-left:0px;padding-right:5px;", value:"<i class='axi axi-ion-android-search'></i>조회",
                							onclick: function(){
                								//fnObj.searchHwaCremation.submit();
                							}
                						}, */
                                  ]},

                                  {display:true, addClass:"", style:"", list:[
										{label:"발인일자", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
											onclick: function(){
	       											var date = Common.search.getValue(fnObj.search.target, "balinDate").date();
	       											date.setDate(date.getDate()-1);
	        											Common.search.setValue(fnObj.search.target, "balinDate", date.print());
	       											$("#btn-search").click();
	       										}
	       									},
	                                      		{label:"", labelWidth:"", type:"inputText", width:"100", key:"balinDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
	                                           	AXBind:{
	                   								type:"date", config:{
	                   									align:"right", valign:"top", defaultDate:new Date(),
	                   									onChange:function(){
	                   										setTimeout(function(){$("#btn-search").click();}, 100);
	                   									}
	                   								}
	                   							}
	                                         	},
	       									{label:"", labelWidth:"", type:"button", width:"30", key:"rightDate", addClass:"", valueBoxStyle:"", value:">",
	       										onclick: function(){
	       											var date = Common.search.getValue(fnObj.search.target, "balinDate").date();
	       											date.setDate(date.getDate()+1);
	       											Common.search.setValue(fnObj.search.target, "balinDate", date.print());
	       											$("#btn-search").click();
	       										}
	      									}
	                             	  ]}

                              ]
                        });
                    },
                    defaultSearch:function(){
                    	this.submit();
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
                                {key:"balinDate", label:"발인일자", width:"100", align:"center",
                                		formatter : function(){
                                			if(this.value){
    	                                		return this.value.date().print("yyyy-mm-dd");
                                    		}else{
                                    			return "";
                                    		}
                                		}
                                },
                                {key:"binsoCode", label:"호실", width:"100", align:"center",
                               			formatter : function(){
                               				for(var i=0; i<fnObj.CODES.binso.length; i++){
                                       			if(this.value == fnObj.CODES.binso[i].binsoCode){
                                       				return fnObj.CODES.binso[i].displayBinso;
                                       			}
                                       		}
                               			}
                                },
                                {key:"deadName", label:"이름", width:"100", align:"center"},
                                {key:"deadDate", label:"사망일자", width:"100", align:"center"
                                		, formatter: function(val){
                                    		if(this.value){
    	                                		return this.value.date().print("yyyy-mm-dd");
                                    		}else{
                                    			return "";
                                    		}
                                    	}
                                },
                                {key:"cremObjt", label:"대상구분", width:"100", align:"center"
                                	,formatter : function(){
                           				for(var i=0; i<fnObj.CODES.objt.length; i++){
                                   			if(this.value == fnObj.CODES.objt[i].optionValue){
                                   				return fnObj.CODES.objt[i].optionText;
                                   			}
                                   		}
                           			}
                            },
                                {key:"applName", label:"이름", width:"100", align:"center"},
                                {key:"phone", label:"전화번호", width:"130", align:"center"},
                            ],
                            colHead: {
                                rows: [
                                    [
										{colSeq: 0, rowspan: 2},
                                        {colSeq: 1, rowspan: 2},
                                        {colSeq: null, colspan: 3, label: "사망자", align: "center"},
                                        {colSeq: null, colspan: 2, label: "신청자", align: "center"},
                                    ],
                                    [
										{colSeq: 2},
										{colSeq: 3},
										{colSeq: 4},
                                        {colSeq: 5},
                                        {colSeq: 6},
                                    ]
                                ]
                            },
                            body : {
                                onclick: function(){
                                	//fnObj.form.setJSON(this.item);
                                },
                            	ondblclick: function(){
                            		var selectedItem =fnObj.grid.target.getSelectedItem();
                            		selectedItem.item.dcGubun = selectedItem.item.cremDcGubun
                            		selectedItem.item.dcCode = selectedItem.item.cremDcCode
                            		app.modal.save("${callBack}", selectedItem);
                            		app.modal.close();
                            	}
                            },
                            page: {
                                display: true,
                                paging: true
                                , onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, balinDate){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/CREM1012/funeral",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (balinDate||fnObj.search.target.getParam())+"&sort=balinDate"
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                            	var gridData = {
                                  list: (function(){
                                 	 for(var i=0; i<res.list.length; i++){

                                 		 for(var key in res.list[i].thedead){
                                 			 res.list[i][key]=res.list[i].thedead[key];
                                 			 res.list[i].thedead.transferDate = res.list[i].transferDate;
                                 		 }
                                 		 for(var key in res.list[i].applicant){
                                 			 res.list[i][key]=res.list[i].applicant[key];
                                 		 }
                                 		res.list[i].addrPart = (res.list[i].dcCode != "000" ? "TCM1000001" : "TCM1000003");
                                 	 }
                                 	 return res.list;
                                  }()),
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
				control: {
					select: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("장례식장자료를 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();

			});
			axdom(window).resize(fnObj.pageResize);

		</script>
	</ax:div>
</ax:layout>