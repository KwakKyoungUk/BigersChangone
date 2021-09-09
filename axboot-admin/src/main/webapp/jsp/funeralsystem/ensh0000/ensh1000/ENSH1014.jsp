<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="기간연장" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


				<div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 고인</h2>
                    </div>
                    <div class="right">
                    	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 연장</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-delete"><i class="axi axi-minus-circle"></i> 삭제</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div id="div-grid-ensdead" style="height: 120px;"></div>

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 기간연장</h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-grid-ensext" id="div-grid-ext" style="height: 250px;"></div>
				<div class="ax-button-group">
                    <div class="right">
                    	<button type="button" class="AXButton" id="btn-reportENSH1010_9">연장영수증</button>
                        <button type="button" class="AXButton" id="btn-applicant-new"><i class="axi axi-plus-circle"></i> 신청자 초기화</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<ax:form id="info-form" name="info-form">
					<input type="hidden" id="info-ensDate" value="${param.ensDate}">
					<input type="hidden" id="info-ensSeq" value="${param.ensSeq}">
					<input type="hidden" id="info-strDate" value="${param.strDate}">
					<input type="hidden" id="info-endDate" value="${param.endDate}">
					<input type="hidden" id="info-ensNo" value="${param.ensNo}">
					<ax:fields>
	          		  <input type="hidden" id="info-applicant-applId" name="applId" title="납부자번호" placeholder="납부자번호"  maxlength="100" class="AXInput W100 " value=""/>
	                  <%--     <ax:field label="납부자번호*" style="width:350px;">
	                          <button id="btn-search-applicant" class="AXButton" onclick="return false;"><i class='axi axi-ion-android-search'></i>조회</button>
	                      </ax:field> --%>
	                      <ax:field label="납부자명*" style="width:180px;">
	                          <input type="text" id="info-applicant-applName" name="applName" title="납부자명" placeholder="납부자명" maxlength="100" class="AXInput W100 " value="" />
	                      </ax:field>
	                      <ax:field label="납부자 주민번호" style="width:180px;">
	                          <input type="text" id="info-applicant-applJumin" name="applJumin" title="납부자 주민번호" placeholder="납부자 주민번호" maxlength="14" class="AXInput W100" value="" />
	                      </ax:field>
	                  </ax:fields>
	                  <ax:fields>
	                      <ax:field label="납부자국적" style="width:180px;">
	                          <select id="info-applicant-nationGb" name="nationGb" class="AXSelect W100"></select>
	                      </ax:field>
	                      <ax:field label="납부자 주소*">
	                          <select id="info-applicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
	                          <input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
	                          <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
	                          <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="납부자 주소" placeholder="" class="AXInput W200 " value=""/>
	                          <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="납부자 주소" placeholder="상세주소" class="AXInput W400 " value="" />
	                      </ax:field>
	                  </ax:fields>
	                  <ax:fields>
	                      <ax:field label="휴대폰*" style="width:180px;">
	                          <input type="text" id="info-applicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 " value="" />
	                          <input type="text" id="info-applicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 " value="" />
	                          <input type="text" id="info-applicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 " value="" />
	                      </ax:field>
	                      <ax:field label="전화번호" style="width:180px;">
	                          <input type="text" id="info-applicant-telno1" name="telno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value="" />
	                          <input type="text" id="info-applicant-telno2" name="telno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                          <input type="text" id="info-applicant-telno3" name="telno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value="" />
	                      </ax:field>
	                  </ax:fields>
					<ax:fields>
                        <ax:field label="연장일자" style="width:180px;">
                            <input type="text" id="info-extDate" name="extDate" title="연장일자" placeholder="연장일자" maxlength="10" class="AXInput W100" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="연번" style="width:180px;">
                            <input type="text" id="info-extSeq" name="extSeq" title="연번" placeholder="연번" maxlength="3" class="AXInput W100" value="" readonly="readonly"/>
                        </ax:field>
                        <ax:field label="기간" style="width:240px;">
                            <input type="text" id="info-extStrDate" name="extStrDate" title="시작일자" placeholder="시작일자" maxlength="10" class="AXInput W100" value="" readonly="readonly"/>
                            <input type="text" id="info-extEndDate" name="extEndDate" title="종료일자" placeholder="종료일자" maxlength="10" class="AXInput W100" value="" readonly="readonly"/>
                        </ax:field>
                    </ax:fields>
                    <ax:fields>
	                    <ax:field label="사용료*" style="width: 180px;">
							<input type="number" id="info-rentalfee" name="rentalfee" title="사용료" placeholder="사용료" maxlength="15" class="AXInput W100 av-required" value=""/>
							<button type="button" class="AXButton" id="btn-calcPrice" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 계산</button>
						</ax:field>
						<ax:field label="관리비" style="width: 180px;">
							<input type="number" id="info-extmngAmt" name="extmngAmt" title="감면금액" placeholder="감면금액" maxlength="15" class="AXInput W100" value=""/>
						</ax:field>
	                    <ax:field label="부과금액*" style="width: 480px;">
	                    	<select id="info-payGb" name="payGb" class="W50 AXSelect"></select>
							<input type="number" id="info-charge" name="charge" title="부과금액" placeholder="부과금액" maxlength="15" class="AXInput W100 av-required" value=""/>
							<button type="button" class="AXButton" id="btn-receipt" style="text-align:right"><i class="axi axi-bmg-revenue-stream"></i> 정산</button>
							<!-- <input type="checkbox" name="unpaidCalc" value="1" id="info-unpaidCalc"> 사용일을 넘긴 반환자료의 요금계산시 체크해주세요 -->
						</ax:field>
                    </ax:fields>
                    <ax:fields>
						<ax:field label="비고" style="width: 98%;">
							<input type="text" id="info-remark" name="remark" title="비고" placeholder="비고" class="AXInput" style="width: 98%;" value=""/>
						</ax:field>
                    </ax:fields>
				</ax:form>

                <div class="ax-button-group">
                    <div class="left">
                    </div>
                    <div class="right">
                    	<!-- <button type="button" class="AXButton" id="btn-report"><i class="axi axi-report"></i> 허가증</button> -->
                    </div>
                    <div class="ax-clear"></div>
                </div>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
