<%----------------------------------------------------------------------------------------
 - 파일이름	: SUIP1030.jsp
 - 설      명	: 수입 관리 > 카드 입금 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.15  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="com.axisj.axboot.core.util.CommonUtils"%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
request.setAttribute("printName", CommonUtils.getCurrentLoginUser().getUserNm());
%>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
      		.al-expect-amount{
      		text-align: right;
      		}
        </style>
    	<link rel="stylesheet" type="text/css" href="/static/plugins/axisj/ui/bigers/AXJ.min.new.css"/>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width: 600px;">

							<div class="ax-button-group">
                                <div class="right">
                                	<b:button text="업로드" id="btn-upload"></b:button>
                                    <b:button text="엑셀" id="btn-exportExcelGrid1"></b:button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

							<table class='AXFormTable'>
                   				<colgroup>
                      				<col width="100"/>
                      				<col/>
                      			</colgroup>
                      			<tr>
                      				<th><div class='tdRel'>밴사</div>
                      				</th>
                      				<td><div class='tdRel'>
                   						<input type="text" id="info-date" name="date" title="다운로드파일일자" class="AXInput W100"  value=""/>
                                    	<b:button text="자료받기" id="btn-ftp"></b:button>
                  					</div></td>
								</tr>
                      			<tr>
                      				<th><div class='tdRel'>조회</div>
                      				</th>
                      				<td><div class='tdRel'>
	                                 	<select id="info-gubun" name="gubun" style="height: 25px;" class="W150"></select>
	                                 	<select id="info-cgubun" name="cgubun" style="height: 25px;" class="W150"></select>
	                                 	<input type="text" id="info-inDate" name="inDate" title="예정일" class="AXInput W100"  value=""/>
	                                    <b:button text="조회" id="btn-srchAutoReceipt"></b:button>
                  					</div></td>
								</tr>
                      			<tr>
                      				<th><div class='tdRel'>입금예정금액</div>
                      				</th>
                      				<td><div class='tdRel'>
	                                 	<input type="text" id="info-total" name="total" title="입금예정금액" class="AXInput W200" style="" value="" readonly="readonly"/>
                  					</div></td>
								</tr>
<!--                       			<tr> -->
<!--                       				<th><div class='tdRel'>대조</div> -->
<!--                       				</th> -->
<!--                       				<td><div class='tdRel'> -->
<%-- 	                                 	<b:button text="입금대조" id="btn-receiptCheck"></b:button> --%>
<!-- 	                                 	<details> -->
<!-- 	                                 		<summary>단말기 번호</summary> -->
<!-- 	                                 		<ul> -->
<!-- 	                                 			<li>장례식장 - 5190989 -->
<!-- 	                                 			</li> -->
<!-- 	                                 			<li>자판기(식권) - 6171296 -->
<!-- 	                                 			</li> -->
<!-- 	                                 			<li>자판기(커피) - 6227982 -->
<!-- 	                                 			</li> -->
<!-- 	                                 			<li>승화원 - 6474775 -->
<!-- 	                                 			</li> -->
<!-- 	                                 		</ul> -->
<!-- 	                                 	</details> -->

