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
                                <div >μμ½μΌμ</div>
                            </th>
                            <td>
                                <div >
                                	<input id="info-leftDate" name="leftDate" type="button" class="AXButton"  value=" < " />
                                    <input id="info-bookDate" name="bookDate " type="text"   value="" class="AXInput W100" />
                                    <input id="info-rightDate" name="rightDate "type="button" class="AXButton"  value=" > " />
                                </div>
                            </td>
                            <th>
                                <div >(μ΄ μμ½ κ±΄μ : </div>
                            </th>
                            <td id="info-totalCnt">
                            </td>
                             <th>
                                <div >μμ²΄ : </div>
                            </th>
                            <td id="info-sisin" align="center" width="40">
                            </td>
                            <th>
                                <div >κ°μ₯μ κ³¨ : </div>
                            </th>
                            <td id="info-ugol" align="center" width="40">
                            </td>
                            <th>
                                <div >μ¬ν : </div>
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
                					{optionValue:"T", optionText:"λν", closable:false},
           			 ],
			         "tab": [
                				{optionValue:"T", optionText:"λν", closable:false},
                				{optionValue:"L", optionText:"λ¦¬μ€νΈ", closable:false}
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
                    $("#ax-page-btn-fn2").html("<i class=\"axi axi-print\"></i> λν");
                    $("#ax-page-btn-fn2").bind("click", function(){
                        setTimeout(function() {
                        	fnObj.print();
                        }, 500);
                    });
                    $("#ax-page-btn-fn3").html("<i class=\"axi axi-print\"></i> μΆλ ₯");
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
                                // λ²νΌμ΄ μ μΈλμ§ μμκ±°λ submit κ°μ²΄κ° μλ κ²½μ° λ°λ ν©λλ€.
                                //fnObj.search.submit();
                                fnObj.drawTable();
                            },
                            /* rows:[
                                  {display:true, addClass:"", style:"", list:[
                                      										{label:"μμ½ μΌμ", labelWidth:"", type:"button", width:"30", key:"leftDate", addClass:"", valueBoxStyle:"", value:"<",
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
                                   	                    						{label:"μ΄ μμ½κ±΄μ : ", labelWidth:"", type:"inputText", width:"70", key:"totalCnt", addClass:"border_none", valueBoxStyle:"readonly", value:"",
                                   	                    							onChange: function(){}
                                   	                    						},
                                   	                    						{label:"μμ²΄ : ", labelWidth:"", type:"inputText", width:"90", key:"1", addClass:"border_none", valueBoxStyle:"", value:"",
                                   	            									onChange:function(){}
                                   	                    						},
                                   	                    						{label:"κ°μ₯μ κ³¨ : ", labelWidth:"", type:"inputText", width:"90", key:"2", addClass:"border_none", valueBoxStyle:"", value:"",
                                   	            									onChange:function(){}
                                   	                    						},
                                   	                    						{label:"μ¬ν : ", labelWidth:"", type:"inputText", width:"90", key:"3", addClass:"border_none", valueBoxStyle:"" , value:"",
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

                	//$.form('/report/excel', {filename: "νμ₯μμ½νν©", excelFormat: $("#div-tab-content-T").html()}, 'POST').submit();
                	////$("#pdf").contents().find("head")[0].append(fnObj.css);
                	//$("#pdf").contents().find('body').html("<p align='center' style='font-size:20px;'>${PAGE_NAME}</p>"+$("#div-tab-content-T").html());

                	//setTimeout(function() {
                	//	document.getElementById("pdf").focus();
                	//	document.getElementById("pdf").contentWindow.print();
					//}, 1);
                },
                goHwacremation : function(bookDate,bookChasu,bookChasuSeq,bookStatus){
                		if(bookStatus == 'λ―Έμ μ'){
                            window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?bookDate="
                        		+bookDate+"&bookChasu="+bookChasu+"&bookChasuSeq="+bookChasuSeq,"_blank");
            			}else{
            				toast.push("λ―Έμ μ μλ£κ° μλλλ€.");
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
                            	contents +="<tr align='center' height='45px;'><td width='6%' style='border:1px solid;' class='header'>κ΅¬λΆ</td>";
                            	for(var k=0; k<Object.keys(res.booking[0]).length ; k++){
                            			contents += "<td style='border:1px solid;' class='header'>"+(k+1)+"νΈκΈ°</td>";
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
                                //{key:"index", label:"μ ν", width:"35", align:"center", formatter:"checkbox"},
                                {key:"bookChasu", label:"μ°¨μ", width:"60", align:"center"},
                                {key:"time", label:"μκ°", width:"100", align:"center"
                                },
                                {key:"bookChasuSeq", label:"νΈκΈ°", width:"60", align:"center"
                                	,formatter:function(){
                                		return parseInt(this.value);
                                	}
                                },
                                {key:"bookDeadName", label:"κ³ μΈλͺ", width:"100", align:"center"},
                                {key:"bookDeadJumin", label:"μ£Όλ―Όλ²νΈ", width:"120", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"bookDeadDate", label:"μ¬λ§μΌμ", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.value){
	                                		return this.value.date().print("yyyy.mm.dd");
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"bookDeadAddr", label:"μ¬λ§μ μ£Όμ", width:"350", align:"left"
                                	,formatter:function(){
                                		return this.item.bookDeadAddr1+" "+ this.item.bookDeadAddr2;
                                	}
                                },
                                {key:"company", label:"λ°μΈμ§", width:"130", align:"left" },


                                /* {key:"bookBurnObjt", label:"λμκ΅¬λΆ", width:"150", align:"center"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.bookBurnObjt.length; i++){
                                    		if(fnObj.CODES.bookBurnObjt[i].optionValue == this.value){
                                    			return fnObj.CODES.bookBurnObjt[i].optionText;
                                    		}
                                    	}
                                    	return this.value;
                                	}
                                }, */

                                {key:"bookApplName", label:"μ μ²­μλͺ", width:"100", align:"center"},
                                {key:"bookApplJumin", label:"μ μ²­μμ£Όλ―Όλ²νΈ", width:"120", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"bookApplAddr", label:"μ μ²­μ μ£Όμ", width:"350", align:"left"
                                	,formatter:function(){
                                		return this.item.bookApplAddr1+" "+ this.item.bookApplAddr2;
                                	}
                                },
                                {key:"bookRelation", label:"μ¬λ§μμμκ΄κ³", width:"150", align:"left"
                                	, formatter:function(val){
                                    	for(var i=0; i<fnObj.CODES.applRelation.length; i++){
                                    		if(fnObj.CODES.applRelation[i].optionValue == this.value){
                                    			return fnObj.CODES.applRelation[i].optionText;
                                    		}
                                    	}
                                    	//return this.value;
                                	}
                                },
                                {key:"bookMobileString", label:"ν΄λμ ν", width:"100", align:"center"
                                	,formatter:function(){
                                		return this.item.bookMobileno1.length > 0 ? this.item.bookMobileno1+"-"+ this.item.bookMobileno2+"-"+this.item.bookMobileno3 : "";
                                	}
                                },
                                {key:"bookTelString", label:"μ νλ²νΈ", width:"100", align:"center"
                                	,formatter:function(){
                                		return this.item.bookTelno1.length > 0 ? this.item.bookTelno1+"-"+ this.item.bookTelno2+"-"+this.item.bookTelno3 : "";
                                	}
                                },




                                /*
                                {key:"receiveymd", label:"μ μμΌμ", width:"150", align:"center"
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

                                {key:"bookingType", label:"μ μκ²½λ‘", width:"150", align:"center"
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

//                                {key:"bookStatus", label:"μν", width:"150", align:"center"
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
                            		if(this.item.bookStatus == 'λ―Έμ μ'){
	                                    window.open("/jsp/funeralsystem/crem0000/crem2000/CREM2010.jsp?bookDate="
                                    		+this.item.bookDate+"&bookChasu="+this.item.bookChasu+"&bookChasuSeq="+this.item.bookChasuSeq,"_blank");
                        			}else{
                        				toast.push("λ―Έμ μ μλ£κ° μλλλ€.");
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
                                 $("#info-totalCnt").html(res.length+0+ " κ±΄)");


                                 _target.setData(gridData);
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>