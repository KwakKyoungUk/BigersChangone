<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="화장예약조회" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">

			<div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 화장예약조회</h2>
                    </div>
                    <div class="right">
                    	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>
                    </div>
		       </div>
		       <div class="ax-search" id="page-search-box"></div>
			   <div class="ax-grid" id="page-grid-box-hwaBooking" style="min-height: 330px;"></div>
			</ax:col>
		</ax:row>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			vdeadId = "";
			var fnObj = {
                CODES: {

                     "objt": Common.getCode("TMC03"),
                     "chasu": [],
                 	bookingType: Common.getCode("TMC04"),
                 	bookBurnObjt: Common.getCode("TMC02"),
                 	 "applRelation": Common.getCode("TCM08"),
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
/*                                   {display:true, addClass:"", style:"", list:[
                 						{label:"사망자", labelWidth:"", type:"inputText", width:"70", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
                 							onChange: function(){}
                 						},
                 						{label:"신청자", labelWidth:"", type:"inputText", width:"70", key:"applName", addClass:"", valueBoxStyle:"", value:"",
                 							onChange: function(){}
                 						},
                                  ]}, */

                                  {display:true, addClass:"", style:"", list:[
										{label:"예약일자", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
											onclick: function(){
	       											var date = Common.search.getValue(fnObj.search.target, "bookDate").date();
	       											date.setDate(date.getDate()-1);
	        											Common.search.setValue(fnObj.search.target, "bookDate", date.print());
	       											$("#btn-search").click();
	       										}
	       									},
	                                      		{label:"", labelWidth:"", type:"inputText", width:"100", key:"bookDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
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
	       											var date = Common.search.getValue(fnObj.search.target, "bookDate").date();
	       											date.setDate(date.getDate()+1);
	       											Common.search.setValue(fnObj.search.target, "bookDate", date.print());
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
                            targetID : "page-grid-box-hwaBooking",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"bookChasu", label:"차수", width:"60", align:"center"},
                                {key:"time", label:"시간", width:"100", align:"center"
                                	,formatter:function(){
                                		return Common.pattern.custom(this.item.strttimeString+this.item.endtimeString, "99:99 - 99:99");
                                	}
                                },
                                {key:"bookChasuSeq", label:"호기", width:"60", align:"center"
                                	,formatter:function(){
                                		return parseInt(this.value);
                                	}
                                },
                                {key:"bookDeadName", label:"고인명", width:"100", align:"center"},
                                {key:"bookDeadJumin", label:"주민번호", width:"120", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"bookDeadDate", label:"사망일자", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.value){
	                                		return this.value.date().print("yyyy.mm.dd");
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"company", label:"발인지", width:"130", align:"center" },


                                /* {key:"bookBurnObjt", label:"대상구분", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.bookBurnObjt.length; i++){
                                    		if(fnObj.CODES.bookBurnObjt[i].optionValue == this.value){
                                    			return fnObj.CODES.bookBurnObjt[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                                }, */

                                {key:"bookApplName", label:"신청자명", width:"100", align:"center"},
                                {key:"bookApplJumin", label:"신청자주민번호", width:"120", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"bookRelation", label:"사망자와의관계", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.applRelation.length; i++){
                                    		if(fnObj.CODES.applRelation[i].optionValue == this.value){
                                    			return fnObj.CODES.applRelation[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                                },
                                {key:"bookMobileString", label:"휴대전화", width:"100", align:"center"},
                                {key:"bookTelString", label:"전화번호", width:"100", align:"center"},
                                {key:"bookDeadAddr", label:"사망자 주소", width:"350", align:"center"
                                	,formatter:function(){
                                		return this.item.bookDeadAddr1+" "+ this.item.bookDeadAddr2;
                                	}
                                },


                                {key:"bookApplAddr", label:"신청자 주소", width:"350", align:"center"
                                	,formatter:function(){
                                		return this.item.bookApplAddr1+" "+ this.item.bookApplAddr2;
                                	}
                                },
                                /*
                                {key:"receiveymd", label:"접수일자", width:"150", align:"center"
                                	, formatter:function(val){
                                		var res = [];
                                		for(var i=0; i<this.value.length; i++){
                                			res.push(this.value[i]);
                                			if(i==3 || i==5){
                                				res.push("-");
                                			}
                                		}
                                		return res.join("");
                                	}
                               	},

                                {key:"bookingType", label:"접수경로", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.bookingType.length; i++){
                                    		if(fnObj.CODES.bookingType[i].optionValue == this.value){
                                    			return fnObj.CODES.bookingType[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                               	},
                               	*/

//                                {key:"bookStatus", label:"상태", width:"150", align:"center"
//                                 	, formatter: function(val){
//                                 		for(var i=0; i<fnObj.CODES.bookStatus.length; i++){
//                                 			if(fnObj.CODES.bookStatus[i].optionValue == val){
// 	                                			return fnObj.CODES.bookStatus[i].optionText;
//                                 			}
//                                 		}
//                                 	}
//                                }
                            ],
                            body : {
                            	ondblclick: function(){
                            		if(this.item.bookStatus == '미접수'){
                            			var selectedItem =fnObj.grid.target.getSelectedItem();
                                		app.modal.save("${callBack}", selectedItem);
                        			}else{
                        				toast.push("미접수 자료가 아닙니다.");
                        			}
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
                             url: "/CREM1020/hwaBooking/page",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=10&bookDate=" + Common.str.replaceAll($("#"+fnObj.search.target.getItemId("bookDate")).val(),"-","")
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {

                            	 var gridData = {
                            		 list: (function(){
                                    	 for(var i=0; i<res.list.length; i++){

                                    		 for(var key in res.list[i]){
                                    			 res.list[i][key]=res.list[i][key];
                                    		 }
                                    		 for(var key in res.list[i].rogrpchasuVTO){
                                    			 res.list[i][key]=res.list[i].rogrpchasuVTO[key];
                                    		 }
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
                        	toast.push("예약자료를 선택해주세요.");
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