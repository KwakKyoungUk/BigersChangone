<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
      <ax:div name="css">
        <style type="text/css">
            .wasteRowcolNum { background-color: lightgray !important; font-size: 20px; }

        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<form id="page-search-box">
                      <div class="sbar">
                      <span class="sitem">
                             <span class="slabel">봉안당구분</span>
                              <select id="locCode" name="locCode" class="AXSelect W100" ></select>
                         </span>
                      <span class="sitem">
                             <span class="slabel">층</span>
                             <select id="floorCode" name="floorCode" class="AXSelect W100" ></select>
                         </span>
                         <span class="sitem">
                             <span class="slabel">호실</span>
                             <select id="roomCode" name="roomCode" class="AXSelect W100" ></select>
                         </span>
                           <span class="sitem">
                             <span class="slabel">블록</span>
                             <select id="blockNum" name="blockNum" class="AXSelect W100" ></select>
                         </span>
                     </div>

                 </form>
                 <div class="ax-clear"></div>
				 <input id="row" name="row" type="hidden" class="AXInput" readonly="readonly">
				 <input id="col" name="col" type="hidden" class="AXInput" readonly="readonly">
                 <ax:form id="form-info" name="form-info">
                 	<ax:fields>
	                 	<ax:field><span>봉안 정보를 수정하시려면 컨트롤키를 누른상태에서 클릭 후 수정해 주시기 바랍니다.</span></ax:field>
                 	</ax:fields>
                 	<ax:fields>
                 		<ax:field label="봉안함번호">
		                 	<input id="info-ensNo" name="ensNo" type="text" class="AXInput" readonly="readonly">
                 		</ax:field>
                 		<ax:field label="안치구분">
							<select id="info-ensKind" name="ensKind" class="AXSelect" ></select>
                 		</ax:field>
                 		<ax:field label="최대인원">
		                 	<input id="info-maxCnt" name="maxCnt" type="number" class="AXInput">
                 		</ax:field>
                 		<ax:field label="상태">
							<select id="info-usingStatus" name="usingStatus" class="AXSelect" ></select>
                 		</ax:field>
                 		<ax:field label="비고">
		                 	<input id="info-remark" name="remark" type="text" class="AXInput">
                 		</ax:field>
                 	</ax:fields>
                 </ax:form>
<!--                  <img src="/static/map/ens/map_status.gif"> -->
   				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/사용가능.gif" alt="사용가능" >
<!-- 					<figcaption>사용가능</figcaption> -->
				</figure>
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/개인안치.gif" alt="개인안치" >
<!-- 					<figcaption>개인안치</figcaption> -->
				</figure>
   				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/무연고.gif" alt="무연고" >
<!-- 					<figcaption>무연고</figcaption> -->
				</figure>
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/반출이동.gif" alt="반출이동" >
<!-- 					<figcaption>반출이동</figcaption> -->
				</figure>
   				<!-- <figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/부부단장.gif" alt="부부단장" >
					<figcaption>부부단장</figcaption>
				</figure> -->
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/부부안치.gif" alt="부부안치" >
<!-- 					<figcaption>부부안치</figcaption> -->
				</figure>
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/수리중.gif" alt="수리중" >
<!-- 					<figcaption>수리중</figcaption> -->
				</figure>
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/봉안맵-아이콘_환풍기.gif" alt="환풍기" >
<!-- 					<figcaption>수리중</figcaption> -->
				</figure>
				<figure style="display: inline-block; text-align: center; width: 50px; margin: 0px; font-size: 9px;">
					<img src="/static/map/ens/봉안맵-아이콘_실공실.gif" alt="실공실" >
