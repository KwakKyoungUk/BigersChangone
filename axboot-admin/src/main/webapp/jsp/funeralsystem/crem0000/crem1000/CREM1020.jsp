<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />

    <ax:div name="css">
        <style type="text/css" id="css">

            .border_none {
	            border:none ;
	            border-right:0px ;
	            border-top:0px ;
	            boder-left:0px ;
	            boder-bottom:0px ;
	            box-shadow :0 ;
	            text-shadow : none ;
             }
             .header{
            	background-color: lightgray ;

            }
            .footer{

            }
            td{
            	font-size: 12px ;
            	text-overflow: ellipsis;
            }
        </style>
    </ax:div>


    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
            <div>
                <table cellpadding="0" cellspacing="0" class="">
                    <colgroup>
                        <col width="100" />
                        <col />
                        <col width="120" />
                        <col />
                        <col width="70" />
                        <col />
                        <col width="70" />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>
                                <div >예약일자</div>
                            </th>
                            <td>
                                <div >
                                	<input id="info-leftDate" name="leftDate" type="button" class="AXButton"  value=" < " />
                                    <input id="info-bookDate" name="bookDate " type="text"   value="" class="AXInput W100" />
                                    <input id="info-rightDate" name="rightDate "type="button" class="AXButton"  value=" > " />
                                </div>
                            </td>
                            <th>
                                <div >(총 예약 건수 : </div>
                            </th>
                            <td id="info-totalCnt">
                            </td>
                             <th>
                                <div >시체 : </div>
                            </th>
                            <td id="info-sisin" align="center" width="40">
                            </td>
                            <th>
                                <div >개장유골 : </div>
                            </th>
                            <td id="info-ugol" align="center" width="40">
                            </td>
                            <th>
                                <div >사태 : </div>
                            </th>
                            <td id="info-sasan" align="center" width="40">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>


			<iframe id="pdf"  style="display: none;"></iframe>
            <div class="ax-search" id="page-search-box"></div>
            </ax:col>

			<ax:custom customid="table">
					<ax:custom customid="tr">
							<ax:custom customid="td">
							<div id="div-tab"></div>
							<div id="div-content"></div>
								<div id="div-contents" style="opacity:0; position: absolute; top: 0px; z-index: -10000; padding-right:10px;">
									<div id="div-tab-content-T"></div>
									<div id="div-tab-content-L">
										<div class="ax-grid" id="page-grid-box-hwaBooking" style="min-height:300px;"></div>
										<div id="grid-context-menu"></div>
									</div>
								</div>
							</ax:custom>
					</ax:custom>
			</ax:custom>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box-hwaBooking", adjust:-97},

            ];
            var fnObj = {

            	css : css,
                CODES: {
                	"firstTab": [
                					{optionValue:"T", optionText:"도표", closable:false},
           			 ],
			         "tab": [
                				{optionValue:"T", optionText:"도표", closable:false},
                				{optionValue:"L", optionText:"리스트", closable:false}
			        ],
			        "chasu": [],
                	bookingType: Common.getCode("TMC04"),
                	bookBurnObjt: Common.getCode("TMC02"),
                	 "applRelation": Common.getCode("TCM08"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.bindEvent();
                    this.grid.bind();
                    this.search.submit();
                    this.drawTable();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-fn2").html("<i class=\"axi axi-print\"></i> 도표");
                    $("#ax-page-btn-fn2").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.print();
                        }, 500);
                    });
                    $("#ax-page-btn-fn3").html("<i class=\"axi axi-print\"></i> 출력");
                    $("#ax-page-btn-fn3").bind("click", function(){
                        setTimeout(function() {
                        	Common.report.open("/reports/changwon/crem/CREM1021", "pdf", "bookDate="+$("#info-bookDate").val());
                        }, 500);
                    });
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-excel").bind("click", function(){
                    	Common.report.gridToExcel("CREM1020", fnObj.grid.target);
                    });
                    $("#info-bookDate").bindDate({
                    	onChange:function(){
									setTimeout(function(){$("#ax-page-btn-search").click();}, 100);
						}
                    });
                    $("#info-bookDate").val(new Date().print());

                    $("#info-leftDate").bind("click", function(){

                    	var date = $("#info-bookDate").val().date();
								date.setDate(date.getDate()-1);
								$("#info-bookDate").val(date.print());
								$("#ax-page-btn-search").click();
                    });

                    $("#info-rightDate").bind("click", function(){
                    	var date = $("#info-bookDate").val().date();
						date.setDate(date.getDate()+1);
						$("#info-bookDate").val(date.print());
						$("#ax-page-btn-search").click();
                    });


                    $("#div-tab").bindTab({
        				theme : "AXTabs",
        				value:"T",
        				overflow:"scroll", /* "visible" */
        				options:fnObj.CODES.firstTab,
        				onchange: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
//         					toast.push("onchange: "+Object.toJSON(value));

// 		                    $("#div-contents").empty();
//         					$("#div-contents").append(fnObj.tabs["div-tab-content-"+value].tab);
//         					fnObj.tabs["div-tab-content-"+value].bindEvent();
//         					$("[id^='div-tab-content-']").css("display", "none");
//         					$("#div-tab-content-"+value).css("display", "");
							$("#div-contents").append($("[id^='div-tab-content-']"));
							$("#div-content").append($("#div-tab-content-"+value));

        				},
        				onclose: function(selectedObject, value){
        					//toast.push(Object.toJSON(this));
        					//toast.push(Object.toJSON(selectedObject));
        					toast.push("onclose: "+Object.toJSON(value));
        				}
        			});

                    //$("#div-content").append($("#div-tab-content-T"));
                    $("#div-tab").updateTabs(fnObj.CODES.tab);
					//$("#div-contents").append($("[id^='div-tab-content-']"));

                },
                tabs:{},
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
                                //fnObj.search.submit();
                                fnObj.drawTable();
                            },
                            /* rows:[
                                  {display:true, addClass:"", style:"", list:[
                                      										{label:"예약 일자", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
                                      											onclick: function(){
                                      	       											var date = Common.search.getValue(fnObj.search.target, "bookDate").date();
                                      	       											date.setDate(date.getDate()-1);
                                      	        											Common.search.setValue(fnObj.search.target, "bookDate", date.print());
                                      	       											$("#ax-page-btn-search").click();
                                      	       										}
                                      	       									},
                                      	                                      		{label:"", labelWidth:"", type:"inputText", width:"100", key:"bookDate", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                      	                                           	AXBind:{
                                      	                   								type:"date", config:{
                                      	                   									align:"right", valign:"top", defaultDate:new Date(),
                                      	                   									onChange:function(){
                                      	                   										setTimeout(function(){$("#ax-page-btn-search").click();}, 100);
                                      	                   									}
                                      	                   								}
                                      	                   							}
                                      	                                         	},
                                      	       									{label:"", labelWidth:"", type:"button", width:"30", key:"rightDate", addClass:"", valueBoxStyle:"", value:">",
                                      	       										onclick: function(){
                                      	       											var date = Common.search.getValue(fnObj.search.target, "bookDate").date();
                                      	       											date.setDate(date.getDate()+1);
                                      	       											Common.search.setValue(fnObj.search.target, "bookDate", date.print());
                                      	       											$("#ax-page-btn-search").click();
                                      	       										}
                                      	      									},
                                   	                    						{label:"총 예약건수 : ", labelWidth:"", type:"inputText", width:"70", key:"totalCnt", addClass:"border_none", valueBoxStyle:"readonly", value:"",
                                   	                    							onChange: function(){}
                                   	                    						},
                                   	                    						{label:"시체 : ", labelWidth:"", type:"inputText", width:"90", key:"1", addClass:"border_none", valueBoxStyle:"", value:"",
                                   	            									onChange:function(){}
                                   	                    						},
                                   	                    						{label:"개장유골 : ", labelWidth:"", type:"inputText", width:"90", key:"2", addClass:"border_none", valueBoxStyle:"", value:"",
                                   	            									onChange:function(){}
                                   	                    						},
                                   	                    						{label:"사태 : ", labelWidth:"", type:"inputText", width:"90", key:"3", addClass:"border_none", valueBoxStyle:"" , value:"",
                                   	            									onChange:function(){}
                                   	                    						},
                                      	                             	  ]}
                            ] */
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                        fnObj.drawTable();
                    }
                },
                print: function(){

                	Common.report.open("/reports/changwon/crem/CREM1022", "pdf", "from="+Common.str.replaceAll($("#info-bookDate").val(),"-","")+"&printName="+"${LOGIN_USER_ID}");

                	//$.form('/report/excel', {filename: "화장예약현황", excelFormat: $("#div-tab-content-T").html()}, 'POST').submit();
                	////$("#pdf").contents().find("head")[0].append(fnObj.css);
                	//$("#pdf").contents().find('body').html("<p align='center' style='font-size:20px;'>${PAGE_NAME}</p>"+$("#div-tab-content-T").html());

                	//setTimeout(function() {
                	//	document.getElementById("pdf").focus();
                	//	document.getElementById("pdf").contentWindow.print();
					//}, 1);
                },
                goHwacremation : function(bookDate,bookChasu,bookChasuSeq,bookStatus){
                		if(bookStatus == '미접수'){
                            window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?bookDate="
                        		+bookDate+"&bookChasu="+bookChasu+"&bookChasuSeq="+bookChasuSeq,"_blank");
            			}else{
            				toast.push("미접수 자료가 아닙니다.");
            			}
                },
                drawTable: function(){

                        app.ajax({
                            type: "GET",
                            url: "/CREM1020/hwaBooking",
                            data: "bookDate="+$("#info-bookDate").val().date().print("yyyymmdd")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                            	var contents = "<table cellpadding='0' cellspacing='0'  width='98%''  class='AXGridTable' style='border:1px solid;' >";
                            	contents +="<tr align='center' height='45px;'><td width='6%' style='border:1px solid;' class='header'>구분</td>";
                            	for(var k=0; k<Object.keys(res.booking[0]).length ; k++){
                            			contents += "<td style='border:1px solid;' class='header'>"+(k+1)+"호기</td>";
                            	}
                            	contents +="</tr>";

                            	for(var i=0; i<res.chasu.length; i++){
                            		contents +="<tr align='center' height='45px;'><td style='border:1px solid;' class='header'>";
                            		contents += res.chasu[i].chasuName + "<br>";
                            		contents += Common.pattern.custom(res.chasu[i].strttimeString+res.chasu[i].endtimeString, "99:99 - 99:99");
                            		contents +="</td style='border:1px solid;'>";
                            		for(var j=1; j<=Object.keys(res.booking[i]).length; j++){
                            			var item = res.booking[i][j];

                            			if(res.booking[i][j] != null){
                            				contents += "<td height='45px;' style='width:10%; font-size:11px; border:1px solid;text-overflow: ellipsis;' ondblclick=fnObj.goHwacremation('"+item.bookDate+"','"+item.bookChasu+"','"+item.bookChasuSeq+"',\'"+item.bookStatus+"') style='cursor:pointer'>";

                            				contents += $("#info-bookDate").val().date().print("mm-dd")+" "+res.booking[i][j].bookApplName+"<br>";
                            				contents += res.booking[i][j].bookDeadName+"<br>";
                            				 contents += res.booking[i][j].bookMobileno1.length > 0 ? res.booking[i][j].bookMobileno1
                            						+"-"+res.booking[i][j].bookMobileno2
                            						+"-"+res.booking[i][j].bookMobileno3 : " ";
                            				contents += "<br>"+res.booking[i][j].company;
                            			}else{
                            				contents += "<td style='border:1px solid; height:45px;'>";
                            			}
                            			contents += "</td>";
                                	}
                            		contents+="</tr>";
                            	}
                            	contents += "</table>";

                            	$("#div-tab-content-T").html(contents);
                            	$("#div-tab").updateTabs(fnObj.CODES.tab);
    							$("#div-contents").append($("[id^='div-tab-content-']"));
    							$("#div-content").append($("#div-tab-content-T"));

                            }
                        });
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
                                {key:"bookDeadAddr", label:"사망자 주소", width:"350", align:"left"
                                	,formatter:function(){
                                		return this.item.bookDeadAddr1+" "+ this.item.bookDeadAddr2;
                                	}
                                },
                                {key:"company", label:"발인지", width:"130", align:"left" },


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
                                {key:"bookApplAddr", label:"신청자 주소", width:"350", align:"left"
                                	,formatter:function(){
                                		return this.item.bookApplAddr1+" "+ this.item.bookApplAddr2;
                                	}
                                },
                                {key:"bookRelation", label:"사망자와의관계", width:"150", align:"left"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.applRelation.length; i++){
                                    		if(fnObj.CODES.applRelation[i].optionValue == this.value){
                                    			return fnObj.CODES.applRelation[i].optionText;
                                    		}
                                    	}
                                    	//return this.value;
                                	}
                                },
                                {key:"bookMobileString", label:"휴대전화", width:"100", align:"center"
                                	,formatter:function(){
                                		return this.item.bookMobileno1.length > 0 ? this.item.bookMobileno1+"-"+ this.item.bookMobileno2+"-"+this.item.bookMobileno3 : "";
                                	}
                                },
                                {key:"bookTelString", label:"전화번호", width:"100", align:"center"
                                	,formatter:function(){
                                		return this.item.bookTelno1.length > 0 ? this.item.bookTelno1+"-"+ this.item.bookTelno2+"-"+this.item.bookTelno3 : "";
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
	                                    window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?bookDate="
                                    		+this.item.bookDate+"&bookChasu="+this.item.bookChasu+"&bookChasuSeq="+this.item.bookChasuSeq,"_blank");
                        			}else{
                        				toast.push("미접수 자료가 아닙니다.");
                        			}
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
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                         app.ajax({
                             type: "GET",
                             url: "/CREM1020/hwaBookingList",
                             data: "bookDate="+Common.str.replaceAll($("#info-bookDate").val(),"-","")
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var sisinCnt = 0;
                            	 var ugolCnt = 0;
                            	 var sasanlCnt = 0;

                            	 var gridData = {
                            		 list: (function(){
                                    	 for(var i=0; i<res.length; i++){

                                    		 if(res[i].bookBurnObjt == "TMC0200001"){
                                				 sisinCnt+=1;
                                			 }else if(res[i].bookBurnObjt == "TMC0200002"){
                                				 ugolCnt+=1;
                                			 }else if(res[i].bookBurnObjt == "TMC0200003"){
                                				 sasanlCnt+=1;
                                			 }

                                    		 for(var key in res[i]){
                                    			 res[i][key]=res[i][key];
                                    		 }
                                    	 }
                                    	 return res;
                                     }())

                                 };

                                 $("#info-sisin").html(sisinCnt);
                                 $("#info-ugol").html(ugolCnt);
                                 $("#info-sasan").html(sasanlCnt);
                                 $("#info-totalCnt").html(res.length+0+ " 건)");


                                 _target.setData(gridData);
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>