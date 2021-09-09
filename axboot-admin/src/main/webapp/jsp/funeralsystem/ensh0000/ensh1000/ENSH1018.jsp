<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="${PAGE_NAME}" />
	<ax:set name="page_desc" value="${PAGE_REMARK}" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


				<div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 고인</h2>
                    </div>
                    <div class="right">
                    	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 반환</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-delete"><i class="axi axi-minus-circle"></i> 삭제</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div id="div-grid-ensdead" style="height: 120px;"></div>

                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 반환</h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<ax:form id="form-info" name="form-info" method="get">
					<input type="hidden" id="info-ensret-ensDate" value="${param.ensDate}">
					<input type="hidden" id="info-ensret-ensSeq" value="${param.ensSeq}">
					<input type="hidden" id="info-ensret-deadSeq" value="">
					<ax:fields>
                       <ax:field label="반환일자" style="width:200px;">
                           <input type="text" id="info-ensret-retDate" name="retDate" title="반환일자" maxlength="10" placeholder="반환일자" class="AXInput W100 " value="" />
                       </ax:field>
                       <ax:field label="연번" style="width:200px;">
                           <input type="text" id="info-ensret-retSeq" name="retSeq" title="연번" maxlength="10" placeholder="연번" class="AXInput W100" value="" readonly="readonly" />
                       </ax:field>
                       <ax:field label="사용시작일" style="width:200px;">
                           <input type="text" id="info-ensret-strDate" name="strDate" title="사용시작일" maxlength="10" placeholder="사용시작일" class="AXInput W100" value="" />
                       </ax:field>
                       <ax:field label="사용종료일" style="width:200px;">
                           <input type="text" id="info-ensret-endDate" name="endDate" title="사용종료일" maxlength="10" placeholder="사용종료일" class="AXInput W100" value="" />
                       </ax:field>
           		</ax:fields>
           		<ax:fields>
                       <ax:field label="수납액" style="width:200px;">
                           <input type="number" id="info-ensret-receiptAmt" name="receiptAmt" title="수납액" maxlength="15" placeholder="사용료" class="AXInput W100 " value="" />
                       </ax:field>
                       <ax:field label="반환사용료" style="width:200px;">
                           <input type="number" id="info-ensret-retuseAmt" name="retuseAmt" title="반환사용료" maxlength="15" placeholder="반환사용료" class="AXInput W100" value="" />
                       </ax:field>
                       <ax:field label="반환관리비" style="width:200px;">
                           <input type="number" id="info-ensret-retmngAmt" name="retAmt" title="반환관리비" maxlength="15" placeholder="반환관리비" class="AXInput W100" value="" />
                       </ax:field>
                       <ax:field label="반환금액" style="width:200px;">
                           <input type="number" id="info-ensret-retAmt" name="retAmt" title="반환금액" maxlength="15" placeholder="반환금액" class="AXInput W100" value="" />
                       </ax:field>

           		</ax:fields>
           		<ax:fields>
	   				<ax:field label="반환율" style="width:200px;">
	                   <input type="number" id="info-ensret-retRate" name="retRate" title="반환율" maxlength="3" placeholder="반환율" class="AXInput W100" value="" />
	              	</ax:field>
	               	<ax:field label="반환방법" style="width:200px;">
	                   <input type="text" id="info-ensret-retMethod" name="retMethod" title="반환방법" maxlength="10" placeholder="반환방법" class="AXInput W100" value="" />
	               	</ax:field>
           		</ax:fields>
           		<%-- <ax:fields>
                       <ax:field label="반환계좌" style="width:98%;">
                           <input type="text" id="info-ensret-retAccno" name="retAccno" title="반환계좌" maxlength="100" placeholder="반환계좌" class="AXInput " style="width: 98%;" value="" />
                       </ax:field>
           		</ax:fields> --%>
           		<ax:fields>
                       <ax:field label="반환사유" style="width:98%;">
                           <input type="text" id="info-ensret-retReason" name="retReason" title="반환사유" maxlength="200" placeholder="반환사유" class="AXInput W100 " value="" style="width:98%;" />
                       </ax:field>
           		</ax:fields>

				<div class="ax-button-group">
	                    <div class="left">
                        <h2><i class="axi axi-table"></i> 신청자</h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>
									<ax:fields>
	                                    <ax:field label="신청자명*" style="width:304px;">
	                                        <input type="text" id="info-applicant-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value="" />
	                                    </ax:field>
	                                    <ax:field label="신청자 주민번호" style="width:480px;">
	                                    <input type="text" name="x" class="AXInput W130" id="ax-input-segment" />
	                                        <input type="text" id="info-applicant-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W101" value="" />
	                                   		<%-- <button type="button" class="AXButton" id="btn-search-applJumin"><i class='axi axi-ion-android-search'></i>중복조회</button> --%>
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="신청자 주소*">
	                                        <select id="info-applicant-addrGubun" name="addrGubun" class="AXSelect W50"></select>
	                                        <input type="text" id="info-applicant-applPost" name="applPost" title="우편번호"  placeholder="우편번호" class="AXInput W50" value="" />
	                                        <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
	                                        <input type="text" id="info-applicant-applAddr1" name="applAddr1" title="신청자 주소"  placeholder="" class="AXInput W300 av-required" value=""/>
	                                        <input type="text" id="info-applicant-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W300" value="" />
	                                    </ax:field>
	                                </ax:fields>
	                                <ax:fields>
	                                    <ax:field label="전화번호*" style="width:304px;">
	                                        <input type="text" id="info-applicant-mobileno1" name="mobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value="" />
	                                        <input type="text" id="info-applicant-mobileno2" name="mobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
	                                        <input type="text" id="info-applicant-mobileno3" name="mobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value="" />
	                                    </ax:field>
	                                	<ax:field label="사용자와의 관계*" style="width:304px;">
	                                        <select id="info-ensret-deadRelation" name="deadRelation" class="AXSelect W160"></select>
	                                        <input type="text" id="info-ensret-deadRelationNm" name="deadRelationNm" title="사용자와의 관계" maxlength="6" placeholder="사용자와의 관계" class="AXInput W100" value=""/>
	                                    </ax:field>
	                                </ax:fields>

				</ax:form>

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
                CODES: {
                    "cardCode": Common.getCode("TCM16"),
                    "receiptGb": Common.getCode("TMC15"),
                    "dcGubun": Common.getCode("TCM12"),
                    "addrPart": Common.getCode("TCM10"),
                    "deadSex": Common.getCode("TCM05"),
                    "applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                },
				data: {
					price: null
				},
				pageStart: function(){
					this.gridEnsdead.bind();
					this.bindEvent();
					this.form.bind();
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
                	$("#ax-input-segment").bindSegment({
            			options:[
            				{optionValue:0, optionText:"주민번호"},
            				{optionValue:1, optionText:"사업자번호"},
            			],
            			onchange:function(){
            				//this.targetID, this.options, this.selectedIndex, this.selectedOption
            				//console.log(this);
            				if(this.selectedIndex == 0){
            					 $("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});


            				}else{
            					$("#info-applicant-applJumin").bindPattern({pattern: "custom", max_length: 10, patternString:"999-99-99999"});

            				}
            				$("#info-applicant-applJumin").change();

            			}
            		});
                	 $("#info-ensret-deadRelation").selectBox({
 	                	basicCd: "TCM08"
 	                	,val : "TCM0800004"
 	               		,async : false
 	                });
                  	$("#info-applicant-addrGubun").selectBox({
	                	basicCd: "TCM07"
	                	,async : false
	                });
                  	$("#btn-applpost").bind("click", function(){
	                   	daumPopPostcode("info-applicant-applPost", "info-applicant-applAddr1", "info-applicant-applAddr2");
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
                    $("#ax-form-btn-save").bind("click", function(){
                    	fnObj.form.save();
                    });

					$("#ax-form-btn-delete").bind("click", function(){
						fnObj.form.del();
					});

					$("#ax-form-btn-new").bind("click",function(){
						var endDate = "${param.endDate}";
						var nowDate = new Date().print();
						// alert(endDate);
						// alert(nowDate);
						if(endDate < nowDate){
							alert("사용종료기간이 지난 반환입니다. 사용연장 탭으로 이동하여 비용을 정산하면 반환처리 됩니다.");
							// return false;
						}

						if(fnObj.gridEnsdead.target.getSelectedItem().item.retSeq > 0){
                    		toast.push("이미 반환자료가 존재합니다.");
                    		return false;
                    	}
						var retnDate = $("#info-ensret-retDate").val();
						fnObj.form.clear();
						$("#info-ensret-ensDate").val('${param.ensDate}');
						$("#info-ensret-ensSeq").val('${param.ensSeq}');
						$("#info-ensret-retDate").bindDate();
						retnDate != ""	? $("#info-ensret-retDate").val(retnDate) : $("#info-ensret-retDate").val(new Date().print());

						var receiptAmt = typeof fnObj.gridEnsdead.target.getSelectedItem().item.extCharge == "undefined" || fnObj.gridEnsdead.target.getSelectedItem().item.extCharge == 0
							? fnObj.gridEnsdead.target.getSelectedItem().item.charge : fnObj.gridEnsdead.target.getSelectedItem().item.extCharge;
						var deadSeq = fnObj.gridEnsdead.target.getSelectedItem().item.deadSeq;

						$("#info-ensret-deadSeq").val(deadSeq);
						$("#info-ensret-receiptAmt").val(receiptAmt);
						$("#info-ensret-strDate").val("${param.strDate}");
						$("#info-ensret-endDate").val("${param.endDate}");

						app.ajax({
	                        type: "GET",
	                        url: "/ENSH1010/retlist/"+$("#info-ensret-strDate").val().date().print("yyyymmdd")+"/"+$("#info-ensret-retDate").val().date().print("yyyymmdd"),
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		if(res.map.retlistVTO == null){
	                    			toast.push("반환율 등록되지 않았습니다.");
	                    			return;
	                    		}
								//개정전
	                    		//var retuseAmt  = typeof fnObj.gridEnsdead.target.getSelectedItem().item.extRentalfee == "undefined" || fnObj.gridEnsdead.target.getSelectedItem().item.extCharge == 0 ? fnObj.gridEnsdead.target.getSelectedItem().item.charge+0 : fnObj.gridEnsdead.target.getSelectedItem().item.extRentalfee;
	                    		//var retmngAmt = typeof fnObj.gridEnsdead.target.getSelectedItem().item.extMng == "undefined" || fnObj.gridEnsdead.target.getSelectedItem().item.extCharge == 0 ? 0 : fnObj.gridEnsdead.target.getSelectedItem().item.extMng;

	                    		//$("#info-ensret-retRate").val(res.map.retlistVTO.retRate);
	                    		//$("#info-ensret-retAmt").val(((retuseAmt+retmngAmt) * res.map.retlistVTO.retRate / 100).toFixed(0));
	                    		//$("#info-ensret-retuseAmt").val((retuseAmt * res.map.retlistVTO.retRate / 100).toFixed(0));
	                    		//$("#info-ensret-retmngAmt").val((retmngAmt * res.map.retlistVTO.retRate / 100).toFixed(0));

	                    		//개정후
	                    		var retuseAmt = 0;
	                    		var retmngAmt = 0;
								if(typeof fnObj.gridEnsdead.target.getSelectedItem().item.extRentalfee == "undefined" || fnObj.gridEnsdead.target.getSelectedItem().item.extRentalfee ==0){
									retuseAmt = (fnObj.gridEnsdead.target.getSelectedItem().item.charge)+0; //20200219 김세현 납부금액이 없는 경우 반환금 처리
								}else{
									retuseAmt = fnObj.gridEnsdead.target.getSelectedItem().item.extRentalfee;
								}
								if(typeof fnObj.gridEnsdead.target.getSelectedItem().item.extMng == "undefined" || fnObj.gridEnsdead.target.getSelectedItem().item.extMng ==0){
									retmngAmt = fnObj.gridEnsdead.target.getSelectedItem().item.mngAmt-fnObj.gridEnsdead.target.getSelectedItem().item.dcMngAmt; //20200219 김세현 납부금액이 없는 경우 반환금 처리
								}else{
									retmngAmt = fnObj.gridEnsdead.target.getSelectedItem().item.extMng;
								}

								var addrPart = fnObj.gridEnsdead.target.getSelectedItem().item.addrPart;
	                    		var minusAmt = addrPart == "TCM1000001" ? 10000 : 20000;

	                    		var yearTerm = Number(new Date().print('yyyy')) - Number('${param.strDate}'.substring(0,4));
	                    		var monthTerm = Number(new Date().print('mm')) - Number('${param.strDate}'.substring(5,7).replace('-',''));
	                    		var dayTerm =  Number(new Date().print('dd')) - Number('${param.strDate}'.substring(8,10).replace('-',''));
								if(yearTerm == 0 && monthTerm < 6){

								}else{

									var term =  yearTerm*12+monthTerm;
									var year = Math.floor(term/12);
									var month = term%12;
									if(month == 6){
										if(dayTerm > 0){
											year+=1;
										}
									}
									if(month > 6){
										year+=1;
									}

									/* minusAmt = minusAmt * year;
									retmngAmt = parseInt(retmngAmt) - parseInt(minusAmt);
									if(retmngAmt < 0){
										retmngAmt = 0; //납부관리비가 없는경우 음수가 나올수 있음으로 0으로 처리한다.
									} */

								}

								retuseAmt = retuseAmt * res.map.retlistVTO.retRate / 100;
	                    		if(retuseAmt == 0 ){
	                    			$("#info-ensret-retRate").val(0);
	                    		}else{
	                    			$("#info-ensret-retRate").val(res.map.retlistVTO.retRate);
	                    		} // 20200219 김세현 납부금액이 없는 감면대상 반환시 반환율도 0 으로 처리
	                    		$("#info-ensret-retAmt").val((retuseAmt+retmngAmt).toFixed(0));
	                    		$("#info-ensret-retuseAmt").val(retuseAmt.toFixed(0));
	                    		$("#info-ensret-retmngAmt").val((retmngAmt));
	                        }
	                    });
					});
					$("#btn-ensret-delete").bind("click",function(){
						fnObj.form.del();
					});
					$("#btn-ensret-save").bind("click",function(){
						fnObj.form.save();
					});
					$("#info-ensret-strDate").bindDate();
					$("#info-ensret-endDate").bindDate();
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
                                {key:"deadSeq", label:"고인순번", width:"100", align:"center", display:false

                                }
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.clear();
                                	fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                        fnObj.gridEnsdead.target.setData({list:[{}]});
                        //fnObj.gridEnsdead.target.setFocus(0);
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

                       					if(res.map.enshrine.ensret[i]){
   			                        		$.each(res.map.enshrine.ensret[i], function(key, value){
   			                        			if(res.map.enshrine.ensret[i].deadSeq ==res.map.enshrine.ensdead[i].deadSeq ){
   			                        				res.map.enshrine.ensdead[i][key] = value;
   			                        			}
   			                        		});
                           				}

                        				if(res.map.enshrine.ensdead[i].thedead){
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
                form: {
                	target: $("#form-info"),
                	validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });
                    },
                    setJSON: function(item) {
                        var _this = this;
                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-ensret-', true);
						app.form.fillForm(fnObj.form.target, info.applicant, 'info-applicant-', true);
                        $("#info-ensret-retDate").attr("readonly", "readonly");
                    },
                    getJSON: function() {
                        var ensret = app.form.serializeObjectWithIds(this.target, 'info-ensret-');
                        ensret.applicant = app.form.serializeObjectWithIds(this.target, 'info-applicant-');

                        return ensret
                    },
                    formApplicant: {
                        target: $('#form-info-applicant'),
                        validate_target: new AXValidator(),
                        bind: function() {
                            var _this = this;

                            this.validate_target.setConfig({
                                targetFormName : "form-info-applicant"
                            });

                        },
                        setJSON: function(item) {
                            var _this = this;

                            // 수정시 입력 방지 처리 필드 처리
//                             $('#info-key').attr("readonly", "readonly");

                            var info = $.extend({}, item);
                            app.form.fillForm(_this.target, info, 'info-');
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
                    clear: function() {
                        app.form.clearFormWithPrefix(this.target, 'info-ensret-');
                    },
                    save: function(){

                    	if(!confirm("반환자료를 저장하시겠습니까?")){
     						return;
     					}

                    	if($("#info-ensret-retDate").val() == ""){
                    		toast.push("반환버튼을 눌러주세요.");
                    		return false;
                    	}
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1010/ensret",
                            data: Object.toJSON(fnObj.form.getJSON())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("저장하였습니다.");
                                fnObj.gridEnsdead.setPage();
                                app.modal.save("${callBack}", "R");
                            }
                        });
                    },
                    del: function(){
                    	if(!confirm("반환자료를 삭제하시겠습니까?")){
                    		return;
                    	}
                    	if($("#info-ensret-retDate").val() == ""){
                    		toast.push("삭제할 반환자료가 없습니다.");
                    		return false;
                    	}

                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensret/"+Common.str.replaceAll($("#info-ensret-retDate").val(), "-", "")
                            		+"/"+Common.str.replaceAll($("#info-ensret-retSeq").val(), "-", ""),
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
                                fnObj.form.clear();
                                app.modal.save("${callBack}", "R");
                            }
                        });
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