<!-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button> -->
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
		<script type="text/javascript">

			var fnObj = {

				strDate : "${param.endDate}"
                ,CODES: {
                    "cardCode": Common.getCode("TCM16"),
                    "receiptGb": Common.getCode("TMC15"),
                    "dcGubun": Common.getCode("TCM12"),
                    "addrPart": Common.getCode("TCM10"),
                    "deadSex": Common.getCode("TCM05"),
                    "applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                    "payGb": Common.getCode("TMC15"),
                },
				data: {
					price: null
				},
				pageStart: function(){
					this.gridEnsdead.bind();
					this.gridExt.bind();
					this.bindEvent();
					this.defaultFn.excute();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				defaultFn: {
                	excute: function(){
                		for(var key in this.fn){
                			this.fn[key]();
                		}

                		if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFn["${param.m}"]();
                	}
                	, fn: {
                		getGridData: function(){
                			fnObj.gridEnsdead.setPage();
                		}
                	}
                },
                eventFn: {
                	calcPrice: function(){
                		if(fnObj.gridExt.target.getList().length == 0){
                			toast.push("연장버튼을 눌러주세요");
                			return false;
                		}
                		var unpaidCalc = 0;
                		if($('input:checkbox[id="info-unpaidCalc"]').is(":checked") == true){
                			unpaidCalc = 1;
                		}
                		app.ajax({
                            type: "GET",
                            url: "/ENSH1014/price",
                            data: "ensDate=${param.ensDate}&ensSeq=${param.ensSeq}&deadSeq="+fnObj.gridEnsdead.target.getSelectedItem().item.deadSeq+"&unpaidCalc="+unpaidCalc
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                        		var isDam = function(){
                        			var ensNo = "${param.ensNo}";
                        			return ensNo.substring(0,1) == "D"
                        		}
                        		var price = res.map.price;

                        		if(isDam() == true){
                        			price = price.map(function(pa){return pa.price});
                        		}

                        		fnObj.data.price = price;

                        		var priceRes = {
                        				rentalfee: 0
                        				, extmngAmt: 0
                        				, charge: 0
                        				, useTerm: 0
                        		}
                        		var strDate = fnObj.strDate.date();
                        		strDate.setDate(strDate.getDate()+1);

                        		$.each(price, function(i, o){

                        			var usePrice = o.price.pricelist;
	                        		var mngPrice = o.price.mngPrice;
	                        		var useTerm = usePrice.useTerm;

	                        		var rentalfee = usePrice.charge;
	                        		var extmngAmt = mngPrice.charge;

	                        		var charge = rentalfee + extmngAmt;

	                        		priceRes.rentalfee += (+rentalfee);
	                        		priceRes.extmngAmt += (+extmngAmt);
	                        		priceRes.charge += (+charge);
	                        		priceRes.useTerm = useTerm;
                        		});


                        		$("#info-rentalfee").val(priceRes.rentalfee);
                        		$("#info-extmngAmt").val(priceRes.extmngAmt);
                        		$("#info-charge").val(priceRes.charge);

                        		$("#info-extStrDate").val(strDate.print());
                        		strDate.setFullYear(strDate.getFullYear()+(+priceRes.useTerm));
                        		strDate.setDate(strDate.getDate()-1)
                        		$("#info-extEndDate").val(strDate.print());
                        		$("[id^='info-']").change();

                            }
                        });

                		$("input[id^=info-applicant]").attr("readonly",true);
                	}
                	, receipt: function(){
                		if($("#info-extSeq").val() <= 0){
                			alert("연장자료 저장 후 정산처리 해주세요.");
                			return false;
                		}
                		app.modal.open({
    	                    url:"ENSH1014_1.jsp",
    	                    pars:"callBack=&deadId="+fnObj.gridEnsdead.target.getSelectedItem().item.deadId
    	                    		+ "&extDate=" + $("#info-extDate").val()
    	                    		+ "&extSeq=" + $("#info-extSeq").val()
    	                    ,
    	                    width:900, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
    	                    top:0 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
               		  	});
                	}
                },
				bindEvent: function(){
                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
	                		$(o).bind("click", fn);
                		}
                	});

					$("#ax-form-btn-new").bind("click", function(){
						if(Common.grid.containsNewItem(fnObj.gridExt.target)){
							return;
						}
						if(fnObj.gridEnsdead.target.getSelectedItem().item.extCharge){
	                		toast.push("이미 연장자료가 존재합니다.");
	                		return false;
	                	}

						fnObj.gridExt.target.pushList({});
						fnObj.gridExt.target.setFocus(fnObj.gridExt.target.list.length-1);
						fnObj.form.clear();
						fnObj.eventFn.calcPrice();

						fnObj.form.setJSON(fnObj.gridEnsdead.target.getSelectedItem().item);
						$("#info-extDate").val(new Date().print());
						$("#info-ensDate").val("${param.ensDate}");
						$("#info-ensSeq").val("${param.ensSeq}");
						$("#info-strDate").val("${param.strDate}");
						$("#info-endDate").val("${param.endDate}");

	                    $("[id^='info-']").change();
					});
                    $("#info-addrPart").bindSelect({
                        options:fnObj.CODES.addrPart
                    });
                    $("#info-dcGubun").bindSelect({
                        options:fnObj.CODES.dcGubun
                    });
                    $("#info-receiptGb").bindSelect({
        				options:fnObj.CODES.receiptGb
        			});
                    $("#info-cardCode").bindSelect({
        				options:fnObj.CODES.cardCode
        			});
                    $("#info-payGb").bindSelect({
        				options:fnObj.CODES.payGb
        			});
