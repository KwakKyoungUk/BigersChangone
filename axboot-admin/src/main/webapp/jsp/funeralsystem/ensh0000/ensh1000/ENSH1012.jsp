<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="봉안맵" />
	<ax:set name="page_desc" value="" />
	<ax:div name="css">
	        <style type="text/css" id="css">

	            .block_td {
	            	width:60px;
	            	height: 40px;
	            	text-align: center;

	            }
	        </style>
	    </ax:div>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 봉안맵</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="sbar">
					<form id="form-search">
						<span class="sitem"> <span class="slabel">봉안당구분</span> <select
							id="locCode" name="locCode" class="AXSelect W100"></select>
						</span> <span class="sitem"> <span class="slabel">층</span> <select
							id="floorCode" name="floorCode" class="AXSelect W100"></select>
						</span> <span class="sitem"> <span class="slabel">호실</span> <select
							id="roomCode" name="roomCode" class="AXSelect W100"></select>
						</span> <span class="sitem"> <span class="slabel">블록</span> <select
							id="blockNum" name="blockNum" class="AXSelect W100"></select>
						</span>
					</form>
				</div>

				<ax:custom customid="table">
	                <ax:custom customid="tr">
	                    <ax:custom customid="td" style="width: 14%;">
	                    	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 개인단 호실 목록</h2>
			                    </div>
			                    <div class="left">
			                    </div>
			                </div>
			                <div class="ax-clear"></div>
							<div class="ax-grid" id="page-grid-box" style="min-height: 300px;" ></div>
							<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 부부단 호실 목록</h2>
			                    </div>
			                    <div class="left">
			                    </div>
			                </div>
			                <div class="ax-clear"></div>
							<div class="ax-grid" id="page-grid-box2" style="min-height: 250px;"></div>
	                    </ax:custom>
	                    <ax:custom customid="td" style="width: 20%;">
	                    	<div class="ax-button-group">
			                    <div class="left">
			                    </div>
			                    <div class="left">
			                    </div>
			                </div>
	                    	 <table id="tb-block" cellpadding="0" cellspacing="0"  border="1">
								    <tbody>
								    	<tr>
								    		<td id="1" class="block_td">1블록</td>
								    		<td id="2" class="block_td">2블록</td>
								    		<td id="3" class="block_td">3블록</td>
								    		<td id="4" class="block_td">4블록</td>
								    		<td id="5" class="block_td">5블록</td>
								    	</tr>
								    	<tr>
								    		<td id="6" class="block_td">6블록</td>
								    		<td id="7" class="block_td">7블록</td>
								    		<td id="8" class="block_td">8블록</td>
								    		<td id="9" class="block_td">9블록</td>
								    		<td id="10" class="block_td">10블록</td>
								    	</tr>
								    	<tr>
								    		<td id="11" class="block_td">11블록</td>
								    		<td id="12" class="block_td">12블록</td>
								    		<td id="13" class="block_td">13블록</td>
								    		<td id="14" class="block_td">14블록</td>
								    		<td id="15" class="block_td">15블록</td>
								    	</tr>
								    	<tr>
								    		<td id="16" class="block_td">16블록</td>
								    		<td id="17" class="block_td">17블록</td>
								    		<td id="18" class="block_td">18블록</td>
								    		<td id="19" class="block_td">19블록</td>
								    		<td id="20" class="block_td">20블록</td>
								    	</tr>
								    	<tr>
								    		<td id="21" class="block_td">21블록</td>
								    		<td id="22" class="block_td">22블록</td>
								    		<td id="23" class="block_td">23블록</td>
								    		<td id="24" class="block_td">24블록</td>
								    		<td id="25" class="block_td">25블록</td>
								    	</tr>
								    </tbody>
								</table>
								<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 반출 호실 목록</h2>
			                    </div>
			                    <div class="left">
			                    </div>
			                </div>
								<div class="ax-grid" id="page-grid-box3" style="min-height: 350px;"></div>
	                    </ax:custom>
	                    <ax:custom customid="td" style="width: 64%;">
							<div class="ax-button-group">
			                    <div class="left">
			                        <p>사용하고자 하는 봉안함 번호를 더블클릭해주세요.</p>
			                    </div>
			                    <div class="right">
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>

			   				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/NTFM1000003.gif" alt="사용가능" >
								<figcaption>사용가능</figcaption>
							</figure>
							<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/UTFM1000001E.gif" alt="개인안치" >
								<figcaption>개인안치</figcaption>
							</figure>
			   				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/UTFM1000004E.gif" alt="무연고" >
								<figcaption>무연고</figcaption>
							</figure>
							<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/RTFM1000003.gif" alt="반출이동" >
								<figcaption>반출이동</figcaption>
							</figure>
			   				<!-- <figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/UTFM1000003.gif" alt="부부단장" >
								<figcaption>부부단장</figcaption>
							</figure> -->
							<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/UTFM1000003E.gif" alt="부부안치" >
								<figcaption>부부안치</figcaption>
							</figure>
							<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
								<img src="/static/map/ens/XTFM1000004E.gif" alt="수리중" >
								<figcaption>수리중</figcaption>
							</figure>

			                 <div style="overflow:auto;">
				                 <table id="tb-matrix" cellpadding="0" cellspacing="0"  border="1">
								    <tbody>
								    </tbody>
								</table>
							</div>
							<table id="tb-ensdead" cellpadding="0" cellspacing="0"  border="1" class="AXGridTable" style="position: absolute; width: 400px; display: none; background-color: white;">
								<thead>
									<tr>
										<td width="80" align="center">
											<div class="tdRel">
			                          			봉안함 번호
			                                </div>
										</td>
										<td width="80" align="center">
											<div class="tdRel">
			                          			고인명
			                                </div>
										</td>
										<td width="80" align="center">
											<div class="tdRel">
			                          			신청자
			                                </div>
										</td>
										<td width="160" align="center">
											<div class="tdRel">
			                          			기간
			                                </div>
										</td>
									</tr>
								</thead>
								<tbody>

								</tbody>
	                    </ax:custom>
	                </ax:custom>
				</ax:custom>

				</table>
			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">자동배정</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">

			var fnObj = {
                CODES: {
                	"locCode": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/ENSH3010/enslocSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
            		"floorCode": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/ENSH3030/ensfloorSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "direction" : Common.getCode("DIRECTION"),
                    "usingStatus" : Common.getCode("USING_STATUS"),
                    "roomCode": (function(){
						var result;
			        	app.ajax({
			        			async: false,
			                    type: "GET",
			                    url: "/ENSH3030/ensRoom/option",
			                    data: ""
			                },
			                function(res){
			                	result = res;
			            	}
			            );
			        	return result;
					}())
                },
				possible:{
					roomCode:null
					, blockNum:null
				},
				pageStart: function(){
					this.getPossible();
					this.grid.bind();
					this.grid2.bind();
					this.grid3.bind();
					this.bindEvent();
					this.search.bind();
// 					setTimeout(this.initMap, 500);

					fnObj.grid.setPage();
					fnObj.grid2.setPage();
					fnObj.grid3.setPage(0,'${param.ensType}');
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				ensType:"${param.ensType}",
				bindEvent: function(){
					$("#locCode").bindSelect({
                        ajaxUrl: "/ENSH3010/findEnsloc", ajaxPars: "", method:"GET", ajaxAsync:false,
                       // isspace: true, isspaceTitle: "선택하세요",
                        setValue:this.optionValue,
                        alwaysOnChange: true,
                        reserveKeys: {
            				options: "list",
            				optionValue: "locCode",
            				optionText: "locName"
            			},
                        onChange: function(){

                        	var locCode = this.optionValue;
                            $("#floorCode").bindSelect({
                                ajaxUrl: "/ENSH3020/findEnsfloor", ajaxPars: "locCode="+locCode, method:"GET", ajaxAsync:false,
                                //isspace: true, isspaceTitle: "선택하세요",
                                setValue:fnObj.possible.floorCode,
                                alwaysOnChange: true,
                                reserveKeys: {
                     				options: "list",
                     				optionValue: "floorCode",
                     				optionText: "charnClassName"
                     			},
                                onChange: function(){
                                	var floorCode = this.optionValue;


                                    $("#roomCode").bindSelect({
			                             ajaxUrl: "/ENSH3030/findEnsroom", ajaxPars: "locCode="+locCode+"&floorCode="+floorCode,  method:"GET", ajaxAsync:false,
			                             //isspace: true, isspaceTitle: "선택하세요",
			                             reserveKeys: {
			                   				options: "list",
			                   				optionValue: "roomCode",
			                   				optionText: "roomName"
			                   			},
										setValue:fnObj.possible.roomCode,
										alwaysOnChange: true,
										onChange: function(){

			                            	 var roomCode = this.optionValue;
			                            	  $("#blockNum").bindSelect({
			                                        ajaxUrl: "/ENSH3040/findMatrix", ajaxPars: "locCode="+locCode+"&floorCode="+floorCode+"&roomCode="+roomCode,  method:"GET", ajaxAsync:false,
			                                        //isspace: true, isspaceTitle: "선택하세요",
			                                        reserveKeys: {
					                      				options: "list",
					                      				optionValue: "blockNum",
					                      				optionText: "blockNum"
					                      			},
			                                        setValue:fnObj.possible.blockNum,
			                                        alwaysOnChange: true,
			                                        onChange: function(_this){

														fnObj.initMap();

			                                        }
			                                    });
			                             }
			                         });
                                }
                            });
                        }
                    });

					$(".block_td").bind("click",function(){
						var blockNum = parseInt($(this).attr("id"));
						setTimeout(function(){
                    		$("#blockNum").bindSelectSetValue(blockNum);
                    	}, 150);
					});
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

                             mediaQuery: {
                             mx:{min:"N", max:250}, dx:{min:250}
                             },

                            colGroup : [
								{key:"floorCode", label:"층", width:"120", align:"left"
									, formatter: function(){
										return Common.grid.codeFormatter("floorCode", this.item.locCode+this.item.floorCode);
									}
								},
                                {key:"roomCode", label:"호실", width:"120", align:"left"
                                	, formatter: function(){
                                		//console.log(this.item.locCode+this.item.floorCode+this.item.roomCode);
                                		return Common.grid.codeFormatter("roomCode", this.item.locCode+this.item.floorCode+this.item.roomCode);
                                	}
                                },
                                {key:"ensNo", label:"시작번호", width:"100",

                                },


                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    console.log(this);
                                    var locCode = this.item.locCode;
									var roomCode = this.item.roomCode;
									var floorCode = this.item.floorCode;


									setTimeout(function(){
                                		$("#locCode").bindSelectSetValue(locCode);

                                	}, 200);

                                	setTimeout(function(){
                                		$("#floorCode").bindSelectSetValue(floorCode);

                                	}, 500);

                                	setTimeout(function(){
                                		$("#roomCode").bindSelectSetValue(roomCode);

                                	}, 900);
                                	
                                	fnObj.grid3.setPage(0,'TFM1000001');
                                	//fnObj.possible.floorCode = this.item.floorCode;
    	                    		//fnObj.possible.roomCode = this.item.roomCode;
    	                    		//fnObj.possible.blockNum = this.item.blockNum;
                                }
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
                             url: "/ENSH1016/ensmap/ensRoom",
                             data: "ensType=TFM1000001"
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
                },
                grid2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box2",
                            theme : "AXGrid",
                            colHeadAlign:"center",

                             mediaQuery: {
                             mx:{min:"N", max:200}, dx:{min:200}
                             },

                            colGroup : [
								{key:"floorCode", label:"층", width:"120", align:"left"
									, formatter: function(){
										return Common.grid.codeFormatter("floorCode", this.item.locCode+this.item.floorCode);
									}
								},        
                                {key:"roomCode", label:"호실", width:"120", align:"left"
                                	, formatter: function(){
                                		return Common.grid.codeFormatter("roomCode", this.item.locCode+this.item.floorCode+this.item.roomCode);
                                	}
                                },
                                {key:"ensNo", label:"시작번호", width:"100",

                                },

                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    console.log(this);
                                    var locCode = this.item.locCode;
									var roomCode = this.item.roomCode;
									var floorCode = this.item.floorCode;
									
									
									setTimeout(function(){
                                		$("#locCode").bindSelectSetValue(locCode);

                                	}, 200);

                                	setTimeout(function(){
                                		$("#floorCode").bindSelectSetValue(floorCode);

                                	}, 600);

                                	setTimeout(function(){
                                		$("#roomCode").bindSelectSetValue(roomCode);

                                	}, 900);
                              	
                                	fnObj.grid3.setPage(0,'TFM1000003');
                                	//fnObj.possible.floorCode = this.item.floorCode;
    	                    		//fnObj.possible.roomCode = this.item.roomCode;
    	                    		//fnObj.possible.blockNum = this.item.blockNum;
                                }
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
                              url: "/ENSH1016/ensmap/ensRoom",
                              data: "ensType=TFM1000003"
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
                },
                grid3: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box3",
                            theme : "AXGrid",
                            colHeadAlign:"center",

                             mediaQuery: {
                             mx:{min:"N", max:200}, dx:{min:200}
                             },

                            colGroup : [
								{key:"floorCode", label:"층", width:"120", align:"left"
									, formatter: function(){
										return Common.grid.codeFormatter("floorCode", this.item.locCode+this.item.floorCode);
									}
								},
                                {key:"roomCode", label:"호실", width:"120", align:"left"
                                	, formatter: function(){
                                		return Common.grid.codeFormatter("roomCode", this.item.locCode+this.item.floorCode+this.item.roomCode);
                                	}
                                },
                                {key:"blockNum", label:"블럭번호", width:"80",

                                },

                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    console.log(this);
                                    var locCode = this.item.locCode;
									var roomCode = this.item.roomCode;
									var blockNum = this.item.blockNum;
									var floorCode = this.item.floorCode;
									
									
									setTimeout(function(){
                                		$("#locCode").bindSelectSetValue(locCode);

                                	}, 200);

                                	setTimeout(function(){
                                		$("#floorCode").bindSelectSetValue(floorCode);

                                	}, 500);

                                	setTimeout(function(){
                                		$("#roomCode").bindSelectSetValue(roomCode);

                                	}, 900);

                                	setTimeout(function(){
                                		$("#blockNum").bindSelectSetValue(blockNum);
                                	}, 1600);


                                	//fnObj.possible.floorCode = this.item.floorCode;
    	                    		//fnObj.possible.roomCode = this.item.roomCode;
    	                    		//fnObj.possible.blockNum = this.item.blockNum;
                                }
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
                             url: "/ENSH1016/ensmap/"+searchParams+"/R",
                             data: ""
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
                },
				control: {
					save: function(){

						var matrixSize = fnObj.matrixInfo.maxCol*fnObj.matrixInfo.maxRow;
						var ensNo = function(){
							var ensNo = '';
							for(var i=matrixSize-1; i>=0; i--){
								for(var j=fnObj.matrix.length-1; j>=0;j--){
									for(var k=fnObj.matrix[j].length-1; k>=0; k--){
										if(fnObj.matrix[j][k].index == i){
											if(fnObj.matrix[j][k].isWaste==false){
												if(fnObj.matrix[j][k].item.usingStatus == "U"){
													return ensNo;
												}
												if(fnObj.matrix[j][k].item.usingStatus == "N" && fnObj.matrix[j][k].item.ensKind == '${param.ensType}'){
													ensNo = fnObj.matrix[j][k].item.ensNo;
													if(i==0){
														return ensNo;
													}
												}
											}
										}
									}
								}
							}
						}();

						if(!ensNo){
							 //$('#blockNum option:selected').next().attr('selected', 'selected');
							//$("#blockNum :selected").val()

							//initMap()
							alert("현재 봉안실에 사용가능한 봉안번호가 없습니다.");
							return;
						}

						app.modal.save("${callBack}", ensNo);

					},
					cancel: function(){
						app.modal.cancel();
					}
				},
				getPossible: function(){

					app.ajax({
	            			async: false,
	                        type: "GET",
	                        url: "/ENSH1016/ensmap/${param.ensType}",
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		fnObj.possible.floorCode = res.map.ensmapVTO.floorCode;
	                    		fnObj.possible.roomCode = res.map.ensmapVTO.roomCode;
	                    		fnObj.possible.blockNum = res.map.ensmapVTO.blockNum;
	                    	}
	                	}
	                );
				},
				direction:{
                	LRLR:function(row, col){
                		var matrix = [];
                		for(var i=0; i<row*col; i++){
                			var rowIdx = Math.floor(i/col);
                    		if(!matrix[rowIdx]){
                    			matrix[rowIdx]=[];
                    		}
                   			matrix[rowIdx].push({
                   				index:i
                   				, row:rowIdx
                   				, isWaste:true
                   				});
                    	}
                		return matrix;
                	}
                	, LRRL:function(row, col){
                		var matrix = this.LRLR(row, col);
                		for(var i=1; i<matrix.length; i+=2){
                			matrix[i] = matrix[i].reverse();
                		}
                		return matrix;
                	}
                	, RLRL:function(row, col){
                		var matrix = this.LRLR(row, col);
                		for(var i=0; i<matrix.length; i++){
                			matrix[i] = matrix[i].reverse();
                		}
                		return matrix;
                	}
                	, RLLR:function(row, col){
                		var matrix = this.LRLR(row, col);
                		for(var i=0; i<matrix.length; i+=2){
                			matrix[i] = matrix[i].reverse();
                		}
                		return matrix;
                	}
                },
                matrixInfo: null,
                initMap: function(){
					app.ajax({
							async: false,
						    type: "GET",
						    url: "/ENSH3050/ensmatrix/"+$("#locCode :selected").val()+"/"+$("#floorCode :selected").val()+"/"+$("#roomCode :selected").val()+"/"+$("#blockNum :selected").val(),
						    data: ""
						},
						function(res){
							fnObj.matrixInfo = res.map.ensmatrixVTO;
						}
					);
               		fnObj.matrix = fnObj.direction[fnObj.matrixInfo.direction](fnObj.matrixInfo.maxRow, fnObj.matrixInfo.maxCol);
					app.ajax({
							async: false,
						    type: "GET",
						    url: "/ENSH3050/ensmap",
						    data: fnObj.search.target.getParam()
						},
						function(res){
							fnObj.mapItems = res.list;
						}
					);
					for(var i=0; i<fnObj.mapItems.length; i++){
						fnObj.mapItems[i].beforeEnsNo = fnObj.mapItems[i].ensNo
					}
               		for(var i=0; i<fnObj.matrix.length; i++){
                		for(var j=0; j<fnObj.matrix[i].length; j++){
		                	for(var k=0; k<fnObj.mapItems.length; k++){
		                		if(fnObj.mapItems[k].mapIdx == fnObj.matrix[i][j].index){
		                			fnObj.matrix[i][j].item = fnObj.mapItems[k];
		                			fnObj.matrix[i][j].isWaste = false;
		                			break;
		                		}
		                	}
                		}
                	}
               		$("#tb-matrix").css("width", fnObj.matrix[0].length*55+"px");
        			$("#tb-matrix").bind("mouseout", function(){
        				$("#tb-ensdead").hide();
       				});
               		fnObj.drawMap();
               		parent.myModal.resize();
                },
                matrix: null,
                mapItems: null,
                drawMap: function(){
                	$("#tb-matrix tbody tr").remove();
                	for(var i=0; i<fnObj.matrix.length; i++){
                		var tr = document.createElement("tr");
                		for(var j=0; j<fnObj.matrix[i].length; j++){
                			var td = document.createElement("td");
                			$(td).attr("row", i);
                			$(td).attr("col", j);
                 			//$(td).attr("width", 500);
                			$(td).attr("height", 55);
                        	$(td).attr("align", "center");
                			if(fnObj.matrix[i][j].isWaste){
                				$(td).addClass("wasteRowcolNum");
                			}else{
	                			$(td).html(fnObj.getItemHTML(fnObj.matrix[i][j].item));
                			}
                			$(td).bind("mouseover", function(event){
                				var row = $(this).attr("row");
                				var col = $(this).attr("col");
                				//console.log("row : " + row);
                				//console.log("col : " + col);
                				if(fnObj.matrix[row][col].isWaste){
                				}else{
                					var enshrineVTO = fnObj.matrix[row][col].item.enshrineVTO;
                					if(!enshrineVTO){
                						return;
                					}
                					var positionX = event.pageX;
                					var winSize = $("#tb-ensdead").width();
                					//console.log(positionX);
									if(positionX >= fnObj.matrix[0].length*50-winSize ){
										positionX = event.pageX-winSize;
									}
                					$("#tb-ensdead").css("left", positionX);
                					$("#tb-ensdead").css("top", event.pageY);
                					$("#tb-ensdead").show();

                					$("#tb-ensdead tbody tr").remove();
                					for(var i=0; i<enshrineVTO.ensdeadVTOList.length; i++){
                						var tr = document.createElement("tr");
                						var tdEnsNo = document.createElement("td");
                						var tdDead = document.createElement("td");
                						var tdAppl = document.createElement("td");
                						var tdPeriod = document.createElement("td");
                						$(tdEnsNo).append("<div class='tdRel' align='center'>"+enshrineVTO.ensNo+"</div>");
                						$(tdDead).append("<div class='tdRel' align='center'>"+enshrineVTO.ensdeadVTOList[i].thedeadVTO.deadName+"</div>");
                						$(tdAppl).append("<div class='tdRel' align='center'>"+enshrineVTO.applicantVTO.applName+"</div>");
                						$(tdPeriod).append("<div class='tdRel' align='center'>"
                														+enshrineVTO.extStrDateString.date().print("yyyy-mm-dd")
                														+"~"+enshrineVTO.extEndDateString.date().print("yyyy-mm-dd")+"</div>");
                						$(tr).append(tdEnsNo);
                						$(tr).append(tdDead);
                						$(tr).append(tdAppl);
                						$(tr).append(tdPeriod);
										$("#tb-ensdead tbody").append(tr);
                					}
                				}

                			});
                			$(td).bind("dblclick", function(event){
                				var row = $(this).attr("row");
                				var col = $(this).attr("col");
                				if(fnObj.matrix[row][col].isWaste || (fnObj.matrix[row][col].item.maxCnt == fnObj.matrix[row][col].item.ensCnt && fnObj.matrix[row][col].item.usingStatus != "R")){
                					return;
                				}
                				app.modal.save("${callBack}", fnObj.matrix[row][col].item.ensNo);
                			});
	                		$(tr).append(td);
                		}
                		$("#tb-matrix tbody").append(tr);
                	}
                }
                , getItemHTML: function(item){
                	var ensNoDiv = document.createElement("div");
                	$(ensNoDiv).css("text-align", "center");
                	$(ensNoDiv).css("font-size", 8);
                	$(ensNoDiv).html(item.ensNo);
                	var img = document.createElement("img");
                	var imgSrc = "/static/map/ens/";
                	var maxStr = "";
                	if(item.maxCnt == item.ensCnt){
                		maxStr = "E";
                	}
               		imgSrc = imgSrc+item.usingStatus+item.ensKind+maxStr+".gif";
                	$(img).attr("src", imgSrc);
                	var wrapDiv = document.createElement("div");
                	$(wrapDiv).append(img);
                	$(wrapDiv).append(ensNoDiv);
                	return $(wrapDiv).html();
                }
                , search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"form-search",
                            theme : "AXSearch",

                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.

                                fnObj.search.submit();
                            },

                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                        fnObj.grid2.setPage(fnObj.grid2.pageNo, pars);
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