<!--                   					</div></td> -->
<!-- 								</tr> -->
<!--                       			<tr> -->
<!--                       				<th><div class='tdRel'>카드사</div> -->
<!--                       				</th> -->
<!--                       				<td><div class='tdRel'> -->
<!--                       					<select id="info-cardCd" name="cardCd" style="height: 25px;"></select> -->
<!--                   					</div></td> -->
<!-- 								</tr> -->
							</table>

                            <div class="ax-grid" id="page-grid1-box" style="min-height: 300px;"></div>

                        </ax:custom>

                        <ax:custom customid="td">

                            <div class="ax-button-group">
                                <div class="left">
                                	<b:button text="입금대조" id="btn-receiptCheck"></b:button>
                                    <b:button text="입금처리" id="btn-receiptProc"></b:button>
                                    <b:button text="입금취소" id="btn-cancelProc"></b:button>
                                </div>
                                <div class="right">
                                	<b:button text="엑셀" id="btn-exportExcelGrid2"></b:button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
							<div class="ax-search" id="page-search-box"></div>

                            <div class="ax-grid" id="page-grid2-box" style="min-height: 300px;"></div>

                        </ax:custom>

                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script>
    	<script type="text/javascript">
    	  var resize_elements = [
                {id:"page-grid1-box", adjust:-132},
                {id:"page-grid2-box", adjust:-105}
            ];
            var pb_data={
                	//입금구분
                	srchReceiptGubun	: "",
                	totExpectAmount : 0

            }
            var fnObj = {
            		CODES: {
            			cardComGubun: Common.getCode("301"),
            			flagGubun: Common.getCode("108"),
            			gubun: [
            				{optionValue: "0", optionText: "입반송내역+거래내역"},
            				{optionValue: "1", optionText: "입반송내역"},
            				{optionValue: "2", optionText: "거래내역"}
            			],
            			cgubun: Common.getCode("CGUBUN"),
            			cgubunTrans: [
            				{optionValue: "", optionText: "전체"}
            				, {optionValue: " ", optionText: "승인"}
            				, {optionValue: "R", optionText: "취소"}
            			]
                	},
                	// 20191015 김세현 XKQD-274 카드입금자료 수동업로드 기능 추가
                	uploadResult : function(files){

    					var list = [];
    					for(var i=0; i<files.length; i++){
    						var item = {};
    						item.docName = files[i].name;
    						item.saveName = files[i].saveName;
    						item.docPath = files[i].uploadedPath;
    						item.thumbPath = files[i].thumbPath;
    						list.push(item);
    					}
    					fnObj.save(list);
    					app.modal.close();
    				},
    				// 20191015 김세현 XKQD-274 카드입금자료 수동업로드 기능 추가
    				save: function(list){
   					 if(!confirm("동일 데이터 존재시 전부 삭제후 저장합니다. 계속하시겠습니까?")){
   							return;
   					}

   					app.ajax({
   						type: "POST",
   						url: "/SUIP1030/upload",
   						data: Object.toJSON(list)
   					}, function(res){
   						if(res.error){
   							alert(res.error.message);
   						}else{

   						}
   					});
   					},
                pageStart: function(){
                	this.search.bind();
                    this.grid1.bind();
                    this.grid2.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    fnObj.grid1.setPage("0");
                    this.search.submit();

                    $("#"+fnObj.search.target.getItemId("expectAmount")).attr("readonly", "readonly");
                    $("#"+fnObj.search.target.getItemId("expectAmount")).val(pb_data.totExpectAmount.money());
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-fn2").html('<i class="axi axi-report"></i> 출력');
                    $("#ax-page-btn-fn2").bind("click", function(){
                    	if("F" == Common.search.getValue(fnObj.search.target, "cjob")){
	                    	fnObj.report.exportPdfSUIP1031();
                    	}else{
                    		fnObj.report.exportPdfSUIP1032();
                    	}
                   	});

                    $("#ax-page-btn-excel").bind("click", function(){
                    	if("F" == Common.search.getValue(fnObj.search.target, "cjob")){
	                    	fnObj.report.exportExcelSUIP1031();
                    	}else{
	                    	fnObj.report.exportExcelSUIP1032();
                    	}
                    });


                    $("#info-gubun").bindSelect({
                    	options: fnObj.CODES.gubun
                    	, onChange: function(){
                    		var options;
                    		if(this.value == "0"){
                    			$("#info-cgubun").bindSelectDisabled(true);
                    			return;
                    		}else if(this.value == "1"){
                    			options = fnObj.CODES.cgubun
                    		}else{
                    			options = fnObj.CODES.cgubunTrans
                    		}
                    		$("#info-cgubun").bindSelectDisabled(false);
                    		$("#info-cgubun").bindSelect({
                            	options: options
                            });
                    	}
                    });
                    $("#info-date").bindDate().val(new Date().add(-1,'d').print());
                    $("#info-inDate").bindDate().val(new Date().add(-1,'d').print());
                    $("#info-total").bindMoney();
                    $("#btn-srchAutoReceipt").bind("click", fnObj.eventFunc.srchAutoReceipt);
                    $("#btn-receiptCheck").bind("click", fnObj.eventFunc.receiptCheck);
                    $("#btn-checkedDelete").bind("click", fnObj.eventFunc.checkedDelete);
                    $("#btn-receiptProc").bind("click", fnObj.eventFunc.receiptProc);
                    $("#btn-cancelProc").bind("click", fnObj.eventFunc.cancelProc);
                    $("#btn-ftp").bind("click", fnObj.eventFunc.ftp);
                    $("#btn-exportExcelGrid1").bind("click", fnObj.report.exportExcelGrid1);
                    $("#btn-exportExcelGrid2").bind("click", fnObj.report.exportExcelGrid2);
                    $("#btn-upload").bind("click", fnObj.eventFunc.upload);
                },
                report: {
                	exportExcelSUIP1031: function(){
                		var params = [];
                		var from 				= Common.search.getValue(fnObj.search.target, "fromEtDate").replace(/-/g, '');
                		var to 					= Common.search.getValue(fnObj.search.target, "toEtDate").replace(/-/g, '');
                		var receiptGubun	= Common.search.getValue(fnObj.search.target, "receiptGubun");
                		var cardCode		= Common.search.getValue(fnObj.search.target, "cardCode");

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("receiptGubun="+receiptGubun);
                		params.push("cardCode="+cardCode);

                		Common.report.go("/reports/changwon/suip/SUIP1031", "excel", params.join("&"));
                	},
                	exportExcelGrid1: function(){
                		Common.report.gridToExcel("syicard", fnObj.grid1.target);
                	},
                	exportExcelGrid2: function(){
                		Common.report.gridToExcel("card", fnObj.grid2.target);
                	},
                	exportExcelSUIP1032: function(){
                		var params = [];
                		var inDate 				= Common.search.getValue(fnObj.search.target, "inDate");

                		params.push("inDate="+inDate);
                		params.push("printName=${printName}");

                		Common.report.gridToExcel("SUIP1032", fnObj.grid2.target);
                		//Common.report.go("/reports/changwon/suip/SUIP1032", "excel", params.join("&"));
                	},
                	exportPdfSUIP1031: function(){
                		var params = [];
                    	from 				= Common.search.getValue(fnObj.search.target, "fromEtDate").replace(/-/g, '');
                		to 					= Common.search.getValue(fnObj.search.target, "toEtDate").replace(/-/g, '');
                		receiptGubun	= Common.search.getValue(fnObj.search.target, "receiptGubun");
                		cardCode		= Common.search.getValue(fnObj.search.target, "cardCode");

                		params.push("FROM="+from);
                		params.push("TO="+to);
                		params.push("receiptGubun="+receiptGubun);
                		params.push("cardCode="+cardCode);

                		Common.report.open("/reports/changwon/suip/SUIP1031", "pdf", params.join("&"), "SUIP1031");
                	},
                	exportPdfSUIP1032: function(){

                		var parameters = [];

                		var params = [];
                		var inDate 				= Common.search.getValue(fnObj.search.target, "inDate");
						var list = fnObj.grid2.target.getList();

						var part = [];
						var crem = "";
						var ensh = "";
						var natu = "";

						for(var i=0; i<list.length;i++){
							if(list[i].part == "70-001"){
								crem = list[i].part;
							}else if(list[i].part == "80-001" || list[i].part == "81-001"){
								ensh = list[i].part;
							}else if(list[i].part == "90-001"){
								natu = list[i].part;
							}
						}
						part.push(crem);
						part.push(ensh);
						part.push(natu);

						for(var i=0; i<part.length;i++){
							if(part[i].length> 0){
								parameters.push({path:"/reports/changwon/suip/SUIP1032", parameter: "inDate="+inDate+"&partCode="+part[i]+"&printName=${printName}"});
							}
						}

						Common.report.mergePdfReport(parameters);
                		//params.push("inDate="+inDate);
                		//params.push("partCode=${printName}");
                		//params.push("printName=${printName}");


                		//Common.report.open("/reports/changwon/suip/SUIP1032", "pdf", params.join("&"), "SUIP1031");
                	}
                },
                eventFunc: {
                	//입금목록조회
                	srchAutoReceipt : function(){
                		fnObj.grid1.setPage("0");
                	},
                	//입금대조
                	receiptCheck: function(){
                		var compare_target		= fnObj.grid1.target;
                		var _target 				= fnObj.grid2.target;

//                 		if(pb_data.srchReceiptGubun  === "1"){
// 							alert("입금구분 미수를 선택하세요.");
// 							return;
// 						}
                		if(_target.list.length === 0 || compare_target.list.length === 0){
							alert("입금대조 진행하려는 목록이 없습니다.");
							return;
						}
                		//좌측 그리드와 비교
                		$.each(compare_target.list, function(i, o){
                			var compare_no 			= o.cno
                			var compare_csungno 	= o.csungno
//                 			var compare_csungdate 	= o.csungdate
                			var compare_camount 	= o.camount
                			//우측 그리드에서 찾아 체크
                			$.each(_target.list, function(idx, val){
//                 				if(compare_no === val.cardNo && compare_csungno === val.appNo){
                				if(compare_csungno === val.appNo
//                 						&& compare_csungdate == val.etDate
                						&& compare_camount == val.amount){
                					fnObj.grid2.target.checkedColSeq(14, true, idx);
                				}
                			});
                		});
                		var checkedList 			= _target.getCheckedList(14);
                		if(checkedList.length === 0){
                			alert("일치하는 항목이 없습니다.");
							return;
                		}
                	},

                	//입금처리
                	receiptProc: function(){
                		var _target 				= fnObj.grid2.target;
                		var checkedListCopy 	= [];
                		var syiCardList			= [];
                		var saleStmtList			= [];
                		var paymentList			= [];
                		//체크된 항목 취득
                		var checkedList 			= _target.getCheckedList(14);
                		//체크된 항목 복사 후 사용
                		checkedListCopy 			= $.extend(true, [], checkedList);
                		if(pb_data.srchReceiptGubun  === "1"){
							alert("입금구분 미수를 선택하세요.");
							return;
						}
                		if(checkedListCopy.length ===0){
							alert("입금처리 진행하려는 항목을 선택하세요.");
							return;
						}

                		//체크한 항목 중 개별판매 , 빈소 판배 구분하여 전달
                		$.each(checkedListCopy, function(i, o){
                			if(o.gubun === "1"){
                				var objSale = {};
                				objSale.customerNo 	= o.id;
                				objSale.partCode 		= o.partCode;
                				objSale.billNo	 		= o.billNo;
                				objSale.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objSale.inAmount 		= o.amount;

                				saleStmtList.push(objSale)
                			}else{
                				var objPay = {};
                				objPay.deadId 		= o.id;
                				objPay.tid	 		= o.partCode;
                				objPay.seq	 		= o.billNo;
                				objPay.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objPay.inAmount 	= o.amount;
                				paymentList.push(objPay)
                			}
                			//체크 항목 중 좌측 그리드(입금목록)과 일치하는 데이타만 따로 취득. 입금목록에 있는 것을 처리하지만 없는 것도 강제 입금 처리 할 수 있음.
                			$.each(fnObj.grid1.target.list, function(idx, val){
                				if(val.csungno === o.appNo){
                					var objSyiCard = {};
                					objSyiCard.cno 		= val.cno;
                					objSyiCard.csungno 	= val.csungno;
                					objSyiCard.result 		= "1";
                					syiCardList.push(objSyiCard);
                				}
                			})
                 		});

                		console.log("syiCardList~", syiCardList)
                		console.log("saleStmtList~", saleStmtList)
                		console.log("paymentList~", paymentList)

                		 var suipCard = {
                			syiCardList		: syiCardList,
                			saleStmtList	: saleStmtList,
                			paymentList	: paymentList
                    	}
                		  app.ajax({
                            type: "POST",
                            url: "/SUIP1030/suipCard",
                            data: Object.toJSON(suipCard)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//입금 처리 후 그리드 리로드
                        		fnObj.grid1.setPage("0");
                        		fnObj.search.submit();
                            }
                        });
                	},

                	//입금취소처리
                	cancelProc: function(){
                		var _target 				= fnObj.grid2.target;
                		var checkedListCopy 	= [];
                		var syiCardList			= [];
                		var saleStmtList			= [];
                		var paymentList			= [];
                		//체크된 항목 취득
                		var checkedList 			= _target.getCheckedList(14);
                		//체크된 항목 복사 후 사용
                		checkedListCopy 			= $.extend(true, [], checkedList);
                		if(pb_data.srchReceiptGubun  === "0"){
							alert("입금구분 입금을 선택하세요.");
							return;
						}
                		if(checkedListCopy.length ===0){
							alert("입금취소 진행하려는 항목을 선택하세요.");
							return;
						}

                		//체크한 항목 중 개별판매 , 빈소 판배 구분하여 전달
                		$.each(checkedListCopy, function(i, o){
                			if(o.gubun === "1"){
                				var objSale = {};
                				objSale.customerNo 	= o.id;
                				objSale.partCode 		= o.partCode;
                				objSale.billNo	 		= o.billNo;
                				objSale.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objSale.inAmount 		= o.amount;

                				saleStmtList.push(objSale)
                			}else{
                				var objPay = {};
                				objPay.deadId 		= o.id;
                				objPay.tid	 		= o.partCode;
                				objPay.seq	 		= o.billNo;
                				objPay.inDate 		= $("#"+fnObj.search.target.getItemId("inDate")).val();
                				objPay.inAmount 	= o.amount;
                				paymentList.push(objPay)
                			}
                			//체크 항목 중 좌측 그리드(입금목록)과 일치하는 데이타만 따로 취득. 입금목록에 있는 것을 처리하지만 없는 것도 강제 입금 처리 할 수 있음.
                			$.each(fnObj.grid1.target.list, function(idx, val){
                				if(val.csungno === o.appNo){
                					var objSyiCard = {};
                					objSyiCard.cno 		= val.cno;
                					objSyiCard.csungno 	= val.csungno;
                					objSyiCard.result 		= "0";
                					syiCardList.push(objSyiCard);
                				}
                			})
                 		});

                		console.log("syiCardList~", syiCardList)
                		console.log("saleStmtList~", saleStmtList)
                		console.log("paymentList~", paymentList)

                		 var suipCard = {
                			syiCardList		: syiCardList,
                			saleStmtList	: saleStmtList,
                			paymentList	: paymentList
                    	}
                		app.ajax({
                            type: "POST",
                            url: "/SUIP1030/suipCard/cancel",
                            data: Object.toJSON(suipCard)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//입금 처리 후 그리드 리로드
                        		fnObj.grid1.setPage("0");
                        		fnObj.search.submit();
                            }
                        });

                	},
                	ftp : function(){
                		app.ajax({
                            type: "GET",
                            url: "/SUIP1030/ftp/"+$("#info-date").val().replace("-","").replace("-","").substring(2,8),
                            data:""
                        }, function(res){
                            if(res.error){
                            //    alert(res.error.message);
                            }
                            else{
                            	 $("#btn-srchAutoReceipt").click();
                            }
                        });
                	},
                	// 입금내역 수동업로드 // 20191015 김세현 XKQD-274 카드입금자료 수동업로드 기능 추가
                	upload : function(){
                		app.modal.open({
    						url:"/jsp/funeralsystem/common/fileUpload.jsp",
    						pars:"callBack=fnObj.uploadResult",
    						width:600, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
    						//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
    					});
                	}


                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"업무구분", labelWidth:"", type:"selectBox", width:"100", key:"cjob", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1030/basic-select-options",
	                                              ajaxPars:"basic_code=CJOB",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  _this.submit();
	                                              }
	                                            }
											}
									},
									{label:"입금구분", labelWidth:"", type:"selectBox", width:"100", key:"receiptGubun", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", config: {
	                                                reserveKeys: {
	                                                	options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },
	                                              ajaxUrl: "/SUIP1030/basic-select-options",
	                                              ajaxPars:"basic_code=402",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            		//0:미수 1:입금
	                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
	                                            	  _this.submit();
	                                              }
	                                            }
											}
									},
									{label:"입금일자", labelWidth:"", type:"inputText", width:"100", key:"inDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
	        									}
	        								}
	        							}
               						},
               						{label:"발생일자", labelWidth:"", type:"inputText", width:"70", key:"fromEtDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"90", key:"toEtDate", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"fromEtDate",
               									onChange:function(){
               										_this.submit();
               									}
               								}
               							}
               						}

                                ]},
                                {display:true, addClass:"", style:"", list:[
										{label:"매입사", labelWidth:"", type:"selectBox", width:"100", key:"cardCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
											   type: "select", config: {
										            reserveKeys: {
										            	options: "list",
										                  optionValue: "code",
										                  optionText: "name"
										               },
										          ajaxUrl: "/SUIP1030/basic-select-options",
										          ajaxPars:"basic_code=301",
										          alwaysOnChange: true,
										          isspace: true,
	                                              isspaceTitle: "전체",
	                                              setValue:"ALL",
										          onChange: function() {
										        		//0:미수 1:입금
										        	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
										        	  _this.submit();
										          }
										        }
											}
										},
	              						{label:"예상금액", labelWidth:"", type:"inputText", width:"150", key:"expectAmount",addClass:"al-expect-amount", valueBoxStyle:"", value:""},
	              						{label:"승인번호", labelWidth:"", type:"inputText", width:"150", key:"appNo",addClass:"", valueBoxStyle:"", value:""}
	                               ]}
                            ]
                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        var pars_arr 		= pars.split('&')
		                var obj 				= {};
                        //파라미터 객체화
	                   	for(var c=0; c < pars_arr.length; c++) {
	                    	var split 		= pars_arr[c].split('=', 2);
	                     	obj[split[0]] 	= split[1];
	                   	}
	                   	pb_data.srchReceiptGubun 	= obj.receiptGubun;

	                   	if(pb_data.srchReceiptGubun != undefined){
	                   		fnObj.grid2.setPage(pars);
	                   	}
                        //검색 시 체크해제
                        fnObj.grid2.target.checkedColSeq(14, false);
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
                            //height:380,
                            colGroup : [
								{key:"i"					, label:" "			, width:"35"		, align:"center", sort: false, formatter: function(){return this.index+1;}},
								{key:"csungdate"		, label:"승인일자"	, width:"100"	, align:"center"},
								{key:"cardCd"			, label:"카드사"			, width:"80"		, align:"center", sort: false,formatter : function(){
                       				for(var i=0; i<fnObj.CODES.cardComGubun.length; i++){
                               			if(this.value == fnObj.CODES.cardComGubun[i].optionValue){
                               				var title = fnObj.CODES.cardComGubun[i].optionText;
                               				return title == "" ? this.value : title;
                               			}
                               		}
                       				return this.value;
                       			}},
								{key:"camount"		, label:"거래금액"	, width:"100" 	, align:"right", sort: false 	, formatter: "money"},
								{key:"cno"				, label:"카드번호"	, width:"150"	, align:"center", sort: false},
								{key:"csungno"		, label:"승인번호"	, width:"100"	, align:"center", sort: false},
								{key:"tid"		, label:"단말기번호"	, width:"100"	, align:"center", sort: false},
                            ],
                            body : {
                            	marker: [
        							{
        								display: function () {
        									return this.item.subTotal ? true : false;
        									},
        								rows: [
        									[{
        										colSeq  : null, colspan: 3, formatter: function () {
        											return "[ 소계 " + Common.grid.codeFormatter("cardComGubun", this.item.cardCd) + " ]";
        										}, align: "center"
        									}, {
        										colSeq: 2, formatter: function () {
        											return this.item.subTotal.camount.money();
        										}
        									}]
        								]
        							},
       							]
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
                            url: "/SUIP1030/syicard?result="
                            		+ param
                            		+"&inDate="+$("#info-inDate").val()
                            		+"&cjob="+Common.search.getValue(fnObj.search.target, "cjob")
                            		+"&cgubun="+$("#info-cgubun").bindSelectGetValue().optionValue
                            		+"&gubun="+$("#info-gubun").bindSelectGetValue().optionValue,
                            data:""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
                            	console.log("res~~card~autoIn~",res);
								_target.setData({list:res.list});
								var total = 0;
								$.each(res.list, function(i,o){
									total+=+o.camount;
								});
								$("#info-total").val(total.money());

								var sorted = $.map(res.list, function(o){
									return o.csungdate;
								}).sort(function(a, b) {
								    return a>b ? 1 : a<b ? -1 : 0;
								});

								var from = sorted.first();
								var to = sorted.last();

								if(from){
									Common.search.setValue(fnObj.search.target, "fromEtDate", from);
									Common.search.setValue(fnObj.search.target, "toEtDate", to);
								}
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
                            colGroup : [
                                {key:"gubun"		, label:"코드"				, display :false},
                                {key:"id"				, label:"아이디"			, display :false},
                                {key:"partCode"	, label:"코드"				, display :false},
                                {key:"billNo"		, label:"코드"				, display :false},
                                {key:"etDate"	, label:"발생일자"		, width:"100"	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                            		}
                                },
                                {key:"partName"	, label:"파트명"			, width:"200" 	, align:"center"},
                                {key:"goin"			, label:"고인정보"		, width:"180" 	, align:"center"},
                                {key:"amount"		, label:"발생금액"		, width:"80" 	, align:"right" , formatter: "money"},
                                {key:"cardCode"	, label:"매입사"			, width:"100" 	, align:"center"
                                	,formatter : function(){
                           				for(var i=0; i<fnObj.CODES.cardComGubun.length; i++){
                                   			if(this.value == fnObj.CODES.cardComGubun[i].optionValue){
                                   				return fnObj.CODES.cardComGubun[i].optionText;
                                   			}
                                   		}
                           			}
                                },
                                {key:"cardName"	, label:"카드명"			, width:"100" 	, align:"center"},
                                {key:"cardNo"		, label:"카드번호"		, width:"100" 	, align:"center", display:false},
                                {key:"appNo"		, label:"승인번호"		, width:"80" 	, align:"center"},
                                {key:"inDate"		, label:"입금일자"		, width:"100" 	, align:"center",
//                                 	formatter : function(){
//                             			if(this.value){
// 	                                		return this.value.date().print("yyyy-mm-dd");
//                                 		}else{
//                                 			return "";
//                                 		}
//                             		}
                                },
                                {key:"inAmount"		, label:"입금액"		, width:"80" 	, align:"right" 		, formatter: "money"},
                                {key:"index"			, label:"선택"			, width:"35"		, align:"center"		, formatter:"checkbox"},
                                {key:"checkCardFlg"	, label:"체크카드"	, width:"80" 	, align:"center"
                                	,formatter : function(){
                           				for(var i=0; i<fnObj.CODES.flagGubun.length; i++){
                                   			if(this.value == fnObj.CODES.flagGubun[i].optionValue){
                                   				return fnObj.CODES.flagGubun[i].optionText;
                                   			}
                                   		}
                           			}
                                },
                                {key:"part"		, label:"코드"		, width:"100" 	, align:"center", display:false}

                            ],
                            body : {
                            	 oncheck       : function(){
//                             		 if(pb_data.srchReceiptGubun  !== "1"){
                            			var chked 					= this.checked;
     									var idx						= this.index;
     									var lngth					= this.list.length;
     									var item						= this.item;
     									var totExpectAmount	= pb_data.totExpectAmount;
     									var tamount 				= 0;
//                                  		//전체체크
//                                  		if(chked === true && idx === lngth){
                                 			$.each(this.list, function(i, o){
                                 				if(o.___checked && o.___checked["14"] === true){
                                        			tamount+= +o.amount;
                                 				}
                                         	});
                                 			pb_data.totExpectAmount = tamount;
//                                  		//전체체크해제
//                                  		}else if(chked === false && idx === lngth){
//                                  			pb_data.totExpectAmount = 0;
//                                  		//개별체크
//                                  		}else if(chked === true && idx !== lngth){
//                                  			totExpectAmount = totExpectAmount + item.amount;
//                                  			pb_data.totExpectAmount = totExpectAmount;
//                                  		//개별체크 해제
//                                  		}else if(chked === false && idx !== lngth){
//                                  			totExpectAmount = totExpectAmount - item.amount;
//                                  			pb_data.totExpectAmount = totExpectAmount;
//                                  		}
                                 		$("#"+fnObj.search.target.getItemId("expectAmount")).val(pb_data.totExpectAmount.money());
//              						}
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
                    setPage: function(searchParams){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/SUIP1030/cardSend?" + searchParams,
                            data:""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else{
                            	console.log("res~~Card~",res);
                            	var obj 					= {};
                            	var detlist 				= [];
                            	for(var i=0;i<res.length;i++){
                            		//개별 : sale_stmt 	, 빈소 :payment
                            		var resDet 			= res[i];
                            		obj 					= {}
                            		obj.gubun	 		= resDet[0];//'1':개별판매 												,'2':빈소판매 임의의 구분값을 직접 부여
                            		obj.id			 		= resDet[1];//개별 : CUSTOMER_NO 									,빈소 : DEAD_ID
                            		obj.partCode 		= resDet[2];//개별 : PART_CODE 										,빈소 : TID
                            		obj.billNo 			= resDet[3];//개별 : BILL_NO 											,빈소 : SEQ
                            		obj.etDate			= resDet[4];//개별 : ET_DATE 											,빈소 : ET_DATE
                            		obj.partName		= resDet[5];//개별 : "창원시설관리공단" + PART.PART_NAME  	,빈소 : "창원시설관리공단" 직접 부여
                            		obj.goin				= resDet[6];//개별 : "개별판매" 직접부여  								,빈소 : BINSO.BINSO_NAME+故+THEDEAD.DEAD_NAME
                            		obj.amount			= resDet[7];//개별 : AMOUNT											,빈소 : CARD_AMT
                            		obj.cardCode		= resDet[8];//개별 : CARD_CODE										,빈소 : CARD_CODE
                            		obj.cardName		= resDet[9];//개별 : CARD_NAME										,빈소 : CARD_NAME
                            		obj.cardNo			= resDet[10];//개별 : CARD_NO										,빈소 : CARD_NO
                            		obj.appNo			= resDet[11];//개별 : APP_NO											,빈소 : APP_NO
                            		obj.inDate			= resDet[12];//개별 & 빈소 : IN_DATE
                            		obj.inAmount		= resDet[13];//개별 & 빈소 : IN_AMOUNT
                            		obj.checkCardFlg	= resDet[14];//개별 & 빈소 : CHECK_CARD_FLG
                            		obj.part	= resDet[15];// SUIP1032 레포트 승화원 파트구분용 파트코드
                            		detlist.push(obj);
                            	}
                            	 var gridData = {
                                         list: detlist
                                     };
                               _target.setData(gridData);
                            }
                        });
                    }
                },


            };
        </script>
    </ax:div>
</ax:layout>