//                     $("#info-extDate").bindDate();
                    $("#info-extDate").val(new Date().print());
					$("#info-extStrDate").bindDate();
					$("#info-extEndDate").bindDate();
                    $("#ax-form-btn-save").bind("click", function(){
                    	fnObj.save();
                    });
                    Common.grid.changeValueToGrid("info-", fnObj.gridExt.target);
					$("#info-cashAmt, #info-cardAmt").bind("keyup", function(){
						var charge = $("#info-charge").val();
						var ids = ["info-cashAmt", "info-cardAmt"];
						var _this = this;
						ids.forEach(function(val){

							if(val == $(_this).attr("id")){
								$("#"+val).val(+$(_this).val());
							}else{
								$("#"+val).val(+charge-$(_this).val());
							}
						});
					});
					$("#ax-form-btn-delete").bind("click", function(){
						fnObj.del();
					});


					$("#btn-reportENSH1010_9").bind("click", function(){
                    	var params = [];
                    	var extDate = $("#info-extDate").val();
                    	var extSeq = $("#info-extSeq").val();
                    	var deadId = "${param.deadId}";
                    	var printName = "${LOGIN_USER_ID}";
                    	console.log(extDate+"/"+extSeq+"/"+deadId )
                    	if(extDate ==  "" || extSeq == ""  || deadId == ""){
                    		toast.push("출력할 기간연장 정보를 선택하세요");
                    		return;
                    	}

                    	params.push("extDate="+extDate);
                		params.push("extSeq="+extSeq);
                		params.push("deadId="+deadId);
                		params.push("printName="+printName);

                    	Common.report.open("/reports/changwon/ensh/ENSH1010_9", "pdf", params.join("&"));

                    });

					$("#info-applicant-nationGb").bindSelect({
	       				options:fnObj.CODES.applNationGb
	       			});

					$("#info-applicant-addrGubun").bindSelect({
	       				options:fnObj.CODES.addrGubun
	       			});
	                $("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
	                });

	                //$("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});
  					$("#info-applicant-applJumin").keyup(function() {
                     	if(this.value.length >= 8 ){
                     		$(this).val(Common.str.replaceAll($("#info-applicant-applJumin").val(), "-", "").substring(0,6)+"-"+Common.str.replaceAll($("#info-applicant-applJumin").val(), "-", "").substring(6,13));
                     		//$("#info-applicant-applJumin").change();
                     	}
 					});

	                $("#btn-applicant-new").bind("click", function(){
	                	$("[id^=info-applicant]").val("");
	                	$("input[id^=info-applicant]").attr("readonly",false);
					});
				},
				isNew: function(){
					return fnObj.gridExt.target.getSelectedItem().item._CUD == "C";
				},
                del: function(){
                	if(!confirm("선택하신 연장자료를 삭제하시겠습니까?")){
                		return;
                	}
                	if(typeof fnObj.gridExt.target.getSelectedItem().item === "undefined" ){
            			toast.push("삭제할 연장자료를 선택하세요.");
            			return false;
            		}
                	if($("#info-extSeq").val() == ""){
                	 	fnObj.gridExt.target.removeListIndex([{index:fnObj.gridExt.target.getSelectedItem().index}]);
                	 	return false;
                	}


                	app.ajax({
                        type: "DELETE",
                        url: "/ENSH1014/ensext/"+$("#info-extDate").val()+"/"+$("#info-extSeq").val(),
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
                    		fnObj.gridEnsdead.setPage();
                    		app.modal.save("${callBack}", "E");
                        }
                    });

                },
                gridEnsdead: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ensdead",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"deadName", label:"고인명", width:"150", align:"center"},
                                {key:"deadJumin", label:"주민번호", width:"200", align:"center"
                                	, formatter: function(val){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadDateString", label:"사망일자", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"deadSex", label:"성별", width:"100", align:"center"
                                	, formatter:function(val){
                                		for(var i=0; i<fnObj.CODES.deadSex.length; i++){
                                			if(this.value == fnObj.CODES.deadSex[i].optionValue){
                                				return fnObj.CODES.deadSex[i].optionText;
                                			}
                                		}
                                	}
                                },
                                {key:"deadSeq", label:"고인순번", width:"100", align:"center", display:false},
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.clear();
                                	fnObj.gridExt.setParent(this.item);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                        fnObj.gridEnsdead.target.setData({list:[{}]});
                        fnObj.gridEnsdead.target.setFocus(0);
                    },
                    setPage: function(pageNo, searchParams){

                   	 var _target = this.target;
                   	 app.ajax({
                			async: false,
                            type: "GET",
                            url: "/ENSH1010/enshrine/${param.ensDate}/${param.ensSeq}",
                            data: ""
                        },
                        function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else
                            {
                           		 if(res.map.enshrine){
                        			for(var i=0; i<res.map.enshrine.ensdead.length; i++){
                        				fnObj.gridEnsdead.target.setData({list:[]})

                        				if(res.map.enshrine.ensdead[i].thedead){
                        					res.map.enshrine.ensdead[i].applicant = res.map.enshrine.applicant;

			                        		$.each(res.map.enshrine.ensdead[i].thedead, function(key, value){
			                        			res.map.enshrine.ensdead[i][key] = value;
			                        		});

                        				}
                        			}
                        			enshrine = res.map.enshrine;
	                        		fnObj.gridEnsdead.target.pushList(res.map.enshrine.ensdead);
	                        		Common.grid.setFocus(fnObj.gridEnsdead.target,0);
                        		}
                            }
                        });
                    }
                },
				gridExt: {
					parent: {},
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ext",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"extDate", label:"연장일자", width:"100", align:"center"},
                                {key:"extSeq", label:"연번", width:"100", align:"center"},
                                {key:"strDate", label:"최초시작일", width:"100", align:"center"},
                                {key:"endDate", label:"최초종료일", width:"100", align:"center"},
                                {key:"extStrDate", label:"연장시작일", width:"100", align:"center"},
                                {key:"extEndDate", label:"연장종료일", width:"100", align:"center"},
                                {key:"rentalfee", label:"사용료", width:"100", align:"center", formatter: "money"},
                                {key:"extmngAmt", label:"관리비", width:"100", align:"center", formatter: "money"},
                                {key:"charge", label:"부과액", width:"100", align:"center", formatter: "money"},

                            ],
                            body : {
                                onclick: function(){
                                	if(this.item.extSeq > 0){
                                		fnObj.form.setJSON(this.item);
                                	}

                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                    },
                    setParent: function(item){
                        if(typeof item.ensDate === "undefined" || item.ensDate == "" || typeof item.ensSeq === "undefined" || item.ensSeq == ""
                        		|| typeof item.deadSeq === "undefined" || item.deadSeq == "" ) {
                            this.clear();
                        }else{
                            this.parent = item;
                            this.setPage( 1, item.deadSeq );
                        }
                    },
                    clear: function(){
                        this.parent = {};
                        this.target.setList([]);
                    },
                    setPage: function(page,deadSeq){
                        var _target = this.target;

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1014/ensext/${param.ensDate}/${param.ensSeq}/"+deadSeq,
                            data: ""
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
                                     			 res.list[i].strDate = "${param.strDate}";
                                     			 res.list[i].endDate = "${param.endDate}";
                                     		 }
                                     	 }
                                     	 return res.list;
                                      }()),
                                };

                                _target.setData(gridData);