<!-- 					<figcaption>수리중</figcaption> -->
				</figure>

                 <div style="overflow:auto;">
	                 <table id="tb-matrix" cellpadding="0" cellspacing="0"  border="1">
					    <tbody>
					    </tbody>
					</table>
				</div>

              </ax:col>
        </ax:row>


    </ax:div>

    <ax:div name="scripts">

        <script type="text/javascript">


            var fnObj = {
            	mapSize : 0,
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
                    "ensType" : Common.getCode("TFM10"),
                    "direction" : Common.getCode("DIRECTION"),
                    "usingStatus" : Common.getCode("USING_STATUS"),


                },
                pageStart: function(){

                    this.search.bind();
                    this.form.bind();
                    this.bindEvent();
                    //this.search.submit();
					setTimeout(fnObj.initMap, 500);
                },
                bindEvent: function(){
                    var _this = this;
                     $("#ax-page-btn-search").bind("click", function(){
                        _this.initMap();
                    });

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
	                                setValue:this.optionValue,
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
											setValue:this.optionValue,
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
// 				                                        setValue:this.optionValue,
 				                                        alwaysOnChange: true,
				                                        onChange: function(_this){
															fnObj.initMap();
// 				                                        	fnObj.search.submit();
				                                        	//var params = "locCode="+locCode+"&floorCode="+floorCode+"&roomCode="+roomCode+"&blockNum="+this.optionValue;

				                                        	//fnObj.getEnsmatrix(params);
				                                        	//axdom("#info-direction").change();
				                                        	//$("#info-blockNum").change();


				                                        }
				                                    });
				                             }
				                         });
	                                }
	                            });
	                        }
	                    });
                     $("#hide").hide();

                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });


                },
                save: function(){
                	var items = fnObj.getMatrixItems();
					app.ajax({
					    type: "PUT",
					    url: "/ENSH3050/ensmap/"+$("#locCode :selected").val()+"/"+$("#floorCode :selected").val()+"/"+$("#roomCode :selected").val()+"/"+$("#blockNum :selected").val(),
					    data: Object.toJSON(items)
					},
					function(res){
						if(res.error){
							alert(res.error.message);
						}else{

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

                             //mediaQuery: {
                            // mx:{min:"N", max:767}, dx:{min:767}
                             //},

                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.

                                fnObj.search.submit();
                            },

                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
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
                	, TBTB: function(row, col){
                		var matrix = this.LRLR(col, row);
                		var res = [];
                		for(var i=0; i<matrix.length; i++){
                			for(var j=0; j<matrix[i].length; j++){
                				if(!res[j]){
                					res[j] = [];
                				}
                				if(!res[j][i]){
                					res[j][i] = [];
                				}
                				res[j][i] = matrix[i][j];
                			}
                		}
                		return res;
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
               		$("#tb-matrix").css("width", fnObj.matrix[0].length*70+"px");
               		fnObj.drawMap();
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
//                 			$(td).attr("width", 500);
                			$(td).attr("height", 55);
                        	$(td).attr("align", "center");
                			if(fnObj.matrix[i][j].isWaste){
                				$(td).addClass("wasteRowcolNum");
                			}else{
	                			$(td).html(fnObj.getItemHTML(fnObj.matrix[i][j].item));
                			}
                			$(td).bind("click", function(event){
//                 			$(td).bind("dblclick", function(){
								// 컨트롤키 대신 클릭/더블클릭 으로 구분하려 했으나 충돌이 나는지 더블클릭 이벤트가 정상적으로 발생하지 않아서 아래와 같이 처리
                			    if(event.ctrlKey) {
                    				var row = $(this).attr("row");
                    				var col = $(this).attr("col");
                    				var item = fnObj.matrix[row][col].item;
                    				$("#row").val(row);
                    				$("#col").val(col);
                    				fnObj.form.setJSON(item);
                    				return;
                			    }
								fnObj.form.clear();
                				var row = $(this).attr("row");
                				var col = $(this).attr("col");
                				console.log("row : " + row);
                				console.log("col : " + col);
                				if(fnObj.matrix[row][col].isWaste){
                					fnObj.matrix[row][col].isWaste = false;
                				}else{
                					fnObj.matrix[row][col].isWaste = true;
                				}
                				var mapItemsClone = fnObj.mapItems.slice();
                				for(var i=0; i<fnObj.matrixInfo.maxRow*fnObj.matrixInfo.maxCol; i++){
                					for(var j=0; j<fnObj.matrix.length; j++){
                						for(var k=0; k<fnObj.matrix[j].length; k++){
                							if(i==fnObj.matrix[j][k].index && !fnObj.matrix[j][k].isWaste){
                								var item = mapItemsClone.shift();
                								if(item){
// 	                								var ensNo = item.ensNo.split("-");
// 	                								ensNo[1] = j+1;
// 	                								item.ensNo = ensNo.join("-");
	                								item.mapIdx = fnObj.matrix[j][k].index
	                								fnObj.matrix[j][k].item = item;
                								}else{
	                								fnObj.matrix[j][k].item = {ensNo:"배정된 함이 없음"};
                								}
                							}
                						}
                					}
                				}

                				fnObj.drawMap();
                			});
//                 			$(td).bind("click", function(){
//                 				var row = $(this).attr("row");
//                 				var col = $(this).attr("col");
//                 				var item = fnObj.matrix[row][col].item;
//                 				$("#row").val(row);
//                 				$("#col").val(col);
//                 				fnObj.form.setJSON(item);
//                				});
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
                , getMatrixItems: function(){
                	var result = [];
                	fnObj.matrix.forEach(function(row, i){
                		row.forEach(function(col){
                			if(col.isWaste == false){
		                		result.push(col.item);
                			}
                		})
              		})
              		return result;
                },
                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });

                        $("[id^='info-']").bind("change", function(){
                        	var row = $("#row").val();
                        	var col = $("#col").val();
                        	if(row.length*col.length == 0){
                        		return;
                        	}
                        	fnObj.matrix[row][col].item[$(this).attr("name")]=this.value;
                        	$("#tb-matrix tbody tr").remove();
                        	fnObj.drawMap();
                        });
                        $("#info-ensKind").bindSelect({
                        	options:fnObj.CODES.ensType
                        });
                        $("#info-usingStatus").bindSelect({
                        	options:fnObj.CODES.usingStatus
                        });
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

//                         var info = $.extend({}, item);
//                         app.form.fillForm(_this.target, info, 'info-'); << 이 기능을 사용할 경우 폼에 값이 세팅될때 change 이벤트가 발생하여 성능저하가 심함.
						$("[id^='info-']").val("");
						for(var key in item){
							$("#info-"+key).val(item[key]);
							$("#info-"+key).bindSelectSetValue(item[key]);
						}
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    }
                },
            };
        </script>
    </ax:div>

</ax:layout>