//                                 parent.fnObj.searchHwaCremation.submit();
                                Common.grid.setFocus(fnObj.gridExt.target,0);
                            }
                        });
                    }
                },
                save: function(){
                	if(!confirm("저장하시겠습니까?")){
                		return;
                	}
                	var info = fnObj.form.getJSON();

                	if(info.ensext.charge == ""){
                		toast.push("계산 버튼을 눌러주세요.");
                		return false;
                	}
                	info.deadSeq = fnObj.gridEnsdead.target.getSelectedItem().item.deadSeq;

                    app.ajax({
                        type: "PUT",
                        url: "/ENSH1014/ensext",
                        data: Object.toJSON(info)
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                        	toast.push("저장하였습니다.");
                        	fnObj.gridEnsdead.setPage();
                        	app.modal.save("${callBack}", "E");
                        }
                    });
                },
                form: {
                    target: $('#info-form'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "info-form"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                       //app.form.fillForm(_this.target, info, 'info-');
						console.log(info);
						app.form.fillForm(_this.target, info, 'info-', true);
						app.form.fillForm(_this.target, info.applicant, 'info-applicant-', true);

                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );

                        if(fnObj.form.getJSON().ensext.extSeq != ""){
                        	$('#info-unpaidCalc').prop('checked', item.unpaidCalc == 1);
                        } else {
                        	$('#info-unpaidCalc').prop('checked', fnObj.form.getJSON().ensext.unpaidCalc == 1);
                        }


                    },
                    getJSON: function() {
                    	var res = {

                    			ensext: app.form.serializeObjectWithIds(this.target, 'info-')
                    			, applicant: app.form.serializeObjectWithIds(this.target, 'info-applicant-')
                    			, prices: fnObj.data.price
                    	}
                    	var unpaidCalc = 0;
                		if($('input:checkbox[id="info-unpaidCalc"]').is(":checked") == true){
                			unpaidCalc = 1;
                		}
                    	res.ensext.unpaidCalc = unpaidCalc;
                        return res;
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        //fnObj.gridExt.target.
                        //this.target.setList([]);

                        fnObj.gridExt.target.updateList(0,[]);
                        var info = fnObj.form.getJSON();
                        fnObj.gridExt.target.updateList(0,fnObj.form.getJSON());
                    }
                },
				control: {

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